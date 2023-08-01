Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C076ADF5
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 11:35:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RFVM65b6lz3bhc
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 19:34:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RFVM148xtz2y1c
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Aug 2023 19:34:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VoqGDSm_1690882480;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoqGDSm_1690882480)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:34:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: generate preallocated extents for tarerofs
Date: Tue,  1 Aug 2023 17:34:39 +0800
Message-Id: <20230801093439.29059-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

It is also useful to fill data blocks from tarballs at runtime in
order to implement image lazy pulling.

Let's generate an additional mapfile for such use cases:
   mkfs.erofs --tar=0,MAPFILE IMAGE TARBALL

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - free inode->chunkindexes on the error path (Jingbo);
 - fix erofs_blocklist_open for the original block list files (Jingbo);
 - tarerofs_write_chunk_data => tarerofs_write_chunkes. 

 include/erofs/blobchunk.h  |   7 +-
 include/erofs/block_list.h |   7 +-
 include/erofs/tar.h        |   1 +
 lib/Makefile.am            |   3 +-
 lib/blobchunk.c            | 159 +++++++++++++++++++++++++++++--------
 lib/block_list.c           |  23 ++++--
 lib/tar.c                  |  88 +-------------------
 mkfs/main.c                |  41 ++++++----
 8 files changed, 182 insertions(+), 147 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 7c5645e..010aee1 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -14,14 +14,13 @@ extern "C"
 
 #include "erofs/internal.h"
 
-struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
-			unsigned int device_id, erofs_blk_t blkaddr);
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd);
-int erofs_blob_remap(struct erofs_sb_info *sbi);
+int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
+int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
 void erofs_blob_exit(void);
 int erofs_blob_init(const char *blobfile_path);
-int erofs_generate_devtable(struct erofs_sb_info *sbi);
+int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 78fab44..9f9975e 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -13,9 +13,12 @@ extern "C"
 
 #include "internal.h"
 
+int erofs_blocklist_open(char *filename, bool srcmap);
+void erofs_blocklist_close(void);
+
+void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
+			      erofs_off_t srcoff);
 #ifdef WITH_ANDROID
-int erofs_droid_blocklist_fopen(void);
-void erofs_droid_blocklist_fclose(void);
 void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks);
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index a14f8ac..8d3f8de 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -15,6 +15,7 @@ struct erofs_pax_header {
 
 struct erofs_tarfile {
 	struct erofs_pax_header global;
+	char *mapfile;
 
 	int fd;
 	u64 offset;
diff --git a/lib/Makefile.am b/lib/Makefile.am
index ebe466b..7a5dc03 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -30,7 +30,8 @@ noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
-		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c
+		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
+		      block_list.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 4e4295e..f5d2957 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -20,13 +20,17 @@ struct erofs_blobchunk {
 	};
 	char		sha256[32];
 	unsigned int	device_id;
-	erofs_off_t	chunksize;
+	union {
+		erofs_off_t	chunksize;
+		erofs_off_t	sourceoffset;
+	};
 	erofs_blk_t	blkaddr;
 };
 
 static struct hashmap blob_hashmap;
 static FILE *blobfile;
 static erofs_blk_t remapped_base;
+static erofs_off_t datablob_size;
 static bool multidev;
 static struct erofs_buffer_head *bh_devt;
 struct erofs_blobchunk erofs_holechunk = {
@@ -34,8 +38,8 @@ struct erofs_blobchunk erofs_holechunk = {
 };
 static LIST_HEAD(unhashed_blobchunks);
 
-struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
-		unsigned int device_id, erofs_blk_t blkaddr)
+static struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
+		erofs_blk_t blkaddr, erofs_off_t sourceoffset)
 {
 	struct erofs_blobchunk *chunk;
 
@@ -43,9 +47,9 @@ struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 
-	chunk->chunksize = chunksize;
 	chunk->device_id = device_id;
 	chunk->blkaddr = blkaddr;
+	chunk->sourceoffset = sourceoffset;
 	list_add_tail(&chunk->list, &unhashed_blobchunks);
 	return chunk;
 }
