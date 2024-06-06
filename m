Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25778FE51A
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 13:18:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D2PK0MeG;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vw1zm4kJYz3dH4
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 21:18:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D2PK0MeG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vw1zh4Mc9z3cbL
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 21:18:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717672717; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Tgc1ObIM108OyUDiP0cF6Cc1tI6jnVM8iQPThTw977g=;
	b=D2PK0MeGdcsS5Bp4i+ekT1o+xI3u7HbMD0Hn6gbHiuWdByCnQe/Sq+K+qdUPldvALO569H0BIUihIfcTn7S9fDWyy0MjBIAcmswK4u7YAhFHFMmMMpbiECuc+Xnlk2eZrWx/1WMwAeCmcmXjwplidjLMXPV/W9qfZukKSBIv37A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7y5e7W_1717672715;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W7y5e7W_1717672715)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:18:36 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: support virtual files
Date: Thu,  6 Jun 2024 19:18:33 +0800
Message-Id: <20240606111833.2389455-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The current erofs-utils I/O implementation is through file descriptors.
The new `erofs_vfile` provides a more flexible way to perform I/Os.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 dump/main.c              |  10 +-
 fsck/main.c              |  16 +-
 fuse/main.c              |  10 +-
 include/erofs/internal.h |  47 ++++-
 include/erofs/io.h       |  55 +++---
 lib/blobchunk.c          |   8 +-
 lib/cache.c              |   2 +-
 lib/compress.c           |  14 +-
 lib/data.c               |  10 +-
 lib/diskbuf.c            |   6 +-
 lib/inode.c              |  18 +-
 lib/io.c                 | 380 +++++++++++++++++++--------------------
 lib/namei.c              |   6 +-
 lib/super.c              |   4 +-
 lib/xattr.c              |  14 +-
 lib/zmap.c               |   6 +-
 mkfs/main.c              |  18 +-
 17 files changed, 324 insertions(+), 300 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index dd2c620..e0456bb 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -167,7 +167,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			usage(argc, argv);
 			exit(0);
 		case 3:
-			err = blob_open_ro(&sbi, optarg);
+			err = erofs_blob_open_ro(&sbi, optarg);
 			if (err)
 				return err;
 			++sbi.extra_devices;
@@ -181,7 +181,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			dumpcfg.show_subdirectories = true;
 			break;
 		case 6:
-			sbi.diskoffset = strtoull(optarg, &endptr, 0);
+			sbi.bdev.offset = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid disk offset %s", optarg);
 				return -EINVAL;
@@ -685,7 +685,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = dev_open_ro(&sbi, cfg.c_img_path);
+	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDONLY | O_TRUNC);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
@@ -718,9 +718,9 @@ int main(int argc, char **argv)
 exit_put_super:
 	erofs_put_super(&sbi);
 exit_dev_close:
-	dev_close(&sbi);
+	erofs_dev_close(&sbi);
 exit:
-	blob_closeall(&sbi);
+	erofs_blob_closeall(&sbi);
 	erofs_exit_configure();
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index 4dcb49d..4de8491 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -184,7 +184,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			}
 			break;
 		case 3:
-			ret = blob_open_ro(&sbi, optarg);
+			ret = erofs_blob_open_ro(&sbi, optarg);
 			if (ret)
 				return ret;
 			++sbi.extra_devices;
@@ -220,7 +220,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			has_opt_preserve = true;
 			break;
 		case 12:
-			sbi.diskoffset = strtoull(optarg, &endptr, 0);
+			sbi.bdev.offset = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid disk offset %s", optarg);
 				return -EINVAL;
@@ -312,7 +312,7 @@ static int erofs_check_sb_chksum(void)
 	struct erofs_super_block *sb;
 	int ret;
 
-	ret = blk_read(&sbi, 0, buf, 0, 1);
+	ret = erofs_blk_read(&sbi, 0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to check checksum: %d",
 			  ret);
@@ -360,7 +360,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	}
 
 	addr = erofs_iloc(inode) + inode->inode_isize;
-	ret = dev_read(sbi, 0, buf, addr, xattr_hdr_size);
+	ret = erofs_dev_read(sbi, 0, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
 			  inode->nid | 0ULL, ret);
@@ -390,7 +390,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	while (remaining > 0) {
 		unsigned int entry_sz;
 
-		ret = dev_read(sbi, 0, buf, addr, xattr_entry_size);
+		ret = erofs_dev_read(sbi, 0, buf, addr, xattr_entry_size);
 		if (ret) {
 			erofs_err("failed to read xattr entry @ nid %llu: %d",
 				  inode->nid | 0ULL, ret);
@@ -966,7 +966,7 @@ int main(int argc, char *argv[])
 	cfg.c_dbg_lvl = -1;
 #endif
 
-	err = dev_open_ro(&sbi, cfg.c_img_path);
+	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDONLY);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
@@ -1022,9 +1022,9 @@ exit_hardlink:
 exit_put_super:
 	erofs_put_super(&sbi);
 exit_dev_close:
-	dev_close(&sbi);
+	erofs_dev_close(&sbi);
 exit:
-	blob_closeall(&sbi);
+	erofs_blob_closeall(&sbi);
 	erofs_exit_configure();
 	return err ? 1 : 0;
 }
