Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85461925FD7
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 14:13:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r+ilzzV7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDdvw4jYRz3dLW
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 22:13:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r+ilzzV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDdvr36tmz3cl9
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 22:12:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008772; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mWtAh+ChzxWFY5o6ilnGes1Z4fbft8Rn3PeAI3Kuyok=;
	b=r+ilzzV78Zr0UcRGiP0TFFGB0wakaH0h9jRSXZcMZQpC3JSDqE7e/af42Nfa80XjrOIjB5H1ZHEVi+FPnL9SnqRZv3NzR5VTaXrMfAbYVZ9ITc0kDgC8wi/wBbdbax6/3fRHNAymjbIkaP4jHCT7PnZnfs3907bamj9qXzAInN4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9nL2wJ_1720008771;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9nL2wJ_1720008771)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:12:51 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: rename the global sbi to g_sbi
Date: Wed,  3 Jul 2024 20:12:47 +0800
Message-Id: <20240703121247.3797289-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703121247.3797289-1-hongzhen@linux.alibaba.com>
References: <20240703121247.3797289-1-hongzhen@linux.alibaba.com>
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

Rename the global `sbi` to `g_sbi` to prepare for
the upcoming per-sbi buffer.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 dump/main.c              |  58 +++++++++----------
 fsck/main.c              |  34 +++++------
 fuse/main.c              |  40 ++++++-------
 include/erofs/cache.h    |   6 +-
 include/erofs/internal.h |   2 +-
 lib/cache.c              |  22 +++----
 lib/config.c             |   2 +-
 lib/diskbuf.c            |   6 +-
 lib/rebuild.c            |   4 +-
 mkfs/main.c              | 122 +++++++++++++++++++--------------------
 10 files changed, 148 insertions(+), 148 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 7c77c92..06ca4d3 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -166,10 +166,10 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			usage(argc, argv);
 			exit(0);
 		case 3:
-			err = erofs_blob_open_ro(&sbi, optarg);
+			err = erofs_blob_open_ro(&g_sbi, optarg);
 			if (err)
 				return err;
-			++sbi.extra_devices;
+			++g_sbi.extra_devices;
 			break;
 		case 4:
 			dumpcfg.inode_path = optarg;
@@ -180,7 +180,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			dumpcfg.show_subdirectories = true;
 			break;
 		case 6:
-			sbi.bdev.offset = strtoull(optarg, &endptr, 0);
+			g_sbi.bdev.offset = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid disk offset %s", optarg);
 				return -EINVAL;
@@ -289,9 +289,9 @@ static int erofsdump_read_packed_inode(void)
 {
 	int err;
 	erofs_off_t occupied_size = 0;
-	struct erofs_inode vi = { .sbi = &sbi, .nid = sbi.packed_nid };
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = g_sbi.packed_nid };
 
-	if (!(erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0))
+	if (!(erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0))
 		return 0;
 
 	err = erofs_read_inode_from_disk(&vi);
@@ -315,7 +315,7 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 {
 	int err;
 	erofs_off_t occupied_size = 0;
-	struct erofs_inode vi = { .sbi = &sbi, .nid = ctx->de_nid };
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = ctx->de_nid };
 
 	err = erofs_read_inode_from_disk(&vi);
 	if (err) {
@@ -370,7 +370,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	int err, i;
 	erofs_off_t size;
 	u16 access_mode;
-	struct erofs_inode inode = { .sbi = &sbi, .nid = dumpcfg.nid };
+	struct erofs_inode inode = { .sbi = &g_sbi, .nid = dumpcfg.nid };
 	char path[PATH_MAX];
 	char access_mode_str[] = "rwxrwxrwx";
 	char timebuf[128] = {0};
@@ -582,7 +582,7 @@ static void erofsdump_print_statistic(void)
 		.pnid = 0,
 		.dir = NULL,
 		.cb = erofsdump_dirent_iter,
-		.de_nid = sbi.root_nid,
+		.de_nid = g_sbi.root_nid,
 		.dname = "",
 		.de_namelen = 0,
 	};
@@ -626,48 +626,48 @@ static void erofsdump_print_supported_compressors(FILE *f, unsigned int mask)
 
 static void erofsdump_show_superblock(void)
 {
-	time_t time = sbi.build_time;
+	time_t time = g_sbi.build_time;
 	char uuid_str[37];
 	int i = 0;
 
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
 			EROFS_SUPER_MAGIC_V1);
 	fprintf(stdout, "Filesystem blocksize:                         %u\n",
-			erofs_blksiz(&sbi));
+			erofs_blksiz(&g_sbi));
 	fprintf(stdout, "Filesystem blocks:                            %llu\n",
-			sbi.total_blocks | 0ULL);
+			g_sbi.total_blocks | 0ULL);
 	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
