Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AB80528
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2019 10:03:49 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460xPG1td4zDrBm
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2019 18:03:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pDfnCHFS"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460xP56QbKzDrBg
 for <linux-erofs@lists.ozlabs.org>; Sat,  3 Aug 2019 18:03:37 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id b13so37153644pfo.1
 for <linux-erofs@lists.ozlabs.org>; Sat, 03 Aug 2019 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=j4U07KE8sqh0anGpjWHMRywPia/lx7j6GCfzTKAQnwU=;
 b=pDfnCHFSXC2PRP1NdeO89PNgTMlCrU2VK9Igp+97ARSJxmwybcZnIeg0cLy55ORBgo
 2yYwOTz8p15TV9t2J9rVnNE4WAMk0kkGjwNTPZlpB+BBOGL6S02WHHgz6CWLZ8AJBe21
 IkoM/4glm2v9BjKFc/OAuXKoLyuDc38kVVFtg0cpdQBHgtV8xTbvEzXn2xYjhUG37p2W
 +MaH2QTq+jyFU+TLZDZgiuBFP2VCs2+/q1tnPpzY4tOVs57tVzqI3+d0dUnXPmWOsqJ1
 P18exyl0N/xoRiRIwOL8BOUagFR7RHwoVAImOYmNhPMZqSXFxjDbeeGZ1MW93SDQw2E+
 w+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=j4U07KE8sqh0anGpjWHMRywPia/lx7j6GCfzTKAQnwU=;
 b=cZ11OMCOImB5DP3Wr//AshdydZRc1MUXLzl4HXv4r+K8yV/hEj1FFpZfs99HC5+HJw
 eQ9qQmTGEdqKao7dieO1s2okeUASFdi+UWI3Y4SPQchQ68RNF/qoN6e/pNQvNVdRUqTv
 b4cbTdylgkl0GkmRzzqvIazv9JQVuGctgqOBHtwkUbDK5/3Epy33NFDbLt6ynXRpgV8N
 KHemIT5yABU4Wsi0Z6IAtq9Kn8Uo/HjPNqlMOjmOOroas/Zv76wSyCU8AyZU/BbDgG3Y
 0qlUp22YvZYZLO2eig56GaDBZAYQ3Ma1fUWgf0CW//V86GDm+pAzfKgTlmS4AnDZep7J
 RzWQ==
X-Gm-Message-State: APjAAAWT+fPVQC4mj7wIgDG/A9t/7oHzrc9oGEPSmzPGYdvuare9BY6K
 BKTh3wx8PY21bvy4fSnc3dLcaFUnm2w=
X-Google-Smtp-Source: APXvYqxDgzK+UvvXJU1jMCL2ZdcsrB3pPpuAUWbJlxPU53CAGOI2ERVo15SPdXcp6FS1c4zvFktihQ==
X-Received: by 2002:a63:58c:: with SMTP id 134mr133303057pgf.106.1564819411717; 
 Sat, 03 Aug 2019 01:03:31 -0700 (PDT)
Received: from localhost.localdomain ([42.107.84.121])
 by smtp.gmail.com with ESMTPSA id o3sm7398887pje.1.2019.08.03.01.03.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Aug 2019 01:03:30 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: code for handling incorrect debug level.
Date: Sat,  3 Aug 2019 13:33:10 +0530
Message-Id: <20190803080310.17827-1-pratikshinde320@gmail.com>
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

handling the case of incorrect debug level.
Added an enumerated type for supported debug levels.
Using 'atoi' in place of 'parse_num_from_str'.

I have dropped the check for invalid compression algo name(which was there
in last patch)
Note:I think this patch covers different set of code changes than previous
patch,Hence I am sending a new patch instead of 'v2' of previous patch.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/print.h | 16 ++++++++++++----
 mkfs/main.c           | 19 ++++++++-----------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/erofs/print.h b/include/erofs/print.h
index bc0b8d4..d6ec692 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -12,6 +12,14 @@
 #include "config.h"
 #include <stdio.h>
 
+enum {
+	EROFS_ERR     = 0,
+	EROFS_WARN    = 2,
+	EROFS_INFO    = 3,
+	EROFS_DBG     = 7,
+	EROFS_DBG_MAX = 9
+};
+
 #define FUNC_LINE_FMT "%s() Line[%d] "
 
 #ifndef pr_fmt
@@ -19,7 +27,7 @@
 #endif
 
 #define erofs_dbg(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 7) {				\
+	if (cfg.c_dbg_lvl >= EROFS_DBG) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -29,7 +37,7 @@
 } while (0)
 
 #define erofs_info(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 3) {				\
+	if (cfg.c_dbg_lvl >= EROFS_INFO) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -40,7 +48,7 @@
 } while (0)
 
 #define erofs_warn(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 2) {				\
+	if (cfg.c_dbg_lvl >= EROFS_WARN) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -51,7 +59,7 @@
 } while (0)
 
 #define erofs_err(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 0) {				\
+	if (cfg.c_dbg_lvl >= EROFS_ERR) {			\
 		fprintf(stderr,					\
 			"Err: " pr_fmt(fmt),			\
 			__func__,				\
diff --git a/mkfs/main.c b/mkfs/main.c
index fdb65fd..9b497d8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -30,16 +30,6 @@ static void usage(void)
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 }
 
-u64 parse_num_from_str(const char *str)
-{
-	u64 num      = 0;
-	char *endptr = NULL;
-
-	num = strtoull(str, &endptr, 10);
-	BUG_ON(num == ULLONG_MAX);
-	return num;
-}
-
 static int parse_extended_opts(const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
@@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 
 		case 'd':
-			cfg.c_dbg_lvl = parse_num_from_str(optarg);
+			cfg.c_dbg_lvl = atoi(optarg);
+			if (cfg.c_dbg_lvl < EROFS_ERR
+			    || cfg.c_dbg_lvl > EROFS_DBG_MAX) {
+				fprintf(stderr,
+					"invalid debug level %d\n",
+					cfg.c_dbg_lvl);
+				return -EINVAL;
+			}
 			break;
 
 		case 'E':
-- 
2.9.3

