Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 715EA690082
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 07:39:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC6fg2p7Rz3cdx
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 17:39:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC6fK4Kptz2ym7
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 17:39:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEsQkr_1675924757;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEsQkr_1675924757)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 14:39:17 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	zhujia.zj@bytedance.com
Subject: [PATCH v3 4/4] erofs: unify anonymous inodes for blob
Date: Thu,  9 Feb 2023 14:39:13 +0800
Message-Id: <20230209063913.46341-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230209063913.46341-1-jefflexu@linux.alibaba.com>
References: <20230209063913.46341-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently there're two anonymous inodes (inode and anon_inode in struct
erofs_fscache) for each blob.  The former was introduced as the
address_space of page cache for bootstrap.

The latter was initially introduced as both the address_space of page
cache and also a sentinel in the shared domain.  Since now the management
of cookies in share domain has been decoupled with the anonymous inode,
there's no need to maintain an extra anonymous inode.  Let's unify these
two anonymous inodes.

Besides, in non-share-domain mode only bootstrap will allocate anonymous
inode.  To simplify the implementation, always allocate anonymous inode
for both bootstrap and data blobs.  Similarly release anonymous inodes
for data blobs when .put_super() is called, or we'll get "VFS: Busy
inodes after unmount." warning.

Also remove the redundant set_nlink() when initializing the anonymous
inode, since i_nlink has already been initialized to 1 when the inode
gets allocated.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 85 ++++++++++++++++++---------------------------
 fs/erofs/internal.h |  7 ++--
 fs/erofs/super.c    |  2 ++
 3 files changed, 38 insertions(+), 56 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index c6f09928b62c..f41d57893e37 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -420,14 +420,14 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 	return err;
 }
 
-static
-struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
-						   char *name,
-						   unsigned int flags)
+static struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
+						char *name, unsigned int flags)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
 	struct fscache_cookie *cookie;
+	struct super_block *isb;
+	struct inode *inode;
 	int ret;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -443,33 +443,32 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 		ret = -EINVAL;
 		goto err;
 	}
-
 	fscache_use_cookie(cookie, false);
-	ctx->cookie = cookie;
-
-	if (flags & EROFS_REG_COOKIE_NEED_INODE) {
-		struct inode *const inode = new_inode(sb);
-
-		if (!inode) {
-			erofs_err(sb, "failed to get anon inode for %s", name);
-			ret = -ENOMEM;
-			goto err_cookie;
-		}
-
-		set_nlink(inode, 1);
-		inode->i_size = OFFSET_MAX;
-		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-		inode->i_private = ctx;
 
-		ctx->inode = inode;
+	/*
+	 * Allocate anonymous inode in global pseudo mount for shareable blobs,
+	 * so that they are accessible among erofs fs instances.
+	 */
+	isb = flags & EROFS_REG_COOKIE_SHARE ? erofs_pseudo_mnt->mnt_sb : sb;
+	inode = new_inode(isb);
+	if (!inode) {
+		erofs_err(sb, "failed to get anon inode for %s", name);
+		ret = -ENOMEM;
+		goto err_cookie;
 	}
 
+	inode->i_size = OFFSET_MAX;
+	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	inode->i_private = ctx;
+
+	ctx->cookie = cookie;
+	ctx->inode = inode;
 	return ctx;
 
 err_cookie:
-	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
-	fscache_relinquish_cookie(ctx->cookie, false);
+	fscache_unuse_cookie(cookie, NULL, NULL);
+	fscache_relinquish_cookie(cookie, false);
 err:
 	kfree(ctx);
 	return ERR_PTR(ret);
@@ -480,18 +479,13 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
 	iput(ctx->inode);
-	iput(ctx->anon_inode);
 	kfree(ctx->name);
 	kfree(ctx);
 }
 
-static
-struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
-						       char *name,
-						       unsigned int flags)
+static struct erofs_fscache *erofs_domain_init_cookie(struct super_block *sb,
+						char *name, unsigned int flags)
 {
-	int err;
-	struct inode *inode;
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
 
@@ -501,35 +495,23 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
 
 	ctx->name = kstrdup(name, GFP_KERNEL);
 	if (!ctx->name) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
-	if (!inode) {
-		err = -ENOMEM;
-		goto out;
+		erofs_fscache_relinquish_cookie(ctx);
+		return ERR_PTR(-ENOMEM);
 	}
 
+	refcount_inc(&domain->ref);
 	ctx->domain = domain;
-	ctx->anon_inode = inode;
 	list_add(&ctx->node, &erofs_domain_cookies_list);
-	inode->i_private = ctx;
-	refcount_inc(&domain->ref);
 	return ctx;
-out:
-	erofs_fscache_relinquish_cookie(ctx);
-	return ERR_PTR(err);
 }
 
-static
-struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
-						   char *name,
-						   unsigned int flags)
+static struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
+						char *name, unsigned int flags)
 {
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
 
+	flags |= EROFS_REG_COOKIE_SHARE;
 	mutex_lock(&erofs_domain_cookies_lock);
 	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
 		if (ctx->domain != domain || strcmp(ctx->name, name))
@@ -544,7 +526,7 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 		mutex_unlock(&erofs_domain_cookies_lock);
 		return ctx;
 	}
-	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
+	ctx = erofs_domain_init_cookie(sb, name, flags);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
 }
@@ -583,7 +565,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	int ret;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
-	unsigned int flags;
+	unsigned int flags = 0;
 
 	if (sbi->domain_id)
 		ret = erofs_fscache_register_domain(sb);
@@ -602,7 +584,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	 *
 	 * Acquired domain/volume will be relinquished in kill_sb() on error.
 	 */
-	flags = EROFS_REG_COOKIE_NEED_INODE;
 	if (sbi->domain_id)
 		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
 	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8358cf5f731e..50cd257d04e3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -107,8 +107,7 @@ struct erofs_domain {
 
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
-	struct inode *inode;
-	struct inode *anon_inode;
+	struct inode *inode;	/* anonymous indoe for the blob */
 
 	/* used for share domain mode */
 	struct erofs_domain *domain;
@@ -450,8 +449,8 @@ extern const struct file_operations erofs_dir_fops;
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
 /* flags for erofs_fscache_register_cookie() */
-#define EROFS_REG_COOKIE_NEED_INODE	1
-#define EROFS_REG_COOKIE_NEED_NOEXIST	2
+#define EROFS_REG_COOKIE_SHARE		0x0001
+#define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
 
 void erofs_unmap_metabuf(struct erofs_buf *buf);
 void erofs_put_metabuf(struct erofs_buf *buf);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 715efa94eed4..19b1ae79cec4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -968,6 +968,8 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
 #endif
+	erofs_free_dev_context(sbi->devs);
+	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
 }
 
-- 
2.19.1.6.gb485710b