@@ -78,7 +82,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 	blkpos = ftell(blobfile);
 	DBG_BUGON(erofs_blkoff(sbi, blkpos));
 
-	if (multidev)
+	if (sbi->extra_devices)
 		chunk->device_id = 1;
 	else
 		chunk->device_id = 0;
@@ -125,6 +129,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	struct erofs_inode_chunk_index idx = {0};
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
 	erofs_blk_t extent_end, chunkblks;
+	erofs_off_t source_offset;
 	unsigned int dst, src, unit;
 	bool first_extent = true;
 
@@ -153,6 +158,9 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		if (extent_start == EROFS_NULL_ADDR ||
 		    idx.blkaddr != extent_end) {
 			if (extent_start != EROFS_NULL_ADDR) {
+				tarerofs_blocklist_write(extent_start,
+						extent_end - extent_start,
+						source_offset);
 				erofs_droid_blocklist_write_extent(inode,
 					extent_start,
 					extent_end - extent_start,
@@ -160,6 +168,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 				first_extent = false;
 			}
 			extent_start = idx.blkaddr;
+			source_offset = chunk->sourceoffset;
 		}
 		extent_end = idx.blkaddr + chunkblks;
 		idx.device_id = cpu_to_le16(chunk->device_id);
@@ -171,6 +180,9 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
 	off = roundup(off, unit);
+	if (extent_start != EROFS_NULL_ADDR)
+		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
+					 source_offset);
 	erofs_droid_blocklist_write_extent(inode, extent_start,
 			extent_start == EROFS_NULL_ADDR ?
 					0 : extent_end - extent_start,
@@ -236,7 +248,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
 
-	if (multidev)
+	if (sbi->extra_devices)
 		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -320,46 +332,120 @@ err:
 	return ret;
 }
 
-int erofs_blob_remap(struct erofs_sb_info *sbi)
+int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int chunkbits = ilog2(inode->i_size - 1) + 1;
+	unsigned int count, unit, device_id;
+	erofs_off_t chunksize, len, pos;
+	erofs_blk_t blkaddr;
+	struct erofs_inode_chunk_index *idx;
+
+	if (chunkbits < sbi->blkszbits)
+		chunkbits = sbi->blkszbits;
+	if (chunkbits - sbi->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
+
+	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
+	if (sbi->extra_devices) {
+		device_id = 1;
+		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
+		unit = sizeof(struct erofs_inode_chunk_index);
+		DBG_BUGON(erofs_blkoff(sbi, data_offset));
+		blkaddr = erofs_blknr(sbi, data_offset);
+	} else {
+		device_id = 0;
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
+		DBG_BUGON(erofs_blkoff(sbi, datablob_size));
+		blkaddr = erofs_blknr(sbi, datablob_size);
+		datablob_size += round_up(inode->i_size, erofs_blksiz(sbi));
+	}
+	chunksize = 1ULL << chunkbits;
+	count = DIV_ROUND_UP(inode->i_size, chunksize);
+
+	inode->extent_isize = count * unit;
+	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
+	if (!idx)
+		return -ENOMEM;
+	inode->chunkindexes = idx;
+
+	for (pos = 0; pos < inode->i_size; pos += len) {
+		struct erofs_blobchunk *chunk;
+
+		len = min_t(erofs_off_t, inode->i_size - pos, chunksize);
+
+		chunk = erofs_get_unhashed_chunk(device_id, blkaddr,
+						 data_offset);
+		if (IS_ERR(chunk))
+			return PTR_ERR(chunk);
+
+		*(void **)idx++ = chunk;
+		blkaddr += erofs_blknr(sbi, len);
+		data_offset += len;
+	}
+	inode->datalayout = EROFS_INODE_CHUNK_BASED;
+	return 0;
+}
+
+int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 {
 	struct erofs_buffer_head *bh;
 	ssize_t length;
 	erofs_off_t pos_in, pos_out;
 	ssize_t ret;
 
-	fflush(blobfile);
-	length = ftell(blobfile);
-	if (length < 0)
-		return -errno;
-	if (multidev) {
-		struct erofs_deviceslot dis = {
-			.blocks = erofs_blknr(sbi, length),
-		};
+	if (blobfile) {
+		fflush(blobfile);
+		length = ftell(blobfile);
+		if (length < 0)
+			return -errno;
 
-		pos_out = erofs_btell(bh_devt, false);
-		ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
-		if (ret)
-			return ret;
+		if (sbi->extra_devices)
+			sbi->devs[0].blocks = erofs_blknr(sbi, length);
+		else
+			datablob_size = length;
+	}
+
+	if (sbi->extra_devices) {
+		unsigned int i;
 
+		pos_out = erofs_btell(bh_devt, false);
+		i = 0;
+		do {
+			struct erofs_deviceslot dis = {
+				.blocks = cpu_to_le32(sbi->devs[i].blocks),
+			};
+			int ret;
+
+			ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
+			if (ret)
+				return ret;
+			pos_out += sizeof(dis);
+		} while (++i < sbi->extra_devices);
 		bh_devt->op = &erofs_drop_directly_bhops;
 		erofs_bdrop(bh_devt, false);
 		return 0;
 	}
-	if (!length)	/* bail out if there is no chunked data */
-		return 0;
-	bh = erofs_balloc(DATA, length, 0, 0);
+
+	bh = erofs_balloc(DATA, blobfile ? datablob_size : 0, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
 	erofs_mapbh(bh->block);
+
 	pos_out = erofs_btell(bh, false);
-	pos_in = 0;
 	remapped_base = erofs_blknr(sbi, pos_out);
-	ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
-				    sbi->devfd, &pos_out, length);
+	if (blobfile) {
+		pos_in = 0;
+		ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
+				sbi->devfd, &pos_out, datablob_size);
+		ret = ret < datablob_size ? -EIO : 0;
+	} else {
+		ret = 0;
+	}
 	bh->op = &erofs_drop_directly_bhops;
 	erofs_bdrop(bh, false);
-	return ret < length ? -EIO : 0;
+	return ret;
 }
 
 void erofs_blob_exit(void)
