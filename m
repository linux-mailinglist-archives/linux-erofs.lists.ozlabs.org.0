Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC57AB92C
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Sep 2023 20:31:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rsgnz1Pz1z3cLQ
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Sep 2023 04:31:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rsgnt4sDYz3c54
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Sep 2023 04:31:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VseCbmd_1695407456;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VseCbmd_1695407456)
          by smtp.aliyun-inc.com;
          Sat, 23 Sep 2023 02:31:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: lib: use xxh64() for faster filtering first for dedupe
Date: Sat, 23 Sep 2023 02:30:53 +0800
Message-Id: <20230922183055.1583756-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Let's check if xxh64 equals when rolling back on global compressed
deduplication.

As a result, it could decrease time by 26.4% (6m57.990s -> 5m7.755s)
on a dataset with "-Ededupe -C8192".

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h   |  5 +++
 include/erofs/xxhash.h | 27 -------------
 lib/Makefile.am        |  4 +-
 lib/dedupe.c           |  9 +++++
 lib/xattr.c            |  2 +-
 lib/xxhash.c           | 92 +++++++++++++++++++++++++++++++++++++++++-
 lib/xxhash.h           | 40 ++++++++++++++++++
 7 files changed, 147 insertions(+), 32 deletions(-)
 delete mode 100644 include/erofs/xxhash.h
 create mode 100644 lib/xxhash.h

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index fefa7e7..e7384a1 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -204,6 +204,11 @@ static inline void put_unaligned_le32(u32 val, void *p)
 	__put_unaligned_t(__le32, cpu_to_le32(val), p);
 }
 
