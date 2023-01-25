Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05167B130
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jan 2023 12:29:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P21pJ4cL1z3cdV
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jan 2023 22:29:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QJJ9Z4WN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QJJ9Z4WN;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P21pB3CPrz3cdj
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jan 2023 22:29:38 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 11955614C5;
	Wed, 25 Jan 2023 11:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB6C4339E;
	Wed, 25 Jan 2023 11:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674646175;
	bh=MKSA4pnIEhyA1wK9ZUCK91ZgbKvksc8BYw8SfMd3xXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QJJ9Z4WN0Il91E9PeY3JoUgIo3rpqItLB+HW8PAn6mqk1rzueejoBMJvnXTLLwcr2
	 XnNjOTXls/1LFQ+ovVV/pE9q5YW5c99H1FlfG1227ZqKsu1yjQMuQejfRsHp3lQ15c
	 N9iVmCDrzVPZvU+rrQ3dOE1h4LQJ34lekKR3NDfTeS/IczFi83yn7O8nCC66T5xoy4
	 WQ6SFejNtnSoMNNJRKSK96N6hLOb48cbLptc19AP5YVk/vV5EIBxXznBn4NJf5Emit
	 KqWeXb3Gt7x7nh13hUQkSadcYcNyThkR8MPZQc2e+a8l1o9wyo+eniKJLhGsA7FVB/
	 7LfKr6EbQoujQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 25 Jan 2023 12:28:50 +0100
Subject: [PATCH 05/12] erofs: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4168; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MKSA4pnIEhyA1wK9ZUCK91ZgbKvksc8BYw8SfMd3xXc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJqYwrjvz0nn9CnfdzjMikjas9H8cRb/tDevlZI6di5T
 C9VY01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRDlNGhtUNKxrZNT8xzzWLOPaG/e
 bhA7v/nRH+/XfKJDPrJ/22ovsZGRZXWp/6eNc6O/mSucH+qvlrNCbeuB58ty7vqLNrzOld37kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
Cc: "Christian Brauner \(Microsoft\)" <brauner@kernel.org>, linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Last cycle we introduced a new posix acl api. Filesystems now only need
to implement the inode operations for posix acls. The generic xattr
handlers aren't used anymore by the vfs and will be completely removed.
Keeping the handler around is confusing and gives the false impression
that the xattr infrastructure of the vfs is used to interact with posix
acls when it really isn't anymore.

For this to work we simply rework the ->listxattr() inode operation to
not rely on the generix posix acl handlers anymore.

Cc: <linux-erofs@lists.ozlabs.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/erofs/xattr.c | 49 +++++++++++++++++++++++++++++++++++++++----------
 fs/erofs/xattr.h | 21 ---------------------
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a62fb8a3318a..a787e74d9a21 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -469,10 +469,6 @@ const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
 
 const struct xattr_handler *erofs_xattr_handlers[] = {
 	&erofs_xattr_user_handler,
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&erofs_xattr_trusted_handler,
 #ifdef CONFIG_EROFS_FS_SECURITY
 	&erofs_xattr_security_handler,
@@ -480,6 +476,43 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
 	NULL,
 };
 
+static const char *erofs_xattr_prefix(int xattr_index, struct dentry *dentry)
+{
+	const char *name = NULL;
+	const struct xattr_handler *handler = NULL;
+
+	switch (xattr_index) {
+	case EROFS_XATTR_INDEX_USER:
+		handler = &erofs_xattr_user_handler;
+		break;
+	case EROFS_XATTR_INDEX_TRUSTED:
+		handler = &erofs_xattr_trusted_handler;
+		break;
+#ifdef CONFIG_EROFS_FS_SECURITY
+	case EROFS_XATTR_INDEX_SECURITY:
+		handler = &erofs_xattr_security_handler;
+		break;
+#endif
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+	case EROFS_XATTR_INDEX_POSIX_ACL_ACCESS:
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT:
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		break;
+#endif
+	default:
+		return NULL;
+	}
+
+	if (xattr_dentry_list(handler, dentry))
+		name = xattr_prefix(handler);
+
+	return name;
+}
+
 struct listxattr_iter {
 	struct xattr_iter it;
 
@@ -496,13 +529,9 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	unsigned int prefix_len;
 	const char *prefix;
 
-	const struct xattr_handler *h =
-		erofs_xattr_handler(entry->e_name_index);
-
-	if (!h || (h->list && !h->list(it->dentry)))
+	prefix = erofs_xattr_prefix(entry->e_name_index, it->dentry);
+	if (!prefix)
 		return 1;
-
-	prefix = xattr_prefix(h);
 	prefix_len = strlen(prefix);
 
 	if (!it->buffer) {
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 0a43c9ee9f8f..9376cbdc32d8 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -40,27 +40,6 @@ static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
 extern const struct xattr_handler erofs_xattr_security_handler;
-
-static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
-{
-	static const struct xattr_handler *xattr_handler_map[] = {
-		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
-			&posix_acl_access_xattr_handler,
-		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
-			&posix_acl_default_xattr_handler,
-#endif
-		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
-#ifdef CONFIG_EROFS_FS_SECURITY
-		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
-#endif
-	};
-
-	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
-		xattr_handler_map[idx] : NULL;
-}
-
 extern const struct xattr_handler *erofs_xattr_handlers[];
 
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);

-- 
2.34.1