@@ -405,22 +491,25 @@ int erofs_blob_init(const char *blobfile_path)
 	return 0;
 }
 
-int erofs_generate_devtable(struct erofs_sb_info *sbi)
+int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
 {
-	struct erofs_deviceslot dis;
-
-	if (!multidev)
+	if (!devices)
 		return 0;
 
-	bh_devt = erofs_balloc(DEVT, sizeof(dis), 0, 0);
-	if (IS_ERR(bh_devt))
-		return PTR_ERR(bh_devt);
+	sbi->devs = calloc(devices, sizeof(sbi->devs[0]));
+	if (!sbi->devs)
+		return -ENOMEM;
 
-	dis = (struct erofs_deviceslot) {};
+	bh_devt = erofs_balloc(DEVT,
+		sizeof(struct erofs_deviceslot) * devices, 0, 0);
+	if (IS_ERR(bh_devt)) {
+		free(sbi->devs);
+		return PTR_ERR(bh_devt);
+	}
 	erofs_mapbh(bh_devt->block);
 	bh_devt->op = &erofs_skip_write_bhops;
 	sbi->devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
-	sbi->extra_devices = 1;
+	sbi->extra_devices = devices;
 	erofs_sb_set_device_table(sbi);
 	return 0;
 }
diff --git a/lib/block_list.c b/lib/block_list.c
index 896fb01..b45b553 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -3,7 +3,6 @@
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
  */
-#ifdef WITH_ANDROID
 #include <stdio.h>
 #include <sys/stat.h>
 #include "erofs/block_list.h"
@@ -12,17 +11,19 @@
 #include "erofs/print.h"
 
 static FILE *block_list_fp;
+bool srcmap_enabled;
 
-int erofs_droid_blocklist_fopen(void)
+int erofs_blocklist_open(char *filename, bool srcmap)
 {
-	block_list_fp = fopen(cfg.block_list_file, "w");
+	block_list_fp = fopen(filename, "w");
 
 	if (!block_list_fp)
-		return -1;
+		return -errno;
+	srcmap_enabled = srcmap;
 	return 0;
 }
 
