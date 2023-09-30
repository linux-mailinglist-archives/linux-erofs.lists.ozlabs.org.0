Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA27B3E23
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Sep 2023 07:01:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a/oP7Gc2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RyFS5384yz3cTJ
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Sep 2023 15:01:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a/oP7Gc2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=wedsonaf@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RyFRy2nxnz3c3k
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 Sep 2023 15:01:32 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5789de5c677so10236052a12.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 29 Sep 2023 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050085; x=1696654885; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF2XqSbh4bo4XlOeQPlKNJjJGH1v1k5zwfAqr3Sp+Eg=;
        b=a/oP7Gc2MOPmICtAfGo/Wn+TStisWM+CLLYlvraIJUWtbyKscbv9EHdGTiPr8MFNe/
         I4EyR4p5PQp/5MXId3jwreXDaB/oLeMYTtTizb4SXRh3ionEtD50W5+OCdJk0Dp4aXfE
         g4W9xwt7xkBUiRttFWZkE7rF+e8XhMK6q2atYid9MrFQ0hwvli8/V5A3TEtjf7AWFp5/
         v7CRaEoOeqnt29DiLOvsFE5uI2VVVBOVQIGKHPFsFYq6pGl9/O6r6Fn+8q27XNA5yFZX
         N5pomoQi1RW5ME34Oz0gbUMjyPsZVZW4zkIPezAl99nXIPpR8dcOA+wrjm68jsEPiXty
         LKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050085; x=1696654885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF2XqSbh4bo4XlOeQPlKNJjJGH1v1k5zwfAqr3Sp+Eg=;
        b=cVYY2ivls65U9qycm6QBC4sM/TZ8cllL+AGDcJ+y8doNhtkGoakg/LNEHo3jkcOm8P
         N8O0WBYRpLIiUG6t4+h9r6LNQjEZ3N545GPZC4G/lLeMs1NLO+4aCfOuZdIM0QFz1Hut
         H3jIB5/HhvEsbQKG9jm5YB37sC6QCRWFoMfslBNMijKscAS6anzCPVBIfyEHRW+vGOKL
         IdpV3XVL+MUUGLCFhr+T4g+sHIwS05FnOLNfYQrIN+IEcgpRFPZZ8p4ptnbHUxM3/HXL
         VLiZwBxe/h/eM6AirFPcQG0kI6y1lWw8WUATf8irPQmGdHQ6MlX91uAHDtBhtXk31Ttd
         WC4A==
X-Gm-Message-State: AOJu0YzK78xFiIJFim42l2H4K75UewZXP/dIimjVsubyQ4aBsH351Vm9
	ft+ze+GoBs0yVxVHNGOAaow=
X-Google-Smtp-Source: AGHT+IE7V3xhs1zZFq/CXLdO1Vk52Mu1MAiCsLfb6oVrmfuzI+coZi/OnssV2s1Maqaixu9A56W4oA==
X-Received: by 2002:a05:6a20:3c87:b0:15e:bcd:57f5 with SMTP id b7-20020a056a203c8700b0015e0bcd57f5mr6763988pzj.3.1696050084677;
        Fri, 29 Sep 2023 22:01:24 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:24 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/29] erofs: move erofs_xattr_handlers and xattr_handler_map to .rodata
Date: Sat, 30 Sep 2023 02:00:12 -0300
Message-Id: <20230930050033.41174-9-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, Wedson Almeida Filho <walmeida@microsoft.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
erofs_xattr_handlers or xattr_handler_map at runtime.

Cc: Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Yue Hu <huyue2@coolpad.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/erofs/xattr.c | 2 +-
 fs/erofs/xattr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 40178b6e0688..a6dd68ea5df2 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -166,7 +166,7 @@ const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
 };
 #endif
 
-const struct xattr_handler *erofs_xattr_handlers[] = {
+const struct xattr_handler * const erofs_xattr_handlers[] = {
 	&erofs_xattr_user_handler,
 	&erofs_xattr_trusted_handler,
 #ifdef CONFIG_EROFS_FS_SECURITY
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index f16283cb8c93..b246cd0e135e 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -23,7 +23,7 @@ static inline const char *erofs_xattr_prefix(unsigned int idx,
 {
 	const struct xattr_handler *handler = NULL;
 
-	static const struct xattr_handler *xattr_handler_map[] = {
+	static const struct xattr_handler * const xattr_handler_map[] = {
 		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
@@ -44,7 +44,7 @@ static inline const char *erofs_xattr_prefix(unsigned int idx,
 	return xattr_prefix(handler);
 }
 
-extern const struct xattr_handler *erofs_xattr_handlers[];
+extern const struct xattr_handler * const erofs_xattr_handlers[];
 
 int erofs_xattr_prefixes_init(struct super_block *sb);
 void erofs_xattr_prefixes_cleanup(struct super_block *sb);
-- 
2.34.1

