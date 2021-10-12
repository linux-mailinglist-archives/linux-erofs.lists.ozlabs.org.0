Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7EB429DC2
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Oct 2021 08:32:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HT5Rd5ZFZz2yPG
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Oct 2021 17:31:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HT5RY3m5dz2xgP
 for <linux-erofs@lists.ozlabs.org>; Tue, 12 Oct 2021 17:31:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UrYOPQA_1634020301; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UrYOPQA_1634020301) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 12 Oct 2021 14:31:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: don't print source file information for
 non-debug version
Date: Tue, 12 Oct 2021 14:31:41 +0800
Message-Id: <20211012063141.115164-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There is no need for end users to know the function details.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/print.h | 73 ++++++++++++++++++++++---------------------
 lib/block_list.c      |  2 +-
 lib/io.c              |  2 +-
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/erofs/print.h b/include/erofs/print.h
index 57b6607..91f864b 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -19,52 +19,55 @@ enum {
 	EROFS_MSG_MAX = 9
 };
 
+#ifndef EROFS_MODNAME
+#define EROFS_MODNAME	"erofs"
+#endif
 #define FUNC_LINE_FMT "%s() Line[%d] "
 
+#ifdef NDEBUG
+#ifndef pr_fmt
+#define pr_fmt(fmt)	EROFS_MODNAME ": " fmt "\n"
+#endif
+#define PR_FMT_FUNC_LINE(fmt)	pr_fmt(fmt)
+#else
 #ifndef pr_fmt
-#define pr_fmt(fmt) "EROFS: " FUNC_LINE_FMT fmt "\n"
+#define pr_fmt(fmt)	EROFS_MODNAME ": " FUNC_LINE_FMT fmt "\n"
+#endif
+#define PR_FMT_FUNC_LINE(fmt)	pr_fmt(fmt), __func__, __LINE__
 #endif
 
-#define erofs_dbg(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= EROFS_DBG) {			\
-		fprintf(stdout,					\
-			pr_fmt(fmt),				\
-			__func__,				\
-			__LINE__,				\
-			##__VA_ARGS__);				\
-	}							\
+#define erofs_dbg(fmt, ...) do {			\
+	if (cfg.c_dbg_lvl >= EROFS_DBG) {		\
+		fprintf(stdout,				\
+			"<D> " PR_FMT_FUNC_LINE(fmt),	\
+			##__VA_ARGS__);			\
+	}						\
 } while (0)
 
-#define erofs_info(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= EROFS_INFO) {			\
-		fprintf(stdout,					\
-			pr_fmt(fmt),				\
-			__func__,				\
-			__LINE__,				\
-			##__VA_ARGS__);				\
-		fflush(stdout);					\
-	}							\
+#define erofs_info(fmt, ...) do {			\
+	if (cfg.c_dbg_lvl >= EROFS_INFO) {		\
+		fprintf(stdout,				\
+			"<I> " PR_FMT_FUNC_LINE(fmt),	\
+			##__VA_ARGS__);			\
+		fflush(stdout);				\
+	}						\
 } while (0)
 
-#define erofs_warn(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= EROFS_WARN) {			\
-		fprintf(stdout,					\
-			pr_fmt(fmt),				\
-			__func__,				\
-			__LINE__,				\
-			##__VA_ARGS__);				\
-		fflush(stdout);					\
-	}							\
+#define erofs_warn(fmt, ...) do {			\
+	if (cfg.c_dbg_lvl >= EROFS_WARN) {		\
+		fprintf(stdout,				\
+			"<W> " PR_FMT_FUNC_LINE(fmt),	\
+			##__VA_ARGS__);			\
+		fflush(stdout);				\
+	}						\
 } while (0)
 
-#define erofs_err(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= EROFS_ERR) {			\
-		fprintf(stderr,					\
-			"Err: " pr_fmt(fmt),			\
-			__func__,				\
-			__LINE__,				\
-			##__VA_ARGS__);				\
-	}							\
+#define erofs_err(fmt, ...) do {			\
+	if (cfg.c_dbg_lvl >= EROFS_ERR) {		\
+		fprintf(stderr,				\
+			"<E> " PR_FMT_FUNC_LINE(fmt),	\
+			##__VA_ARGS__);			\
+	}						\
 } while (0)
 
 #define erofs_dump(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
diff --git a/lib/block_list.c b/lib/block_list.c
index 15bb5cf..096dc9b 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -8,7 +8,7 @@
 #include <sys/stat.h>
 #include "erofs/block_list.h"
 
-#define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
+#define EROFS_MODNAME	"erofs block_list"
 #include "erofs/print.h"
 
 static FILE *block_list_fp;
diff --git a/lib/io.c b/lib/io.c
index 03c7e33..cfc062d 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -20,7 +20,7 @@
 #include <linux/falloc.h>
 #endif
 
-#define pr_fmt(fmt) "EROFS IO: " FUNC_LINE_FMT fmt "\n"
+#define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
 static const char *erofs_devname;
-- 
2.24.4

