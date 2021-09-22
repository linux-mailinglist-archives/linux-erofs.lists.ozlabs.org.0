Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7679415045
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 20:57:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF6wV4ffLz2yxT
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 04:56:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF6wG1nFsz2yZt
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 04:56:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UpFo0Io_1632336968; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpFo0Io_1632336968) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 02:56:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 5/5] erofs-utils: mkfs: support chunk-based uncompressed
 files
Date: Thu, 23 Sep 2021 02:56:07 +0800
Message-Id: <20210922185607.49909-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
References: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

mkfs support for the new chunk-based uncompressed files,
including:
 * chunk-based files with 4-byte block address array;
 * chunk-based files with 8-byte inode chunk indexes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/blobchunk.h |  18 ++++
 include/erofs/config.h    |   1 +
 include/erofs/defs.h      |  77 ++++++++++++++
 include/erofs/hashtable.h |  77 --------------
 include/erofs/internal.h  |   1 +
 include/erofs/io.h        |   2 +
 lib/Makefile.am           |   2 +-
 lib/blobchunk.c           | 217 ++++++++++++++++++++++++++++++++++++++
 lib/inode.c               |  36 +++++--
 lib/io.c                  |   2 +-
 man/mkfs.erofs.1          |   3 +
 mkfs/main.c               |  38 +++++++
 12 files changed, 389 insertions(+), 85 deletions(-)
 create mode 100644 include/erofs/blobchunk.h
 create mode 100644 lib/blobchunk.c

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
new file mode 100644
index 000000000000..b418227e0ef8
--- /dev/null
+++ b/include/erofs/blobchunk.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/blobchunk.h
+ *
+ * Copyright (C) 2021, Alibaba Cloud
+ */
+#ifndef __EROFS_BLOBCHUNK_H
+#define __EROFS_BLOBCHUNK_H
+
+#include "erofs/internal.h"
+
+int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
+int erofs_blob_write_chunked_file(struct erofs_inode *inode);
+int erofs_blob_remap(void);
+void erofs_blob_exit(void);
+int erofs_blob_init(void);
+
+#endif
diff --git a/include/erofs/config.h b/include/erofs/config.h
index d5d9b5a751c0..574dd52be12d 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -42,6 +42,7 @@ struct erofs_configure {
 	bool c_random_pclusterblks;
 #endif
 	char c_timeinherit;
+	char c_chunkbits;
 	bool c_noinline_data;
 
 #ifdef HAVE_LIBSELINUX
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 6e0a7774871c..96bbb6574ff3 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -175,6 +175,83 @@ static inline u32 get_unaligned_le32(const u8 *p)
 	return p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24;
 }
 