+static inline u32 get_unaligned_le64(const void *p)
+{
+	return le64_to_cpu(__get_unaligned_t(__le64, p));
+}
+
 /**
  * ilog2 - log of base 2 of 32-bit or a 64-bit unsigned value
  * @n - parameter
diff --git a/include/erofs/xxhash.h b/include/erofs/xxhash.h
deleted file mode 100644
index 5441209..0000000
--- a/include/erofs/xxhash.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ */
-#ifndef __EROFS_XXHASH_H
-#define __EROFS_XXHASH_H
-
-#ifdef __cplusplus
-extern "C"
-{
-#endif
-
-#include <stdint.h>
-
-/**
- * xxh32() - calculate the 32-bit hash of the input with a given seed.
- *
- * @input:  The data to hash.
- * @length: The length of the data to hash.
- * @seed:   The seed can be used to alter the result predictably.
- *
- * Return:  The 32-bit hash of the data.
- */
-uint32_t xxh32(const void *input, size_t length, uint32_t seed);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 483d410..470e095 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -25,9 +25,9 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
       $(top_srcdir)/include/erofs/fragments.h \
-      $(top_srcdir)/include/erofs/xxhash.h \
       $(top_srcdir)/include/erofs/rebuild.h \
-      $(top_srcdir)/lib/liberofs_private.h
+      $(top_srcdir)/lib/liberofs_private.h \
+      $(top_srcdir)/lib/xxhash.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
diff --git a/lib/dedupe.c b/lib/dedupe.c
index 17da452..2f86f8d 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -6,6 +6,7 @@
 #include "erofs/print.h"
 #include "rb_tree.h"
 #include "rolling_hash.h"
+#include "xxhash.h"
 #include "sha256.h"
 
 unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
@@ -66,6 +67,7 @@ static struct rb_tree *dedupe_tree, *dedupe_subtree;
 struct z_erofs_dedupe_item {
 	long long	hash;
 	u8		prefix_sha256[32];
+	u64		prefix_xxh64;
 
 	erofs_blk_t	compressed_blkaddr;
 	unsigned int	compressed_blks;
@@ -102,6 +104,7 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 	for (; cur >= ctx->start; --cur) {
 		struct z_erofs_dedupe_item *e;
 		unsigned int extra;
+		u64 xxh64_csum;
 		u8 sha256[32];
 
 		if (initial) {
@@ -120,6 +123,10 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 				continue;
 		}
 
+		xxh64_csum = xxh64(cur, window_size, 0);
+		if (e->prefix_xxh64 != xxh64_csum)
+			continue;
+
 		erofs_sha256(cur, window_size, sha256);
 		if (memcmp(sha256, e->prefix_sha256, sizeof(sha256)))
 			continue;
@@ -155,6 +162,8 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 
 	di->original_length = e->length;
 	erofs_sha256(original_data, window_size, di->prefix_sha256);
+
+	di->prefix_xxh64 = xxh64(original_data, window_size, 0);
 	di->hash = erofs_rolling_hash_init(original_data,
 			window_size, true);
 	memcpy(di->extra_data, original_data + window_size,
diff --git a/lib/xattr.c b/lib/xattr.c
index 6c8ebf4..77c8c3a 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -18,7 +18,7 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include "erofs/fragments.h"
-#include "erofs/xxhash.h"
+#include "xxhash.h"
 #include "liberofs_private.h"
 
 #ifndef XATTR_SYSTEM_PREFIX
diff --git a/lib/xxhash.c b/lib/xxhash.c
index 7289c77..2768375 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -43,14 +43,14 @@
  * - xxHash homepage: https://cyan4973.github.io/xxHash/
  * - xxHash source repository: https://github.com/Cyan4973/xxHash
  */
-
 #include "erofs/defs.h"
-#include "erofs/xxhash.h"
+#include "xxhash.h"
 
 /*-*************************************
  * Macros
  **************************************/
 #define xxh_rotl32(x, r) ((x << r) | (x >> (32 - r)))
+#define xxh_rotl64(x, r) ((x << r) | (x >> (64 - r)))
 
 /*-*************************************
  * Constants
@@ -61,6 +61,12 @@ static const uint32_t PRIME32_3 = 3266489917U;
 static const uint32_t PRIME32_4 =  668265263U;
 static const uint32_t PRIME32_5 =  374761393U;
 
+static const uint64_t PRIME64_1 = 11400714785074694791ULL;
+static const uint64_t PRIME64_2 = 14029467366897019727ULL;
+static const uint64_t PRIME64_3 =  1609587929392839161ULL;
+static const uint64_t PRIME64_4 =  9650029242287828579ULL;
+static const uint64_t PRIME64_5 =  2870177450012600261ULL;
+
 /*-***************************
  * Simple Hash Functions
  ****************************/
@@ -124,3 +130,85 @@ uint32_t xxh32(const void *input, const size_t len, const uint32_t seed)
 
 	return h32;
 }
+
+static uint64_t xxh64_round(uint64_t acc, const uint64_t input)
+{
+	acc += input * PRIME64_2;
+	acc = xxh_rotl64(acc, 31);
+	acc *= PRIME64_1;
+	return acc;
+}
+
+static uint64_t xxh64_merge_round(uint64_t acc, uint64_t val)
+{
+	val = xxh64_round(0, val);
+	acc ^= val;
+	acc = acc * PRIME64_1 + PRIME64_4;
+	return acc;
+}
+
+uint64_t xxh64(const void *input, const size_t len, const uint64_t seed)
+{
+	const uint8_t *p = (const uint8_t *)input;
+	const uint8_t *const b_end = p + len;
+	uint64_t h64;
+
+	if (len >= 32) {
+		const uint8_t *const limit = b_end - 32;
+		uint64_t v1 = seed + PRIME64_1 + PRIME64_2;
+		uint64_t v2 = seed + PRIME64_2;
+		uint64_t v3 = seed + 0;
+		uint64_t v4 = seed - PRIME64_1;
+
+		do {
+			v1 = xxh64_round(v1, get_unaligned_le64(p));
+			p += 8;
+			v2 = xxh64_round(v2, get_unaligned_le64(p));
+			p += 8;
+			v3 = xxh64_round(v3, get_unaligned_le64(p));
+			p += 8;
+			v4 = xxh64_round(v4, get_unaligned_le64(p));
+			p += 8;
+		} while (p <= limit);
+
+		h64 = xxh_rotl64(v1, 1) + xxh_rotl64(v2, 7) +
+			xxh_rotl64(v3, 12) + xxh_rotl64(v4, 18);
+		h64 = xxh64_merge_round(h64, v1);
+		h64 = xxh64_merge_round(h64, v2);
+		h64 = xxh64_merge_round(h64, v3);
+		h64 = xxh64_merge_round(h64, v4);
+
+	} else {
+		h64  = seed + PRIME64_5;
+	}
+
+	h64 += (uint64_t)len;
+
+	while (p + 8 <= b_end) {
+		const uint64_t k1 = xxh64_round(0, get_unaligned_le64(p));
+
+		h64 ^= k1;
+		h64 = xxh_rotl64(h64, 27) * PRIME64_1 + PRIME64_4;
+		p += 8;
+	}
+
+	if (p + 4 <= b_end) {
+		h64 ^= (uint64_t)(get_unaligned_le32(p)) * PRIME64_1;
+		h64 = xxh_rotl64(h64, 23) * PRIME64_2 + PRIME64_3;
+		p += 4;
+	}
+
+	while (p < b_end) {
+		h64 ^= (*p) * PRIME64_5;
+		h64 = xxh_rotl64(h64, 11) * PRIME64_1;
+		p++;
+	}
+
+	h64 ^= h64 >> 33;
+	h64 *= PRIME64_2;
+	h64 ^= h64 >> 29;
+	h64 *= PRIME64_3;
+	h64 ^= h64 >> 32;
+
+	return h64;
+}
diff --git a/lib/xxhash.h b/lib/xxhash.h
new file mode 100644
index 0000000..723c3a5
--- /dev/null
+++ b/lib/xxhash.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ */
+#ifndef __EROFS_LIB_XXHASH_H
+#define __EROFS_LIB_XXHASH_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include <stdint.h>
+
+/*
+ * xxh32() - calculate the 32-bit hash of the input with a given seed.
+ *
+ * @input:  The data to hash.
+ * @length: The length of the data to hash.
+ * @seed:   The seed can be used to alter the result predictably.
+ *
+ * Return:  The 32-bit hash of the data.
+ */
+uint32_t xxh32(const void *input, size_t length, uint32_t seed);
+
+/*
+ * xxh64() - calculate the 64-bit hash of the input with a given seed.
+ *
+ * @input:  The data to hash.
+ * @length: The length of the data to hash.
+ * @seed:   The seed can be used to alter the result predictably.
+ *
+ * This function runs 2x faster on 64-bit systems, but slower on 32-bit systems.
+ *
+ * Return:  The 64-bit hash of the data.
+ */
+uint64_t xxh64(const void *input, const size_t len, const uint64_t seed);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.39.3

