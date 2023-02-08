Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD6C68E8C7
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 08:16:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBWWk0Zh6z3cS4
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 18:16:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBWWd08G4z3bTK
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Feb 2023 18:16:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbAXJP5_1675840583;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbAXJP5_1675840583)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 15:16:24 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	zhujia.zj@bytedance.com
Subject: [PATCH 2/4] erofs: maintain cookies of share domain in self-contained list
Date: Wed,  8 Feb 2023 15:16:23 +0800
Message-Id: <99618b85e5802aacf498387b48c61f1307c6f1f7.1675840368.git.jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1675840368.git.jefflexu@linux.alibaba.com>
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
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

Besides, relinquish cookie with the mutext held.  Otherwise if a cookie
is registered when the old cookie with the same name in the same domain
has been removed from the list but not relinquished yet, fscache may
complain "Duplicate cookie detected".

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 48 ++++++++++++++++++++++-----------------------
 fs/erofs/internal.h |  4 ++++
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 03de4dc99302..2f5930e177cc 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,8 +7,11 @@
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
-static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
+
+static DEFINE_MUTEX(erofs_domain_cookies_lock);
+static LIST_HEAD(erofs_domain_cookies_list);
+
 static struct vfsmount *erofs_pseudo_mnt;
 
 struct erofs_fscache_request {
@@ -318,8 +321,6 @@ const struct address_space_operations erofs_fscache_access_aops = {
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
-	if (!domain)
-		return;
 	mutex_lock(&erofs_domain_list_lock);
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
@@ -434,6 +435,8 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
+	INIT_LIST_HEAD(&ctx->node);
+	refcount_set(&ctx->ref, 1);
 
 	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
 					name, strlen(name), NULL, 0, 0);
@@ -479,6 +482,7 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
 	iput(ctx->inode);
+	iput(ctx->anon_inode);
 	kfree(ctx->name);
 	kfree(ctx);
 }
@@ -511,6 +515,7 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
 
 	ctx->domain = domain;
 	ctx->anon_inode = inode;
+	list_add(&ctx->node, &erofs_domain_cookies_list);
 	inode->i_private = ctx;
 	refcount_inc(&domain->ref);
 	return ctx;
@@ -524,29 +529,23 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
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
@@ -563,23 +562,22 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 
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

