Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948568E8CF
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 08:17:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBWXh1Tk9z3cdx
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 18:17:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBWXc23mlz3bTK
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Feb 2023 18:17:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbAZ945_1675840635;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbAZ945_1675840635)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 15:17:16 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org,
	zhujia.zj@bytedance.com,
	houtao1@huawei.com
Subject: [PATCH 4/4] erofs: simplify the name collision checking in share domain mode
Date: Wed,  8 Feb 2023 15:17:15 +0800
Message-Id: <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
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

When share domain is enabled, data blobs can be shared among filesystem
instances in the same domain for data deduplication, while bootstrap
blobs are always dedicated to the corresponding filesystem instance, and
have no need to be shared.

In the initial implementation of share domain (commit 7d41963759fe
("erofs: Support sharing cookies in the same domain")), bootstrap blobs
are also in the share domain, and thus can be referenced by the
following filesystem instances.  In this case, mounting twice with the
same fsid and domain_id will trigger warning in sysfs.  Commit
27f2a2dcc626 ("erofs: check the uniqueness of fsid in shared domain in
advance") fixes this by introducing the name collision checking.

This patch attempts to fix the above issue in another simpler way.
Since the bootstrap blobs have no need to be shared, move them out of
the share domain, so that one bootstrap blob can not be referenced by
other filesystem instances.  Attempt to mount twice with the same fsid
and domain_id will fail with info of duplicate cookies, which is
consistent with the behavior in non-share-domain mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 36 ++++++++----------------------------
 fs/erofs/internal.h |  4 ++--
 fs/erofs/super.c    |  2 +-
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8353a5fe8c71..8da6e05e9d23 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -505,25 +505,18 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
 
 static
 struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
-						   char *name,
-						   unsigned int flags)
+						   char *name)
 {
 	struct erofs_fscache *ctx;
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
 
 	mutex_lock(&erofs_domain_cookies_lock);
 	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
-		if (ctx->domain != domain || strcmp(ctx->name, name))
-			continue;
-		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
+		if (ctx->domain == domain && !strcmp(ctx->name, name)) {
 			refcount_inc(&ctx->ref);
-		} else {
-			erofs_err(sb, "%s already exists in domain %s", name,
-				  domain->domain_id);
-			ctx = ERR_PTR(-EEXIST);
+			mutex_unlock(&erofs_domain_cookies_lock);
+			return ctx;
 		}
-		mutex_unlock(&erofs_domain_cookies_lock);
-		return ctx;
 	}
 	ctx = erofs_fscache_domain_init_cookie(sb, name);
 	mutex_unlock(&erofs_domain_cookies_lock);
@@ -531,11 +524,10 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 }
 
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						    char *name,
-						    unsigned int flags)
+						    char *name)
 {
 	if (EROFS_SB(sb)->domain_id)
-		return erofs_domain_register_cookie(sb, name, flags);
+		return erofs_domain_register_cookie(sb, name);
 	return erofs_fscache_acquire_cookie(sb, sb, name);
 }
 
@@ -564,7 +556,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	int ret;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
-	unsigned int flags = 0;
 
 	if (sbi->domain_id)
 		ret = erofs_fscache_register_domain(sb);
@@ -573,19 +564,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	if (ret)
 		return ret;
 
-	/*
-	 * When shared domain is enabled, using NEED_NOEXIST to guarantee
-	 * the primary data blob (aka fsid) is unique in the shared domain.
-	 *
-	 * For non-shared-domain case, fscache_acquire_volume() invoked by
-	 * erofs_fscache_register_volume() has already guaranteed
-	 * the uniqueness of primary data blob.
-	 *
-	 * Acquired domain/volume will be relinquished in kill_sb() on error.
-	 */
-	if (sbi->domain_id)
-		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
-	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
+	/* acquired domain/volume will be relinquished in kill_sb() on error */
+	fscache = erofs_fscache_acquire_cookie(sb, sb, sbi->fsid);
 	if (IS_ERR(fscache))
 		return PTR_ERR(fscache);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 125e4aa8d295..fded736bc3d5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -570,7 +570,7 @@ int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-					char *name, unsigned int flags);
+						    char *name);
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
@@ -581,7 +581,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
 static inline
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-					char *name, unsigned int flags)
+						    char *name)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..8706ca34f26a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -244,7 +244,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
+		fscache = erofs_fscache_register_cookie(sb, dif->path);
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
-- 
2.19.1.6.gb485710b

