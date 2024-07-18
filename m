Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 682FD9347A8
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 07:40:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SWjrOAPz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPhVJ27Dkz3ck9
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 15:40:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SWjrOAPz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPhVC6fDvz3cT7
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 15:40:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721281230; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=y53hvfHg6yLScjONxBZV3eu3mXYYw5N0nnCJkMfmY4I=;
	b=SWjrOAPzIRj6mwBfVUjrRfK50fITgvBOWY3vy/Xd/kM0eNn+ng/BBAgPIlHKbQNENAUkSZPaqce/oAHaCvnUmkBUrV92GWGmF3pITpK00WySbNyAox7/+fPTDG8a46cQMDBhl1uck+pkfXC/izMu4t9+a1f+T3r97szGW5/XzU0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAn8f1b_1721281229;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WAn8f1b_1721281229)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 13:40:29 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: lib: add bloom filter
Date: Thu, 18 Jul 2024 13:40:24 +0800
Message-ID: <20240718054025.427439-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240718054025.427439-1-hongzhen@linux.alibaba.com>
References: <20240718054025.427439-1-hongzhen@linux.alibaba.com>
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

Introduce following bloom filter helpers:

	erofs_bloom_init
	erofs_bloom_add
	erofs_bloom_test
	erofs_bloom_exit

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/bloom_filter.h | 30 ++++++++++++
 include/erofs/internal.h     |  2 +
 lib/Makefile.am              |  2 +-
 lib/bloom_filter.c           | 92 ++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/bloom_filter.h
 create mode 100644 lib/bloom_filter.c

diff --git a/include/erofs/bloom_filter.h b/include/erofs/bloom_filter.h
new file mode 100644
index 0000000..a0915e4
--- /dev/null
+++ b/include/erofs/bloom_filter.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_BLOOM_FILTER_H
+#define __EROFS_BLOOM_FILTER_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "internal.h"
+#include "bitops.h"
+
+struct erofs_bloom_filter {
+        struct bitmap bmap;
+        unsigned long bitmap_mask;
+        u32 hash_seed;
+        u32 nr_funcs;
+};
+
+int erofs_bloom_init(struct erofs_sb_info *sbi, u32 nr_funcs,
+                     unsigned long entries, u32 seed);
+long erofs_bloom_add(struct erofs_sb_info *sbi, void *data, size_t length);
+long erofs_bloom_test(struct erofs_sb_info *sbi, void *data, size_t length);
+void erofs_bloom_exit(struct erofs_sb_info *sbi);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
\ No newline at end of file
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 708e51e..d3dd676 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -74,6 +74,7 @@ struct erofs_xattr_prefix_item {
 #define EROFS_PACKED_NID_UNALLOCATED	-1
 
 struct erofs_mkfs_dfops;
+struct erofs_bloom_filter;
 struct erofs_sb_info {
 	struct erofs_device_info *devs;
 	char *devname;
@@ -134,6 +135,7 @@ struct erofs_sb_info {
 #endif
 	struct erofs_bufmgr *bmgr;
 	bool useqpl;
+	struct erofs_bloom_filter *bf;
 };
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 6b52470..78140e7 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -35,7 +35,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c xxhash.c rebuild.c diskbuf.c
+		      block_list.c xxhash.c rebuild.c diskbuf.c bloom_filter.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/bloom_filter.c b/lib/bloom_filter.c
new file mode 100644
index 0000000..c460261
--- /dev/null
+++ b/lib/bloom_filter.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/bloom_filter.h"
+#include "xxhash.h"
+#include <stdlib.h>
+
+static u32 erofs_bloom_hash(struct erofs_bloom_filter *bf, void *data,
+                            size_t length, u32 index)
+{
+        u32 h;
+
+        h = xxh32(data, length, bf->hash_seed + index);
+        return h & bf->bitmap_mask;
+}
+
+/* The optimal bit array size that minimizes the false positive is
+ * m * k / ln(2) where m is the # of elements inserted into the bloom
+ * filter and k is the # of hash functions. Here, 1.44 is used to approximate
+ * 1 / ln(2).
+ */
+int erofs_bloom_init(struct erofs_sb_info *sbi, u32 nr_funcs,
+                     unsigned long entries, u32 seed)
+{
+        struct erofs_bloom_filter *bf;
+
+        bf = calloc(1, sizeof(struct erofs_bloom_filter));
+        if (!bf)
+                return -EINVAL;
+
+        bf->nr_funcs = nr_funcs;
+        bf->hash_seed = seed;
+        bf->bmap.size = roundup_pow_of_two(((long)(entries * nr_funcs * 1.44)));
+        bf->bitmap_mask = bf->bmap.size - 1;
+        bf->bmap.map = calloc(BITS_TO_LONGS(bf->bmap.size), sizeof(long));
+        if (!bf->bmap.map) {
+                free(bf);
+                return -ENOMEM;
+        }
+        sbi->bf = bf;
+
+        return 0;
+}
+
+long erofs_bloom_add(struct erofs_sb_info *sbi, void *data, size_t length)
+{
+        u32 i, h;
+        struct erofs_bloom_filter *bf;
+
+        bf = sbi->bf;
+        if (!bf)
+                return -EINVAL;
+
+        for (i = 0; i < bf->nr_funcs; i ++) {
+                h = erofs_bloom_hash(bf, data, length, i);
+                set_bit(h, bf->bmap.map);
+        }
+
+        return 0;
+}
+
+/*
+ * Return negative error code on failure, 0 if the key is not in the bloom filter
+ * and 1 if the key might be in the bloom filter.
+ */
+long erofs_bloom_test(struct erofs_sb_info *sbi, void *data, size_t length)
+{
+        u32 i, h;
+        struct erofs_bloom_filter *bf;
+
+        bf = sbi->bf;
+        if (!bf)
+                return -EINVAL;
+
+        for (i = 0; i < bf->nr_funcs; i ++) {
+                h = erofs_bloom_hash(bf, data, length, i);
+                if (!test_bit(h, bf->bmap.map))
+                        return 0;
+        }
+
+        return 1;
+}
+
+void erofs_bloom_exit(struct erofs_sb_info *sbi)
+{
+        if (sbi->bf) {
+                if (sbi->bf->bmap.map) {
+                        free(sbi->bf->bmap.map);
+                        sbi->bf->bmap.map = NULL;
+                }
+                free(sbi->bf);
+                sbi->bf = NULL;
+        }
+}
\ No newline at end of file
-- 
2.43.5

