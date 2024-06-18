Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58F90C4E8
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 10:25:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b63Roij9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3KZJ4RdKz3bxZ
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 18:25:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b63Roij9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3KYK3H4qz3bjK
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 18:24:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718699074; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OOQ811mlDDDjoyeo/LteAR9wjzko+VdbQSf76qDUNTo=;
	b=b63Roij9IFNnOKJohqw7uivX7KnDbTPL49VckEUunfVNT0PE6NBi1eFZ97PLzqVQsVsDp64JDgdSay7TqdEIERvUffAI09yWUmkYCCU0zrwOgwekQPZo53yyHVxzsfDg/b5BJTRKy8shbq9xjy9SGZdc3S7PkvtZuHBzWdVWJIo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jcNBd_1718699073;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jcNBd_1718699073)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:24:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 08/10] erofs-utils: enable incremental builds
Date: Tue, 18 Jun 2024 16:24:13 +0800
Message-Id: <20240618082414.47876-8-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
References: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
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

`--incremental=<data|rvsp>` are now supported for tarerofs but
only `--incremental=rvsp` works for the rebuild mode.

For example:
$ mkfs.erofs --tar=f --gzip --aufs --clean=data foo.erofs f0.tgz
$ mkfs.erofs --tar=f --gzip --aufs --incremental=data foo.erofs f1.tgz
...
$ mkfs.erofs --tar=f --gzip --aufs --incremental=data foo.erofs fn-1.tgz

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/io.h  |   2 +
 include/erofs/tar.h |   3 +-
 lib/io.c            |  13 +++++
 lib/tar.c           |  15 ++++-
 mkfs/main.c         | 138 ++++++++++++++++++++++++++++++++++----------
 5 files changed, 137 insertions(+), 34 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index f24a563..d3a487f 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -32,6 +32,7 @@ struct erofs_vfops {
 	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
 	ssize_t (*read)(struct erofs_vfile *vf, void *buf, size_t len);
 	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
+	int (*fstat)(struct erofs_vfile *vf, struct stat *buf);
 };
 
 struct erofs_vfile {
@@ -40,6 +41,7 @@ struct erofs_vfile {
 	int fd;
 };
 
+int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf);
 ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
 int erofs_io_fsync(struct erofs_vfile *vf);
 ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index e1de0df..403f3a8 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -57,9 +57,10 @@ struct erofs_tarfile {
 	struct erofs_iostream ios;
 	char *mapfile, *dumpfile;
 
+	u32 dev;
 	int fd;
 	u64 offset;
-	bool index_mode, headeronly_mode, aufs;
+	bool index_mode, headeronly_mode, rvsp_mode, aufs;
 };
 
 void erofs_iostream_close(struct erofs_iostream *ios);
diff --git a/lib/io.c b/lib/io.c
index c523f00..83c145c 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -26,6 +26,19 @@
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
+int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf)
+{
+	if (unlikely(cfg.c_dry_run)) {
+		buf->st_size = 0;
+		buf->st_mode = S_IFREG | 0777;
+		return 0;
+	}
+
+	if (vf->ops)
+		return vf->ops->fstat(vf, buf);
+	return fstat(vf->fd, buf);
+}
+
 ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 			u64 pos, size_t len)
 {
diff --git a/lib/tar.c b/lib/tar.c
index 53a1188..8d2caa5 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -942,6 +942,7 @@ new_inode:
 			ret = PTR_ERR(inode);
 			goto out;
 		}
+		inode->dev = tar->dev;
 		inode->i_parent = d->inode;
 		d->inode = inode;
 		d->type = erofs_mode_to_ftype(st.st_mode);
@@ -981,13 +982,21 @@ new_inode:
 			inode->i_link = malloc(inode->i_size + 1);
 			memcpy(inode->i_link, eh.link, inode->i_size + 1);
 		} else if (inode->i_size) {
-			if (tar->headeronly_mode)
+			if (tar->headeronly_mode) {
 				ret = erofs_write_zero_inode(inode);
-			else if (tar->index_mode)
+			} else if (tar->rvsp_mode) {
+				inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+				inode->i_ino[1] = data_offset;
+				if (erofs_iostream_lskip(&tar->ios, inode->i_size))
+					ret = -EIO;
+				else
+					ret = 0;
+			} else if (tar->index_mode) {
 				ret = tarerofs_write_file_index(inode, tar,
 								data_offset);
-			else
+			} else {
 				ret = tarerofs_write_file_data(inode, tar);
+			}
 			if (ret)
 				goto out;
 		}
