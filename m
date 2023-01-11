Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08887665623
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 09:32:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsLWz6FHTz3cdp
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 19:32:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsLWm5mSPz3c65
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 19:32:04 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZMeLpU_1673425920;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMeLpU_1673425920)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:32:01 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/7] erofs: unify anonymous inodes for blob
Date: Wed, 11 Jan 2023 16:31:53 +0800
Message-Id: <20230111083158.23462-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
References: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently only bootstrap will allocate anonymous inode for the
address_space of page cache.  In prep for the following support for page
cache sharing, as the first step, always allocate anonymous inode for
this use for both bootstrap and data blobs.

Since now anonymous inode is also allocated for data blobs, release
these anonymous inodes when .put_super() is called, or we'll get
"VFS: Busy inodes after unmount." warning.

Similarly, the fscache contexts for data blobs are initialized prior to
the root inode, thus .kill_sb() shall also contain the cleanup routine,
so that these fscache contexts can be cleaned up when mount fails while
root inode has not been initialized yet.

Also remove the redundant set_nlink() when initializing anonymous inode,
since i_nlink has already been initialized to 1 when the inode gets
allocated.

Until then there're two anonymous inodes (inode and anon_inode in struct
erofs_fscache) may be used for each blob.  The former is used as the
address_space of page cache, while the latter is used as a sentinel in
the shared domain.

In prep for the following support for page cache sharing, unify these
two anonymous inodes.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 103 ++++++++++++++++++++------------------------
 fs/erofs/internal.h |   6 +--
 fs/erofs/super.c    |   2 +
 3 files changed, 51 insertions(+), 60 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 03de4dc99302..81f96c910277 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -318,8 +318,6 @@ const struct address_space_operations erofs_fscache_access_aops = {
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
-	if (!domain)
-		return;
 	mutex_lock(&erofs_domain_list_lock);
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
@@ -423,12 +421,13 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 
 static
 struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
-						   char *name,
-						   unsigned int flags)
+						   char *name)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
 	struct fscache_cookie *cookie;
+	struct super_block *psb;
+	struct inode *inode;
 	int ret;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -442,33 +441,28 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
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
+	psb = EROFS_SB(sb)->domain_id ? erofs_pseudo_mnt->mnt_sb : sb;
+	inode = new_inode(psb);
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
@@ -485,38 +479,34 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 
 static
 struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
-						       char *name,
-						       unsigned int flags)
+						       char *name)
 {
-	int err;
-	struct inode *inode;
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
 
-	ctx = erofs_fscache_acquire_cookie(sb, name, flags);
+	ctx = erofs_fscache_acquire_cookie(sb, name);
 	if (IS_ERR(ctx))
 		return ctx;
 
 	ctx->name = kstrdup(name, GFP_KERNEL);
 	if (!ctx->name) {
-		err = -ENOMEM;
-		goto out;
+		erofs_fscache_relinquish_cookie(ctx);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
-	if (!inode) {
-		err = -ENOMEM;
-		goto out;
-	}
+	/*
+	 * In share domain scenarios, the unified anonymous inode is not only
+	 * used as the address_space of shared page cache, but also a sentinel
+	 * in pseudo mount.  The initial refcount is used for the former and
+	 * will be killed when the cookie finally gets relinquished.  For the
+	 * latter, the refcount is increased every time the cookie in the domain
+	 * gets referred to.
+	 */
+	igrab(ctx->inode);
 
 	ctx->domain = domain;
-	ctx->anon_inode = inode;
-	inode->i_private = ctx;
 	refcount_inc(&domain->ref);
 	return ctx;
-out:
-	erofs_fscache_relinquish_cookie(ctx);
-	return ERR_PTR(err);
 }
 
 static
@@ -547,7 +537,7 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 		return ctx;
 	}
 	spin_unlock(&psb->s_inode_list_lock);
-	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
+	ctx = erofs_fscache_domain_init_cookie(sb, name);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
 }
@@ -558,7 +548,7 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 {
 	if (EROFS_SB(sb)->domain_id)
 		return erofs_domain_register_cookie(sb, name, flags);
-	return erofs_fscache_acquire_cookie(sb, name, flags);
+	return erofs_fscache_acquire_cookie(sb, name);
 }
 
 void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
@@ -568,18 +558,20 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 
 	if (!ctx)
 		return;
-	domain = ctx->domain;
-	if (domain) {
-		mutex_lock(&erofs_domain_cookies_lock);
-		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
-		iput(ctx->anon_inode);
-		mutex_unlock(&erofs_domain_cookies_lock);
-		if (!drop)
-			return;
-	}
 
-	erofs_fscache_relinquish_cookie(ctx);
-	erofs_fscache_domain_put(domain);
+	if (!ctx->domain)
+		return erofs_fscache_relinquish_cookie(ctx);
+
+	domain = ctx->domain;
+	mutex_lock(&erofs_domain_cookies_lock);
+	/* drop the ref for the sentinel in pseudo mount */
+	iput(ctx->inode);
+	drop = atomic_read(&ctx->inode->i_count) == 1;
+	if (drop)
+		erofs_fscache_relinquish_cookie(ctx);
+	mutex_unlock(&erofs_domain_cookies_lock);
+	if (drop)
+		erofs_fscache_domain_put(domain);
 }
 
 int erofs_fscache_register_fs(struct super_block *sb)
@@ -587,7 +579,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	int ret;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
-	unsigned int flags;
+	unsigned int flags = 0;
 
 	if (sbi->domain_id)
 		ret = erofs_fscache_register_domain(sb);
@@ -606,7 +598,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	 *
 	 * Acquired domain/volume will be relinquished in kill_sb() on error.
 	 */
-	flags = EROFS_REG_COOKIE_NEED_INODE;
 	if (sbi->domain_id)
 		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
 	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index bb8501c0ff5b..b3d04bc2d279 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -108,8 +108,7 @@ struct erofs_domain {
 
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
-	struct inode *inode;
-	struct inode *anon_inode;
+	struct inode *inode;	/* anonymous indoe for the blob */
 	struct erofs_domain *domain;
 	char *name;
 };
@@ -604,8 +603,7 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* flags for erofs_fscache_register_cookie() */
-#define EROFS_REG_COOKIE_NEED_INODE	1
-#define EROFS_REG_COOKIE_NEED_NOEXIST	2
+#define EROFS_REG_COOKIE_NEED_NOEXIST	1
 
 /* fscache.c */
 #ifdef CONFIG_EROFS_FS_ONDEMAND
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 626a615dafc2..835b69c9511b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -969,6 +969,8 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
 #endif
+	erofs_free_dev_context(sbi->devs);
+	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
 }
 
-- 
2.19.1.6.gb485710b

