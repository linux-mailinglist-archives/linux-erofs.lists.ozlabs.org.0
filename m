Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5B86B48E
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 17:18:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlKJk0Sm6z3cy8
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 03:17:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlKJg5XyFz3bsQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 03:17:55 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 732641008EE04;
	Thu, 29 Feb 2024 00:17:04 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6A2AF37C986;
	Thu, 29 Feb 2024 00:17:02 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v4 4/5] erofs-utils: lib: introduce atomic operations
Date: Thu, 29 Feb 2024 00:16:51 +0800
Message-ID: <20240228161652.1010997-5-zhaoyifan@sjtu.edu.cn>
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

Add some helpers (relaxed semantics) in order to prepare for the
upcoming multi-threaded support.

For example, compressor may be initialized more than once in different
worker threads, resulting in noisy warnings.

This patch makes sure that each message will be printed only once by
adding `__warnonce` atomic booleans to each erofs_compressor_init().

Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 include/erofs/atomic.h      | 28 ++++++++++++++++++++++++++++
 lib/compressor_deflate.c    | 11 ++++++++---
 lib/compressor_libdeflate.c |  6 +++++-
 lib/compressor_liblzma.c    |  5 ++++-
 4 files changed, 45 insertions(+), 5 deletions(-)
 create mode 100644 include/erofs/atomic.h

diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
new file mode 100644
index 0000000..214cdb1
--- /dev/null
+++ b/include/erofs/atomic.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2024 Alibaba Cloud
+ */
+#ifndef __EROFS_ATOMIC_H
+#define __EROFS_ATOMIC_H
+
+/*
+ * Just use GCC/clang built-in functions for now
+ * See: https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
+ */
+typedef unsigned long erofs_atomic_t;
+typedef char erofs_atomic_bool_t;
+
+#define erofs_atomic_read(ptr) ({ \
+	typeof(*ptr) __n;    \
+	__atomic_load(ptr, &__n, __ATOMIC_RELAXED); \
+__n;})
+
+#define erofs_atomic_set(ptr, n) do { \
+	typeof(*ptr) __n = (n);    \
+	__atomic_store(ptr, &__n, __ATOMIC_RELAXED); \
+} while(0)
+
+#define erofs_atomic_test_and_set(ptr) \
+	__atomic_test_and_set(ptr, __ATOMIC_RELAXED)
+
+#endif
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index 8629415..e482224 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -7,6 +7,7 @@
 #include "erofs/print.h"
 #include "erofs/config.h"
 #include "compressor.h"
+#include "erofs/atomic.h"
 
 void *kite_deflate_init(int level, unsigned int dict_size);
 void kite_deflate_end(void *s);
@@ -36,6 +37,8 @@ static int compressor_deflate_exit(struct erofs_compress *c)
 
 static int compressor_deflate_init(struct erofs_compress *c)
 {
+	static erofs_atomic_bool_t __warnonce;
+
 	if (c->private_data) {
 		kite_deflate_end(c->private_data);
 		c->private_data = NULL;
@@ -44,9 +47,11 @@ static int compressor_deflate_init(struct erofs_compress *c)
 	if (IS_ERR_VALUE(c->private_data))
 		return PTR_ERR(c->private_data);
 
-	erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
-	erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
-	erofs_warn("Please send a report to <linux-erofs@lists.ozlabs.org> if something is wrong.");
+	if (!erofs_atomic_test_and_set(&__warnonce)) {
+		erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
+		erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
+		erofs_warn("Please send a report to <linux-erofs@lists.ozlabs.org> if something is wrong.");
+	}
 	return 0;
 }
 
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index 62d93f7..14cbce4 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -4,6 +4,7 @@
 #include "erofs/config.h"
 #include <libdeflate.h>
 #include "compressor.h"
+#include "erofs/atomic.h"
 
 static int libdeflate_compress_destsize(const struct erofs_compress *c,
 				        const void *src, unsigned int *srcsize,
@@ -82,12 +83,15 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
 
 static int compressor_libdeflate_init(struct erofs_compress *c)
 {
+	static erofs_atomic_bool_t __warnonce;
+
 	libdeflate_free_compressor(c->private_data);
 	c->private_data = libdeflate_alloc_compressor(c->compression_level);
 	if (!c->private_data)
 		return -ENOMEM;
 
-	erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
+	if (!erofs_atomic_test_and_set(&__warnonce))
+		erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
 	return 0;
 }
 
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 712f44f..2f19a93 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -9,6 +9,7 @@
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/internal.h"
+#include "erofs/atomic.h"
 #include "compressor.h"
 
 struct erofs_liblzma_context {
@@ -85,6 +86,7 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 {
 	struct erofs_liblzma_context *ctx;
 	u32 preset;
+	static erofs_atomic_bool_t __warnonce;
 
 	ctx = malloc(sizeof(*ctx));
 	if (!ctx)
@@ -103,7 +105,8 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 	ctx->opt.dict_size = c->dict_size;
 
 	c->private_data = ctx;
-	erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
+	if (!erofs_atomic_test_and_set(&__warnonce))
+		erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
 	return 0;
 }
 
-- 
2.44.0

