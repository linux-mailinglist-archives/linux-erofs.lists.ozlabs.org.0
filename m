Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EA5B2C17
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 04:23:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP0D25pcNz3bZ2
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 12:23:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 302 seconds by postgrey-1.36 at boromir; Fri, 09 Sep 2022 12:23:36 AEST
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP0Cr5K8mz2xYy
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 12:23:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VP7G-pX_1662689907;
Received: from localhost.localdomain(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VP7G-pX_1662689907)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 10:18:28 +0800
From: Huang Jianan <jnhuang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs-utils: remove global erofs_devfd
Date: Fri,  9 Sep 2022 10:18:13 +0800
Message-Id: <20220909021816.10544-1-jnhuang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

Move global erofs_dev related variables to sbi->dev, which will
make erofs-utils more library friendly.

Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>
---
 dump/main.c              |  20 ++++--
 fsck/main.c              |  28 +++++---
 fuse/main.c              |  14 ++--
 include/erofs/cache.h    |   6 +-
 include/erofs/config.h   |   2 +
 include/erofs/internal.h |   8 +++
 include/erofs/io.h       |  37 ++++++-----
 lib/blobchunk.c          |  11 ++--
 lib/cache.c              |  12 ++--
 lib/compress.c           |  11 ++--
 lib/config.c             |  12 ++++
 lib/data.c               |   6 +-
 lib/inode.c              |  28 ++++----
 lib/io.c                 | 139 ++++++++++++++++++++-------------------
 lib/namei.c              |   5 +-
 lib/super.c              |   4 +-
 lib/xattr.c              |  17 ++---
 lib/zmap.c               |   4 +-
 mkfs/main.c              |  19 ++++--
 19 files changed, 225 insertions(+), 158 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index f2a09b6..07fa151 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -152,7 +152,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			usage();
 			exit(0);
 		case 3:
-			err = blob_open_ro(optarg);
+			err = blob_open_ro(sbi.dev, optarg);
 			if (err)
 				return err;
 			++sbi.extra_devices;
@@ -599,17 +599,24 @@ int main(int argc, char **argv)
 	int err;
 
 	erofs_init_configure();
+
+	sbi.dev = erofs_init_dev();
+	if (IS_ERR(sbi.dev)) {
+		err = PTR_ERR(sbi.dev);
+		goto exit;
+	}
+
 	err = erofsdump_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
 			usage();
-		goto exit;
+		goto exit_blob_close;
 	}
 
-	err = dev_open_ro(cfg.c_img_path);
+	err = dev_open_ro(sbi.dev, cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
-		goto exit;
+		goto exit_blob_close;
 	}
 
 	err = erofs_read_superblock();
@@ -639,9 +646,10 @@ int main(int argc, char **argv)
 exit_put_super:
 	erofs_put_super();
 exit_dev_close:
-	dev_close();
+	dev_close(sbi.dev);
+exit_blob_close:
+	blob_closeall(sbi.dev);
 exit:
-	blob_closeall();
 	erofs_exit_configure();
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index 410e756..1c8f567 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -143,7 +143,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			}
 			break;
 		case 3:
-			ret = blob_open_ro(optarg);
+			ret = blob_open_ro(sbi.dev, optarg);
 			if (ret)
 				return ret;
 			++sbi.extra_devices;
@@ -263,7 +263,7 @@ static int erofs_check_sb_chksum(void)
 	u32 crc;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(0, buf, 0, 1);
+	ret = blk_read(sbi.dev, 0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to check checksum: %d",
 			  ret);
@@ -291,6 +291,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	unsigned int ofs, xattr_shared_count;
 	struct erofs_xattr_ibody_header *ih;
 	struct erofs_xattr_entry *entry;
+	struct erofs_device *dev = sbi.dev;
 	int i, remaining = inode->xattr_isize, ret = 0;
 	char buf[EROFS_BLKSIZ];
 
@@ -309,7 +310,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	}
 
 	addr = iloc(inode->nid) + inode->inode_isize;
-	ret = dev_read(0, buf, addr, xattr_hdr_size);
+	ret = dev_read(dev, 0, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
 			  inode->nid | 0ULL, ret);