+/**
+ * ilog2 - log of base 2 of 32-bit or a 64-bit unsigned value
+ * @n - parameter
+ *
+ * constant-capable log of base 2 calculation
+ * - this can be used to initialise global variables from constant data, hence
+ *   the massive ternary operator construction
+ *
+ * selects the appropriately-sized optimised version depending on sizeof(n)
+ */
+#define ilog2(n)			\
+(					\
+	(n) & (1ULL << 63) ? 63 :	\
+	(n) & (1ULL << 62) ? 62 :	\
+	(n) & (1ULL << 61) ? 61 :	\
+	(n) & (1ULL << 60) ? 60 :	\
+	(n) & (1ULL << 59) ? 59 :	\
+	(n) & (1ULL << 58) ? 58 :	\
+	(n) & (1ULL << 57) ? 57 :	\
+	(n) & (1ULL << 56) ? 56 :	\
+	(n) & (1ULL << 55) ? 55 :	\
+	(n) & (1ULL << 54) ? 54 :	\
+	(n) & (1ULL << 53) ? 53 :	\
+	(n) & (1ULL << 52) ? 52 :	\
+	(n) & (1ULL << 51) ? 51 :	\
+	(n) & (1ULL << 50) ? 50 :	\
+	(n) & (1ULL << 49) ? 49 :	\
+	(n) & (1ULL << 48) ? 48 :	\
+	(n) & (1ULL << 47) ? 47 :	\
+	(n) & (1ULL << 46) ? 46 :	\
+	(n) & (1ULL << 45) ? 45 :	\
+	(n) & (1ULL << 44) ? 44 :	\
+	(n) & (1ULL << 43) ? 43 :	\
+	(n) & (1ULL << 42) ? 42 :	\
+	(n) & (1ULL << 41) ? 41 :	\
+	(n) & (1ULL << 40) ? 40 :	\
+	(n) & (1ULL << 39) ? 39 :	\
+	(n) & (1ULL << 38) ? 38 :	\
+	(n) & (1ULL << 37) ? 37 :	\
+	(n) & (1ULL << 36) ? 36 :	\
+	(n) & (1ULL << 35) ? 35 :	\
+	(n) & (1ULL << 34) ? 34 :	\
+	(n) & (1ULL << 33) ? 33 :	\
+	(n) & (1ULL << 32) ? 32 :	\
+	(n) & (1ULL << 31) ? 31 :	\
+	(n) & (1ULL << 30) ? 30 :	\
+	(n) & (1ULL << 29) ? 29 :	\
+	(n) & (1ULL << 28) ? 28 :	\
+	(n) & (1ULL << 27) ? 27 :	\
+	(n) & (1ULL << 26) ? 26 :	\
+	(n) & (1ULL << 25) ? 25 :	\
+	(n) & (1ULL << 24) ? 24 :	\
+	(n) & (1ULL << 23) ? 23 :	\
+	(n) & (1ULL << 22) ? 22 :	\
+	(n) & (1ULL << 21) ? 21 :	\
+	(n) & (1ULL << 20) ? 20 :	\
+	(n) & (1ULL << 19) ? 19 :	\
+	(n) & (1ULL << 18) ? 18 :	\
+	(n) & (1ULL << 17) ? 17 :	\
+	(n) & (1ULL << 16) ? 16 :	\
+	(n) & (1ULL << 15) ? 15 :	\
+	(n) & (1ULL << 14) ? 14 :	\
+	(n) & (1ULL << 13) ? 13 :	\
+	(n) & (1ULL << 12) ? 12 :	\
+	(n) & (1ULL << 11) ? 11 :	\
+	(n) & (1ULL << 10) ? 10 :	\
+	(n) & (1ULL <<  9) ?  9 :	\
+	(n) & (1ULL <<  8) ?  8 :	\
+	(n) & (1ULL <<  7) ?  7 :	\
+	(n) & (1ULL <<  6) ?  6 :	\
+	(n) & (1ULL <<  5) ?  5 :	\
+	(n) & (1ULL <<  4) ?  4 :	\
+	(n) & (1ULL <<  3) ?  3 :	\
+	(n) & (1ULL <<  2) ?  2 :	\
+	(n) & (1ULL <<  1) ?  1 : 0	\
+)
+
 #ifndef __always_inline
 #define __always_inline	inline
 #endif
diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
index a71cb0044816..90eb84ee8598 100644
--- a/include/erofs/hashtable.h
+++ b/include/erofs/hashtable.h
@@ -262,83 +262,6 @@ static __always_inline u32 hash_64(u64 val, unsigned int bits)
 #endif
 }
 
