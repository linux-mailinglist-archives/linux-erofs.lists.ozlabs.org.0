Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29969007F
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 07:39:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC6fT4zB8z3f4F
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 17:39:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC6fH6qqxz2xl2
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 17:39:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEr-qA_1675924755;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEr-qA_1675924755)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 14:39:15 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	zhujia.zj@bytedance.com
Subject: [PATCH v3 2/4] erofs: maintain cookies of share domain in self-contained list
Date: Thu,  9 Feb 2023 14:39:11 +0800
Message-Id: <20230209063913.46341-3-jefflexu@linux.alibaba.com>
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

We'd better not touch sb->s_inodes list and inode->i_count directly.
Let's maintain cookies of share domain in a self-contained list in erofs.

Besides, relinquish cookie with the mutex held.  Otherwise if a cookie
is registered when the old cookie with the same name in the same domain
has been removed from the list but not relinquished yet, fscache may
complain "Duplicate cookie detected".

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 44 ++++++++++++++++++++------------------------
 fs/erofs/internal.h |  4 ++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 03de4dc99302..a302d6d23ab5 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -9,6 +9,7 @@
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
+static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
 struct erofs_fscache_request {
@@ -318,8 +319,6 @@ const struct address_space_operations erofs_fscache_access_aops = {
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
-	if (!domain)
-		return;
 	mutex_lock(&erofs_domain_list_lock);
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
@@ -434,6 +433,8 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
+	INIT_LIST_HEAD(&ctx->node);
+	refcount_set(&ctx->ref, 1);
 
 	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
 					name, strlen(name), NULL, 0, 0);
@@ -479,6 +480,7 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
 	iput(ctx->inode);
+	iput(ctx->anon_inode);
 	kfree(ctx->name);
 	kfree(ctx);
 }
@@ -511,6 +513,7 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
 
 	ctx->domain = domain;
 	ctx->anon_inode = inode;
+	list_add(&ctx->node, &erofs_domain_cookies_list);
 	inode->i_private = ctx;
 	refcount_inc(&domain->ref);
 	return ctx;
@@ -524,29 +527,23 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 						   char *name,
 						   unsigned int flags)
 {
-	struct inode *inode;
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
-	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
 
 	mutex_lock(&erofs_domain_cookies_lock);
-	spin_lock(&psb->s_inode_list_lock);
-	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
-		ctx = inode->i_private;
-		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
+	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
+		if (ctx->domain != domain || strcmp(ctx->name, name))
 			continue;
 		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
-			igrab(inode);
+			refcount_inc(&ctx->ref);
 		} else {
 			erofs_err(sb, "%s already exists in domain %s", name,
 				  domain->domain_id);
 			ctx = ERR_PTR(-EEXIST);
 		}
-		spin_unlock(&psb->s_inode_list_lock);
 		mutex_unlock(&erofs_domain_cookies_lock);
 		return ctx;
 	}
-	spin_unlock(&psb->s_inode_list_lock);
 	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
@@ -563,23 +560,22 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 
 void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 {
-	bool drop;
-	struct erofs_domain *domain;
+	struct erofs_domain *domain = NULL;
 
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
+	if (!ctx->domain)
+		return erofs_fscache_relinquish_cookie(ctx);
 
-	erofs_fscache_relinquish_cookie(ctx);
-	erofs_fscache_domain_put(domain);
+	mutex_lock(&erofs_domain_cookies_lock);
+	if (refcount_dec_and_test(&ctx->ref)) {
+		domain = ctx->domain;
+		list_del(&ctx->node);
+		erofs_fscache_relinquish_cookie(ctx);
+	}
+	mutex_unlock(&erofs_domain_cookies_lock);
+	if (domain)
+		erofs_fscache_domain_put(domain);
 }
 
 int erofs_fscache_register_fs(struct super_block *sb)
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 48a2f33de15a..8358cf5f731e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -109,7 +109,11 @@ struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
 	struct inode *anon_inode;
+
+	/* used for share domain mode */
 	struct erofs_domain *domain;
+	struct list_head node;
+	refcount_t ref;
 	char *name;
 };
 
-- 
2.19.1.6.gb485710b

