Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 804748FB1D6
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 14:10:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WA67/gtX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VtqDq2vRnz3cX3
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 22:10:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WA67/gtX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VtqDg27CMz3cP3
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jun 2024 22:10:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717503037; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lM0GGN4oT07KaH8XV0VG16QR2pXWA51+hKt6mDEU7WU=;
	b=WA67/gtXAFdnF0qFs2PpZnoym+yX+CvyRLCLNbdpXi2tVcO0UShfgmRn6JKViiXOg8YA1sni/j0QIgKUPc+T/r7p0S2XXeqYKro+KI8595lwJUlAKRfOAKSlkQxytnEGzCy55PliyIydI4mPNPilqw/VjBMxVp7P68Wf3r8RX6o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7r6ScC_1717503035;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W7r6ScC_1717503035)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 20:10:36 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: introduce the I/O manager
Date: Tue,  4 Jun 2024 20:10:29 +0800
Message-Id: <20240604121029.4030290-1-hongzhen@linux.alibaba.com>
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

Introduce the I/O manager to provide a more flexible way to specify
the virtual storage.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Updated the handling of `.dev_close` being unimplemented in `erofs_dev_close` and so on.
v1: https://lore.kernel.org/all/20240604093556.3883585-1-hongzhen@linux.alibaba.com/
---
 dump/main.c              |   8 +--
 fsck/main.c              |  14 ++---
 fuse/main.c              |   8 +--
 include/erofs/internal.h |   1 +
 include/erofs/io.h       |  45 +++++++++-----
 lib/blobchunk.c          |   4 +-
 lib/cache.c              |   2 +-
 lib/compress.c           |  14 ++---
 lib/data.c               |  10 ++--
 lib/inode.c              |  18 +++---
 lib/io.c                 | 126 ++++++++++++++++++++++++++++++++++-----
 lib/namei.c              |   4 +-
 lib/super.c              |   4 +-
 lib/tar.c                |   4 +-
 lib/xattr.c              |  14 ++---
 lib/zmap.c               |   4 +-
 mkfs/main.c              |  16 ++---
 17 files changed, 206 insertions(+), 90 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index dd2c620..82542a0 100644
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
@@ -685,7 +685,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = dev_open_ro(&sbi, cfg.c_img_path);
+	err = erofs_dev_open_ro(&sbi, cfg.c_img_path);
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
index 4dcb49d..be400ff 100644
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
+	err = erofs_dev_open_ro(&sbi, cfg.c_img_path);
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
index 32f59a3..f0a00a1 100644
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
@@ -677,7 +677,7 @@ int main(int argc, char *argv[])
 		cfg.c_dbg_lvl = EROFS_DBG;
 
 	sbi.diskoffset = fusecfg.offset;
-	ret = dev_open_ro(&sbi, fusecfg.disk);
+	ret = erofs_dev_open_ro(&sbi, fusecfg.disk);
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
index 2337bb5..e8a9e3a 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -130,6 +130,7 @@ struct erofs_sb_info {
 	pthread_t dfops_worker;
 	struct erofs_mkfs_dfops *mkfs_dfops;
 #endif
+	struct erofs_io_manager *io_manager;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 4db5716..9b38149 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -22,38 +22,55 @@ extern "C"
 #define O_BINARY	0
 #endif
 
-void blob_closeall(struct erofs_sb_info *sbi);
-int blob_open_ro(struct erofs_sb_info *sbi, const char *dev);
-int dev_open(struct erofs_sb_info *sbi, const char *devname);
-int dev_open_ro(struct erofs_sb_info *sbi, const char *dev);
-void dev_close(struct erofs_sb_info *sbi);
-int dev_write(struct erofs_sb_info *sbi, const void *buf,
+void erofs_blob_closeall(struct erofs_sb_info *sbi);
+int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev);
+int erofs_dev_open(struct erofs_sb_info *sbi, const char *devname);
+int erofs_dev_open_ro(struct erofs_sb_info *sbi, const char *dev);
+void erofs_dev_close(struct erofs_sb_info *sbi);
+int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
 	      u64 offset, size_t len);
-int dev_read(struct erofs_sb_info *sbi, int device_id,
+int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 	     void *buf, u64 offset, size_t len);
-int dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
+int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
 		 size_t len, bool padding);
-int dev_fsync(struct erofs_sb_info *sbi);
-int dev_resize(struct erofs_sb_info *sbi, erofs_blk_t nblocks);
+int erofs_dev_fsync(struct erofs_sb_info *sbi);
+int erofs_dev_resize(struct erofs_sb_info *sbi, erofs_blk_t nblocks);
 
 ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 			      int fd_out, erofs_off_t *off_out,
 			      size_t length);
 
