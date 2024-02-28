Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840486B489
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 17:17:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlKJD4xCnz3d24
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 03:17:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlKJ95jNJz3bsQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 03:17:29 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id D80831008EE02;
	Thu, 29 Feb 2024 00:17:00 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 0D04C37C969;
	Thu, 29 Feb 2024 00:16:59 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v4 2/5] erofs-utils: add a helper to get available processors
Date: Thu, 29 Feb 2024 00:16:49 +0800
Message-ID: <20240228161652.1010997-3-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240228161652.1010997-1-zhaoyifan@sjtu.edu.cn>
References: <20240228161652.1010997-1-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

In order to prepare for multi-threaded decompression.

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
2.44.0

