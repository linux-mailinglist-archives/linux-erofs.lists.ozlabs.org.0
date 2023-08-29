Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EE08178C815
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 16:55:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZr7n6JvVz3bTj
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 00:55:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZr7j492qz2ytr
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 00:55:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqrmBwb_1693320905;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqrmBwb_1693320905)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 22:55:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 1/3] erofs-utils: add xxh32 library
Date: Tue, 29 Aug 2023 22:55:02 +0800
Message-Id: <20230829145504.93567-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230829145504.93567-1-jefflexu@linux.alibaba.com>
References: <20230829145504.93567-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add xxh32 library which could be used by following xattr bloom filter
feature.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/xxhash.h |  27 +++++++++
 lib/Makefile.am        |   3 +-
 lib/xxhash.c           | 126 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/xxhash.h
 create mode 100644 lib/xxhash.c

diff --git a/include/erofs/xxhash.h b/include/erofs/xxhash.h
new file mode 100644
index 0000000..28dc360
--- /dev/null
+++ b/include/erofs/xxhash.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-only */
+#ifndef __EROFS_XXHASH_H
+#define __EROFS_XXHASH_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include <stdint.h>
+
+/**
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
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 7a5dc03..3e09516 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -24,6 +24,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
       $(top_srcdir)/include/erofs/fragments.h \
+      $(top_srcdir)/include/erofs/xxhash.h \
       $(top_srcdir)/lib/liberofs_private.h
 
 noinst_HEADERS += compressor.h
@@ -31,7 +32,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c
+		      block_list.c xxhash.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/xxhash.c b/lib/xxhash.c
new file mode 100644
index 0000000..7289c77
--- /dev/null
+++ b/lib/xxhash.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-only
+/*
+ * The xxhash is copied from the linux kernel at:
+ *	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xxhash.c
+ *
+ * The original copyright is:
+ *
+ * xxHash - Extremely Fast Hash algorithm
+ * Copyright (C) 2012-2016, Yann Collet.
+ *
+ * BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above
+ *     copyright notice, this list of conditions and the following disclaimer
+ *     in the documentation and/or other materials provided with the
+ *     distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation. This program is dual-licensed; you may select
+ * either version 2 of the GNU General Public License ("GPL") or BSD license
+ * ("BSD").
+ *
+ * You can contact the author at:
+ * - xxHash homepage: https://cyan4973.github.io/xxHash/
+ * - xxHash source repository: https://github.com/Cyan4973/xxHash
+ */
+
+#include "erofs/defs.h"
+#include "erofs/xxhash.h"
+
+/*-*************************************
+ * Macros
+ **************************************/
+#define xxh_rotl32(x, r) ((x << r) | (x >> (32 - r)))
+
+/*-*************************************
+ * Constants
+ **************************************/
+static const uint32_t PRIME32_1 = 2654435761U;
+static const uint32_t PRIME32_2 = 2246822519U;
+static const uint32_t PRIME32_3 = 3266489917U;
+static const uint32_t PRIME32_4 =  668265263U;
+static const uint32_t PRIME32_5 =  374761393U;
+
+/*-***************************
+ * Simple Hash Functions
+ ****************************/
+static uint32_t xxh32_round(uint32_t seed, const uint32_t input)
+{
+	seed += input * PRIME32_2;
+	seed = xxh_rotl32(seed, 13);
+	seed *= PRIME32_1;
+	return seed;
+}
+
+uint32_t xxh32(const void *input, const size_t len, const uint32_t seed)
+{
+	const uint8_t *p = (const uint8_t *)input;
+	const uint8_t *b_end = p + len;
+	uint32_t h32;
+
+	if (len >= 16) {
+		const uint8_t *const limit = b_end - 16;
+		uint32_t v1 = seed + PRIME32_1 + PRIME32_2;
+		uint32_t v2 = seed + PRIME32_2;
+		uint32_t v3 = seed + 0;
+		uint32_t v4 = seed - PRIME32_1;
+
+		do {
+			v1 = xxh32_round(v1, get_unaligned_le32(p));
+			p += 4;
+			v2 = xxh32_round(v2, get_unaligned_le32(p));
+			p += 4;
+			v3 = xxh32_round(v3, get_unaligned_le32(p));
+			p += 4;
+			v4 = xxh32_round(v4, get_unaligned_le32(p));
+			p += 4;
+		} while (p <= limit);
+
+		h32 = xxh_rotl32(v1, 1) + xxh_rotl32(v2, 7) +
+			xxh_rotl32(v3, 12) + xxh_rotl32(v4, 18);
+	} else {
+		h32 = seed + PRIME32_5;
+	}
+
+	h32 += (uint32_t)len;
+
+	while (p + 4 <= b_end) {
+		h32 += get_unaligned_le32(p) * PRIME32_3;
+		h32 = xxh_rotl32(h32, 17) * PRIME32_4;
+		p += 4;
+	}
+
+	while (p < b_end) {
+		h32 += (*p) * PRIME32_5;
+		h32 = xxh_rotl32(h32, 11) * PRIME32_1;
+		p++;
+	}
+
+	h32 ^= h32 >> 15;
+	h32 *= PRIME32_2;
+	h32 ^= h32 >> 13;
+	h32 *= PRIME32_3;
+	h32 ^= h32 >> 16;
+
+	return h32;
+}
-- 
2.19.1.6.gb485710b

