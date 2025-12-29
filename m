Return-Path: <linux-erofs+bounces-1633-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 50472CE64AD
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 10:30:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfrXs2xPzz2xdV;
	Mon, 29 Dec 2025 20:30:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767000605;
	cv=none; b=OZ4Ieg4/uBtTWZvnL1T3j6gNxs9eSOj5p7rWDQ+L9oWteY8NHeXFbajzcIk/UFJFl6poifZzLXh0QYexVeX6dlvVwxnnnNTeBeJExLfYpk3j9hAcAbUbpoUFSyUavJm/xUcpLO1Wu1eIrGguq6vgoZnAugSVPekenrJ7DclfLj2CeXZM5BKR0Z4uvDR8GVYhfdN00le3ZU4KKaLZy6jvEPqVfuQqCMJ+jDNAt1G0dORU9e/tB2ZbwT2QPKvYKZrNob0ElKIroNEXVgvaykSUl8phyk09V/2UAPiePMUEolKgk1lvgzUcyCwC5dK4yHsrK1wYai5vptgIKi0D/dqO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767000605; c=relaxed/relaxed;
	bh=zzU0fFMiBI6Btba2fQszSuRuhXNAVv5WzkyTFe9Hlhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDKqSPfyPX2HKJ47bB0l+GoNkaJDlMH3m7YuBaSYxY6bPIl7dIw/H2VH0dYG2owPJMqiEQScLWbFPKVj2eN7wxs39IG1VveG6ZVV8nBi+7bEny/exi6H5kC0BNwDQxfCI2JXSHQQ9FppFC+w5AooUFVMMykgW4YJxKdaUOima+opMFb5CxNFD76sEHDKeUZ06FhYTEpY9Wi2jQWwHs8y0IZlhrH1azMyy0Insdz6eJ5+68X57VrOEVRVGQPHTPcWBytt6a5h26cmuHNOOUN2M/8vFQRXWbec7B9n7KOwvgtkpXTuxTdl05GMZMsrgX51Sd+o8wFTMfw69ywcHgoZzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ozHQNYAw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ozHQNYAw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfrXp2vzpz2xqj
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 20:30:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767000597; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zzU0fFMiBI6Btba2fQszSuRuhXNAVv5WzkyTFe9Hlhs=;
	b=ozHQNYAwOSikn5IZlj1YFCPDApGhkpw2njzeLATpd6HSGlRsj2btXZJgyLYeHjAGpvC46l3S7ePg4SccaOa1XQeWLfDaQALcpTpjuAI50QFl37DqFfEqHaY6AGGjPkvX6gvLda+gW8NJ/9rNiBsA0DRHJ15vTZ8/sTEPrXY275k=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvqzdtL_1767000595 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 17:29:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/4] erofs: unexport erofs_xattr_prefix()
Date: Mon, 29 Dec 2025 17:29:49 +0800
Message-ID: <20251229092949.2316075-4-hsiangkao@linux.alibaba.com>
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

It can be simply in xattr.c due to no external users.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 27 +++++++++++++++++++++++++++
 fs/erofs/xattr.h | 30 ------------------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 972941ecb71c..d25c1cc1940c 100644
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
@@ -462,6 +464,31 @@ const struct xattr_handler * const erofs_xattr_handlers[] = {
 	NULL,
 };
 
+static const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry)
+{
+	const struct xattr_handler *handler = NULL;
+
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
+
+	if (idx && idx < ARRAY_SIZE(xattr_handler_map))
+		handler = xattr_handler_map[idx];
+
+	if (!xattr_handler_can_list(handler, dentry))
+		return NULL;
+
+	return xattr_prefix(handler);
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