-static inline int blk_write(struct erofs_sb_info *sbi, const void *buf,
+static inline int erofs_blk_write(struct erofs_sb_info *sbi, const void *buf,
 			    erofs_blk_t blkaddr, u32 nblocks)
 {
-	return dev_write(sbi, buf, erofs_pos(sbi, blkaddr),
+	return erofs_dev_write(sbi, buf, erofs_pos(sbi, blkaddr),
 			 erofs_pos(sbi, nblocks));
 }
 
-static inline int blk_read(struct erofs_sb_info *sbi, int device_id, void *buf,
+static inline int erofs_blk_read(struct erofs_sb_info *sbi, int device_id, void *buf,
 			   erofs_blk_t start, u32 nblocks)
 {
-	return dev_read(sbi, device_id, buf, erofs_pos(sbi, start),
+	return erofs_dev_read(sbi, device_id, buf, erofs_pos(sbi, start),
 			erofs_pos(sbi, nblocks));
 }
 
+struct erofs_io_manager {
+	int (*dev_open)(struct erofs_sb_info *sbi, const char *devname);
+	int (*dev_open_ro)(struct erofs_sb_info *sbi, const char *dev);
+	int (*blob_open_ro)(struct erofs_sb_info *sbi, const char *dev);
+	int (*dev_read)(struct erofs_sb_info *sbi, int device_id,
+		void *buf, u64 offset, size_t len);
+	int (*dev_write)(struct erofs_sb_info *sbi, const void *buf,
+		u64 offset, size_t len);
+	int (*dev_fillzero)(struct erofs_sb_info *sbi, u64 offset,
+		size_t len, bool padding);
+	int (*dev_fsync)(struct erofs_sb_info *sbi);
+	int (*dev_resize)(struct erofs_sb_info *sbi, erofs_blk_t nblocks);
+	void (*dev_close)(struct erofs_sb_info *sbi);
+	void (*blob_closeall)(struct erofs_sb_info *sbi);
+	void *private_data;
+};
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 9d102a4..22a366a 100644
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
diff --git a/lib/cache.c b/lib/cache.c
index 0a88061..faf6d4b 100644
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
index a87053f..94b75e2 100644
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
 	len = le16_to_cpu(*(__le16 *)&data[erofs_blkoff(sbi, *offset)]);
@@ -433,7 +433,7 @@ static void *erofs_read_metadata_bdi(struct erofs_sb_info *sbi,
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(int, erofs_blksiz(sbi) - erofs_blkoff(sbi, *offset),
 			    len - i);
-		ret = blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
+		ret = erofs_blk_read(sbi, 0, data, erofs_blknr(sbi, *offset), 1);
 		if (ret) {
 			free(buffer);
 			return ERR_PTR(ret);
diff --git a/lib/inode.c b/lib/inode.c
index bdeb355..1be9acc 100644
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
@@ -592,7 +592,7 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		BUG_ON(1);
 	}
 
-	ret = dev_write(sbi, &u, off, inode->inode_isize);
+	ret = erofs_dev_write(sbi, &u, off, inode->inode_isize);
 	if (ret)
 		return ret;
 	off += inode->inode_isize;
@@ -603,7 +603,7 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (IS_ERR(xattrs))
 			return PTR_ERR(xattrs);
 
-		ret = dev_write(sbi, xattrs, off, inode->xattr_isize);
+		ret = erofs_dev_write(sbi, xattrs, off, inode->xattr_isize);
 		free(xattrs);
 		if (ret)
 			return ret;
@@ -619,7 +619,7 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		} else {
 			/* write compression metadata */
 			off = roundup(off, 8);
-			ret = dev_write(sbi, inode->compressmeta, off,
+			ret = erofs_dev_write(sbi, inode->compressmeta, off,
 					inode->extent_isize);
 			if (ret)
 				return ret;
@@ -741,7 +741,7 @@ static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = dev_write(inode->sbi, inode->idata, off, inode->idata_size);
+	ret = erofs_dev_write(inode->sbi, inode->idata, off, inode->idata_size);
 	if (ret)
 		return ret;
 
@@ -812,13 +812,13 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
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
index bfae73a..6c579b0 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -46,7 +46,7 @@ static int dev_get_blkdev_size(int fd, u64 *bytes)
 	return -errno;
 }
 
-void dev_close(struct erofs_sb_info *sbi)
+static void builtin_dev_close(struct erofs_sb_info *sbi)
 {
 	close(sbi->devfd);
 	free(sbi->devname);
@@ -55,7 +55,7 @@ void dev_close(struct erofs_sb_info *sbi)
 	sbi->devsz   = 0;
 }
 
-int dev_open(struct erofs_sb_info *sbi, const char *dev)
+static int builtin_dev_open(struct erofs_sb_info *sbi, const char *dev)
 {
 	struct stat st;
 	int fd, ret;
@@ -138,7 +138,7 @@ repeat:
 	return 0;
 }
 
-void blob_closeall(struct erofs_sb_info *sbi)
+static void builtin_blob_closeall(struct erofs_sb_info *sbi)
 {
 	unsigned int i;
 
@@ -147,7 +147,7 @@ void blob_closeall(struct erofs_sb_info *sbi)
 	sbi->nblobs = 0;
 }
 
-int blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
+static int builtin_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 {
 	int fd = open(dev, O_RDONLY | O_BINARY);
 
@@ -163,7 +163,7 @@ int blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 }
 
 /* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
-int dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
+static int builtin_dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
 {
 	int fd = open(dev, O_RDONLY | O_BINARY);
 
@@ -182,7 +182,7 @@ int dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
 	return 0;
 }
 
-int dev_write(struct erofs_sb_info *sbi, const void *buf, u64 offset, size_t len)
+static int builtin_dev_write(struct erofs_sb_info *sbi, const void *buf, u64 offset, size_t len)
 {
 	int ret;
 
@@ -221,7 +221,7 @@ int dev_write(struct erofs_sb_info *sbi, const void *buf, u64 offset, size_t len
 	return 0;
 }
 
-int dev_fillzero(struct erofs_sb_info *sbi, u64 offset, size_t len, bool padding)
+static int builtin_dev_fillzero(struct erofs_sb_info *sbi, u64 offset, size_t len, bool padding)
 {
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	int ret;
@@ -235,16 +235,16 @@ int dev_fillzero(struct erofs_sb_info *sbi, u64 offset, size_t len, bool padding
 		return 0;
 #endif
 	while (len > erofs_blksiz(sbi)) {
-		ret = dev_write(sbi, zero, offset, erofs_blksiz(sbi));
+		ret = erofs_dev_write(sbi, zero, offset, erofs_blksiz(sbi));
 		if (ret)
 			return ret;
 		len -= erofs_blksiz(sbi);
 		offset += erofs_blksiz(sbi);
 	}
-	return dev_write(sbi, zero, offset, len);
+	return erofs_dev_write(sbi, zero, offset, len);
 }
 
-int dev_fsync(struct erofs_sb_info *sbi)
+static int builtin_dev_fsync(struct erofs_sb_info *sbi)
 {
 	int ret;
 
@@ -256,7 +256,7 @@ int dev_fsync(struct erofs_sb_info *sbi)
 	return 0;
 }
 
-int dev_resize(struct erofs_sb_info *sbi, erofs_blk_t blocks)
+static int builtin_dev_resize(struct erofs_sb_info *sbi, erofs_blk_t blocks)
 {
 	int ret;
 	struct stat st;
@@ -283,12 +283,12 @@ int dev_resize(struct erofs_sb_info *sbi, erofs_blk_t blocks)
 	if (fallocate(sbi->devfd, 0, st.st_size, length) >= 0)
 		return 0;
 #endif
-	return dev_fillzero(sbi, st.st_size - sbi->diskoffset,
+	return erofs_dev_fillzero(sbi, st.st_size - sbi->diskoffset,
 			    length, true);
 }
 
-int dev_read(struct erofs_sb_info *sbi, int device_id,
-	     void *buf, u64 offset, size_t len)
+static int builtin_dev_read(struct erofs_sb_info *sbi, int device_id,
+		    void *buf, u64 offset, size_t len)
 {
 	int read_count, fd;
 
@@ -430,3 +430,101 @@ out:
 #endif
 	return __erofs_copy_file_range(fd_in, off_in, fd_out, off_out, length);
 }
+
+void erofs_blob_closeall(struct erofs_sb_info *sbi)
+{
+	if (sbi->io_manager && !sbi->io_manager->blob_closeall)
+		return;
+
+	if (sbi->io_manager)
+		sbi->io_manager->blob_closeall(sbi);
+	else
+		builtin_blob_closeall(sbi);
+}
+
+int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
+{
+	if (sbi->io_manager && !sbi->io_manager->blob_open_ro)
+		return -EOPNOTSUPP;
+
+	return sbi->io_manager ? sbi->io_manager->blob_open_ro(sbi, dev) :
+		builtin_blob_open_ro(sbi, dev);
+}
+
+int erofs_dev_open(struct erofs_sb_info *sbi, const char *devname)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_open)
+		return -EOPNOTSUPP;
+
+	return sbi->io_manager ? sbi->io_manager->dev_open(sbi, devname) :
+		builtin_dev_open(sbi, devname);
+}
+
+int erofs_dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_open_ro)
+		return -EOPNOTSUPP;
+
+	return sbi->io_manager ?  sbi->io_manager->dev_open_ro(sbi, dev) :
+		builtin_dev_open_ro(sbi, dev);
+}
+
+void erofs_dev_close(struct erofs_sb_info *sbi)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_close)
+		return;
+
+	if (sbi->io_manager)
+		sbi->io_manager->dev_close(sbi);
+	else
+		builtin_dev_close(sbi);
+}
+
+int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
+		    u64 offset, size_t len)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_write)
+		return -EOPNOTSUPP;
+
+	return sbi->io_manager ? sbi->io_manager->dev_write(sbi, buf, offset, len) :
+		builtin_dev_write(sbi, buf, offset, len);
+}
+
+int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
+		   void *buf, u64 offset, size_t len)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_read)
+		return -EOPNOTSUPP;
+
+	return sbi->io_manager ? sbi->io_manager->dev_read(sbi, device_id, buf, offset, len) :
+		builtin_dev_read(sbi, device_id, buf, offset, len);
+}
+
+int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
+		       size_t len, bool padding)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_fillzero)
+		return -EOPNOTSUPP;
+
+	if (sbi->io_manager && sbi->io_manager->dev_fillzero)
+		return sbi->io_manager->dev_fillzero(sbi, offset, len, padding);
+	return builtin_dev_fillzero(sbi, offset, len, padding);
+}
+
+int erofs_dev_fsync(struct erofs_sb_info *sbi)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_fsync)
+		return 0;
+
+	return sbi->io_manager ? sbi->io_manager->dev_fsync(sbi) :
+		builtin_dev_fsync(sbi);
+}
+
+int erofs_dev_resize(struct erofs_sb_info *sbi, erofs_blk_t nblocks)
+{
+	if (sbi->io_manager && !sbi->io_manager->dev_resize)
+		return 0;
+
+	return sbi->io_manager ? sbi->io_manager->dev_resize(sbi, nblocks) :
+		builtin_dev_resize(sbi, nblocks);
+}
diff --git a/lib/namei.c b/lib/namei.c
index 294d7a3..bdc78c5 100644
--- a/lib/namei.c
+++ b/lib/namei.c
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
diff --git a/lib/tar.c b/lib/tar.c
index ac2484e..f12dac2 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -1099,7 +1099,7 @@ int tarerofs_append_tree(struct erofs_inode *root, struct erofs_tarfile *tar)
 	struct erofs_sb_info base = {};
 	struct bitmap datablk;
 
-	ret = dev_open_ro(&base, tar->base);
+	ret = erofs_dev_open_ro(&base, tar->base);
 	if (ret)
 		return ret;
 	base.dev = 0;
@@ -1110,6 +1110,6 @@ int tarerofs_append_tree(struct erofs_inode *root, struct erofs_tarfile *tar)
 
 	ret = tarerofs_alloc_data_block(root, &datablk);
 out:
-	dev_close(&base);
+	erofs_dev_close(&base);
 	return ret;
 }
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
index 2ec8505..d75174e 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
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
index 1cf2664..60b3cc4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -504,7 +504,7 @@ static void erofs_rebuild_cleanup(void)
 	list_for_each_entry_safe(src, n, &rebuild_src_list, list) {
 		list_del(&src->list);
 		erofs_put_super(src);
-		dev_close(src);
+		erofs_dev_close(src);
 		free(src);
 	}
 	rebuild_src_count = 0;
@@ -901,7 +901,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					return -ENOMEM;
 				}
 
-				err = dev_open_ro(src, srcpath);
+				err = erofs_dev_open_ro(src, srcpath);
 				if (err) {
 					free(src);
 					erofs_rebuild_cleanup();
@@ -1001,7 +1001,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	}
 	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
 
-	ret = dev_write(&sbi, buf, erofs_btell(bh, false), EROFS_SUPER_END);
+	ret = erofs_dev_write(&sbi, buf, erofs_btell(bh, false), EROFS_SUPER_END);
 	free(buf);
 	erofs_bdrop(bh, false);
 	return ret;
@@ -1015,7 +1015,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	unsigned int len;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(&sbi, 0, buf, 0, erofs_blknr(&sbi, EROFS_SUPER_END) + 1);
+	ret = erofs_blk_read(&sbi, 0, buf, 0, erofs_blknr(&sbi, EROFS_SUPER_END) + 1);
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
@@ -1045,7 +1045,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(crc);
 
-	ret = blk_write(&sbi, buf, 0, 1);
+	ret = erofs_blk_write(&sbi, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to write checksummed superblock: %s",
 			  erofs_strerror(ret));
@@ -1240,7 +1240,7 @@ int main(int argc, char **argv)
 		sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = dev_open(&sbi, cfg.c_img_path);
+	err = erofs_dev_open(&sbi, cfg.c_img_path);
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
@@ -1477,7 +1477,7 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
-	err = dev_resize(&sbi, nblocks);
+	err = erofs_dev_resize(&sbi, nblocks);
 
 	if (!err && erofs_sb_has_sb_chksum(&sbi))
 		err = erofs_mkfs_superblock_csum_set();
@@ -1485,7 +1485,7 @@ exit:
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