diff --git a/fuse/main.c b/fuse/main.c
index 32f59a3..63777f4 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -574,7 +574,7 @@ static int optional_opt_func(void *data, const char *arg, int key,
 
 	switch (key) {
 	case 1:
-		ret = blob_open_ro(&sbi, arg + sizeof("--device=") - 1);
+		ret = erofs_blob_open_ro(&sbi, arg + sizeof("--device=") - 1);
 		if (ret)
 			return -1;
 		++sbi.extra_devices;
@@ -676,8 +676,8 @@ int main(int argc, char *argv[])
 	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
 		cfg.c_dbg_lvl = EROFS_DBG;
 
-	sbi.diskoffset = fusecfg.offset;
-	ret = dev_open_ro(&sbi, fusecfg.disk);
+	sbi.bdev.offset = fusecfg.offset;
+	ret = erofs_dev_open(&sbi, fusecfg.disk, O_RDONLY);
 	if (ret) {
 		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
 		goto err_fuse_free_args;
@@ -747,8 +747,8 @@ int main(int argc, char *argv[])
 err_super_put:
 	erofs_put_super(&sbi);
 err_dev_close:
-	blob_closeall(&sbi);
-	dev_close(&sbi);
+	erofs_blob_closeall(&sbi);
+	erofs_dev_close(&sbi);
 err_fuse_free_args:
 	free(opts.mountpoint);
 	fuse_opt_free_args(&args);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 46345e0..50e3bb2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -26,6 +26,7 @@ typedef unsigned short umode_t;
 #include <pthread.h>
 #endif
 #include "atomic.h"
+#include "io.h"
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -114,9 +115,8 @@ struct erofs_sb_info {
 	u8 xattr_prefix_count;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 
-	int devfd, devblksz;
-	/* offset when reading multi-part images */
-	u64 diskoffset;
+	struct erofs_vfile bdev;
+	int devblksz;
 	u64 devsz;
 	dev_t dev;
 	unsigned int nblobs;
@@ -440,6 +440,47 @@ int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map, int flags);
 
+/* io.c */
+int erofs_dev_open(struct erofs_sb_info *sbi, const char *dev, int flags);
+void erofs_dev_close(struct erofs_sb_info *sbi);
+void erofs_blob_closeall(struct erofs_sb_info *sbi);
+int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev);
+
+int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
+		   void *buf, u64 offset, size_t len);
+
+static inline int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
+				  u64 offset, size_t len)
+{
+	return erofs_io_pwrite(&sbi->bdev, buf, offset, len);
+}
+
+static inline int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
+				     size_t len, bool pad)
+{
+	return erofs_io_fallocate(&sbi->bdev, offset, len, pad);
+}
+
+static inline int erofs_dev_resize(struct erofs_sb_info *sbi,
+				   erofs_blk_t blocks)
+{
+	return erofs_io_ftruncate(&sbi->bdev, (u64)blocks * erofs_blksiz(sbi));
+}
+
+static inline int erofs_blk_write(struct erofs_sb_info *sbi, const void *buf,
+				  erofs_blk_t blkaddr, u32 nblocks)
+{
+	return erofs_dev_write(sbi, buf, erofs_pos(sbi, blkaddr),
+			 erofs_pos(sbi, nblocks));
+}
+
+static inline int erofs_blk_read(struct erofs_sb_info *sbi, int device_id,
+				 void *buf, erofs_blk_t start, u32 nblocks)
+{
+	return erofs_dev_read(sbi, device_id, buf, erofs_pos(sbi, start),
+			erofs_pos(sbi, nblocks));
+}
+
 #ifdef EUCLEAN
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #else
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 4db5716..c82dfdf 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -16,44 +16,37 @@ extern "C"
 #define _GNU_SOURCE
 #endif
 #include <unistd.h>
-#include "internal.h"
+#include "defs.h"
 
 #ifndef O_BINARY
 #define O_BINARY	0
 #endif
 
-void blob_closeall(struct erofs_sb_info *sbi);
-int blob_open_ro(struct erofs_sb_info *sbi, const char *dev);
-int dev_open(struct erofs_sb_info *sbi, const char *devname);
-int dev_open_ro(struct erofs_sb_info *sbi, const char *dev);
-void dev_close(struct erofs_sb_info *sbi);
-int dev_write(struct erofs_sb_info *sbi, const void *buf,
-	      u64 offset, size_t len);
-int dev_read(struct erofs_sb_info *sbi, int device_id,
-	     void *buf, u64 offset, size_t len);
-int dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
-		 size_t len, bool padding);
-int dev_fsync(struct erofs_sb_info *sbi);
-int dev_resize(struct erofs_sb_info *sbi, erofs_blk_t nblocks);
-
-ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
-			      int fd_out, erofs_off_t *off_out,
+struct erofs_vfile;
+
+struct erofs_vfops {
+	int (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+	int (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
+	int (*fsync)(struct erofs_vfile *vf);
+	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
+	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
+};
+
+struct erofs_vfile {
+	struct erofs_vfops *ops;
+	u64 offset;
+	int fd;
+};
+
+int erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
+int erofs_io_fsync(struct erofs_vfile *vf);
+int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
+int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
+int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+
+ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
 			      size_t length);
 
-static inline int blk_write(struct erofs_sb_info *sbi, const void *buf,
-			    erofs_blk_t blkaddr, u32 nblocks)
-{
-	return dev_write(sbi, buf, erofs_pos(sbi, blkaddr),
-			 erofs_pos(sbi, nblocks));
-}
-
-static inline int blk_read(struct erofs_sb_info *sbi, int device_id, void *buf,
-			   erofs_blk_t start, u32 nblocks)
-{
-	return dev_read(sbi, device_id, buf, erofs_pos(sbi, start),
-			erofs_pos(sbi, nblocks));
-}
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 8082aa4..44b3113 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -195,7 +195,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 					0 : extent_end - extent_start,
 					   first_extent, true);
 
