Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E31809F5
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 10:20:14 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461Yjl1xpszDqgB
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 18:20:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mqV7tEz5"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461Yjd3lYKzDqTL
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Aug 2019 18:20:02 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id m30so38096968pff.8
 for <linux-erofs@lists.ozlabs.org>; Sun, 04 Aug 2019 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=494QQhiX01O8XObRPMxSFAi4k/TtIBxBlLUKQunsN88=;
 b=mqV7tEz5TmdM4/UnyiekOgWHQEt3aBmpuze9qkg3jiwWgz30AayLKbS/xKVjVjnDSz
 2TiXIg6KFu1x2fj747sdmEH1kkkGAMghjx/qBCOXFXuzN1tKB8/3NDLCtME5fiwsvWjD
 lTNP1oi6f5XJwS//aayqpsm8tJdR6oRMsmfGZnyWOns/vvZMqCUf9v8kQoAfVqpx29D6
 qtRCtG9vjZX44sQXQi7HtAlH6fmzo0eaHS0iCOHjG/riycTMxNvcPlkpKXrp5X5XTh88
 hxk0gZmzjBqMbZmvLZOOTBy/YEdPycW5hyP27zBnaxr4LQg5oY8V18HHcnl3ydTXPr4k
 INEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=494QQhiX01O8XObRPMxSFAi4k/TtIBxBlLUKQunsN88=;
 b=Ga6SH2BEMpyzwWhq3m1bJaRV1LUijcaaCf2hl0oeVIT3PD9Y4nAUe884w5hff0t8Rv
 bdWWJ9lMx9mIQhhsC523O7cVfm9m/Xe9H3E9qVpQRf/6V8PBZCYxp5C8RCREaz12BMKf
 S38+RtrCXCuloN8NNF2ILa5bVrEIu8khnahVBuLCSJ3qXGyfaMQTret9wLjl08kE39Xp
 ipxBbgZtvhj6SOJP1WDyp1uedtXc2EW+rb8K0Z/uICUxjcOde/bQnFd5XnpEnxW1trjR
 7nJOzXHvJ0w50yz2jO040e64KijaIlSi2u7JUvxwG6+moMiklev3mI/1kfi56Pl5NNqq
 WnBg==
X-Gm-Message-State: APjAAAXj7wI/v1TUHQRS++jym/TxSBEnoYbWHzSgMGeSp4DTnU8SbM61
 owlWkzlaTS3OhT1RyqbXExwUGJhBYU/XWQ==
X-Google-Smtp-Source: APXvYqx9hg/HvCtwBsmnx80Ff9CH0Z6zsYVj+8sFQY+E9+7lmTk7HL0jDLkkDV9oBItSM4Qm8u57dQ==
X-Received: by 2002:a65:640d:: with SMTP id
 a13mr130545546pgv.256.1564906798875; 
 Sun, 04 Aug 2019 01:19:58 -0700 (PDT)
Received: from localhost.localdomain ([103.97.240.130])
 by smtp.gmail.com with ESMTPSA id w197sm101630357pfd.41.2019.08.04.01.19.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 01:19:57 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH v2] erofs-utils: code for handling incorrect debug level.
Date: Sun,  4 Aug 2019 13:49:43 +0530
Message-Id: <20190804081943.20666-1-pratikshinde320@gmail.com>
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

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 include/erofs/print.h | 18 +++++++++++++-----
 mkfs/main.c           | 19 ++++++++-----------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/erofs/print.h b/include/erofs/print.h
index bc0b8d4..296cbbf 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -12,6 +12,15 @@
 #include "config.h"
 #include <stdio.h>
 
+enum {
+	EROFS_MSG_MIN = 0,
+	EROFS_ERR     = 0,
+	EROFS_WARN    = 2,
+	EROFS_INFO    = 3,
+	EROFS_DBG     = 7,
+	EROFS_MSG_MAX = 9
+};
+
 #define FUNC_LINE_FMT "%s() Line[%d] "
 
 #ifndef pr_fmt
@@ -19,7 +28,7 @@
 #endif
 
 #define erofs_dbg(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 7) {				\
+	if (cfg.c_dbg_lvl >= EROFS_DBG) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -29,7 +38,7 @@
 } while (0)
 
 #define erofs_info(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 3) {				\
+	if (cfg.c_dbg_lvl >= EROFS_INFO) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -40,7 +49,7 @@
 } while (0)
 
 #define erofs_warn(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 2) {				\
+	if (cfg.c_dbg_lvl >= EROFS_WARN) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -51,7 +60,7 @@
 } while (0)
 
 #define erofs_err(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 0) {				\
+	if (cfg.c_dbg_lvl >= EROFS_ERR) {			\
 		fprintf(stderr,					\
 			"Err: " pr_fmt(fmt),			\
 			__func__,				\
@@ -64,4 +73,3 @@
 
 
 #endif
-
diff --git a/mkfs/main.c b/mkfs/main.c
index fdb65fd..d915d00 100644
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
+			if (cfg.c_dbg_lvl < EROFS_MSG_MIN
+			    || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
+				fprintf(stderr,
+					"invalid debug level %d\n",
+					cfg.c_dbg_lvl);
+				return -EINVAL;
+			}
 			break;
 
 		case 'E':
-- 
2.9.3

