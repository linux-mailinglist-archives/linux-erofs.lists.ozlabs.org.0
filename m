Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED43EFD48
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 09:03:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqJlw3LTzz3bYX
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 17:03:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqJlh4DRbz2xgP
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Aug 2021 17:03:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UjgIOt5_1629270197; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UjgIOt5_1629270197) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 18 Aug 2021 15:03:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH 4/4] erofs-utils: support chunk-based uncompressed files
Date: Wed, 18 Aug 2021 15:03:16 +0800
Message-Id: <20210818070316.1970-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210818070316.1970-1-hsiangkao@linux.alibaba.com>
References: <20210818070316.1970-1-hsiangkao@linux.alibaba.com>
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
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Eryu Guan <eguan@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add mkfs support to new chunk-based uncompressed files.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/blobchunk.h |  18 ++++
 include/erofs/config.h    |   2 +-
 include/erofs/internal.h  |   1 +
 include/erofs/io.h        |   2 +
 include/erofs_fs.h        |  39 +++++++-
 lib/Makefile.am           |   2 +-
 lib/blobchunk.c           | 200 ++++++++++++++++++++++++++++++++++++++
 lib/inode.c               |  35 +++++--
 lib/io.c                  |   2 +-
 mkfs/main.c               |  41 +++++++-
 10 files changed, 328 insertions(+), 14 deletions(-)
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
index 8124f3b36baf..0cd6a359e216 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -44,6 +44,7 @@ struct erofs_configure {
 	bool c_random_pclusterblks;
 #endif
 	char c_timeinherit;
+	char c_chunkbits;
 	bool c_noinline_data;
 
 #ifdef HAVE_LIBSELINUX
@@ -57,7 +58,6 @@ struct erofs_configure {
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
-
 	u32 c_physical_clusterblks;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5583861b766d..12274769c10d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -160,6 +160,7 @@ struct erofs_inode {
 
 	union {
 		void *compressmeta;
+		void *chunkindexes;
 		struct {
 			uint16_t z_advise;
 			uint8_t  z_algorithmtype[2];
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 5b685d217a0f..226509ff33ca 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -27,6 +27,8 @@ int dev_fsync(void);
 int dev_resize(erofs_blk_t nblocks);
 u64 dev_length(void);
 
+extern int erofs_devfd;
+
 int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
                           int fd_out, erofs_off_t *off_out,
                           size_t length);
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 18fc1820c58c..b3de05fc5e50 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
+ * Copyright (C) 2021, Alibaba Cloud
  */
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
@@ -22,10 +22,12 @@
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
+#define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
-	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
+	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -67,13 +69,16 @@ struct erofs_super_block {
  * inode, [xattrs], last_inline_data, ... | ... | no-holed data
  * 3 - inode compression D:
  * inode, [xattrs], map_header, extents ... | ...
- * 4~7 - reserved
+ * 4 - inode chunk-based E:
+ * inode, [xattrs], chunk indexes ... | ...
+ * 5~7 - reserved
  */
 enum {
 	EROFS_INODE_FLAT_PLAIN			= 0,
 	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
 	EROFS_INODE_FLAT_INLINE			= 2,
 	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_CHUNK_BASED			= 4,
 	EROFS_INODE_DATALAYOUT_MAX
 };
 
@@ -93,6 +98,16 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_ALL	\
 	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
 
+/* indicate chunk blkbits, thus `chunksize = blocksize << chunk blkbits' */
+#define EROFS_CHUNK_FORMAT_BLKBITS		0x001F
+/* with chunk indexes or just a 4-byte blkaddr array */
+#define EROFS_CHUNK_FORMAT_INDEXES		0x0020
+
+struct erofs_inode_chunk_info {
+	__le16 format;		/* chunk blkbits */
+	__le16 reserved;
+};
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
@@ -110,6 +125,9 @@ struct erofs_inode_compact {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
 	} i_u;
 	__le32 i_ino;           /* only used for 32-bit stat compatibility */
 	__le16 i_uid;
@@ -138,6 +156,9 @@ struct erofs_inode_extended {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
 	} i_u;
 
 	/* only used for 32-bit stat compatibility */
@@ -207,6 +228,15 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 				 e->e_name_len + le16_to_cpu(e->e_value_size));
 }
 
+/* represent a zeroed chunk (hole) */
+#define EROFS_NULL_ADDR			-1
+
+struct erofs_inode_chunk_index {
+	__le32 blkaddr;
+	__le16 device_id;	/* back-end storage id, always 0 for now */
+	__le16 reserved;	/* reserved, don't care */
+};
+
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
@@ -351,6 +381,8 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_info) != 4);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
@@ -360,4 +392,3 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 }
 
 #endif
