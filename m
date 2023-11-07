Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA717E361F
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 08:56:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SPgX10rdRz3c3g
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 18:56:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SPgWv2fJNz2yVR
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Nov 2023 18:56:08 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvtbHFA_1699343755;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvtbHFA_1699343755)
          by smtp.aliyun-inc.com;
          Tue, 07 Nov 2023 15:56:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: mkfs,fsck,dump: support `--offset` option
Date: Tue,  7 Nov 2023 15:55:55 +0800
Message-Id: <20231107075555.2554444-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Pavel Otchertsov <pavel.otchertsov@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add `--offset` option to allows users to specify an offset in the file
where the filesystem will begin.

Suggested-by: Pavel Otchertsov <pavel.otchertsov@gmail.com>
Closes: https://lore.kernel.org/r/CAAxnTOGTD2NkKnBphZ+vEr7NVnWvT0u02E+c8pN8ZVFcXp5uhg@mail.gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
I plan to apply this version.

 dump/main.c              | 10 ++++++++++
 fsck/main.c              | 10 ++++++++++
 fuse/main.c              |  5 ++---
 include/erofs/config.h   |  3 ---
 include/erofs/internal.h |  2 ++
 lib/blobchunk.c          |  1 +
 lib/io.c                 | 12 +++++++-----
 mkfs/main.c              |  9 +++++++++
 8 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 293093d..a89fc6b 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -80,6 +80,7 @@ static struct option long_options[] = {
 	{"device", required_argument, NULL, 3},
 	{"path", required_argument, NULL, 4},
 	{"ls", no_argument, NULL, 5},
+	{"offset", required_argument, NULL, 6},
 	{0, 0, 0, 0},
 };
 
@@ -124,6 +125,7 @@ static void usage(int argc, char **argv)
 		" --device=X      specify an extra device to be used together\n"
 		" --ls            show directory contents (INODE required)\n"
 		" --nid=#         show the target inode info of nid #\n"
+		" --offset=#      skip # bytes at the beginning of IMAGE\n"
 		" --path=X        show the target inode info of path X\n",
 		argv[0]);
 }
