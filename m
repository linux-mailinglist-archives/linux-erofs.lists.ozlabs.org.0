Return-Path: <linux-erofs+bounces-1630-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E09CE64B0
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 10:30:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfrXr2XNqz2xrC;
	Mon, 29 Dec 2025 20:30:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767000604;
	cv=none; b=oejMXTiU1hDEGpaAg6ya8/3i3mOxLv2pChZBq/7cMEwcKTydX8pnVfBmjjNVDrXdWczr+WjOFe0fIW/03BkStR5Se10LbCPo2k4hihuwEU5k2CSUDZ/Fm1a4AFewjOmmupx9QjJk8jhQYbFGIsOFdLV4JNw/TQOJEczs9ThaIuhXdfVy6LEcUWaRTKLELsCpAnEn2lWG6DMa1+BeBiDOiQJ4gXZhGNYBBkBbGVrUDrdTPzd+yNZMw/BcQt5wlIc315GoqizQUJ3fovvEdFwWIxJVhHKeah1Vd43+pJNztm9pdS731SOv4hDsF1yep++CMRGqxtabYRs+w3IXj14a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767000604; c=relaxed/relaxed;
	bh=JCzITJuRjeKFtm3K6ox8VTBVlLhqGgUOp9rwEBGomNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcHBug1NDzJbPmRxiGjjOa2Ed83/AArcAieKBdcOc86ZNXs6krR8u3G+tgXBkH1EHUTskuWZnnJRFmLNgf1ZUcDouDb1DjQmlDe6bteX9Cg4nERwzI9zU+1O7TscrIA8xfpnlx3imbymeaE6pgvpHrGW+RGs7qcBZLfzNfeoXSNpyfMC76f7lvNSoNru/6DCOvBOkvyBF5DHMvi/LqAQ6D1sLhM4W3Dcl1cD9Fwr8Xq+0iZkF/gRv2BuTdIZtjR1GlT8reTbAL41b9vprJz3GwE54KOkHOiJpX/53tmxAmdeuDTAcAWDbXXV9zZEiw2vEMoaRUpkqU3knqXE2LcbsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I/ltyjvI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I/ltyjvI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfrXn52nFz2x9M
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 20:30:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767000596; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JCzITJuRjeKFtm3K6ox8VTBVlLhqGgUOp9rwEBGomNU=;
	b=I/ltyjvISz9vAbmwaTso0VQtRACF5JLjxrlIe601Bm7uArQgKAlp+hvraomNQYqv8HkQ7vEE3hBwyTGriJR+o701dCI4tlWcdBXcEI/SSW3MsY4oeMIsSIO8WxkVscnOMomvJJNTbHT6AaQZHKtal8eY5/DUm3Chcx3Jlpb3XSY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvqzdsy_1767000594 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 17:29:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/4] erofs: unexport erofs_getxattr()
Date: Mon, 29 Dec 2025 17:29:48 +0800
Message-ID: <20251229092949.2316075-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
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

No external users other than those in xattr.c.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 108 +++++++++++++++++++++++------------------------
 fs/erofs/xattr.h |   7 ---
 2 files changed, 54 insertions(+), 61 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..972941ecb71c 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -125,58 +125,6 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	return ret;
 }
 