-	return dev_write(inode->sbi, inode->chunkindexes, off, inode->extent_isize);
+	return erofs_dev_write(inode->sbi, inode->chunkindexes, off, inode->extent_isize);
 }
 
 int erofs_blob_mergechunks(struct erofs_inode *inode, unsigned int chunkbits,
@@ -506,7 +506,7 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 			};
 
 			memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
-			ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
+			ret = erofs_dev_write(sbi, &dis, pos_out, sizeof(dis));
 			if (ret)
 				return ret;
 			pos_out += sizeof(dis);
@@ -525,11 +525,11 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 
 	pos_out = erofs_btell(bh, false);
 	remapped_base = erofs_blknr(sbi, pos_out);
-	pos_out += sbi->diskoffset;
+	pos_out += sbi->bdev.offset;
 	if (blobfile) {
 		pos_in = 0;
 		ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
-				sbi->devfd, &pos_out, datablob_size);
+				sbi->bdev.fd, &pos_out, datablob_size);
 		ret = ret < datablob_size ? -EIO : 0;
 	} else {
 		ret = 0;
diff --git a/lib/cache.c b/lib/cache.c
index 0a88061..f65f956 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -400,7 +400,7 @@ int erofs_bflush(struct erofs_buffer_block *bb)
 
 		padding = blksiz - (p->buffers.off & (blksiz - 1));
 		if (padding != blksiz)
-			dev_fillzero(&sbi, erofs_pos(&sbi, blkaddr) - padding,
+			erofs_dev_fillzero(&sbi, erofs_pos(&sbi, blkaddr) - padding,
 				     padding, true);
 
 		if (p->type != DATA)
diff --git a/lib/compress.c b/lib/compress.c
index f783236..12368eb 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -407,7 +407,7 @@ static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
 	} else {
 		erofs_dbg("Writing %u uncompressed data to block %u", count,
 			  ctx->blkaddr);
-		ret = blk_write(sbi, dst, ctx->blkaddr, 1);
+		ret = erofs_blk_write(sbi, dst, ctx->blkaddr, 1);
 		if (ret)
 			return ret;
 	}
@@ -659,7 +659,7 @@ frag_packing:
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
 				  e->length, ctx->blkaddr, e->compressedblks);
 