-			sbi.meta_blkaddr);
+			g_sbi.meta_blkaddr);
 	fprintf(stdout, "Filesystem shared xattr metadata start block: %u\n",
-			sbi.xattr_blkaddr);
+			g_sbi.xattr_blkaddr);
 	fprintf(stdout, "Filesystem root nid:                          %llu\n",
-			sbi.root_nid | 0ULL);
-	if (erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0)
+			g_sbi.root_nid | 0ULL);
+	if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
-			sbi.packed_nid | 0ULL);
-	if (erofs_sb_has_compr_cfgs(&sbi)) {
+			g_sbi.packed_nid | 0ULL);
+	if (erofs_sb_has_compr_cfgs(&g_sbi)) {
 		fprintf(stdout, "Filesystem compr_algs:                        ");
 		erofsdump_print_supported_compressors(stdout,
-			sbi.available_compr_algs);
+			g_sbi.available_compr_algs);
 	} else {
 		fprintf(stdout, "Filesystem lz4_max_distance:                  %u\n",
-			sbi.lz4_max_distance | 0U);
+			g_sbi.lz4_max_distance | 0U);
 	}
 	fprintf(stdout, "Filesystem sb_size:                           %u\n",
-			sbi.sb_size | 0U);
+			g_sbi.sb_size | 0U);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
-			sbi.inos | 0ULL);
+			g_sbi.inos | 0ULL);
 	fprintf(stdout, "Filesystem created:                           %s",
 			ctime(&time));
 	fprintf(stdout, "Filesystem features:                          ");
 	for (; i < ARRAY_SIZE(feature_lists); i++) {
 		u32 feat = le32_to_cpu(feature_lists[i].compat ?
-				       sbi.feature_compat :
-				       sbi.feature_incompat);
+				       g_sbi.feature_compat :
+				       g_sbi.feature_incompat);
 		if (feat & feature_lists[i].flag)
 			fprintf(stdout, "%s ", feature_lists[i].name);
 	}
-	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
+	erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
 	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
 			uuid_str);
 }
@@ -684,13 +684,13 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDONLY | O_TRUNC);
+	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDONLY | O_TRUNC);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
 	}
 
-	err = erofs_read_superblock(&sbi);
+	err = erofs_read_superblock(&g_sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit_dev_close;
@@ -715,11 +715,11 @@ int main(int argc, char **argv)
 		erofsdump_show_fileinfo(dumpcfg.show_extent);
 
 exit_put_super:
-	erofs_put_super(&sbi);
+	erofs_put_super(&g_sbi);
 exit_dev_close:
-	erofs_dev_close(&sbi);
+	erofs_dev_close(&g_sbi);
 exit:
-	erofs_blob_closeall(&sbi);
+	erofs_blob_closeall(&g_sbi);
 	erofs_exit_configure();
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index a505e99..8ec9486 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -183,10 +183,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			}
 			break;
 		case 3:
-			ret = erofs_blob_open_ro(&sbi, optarg);
+			ret = erofs_blob_open_ro(&g_sbi, optarg);
 			if (ret)
 				return ret;
-			++sbi.extra_devices;
+			++g_sbi.extra_devices;
 			break;
 		case 4:
 			fsckcfg.force = true;
@@ -219,7 +219,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			has_opt_preserve = true;
 			break;
 		case 12:
-			sbi.bdev.offset = strtoull(optarg, &endptr, 0);
+			g_sbi.bdev.offset = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid disk offset %s", optarg);
 				return -EINVAL;
@@ -311,7 +311,7 @@ static int erofs_check_sb_chksum(void)
 	struct erofs_super_block *sb;
 	int ret;
 
-	ret = erofs_blk_read(&sbi, 0, buf, 0, 1);
+	ret = erofs_blk_read(&g_sbi, 0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to check checksum: %d",
 			  ret);
@@ -321,10 +321,10 @@ static int erofs_check_sb_chksum(void)
 	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
 	sb->checksum = 0;
 
-	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz(&sbi) - EROFS_SUPER_OFFSET);
-	if (crc != sbi.checksum) {
+	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz(&g_sbi) - EROFS_SUPER_OFFSET);
+	if (crc != g_sbi.checksum) {
 		erofs_err("superblock chksum doesn't match: saved(%08xh) calculated(%08xh)",
-			  sbi.checksum, crc);
+			  g_sbi.checksum, crc);
 		fsckcfg.corrupted = true;
 		return -1;
 	}
@@ -889,7 +889,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
 
 	inode.nid = nid;
-	inode.sbi = &sbi;
+	inode.sbi = &g_sbi;
 	ret = erofs_read_inode_from_disk(&inode);
 	if (ret) {
 		if (ret == -EIO)
@@ -965,19 +965,19 @@ int main(int argc, char *argv[])
 	cfg.c_dbg_lvl = -1;
 #endif
 
-	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDONLY);
+	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDONLY);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
 	}
 
-	err = erofs_read_superblock(&sbi);
+	err = erofs_read_superblock(&g_sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit_dev_close;
 	}
 