-
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 8e4ed37f9c70..ea84e0edd628 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -22,7 +22,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      hashmap.c sha256.c
+		      hashmap.c sha256.c blobchunk.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
new file mode 100644
index 000000000000..6ff1c1373e32
--- /dev/null
+++ b/lib/blobchunk.c
@@ -0,0 +1,200 @@
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
+	unsigned int pos;
+
+	for (pos = 0; pos < inode->extent_isize;
+	     pos += sizeof(struct erofs_inode_chunk_index)) {
+		struct erofs_blobchunk *chunk;
+
+		chunk = *(void **)(inode->chunkindexes + pos);
+		idx.blkaddr = chunk->blkaddr + remapped_base;
+		memcpy(inode->chunkindexes + pos, &idx, sizeof(idx));
+	}
+	off = roundup(off, sizeof(struct erofs_inode_chunk_index));
+
+	return dev_write(inode->chunkindexes, off, inode->extent_isize);
+}
+
+int erofs_blob_write_chunked_file(struct erofs_inode *inode)
+{
+	unsigned int chunksize = 1 << cfg.c_chunkbits;
+	unsigned int count = DIV_ROUND_UP(inode->i_size, chunksize);
+	struct erofs_inode_chunk_index *idx;
+	erofs_off_t pos;
+	unsigned int len;
+	int fd, ret;
+
+	inode->extent_isize = count * sizeof(struct erofs_inode_chunk_index);
+	idx = malloc(inode->extent_isize);
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
+		len = min_t(unsigned int, inode->i_size - pos, chunksize);
+		chunk = erofs_blob_getchunk(fd, len);
+		if (IS_ERR(chunk)) {
+			ret = PTR_ERR(chunk);
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
index 6871d2be2d49..ac4b833388a8 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -25,6 +25,7 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/blobchunk.h"
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
@@ -386,6 +387,9 @@ int erofs_write_file(struct erofs_inode *inode)
 		return 0;
 	}
 
+	if (cfg.c_chunkbits)
+		return erofs_blob_write_chunked_file(inode);
+
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
 		ret = erofs_write_compressed_file(inode);
 
@@ -439,6 +443,11 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 			if (is_inode_layout_compression(inode))
 				u.dic.i_u.compressed_blocks =
 					cpu_to_le32(inode->u.i_blocks);
+			else if (inode->datalayout ==
+					EROFS_INODE_CHUNK_BASED)
+				u.dic.i_u.c.format = (cfg.c_chunkbits -
+					LOG_BLOCK_SIZE) |
+					EROFS_CHUNK_FORMAT_INDEXES;
 			else
 				u.dic.i_u.raw_blkaddr =
 					cpu_to_le32(inode->u.i_blkaddr);
@@ -472,6 +481,11 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 			if (is_inode_layout_compression(inode))
 				u.die.i_u.compressed_blocks =
 					cpu_to_le32(inode->u.i_blocks);
+			else if (inode->datalayout ==
+					EROFS_INODE_CHUNK_BASED)
+				u.die.i_u.c.format = (cfg.c_chunkbits -
+					LOG_BLOCK_SIZE) |
+					EROFS_CHUNK_FORMAT_INDEXES;
 			else
 				u.die.i_u.raw_blkaddr =
 					cpu_to_le32(inode->u.i_blkaddr);
@@ -504,12 +518,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
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
@@ -564,6 +585,8 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	if (is_inode_layout_compression(inode))
 		goto noinline;
+	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
+		goto noinline;
 
 	if (cfg.c_noinline_data && S_ISREG(inode->i_mode)) {
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
diff --git a/lib/io.c b/lib/io.c
index e4083bb53c27..d0d1a3695b6b 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -26,7 +26,7 @@
 #include "erofs/print.h"
 
 static const char *erofs_devname;
-static int erofs_devfd = -1;
+int erofs_devfd = -1;
 static u64 erofs_devsz;
 
 int dev_get_blkdev_size(int fd, u64 *bytes)
diff --git a/mkfs/main.c b/mkfs/main.c
index 10fe14d7a722..8c813a229c57 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -23,6 +23,8 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
+#include "erofs/hashtable.h"
+#include "erofs/blobchunk.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -44,6 +46,7 @@ static struct option long_options[] = {
 	{"random-pclusterblks", no_argument, NULL, 8},
 #endif
 	{"max-extent-bytes", required_argument, NULL, 9},
+	{"chunksize", required_argument, NULL, 256},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 10},
 	{"product-out", required_argument, NULL, 11},
@@ -79,6 +82,7 @@ static void usage(void)
 #ifdef HAVE_LIBUUID
 	      " -UX                   use a given filesystem UUID\n"
 #endif
+	      " --chunksize=X         set chunk size to X bytes and use chunk-based files instead\n"
 	      " --exclude-path=X      avoid including file X (X = exact literal path)\n"
 	      " --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
@@ -176,7 +180,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while((opt = getopt_long(argc, argv, "d:x:z:E:T:U:C:",
+	while((opt = getopt_long(argc, argv, "c:d:x:z:E:T:U:C:",
 				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -316,6 +320,24 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_physical_clusterblks = i / EROFS_BLKSIZ;
 			break;
+		case 256:
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
+			break;
 
 		case 1:
 			usage();
@@ -523,6 +545,12 @@ int main(int argc, char **argv)
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
@@ -610,6 +638,13 @@ int main(int argc, char **argv)
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
@@ -629,6 +664,10 @@ exit:
 #endif
 	dev_close();
 	erofs_cleanup_exclude_rules();
+
+	if (cfg.c_chunkbits)
+		erofs_blob_exit();
+
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.24.4