-static bool erofs_xattr_user_list(struct dentry *dentry)
-{
-	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
-}
-
-static bool erofs_xattr_trusted_list(struct dentry *dentry)
-{
-	return capable(CAP_SYS_ADMIN);
-}
-
-static int erofs_xattr_generic_get(const struct xattr_handler *handler,
-				   struct dentry *unused, struct inode *inode,
-				   const char *name, void *buffer, size_t size)
-{
-	if (handler->flags == EROFS_XATTR_INDEX_USER &&
-	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
-		return -EOPNOTSUPP;
-
-	return erofs_getxattr(inode, handler->flags, name, buffer, size);
-}
-
-const struct xattr_handler erofs_xattr_user_handler = {
-	.prefix	= XATTR_USER_PREFIX,
-	.flags	= EROFS_XATTR_INDEX_USER,
-	.list	= erofs_xattr_user_list,
-	.get	= erofs_xattr_generic_get,
-};
-
-const struct xattr_handler erofs_xattr_trusted_handler = {
-	.prefix	= XATTR_TRUSTED_PREFIX,
-	.flags	= EROFS_XATTR_INDEX_TRUSTED,
-	.list	= erofs_xattr_trusted_list,
-	.get	= erofs_xattr_generic_get,
-};
-
-#ifdef CONFIG_EROFS_FS_SECURITY
-const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
-	.prefix	= XATTR_SECURITY_PREFIX,
-	.flags	= EROFS_XATTR_INDEX_SECURITY,
-	.get	= erofs_xattr_generic_get,
-};
-#endif
-
-const struct xattr_handler * const erofs_xattr_handlers[] = {
-	&erofs_xattr_user_handler,
-	&erofs_xattr_trusted_handler,
-#ifdef CONFIG_EROFS_FS_SECURITY
-	&erofs_xattr_security_handler,
-#endif
-	NULL,
-};
-
 static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
 				      unsigned int len)
 {
@@ -391,8 +339,8 @@ static int erofs_xattr_iter_shared(struct erofs_xattr_iter *it,
 	return i ? ret : -ENODATA;
 }
 
-int erofs_getxattr(struct inode *inode, int index, const char *name,
-		   void *buffer, size_t buffer_size)
+static int erofs_getxattr(struct inode *inode, int index, const char *name,
+			  void *buffer, size_t buffer_size)
 {
 	int ret;
 	unsigned int hashbit;
@@ -462,6 +410,58 @@ ssize_t erofs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	return ret ? ret : it.buffer_ofs;
 }
 
+static bool erofs_xattr_user_list(struct dentry *dentry)
+{
+	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
+}
+
+static bool erofs_xattr_trusted_list(struct dentry *dentry)
+{
+	return capable(CAP_SYS_ADMIN);
+}
+
+static int erofs_xattr_generic_get(const struct xattr_handler *handler,
+				   struct dentry *unused, struct inode *inode,
+				   const char *name, void *buffer, size_t size)
+{
+	if (handler->flags == EROFS_XATTR_INDEX_USER &&
+	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
+		return -EOPNOTSUPP;
+
+	return erofs_getxattr(inode, handler->flags, name, buffer, size);
+}
+
+const struct xattr_handler erofs_xattr_user_handler = {
+	.prefix	= XATTR_USER_PREFIX,
+	.flags	= EROFS_XATTR_INDEX_USER,
+	.list	= erofs_xattr_user_list,
+	.get	= erofs_xattr_generic_get,
+};
+
+const struct xattr_handler erofs_xattr_trusted_handler = {
+	.prefix	= XATTR_TRUSTED_PREFIX,
+	.flags	= EROFS_XATTR_INDEX_TRUSTED,
+	.list	= erofs_xattr_trusted_list,
+	.get	= erofs_xattr_generic_get,
+};
+
+#ifdef CONFIG_EROFS_FS_SECURITY
+const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.flags	= EROFS_XATTR_INDEX_SECURITY,
+	.get	= erofs_xattr_generic_get,
+};
+#endif
+
+const struct xattr_handler * const erofs_xattr_handlers[] = {
+	&erofs_xattr_user_handler,
+	&erofs_xattr_trusted_handler,
+#ifdef CONFIG_EROFS_FS_SECURITY
+	&erofs_xattr_security_handler,
+#endif
+	NULL,
+};
+
 void erofs_xattr_prefixes_cleanup(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 6317caa8413e..ee1d8c310d97 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -45,17 +45,10 @@ extern const struct xattr_handler * const erofs_xattr_handlers[];
 
 int erofs_xattr_prefixes_init(struct super_block *sb);
 void erofs_xattr_prefixes_cleanup(struct super_block *sb);
-int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
 ssize_t erofs_listxattr(struct dentry *, char *, size_t);
 #else
 static inline int erofs_xattr_prefixes_init(struct super_block *sb) { return 0; }
 static inline void erofs_xattr_prefixes_cleanup(struct super_block *sb) {}
-static inline int erofs_getxattr(struct inode *inode, int index,
-				 const char *name, void *buffer,
-				 size_t buffer_size)
-{
-	return -EOPNOTSUPP;
-}
 
 #define erofs_listxattr (NULL)
 #define erofs_xattr_handlers (NULL)
-- 
2.43.5