-void erofs_droid_blocklist_fclose(void)
+void erofs_blocklist_close(void)
 {
 	if (!block_list_fp)
 		return;
@@ -31,6 +32,18 @@ void erofs_droid_blocklist_fclose(void)
 	block_list_fp = NULL;
 }
 
+/* XXX: really need to be cleaned up */
+void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
+			      erofs_off_t srcoff)
+{
+	if (!block_list_fp || !nblocks || !srcmap_enabled)
+		return;
+
+	fprintf(block_list_fp, "%08x %8x %08" PRIx64 "\n",
+		blkaddr, nblocks, srcoff);
+}
+
+#ifdef WITH_ANDROID
 static void blocklist_write(const char *path, erofs_blk_t blk_start,
 			    erofs_blk_t nblocks, bool first_extent,
 			    bool last_extent)
diff --git a/lib/tar.c b/lib/tar.c
index 3c145e5..54ee33f 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -341,44 +341,6 @@ out:
 	return ret;
 }
 
-int tarerofs_write_chunk_indexes(struct erofs_inode *inode, erofs_blk_t blkaddr)
-{
-	struct erofs_sb_info *sbi = inode->sbi;
-	unsigned int chunkbits = ilog2(inode->i_size - 1) + 1;
-	unsigned int count, unit;
-	erofs_off_t chunksize, len, pos;
-	struct erofs_inode_chunk_index *idx;
-
-	if (chunkbits < sbi->blkszbits)
-		chunkbits = sbi->blkszbits;
-	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
-	inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
-	chunksize = 1ULL << chunkbits;
-	count = DIV_ROUND_UP(inode->i_size, chunksize);
-
-	unit = sizeof(struct erofs_inode_chunk_index);
-	inode->extent_isize = count * unit;
-	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
-	if (!idx)
-		return -ENOMEM;
-	inode->chunkindexes = idx;
-
-	for (pos = 0; pos < inode->i_size; pos += len) {
-		struct erofs_blobchunk *chunk;
-
-		len = min_t(erofs_off_t, inode->i_size - pos, chunksize);
-
-		chunk = erofs_get_unhashed_chunk(chunksize, 1, blkaddr);
-		if (IS_ERR(chunk))
-			return PTR_ERR(chunk);
-
-		*(void **)idx++ = chunk;
-		blkaddr += erofs_blknr(sbi, len);
-	}
-	inode->datalayout = EROFS_INODE_CHUNK_BASED;
-	return 0;
-}
-
 void tarerofs_remove_inode(struct erofs_inode *inode)
 {
 	struct erofs_dentry *d;
@@ -608,7 +570,8 @@ restart:
 			eh.link = strndup(th.linkname, sizeof(th.linkname));
 	}
 
