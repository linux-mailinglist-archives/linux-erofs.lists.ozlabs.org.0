Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DEC75731B
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 07:21:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4nP212Vzz305R
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 15:21:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4nNl20zBz300f
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jul 2023 15:21:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VngKAqw_1689657665;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VngKAqw_1689657665)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 13:21:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs-utils: remove global sbi in library
Date: Tue, 18 Jul 2023 13:21:01 +0800
Message-Id: <20230718052101.124039-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230718052101.124039-1-jefflexu@linux.alibaba.com>
References: <20230718052101.124039-1-jefflexu@linux.alibaba.com>
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

Later mkfs is going to be capable of converting multiple erofs images
into one merged erofs image, in which case there are multiple device
context and sbi instances.

In preparation for that, remove global device context and sbi in all
libraries except buffer block library, as there's still only one output
erofs image.

The device context is inlined into sbi.  Global sbi is remained but only
used by utils directly, e.g. mkfs/dump/fsck.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 dump/main.c                    |  30 +++---
 fsck/main.c                    |  39 ++++----
 fuse/main.c                    |  24 ++---
 include/erofs/blobchunk.h      |   4 +-
 include/erofs/cache.h          |   6 +-
 include/erofs/compress.h       |   8 +-
 include/erofs/compress_hints.h |   2 +-
 include/erofs/decompress.h     |   1 +
 include/erofs/dir.h            |   3 +-
 include/erofs/internal.h       |  51 +++++-----
 include/erofs/io.h             |  38 ++++----
 include/erofs/tar.h            |   4 +-
 include/erofs/xattr.h          |  16 ++--
 lib/blobchunk.c                |  45 ++++-----
 lib/cache.c                    |  42 ++++-----
 lib/compress.c                 | 165 ++++++++++++++++++---------------
 lib/compress_hints.c           |  10 +-
 lib/compressor.c               |  15 +--
 lib/compressor.h               |   4 +-
 lib/compressor_lz4.c           |   2 +-
 lib/compressor_lz4hc.c         |   2 +-
 lib/data.c                     |  65 +++++++------
 lib/decompress.c               |  29 +++---
 lib/dir.c                      |  21 +++--
 lib/fragments.c                |   2 +-
 lib/inode.c                    | 118 ++++++++++++-----------
 lib/io.c                       | 119 +++++++++++-------------
 lib/namei.c                    |  36 ++++---
 lib/super.c                    |  51 +++++-----
 lib/tar.c                      |  36 +++----
 lib/xattr.c                    |  75 ++++++++-------
 lib/zmap.c                     |  37 +++++---
 mkfs/main.c                    |  62 ++++++-------
 33 files changed, 617 insertions(+), 545 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 7e75719..35f92b1 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -154,7 +154,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			usage();
 			exit(0);
 		case 3:
-			err = blob_open_ro(optarg);
+			err = blob_open_ro(&sbi, optarg);
 			if (err)
 				return err;
 			++sbi.extra_devices;