-			ret = blk_write(sbi, dst - padding, ctx->blkaddr,
+			ret = erofs_blk_write(sbi, dst - padding, ctx->blkaddr,
 					e->compressedblks);
 			if (ret)
 				return ret;
@@ -1288,7 +1288,7 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 		/* skip write data but leave blkaddr for inline fallback */
 		if (ei->e.inlined || !ei->e.compressedblks)
 			continue;
-		ret2 = blk_write(sbi, sctx->membuf + blkoff * erofs_blksiz(sbi),
+		ret2 = erofs_blk_write(sbi, sctx->membuf + blkoff * erofs_blksiz(sbi),
 				 ei->e.blkaddr, ei->e.compressedblks);
 		blkoff += ei->e.compressedblks;
 		if (ret2) {
@@ -1603,7 +1603,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(sbi, &lz4alg, erofs_btell(bh, false),
+		ret = erofs_dev_write(sbi, &lz4alg, erofs_btell(bh, false),
 				sizeof(lz4alg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -1627,7 +1627,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(sbi, &lzmaalg, erofs_btell(bh, false),
+		ret = erofs_dev_write(sbi, &lzmaalg, erofs_btell(bh, false),
 				sizeof(lzmaalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -1651,7 +1651,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(sbi, &zalg, erofs_btell(bh, false),
+		ret = erofs_dev_write(sbi, &zalg, erofs_btell(bh, false),
 				sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -1674,7 +1674,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(sbi, &zalg, erofs_btell(bh, false),
+		ret = erofs_dev_write(sbi, &zalg, erofs_btell(bh, false),
 				sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
diff --git a/lib/data.c b/lib/data.c
index c139e0c..5a79615 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -95,7 +95,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	pos = roundup(erofs_iloc(vi) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
-	err = blk_read(sbi, 0, buf, erofs_blknr(sbi, pos), 1);
+	err = erofs_blk_read(sbi, 0, buf, erofs_blknr(sbi, pos), 1);
 	if (err < 0)
 		return -EIO;
 
@@ -176,7 +176,7 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
 	if (ret)
 		return ret;
 
-	ret = dev_read(sbi, mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
+	ret = erofs_dev_read(sbi, mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
 	if (ret < 0)
 		return -EIO;
 	return 0;
@@ -266,7 +266,7 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 		return ret;
 	}
 
-	ret = dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
+	ret = erofs_dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
 	if (ret < 0)
 		return ret;
 
@@ -417,7 +417,7 @@ static void *erofs_read_metadata_bdi(struct erofs_sb_info *sbi,
 	u8 data[EROFS_MAX_BLOCK_SIZE];
 
 	*offset = round_up(*offset, 4);
-	ret = blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
+	ret = erofs_blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
 	if (ret)
 		return ERR_PTR(ret);
 	len = le16_to_cpu(*(__le16 *)(data + erofs_blkoff(sbi, *offset)));
@@ -433,7 +433,7 @@ static void *erofs_read_metadata_bdi(struct erofs_sb_info *sbi,
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(int, erofs_blksiz(sbi) - erofs_blkoff(sbi, *offset),
 			    len - i);
-		ret = blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
+		ret = erofs_blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
 		if (ret) {
 			free(buffer);
 			return ERR_PTR(ret);
diff --git a/lib/diskbuf.c b/lib/diskbuf.c
index e5889df..e5f1f0c 100644
--- a/lib/diskbuf.c
+++ b/lib/diskbuf.c
@@ -104,10 +104,10 @@ int erofs_diskbuf_init(unsigned int nstrms)
 		struct stat st;
 
 		/* try to use the devfd for regfiles on stream 0 */
-		if (strm == dbufstrm && sbi.devsz == INT64_MAX) {
+		if (strm == dbufstrm && !sbi.bdev.ops) {
 			strm->devpos = 1ULL << 40;
-			if (!ftruncate(sbi.devfd, strm->devpos << 1)) {
-				strm->fd = dup(sbi.devfd);
+			if (!ftruncate(sbi.bdev.fd, strm->devpos << 1)) {
+				strm->fd = dup(sbi.bdev.fd);
 				if (lseek(strm->fd, strm->devpos,
 					  SEEK_SET) != strm->devpos)
 					return -EIO;
diff --git a/lib/inode.c b/lib/inode.c
index cd48e55..909cb53 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -315,7 +315,7 @@ static int write_dirblock(struct erofs_sb_info *sbi,
 	char buf[EROFS_MAX_BLOCK_SIZE];
 
 	fill_dirblock(buf, erofs_blksiz(sbi), q, head, end);
-	return blk_write(sbi, buf, blkaddr, 1);
+	return erofs_blk_write(sbi, buf, blkaddr, 1);
 }
 
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
@@ -413,7 +413,7 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 		return ret;
 
 	if (nblocks)
-		blk_write(sbi, buf, inode->u.i_blkaddr, nblocks);
+		erofs_blk_write(sbi, buf, inode->u.i_blkaddr, nblocks);
 	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
@@ -456,7 +456,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 			return -EAGAIN;
 		}
 
-		ret = blk_write(sbi, buf, inode->u.i_blkaddr + i, 1);
+		ret = erofs_blk_write(sbi, buf, inode->u.i_blkaddr + i, 1);
 		if (ret)
 			return ret;
 	}
@@ -584,7 +584,7 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		BUG_ON(1);
 	}
 
-	ret = dev_write(sbi, &u, off, inode->inode_isize);
+	ret = erofs_dev_write(sbi, &u, off, inode->inode_isize);
 	if (ret)
 		return ret;
 	off += inode->inode_isize;
@@ -595,7 +595,7 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (IS_ERR(xattrs))
 			return PTR_ERR(xattrs);
 
-		ret = dev_write(sbi, xattrs, off, inode->xattr_isize);
+		ret = erofs_dev_write(sbi, xattrs, off, inode->xattr_isize);
 		free(xattrs);
 		if (ret)
 			return ret;
@@ -611,7 +611,7 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		} else {
 			/* write compression metadata */
 			off = roundup(off, 8);
-			ret = dev_write(sbi, inode->compressmeta, off,
+			ret = erofs_dev_write(sbi, inode->compressmeta, off,
 					inode->extent_isize);
 			if (ret)
 				return ret;
@@ -733,7 +733,7 @@ static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = dev_write(inode->sbi, inode->idata, off, inode->idata_size);
+	ret = erofs_dev_write(inode->sbi, inode->idata, off, inode->idata_size);
 	if (ret)
 		return ret;
 
@@ -804,13 +804,13 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 			/* pad 0'ed data for the other cases */
 			zero_pos = pos + inode->idata_size;
 		}
-		ret = dev_write(sbi, inode->idata, pos, inode->idata_size);
+		ret = erofs_dev_write(sbi, inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
 
 		DBG_BUGON(inode->idata_size > erofs_blksiz(sbi));
 		if (inode->idata_size < erofs_blksiz(sbi)) {
-			ret = dev_fillzero(sbi, zero_pos,
+			ret = erofs_dev_fillzero(sbi, zero_pos,
 					   erofs_blksiz(sbi) - inode->idata_size,
 					   false);
 			if (ret)
diff --git a/lib/io.c b/lib/io.c
index bfae73a..2cd034d 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -13,7 +13,7 @@
 #include <stdlib.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
-#include "erofs/io.h"
+#include "erofs/internal.h"
 #ifdef HAVE_LINUX_FS_H
 #include <linux/fs.h>
 #endif
@@ -26,7 +26,140 @@
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
-static int dev_get_blkdev_size(int fd, u64 *bytes)
+int erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
+		    u64 pos, size_t len)
+{
+	ssize_t ret;
+
+	if (unlikely(cfg.c_dry_run))
+		return 0;
+
+	if (vf->ops)
+		return vf->ops->pwrite(vf, buf, pos, len);
+
+	pos += vf->offset;
+	do {
+#ifdef HAVE_PWRITE64
+		ret = pwrite64(vf->fd, buf, len, (off64_t)pos);
+#else
+		ret = pwrite(vf->fd, buf, len, (off_t)pos);
+#endif
+		if (ret <= 0) {
+			erofs_err("failed to write: %s", strerror(errno));
+			return -errno;
+		}
+		len -= ret;
+		buf += ret;
+		pos += ret;
+	} while (len);
+
+	return 0;
+}
+
+int erofs_io_fsync(struct erofs_vfile *vf)
+{
+	int ret;
+
+	if (unlikely(cfg.c_dry_run))
+		return 0;
+
+	if (vf->ops)
+		return vf->ops->fsync(vf);
+
+	ret = fsync(vf->fd);
+	if (ret) {
+		erofs_err("failed to fsync(!): %s", strerror(errno));
+		return -errno;
+	}
+	return 0;
+}
+
+int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
+		       size_t len, bool zeroout)
+{
+	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
+	int ret;
+
+	if (cfg.c_dry_run)
+		return 0;
+
+	if (vf->ops)
+		return vf->ops->fallocate(vf, offset, len, zeroout);
+
+#if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
+	if (!zeroout && fallocate(vf->fd, FALLOC_FL_PUNCH_HOLE |
+		    FALLOC_FL_KEEP_SIZE, offset + vf->offset, len) >= 0)
+		return 0;
+#endif
+	while (len > EROFS_MAX_BLOCK_SIZE) {
+		ret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
+		if (ret)
+			return ret;
+		len -= EROFS_MAX_BLOCK_SIZE;
+		offset += EROFS_MAX_BLOCK_SIZE;
+	}
+	return erofs_io_pwrite(vf, zero, offset, len);
+}
+
+int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
+{
+	int ret;
+	struct stat st;
+
+	if (unlikely(cfg.c_dry_run))
+		return 0;
+
+	if (vf->ops)
+		return vf->ops->ftruncate(vf, length);
+
+	ret = fstat(vf->fd, &st);
+	if (ret) {
+		erofs_err("failed to fstat: %s", strerror(errno));
+		return -errno;
+	}
+	length += vf->offset;
+	if (S_ISBLK(st.st_mode) || st.st_size == length)
+		return 0;
+	return ftruncate(vf->fd, length);
+}
+
+int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
+{
+	ssize_t ret;
+
+	if (unlikely(cfg.c_dry_run))
+		return 0;
+
+	if (vf->ops)
+		return vf->ops->pread(vf, buf, pos, len);
+
+	pos += vf->offset;
+	do {
+#ifdef HAVE_PREAD64
+		ret = pread64(vf->fd, buf, len, (off64_t)pos);
+#else
+		ret = pread(vf->fd, buf, len, (off_t)pos);
+#endif
+		if (ret <= 0) {
+			if (!ret) {
+				erofs_info("reach EOF of device");
+				memset(buf, 0, len);
+				return 0;
+			}
+			if (errno != EINTR) {
+				erofs_err("failed to read: %s", strerror(errno));
+				return -errno;
+			}
+			ret = 0;
+		}
+		pos += ret;
+		len -= ret;
+		buf += ret;
+	} while (len);
+	return 0;
+}
+
+static int erofs_get_bdev_size(int fd, u64 *bytes)
 {
 	errno = ENOTSUP;
 #ifdef BLKGETSIZE64
@@ -46,17 +179,25 @@ static int dev_get_blkdev_size(int fd, u64 *bytes)
 	return -errno;
 }
 
-void dev_close(struct erofs_sb_info *sbi)
+#if defined(__linux__) && !defined(BLKDISCARD)
+#define BLKDISCARD	_IO(0x12, 119)
+#endif
+
+static int erofs_bdev_discard(int fd, u64 block, u64 count)
 {
-	close(sbi->devfd);
-	free(sbi->devname);
-	sbi->devname = NULL;
-	sbi->devfd   = -1;
-	sbi->devsz   = 0;
+#ifdef BLKDISCARD
+	u64 range[2] = { block, count };
+
+	return ioctl(fd, BLKDISCARD, &range);
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
-int dev_open(struct erofs_sb_info *sbi, const char *dev)
+int erofs_dev_open(struct erofs_sb_info *sbi, const char *dev, int flags)
 {
+	bool ro = (flags & O_ACCMODE) == O_RDONLY;
+	bool truncate = flags & O_TRUNC;
 	struct stat st;
 	int fd, ret;
 
@@ -65,28 +206,36 @@ int dev_open(struct erofs_sb_info *sbi, const char *dev)
 
 repeat:
 #endif
-	fd = open(dev, O_RDWR | O_CREAT | O_BINARY, 0644);
+	fd = open(dev, (ro ? O_RDONLY : O_RDWR | O_CREAT) | O_BINARY, 0644);
 	if (fd < 0) {
-		erofs_err("failed to open(%s).", dev);
+		erofs_err("failed to open %s: %s", dev, strerror(errno));
 		return -errno;
 	}
 
+	if (ro || !truncate)
+		goto out;
+
 	ret = fstat(fd, &st);
 	if (ret) {
-		erofs_err("failed to fstat(%s).", dev);
+		erofs_err("failed to fstat(%s): %s", dev, strerror(errno));
 		close(fd);
 		return -errno;
 	}
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFBLK:
-		ret = dev_get_blkdev_size(fd, &sbi->devsz);
+		ret = erofs_get_bdev_size(fd, &sbi->devsz);
 		if (ret) {
-			erofs_err("failed to get block device size(%s).", dev);
+			erofs_err("failed to get block device size(%s): %s",
+				  dev, strerror(errno));
 			close(fd);
 			return ret;
 		}
 		sbi->devsz = round_down(sbi->devsz, erofs_blksiz(sbi));
+		ret = erofs_bdev_discard(fd, 0, sbi->devsz);
+		if (ret)
+			erofs_err("failed to erase block device(%s): %s",
+				  dev, erofs_strerror(ret));
 		break;
 	case S_IFREG:
 		if (st.st_size) {
@@ -117,8 +266,6 @@ repeat:
 				return -errno;
 			}
 		}
-		/* INT64_MAX is the limit of kernel vfs */
-		sbi->devsz = INT64_MAX;
 		sbi->devblksz = st.st_blksize;
 		break;
 	default:
@@ -127,18 +274,26 @@ repeat:
 		return -EINVAL;
 	}
 
+out:
 	sbi->devname = strdup(dev);
 	if (!sbi->devname) {
 		close(fd);
 		return -ENOMEM;
 	}
-	sbi->devfd = fd;
-
+	sbi->bdev.fd = fd;
 	erofs_info("successfully to open %s", dev);
 	return 0;
 }
 
-void blob_closeall(struct erofs_sb_info *sbi)
+void erofs_dev_close(struct erofs_sb_info *sbi)
+{
+	close(sbi->bdev.fd);
+	free(sbi->devname);
+	sbi->devname = NULL;
+	sbi->bdev.fd = -1;
+}
+
+void erofs_blob_closeall(struct erofs_sb_info *sbi)
 {
 	unsigned int i;
 
@@ -147,7 +302,7 @@ void blob_closeall(struct erofs_sb_info *sbi)
 	sbi->nblobs = 0;
 }
 
-int blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
+int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 {
 	int fd = open(dev, O_RDONLY | O_BINARY);
 
@@ -162,182 +317,18 @@ int blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 	return 0;
 }
 
-/* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
-int dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
+int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
+		   void *buf, u64 offset, size_t len)
 {
-	int fd = open(dev, O_RDONLY | O_BINARY);
-
-	if (fd < 0) {
-		erofs_err("failed to open(%s).", dev);
-		return -errno;
-	}
-
-	sbi->devname = strdup(dev);
-	if (!sbi->devname) {
-		close(fd);
-		return -ENOMEM;
-	}
-	sbi->devfd = fd;
-	sbi->devsz = INT64_MAX;
-	return 0;
-}
-
-int dev_write(struct erofs_sb_info *sbi, const void *buf, u64 offset, size_t len)
-{
-	int ret;
-
-	if (cfg.c_dry_run)
-		return 0;
-
-	if (!buf) {
-		erofs_err("buf is NULL");
-		return -EINVAL;
-	}
-
-	offset += sbi->diskoffset;
-	if (offset >= sbi->devsz || len > sbi->devsz ||
-	    offset > sbi->devsz - len) {
-		erofs_err("Write posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
-			  offset, len, sbi->devsz);
-		return -EINVAL;
-	}
-
-#ifdef HAVE_PWRITE64
-	ret = pwrite64(sbi->devfd, buf, len, (off64_t)offset);
-#else
-	ret = pwrite(sbi->devfd, buf, len, (off_t)offset);
-#endif
-	if (ret != (int)len) {
-		if (ret < 0) {
-			erofs_err("Failed to write data into device - %s:[%" PRIu64 ", %zd].",
-				  sbi->devname, offset, len);
-			return -errno;
-		}
-
-		erofs_err("Writing data into device - %s:[%" PRIu64 ", %zd] - was truncated.",
-			  sbi->devname, offset, len);
-		return -ERANGE;
-	}
-	return 0;
-}
-
-int dev_fillzero(struct erofs_sb_info *sbi, u64 offset, size_t len, bool padding)
-{
-	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
-	int ret;
-
-	if (cfg.c_dry_run)
-		return 0;
-
-#if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
-	if (!padding && fallocate(sbi->devfd, FALLOC_FL_PUNCH_HOLE |
-	    FALLOC_FL_KEEP_SIZE, offset + sbi->diskoffset, len) >= 0)
-		return 0;
-#endif
-	while (len > erofs_blksiz(sbi)) {
-		ret = dev_write(sbi, zero, offset, erofs_blksiz(sbi));
-		if (ret)
-			return ret;
-		len -= erofs_blksiz(sbi);
-		offset += erofs_blksiz(sbi);
-	}
-	return dev_write(sbi, zero, offset, len);
-}
-
-int dev_fsync(struct erofs_sb_info *sbi)
-{
-	int ret;
-
-	ret = fsync(sbi->devfd);
-	if (ret) {
-		erofs_err("Could not fsync device!!!");
-		return -EIO;
-	}
-	return 0;
-}
-
-int dev_resize(struct erofs_sb_info *sbi, erofs_blk_t blocks)
-{
-	int ret;
-	struct stat st;
-	u64 length;
-
-	if (cfg.c_dry_run || sbi->devsz != INT64_MAX)
-		return 0;
-
-	ret = fstat(sbi->devfd, &st);
-	if (ret) {
-		erofs_err("failed to fstat.");
-		return -errno;
-	}
-
-	length = (u64)blocks * erofs_blksiz(sbi);
-	length += sbi->diskoffset;
-	if (st.st_size == length)
-		return 0;
-	if (st.st_size > length)
-		return ftruncate(sbi->devfd, length);
-
-	length = length - st.st_size;
-#if defined(HAVE_FALLOCATE)
-	if (fallocate(sbi->devfd, 0, st.st_size, length) >= 0)
-		return 0;
-#endif
-	return dev_fillzero(sbi, st.st_size - sbi->diskoffset,
-			    length, true);
-}
-
-int dev_read(struct erofs_sb_info *sbi, int device_id,
-	     void *buf, u64 offset, size_t len)
-{
-	int read_count, fd;
-
-	if (cfg.c_dry_run)
-		return 0;
-
-	if (!buf) {
-		erofs_err("buf is NULL");
-		return -EINVAL;
-	}
-
-	if (!device_id) {
-		fd = sbi->devfd;
-		offset += sbi->diskoffset;
-	} else {
-		if (device_id > sbi->nblobs) {
-			erofs_err("invalid device id %d", device_id);
-			return -ENODEV;
-		}
-		fd = sbi->blobfd[device_id - 1];
-	}
-
-	while (len > 0) {
-#ifdef HAVE_PREAD64
-		read_count = pread64(fd, buf, len, (off64_t)offset);
-#else
-		read_count = pread(fd, buf, len, (off_t)offset);
-#endif
-		if (read_count < 1) {
-			if (!read_count) {
-				erofs_info("Reach EOF of device - %s:[%" PRIu64 ", %zd].",
-					   sbi->devname, offset, len);
-				memset(buf, 0, len);
-				return 0;
-			} else if (errno != EINTR) {
-				erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
-					  sbi->devname, offset, len);
-				return -errno;
-			}
-		}
-		offset += read_count;
-		len -= read_count;
-		buf += read_count;
-	}
-	return 0;
+	if (device_id)
+		return erofs_io_pread(&((struct erofs_vfile) {
+				.fd = sbi->blobfd[device_id - 1],
+			}), buf, offset, len);
+	return erofs_io_pread(&sbi->bdev, buf, offset, len);
 }
 
-static ssize_t __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
-				       int fd_out, erofs_off_t *off_out,
+static ssize_t __erofs_copy_file_range(int fd_in, u64 *off_in,
+				       int fd_out, u64 *off_out,
 				       size_t length)
 {
 	size_t copied = 0;
@@ -408,8 +399,7 @@ static ssize_t __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 	return copied;
 }
 
-ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
-			      int fd_out, erofs_off_t *off_out,
+ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
 			      size_t length)
 {
 #ifdef HAVE_COPY_FILE_RANGE
diff --git a/lib/namei.c b/lib/namei.c
index 294d7a3..6f35ee6 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -12,7 +12,7 @@
 #include <sys/sysmacros.h>
 #endif
 #include "erofs/print.h"
-#include "erofs/io.h"
+#include "erofs/internal.h"
 
 static dev_t erofs_new_decode_dev(u32 dev)
 {
@@ -34,7 +34,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	DBG_BUGON(!sbi);
 	inode_loc = erofs_iloc(vi);
 
-	ret = dev_read(sbi, 0, buf, inode_loc, sizeof(*dic));
+	ret = erofs_dev_read(sbi, 0, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
 		return -EIO;
 
@@ -51,7 +51,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
-		ret = dev_read(sbi, 0, buf + sizeof(*dic),
+		ret = erofs_dev_read(sbi, 0, buf + sizeof(*dic),
 			       inode_loc + sizeof(*dic),
 			       sizeof(*die) - sizeof(*dic));
 		if (ret < 0)
diff --git a/lib/super.c b/lib/super.c
index f952f7e..674ee1a 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -56,7 +56,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 		struct erofs_deviceslot dis;
 		int ret;
 
-		ret = dev_read(sbi, 0, &dis, pos, sizeof(dis));
+		ret = erofs_dev_read(sbi, 0, &dis, pos, sizeof(dis));
 		if (ret < 0) {
 			free(sbi->devs);
 			sbi->devs = NULL;
@@ -79,7 +79,7 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	int ret;
 
 	sbi->blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
-	ret = blk_read(sbi, 0, data, 0, erofs_blknr(sbi, sizeof(data)));
+	ret = erofs_blk_read(sbi, 0, data, 0, erofs_blknr(sbi, sizeof(data)));
 	if (ret < 0) {
 		erofs_err("cannot read erofs superblock: %d", ret);
 		return -EIO;
diff --git a/lib/xattr.c b/lib/xattr.c
index 427933f..e7417e1 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -931,7 +931,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	shared_xattrs_list = sorted_n[0];
 	free(sorted_n);
 	bh->op = &erofs_drop_directly_bhops;
-	ret = dev_write(sbi, buf, erofs_btell(bh, false), shared_xattrs_size);
+	ret = erofs_dev_write(sbi, buf, erofs_btell(bh, false), shared_xattrs_size);
 	free(buf);
 	erofs_bdrop(bh, false);
 out:
@@ -1054,7 +1054,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	it.blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + vi->inode_isize);
 	it.ofs = erofs_blkoff(sbi, erofs_iloc(vi) + vi->inode_isize);
 
-	ret = blk_read(sbi, 0, it.page, it.blkaddr, 1);
+	ret = erofs_blk_read(sbi, 0, it.page, it.blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -1074,7 +1074,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 			/* cannot be unaligned */
 			DBG_BUGON(it.ofs != erofs_blksiz(sbi));
 
-			ret = blk_read(sbi, 0, it.page, ++it.blkaddr, 1);
+			ret = erofs_blk_read(sbi, 0, it.page, ++it.blkaddr, 1);
 			if (ret < 0) {
 				free(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -1120,7 +1120,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 
 	it->blkaddr += erofs_blknr(sbi, it->ofs);
 
-	ret = blk_read(sbi, 0, it->page, it->blkaddr, 1);
+	ret = erofs_blk_read(sbi, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -1147,7 +1147,7 @@ static int inline_xattr_iter_pre(struct xattr_iter *it,
 	it->blkaddr = erofs_blknr(sbi, erofs_iloc(vi) + inline_xattr_ofs);
 	it->ofs = erofs_blkoff(sbi, erofs_iloc(vi) + inline_xattr_ofs);
 
-	ret = blk_read(sbi, 0, it->page, it->blkaddr, 1);
+	ret = erofs_blk_read(sbi, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -1374,7 +1374,7 @@ static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
 
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
+			ret = erofs_blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
@@ -1530,7 +1530,7 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
+			ret = erofs_blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 2ec8505..a5c5b00 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -7,7 +7,7 @@
  * Created by Gao Xiang <xiang@kernel.org>
  * Modified by Huang Jianan <huangjianan@oppo.com>
  */
-#include "erofs/io.h"
+#include "erofs/internal.h"
 #include "erofs/print.h"
 
 static int z_erofs_do_map_blocks(struct erofs_inode *vi,
@@ -43,7 +43,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return 0;
 
 	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
-	ret = dev_read(sbi, 0, buf, pos, sizeof(buf));
+	ret = erofs_dev_read(sbi, 0, buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -133,7 +133,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	if (map->index == eblk)
 		return 0;
 
-	ret = blk_read(m->inode->sbi, 0, mpage, eblk, 1);
+	ret = erofs_blk_read(m->inode->sbi, 0, mpage, eblk, 1);
 	if (ret < 0)
 		return -EIO;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 12321ed..eeffebd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -501,7 +501,7 @@ static void erofs_rebuild_cleanup(void)
 	list_for_each_entry_safe(src, n, &rebuild_src_list, list) {
 		list_del(&src->list);
 		erofs_put_super(src);
-		dev_close(src);
+		erofs_dev_close(src);
 		free(src);
 	}
 	rebuild_src_count = 0;
@@ -739,7 +739,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				cfg.c_ovlfs_strip = false;
 			break;
 		case 517:
-			sbi.diskoffset = strtoull(optarg, &endptr, 0);
+			sbi.bdev.offset = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid disk offset %s", optarg);
 				return -EINVAL;
@@ -882,7 +882,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					return -ENOMEM;
 				}
 
-				err = dev_open_ro(src, srcpath);
+				err = erofs_dev_open(src, srcpath, O_RDONLY);
 				if (err) {
 					free(src);
 					erofs_rebuild_cleanup();
@@ -982,7 +982,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	}
 	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
 
-	ret = dev_write(&sbi, buf, erofs_btell(bh, false), EROFS_SUPER_END);
+	ret = erofs_dev_write(&sbi, buf, erofs_btell(bh, false), EROFS_SUPER_END);
 	free(buf);
 	erofs_bdrop(bh, false);
 	return ret;
@@ -996,7 +996,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	unsigned int len;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(&sbi, 0, buf, 0, erofs_blknr(&sbi, EROFS_SUPER_END) + 1);
+	ret = erofs_blk_read(&sbi, 0, buf, 0, erofs_blknr(&sbi, EROFS_SUPER_END) + 1);
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
@@ -1026,7 +1026,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(crc);
 
-	ret = blk_write(&sbi, buf, 0, 1);
+	ret = erofs_blk_write(&sbi, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to write checksummed superblock: %s",
 			  erofs_strerror(ret));
@@ -1221,7 +1221,7 @@ int main(int argc, char **argv)
 		sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = dev_open(&sbi, cfg.c_img_path);
+	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDWR | O_TRUNC);
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
@@ -1452,7 +1452,7 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
-	err = dev_resize(&sbi, nblocks);
+	err = erofs_dev_resize(&sbi, nblocks);
 
 	if (!err && erofs_sb_has_sb_chksum(&sbi))
 		err = erofs_mkfs_superblock_csum_set();
@@ -1460,7 +1460,7 @@ exit:
 	z_erofs_compress_exit();
 	z_erofs_dedupe_exit();
 	erofs_blocklist_close();
-	dev_close(&sbi);
+	erofs_dev_close(&sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
-- 
2.39.3

