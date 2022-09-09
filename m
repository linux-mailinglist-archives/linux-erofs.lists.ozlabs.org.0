Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EFC5B2C19
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 04:23:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP0D70cvhz3bfH
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 12:23:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.12; helo=out199-12.us.a.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 307 seconds by postgrey-1.36 at boromir; Fri, 09 Sep 2022 12:23:43 AEST
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP0Cz5cj3z309f
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 12:23:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VP7G-pq_1662689908;
Received: from localhost.localdomain(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VP7G-pq_1662689908)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 10:18:28 +0800
From: Huang Jianan <jnhuang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs-utils: remove global sbi
Date: Fri,  9 Sep 2022 10:18:14 +0800
Message-Id: <20220909021816.10544-2-jnhuang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220909021816.10544-1-jnhuang@linux.alibaba.com>
References: <20220909021816.10544-1-jnhuang@linux.alibaba.com>
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

Remove global sbi which will make erofs-utils more library friendly.

Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>
---
 dump/main.c                | 71 ++++++++++++++++-------------
 fsck/main.c                | 55 +++++++++++++----------
 fuse/main.c                | 42 +++++++++++-------
 include/erofs/blobchunk.h  |  4 +-
 include/erofs/cache.h      |  2 +-
 include/erofs/compress.h   |  3 +-
 include/erofs/config.h     |  5 ++-
 include/erofs/decompress.h |  1 +
 include/erofs/dir.h        |  4 +-
 include/erofs/inode.h      |  3 +-
 include/erofs/internal.h   | 25 +++++------
 include/erofs/xattr.h      |  8 ++--
 lib/blobchunk.c            | 17 +++----
 lib/cache.c                |  4 +-
 lib/compress.c             | 71 +++++++++++++++--------------
 lib/compressor.h           |  1 +
 lib/compressor_lz4.c       |  2 +-
 lib/compressor_lz4hc.c     |  2 +-
 lib/config.c               | 17 +++++--
 lib/data.c                 | 21 +++++----
 lib/decompress.c           |  2 +-
 lib/dir.c                  | 17 ++++---
 lib/inode.c                | 68 ++++++++++++++++------------
 lib/io.c                   |  2 +
 lib/namei.c                | 19 +++++---
 lib/super.c                | 38 ++++++++--------
 lib/xattr.c                | 40 ++++++++++-------
 lib/zmap.c                 | 26 ++++++-----
 mkfs/main.c                | 91 ++++++++++++++++++++------------------
 29 files changed, 382 insertions(+), 279 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 07fa151..586302b 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -152,10 +152,10 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			usage();
 			exit(0);
 		case 3:
-			err = blob_open_ro(sbi.dev, optarg);
+			err = blob_open_ro(cfg.sbi->dev, optarg);
 			if (err)
 				return err;
-			++sbi.extra_devices;
+			++cfg.sbi->extra_devices;
 			break;
 		case 4:
 			dumpcfg.inode_path = optarg;
@@ -281,7 +281,10 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 {
 	int err;
 	erofs_off_t occupied_size = 0;
-	struct erofs_inode vi = { .nid = ctx->de_nid };
+	struct erofs_inode vi = {
+		.sbi = ctx->sbi,
+		.nid = ctx->de_nid,
+	};
 
 	err = erofs_read_inode_from_disk(&vi);
 	if (err) {
@@ -307,6 +310,7 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(vi.i_mode)) {
 		struct erofs_dir_context nctx = {
+			.sbi = ctx->sbi,
 			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
 			.pnid = ctx->dir ? ctx->dir->nid : 0,
 			.dir = &vi,
@@ -326,7 +330,7 @@ static int erofsdump_map_blocks(struct erofs_inode *inode,
 	return erofs_map_blocks(inode, map, flags);
 }
 
-static void erofsdump_show_fileinfo(bool show_extent)
+static void erofsdump_show_fileinfo(struct erofs_sb_info *sbi, bool show_extent)
 {
 	const char *ext_fmt[] = {
 		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "\n",
@@ -335,11 +339,14 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	int err, i;
 	erofs_off_t size;
 	u16 access_mode;
-	struct erofs_inode inode = { .nid = dumpcfg.nid };
 	char path[PATH_MAX];
 	char access_mode_str[] = "rwxrwxrwx";
 	char timebuf[128] = {0};
 	unsigned int extent_count = 0;
+	struct erofs_inode inode = {
+		.sbi = sbi,
+		.nid = dumpcfg.nid,
+	};
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 		.m_la = 0,
@@ -366,7 +373,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		return;
 	}
 
-	err = erofs_get_pathname(inode.nid, path, sizeof(path));
+	err = erofs_get_pathname(sbi, inode.nid, path, sizeof(path));
 	if (err < 0) {
 		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
 		return;
@@ -396,6 +403,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 
 	if (dumpcfg.show_subdirectories) {
 		struct erofs_dir_context ctx = {
+			.sbi = sbi,
 			.flags = EROFS_READDIR_VALID_PNID,
 			.pnid = inode.nid,
 			.dir = &inode,
@@ -431,7 +439,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
 		};
-		err = erofs_map_dev(&sbi, &mdev);
+		err = erofs_map_dev(sbi, &mdev);
 		if (err) {
 			erofs_err("failed to map device");
 			return;
@@ -531,15 +539,16 @@ static void erofsdump_file_statistic(void)
 			stats.compress_rate);
 }
 
-static void erofsdump_print_statistic(void)
+static void erofsdump_print_statistic(struct erofs_sb_info *sbi)
 {
 	int err;
 	struct erofs_dir_context ctx = {
+		.sbi = sbi,
 		.flags = 0,
 		.pnid = 0,
 		.dir = NULL,
 		.cb = erofsdump_dirent_iter,
-		.de_nid = sbi.root_nid,
+		.de_nid = sbi->root_nid,
 		.dname = "",
 		.de_namelen = 0,
 	};
@@ -559,36 +568,36 @@ static void erofsdump_print_statistic(void)
 	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
 }
 
-static void erofsdump_show_superblock(void)
+static void erofsdump_show_superblock(struct erofs_sb_info *sbi)
 {
-	time_t time = sbi.build_time;
+	time_t time = sbi->build_time;
 	char uuid_str[37] = "not available";
 	int i = 0;
 
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
 			EROFS_SUPER_MAGIC_V1);
 	fprintf(stdout, "Filesystem blocks:                            %llu\n",
-			sbi.total_blocks | 0ULL);
+			sbi->total_blocks | 0ULL);
 	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
-			sbi.meta_blkaddr);
+			sbi->meta_blkaddr);
 	fprintf(stdout, "Filesystem shared xattr metadata start block: %u\n",
-			sbi.xattr_blkaddr);
+			sbi->xattr_blkaddr);
 	fprintf(stdout, "Filesystem root nid:                          %llu\n",
-			sbi.root_nid | 0ULL);
+			sbi->root_nid | 0ULL);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
-			sbi.inos | 0ULL);
+			sbi->inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
 			ctime(&time));
 	fprintf(stdout, "Filesystem features:                          ");
 	for (; i < ARRAY_SIZE(feature_lists); i++) {
 		u32 feat = le32_to_cpu(feature_lists[i].compat ?
-				       sbi.feature_compat :
-				       sbi.feature_incompat);
+				       sbi->feature_compat :
+				       sbi->feature_incompat);
 		if (feat & feature_lists[i].flag)
 			fprintf(stdout, "%s ", feature_lists[i].name);
 	}
 #ifdef HAVE_LIBUUID
-	uuid_unparse_lower(sbi.uuid, uuid_str);
+	uuid_unparse_lower(sbi->uuid, uuid_str);
 #endif
 	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
 			uuid_str);
