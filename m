Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A7A10756
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 14:05:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXTrF2BYSz30RG
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 00:05:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736859915;
	cv=none; b=NxtFLg3c08pycWnNCWfYhPDb+T1nue0GnnyP1z2BQO4Q6YtVH1QRlb0LKOsMYMgxJtzuXf4LjU/3XaD0OVhZTLUEZHZJf3A/8HtOIkOKci11qMVuhG0o+seLnxtY/8WJqAaDPHiWjXOe+WdNn46n2PQaBRtZbhEpf98x16xPoFHlUrzzPZ/RaZ4hawjJdu19Yl1EXSvz9CeydXNu4dlxvuypd9KmPwoAV0wF6rhp3R91/O2kYrfz5gxd5PYDcYAHkACqs5fn01msAtcEEP403jD0elDa0bKW4SVNqh9SlN8bM24LDYhjuq0obCldLMh1YrjTe+zGrTLNgPbA3nEELg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736859915; c=relaxed/relaxed;
	bh=MOQLw24UbhJ0+yCuKw+FR0D5mCkV3IXTCzxyOWOJ5yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibQht0A0rIZdyJMXGpyuEQw8pGTSAru69RV+rs4s+fgW+PsDXaBp2X8gOvAs2nGyRnZQ0PMUlSEAtF/HPtgEmySMFqhNPPjAea+f5b1uhles1K97dtD9t607IKu24hgfWzode8CryXtyvuickbGbcL/I/maxpkxEZfdR/gsWEabhNAJKEUXfCW+Q5rWypmVtPDRNidKhFqz5YzKJG4E6OWtth0uUczT7AA5hNgnH1YzlZTY2PTiNtl5YneEOwdVyzI0vYN7X0DWgmA68wLz31NSarMD17DaB11Ge5c1xwLasv3yADv14p1aZdCpmtAVl+vryebZrANnkbSzlmt9EMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kCBTfTfu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kCBTfTfu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXTr71YfNz30Lt
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 00:05:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736859903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MOQLw24UbhJ0+yCuKw+FR0D5mCkV3IXTCzxyOWOJ5yQ=;
	b=kCBTfTfuG+hJ4qrej1Kzs6UPMUpKWbQZ1I3wPUbKOMNN9p2MsYuljeldp3snC4sag8k9QqZSCmF+N8oJv472CW4T4xJuOEXHllKeVSUt5Cjv4xrWXOnHm3bxt94kkSb6vXWESFUopJHzwQnFIC0F86eHn3rtL6flcPkInxwGdjo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNfNthE_1736859896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 21:05:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] include/linux/lz4.h: add some missing macros
Date: Tue, 14 Jan 2025 21:04:54 +0800
Message-ID: <20250114130454.1191150-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250114082807.827690-1-hsiangkao@linux.alibaba.com>
References: <20250114082807.827690-1-hsiangkao@linux.alibaba.com>
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
change since v1:
 - should be `#define MAX_DISTANCE LZ4_DISTANCE_MAX` reported in
   https://lore.kernel.org/r/202501142005.DqdNQGKc-lkp@intel.com

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
index cb358d6bde5a..17277ec16919 100644
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
+#define MAX_DISTANCE LZ4_DISTANCE_MAX
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