-	if (tar->index_mode && erofs_blkoff(sbi, tar_offset + sizeof(th))) {
+	if (tar->index_mode && !tar->mapfile &&
+	    erofs_blkoff(sbi, data_offset)) {
 		erofs_err("invalid tar data alignment @ %llu", tar_offset);
 		ret = -EIO;
 		goto out;
@@ -710,8 +673,7 @@ new_inode:
 			inode->i_link = malloc(inode->i_size + 1);
 			memcpy(inode->i_link, eh.link, inode->i_size + 1);
 		} else if (tar->index_mode) {
-			ret = tarerofs_write_chunk_indexes(inode,
-					erofs_blknr(sbi, data_offset));
+			ret = tarerofs_write_chunkes(inode, data_offset);
 			if (ret)
 				goto out;
 			if (erofs_lskip(tar->fd, inode->i_size)) {
@@ -763,47 +725,3 @@ invalid_tar:
 	ret = -EIO;
 	goto out;
 }
-
-static struct erofs_buffer_head *bh_devt;
-
-int tarerofs_reserve_devtable(struct erofs_sb_info *sbi, unsigned int devices)
-{
-	if (!devices)
-		return 0;
-
-	bh_devt = erofs_balloc(DEVT,
-		sizeof(struct erofs_deviceslot) * devices, 0, 0);
-	if (IS_ERR(bh_devt))
-		return PTR_ERR(bh_devt);
-
-	erofs_mapbh(bh_devt->block);
-	bh_devt->op = &erofs_skip_write_bhops;
-	sbi->devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
-	sbi->extra_devices = devices;
-	erofs_sb_set_device_table(sbi);
-	return 0;
-}
-
-int tarerofs_write_devtable(struct erofs_sb_info *sbi, struct erofs_tarfile *tar)
-{
-	erofs_off_t pos_out;
-	unsigned int i;
-
-	if (!sbi->extra_devices)
-		return 0;
-	pos_out = erofs_btell(bh_devt, false);
-	for (i = 0; i < sbi->extra_devices; ++i) {
-		struct erofs_deviceslot dis = {
-			.blocks = erofs_blknr(sbi, tar->offset),
-		};
-		int ret;
-
-		ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
-		if (ret)
-			return ret;
-		pos_out += sizeof(dis);
-	}
-	bh_devt->op = &erofs_drop_directly_bhops;
-	erofs_bdrop(bh_devt, false);
-	return 0;
-}
diff --git a/mkfs/main.c b/mkfs/main.c
index bc5ed87..3809c71 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -484,8 +484,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 		case 20:
 			if (optarg && (!strcmp(optarg, "i") ||
-					!strcmp(optarg, "0")))
+				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2))) {
 				erofstar.index_mode = true;
+				if (!memcmp(optarg, "0,", 2))
+					erofstar.mapfile = strdup(optarg + 2);
+			}
 			tar_mode = true;
 			break;
 		case 21:
@@ -795,7 +798,8 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (cfg.block_list_file && erofs_droid_blocklist_fopen() < 0) {
+	if (cfg.block_list_file &&
+	    erofs_blocklist_open(cfg.block_list_file, false)) {
 		erofs_err("failed to open %s", cfg.block_list_file);
 		return 1;
 	}
@@ -827,8 +831,18 @@ int main(int argc, char **argv)
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
 #endif
-	if (tar_mode && erofstar.index_mode)
-		sbi.blkszbits = 9;
+	if (tar_mode && erofstar.index_mode) {
+		if (erofstar.mapfile) {
+			err = erofs_blocklist_open(erofstar.mapfile, true);
+			if (err) {
+				erofs_err("failed to open %s", erofstar.mapfile);
+				goto exit;
+			}
+		} else {
+			sbi.blkszbits = 9;
+		}
+	}
+
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
@@ -884,10 +898,8 @@ int main(int argc, char **argv)
 			return 1;
 	}
 
-	if (tar_mode && erofstar.index_mode)
-		err = tarerofs_reserve_devtable(&sbi, 1);
-	else
-		err = erofs_generate_devtable(&sbi);
+	if ((erofstar.index_mode && !erofstar.mapfile) || cfg.c_blobdev_path)
+		err = erofs_mkfs_init_devices(&sbi, 1);
 	if (err) {
 		erofs_err("failed to generate device table: %s",
 			  erofs_strerror(err));
@@ -942,11 +954,12 @@ int main(int argc, char **argv)
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
 
-	if (tar_mode)
-		tarerofs_write_devtable(&sbi, &erofstar);
-	if (cfg.c_chunkbits) {
+	if (erofstar.index_mode || cfg.c_chunkbits) {
 		erofs_info("total metadata: %u blocks", erofs_mapbh(NULL));
-		err = erofs_blob_remap(&sbi);
+		if (erofstar.index_mode && !erofstar.mapfile)
+			sbi.devs[0].blocks =
+				BLK_ROUND_UP(&sbi, erofstar.offset);
+		err = erofs_mkfs_dump_blobs(&sbi);
 		if (err)
 			goto exit;
 	}
@@ -980,9 +993,7 @@ int main(int argc, char **argv)
 exit:
 	z_erofs_compress_exit();
 	z_erofs_dedupe_exit();
-#ifdef WITH_ANDROID
-	erofs_droid_blocklist_fclose();
-#endif
+	erofs_blocklist_close();
 	dev_close(&sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
-- 
2.24.4

