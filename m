Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24152A10202
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 09:28:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXMhr5dHcz30DL
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 19:28:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736843307;
	cv=none; b=Je7VfyCFXY0t6di4L/j0pul96Fq9WwjLf9CfMYk/sPPd7ETdsldWna0d9S2vxFmwsm/G8UMwjj4b+EFfCYU5kgHFAb06pizKwy0B3VcPQ78zZeLe6HQ1yfoEXQJhqe7pTFUVtGQtQ08Vn9lMbW4LG2gQ2OTPWL2hpunCFVk0f1NeUEGu3AAhzodDvCksQYvO1X7Sx0Mxh/r3N+YFGbjCSG0eNr0MhBVd/d9QpFkOqjZD32I7mys65W4tv613HwZHZRaR6UL6+7VtobnEGgx22VSCEfdrv7pNmGIIHhAUw2QSZs/LEkpwB8UMqgzu3Zyf+UCIRsxslB/m10aSsnO3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736843307; c=relaxed/relaxed;
	bh=7XPgDDQ1CgGDc3sN4zJ8GISJcatuj4inkfzaFVSgP5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0qAZi8dCkW8qgXTVedeMbGvrLw5+2pvQVCjHumWvF3D12kHbFA5X+dF04R38HDJecE7nDBN9Gz1I/+iuu5w/jZxA+AGrq2Sm1eb2yUPldG9gBzQ6KcqqD/Rp0U4RvBXviBVr/x7Xtn/efuCdk4sX3SiOKS6AO3DZbwCcfGLd0iO9S7vmVQfqS4+u1Uv+JNDx6iWez3FgpOeD56l9MvsARXEkq43LL89wRbqZUSIR5S9IjNlzWdHg97L0v4Ropx7rYX5PmwjpltjnwRHlMOnIEXFathlw0zMNQgTlk8oKbKtlrNg9NVM5ov009CFYmyOSFigppxzpxlyM6nhvRu1Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E6uSnL0b; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E6uSnL0b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXMhm4fd6z301n
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jan 2025 19:28:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736843297; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7XPgDDQ1CgGDc3sN4zJ8GISJcatuj4inkfzaFVSgP5s=;
	b=E6uSnL0bDHi+0eG81foCLsiEF2pTMoreuLE9M4S8UPBIYYyc84mybdZk5WrPBeYWCoer7tMg1V64Zs9jmTkGgI+7NlhO9sNNj7ZaqBYX1eS39pwiTsI3J07EUeAqpwzRR0T4VjWi7u41hP1U6lbZX4i0Bze2Ec6y4NAI0X9MU1A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNehOg-_1736843288 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 16:28:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] include/linux/lz4.h: add some missing macros
Date: Tue, 14 Jan 2025 16:28:07 +0800
Message-ID: <20250114082807.827690-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Yann Collet <yann.collet.73@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Nick Terrell <terrelln@fb.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, LZ4_DISTANCE_MAX and LZ4_DECOMPRESS_INPLACE_MARGIN are
defined in the erofs subsystem for LZ4 in-place decompression, which is
somewhat unsuitable since they should belong to the LZ4 itself and
may change with future LZ4 codebase updates.

Move them to include/linux/lz4.h to match the upstream LZ4 library [1].
No logic changes.

[1] https://github.com/lz4/lz4/blob/v1.10.0/lib/lz4.h#L670

Cc: Yann Collet <yann.collet.73@gmail.com>
Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi,

It doesn't change any logic, but it'd be helpful to be moved for
the next 6.14 cycle if it looks good.

I keep the internal "MAX_DISTANCE" as-is since no need to touch
the real implementation for now.

 fs/erofs/decompressor.c  | 7 -------
 include/linux/lz4.h      | 6 ++++++
 lib/lz4/lz4_compress.c   | 1 -
 lib/lz4/lz4_decompress.c | 1 -
 lib/lz4/lz4defs.h        | 4 ++--
 lib/lz4/lz4hc_compress.c | 1 -
 6 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index eb318c7ddd80..2b123b070a42 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -7,14 +7,7 @@
 #include "compress.h"
 #include <linux/lz4.h>
 
-#ifndef LZ4_DISTANCE_MAX	/* history window size */
-#define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
-#endif
-
 #define LZ4_MAX_DISTANCE_PAGES	(DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
-#ifndef LZ4_DECOMPRESS_INPLACE_MARGIN
-#define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
-#endif
 
 struct z_erofs_lz4_decompress_ctx {
 	struct z_erofs_decompress_req *rq;
diff --git a/include/linux/lz4.h b/include/linux/lz4.h
index b16e15b9587a..ad6042a718b5 100644
--- a/include/linux/lz4.h
+++ b/include/linux/lz4.h
@@ -645,4 +645,10 @@ int LZ4_decompress_safe_usingDict(const char *source, char *dest,
 int LZ4_decompress_fast_usingDict(const char *source, char *dest,
 	int originalSize, const char *dictStart, int dictSize);
 
+#define LZ4_DECOMPRESS_INPLACE_MARGIN(compressedSize)          (((compressedSize) >> 8) + 32)
+
+#ifndef LZ4_DISTANCE_MAX	/* history window size; can be user-defined at compile time */
+#define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
+#endif
+
 #endif
diff --git a/lib/lz4/lz4_compress.c b/lib/lz4/lz4_compress.c
index b0bbeeb74b9e..2a397bb2c661 100644
--- a/lib/lz4/lz4_compress.c
+++ b/lib/lz4/lz4_compress.c
@@ -33,7 +33,6 @@
 /*-************************************
  *	Dependencies
  **************************************/
-#include <linux/lz4.h>
 #include "lz4defs.h"
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 0e31e6da5ce7..3a2cd9acada4 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -33,7 +33,6 @@
 /*-************************************
  *	Dependencies
  **************************************/
-#include <linux/lz4.h>
 #include "lz4defs.h"
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
index cb358d6bde5a..76d187d225cd 100644
--- a/lib/lz4/lz4defs.h
+++ b/lib/lz4/lz4defs.h
@@ -39,6 +39,7 @@
 
 #include <linux/bitops.h>
 #include <linux/string.h>	 /* memset, memcpy */
+#include <linux/lz4.h>
 
 #define FORCE_INLINE __always_inline
 
@@ -92,8 +93,7 @@ typedef uintptr_t uptrval;
 #define MB (1 << 20)
 #define GB (1U << 30)
 
-#define MAXD_LOG 16
-#define MAX_DISTANCE ((1 << MAXD_LOG) - 1)
+#define MAX_DISTANCE LZ4_MAX_DISTANCE
 #define STEPSIZE sizeof(size_t)
 
 #define ML_BITS	4
diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index bc45594ad2a8..91936dc3d14b 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -34,7 +34,6 @@
 /*-************************************
  *	Dependencies
  **************************************/
-#include <linux/lz4.h>
 #include "lz4defs.h"
 #include <linux/module.h>
 #include <linux/kernel.h>
-- 
2.43.5

