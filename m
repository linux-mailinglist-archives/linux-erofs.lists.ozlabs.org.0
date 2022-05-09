Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12351F572
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 09:41:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxY4v3XYpz3cKM
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 17:41:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxY4n0tb6z3cG9
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 17:40:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R241e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VCfxsaA_1652082049; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCfxsaA_1652082049) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 May 2022 15:40:50 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v11 13/22] erofs: add anonymous inode caching metadata for
 data blobs
Date: Mon,  9 May 2022 15:40:19 +0800
Message-Id: <20220509074028.74954-14-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
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
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce one anonymous inode for data blobs so that erofs can cache
metadata directly within such anonymous inode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 39 ++++++++++++++++++++++++++++++++++++---
 fs/erofs/internal.h |  6 ++++--
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index dfff245b006b..26f038d9c4e1 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -5,12 +5,17 @@
 #include <linux/fscache.h>
 #include "internal.h"
 
+static const struct address_space_operations erofs_fscache_meta_aops = {
+};
+
 int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache, char *name)
+				  struct erofs_fscache **fscache,
+				  char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
 	struct fscache_cookie *cookie;
+	int ret;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -20,15 +25,40 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 					name, strlen(name), NULL, 0, 0);
 	if (!cookie) {
 		erofs_err(sb, "failed to get cookie for %s", name);
-		kfree(name);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	fscache_use_cookie(cookie, false);
 	ctx->cookie = cookie;
 
+	if (need_inode) {
+		struct inode *const inode = new_inode(sb);
+
+		if (!inode) {
+			erofs_err(sb, "failed to get anon inode for %s", name);
+			ret = -ENOMEM;
+			goto err_cookie;
+		}
+
+		set_nlink(inode, 1);
+		inode->i_size = OFFSET_MAX;
+		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+
+		ctx->inode = inode;
+	}
+
 	*fscache = ctx;
 	return 0;
+
+err_cookie:
+	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
+	fscache_relinquish_cookie(ctx->cookie, false);
+	ctx->cookie = NULL;
+err:
+	kfree(ctx);
+	return ret;
 }
 
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
@@ -42,6 +72,9 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 	fscache_relinquish_cookie(ctx->cookie, false);
 	ctx->cookie = NULL;
 
+	iput(ctx->inode);
+	ctx->inode = NULL;
+
 	kfree(ctx);
 	*fscache = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b1f19f058503..5867cb63fd74 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -99,6 +99,7 @@ struct erofs_sb_lz4_info {
 
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
+	struct inode *inode;
 };
 
 struct erofs_sb_info {
@@ -632,7 +633,8 @@ int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
 int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache, char *name);
+				  struct erofs_fscache **fscache,
+				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
@@ -643,7 +645,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
 static inline int erofs_fscache_register_cookie(struct super_block *sb,
 						struct erofs_fscache **fscache,
-						char *name)
+						char *name, bool need_inode)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.27.0