diff --git a/mkfs/main.c b/mkfs/main.c
index 425fe00..6e9120f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -79,6 +79,8 @@ static struct option long_options[] = {
 	{"workers", required_argument, NULL, 520},
 #endif
 	{"zfeature-bits", required_argument, NULL, 521},
+	{"clean", optional_argument, NULL, 522},
+	{"incremental", optional_argument, NULL, 523},
 	{0, 0, 0, 0},
 };
 
@@ -152,6 +154,10 @@ static void usage(int argc, char **argv)
 		" --all-root            make all files owned by root\n"
 		" --blobdev=X           specify an extra device X to store chunked data\n"
 		" --chunksize=#         generate chunk-based files with #-byte chunks\n"
+		" --clean=X             run full clean build (default) or:\n"
+		" --incremental=X       run incremental build\n"
+		"                       (X = data|rvsp; data=complete data, rvsp=space is allocated\n"
+		"                                       and filled with zeroes)\n"
 		" --compress-hints=X    specify a file to configure per-file compression strategy\n"
 		" --exclude-path=X      avoid including file X (X = exact literal path)\n"
 		" --exclude-regex=X     avoid including files that match X (X = regular expression)\n"
@@ -214,7 +220,14 @@ static unsigned int pclustersize_packed, pclustersize_max;
 static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
 };
-static bool tar_mode, rebuild_mode;
+static bool tar_mode, rebuild_mode, incremental_mode;
+
+enum {
+	EROFS_MKFS_DATA_IMPORT_DEFAULT,
+	EROFS_MKFS_DATA_IMPORT_FULLDATA,
+	EROFS_MKFS_DATA_IMPORT_RVSP,
+	EROFS_MKFS_DATA_IMPORT_SPARSE,
+} dataimport_mode;
 
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
@@ -775,6 +788,22 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (err)
 				return err;
 			break;
+		case 522:
+		case 523:
+			if (!optarg || !strcmp(optarg, "data")) {
+				dataimport_mode = EROFS_MKFS_DATA_IMPORT_FULLDATA;
+			} else if (!strcmp(optarg, "rvsp")) {
+				dataimport_mode = EROFS_MKFS_DATA_IMPORT_RVSP;
+			} else {
+				dataimport_mode = strtol(optarg, &endptr, 0);
+				if (errno || *endptr != '\0') {
+					erofs_err("invalid --%s=%s",
+						  opt == 523 ? "incremental" : "clean", optarg);
+					return -EINVAL;
+				}
+			}
+			incremental_mode = (opt == 523);
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -998,9 +1027,6 @@ static void erofs_mkfs_default_options(void)
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
-
-	/* generate a default uuid first */
-	erofs_uuid_generate(sbi.uuid);
 }
 
 /* https://reproducible-builds.org/specs/source-date-epoch/ for more details */
@@ -1052,16 +1078,30 @@ static struct erofs_inode *erofs_mkfs_alloc_root(struct erofs_sb_info *sbi)
 	return root;
 }
 
