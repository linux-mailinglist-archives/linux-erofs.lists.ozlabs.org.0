Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F34389C74A2
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 15:43:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XpQxs4mLhz2ykx
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 01:43:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731508991;
	cv=none; b=LRxDWsZmipqFdsZDrA1Tphx75xRIm51PqOsOyGUSiWPHPJ57fqcQT+2m813+RiNX60PcauzHoBPSPFyM8DGKD46+gPSQt15ZRbQa+JBCjInJ1Sn6QxzcwJUf2bebiqeqB/y1hcZ1gJdfRgiLApltMRp6aeCon0Z/euGo9eDxz+lxr55GpDvD7RK2dkztHisutSbrJ4j6P8j3U1bk2VIdDgP4JsMJcG9ACdaINvj61os7B35hMExD1CN0L0y7geIQqfsaX9e1GhnBqFSDFtC7ztVXl8AEXDcxvH69qnZUqiieg52bc2uyDJ1fOnb8E3vJONCRe1KEzrsLoKtf2rSgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731508991; c=relaxed/relaxed;
	bh=tcccd3hBahsewM/oREozkbOfOAC3JC5LE7jpoIyvSG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LkwWEz8NDc9ptudBIbtdIwARj4wHaBWF2BKb4scW5lT/O/1rc83tnOGnZ9BfFoIjjSFtkvI0luvWr0pav4vVrnmU60pNFVPO1jIsRF5AwrlahS9qHEPRWk085a0B9b2+wSc/bhuWZnpKfAqSA7vjT6qYnBp32kvIUYgaYK35VqukNnNahvNdIiBfGrBi+CKt3hy65rQSZgX/GaDwnX4oO5OWciMTJO3IuYOv44+9V+zul8TwmhKd2oa014rnq33AyrBeOyYuFzmdIbPRo7QHRIwGlKbhlRaaDfI3pfe/btVrqMBN5ibuGM3cZ0v6TnrXfYR4I8sDNITDD+YZxftY8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Qt1vGPrK; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Qt1vGPrK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XpQxm6Qmsz2x9j
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 01:43:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731508897;
	bh=tcccd3hBahsewM/oREozkbOfOAC3JC5LE7jpoIyvSG0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Qt1vGPrKCGfpqSMpsfPk7r+lqjDleEgwRVdyPgqDjnEcB8EKBkYqUy45NkBqTIKnL
	 BO7oGzWdLDKIdv1oz3X+qe/8IFxoDAhFu31ljTU9Ww82/pxGpsyK6sdx3WchZO/wTh
	 sIG7P5TwJCJVqmYRxCS+iLDEKB3b6QzLaHvo3+1o=
X-QQ-mid: bizesmtpip3t1731508890tnsri50
X-QQ-Originating-IP: 72EAmLEmLHjrTNLhjiWJbsIPwPf8mNCoZufANwO7KbQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Nov 2024 22:41:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3136521576167551353
From: Gou Hao <gouhao@uniontech.com>
To: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V2] erofs: simplify definition of the log functions
Date: Wed, 13 Nov 2024 22:41:28 +0800
Message-Id: <20241113144128.16007-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MxDmZisZxeG6tejz1Ix4o5+kvAUB8JTogwiI965QF/2lwbUjKCxma7Tj
	rNSPUY11+fXVG84FZTChrLCKDw/UuzZuwR3OcsGzBdsXOYdB9h329dN5wdV+erG+BHRQiL7
	gbYp95n38ZsiFpUlIixPrqat/1wUYXMZI++O/WJ3zESSNIE5iohUdOSz/xvFwSQLhAFkwXz
	XR5x6HnqBm3OKTz1nhE1ZdNkmcxR0pN0XV4K7WPg7QoL3PJcLpwt80/MHta4wBhY05+lg/H
	Gnq5B2cWUE+p04cODLAmf5O7yMZEaH9BeTCfWTh231p8tEi+jB2RLnJNEVqpqlPdzuK6ztf
	nwxdYD2VtSPoSqn1YMmQRntZUk36wB9gHeOGSy8ZgBEob79IOyr2gaTz+Bcszsp2GeP4Xrf
	aXH0VF5hI9GOSjwAK5Q/joZnLUVqFQQbweRxYrVJRidcI7QigEQjGc9pZGB+nsJIsXSYxAU
	oW1AMpnxObr1itWyavbY1bZnR8ztDZHpXnEq7pVpDAKHPNcf83mR2vi2O5kvjn8pnkXLkFI
	wA6ed7yXUA+pTlLLYoTvvVWRDebHezW9jZKPCdIT6Z3aZTGCOIrTCvyx+dgEEDHhoeEygM1
	PHQX5+zfD5MwFACOTnz0eu4GeeVN7sntCOSo14I4aPTXwZpspkh/97NWj27YNoOh1IPOCoG
	tigIxrUB6iZZ9L0Gn6QbC+B0rjfzq0e6upsPe2rRqopP/ZXA3sKNklphATIyTLkZx+cNsIo
	foNtGsUlKmZ2Qw6/98B0nWT/aTARGyy2lnGKvuB+dShIjTjOEBmtCPam10roMUIXI+NaGhS
	zIYLCFCXK9FP4PH93jXty2C3FDqY7MS4ugBsc2hJ5OrtPyBUl4eT9UzjhbFUDSgyPXmhICU
	akftEJVo8Wwq+437VJz4qDRT1aKyd0C9frH5SY97j1gmQFDc7K1yBwjyvIgwvfx6YOW2z/V
	XzjSUZeehsklFPk3slOyAph79Qp0iAjloQNXLEZiVqFLdTydsLLZtY3RJcHn6UvQEyqNaJJ
	kouD0prg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: gouhaojake@163.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use printk instead of pr_info/err to reduce
redundant code.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h | 14 ++++----------
 fs/erofs/super.c    | 28 +++++++---------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

Changes:
V2:
- remove 'const char  *function' from _erofs_printk
- remove pr_fmt macro, put 'erofs' prefix into printk

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..116c82588661 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -20,18 +20,12 @@
 #include <linux/iomap.h>
 #include "erofs_fs.h"
 
-/* redefine pr_fmt "erofs: " */
-#undef pr_fmt
-#define pr_fmt(fmt) "erofs: " fmt
-
-__printf(3, 4) void _erofs_err(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+__printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
 #define erofs_err(sb, fmt, ...)	\
-	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
-__printf(3, 4) void _erofs_info(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+	_erofs_printk(sb, KERN_ERR fmt "\n", ##__VA_ARGS__)
 #define erofs_info(sb, fmt, ...) \
-	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
+	_erofs_printk(sb, KERN_INFO fmt "\n", ##__VA_ARGS__)
+
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define DBG_BUGON               BUG_ON
 #else
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..93b44b77a41c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,37 +18,23 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
+void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
+	int level;
 
 	va_start(args, fmt);
 
-	vaf.fmt = fmt;
+	level = printk_get_level(fmt);
+	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
 
 	if (sb)
-		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+		printk("%c%cerofs: (device %s): %pV",
+				KERN_SOH_ASCII, level, sb->s_id, &vaf);
 	else
-		pr_err("%s: %pV", func, &vaf);
-	va_end(args);
-}
-
-void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	if (sb)
-		pr_info("(device %s): %pV", sb->s_id, &vaf);
-	else
-		pr_info("%pV", &vaf);
+		printk("%c%cerofs: %pV", KERN_SOH_ASCII, level, &vaf);
 	va_end(args);
 }
 
-- 
2.43.0