@@ -202,7 +202,7 @@ static int erofsdump_get_occupied_size(struct erofs_inode *inode,
 	case EROFS_INODE_COMPRESSED_FULL:
 	case EROFS_INODE_COMPRESSED_COMPACT:
 		stats.compressed_files++;
-		*size = inode->u.i_blocks * erofs_blksiz();
+		*size = inode->u.i_blocks * erofs_blksiz(inode->sbi);
 		break;
 	default:
 		erofs_err("unknown datalayout");
@@ -272,10 +272,10 @@ static int erofsdump_read_packed_inode(void)
 	erofs_off_t occupied_size = 0;
 	struct erofs_inode vi = { .nid = sbi.packed_nid };
 
-	if (!(erofs_sb_has_fragments() && sbi.packed_nid > 0))
+	if (!(erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0))
 		return 0;
 
-	err = erofs_read_inode_from_disk(&vi);
+	err = erofs_read_inode_from_disk(&sbi, &vi);
 	if (err) {
 		erofs_err("failed to read packed file inode from disk");
 		return err;
@@ -298,7 +298,7 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 	erofs_off_t occupied_size = 0;
 	struct erofs_inode vi = { .nid = ctx->de_nid };
 
-	err = erofs_read_inode_from_disk(&vi);
+	err = erofs_read_inode_from_disk(&sbi, &vi);
 	if (err) {
 		erofs_err("failed to read file inode from disk");
 		return err;
@@ -362,13 +362,13 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	};
 
 	if (dumpcfg.inode_path) {
-		err = erofs_ilookup(dumpcfg.inode_path, &inode);
+		err = erofs_ilookup(&sbi, dumpcfg.inode_path, &inode);
 		if (err) {
 			erofs_err("read inode failed @ %s", dumpcfg.inode_path);
 			return;
 		}
 	} else {
-		err = erofs_read_inode_from_disk(&inode);
+		err = erofs_read_inode_from_disk(&sbi, &inode);
 		if (err) {
 			erofs_err("read inode failed @ nid %llu",
 				  inode.nid | 0ULL);
@@ -382,7 +382,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		return;
 	}
 
-	err = erofs_get_pathname(inode.nid, path, sizeof(path));
+	err = erofs_get_pathname(inode.sbi, inode.nid, path, sizeof(path));
 	if (err < 0) {
 		strncpy(path, "(not found)", sizeof(path) - 1);
 		path[sizeof(path) - 1] = '\0';
@@ -447,7 +447,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
 		};
-		err = erofs_map_dev(&mdev);
+		err = erofs_map_dev(inode.sbi, &mdev);
 		if (err) {
 			erofs_err("failed to map device");
 			return;
@@ -604,7 +604,7 @@ static void erofsdump_show_superblock(void)
 			sbi.xattr_blkaddr);
 	fprintf(stdout, "Filesystem root nid:                          %llu\n",
 			sbi.root_nid | 0ULL);
-	if (erofs_sb_has_fragments() && sbi.packed_nid > 0)
+	if (erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
 			sbi.packed_nid | 0ULL);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
@@ -636,13 +636,13 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = dev_open_ro(cfg.c_img_path);
+	err = dev_open_ro(&sbi, cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
 	}
 
-	err = erofs_read_superblock();
+	err = erofs_read_superblock(&sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit_dev_close;
@@ -667,11 +667,11 @@ int main(int argc, char **argv)
 		erofsdump_show_fileinfo(dumpcfg.show_extent);
 
 exit_put_super:
-	erofs_put_super();
+	erofs_put_super(&sbi);
 exit_dev_close:
-	dev_close();
+	dev_close(&sbi);
 exit:
-	blob_closeall();
+	blob_closeall(&sbi);
 	erofs_exit_configure();
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index 498c646..4545050 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -158,7 +158,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			}
 			break;
 		case 3:
-			ret = blob_open_ro(optarg);
+			ret = blob_open_ro(&sbi, optarg);
 			if (ret)
 				return ret;
 			++sbi.extra_devices;
@@ -279,7 +279,7 @@ static int erofs_check_sb_chksum(void)
 	struct erofs_super_block *sb;
 	int ret;
 
-	ret = blk_read(0, buf, 0, 1);
+	ret = blk_read(&sbi, 0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to check checksum: %d",
 			  ret);
@@ -289,7 +289,7 @@ static int erofs_check_sb_chksum(void)
 	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
 	sb->checksum = 0;
 
-	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz() - EROFS_SUPER_OFFSET);
+	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz(&sbi) - EROFS_SUPER_OFFSET);
 	if (crc != sbi.checksum) {
 		erofs_err("superblock chksum doesn't match: saved(%08xh) calculated(%08xh)",
 			  sbi.checksum, crc);
@@ -302,6 +302,7 @@ static int erofs_check_sb_chksum(void)
 
 static int erofs_verify_xattr(struct erofs_inode *inode)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
 	unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
 	erofs_off_t addr;
@@ -326,7 +327,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	}
 
 	addr = iloc(inode) + inode->inode_isize;
-	ret = dev_read(0, buf, addr, xattr_hdr_size);
+	ret = dev_read(sbi, 0, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
 			  inode->nid | 0ULL, ret);
@@ -335,12 +336,12 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	ih = (struct erofs_xattr_ibody_header *)buf;
 	xattr_shared_count = ih->h_shared_count;
 
-	ofs = erofs_blkoff(addr) + xattr_hdr_size;
+	ofs = erofs_blkoff(sbi, addr) + xattr_hdr_size;
 	addr += xattr_hdr_size;
 	remaining -= xattr_hdr_size;
 	for (i = 0; i < xattr_shared_count; ++i) {
-		if (ofs >= erofs_blksiz()) {
-			if (ofs != erofs_blksiz()) {
+		if (ofs >= erofs_blksiz(sbi)) {
+			if (ofs != erofs_blksiz(sbi)) {
 				erofs_err("unaligned xattr entry in xattr shared area @ nid %llu",
 					  inode->nid | 0ULL);
 				ret = -EFSCORRUPTED;
@@ -356,7 +357,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	while (remaining > 0) {
 		unsigned int entry_sz;
 
-		ret = dev_read(0, buf, addr, xattr_entry_size);
+		ret = dev_read(sbi, 0, buf, addr, xattr_entry_size);
 		if (ret) {
 			erofs_err("failed to read xattr entry @ nid %llu: %d",
 				  inode->nid | 0ULL, ret);
@@ -483,7 +484,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 				u64 count = min_t(u64, alloc_rawsize,
 						  map.m_llen);
 
-				ret = erofs_read_one_data(&map, raw, p, count);
+				ret = erofs_read_one_data(inode, &map, raw, p, count);
 				if (ret)
 					goto out;
 
@@ -497,8 +498,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 
 	if (fsckcfg.print_comp_ratio) {
 		if (!erofs_is_packed_inode(inode))
-			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
-		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
+			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->sbi, inode->i_size);
+		fsckcfg.physical_blocks += BLK_ROUND_UP(inode->sbi, pchunk_len);
 	}
 out:
 	if (raw)
@@ -845,7 +846,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
 
 	inode.nid = nid;
-	ret = erofs_read_inode_from_disk(&inode);
+	ret = erofs_read_inode_from_disk(&sbi, &inode);
 	if (ret) {
 		if (ret == -EIO)
 			erofs_err("I/O error occurred when reading nid(%llu)",
@@ -920,19 +921,19 @@ int main(int argc, char *argv[])
 	cfg.c_dbg_lvl = -1;
 #endif
 
-	err = dev_open_ro(cfg.c_img_path);
+	err = dev_open_ro(&sbi, cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
 	}
 
-	err = erofs_read_superblock();
+	err = erofs_read_superblock(&sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit_dev_close;
 	}
 
-	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
+	if (erofs_sb_has_sb_chksum(&sbi) && erofs_check_sb_chksum()) {
 		erofs_err("failed to verify superblock checksum");
 		goto exit_put_super;
 	}
@@ -940,7 +941,7 @@ int main(int argc, char *argv[])
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_init();
 
-	if (erofs_sb_has_fragments() && sbi.packed_nid > 0) {
+	if (erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0) {
 		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
 		if (err) {
 			erofs_err("failed to verify packed file");
@@ -974,11 +975,11 @@ exit_hardlink:
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_exit();
 exit_put_super:
-	erofs_put_super();
+	erofs_put_super(&sbi);
 exit_dev_close:
-	dev_close();
+	dev_close(&sbi);
 exit:
-	blob_closeall();
+	blob_closeall(&sbi);
 	erofs_exit_configure();
 	return err ? 1 : 0;
 }
diff --git a/fuse/main.c b/fuse/main.c
index b060e06..da5b0ff 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -49,7 +49,7 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	};
 	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
 
-	ret = erofs_ilookup(path, &dir);
+	ret = erofs_ilookup(&sbi, path, &dir);
 	if (ret)
 		return ret;
 
@@ -88,14 +88,14 @@ static int erofsfuse_getattr(const char *path, struct stat *stbuf)
 	int ret;
 
 	erofs_dbg("getattr(%s)", path);
-	ret = erofs_ilookup(path, &vi);
+	ret = erofs_ilookup(&sbi, path, &vi);
 	if (ret)
 		return -ENOENT;
 
 	stbuf->st_mode  = vi.i_mode;
 	stbuf->st_nlink = vi.i_nlink;
 	stbuf->st_size  = vi.i_size;
-	stbuf->st_blocks = roundup(vi.i_size, erofs_blksiz()) >> 9;
+	stbuf->st_blocks = roundup(vi.i_size, erofs_blksiz(vi.sbi)) >> 9;
 	stbuf->st_uid = vi.i_uid;
 	stbuf->st_gid = vi.i_gid;
 	if (S_ISBLK(vi.i_mode) || S_ISCHR(vi.i_mode))
@@ -115,7 +115,7 @@ static int erofsfuse_read(const char *path, char *buffer,
 
 	erofs_dbg("path:%s size=%zd offset=%llu", path, size, (long long)offset);
 
-	ret = erofs_ilookup(path, &vi);
+	ret = erofs_ilookup(&sbi, path, &vi);
 	if (ret)
 		return ret;
 
@@ -155,7 +155,7 @@ static int erofsfuse_getxattr(const char *path, const char *name, char *value,
 
 	erofs_dbg("getxattr(%s): name=%s size=%llu", path, name, size);
 
-	ret = erofs_ilookup(path, &vi);
+	ret = erofs_ilookup(&sbi, path, &vi);
 	if (ret)
 		return ret;
 
@@ -169,7 +169,7 @@ static int erofsfuse_listxattr(const char *path, char *list, size_t size)
 
 	erofs_dbg("listxattr(%s): size=%llu", path, size);
 
-	ret = erofs_ilookup(path, &vi);
+	ret = erofs_ilookup(&sbi, path, &vi);
 	if (ret)
 		return ret;
 
@@ -244,7 +244,7 @@ static int optional_opt_func(void *data, const char *arg, int key,
 
 	switch (key) {
 	case 1:
-		ret = blob_open_ro(arg + sizeof("--device=") - 1);
+		ret = blob_open_ro(&sbi, arg + sizeof("--device=") - 1);
 		if (ret)
 			return -1;
 		++sbi.extra_devices;
@@ -325,13 +325,13 @@ int main(int argc, char *argv[])
 	cfg.c_offset = fusecfg.offset;
 
 	erofsfuse_dumpcfg();
-	ret = dev_open_ro(fusecfg.disk);
+	ret = dev_open_ro(&sbi, fusecfg.disk);
 	if (ret) {
 		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
 		goto err_fuse_free_args;
 	}
 
-	ret = erofs_read_superblock();
+	ret = erofs_read_superblock(&sbi);
 	if (ret) {
 		fprintf(stderr, "failed to read erofs super block\n");
 		goto err_dev_close;
@@ -339,10 +339,10 @@ int main(int argc, char *argv[])
 
 	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
 
-	erofs_put_super();
+	erofs_put_super(&sbi);
 err_dev_close:
-	blob_closeall();
-	dev_close();
+	blob_closeall(&sbi);
+	dev_close(&sbi);
 err_fuse_free_args:
 	fuse_opt_free_args(&args);
 err:
diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 4269d82..7c5645e 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -18,10 +18,10 @@ struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
 			unsigned int device_id, erofs_blk_t blkaddr);
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd);
-int erofs_blob_remap(void);
+int erofs_blob_remap(struct erofs_sb_info *sbi);
 void erofs_blob_exit(void);
 int erofs_blob_init(const char *blobfile_path);
-int erofs_generate_devtable(void);
+int erofs_generate_devtable(struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 8c3bd46..dc29985 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -57,14 +57,14 @@ struct erofs_buffer_block {
 static inline const int get_alignsize(int type, int *type_ret)
 {
 	if (type == DATA)
-		return erofs_blksiz();
+		return erofs_blksiz(&sbi);
 
 	if (type == INODE) {
 		*type_ret = META;
 		return sizeof(struct erofs_inode_compact);
 	} else if (type == DIRA) {
 		*type_ret = META;
-		return erofs_blksiz();
+		return erofs_blksiz(&sbi);
 	} else if (type == XATTR) {
 		*type_ret = META;
 		return sizeof(struct erofs_xattr_entry);
@@ -88,7 +88,7 @@ static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 	if (bb->blkaddr == NULL_ADDR)
 		return NULL_ADDR_UL;
 
-	return erofs_pos(bb->blkaddr) +
+	return erofs_pos(&sbi, bb->blkaddr) +
 		(end ? list_next_entry(bh, list)->off : bh->off);
 }
 
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 08af9e3..8ac93f5 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -19,18 +19,20 @@ extern "C"
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
-int z_erofs_compress_init(struct erofs_buffer_head *bh);
+int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_available_compressors(unsigned int i);
 
 static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 {
+	erofs_nid_t packed_nid = inode->sbi->packed_nid;
+
 	if (inode->nid == EROFS_PACKED_NID_UNALLOCATED) {
-		DBG_BUGON(sbi.packed_nid != EROFS_PACKED_NID_UNALLOCATED);
+		DBG_BUGON(packed_nid != EROFS_PACKED_NID_UNALLOCATED);
 		return true;
 	}
-	return (sbi.packed_nid > 0 && inode->nid == sbi.packed_nid);
+	return (packed_nid > 0 && inode->nid == packed_nid);
 }
 
 #ifdef __cplusplus
diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
index d836f22..9f0d8ae 100644
--- a/include/erofs/compress_hints.h
+++ b/include/erofs/compress_hints.h
@@ -25,7 +25,7 @@ struct erofs_compress_hints {
 
 bool z_erofs_apply_compress_hints(struct erofs_inode *inode);
 void erofs_cleanup_compress_hints(void);
-int erofs_load_compress_hints(void);
+int erofs_load_compress_hints(struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index a9067cb..0d55483 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -14,6 +14,7 @@ extern "C"
 #include "internal.h"
 
 struct z_erofs_decompress_req {
+	struct erofs_sb_info *sbi;
 	char *in, *out;
 
 	/*
diff --git a/include/erofs/dir.h b/include/erofs/dir.h
index 74bffb5..5460ac4 100644
--- a/include/erofs/dir.h
+++ b/include/erofs/dir.h
@@ -62,7 +62,8 @@ struct erofs_dir_context {
 /* Iterate over inodes that are in directory */
 int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck);
 /* Get a full pathname of the inode NID */
-int erofs_get_pathname(erofs_nid_t nid, char *buf, size_t size);
+int erofs_get_pathname(struct erofs_sb_info *sbi, erofs_nid_t nid,
+		       char *buf, size_t size);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 23f64b7..4ca7337 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -44,12 +44,11 @@ typedef u32 erofs_blk_t;
 /* global sbi */
 extern struct erofs_sb_info sbi;
 
-#define erofs_blksiz()		(1u << sbi.blkszbits)
-#define erofs_blknr(addr)       ((addr) >> sbi.blkszbits)
-#define erofs_blkoff(addr)      ((addr) & (erofs_blksiz() - 1))
-#define erofs_pos(nr)           ((erofs_off_t)(nr) << sbi.blkszbits)
-
-#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, 1u << sbi.blkszbits)
+#define erofs_blksiz(sbi)	(1u << (sbi)->blkszbits)
+#define erofs_blknr(sbi, addr)  ((addr) >> (sbi)->blkszbits)
+#define erofs_blkoff(sbi, addr) ((addr) & (erofs_blksiz(sbi) - 1))
+#define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
+#define BLK_ROUND_UP(sbi, addr)	DIV_ROUND_UP(addr, erofs_blksiz(sbi))
 
 struct erofs_buffer_head;
 
@@ -61,6 +60,12 @@ struct erofs_device_info {
 #define EROFS_PACKED_NID_UNALLOCATED	-1
 
 struct erofs_sb_info {
+	const char *devname;
+	int devfd;
+	u64 devsz;
+	unsigned int nblobs;
+	unsigned int blobfd[256];
+
 	struct erofs_device_info *devs;
 
 	u64 total_blocks;
@@ -104,17 +109,17 @@ struct erofs_sb_info {
 extern int erofs_assert_largefile[sizeof(off_t)-8];
 
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
-static inline bool erofs_sb_has_##name(void) \
+static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 { \
-	return sbi.feature_##compat & EROFS_FEATURE_##feature; \
+	return sbi->feature_##compat & EROFS_FEATURE_##feature; \
 } \
-static inline void erofs_sb_set_##name(void) \
+static inline void erofs_sb_set_##name(struct erofs_sb_info *sbi) \
 { \
-	sbi.feature_##compat |= EROFS_FEATURE_##feature; \
+	sbi->feature_##compat |= EROFS_FEATURE_##feature; \
 } \
-static inline void erofs_sb_clear_##name(void) \
+static inline void erofs_sb_clear_##name(struct erofs_sb_info *sbi) \
 { \
-	sbi.feature_##compat &= ~EROFS_FEATURE_##feature; \
+	sbi->feature_##compat &= ~EROFS_FEATURE_##feature; \
 }
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_ZERO_PADDING)
@@ -143,6 +148,7 @@ struct erofs_inode {
 		u32 subdirs_queued;
 	};
 	unsigned int i_count;
+	struct erofs_sb_info *sbi;
 	struct erofs_inode *i_parent;
 
 	umode_t i_mode;
@@ -216,7 +222,9 @@ struct erofs_inode {
 
 static inline erofs_off_t iloc(struct erofs_inode *inode)
 {
-	return erofs_pos(sbi.meta_blkaddr) + (inode->nid << sbi.islotbits);
+	struct erofs_sb_info *sbi = inode->sbi;
+
+	return erofs_pos(sbi, sbi->meta_blkaddr) + (inode->nid << sbi->islotbits);
 }
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
@@ -336,22 +344,21 @@ struct erofs_map_dev {
 };
 
 /* super.c */
-int erofs_read_superblock(void);
-void erofs_put_super(void);
+int erofs_read_superblock(struct erofs_sb_info *sbi);
+void erofs_put_super(struct erofs_sb_info *sbi);
 
 /* namei.c */
-int erofs_read_inode_from_disk(struct erofs_inode *vi);
-int erofs_ilookup(const char *path, struct erofs_inode *vi);
-int erofs_read_inode_from_disk(struct erofs_inode *vi);
+int erofs_read_inode_from_disk(struct erofs_sb_info *sbi, struct erofs_inode *vi);
+int erofs_ilookup(struct erofs_sb_info *sbi, const char *path, struct erofs_inode *vi);
 
 /* data.c */
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
-int erofs_map_dev(struct erofs_map_dev *map);
-int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
-			size_t len);
+int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
+			char *buffer, u64 offset, size_t len);
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
 			erofs_off_t skip, erofs_off_t length, bool trimmed);
@@ -368,7 +375,7 @@ static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 		break;
 	case EROFS_INODE_COMPRESSED_FULL:
 	case EROFS_INODE_COMPRESSED_COMPACT:
-		*size = inode->u.i_blocks * erofs_blksiz();
+		*size = inode->u.i_blocks * erofs_blksiz(inode->sbi);
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 36210a3..4db5716 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -22,34 +22,36 @@ extern "C"
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
-
-extern int erofs_devfd;
+void blob_closeall(struct erofs_sb_info *sbi);
+int blob_open_ro(struct erofs_sb_info *sbi, const char *dev);
+int dev_open(struct erofs_sb_info *sbi, const char *devname);
+int dev_open_ro(struct erofs_sb_info *sbi, const char *dev);
+void dev_close(struct erofs_sb_info *sbi);
+int dev_write(struct erofs_sb_info *sbi, const void *buf,
+	      u64 offset, size_t len);
+int dev_read(struct erofs_sb_info *sbi, int device_id,
+	     void *buf, u64 offset, size_t len);
+int dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
+		 size_t len, bool padding);
+int dev_fsync(struct erofs_sb_info *sbi);
+int dev_resize(struct erofs_sb_info *sbi, erofs_blk_t nblocks);
 
 ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
 			      int fd_out, erofs_off_t *off_out,
 			      size_t length);
 
-static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
-			    u32 nblocks)
+static inline int blk_write(struct erofs_sb_info *sbi, const void *buf,
+			    erofs_blk_t blkaddr, u32 nblocks)
 {
-	return dev_write(buf, erofs_pos(blkaddr), erofs_pos(nblocks));
+	return dev_write(sbi, buf, erofs_pos(sbi, blkaddr),
+			 erofs_pos(sbi, nblocks));
 }
 
-static inline int blk_read(int device_id, void *buf,
+static inline int blk_read(struct erofs_sb_info *sbi, int device_id, void *buf,
 			   erofs_blk_t start, u32 nblocks)
 {
-	return dev_read(device_id, buf, erofs_pos(start), erofs_pos(nblocks));
+	return dev_read(sbi, device_id, buf, erofs_pos(sbi, start),
+			erofs_pos(sbi, nblocks));
 }
 
 #ifdef __cplusplus
diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 268c57b..a14f8ac 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -23,7 +23,7 @@ struct erofs_tarfile {
 
 int tarerofs_init_empty_dir(struct erofs_inode *inode);
 int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar);
-int tarerofs_reserve_devtable(unsigned int devices);
-int tarerofs_write_devtable(struct erofs_tarfile *tar);
+int tarerofs_reserve_devtable(struct erofs_sb_info *sbi, unsigned int devices);
+int tarerofs_write_devtable(struct erofs_sb_info *sbi, struct erofs_tarfile *tar);
 
 #endif
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 27e14bf..dc27cf6 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -24,15 +24,17 @@ static inline unsigned int inlinexattr_header_size(struct erofs_inode *vi)
 		sizeof(u32) * vi->xattr_shared_count;
 }
 
-static inline erofs_blk_t xattrblock_addr(unsigned int xattr_id)
+static inline erofs_blk_t xattrblock_addr(struct erofs_inode *vi,
+					  unsigned int xattr_id)
 {
-	return sbi.xattr_blkaddr +
-		((xattr_id * sizeof(__u32)) >> sbi.blkszbits);
+	return vi->sbi->xattr_blkaddr +
+		erofs_blknr(vi->sbi, xattr_id * sizeof(__u32));
 }
 
-static inline unsigned int xattrblock_offset(unsigned int xattr_id)
+static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
+					     unsigned int xattr_id)
 {
-	return (xattr_id * sizeof(__u32)) & (erofs_blksiz() - 1);
+	return erofs_blkoff(vi->sbi, xattr_id * sizeof(__u32));
 }
 
 #define EROFS_INODE_XATTR_ICOUNT(_size)	({\
@@ -75,11 +77,11 @@ static inline unsigned int xattrblock_offset(unsigned int xattr_id)
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
-int erofs_build_shared_xattrs_from_path(const char *path);
+int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path);
 
 int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
-int erofs_xattr_write_name_prefixes(FILE *f);
+int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f);
 
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 1d91a67..8a7416f 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -50,8 +50,8 @@ struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
 	return chunk;
 }
 
-static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
-		erofs_off_t chunksize)
+static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
+		int fd, erofs_off_t chunksize)
 {
 	static u8 zeroed[EROFS_MAX_BLOCK_SIZE];
 	u8 *chunkdata, sha256[32];
@@ -84,17 +84,17 @@ static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 
 	chunk->chunksize = chunksize;
 	blkpos = ftell(blobfile);
-	DBG_BUGON(erofs_blkoff(blkpos));
+	DBG_BUGON(erofs_blkoff(sbi, blkpos));
 	chunk->device_id = 0;
-	chunk->blkaddr = erofs_blknr(blkpos);
+	chunk->blkaddr = erofs_blknr(sbi, blkpos);
 	memcpy(chunk->sha256, sha256, sizeof(sha256));
 	hashmap_entry_init(&chunk->ent, hash);
 	hashmap_add(&blob_hashmap, chunk);
 
 	erofs_dbg("Writing chunk (%u bytes) to %u", chunksize, chunk->blkaddr);
 	ret = fwrite(chunkdata, chunksize, 1, blobfile);
-	if (ret == 1 && erofs_blkoff(chunksize))
-		ret = fwrite(zeroed, erofs_blksiz() - erofs_blkoff(chunksize),
+	if (ret == 1 && erofs_blkoff(sbi, chunksize))
+		ret = fwrite(zeroed, erofs_blksiz(sbi) - erofs_blkoff(sbi, chunksize),
 			     1, blobfile);
 	if (ret < 1) {
 		hashmap_remove(&blob_hashmap, &chunk->ent);
@@ -182,11 +182,12 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	erofs_droid_blocklist_write_extent(inode, extent_start, extents_blks,
 					   first_extent, true);
 
-	return dev_write(inode->chunkindexes, off, inode->extent_isize);
+	return dev_write(inode->sbi, inode->chunkindexes, off, inode->extent_isize);
 }
 
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int chunkbits = cfg.c_chunkbits;
 	unsigned int count, unit;
 	struct erofs_inode_chunk_index *idx;
@@ -197,15 +198,15 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 	/* if the file is fully sparsed, use one big chunk instead */
 	if (lseek(fd, 0, SEEK_DATA) < 0 && errno == ENXIO) {
 		chunkbits = ilog2(inode->i_size - 1) + 1;
-		if (chunkbits < sbi.blkszbits)
-			chunkbits = sbi.blkszbits;
+		if (chunkbits < sbi->blkszbits)
+			chunkbits = sbi->blkszbits;
 	}
 #endif
-	if (chunkbits - sbi.blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
-		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi.blkszbits;
+	if (chunkbits - sbi->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
-	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
+	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
 	if (multidev)
 		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
 
@@ -246,7 +247,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 #endif
 
 		len = min_t(u64, inode->i_size - pos, chunksize);
-		chunk = erofs_blob_getchunk(fd, len);
+		chunk = erofs_blob_getchunk(sbi, fd, len);
 		if (IS_ERR(chunk)) {
 			ret = PTR_ERR(chunk);
 			goto err;
@@ -263,7 +264,7 @@ err:
 	return ret;
 }
 
-int erofs_blob_remap(void)
+int erofs_blob_remap(struct erofs_sb_info *sbi)
 {
 	struct erofs_buffer_head *bh;
 	ssize_t length;
@@ -276,11 +277,11 @@ int erofs_blob_remap(void)
 		return -errno;
 	if (multidev) {
 		struct erofs_deviceslot dis = {
-			.blocks = erofs_blknr(length),
+			.blocks = erofs_blknr(sbi, length),
 		};
 
 		pos_out = erofs_btell(bh_devt, false);
-		ret = dev_write(&dis, pos_out, sizeof(dis));
+		ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
 		if (ret)
 			return ret;
 
@@ -297,9 +298,9 @@ int erofs_blob_remap(void)
 	erofs_mapbh(bh->block);
 	pos_out = erofs_btell(bh, false);
 	pos_in = 0;
-	remapped_base = erofs_blknr(pos_out);
+	remapped_base = erofs_blknr(sbi, pos_out);
 	ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
-				    erofs_devfd, &pos_out, length);
+				    sbi->devfd, &pos_out, length);
 	bh->op = &erofs_drop_directly_bhops;
 	erofs_bdrop(bh, false);
 	return ret < length ? -EIO : 0;
@@ -348,7 +349,7 @@ int erofs_blob_init(const char *blobfile_path)
 	return 0;
 }
 
-int erofs_generate_devtable(void)
+int erofs_generate_devtable(struct erofs_sb_info *sbi)
 {
 	struct erofs_deviceslot dis;
 
@@ -362,8 +363,8 @@ int erofs_generate_devtable(void)
 	dis = (struct erofs_deviceslot) {};
 	erofs_mapbh(bh_devt->block);
 	bh_devt->op = &erofs_skip_write_bhops;
-	sbi.devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
-	sbi.extra_devices = 1;
-	erofs_sb_set_device_table();
+	sbi->devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
+	sbi->extra_devices = 1;
+	erofs_sb_set_device_table(sbi);
 	return 0;
 }
diff --git a/lib/cache.c b/lib/cache.c
index 178bd5a..681ba76 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -63,7 +63,7 @@ static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
 	if (bb->blkaddr == NULL_ADDR)
 		return;
 
-	bkt = mapped_buckets[bb->type] + bb->buffers.off % erofs_blksiz();
+	bkt = mapped_buckets[bb->type] + bb->buffers.off % erofs_blksiz(&sbi);
 	list_del(&bb->mapped_list);
 	list_add_tail(&bb->mapped_list, bkt);
 }
@@ -77,9 +77,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   bool dryrun)
 {
 	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = cmpsgn(roundup((bb->buffers.off - 1) % erofs_blksiz() + 1,
+	const int oob = cmpsgn(roundup((bb->buffers.off - 1) % erofs_blksiz(&sbi) + 1,
 				       alignsize) + incr + extrasize,
-			       erofs_blksiz());
+			       erofs_blksiz(&sbi));
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
 
@@ -91,7 +91,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		blkaddr = bb->blkaddr;
 		if (blkaddr != NULL_ADDR) {
 			tailupdate = (tail_blkaddr == blkaddr +
-				      BLK_ROUND_UP(bb->buffers.off));
+				      BLK_ROUND_UP(&sbi, bb->buffers.off));
 			if (oob && !tailupdate)
 				return -EINVAL;
 		}
@@ -106,10 +106,10 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		bb->buffers.off = alignedoffset + incr;
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
-			tail_blkaddr = blkaddr + BLK_ROUND_UP(bb->buffers.off);
+			tail_blkaddr = blkaddr + BLK_ROUND_UP(&sbi, bb->buffers.off);
 		erofs_bupdate_mapped(bb);
 	}
-	return (alignedoffset + incr - 1) % erofs_blksiz() + 1;
+	return (alignedoffset + incr - 1) % erofs_blksiz(&sbi) + 1;
 }
 
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
@@ -133,12 +133,12 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 	unsigned int used0, used_before, usedmax, used;
 	int ret;
 
-	used0 = (size + required_ext) % erofs_blksiz() + inline_ext;
+	used0 = (size + required_ext) % erofs_blksiz(&sbi) + inline_ext;
 	/* inline data should be in the same fs block */
-	if (used0 > erofs_blksiz())
+	if (used0 > erofs_blksiz(&sbi))
 		return -ENOSPC;
 
-	if (!used0 || alignsize == erofs_blksiz()) {
+	if (!used0 || alignsize == erofs_blksiz(&sbi)) {
 		*bbp = NULL;
 		return 0;
 	}
@@ -147,10 +147,10 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 	bb = NULL;
 
 	/* try to find a most-fit mapped buffer block first */
-	if (size + required_ext + inline_ext >= erofs_blksiz())
+	if (size + required_ext + inline_ext >= erofs_blksiz(&sbi))
 		goto skip_mapped;
 
-	used_before = rounddown(erofs_blksiz() -
+	used_before = rounddown(erofs_blksiz(&sbi) -
 				(size + required_ext + inline_ext), alignsize);
 	for (; used_before; --used_before) {
 		struct list_head *bt = mapped_buckets[type] + used_before;
@@ -168,7 +168,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 		DBG_BUGON(cur->type != type);
 		DBG_BUGON(cur->blkaddr == NULL_ADDR);
-		DBG_BUGON(used_before != cur->buffers.off % erofs_blksiz());
+		DBG_BUGON(used_before != cur->buffers.off % erofs_blksiz(&sbi));
 
 		ret = __erofs_battach(cur, NULL, size, alignsize,
 				      required_ext + inline_ext, true);
@@ -179,7 +179,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 		/* should contain all data in the current block */
 		used = ret + required_ext + inline_ext;
-		DBG_BUGON(used > erofs_blksiz());
+		DBG_BUGON(used > erofs_blksiz(&sbi));
 
 		bb = cur;
 		usedmax = used;
@@ -192,7 +192,7 @@ skip_mapped:
 	if (cur == &blkh)
 		cur = list_next_entry(cur, list);
 	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
-		used_before = cur->buffers.off % erofs_blksiz();
+		used_before = cur->buffers.off % erofs_blksiz(&sbi);
 
 		/* skip if buffer block is just full */
 		if (!used_before)
@@ -207,10 +207,10 @@ skip_mapped:
 		if (ret < 0)
 			continue;
 
-		used = (ret + required_ext) % erofs_blksiz() + inline_ext;
+		used = (ret + required_ext) % erofs_blksiz(&sbi) + inline_ext;
 
 		/* should contain inline data in current block */
-		if (used > erofs_blksiz())
+		if (used > erofs_blksiz(&sbi))
 			continue;
 
 		/*
@@ -323,7 +323,7 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 		erofs_bupdate_mapped(bb);
 	}
 
-	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
+	blkaddr = bb->blkaddr + BLK_ROUND_UP(&sbi, bb->buffers.off);
 	if (blkaddr > tail_blkaddr)
 		tail_blkaddr = blkaddr;
 
@@ -376,9 +376,9 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 		if (skip)
 			continue;
 
-		padding = erofs_blksiz() - p->buffers.off % erofs_blksiz();
-		if (padding != erofs_blksiz())
-			dev_fillzero(erofs_pos(blkaddr) - padding,
+		padding = erofs_blksiz(&sbi) - p->buffers.off % erofs_blksiz(&sbi);
+		if (padding != erofs_blksiz(&sbi))
+			dev_fillzero(&sbi, erofs_pos(&sbi, blkaddr) - padding,
 				     padding, true);
 
 		DBG_BUGON(!list_empty(&p->buffers.list));
@@ -400,7 +400,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 
 	/* tail_blkaddr could be rolled back after revoking all bhs */
 	if (tryrevoke && blkaddr != NULL_ADDR &&
-	    tail_blkaddr == blkaddr + BLK_ROUND_UP(bb->buffers.off))
+	    tail_blkaddr == blkaddr + BLK_ROUND_UP(&sbi, bb->buffers.off))
 		rollback = true;
 
 	bh->op = &erofs_drop_directly_bhops;
diff --git a/lib/compress.c b/lib/compress.c
index a871322..eab240e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -68,9 +68,10 @@ static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int clusterofs = ctx->clusterofs;
 	unsigned int count = ctx->e.length;
-	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz();
+	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz(sbi);
 	struct z_erofs_lcluster_index di;
 	unsigned int type, advise;
 
@@ -109,7 +110,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	do {
 		advise = 0;
 		/* XXX: big pcluster feature should be per-inode */
-		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
+		if (d0 == 1 && erofs_sb_has_big_pcluster(sbi)) {
 			type = Z_EROFS_LCLUSTER_TYPE_NONHEAD;
 			di.di_u.delta[0] = cpu_to_le16(ctx->e.compressedblks |
 						       Z_EROFS_LI_D0_CBLKCNT);
@@ -155,12 +156,12 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
-		count -= erofs_blksiz() - clusterofs;
+		count -= erofs_blksiz(sbi) - clusterofs;
 		clusterofs = 0;
 
 		++d0;
 		--d1;
-	} while (clusterofs + count >= erofs_blksiz());
+	} while (clusterofs + count >= erofs_blksiz(sbi));
 
 	ctx->clusterofs = clusterofs + count;
 }
@@ -169,6 +170,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 				   unsigned int *len)
 {
 	struct erofs_inode *inode = ctx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	int ret = 0;
 
 	/*
@@ -181,12 +183,12 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 	do {
 		struct z_erofs_dedupe_ctx dctx = {
 			.start = ctx->queue + ctx->head - ({ int rc;
-				if (ctx->e.length <= erofs_blksiz())
+				if (ctx->e.length <= erofs_blksiz(sbi))
 					rc = 0;
-				else if (ctx->e.length - erofs_blksiz() >= ctx->head)
+				else if (ctx->e.length - erofs_blksiz(sbi) >= ctx->head)
 					rc = ctx->head;
 				else
-					rc = ctx->e.length - erofs_blksiz();
+					rc = ctx->e.length - erofs_blksiz(sbi);
 				rc; }),
 			.end = ctx->queue + ctx->head + *len,
 			.cur = ctx->queue + ctx->head,
@@ -203,14 +205,14 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		 * decompresssion could be done as another try in practice.
 		 */
 		if (dctx.e.compressedblks > 1 &&
-		    (ctx->clusterofs + ctx->e.length - delta) % erofs_blksiz() +
-			dctx.e.length < 2 * erofs_blksiz())
+		    (ctx->clusterofs + ctx->e.length - delta) % erofs_blksiz(sbi) +
+			dctx.e.length < 2 * erofs_blksiz(sbi))
 			break;
 
 		/* fall back to noncompact indexes for deduplication */
 		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-		erofs_sb_set_dedupe();
+		erofs_sb_set_dedupe(sbi);
 
 		if (delta) {
 			DBG_BUGON(delta < 0);
@@ -230,7 +232,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 
 		if (ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
-				round_down(ctx->head, erofs_blksiz());
+				round_down(ctx->head, erofs_blksiz(sbi));
 			const unsigned int qh_after = ctx->head - qh_aligned;
 
 			memmove(ctx->queue, ctx->queue + qh_aligned,
@@ -251,33 +253,34 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 				     unsigned int *len, char *dst)
 {
 	int ret;
+	struct erofs_sb_info *sbi = ctx->inode->sbi;
 	unsigned int count, interlaced_offset, rightpart;
 
 	/* reset clusterofs to 0 if permitted */
-	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
+	if (!erofs_sb_has_lz4_0padding(sbi) && ctx->clusterofs &&
 	    ctx->head >= ctx->clusterofs) {
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
 		ctx->clusterofs = 0;
 	}
 
-	count = min(erofs_blksiz(), *len);
+	count = min(erofs_blksiz(sbi), *len);
 
 	/* write interlaced uncompressed data if needed */
 	if (ctx->inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
 		interlaced_offset = ctx->clusterofs;
 	else
 		interlaced_offset = 0;
-	rightpart = min(erofs_blksiz() - interlaced_offset, count);
+	rightpart = min(erofs_blksiz(sbi) - interlaced_offset, count);
 
-	memset(dst, 0, erofs_blksiz());
+	memset(dst, 0, erofs_blksiz(sbi));
 
 	memcpy(dst + interlaced_offset, ctx->queue + ctx->head, rightpart);
 	memcpy(dst, ctx->queue + ctx->head + rightpart, count - rightpart);
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
-	ret = blk_write(dst, ctx->blkaddr, 1);
+	ret = blk_write(sbi, dst, ctx->blkaddr, 1);
 	if (ret)
 		return ret;
 	return count;
@@ -315,23 +318,25 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 	return len;
 }
 
-static void tryrecompress_trailing(struct erofs_compress *ec,
+static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
+				   struct erofs_compress *ec,
 				   void *in, unsigned int *insize,
 				   void *out, int *compressedsize)
 {
+	struct erofs_sb_info *sbi = ctx->inode->sbi;
 	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
 	unsigned int count;
 	int ret = *compressedsize;
 
 	/* no need to recompress */
-	if (!(ret & (erofs_blksiz() - 1)))
+	if (!(ret & (erofs_blksiz(sbi) - 1)))
 		return;
 
 	count = *insize;
 	ret = erofs_compress_destsize(ec, in, &count, (void *)tmp,
-				      rounddown(ret, erofs_blksiz()), false);
+				      rounddown(ret, erofs_blksiz(sbi)), false);
 	if (ret <= 0 || ret + (*insize - count) >=
-			roundup(*compressedsize, erofs_blksiz()))
+			roundup(*compressedsize, erofs_blksiz(sbi)))
 		return;
 
 	/* replace the original compressed data if any gain */
@@ -344,15 +349,16 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 					   unsigned int len)
 {
 	struct erofs_inode *inode = ctx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	const unsigned int newsize = ctx->remaining + len;
 
 	DBG_BUGON(!inode->fragment_size);
 
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
-		ctx->pclustersize = min(z_erofs_get_max_pclusterblks(inode) * erofs_blksiz(),
+		ctx->pclustersize = min(z_erofs_get_max_pclusterblks(inode) * erofs_blksiz(sbi),
 					roundup(newsize - inode->fragment_size,
-						erofs_blksiz()));
+						erofs_blksiz(sbi)));
 		return false;
 	}
 
@@ -373,7 +379,8 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 {
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode *inode = ctx->inode;
-	char *const dst = dstbuf + erofs_blksiz();
+	struct erofs_sb_info *sbi = inode->sbi;
+	char *const dst = dstbuf + erofs_blksiz(sbi);
 	struct erofs_compress *const h = &ctx->ccfg->handle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
@@ -396,13 +403,13 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 			if (may_packing) {
 				if (inode->fragment_size && !fix_dedupedfrag) {
 					ctx->pclustersize =
-						roundup(len, erofs_blksiz());
+						roundup(len, erofs_blksiz(sbi));
 					goto fix_dedupedfrag;
 				}
 				ctx->e.length = len;
 				goto frag_packing;
 			}
-			if (!may_inline && len <= erofs_blksiz())
+			if (!may_inline && len <= erofs_blksiz(sbi))
 				goto nocompression;
 		}
 
@@ -418,7 +425,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 					  erofs_strerror(ret));
 			}
 
-			if (may_inline && len < erofs_blksiz()) {
+			if (may_inline && len < erofs_blksiz(sbi)) {
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
 						len, true);
@@ -455,8 +462,8 @@ frag_packing:
 			fix_dedupedfrag = false;
 		/* tailpcluster should be less than 1 block */
 		} else if (may_inline && len == ctx->e.length &&
-			   ret < erofs_blksiz()) {
-			if (ctx->clusterofs + len <= erofs_blksiz()) {
+			   ret < erofs_blksiz(sbi)) {
+			if (ctx->clusterofs + len <= erofs_blksiz(sbi)) {
 				inode->eof_tailraw = malloc(len);
 				if (!inode->eof_tailraw)
 					return -ENOMEM;
@@ -482,36 +489,36 @@ frag_packing:
 			 * Otherwise, just drop it and go to packing.
 			 */
 			if (may_packing && len == ctx->e.length &&
-			    (ret & (erofs_blksiz() - 1)) &&
+			    (ret & (erofs_blksiz(sbi) - 1)) &&
 			    ctx->tail < sizeof(ctx->queue)) {
 				ctx->pclustersize =
-					BLK_ROUND_UP(ret) * erofs_blksiz();
+					BLK_ROUND_UP(sbi, ret) * erofs_blksiz(sbi);
 				goto fix_dedupedfrag;
 			}
 
 			if (may_inline && len == ctx->e.length)
-				tryrecompress_trailing(h, ctx->queue + ctx->head,
+				tryrecompress_trailing(ctx, h, ctx->queue + ctx->head,
 						&ctx->e.length, dst, &ret);
 
-			tailused = ret & (erofs_blksiz() - 1);
+			tailused = ret & (erofs_blksiz(sbi) - 1);
 			padding = 0;
-			ctx->e.compressedblks = BLK_ROUND_UP(ret);
-			DBG_BUGON(ctx->e.compressedblks * erofs_blksiz() >=
+			ctx->e.compressedblks = BLK_ROUND_UP(sbi, ret);
+			DBG_BUGON(ctx->e.compressedblks * erofs_blksiz(sbi) >=
 				  ctx->e.length);
 
 			/* zero out garbage trailing data for non-0padding */
-			if (!erofs_sb_has_lz4_0padding())
+			if (!erofs_sb_has_lz4_0padding(sbi))
 				memset(dst + ret, 0,
-				       roundup(ret, erofs_blksiz()) - ret);
+				       roundup(ret, erofs_blksiz(sbi)) - ret);
 			else if (tailused)
-				padding = erofs_blksiz() - tailused;
+				padding = erofs_blksiz(sbi) - tailused;
 
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
 				  ctx->e.length, ctx->blkaddr,
 				  ctx->e.compressedblks);
 
-			ret = blk_write(dst - padding, ctx->blkaddr,
+			ret = blk_write(sbi, dst - padding, ctx->blkaddr,
 					ctx->e.compressedblks);
 			if (ret)
 				return ret;
@@ -534,7 +541,7 @@ frag_packing:
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
-				round_down(ctx->head, erofs_blksiz());
+				round_down(ctx->head, erofs_blksiz(sbi));
 			const unsigned int qh_after = ctx->head - qh_aligned;
 
 			memmove(ctx->queue, ctx->queue + qh_aligned,
@@ -592,10 +599,9 @@ static void *write_compacted_indexes(u8 *out,
 				     erofs_blk_t *blkaddr_ret,
 				     unsigned int destsize,
 				     unsigned int logical_clusterbits,
-				     bool final, bool *dummy_head)
+				     bool final, bool *dummy_head, bool update_blkaddr)
 {
 	unsigned int vcnt, encodebits, pos, i, cblks;
-	bool update_blkaddr;
 	erofs_blk_t blkaddr;
 
 	if (destsize == 4)
@@ -606,7 +612,6 @@ static void *write_compacted_indexes(u8 *out,
 		return ERR_PTR(-EINVAL);
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
-	update_blkaddr = erofs_sb_has_big_pcluster();
 
 	pos = 0;
 	for (i = 0; i < vcnt; ++i) {
@@ -669,12 +674,14 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	const unsigned int logical_clusterbits = inode->z_logical_clusterbits;
 	u8 *out, *in;
 	struct z_erofs_compressindex_vec cv[16];
+	struct erofs_sb_info *sbi = inode->sbi;
 	/* # of 8-byte units so that it can be aligned with 32 bytes */
 	unsigned int compacted_4b_initial, compacted_4b_end;
 	unsigned int compacted_2b;
 	bool dummy_head;
+	bool big_pcluster = erofs_sb_has_big_pcluster(sbi);
 
-	if (logical_clusterbits < sbi.blkszbits || sbi.blkszbits < 12)
+	if (logical_clusterbits < sbi->blkszbits || sbi->blkszbits < 12)
 		return -EINVAL;
 	if (logical_clusterbits > 14) {
 		erofs_err("compact format is unsupported for lcluster size %u",
@@ -714,7 +721,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	dummy_head = false;
 	/* prior to bigpcluster, blkaddr was bumped up once coming into HEAD */
-	if (!erofs_sb_has_big_pcluster()) {
+	if (!big_pcluster) {
 		--blkaddr;
 		dummy_head = true;
 	}
@@ -724,7 +731,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 2, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      4, logical_clusterbits, false,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 		compacted_4b_initial -= 2;
 	}
 	DBG_BUGON(compacted_4b_initial);
@@ -734,7 +741,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 16, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      2, logical_clusterbits, false,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 		compacted_2b -= 16;
 	}
 	DBG_BUGON(compacted_2b);
@@ -744,7 +751,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 2, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      4, logical_clusterbits, false,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 		compacted_4b_end -= 2;
 	}
 
@@ -754,7 +761,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 1, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      4, logical_clusterbits, true,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 	}
 	inode->extent_isize = out - (u8 *)compressmeta;
 	return 0;
@@ -763,12 +770,13 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 static void z_erofs_write_mapheader(struct erofs_inode *inode,
 				    void *compressmeta)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
-		.h_clusterbits = inode->z_logical_clusterbits - sbi.blkszbits,
+		.h_clusterbits = inode->z_logical_clusterbits - sbi->blkszbits,
 	};
 
 	if (inode->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
@@ -783,6 +791,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_map_header *h = inode->compressmeta;
 
@@ -808,12 +817,12 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 		u8 *out;
 
 		eofs = inode->extent_isize -
-			(4 << (BLK_ROUND_UP(inode->i_size) & 1));
+			(4 << (BLK_ROUND_UP(sbi, inode->i_size) & 1));
 		base = round_down(eofs, 8);
 		pos = 16 /* encodebits */ * ((eofs - base) / 4);
 		out = inode->compressmeta + base;
-		lo = get_unaligned_le32(out + pos / 8) & (erofs_blksiz() - 1);
-		v = (type << sbi.blkszbits) | lo;
+		lo = erofs_blkoff(sbi, get_unaligned_le32(out + pos / 8));
+		v = (type << sbi->blkszbits) | lo;
 		out[pos / 8] = v & 0xff;
 		out[pos / 8 + 1] = v >> 8;
 	} else {
@@ -835,7 +844,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
 	int ret;
-	u8 *compressmeta = malloc(BLK_ROUND_UP(inode->i_size) *
+	struct erofs_sb_info *sbi = inode->sbi;
+	u8 *compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
 				  sizeof(struct z_erofs_lcluster_index) +
 				  Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 
@@ -851,7 +861,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
-	inode->z_logical_clusterbits = sbi.blkszbits;
+	inode->z_logical_clusterbits = sbi->blkszbits;
 	if (!cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
 		if (inode->z_logical_clusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
@@ -860,7 +870,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 	}
 
-	if (erofs_sb_has_big_pcluster()) {
+	if (erofs_sb_has_big_pcluster(sbi)) {
 		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
@@ -897,7 +907,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
-	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * erofs_blksiz();
+	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * erofs_blksiz(sbi);
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
@@ -950,7 +960,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size &&
-	    compressed_blocks * erofs_blksiz() + inode->idata_size +
+	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
 	    legacymetasize >= inode->i_size) {
 		z_erofs_dedupe_commit(true);
 		ret = -ENOSPC;
@@ -969,8 +979,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	}
 
 	if (compressed_blocks) {
-		ret = erofs_bh_balloon(bh, erofs_pos(compressed_blocks));
-		DBG_BUGON(ret != erofs_blksiz());
+		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
+		DBG_BUGON(ret != erofs_blksiz(sbi));
 	} else {
 		if (!cfg.c_fragments && !cfg.c_dedupe)
 			DBG_BUGON(!inode->idata_size);
@@ -1025,12 +1035,13 @@ static int erofs_get_compress_algorithm_id(const char *name)
 	return -ENOTSUP;
 }
 
-int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
+static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
+				    struct erofs_buffer_head *sb_bh)
 {
 	struct erofs_buffer_head *bh = sb_bh;
 	int ret = 0;
 
-	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
+	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
 		struct {
 			__le16 size;
 			struct z_erofs_lz4_cfgs lz4;
@@ -1038,7 +1049,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			.size = cpu_to_le16(sizeof(struct z_erofs_lz4_cfgs)),
 			.lz4 = {
 				.max_distance =
-					cpu_to_le16(sbi.lz4_max_distance),
+					cpu_to_le16(sbi->lz4_max_distance),
 				.max_pclusterblks = cfg.c_pclusterblks_max,
 			}
 		};
@@ -1049,12 +1060,12 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(&lz4alg, erofs_btell(bh, false),
+		ret = dev_write(sbi, &lz4alg, erofs_btell(bh, false),
 				sizeof(lz4alg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
 #ifdef HAVE_LIBLZMA
-	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZMA)) {
+	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZMA)) {
 		struct {
 			__le16 size;
 			struct z_erofs_lzma_cfgs lzma;
@@ -1071,12 +1082,12 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(&lzmaalg, erofs_btell(bh, false),
+		ret = dev_write(sbi, &lzmaalg, erofs_btell(bh, false),
 				sizeof(lzmaalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
 #endif
-	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_DEFLATE)) {
+	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_DEFLATE)) {
 		struct {
 			__le16 size;
 			struct z_erofs_deflate_cfgs z;
@@ -1094,19 +1105,19 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(&zalg, erofs_btell(bh, false),
+		ret = dev_write(sbi, &zalg, erofs_btell(bh, false),
 				sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
 	return ret;
 }
 
-int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
+int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 {
 	int i, ret;
 
 	for (i = 0; cfg.c_compr_alg[i]; ++i) {
-		ret = erofs_compressor_init(&erofs_ccfg[i].handle,
+		ret = erofs_compressor_init(sbi, &erofs_ccfg[i].handle,
 					     cfg.c_compr_alg[i]);
 		if (ret)
 			return ret;
@@ -1121,9 +1132,9 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 			return ret;
 		erofs_ccfg[i].algorithmtype = ret;
 		erofs_ccfg[i].enable = true;
-		sbi.available_compr_algs |= 1 << ret;
+		sbi->available_compr_algs |= 1 << ret;
 		if (ret != Z_EROFS_COMPRESSION_LZ4)
-			erofs_sb_set_compr_cfgs();
+			erofs_sb_set_compr_cfgs(sbi);
 	}
 
 	/*
@@ -1132,7 +1143,7 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	 */
 	if (!cfg.c_compr_alg[0] ||
 	    (cfg.c_legacy_compress && !strncmp(cfg.c_compr_alg[0], "lz4", 3)))
-		erofs_sb_clear_lz4_0padding();
+		erofs_sb_clear_lz4_0padding(sbi);
 
 	if (!cfg.c_compr_alg[0])
 		return 0;
@@ -1143,21 +1154,21 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	 */
 	if (cfg.c_pclusterblks_max > 1) {
 		if (cfg.c_pclusterblks_max >
-		    Z_EROFS_PCLUSTER_MAX_SIZE / erofs_blksiz()) {
+		    Z_EROFS_PCLUSTER_MAX_SIZE / erofs_blksiz(sbi)) {
 			erofs_err("unsupported clusterblks %u (too large)",
 				  cfg.c_pclusterblks_max);
 			return -EINVAL;
 		}
-		erofs_sb_set_big_pcluster();
+		erofs_sb_set_big_pcluster(sbi);
 	}
 	if (cfg.c_pclusterblks_packed > cfg.c_pclusterblks_max) {
 		erofs_err("invalid physical cluster size for the packed file");
 		return -EINVAL;
 	}
 
-	if (erofs_sb_has_compr_cfgs()) {
-		sbi.available_compr_algs |= 1 << ret;
-		return z_erofs_build_compr_cfgs(sb_bh);
+	if (erofs_sb_has_compr_cfgs(sbi)) {
+		sbi->available_compr_algs |= 1 << ret;
+		return z_erofs_build_compr_cfgs(sbi, sb_bh);
 	}
 	return 0;
 }
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 0182e93..f549604 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -86,7 +86,7 @@ void erofs_cleanup_compress_hints(void)
 	}
 }
 
-int erofs_load_compress_hints(void)
+int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 {
 	char buf[PATH_MAX + 100];
 	FILE *f;
@@ -133,21 +133,21 @@ int erofs_load_compress_hints(void)
 			}
 		}
 
-		if (pclustersize % erofs_blksiz()) {
+		if (pclustersize % erofs_blksiz(sbi)) {
 			erofs_warn("invalid physical clustersize %u, "
 				   "use default pclusterblks %u",
 				   pclustersize, cfg.c_pclusterblks_def);
 			continue;
 		}
 		erofs_insert_compress_hints(pattern,
-					    pclustersize / erofs_blksiz(), ccfg);
+					    pclustersize / erofs_blksiz(sbi), ccfg);
 
 		if (pclustersize > max_pclustersize)
 			max_pclustersize = pclustersize;
 	}
 
-	if (cfg.c_pclusterblks_max * erofs_blksiz() < max_pclustersize) {
-		cfg.c_pclusterblks_max = max_pclustersize / erofs_blksiz();
+	if (cfg.c_pclusterblks_max * erofs_blksiz(sbi) < max_pclustersize) {
+		cfg.c_pclusterblks_max = max_pclustersize / erofs_blksiz(sbi);
 		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
 	}
 out:
diff --git a/lib/compressor.c b/lib/compressor.c
index f81db5b..4333f26 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -42,10 +42,10 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	if (ret < 0)
 		return ret;
 
-	/* XXX: ret >= erofs_blksiz() is a temporary hack for ztailpacking */
-	if (inblocks || ret >= erofs_blksiz() ||
+	/* XXX: ret >= destsize_alignsize is a temporary hack for ztailpacking */
+	if (inblocks || ret >= c->destsize_alignsize ||
 	    uncompressed_capacity != *srcsize)
-		compressed_size = roundup(ret, erofs_blksiz());
+		compressed_size = roundup(ret, c->destsize_alignsize);
 	else
 		compressed_size = ret;
 	DBG_BUGON(c->compress_threshold < 100);
@@ -72,16 +72,19 @@ int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
 	return 0;
 }
 
-int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
+int erofs_compressor_init(struct erofs_sb_info *sbi,
+			  struct erofs_compress *c, char *alg_name)
 {
 	int ret, i;
 
+	c->sbi = sbi;
+
 	/* should be written in "minimum compression ratio * 100" */
 	c->compress_threshold = 100;
 
 	/* optimize for 4k size page */
-	c->destsize_alignsize = erofs_blksiz();
-	c->destsize_redzone_begin = erofs_blksiz() - 16;
+	c->destsize_alignsize = erofs_blksiz(sbi);
+	c->destsize_redzone_begin = erofs_blksiz(sbi) - 16;
 	c->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
 
 	if (!alg_name) {
diff --git a/lib/compressor.h b/lib/compressor.h
index f699fe7..08a3988 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -27,6 +27,7 @@ struct erofs_compressor {
 };
 
 struct erofs_compress {
+	struct erofs_sb_info *sbi;
 	const struct erofs_compressor *alg;
 
 	unsigned int compress_threshold;
@@ -52,7 +53,8 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 			    void *dst, unsigned int dstsize, bool inblocks);
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
-int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
+int erofs_compressor_init(struct erofs_sb_info *sbi,
+		struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
 
 #endif
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index b6f6e7e..e507b70 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -33,7 +33,7 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 static int compressor_lz4_init(struct erofs_compress *c)
 {
 	c->alg = &erofs_compressor_lz4;
-	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
+	c->sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index eec1c84..f2120d8 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -44,7 +44,7 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	if (!c->private_data)
 		return -ENOMEM;
 
-	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
+	c->sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/lib/data.c b/lib/data.c
index cc8ff2b..afaa4c3 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -18,27 +18,28 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
 	struct erofs_inode *vi = inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
 
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
 
-	nblocks = BLK_ROUND_UP(inode->i_size);
+	nblocks = BLK_ROUND_UP(sbi, inode->i_size);
 	lastblk = nblocks - tailendpacking;
 
 	/* there is no hole in flatmode */
 	map->m_flags = EROFS_MAP_MAPPED;
 
-	if (offset < erofs_pos(lastblk)) {
-		map->m_pa = erofs_pos(vi->u.i_blkaddr) + map->m_la;
-		map->m_plen = erofs_pos(lastblk) - offset;
+	if (offset < erofs_pos(sbi, lastblk)) {
+		map->m_pa = erofs_pos(sbi, vi->u.i_blkaddr) + map->m_la;
+		map->m_plen = erofs_pos(sbi, lastblk) - offset;
 	} else if (tailendpacking) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
 		map->m_pa = iloc(vi) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(map->m_la);
+			vi->xattr_isize + erofs_blkoff(sbi, map->m_la);
 		map->m_plen = inode->i_size - offset;
 
 		/* inline data should be located in the same meta block */
-		if (erofs_blkoff(map->m_pa) + map->m_plen > erofs_blksiz()) {
+		if (erofs_blkoff(sbi, map->m_pa) + map->m_plen > erofs_blksiz(sbi)) {
 			erofs_err("inline data cross block boundary @ nid %" PRIu64,
 				  vi->nid);
 			DBG_BUGON(1);
@@ -65,6 +66,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_inode_chunk_index *idx;
 	u8 buf[EROFS_MAX_BLOCK_SIZE];
 	u64 chunknr;
@@ -92,36 +94,36 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	pos = roundup(iloc(vi) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
-	err = blk_read(0, buf, erofs_blknr(pos), 1);
+	err = blk_read(sbi, 0, buf, erofs_blknr(sbi, pos), 1);
 	if (err < 0)
 		return -EIO;
 
 	map->m_la = chunknr << vi->u.chunkbits;
 	map->m_plen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
-			    roundup(inode->i_size - map->m_la, erofs_blksiz()));
+			    roundup(inode->i_size - map->m_la, erofs_blksiz(sbi)));
 
 	/* handle block map */
 	if (!(vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
-		__le32 *blkaddr = (void *)buf + erofs_blkoff(pos);
+		__le32 *blkaddr = (void *)buf + erofs_blkoff(sbi, pos);
 
 		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
 			map->m_flags = 0;
 		} else {
-			map->m_pa = erofs_pos(le32_to_cpu(*blkaddr));
+			map->m_pa = erofs_pos(sbi, le32_to_cpu(*blkaddr));
 			map->m_flags = EROFS_MAP_MAPPED;
 		}
 		goto out;
 	}
 	/* parse chunk indexes */
-	idx = (void *)buf + erofs_blkoff(pos);
+	idx = (void *)buf + erofs_blkoff(sbi, pos);
 	switch (le32_to_cpu(idx->blkaddr)) {
 	case EROFS_NULL_ADDR:
 		map->m_flags = 0;
 		break;
 	default:
 		map->m_deviceid = le16_to_cpu(idx->device_id) &
-			sbi.device_id_mask;
-		map->m_pa = erofs_pos(le32_to_cpu(idx->blkaddr));
+			sbi->device_id_mask;
+		map->m_pa = erofs_pos(sbi, le32_to_cpu(idx->blkaddr));
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
 	}
@@ -130,23 +132,23 @@ out:
 	return err;
 }
 
-int erofs_map_dev(struct erofs_map_dev *map)
+int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 {
 	struct erofs_device_info *dif;
 	int id;
 
 	if (map->m_deviceid) {
-		if (sbi.extra_devices < map->m_deviceid)
+		if (sbi->extra_devices < map->m_deviceid)
 			return -ENODEV;
-	} else if (sbi.extra_devices) {
-		for (id = 0; id < sbi.extra_devices; ++id) {
+	} else if (sbi->extra_devices) {
+		for (id = 0; id < sbi->extra_devices; ++id) {
 			erofs_off_t startoff, length;
 
-			dif = sbi.devs + id;
+			dif = sbi->devs + id;
 			if (!dif->mapped_blkaddr)
 				continue;
-			startoff = erofs_pos(dif->mapped_blkaddr);
-			length = erofs_pos(dif->blocks);
+			startoff = erofs_pos(sbi, dif->mapped_blkaddr);
+			length = erofs_pos(sbi, dif->blocks);
 
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
@@ -158,9 +160,10 @@ int erofs_map_dev(struct erofs_map_dev *map)
 	return 0;
 }
 
-int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
-			size_t len)
+int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
+			char *buffer, u64 offset, size_t len)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_dev mdev;
 	int ret;
 
@@ -168,11 +171,11 @@ int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
 		.m_deviceid = map->m_deviceid,
 		.m_pa = map->m_pa,
 	};
-	ret = erofs_map_dev(&mdev);
+	ret = erofs_map_dev(sbi, &mdev);
 	if (ret)
 		return ret;
 
-	ret = dev_read(mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
+	ret = dev_read(sbi, mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
 	if (ret < 0)
 		return -EIO;
 	return 0;
@@ -219,7 +222,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			map.m_la = ptr;
 		}
 
-		ret = erofs_read_one_data(&map, estart, moff, eend - map.m_la);
+		ret = erofs_read_one_data(inode, &map, estart, moff, eend - map.m_la);
 		if (ret)
 			return ret;
 		ptr = eend;
@@ -231,15 +234,16 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
 			erofs_off_t skip, erofs_off_t length, bool trimmed)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_dev mdev;
 	int ret = 0;
 
 	if (map->m_flags & EROFS_MAP_FRAGMENT) {
 		struct erofs_inode packed_inode = {
-			.nid = sbi.packed_nid,
+			.nid = sbi->packed_nid,
 		};
 
-		ret = erofs_read_inode_from_disk(&packed_inode);
+		ret = erofs_read_inode_from_disk(sbi, &packed_inode);
 		if (ret) {
 			erofs_err("failed to read packed inode from disk");
 			return ret;
@@ -253,23 +257,24 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	mdev = (struct erofs_map_dev) {
 		.m_pa = map->m_pa,
 	};
-	ret = erofs_map_dev(&mdev);
+	ret = erofs_map_dev(sbi, &mdev);
 	if (ret) {
 		DBG_BUGON(1);
 		return ret;
 	}
 
-	ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
+	ret = dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
 	if (ret < 0)
 		return ret;
 
 	ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+			.sbi = sbi,
 			.in = raw,
 			.out = buffer,
 			.decodedskip = skip,
 			.interlaced_offset =
 				map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
-					erofs_blkoff(map->m_la) : 0,
+					erofs_blkoff(sbi, map->m_la) : 0,
 			.inputsize = map->m_plen,
 			.decodedlength = length,
 			.alg = map->m_algorithmformat,
diff --git a/lib/decompress.c b/lib/decompress.c
index 0b41ff4..a7cf907 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -97,14 +97,15 @@ static int zerr(int ret)
 static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 {
 	int ret = 0;
+	struct erofs_sb_info *sbi = rq->sbi;
 	u8 *dest = (u8 *)rq->out;
 	u8 *src = (u8 *)rq->in;
 	u8 *buff = NULL;
 	unsigned int inputmargin = 0;
 	z_stream strm;
 
-	while (!src[inputmargin & (erofs_blksiz() - 1)])
-		if (!(++inputmargin & (erofs_blksiz() - 1)))
+	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
+		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
 			break;
 
 	if (inputmargin >= rq->inputsize)
@@ -158,6 +159,7 @@ out_inflate_end:
 static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq)
 {
 	int ret = 0;
+	struct erofs_sb_info *sbi = rq->sbi;
 	u8 *dest = (u8 *)rq->out;
 	u8 *src = (u8 *)rq->in;
 	u8 *buff = NULL;
@@ -165,8 +167,8 @@ static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq)
 	lzma_stream strm;
 	lzma_ret ret2;
 
-	while (!src[inputmargin & (erofs_blksiz() - 1)])
-		if (!(++inputmargin & (erofs_blksiz() - 1)))
+	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
+		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
 			break;
 
 	if (inputmargin >= rq->inputsize)
@@ -224,12 +226,13 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 	char *buff = NULL;
 	bool support_0padding = false;
 	unsigned int inputmargin = 0;
+	struct erofs_sb_info *sbi = rq->sbi;
 
-	if (erofs_sb_has_lz4_0padding()) {
+	if (erofs_sb_has_lz4_0padding(sbi)) {
 		support_0padding = true;
 
-		while (!src[inputmargin & (erofs_blksiz() - 1)])
-			if (!(++inputmargin & (erofs_blksiz() - 1)))
+		while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
+			if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
 				break;
 
 		if (inputmargin >= rq->inputsize)
@@ -274,22 +277,24 @@ out:
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
+	struct erofs_sb_info *sbi = rq->sbi;
+
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		unsigned int count, rightpart, skip;
 
-		/* XXX: should support inputsize >= erofs_blksiz() later */
-		if (rq->inputsize > erofs_blksiz())
+		/* XXX: should support inputsize >= erofs_blksiz(sbi) later */
+		if (rq->inputsize > erofs_blksiz(sbi))
 			return -EFSCORRUPTED;
 
-		if (rq->decodedlength > erofs_blksiz())
+		if (rq->decodedlength > erofs_blksiz(sbi))
 			return -EFSCORRUPTED;
 
 		if (rq->decodedlength < rq->decodedskip)
 			return -EFSCORRUPTED;
 
 		count = rq->decodedlength - rq->decodedskip;
-		skip = erofs_blkoff(rq->interlaced_offset + rq->decodedskip);
-		rightpart = min(erofs_blksiz() - skip, count);
+		skip = erofs_blkoff(sbi, rq->interlaced_offset + rq->decodedskip);
+		rightpart = min(erofs_blksiz(sbi) - skip, count);
 		memcpy(rq->out, rq->in + skip, rightpart);
 		memcpy(rq->out + rightpart, rq->in, count - rightpart);
 		return 0;
diff --git a/lib/dir.c b/lib/dir.c
index 6758b8d..3e87086 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -10,6 +10,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 			    bool fsck)
 {
 	struct erofs_inode *dir = ctx->dir;
+	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dirent *de = dentry_blk;
 	const struct erofs_dirent *end = dentry_blk + next_nameoff;
 	const char *prev_name = NULL;
@@ -77,8 +78,8 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 					goto out;
 				}
 				ctx->flags |= EROFS_READDIR_DOTDOT_FOUND;
-				if (sbi.root_nid == dir->nid) {
-					ctx->pnid = sbi.root_nid;
+				if (sbi->root_nid == dir->nid) {
+					ctx->pnid = sbi->root_nid;
 					ctx->flags |= EROFS_READDIR_VALID_PNID;
 				}
 				if (fsck &&
@@ -124,6 +125,7 @@ out:
 int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 {
 	struct erofs_inode *dir = ctx->dir;
+	struct erofs_sb_info *sbi = dir->sbi;
 	int err = 0;
 	erofs_off_t pos;
 	char buf[EROFS_MAX_BLOCK_SIZE];
@@ -134,9 +136,9 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 	ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
 	pos = 0;
 	while (pos < dir->i_size) {
-		erofs_blk_t lblk = erofs_blknr(pos);
+		erofs_blk_t lblk = erofs_blknr(sbi, pos);
 		erofs_off_t maxsize = min_t(erofs_off_t,
-					dir->i_size - pos, erofs_blksiz());
+					dir->i_size - pos, erofs_blksiz(sbi));
 		const struct erofs_dirent *de = (const void *)buf;
 		unsigned int nameoff;
 
@@ -149,7 +151,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= erofs_blksiz()) {
+		    nameoff >= erofs_blksiz(sbi)) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
 				  nameoff, dir->nid | 0ULL, lblk);
 			return -EFSCORRUPTED;
@@ -206,7 +208,7 @@ static int erofs_get_pathname_iter(struct erofs_dir_context *ctx)
 	if (ctx->de_ftype == EROFS_FT_DIR || ctx->de_ftype == EROFS_FT_UNKNOWN) {
 		struct erofs_inode dir = { .nid = ctx->de_nid };
 
-		ret = erofs_read_inode_from_disk(&dir);
+		ret = erofs_read_inode_from_disk(ctx->dir->sbi, &dir);
 		if (ret) {
 			erofs_err("read inode failed @ nid %llu", dir.nid | 0ULL);
 			return ret;
@@ -230,10 +232,11 @@ static int erofs_get_pathname_iter(struct erofs_dir_context *ctx)
 	return 0;
 }
 
-int erofs_get_pathname(erofs_nid_t nid, char *buf, size_t size)
+int erofs_get_pathname(struct erofs_sb_info *sbi, erofs_nid_t nid,
+		       char *buf, size_t size)
 {
 	int ret;
-	struct erofs_inode root = { .nid = sbi.root_nid };
+	struct erofs_inode root = { .nid = sbi->root_nid };
 	struct erofs_get_pathname_context pathctx = {
 		.ctx.flags = 0,
 		.ctx.dir = &root,
@@ -256,7 +259,7 @@ int erofs_get_pathname(erofs_nid_t nid, char *buf, size_t size)
 		return 0;
 	}
 
-	ret = erofs_read_inode_from_disk(&root);
+	ret = erofs_read_inode_from_disk(sbi, &root);
 	if (ret) {
 		erofs_err("read inode failed @ nid %llu", root.nid | 0ULL);
 		return ret;
diff --git a/lib/fragments.c b/lib/fragments.c
index 1d243d3..d4f6be1 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -229,7 +229,7 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 
 	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-	erofs_sb_set_fragments();
+	erofs_sb_set_fragments(inode->sbi);
 }
 
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
diff --git a/lib/inode.c b/lib/inode.c
index 0d14441..f21278b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -153,7 +153,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(type, erofs_pos(nblocks), 0, 0);
+	bh = erofs_balloc(type, erofs_pos(inode->sbi, nblocks), 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -181,6 +181,7 @@ static int comp_subdir(const void *a, const void *b)
 static int erofs_prepare_dir_layout(struct erofs_inode *dir,
 				    unsigned int nr_subdirs)
 {
+	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dentry *d, *n, **sorted_d;
 	unsigned int i;
 	unsigned int d_size = 0;
@@ -203,8 +204,8 @@ static int erofs_prepare_dir_layout(struct erofs_inode *dir,
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		int len = strlen(d->name) + sizeof(struct erofs_dirent);
 
-		if ((d_size & (erofs_blksiz() - 1)) + len > erofs_blksiz())
-			d_size = round_up(d_size, erofs_blksiz());
+		if (erofs_blkoff(sbi, d_size) + len > erofs_blksiz(sbi))
+			d_size = round_up(d_size, erofs_blksiz(sbi));
 		d_size += len;
 	}
 	dir->i_size = d_size;
@@ -213,7 +214,7 @@ static int erofs_prepare_dir_layout(struct erofs_inode *dir,
 	dir->datalayout = EROFS_INODE_FLAT_INLINE;
 
 	/* it will be used in erofs_prepare_inode_buffer */
-	dir->idata_size = d_size % erofs_blksiz();
+	dir->idata_size = d_size % erofs_blksiz(sbi);
 	return 0;
 }
 
@@ -274,18 +275,20 @@ static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
 	memset(buf + q, 0, size - q);
 }
 
-static int write_dirblock(unsigned int q, struct erofs_dentry *head,
+static int write_dirblock(struct erofs_sb_info *sbi,
+			  unsigned int q, struct erofs_dentry *head,
 			  struct erofs_dentry *end, erofs_blk_t blkaddr)
 {
 	char buf[EROFS_MAX_BLOCK_SIZE];
 
-	fill_dirblock(buf, erofs_blksiz(), q, head, end);
-	return blk_write(buf, blkaddr, 1);
+	fill_dirblock(buf, sizeof(buf), q, head, end);
+	return blk_write(sbi, buf, blkaddr, 1);
 }
 
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *const bh = inode->bh;
+	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_off_t off, meta_offset;
 
 	if (!bh || (long long)inode->nid > 0)
@@ -294,7 +297,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	meta_offset = erofs_pos(sbi.meta_blkaddr);
+	meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
 	DBG_BUGON(off < meta_offset);
 	inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 	erofs_dbg("Assign nid %llu to file %s (mode %05o)",
@@ -315,6 +318,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	struct erofs_dentry *head = list_first_entry(&dir->i_subdirs,
 						     struct erofs_dentry,
 						     d_child);
+	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dentry *d;
 	int ret;
 	unsigned int q, used, blkno;
@@ -322,7 +326,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	q = used = blkno = 0;
 
 	/* allocate dir main data */
-	ret = __allocate_inode_bh_data(dir, erofs_blknr(dir->i_size), DIRA);
+	ret = __allocate_inode_bh_data(dir, erofs_blknr(sbi, dir->i_size), DIRA);
 	if (ret)
 		return ret;
 
@@ -331,8 +335,8 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 			sizeof(struct erofs_dirent);
 
 		erofs_d_invalidate(d);
-		if (used + len > erofs_blksiz()) {
-			ret = write_dirblock(q, head, d,
+		if (used + len > erofs_blksiz(sbi)) {
+			ret = write_dirblock(sbi, q, head, d,
 					     dir->u.i_blkaddr + blkno);
 			if (ret)
 				return ret;
@@ -345,13 +349,13 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 		q += sizeof(struct erofs_dirent);
 	}
 
-	DBG_BUGON(used > erofs_blksiz());
-	if (used == erofs_blksiz()) {
-		DBG_BUGON(dir->i_size % erofs_blksiz());
+	DBG_BUGON(used > erofs_blksiz(sbi));
+	if (used == erofs_blksiz(sbi)) {
+		DBG_BUGON(dir->i_size % erofs_blksiz(sbi));
 		DBG_BUGON(dir->idata_size);
-		return write_dirblock(q, head, d, dir->u.i_blkaddr + blkno);
+		return write_dirblock(sbi, q, head, d, dir->u.i_blkaddr + blkno);
 	}
-	DBG_BUGON(used != dir->i_size % erofs_blksiz());
+	DBG_BUGON(used != dir->i_size % erofs_blksiz(sbi));
 	if (used) {
 		/* fill tail-end dir block */
 		dir->idata = malloc(used);
@@ -365,7 +369,8 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 
 int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 {
-	const unsigned int nblocks = erofs_blknr(inode->i_size);
+	struct erofs_sb_info *sbi = inode->sbi;
+	const unsigned int nblocks = erofs_blknr(sbi, inode->i_size);
 	int ret;
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
@@ -375,13 +380,13 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 		return ret;
 
 	if (nblocks)
-		blk_write(buf, inode->u.i_blkaddr, nblocks);
-	inode->idata_size = inode->i_size % erofs_blksiz();
+		blk_write(sbi, buf, inode->u.i_blkaddr, nblocks);
+	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
 		if (!inode->idata)
 			return -ENOMEM;
-		memcpy(inode->idata, buf + erofs_pos(nblocks),
+		memcpy(inode->idata, buf + erofs_pos(sbi, nblocks),
 		       inode->idata_size);
 	}
 	return 0;
@@ -399,9 +404,10 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 {
 	int ret;
 	unsigned int nblocks, i;
+	struct erofs_sb_info *sbi = inode->sbi;
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
-	nblocks = inode->i_size / erofs_blksiz();
+	nblocks = inode->i_size / erofs_blksiz(sbi);
 
 	ret = __allocate_inode_bh_data(inode, nblocks, DATA);
 	if (ret)
@@ -410,20 +416,20 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	for (i = 0; i < nblocks; ++i) {
 		char buf[EROFS_MAX_BLOCK_SIZE];
 
-		ret = read(fd, buf, erofs_blksiz());
-		if (ret != erofs_blksiz()) {
+		ret = read(fd, buf, erofs_blksiz(sbi));
+		if (ret != erofs_blksiz(sbi)) {
 			if (ret < 0)
 				return -errno;
 			return -EAGAIN;
 		}
 
-		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
+		ret = blk_write(sbi, buf, inode->u.i_blkaddr + i, 1);
 		if (ret)
 			return ret;
 	}
 
 	/* read the tail-end data */
-	inode->idata_size = inode->i_size % erofs_blksiz();
+	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
 		if (!inode->idata)
@@ -473,6 +479,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd)
 static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
+	struct erofs_sb_info *sbi = inode->sbi;
 	const u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
 	erofs_off_t off = erofs_btell(bh, false);
 	union {
@@ -559,7 +566,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		BUG_ON(1);
 	}
 
-	ret = dev_write(&u, off, inode->inode_isize);
+	ret = dev_write(sbi, &u, off, inode->inode_isize);
 	if (ret)
 		return false;
 	off += inode->inode_isize;
@@ -570,7 +577,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (IS_ERR(xattrs))
 			return false;
 
-		ret = dev_write(xattrs, off, inode->xattr_isize);
+		ret = dev_write(sbi, xattrs, off, inode->xattr_isize);
 		free(xattrs);
 		if (ret)
 			return false;
@@ -586,7 +593,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		} else {
 			/* write compression metadata */
 			off = roundup(off, 8);
-			ret = dev_write(inode->compressmeta, off,
+			ret = dev_write(sbi, inode->compressmeta, off,
 					inode->extent_isize);
 			if (ret)
 				return false;
@@ -605,6 +612,7 @@ static struct erofs_bhops erofs_write_inode_bhops = {
 
 static int erofs_prepare_tail_block(struct erofs_inode *inode)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_buffer_head *bh;
 	int ret;
 
@@ -614,8 +622,8 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	bh = inode->bh_data;
 	if (bh) {
 		/* expend a block as the tail block (should be successful) */
-		ret = erofs_bh_balloon(bh, erofs_blksiz());
-		if (ret != erofs_blksiz()) {
+		ret = erofs_bh_balloon(bh, erofs_blksiz(sbi));
+		if (ret != erofs_blksiz(sbi)) {
 			DBG_BUGON(1);
 			return -EIO;
 		}
@@ -678,7 +686,7 @@ noinline:
 			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
 				  inode->compressed_idata ? "" : "un",
 				  inode->idata_size, inode->i_srcpath);
-			erofs_sb_set_ztailpacking();
+			erofs_sb_set_ztailpacking(inode->sbi);
 		} else {
 			inode->datalayout = EROFS_INODE_FLAT_INLINE;
 			erofs_dbg("Inline tail-end data (%u bytes) to %s",
@@ -706,7 +714,7 @@ static bool erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = dev_write(inode->idata, off, inode->idata_size);
+	ret = dev_write(inode->sbi, inode->idata, off, inode->idata_size);
 	if (ret)
 		return false;
 
@@ -724,6 +732,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 
 static int erofs_write_tail_end(struct erofs_inode *inode)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_buffer_head *bh, *ibh;
 
 	bh = inode->bh_data;
@@ -744,7 +753,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		erofs_off_t pos, zero_pos;
 
 		if (!bh) {
-			bh = erofs_balloc(DATA, erofs_blksiz(), 0, 0);
+			bh = erofs_balloc(DATA, erofs_blksiz(sbi), 0, 0);
 			if (IS_ERR(bh))
 				return PTR_ERR(bh);
 			bh->op = &erofs_skip_write_bhops;
@@ -756,8 +765,8 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		} else {
 			if (inode->lazy_tailblock) {
 				/* expend a tail block (should be successful) */
-				ret = erofs_bh_balloon(bh, erofs_blksiz());
-				if (ret != erofs_blksiz()) {
+				ret = erofs_bh_balloon(bh, erofs_blksiz(sbi));
+				if (ret != erofs_blksiz(sbi)) {
 					DBG_BUGON(1);
 					return -EIO;
 				}
@@ -766,24 +775,24 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 			ret = erofs_mapbh(bh->block);
 		}
 		DBG_BUGON(ret < 0);
-		pos = erofs_btell(bh, true) - erofs_blksiz();
+		pos = erofs_btell(bh, true) - erofs_blksiz(sbi);
 
 		/* 0'ed data should be padded at head for 0padding conversion */
-		if (erofs_sb_has_lz4_0padding() && inode->compressed_idata) {
+		if (erofs_sb_has_lz4_0padding(sbi) && inode->compressed_idata) {
 			zero_pos = pos;
-			pos += erofs_blksiz() - inode->idata_size;
+			pos += erofs_blksiz(sbi) - inode->idata_size;
 		} else {
 			/* pad 0'ed data for the other cases */
 			zero_pos = pos + inode->idata_size;
 		}
-		ret = dev_write(inode->idata, pos, inode->idata_size);
+		ret = dev_write(sbi, inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
 
-		DBG_BUGON(inode->idata_size > erofs_blksiz());
-		if (inode->idata_size < erofs_blksiz()) {
-			ret = dev_fillzero(zero_pos,
-					   erofs_blksiz() - inode->idata_size,
+		DBG_BUGON(inode->idata_size > erofs_blksiz(sbi));
+		if (inode->idata_size < erofs_blksiz(sbi)) {
+			ret = dev_fillzero(sbi, zero_pos,
+					   erofs_blksiz(sbi) - inode->idata_size,
 					   false);
 			if (ret)
 				return ret;
@@ -792,7 +801,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		free(inode->idata);
 		inode->idata = NULL;
 
-		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(pos));
+		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(sbi, pos));
 	}
 out:
 	/* now bh_data can drop directly */
@@ -821,8 +830,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if ((inode->i_mtime != sbi.build_time ||
-	     inode->i_mtime_nsec != sbi.build_time_nsec) &&
+	if ((inode->i_mtime != inode->sbi->build_time ||
+	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
 	    !cfg.c_ignore_mtime)
 		return true;
 	return false;
@@ -897,6 +906,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 			    const char *path)
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
+	struct erofs_sb_info *sbi = inode->sbi;
 
 	if (err)
 		return err;
@@ -917,11 +927,11 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 
 	switch (cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
-		if (inode->i_mtime < sbi.build_time)
+		if (inode->i_mtime < sbi->build_time)
 			break;
 	case TIMESTAMP_FIXED:
-		inode->i_mtime = sbi.build_time;
-		inode->i_mtime_nsec = sbi.build_time_nsec;
+		inode->i_mtime = sbi->build_time;
+		inode->i_mtime_nsec = sbi->build_time_nsec;
 	default:
 		break;
 	}
@@ -978,6 +988,7 @@ struct erofs_inode *erofs_new_inode(void)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	inode->sbi = &sbi;
 	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
 	inode->i_count = 1;
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
@@ -1031,16 +1042,17 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 {
 	const erofs_off_t rootnid_maxoffset = 0xffff << EROFS_ISLOTBITS;
 	struct erofs_buffer_head *const bh = rootdir->bh;
+	struct erofs_sb_info *sbi = rootdir->sbi;
 	erofs_off_t off, meta_offset;
 
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	if (off > rootnid_maxoffset)
-		meta_offset = round_up(off - rootnid_maxoffset, erofs_blksiz());
+		meta_offset = round_up(off - rootnid_maxoffset, erofs_blksiz(sbi));
 	else
 		meta_offset = 0;
-	sbi.meta_blkaddr = erofs_blknr(meta_offset);
+	sbi->meta_blkaddr = erofs_blknr(sbi, meta_offset);
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
@@ -1283,8 +1295,8 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	}
 
 	if (name == EROFS_PACKED_INODE) {
-		sbi.packed_nid = EROFS_PACKED_NID_UNALLOCATED;
-		inode->nid = sbi.packed_nid;
+		inode->sbi->packed_nid = EROFS_PACKED_NID_UNALLOCATED;
+		inode->nid = inode->sbi->packed_nid;
 	}
 
 	ret = erofs_write_compressed_file(inode, fd);
diff --git a/lib/io.c b/lib/io.c
index 1d266a5..8d84de2 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -23,12 +23,7 @@
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
-static const char *erofs_devname;
-int erofs_devfd = -1;
-static u64 erofs_devsz;
-static unsigned int erofs_nblobs, erofs_blobfd[256];
-
-int dev_get_blkdev_size(int fd, u64 *bytes)
+static int dev_get_blkdev_size(int fd, u64 *bytes)
 {
 	errno = ENOTSUP;
 #ifdef BLKGETSIZE64
@@ -48,15 +43,15 @@ int dev_get_blkdev_size(int fd, u64 *bytes)
 	return -errno;
 }
 
-void dev_close(void)
+void dev_close(struct erofs_sb_info *sbi)
 {
-	close(erofs_devfd);
-	erofs_devname = NULL;
-	erofs_devfd   = -1;
-	erofs_devsz   = 0;
+	close(sbi->devfd);
+	sbi->devname = NULL;
+	sbi->devfd   = -1;
+	sbi->devsz   = 0;
 }
 
-int dev_open(const char *dev)
+int dev_open(struct erofs_sb_info *sbi, const char *dev)
 {
 	struct stat st;
 	int fd, ret;
@@ -76,13 +71,13 @@ int dev_open(const char *dev)
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFBLK:
-		ret = dev_get_blkdev_size(fd, &erofs_devsz);
+		ret = dev_get_blkdev_size(fd, &sbi->devsz);
 		if (ret) {
 			erofs_err("failed to get block device size(%s).", dev);
 			close(fd);
 			return ret;
 		}
-		erofs_devsz = round_down(erofs_devsz, erofs_blksiz());
+		sbi->devsz = round_down(sbi->devsz, erofs_blksiz(sbi));
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
@@ -92,7 +87,7 @@ int dev_open(const char *dev)
 			return -errno;
 		}
 		/* INT64_MAX is the limit of kernel vfs */
-		erofs_devsz = INT64_MAX;
+		sbi->devsz = INT64_MAX;
 		break;
 	default:
 		erofs_err("bad file type (%s, %o).", dev, st.st_mode);
@@ -100,23 +95,23 @@ int dev_open(const char *dev)
 		return -EINVAL;
 	}
 
-	erofs_devname = dev;
-	erofs_devfd = fd;
+	sbi->devname = dev;
+	sbi->devfd = fd;
 
 	erofs_info("successfully to open %s", dev);
 	return 0;
 }
 
-void blob_closeall(void)
+void blob_closeall(struct erofs_sb_info *sbi)
 {
 	unsigned int i;
 
-	for (i = 0; i < erofs_nblobs; ++i)
-		close(erofs_blobfd[i]);
-	erofs_nblobs = 0;
+	for (i = 0; i < sbi->nblobs; ++i)
+		close(sbi->blobfd[i]);
+	sbi->nblobs = 0;
 }
 
-int blob_open_ro(const char *dev)
+int blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
 {
 	int fd = open(dev, O_RDONLY | O_BINARY);
 
@@ -125,14 +120,14 @@ int blob_open_ro(const char *dev)
 		return -errno;
 	}
 
-	erofs_blobfd[erofs_nblobs] = fd;
-	erofs_info("successfully to open blob%u %s", erofs_nblobs, dev);
-	++erofs_nblobs;
+	sbi->blobfd[sbi->nblobs] = fd;
+	erofs_info("successfully to open blob%u %s", sbi->nblobs, dev);
+	++sbi->nblobs;
 	return 0;
 }
 
 /* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
-int dev_open_ro(const char *dev)
+int dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
 {
 	int fd = open(dev, O_RDONLY | O_BINARY);
 
@@ -141,18 +136,13 @@ int dev_open_ro(const char *dev)
 		return -errno;
 	}
 
-	erofs_devfd = fd;
-	erofs_devname = dev;
-	erofs_devsz = INT64_MAX;
+	sbi->devfd = fd;
+	sbi->devname = dev;
+	sbi->devsz = INT64_MAX;
 	return 0;
 }
 
-u64 dev_length(void)
-{
-	return erofs_devsz;
-}
-
-int dev_write(const void *buf, u64 offset, size_t len)
+int dev_write(struct erofs_sb_info *sbi, const void *buf, u64 offset, size_t len)
 {
 	int ret;
 
@@ -164,33 +154,33 @@ int dev_write(const void *buf, u64 offset, size_t len)
 		return -EINVAL;
 	}
 
-	if (offset >= erofs_devsz || len > erofs_devsz ||
-	    offset > erofs_devsz - len) {
+	if (offset >= sbi->devsz || len > sbi->devsz ||
+	    offset > sbi->devsz - len) {
 		erofs_err("Write posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
-			  offset, len, erofs_devsz);
+			  offset, len, sbi->devsz);
 		return -EINVAL;
 	}
 
 #ifdef HAVE_PWRITE64
-	ret = pwrite64(erofs_devfd, buf, len, (off64_t)offset);
+	ret = pwrite64(sbi->devfd, buf, len, (off64_t)offset);
 #else
-	ret = pwrite(erofs_devfd, buf, len, (off_t)offset);
+	ret = pwrite(sbi->devfd, buf, len, (off_t)offset);
 #endif
 	if (ret != (int)len) {
 		if (ret < 0) {
 			erofs_err("Failed to write data into device - %s:[%" PRIu64 ", %zd].",
-				  erofs_devname, offset, len);
+				  sbi->devname, offset, len);
 			return -errno;
 		}
 
 		erofs_err("Writing data into device - %s:[%" PRIu64 ", %zd] - was truncated.",
-			  erofs_devname, offset, len);
+			  sbi->devname, offset, len);
 		return -ERANGE;
 	}
 	return 0;
 }
 
-int dev_fillzero(u64 offset, size_t len, bool padding)
+int dev_fillzero(struct erofs_sb_info *sbi, u64 offset, size_t len, bool padding)
 {
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	int ret;
@@ -199,25 +189,25 @@ int dev_fillzero(u64 offset, size_t len, bool padding)
 		return 0;
 
 #if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
-	if (!padding && fallocate(erofs_devfd, FALLOC_FL_PUNCH_HOLE |
+	if (!padding && fallocate(sbi->devfd, FALLOC_FL_PUNCH_HOLE |
 				  FALLOC_FL_KEEP_SIZE, offset, len) >= 0)
 		return 0;
 #endif
-	while (len > erofs_blksiz()) {
-		ret = dev_write(zero, offset, erofs_blksiz());
+	while (len > erofs_blksiz(sbi)) {
+		ret = dev_write(sbi, zero, offset, erofs_blksiz(sbi));
 		if (ret)
 			return ret;
-		len -= erofs_blksiz();
-		offset += erofs_blksiz();
+		len -= erofs_blksiz(sbi);
+		offset += erofs_blksiz(sbi);
 	}
-	return dev_write(zero, offset, len);
+	return dev_write(sbi, zero, offset, len);
 }
 
-int dev_fsync(void)
+int dev_fsync(struct erofs_sb_info *sbi)
 {
 	int ret;
 
-	ret = fsync(erofs_devfd);
+	ret = fsync(sbi->devfd);
 	if (ret) {
 		erofs_err("Could not fsync device!!!");
 		return -EIO;
@@ -225,36 +215,37 @@ int dev_fsync(void)
 	return 0;
 }
 
-int dev_resize(unsigned int blocks)
+int dev_resize(struct erofs_sb_info *sbi, unsigned int blocks)
 {
 	int ret;
 	struct stat st;
 	u64 length;
 
-	if (cfg.c_dry_run || erofs_devsz != INT64_MAX)
+	if (cfg.c_dry_run || sbi->devsz != INT64_MAX)
 		return 0;
 
-	ret = fstat(erofs_devfd, &st);
+	ret = fstat(sbi->devfd, &st);
 	if (ret) {
 		erofs_err("failed to fstat.");
 		return -errno;
 	}
 
-	length = (u64)blocks * erofs_blksiz();
+	length = (u64)blocks * erofs_blksiz(sbi);
 	if (st.st_size == length)
 		return 0;
 	if (st.st_size > length)
-		return ftruncate(erofs_devfd, length);
+		return ftruncate(sbi->devfd, length);
 
 	length = length - st.st_size;
 #if defined(HAVE_FALLOCATE)
-	if (fallocate(erofs_devfd, 0, st.st_size, length) >= 0)
+	if (fallocate(sbi->devfd, 0, st.st_size, length) >= 0)
 		return 0;
 #endif
-	return dev_fillzero(st.st_size, length, true);
+	return dev_fillzero(sbi, st.st_size, length, true);
 }
 
-int dev_read(int device_id, void *buf, u64 offset, size_t len)
+int dev_read(struct erofs_sb_info *sbi, int device_id,
+	     void *buf, u64 offset, size_t len)
 {
 	int read_count, fd;
 
@@ -269,13 +260,13 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 	}
 
 	if (!device_id) {
-		fd = erofs_devfd;
+		fd = sbi->devfd;
 	} else {
-		if (device_id > erofs_nblobs) {
+		if (device_id > sbi->nblobs) {
 			erofs_err("invalid device id %d", device_id);
 			return -ENODEV;
 		}
-		fd = erofs_blobfd[device_id - 1];
+		fd = sbi->blobfd[device_id - 1];
 	}
 
 	while (len > 0) {
@@ -287,12 +278,12 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 		if (read_count < 1) {
 			if (!read_count) {
 				erofs_info("Reach EOF of device - %s:[%" PRIu64 ", %zd].",
-					   erofs_devname, offset, len);
+					   sbi->devname, offset, len);
 				memset(buf, 0, len);
 				return 0;
 			} else if (errno != EINTR) {
 				erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
-					  erofs_devname, offset, len);
+					  sbi->devname, offset, len);
 				return -errno;
 			}
 		}
diff --git a/lib/namei.c b/lib/namei.c
index 4b7e3e4..4a1ff98 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -22,15 +22,18 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-int erofs_read_inode_from_disk(struct erofs_inode *vi)
+int erofs_read_inode_from_disk(struct erofs_sb_info *sbi, struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[sizeof(struct erofs_inode_extended)];
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
-	const erofs_off_t inode_loc = iloc(vi);
+	erofs_off_t inode_loc;
 
-	ret = dev_read(0, buf, inode_loc, sizeof(*dic));
+	vi->sbi = sbi;
+	inode_loc = iloc(vi);
+
+	ret = dev_read(sbi, 0, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
 		return -EIO;
 
@@ -47,7 +50,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
-		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
+		ret = dev_read(sbi, 0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
 			       sizeof(*die) - sizeof(*dic));
 		if (ret < 0)
 			return -EIO;
@@ -114,8 +117,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_gid = le16_to_cpu(dic->i_gid);
 		vi->i_nlink = le16_to_cpu(dic->i_nlink);
 
-		vi->i_mtime = sbi.build_time;
-		vi->i_mtime_nsec = sbi.build_time_nsec;
+		vi->i_mtime = sbi->build_time;
+		vi->i_mtime_nsec = sbi->build_time_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
 		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
@@ -134,10 +137,10 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 				  vi->u.chunkformat, vi->nid | 0ULL);
 			return -EOPNOTSUPP;
 		}
-		vi->u.chunkbits = sbi.blkszbits +
+		vi->u.chunkbits = sbi->blkszbits +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		if (erofs_blksiz() != EROFS_MAX_BLOCK_SIZE)
+		if (erofs_blksiz(vi->sbi) != EROFS_MAX_BLOCK_SIZE)
 			return -EOPNOTSUPP;
 		return z_erofs_fill_inode(vi);
 	}
@@ -185,6 +188,7 @@ struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
 }
 
 struct nameidata {
+	struct erofs_sb_info *sbi;
 	erofs_nid_t	nid;
 	unsigned int	ftype;
 };
@@ -195,16 +199,17 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 	int ret;
 	char buf[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode vi = { .nid = nid };
+	struct erofs_sb_info *sbi = nd->sbi;
 	erofs_off_t offset;
 
-	ret = erofs_read_inode_from_disk(&vi);
+	ret = erofs_read_inode_from_disk(sbi, &vi);
 	if (ret)
 		return ret;
 
 	offset = 0;
 	while (offset < vi.i_size) {
 		erofs_off_t maxsize = min_t(erofs_off_t,
-					    vi.i_size - offset, erofs_blksiz());
+					    vi.i_size - offset, erofs_blksiz(sbi));
 		struct erofs_dirent *de = (void *)buf;
 		unsigned int nameoff;
 
@@ -214,7 +219,7 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 
 		nameoff = le16_to_cpu(de->nameoff);
 		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= erofs_blksiz()) {
+		    nameoff >= erofs_blksiz(sbi)) {
 			erofs_err("invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, nid | 0ULL);
 			return -EFSCORRUPTED;
@@ -236,7 +241,7 @@ int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
 
 static int link_path_walk(const char *name, struct nameidata *nd)
 {
-	nd->nid = sbi.root_nid;
+	nd->nid = nd->sbi->root_nid;
 
 	while (*name == '/')
 		name++;
@@ -263,15 +268,16 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	return 0;
 }
 
-int erofs_ilookup(const char *path, struct erofs_inode *vi)
+int erofs_ilookup(struct erofs_sb_info *sbi, const char *path,
+		  struct erofs_inode *vi)
 {
 	int ret;
-	struct nameidata nd;
+	struct nameidata nd = { .sbi = sbi };
 
 	ret = link_path_walk(path, &nd);
 	if (ret)
 		return ret;
 
 	vi->nid = nd.nid;
-	return erofs_read_inode_from_disk(vi);
+	return erofs_read_inode_from_disk(sbi, vi);
 }
diff --git a/lib/super.c b/lib/super.c
index 820c883..16a1d62 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -31,7 +31,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 
 	sbi->total_blocks = sbi->primarydevice_blocks;
 
-	if (!erofs_sb_has_device_table())
+	if (!erofs_sb_has_device_table(sbi))
 		ondisk_extradevs = 0;
 	else
 		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
@@ -53,7 +53,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 		struct erofs_deviceslot dis;
 		int ret;
 
-		ret = dev_read(0, &dis, pos, sizeof(dis));
+		ret = dev_read(sbi, 0, &dis, pos, sizeof(dis));
 		if (ret < 0) {
 			free(sbi->devs);
 			return ret;
@@ -66,13 +66,14 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	return 0;
 }
 
-int erofs_read_superblock(void)
+int erofs_read_superblock(struct erofs_sb_info *sbi)
 {
 	u8 data[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_super_block *dsb;
 	int ret;
 
-	ret = blk_read(0, data, 0, erofs_blknr(sizeof(data)));
+	sbi->blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
+	ret = blk_read(sbi, 0, data, 0, erofs_blknr(sbi, sizeof(data)));
 	if (ret < 0) {
 		erofs_err("cannot read erofs superblock: %d", ret);
 		return -EIO;
@@ -85,36 +86,36 @@ int erofs_read_superblock(void)
 		return ret;
 	}
 
-	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 
-	sbi.blkszbits = dsb->blkszbits;
-	if (sbi.blkszbits < 9 ||
-	    sbi.blkszbits > ilog2(EROFS_MAX_BLOCK_SIZE)) {
+	sbi->blkszbits = dsb->blkszbits;
+	if (sbi->blkszbits < 9 ||
+	    sbi->blkszbits > ilog2(EROFS_MAX_BLOCK_SIZE)) {
 		erofs_err("blksize %llu isn't supported on this platform",
-			  erofs_blksiz() | 0ULL);
+			  erofs_blksiz(sbi) | 0ULL);
 		return ret;
-	} else if (!check_layout_compatibility(&sbi, dsb)) {
+	} else if (!check_layout_compatibility(sbi, dsb)) {
 		return ret;
 	}
 
-	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
-	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
-	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
-	sbi.islotbits = EROFS_ISLOTBITS;
-	sbi.root_nid = le16_to_cpu(dsb->root_nid);
-	sbi.packed_nid = le64_to_cpu(dsb->packed_nid);
-	sbi.inos = le64_to_cpu(dsb->inos);
-	sbi.checksum = le32_to_cpu(dsb->checksum);
+	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
+	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
+	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
+	sbi->islotbits = EROFS_ISLOTBITS;
+	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
+	sbi->inos = le64_to_cpu(dsb->inos);
+	sbi->checksum = le32_to_cpu(dsb->checksum);
 
-	sbi.build_time = le64_to_cpu(dsb->build_time);
-	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+	sbi->build_time = le64_to_cpu(dsb->build_time);
+	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
-	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
-	return erofs_init_devices(&sbi, dsb);
+	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
+	return erofs_init_devices(sbi, dsb);
 }
 
-void erofs_put_super(void)
+void erofs_put_super(struct erofs_sb_info *sbi)
 {
-	if (sbi.devs)
-		free(sbi.devs);
+	if (sbi->devs)
+		free(sbi->devs);
 }
diff --git a/lib/tar.c b/lib/tar.c
index b62e562..76ba69d 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -161,8 +161,8 @@ static struct erofs_dentry *tarerofs_mkdir(struct erofs_inode *dir, const char *
 	inode->i_parent = dir;
 	inode->i_uid = getuid();
 	inode->i_gid = getgid();
-	inode->i_mtime = sbi.build_time;
-	inode->i_mtime_nsec = sbi.build_time_nsec;
+	inode->i_mtime = inode->sbi->build_time;
+	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
 	tarerofs_init_empty_dir(inode);
 
 	d = erofs_d_alloc(dir, s);
@@ -353,14 +353,15 @@ out:
 
 int tarerofs_write_chunk_indexes(struct erofs_inode *inode, erofs_blk_t blkaddr)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int chunkbits = ilog2(inode->i_size - 1) + 1;
 	unsigned int count, unit;
 	erofs_off_t chunksize, len, pos;
 	struct erofs_inode_chunk_index *idx;
 
-	if (chunkbits < sbi.blkszbits)
-		chunkbits = sbi.blkszbits;
-	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
+	if (chunkbits < sbi->blkszbits)
+		chunkbits = sbi->blkszbits;
+	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
 	inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
@@ -382,7 +383,7 @@ int tarerofs_write_chunk_indexes(struct erofs_inode *inode, erofs_blk_t blkaddr)
 			return PTR_ERR(chunk);
 
 		*(void **)idx++ = chunk;
-		blkaddr += erofs_blknr(len);
+		blkaddr += erofs_blknr(sbi, len);
 	}
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
 	return 0;
@@ -410,6 +411,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 {
 	char path[PATH_MAX];
 	struct erofs_pax_header eh = tar->global;
+	struct erofs_sb_info *sbi = root->sbi;
 	bool e, whout, opq;
 	struct stat st;
 	erofs_off_t tar_offset, data_offset;
@@ -616,7 +618,7 @@ restart:
 			eh.link = strndup(th.linkname, sizeof(th.linkname));
 	}
 
-	if (tar->index_mode && erofs_blkoff(tar_offset + sizeof(th))) {
+	if (tar->index_mode && erofs_blkoff(sbi, tar_offset + sizeof(th))) {
 		erofs_err("invalid tar data alignment @ %llu", tar_offset);
 		ret = -EIO;
 		goto out;
@@ -719,7 +721,7 @@ new_inode:
 			memcpy(inode->i_link, eh.link, inode->i_size + 1);
 		} else if (tar->index_mode) {
 			ret = tarerofs_write_chunk_indexes(inode,
-					erofs_blknr(data_offset));
+					erofs_blknr(sbi, data_offset));
 			if (ret)
 				goto out;
 			if (erofs_lskip(tar->fd, inode->i_size)) {
@@ -774,7 +776,7 @@ invalid_tar:
 
 static struct erofs_buffer_head *bh_devt;
 
-int tarerofs_reserve_devtable(unsigned int devices)
+int tarerofs_reserve_devtable(struct erofs_sb_info *sbi, unsigned int devices)
 {
 	if (!devices)
 		return 0;
@@ -786,27 +788,27 @@ int tarerofs_reserve_devtable(unsigned int devices)
 
 	erofs_mapbh(bh_devt->block);
 	bh_devt->op = &erofs_skip_write_bhops;
-	sbi.devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
-	sbi.extra_devices = devices;
-	erofs_sb_set_device_table();
+	sbi->devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
+	sbi->extra_devices = devices;
+	erofs_sb_set_device_table(sbi);
 	return 0;
 }
 
-int tarerofs_write_devtable(struct erofs_tarfile *tar)
+int tarerofs_write_devtable(struct erofs_sb_info *sbi, struct erofs_tarfile *tar)
 {
 	erofs_off_t pos_out;
 	unsigned int i;
 
-	if (!sbi.extra_devices)
+	if (!sbi->extra_devices)
 		return 0;
 	pos_out = erofs_btell(bh_devt, false);
-	for (i = 0; i < sbi.extra_devices; ++i) {
+	for (i = 0; i < sbi->extra_devices; ++i) {
 		struct erofs_deviceslot dis = {
-			.blocks = erofs_blknr(tar->offset),
+			.blocks = erofs_blknr(sbi, tar->offset),
 		};
 		int ret;
 
-		ret = dev_write(&dis, pos_out, sizeof(dis));
+		ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
 		if (ret)
 			return ret;
 		pos_out += sizeof(dis);
diff --git a/lib/xattr.c b/lib/xattr.c
index 5ad2d25..db63889 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -636,7 +636,7 @@ static inline int erofs_xattr_index_by_prefix(const char *prefix, int *len)
 	return -ENODATA;
 }
 
-int erofs_xattr_write_name_prefixes(FILE *f)
+int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f)
 {
 	struct ea_type_node *tnode;
 	struct xattr_prefix *p;
@@ -653,8 +653,8 @@ int erofs_xattr_write_name_prefixes(FILE *f)
 	offset = round_up(offset, 4);
 	if (fseek(f, offset, SEEK_SET))
 		return -errno;
-	sbi.xattr_prefix_start = (u32)offset >> 2;
-	sbi.xattr_prefix_count = ea_prefix_count;
+	sbi->xattr_prefix_start = (u32)offset >> 2;
+	sbi->xattr_prefix_count = ea_prefix_count;
 
 	list_for_each_entry(tnode, &ea_name_prefixes, list) {
 		union {
@@ -682,12 +682,12 @@ int erofs_xattr_write_name_prefixes(FILE *f)
 		if (fseek(f, offset, SEEK_SET))
 			return -errno;
 	}
-	erofs_sb_set_fragments();
-	erofs_sb_set_xattr_prefixes();
+	erofs_sb_set_fragments(sbi);
+	erofs_sb_set_xattr_prefixes(sbi);
 	return 0;
 }
 
-int erofs_build_shared_xattrs_from_path(const char *path)
+int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
@@ -746,8 +746,8 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	sbi.xattr_blkaddr = off / erofs_blksiz();
-	off %= erofs_blksiz();
+	sbi->xattr_blkaddr = off / erofs_blksiz(sbi);
+	off %= erofs_blksiz(sbi);
 	p = 0;
 	for (i = 0; i < shared_xattrs_count; i++) {
 		struct xattr_item *item = sorted_n[i];
@@ -768,7 +768,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	shared_xattrs_list = sorted_n[0];
 	free(sorted_n);
 	bh->op = &erofs_drop_directly_bhops;
-	ret = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
+	ret = dev_write(sbi, buf, erofs_btell(bh, false), shared_xattrs_size);
 	free(buf);
 	erofs_bdrop(bh, false);
 out:
@@ -837,10 +837,12 @@ struct xattr_iter {
 
 	erofs_blk_t blkaddr;
 	unsigned int ofs;
+	struct erofs_sb_info *sbi;
 };
 
 static int init_inode_xattrs(struct erofs_inode *vi)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
@@ -871,10 +873,10 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 		return -ENOATTR;
 	}
 
-	it.blkaddr = erofs_blknr(iloc(vi) + vi->inode_isize);
-	it.ofs = erofs_blkoff(iloc(vi) + vi->inode_isize);
+	it.blkaddr = erofs_blknr(sbi, iloc(vi) + vi->inode_isize);
+	it.ofs = erofs_blkoff(sbi, iloc(vi) + vi->inode_isize);
 
-	ret = blk_read(0, it.page, it.blkaddr, 1);
+	ret = blk_read(sbi, 0, it.page, it.blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -890,11 +892,11 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= erofs_blksiz()) {
+		if (it.ofs >= erofs_blksiz(sbi)) {
 			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != erofs_blksiz());
+			DBG_BUGON(it.ofs != erofs_blksiz(sbi));
 
-			ret = blk_read(0, it.page, ++it.blkaddr, 1);
+			ret = blk_read(sbi, 0, it.page, ++it.blkaddr, 1);
 			if (ret < 0) {
 				free(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -932,25 +934,27 @@ struct xattr_iter_handlers {
 
 static inline int xattr_iter_fixup(struct xattr_iter *it)
 {
+	struct erofs_sb_info *sbi = it->sbi;
 	int ret;
 
-	if (it->ofs < erofs_blksiz())
+	if (it->ofs < erofs_blksiz(sbi))
 		return 0;
 
-	it->blkaddr += erofs_blknr(it->ofs);
+	it->blkaddr += erofs_blknr(sbi, it->ofs);
 
-	ret = blk_read(0, it->page, it->blkaddr, 1);
+	ret = blk_read(sbi, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
 	it->kaddr = it->page;
-	it->ofs = erofs_blkoff(it->ofs);
+	it->ofs = erofs_blkoff(sbi, it->ofs);
 	return 0;
 }
 
 static int inline_xattr_iter_pre(struct xattr_iter *it,
 				   struct erofs_inode *vi)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 	int ret;
 
@@ -962,10 +966,10 @@ static int inline_xattr_iter_pre(struct xattr_iter *it,
 
 	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
 
-	it->blkaddr = erofs_blknr(iloc(vi) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(iloc(vi) + inline_xattr_ofs);
+	it->blkaddr = erofs_blknr(sbi, iloc(vi) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(sbi, iloc(vi) + inline_xattr_ofs);
 
-	ret = blk_read(0, it->page, it->blkaddr, 1);
+	ret = blk_read(sbi, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -981,6 +985,7 @@ static int xattr_foreach(struct xattr_iter *it,
 			 const struct xattr_iter_handlers *op,
 			 unsigned int *tlimit)
 {
+	struct erofs_sb_info *sbi = it->sbi;
 	struct erofs_xattr_entry entry;
 	unsigned int value_sz, processed, slice;
 	int err;
@@ -1021,8 +1026,8 @@ static int xattr_foreach(struct xattr_iter *it,
 	processed = 0;
 
 	while (processed < entry.e_name_len) {
-		if (it->ofs >= erofs_blksiz()) {
-			DBG_BUGON(it->ofs > erofs_blksiz());
+		if (it->ofs >= erofs_blksiz(sbi)) {
+			DBG_BUGON(it->ofs > erofs_blksiz(sbi));
 
 			err = xattr_iter_fixup(it);
 			if (err)
@@ -1030,7 +1035,7 @@ static int xattr_foreach(struct xattr_iter *it,
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, erofs_blksiz() - it->ofs,
+		slice = min_t(unsigned int, erofs_blksiz(sbi) - it->ofs,
 			      entry.e_name_len - processed);
 
 		/* handle name */
@@ -1056,8 +1061,8 @@ static int xattr_foreach(struct xattr_iter *it,
 	}
 
 	while (processed < value_sz) {
-		if (it->ofs >= erofs_blksiz()) {
-			DBG_BUGON(it->ofs > erofs_blksiz());
+		if (it->ofs >= erofs_blksiz(sbi)) {
+			DBG_BUGON(it->ofs > erofs_blksiz(sbi));
 
 			err = xattr_iter_fixup(it);
 			if (err)
@@ -1065,7 +1070,7 @@ static int xattr_foreach(struct xattr_iter *it,
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, erofs_blksiz() - it->ofs,
+		slice = min_t(unsigned int, erofs_blksiz(sbi) - it->ofs,
 			      value_sz - processed);
 		op->value(it, processed, it->kaddr + it->ofs, slice);
 		it->ofs += slice;
@@ -1157,12 +1162,12 @@ static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		erofs_blk_t blkaddr =
-			xattrblock_addr(vi->xattr_shared_xattrs[i]);
+			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
 
-		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
+		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
 
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(0, it->it.page, blkaddr, 1);
+			ret = blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
@@ -1196,6 +1201,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	if (!match_prefix(name, &prefix, &prefixlen))
 		return -ENODATA;
 
+	it.it.sbi = vi->sbi;
 	it.index = prefix;
 	it.name = name + prefixlen;
 	it.len = strlen(it.name);
@@ -1297,11 +1303,11 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		erofs_blk_t blkaddr =
-			xattrblock_addr(vi->xattr_shared_xattrs[i]);
+			xattrblock_addr(vi, vi->xattr_shared_xattrs[i]);
 
-		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
+		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(0, it->it.page, blkaddr, 1);
+			ret = blk_read(vi->sbi, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
@@ -1328,6 +1334,7 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	if (ret)
 		return ret;
 
+	it.it.sbi = vi->sbi;
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
diff --git a/lib/zmap.c b/lib/zmap.c
index b0ae88e..9750d1c 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -16,13 +16,15 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
-	if (!erofs_sb_has_big_pcluster() &&
-	    !erofs_sb_has_ztailpacking() && !erofs_sb_has_fragments() &&
+	struct erofs_sb_info *sbi = vi->sbi;
+
+	if (!erofs_sb_has_big_pcluster(sbi) &&
+	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
 	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = sbi.blkszbits;
+		vi->z_logical_clusterbits = sbi->blkszbits;
 
 		vi->flags |= EROFS_I_Z_INITED;
 	}
@@ -35,12 +37,13 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	erofs_off_t pos;
 	struct z_erofs_map_header *h;
 	char buf[sizeof(struct z_erofs_map_header)];
+	struct erofs_sb_info *sbi = vi->sbi;
 
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
 	pos = round_up(iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
-	ret = dev_read(0, buf, pos, sizeof(buf));
+	ret = dev_read(sbi, 0, buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -66,7 +69,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return -EOPNOTSUPP;
 	}
 
-	vi->z_logical_clusterbits = sbi.blkszbits + (h->h_clusterbits & 7);
+	vi->z_logical_clusterbits = sbi->blkszbits + (h->h_clusterbits & 7);
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
@@ -82,7 +85,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		ret = z_erofs_do_map_blocks(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > erofs_blksiz()) {
+		    erofs_blkoff(sbi, map.m_pa) + map.m_plen > erofs_blksiz(sbi)) {
 			erofs_err("invalid tail-packing pclustersize %llu",
 				  map.m_plen | 0ULL);
 			return -EFSCORRUPTED;
@@ -130,7 +133,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	if (map->index == eblk)
 		return 0;
 
-	ret = blk_read(0, mpage, eblk, 1);
+	ret = blk_read(m->inode->sbi, 0, mpage, eblk, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -143,6 +146,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					 unsigned long lcn)
 {
 	struct erofs_inode *const vi = m->inode;
+	struct erofs_sb_info *sbi = vi->sbi;
 	const erofs_off_t ibase = iloc(vi);
 	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(ibase +
 			vi->inode_isize + vi->xattr_isize) +
@@ -151,13 +155,13 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int advise, type;
 	int err;
 
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	err = z_erofs_reload_indexes(m, erofs_blknr(sbi, pos));
 	if (err)
 		return err;
 
 	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 	m->lcn = lcn;
-	di = m->kaddr + erofs_blkoff(pos);
+	di = m->kaddr + erofs_blkoff(sbi, pos);
 
 	advise = le16_to_cpu(di->di_advise);
 	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
@@ -252,7 +256,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			 (vcnt << amortizedshift);
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
-	eofs = erofs_blkoff(pos);
+	eofs = erofs_blkoff(vi->sbi, pos);
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
 
@@ -341,11 +345,12 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					    unsigned long lcn, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
+	struct erofs_sb_info *sbi = vi->sbi;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = round_up(iloc(vi) + vi->inode_isize +
 					   vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
-	const unsigned int totalidx = BLK_ROUND_UP(vi->i_size);
+	const unsigned int totalidx = BLK_ROUND_UP(sbi, vi->i_size);
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
 	erofs_off_t pos;
@@ -386,7 +391,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	amortizedshift = 2;
 out:
 	pos += lcn * (1 << amortizedshift);
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	err = z_erofs_reload_indexes(m, erofs_blknr(sbi, pos));
 	if (err)
 		return err;
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
@@ -455,6 +460,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 					    unsigned int initial_lcn)
 {
 	struct erofs_inode *const vi = m->inode;
+	struct erofs_sb_info *sbi = vi->sbi;
 	struct erofs_map_blocks *const map = m->map;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	unsigned long lcn;
@@ -495,7 +501,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
-		m->compressedblks = 1 << (lclusterbits - sbi.blkszbits);
+		m->compressedblks = 1 << (lclusterbits - sbi->blkszbits);
 		break;
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
@@ -510,7 +516,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = m->compressedblks << sbi.blkszbits;
+	map->m_plen = m->compressedblks << sbi->blkszbits;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
@@ -565,6 +571,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 				 struct erofs_map_blocks *map,
 				 int flags)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
@@ -645,7 +652,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
-		map->m_pa = erofs_pos(m.pblk);
+		map->m_pa = erofs_pos(sbi, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 		if (err)
 			goto out;
diff --git a/mkfs/main.c b/mkfs/main.c
index 7369b90..92a07fd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -189,7 +189,7 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			erofs_sb_clear_sb_chksum();
+			erofs_sb_clear_sb_chksum(&sbi);
 		}
 
 		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
@@ -442,7 +442,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  optarg);
 				return -EINVAL;
 			}
-			erofs_sb_set_chunked_file();
+			erofs_sb_set_chunked_file(&sbi);
 			break;
 		case 12:
 			quiet = true;
@@ -545,14 +545,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_dbg_lvl = EROFS_ERR;
 		cfg.c_showprogress = false;
 	}
-	if (cfg.c_compr_alg[0] && erofs_blksiz() != EROFS_MAX_BLOCK_SIZE) {
+	if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) != EROFS_MAX_BLOCK_SIZE) {
 		erofs_err("compression is unsupported for now with block size %u",
-			  erofs_blksiz());
+			  erofs_blksiz(&sbi));
 		return -EINVAL;
 	}
 	if (pclustersize_max) {
-		if (pclustersize_max < erofs_blksiz() ||
-		    pclustersize_max % erofs_blksiz()) {
+		if (pclustersize_max < erofs_blksiz(&sbi) ||
+		    pclustersize_max % erofs_blksiz(&sbi)) {
 			erofs_err("invalid physical clustersize %u",
 				  pclustersize_max);
 			return -EINVAL;
@@ -567,8 +567,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	}
 
 	if (pclustersize_packed) {
-		if (pclustersize_max < erofs_blksiz() ||
-		    pclustersize_max % erofs_blksiz()) {
+		if (pclustersize_max < erofs_blksiz(&sbi) ||
+		    pclustersize_max % erofs_blksiz(&sbi)) {
 			erofs_err("invalid pcluster size for the packed file %u",
 				  pclustersize_packed);
 			return -EINVAL;
@@ -600,7 +600,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.extra_devices = cpu_to_le16(sbi.extra_devices),
 		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
 	};
-	const u32 sb_blksize = round_up(EROFS_SUPER_END, erofs_blksiz());
+	const u32 sb_blksize = round_up(EROFS_SUPER_END, erofs_blksiz(&sbi));
 	char *buf;
 	int ret;
 
@@ -611,7 +611,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
 	memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
 
-	if (erofs_sb_has_compr_cfgs())
+	if (erofs_sb_has_compr_cfgs(&sbi))
 		sb.u1.available_compr_algs = cpu_to_le16(sbi.available_compr_algs);
 	else
 		sb.u1.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance);
@@ -624,7 +624,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	}
 	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
 
-	ret = dev_write(buf, erofs_btell(bh, false), EROFS_SUPER_END);
+	ret = dev_write(&sbi, buf, erofs_btell(bh, false), EROFS_SUPER_END);
 	free(buf);
 	erofs_bdrop(bh, false);
 	return ret;
@@ -638,7 +638,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	unsigned int len;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(0, buf, 0, erofs_blknr(EROFS_SUPER_END) + 1);
+	ret = blk_read(&sbi, 0, buf, 0, erofs_blknr(&sbi, EROFS_SUPER_END) + 1);
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
@@ -659,16 +659,16 @@ static int erofs_mkfs_superblock_csum_set(void)
 	/* turn on checksum feature */
 	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
 					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
-	if (erofs_blksiz() > EROFS_SUPER_OFFSET)
-		len = erofs_blksiz() - EROFS_SUPER_OFFSET;
+	if (erofs_blksiz(&sbi) > EROFS_SUPER_OFFSET)
+		len = erofs_blksiz(&sbi) - EROFS_SUPER_OFFSET;
 	else
-		len = erofs_blksiz();
+		len = erofs_blksiz(&sbi);
 	crc = erofs_crc32c(~0, (u8 *)sb, len);
 
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(crc);
 
-	ret = blk_write(buf, 0, 1);
+	ret = blk_write(&sbi, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to write checksummed superblock: %s",
 			  erofs_strerror(ret));
@@ -782,7 +782,7 @@ int main(int argc, char **argv)
 		sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = dev_open(cfg.c_img_path);
+	err = dev_open(&sbi, cfg.c_img_path);
 	if (err) {
 		usage();
 		return 1;
@@ -850,14 +850,14 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = erofs_load_compress_hints();
+	err = erofs_load_compress_hints(&sbi);
 	if (err) {
 		erofs_err("failed to load compress hints %s",
 			  cfg.c_compress_hints_file);
 		goto exit;
 	}
 
-	err = z_erofs_compress_init(sb_bh);
+	err = z_erofs_compress_init(&sbi, sb_bh);
 	if (err) {
 		erofs_err("failed to initialize compressor: %s",
 			  erofs_strerror(err));
@@ -869,7 +869,7 @@ int main(int argc, char **argv)
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
 			cfg.c_chunkbits = sbi.blkszbits;
 		} else {
-			err = z_erofs_dedupe_init(erofs_blksiz());
+			err = z_erofs_dedupe_init(erofs_blksiz(&sbi));
 			if (err) {
 				erofs_err("failed to initialize deduplication: %s",
 					  erofs_strerror(err));
@@ -885,9 +885,9 @@ int main(int argc, char **argv)
 	}
 
 	if (tar_mode && erofstar.index_mode)
-		err = tarerofs_reserve_devtable(1);
+		err = tarerofs_reserve_devtable(&sbi, 1);
 	else
-		err = erofs_generate_devtable();
+		err = erofs_generate_devtable(&sbi);
 	if (err) {
 		erofs_err("failed to generate device table: %s",
 			  erofs_strerror(err));
@@ -899,10 +899,10 @@ int main(int argc, char **argv)
 	erofs_inode_manager_init();
 
 	if (cfg.c_extra_ea_name_prefixes)
-		erofs_xattr_write_name_prefixes(packedfile);
+		erofs_xattr_write_name_prefixes(&sbi, packedfile);
 
 	if (!tar_mode) {
-		err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
+		err = erofs_build_shared_xattrs_from_path(&sbi, cfg.c_src_path);
 		if (err) {
 			erofs_err("failed to build shared xattrs: %s",
 				  erofs_strerror(err));
@@ -910,7 +910,7 @@ int main(int argc, char **argv)
 		}
 
 		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_write_name_prefixes(packedfile);
+			erofs_xattr_write_name_prefixes(&sbi, packedfile);
 
 		root_inode = erofs_mkfs_build_tree_from_path(cfg.c_src_path);
 		if (IS_ERR(root_inode)) {
@@ -943,17 +943,17 @@ int main(int argc, char **argv)
 	erofs_iput(root_inode);
 
 	if (tar_mode)
-		tarerofs_write_devtable(&erofstar);
+		tarerofs_write_devtable(&sbi, &erofstar);
 	if (cfg.c_chunkbits) {
 		erofs_info("total metadata: %u blocks", erofs_mapbh(NULL));
-		err = erofs_blob_remap();
+		err = erofs_blob_remap(&sbi);
 		if (err)
 			goto exit;
 	}
 
 	packed_nid = 0;
 	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
-	    erofs_sb_has_fragments()) {
+	    erofs_sb_has_fragments(&sbi)) {
 		erofs_update_progressinfo("Handling packed_file ...");
 		packed_inode = erofs_mkfs_build_packedfile();
 		if (IS_ERR(packed_inode)) {
@@ -973,9 +973,9 @@ int main(int argc, char **argv)
 	if (!erofs_bflush(NULL))
 		err = -EIO;
 	else
-		err = dev_resize(nblocks);
+		err = dev_resize(&sbi, nblocks);
 
-	if (!err && erofs_sb_has_sb_chksum())
+	if (!err && erofs_sb_has_sb_chksum(&sbi))
 		err = erofs_mkfs_superblock_csum_set();
 exit:
 	z_erofs_compress_exit();
@@ -983,7 +983,7 @@ exit:
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
 #endif
-	dev_close();
+	dev_close(&sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
-- 
2.19.1.6.gb485710b

