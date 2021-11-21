Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104E458209
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 06:39:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HxfNx1mwgz3036
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 16:39:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637473185;
	bh=irGYSXW+CuonUAAjbRNga7YvtPiqklklO3ZYAcikifE=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=L/VCzKikBNOK5ldKhiCWJ+284iRvaBfJcuQf+w/lMEUCqkpt67kAkHDgBJHszA7fv
	 E38T20CZ0vWak85zMdtBCnRG+zL7QxPkvPr0u8TTzoURG1AwIMtNiQWMzgXP1XEwPY
	 afbjWrQVRJJ9P+UYzqogBDB7nYDJ+ytqKASbSVvt1BZa173G2nKGHjD8eQNeLg0tRt
	 V+zDtLj7QAVQhmfUN0wGder5Woa+rUksgkTIGMQomR/gZ3Ee3l8jh18mBSlUulWBl5
	 3/fJgIbmrnFmW29m/4iED9KPyHyLk855RB9mcujOhEKpaRnzwNLqxQiaN79sNVhQgN
	 nvba5RHrdeR1Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3l9uzyqskc8gdvo1uysz9w1u22uzs.q20zw18b-s52t6zw676.2dzop6.25u@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=ONPrQIt+; dkim-atps=neutral
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HxfNq1NvKz2xvy
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Nov 2021 16:39:39 +1100 (AEDT)
Received: by mail-qk1-x749.google.com with SMTP id
 x5-20020a05620a0b4500b004679442640aso11787645qkg.20
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 21:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=irGYSXW+CuonUAAjbRNga7YvtPiqklklO3ZYAcikifE=;
 b=Ov+ExGCJPCGOlkyqmiNJCyyvu5QXpEbFNeBUyU5WeIYU9XXKuHuz9Oq9Fa1mTnPF7+
 fPoO0s6tczWIK7Zk+bZZ2Tb82BFhOpIwCrICemYbgQBaUnLPpegblC2TwcxLCCoVRhXW
 fTPEeaMZMFm2ZAaQ2w6dA/TVKidxP4iXMflpM11P0xMiHAHWn1CzDB71PoiWrEp5SmGc
 qkcbULuYlvL/sXV/VoIwfuNIP+al5g6I5shaC4w7CFgh3LX+L/GFPm4UJ+i56NInle4z
 3bAfFisCb8G4NEYrBPqLVwiAh7BhM0ZDfXEMM8ftt6LLHJHwXAN3I/7y7aLNG540L1pN
 vm6A==
X-Gm-Message-State: AOAM530q9hd/B24OM2Mjr09KI7H5T6zbOfNVSjId4WJ27s3F0GQUJPog
 lm73sSW8mWNQLrN3pwLeo3ViyIliqbB1uvwI36mgzx37kC1zSUP0Bfl4DTW7ACEgl2VAxlR9bXk
 suHt+62ShPf69qrF241t/BP4BaSssNSzlh9tlghpQwWdoDFwGe0WAp90QybR3kJnyGFBYOPVkJI
 wFrN/7r3U=
X-Google-Smtp-Source: ABdhPJxJcdev7FkrPBv5n5IijAmlx/orvGoiz3pwSgatpYZD+0GwWqCyKoygjNdm9/pnlyH8LFEq7uCizKpDMzKrOA==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:622a:188a:: with SMTP id
 v10mr20286959qtc.297.1637473175636; Sat, 20 Nov 2021 21:39:35 -0800 (PST)
Date: Sat, 20 Nov 2021 21:39:18 -0800
In-Reply-To: <20211121053920.2580751-1-zhangkelvin@google.com>
Message-Id: <20211121053920.2580751-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211121053920.2580751-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1 1/4] Make erofs_devfd a parameter for most functions
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Li Guifu <bluce.liguifu@huawei.com>, 
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>, Chao Yu <yuchao0@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Test: extract system.img from
aosp_cf_x86_64_phone-target_files-7731383.zip , mount it, mkfs.erofs to
generate an EROFS image. Make sure the content is the same before/after
this patch. (Except super block, which has an UUID)

target_files.zip can be downloaded from
https://ci.android.com/builds/branches/aosp-master/grid?head=7934850&tail=7934850

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c               | 61 +++++++++++++++--------------
 fsck/main.c               | 65 ++++++++++++++++---------------
 fuse/dir.c                |  7 +++-
 fuse/main.c               | 18 +++++----
 include/erofs/blobchunk.h |  7 +++-
 include/erofs/cache.h     |  7 ++--
 include/erofs/compress.h  |  8 +++-
 include/erofs/config.h    | 15 ++++----
 include/erofs/defs.h      | 21 ++++++++++
 include/erofs/inode.h     |  6 ++-
 include/erofs/internal.h  | 52 +++++++++----------------
 include/erofs/io.h        | 48 ++++++++++++++---------
 lib/blobchunk.c           | 11 ++++--
 lib/cache.c               | 27 ++++++++-----
 lib/compress.c            | 54 ++++++++++++++------------
 lib/compressor_liblzma.c  |  2 +-
 lib/config.c              | 63 ++++++++++++++++++------------
 lib/data.c                | 30 +++++++++------
 lib/decompress.c          |  2 +-
 lib/inode.c               | 81 +++++++++++++++++++++++----------------
 lib/io.c                  | 74 +++++++++++++++++++----------------
 lib/namei.c               | 22 +++++------
 lib/super.c               | 28 +++++++-------
 lib/xattr.c               |  6 ++-
 lib/zmap.c                | 74 +++++++++++++++++++++--------------
 mkfs/main.c               | 39 ++++++++++---------
 26 files changed, 476 insertions(+), 352 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 401e684..8d0dbd0 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -85,7 +85,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 };
 
-static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid);
+static int erofs_read_dir(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t parent_nid);
 static inline int erofs_checkdirent(struct erofs_dirent *de,
 		struct erofs_dirent *last_de,
 		u32 maxsize, const char *dname);
@@ -257,7 +257,8 @@ static inline int erofs_checkdirent(struct erofs_dirent *de,
 	return dname_len;
 }
 
