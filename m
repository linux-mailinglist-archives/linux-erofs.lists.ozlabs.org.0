Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FE76ACE1
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 18:36:05 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p5cd70BbzDqcl
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 02:36:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=karen.palacio.1994@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="en1RnZXj"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45p5cW1zKpzDqVv
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 02:35:51 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id d15so15079018qkl.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=nh9TRJL/K8T4zPdIntfX6BH8MCZBmQixSPnd0YhJt1g=;
 b=en1RnZXj8YDhDGqW04SYySgMEhAR441ByIwhjWRBVk58SRk4l2PeCyo8KuxCAv3/3m
 49eLLvNfdWSK44qeEvtXOKEdI6m4DOGN4tYBTEjxvWMoBbHH6Bp/7GSIC59k0sIHFDR+
 bpESgX5UsOHObZyE4PZScnNVapdZsXynMgKrLxuS8/YzcxHdEaOl0Vxi8u2shP8/m+Gm
 XYtn58uma7w29iEbOCd3NRtKfzY4SZvCbY72qMhQ0nixNY5kkh3WXtN9mRQvL7A0ctYh
 wYCrLm+/cIJ9UBbj6CzFuwu3N+fPSZzk9XQ6uvYpCYDmlS33CdF+ZJ1us1DzpizXyW3w
 epVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=nh9TRJL/K8T4zPdIntfX6BH8MCZBmQixSPnd0YhJt1g=;
 b=msbtYCPWfidtv0s2D0D3PxUf1qaXniPjltWM6FlcZpTVUDniUNUlq5ZXI0y3e0T3+T
 4F4OIVI0VFSM/Ulr3s1KEyFa92T+qsgSmijHWXttydJ1gMgChGlPA89IrEsGpbYms5kU
 jd+GcuVi7130QWIhtGHhsBkcw713Hz1wpV/jnay8DU/AiYLMuEZ/fF7/9kBX/5GKlOK1
 hUTgbY0yIew4g2SrKm953Ui21brqqwiamj+hfJDW3/CKlLLrwHqyLcb+ezEBrmrvrMEF
 bI8BeIaHGntX5/93FU30FxuJFXcw/IrrfBsX+tTmL4rf2oBRtVmsaEoRygxaiKwZB83l
 ZIkQ==
X-Gm-Message-State: APjAAAUMLdRLmoxP9Tl+QxoNyXqo1KizYsqTFn54SoZigzz+fW/P25wT
 v/0SRBfNRuLskwYS+FRprGR2OMn1rBg=
X-Google-Smtp-Source: APXvYqz9d2L3jP1bkM+IMvY9gjJWbxYcsrj9l/fTSt6M0ABvgfEbbTTlUp29IzLGu0TSMW+DvPG92g==
X-Received: by 2002:ae9:e845:: with SMTP id a66mr21943097qkg.451.1563294947824; 
 Tue, 16 Jul 2019 09:35:47 -0700 (PDT)
Received: from maquinola.fibertel.com.ar ([181.31.154.224])
 by smtp.gmail.com with ESMTPSA id m12sm8869708qkk.123.2019.07.16.09.35.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 16 Jul 2019 09:35:47 -0700 (PDT)
From: Karen Palacio <karen.palacio.1994@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@huawei.com,
	yucha0@huawei.com
Subject: [PATCH] staging: erofs: a few minor style fixes found using checkpatch
Date: Tue, 16 Jul 2019 13:35:42 -0300
Message-Id: <1563294942-31395-1-git-send-email-karen.palacio.1994@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 Karen Palacio <karen.palacio.1994@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fix camel case use in variable names,
Fix multiple assignments done in a single line,
Fix end of line containing '('.

Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
---
 drivers/staging/erofs/super.c | 55 ++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 5449441..e281125 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -228,21 +228,21 @@ static void default_options(struct erofs_sb_info *sbi)
 }
 
 enum {
-	Opt_user_xattr,
-	Opt_nouser_xattr,
-	Opt_acl,
-	Opt_noacl,
-	Opt_fault_injection,
-	Opt_err
+	opt_user_xattr,
+	opt_nouser_xattr,
+	opt_acl,
+	opt_noacl,
+	opt_fault_injection,
+	opt_err
 };
 
 static match_table_t erofs_tokens = {
-	{Opt_user_xattr, "user_xattr"},
-	{Opt_nouser_xattr, "nouser_xattr"},
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_fault_injection, "fault_injection=%u"},
-	{Opt_err, NULL}
+	{opt_user_xattr, "user_xattr"},
+	{opt_nouser_xattr, "nouser_xattr"},
+	{opt_acl, "acl"},
+	{opt_noacl, "noacl"},
+	{opt_fault_injection, "fault_injection=%u"},
+	{opt_err, NULL}
 };
 
 static int parse_options(struct super_block *sb, char *options)
@@ -260,41 +260,42 @@ static int parse_options(struct super_block *sb, char *options)
 		if (!*p)
 			continue;
 
-		args[0].to = args[0].from = NULL;
+		args[0].to = NULL;
+		args[0].from = NULL;
 		token = match_token(p, erofs_tokens, args);
 
 		switch (token) {
 #ifdef CONFIG_EROFS_FS_XATTR
-		case Opt_user_xattr:
+		case opt_user_xattr:
 			set_opt(EROFS_SB(sb), XATTR_USER);
 			break;
-		case Opt_nouser_xattr:
+		case opt_nouser_xattr:
 			clear_opt(EROFS_SB(sb), XATTR_USER);
 			break;
 #else
-		case Opt_user_xattr:
+		case opt_user_xattr:
 			infoln("user_xattr options not supported");
 			break;
-		case Opt_nouser_xattr:
+		case opt_nouser_xattr:
 			infoln("nouser_xattr options not supported");
 			break;
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-		case Opt_acl:
+		case opt_acl:
 			set_opt(EROFS_SB(sb), POSIX_ACL);
 			break;
-		case Opt_noacl:
+		case opt_noacl:
 			clear_opt(EROFS_SB(sb), POSIX_ACL);
 			break;
 #else
-		case Opt_acl:
+		case opt_acl:
 			infoln("acl options not supported");
 			break;
-		case Opt_noacl:
+		case opt_noacl:
 			infoln("noacl options not supported");
 			break;
 #endif
-		case Opt_fault_injection:
+		case opt_fault_injection:
 			err = erofs_build_fault_attr(EROFS_SB(sb), args);
 			if (err)
 				return err;
@@ -525,7 +526,6 @@ static void erofs_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
-
 struct erofs_mount_private {
 	const char *dev_name;
 	char *options;
@@ -541,9 +541,9 @@ static int erofs_fill_super(struct super_block *sb,
 		priv->options, silent);
 }
 
-static struct dentry *erofs_mount(
-	struct file_system_type *fs_type, int flags,
-	const char *dev_name, void *data)
+static struct dentry *erofs_mount(struct file_system_type *fs_type,
+				  int flags,
+				  const char *dev_name, void *data)
 {
 	struct erofs_mount_private priv = {
 		.dev_name = dev_name,
@@ -623,7 +623,8 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = EROFS_BLKSIZ;
 	buf->f_blocks = sbi->blocks;
-	buf->f_bfree = buf->f_bavail = 0;
+	buf->f_bfree = 0;
+	buf->f_bavail = 0;
 
 	buf->f_files = ULLONG_MAX;
 	buf->f_ffree = ULLONG_MAX - sbi->inos;
-- 
2.7.4