@@ -597,14 +606,16 @@ static void erofsdump_show_superblock(void)
 int main(int argc, char **argv)
 {
 	int err;
+	struct erofs_sb_info *sbi;
 
 	erofs_init_configure();
 
-	sbi.dev = erofs_init_dev();
-	if (IS_ERR(sbi.dev)) {
-		err = PTR_ERR(sbi.dev);
+	sbi = erofs_init_sbi();
+	if (IS_ERR(sbi)) {
+		err = PTR_ERR(sbi);
 		goto exit;
 	}
+	cfg.sbi = sbi;
 
 	err = erofsdump_parse_options_cfg(argc, argv);
 	if (err) {
@@ -613,13 +624,13 @@ int main(int argc, char **argv)
 		goto exit_blob_close;
 	}
 
-	err = dev_open_ro(sbi.dev, cfg.c_img_path);
+	err = dev_open_ro(sbi->dev, cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit_blob_close;
 	}
 
-	err = erofs_read_superblock();
+	err = erofs_read_superblock(sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit_dev_close;
@@ -630,10 +641,10 @@ int main(int argc, char **argv)
 		dumpcfg.totalshow = 1;
 	}
 	if (dumpcfg.show_superblock)
-		erofsdump_show_superblock();
+		erofsdump_show_superblock(sbi);
 
 	if (dumpcfg.show_statistics)
-		erofsdump_print_statistic();
+		erofsdump_print_statistic(sbi);
 
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
@@ -641,14 +652,14 @@ int main(int argc, char **argv)
 	}
 
 	if (dumpcfg.show_inode)
-		erofsdump_show_fileinfo(dumpcfg.show_extent);
+		erofsdump_show_fileinfo(sbi, dumpcfg.show_extent);
 
 exit_put_super:
-	erofs_put_super();
+	erofs_put_super(sbi);
 exit_dev_close:
-	dev_close(sbi.dev);
+	dev_close(sbi->dev);
 exit_blob_close:
-	blob_closeall(sbi.dev);
+	blob_closeall(sbi->dev);
 exit:
 	erofs_exit_configure();
 	return err;
diff --git a/fsck/main.c b/fsck/main.c
index 1c8f567..ddfbf82 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -15,7 +15,8 @@
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
 
-static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
+static int erofsfsck_check_inode(struct erofs_sb_info *sbi,
+				 erofs_nid_t pnid, erofs_nid_t nid);
 
 struct erofsfsck_cfg {
 	u64 physical_blocks;
@@ -143,10 +144,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			}
 			break;
 		case 3:
-			ret = blob_open_ro(sbi.dev, optarg);
+			ret = blob_open_ro(cfg.sbi->dev, optarg);
 			if (ret)
 				return ret;
-			++sbi.extra_devices;
+			++cfg.sbi->extra_devices;
 			break;
 		case 4:
 			fsckcfg.force = true;
@@ -256,14 +257,14 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 	}
 }
 
-static int erofs_check_sb_chksum(void)
+static int erofs_check_sb_chksum(struct erofs_sb_info *sbi)
 {
 	int ret;
 	u8 buf[EROFS_BLKSIZ];
 	u32 crc;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(sbi.dev, 0, buf, 0, 1);
+	ret = blk_read(sbi->dev, 0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to check checksum: %d",
 			  ret);
@@ -274,9 +275,9 @@ static int erofs_check_sb_chksum(void)
 	sb->checksum = 0;
 
 	crc = erofs_crc32c(~0, (u8 *)sb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
-	if (crc != sbi.checksum) {
+	if (crc != sbi->checksum) {
 		erofs_err("superblock chksum doesn't match: saved(%08xh) calculated(%08xh)",
-			  sbi.checksum, crc);
+			  sbi->checksum, crc);
 		fsckcfg.corrupted = true;
 		return -1;
 	}
@@ -291,7 +292,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	unsigned int ofs, xattr_shared_count;
 	struct erofs_xattr_ibody_header *ih;
 	struct erofs_xattr_entry *entry;
-	struct erofs_device *dev = sbi.dev;
+	struct erofs_device *dev = inode->sbi->dev;
 	int i, remaining = inode->xattr_isize, ret = 0;
 	char buf[EROFS_BLKSIZ];
 
@@ -309,7 +310,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 		}
 	}
 
-	addr = iloc(inode->nid) + inode->inode_isize;
+	addr = iloc(inode->sbi, inode->nid) + inode->inode_isize;
 	ret = dev_read(dev, 0, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
@@ -367,6 +368,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_dev mdev;
 	int ret = 0;
 	bool compressed;
@@ -432,7 +434,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
 		};