-/**
- * ilog2 - log of base 2 of 32-bit or a 64-bit unsigned value
- * @n - parameter
- *
- * constant-capable log of base 2 calculation
- * - this can be used to initialise global variables from constant data, hence
- *   the massive ternary operator construction
- *
- * selects the appropriately-sized optimised version depending on sizeof(n)
- */
-#define ilog2(n)				\
-(								\
-	(n) & (1ULL << 63) ? 63 :	\
-	(n) & (1ULL << 62) ? 62 :	\
-	(n) & (1ULL << 61) ? 61 :	\
-	(n) & (1ULL << 60) ? 60 :	\
-	(n) & (1ULL << 59) ? 59 :	\
-	(n) & (1ULL << 58) ? 58 :	\
-	(n) & (1ULL << 57) ? 57 :	\
-	(n) & (1ULL << 56) ? 56 :	\
-	(n) & (1ULL << 55) ? 55 :	\
-	(n) & (1ULL << 54) ? 54 :	\
-	(n) & (1ULL << 53) ? 53 :	\
-	(n) & (1ULL << 52) ? 52 :	\
-	(n) & (1ULL << 51) ? 51 :	\
-	(n) & (1ULL << 50) ? 50 :	\
-	(n) & (1ULL << 49) ? 49 :	\
-	(n) & (1ULL << 48) ? 48 :	\
-	(n) & (1ULL << 47) ? 47 :	\
-	(n) & (1ULL << 46) ? 46 :	\
-	(n) & (1ULL << 45) ? 45 :	\
-	(n) & (1ULL << 44) ? 44 :	\
-	(n) & (1ULL << 43) ? 43 :	\
-	(n) & (1ULL << 42) ? 42 :	\
-	(n) & (1ULL << 41) ? 41 :	\
-	(n) & (1ULL << 40) ? 40 :	\
-	(n) & (1ULL << 39) ? 39 :	\
-	(n) & (1ULL << 38) ? 38 :	\
-	(n) & (1ULL << 37) ? 37 :	\
-	(n) & (1ULL << 36) ? 36 :	\
-	(n) & (1ULL << 35) ? 35 :	\
-	(n) & (1ULL << 34) ? 34 :	\
-	(n) & (1ULL << 33) ? 33 :	\
-	(n) & (1ULL << 32) ? 32 :	\
-	(n) & (1ULL << 31) ? 31 :	\
-	(n) & (1ULL << 30) ? 30 :	\
-	(n) & (1ULL << 29) ? 29 :	\
-	(n) & (1ULL << 28) ? 28 :	\
-	(n) & (1ULL << 27) ? 27 :	\
-	(n) & (1ULL << 26) ? 26 :	\
-	(n) & (1ULL << 25) ? 25 :	\
-	(n) & (1ULL << 24) ? 24 :	\
-	(n) & (1ULL << 23) ? 23 :	\
-	(n) & (1ULL << 22) ? 22 :	\
-	(n) & (1ULL << 21) ? 21 :	\
-	(n) & (1ULL << 20) ? 20 :	\
-	(n) & (1ULL << 19) ? 19 :	\
-	(n) & (1ULL << 18) ? 18 :	\
-	(n) & (1ULL << 17) ? 17 :	\
-	(n) & (1ULL << 16) ? 16 :	\
-	(n) & (1ULL << 15) ? 15 :	\
-	(n) & (1ULL << 14) ? 14 :	\
-	(n) & (1ULL << 13) ? 13 :	\
-	(n) & (1ULL << 12) ? 12 :	\
-	(n) & (1ULL << 11) ? 11 :	\
-	(n) & (1ULL << 10) ? 10 :	\
-	(n) & (1ULL <<  9) ?  9 :	\
-	(n) & (1ULL <<  8) ?  8 :	\
-	(n) & (1ULL <<  7) ?  7 :	\
-	(n) & (1ULL <<  6) ?  6 :	\
-	(n) & (1ULL <<  5) ?  5 :	\
-	(n) & (1ULL <<  4) ?  4 :	\
-	(n) & (1ULL <<  3) ?  3 :	\
-	(n) & (1ULL <<  2) ?  2 :	\
-	(n) & (1ULL <<  1) ?  1 : 0	\
-)
-
 #define DEFINE_HASHTABLE(name, bits)					\
 	struct hlist_head name[1 << (bits)] =				\
 			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 8621f3426410..8b154edb9f88 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -165,6 +165,7 @@ struct erofs_inode {
 
 	union {
 		void *compressmeta;
+		void *chunkindexes;
 		struct {
 			uint16_t z_advise;
 			uint8_t  z_algorithmtype[2];
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 2597bf48a1c4..2597c5c0eb96 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -25,6 +25,8 @@ int dev_fsync(void);
 int dev_resize(erofs_blk_t nblocks);
 u64 dev_length(void);
 
+extern int erofs_devfd;
+
 int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
                           int fd_out, erofs_off_t *off_out,
                           size_t length);
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 2638a109c29c..b64d90b3e144 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -22,7 +22,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      compress_hints.c hashmap.c sha256.c
+		      compress_hints.c hashmap.c sha256.c blobchunk.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
new file mode 100644
index 000000000000..e05d0cb08252
--- /dev/null
+++ b/lib/blobchunk.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/blobchunk.c
+ *
+ * Copyright (C) 2021, Alibaba Cloud
+ */
+#define _GNU_SOURCE
+#include "erofs/hashmap.h"
+#include "erofs/blobchunk.h"
+#include "erofs/cache.h"
+#include "erofs/io.h"
+#include <unistd.h>
+
+void erofs_sha256(const unsigned char *in, unsigned long in_size,
+		  unsigned char out[32]);
+
+struct erofs_blobchunk {
+	struct hashmap_entry ent;
+	char		sha256[32];
+	unsigned int	chunksize;
+	erofs_blk_t	blkaddr;
+};
+
+static struct hashmap blob_hashmap;
+static FILE *blobfile;
+static erofs_blk_t remapped_base;
+
+static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
+		unsigned int chunksize)
+{
+	static u8 zeroed[EROFS_BLKSIZ];
+	u8 *chunkdata, sha256[32];
+	int ret;
+	unsigned int hash;
+	erofs_off_t blkpos;
+	struct erofs_blobchunk *chunk;
+
+	chunkdata = malloc(chunksize);
+	if (!chunkdata)
+		return ERR_PTR(-ENOMEM);
+
+	ret = read(fd, chunkdata, chunksize);
+	if (ret < chunksize) {
+		chunk = ERR_PTR(-EIO);
+		goto out;
+	}
+	erofs_sha256(chunkdata, chunksize, sha256);
+	hash = memhash(sha256, sizeof(sha256));
+	chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
+	if (chunk) {
+		DBG_BUGON(chunksize != chunk->chunksize);
+		goto out;
+	}
+	chunk = malloc(sizeof(struct erofs_blobchunk));
+	if (!chunk) {
+		chunk = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	chunk->chunksize = chunksize;
+	blkpos = ftell(blobfile);
+	DBG_BUGON(erofs_blkoff(blkpos));
+	chunk->blkaddr = erofs_blknr(blkpos);
+	memcpy(chunk->sha256, sha256, sizeof(sha256));
+	hashmap_entry_init(&chunk->ent, hash);
+	hashmap_add(&blob_hashmap, chunk);
+
+	erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, chunk->blkaddr);
+	ret = fwrite(chunkdata, chunksize, 1, blobfile);
+	if (ret == 1 && erofs_blkoff(chunksize))
+		ret = fwrite(zeroed, EROFS_BLKSIZ - erofs_blkoff(chunksize),
+			     1, blobfile);
+	if (ret < 1) {
+		struct hashmap_entry key;
+
+		hashmap_entry_init(&key, hash);
+		hashmap_remove(&blob_hashmap, &key, sha256);
+		chunk = ERR_PTR(-ENOSPC);
+		goto out;
+	}
+out:
+	free(chunkdata);
+	return chunk;
+}
+
+static int erofs_blob_hashmap_cmp(const void *a, const void *b,
+				  const void *key)
+{
+	const struct erofs_blobchunk *ec1 =
+			container_of((struct hashmap_entry *)a,
+				     struct erofs_blobchunk, ent);
+	const struct erofs_blobchunk *ec2 =
+			container_of((struct hashmap_entry *)b,
+				     struct erofs_blobchunk, ent);
+
+	return memcmp(ec1->sha256, key ? key : ec2->sha256,
+		      sizeof(ec1->sha256));
+}
+
+int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
+				   erofs_off_t off)
+{
+	struct erofs_inode_chunk_index idx = {0};
+	unsigned int dst, src, unit;
+
+	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+		unit = sizeof(struct erofs_inode_chunk_index);
+	else
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
+
+	for (dst = src = 0; dst < inode->extent_isize;
+	     src += sizeof(void *), dst += unit) {
+		struct erofs_blobchunk *chunk;
+
+		chunk = *(void **)(inode->chunkindexes + src);
+
+		idx.blkaddr = chunk->blkaddr + remapped_base;
+		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
+			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
+		else
+			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
+	}
+	off = roundup(off, unit);
+
+	return dev_write(inode->chunkindexes, off, inode->extent_isize);
+}
+
+int erofs_blob_write_chunked_file(struct erofs_inode *inode)
+{
+	unsigned int chunksize = 1 << cfg.c_chunkbits;
+	unsigned int count = DIV_ROUND_UP(inode->i_size, chunksize);
+	struct erofs_inode_chunk_index *idx;
+	erofs_off_t pos, len;
+	unsigned int unit;
+	int fd, ret;
+
+	inode->u.chunkformat |= inode->u.chunkbits - LOG_BLOCK_SIZE;
+
+	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+		unit = sizeof(struct erofs_inode_chunk_index);
+	else
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
+
+	inode->extent_isize = count * unit;
+	idx = malloc(count * max(sizeof(*idx), sizeof(void *)));
+	if (!idx)
+		return -ENOMEM;
+	inode->chunkindexes = idx;
+
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0) {
+		ret = -errno;
+		goto err;
+	}
+
+	for (pos = 0; pos < inode->i_size; pos += len) {
+		struct erofs_blobchunk *chunk;
+
+		len = min_t(u64, inode->i_size - pos, chunksize);
+		chunk = erofs_blob_getchunk(fd, len);
+		if (IS_ERR(chunk)) {
+			ret = PTR_ERR(chunk);
+			close(fd);
+			goto err;
+		}
+		*(void **)idx++ = chunk;
+	}
+	inode->datalayout = EROFS_INODE_CHUNK_BASED;
+	close(fd);
+	return 0;
+err:
+	free(inode->chunkindexes);
+	inode->chunkindexes = NULL;
+	return ret;
+}
+
+int erofs_blob_remap(void)
+{
+	struct erofs_buffer_head *bh;
+	ssize_t length;
+	erofs_off_t pos_in, pos_out;
+	int ret;
+
+	fflush(blobfile);
+	length = ftell(blobfile);
+	bh = erofs_balloc(DATA, length, 0, 0);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	erofs_mapbh(bh->block);
+	pos_out = erofs_btell(bh, false);
+	pos_in = 0;
+	remapped_base = erofs_blknr(pos_out);
+	ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
+				    erofs_devfd, &pos_out, length);
+	bh->op = &erofs_skip_write_bhops;
+	erofs_bdrop(bh, false);
+	return ret < length ? -EIO : 0;
+}
+
+void erofs_blob_exit(void)
+{
+	if (blobfile)
+		fclose(blobfile);
+
+	hashmap_free(&blob_hashmap, 1);
+}
+
+int erofs_blob_init(void)
+{
+	blobfile = tmpfile64();
+	if (!blobfile)
+		return -ENOMEM;
+
+	hashmap_init(&blob_hashmap, erofs_blob_hashmap_cmp, 0);
+	return 0;
+}
diff --git a/lib/inode.c b/lib/inode.c
index 4c40c348aa4b..26ffa4b2bb38 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -24,6 +24,7 @@
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
+#include "erofs/blobchunk.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
@@ -387,6 +388,12 @@ int erofs_write_file(struct erofs_inode *inode)
 		return 0;
 	}
 