-static int erofs_read_dirent(struct erofs_dirent *de,
+static int erofs_read_dirent(
+		struct erofs_device erofs_dev, struct erofs_dirent *de,
 		erofs_nid_t nid, erofs_nid_t parent_nid,
 		const char *dname)
 {
@@ -267,7 +268,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 
 	stats.files++;
 	stats.file_category_stat[de->file_type]++;
-	err = erofs_read_inode_from_disk(&inode);
+	err = erofs_read_inode_from_disk(erofs_dev, &inode);
 	if (err) {
 		erofs_err("read file inode from disk failed!");
 		return err;
@@ -288,7 +289,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 
 	if ((de->file_type == EROFS_FT_DIR)
 			&& de->nid != nid && de->nid != parent_nid) {
-		err = erofs_read_dir(de->nid, nid);
+		err = erofs_read_dir(erofs_dev, de->nid, nid);
 		if (err) {
 			erofs_err("parse dir nid %llu error occurred\n",
 					de->nid);
@@ -298,14 +299,14 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 	return 0;
 }
 
-static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
+static int erofs_read_dir(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t parent_nid)
 {
 	int err;
 	erofs_off_t offset;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_inode vi = { .nid = nid };
 
-	err = erofs_read_inode_from_disk(&vi);
+	err = erofs_read_inode_from_disk(fd, &vi);
 	if (err)
 		return err;
 
@@ -317,7 +318,7 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
 		struct erofs_dirent *end;
 		unsigned int nameoff;
 
-		err = erofs_pread(&vi, buf, maxsize, offset);
+		err = erofs_pread(fd, &vi, buf, maxsize, offset);
 		if (err)
 			return err;
 
@@ -337,7 +338,7 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
 			ret = erofs_checkdirent(de, end, maxsize, dname);
 			if (ret < 0)
 				return ret;
-			ret = erofs_read_dirent(de, nid, parent_nid, dname);
+			ret = erofs_read_dirent(fd, de, nid, parent_nid, dname);
 			if (ret < 0)
 				return ret;
 			++de;
@@ -347,7 +348,7 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
 	return 0;
 }
 
-static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
+static int erofs_get_pathname(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t parent_nid,
 		erofs_nid_t target, char *path, unsigned int pos)
 {
 	int err;
@@ -359,7 +360,7 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 	if (target == sbi.root_nid)
 		return 0;
 
-	err = erofs_read_inode_from_disk(&inode);
+	err = erofs_read_inode_from_disk(fd, &inode);
 	if (err) {
 		erofs_err("read inode failed @ nid %llu", nid | 0ULL);
 		return err;
@@ -373,7 +374,7 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 		struct erofs_dirent *end;
 		unsigned int nameoff;
 
-		err = erofs_pread(&inode, buf, maxsize, offset);
+		err = erofs_pread(fd, &inode, buf, maxsize, offset);
 		if (err)
 			return err;
 
@@ -399,7 +400,7 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 					de->nid != parent_nid &&
 					de->nid != nid) {
 				memcpy(path + pos, dname, len);
-				err = erofs_get_pathname(de->nid, nid,
+				err = erofs_get_pathname(fd, de->nid, nid,
 						target, path, pos + len);
 				if (!err)
 					return 0;
@@ -412,15 +413,18 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 	return -1;
 }
 
-static int erofsdump_map_blocks(struct erofs_inode *inode,
-		struct erofs_map_blocks *map, int flags)
+static int erofsdump_map_blocks(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *inode,
+	struct erofs_map_blocks *map,
+	int flags)
 {
 	if (erofs_inode_is_data_compressed(inode->datalayout))
-		return z_erofs_map_blocks_iter(inode, map, flags);
-	return erofs_map_blocks(inode, map, flags);
+		return z_erofs_map_blocks_iter(erofs_dev, inode, map, flags);
+	return erofs_map_blocks(erofs_dev, inode, map, flags);
 }
 
-static void erofsdump_show_fileinfo(bool show_extent)
+static void erofsdump_show_fileinfo(struct erofs_device fd, bool show_extent)
 {
 	int err, i;
 	erofs_off_t size;
@@ -435,7 +439,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		.m_la = 0,
 	};
 
-	err = erofs_read_inode_from_disk(&inode);
+	err = erofs_read_inode_from_disk(fd, &inode);
 	if (err) {
 		erofs_err("read inode failed @ nid %llu", inode.nid | 0ULL);
 		return;
@@ -447,7 +451,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 		return;
 	}
 
-	err = erofs_get_pathname(sbi.root_nid, sbi.root_nid,
+	err = erofs_get_pathname(fd, sbi.root_nid, sbi.root_nid,
 				 inode.nid, path, 0);
 	if (err < 0) {
 		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
@@ -480,7 +484,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 
 	fprintf(stdout, "\n Ext:   logical offset   |  length :     physical offset    |  length \n");
 	while (map.m_la < inode.i_size) {
-		err = erofsdump_map_blocks(&inode, &map,
+		err = erofsdump_map_blocks(fd, &inode, &map,
 				EROFS_GET_BLOCKS_FIEMAP);
 		if (err) {
 			erofs_err("get file blocks range failed");
@@ -580,11 +584,11 @@ static void erofsdump_file_statistic(void)
 			stats.compress_rate);
 }
 
-static void erofsdump_print_statistic(void)
+static void erofsdump_print_statistic(struct erofs_device fd)
 {
 	int err;
 
-	err = erofs_read_dir(sbi.root_nid, sbi.root_nid);
+	err = erofs_read_dir(fd, sbi.root_nid, sbi.root_nid);
 	if (err) {
 		erofs_err("read dir failed");
 		return;
@@ -638,8 +642,9 @@ static void erofsdump_show_superblock(void)
 int main(int argc, char **argv)
 {
 	int err;
+	struct erofs_device erofs_dev;
 
-	erofs_init_configure();
+	erofs_init_global_configure();
 	err = erofsdump_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
@@ -647,13 +652,13 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = dev_open_ro(cfg.c_img_path);
+	err = dev_open_ro(cfg.c_img_path, &erofs_dev);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
 	}
 
-	err = erofs_read_superblock();
+	err = erofs_read_superblock(erofs_dev, &sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit;
@@ -667,7 +672,7 @@ int main(int argc, char **argv)
 		erofsdump_show_superblock();
 
 	if (dumpcfg.show_statistics)
-		erofsdump_print_statistic();
+		erofsdump_print_statistic(erofs_dev);
 
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
@@ -675,9 +680,9 @@ int main(int argc, char **argv)
 	}
 
 	if (dumpcfg.show_inode)
-		erofsdump_show_fileinfo(dumpcfg.show_extent);
+		erofsdump_show_fileinfo(erofs_dev, dumpcfg.show_extent);
 
 exit:
-	erofs_exit_configure();
+	erofs_exit_global_configure();
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index d81d600..b69333b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -6,11 +6,12 @@
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
+#include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
 #include "erofs/decompress.h"
 
-static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
+static void erofs_check_inode(struct erofs_device devfd, erofs_nid_t pnid, erofs_nid_t nid);
 
 struct erofsfsck_cfg {
 	bool corrupted;
@@ -90,14 +91,16 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
-static int erofs_check_sb_chksum(void)
+static int erofs_check_sb_chksum(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi)
 {
 	int ret;
 	u8 buf[EROFS_BLKSIZ];
 	u32 crc;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(buf, 0, 1);
+	ret = blk_read(erofs_dev, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to check checksum: %d",
 			  ret);
@@ -108,9 +111,9 @@ static int erofs_check_sb_chksum(void)
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
@@ -135,7 +138,7 @@ static bool check_special_dentry(struct erofs_dirent *de,
 	return true;
 }
 
-static int traverse_dirents(erofs_nid_t pnid, erofs_nid_t nid,
+static int traverse_dirents(struct erofs_device devfd, erofs_nid_t pnid, erofs_nid_t nid,
 			    void *dentry_blk, erofs_blk_t block,
 			    unsigned int next_nameoff, unsigned int maxsize)
 {
@@ -209,7 +212,7 @@ static int traverse_dirents(erofs_nid_t pnid, erofs_nid_t nid,
 				goto out;
 			}
 		} else {
-			erofs_check_inode(nid, de->nid);
+			erofs_check_inode(devfd, nid, de->nid);
 		}
 
 		if (fsckcfg.corrupted) {
@@ -232,7 +235,8 @@ out:
 	return ret;
 }
 
-static int verify_uncompressed_inode(struct erofs_inode *inode)
+static int verify_uncompressed_inode(
+	struct erofs_device erofs_dev, struct erofs_inode *inode)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
@@ -243,7 +247,7 @@ static int verify_uncompressed_inode(struct erofs_inode *inode)
 
 	while (ptr < inode->i_size) {
 		map.m_la = ptr;
-		ret = erofs_map_blocks(inode, &map, 0);
+		ret = erofs_map_blocks(erofs_dev, inode, &map, 0);
 		if (ret)
 			return ret;
 
@@ -270,7 +274,7 @@ static int verify_uncompressed_inode(struct erofs_inode *inode)
 	return 0;
 }
 
-static int verify_compressed_inode(struct erofs_inode *inode)
+static int verify_compressed_inode(struct erofs_device erofs_dev, struct erofs_inode *inode)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
@@ -284,7 +288,7 @@ static int verify_compressed_inode(struct erofs_inode *inode)
 	while (end > 0) {
 		map.m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(inode, &map, 0);
+		ret = z_erofs_map_blocks_iter(erofs_dev, inode, &map, 0);
 		if (ret)
 			goto out;
 
@@ -317,7 +321,7 @@ static int verify_compressed_inode(struct erofs_inode *inode)
 			BUG_ON(!buffer);
 		}
 
-		ret = dev_read(raw, map.m_pa, map.m_plen);
+		ret = dev_read(erofs_dev, raw, map.m_pa, map.m_plen);
 		if (ret < 0) {
 			erofs_err("failed to read compressed data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
 				  map.m_pa, map.m_plen, inode->nid | 0ULL, ret);
@@ -355,7 +359,7 @@ out:
 	return ret < 0 ? ret : 0;
 }
 
-static int erofs_verify_xattr(struct erofs_inode *inode)
+static int erofs_verify_xattr(struct erofs_device erofs_dev, struct erofs_inode *inode)
 {
 	unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
 	unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
@@ -381,7 +385,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	}
 
 	addr = iloc(inode->nid) + inode->inode_isize;
-	ret = dev_read(buf, addr, xattr_hdr_size);
+	ret = dev_read(erofs_dev, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
 			  inode->nid | 0ULL, ret);
@@ -411,7 +415,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	while (remaining > 0) {
 		unsigned int entry_sz;
 
-		ret = dev_read(buf, addr, xattr_entry_size);
+		ret = dev_read(erofs_dev, buf, addr, xattr_entry_size);
 		if (ret) {
 			erofs_err("failed to read xattr entry @ nid %llu: %d",
 				  inode->nid | 0ULL, ret);
@@ -433,7 +437,7 @@ out:
 	return ret;
 }
 
-static int erofs_verify_inode_data(struct erofs_inode *inode)
+static int erofs_verify_inode_data(struct erofs_device erofs_dev, struct erofs_inode *inode)
 {
 	int ret;
 
@@ -444,11 +448,11 @@ static int erofs_verify_inode_data(struct erofs_inode *inode)
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
-		ret = verify_uncompressed_inode(inode);
+		ret = verify_uncompressed_inode(erofs_dev, inode);
 		break;
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		ret = verify_compressed_inode(inode);
+		ret = verify_compressed_inode(erofs_dev, inode);
 		break;
 	default:
 		ret = -EINVAL;
@@ -462,7 +466,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode)
 	return ret;
 }
 
-static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
+static void erofs_check_inode(struct erofs_device erofs_dev, erofs_nid_t pnid, erofs_nid_t nid)
 {
 	int ret;
 	struct erofs_inode inode;
@@ -472,7 +476,7 @@ static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
 
 	inode.nid = nid;
-	ret = erofs_read_inode_from_disk(&inode);
+	ret = erofs_read_inode_from_disk(erofs_dev, &inode);
 	if (ret) {
 		if (ret == -EIO)
 			erofs_err("I/O error occurred when reading nid(%llu)",
@@ -481,12 +485,12 @@ static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	}
 
 	/* verify xattr field */
-	ret = erofs_verify_xattr(&inode);
+	ret = erofs_verify_xattr(erofs_dev,&inode);
 	if (ret)
 		goto out;
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(&inode);
+	ret = erofs_verify_inode_data(erofs_dev, &inode);
 	if (ret)
 		goto out;
 
@@ -502,7 +506,7 @@ static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 
 		unsigned int nameoff;
 
-		ret = erofs_pread(&inode, buf, maxsize, offset);
+		ret = erofs_pread(erofs_dev, &inode, buf, maxsize, offset);
 		if (ret) {
 			erofs_err("I/O error occurred when reading dirents @ nid %llu, block %u: %d",
 				  nid | 0ULL, block, ret);
@@ -518,7 +522,7 @@ static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			goto out;
 		}
 
-		ret = traverse_dirents(pnid, nid, buf, block,
+		ret = traverse_dirents(erofs_dev, pnid, nid, buf, block,
 				       nameoff, maxsize);
 		if (ret)
 			goto out;
@@ -533,8 +537,9 @@ out:
 int main(int argc, char **argv)
 {
 	int err;
+	struct erofs_device erofs_dev;
 
-	erofs_init_configure();
+	erofs_init_global_configure();
 
 	fsckcfg.corrupted = false;
 	fsckcfg.print_comp_ratio = false;
@@ -549,24 +554,24 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = dev_open_ro(cfg.c_img_path);
+	err = dev_open_ro(cfg.c_img_path, &erofs_dev);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
 	}
 
-	err = erofs_read_superblock();
+	err = erofs_read_superblock(erofs_dev, &sbi);
 	if (err) {
 		erofs_err("failed to read superblock");
 		goto exit;
 	}
 
-	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
+	if (erofs_sb_has_sb_chksum(&sbi) && erofs_check_sb_chksum(erofs_dev, &sbi)) {
 		erofs_err("failed to verify superblock checksum");
 		goto exit;
 	}
 
-	erofs_check_inode(sbi.root_nid, sbi.root_nid);
+	erofs_check_inode(erofs_dev, sbi.root_nid, sbi.root_nid);
 
 	if (fsckcfg.corrupted) {
 		erofs_err("Found some filesystem corruption");
@@ -583,6 +588,6 @@ int main(int argc, char **argv)
 	}
 
 exit:
-	erofs_exit_configure();
+	erofs_exit_global_configure();
 	return err ? 1 : 0;
 }
diff --git a/fuse/dir.c b/fuse/dir.c
index bc8735b..494c915 100644
--- a/fuse/dir.c
+++ b/fuse/dir.c
@@ -8,6 +8,9 @@
 #include "erofs/internal.h"
 #include "erofs/print.h"
 
+// defined in fuse/main.c
+extern struct erofs_device erofs_dev;
+
 static int erofs_fill_dentries(struct erofs_inode *dir,
 			       fuse_fill_dir_t filler, void *buf,
 			       void *dblk, unsigned int nameoff,
@@ -57,7 +60,7 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 
 	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
 
-	ret = erofs_ilookup(path, &dir);
+	ret = erofs_ilookup(erofs_dev, path, &dir);
 	if (ret)
 		return ret;
 
@@ -76,7 +79,7 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 
 		maxsize = min_t(unsigned int, EROFS_BLKSIZ,
 				dir.i_size - pos);
-		ret = erofs_pread(&dir, dblk, maxsize, pos);
+		ret = erofs_pread(erofs_dev, &dir, dblk, maxsize, pos);
 		if (ret)
 			return ret;
 
diff --git a/fuse/main.c b/fuse/main.c
index 8137421..b3e1a3d 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -13,6 +13,8 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 
+struct erofs_device erofs_dev;
+
 int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
 		      off_t offset, struct fuse_file_info *fi);
 
@@ -38,7 +40,7 @@ static int erofsfuse_getattr(const char *path, struct stat *stbuf)
 	int ret;
 
 	erofs_dbg("getattr(%s)", path);
-	ret = erofs_ilookup(path, &vi);
+	ret = erofs_ilookup(erofs_dev, path, &vi);
 	if (ret)
 		return -ENOENT;
 
@@ -65,11 +67,11 @@ static int erofsfuse_read(const char *path, char *buffer,
 
 	erofs_dbg("path:%s size=%zd offset=%llu", path, size, (long long)offset);
 
-	ret = erofs_ilookup(path, &vi);
+	ret = erofs_ilookup(erofs_dev, path, &vi);
 	if (ret)
 		return ret;
 
-	ret = erofs_pread(&vi, buffer, size, offset);
+	ret = erofs_pread(erofs_dev, &vi, buffer, size, offset);
 	if (ret)
 		return ret;
 	if (offset >= vi.i_size)
@@ -199,7 +201,7 @@ int main(int argc, char *argv[])
 	int ret;
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
 
-	erofs_init_configure();
+	erofs_init_global_configure();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
 
 #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
@@ -223,13 +225,13 @@ int main(int argc, char *argv[])
 		cfg.c_dbg_lvl = EROFS_DBG;
 
 	erofsfuse_dumpcfg();
-	ret = dev_open_ro(fusecfg.disk);
+	ret = dev_open_ro(fusecfg.disk, &erofs_dev);
 	if (ret) {
 		fprintf(stderr, "failed to open: %s\n", fusecfg.disk);
 		goto err_fuse_free_args;
 	}
 
-	ret = erofs_read_superblock();
+	ret = erofs_read_superblock(erofs_dev, &sbi);
 	if (ret) {
 		fprintf(stderr, "failed to read erofs super block\n");
 		goto err_dev_close;
@@ -237,10 +239,10 @@ int main(int argc, char *argv[])
 
 	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
 err_dev_close:
-	dev_close();
+	dev_close(&erofs_dev);
 err_fuse_free_args:
 	fuse_opt_free_args(&args);
 err:
-	erofs_exit_configure();
+	erofs_exit_global_configure();
 	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
 }
diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index b418227..7f58b17 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -9,9 +9,12 @@
 
 #include "erofs/internal.h"
 
-int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
+int erofs_blob_write_chunk_indexes(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *inode,
+	erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode);
-int erofs_blob_remap(void);
+int erofs_blob_remap(struct erofs_device erofs_dev);
 void erofs_blob_exit(void);
 int erofs_blob_init(void);
 
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index e324d92..051c696 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -9,6 +9,7 @@
 #define __EROFS_CACHE_H
 
 #include "internal.h"
+#include <stdlib.h>
 
 struct erofs_buffer_head;
 struct erofs_buffer_block;
@@ -21,8 +22,8 @@ struct erofs_buffer_block;
 #define XATTR		3
 
 struct erofs_bhops {
-	bool (*preflush)(struct erofs_buffer_head *bh);
-	bool (*flush)(struct erofs_buffer_head *bh);
+	bool (*preflush)(struct erofs_device erofs_dev, struct erofs_buffer_head *bh);
+	bool (*flush)(struct erofs_device erofs_dev, struct erofs_buffer_head *bh);
 };
 
 struct erofs_buffer_head {
@@ -95,7 +96,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
-bool erofs_bflush(struct erofs_buffer_block *bb);
+bool erofs_bflush(struct erofs_device erofs_dev, struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
 
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 4434aaa..73834a7 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -14,9 +14,13 @@
 #define EROFS_CONFIG_COMPR_MAX_SZ           (900  * 1024)
 #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
 
-int erofs_write_compressed_file(struct erofs_inode *inode);
+int erofs_write_compressed_file(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *inode);
 
-int z_erofs_compress_init(struct erofs_buffer_head *bh);
+int z_erofs_compress_init(
+	struct erofs_device erofs_dev,
+	struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_available_compressors(unsigned int i);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index a18c883..2b0510e 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -4,10 +4,11 @@
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
  */
-#ifndef __EROFS_CONFIG_H
-#define __EROFS_CONFIG_H
+#ifndef EROFS_CONFIG_H_
+#define EROFS_CONFIG_H_
 
 #include "defs.h"
+#include "erofs/internal.h"
 #include "err.h"
 
 #ifdef HAVE_LIBSELINUX
@@ -73,20 +74,20 @@ struct erofs_configure {
 
 extern struct erofs_configure cfg;
 
-void erofs_init_configure(void);
+void erofs_init_global_configure(void);
 void erofs_show_config(void);
-void erofs_exit_configure(void);
+void erofs_exit_global_configure(void);
 
 void erofs_set_fs_root(const char *rootdir);
 const char *erofs_fspath(const char *fullpath);
 
 #ifdef HAVE_LIBSELINUX
-int erofs_selabel_open(const char *file_contexts);
+int erofs_global_selabel_open(const char *file_contexts);
 #else
-static inline int erofs_selabel_open(const char *file_contexts)
+static inline int erofs_global_selabel_open(const char *file_contexts)
 {
 	return -EINVAL;
 }
 #endif
 
-#endif
+#endif // EROFS_CONFIG_H_
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 96bbb65..2dc9177 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -38,6 +38,27 @@ typedef uint16_t        u16;
 typedef uint32_t        u32;
 typedef uint64_t        u64;
 
+typedef u64 erofs_off_t;
+typedef u64 erofs_nid_t;
+/* data type for filesystem-wide blocks number */
+typedef u32 erofs_blk_t;
+
+#define LOG_BLOCK_SIZE          (12)
+#define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
+
+#define EROFS_ISLOTBITS		5
+#define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
+
+
+#define NULL_ADDR	((unsigned int)-1)
+#define NULL_ADDR_UL	((unsigned long)-1)
+
+#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
+#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
+#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
+
+#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
+
 #ifndef HAVE_LINUX_TYPES_H
 typedef u8	__u8;
 typedef u16	__u16;
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index a736762..5483d04 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -13,7 +13,9 @@
 void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
-						    const char *path);
+struct erofs_inode *erofs_mkfs_build_tree_from_path(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *parent,
+	const char *path);
 
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f84e6b4..49a883e 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -16,6 +16,7 @@ typedef unsigned short umode_t;
 
 #include "erofs_fs.h"
 #include <fcntl.h>
+#include "io.h"
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -38,25 +39,6 @@ typedef unsigned short umode_t;
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 #endif
 
-#define LOG_BLOCK_SIZE          (12)
-#define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
-
-#define EROFS_ISLOTBITS		5
-#define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
-
-typedef u64 erofs_off_t;
-typedef u64 erofs_nid_t;
-/* data type for filesystem-wide blocks number */
-typedef u32 erofs_blk_t;
-
-#define NULL_ADDR	((unsigned int)-1)
-#define NULL_ADDR_UL	((unsigned long)-1)
-
-#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
-#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
-#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
-
-#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
 
 struct erofs_buffer_head;
 
@@ -95,17 +77,17 @@ static inline erofs_off_t iloc(erofs_nid_t nid)
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
@@ -268,22 +250,26 @@ struct erofs_map_blocks {
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 
 /* super.c */
-int erofs_read_superblock(void);
+int erofs_read_superblock(struct erofs_device devfd, struct erofs_sb_info *sbi);
 
 /* namei.c */
-int erofs_read_inode_from_disk(struct erofs_inode *vi);
-int erofs_ilookup(const char *path, struct erofs_inode *vi);
-int erofs_read_inode_from_disk(struct erofs_inode *vi);
+int erofs_read_inode_from_disk(struct erofs_device fd, struct erofs_inode *vi);
+int erofs_ilookup(struct erofs_device devfd, const char *path, struct erofs_inode *vi);
 
 /* data.c */
-int erofs_pread(struct erofs_inode *inode, char *buf,
+int erofs_pread(struct erofs_device fd, struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
-int erofs_map_blocks(struct erofs_inode *inode,
+int erofs_map_blocks(
+		struct erofs_device erofs_dev,
+		struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
-int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map, int flags);
+int z_erofs_map_blocks_iter(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *vi,
+	struct erofs_map_blocks *map,
+	int flags);
 
 #ifdef EUCLEAN
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 2597c5c..bbdccc4 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -9,40 +9,52 @@
 
 #define _GNU_SOURCE
 #include <unistd.h>
-#include "internal.h"
+#include "defs.h"
 
 #ifndef O_BINARY
 #define O_BINARY	0
 #endif
 
-int dev_open(const char *devname);
-int dev_open_ro(const char *dev);
-void dev_close(void);
-int dev_write(const void *buf, u64 offset, size_t len);
-int dev_read(void *buf, u64 offset, size_t len);
-int dev_fillzero(u64 offset, size_t len, bool padding);
-int dev_fsync(void);
-int dev_resize(erofs_blk_t nblocks);
-u64 dev_length(void);
+struct erofs_device {
+	const char *erofs_devname;
+	int erofs_devfd;
+	u64 erofs_devsz;
+};
+
+int dev_open(const char *devname, struct erofs_device *erofs_dev);
+int dev_open_ro(const char *dev, struct erofs_device *erofs_dev);
+void dev_close(struct erofs_device *erofs_dev);
+int dev_write(struct erofs_device erofs_dev, const void *buf, u64 offset, size_t len);
+int dev_read(struct erofs_device erofs_dev, void *buf, u64 offset, size_t len);
+int dev_fillzero(struct erofs_device erofs_dev, u64 offset, size_t len, bool padding);
+int dev_fsync(struct erofs_device erofs_dev);
+int dev_resize(struct erofs_device erofs_dev, erofs_blk_t nblocks);
+u64 dev_length(struct erofs_device erofs_dev);
+
 
-extern int erofs_devfd;
 
 int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
                           int fd_out, erofs_off_t *off_out,
                           size_t length);
 
-static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
-			    u32 nblocks)
+static inline int blk_write(
+	struct erofs_device dev,
+	const void *buf,
+	erofs_blk_t blkaddr,
+	u32 nblocks)
 {
-	return dev_write(buf, blknr_to_addr(blkaddr),
+	return dev_write(dev, buf, blknr_to_addr(blkaddr),
 			 blknr_to_addr(nblocks));
 }
 
-static inline int blk_read(void *buf, erofs_blk_t start,
-			    u32 nblocks)
+static inline int blk_read(
+	struct erofs_device dev,
+	void *buf,
+	erofs_blk_t start,
+	u32 nblocks)
 {
-	return dev_read(buf, blknr_to_addr(start),
+	return dev_read(dev, buf, blknr_to_addr(start),
 			 blknr_to_addr(nblocks));
 }
 
-#endif
+#endif // EROFS_IO_H_
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 661c5d0..24904fb 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -97,8 +97,10 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
 		      sizeof(ec1->sha256));
 }
 
-int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
-				   erofs_off_t off)
+int erofs_blob_write_chunk_indexes(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *inode,
+	erofs_off_t off)
 {
 	struct erofs_inode_chunk_index idx = {0};
 	unsigned int dst, src, unit;
@@ -122,7 +124,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	}
 	off = roundup(off, unit);
 
-	return dev_write(inode->chunkindexes, off, inode->extent_isize);
+	return dev_write(erofs_dev, inode->chunkindexes, off, inode->extent_isize);
 }
 
 int erofs_blob_write_chunked_file(struct erofs_inode *inode)
@@ -174,12 +176,13 @@ err:
 	return ret;
 }
 
-int erofs_blob_remap(void)
+int erofs_blob_remap(struct erofs_device erofs_dev)
 {
 	struct erofs_buffer_head *bh;
 	ssize_t length;
 	erofs_off_t pos_in, pos_out;
 	int ret;
+	const int erofs_devfd = erofs_dev.erofs_devfd;
 
 	fflush(blobfile);
 	length = ftell(blobfile);
diff --git a/lib/cache.c b/lib/cache.c
index 8016e38..bae172c 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -21,7 +21,9 @@ static struct list_head mapped_buckets[META + 1][EROFS_BLKSIZ];
 /* last mapped buffer block to accelerate erofs_mapbh() */
 static struct erofs_buffer_block *last_mapped_block = &blkh;
 
-static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
+static bool erofs_bh_flush_drop_directly(
+	struct erofs_device erofs_dev,
+	struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
 }
@@ -30,7 +32,9 @@ struct erofs_bhops erofs_drop_directly_bhops = {
 	.flush = erofs_bh_flush_drop_directly,
 };
 
-static bool erofs_bh_flush_skip_write(struct erofs_buffer_head *bh)
+static bool erofs_bh_flush_skip_write(
+	struct erofs_device erofs_dev,
+	struct erofs_buffer_head *bh)
 {
 	return false;
 }
@@ -39,18 +43,20 @@ struct erofs_bhops erofs_skip_write_bhops = {
 	.flush = erofs_bh_flush_skip_write,
 };
 
-int erofs_bh_flush_generic_write(struct erofs_buffer_head *bh, void *buf)
+int erofs_bh_flush_generic_write(struct erofs_device erofs_dev, struct erofs_buffer_head *bh, void *buf)
 {
 	struct erofs_buffer_head *nbh = list_next_entry(bh, list);
 	erofs_off_t offset = erofs_btell(bh, false);
 
 	DBG_BUGON(nbh->off < bh->off);
-	return dev_write(buf, offset, nbh->off - bh->off);
+	return dev_write(erofs_dev, buf, offset, nbh->off - bh->off);
 }
 
-static bool erofs_bh_flush_buf_write(struct erofs_buffer_head *bh)
+static bool erofs_bh_flush_buf_write(
+	struct erofs_device erofs_dev,
+	struct erofs_buffer_head *bh)
 {
-	int err = erofs_bh_flush_generic_write(bh, bh->fsprivate);
+	int err = erofs_bh_flush_generic_write(erofs_dev, bh, bh->fsprivate);
 
 	if (err)
 		return false;
@@ -58,6 +64,7 @@ static bool erofs_bh_flush_buf_write(struct erofs_buffer_head *bh)
 	return erofs_bh_flush_generic_end(bh);
 }
 
+
 struct erofs_bhops erofs_buf_write_bhops = {
 	.flush = erofs_bh_flush_buf_write,
 };
@@ -368,7 +375,7 @@ erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
 	return tail_blkaddr;
 }
 
-bool erofs_bflush(struct erofs_buffer_block *bb)
+bool erofs_bflush(struct erofs_device erofs_dev, struct erofs_buffer_block *bb)
 {
 	struct erofs_buffer_block *p, *n;
 	erofs_blk_t blkaddr;
@@ -383,14 +390,14 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		/* check if the buffer block can flush */
 		list_for_each_entry(bh, &p->buffers.list, list)
-			if (bh->op->preflush && !bh->op->preflush(bh))
+			if (bh->op->preflush && !bh->op->preflush(erofs_dev, bh))
 				return false;
 
 		blkaddr = __erofs_mapbh(p);
 
 		list_for_each_entry_safe(bh, nbh, &p->buffers.list, list) {
 			/* flush and remove bh */
-			if (!bh->op->flush(bh))
+			if (!bh->op->flush(erofs_dev, bh))
 				skip = true;
 		}
 
@@ -399,7 +406,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		padding = EROFS_BLKSIZ - p->buffers.off % EROFS_BLKSIZ;
 		if (padding != EROFS_BLKSIZ)
-			dev_fillzero(blknr_to_addr(blkaddr) - padding,
+			dev_fillzero(erofs_dev, blknr_to_addr(blkaddr) - padding,
 				     padding, true);
 
 		DBG_BUGON(!list_empty(&p->buffers.list));
diff --git a/lib/compress.c b/lib/compress.c
index 98be7a2..766b75b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -89,7 +89,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 	do {
 		/* XXX: big pcluster feature should be per-inode */
-		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
+		if (d0 == 1 && erofs_sb_has_big_pcluster(&sbi)) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
 					Z_EROFS_VLE_DI_D0_CBLKCNT);
@@ -120,14 +120,16 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
+static int write_uncompressed_extent(
+	struct erofs_device erofs_dev,
+	struct z_erofs_vle_compress_ctx *ctx,
 				     unsigned int *len, char *dst)
 {
 	int ret;
 	unsigned int count;
 
 	/* reset clusterofs to 0 if permitted */
-	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
+	if (!erofs_sb_has_lz4_0padding(&sbi) && ctx->clusterofs &&
 	    ctx->head >= ctx->clusterofs) {
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
@@ -142,7 +144,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
-	ret = blk_write(dst, ctx->blkaddr, 1);
+	ret = blk_write(erofs_dev, dst, ctx->blkaddr, 1);
 	if (ret)
 		return ret;
 	return count;
@@ -162,9 +164,11 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 	return cfg.c_pclusterblks_def;
 }
 
-static int vle_compress_one(struct erofs_inode *inode,
-			    struct z_erofs_vle_compress_ctx *ctx,
-			    bool final)
+static int vle_compress_one(
+		struct erofs_device erofs_dev,
+		struct erofs_inode *inode,
+		struct z_erofs_vle_compress_ctx *ctx,
+		bool final)
 {
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
@@ -197,7 +201,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 nocompression:
-			ret = write_uncompressed_extent(ctx, &len, dst);
+			ret = write_uncompressed_extent(erofs_dev, ctx, &len, dst);
 			if (ret < 0)
 				return ret;
 			count = ret;
@@ -206,14 +210,14 @@ nocompression:
 		} else {
 			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
 			const unsigned int padding =
-				erofs_sb_has_lz4_0padding() && tailused ?
+				erofs_sb_has_lz4_0padding(&sbi) && tailused ?
 					EROFS_BLKSIZ - tailused : 0;
 
 			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
 			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
 
 			/* zero out garbage trailing data for non-0padding */
-			if (!erofs_sb_has_lz4_0padding())
+			if (!erofs_sb_has_lz4_0padding(&sbi))
 				memset(dst + ret, 0,
 				       roundup(ret, EROFS_BLKSIZ) - ret);
 
@@ -221,7 +225,7 @@ nocompression:
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
 				  count, ctx->blkaddr, ctx->compressedblks);
 
-			ret = blk_write(dst - padding, ctx->blkaddr,
+			ret = blk_write(erofs_dev, dst - padding, ctx->blkaddr,
 					ctx->compressedblks);
 			if (ret)
 				return ret;
@@ -302,7 +306,7 @@ static void *write_compacted_indexes(u8 *out,
 		return ERR_PTR(-EINVAL);
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
-	update_blkaddr = erofs_sb_has_big_pcluster();
+	update_blkaddr = erofs_sb_has_big_pcluster(&sbi);
 
 	pos = 0;
 	for (i = 0; i < vcnt; ++i) {
@@ -398,7 +402,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	dummy_head = false;
 	/* prior to bigpcluster, blkaddr was bumped up once coming into HEAD */
-	if (!erofs_sb_has_big_pcluster()) {
+	if (!erofs_sb_has_big_pcluster(&sbi)) {
 		--blkaddr;
 		dummy_head = true;
 	}
@@ -460,7 +464,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
 }
 
-int erofs_write_compressed_file(struct erofs_inode *inode)
+int erofs_write_compressed_file(struct erofs_device erofs_dev, struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh;
 	struct z_erofs_vle_compress_ctx ctx;
@@ -495,7 +499,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	}
 
-	if (erofs_sb_has_big_pcluster()) {
+	if (erofs_sb_has_big_pcluster(&sbi)) {
 		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
@@ -526,13 +530,13 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		ctx.tail += readcount;
 
 		/* do one compress round */
-		ret = vle_compress_one(inode, &ctx, false);
+		ret = vle_compress_one(erofs_dev, inode, &ctx, false);
 		if (ret)
 			goto err_bdrop;
 	}
 
 	/* do the final round */
-	ret = vle_compress_one(inode, &ctx, true);
+	ret = vle_compress_one(erofs_dev, inode, &ctx, true);
 	if (ret)
 		goto err_bdrop;
 
@@ -593,7 +597,7 @@ static int erofs_get_compress_algorithm_id(const char *name)
 	return -ENOTSUP;
 }
 
-int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
+int z_erofs_build_compr_cfgs(struct erofs_device erofs_dev, struct erofs_buffer_head *sb_bh)
 {
 	struct erofs_buffer_head *bh = sb_bh;
 	int ret = 0;
@@ -617,7 +621,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			return PTR_ERR(bh);
 		}
 		erofs_mapbh(bh->block);
-		ret = dev_write(&lz4alg, erofs_btell(bh, false),
+		ret = dev_write(erofs_dev, &lz4alg, erofs_btell(bh, false),
 				sizeof(lz4alg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -647,7 +651,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 	return ret;
 }
 
-int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
+int z_erofs_compress_init(struct erofs_device erofs_dev, struct erofs_buffer_head *sb_bh)
 {
 	/* initialize for primary compression algorithm */
 	int ret = erofs_compressor_init(&compresshandle,
@@ -662,7 +666,7 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	 */
 	if (!cfg.c_compr_alg_master ||
 	    (cfg.c_legacy_compress && !strcmp(cfg.c_compr_alg_master, "lz4")))
-		erofs_sb_clear_lz4_0padding();
+		erofs_sb_clear_lz4_0padding(&sbi);
 
 	if (!cfg.c_compr_alg_master)
 		return 0;
@@ -690,16 +694,16 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 				  cfg.c_pclusterblks_max);
 			return -EINVAL;
 		}
-		erofs_sb_set_big_pcluster();
+		erofs_sb_set_big_pcluster(&sbi);
 		erofs_warn("EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
 	}
 
 	if (ret != Z_EROFS_COMPRESSION_LZ4)
-		erofs_sb_set_compr_cfgs();
+		erofs_sb_set_compr_cfgs(&sbi);
 
-	if (erofs_sb_has_compr_cfgs()) {
+	if (erofs_sb_has_compr_cfgs(&sbi)) {
 		sbi.available_compr_algs |= 1 << ret;
-		return z_erofs_build_compr_cfgs(sb_bh);
+		return z_erofs_build_compr_cfgs(erofs_dev, sb_bh);
 	}
 	return 0;
 }
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 40a05ef..576cdae 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -4,9 +4,9 @@
  *
  * Copyright (C) 2021 Gao Xiang <xiang@kernel.org>
  */
+#ifdef HAVE_LIBLZMA
 #include <stdlib.h>
 #include "config.h"
-#ifdef HAVE_LIBLZMA
 #include <lzma.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
diff --git a/lib/config.c b/lib/config.c
index 363dcc5..7488e08 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -12,22 +12,26 @@
 struct erofs_configure cfg;
 struct erofs_sb_info sbi;
 
-void erofs_init_configure(void)
+void erofs_init_config(struct erofs_configure *cfg)
 {
-	memset(&cfg, 0, sizeof(cfg));
-
-	cfg.c_dbg_lvl  = EROFS_WARN;
-	cfg.c_version  = PACKAGE_VERSION;
-	cfg.c_dry_run  = false;
-	cfg.c_compr_level_master = -1;
-	cfg.c_force_inodeversion = 0;
-	cfg.c_inline_xattr_tolerance = 2;
-	cfg.c_unix_timestamp = -1;
-	cfg.c_uid = -1;
-	cfg.c_gid = -1;
-	cfg.c_pclusterblks_max = 1;
-	cfg.c_pclusterblks_def = 1;
-	cfg.c_max_decompressed_extent_bytes = -1;
+	memset(cfg, 0, sizeof(*cfg));
+
+	cfg->c_dbg_lvl  = EROFS_WARN;
+	cfg->c_version  = PACKAGE_VERSION;
+	cfg->c_dry_run  = false;
+	cfg->c_compr_level_master = -1;
+	cfg->c_force_inodeversion = 0;
+	cfg->c_inline_xattr_tolerance = 2;
+	cfg->c_unix_timestamp = -1;
+	cfg->c_uid = -1;
+	cfg->c_gid = -1;
+	cfg->c_pclusterblks_max = 1;
+	cfg->c_pclusterblks_def = 1;
+	cfg->c_max_decompressed_extent_bytes = -1;
+}
+
+void erofs_init_global_configure() {
+  erofs_init_config(&cfg);
 }
 
 void erofs_show_config(void)
@@ -41,14 +45,18 @@ void erofs_show_config(void)
 	erofs_dump("\tc_dry_run:           [%8d]\n", c->c_dry_run);
 }
 
-void erofs_exit_configure(void)
+void erofs_exit_configure(struct erofs_configure *cfg)
 {
 #ifdef HAVE_LIBSELINUX
-	if (cfg.sehnd)
-		selabel_close(cfg.sehnd);
+	if (cfg->sehnd)
+		selabel_close(cfg->sehnd);
 #endif
-	if (cfg.c_img_path)
-		free(cfg.c_img_path);
+	if (cfg->c_img_path)
+		free(cfg->c_img_path);
+}
+
+void erofs_exit_global_configure(void) {
+  erofs_exit_configure(&cfg);
 }
 
 static unsigned int fullpath_prefix;	/* root directory prefix length */
@@ -68,24 +76,31 @@ const char *erofs_fspath(const char *fullpath)
 }
 
 #ifdef HAVE_LIBSELINUX
-int erofs_selabel_open(const char *file_contexts)
+int erofs_selabel_open(struct erofs_configure *cfg_p,const char *file_contexts)
 {
 	struct selinux_opt seopts[] = {
 		{ .type = SELABEL_OPT_PATH, .value = file_contexts }
 	};
 
-	if (cfg.sehnd) {
+	if (cfg_p->sehnd) {
+    struct erofs_configure cfg = *cfg_p;
 		erofs_info("ignore duplicated file contexts \"%s\"",
 			   file_contexts);
 		return -EBUSY;
 	}
 
-	cfg.sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
-	if (!cfg.sehnd) {
+	cfg_p->sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
+	if (!cfg_p->sehnd) {
+    struct erofs_configure cfg = *cfg_p;
 		erofs_err("failed to open file contexts \"%s\"",
 			  file_contexts);
 		return -EINVAL;
 	}
 	return 0;
 }
+
+int erofs_global_selabel_open(const char *file_contexts) {
+  return erofs_selabel_open(&cfg, file_contexts);
+}
+
 #endif
diff --git a/lib/data.c b/lib/data.c
index b5f0196..d9d20ec 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -61,7 +61,9 @@ err_out:
 	return err;
 }
 
-int erofs_map_blocks(struct erofs_inode *inode,
+int erofs_map_blocks(
+		struct erofs_device erofs_dev,
+		struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
@@ -91,7 +93,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	pos = roundup(iloc(vi->nid) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
-	err = blk_read(buf, erofs_blknr(pos), 1);
+	err = blk_read(erofs_dev, buf, erofs_blknr(pos), 1);
 	if (err < 0)
 		return -EIO;
 
@@ -135,7 +137,7 @@ out:
 	return err;
 }
 
-static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+static int erofs_read_raw_data(struct erofs_device erofs_dev, struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
 	struct erofs_map_blocks map = {
@@ -149,7 +151,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 		erofs_off_t eend;
 
 		map.m_la = ptr;
-		ret = erofs_map_blocks(inode, &map, 0);
+		ret = erofs_map_blocks(erofs_dev, inode, &map, 0);
 		if (ret)
 			return ret;
 
@@ -176,7 +178,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			map.m_la = ptr;
 		}
 
-		ret = dev_read(estart, map.m_pa, eend - map.m_la);
+		ret = dev_read(erofs_dev, estart, map.m_pa, eend - map.m_la);
 		if (ret < 0)
 			return -EIO;
 		ptr = eend;
@@ -184,8 +186,12 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
-static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
-			     erofs_off_t size, erofs_off_t offset)
+static int z_erofs_read_data(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *inode,
+	char *buffer,
+	erofs_off_t size,
+	erofs_off_t offset)
 {
 	erofs_off_t end, length, skip;
 	struct erofs_map_blocks map = {
@@ -201,7 +207,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	while (end > offset) {
 		map.m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(inode, &map, 0);
+		ret = z_erofs_map_blocks_iter(erofs_dev, inode, &map, 0);
 		if (ret)
 			break;
 
@@ -240,7 +246,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 				break;
 			}
 		}
-		ret = dev_read(raw, map.m_pa, map.m_plen);
+		ret = dev_read(erofs_dev, raw, map.m_pa, map.m_plen);
 		if (ret < 0)
 			break;
 
@@ -266,17 +272,17 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	return ret < 0 ? ret : 0;
 }
 
-int erofs_pread(struct erofs_inode *inode, char *buf,
+int erofs_pread(struct erofs_device fd, struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset)
 {
 	switch (inode->datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
-		return erofs_read_raw_data(inode, buf, count, offset);
+		return erofs_read_raw_data(fd, inode, buf, count, offset);
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		return z_erofs_read_data(inode, buf, count, offset);
+		return z_erofs_read_data(fd, inode, buf, count, offset);
 	default:
 		break;
 	}
diff --git a/lib/decompress.c b/lib/decompress.c
index f313e41..6a60400 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -82,7 +82,7 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 	bool support_0padding = false;
 	unsigned int inputmargin = 0;
 
-	if (erofs_sb_has_lz4_0padding()) {
+	if (erofs_sb_has_lz4_0padding(&sbi)) {
 		support_0padding = true;
 
 		while (!src[inputmargin & ~PAGE_MASK])
diff --git a/lib/inode.c b/lib/inode.c
index 6597a26..d1adb49 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -246,16 +246,20 @@ static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
 	memset(buf + q, 0, size - q);
 }
 
-static int write_dirblock(unsigned int q, struct erofs_dentry *head,
-			  struct erofs_dentry *end, erofs_blk_t blkaddr)
+static int write_dirblock(
+	struct erofs_device erofs_dev,
+	unsigned int q, struct erofs_dentry *head,
+	struct erofs_dentry *end, erofs_blk_t blkaddr)
 {
 	char buf[EROFS_BLKSIZ];
 
 	fill_dirblock(buf, EROFS_BLKSIZ, q, head, end);
-	return blk_write(buf, blkaddr, 1);
+	return blk_write(erofs_dev, buf, blkaddr, 1);
 }
 
-static int erofs_write_dir_file(struct erofs_inode *dir)
+static int erofs_write_dir_file(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *dir)
 {
 	struct erofs_dentry *head = list_first_entry(&dir->i_subdirs,
 						     struct erofs_dentry,
@@ -271,7 +275,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 			sizeof(struct erofs_dirent);
 
 		if (used + len > EROFS_BLKSIZ) {
-			ret = write_dirblock(q, head, d,
+			ret = write_dirblock(erofs_dev, q, head, d,
 					     dir->u.i_blkaddr + blkno);
 			if (ret)
 				return ret;
@@ -288,7 +292,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	if (used == EROFS_BLKSIZ) {
 		DBG_BUGON(dir->i_size % EROFS_BLKSIZ);
 		DBG_BUGON(dir->idata_size);
-		return write_dirblock(q, head, d, dir->u.i_blkaddr + blkno);
+		return write_dirblock(erofs_dev, q, head, d, dir->u.i_blkaddr + blkno);
 	}
 	DBG_BUGON(used != dir->i_size % EROFS_BLKSIZ);
 	if (used) {
@@ -302,7 +306,9 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	return 0;
 }
 
-static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
+static int erofs_write_file_from_buffer(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *inode, char *buf)
 {
 	const unsigned int nblocks = erofs_blknr(inode->i_size);
 	int ret;
@@ -314,7 +320,7 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 		return ret;
 
 	if (nblocks)
-		blk_write(buf, inode->u.i_blkaddr, nblocks);
+		blk_write(erofs_dev, buf, inode->u.i_blkaddr, nblocks);
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
@@ -334,7 +340,9 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 	return true;
 }
 
-static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
+static int write_uncompressed_file_from_fd(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *inode, int fd)
 {
 	int ret;
 	unsigned int nblocks, i;
@@ -356,7 +364,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 			return -EAGAIN;
 		}
 
-		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
+		ret = blk_write(erofs_dev, buf, inode->u.i_blkaddr + i, 1);
 		if (ret)
 			return ret;
 	}
@@ -379,7 +387,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-int erofs_write_file(struct erofs_inode *inode)
+int erofs_write_file(struct erofs_device erofs_dev, struct erofs_inode *inode)
 {
 	int ret, fd;
 
@@ -395,7 +403,7 @@ int erofs_write_file(struct erofs_inode *inode)
 	}
 
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode);
+		ret = erofs_write_compressed_file(erofs_dev, inode);
 
 		if (!ret || ret != -ENOSPC)
 			return ret;
@@ -406,12 +414,14 @@ int erofs_write_file(struct erofs_inode *inode)
 	if (fd < 0)
 		return -errno;
 
-	ret = write_uncompressed_file_from_fd(inode, fd);
+	ret = write_uncompressed_file_from_fd(erofs_dev, inode, fd);
 	close(fd);
 	return ret;
 }
 
-static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
+static bool erofs_bh_flush_write_inode(
+	struct erofs_device erofs_dev,
+	struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
 	const u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
@@ -500,7 +510,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		BUG_ON(1);
 	}
 
-	ret = dev_write(&u, off, inode->inode_isize);
+	ret = dev_write(erofs_dev, &u, off, inode->inode_isize);
 	if (ret)
 		return false;
 	off += inode->inode_isize;
@@ -511,7 +521,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (IS_ERR(xattrs))
 			return false;
 
-		ret = dev_write(xattrs, off, inode->xattr_isize);
+		ret = dev_write(erofs_dev, xattrs, off, inode->xattr_isize);
 		free(xattrs);
 		if (ret)
 			return false;
@@ -521,13 +531,13 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 
 	if (inode->extent_isize) {
 		if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
-			ret = erofs_blob_write_chunk_indexes(inode, off);
+			ret = erofs_blob_write_chunk_indexes(erofs_dev, inode, off);
 			if (ret)
 				return false;
 		} else {
 			/* write compression metadata */
 			off = Z_EROFS_VLE_EXTENT_ALIGN(off);
-			ret = dev_write(inode->compressmeta, off,
+			ret = dev_write(erofs_dev, inode->compressmeta, off,
 					inode->extent_isize);
 			if (ret)
 				return false;
@@ -636,13 +646,15 @@ noinline:
 	return 0;
 }
 
-static bool erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
+static bool erofs_bh_flush_write_inline(
+	struct erofs_device erofs_dev,
+	struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = dev_write(inode->idata, off, inode->idata_size);
+	ret = dev_write(erofs_dev, inode->idata, off, inode->idata_size);
 	if (ret)
 		return false;
 
@@ -658,7 +670,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 	.flush = erofs_bh_flush_write_inline,
 };
 
-static int erofs_write_tail_end(struct erofs_inode *inode)
+static int erofs_write_tail_end(struct erofs_device erofs_dev, struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh, *ibh;
 
@@ -681,11 +693,11 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 
 		erofs_mapbh(bh->block);
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
-		ret = dev_write(inode->idata, pos, inode->idata_size);
+		ret = dev_write(erofs_dev, inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
 		if (inode->idata_size < EROFS_BLKSIZ) {
-			ret = dev_fillzero(pos + inode->idata_size,
+			ret = dev_fillzero(erofs_dev, pos + inode->idata_size,
 					   EROFS_BLKSIZ - inode->idata_size,
 					   false);
 			if (ret)
@@ -950,7 +962,8 @@ static void erofs_d_invalidate(struct erofs_dentry *d)
 	erofs_iput(inode);
 }
 
-static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
+static struct erofs_inode *erofs_mkfs_build_tree(
+	struct erofs_device erofs_dev, struct erofs_inode *dir)
 {
 	int ret;
 	DIR *_dir;
@@ -974,18 +987,18 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 				return ERR_PTR(-errno);
 			}
 
-			ret = erofs_write_file_from_buffer(dir, symlink);
+			ret = erofs_write_file_from_buffer(erofs_dev, dir, symlink);
 			free(symlink);
 			if (ret)
 				return ERR_PTR(ret);
 		} else {
-			ret = erofs_write_file(dir);
+			ret = erofs_write_file(erofs_dev, dir);
 			if (ret)
 				return ERR_PTR(ret);
 		}
 
 		erofs_prepare_inode_buffer(dir);
-		erofs_write_tail_end(dir);
+		erofs_write_tail_end(erofs_dev, dir);
 		return dir;
 	}
 
@@ -1060,7 +1073,7 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			goto fail;
 		}
 
-		d->inode = erofs_mkfs_build_tree_from_path(dir, buf);
+		d->inode = erofs_mkfs_build_tree_from_path(erofs_dev, dir, buf);
 		if (IS_ERR(d->inode)) {
 			ret = PTR_ERR(d->inode);
 fail:
@@ -1078,8 +1091,8 @@ fail:
 			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
 			   d->type);
 	}
-	erofs_write_dir_file(dir);
-	erofs_write_tail_end(dir);
+	erofs_write_dir_file(erofs_dev, dir);
+	erofs_write_tail_end(erofs_dev, dir);
 	return dir;
 
 err_closedir:
@@ -1088,8 +1101,10 @@ err:
 	return ERR_PTR(ret);
 }
 
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
-						    const char *path)
+struct erofs_inode *erofs_mkfs_build_tree_from_path(
+	struct erofs_device erofs_dev,
+	struct erofs_inode *parent,
+	const char *path)
 {
 	struct erofs_inode *const inode = erofs_iget_from_path(path, true);
 
@@ -1108,5 +1123,5 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 	else
 		inode->i_parent = inode;	/* rootdir mark */
 
-	return erofs_mkfs_build_tree(inode);
+	return erofs_mkfs_build_tree(erofs_dev, inode);
 }
diff --git a/lib/io.c b/lib/io.c
index cfc062d..2cb4cb2 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -23,10 +23,6 @@
 #define EROFS_MODNAME	"erofs_io"
 #include "erofs/print.h"
 
-static const char *erofs_devname;
-int erofs_devfd = -1;
-static u64 erofs_devsz;
-
 int dev_get_blkdev_size(int fd, u64 *bytes)
 {
 	errno = ENOTSUP;
@@ -47,17 +43,18 @@ int dev_get_blkdev_size(int fd, u64 *bytes)
 	return -errno;
 }
 
-void dev_close(void)
+void dev_close(struct erofs_device *erofs_dev)
 {
-	close(erofs_devfd);
-	erofs_devname = NULL;
-	erofs_devfd   = -1;
-	erofs_devsz   = 0;
+	close(erofs_dev->erofs_devfd);
+	erofs_dev->erofs_devname = NULL;
+	erofs_dev->erofs_devfd   = -1;
+	erofs_dev->erofs_devsz   = 0;
 }
 
-int dev_open(const char *dev)
+int dev_open(const char *dev, struct erofs_device *erofs_dev)
 {
 	struct stat st;
+
 	int fd, ret;
 
 	fd = open(dev, O_RDWR | O_CREAT | O_BINARY, 0644);
@@ -75,13 +72,13 @@ int dev_open(const char *dev)
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFBLK:
-		ret = dev_get_blkdev_size(fd, &erofs_devsz);
+		ret = dev_get_blkdev_size(fd, &erofs_dev->erofs_devsz);
 		if (ret) {
 			erofs_err("failed to get block device size(%s).", dev);
 			close(fd);
 			return ret;
 		}
-		erofs_devsz = round_down(erofs_devsz, EROFS_BLKSIZ);
+		erofs_dev->erofs_devsz = round_down(erofs_dev->erofs_devsz, EROFS_BLKSIZ);
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
@@ -91,7 +88,7 @@ int dev_open(const char *dev)
 			return -errno;
 		}
 		/* INT64_MAX is the limit of kernel vfs */
-		erofs_devsz = INT64_MAX;
+		erofs_dev->erofs_devsz = INT64_MAX;
 		break;
 	default:
 		erofs_err("bad file type (%s, %o).", dev, st.st_mode);
@@ -99,15 +96,15 @@ int dev_open(const char *dev)
 		return -EINVAL;
 	}
 
-	erofs_devname = dev;
-	erofs_devfd = fd;
+	erofs_dev->erofs_devname = dev;
+	erofs_dev->erofs_devfd = fd;
 
 	erofs_info("successfully to open %s", dev);
 	return 0;
 }
 
 /* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
-int dev_open_ro(const char *dev)
+int dev_open_ro(const char *dev, struct erofs_device *erofs_dev)
 {
 	int fd = open(dev, O_RDONLY | O_BINARY);
 
@@ -116,20 +113,23 @@ int dev_open_ro(const char *dev)
 		return -errno;
 	}
 
-	erofs_devfd = fd;
-	erofs_devname = dev;
-	erofs_devsz = INT64_MAX;
+	erofs_dev->erofs_devfd = fd;
+	erofs_dev->erofs_devname = dev;
+	erofs_dev->erofs_devsz = INT64_MAX;
 	return 0;
 }
 
-u64 dev_length(void)
+u64 dev_length(struct erofs_device erofs_dev)
 {
-	return erofs_devsz;
+	return erofs_dev.erofs_devsz;
 }
 
-int dev_write(const void *buf, u64 offset, size_t len)
+int dev_write_fd(const struct erofs_device dev, const void *buf, u64 offset, size_t len)
 {
 	int ret;
+	const int erofs_devfd = dev.erofs_devfd;
+	const u64 erofs_devsz = dev.erofs_devsz;
+	const char *const erofs_devname = dev.erofs_devname;
 
 	if (cfg.c_dry_run)
 		return 0;
@@ -165,7 +165,12 @@ int dev_write(const void *buf, u64 offset, size_t len)
 	return 0;
 }
 
-int dev_fillzero(u64 offset, size_t len, bool padding)
+int dev_write(struct erofs_device erofs_dev, const void *buf, u64 offset, size_t len)
+{
+	return dev_write_fd(erofs_dev, buf, offset, len);
+}
+
+int dev_fillzero(struct erofs_device erofs_dev, u64 offset, size_t len, bool padding)
 {
 	static const char zero[EROFS_BLKSIZ] = {0};
 	int ret;
@@ -174,23 +179,24 @@ int dev_fillzero(u64 offset, size_t len, bool padding)
 		return 0;
 
 #if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
-	if (!padding && fallocate(erofs_devfd, FALLOC_FL_PUNCH_HOLE |
+	if (!padding && fallocate(erofs_dev.erofs_devfd, FALLOC_FL_PUNCH_HOLE |
 				  FALLOC_FL_KEEP_SIZE, offset, len) >= 0)
 		return 0;
 #endif
 	while (len > EROFS_BLKSIZ) {
-		ret = dev_write(zero, offset, EROFS_BLKSIZ);
+		ret = dev_write(erofs_dev, zero, offset, EROFS_BLKSIZ);
 		if (ret)
 			return ret;
 		len -= EROFS_BLKSIZ;
 		offset += EROFS_BLKSIZ;
 	}
-	return dev_write(zero, offset, len);
+	return dev_write(erofs_dev, zero, offset, len);
 }
 
-int dev_fsync(void)
+int dev_fsync(struct erofs_device erofs_dev)
 {
 	int ret;
+	const int erofs_devfd = erofs_dev.erofs_devfd;
 
 	ret = fsync(erofs_devfd);
 	if (ret) {
@@ -200,12 +206,13 @@ int dev_fsync(void)
 	return 0;
 }
 
-int dev_resize(unsigned int blocks)
+int dev_resize(struct erofs_device erofs_dev, unsigned int blocks)
 {
 	int ret;
 	struct stat st;
 	u64 length;
-
+	const int erofs_devfd = erofs_dev.erofs_devfd;
+	const u64 erofs_devsz = erofs_dev.erofs_devsz;
 	if (cfg.c_dry_run || erofs_devsz != INT64_MAX)
 		return 0;
 
@@ -226,12 +233,15 @@ int dev_resize(unsigned int blocks)
 	if (fallocate(erofs_devfd, 0, st.st_size, length) >= 0)
 		return 0;
 #endif
-	return dev_fillzero(st.st_size, length, true);
+	return dev_fillzero(erofs_dev, st.st_size, length, true);
 }
 
-int dev_read(void *buf, u64 offset, size_t len)
+int dev_read(const struct erofs_device dev, void *buf, u64 offset, size_t len)
 {
 	int ret;
+	const int erofs_devfd = dev.erofs_devfd;
+	const u64 erofs_devsz = dev.erofs_devsz;
+	const char * const erofs_devname = dev.erofs_devname;
 
 	if (cfg.c_dry_run)
 		return 0;
@@ -350,6 +360,6 @@ out:
 		*off_out = off64_out;
 		return ret;
 	}
-#endif
+#endif // LIB_IO_H_
 	return __erofs_copy_file_range(fd_in, off_in, fd_out, off_out, length);
 }
diff --git a/lib/namei.c b/lib/namei.c
index 56f199a..57041f5 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -22,7 +22,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-int erofs_read_inode_from_disk(struct erofs_inode *vi)
+int erofs_read_inode_from_disk(struct erofs_device fd, struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[sizeof(struct erofs_inode_extended)];
@@ -30,7 +30,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	struct erofs_inode_extended *die;
 	const erofs_off_t inode_loc = iloc(vi->nid);
 
-	ret = dev_read(buf, inode_loc, sizeof(*dic));
+	ret = dev_read(fd, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
 		return -EIO;
 
@@ -47,7 +47,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
-		ret = dev_read(buf + sizeof(*dic), inode_loc + sizeof(*dic),
+		ret = dev_read(fd, buf + sizeof(*dic), inode_loc + sizeof(*dic),
 			       sizeof(*die) - sizeof(*dic));
 		if (ret < 0)
 			return -EIO;
@@ -187,7 +187,7 @@ struct nameidata {
 	unsigned int	ftype;
 };
 
-int erofs_namei(struct nameidata *nd,
+int erofs_namei(struct erofs_device fd, struct nameidata *nd,
 		const char *name, unsigned int len)
 {
 	erofs_nid_t nid = nd->nid;
@@ -196,7 +196,7 @@ int erofs_namei(struct nameidata *nd,
 	struct erofs_inode vi = { .nid = nid };
 	erofs_off_t offset;
 
-	ret = erofs_read_inode_from_disk(&vi);
+	ret = erofs_read_inode_from_disk(fd, &vi);
 	if (ret)
 		return ret;
 
@@ -207,7 +207,7 @@ int erofs_namei(struct nameidata *nd,
 		struct erofs_dirent *de = (void *)buf;
 		unsigned int nameoff;
 
-		ret = erofs_pread(&vi, buf, maxsize, offset);
+		ret = erofs_pread(fd, &vi, buf, maxsize, offset);
 		if (ret)
 			return ret;
 
@@ -233,7 +233,7 @@ int erofs_namei(struct nameidata *nd,
 	return -ENOENT;
 }
 
-static int link_path_walk(const char *name, struct nameidata *nd)
+static int link_path_walk(struct erofs_device devfd, const char *name, struct nameidata *nd)
 {
 	nd->nid = sbi.root_nid;
 
@@ -250,7 +250,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		} while (*p != '\0' && *p != '/');
 
 		DBG_BUGON(p <= name);
-		ret = erofs_namei(nd, name, p - name);
+		ret = erofs_namei(devfd, nd, name, p - name);
 		if (ret)
 			return ret;
 
@@ -262,15 +262,15 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	return 0;
 }
 
-int erofs_ilookup(const char *path, struct erofs_inode *vi)
+int erofs_ilookup(struct erofs_device devfd, const char *path, struct erofs_inode *vi)
 {
 	int ret;
 	struct nameidata nd;
 
-	ret = link_path_walk(path, &nd);
+	ret = link_path_walk(devfd, path, &nd);
 	if (ret)
 		return ret;
 
 	vi->nid = nd.nid;
-	return erofs_read_inode_from_disk(vi);
+	return erofs_read_inode_from_disk(devfd, vi);
 }
diff --git a/lib/super.c b/lib/super.c
index 0c30403..9cb5768 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -23,14 +23,14 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 	return true;
 }
 
-int erofs_read_superblock(void)
+int erofs_read_superblock(struct erofs_device devfd, struct erofs_sb_info *sbi)
 {
 	char data[EROFS_BLKSIZ];
 	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	int ret;
 
-	ret = blk_read(data, 0, 1);
+	ret = blk_read(devfd, data, 0, 1);
 	if (ret < 0) {
 		erofs_err("cannot read erofs superblock: %d", ret);
 		return -EIO;
@@ -43,7 +43,7 @@ int erofs_read_superblock(void)
 		return ret;
 	}
 
-	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
@@ -53,20 +53,20 @@ int erofs_read_superblock(void)
 		return ret;
 	}
 
-	if (!check_layout_compatibility(&sbi, dsb))
+	if (!check_layout_compatibility(sbi, dsb))
 		return ret;
 
-	sbi.blocks = le32_to_cpu(dsb->blocks);
-	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
-	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
-	sbi.islotbits = EROFS_ISLOTBITS;
-	sbi.root_nid = le16_to_cpu(dsb->root_nid);
-	sbi.inos = le64_to_cpu(dsb->inos);
-	sbi.checksum = le32_to_cpu(dsb->checksum);
+	sbi->blocks = le32_to_cpu(dsb->blocks);
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
+	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
 	return 0;
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index 196133a..9f16664 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -547,10 +547,12 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 	shared_xattrs_size = shared_xattrs_count = 0;
 }
 
-static bool erofs_bh_flush_write_shared_xattrs(struct erofs_buffer_head *bh)
+static bool erofs_bh_flush_write_shared_xattrs(
+	struct erofs_device erofs_dev,
+	struct erofs_buffer_head *bh)
 {
 	void *buf = bh->fsprivate;
-	int err = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
+	int err = dev_write(erofs_dev, buf, erofs_btell(bh, false), shared_xattrs_size);
 
 	if (err)
 		return false;
diff --git a/lib/zmap.c b/lib/zmap.c
index 7dbda87..69fef80 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -12,7 +12,7 @@
 
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
-	if (!erofs_sb_has_big_pcluster() &&
+	if (!erofs_sb_has_big_pcluster(&sbi) &&
 	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
@@ -24,7 +24,7 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
+static int z_erofs_fill_inode_lazy(struct erofs_device erofs_dev, struct erofs_inode *vi)
 {
 	int ret;
 	erofs_off_t pos;
@@ -34,11 +34,11 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
-	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
+	DBG_BUGON(!erofs_sb_has_big_pcluster(&sbi) &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
-	ret = dev_read(buf, pos, sizeof(buf));
+	ret = dev_read(erofs_dev, buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -78,7 +78,9 @@ struct z_erofs_maprecorder {
 	erofs_blk_t pblk, compressedlcs;
 };
 
-static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
+static int z_erofs_reload_indexes(
+	struct erofs_device erofs_dev,
+	struct z_erofs_maprecorder *m,
 				  erofs_blk_t eblk)
 {
 	int ret;
@@ -88,7 +90,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	if (map->index == eblk)
 		return 0;
 
-	ret = blk_read(mpage, eblk, 1);
+	ret = blk_read(erofs_dev, mpage, eblk, 1);
 	if (ret < 0)
 		return -EIO;
 
@@ -97,8 +99,10 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					 unsigned long lcn)
+static int legacy_load_cluster_from_disk(
+	struct erofs_device erofs_dev,
+	struct z_erofs_maprecorder *m,
+	unsigned long lcn)
 {
 	struct erofs_inode *const vi = m->inode;
 	const erofs_off_t ibase = iloc(vi->nid);
@@ -110,7 +114,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int advise, type;
 	int err;
 
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	err = z_erofs_reload_indexes(erofs_dev, m, erofs_blknr(pos));
 	if (err)
 		return err;
 
@@ -289,8 +293,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					    unsigned long lcn, bool lookahead)
+static int compacted_load_cluster_from_disk(
+	struct erofs_device erofs_dev,
+	struct z_erofs_maprecorder *m,
+	unsigned long lcn, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
@@ -337,28 +343,32 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	amortizedshift = 2;
 out:
 	pos += lcn * (1 << amortizedshift);
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	err = z_erofs_reload_indexes(erofs_dev, m, erofs_blknr(pos));
 	if (err)
 		return err;
 	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
 				      lookahead);
 }
 
-static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+static int z_erofs_load_cluster_from_disk(
+	struct erofs_device erofs_dev,
+	struct z_erofs_maprecorder *m,
 					  unsigned int lcn, bool lookahead)
 {
 	const unsigned int datamode = m->inode->datalayout;
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
-		return legacy_load_cluster_from_disk(m, lcn);
+		return legacy_load_cluster_from_disk(erofs_dev, m, lcn);
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
-		return compacted_load_cluster_from_disk(m, lcn, lookahead);
+		return compacted_load_cluster_from_disk(erofs_dev, m, lcn, lookahead);
 
 	return -EINVAL;
 }
 
-static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
+static int z_erofs_extent_lookback(
+	struct erofs_device erofs_dev,
+	struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
 	struct erofs_inode *const vi = m->inode;
@@ -376,7 +386,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 
 	/* load extent head logical cluster if needed */
 	lcn -= lookback_distance;
-	err = z_erofs_load_cluster_from_disk(m, lcn, false);
+	err = z_erofs_load_cluster_from_disk(erofs_dev, m, lcn, false);
 	if (err)
 		return err;
 
@@ -388,7 +398,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
-		return z_erofs_extent_lookback(m, m->delta[0]);
+		return z_erofs_extent_lookback(erofs_dev, m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		map->m_flags &= ~EROFS_MAP_ZIPPED;
 		/* fallthrough */
@@ -404,8 +414,10 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
-					    unsigned int initial_lcn)
+static int z_erofs_get_extent_compressedlen(
+	struct erofs_device erofs_dev,
+	struct z_erofs_maprecorder *m,
+	unsigned int initial_lcn)
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_map_blocks *const map = m->map;
@@ -425,7 +437,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if (m->compressedlcs)
 		goto out;
 
-	err = z_erofs_load_cluster_from_disk(m, lcn, false);
+	err = z_erofs_load_cluster_from_disk(erofs_dev, m, lcn, false);
 	if (err)
 		return err;
 
@@ -471,7 +483,9 @@ err_bonus_cblkcnt:
 	return -EFSCORRUPTED;
 }
 
-static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
+static int z_erofs_get_extent_decompressedlen(
+	struct erofs_device erofs_dev,
+	struct z_erofs_maprecorder *m)
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_map_blocks *map = m->map;
@@ -486,7 +500,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return 0;
 		}
 
-		err = z_erofs_load_cluster_from_disk(m, lcn, true);
+		err = z_erofs_load_cluster_from_disk(erofs_dev, m, lcn, true);
 		if (err)
 			return err;
 
@@ -513,7 +527,9 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	return 0;
 }
 
-int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+int z_erofs_map_blocks_iter(
+					struct erofs_device erofs_dev,
+					struct erofs_inode *vi,
 			    struct erofs_map_blocks *map,
 			    int flags)
 {
@@ -535,7 +551,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 		goto out;
 	}
 
-	err = z_erofs_fill_inode_lazy(vi);
+	err = z_erofs_fill_inode_lazy(erofs_dev, vi);
 	if (err)
 		goto out;
 
@@ -544,7 +560,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
+	err = z_erofs_load_cluster_from_disk(erofs_dev, &m, initial_lcn, false);
 	if (err)
 		goto out;
 
@@ -573,7 +589,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
-		err = z_erofs_extent_lookback(&m, m.delta[0]);
+		err = z_erofs_extent_lookback(erofs_dev, &m, m.delta[0]);
 		if (err)
 			goto out;
 		break;
@@ -588,12 +604,12 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	map->m_pa = blknr_to_addr(m.pblk);
 	map->m_flags |= EROFS_MAP_MAPPED;
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	err = z_erofs_get_extent_compressedlen(erofs_dev, &m, initial_lcn);
 	if (err)
 		goto out;
 
 	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
-		err = z_erofs_get_extent_decompressedlen(&m);
+		err = z_erofs_get_extent_decompressedlen(erofs_dev, &m);
 		if (!err)
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 4ea5467..16f8060 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -164,7 +164,7 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			erofs_sb_clear_sb_chksum();
+			erofs_sb_clear_sb_chksum(&sbi);
 		}
 
 		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
@@ -259,7 +259,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 
 		case 4:
-			opt = erofs_selabel_open(optarg);
+			opt = erofs_global_selabel_open(optarg);
 			if (opt && opt != -EBUSY)
 				return opt;
 			break;
@@ -343,7 +343,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  optarg);
 				return -EINVAL;
 			}
-			erofs_sb_set_chunked_file();
+			erofs_sb_set_chunked_file(&sbi);
 			break;
 		case 12:
 			quiet = true;
@@ -411,7 +411,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	sb.root_nid     = cpu_to_le16(root_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
 
-	if (erofs_sb_has_compr_cfgs())
+	if (erofs_sb_has_compr_cfgs(&sbi))
 		sb.u1.available_compr_algs = sbi.available_compr_algs;
 	else
 		sb.u1.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance);
@@ -429,14 +429,14 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	return 0;
 }
 
-static int erofs_mkfs_superblock_csum_set(void)
+static int erofs_mkfs_superblock_csum_set(struct erofs_device erofs_dev)
 {
 	int ret;
 	u8 buf[EROFS_BLKSIZ];
 	u32 crc;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(buf, 0, 1);
+	ret = blk_read(erofs_dev, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
@@ -462,7 +462,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(crc);
 
-	ret = blk_write(buf, 0, 1);
+	ret = blk_write(erofs_dev, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to write checksummed superblock: %s",
 			  erofs_strerror(ret));
@@ -530,8 +530,9 @@ int main(int argc, char **argv)
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37] = "not available";
+	struct erofs_device erofs_dev;
 
-	erofs_init_configure();
+	erofs_init_global_configure();
 	erofs_mkfs_default_options();
 
 	err = mkfs_parse_options_cfg(argc, argv);
@@ -572,7 +573,7 @@ int main(int argc, char **argv)
 		sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = dev_open(cfg.c_img_path);
+	err = dev_open(cfg.c_img_path, &erofs_dev);
 	if (err) {
 		usage();
 		return 1;
@@ -591,7 +592,7 @@ int main(int argc, char **argv)
 	}
 #endif
 	erofs_show_config();
-	if (erofs_sb_has_chunked_file())
+	if (erofs_sb_has_chunked_file(&sbi))
 		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
 	erofs_set_fs_root(cfg.c_src_path);
 #ifndef NDEBUG
@@ -619,7 +620,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = z_erofs_compress_init(sb_bh);
+	err = z_erofs_compress_init(erofs_dev, sb_bh);
 	if (err) {
 		erofs_err("Failed to initialize compressor: %s",
 			  erofs_strerror(err));
@@ -640,7 +641,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	root_inode = erofs_mkfs_build_tree_from_path(NULL, cfg.c_src_path);
+	root_inode = erofs_mkfs_build_tree_from_path(erofs_dev, NULL, cfg.c_src_path);
 	if (IS_ERR(root_inode)) {
 		err = PTR_ERR(root_inode);
 		goto exit;
@@ -651,7 +652,7 @@ int main(int argc, char **argv)
 
 	if (cfg.c_chunkbits) {
 		erofs_info("total metadata: %u blocks", erofs_mapbh(NULL));
-		err = erofs_blob_remap();
+		err = erofs_blob_remap(erofs_dev);
 		if (err)
 			goto exit;
 	}
@@ -661,24 +662,24 @@ int main(int argc, char **argv)
 		goto exit;
 
 	/* flush all remaining buffers */
-	if (!erofs_bflush(NULL))
+	if (!erofs_bflush(erofs_dev, NULL))
 		err = -EIO;
 	else
-		err = dev_resize(nblocks);
+		err = dev_resize(erofs_dev, nblocks);
 
-	if (!err && erofs_sb_has_sb_chksum())
-		err = erofs_mkfs_superblock_csum_set();
+	if (!err && erofs_sb_has_sb_chksum(&sbi))
+		err = erofs_mkfs_superblock_csum_set(erofs_dev);
 exit:
 	z_erofs_compress_exit();
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
 #endif
-	dev_close();
+	dev_close(&erofs_dev);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
-	erofs_exit_configure();
+	erofs_exit_global_configure();
 
 	if (err) {
 		erofs_err("\tCould not format the device : %s\n",
-- 
2.34.0.rc2.393.gf8c9666880-goog