@@ -136,6 +138,7 @@ static void erofsdump_print_version(void)
 static int erofsdump_parse_options_cfg(int argc, char **argv)
 {
 	int opt, err;
+	char *endptr;
 
 	while ((opt = getopt_long(argc, argv, "SVesh",
 				  long_options, NULL)) != -1) {
@@ -177,6 +180,13 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		case 5:
 			dumpcfg.show_subdirectories = true;
 			break;
+		case 6:
+			sbi.diskoffset = strtoull(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid disk offset %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/fsck/main.c b/fsck/main.c
index 26cd131..e5c37be 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -48,6 +48,7 @@ static struct option long_options[] = {
 	{"no-preserve", no_argument, 0, 9},
 	{"no-preserve-owner", no_argument, 0, 10},
 	{"no-preserve-perms", no_argument, 0, 11},
+	{"offset", required_argument, 0, 12},
 	{0, 0, 0, 0},
 };
 
@@ -97,6 +98,7 @@ static void usage(int argc, char **argv)
 		" --device=X             specify an extra device to be used together\n"
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
+		" --offset=#             skip # bytes at the beginning of IMAGE\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
 		"\n"
@@ -123,6 +125,7 @@ static void erofsfsck_print_version(void)
 
 static int erofsfsck_parse_options_cfg(int argc, char **argv)
 {
+	char *endptr;
 	int opt, ret;
 	bool has_opt_preserve = false;
 
@@ -216,6 +219,13 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 			fsckcfg.preserve_perms = false;
 			has_opt_preserve = true;
 			break;
+		case 12:
+			sbi.diskoffset = strtoull(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid disk offset %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/fuse/main.c b/fuse/main.c
index 5b2c64d..f07165c 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -547,7 +547,7 @@ static void usage(void)
 #endif
 	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
 	      "Options:\n"
-	      "    --offset=#             skip # bytes when reading IMAGE\n"
+	      "    --offset=#             skip # bytes at the beginning of IMAGE\n"
 	      "    --dbglevel=#           set output message level to # (maximum 9)\n"
 	      "    --device=#             specify an extra device to be used together\n"
 #if FUSE_MAJOR_VERSION < 3
@@ -676,8 +676,7 @@ int main(int argc, char *argv[])
 	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
 		cfg.c_dbg_lvl = EROFS_DBG;
 
-	cfg.c_offset = fusecfg.offset;
-
+	sbi.diskoffset = fusecfg.offset;
 	ret = dev_open_ro(&sbi, fusecfg.disk);
 	if (ret) {
 		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index e342722..89fe522 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -83,9 +83,6 @@ struct erofs_configure {
 	char *fs_config_file;
 	char *block_list_file;
 #endif
-
-	/* offset when reading multi partition images */
-	u64 c_offset;
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 4d794ae..78b9f32 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -110,6 +110,8 @@ struct erofs_sb_info {
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 
 	int devfd, devblksz;
+	/* offset when reading multi-part images */
+	u64 diskoffset;
 	u64 devsz;
 	dev_t dev;
 	unsigned int nblobs;
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index e4d0bad..6d2501e 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -448,6 +448,7 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 
 	pos_out = erofs_btell(bh, false);
 	remapped_base = erofs_blknr(sbi, pos_out);
+	pos_out += sbi->diskoffset;
 	if (blobfile) {
 		pos_in = 0;
 		ret = erofs_copy_file_range(fileno(blobfile), &pos_in,
diff --git a/lib/io.c b/lib/io.c
index c92f16c..bfae73a 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -194,6 +194,7 @@ int dev_write(struct erofs_sb_info *sbi, const void *buf, u64 offset, size_t len
 		return -EINVAL;
 	}
 
+	offset += sbi->diskoffset;
 	if (offset >= sbi->devsz || len > sbi->devsz ||
 	    offset > sbi->devsz - len) {
 		erofs_err("Write posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
@@ -230,7 +231,7 @@ int dev_fillzero(struct erofs_sb_info *sbi, u64 offset, size_t len, bool padding
 
 #if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
 	if (!padding && fallocate(sbi->devfd, FALLOC_FL_PUNCH_HOLE |
-				  FALLOC_FL_KEEP_SIZE, offset, len) >= 0)
+	    FALLOC_FL_KEEP_SIZE, offset + sbi->diskoffset, len) >= 0)
 		return 0;
 #endif
 	while (len > erofs_blksiz(sbi)) {
@@ -255,7 +256,7 @@ int dev_fsync(struct erofs_sb_info *sbi)
 	return 0;
 }
 
-int dev_resize(struct erofs_sb_info *sbi, unsigned int blocks)
+int dev_resize(struct erofs_sb_info *sbi, erofs_blk_t blocks)
 {
 	int ret;
 	struct stat st;
@@ -271,6 +272,7 @@ int dev_resize(struct erofs_sb_info *sbi, unsigned int blocks)
 	}
 
 	length = (u64)blocks * erofs_blksiz(sbi);
+	length += sbi->diskoffset;
 	if (st.st_size == length)
 		return 0;
 	if (st.st_size > length)
@@ -281,7 +283,8 @@ int dev_resize(struct erofs_sb_info *sbi, unsigned int blocks)
 	if (fallocate(sbi->devfd, 0, st.st_size, length) >= 0)
 		return 0;
 #endif
-	return dev_fillzero(sbi, st.st_size, length, true);
+	return dev_fillzero(sbi, st.st_size - sbi->diskoffset,
+			    length, true);
 }
 
 int dev_read(struct erofs_sb_info *sbi, int device_id,
@@ -292,8 +295,6 @@ int dev_read(struct erofs_sb_info *sbi, int device_id,
 	if (cfg.c_dry_run)
 		return 0;
 
-	offset += cfg.c_offset;
-
 	if (!buf) {
 		erofs_err("buf is NULL");
 		return -EINVAL;
@@ -301,6 +302,7 @@ int dev_read(struct erofs_sb_info *sbi, int device_id,
 
 	if (!device_id) {
 		fd = sbi->devfd;
+		offset += sbi->diskoffset;
 	} else {
 		if (device_id > sbi->nblobs) {
 			erofs_err("invalid device id %d", device_id);
diff --git a/mkfs/main.c b/mkfs/main.c
index f024026..0517849 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -71,6 +71,7 @@ static struct option long_options[] = {
 #ifdef HAVE_ZLIB
 	{"gzip", no_argument, NULL, 517},
 #endif
+	{"offset", required_argument, NULL, 518},
 	{0, 0, 0, 0},
 };
 
@@ -151,6 +152,7 @@ static void usage(int argc, char **argv)
 		" --ignore-mtime        use build time instead of strict per-file modification time\n"
 		" --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 		" --preserve-mtime      keep per-file modification time strictly\n"
+		" --offset=#            skip # bytes at the beginning of IMAGE.\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
 		" --tar=[fi]            generate an image from tarball(s)\n"
 		" --ovlfs-strip=<0,1>   strip overlayfs metadata in the target image (e.g. whiteouts)\n"
@@ -571,6 +573,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 517:
 			gzip_supported = true;
 			break;
+		case 518:
+			sbi.diskoffset = strtoull(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid disk offset %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.39.3