+	if (cfg.c_chunkbits) {
+		inode->u.chunkbits = cfg.c_chunkbits;
+		inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
+		return erofs_blob_write_chunked_file(inode);
+	}
+
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
 		ret = erofs_write_compressed_file(inode);
 
@@ -440,6 +447,10 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 			if (is_inode_layout_compression(inode))
 				u.dic.i_u.compressed_blocks =
 					cpu_to_le32(inode->u.i_blocks);
+			else if (inode->datalayout ==
+					EROFS_INODE_CHUNK_BASED)
+				u.dic.i_u.c.format =
+					cpu_to_le16(inode->u.chunkformat);
 			else
 				u.dic.i_u.raw_blkaddr =
 					cpu_to_le32(inode->u.i_blkaddr);
@@ -473,6 +484,10 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 			if (is_inode_layout_compression(inode))
 				u.die.i_u.compressed_blocks =
 					cpu_to_le32(inode->u.i_blocks);
+			else if (inode->datalayout ==
+					EROFS_INODE_CHUNK_BASED)
+				u.die.i_u.c.format =
+					cpu_to_le16(inode->u.chunkformat);
 			else
 				u.die.i_u.raw_blkaddr =
 					cpu_to_le32(inode->u.i_blkaddr);
@@ -505,12 +520,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 	}
 
 	if (inode->extent_isize) {
-		/* write compression metadata */
-		off = Z_EROFS_VLE_EXTENT_ALIGN(off);
-		ret = dev_write(inode->compressmeta, off, inode->extent_isize);
-		if (ret)
-			return false;
-		free(inode->compressmeta);
+		if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
+			ret = erofs_blob_write_chunk_indexes(inode, off);
+			if (ret)
+				return false;
+		} else {
+			/* write compression metadata */
+			off = Z_EROFS_VLE_EXTENT_ALIGN(off);
+			ret = dev_write(inode->compressmeta, off,
+					inode->extent_isize);
+			if (ret)
+				return false;
+			free(inode->compressmeta);
+		}
 	}
 
 	inode->bh = NULL;