-		ret = erofs_map_dev(&sbi, &mdev);
+		ret = erofs_map_dev(sbi, &mdev);
 		if (ret) {
 			erofs_err("failed to map device of m_pa %" PRIu64 ", m_deviceid %u @ nid %llu: %d",
 				  map.m_pa, map.m_deviceid, inode->nid | 0ULL,
@@ -446,7 +448,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			BUG_ON(!buffer);
 		}
 
-		ret = dev_read(sbi.dev, mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
+		ret = dev_read(sbi->dev, mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
 		if (ret < 0) {
 			erofs_err("failed to read data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
 				  mdev.m_pa, map.m_plen, inode->nid | 0ULL,
@@ -456,6 +458,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 
 		if (compressed) {
 			struct z_erofs_decompress_req rq = {
+				.sbi = sbi,
 				.in = raw,
 				.out = buffer,
 				.decodedskip = 0,
@@ -694,7 +697,8 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 		fsckcfg.extract_pos = curr_pos;
 	}
 
-	ret = erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
+	ret = erofsfsck_check_inode(ctx->dir->sbi,
+				    ctx->dir->nid, ctx->de_nid);
 
 	if (fsckcfg.extract_path) {
 		fsckcfg.extract_path[prev_pos] = '\0';
@@ -703,7 +707,8 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 	return ret;
 }
 
-static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
+static int erofsfsck_check_inode(struct erofs_sb_info *sbi,
+				 erofs_nid_t pnid, erofs_nid_t nid)
 {
 	int ret;
 	struct erofs_inode inode;
@@ -711,6 +716,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
 
 	inode.nid = nid;
+	inode.sbi = sbi;
 	ret = erofs_read_inode_from_disk(&inode);
 	if (ret) {
 		if (ret == -EIO)
@@ -756,6 +762,7 @@ verify:
 	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(inode.i_mode)) {
 		struct erofs_dir_context ctx = {
+			.sbi = sbi,
 			.flags = EROFS_READDIR_VALID_PNID,
 			.pnid = pnid,
 			.dir = &inode,
@@ -779,14 +786,16 @@ out:
 int main(int argc, char **argv)
 {
 	int err;
+	struct erofs_sb_info *sbi;
 
 	erofs_init_configure();
 
-	sbi.dev = erofs_init_dev();
-	if (IS_ERR(sbi.dev)) {
-		err = PTR_ERR(sbi.dev);
+	sbi = erofs_init_sbi();
+	if (IS_ERR(sbi)) {
+		err = PTR_ERR(sbi);
 		goto exit;
 	}
+	cfg.sbi = sbi;
 
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
@@ -809,24 +818,24 @@ int main(int argc, char **argv)
 		goto exit_blob_close;
 	}
 
-	err = dev_open_ro(sbi.dev, cfg.c_img_path);
+	err = dev_open_ro(sbi->dev, cfg.c_img_path);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit_blob_close;
 	}
 
-	err = erofs_read_superblock();
+	err = erofs_read_superblock(sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit_dev_close;
 	}
 
-	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
+	if (erofs_sb_has_sb_chksum(sbi) && erofs_check_sb_chksum(sbi)) {
 		erofs_err("failed to verify superblock checksum");
 		goto exit_put_super;
 	}
 
-	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
+	err = erofsfsck_check_inode(sbi, sbi->root_nid, sbi->root_nid);
 	if (fsckcfg.corrupted) {
 		if (!fsckcfg.extract_path)
 			erofs_err("Found some filesystem corruption");
@@ -849,11 +858,11 @@ int main(int argc, char **argv)
 	}
 
 exit_put_super:
-	erofs_put_super();
+	erofs_put_super(sbi);
 exit_dev_close:
-	dev_close(sbi.dev);
+	dev_close(sbi->dev);
 exit_blob_close:
-	blob_closeall(sbi.dev);
+	blob_closeall(sbi->dev);
 exit:
 	erofs_exit_configure();
 	return err ? 1 : 0;
diff --git a/fuse/main.c b/fuse/main.c
index ee86e50..edabdff 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -39,8 +39,10 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 		      off_t offset, struct fuse_file_info *fi)
 {
 	int ret;
-	struct erofs_inode dir;
+	struct erofs_sb_info *sbi = fuse_get_context()->private_data;
+	struct erofs_inode dir = { .sbi = sbi };
 	struct erofsfuse_dir_context ctx = {
+		.ctx.sbi = sbi,
 		.ctx.dir = &dir,
 		.ctx.cb = erofsfuse_fill_dentries,
 		.filler = filler,
@@ -69,7 +71,7 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 static void *erofsfuse_init(struct fuse_conn_info *info)
 {
 	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
-	return NULL;
+	return fuse_get_context()->private_data;
 }
 
 static int erofsfuse_open(const char *path, struct fuse_file_info *fi)
@@ -84,7 +86,8 @@ static int erofsfuse_open(const char *path, struct fuse_file_info *fi)
 
 static int erofsfuse_getattr(const char *path, struct stat *stbuf)
 {
-	struct erofs_inode vi = {};
+	struct erofs_sb_info *sbi = fuse_get_context()->private_data;
+	struct erofs_inode vi = { .sbi = sbi };
 	int ret;
 
 	erofs_dbg("getattr(%s)", path);
@@ -111,7 +114,8 @@ static int erofsfuse_read(const char *path, char *buffer,
 			  struct fuse_file_info *fi)
 {
 	int ret;
-	struct erofs_inode vi;
+	struct erofs_sb_info *sbi = fuse_get_context()->private_data;
+	struct erofs_inode vi = { .sbi = sbi };
 
 	erofs_dbg("path:%s size=%zd offset=%llu", path, size, (long long)offset);
 
@@ -146,7 +150,8 @@ static int erofsfuse_getxattr(const char *path, const char *name, char *value,
 			size_t size)
 {
 	int ret;
-	struct erofs_inode vi;
+	struct erofs_sb_info *sbi = fuse_get_context()->private_data;
+	struct erofs_inode vi = { .sbi = sbi };
 
 	erofs_dbg("getxattr(%s): name=%s size=%llu", path, name, size);
 
@@ -160,7 +165,8 @@ static int erofsfuse_getxattr(const char *path, const char *name, char *value,
 static int erofsfuse_listxattr(const char *path, char *list, size_t size)
 {
 	int ret;
-	struct erofs_inode vi;
+	struct erofs_sb_info *sbi = fuse_get_context()->private_data;
+	struct erofs_inode vi = { .sbi = sbi };
 
 	erofs_dbg("listxattr(%s): size=%llu", path, size);
 
@@ -239,10 +245,10 @@ static int optional_opt_func(void *data, const char *arg, int key,
 
 	switch (key) {
 	case 1:
-		ret = blob_open_ro(sbi.dev, arg + sizeof("--device=") - 1);
+		ret = blob_open_ro(cfg.sbi->dev, arg + sizeof("--device=") - 1);
 		if (ret)
 			return -1;
-		++sbi.extra_devices;
+		++cfg.sbi->extra_devices;
 		return 0;
 	case FUSE_OPT_KEY_NONOPT:
 		if (fusecfg.mountpoint)
@@ -293,15 +299,17 @@ int main(int argc, char *argv[])
 {
 	int ret;
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
+	struct erofs_sb_info *sbi;
 
 	erofs_init_configure();
 	printf("%s %s\n", basename(argv[0]), cfg.c_version);
 
-	sbi.dev = erofs_init_dev();
-	if (IS_ERR(sbi.dev)) {
-		ret = PTR_ERR(sbi.dev);
+	sbi = erofs_init_sbi();
+	if (IS_ERR(sbi)) {
+		ret = PTR_ERR(sbi);
 		goto err;
 	}
+	cfg.sbi = sbi;
 
 #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
 	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
@@ -326,24 +334,24 @@ int main(int argc, char *argv[])
 	cfg.c_offset = fusecfg.offset;
 
 	erofsfuse_dumpcfg();
-	ret = dev_open_ro(sbi.dev, fusecfg.disk);
+	ret = dev_open_ro(sbi->dev, fusecfg.disk);
 	if (ret) {
 		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
 		goto err_fuse_free_args;
 	}
 
-	ret = erofs_read_superblock();
+	ret = erofs_read_superblock(sbi);
 	if (ret) {
 		fprintf(stderr, "failed to read erofs super block\n");
 		goto err_dev_close;
 	}
 
-	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
+	ret = fuse_main(args.argc, args.argv, &erofs_ops, sbi);
 
-	erofs_put_super();
+	erofs_put_super(sbi);
 err_dev_close:
-	blob_closeall(sbi.dev);
-	dev_close(sbi.dev);
+	blob_closeall(sbi->dev);
+	dev_close(sbi->dev);
 err_fuse_free_args:
 	fuse_opt_free_args(&args);
 err:
diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 49cb7bf..82426b7 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -16,10 +16,10 @@ extern "C"
 
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode);
-int erofs_blob_remap(void);
+int erofs_blob_remap(struct erofs_sb_info *sbi);
 void erofs_blob_exit(void);
 int erofs_blob_init(const char *blobfile_path);
-int erofs_generate_devtable(void);
+int erofs_generate_devtable(struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index e7aec2b..c11d676 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -96,7 +96,7 @@ static inline bool erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 	return true;
 }
 
-struct erofs_buffer_head *erofs_buffer_init(void);
+struct erofs_buffer_head *erofs_buffer_init(struct erofs_sb_info *sbi);
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
 
 struct erofs_buffer_head *erofs_balloc(struct erofs_device *dev,
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 24f6204..b2c1fda 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -20,7 +20,8 @@ extern "C"
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode);
 
-int z_erofs_compress_init(struct erofs_buffer_head *bh);
+int z_erofs_compress_init(struct erofs_sb_info *sbi,
+			  struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_available_compressors(unsigned int i);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 6c96664..1129989 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -14,6 +14,7 @@ extern "C"
 
 #include "defs.h"
 #include "err.h"
+#include "internal.h"
 
 
 enum {
@@ -77,6 +78,8 @@ struct erofs_configure {
 
 	/* offset when reading multi partition images */
 	u64 c_offset;
+
+	struct erofs_sb_info *sbi;
 };
 
 extern struct erofs_configure cfg;
@@ -85,7 +88,7 @@ void erofs_init_configure(void);
 void erofs_show_config(void);
 void erofs_exit_configure(void);
 
-struct erofs_device *erofs_init_dev(void);
+struct erofs_sb_info *erofs_init_sbi(void);
 
 void erofs_set_fs_root(const char *rootdir);
 const char *erofs_fspath(const char *fullpath);
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 82bf7b8..dd7eee2 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -14,6 +14,7 @@ extern "C"
 #include "internal.h"
 
 struct z_erofs_decompress_req {
+	struct erofs_sb_info *sbi;
 	char *in, *out;
 
 	/*
diff --git a/include/erofs/dir.h b/include/erofs/dir.h
index 74bffb5..cd257c4 100644
--- a/include/erofs/dir.h
+++ b/include/erofs/dir.h
@@ -39,6 +39,7 @@ typedef int (*erofs_readdir_cb)(struct erofs_dir_context *);
  * the callback context. |de_namelen| is the exact dirent name length.
  */
 struct erofs_dir_context {
+	struct erofs_sb_info *sbi;
 	/*
 	 * During execution of |erofs_iterate_dir|, the function needs to
 	 * read the values inside |erofs_inode* dir|. So it is important
@@ -62,7 +63,8 @@ struct erofs_dir_context {
 /* Iterate over inodes that are in directory */
 int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck);
 /* Get a full pathname of the inode NID */
-int erofs_get_pathname(erofs_nid_t nid, char *buf, size_t size);
+int erofs_get_pathname(struct erofs_sb_info *sbi, erofs_nid_t nid,
+		       char *buf, size_t size);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 79b8d89..f76c675 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -20,7 +20,8 @@ unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
+struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
+						    struct erofs_inode *parent,
 						    const char *path);
 
 #ifdef __cplusplus
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index c4b36e9..98cfed1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -112,26 +112,23 @@ struct erofs_sb_info {
 	};
 };
 
-/* global sbi */
-extern struct erofs_sb_info sbi;
-
-static inline erofs_off_t iloc(erofs_nid_t nid)
+static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
 {
-	return blknr_to_addr(sbi.meta_blkaddr) + (nid << sbi.islotbits);
+	return blknr_to_addr(sbi->meta_blkaddr) + (nid << sbi->islotbits);
 }
 
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
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
@@ -156,6 +153,7 @@ struct erofs_inode {
 	};
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
+	struct erofs_sb_info *sbi;
 
 	umode_t i_mode;
 	erofs_off_t i_size;
@@ -246,6 +244,7 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
 
 struct erofs_dentry {
 	struct list_head d_child;	/* child of parent list */
+	struct erofs_sb_info *sbi;
 
 	unsigned int type;
 	char name[EROFS_NAME_LEN];
@@ -328,8 +327,8 @@ struct erofs_map_dev {
 };
 
 /* super.c */
-int erofs_read_superblock(void);
-void erofs_put_super(void);
+int erofs_read_superblock(struct erofs_sb_info *sbi);
+void erofs_put_super(struct erofs_sb_info *sbi);
 
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index a0528c0..0b63439 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -24,9 +24,10 @@ static inline unsigned int inlinexattr_header_size(struct erofs_inode *vi)
 		sizeof(u32) * vi->xattr_shared_count;
 }
 
-static inline erofs_blk_t xattrblock_addr(unsigned int xattr_id)
+static inline erofs_blk_t xattrblock_addr(struct erofs_sb_info *sbi,
+					  unsigned int xattr_id)
 {
-	return sbi.xattr_blkaddr +
+	return sbi->xattr_blkaddr +
 		xattr_id * sizeof(__u32) / EROFS_BLKSIZ;
 }
 
@@ -68,7 +69,8 @@ static inline unsigned int xattrblock_offset(unsigned int xattr_id)
 
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
-int erofs_build_shared_xattrs_from_path(const char *path);
+int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi,
+					const char *path);
 
 #ifdef __cplusplus
 }
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index d11d7db..b91a0cf 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -104,6 +104,7 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 				   erofs_off_t off)
 {
+	struct erofs_device *dev = inode->sbi->dev;
 	struct erofs_inode_chunk_index idx = {0};
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
 	erofs_blk_t extent_end, extents_blks;
@@ -158,7 +159,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	erofs_droid_blocklist_write_extent(inode, extent_start, extents_blks,
 					   first_extent, true);
 
-	return dev_write(sbi.dev, inode->chunkindexes, off, inode->extent_isize);
+	return dev_write(dev, inode->chunkindexes, off, inode->extent_isize);
 }
 
 int erofs_blob_write_chunked_file(struct erofs_inode *inode)
@@ -212,9 +213,9 @@ err:
 	return ret;
 }
 
-int erofs_blob_remap(void)
+int erofs_blob_remap(struct erofs_sb_info *sbi)
 {
-	struct erofs_device *dev = sbi.dev;
+	struct erofs_device *dev = sbi->dev;
 	struct erofs_buffer_head *bh;
 	ssize_t length;
 	erofs_off_t pos_in, pos_out;
@@ -281,22 +282,22 @@ int erofs_blob_init(const char *blobfile_path)
 	return 0;
 }
 
-int erofs_generate_devtable(void)
+int erofs_generate_devtable(struct erofs_sb_info *sbi)
 {
 	struct erofs_deviceslot dis;
 
 	if (!multidev)
 		return 0;
 
-	bh_devt = erofs_balloc(sbi.dev, DEVT, sizeof(dis), 0, 0);
+	bh_devt = erofs_balloc(sbi->dev, DEVT, sizeof(dis), 0, 0);
 	if (IS_ERR(bh_devt))
 		return PTR_ERR(bh_devt);
 
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
index 60b0ee6..478ac17 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -63,10 +63,10 @@ const struct erofs_bhops erofs_buf_write_bhops = {
 };
 
 /* return buffer_head of erofs super block (with size 0) */
-struct erofs_buffer_head *erofs_buffer_init(void)
+struct erofs_buffer_head *erofs_buffer_init(struct erofs_sb_info *sbi)
 {
 	int i, j;
-	struct erofs_buffer_head *bh = erofs_balloc(sbi.dev, META, 0, 0, 0);
+	struct erofs_buffer_head *bh = erofs_balloc(sbi->dev, META, 0, 0, 0);
 
 	if (IS_ERR(bh))
 		return bh;
diff --git a/lib/compress.c b/lib/compress.c
index ded0399..4f8d763 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -30,6 +30,7 @@ struct z_erofs_vle_compress_ctx {
 	unsigned int compressedblks;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
+	struct erofs_inode *vi;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -93,7 +94,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 	do {
 		/* XXX: big pcluster feature should be per-inode */
-		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
+		if (d0 == 1 && erofs_sb_has_big_pcluster(ctx->vi->sbi)) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
 					Z_EROFS_VLE_DI_D0_CBLKCNT);
@@ -142,12 +143,13 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 				     unsigned int *len, char *dst)
 {
+	struct erofs_sb_info *sbi = ctx->vi->sbi;
 	int ret;
 	unsigned int count;
 
 	/* reset clusterofs to 0 if permitted */
-	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
-	    ctx->head >= ctx->clusterofs) {
+	if (!erofs_sb_has_lz4_0padding(sbi) &&
+	    ctx->clusterofs && ctx->head >= ctx->clusterofs) {
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
 		ctx->clusterofs = 0;
@@ -161,7 +163,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
-	ret = blk_write(sbi.dev, dst, ctx->blkaddr, 1);
+	ret = blk_write(sbi->dev, dst, ctx->blkaddr, 1);
 	if (ret)
 		return ret;
 	return count;
@@ -307,7 +309,7 @@ nocompression:
 			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
 
 			/* zero out garbage trailing data for non-0padding */
-			if (!erofs_sb_has_lz4_0padding())
+			if (!erofs_sb_has_lz4_0padding(ctx->vi->sbi))
 				memset(dst + ret, 0,
 				       roundup(ret, EROFS_BLKSIZ) - ret);
 			else if (tailused)
@@ -317,8 +319,8 @@ nocompression:
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
 				  count, ctx->blkaddr, ctx->compressedblks);
 
-			ret = blk_write(sbi.dev, dst - padding, ctx->blkaddr,
-					ctx->compressedblks);
+			ret = blk_write(inode->sbi->dev, dst - padding,
+					ctx->blkaddr, ctx->compressedblks);
 			if (ret)
 				return ret;
 			raw = false;
@@ -384,10 +386,10 @@ static void *write_compacted_indexes(u8 *out,
 				     erofs_blk_t *blkaddr_ret,
 				     unsigned int destsize,
 				     unsigned int logical_clusterbits,
-				     bool final, bool *dummy_head)
+				     bool final, bool *dummy_head,
+				     bool update_blkaddr)
 {
 	unsigned int vcnt, encodebits, pos, i, cblks;
-	bool update_blkaddr;
 	erofs_blk_t blkaddr;
 
 	if (destsize == 4)
@@ -398,7 +400,6 @@ static void *write_compacted_indexes(u8 *out,
 		return ERR_PTR(-EINVAL);
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
-	update_blkaddr = erofs_sb_has_big_pcluster();
 
 	pos = 0;
 	for (i = 0; i < vcnt; ++i) {
@@ -463,7 +464,8 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	/* # of 8-byte units so that it can be aligned with 32 bytes */
 	unsigned int compacted_4b_initial, compacted_4b_end;
 	unsigned int compacted_2b;
-	bool dummy_head;
+	struct erofs_sb_info *sbi = inode->sbi;
+	bool dummy_head, big_pcluster = erofs_sb_has_big_pcluster(sbi);
 
 	if (logical_clusterbits < LOG_BLOCK_SIZE || LOG_BLOCK_SIZE < 12)
 		return -EINVAL;
@@ -495,7 +497,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	dummy_head = false;
 	/* prior to bigpcluster, blkaddr was bumped up once coming into HEAD */
-	if (!erofs_sb_has_big_pcluster()) {
+	if (!big_pcluster) {
 		--blkaddr;
 		dummy_head = true;
 	}
@@ -505,7 +507,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 2, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      4, logical_clusterbits, false,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 		compacted_4b_initial -= 2;
 	}
 	DBG_BUGON(compacted_4b_initial);
@@ -515,7 +517,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 16, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      2, logical_clusterbits, false,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 		compacted_2b -= 16;
 	}
 	DBG_BUGON(compacted_2b);
@@ -525,7 +527,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 2, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      4, logical_clusterbits, false,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 		compacted_4b_end -= 2;
 	}
 
@@ -535,7 +537,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		in = parse_legacy_indexes(cv, 1, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
 					      4, logical_clusterbits, true,
-					      &dummy_head);
+					      &dummy_head, big_pcluster);
 	}
 	inode->extent_isize = out - (u8 *)compressmeta;
 	return 0;
@@ -625,7 +627,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(sbi.dev, DATA, 0, 0, 0);
+	bh = erofs_balloc(inode->sbi->dev, DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto err_close;
@@ -640,7 +642,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	}
 
-	if (erofs_sb_has_big_pcluster()) {
+	if (erofs_sb_has_big_pcluster(inode->sbi)) {
 		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
@@ -654,6 +656,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
+	ctx.vi = inode;
 	remaining = inode->i_size;
 
 	while (remaining) {
@@ -743,13 +746,14 @@ static int erofs_get_compress_algorithm_id(const char *name)
 	return -ENOTSUP;
 }
 
-int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
+int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
+			     struct erofs_buffer_head *sb_bh)
 {
 	struct erofs_buffer_head *bh = sb_bh;
-	struct erofs_device *dev = sbi.dev;
+	struct erofs_device *dev = sbi->dev;
 	int ret = 0;
 
-	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
+	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
 		struct {
 			__le16 size;
 			struct z_erofs_lz4_cfgs lz4;
@@ -757,7 +761,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			.size = cpu_to_le16(sizeof(struct z_erofs_lz4_cfgs)),
 			.lz4 = {
 				.max_distance =
-					cpu_to_le16(sbi.lz4_max_distance),
+					cpu_to_le16(sbi->lz4_max_distance),
 				.max_pclusterblks = cfg.c_pclusterblks_max,
 			}
 		};
@@ -773,7 +777,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 		bh->op = &erofs_drop_directly_bhops;
 	}
 #ifdef HAVE_LIBLZMA
-	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZMA)) {
+	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZMA)) {
 		struct {
 			__le16 size;
 			struct z_erofs_lzma_cfgs lzma;
@@ -798,12 +802,15 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 	return ret;
 }
 
-int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
+int z_erofs_compress_init(struct erofs_sb_info *sbi,
+			  struct erofs_buffer_head *sb_bh)
 {
+	int ret;
+
+	compresshandle.sbi = sbi;
 	/* initialize for primary compression algorithm */
-	int ret = erofs_compressor_init(&compresshandle,
+	ret = erofs_compressor_init(&compresshandle,
 					cfg.c_compr_alg_master);
-
 	if (ret)
 		return ret;
 
@@ -813,7 +820,7 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	 */
 	if (!cfg.c_compr_alg_master ||
 	    (cfg.c_legacy_compress && !strcmp(cfg.c_compr_alg_master, "lz4")))
-		erofs_sb_clear_lz4_0padding();
+		erofs_sb_clear_lz4_0padding(sbi);
 
 	if (!cfg.c_compr_alg_master)
 		return 0;
@@ -841,15 +848,15 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 				  cfg.c_pclusterblks_max);
 			return -EINVAL;
 		}
-		erofs_sb_set_big_pcluster();
+		erofs_sb_set_big_pcluster(sbi);
 	}
 
 	if (ret != Z_EROFS_COMPRESSION_LZ4)
-		erofs_sb_set_compr_cfgs();
+		erofs_sb_set_compr_cfgs(sbi);
 
-	if (erofs_sb_has_compr_cfgs()) {
-		sbi.available_compr_algs |= 1 << ret;
-		return z_erofs_build_compr_cfgs(sb_bh);
+	if (erofs_sb_has_compr_cfgs(sbi)) {
+		sbi->available_compr_algs |= 1 << ret;
+		return z_erofs_build_compr_cfgs(sbi, sb_bh);
 	}
 	return 0;
 }
diff --git a/lib/compressor.h b/lib/compressor.h
index cf063f1..6b2401a 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -28,6 +28,7 @@ struct erofs_compressor {
 
 struct erofs_compress {
 	const struct erofs_compressor *alg;
+	struct erofs_sb_info *sbi;
 
 	unsigned int compress_threshold;
 	unsigned int compression_level;
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
 
diff --git a/lib/config.c b/lib/config.c
index 3cc1d22..53a54e8 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -15,7 +15,6 @@
 #endif
 
 struct erofs_configure cfg;
-struct erofs_sb_info sbi;
 
 void erofs_init_configure(void)
 {
@@ -55,18 +54,28 @@ void erofs_exit_configure(void)
 #endif
 	if (cfg.c_img_path)
 		free(cfg.c_img_path);
+	if (cfg.sbi)
+		free(cfg.sbi);
 }
 
-struct erofs_device *erofs_init_dev(void)
+struct erofs_sb_info *erofs_init_sbi(void)
 {
 	struct erofs_device *dev;
+	struct erofs_sb_info *sbi;
+
 	dev = calloc(1, sizeof(struct erofs_device));
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
-
 	dev->fd = -1;
 
-	return dev;
+	sbi = calloc(1, sizeof(struct erofs_sb_info));
+	if (!dev) {
+		free(dev);
+		return ERR_PTR(-ENOMEM);
+	}
+	sbi->dev = dev;
+
+	return sbi;
 }
 
 static unsigned int fullpath_prefix;	/* root directory prefix length */
diff --git a/lib/data.c b/lib/data.c
index abfa3f4..b87a505 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -33,7 +33,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 		map->m_plen = blknr_to_addr(lastblk) - offset;
 	} else if (tailendpacking) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
-		map->m_pa = iloc(vi->nid) + vi->inode_isize +
+		map->m_pa = iloc(vi->sbi, vi->nid) + vi->inode_isize +
 			vi->xattr_isize + erofs_blkoff(map->m_la);
 		map->m_plen = inode->i_size - offset;
 
@@ -65,6 +65,8 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
+	struct erofs_sb_info *sbi = vi->sbi;
+	struct erofs_device *dev = vi->sbi->dev;
 	struct erofs_inode_chunk_index *idx;
 	u8 buf[EROFS_BLKSIZ];
 	u64 chunknr;
@@ -89,10 +91,10 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
 
 	chunknr = map->m_la >> vi->u.chunkbits;
-	pos = roundup(iloc(vi->nid) + vi->inode_isize +
+	pos = roundup(iloc(sbi, vi->nid) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
-	err = blk_read(sbi.dev, 0, buf, erofs_blknr(pos), 1);
+	err = blk_read(dev, 0, buf, erofs_blknr(pos), 1);
 	if (err < 0)
 		return -EIO;
 
@@ -120,7 +122,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		break;
 	default:
 		map->m_deviceid = le16_to_cpu(idx->device_id) &
-			sbi.device_id_mask;
+			sbi->device_id_mask;
 		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
@@ -161,6 +163,7 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
@@ -183,7 +186,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
 		};
-		ret = erofs_map_dev(&sbi, &mdev);
+		ret = erofs_map_dev(sbi, &mdev);
 		if (ret)
 			return ret;
 
@@ -208,7 +211,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			map.m_la = ptr;
 		}
 
-		ret = dev_read(sbi.dev, mdev.m_deviceid, estart, mdev.m_pa,
+		ret = dev_read(sbi->dev, mdev.m_deviceid, estart, mdev.m_pa,
 			       eend - map.m_la);
 		if (ret < 0)
 			return -EIO;
@@ -225,6 +228,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		.index = UINT_MAX,
 	};
 	struct erofs_map_dev mdev;
+	struct erofs_sb_info *sbi = inode->sbi;
 	bool partial;
 	unsigned int bufsize = 0;
 	char *raw = NULL;
@@ -242,7 +246,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		mdev = (struct erofs_map_dev) {
 			.m_pa = map.m_pa,
 		};
-		ret = erofs_map_dev(&sbi, &mdev);
+		ret = erofs_map_dev(sbi, &mdev);
 		if (ret) {
 			DBG_BUGON(1);
 			break;
@@ -283,11 +287,12 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 				break;
 			}
 		}
-		ret = dev_read(sbi.dev, mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
+		ret = dev_read(sbi->dev, mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
 		if (ret < 0)
 			break;
 
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.sbi = sbi,
 					.in = raw,
 					.out = buffer + end - offset,
 					.decodedskip = skip,
diff --git a/lib/decompress.c b/lib/decompress.c
index 1661f91..fc4e049 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -82,7 +82,7 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 	bool support_0padding = false;
 	unsigned int inputmargin = 0;
 
-	if (erofs_sb_has_lz4_0padding()) {
+	if (erofs_sb_has_lz4_0padding(rq->sbi)) {
 		support_0padding = true;
 
 		while (!src[inputmargin & ~PAGE_MASK])
diff --git a/lib/dir.c b/lib/dir.c
index e6b9283..073d704 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -76,8 +76,8 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 					goto out;
 				}
 				ctx->flags |= EROFS_READDIR_DOTDOT_FOUND;
-				if (sbi.root_nid == ctx->dir->nid) {
-					ctx->pnid = sbi.root_nid;
+				if (ctx->sbi->root_nid == ctx->dir->nid) {
+					ctx->pnid = ctx->sbi->root_nid;
 					ctx->flags |= EROFS_READDIR_VALID_PNID;
 				}
 				if (fsck &&
@@ -203,7 +203,9 @@ static int erofs_get_pathname_iter(struct erofs_dir_context *ctx)
 	}
 
 	if (ctx->de_ftype == EROFS_FT_DIR || ctx->de_ftype == EROFS_FT_UNKNOWN) {
-		struct erofs_inode dir = { .nid = ctx->de_nid };
+		struct erofs_inode dir = {
+			.sbi = ctx->sbi,
+			.nid = ctx->de_nid, };
 
 		ret = erofs_read_inode_from_disk(&dir);
 		if (ret) {
@@ -229,11 +231,16 @@ static int erofs_get_pathname_iter(struct erofs_dir_context *ctx)
 	return 0;
 }
 
-int erofs_get_pathname(erofs_nid_t nid, char *buf, size_t size)
+int erofs_get_pathname(struct erofs_sb_info *sbi, erofs_nid_t nid,
+		       char *buf, size_t size)
 {
 	int ret;
-	struct erofs_inode root = { .nid = sbi.root_nid };
+	struct erofs_inode root = {
+		.sbi = sbi,
+		.nid = sbi->root_nid,
+	};
 	struct erofs_get_pathname_context pathctx = {
+		.ctx.sbi = sbi,
 		.ctx.flags = 0,
 		.ctx.dir = &root,
 		.ctx.cb = erofs_get_pathname_iter,
diff --git a/lib/inode.c b/lib/inode.c
index 09cd79f..cc21fd1 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -130,6 +130,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 	if (!d)
 		return ERR_PTR(-ENOMEM);
 
+	d->sbi = parent->sbi;
 	strncpy(d->name, name, EROFS_NAME_LEN - 1);
 	d->name[EROFS_NAME_LEN - 1] = '\0';
 
@@ -151,7 +152,8 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(sbi.dev, DATA, blknr_to_addr(nblocks), 0, 0);
+	bh = erofs_balloc(inode->sbi->dev, DATA, blknr_to_addr(nblocks),
+			  0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -278,7 +280,7 @@ static int write_dirblock(unsigned int q, struct erofs_dentry *head,
 	char buf[EROFS_BLKSIZ];
 
 	fill_dirblock(buf, EROFS_BLKSIZ, q, head, end);
-	return blk_write(sbi.dev, buf, blkaddr, 1);
+	return blk_write(head->sbi->dev, buf, blkaddr, 1);
 }
 
 static int erofs_write_dir_file(struct erofs_inode *dir)
@@ -340,7 +342,8 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 		return ret;
 
 	if (nblocks)
-		blk_write(sbi.dev, buf, inode->u.i_blkaddr, nblocks);
+		blk_write(inode->sbi->dev, buf, inode->u.i_blkaddr,
+			  nblocks);
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
@@ -382,7 +385,8 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 			return -EAGAIN;
 		}
 
-		ret = blk_write(sbi.dev, buf, inode->u.i_blkaddr + i, 1);
+		ret = blk_write(inode->sbi->dev, buf,
+				inode->u.i_blkaddr + i, 1);
 		if (ret)
 			return ret;
 	}
@@ -443,7 +447,7 @@ int erofs_write_file(struct erofs_inode *inode)
 static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
-	struct erofs_device *dev = sbi.dev;
+	struct erofs_device *dev = bh->block->dev;
 	const u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
 	erofs_off_t off = erofs_btell(bh, false);
 	union {
@@ -584,7 +588,8 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 
 	bh = inode->bh_data;
 	if (!bh) {
-		bh = erofs_balloc(sbi.dev, DATA, EROFS_BLKSIZ, 0, 0);
+		bh = erofs_balloc(inode->sbi->dev, DATA, EROFS_BLKSIZ,
+				  0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		bh->op = &erofs_skip_write_bhops;
@@ -607,6 +612,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 {
 	unsigned int inodesize;
 	struct erofs_buffer_head *bh, *ibh;
+	struct erofs_sb_info *sbi = inode->sbi;
 
 	DBG_BUGON(inode->bh || inode->bh_inline);
 
@@ -632,7 +638,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	bh = erofs_balloc(sbi.dev, INODE, inodesize, 0, inode->idata_size);
+	bh = erofs_balloc(sbi->dev, INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
@@ -645,7 +651,7 @@ noinline:
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
-		bh = erofs_balloc(sbi.dev, INODE, inodesize, 0, 0);
+		bh = erofs_balloc(sbi->dev, INODE, inodesize, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		DBG_BUGON(inode->bh_inline);
@@ -657,7 +663,7 @@ noinline:
 			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
 				  inode->compressed_idata ? "" : "un",
 				  inode->idata_size, inode->i_srcpath);
-			erofs_sb_set_ztailpacking();
+			erofs_sb_set_ztailpacking(sbi);
 		} else {
 			inode->datalayout = EROFS_INODE_FLAT_INLINE;
 			erofs_dbg("Inline tail-end data (%u bytes) to %s",
@@ -685,7 +691,7 @@ static bool erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = dev_write(sbi.dev, inode->idata, off, inode->idata_size);
+	ret = dev_write(bh->block->dev, inode->idata, off, inode->idata_size);
 	if (ret)
 		return false;
 
@@ -704,7 +710,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 static int erofs_write_tail_end(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh, *ibh;
-	struct erofs_device *dev = sbi.dev;
+	struct erofs_sb_info *sbi = inode->sbi;
 
 	bh = inode->bh_data;
 
@@ -727,20 +733,20 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
 
 		/* 0'ed data should be padded at head for 0padding conversion */
-		if (erofs_sb_has_lz4_0padding() && inode->compressed_idata) {
+		if (erofs_sb_has_lz4_0padding(sbi) && inode->compressed_idata) {
 			zero_pos = pos;
 			pos += EROFS_BLKSIZ - inode->idata_size;
 		} else {
 			/* pad 0'ed data for the other cases */
 			zero_pos = pos + inode->idata_size;
 		}
-		ret = dev_write(dev, inode->idata, pos, inode->idata_size);
+		ret = dev_write(sbi->dev, inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
 
 		DBG_BUGON(inode->idata_size > EROFS_BLKSIZ);
 		if (inode->idata_size < EROFS_BLKSIZ) {
-			ret = dev_fillzero(dev, zero_pos,
+			ret = dev_fillzero(sbi->dev, zero_pos,
 					   EROFS_BLKSIZ - inode->idata_size,
 					   false);
 			if (ret)
@@ -767,6 +773,8 @@ out:
 
 static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
+
 	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
 		return true;
 	if (inode->i_size > UINT_MAX)
@@ -777,8 +785,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if ((inode->i_mtime != sbi.build_time ||
-	     inode->i_mtime_nsec != sbi.build_time_nsec) &&
+	if ((inode->i_mtime != sbi->build_time ||
+	     inode->i_mtime_nsec != sbi->build_time_nsec) &&
 	    !cfg.c_ignore_mtime)
 		return true;
 	return false;
@@ -850,6 +858,7 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 			    struct stat64 *st,
 			    const char *path)
 {
+	struct erofs_sb_info *sbi = inode->sbi;
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
 
 	if (err)
@@ -871,11 +880,11 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 
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
@@ -921,7 +930,7 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 	return 0;
 }
 
-static struct erofs_inode *erofs_new_inode(void)
+static struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 {
 	struct erofs_inode *inode;
 
@@ -929,7 +938,8 @@ static struct erofs_inode *erofs_new_inode(void)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
+	inode->sbi = sbi;
+	inode->i_ino[0] = sbi->inos++;	/* inode serial number */
 	inode->i_count = 1;
 
 	init_list_head(&inode->i_subdirs);
@@ -938,7 +948,8 @@ static struct erofs_inode *erofs_new_inode(void)
 }
 
 /* get the inode from the (source) path */
-static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
+static struct erofs_inode *erofs_iget_from_path(struct erofs_sb_info *sbi,
+						const char *path, bool is_src)
 {
 	struct stat64 st;
 	struct erofs_inode *inode;
@@ -964,7 +975,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	}
 
 	/* cannot find in the inode cache */
-	inode = erofs_new_inode();
+	inode = erofs_new_inode(sbi);
 	if (IS_ERR(inode))
 		return inode;
 
@@ -990,7 +1001,7 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 		meta_offset = round_up(off - rootnid_maxoffset, EROFS_BLKSIZ);
 	else
 		meta_offset = 0;
-	sbi.meta_blkaddr = erofs_blknr(meta_offset);
+	rootdir->sbi->meta_blkaddr = erofs_blknr(meta_offset);
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
@@ -1005,7 +1016,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
+	meta_offset = blknr_to_addr(inode->sbi->meta_blkaddr);
 	DBG_BUGON(off < meta_offset);
 	return inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
@@ -1132,7 +1143,7 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 					sizeof("Processing  ...") - 1);
 		erofs_update_progressinfo("Processing %s ...", trimmed);
 		free(trimmed);
-		d->inode = erofs_mkfs_build_tree_from_path(dir, buf);
+		d->inode = erofs_mkfs_build_tree_from_path(dir->sbi, dir, buf);
 		if (IS_ERR(d->inode)) {
 			ret = PTR_ERR(d->inode);
 fail:
@@ -1160,10 +1171,11 @@ err:
 	return ERR_PTR(ret);
 }
 
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
+struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
+						    struct erofs_inode *parent,
 						    const char *path)
 {
-	struct erofs_inode *const inode = erofs_iget_from_path(path, true);
+	struct erofs_inode *const inode = erofs_iget_from_path(sbi, path, true);
 
 	if (IS_ERR(inode))
 		return inode;
diff --git a/lib/io.c b/lib/io.c
index 2b9811e..d4d127e 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -10,6 +10,7 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
+#include <stdlib.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include "erofs/io.h"
@@ -52,6 +53,7 @@ void dev_close(struct erofs_device *dev)
 	dev->name = NULL;
 	dev->fd   = -1;
 	dev->size   = 0;
+	free(dev);
 }
 
 int dev_open(struct erofs_device *dev, const char *devname)
diff --git a/lib/namei.c b/lib/namei.c
index bb14d30..8612b81 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -28,8 +28,9 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	char buf[sizeof(struct erofs_inode_extended)];
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
-	struct erofs_device *dev = sbi.dev;
-	const erofs_off_t inode_loc = iloc(vi->nid);
+	struct erofs_sb_info *sbi = vi->sbi;
+	struct erofs_device *dev = vi->sbi->dev;
+	const erofs_off_t inode_loc = iloc(sbi, vi->nid);
 
 	ret = dev_read(dev, 0, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
@@ -115,8 +116,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_gid = le16_to_cpu(dic->i_gid);
 		vi->i_nlink = le16_to_cpu(dic->i_nlink);
 
-		vi->i_mtime = sbi.build_time;
-		vi->i_mtime_nsec = sbi.build_time_nsec;
+		vi->i_mtime = sbi->build_time;
+		vi->i_mtime_nsec = sbi->build_time_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
 		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
@@ -183,6 +184,7 @@ struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
 }
 
 struct nameidata {
+	struct erofs_sb_info *sbi;
 	erofs_nid_t	nid;
 	unsigned int	ftype;
 };
@@ -193,7 +195,10 @@ int erofs_namei(struct nameidata *nd,
 	erofs_nid_t nid = nd->nid;
 	int ret;
 	char buf[EROFS_BLKSIZ];
-	struct erofs_inode vi = { .nid = nid };
+	struct erofs_inode vi = {
+		.sbi = nd->sbi,
+		.nid = nid,
+	};
 	erofs_off_t offset;
 
 	ret = erofs_read_inode_from_disk(&vi);
@@ -235,7 +240,7 @@ int erofs_namei(struct nameidata *nd,
 
 static int link_path_walk(const char *name, struct nameidata *nd)
 {
-	nd->nid = sbi.root_nid;
+	nd->nid = nd->sbi->root_nid;
 
 	while (*name == '/')
 		name++;
@@ -265,7 +270,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 int erofs_ilookup(const char *path, struct erofs_inode *vi)
 {
 	int ret;
-	struct nameidata nd;
+	struct nameidata nd = { .sbi = vi->sbi };
 
 	ret = link_path_walk(path, &nd);
 	if (ret)
diff --git a/lib/super.c b/lib/super.c
index 8727161..fcd27b6 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -31,7 +31,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 
 	sbi->total_blocks = sbi->primarydevice_blocks;
 
-	if (!erofs_sb_has_device_table())
+	if (!erofs_sb_has_device_table(sbi))
 		ondisk_extradevs = 0;
 	else
 		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
@@ -66,14 +66,14 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	return 0;
 }
 
-int erofs_read_superblock(void)
+int erofs_read_superblock(struct erofs_sb_info *sbi)
 {
 	char data[EROFS_BLKSIZ];
 	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	int ret;
 
-	ret = blk_read(sbi.dev, 0, data, 0, 1);
+	ret = blk_read(sbi->dev, 0, data, 0, 1);
 	if (ret < 0) {
 		erofs_err("cannot read erofs superblock: %d", ret);
 		return -EIO;
@@ -86,7 +86,7 @@ int erofs_read_superblock(void)
 		return ret;
 	}
 
-	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
@@ -96,26 +96,26 @@ int erofs_read_superblock(void)
 		return ret;
 	}
 
-	if (!check_layout_compatibility(&sbi, dsb))
+	if (!check_layout_compatibility(sbi, dsb))
 		return ret;
 
-	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
-	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
-	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
-	sbi.islotbits = EROFS_ISLOTBITS;
-	sbi.root_nid = le16_to_cpu(dsb->root_nid);
-	sbi.inos = le64_to_cpu(dsb->inos);
-	sbi.checksum = le32_to_cpu(dsb->checksum);
+	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
+	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
+	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
+	sbi->islotbits = EROFS_ISLOTBITS;
+	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->inos = le64_to_cpu(dsb->inos);
+	sbi->checksum = le32_to_cpu(dsb->checksum);
 
-	sbi.build_time = le64_to_cpu(dsb->build_time);
-	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+	sbi->build_time = le64_to_cpu(dsb->build_time);
+	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
-	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
-	return erofs_init_devices(&sbi, dsb);
+	memcpy(sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
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
diff --git a/lib/xattr.c b/lib/xattr.c
index e0bf922..2496004 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -549,7 +549,8 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 static bool erofs_bh_flush_write_shared_xattrs(struct erofs_buffer_head *bh)
 {
 	void *buf = bh->fsprivate;
-	int err = dev_write(sbi.dev, buf, erofs_btell(bh, false), shared_xattrs_size);
+	int err = dev_write(bh->block->dev, buf, erofs_btell(bh, false),
+			    shared_xattrs_size);
 
 	if (err)
 		return false;
@@ -579,7 +580,8 @@ static int comp_xattr_item(const void *a, const void *b)
 	return la > lb;
 }
 
-int erofs_build_shared_xattrs_from_path(const char *path)
+int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi,
+					const char *path)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
@@ -609,7 +611,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	if (!buf)
 		return -ENOMEM;
 
-	bh = erofs_balloc(sbi.dev, XATTR, shared_xattrs_size, 0, 0);
+	bh = erofs_balloc(sbi->dev, XATTR, shared_xattrs_size, 0, 0);
 	if (IS_ERR(bh)) {
 		free(buf);
 		return PTR_ERR(bh);
@@ -619,7 +621,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
+	sbi->xattr_blkaddr = off / EROFS_BLKSIZ;
 	off %= EROFS_BLKSIZ;
 	p = 0;
 
@@ -716,6 +718,7 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 }
 
 struct xattr_iter {
+	struct erofs_sb_info *sbi;
 	char page[EROFS_BLKSIZ];
 
 	void *kaddr;
@@ -729,7 +732,8 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
-	struct erofs_device *dev = sbi.dev;
+	struct erofs_sb_info *sbi = vi->sbi;
+	struct erofs_device *dev = vi->sbi->dev;
 	int ret = 0;
 
 	/* the most case is that xattrs of this inode are initialized. */
@@ -757,8 +761,8 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 		return -ENOATTR;
 	}
 
-	it.blkaddr = erofs_blknr(iloc(vi->nid) + vi->inode_isize);
-	it.ofs = erofs_blkoff(iloc(vi->nid) + vi->inode_isize);
+	it.blkaddr = erofs_blknr(iloc(sbi, vi->nid) + vi->inode_isize);
+	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
 
 	ret = blk_read(dev, 0, it.page, it.blkaddr, 1);
 	if (ret < 0)
@@ -825,7 +829,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 
 	it->blkaddr += erofs_blknr(it->ofs);
 
-	ret = blk_read(sbi.dev, 0, it->page, it->blkaddr, 1);
+	ret = blk_read(it->sbi->dev, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -837,6 +841,8 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 static int inline_xattr_iter_pre(struct xattr_iter *it,
 				   struct erofs_inode *vi)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
+	struct erofs_device *dev = vi->sbi->dev;
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 	int ret;
 
@@ -848,10 +854,10 @@ static int inline_xattr_iter_pre(struct xattr_iter *it,
 
 	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
 
-	it->blkaddr = erofs_blknr(iloc(vi->nid) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(iloc(vi->nid) + inline_xattr_ofs);
+	it->blkaddr = erofs_blknr(iloc(sbi, vi->nid) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
 
-	ret = blk_read(sbi.dev, 0, it->page, it->blkaddr, 1);
+	ret = blk_read(dev, 0, it->page, it->blkaddr, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -1038,17 +1044,18 @@ static int inline_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 
 static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		erofs_blk_t blkaddr =
-			xattrblock_addr(vi->xattr_shared_xattrs[i]);
+			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
 
 		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
 
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(sbi.dev, 0, it->it.page, blkaddr, 1);
+			ret = blk_read(sbi->dev, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
@@ -1091,6 +1098,7 @@ int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 	it.buffer = buffer;
 	it.buffer_size = buffer_size;
 
+	it.it.sbi = vi->sbi;
 	ret = inline_getxattr(vi, &it);
 	if (ret == -ENOATTR)
 		ret = shared_getxattr(vi, &it);
@@ -1178,16 +1186,17 @@ static int inline_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 
 static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	unsigned int i;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		erofs_blk_t blkaddr =
-			xattrblock_addr(vi->xattr_shared_xattrs[i]);
+			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
 
 		it->it.ofs = xattrblock_offset(vi->xattr_shared_xattrs[i]);
 		if (!i || blkaddr != it->it.blkaddr) {
-			ret = blk_read(sbi.dev, 0, it->it.page, blkaddr, 1);
+			ret = blk_read(sbi->dev, 0, it->it.page, blkaddr, 1);
 			if (ret < 0)
 				return -EIO;
 
@@ -1218,6 +1227,7 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	it.buffer_size = buffer_size;
 	it.buffer_ofs = 0;
 
+	it.it.sbi = vi->sbi;
 	ret = inline_listxattr(vi, &it);
 	if (ret < 0 && ret != -ENOATTR)
 		return ret;
diff --git a/lib/zmap.c b/lib/zmap.c
index 6e5a5d4..0ddc922 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -16,8 +16,10 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
-	if (!erofs_sb_has_big_pcluster() &&
-	    !erofs_sb_has_ztailpacking() &&
+	struct erofs_sb_info *sbi = vi->sbi;
+
+	if (!erofs_sb_has_big_pcluster(sbi) &&
+	    !erofs_sb_has_ztailpacking(sbi) &&
 	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
@@ -31,6 +33,7 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
+	struct erofs_sb_info *sbi = vi->sbi;
 	int ret;
 	erofs_off_t pos;
 	struct z_erofs_map_header *h;
@@ -39,12 +42,13 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
-	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
-		  !erofs_sb_has_ztailpacking() &&
+	DBG_BUGON(!erofs_sb_has_big_pcluster(sbi) &&
+		  !erofs_sb_has_ztailpacking(sbi) &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
-	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+	pos = round_up(iloc(vi->sbi, vi->nid) + vi->inode_isize +
+		       vi->xattr_isize, 8);
 
-	ret = dev_read(sbi.dev, 0, buf, pos, sizeof(buf));
+	ret = dev_read(sbi->dev, 0, buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -111,7 +115,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	if (map->index == eblk)
 		return 0;
 
-	ret = blk_read(sbi.dev, 0, mpage, eblk, 1);
+	ret = blk_read(m->inode->sbi->dev, 0, mpage, eblk, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -124,7 +128,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					 unsigned long lcn)
 {
 	struct erofs_inode *const vi = m->inode;
-	const erofs_off_t ibase = iloc(vi->nid);
+	const erofs_off_t ibase = iloc(vi->sbi, vi->nid);
 	const erofs_off_t pos =
 		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
 					       vi->xattr_isize) +
@@ -322,9 +326,9 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
-					   vi->xattr_isize, 8) +
-		sizeof(struct z_erofs_map_header);
+	const erofs_off_t ebase = round_up(iloc(vi->sbi, vi->nid) +
+					   vi->inode_isize + vi->xattr_isize, 8) +
+				  sizeof(struct z_erofs_map_header);
 	const unsigned int totalidx = BLK_ROUND_UP(vi->i_size);
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
diff --git a/mkfs/main.c b/mkfs/main.c
index e3ad9d9..3e8a1c0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -176,7 +176,7 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			erofs_sb_clear_sb_chksum();
+			erofs_sb_clear_sb_chksum(cfg.sbi);
 		}
 
 		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
@@ -265,7 +265,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 #ifdef HAVE_LIBUUID
 		case 'U':
-			if (uuid_parse(optarg, sbi.uuid)) {
+			if (uuid_parse(optarg, cfg.sbi->uuid)) {
 				erofs_err("invalid UUID %s", optarg);
 				return -EINVAL;
 			}
@@ -373,7 +373,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  optarg);
 				return -EINVAL;
 			}
-			erofs_sb_set_chunked_file();
+			erofs_sb_set_chunked_file(cfg.sbi);
 			break;
 		case 12:
 			quiet = true;
@@ -456,24 +456,25 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	return 0;
 }
 
-int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
+int erofs_mkfs_update_super_block(struct erofs_sb_info *sbi,
+				  struct erofs_buffer_head *bh,
 				  erofs_nid_t root_nid,
 				  erofs_blk_t *blocks)
 {
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
 		.blkszbits = LOG_BLOCK_SIZE,
-		.inos   = cpu_to_le64(sbi.inos),
-		.build_time = cpu_to_le64(sbi.build_time),
-		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
+		.inos   = cpu_to_le64(sbi->inos),
+		.build_time = cpu_to_le64(sbi->build_time),
+		.build_time_nsec = cpu_to_le32(sbi->build_time_nsec),
 		.blocks = 0,
-		.meta_blkaddr  = sbi.meta_blkaddr,
-		.xattr_blkaddr = sbi.xattr_blkaddr,
-		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
-		.feature_compat = cpu_to_le32(sbi.feature_compat &
+		.meta_blkaddr  = sbi->meta_blkaddr,
+		.xattr_blkaddr = sbi->xattr_blkaddr,
+		.feature_incompat = cpu_to_le32(sbi->feature_incompat),
+		.feature_compat = cpu_to_le32(sbi->feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
-		.extra_devices = cpu_to_le16(sbi.extra_devices),
-		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
+		.extra_devices = cpu_to_le16(sbi->extra_devices),
+		.devt_slotoff = cpu_to_le16(sbi->devt_slotoff),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -482,12 +483,12 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
-	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
+	memcpy(sb.uuid, sbi->uuid, sizeof(sb.uuid));
 
-	if (erofs_sb_has_compr_cfgs())
-		sb.u1.available_compr_algs = sbi.available_compr_algs;
+	if (erofs_sb_has_compr_cfgs(sbi))
+		sb.u1.available_compr_algs = sbi->available_compr_algs;
 	else
-		sb.u1.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance);
+		sb.u1.lz4_max_distance = cpu_to_le16(sbi->lz4_max_distance);
 
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
@@ -502,13 +503,13 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	return 0;
 }
 
-static int erofs_mkfs_superblock_csum_set(void)
+static int erofs_mkfs_superblock_csum_set(struct erofs_sb_info *sbi)
 {
 	int ret;
 	u8 buf[EROFS_BLKSIZ];
 	u32 crc;
 	struct erofs_super_block *sb;
-	struct erofs_device *dev = sbi.dev;
+	struct erofs_device *dev = sbi->dev;
 
 	ret = blk_read(dev, 0, buf, 0, 1);
 	if (ret) {
@@ -551,15 +552,15 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
-	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
-	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
+	cfg.sbi->feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	cfg.sbi->feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
 
 	/* generate a default uuid first */
 #ifdef HAVE_LIBUUID
 	do {
-		uuid_generate(sbi.uuid);
-	} while (uuid_is_null(sbi.uuid));
+		uuid_generate(cfg.sbi->uuid);
+	} while (uuid_is_null(cfg.sbi->uuid));
 #endif
 }
 
@@ -599,6 +600,7 @@ void erofs_show_progs(int argc, char *argv[])
 int main(int argc, char **argv)
 {
 	int err = 0;
+	struct erofs_sb_info *sbi;
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode;
 	erofs_nid_t root_nid;
@@ -609,9 +611,10 @@ int main(int argc, char **argv)
 
 	erofs_init_configure();
 
-	sbi.dev = erofs_init_dev();
-	if (IS_ERR(sbi.dev))
+	sbi = erofs_init_sbi();
+	if (IS_ERR(sbi))
 		return 1;
+	cfg.sbi = sbi;
 
 	erofs_mkfs_default_options();
 	err = mkfs_parse_options_cfg(argc, argv);
@@ -645,14 +648,14 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_unix_timestamp != -1) {
-		sbi.build_time      = cfg.c_unix_timestamp;
-		sbi.build_time_nsec = 0;
+		sbi->build_time      = cfg.c_unix_timestamp;
+		sbi->build_time_nsec = 0;
 	} else if (!gettimeofday(&t, NULL)) {
-		sbi.build_time      = t.tv_sec;
-		sbi.build_time_nsec = t.tv_usec;
+		sbi->build_time      = t.tv_sec;
+		sbi->build_time_nsec = t.tv_usec;
 	}
 
-	err = dev_open(sbi.dev, cfg.c_img_path);
+	err = dev_open(sbi->dev, cfg.c_img_path);
 	if (err) {
 		usage();
 		return 1;
@@ -671,7 +674,7 @@ int main(int argc, char **argv)
 	}
 #endif
 	erofs_show_config();
-	if (erofs_sb_has_chunked_file())
+	if (erofs_sb_has_chunked_file(sbi))
 		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
 	if (cfg.c_ztailpacking)
 		erofs_warn("EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
@@ -680,7 +683,7 @@ int main(int argc, char **argv)
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
 #endif
-	sb_bh = erofs_buffer_init();
+	sb_bh = erofs_buffer_init(sbi);
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
 		erofs_err("failed to initialize buffers: %s",
@@ -701,34 +704,34 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = z_erofs_compress_init(sb_bh);
+	err = z_erofs_compress_init(sbi, sb_bh);
 	if (err) {
 		erofs_err("failed to initialize compressor: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 
-	err = erofs_generate_devtable();
+	err = erofs_generate_devtable(sbi);
 	if (err) {
 		erofs_err("failed to generate device table: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 #ifdef HAVE_LIBUUID
-	uuid_unparse_lower(sbi.uuid, uuid_str);
+	uuid_unparse_lower(sbi->uuid, uuid_str);
 #endif
 	erofs_info("filesystem UUID: %s", uuid_str);
 
 	erofs_inode_manager_init();
 
-	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
+	err = erofs_build_shared_xattrs_from_path(sbi, cfg.c_src_path);
 	if (err) {
 		erofs_err("failed to build shared xattrs: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 
-	root_inode = erofs_mkfs_build_tree_from_path(NULL, cfg.c_src_path);
+	root_inode = erofs_mkfs_build_tree_from_path(sbi, NULL, cfg.c_src_path);
 	if (IS_ERR(root_inode)) {
 		err = PTR_ERR(root_inode);
 		goto exit;
@@ -739,29 +742,29 @@ int main(int argc, char **argv)
 
 	if (cfg.c_chunkbits) {
 		erofs_info("total metadata: %u blocks", erofs_mapbh(NULL));
-		err = erofs_blob_remap();
+		err = erofs_blob_remap(sbi);
 		if (err)
 			goto exit;
 	}
 
-	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
+	err = erofs_mkfs_update_super_block(sbi, sb_bh, root_nid, &nblocks);
 	if (err)
 		goto exit;
 
 	/* flush all remaining buffers */
-	if (!erofs_bflush(sbi.dev, NULL))
+	if (!erofs_bflush(sbi->dev, NULL))
 		err = -EIO;
 	else
-		err = dev_resize(sbi.dev, nblocks);
+		err = dev_resize(sbi->dev, nblocks);
 
-	if (!err && erofs_sb_has_sb_chksum())
-		err = erofs_mkfs_superblock_csum_set();
+	if (!err && erofs_sb_has_sb_chksum(sbi))
+		err = erofs_mkfs_superblock_csum_set(sbi);
 exit:
 	z_erofs_compress_exit();
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
 #endif
-	dev_close(sbi.dev);
+	dev_close(sbi->dev);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
-- 
2.34.1

