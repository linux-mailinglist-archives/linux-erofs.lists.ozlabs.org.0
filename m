Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BE86A9BD
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 09:21:34 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FitAWJCb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tl6kz4R80z3cM4
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 19:21:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FitAWJCb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tl6ks5nLdz3bmy
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Feb 2024 19:21:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709108479; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a45xa8sNdDLYnsiFxukqu/cSnK9SRiBhhB7BUc0yoUM=;
	b=FitAWJCbP0kKBNBHBjssgCELUcGAy0ufk2pXC7g4PO7STMNzb7KH7Ss/tHB3SEkLwimNqeR5zYndmkPoFNjgiD+GT+qhckmE7LorTkznxYsajD+ahE7SErU0YRfb0bgBbxgzCmWIeTWgJtIdfo/qy+DPwiNqEybbt88F4KuW3Vg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1PJbMi_1709108468;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1PJbMi_1709108468)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 16:21:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: introduce atomic operations
Date: Wed, 28 Feb 2024 16:21:07 +0800
Message-Id: <20240228082107.1014131-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Add some helpers (relaxed semantics) in order to prepare for the
upcoming multi-threaded support.

For example, compressor may be initialized more than once in different
worker threads, resulting in noisy warnings.

This patch makes sure that each message will be printed only once by
adding `__warnonce` atomic booleans to each erofs_compressor_init().

Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/atomic.h      | 27 +++++++++++++++++++++++++++
 lib/compressor_deflate.c    | 11 ++++++++---
 lib/compressor_libdeflate.c |  6 +++++-
 lib/compressor_liblzma.c    |  5 ++++-
 4 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 include/erofs/atomic.h

diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
new file mode 100644
index 0000000..c486491
--- /dev/null
+++ b/include/erofs/atomic.h
@@ -0,0 +1,27 @@
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
index 8629415..60bb2f6 100644
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
+	static erofs_atomic_t __warnonce;
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
index 62d93f7..f90d720 100644
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
+	static erofs_atomic_t __warnonce;
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
index 712f44f..e79717d 100644
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
+	static erofs_atomic_t __warnonce;
 
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
2.39.3

