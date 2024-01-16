Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22582E887
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 05:27:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TDbZG6Gljz3bsS
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 15:27:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TDbZ72zqfz3bX9
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jan 2024 15:26:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W-kkCpQ_1705379203;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-kkCpQ_1705379203)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 12:26:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: avoid noisy prints if stdout is not a tty
Date: Tue, 16 Jan 2024 12:26:42 +0800
Message-Id: <20240116042642.3124559-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CAO8sHcmnq+foWo7AZYbkxJXHfSeZkd73Dq+1dQSZYBE6QxL8JQ@mail.gmail.com>
References: <CAO8sHcmnq+foWo7AZYbkxJXHfSeZkd73Dq+1dQSZYBE6QxL8JQ@mail.gmail.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Daan reported, "mkfs.erofs is super verbose as \r doesn't go to
the beginning of the line".  Don't print messages like this if
stdout is not a tty.

Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Closes: https://lore.kernel.org/r/CAO8sHcmnq+foWo7AZYbkxJXHfSeZkd73Dq+1dQSZYBE6QxL8JQ@mail.gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/config.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/lib/config.c b/lib/config.c
index 0cddc95..aa3dd1f 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <unistd.h>
 #include "erofs/print.h"
 #include "erofs/internal.h"
 #include "liberofs_private.h"
@@ -16,6 +17,7 @@
 
 struct erofs_configure cfg;
 struct erofs_sb_info sbi;
+bool erofs_stdout_tty;
 
 void erofs_init_configure(void)
 {
@@ -33,6 +35,8 @@ void erofs_init_configure(void)
 	cfg.c_pclusterblks_max = 1;
 	cfg.c_pclusterblks_def = 1;
 	cfg.c_max_decompressed_extent_bytes = -1;
+
+	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
 
 void erofs_show_config(void)
@@ -107,15 +111,19 @@ char *erofs_trim_for_progressinfo(const char *str, int placeholder)
 {
 	int col, len;
 
+	if (!erofs_stdout_tty) {
+		return strdup(str);
+	} else {
 #ifdef GWINSZ_IN_SYS_IOCTL
-	struct winsize winsize;
+		struct winsize winsize;
 
-	if(ioctl(1, TIOCGWINSZ, &winsize) >= 0 &&
-	   winsize.ws_col > 0)
-		col = winsize.ws_col;
-	else
+		if(ioctl(STDOUT_FILENO, TIOCGWINSZ, &winsize) >= 0 &&
+		   winsize.ws_col > 0)
+			col = winsize.ws_col;
+		else
 #endif
-		col = 80;
+			col = 80;
+	}
 
 	if (col <= placeholder)
 		return strdup("");
@@ -140,7 +148,7 @@ void erofs_msg(int dbglv, const char *fmt, ...)
 	FILE *f = dbglv >= EROFS_ERR ? stderr : stdout;
 
 	if (__erofs_is_progressmsg) {
-		fputc('\n', f);
+		fputc('\n', stdout);
 		__erofs_is_progressmsg = false;
 	}
 	va_start(ap, fmt);
@@ -160,7 +168,12 @@ void erofs_update_progressinfo(const char *fmt, ...)
 	vsprintf(msg, fmt, ap);
 	va_end(ap);
 
-	printf("\r\033[K%s", msg);
-	__erofs_is_progressmsg = true;
-	fflush(stdout);
+	if (erofs_stdout_tty) {
+		printf("\r\033[K%s", msg);
+		__erofs_is_progressmsg = true;
+		fflush(stdout);
+		return;
+	}
+	fputs(msg, stdout);
+	fputc('\n', stdout);
 }
-- 
2.39.3

