Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A1E4DB10A
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 14:18:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJW6q3rXrz3bYL
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 00:18:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJW6T5GZ0z308J
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 00:17:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7NEPqi_1647436663; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7NEPqi_1647436663) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Mar 2022 21:17:43 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v5 13/22] erofs: add anonymous inode managing page cache of
 blob file
Date: Wed, 16 Mar 2022 21:17:14 +0800
Message-Id: <20220316131723.111553-14-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce one anonymous inode for managing page cache of corresponding
blob file. Then erofs could read directly from the address space of the
anonymous inode when cache hit.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 45 ++++++++++++++++++++++++++++++++++++++++++---
 fs/erofs/internal.h |  3 ++-
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 28ec7c69744a..684ac6f940bc 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -6,6 +6,9 @@
 
 static struct fscache_volume *volume;
 
+static const struct address_space_operations erofs_fscache_blob_aops = {
+};
+
 static int erofs_fscache_init_cookie(struct erofs_fscache_context *ctx,
 				     char *path)
 {
@@ -32,8 +35,34 @@ void erofs_fscache_cleanup_cookie(struct erofs_fscache_context *ctx)
 	ctx->cookie = NULL;
 }
 
+static int erofs_fscache_get_inode(struct erofs_fscache_context *ctx,
+				   struct super_block *sb)
+{
+	struct inode *const inode = new_inode(sb);
+
+	if (!inode)
+		return -ENOMEM;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+
+	inode->i_mapping->a_ops = &erofs_fscache_blob_aops;
+	mapping_set_gfp_mask(inode->i_mapping,
+			GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	ctx->inode = inode;
+	return 0;
+}
+
+static inline
+void erofs_fscache_put_inode(struct erofs_fscache_context *ctx)
+{
+	iput(ctx->inode);
+	ctx->inode = NULL;
+}
+
 static int erofs_fscache_init_ctx(struct erofs_fscache_context *ctx,
-				  struct super_block *sb, char *path)
+				  struct super_block *sb, char *path,
+				  bool need_inode)
 {
 	int ret;
 
@@ -43,6 +72,15 @@ static int erofs_fscache_init_ctx(struct erofs_fscache_context *ctx,
 		return ret;
 	}
 
+	if (need_inode) {
+		ret = erofs_fscache_get_inode(ctx, sb);
+		if (ret) {
+			erofs_err(sb, "failed to get anonymous inode");
+			erofs_fscache_cleanup_cookie(ctx);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -50,10 +88,11 @@ static inline
 void erofs_fscache_cleanup_ctx(struct erofs_fscache_context *ctx)
 {
 	erofs_fscache_cleanup_cookie(ctx);
+	erofs_fscache_put_inode(ctx);
 }
 
 struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
-						char *path)
+						char *path, bool need_inode)
 {
 	struct erofs_fscache_context *ctx;
 	int ret;
@@ -62,7 +101,7 @@ struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	ret = erofs_fscache_init_ctx(ctx, sb, path);
+	ret = erofs_fscache_init_ctx(ctx, sb, path, need_inode);
 	if (ret) {
 		kfree(ctx);
 		return ERR_PTR(ret);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 123a8dfc179b..32aaa5ee5e14 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -99,6 +99,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_fscache_context {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
@@ -626,7 +627,7 @@ int erofs_init_fscache(void);
 void erofs_exit_fscache(void);
 
 struct erofs_fscache_context *erofs_fscache_get_ctx(struct super_block *sb,
-						char *path);
+						char *path, bool need_inode);
 void erofs_fscache_put_ctx(struct erofs_fscache_context *ctx);
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-- 
2.27.0