@@ -565,6 +587,8 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	if (is_inode_layout_compression(inode))
 		goto noinline;
+	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
+		goto noinline;
 
 	if (cfg.c_noinline_data && S_ISREG(inode->i_mode)) {
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
diff --git a/lib/io.c b/lib/io.c
index 504a69e4bdc1..03c7e3355089 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -24,7 +24,7 @@
 #include "erofs/print.h"
 
 static const char *erofs_devname;
-static int erofs_devfd = -1;
+int erofs_devfd = -1;
 static u64 erofs_devsz;
 
 int dev_get_blkdev_size(int fd, u64 *bytes)
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 1446cb56db30..3c250c118168 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -83,6 +83,9 @@ Set all file gids to \fIGID\fR.
 .B \-\-all-root
 Make all files owned by root.
 .TP
+.BI "\-\-chunksize " #
+Generate chunk-based files with #-byte chunks.
+.TP
 .B \-\-help
 Display this help and exit.
 .TP
diff --git a/mkfs/main.c b/mkfs/main.c
index addefcefea38..b61205dac91a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -22,6 +22,7 @@
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
+#include "erofs/blobchunk.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -44,6 +45,7 @@ static struct option long_options[] = {
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
 	{"compress-hints", required_argument, NULL, 10},
+	{"chunksize", required_argument, NULL, 11},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -79,6 +81,7 @@ static void usage(void)
 #ifdef HAVE_LIBUUID
 	      " -UX                   use a given filesystem UUID\n"
 #endif
+	      " --chunksize=X         generate chunk-based files with X-byte chunks\n"
 	      " --exclude-path=X      avoid including file X (X = exact literal path)\n"
 	      " --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
@@ -321,6 +324,26 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_pclusterblks_max = i / EROFS_BLKSIZ;
 			cfg.c_pclusterblks_def = cfg.c_pclusterblks_max;
 			break;
+		case 11:
+			i = strtol(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid chunksize %s", optarg);
+				return -EINVAL;
+			}
+			cfg.c_chunkbits = ilog2(i);
+			if ((1 << cfg.c_chunkbits) != i) {
+				erofs_err("chunksize %s must be a power of two",
+					  optarg);
+				return -EINVAL;
+			}
+			if (i < EROFS_BLKSIZ) {
+				erofs_err("chunksize %s must be larger than block size",
+					  optarg);
+				return -EINVAL;
+			}
+			erofs_sb_set_chunked_file();
+			erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
+			break;
 
 		case 1:
 			usage();
@@ -528,6 +551,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (cfg.c_chunkbits) {
+		err = erofs_blob_init();
+		if (err)
+			return 1;
+	}
+
 	err = lstat64(cfg.c_src_path, &st);
 	if (err)
 		return 1;
@@ -622,6 +651,13 @@ int main(int argc, char **argv)
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
 
+	if (cfg.c_chunkbits) {
+		erofs_info("total metadata: %u blocks", erofs_mapbh(NULL));
+		err = erofs_blob_remap();
+		if (err)
+			goto exit;
+	}
+
 	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
 	if (err)
 		goto exit;
@@ -642,6 +678,8 @@ exit:
 	dev_close();
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
+	if (cfg.c_chunkbits)
+		erofs_blob_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.24.4

