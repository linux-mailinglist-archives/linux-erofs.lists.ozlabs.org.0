Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE687C6F5
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 02:10:41 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OUwLpNOV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwmQR4wXcz3dVb
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 12:10:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OUwLpNOV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwmQJ2nxGz3cFX
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 12:10:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710465028; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tL4HppS5y0HvXefW9tb8Qh2TOKwqM7KqH/+j5xUSw28=;
	b=OUwLpNOVpf5bly+yN1gTgFKQpTk946GLs81XcdKn2T0/XomCOMil8dwYyoV9avibgueHkD/nqLkMxZMhsrDOkRQdqQyXWMNLJJBpoEZrFCoz4DIVqoeMTSiOryDDUxgblbNlJ95dbedNNO5Dye7YDDtg4Lq6e2xcWh9JXcPz1gI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W2UFdI._1710465024;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2UFdI._1710465024)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 09:10:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 2/5] erofs-utils: add a helper to get available processors
Date: Fri, 15 Mar 2024 09:10:16 +0800
Message-Id: <20240315011019.610442-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to prepare for multi-threaded decompression.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac           |  1 +
 include/erofs/config.h |  1 +
 lib/config.c           | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3ccd6bb..2e69260 100644
--- a/configure.ac
+++ b/configure.ac
@@ -256,6 +256,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	strerror
 	strrchr
 	strtoull
+	sysconf
 	tmpfile64
 	utimensat]))
 
diff --git a/include/erofs/config.h b/include/erofs/config.h
index eecf575..73e3ac2 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -109,6 +109,7 @@ static inline int erofs_selabel_open(const char *file_contexts)
 
 void erofs_update_progressinfo(const char *fmt, ...);
 char *erofs_trim_for_progressinfo(const char *str, int placeholder);
+unsigned int erofs_get_available_processors(void);
 
 #ifdef __cplusplus
 }
diff --git a/lib/config.c b/lib/config.c
index 1096cd1..947a183 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -14,6 +14,9 @@
 #ifdef HAVE_SYS_IOCTL_H
 #include <sys/ioctl.h>
 #endif
+#ifdef HAVE_UNISTD_H
+#include <unistd.h>
+#endif
 
 struct erofs_configure cfg;
 struct erofs_sb_info sbi;
@@ -177,3 +180,12 @@ void erofs_update_progressinfo(const char *fmt, ...)
 	fputs(msg, stdout);
 	fputc('\n', stdout);
 }
+
+unsigned int erofs_get_available_processors(void)
+{
+#if defined(HAVE_UNISTD_H) && defined(HAVE_SYSCONF)
+	return sysconf(_SC_NPROCESSORS_ONLN);
+#else
+	return 0;
+#endif
+}
-- 
2.39.3