@@ -339,7 +340,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	while (remaining > 0) {
 		unsigned int entry_sz;
 
-		ret = dev_read(0, buf, addr, xattr_entry_size);
+		ret = dev_read(dev, 0, buf, addr, xattr_entry_size);
 		if (ret) {
 			erofs_err("failed to read xattr entry @ nid %llu: %d",
 				  inode->nid | 0ULL, ret);
@@ -445,7 +446,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			BUG_ON(!buffer);
 		}
 
-		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
+		ret = dev_read(sbi.dev, mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
 		if (ret < 0) {
 			erofs_err("failed to read data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
 				  mdev.m_pa, map.m_plen, inode->nid | 0ULL,
@@ -781,6 +782,12 @@ int main(int argc, char **argv)
 
 	erofs_init_configure();
 
+	sbi.dev = erofs_init_dev();
+	if (IS_ERR(sbi.dev)) {
+		err = PTR_ERR(sbi.dev);
+		goto exit;
+	}
+
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
 	fsckcfg.extract_path = NULL;
@@ -799,13 +806,13 @@ int main(int argc, char **argv)
 	if (err) {
 		if (err == -EINVAL)
 			usage();
-		goto exit;
+		goto exit_blob_close;
 	}
 
-	err = dev_open_ro(cfg.c_img_path);
+	err = dev_open_ro(sbi.dev, cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
-		goto exit;
+		goto exit_blob_close;
 	}
 
 	err = erofs_read_superblock();
@@ -844,9 +851,10 @@ int main(int argc, char **argv)
 exit_put_super:
 	erofs_put_super();
 exit_dev_close:
-	dev_close();
+	dev_close(sbi.dev);
+exit_blob_close:
+	blob_closeall(sbi.dev);
 exit:
-	blob_closeall();
 	erofs_exit_configure();
 	return err ? 1 : 0;
 }
diff --git a/fuse/main.c b/fuse/main.c
index f1d1b47..ee86e50 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -239,7 +239,7 @@ static int optional_opt_func(void *data, const char *arg, int key,
 
 	switch (key) {
 	case 1:
-		ret = blob_open_ro(arg + sizeof("--device=") - 1);
+		ret = blob_open_ro(sbi.dev, arg + sizeof("--device=") - 1);
 		if (ret)
 			return -1;
 		++sbi.extra_devices;
@@ -297,6 +297,12 @@ int main(int argc, char *argv[])
 	erofs_init_configure();
 	printf("%s %s\n", basename(argv[0]), cfg.c_version);
 
+	sbi.dev = erofs_init_dev();
+	if (IS_ERR(sbi.dev)) {
+		ret = PTR_ERR(sbi.dev);
+		goto err;
+	}
+
 #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
 	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
 		fprintf(stderr, "failed to initialize signals\n");
@@ -320,7 +326,7 @@ int main(int argc, char *argv[])
 	cfg.c_offset = fusecfg.offset;
 
 	erofsfuse_dumpcfg();
-	ret = dev_open_ro(fusecfg.disk);
+	ret = dev_open_ro(sbi.dev, fusecfg.disk);
 	if (ret) {
 		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
 		goto err_fuse_free_args;
@@ -336,8 +342,8 @@ int main(int argc, char *argv[])
 
 	erofs_put_super();
 err_dev_close:
-	blob_closeall();
-	dev_close();
+	blob_closeall(sbi.dev);
+	dev_close(sbi.dev);
 err_fuse_free_args:
 	fuse_opt_free_args(&args);
 err:
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index de12399..e7aec2b 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -45,6 +45,7 @@ struct erofs_buffer_head {
 struct erofs_buffer_block {
 	struct list_head list;
 	struct list_head mapped_list;
+	struct erofs_device *dev;
 
 	erofs_blk_t blkaddr;
 	int type;
@@ -98,14 +99,15 @@ static inline bool erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 struct erofs_buffer_head *erofs_buffer_init(void);
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
 
-struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
+struct erofs_buffer_head *erofs_balloc(struct erofs_device *dev,
+				       int type, erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext);
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
-bool erofs_bflush(struct erofs_buffer_block *bb);
+bool erofs_bflush(struct erofs_device *dev, struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
 
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 539d813..6c96664 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -85,6 +85,8 @@ void erofs_init_configure(void);
 void erofs_show_config(void);
 void erofs_exit_configure(void);
 
+struct erofs_device *erofs_init_dev(void);
+
 void erofs_set_fs_root(const char *rootdir);
 const char *erofs_fspath(const char *fullpath);
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2e0aae8..c4b36e9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -65,12 +65,20 @@ typedef u32 erofs_blk_t;
 
 struct erofs_buffer_head;
 
+struct erofs_device {
+	const char *name;
+	int fd;
+	u64 size;
+	unsigned int nblobs, blobfd[256];
+};
+
 struct erofs_device_info {
 	u32 blocks;
 	u32 mapped_blkaddr;
 };
 
 struct erofs_sb_info {
+	struct erofs_device *dev;
 	struct erofs_device_info *devs;
 
 	u64 total_blocks;
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 0f58c70..abbb2e0 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -22,17 +22,20 @@ extern "C"
 #define O_BINARY	0
 #endif
 
-void blob_closeall(void);
-int blob_open_ro(const char *dev);
-int dev_open(const char *devname);
-int dev_open_ro(const char *dev);
-void dev_close(void);
-int dev_write(const void *buf, u64 offset, size_t len);
-int dev_read(int device_id, void *buf, u64 offset, size_t len);
-int dev_fillzero(u64 offset, size_t len, bool padding);
-int dev_fsync(void);
-int dev_resize(erofs_blk_t nblocks);
-u64 dev_length(void);
+void blob_closeall(struct erofs_device *dev);
+int blob_open_ro(struct erofs_device *dev, const char *devname);
+int dev_open(struct erofs_device *dev, const char *devname);
+int dev_open_ro(struct erofs_device *dev, const char *devname);
+void dev_close(struct erofs_device *dev);
+int dev_write(struct erofs_device *dev,
+	      const void *buf, u64 offset, size_t len);
+int dev_read(struct erofs_device *dev, int device_id,
+	     void *buf, u64 offset, size_t len);
+int dev_fillzero(struct erofs_device *dev,
+		 u64 offset, size_t len, bool padding);
+int dev_fsync(struct erofs_device *dev);
+int dev_resize(struct erofs_device *dev, erofs_blk_t nblocks);
+u64 dev_length(struct erofs_device *dev);
 
 extern int erofs_devfd;
 
@@ -40,17 +43,17 @@ ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 			      int fd_out, erofs_off_t *off_out,
 			      size_t length);
 
-static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
-			    u32 nblocks)
+static inline int blk_write(struct erofs_device *dev, const void *buf,
+			    erofs_blk_t blkaddr, u32 nblocks)
 {
-	return dev_write(buf, blknr_to_addr(blkaddr),
+	return dev_write(dev, buf, blknr_to_addr(blkaddr),
 			 blknr_to_addr(nblocks));
 }
 
-static inline int blk_read(int device_id, void *buf,
-			   erofs_blk_t start, u32 nblocks)
+static inline int blk_read(struct erofs_device *dev, int device_id,
+			   void *buf, erofs_blk_t start, u32 nblocks)
 {
-	return dev_read(device_id, buf, blknr_to_addr(start),
+	return dev_read(dev, device_id, buf, blknr_to_addr(start),
 			 blknr_to_addr(nblocks));
 }
 
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 77b0c17..d11d7db 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -158,7 +158,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	erofs_droid_blocklist_write_extent(inode, extent_start, extents_blks,
 					   first_extent, true);
 
-	return dev_write(inode->chunkindexes, off, inode->extent_isize);
+	return dev_write(sbi.dev, inode->chunkindexes, off, inode->extent_isize);
 }
 
 int erofs_blob_write_chunked_file(struct erofs_inode *inode)
@@ -214,6 +214,7 @@ err:
 
 int erofs_blob_remap(void)
 {
+	struct erofs_device *dev = sbi.dev;
 	struct erofs_buffer_head *bh;
 	ssize_t length;
 	erofs_off_t pos_in, pos_out;
@@ -229,7 +230,7 @@ int erofs_blob_remap(void)
 		};
 
 		pos_out = erofs_btell(bh_devt, false);
-		ret = dev_write(&dis, pos_out, sizeof(dis));
+		ret = dev_write(dev, &dis, pos_out, sizeof(dis));
 		if (ret)
 			return ret;
 
@@ -237,7 +238,7 @@ int erofs_blob_remap(void)
 		erofs_bdrop(bh_devt, false);
 		return 0;
 	}
-	bh = erofs_balloc(DATA, length, 0, 0);
+	bh = erofs_balloc(dev, DATA, length, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -246,7 +247,7 @@ int erofs_blob_remap(void)
 	pos_in = 0;
 	remapped_base = erofs_blknr(pos_out);
 	ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
-				    erofs_devfd, &pos_out, length);
+				    dev->fd, &pos_out, length);
 	bh->op = &erofs_drop_directly_bhops;
 	erofs_bdrop(bh, false);
 	return ret < length ? -EIO : 0;
@@ -287,7 +288,7 @@ int erofs_generate_devtable(void)
 	if (!multidev)
 		return 0;
 
-	bh_devt = erofs_balloc(DEVT, sizeof(dis), 0, 0);
+	bh_devt = erofs_balloc(sbi.dev, DEVT, sizeof(dis), 0, 0);
 	if (IS_ERR(bh_devt))
 		return PTR_ERR(bh_devt);
 
diff --git a/lib/cache.c b/lib/cache.c
index c735363..60b0ee6 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -45,7 +45,7 @@ int erofs_bh_flush_generic_write(struct erofs_buffer_head *bh, void *buf)
 	erofs_off_t offset = erofs_btell(bh, false);
 
 	DBG_BUGON(nbh->off < bh->off);
-	return dev_write(buf, offset, nbh->off - bh->off);
+	return dev_write(bh->block->dev, buf, offset, nbh->off - bh->off);
 }
 
 static bool erofs_bh_flush_buf_write(struct erofs_buffer_head *bh)
@@ -66,7 +66,7 @@ const struct erofs_bhops erofs_buf_write_bhops = {
 struct erofs_buffer_head *erofs_buffer_init(void)
 {
 	int i, j;
-	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
+	struct erofs_buffer_head *bh = erofs_balloc(sbi.dev, META, 0, 0, 0);
 
 	if (IS_ERR(bh))
 		return bh;
@@ -252,7 +252,8 @@ skip_mapped:
 	return 0;
 }
 
-struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
+struct erofs_buffer_head *erofs_balloc(struct erofs_device *dev,
+				       int type, erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext)
 {
@@ -284,6 +285,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		if (!bb)
 			return ERR_PTR(-ENOMEM);
 
+		bb->dev = dev;
 		bb->type = type;
 		bb->blkaddr = NULL_ADDR;
 		bb->buffers.off = 0;
@@ -367,7 +369,7 @@ erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
 	return tail_blkaddr;
 }
 
-bool erofs_bflush(struct erofs_buffer_block *bb)
+bool erofs_bflush(struct erofs_device *dev, struct erofs_buffer_block *bb)
 {
 	struct erofs_buffer_block *p, *n;
 	erofs_blk_t blkaddr;
@@ -398,7 +400,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		padding = EROFS_BLKSIZ - p->buffers.off % EROFS_BLKSIZ;
 		if (padding != EROFS_BLKSIZ)
-			dev_fillzero(blknr_to_addr(blkaddr) - padding,
+			dev_fillzero(dev, blknr_to_addr(blkaddr) - padding,
 				     padding, true);
 
 		DBG_BUGON(!list_empty(&p->buffers.list));
diff --git a/lib/compress.c b/lib/compress.c
index fd02053..ded0399 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -161,7 +161,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
-	ret = blk_write(dst, ctx->blkaddr, 1);
+	ret = blk_write(sbi.dev, dst, ctx->blkaddr, 1);
 	if (ret)
 		return ret;
 	return count;
@@ -317,7 +317,7 @@ nocompression:
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
 				  count, ctx->blkaddr, ctx->compressedblks);
 
-			ret = blk_write(dst - padding, ctx->blkaddr,
+			ret = blk_write(sbi.dev, dst - padding, ctx->blkaddr,
 					ctx->compressedblks);
 			if (ret)
 				return ret;
@@ -625,7 +625,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(DATA, 0, 0, 0);
+	bh = erofs_balloc(sbi.dev, DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto err_close;
@@ -746,6 +746,7 @@ static int erofs_get_compress_algorithm_id(const char *name)
 int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 {
 	struct erofs_buffer_head *bh = sb_bh;
+	struct erofs_device *dev = sbi.dev;
 	int ret = 0;
 
 	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
@@ -767,7 +768,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(&lz4alg, erofs_btell(bh, false),
+		ret = dev_write(dev, &lz4alg, erofs_btell(bh, false),
 				sizeof(lz4alg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -789,7 +790,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(&lzmaalg, erofs_btell(bh, false),
+		ret = dev_write(dev, &lzmaalg, erofs_btell(bh, false),
 				sizeof(lzmaalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
diff --git a/lib/config.c b/lib/config.c
index 3963df2..3cc1d22 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -57,6 +57,18 @@ void erofs_exit_configure(void)
 		free(cfg.c_img_path);
 }
 
+struct erofs_device *erofs_init_dev(void)
+{
+	struct erofs_device *dev;
+	dev = calloc(1, sizeof(struct erofs_device));
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->fd = -1;
+
+	return dev;
+}
+
 static unsigned int fullpath_prefix;	/* root directory prefix length */
 
 void erofs_set_fs_root(const char *rootdir)
diff --git a/lib/data.c b/lib/data.c
index ad7b2cb..abfa3f4 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -92,7 +92,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	pos = roundup(iloc(vi->nid) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
-	err = blk_read(0, buf, erofs_blknr(pos), 1);
+	err = blk_read(sbi.dev, 0, buf, erofs_blknr(pos), 1);
 	if (err < 0)
 		return -EIO;
 
@@ -208,7 +208,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			map.m_la = ptr;
 		}
 
-		ret = dev_read(mdev.m_deviceid, estart, mdev.m_pa,
+		ret = dev_read(sbi.dev, mdev.m_deviceid, estart, mdev.m_pa,
 			       eend - map.m_la);
 		if (ret < 0)
 			return -EIO;
@@ -283,7 +283,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 				break;
 			}
 		}
-		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
+		ret = dev_read(sbi.dev, mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
 		if (ret < 0)
 			break;
 
diff --git a/lib/inode.c b/lib/inode.c
index 4da28b3..09cd79f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -151,7 +151,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(DATA, blknr_to_addr(nblocks), 0, 0);
+	bh = erofs_balloc(sbi.dev, DATA, blknr_to_addr(nblocks), 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -278,7 +278,7 @@ static int write_dirblock(unsigned int q, struct erofs_dentry *head,
 	char buf[EROFS_BLKSIZ];
 
 	fill_dirblock(buf, EROFS_BLKSIZ, q, head, end);
-	return blk_write(buf, blkaddr, 1);
+	return blk_write(sbi.dev, buf, blkaddr, 1);
 }
 
 static int erofs_write_dir_file(struct erofs_inode *dir)
@@ -340,7 +340,7 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 		return ret;
 
 	if (nblocks)
-		blk_write(buf, inode->u.i_blkaddr, nblocks);
+		blk_write(sbi.dev, buf, inode->u.i_blkaddr, nblocks);
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
@@ -382,7 +382,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 			return -EAGAIN;
 		}
 
-		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
+		ret = blk_write(sbi.dev, buf, inode->u.i_blkaddr + i, 1);
 		if (ret)
 			return ret;
 	}
@@ -443,6 +443,7 @@ int erofs_write_file(struct erofs_inode *inode)
 static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
+	struct erofs_device *dev = sbi.dev;
 	const u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
 	erofs_off_t off = erofs_btell(bh, false);
 	union {
@@ -529,7 +530,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		BUG_ON(1);
 	}
 
-	ret = dev_write(&u, off, inode->inode_isize);
+	ret = dev_write(dev, &u, off, inode->inode_isize);
 	if (ret)
 		return false;
 	off += inode->inode_isize;
@@ -540,7 +541,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (IS_ERR(xattrs))
 			return false;
 
-		ret = dev_write(xattrs, off, inode->xattr_isize);
+		ret = dev_write(dev, xattrs, off, inode->xattr_isize);
 		free(xattrs);
 		if (ret)
 			return false;
@@ -556,7 +557,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		} else {
 			/* write compression metadata */
 			off = Z_EROFS_VLE_EXTENT_ALIGN(off);
-			ret = dev_write(inode->compressmeta, off,
+			ret = dev_write(dev, inode->compressmeta, off,
 					inode->extent_isize);
 			if (ret)
 				return false;
@@ -583,7 +584,7 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 
 	bh = inode->bh_data;
 	if (!bh) {
-		bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
+		bh = erofs_balloc(sbi.dev, DATA, EROFS_BLKSIZ, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		bh->op = &erofs_skip_write_bhops;
@@ -631,7 +632,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
+	bh = erofs_balloc(sbi.dev, INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
@@ -644,7 +645,7 @@ noinline:
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
-		bh = erofs_balloc(INODE, inodesize, 0, 0);
+		bh = erofs_balloc(sbi.dev, INODE, inodesize, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		DBG_BUGON(inode->bh_inline);
@@ -684,7 +685,7 @@ static bool erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = dev_write(inode->idata, off, inode->idata_size);
+	ret = dev_write(sbi.dev, inode->idata, off, inode->idata_size);
 	if (ret)
 		return false;
 
@@ -703,6 +704,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 static int erofs_write_tail_end(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh, *ibh;
+	struct erofs_device *dev = sbi.dev;
 
 	bh = inode->bh_data;
 
@@ -732,13 +734,13 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 			/* pad 0'ed data for the other cases */
 			zero_pos = pos + inode->idata_size;
 		}
-		ret = dev_write(inode->idata, pos, inode->idata_size);
+		ret = dev_write(dev, inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
 
 		DBG_BUGON(inode->idata_size > EROFS_BLKSIZ);
 		if (inode->idata_size < EROFS_BLKSIZ) {
-			ret = dev_fillzero(zero_pos,
+			ret = dev_fillzero(dev, zero_pos,
 					   EROFS_BLKSIZ - inode->idata_size,
 					   false);
 			if (ret)
diff --git a/lib/io.c b/lib/io.c
index 524cfb4..2b9811e 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -23,11 +23,6 @@
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
-static const char *erofs_devname;
-int erofs_devfd = -1;
-static u64 erofs_devsz;
-static unsigned int erofs_nblobs, erofs_blobfd[256];
-
 int dev_get_blkdev_size(int fd, u64 *bytes)
 {
 	errno = ENOTSUP;
@@ -48,111 +43,119 @@ int dev_get_blkdev_size(int fd, u64 *bytes)
 	return -errno;
 }
 
-void dev_close(void)
+void dev_close(struct erofs_device *dev)
 {
-	close(erofs_devfd);
-	erofs_devname = NULL;
-	erofs_devfd   = -1;
-	erofs_devsz   = 0;
+	if (!dev)
+		return;
+
+	close(dev->fd);
+	dev->name = NULL;
+	dev->fd   = -1;
+	dev->size   = 0;
 }
 
-int dev_open(const char *dev)
+int dev_open(struct erofs_device *dev, const char *devname)
 {
 	struct stat st;
 	int fd, ret;
 
-	fd = open(dev, O_RDWR | O_CREAT | O_BINARY, 0644);
+	fd = open(devname, O_RDWR | O_CREAT | O_BINARY, 0644);
 	if (fd < 0) {
-		erofs_err("failed to open(%s).", dev);
+		erofs_err("failed to open(%s).", devname);
 		return -errno;
 	}
 
 	ret = fstat(fd, &st);
 	if (ret) {
-		erofs_err("failed to fstat(%s).", dev);
+		erofs_err("failed to fstat(%s).", devname);
 		close(fd);
 		return -errno;
 	}
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFBLK:
-		ret = dev_get_blkdev_size(fd, &erofs_devsz);
+		ret = dev_get_blkdev_size(fd, &dev->size);
 		if (ret) {
-			erofs_err("failed to get block device size(%s).", dev);
+			erofs_err("failed to get block device size(%s).",
+				  devname);
 			close(fd);
 			return ret;
 		}
-		erofs_devsz = round_down(erofs_devsz, EROFS_BLKSIZ);
+		dev->size = round_down(dev->size, EROFS_BLKSIZ);
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
 		if (ret) {
-			erofs_err("failed to ftruncate(%s).", dev);
+			erofs_err("failed to ftruncate(%s).", devname);
 			close(fd);
 			return -errno;
 		}
 		/* INT64_MAX is the limit of kernel vfs */
-		erofs_devsz = INT64_MAX;
+		dev->size = INT64_MAX;
 		break;
 	default:
-		erofs_err("bad file type (%s, %o).", dev, st.st_mode);
+		erofs_err("bad file type (%s, %o).", devname, st.st_mode);
 		close(fd);
 		return -EINVAL;
 	}
 
-	erofs_devname = dev;
-	erofs_devfd = fd;
+	dev->name = devname;
+	dev->fd = fd;
 
-	erofs_info("successfully to open %s", dev);
-	return 0;
+	erofs_info("successfully to open %s", devname);
+	return ret;
 }
 
-void blob_closeall(void)
+void blob_closeall(struct erofs_device *dev)
 {
 	unsigned int i;
 
-	for (i = 0; i < erofs_nblobs; ++i)
-		close(erofs_blobfd[i]);
-	erofs_nblobs = 0;
+	if (!dev)
+		return;
+
+	for (i = 0; i < dev->nblobs; ++i)
+		close(dev->blobfd[i]);
+	dev->nblobs = 0;
 }
 
-int blob_open_ro(const char *dev)
+int blob_open_ro(struct erofs_device *dev, const char *devname)
 {
-	int fd = open(dev, O_RDONLY | O_BINARY);
+	int fd = open(devname, O_RDONLY | O_BINARY);
 
 	if (fd < 0) {
-		erofs_err("failed to open(%s).", dev);
+		erofs_err("failed to open(%s).", devname);
 		return -errno;
 	}
 
-	erofs_blobfd[erofs_nblobs] = fd;
-	erofs_info("successfully to open blob%u %s", erofs_nblobs, dev);
-	++erofs_nblobs;
+	dev->blobfd[dev->nblobs] = fd;
+	erofs_info("successfully to open blob%u %s", dev->nblobs, devname);
+	++dev->nblobs;
 	return 0;
 }
 
 /* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
-int dev_open_ro(const char *dev)
+int dev_open_ro(struct erofs_device *dev, const char *devname)
 {
-	int fd = open(dev, O_RDONLY | O_BINARY);
+	int fd = open(devname, O_RDONLY | O_BINARY);
 
 	if (fd < 0) {
-		erofs_err("failed to open(%s).", dev);
+		erofs_err("failed to open(%s).", devname);
 		return -errno;
 	}
 
-	erofs_devfd = fd;
-	erofs_devname = dev;
-	erofs_devsz = INT64_MAX;
+	dev->fd = fd;
+	dev->name = devname;
+	dev->size = INT64_MAX;
 	return 0;
 }
 
-u64 dev_length(void)
+u64 dev_length(struct erofs_device *dev)
 {
-	return erofs_devsz;
+	return dev->size;
 }
 
-int dev_write(const void *buf, u64 offset, size_t len)
+int dev_write(struct erofs_device *dev,
+	      const void *buf, u64 offset, size_t len)
 {
 	int ret;
 
@@ -164,33 +167,34 @@ int dev_write(const void *buf, u64 offset, size_t len)
 		return -EINVAL;
 	}
 
-	if (offset >= erofs_devsz || len > erofs_devsz ||
-	    offset > erofs_devsz - len) {
+	if (offset >= dev->size || len > dev->size ||
+	    offset > dev->size - len) {
 		erofs_err("Write posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
-			  offset, len, erofs_devsz);
+			  offset, len, dev->size);
 		return -EINVAL;
 	}
 
 #ifdef HAVE_PWRITE64
-	ret = pwrite64(erofs_devfd, buf, len, (off64_t)offset);
+	ret = pwrite64(dev->fd, buf, len, (off64_t)offset);
 #else
-	ret = pwrite(erofs_devfd, buf, len, (off_t)offset);
+	ret = pwrite(dev->fd, buf, len, (off_t)offset);
 #endif
 	if (ret != (int)len) {
 		if (ret < 0) {
 			erofs_err("Failed to write data into device - %s:[%" PRIu64 ", %zd].",
-				  erofs_devname, offset, len);
+				  dev->name, offset, len);
 			return -errno;
 		}
 
 		erofs_err("Writing data into device - %s:[%" PRIu64 ", %zd] - was truncated.",
-			  erofs_devname, offset, len);
+			  dev->name, offset, len);
 		return -ERANGE;
 	}
 	return 0;
 }
 
-int dev_fillzero(u64 offset, size_t len, bool padding)
+int dev_fillzero(struct erofs_device *dev,
+		 u64 offset, size_t len, bool padding)
 {
 	static const char zero[EROFS_BLKSIZ] = {0};
 	int ret;
@@ -199,25 +203,25 @@ int dev_fillzero(u64 offset, size_t len, bool padding)
 		return 0;
 
 #if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
-	if (!padding && fallocate(erofs_devfd, FALLOC_FL_PUNCH_HOLE |
+	if (!padding && fallocate(dev->fd, FALLOC_FL_PUNCH_HOLE |
 				  FALLOC_FL_KEEP_SIZE, offset, len) >= 0)
 		return 0;
 #endif
 	while (len > EROFS_BLKSIZ) {
-		ret = dev_write(zero, offset, EROFS_BLKSIZ);
+		ret = dev_write(dev, zero, offset, EROFS_BLKSIZ);
 		if (ret)
 			return ret;
 		len -= EROFS_BLKSIZ;
 		offset += EROFS_BLKSIZ;
 	}
-	return dev_write(zero, offset, len);
+	return dev_write(dev, zero, offset, len);
 }
 
-int dev_fsync(void)
+int dev_fsync(struct erofs_device *dev)
 {
 	int ret;
 
-	ret = fsync(erofs_devfd);
+	ret = fsync(dev->fd);
 	if (ret) {
 		erofs_err("Could not fsync device!!!");
 		return -EIO;
@@ -225,16 +229,16 @@ int dev_fsync(void)
 	return 0;
 }
 
-int dev_resize(unsigned int blocks)
+int dev_resize(struct erofs_device *dev, unsigned int blocks)
 {
 	int ret;
 	struct stat st;
 	u64 length;
 
-	if (cfg.c_dry_run || erofs_devsz != INT64_MAX)
+	if (cfg.c_dry_run || dev->size != INT64_MAX)
 		return 0;
 
-	ret = fstat(erofs_devfd, &st);
+	ret = fstat(dev->fd, &st);
 	if (ret) {
 		erofs_err("failed to fstat.");
 		return -errno;
@@ -244,17 +248,18 @@ int dev_resize(unsigned int blocks)
 	if (st.st_size == length)
 		return 0;
 	if (st.st_size > length)
-		return ftruncate(erofs_devfd, length);
+		return ftruncate(dev->fd, length);
 
 	length = length - st.st_size;
 #if defined(HAVE_FALLOCATE)
-	if (fallocate(erofs_devfd, 0, st.st_size, length) >= 0)
+	if (fallocate(dev->fd, 0, st.st_size, length) >= 0)
 		return 0;
 #endif
-	return dev_fillzero(st.st_size, length, true);
+	return dev_fillzero(dev, st.st_size, length, true);
 }
 
-int dev_read(int device_id, void *buf, u64 offset, size_t len)
+int dev_read(struct erofs_device *dev, int device_id,
+	     void *buf, u64 offset, size_t len)
 {
 	int ret, fd;
 
@@ -269,13 +274,13 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 	}
 
 	if (!device_id) {
-		fd = erofs_devfd;
+		fd = dev->fd;
 	} else {
-		if (device_id > erofs_nblobs) {
+		if (device_id > dev->nblobs) {
 			erofs_err("invalid device id %d", device_id);
 			return -ENODEV;
 		}
-		fd = erofs_blobfd[device_id - 1];
+		fd = dev->blobfd[device_id - 1];
 	}
 
 #ifdef HAVE_PREAD64
@@ -285,7 +290,7 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 #endif
 	if (ret != (int)len) {
 		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
-			  erofs_devname, offset, len);
+			  dev->name, offset, len);
 		return -errno;
 	}
 	return 0;
diff --git a/lib/namei.c b/lib/namei.c
index 7b69a59..bb14d30 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -28,9 +28,10 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	char buf[sizeof(struct erofs_inode_extended)];
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
+	struct erofs_device *dev = sbi.dev;
 	const erofs_off_t inode_loc = iloc(vi->nid);
 
-	ret = dev_read(0, buf, inode_loc, sizeof(*dic));
+	ret = dev_read(dev, 0, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
 		return -EIO;
 
@@ -47,7 +48,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
-		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
+		ret = dev_read(dev, 0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
 			       sizeof(*die) - sizeof(*dic));
 		if (ret < 0)
 			return -EIO;
diff --git a/lib/super.c b/lib/super.c
index b267412..8727161 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -53,7 +53,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 		struct erofs_deviceslot dis;
 		int ret;
 
-		ret = dev_read(0, &dis, pos, sizeof(dis));
+		ret = dev_read(sbi->dev, 0, &dis, pos, sizeof(dis));
 		if (ret < 0) {
 			free(sbi->devs);
 			return ret;
@@ -73,7 +73,7 @@ int erofs_read_superblock(void)
 	unsigned int blkszbits;
 	int ret;
 
-	ret = blk_read(0, data, 0, 1);
+	ret = blk_read(sbi.dev, 0, data, 0, 1);
 	if (ret < 0) {
 		erofs_err("cannot read erofs superblock: %d", ret);
 		return -EIO;
diff --git a/lib/xattr.c b/lib/xattr.c
index 8979dcc..e0bf922 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -549,7 +549,7 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 static bool erofs_bh_flush_write_shared_xattrs(struct erofs_buffer_head *bh)
 {
 	void *buf = bh->fsprivate;
-	int err = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
+	int err = dev_write(sbi.dev, buf, erofs_btell(bh, false), shared_xattrs_size);
 
 	if (err)
 		return false;
@@ -609,7 +609,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	if (!buf)
 		return -ENOMEM;
 
-	bh = erofs_balloc(XATTR, shared_xattrs_size, 0, 0);
+	bh = erofs_balloc(sbi.dev, XATTR, shared_xattrs_size, 0, 0);
 	if (IS_ERR(bh)) {
 		free(buf);
 		return PTR_ERR(bh);
@@ -729,6 +729,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
+	struct erofs_device *dev = sbi.dev;
 	int ret = 0;
 
 	/* the most case is that xattrs of this inode are initialized. */
@@ -759,7 +760,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	it.blkaddr = erofs_blknr(iloc(vi->nid) + vi->inode_isize);
 	it.ofs = erofs_blkoff(iloc(vi->nid) + vi->inode_isize);
 
-	ret = blk_read(0, it.page, it.blkaddr, 1);
+	ret = blk_read(dev, 0, it.page, it.blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -779,7 +780,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 			/* cannot be unaligned */
 			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
 
-			ret = blk_read(0, it.page, ++it.blkaddr, 1);
+			ret = blk_read(dev, 0, it.page, ++it.blkaddr, 1);
 			if (ret < 0) {
 				free(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -824,7 +825,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 
 	it->blkaddr += erofs_blknr(it->ofs);
 
-	ret = blk_read(0, it->page, it->blkaddr, 1);
+	ret = blk_read(sbi.dev, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -850,7 +851,7 @@ static int inline_xattr_iter_pre(struct xattr_iter *it,
 	it->blkaddr = erofs_blknr(iloc(vi->nid) + inline_xattr_ofs);
 	it->ofs = erofs_blkoff(iloc(vi->nid) + inline_xattr_ofs);
 
-	ret = blk_read(0, it->page, it->blkaddr, 1);
+	ret = blk_read(sbi.dev, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -1047,7 +1048,7 @@ static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
 
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(0, it->it.page, blkaddr, 1);
+			ret = blk_read(sbi.dev, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
@@ -1186,7 +1187,7 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 
 		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(0, it->it.page, blkaddr, 1);
+			ret = blk_read(sbi.dev, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index abe0d31..6e5a5d4 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -44,7 +44,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
-	ret = dev_read(0, buf, pos, sizeof(buf));
+	ret = dev_read(sbi.dev, 0, buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -111,7 +111,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	if (map->index == eblk)
 		return 0;
 
-	ret = blk_read(0, mpage, eblk, 1);
+	ret = blk_read(sbi.dev, 0, mpage, eblk, 1);
 	if (ret < 0)
 		return -EIO;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index b969b35..e3ad9d9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -508,8 +508,9 @@ static int erofs_mkfs_superblock_csum_set(void)
 	u8 buf[EROFS_BLKSIZ];
 	u32 crc;
 	struct erofs_super_block *sb;
+	struct erofs_device *dev = sbi.dev;
 
-	ret = blk_read(0, buf, 0, 1);
+	ret = blk_read(dev, 0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
@@ -535,7 +536,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(crc);
 
-	ret = blk_write(buf, 0, 1);
+	ret = blk_write(dev, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to write checksummed superblock: %s",
 			  erofs_strerror(ret));
@@ -607,8 +608,12 @@ int main(int argc, char **argv)
 	char uuid_str[37] = "not available";
 
 	erofs_init_configure();
-	erofs_mkfs_default_options();
 
+	sbi.dev = erofs_init_dev();
+	if (IS_ERR(sbi.dev))
+		return 1;
+
+	erofs_mkfs_default_options();
 	err = mkfs_parse_options_cfg(argc, argv);
 	erofs_show_progs(argc, argv);
 	if (err) {
@@ -647,7 +652,7 @@ int main(int argc, char **argv)
 		sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = dev_open(cfg.c_img_path);
+	err = dev_open(sbi.dev, cfg.c_img_path);
 	if (err) {
 		usage();
 		return 1;
@@ -744,10 +749,10 @@ int main(int argc, char **argv)
 		goto exit;
 
 	/* flush all remaining buffers */
-	if (!erofs_bflush(NULL))
+	if (!erofs_bflush(sbi.dev, NULL))
 		err = -EIO;
 	else
-		err = dev_resize(nblocks);
+		err = dev_resize(sbi.dev, nblocks);
 
 	if (!err && erofs_sb_has_sb_chksum())
 		err = erofs_mkfs_superblock_csum_set();
@@ -756,7 +761,7 @@ exit:
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
 #endif
-	dev_close();
+	dev_close(sbi.dev);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
-- 
2.34.1

