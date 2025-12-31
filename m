Return-Path: <linux-erofs+bounces-1657-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB95CEB41A
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 05:57:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgyPr2FCHz2yFY;
	Wed, 31 Dec 2025 15:57:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767157072;
	cv=none; b=hQAY61vGvjYHxPfSrS5jXi0gRZ67wFtqZveXOTVmYgTZpSWPBaFgrSqHeDW0NJrQ5PgTYYBlVAZHJzO0dyl1UOkBb7Kph5yCTfQz1Zg8TFO+f8znjMm2OSQaEZra2oIuVMoZfax2WdB7R2v9StVCKpXXc16hQ2zEZL7EUqt0D4l71ci9TAI5FAQWd/iGzBTd151ECr7/gO+XKDhY6CrMmB3LXC4ksgenF/o9o0xZIWnC9kTJdKEnuGenIN68pny8vRzW/f8ZM+HGgSU97mXjKwZUKRZP7g5HFrFfQ4H8fDjMbqmOElKJ/Zs7BY6rzbBo0rYWb63mnNCUwUzsDcxIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767157072; c=relaxed/relaxed;
	bh=mv2IZ5fzK6kHpN8pu8lDd8Jbw4Yx0JwvlW/ztt+xKbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsZSjZzcW4iiN1KApeVgE0LJSKf85fqjYVlzbl0D8CYc99QWFvK9CJQ0I/w3XuRsKe4lHGF2zghZcGCgkVMeHPhD3Sf9BqSLM0Xo8cE8lNg/IutXIQh5f/x5BJrxGrpWYKo8gUzNnpdsBR8jKnpsXRVJtvCvuE7t8k8mNbAQ0QBmqlic0b71l35PgZCUdhLJmgdHEPLaR2ec+RVhPNQWr+U2yvxsLoyE/IZb9yA80yYufYAC05IyDerBdMREsUKdpQNYFhtmqSmsoYPt/sxprCSc909xSxp6ZqRkOIzLAie/MR9FQCQ4hWBD481Gq5b+m082ITV2+7NB93nI4vIXRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AVeFdrqY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AVeFdrqY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgyPn6Mqcz2xg9
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Dec 2025 15:57:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767157062; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mv2IZ5fzK6kHpN8pu8lDd8Jbw4Yx0JwvlW/ztt+xKbg=;
	b=AVeFdrqYpd4GWM2e4u9Go+iHXqvTFJUqRwmnSVlxWfmCLbjmIDT85mAtRJCKJEJ7SaZO978IsY2AbkXmBxDYXxC+AIfEngQjJjZhYkfAeh5VrqMrgC6gAwzzk6/7n4FYkkpJWVp5JTsuEdgIN/m7Illzq2aYmYZW5lwyocWI/bA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ww.tb1Q_1767157056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 31 Dec 2025 12:57:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH v2 4/4] erofs: unexport erofs_xattr_prefix()
Date: Wed, 31 Dec 2025 12:57:36 +0800
Message-ID: <20251231045736.1552300-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229092949.2316075-4-hsiangkao@linux.alibaba.com>
References: <20251229092949.2316075-4-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

It can be simply in xattr.c due to no external users.

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix sparse warnings:
     https://lore.kernel.org/r/202512311021.L0IMtTOh-lkp@intel.com

 fs/erofs/xattr.c | 31 ++++++++++++++++++++++++++++---
 fs/erofs/xattr.h | 30 ------------------------------
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 972941ecb71c..f8668157162f 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -25,6 +25,8 @@ struct erofs_xattr_iter {
 	struct dentry *dentry;
 };
 
+static const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry);
+
 static int erofs_init_inode_xattrs(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -431,14 +433,14 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 	return erofs_getxattr(inode, handler->flags, name, buffer, size);
 }
 
-const struct xattr_handler erofs_xattr_user_handler = {
+static const struct xattr_handler erofs_xattr_user_handler = {
 	.prefix	= XATTR_USER_PREFIX,
 	.flags	= EROFS_XATTR_INDEX_USER,
 	.list	= erofs_xattr_user_list,
 	.get	= erofs_xattr_generic_get,
 };
 
-const struct xattr_handler erofs_xattr_trusted_handler = {
+static const struct xattr_handler erofs_xattr_trusted_handler = {
 	.prefix	= XATTR_TRUSTED_PREFIX,
 	.flags	= EROFS_XATTR_INDEX_TRUSTED,
 	.list	= erofs_xattr_trusted_list,
@@ -446,7 +448,7 @@ const struct xattr_handler erofs_xattr_trusted_handler = {
 };
 
 #ifdef CONFIG_EROFS_FS_SECURITY
-const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
+static const struct xattr_handler erofs_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.flags	= EROFS_XATTR_INDEX_SECURITY,
 	.get	= erofs_xattr_generic_get,
@@ -462,6 +464,29 @@ const struct xattr_handler * const erofs_xattr_handlers[] = {
 	NULL,
 };
 
+static const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry)
+{
+	static const struct xattr_handler * const xattr_handler_map[] = {
+		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
+		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
+#endif
+		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
+#ifdef CONFIG_EROFS_FS_SECURITY
+		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
+#endif
+	};
+	const struct xattr_handler *handler = NULL;
+
+	if (idx && idx < ARRAY_SIZE(xattr_handler_map)) {
+		handler = xattr_handler_map[idx];
+		if (xattr_handler_can_list(handler, dentry))
+			return xattr_prefix(handler);
+	}
+	return NULL;
+}
+
 void erofs_xattr_prefixes_cleanup(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index ee1d8c310d97..36f2667afc2d 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -11,36 +11,6 @@
 #include <linux/xattr.h>
 
 #ifdef CONFIG_EROFS_FS_XATTR
-extern const struct xattr_handler erofs_xattr_user_handler;
-extern const struct xattr_handler erofs_xattr_trusted_handler;
-extern const struct xattr_handler erofs_xattr_security_handler;
-
-static inline const char *erofs_xattr_prefix(unsigned int idx,
-					     struct dentry *dentry)
-{
-	const struct xattr_handler *handler = NULL;
-
-	static const struct xattr_handler * const xattr_handler_map[] = {
-		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
-		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
-#endif
-		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
-#ifdef CONFIG_EROFS_FS_SECURITY
-		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
-#endif
-	};
-
-	if (idx && idx < ARRAY_SIZE(xattr_handler_map))
-		handler = xattr_handler_map[idx];
-
-	if (!xattr_handler_can_list(handler, dentry))
-		return NULL;
-
-	return xattr_prefix(handler);
-}
-
 extern const struct xattr_handler * const erofs_xattr_handlers[];
 
 int erofs_xattr_prefixes_init(struct super_block *sb);
-- 
2.43.5