-	if (erofs_sb_has_sb_chksum(&sbi) && erofs_check_sb_chksum()) {
+	if (erofs_sb_has_sb_chksum(&g_sbi) && erofs_check_sb_chksum()) {
 		erofs_err("failed to verify superblock checksum");
 		goto exit_put_super;
 	}
@@ -985,15 +985,15 @@ int main(int argc, char *argv[])
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_init();
 
-	if (erofs_sb_has_fragments(&sbi) && sbi.packed_nid > 0) {
-		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
+	if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
+		err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
 		if (err) {
 			erofs_err("failed to verify packed file");
 			goto exit_hardlink;
 		}
 	}
 
-	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
+	err = erofsfsck_check_inode(g_sbi.root_nid, g_sbi.root_nid);
 	if (fsckcfg.corrupted) {
 		if (!fsckcfg.extract_path)
 			erofs_err("Found some filesystem corruption");
@@ -1019,11 +1019,11 @@ exit_hardlink:
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_exit();
 exit_put_super:
-	erofs_put_super(&sbi);
+	erofs_put_super(&g_sbi);
 exit_dev_close:
-	erofs_dev_close(&sbi);
+	erofs_dev_close(&g_sbi);
 exit:
-	erofs_blob_closeall(&sbi);
+	erofs_blob_closeall(&g_sbi);
 	erofs_exit_configure();
 	return err ? 1 : 0;
 }
diff --git a/fuse/main.c b/fuse/main.c
index 70e3218..f6c04e8 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -41,13 +41,13 @@ struct erofsfuse_lookupdir_context {
 static inline erofs_nid_t erofsfuse_to_nid(fuse_ino_t ino)
 {
 	if (ino == FUSE_ROOT_ID)
-		return sbi.root_nid;
+		return g_sbi.root_nid;
 	return (erofs_nid_t)(ino - FUSE_ROOT_ID);
 }
 
 static inline fuse_ino_t erofsfuse_to_ino(erofs_nid_t nid)
 {
-	if (nid == sbi.root_nid)
+	if (nid == g_sbi.root_nid)
 		return FUSE_ROOT_ID;
 	return (nid + FUSE_ROOT_ID);
 }
@@ -60,7 +60,7 @@ static void erofsfuse_fill_stat(struct erofs_inode *vi, struct stat *stbuf)
 	stbuf->st_mode = vi->i_mode;
 	stbuf->st_nlink = vi->i_nlink;
 	stbuf->st_size = vi->i_size;
-	stbuf->st_blocks = roundup(vi->i_size, erofs_blksiz(&sbi)) >> 9;
+	stbuf->st_blocks = roundup(vi->i_size, erofs_blksiz(&g_sbi)) >> 9;
 	stbuf->st_uid = vi->i_uid;
 	stbuf->st_gid = vi->i_gid;
 	stbuf->st_ctime = vi->i_mtime;
@@ -94,7 +94,7 @@ static int erofsfuse_add_dentry(struct erofs_dir_context *ctx)
 #if FUSE_MAJOR_VERSION >= 3
 		int ret;
 		struct erofs_inode vi = {
-			.sbi = &sbi,
+			.sbi = &g_sbi,
 			.nid = ctx->de_nid
 		};
 
@@ -140,7 +140,7 @@ static int erofsfuse_lookup_dentry(struct erofs_dir_context *ctx)
 	if (!strncmp(lookup_ctx->target_name, ctx->dname, ctx->de_namelen)) {
 		int ret;
 		struct erofs_inode vi = {
-			.sbi = &sbi,
+			.sbi = &g_sbi,
 			.nid = (erofs_nid_t)ctx->de_nid,
 		};
 
@@ -236,7 +236,7 @@ static void erofsfuse_open(fuse_req_t req, fuse_ino_t ino,
 		return;
 	}
 
-	vi->sbi = &sbi;
+	vi->sbi = &g_sbi;
 	vi->nid = erofsfuse_to_nid(ino);
 	ret = erofs_read_inode_from_disk(vi);
 	if (ret < 0) {
@@ -262,7 +262,7 @@ static void erofsfuse_getattr(fuse_req_t req, fuse_ino_t ino,
 {
 	int ret;
 	struct stat stbuf = { 0 };
-	struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_to_nid(ino) };
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
 
 	ret = erofs_read_inode_from_disk(&vi);
 	if (ret < 0)
@@ -286,7 +286,7 @@ static void erofsfuse_opendir(fuse_req_t req, fuse_ino_t ino,
 		return;
 	}
 
-	vi->sbi = &sbi;
+	vi->sbi = &g_sbi;
 	vi->nid = erofsfuse_to_nid(ino);
 	ret = erofs_read_inode_from_disk(vi);
 	if (ret < 0) {
@@ -329,7 +329,7 @@ static void erofsfuse_lookup(fuse_req_t req, fuse_ino_t parent,
 		return;
 	}
 
-	vi->sbi = &sbi;
+	vi->sbi = &g_sbi;
 	vi->nid = erofsfuse_to_nid(parent);
 	ret = erofs_read_inode_from_disk(vi);
 	if (ret < 0) {
@@ -399,7 +399,7 @@ static void erofsfuse_readlink(fuse_req_t req, fuse_ino_t ino)
 {
 	int ret;
 	char *buf = NULL;
-	struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_to_nid(ino) };
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
 
 	ret = erofs_read_inode_from_disk(&vi);
 	if (ret < 0) {
@@ -436,7 +436,7 @@ static void erofsfuse_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
 {
 	int ret;
 	char *buf = NULL;
-	struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_to_nid(ino) };
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
 
 	erofs_dbg("getattr(%llu): name = %s, size = %zu", ino | 0ULL, name, size);
 
@@ -469,7 +469,7 @@ static void erofsfuse_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
 {
 	int ret;
 	char *buf = NULL;
-	struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_to_nid(ino) };
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
 
 	erofs_dbg("listxattr(%llu): size = %zu", ino | 0ULL, size);
 
@@ -573,10 +573,10 @@ static int optional_opt_func(void *data, const char *arg, int key,
 
 	switch (key) {
 	case 1:
-		ret = erofs_blob_open_ro(&sbi, arg + sizeof("--device=") - 1);
+		ret = erofs_blob_open_ro(&g_sbi, arg + sizeof("--device=") - 1);
 		if (ret)
 			return -1;
-		++sbi.extra_devices;
+		++g_sbi.extra_devices;
 		return 0;
 	case FUSE_OPT_KEY_NONOPT:
 		if (fusecfg.mountpoint)
@@ -675,14 +675,14 @@ int main(int argc, char *argv[])
 	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
 		cfg.c_dbg_lvl = EROFS_DBG;
 
-	sbi.bdev.offset = fusecfg.offset;
-	ret = erofs_dev_open(&sbi, fusecfg.disk, O_RDONLY);
+	g_sbi.bdev.offset = fusecfg.offset;
+	ret = erofs_dev_open(&g_sbi, fusecfg.disk, O_RDONLY);
 	if (ret) {
 		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
 		goto err_fuse_free_args;
 	}
 
-	ret = erofs_read_superblock(&sbi);
+	ret = erofs_read_superblock(&g_sbi);
 	if (ret) {
 		fprintf(stderr, "failed to read erofs super block\n");
 		goto err_dev_close;
@@ -744,10 +744,10 @@ int main(int argc, char *argv[])
 #endif
 
 err_super_put:
-	erofs_put_super(&sbi);
+	erofs_put_super(&g_sbi);
 err_dev_close:
-	erofs_blob_closeall(&sbi);
-	erofs_dev_close(&sbi);
+	erofs_blob_closeall(&g_sbi);
+	erofs_dev_close(&g_sbi);
 err_fuse_free_args:
 	free(opts.mountpoint);
 	fuse_opt_free_args(&args);
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index f30fe9f..234185f 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -56,14 +56,14 @@ struct erofs_buffer_block {
 static inline const int get_alignsize(int type, int *type_ret)
 {
 	if (type == DATA)
-		return erofs_blksiz(&sbi);
+		return erofs_blksiz(&g_sbi);
 
 	if (type == INODE) {
 		*type_ret = META;
 		return sizeof(struct erofs_inode_compact);
 	} else if (type == DIRA) {
 		*type_ret = META;
-		return erofs_blksiz(&sbi);
+		return erofs_blksiz(&g_sbi);
 	} else if (type == XATTR) {
 		*type_ret = META;
 		return sizeof(struct erofs_xattr_entry);
@@ -87,7 +87,7 @@ static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 	if (bb->blkaddr == NULL_ADDR)
 		return NULL_ADDR_UL;
 
-	return erofs_pos(&sbi, bb->blkaddr) +
+	return erofs_pos(&g_sbi, bb->blkaddr) +
 		(end ? list_next_entry(bh, list)->off : bh->off);
 }
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d5c5ce2..5f70570 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -48,7 +48,7 @@ typedef u32 erofs_blk_t;
 #define NULL_ADDR_UL	((unsigned long)-1)
 
 /* global sbi */
-extern struct erofs_sb_info sbi;
+extern struct erofs_sb_info g_sbi;
 
 #define erofs_blksiz(sbi)	(1u << (sbi)->blkszbits)
 #define erofs_blknr(sbi, addr)  ((addr) >> (sbi)->blkszbits)
diff --git a/lib/cache.c b/lib/cache.c
index 328ca4a..e3dc9de 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -56,7 +56,7 @@ static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
 		return;
 
 	bkt = mapped_buckets[bb->type] +
-		(bb->buffers.off & (erofs_blksiz(&sbi) - 1));
+		(bb->buffers.off & (erofs_blksiz(&g_sbi) - 1));
 	list_del(&bb->mapped_list);
 	list_add_tail(&bb->mapped_list, bkt);
 }
@@ -69,7 +69,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   unsigned int extrasize,
 			   bool dryrun)
 {
-	const unsigned int blksiz = erofs_blksiz(&sbi);
+	const unsigned int blksiz = erofs_blksiz(&g_sbi);
 	const unsigned int blkmask = blksiz - 1;
 	erofs_off_t boff = bb->buffers.off;
 	const erofs_off_t alignedoffset = roundup(boff, alignsize);
@@ -86,7 +86,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		blkaddr = bb->blkaddr;
 		if (blkaddr != NULL_ADDR) {
 			tailupdate = (tail_blkaddr == blkaddr +
-				      BLK_ROUND_UP(&sbi, boff));
+				      BLK_ROUND_UP(&g_sbi, boff));
 			if (oob && !tailupdate)
 				return -EINVAL;
 		}
@@ -102,7 +102,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		bb->buffers.off = boff;
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
-			tail_blkaddr = blkaddr + BLK_ROUND_UP(&sbi, boff);
+			tail_blkaddr = blkaddr + BLK_ROUND_UP(&g_sbi, boff);
 		erofs_bupdate_mapped(bb);
 	}
 	return ((alignedoffset + incr - 1) & blkmask) + 1;
@@ -125,7 +125,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 				  unsigned int alignsize,
 				  struct erofs_buffer_block **bbp)
 {
-	const unsigned int blksiz = erofs_blksiz(&sbi);
+	const unsigned int blksiz = erofs_blksiz(&g_sbi);
 	struct erofs_buffer_block *cur, *bb;
 	unsigned int used0, used_before, usedmax, used;
 	int ret;
@@ -322,7 +322,7 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 		erofs_bupdate_mapped(bb);
 	}
 
-	blkaddr = bb->blkaddr + BLK_ROUND_UP(&sbi, bb->buffers.off);
+	blkaddr = bb->blkaddr + BLK_ROUND_UP(&g_sbi, bb->buffers.off);
 	if (blkaddr > tail_blkaddr)
 		tail_blkaddr = blkaddr;
 
@@ -360,7 +360,7 @@ static void erofs_bfree(struct erofs_buffer_block *bb)
 
 int erofs_bflush(struct erofs_buffer_block *bb)
 {
-	const unsigned int blksiz = erofs_blksiz(&sbi);
+	const unsigned int blksiz = erofs_blksiz(&g_sbi);
 	struct erofs_buffer_block *p, *n;
 	erofs_blk_t blkaddr;
 
@@ -392,11 +392,11 @@ int erofs_bflush(struct erofs_buffer_block *bb)
 
 		padding = blksiz - (p->buffers.off & (blksiz - 1));
 		if (padding != blksiz)
-			erofs_dev_fillzero(&sbi, erofs_pos(&sbi, blkaddr) - padding,
+			erofs_dev_fillzero(&g_sbi, erofs_pos(&g_sbi, blkaddr) - padding,
 					   padding, true);
 
 		if (p->type != DATA)
-			erofs_metablkcnt += BLK_ROUND_UP(&sbi, p->buffers.off);
+			erofs_metablkcnt += BLK_ROUND_UP(&g_sbi, p->buffers.off);
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 		erofs_bfree(p);
 	}
@@ -411,7 +411,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 
 	/* tail_blkaddr could be rolled back after revoking all bhs */
 	if (tryrevoke && blkaddr != NULL_ADDR &&
-	    tail_blkaddr == blkaddr + BLK_ROUND_UP(&sbi, bb->buffers.off))
+	    tail_blkaddr == blkaddr + BLK_ROUND_UP(&g_sbi, bb->buffers.off))
 		rollback = true;
 
 	bh->op = &erofs_drop_directly_bhops;
@@ -421,7 +421,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 		return;
 
 	if (!rollback && bb->type != DATA)
-		erofs_metablkcnt += BLK_ROUND_UP(&sbi, bb->buffers.off);
+		erofs_metablkcnt += BLK_ROUND_UP(&g_sbi, bb->buffers.off);
 	erofs_bfree(bb);
 	if (rollback)
 		tail_blkaddr = blkaddr;
diff --git a/lib/config.c b/lib/config.c
index 44f0606..848bc59 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -19,7 +19,7 @@
 #endif
 
 struct erofs_configure cfg;
-struct erofs_sb_info sbi;
+struct erofs_sb_info g_sbi;
 bool erofs_stdout_tty;
 
 void erofs_init_configure(void)
diff --git a/lib/diskbuf.c b/lib/diskbuf.c
index e5f1f0c..3789654 100644
--- a/lib/diskbuf.c
+++ b/lib/diskbuf.c
@@ -104,10 +104,10 @@ int erofs_diskbuf_init(unsigned int nstrms)
 		struct stat st;
 
 		/* try to use the devfd for regfiles on stream 0 */
-		if (strm == dbufstrm && !sbi.bdev.ops) {
+		if (strm == dbufstrm && !g_sbi.bdev.ops) {
 			strm->devpos = 1ULL << 40;
-			if (!ftruncate(sbi.bdev.fd, strm->devpos << 1)) {
-				strm->fd = dup(sbi.bdev.fd);
+			if (!ftruncate(g_sbi.bdev.fd, strm->devpos << 1)) {
+				strm->fd = dup(g_sbi.bdev.fd);
 				if (lseek(strm->fd, strm->devpos,
 					  SEEK_SET) != strm->devpos)
 					return -EIO;
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 0b1a6c6..9e8bf8f 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -360,7 +360,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 			inode->i_ino[1] = inode->nid;
 			inode->i_nlink = 1;
 
-			ret = erofs_rebuild_update_inode(&sbi, inode,
+			ret = erofs_rebuild_update_inode(&g_sbi, inode,
 							 rctx->datamode);
 			if (ret) {
 				erofs_iput(inode);
@@ -386,7 +386,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 	}
 
 	/* reset sbi, nid after subdirs are all loaded for the final dump */
-	inode->sbi = &sbi;
+	inode->sbi = &g_sbi;
 	inode->nid = 0;
 out:
 	free(path);
diff --git a/mkfs/main.c b/mkfs/main.c
index bfd6d60..37f250b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -357,7 +357,7 @@ static int parse_extended_opts(const char *opts)
 		} else if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			erofs_sb_clear_sb_chksum(&sbi);
+			erofs_sb_clear_sb_chksum(&g_sbi);
 		} else if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -560,7 +560,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid block size %s", optarg);
 				return -EINVAL;
 			}
-			sbi.blkszbits = ilog2(i);
+			g_sbi.blkszbits = ilog2(i);
 			break;
 
 		case 'd':
@@ -589,12 +589,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 		case 'L':
 			if (optarg == NULL ||
-			    strlen(optarg) > sizeof(sbi.volume_name)) {
+			    strlen(optarg) > sizeof(g_sbi.volume_name)) {
 				erofs_err("invalid volume label");
 				return -EINVAL;
 			}
-			strncpy(sbi.volume_name, optarg,
-				sizeof(sbi.volume_name));
+			strncpy(g_sbi.volume_name, optarg,
+				sizeof(g_sbi.volume_name));
 			break;
 
 		case 'T':
@@ -606,7 +606,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
 		case 'U':
-			if (erofs_uuid_parse(optarg, sbi.uuid)) {
+			if (erofs_uuid_parse(optarg, g_sbi.uuid)) {
 				erofs_err("invalid UUID %s", optarg);
 				return -EINVAL;
 			}
@@ -709,7 +709,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  optarg);
 				return -EINVAL;
 			}
-			erofs_sb_set_chunked_file(&sbi);
+			erofs_sb_set_chunked_file(&g_sbi);
 			break;
 		case 12:
 			quiet = true;
@@ -762,7 +762,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				cfg.c_ovlfs_strip = false;
 			break;
 		case 517:
-			sbi.bdev.offset = strtoull(optarg, &endptr, 0);
+			g_sbi.bdev.offset = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid disk offset %s", optarg);
 				return -EINVAL;
@@ -829,7 +829,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 	}
 
-	if (cfg.c_blobdev_path && cfg.c_chunkbits < sbi.blkszbits) {
+	if (cfg.c_blobdev_path && cfg.c_chunkbits < g_sbi.blkszbits) {
 		erofs_err("--blobdev must be used together with --chunksize");
 		return -EINVAL;
 	}
@@ -942,14 +942,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_showprogress = false;
 	}
 
-	if (cfg.c_compr_opts[0].alg && erofs_blksiz(&sbi) != getpagesize())
+	if (cfg.c_compr_opts[0].alg && erofs_blksiz(&g_sbi) != getpagesize())
 		erofs_warn("Please note that subpage blocksize with compression isn't yet supported in kernel. "
 			   "This compressed image will only work with bs = ps = %u bytes",
-			   erofs_blksiz(&sbi));
+			   erofs_blksiz(&g_sbi));
 
 	if (pclustersize_max) {
-		if (pclustersize_max < erofs_blksiz(&sbi) ||
-		    pclustersize_max % erofs_blksiz(&sbi)) {
+		if (pclustersize_max < erofs_blksiz(&g_sbi) ||
+		    pclustersize_max % erofs_blksiz(&g_sbi)) {
 			erofs_err("invalid physical clustersize %u",
 				  pclustersize_max);
 			return -EINVAL;
@@ -957,15 +957,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_mkfs_pclustersize_max = pclustersize_max;
 		cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
 	}
-	if (cfg.c_chunkbits && cfg.c_chunkbits < sbi.blkszbits) {
+	if (cfg.c_chunkbits && cfg.c_chunkbits < g_sbi.blkszbits) {
 		erofs_err("chunksize %u must be larger than block size",
 			  1u << cfg.c_chunkbits);
 		return -EINVAL;
 	}
 
 	if (pclustersize_packed) {
-		if (pclustersize_packed < erofs_blksiz(&sbi) ||
-		    pclustersize_packed % erofs_blksiz(&sbi)) {
+		if (pclustersize_packed < erofs_blksiz(&g_sbi) ||
+		    pclustersize_packed % erofs_blksiz(&g_sbi)) {
 			erofs_err("invalid pcluster size for the packed file %u",
 				  pclustersize_packed);
 			return -EINVAL;
@@ -985,11 +985,11 @@ static void erofs_mkfs_default_options(void)
 	cfg.c_mt_workers = erofs_get_available_processors();
 	cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
 #endif
-	sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
-	cfg.c_mkfs_pclustersize_max = erofs_blksiz(&sbi);
+	g_sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
+	cfg.c_mkfs_pclustersize_max = erofs_blksiz(&g_sbi);
 	cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
-	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
-	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
+	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
+	g_sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
 }
 
@@ -1071,7 +1071,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		return -EOPNOTSUPP;
 	}
 
-	ret = erofs_mkfs_init_devices(&sbi, rebuild_src_count);
+	ret = erofs_mkfs_init_devices(&g_sbi, rebuild_src_count);
 	if (ret)
 		return ret;
 
@@ -1086,12 +1086,12 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 		}
 		DBG_BUGON(src->dev < 1);
 		idx = src->dev - 1;
-		sbi.devs[idx].blocks = nblocks;
+		g_sbi.devs[idx].blocks = nblocks;
 		if (tag && *tag)
-			memcpy(sbi.devs[idx].tag, tag, sizeof(sbi.devs[0].tag));
+			memcpy(g_sbi.devs[idx].tag, tag, sizeof(g_sbi.devs[0].tag));
 		else
 			/* convert UUID of the source image to a hex string */
-			sprintf((char *)sbi.devs[idx].tag,
+			sprintf((char *)g_sbi.devs[idx].tag,
 				"%04x%04x%04x%04x%04x%04x%04x%04x",
 				(src->uuid[0] << 8) | src->uuid[1],
 				(src->uuid[2] << 8) | src->uuid[3],
@@ -1113,16 +1113,16 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 	if (!(cfg.c_dbg_lvl > EROFS_ERR && cfg.c_showprogress))
 		return;
 
-	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
+	erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
 
 	fprintf(stdout, "------\nFilesystem UUID: %s\n"
 		"Filesystem total blocks: %u (of %u-byte blocks)\n"
 		"Filesystem total inodes: %llu\n"
 		"Filesystem %s metadata blocks: %u\n"
 		"Filesystem %s deduplicated bytes (of source files): %llu\n",
-		uuid_str, nblocks, 1U << sbi.blkszbits, sbi.inos | 0ULL,
+		uuid_str, nblocks, 1U << g_sbi.blkszbits, g_sbi.inos | 0ULL,
 		incr, erofs_total_metablocks(),
-		incr, sbi.saved_by_deduplication | 0ULL);
+		incr, g_sbi.saved_by_deduplication | 0ULL);
 }
 
 int main(int argc, char **argv)
@@ -1154,14 +1154,14 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_unix_timestamp != -1) {
-		sbi.build_time      = cfg.c_unix_timestamp;
-		sbi.build_time_nsec = 0;
+		g_sbi.build_time      = cfg.c_unix_timestamp;
+		g_sbi.build_time_nsec = 0;
 	} else if (!gettimeofday(&t, NULL)) {
-		sbi.build_time      = t.tv_sec;
-		sbi.build_time_nsec = t.tv_usec;
+		g_sbi.build_time      = t.tv_sec;
+		g_sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDWR |
+	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
@@ -1224,7 +1224,7 @@ int main(int argc, char **argv)
 			 * If mapfile is unspecified for tarfs index mode,
 			 * 512-byte block size is enforced here.
 			 */
-			sbi.blkszbits = 9;
+			g_sbi.blkszbits = 9;
 		}
 	}
 
@@ -1241,7 +1241,7 @@ int main(int argc, char **argv)
 			erofs_err("failed to read superblock of %s", src->devname);
 			goto exit;
 		}
-		sbi.blkszbits = src->blkszbits;
+		g_sbi.blkszbits = src->blkszbits;
 	}
 
 	if (!incremental_mode) {
@@ -1251,7 +1251,7 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 		/* generate new UUIDs for clean builds */
-		erofs_uuid_generate(sbi.uuid);
+		erofs_uuid_generate(g_sbi.uuid);
 	} else {
 		union {
 			struct stat st;
@@ -1259,17 +1259,17 @@ int main(int argc, char **argv)
 		} u;
 
 		erofs_warn("EXPERIMENTAL incremental build in use. Use at your own risk!");
-		err = erofs_read_superblock(&sbi);
+		err = erofs_read_superblock(&g_sbi);
 		if (err) {
-			erofs_err("failed to read superblock of %s", sbi.devname);
+			erofs_err("failed to read superblock of %s", g_sbi.devname);
 			goto exit;
 		}
 
-		err = erofs_io_fstat(&sbi.bdev, &u.st);
+		err = erofs_io_fstat(&g_sbi.bdev, &u.st);
 		if (!err && S_ISREG(u.st.st_mode))
-			u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(&sbi));
+			u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(&g_sbi));
 		else
-			u.startblk = sbi.primarydevice_blocks;
+			u.startblk = g_sbi.primarydevice_blocks;
 		erofs_buffer_init(u.startblk);
 		sb_bh = NULL;
 	}
@@ -1283,14 +1283,14 @@ int main(int argc, char **argv)
 		}
 	}
 
-	err = erofs_load_compress_hints(&sbi);
+	err = erofs_load_compress_hints(&g_sbi);
 	if (err) {
 		erofs_err("failed to load compress hints %s",
 			  cfg.c_compress_hints_file);
 		goto exit;
 	}
 
-	err = z_erofs_compress_init(&sbi, sb_bh);
+	err = z_erofs_compress_init(&g_sbi, sb_bh);
 	if (err) {
 		erofs_err("failed to initialize compressor: %s",
 			  erofs_strerror(err));
@@ -1300,9 +1300,9 @@ int main(int argc, char **argv)
 	if (cfg.c_dedupe) {
 		if (!cfg.c_compr_opts[0].alg) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
-			cfg.c_chunkbits = sbi.blkszbits;
+			cfg.c_chunkbits = g_sbi.blkszbits;
 		} else {
-			err = z_erofs_dedupe_init(erofs_blksiz(&sbi));
+			err = z_erofs_dedupe_init(erofs_blksiz(&g_sbi));
 			if (err) {
 				erofs_err("failed to initialize deduplication: %s",
 					  erofs_strerror(err));
@@ -1319,7 +1319,7 @@ int main(int argc, char **argv)
 
 	if (((erofstar.index_mode && !erofstar.headeronly_mode) &&
 	    !erofstar.mapfile) || cfg.c_blobdev_path) {
-		err = erofs_mkfs_init_devices(&sbi, 1);
+		err = erofs_mkfs_init_devices(&g_sbi, 1);
 		if (err) {
 			erofs_err("failed to generate device table: %s",
 				  erofs_strerror(err));
@@ -1330,7 +1330,7 @@ int main(int argc, char **argv)
 	erofs_inode_manager_init();
 
 	if (tar_mode) {
-		root = erofs_rebuild_make_root(&sbi);
+		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
@@ -1345,7 +1345,7 @@ int main(int argc, char **argv)
 		if (err < 0)
 			goto exit;
 	} else if (rebuild_mode) {
-		root = erofs_rebuild_make_root(&sbi);
+		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
@@ -1358,7 +1358,7 @@ int main(int argc, char **argv)
 		if (err)
 			goto exit;
 	} else {
-		err = erofs_build_shared_xattrs_from_path(&sbi, cfg.c_src_path);
+		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg.c_src_path);
 		if (err) {
 			erofs_err("failed to build shared xattrs: %s",
 				  erofs_strerror(err));
@@ -1366,27 +1366,27 @@ int main(int argc, char **argv)
 		}
 
 		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_write_name_prefixes(&sbi, packedfile);
+			erofs_xattr_write_name_prefixes(&g_sbi, packedfile);
 
-		root = erofs_mkfs_build_tree_from_path(&sbi, cfg.c_src_path);
+		root = erofs_mkfs_build_tree_from_path(&g_sbi, cfg.c_src_path);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
 		}
 	}
 
-	if (erofstar.index_mode && sbi.extra_devices && !erofstar.mapfile)
-		sbi.devs[0].blocks = BLK_ROUND_UP(&sbi, erofstar.offset);
+	if (erofstar.index_mode && g_sbi.extra_devices && !erofstar.mapfile)
+		g_sbi.devs[0].blocks = BLK_ROUND_UP(&g_sbi, erofstar.offset);
 
-	if (erofs_sb_has_fragments(&sbi)) {
+	if (erofs_sb_has_fragments(&g_sbi)) {
 		erofs_update_progressinfo("Handling packed data ...");
-		err = erofs_flush_packed_inode(&sbi);
+		err = erofs_flush_packed_inode(&g_sbi);
 		if (err)
 			goto exit;
 	}
 
-	if (erofstar.index_mode || cfg.c_chunkbits || sbi.extra_devices) {
-		err = erofs_mkfs_dump_blobs(&sbi);
+	if (erofstar.index_mode || cfg.c_chunkbits || g_sbi.extra_devices) {
+		err = erofs_mkfs_dump_blobs(&g_sbi);
 		if (err)
 			goto exit;
 	}
@@ -1400,7 +1400,7 @@ int main(int argc, char **argv)
 	erofs_iput(root);
 	root = NULL;
 
-	err = erofs_writesb(&sbi, sb_bh, &nblocks);
+	err = erofs_writesb(&g_sbi, sb_bh, &nblocks);
 	if (err)
 		goto exit;
 
@@ -1409,10 +1409,10 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
-	err = erofs_dev_resize(&sbi, nblocks);
+	err = erofs_dev_resize(&g_sbi, nblocks);
 
-	if (!err && erofs_sb_has_sb_chksum(&sbi)) {
-		err = erofs_enable_sb_chksum(&sbi, &crc);
+	if (!err && erofs_sb_has_sb_chksum(&g_sbi)) {
+		err = erofs_enable_sb_chksum(&g_sbi, &crc);
 		if (!err)
 			erofs_info("superblock checksum 0x%08x written", crc);
 	}
@@ -1424,7 +1424,7 @@ exit:
 	blklst = erofs_blocklist_close();
 	if (blklst)
 		fclose(blklst);
-	erofs_dev_close(&sbi);
+	erofs_dev_close(&g_sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
-- 
2.39.3

