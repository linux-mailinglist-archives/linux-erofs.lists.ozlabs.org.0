Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAF14E730C
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 13:23:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQ1T1374Xz30HJ
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 23:23:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQ1Sw0Y5cz30Dh
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Mar 2022 23:22:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V89aFt._1648210964; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V89aFt._1648210964) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 25 Mar 2022 20:22:45 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 13/22] erofs: add anonymous inode managing page cache of
 blob file
Date: Fri, 25 Mar 2022 20:22:14 +0800
Message-Id: <20220325122223.102958-14-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce one anonymous inode for managing page cache of corresponding
blob file. Then erofs could read directly from the address space of the
anonymous inode when cache hit.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h |  7 +++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 73235fd43bf6..30383d9adb62 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,6 +7,9 @@
 
 static struct fscache_volume *volume;
 
+static const struct address_space_operations erofs_fscache_blob_aops = {
+};
+
 static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
 {
 	struct fscache_cookie *cookie;
@@ -31,6 +34,29 @@ static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
 	ctx->cookie = NULL;
 }
 
+static int erofs_fscache_get_inode(struct erofs_fscache *ctx,
+				   struct super_block *sb)
+{
+	struct inode *const inode = new_inode(sb);
+
+	if (!inode)
+		return -ENOMEM;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+	inode->i_mapping->a_ops = &erofs_fscache_blob_aops;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+
+	ctx->inode = inode;
+	return 0;
+}
+
+static inline void erofs_fscache_put_inode(struct erofs_fscache *ctx)
+{
+	iput(ctx->inode);
+	ctx->inode = NULL;
+}
+
 /*
  * erofs_fscache_get - create an fscache context for blob file
  * @sb:		superblock
@@ -38,7 +64,8 @@ static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
  *
  * Return: fscache context on success, ERR_PTR() on failure.
  */
-struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
+struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
+					bool need_inode)
 {
 	struct erofs_fscache *ctx;
 	int ret;
@@ -53,7 +80,18 @@ struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
 		goto err;
 	}
 
+	if (need_inode) {
+		ret = erofs_fscache_get_inode(ctx, sb);
+		if (ret) {
+			erofs_err(sb, "failed to get anonymous inode");
+			goto err_cookie;
+		}
+	}
+
 	return ctx;
+
+err_cookie:
+	erofs_fscache_cleanup_cookie(ctx);
 err:
 	kfree(ctx);
 	return ERR_PTR(ret);
@@ -65,6 +103,7 @@ void erofs_fscache_put(struct erofs_fscache *ctx)
 		return;
 
 	erofs_fscache_cleanup_cookie(ctx);
+	erofs_fscache_put_inode(ctx);
 	kfree(ctx);
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d4f2b43cedae..459f31803c3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -98,6 +98,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
@@ -625,14 +626,16 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_init_fscache(void);
 void erofs_exit_fscache(void);
 
-struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path);
+struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
+					bool need_inode);
 void erofs_fscache_put(struct erofs_fscache *ctx);
 #else
 static inline int erofs_init_fscache(void) { return 0; }
 static inline void erofs_exit_fscache(void) {}
 
 static inline struct erofs_fscache *erofs_fscache_get(struct super_block *sb,
-						      char *path)
+						      char *path,
+						      bool need_inode)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.27.0