-static int erofs_rebuild_load_trees(struct erofs_inode *root)
+static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 {
 	struct erofs_sb_info *src;
 	unsigned int extra_devices = 0;
 	erofs_blk_t nblocks;
 	int ret, idx;
+	enum erofs_rebuild_datamode datamode;
+
+	switch (dataimport_mode) {
+	case EROFS_MKFS_DATA_IMPORT_DEFAULT:
+		datamode = EROFS_REBUILD_DATA_BLOB_INDEX;
+		break;
+	case EROFS_MKFS_DATA_IMPORT_FULLDATA:
+		datamode = EROFS_REBUILD_DATA_FULL;
+		break;
+	case EROFS_MKFS_DATA_IMPORT_RVSP:
+		datamode = EROFS_REBUILD_DATA_RESVSP;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	list_for_each_entry(src, &rebuild_src_list, list) {
-		ret = erofs_rebuild_load_tree(root, src,
-					      EROFS_REBUILD_DATA_BLOB_INDEX);
+		ret = erofs_rebuild_load_tree(root, src, datamode);
 		if (ret) {
 			erofs_err("failed to load %s", src->devname);
 			return ret;
@@ -1074,7 +1114,10 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 		extra_devices += src->extra_devices;
 	}
 
-	if (extra_devices && extra_devices != rebuild_src_count) {
+	if (datamode != EROFS_REBUILD_DATA_BLOB_INDEX)
+		return 0;
+
+	if (extra_devices != rebuild_src_count) {
 		erofs_err("extra_devices(%u) is mismatched with source images(%u)",
 			  extra_devices, rebuild_src_count);
 		return -EOPNOTSUPP;
@@ -1117,6 +1160,7 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 {
 	char uuid_str[37] = {};
+	char *incr = incremental_mode ? "new" : "total";
 
 	if (!(cfg.c_dbg_lvl > EROFS_ERR && cfg.c_showprogress))
 		return;
@@ -1126,11 +1170,11 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 	fprintf(stdout, "------\nFilesystem UUID: %s\n"
 		"Filesystem total blocks: %u (of %u-byte blocks)\n"
 		"Filesystem total inodes: %llu\n"
-		"Filesystem total metadata blocks: %u\n"
-		"Filesystem total deduplicated bytes (of source files): %llu\n",
+		"Filesystem %s metadata blocks: %u\n"
+		"Filesystem %s deduplicated bytes (of source files): %llu\n",
 		uuid_str, nblocks, 1U << sbi.blkszbits, sbi.inos | 0ULL,
-		erofs_total_metablocks(),
-		sbi.saved_by_deduplication | 0ULL);
+		incr, erofs_total_metablocks(),
+		incr, sbi.saved_by_deduplication | 0ULL);
 }
 
 int main(int argc, char **argv)
@@ -1167,20 +1211,13 @@ int main(int argc, char **argv)
 		sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDWR | O_TRUNC);
+	err = erofs_dev_open(&sbi, cfg.c_img_path, O_RDWR |
+				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
 	}
 
-	if (tar_mode && !erofstar.index_mode) {
-		err = erofs_diskbuf_init(1);
-		if (err) {
-			erofs_err("failed to initialize diskbuf: %s",
-				   strerror(-err));
-			goto exit;
-		}
-	}
 #ifdef WITH_ANDROID
 	if (cfg.fs_config_file &&
 	    load_canned_fs_config(cfg.fs_config_file) < 0) {
@@ -1218,14 +1255,22 @@ int main(int argc, char **argv)
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
 #endif
-	if (tar_mode && erofstar.index_mode) {
+	if (tar_mode) {
+		if (dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
+			erofstar.rvsp_mode = true;
+		erofstar.dev = rebuild_src_count + 1;
+
 		if (erofstar.mapfile) {
 			err = erofs_blocklist_open(erofstar.mapfile, true);
 			if (err) {
 				erofs_err("failed to open %s", erofstar.mapfile);
 				goto exit;
 			}
-		} else {
+		} else if (erofstar.index_mode) {
+			/*
+			 * If mapfile is unspecified for tarfs index mode,
+			 * 512-byte block size is enforced here.
+			 */
 			sbi.blkszbits = 9;
 		}
 	}
@@ -1246,10 +1291,43 @@ int main(int argc, char **argv)
 		sbi.blkszbits = src->blkszbits;
 	}
 
-	sb_bh = erofs_reserve_sb();
-	if (IS_ERR(sb_bh)) {
-		err = PTR_ERR(sb_bh);
-		goto exit;
+	if (!incremental_mode) {
+		sb_bh = erofs_reserve_sb();
+		if (IS_ERR(sb_bh)) {
+			err = PTR_ERR(sb_bh);
+			goto exit;
+		}
+		/* generate new UUIDs for clean builds */
+		erofs_uuid_generate(sbi.uuid);
+	} else {
+		union {
+			struct stat st;
+			erofs_blk_t startblk;
+		} u;
+
+		erofs_warn("EXPERIMENTAL incremental build in use. Use at your own risk!");
+		err = erofs_read_superblock(&sbi);
+		if (err) {
+			erofs_err("failed to read superblock of %s", sbi.devname);
+			goto exit;
+		}
+
+		err = erofs_io_fstat(&sbi.bdev, &u.st);
+		if (!err && S_ISREG(u.st.st_mode))
+			u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(&sbi));
+		else
+			u.startblk = sbi.primarydevice_blocks;
+		erofs_buffer_init(u.startblk);
+		sb_bh = NULL;
+	}
+
+	if (tar_mode && !erofstar.index_mode) {
+		err = erofs_diskbuf_init(1);
+		if (err) {
+			erofs_err("failed to initialize diskbuf: %s",
+				   strerror(-err));
+			goto exit;
+		}
 	}
 
 	err = erofs_load_compress_hints(&sbi);
@@ -1310,7 +1388,7 @@ int main(int argc, char **argv)
 		if (err < 0)
 			goto exit;
 
-		err = erofs_rebuild_dump_tree(root, false);
+		err = erofs_rebuild_dump_tree(root, incremental_mode);
 		if (err < 0)
 			goto exit;
 	} else if (rebuild_mode) {
@@ -1320,10 +1398,10 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 
-		err = erofs_rebuild_load_trees(root);
+		err = erofs_mkfs_rebuild_load_trees(root);
 		if (err)
 			goto exit;
-		err = erofs_rebuild_dump_tree(root, false);
+		err = erofs_rebuild_dump_tree(root, incremental_mode);
 		if (err)
 			goto exit;
 	} else {
-- 
2.39.3

