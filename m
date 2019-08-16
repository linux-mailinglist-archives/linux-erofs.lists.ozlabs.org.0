Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE68FBBD
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 09:10:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468vbm0wN7zDrL9
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 17:10:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uv35nsyP"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468vbc2NP0zDrKj
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 17:10:20 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id 129so2676930pfa.4
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 00:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=k5yhjYXhzIvgVVXVbfUjZGOTp1F4rSJQyC6/j00Klao=;
 b=uv35nsyPOhdGN0c2e2tEv/wAT2T/32wnO67hoeIvUlA544hruvvsf0G18zqPY3is2K
 HzBONua/LI4nFpHDLBePx4sDsEeelmAxO08jfCLR4QaKL87KNs6eaCoFKdjsPlcxGBYm
 CKT5/gpNB85cv5DtaZbayvN4cSo3iU/7P6jQOXnTwRR+B6E3tiMtShKz+jen4RmlLvgi
 MCzApbFazkbSi7JLj+zdenchUv0a1xaQsdgWMoGSV3V/xFHKKGx8d//S+fPZW8BDsJSV
 +1SDLM1P7xM07HRndGBV7oTp/NiMIYi2582ZhFCMw3htWcIl6/Wg/rJ70QGtoG8tF9u4
 yH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=k5yhjYXhzIvgVVXVbfUjZGOTp1F4rSJQyC6/j00Klao=;
 b=kc8XMwwLqG/8F3UlR04q8MVLgN2eZTAsR0qFhlpFcZtxeB48jnRvwp2rwTuG2ojnEB
 Sr9esS1526xbFdviFF5qw28tvIQqjxI8eTi+krby0kTIEkrkNgGHwJzXfMokZtMm7LMR
 k8zLImV2s7jg2xHWD2WPiypu7shhfIflwS+i5OJOCM39LfxewxqNVegKKzgSFTLNs6BF
 5UjZXFRecNsbBbFIXeyXi7bMaVvAbSv4nksVeNFR7HM7AnXWmvf782ppcoeLBYljjUKn
 6QjoDmpI0KvEUQO06G7V+M1CaKAQ388H0cIaLd+20ZA6z9ANlD7/sI27X74zyM/RVY9f
 8Esw==
X-Gm-Message-State: APjAAAXviHZpg0ypnlQs4zeqGeKFQdtadcVO/aWtRf5VEkRcA/6Y1shV
 To2zYMCT+SrSwygLbxuu9yT7MsztTCc=
X-Google-Smtp-Source: APXvYqxeonT28/mEWKkjSICHwlTQNmO5KN3FewEMQ+VlHQjmDeQzfV8xQ/DNWYLkM4SagQu3nGGZRA==
X-Received: by 2002:aa7:85d6:: with SMTP id z22mr9084329pfn.262.1565939415236; 
 Fri, 16 Aug 2019 00:10:15 -0700 (PDT)
Received: from localhost.localdomain ([42.107.88.47])
 by smtp.gmail.com with ESMTPSA id c70sm6560062pfb.163.2019.08.16.00.10.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Aug 2019 00:10:14 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils : Fail the image creation when source path is not
 a directory file.
Date: Fri, 16 Aug 2019 12:38:46 +0530
Message-Id: <20190816070846.21557-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In the erofs.mkfs utility, if the source path is not a directory,image
creation should not proceed.since root of the filesystem needs to be a directory.

In the erofs kernel code, we return error in case root inode(read from disk) is not
a directory.But the mkfs utility lets you create an image based on Regular file
(S_IFREG) too.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 mkfs/main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 93cacca..e72b9e2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <libgen.h>
+#include <sys/stat.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/cache.h"
@@ -76,8 +77,8 @@ static int parse_extended_opts(const char *opts)
 
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
-	int opt, i;
-
+	int opt, i, ret;
+	struct stat64 st;
 	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
 		switch (opt) {
 		case 'z':
@@ -135,7 +136,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			  erofs_strerror(-errno));
 		return -ENOENT;
 	}
-
+	ret = lstat64(cfg.c_src_path, &st);
+	if (ret)
+		return -EINVAL;
+	if ((st.st_mode & S_IFMT) != S_IFDIR) {
+		erofs_err("root of the filesystem is not a directory - %s",
+			  cfg.c_src_path);
+		return -EINVAL;
+	}
 	if (optind < argc) {
 		erofs_err("Unexpected argument: %s\n", argv[optind]);
 		return -EINVAL;
-- 
2.9.3

