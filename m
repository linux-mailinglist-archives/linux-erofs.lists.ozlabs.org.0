Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7C45820B
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 06:40:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HxfPY37rPz301j
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Nov 2021 16:40:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637473217;
	bh=BzMKksSla38r437GgFvxUThT6keX+c1amNnJtPNBZUg=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=f4KcB60KrnwUoSapoMB+4ARTWg6tZpmYhBNN31sv2l+ZYXOHNS6WZbBXVw40cXymN
	 eujwEJedpkGKhmpNXMEv7aR3B/uRl0S/AJ1dH8cSt8eP5W8LTb+SIVMaGnlzxZ5TVi
	 pxvD9E62oOR27hQxQRR8yRkld3EOrA0nMKwTzh5Xrk7ag3Xye26fBq3IimHHgT3CqP
	 etoZZ5GlkXxJl0lIAHDL01mM7663nNA1laUKkCllXTJcGTMLGkwjK6IHV+tNFUnjP4
	 PZxUl0oGRYSst5CGroQp4ICwsB5t509VCwlR4PX3tOKfpYzKdu0NabKzgQOsWkqhgY
	 XF3N2UCMZHjGA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::f49; helo=mail-qv1-xf49.google.com;
 envelope-from=3utuzyqskc-smunatxryivatbbtyr.pbzyvahk-rebsfyvfgf.bmynof.bet@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=U7mNtg2d; dkim-atps=neutral
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com
 [IPv6:2607:f8b0:4864:20::f49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HxfPS74DSz2xv8
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Nov 2021 16:40:12 +1100 (AEDT)
Received: by mail-qv1-xf49.google.com with SMTP id
 n4-20020a0ce944000000b003bdcabf4cdfso13183199qvo.16
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 21:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=BzMKksSla38r437GgFvxUThT6keX+c1amNnJtPNBZUg=;
 b=Sz0iZQbdzEMPLhHfhkwyH+Aqt8f/U1cs20GJUI6Kt8UsRLdOBCUjs+cbLEtEt8ODkh
 nTftMQBuf7naCD+nbNzEguT8eCQZmFjklD8+1WWOM5IeNVG8liA0O2jbzJguVG5S7mbq
 uDYg7dVaTI9t1PsE9uPV+UFdUAKxTmccqLGLcc9OnmRUsDmShAzV3oFYK/j/SUM5ii6T
 VrF6uSYER8YwOWLJ4DjAJb9KA7xg/CFVJwWHNLAnnf9CA+zPvCYGbHQqepkfvA6yY48F
 gG+6t51G6QPc+d+HZBBbK9LoQBzSOgyeF+g/aa4REF2pMv4F7Q41lcrYncZtDbOcD4O1
 R9tw==
X-Gm-Message-State: AOAM5307Fpi/yp5FicsE/izaJ+GI7Hx/vdShFsMxaZLV2iVHFIA9uZbw
 3sPa1puaa7WAo0sfZKnP6YcnIlnZEmjlJMe3v5mfVhB9tbYJ3EV8MHKlOsc2AYq4Cn1q6U0M1Dk
 1bY35mEKHql0wPycvhEeZw7JYMD/yfcq39jluC/3UJuT08gcpvkBozRZCZQ9cSxWRXCykd+Zcu+
 K2UB4GKqs=
X-Google-Smtp-Source: ABdhPJwS46uT9xmnyIvr/KaSbH9u6owbLPCv4ujI9IGJiiP0zk9a4L/dhFa2nmXYYsxSVnY7XG+qMAjeLwmHurbnjA==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ac8:7d01:: with SMTP id
 g1mr20779165qtb.175.1637473210814; Sat, 20 Nov 2021 21:40:10 -0800 (PST)
Date: Sat, 20 Nov 2021 21:39:20 -0800
In-Reply-To: <20211121053920.2580751-1-zhangkelvin@google.com>
Message-Id: <20211121053920.2580751-4-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211121053920.2580751-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v1 3/4] Make super block info struct a paramater instead of
 globals
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


Test: mkfs.erofs on system.img of
    aosp_cf_x86_64_phone-target_files-7731383.zip
    Make sure output is the same before/after this patch

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c                | 67 +++++++++++++++++++------------
 fsck/main.c                | 61 +++++++++++++++++++----------
 fuse/dir.c                 |  5 ++-
 fuse/main.c                |  7 ++--
 include/erofs/compress.h   |  2 +
 include/erofs/decompress.h |  5 ++-
 include/erofs/inode.h      |  3 +-
 include/erofs/internal.h   | 26 ++++++++-----
 include/erofs/xattr.h      |  2 +-
 lib/compress.c             | 80 +++++++++++++++++++++++---------------
 lib/compressor.c           |  7 +++-
 lib/compressor.h           |  5 ++-
 lib/compressor_lz4.c       |  6 ++-
 lib/compressor_lz4hc.c     |  4 +-
 lib/config.c               |  1 -
 lib/data.c                 | 36 ++++++++++-------
 lib/decompress.c           | 12 +++---
 lib/inode.c                | 60 ++++++++++++++++------------
 lib/namei.c                | 40 ++++++++++++-------
 lib/xattr.c                |  4 +-
 lib/zmap.c                 | 46 +++++++++++++---------
 mkfs/main.c                | 63 ++++++++++++++++--------------
 22 files changed, 332 insertions(+), 210 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 8d0dbd0..0ac97a0 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -85,7 +85,10 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 };
 
-static int erofs_read_dir(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t parent_nid);
+static int erofs_read_dir(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	erofs_nid_t nid, erofs_nid_t parent_nid);
 static inline int erofs_checkdirent(struct erofs_dirent *de,
 		struct erofs_dirent *last_de,
 		u32 maxsize, const char *dname);
@@ -258,7 +261,9 @@ static inline int erofs_checkdirent(struct erofs_dirent *de,
 }
 
 static int erofs_read_dirent(
-		struct erofs_device erofs_dev, struct erofs_dirent *de,
+		struct erofs_device erofs_dev,
+		struct erofs_sb_info *sbi,
+		struct erofs_dirent *de,
 		erofs_nid_t nid, erofs_nid_t parent_nid,
 		const char *dname)
 {
@@ -268,7 +273,7 @@ static int erofs_read_dirent(
 
 	stats.files++;
 	stats.file_category_stat[de->file_type]++;
-	err = erofs_read_inode_from_disk(erofs_dev, &inode);
+	err = erofs_read_inode_from_disk(erofs_dev, sbi, &inode);
 	if (err) {
 		erofs_err("read file inode from disk failed!");
 		return err;
@@ -289,7 +294,7 @@ static int erofs_read_dirent(
 
 	if ((de->file_type == EROFS_FT_DIR)
 			&& de->nid != nid && de->nid != parent_nid) {
-		err = erofs_read_dir(erofs_dev, de->nid, nid);
+		err = erofs_read_dir(erofs_dev, sbi, de->nid, nid);
 		if (err) {
 			erofs_err("parse dir nid %llu error occurred\n",
 					de->nid);
@@ -299,14 +304,17 @@ static int erofs_read_dirent(
 	return 0;
 }
 
-static int erofs_read_dir(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t parent_nid)
+static int erofs_read_dir(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	erofs_nid_t nid, erofs_nid_t parent_nid)
 {
 	int err;
 	erofs_off_t offset;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_inode vi = { .nid = nid };
 
-	err = erofs_read_inode_from_disk(fd, &vi);
+	err = erofs_read_inode_from_disk(fd, sbi, &vi);
 	if (err)
 		return err;
 
@@ -318,7 +326,7 @@ static int erofs_read_dir(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t p
 		struct erofs_dirent *end;
 		unsigned int nameoff;
 
-		err = erofs_pread(fd, &vi, buf, maxsize, offset);
+		err = erofs_pread(fd, sbi, &vi, buf, maxsize, offset);
 		if (err)
 			return err;
 
@@ -338,7 +346,7 @@ static int erofs_read_dir(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t p
 			ret = erofs_checkdirent(de, end, maxsize, dname);
 			if (ret < 0)
 				return ret;
-			ret = erofs_read_dirent(fd, de, nid, parent_nid, dname);
+			ret = erofs_read_dirent(fd, sbi, de, nid, parent_nid, dname);
 			if (ret < 0)
 				return ret;
 			++de;
@@ -348,7 +356,10 @@ static int erofs_read_dir(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t p
 	return 0;
 }
 
-static int erofs_get_pathname(struct erofs_device fd, erofs_nid_t nid, erofs_nid_t parent_nid,
+static int erofs_get_pathname(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	erofs_nid_t nid, erofs_nid_t parent_nid,
 		erofs_nid_t target, char *path, unsigned int pos)
 {
 	int err;
@@ -357,10 +368,10 @@ static int erofs_get_pathname(struct erofs_device fd, erofs_nid_t nid, erofs_nid
 	struct erofs_inode inode = { .nid = nid };
 
 	path[pos++] = '/';
-	if (target == sbi.root_nid)
+	if (target == sbi->root_nid)
 		return 0;
 
-	err = erofs_read_inode_from_disk(fd, &inode);
+	err = erofs_read_inode_from_disk(fd, sbi, &inode);
 	if (err) {
 		erofs_err("read inode failed @ nid %llu", nid | 0ULL);
 		return err;
@@ -374,7 +385,7 @@ static int erofs_get_pathname(struct erofs_device fd, erofs_nid_t nid, erofs_nid
 		struct erofs_dirent *end;
 		unsigned int nameoff;
 
-		err = erofs_pread(fd, &inode, buf, maxsize, offset);
+		err = erofs_pread(fd, sbi, &inode, buf, maxsize, offset);
 		if (err)
 			return err;
 
@@ -400,7 +411,7 @@ static int erofs_get_pathname(struct erofs_device fd, erofs_nid_t nid, erofs_nid
 					de->nid != parent_nid &&
 					de->nid != nid) {
 				memcpy(path + pos, dname, len);
-				err = erofs_get_pathname(fd, de->nid, nid,
+				err = erofs_get_pathname(fd, sbi, de->nid, nid,
 						target, path, pos + len);
 				if (!err)
 					return 0;
@@ -415,16 +426,19 @@ static int erofs_get_pathname(struct erofs_device fd, erofs_nid_t nid, erofs_nid
 
 static int erofsdump_map_blocks(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct erofs_inode *inode,
 	struct erofs_map_blocks *map,
 	int flags)
 {
 	if (erofs_inode_is_data_compressed(inode->datalayout))
-		return z_erofs_map_blocks_iter(erofs_dev, inode, map, flags);
-	return erofs_map_blocks(erofs_dev, inode, map, flags);
+		return z_erofs_map_blocks_iter(erofs_dev, sbi, inode, map, flags);
+	return erofs_map_blocks(erofs_dev, sbi, inode, map, flags);
 }
 
-static void erofsdump_show_fileinfo(struct erofs_device fd, bool show_extent)
+static void erofsdump_show_fileinfo(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi, bool show_extent)
 {
 	int err, i;
 	erofs_off_t size;
@@ -439,7 +453,7 @@ static void erofsdump_show_fileinfo(struct erofs_device fd, bool show_extent)
 		.m_la = 0,
 	};
 
-	err = erofs_read_inode_from_disk(fd, &inode);
+	err = erofs_read_inode_from_disk(fd, sbi, &inode);
 	if (err) {
 		erofs_err("read inode failed @ nid %llu", inode.nid | 0ULL);
 		return;
@@ -451,7 +465,7 @@ static void erofsdump_show_fileinfo(struct erofs_device fd, bool show_extent)
 		return;
 	}
 
-	err = erofs_get_pathname(fd, sbi.root_nid, sbi.root_nid,
+	err = erofs_get_pathname(fd, sbi, sbi->root_nid, sbi->root_nid,
 				 inode.nid, path, 0);
 	if (err < 0) {
 		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
@@ -484,7 +498,7 @@ static void erofsdump_show_fileinfo(struct erofs_device fd, bool show_extent)
 
 	fprintf(stdout, "\n Ext:   logical offset   |  length :     physical offset    |  length \n");
 	while (map.m_la < inode.i_size) {
-		err = erofsdump_map_blocks(fd, &inode, &map,
+		err = erofsdump_map_blocks(fd, sbi, &inode, &map,
 				EROFS_GET_BLOCKS_FIEMAP);
 		if (err) {
 			erofs_err("get file blocks range failed");
@@ -584,11 +598,13 @@ static void erofsdump_file_statistic(void)
 			stats.compress_rate);
 }
 
-static void erofsdump_print_statistic(struct erofs_device fd)
+static void erofsdump_print_statistic(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi)
 {
 	int err;
 
-	err = erofs_read_dir(fd, sbi.root_nid, sbi.root_nid);
+	err = erofs_read_dir(fd, sbi, sbi->root_nid, sbi->root_nid);
 	if (err) {
 		erofs_err("read dir failed");
 		return;
@@ -604,7 +620,7 @@ static void erofsdump_print_statistic(struct erofs_device fd)
 	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
 }
 
-static void erofsdump_show_superblock(void)
+static void erofsdump_show_superblock(struct erofs_sb_info sbi)
 {
 	time_t time = sbi.build_time;
 	char uuid_str[37] = "not available";
@@ -643,6 +659,7 @@ int main(int argc, char **argv)
 {
 	int err;
 	struct erofs_device erofs_dev;
+	struct erofs_sb_info sbi;
 
 	erofs_init_global_configure();
 	err = erofsdump_parse_options_cfg(argc, argv);
@@ -669,10 +686,10 @@ int main(int argc, char **argv)
 		dumpcfg.totalshow = 1;
 	}
 	if (dumpcfg.show_superblock)
-		erofsdump_show_superblock();
+		erofsdump_show_superblock(sbi);
 
 	if (dumpcfg.show_statistics)
-		erofsdump_print_statistic(erofs_dev);
+		erofsdump_print_statistic(erofs_dev, &sbi);
 
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
@@ -680,7 +697,7 @@ int main(int argc, char **argv)
 	}
 
 	if (dumpcfg.show_inode)
-		erofsdump_show_fileinfo(erofs_dev, dumpcfg.show_extent);
+		erofsdump_show_fileinfo(erofs_dev, &sbi, dumpcfg.show_extent);
 
 exit:
 	erofs_exit_global_configure();
diff --git a/fsck/main.c b/fsck/main.c
index b69333b..d6ce1a4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -11,7 +11,10 @@
 #include "erofs/io.h"
 #include "erofs/decompress.h"
 
-static void erofs_check_inode(struct erofs_device devfd, erofs_nid_t pnid, erofs_nid_t nid);
+static void erofs_check_inode(
+	struct erofs_device devfd,
+	struct erofs_sb_info *sbi,
+	erofs_nid_t pnid, erofs_nid_t nid);
 
 struct erofsfsck_cfg {
 	bool corrupted;
@@ -138,7 +141,10 @@ static bool check_special_dentry(struct erofs_dirent *de,
 	return true;
 }
 
-static int traverse_dirents(struct erofs_device devfd, erofs_nid_t pnid, erofs_nid_t nid,
+static int traverse_dirents(
+	struct erofs_device devfd,
+	struct erofs_sb_info *sbi,
+	erofs_nid_t pnid, erofs_nid_t nid,
 			    void *dentry_blk, erofs_blk_t block,
 			    unsigned int next_nameoff, unsigned int maxsize)
 {
@@ -212,7 +218,7 @@ static int traverse_dirents(struct erofs_device devfd, erofs_nid_t pnid, erofs_n
 				goto out;
 			}
 		} else {
-			erofs_check_inode(devfd, nid, de->nid);
+			erofs_check_inode(devfd, sbi, nid, de->nid);
 		}
 
 		if (fsckcfg.corrupted) {
@@ -236,7 +242,9 @@ out:
 }
 
 static int verify_uncompressed_inode(
-	struct erofs_device erofs_dev, struct erofs_inode *inode)
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
@@ -247,7 +255,7 @@ static int verify_uncompressed_inode(
 
 	while (ptr < inode->i_size) {
 		map.m_la = ptr;
-		ret = erofs_map_blocks(erofs_dev, inode, &map, 0);
+		ret = erofs_map_blocks(erofs_dev, sbi, inode, &map, 0);
 		if (ret)
 			return ret;
 
@@ -274,7 +282,10 @@ static int verify_uncompressed_inode(
 	return 0;
 }
 
-static int verify_compressed_inode(struct erofs_device erofs_dev, struct erofs_inode *inode)
+static int verify_compressed_inode(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
@@ -288,7 +299,7 @@ static int verify_compressed_inode(struct erofs_device erofs_dev, struct erofs_i
 	while (end > 0) {
 		map.m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(erofs_dev, inode, &map, 0);
+		ret = z_erofs_map_blocks_iter(erofs_dev, sbi, inode, &map, 0);
 		if (ret)
 			goto out;
 
@@ -336,7 +347,7 @@ static int verify_compressed_inode(struct erofs_device erofs_dev, struct erofs_i
 					.decodedlength = map.m_llen,
 					.alg = algorithmformat,
 					.partial_decoding = 0
-					 });
+					 }, sbi);
 
 		if (ret < 0) {
 			erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
@@ -359,7 +370,10 @@ out:
 	return ret < 0 ? ret : 0;
 }
 
-static int erofs_verify_xattr(struct erofs_device erofs_dev, struct erofs_inode *inode)
+static int erofs_verify_xattr(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode)
 {
 	unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
 	unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
@@ -384,7 +398,7 @@ static int erofs_verify_xattr(struct erofs_device erofs_dev, struct erofs_inode
 		}
 	}
 
-	addr = iloc(inode->nid) + inode->inode_isize;
+	addr = iloc(sbi, inode->nid) + inode->inode_isize;
 	ret = dev_read(erofs_dev, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
@@ -437,7 +451,10 @@ out:
 	return ret;
 }
 
-static int erofs_verify_inode_data(struct erofs_device erofs_dev, struct erofs_inode *inode)
+static int erofs_verify_inode_data(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode)
 {
 	int ret;
 
@@ -448,11 +465,11 @@ static int erofs_verify_inode_data(struct erofs_device erofs_dev, struct erofs_i
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
-		ret = verify_uncompressed_inode(erofs_dev, inode);
+		ret = verify_uncompressed_inode(erofs_dev, sbi, inode);
 		break;
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		ret = verify_compressed_inode(erofs_dev, inode);
+		ret = verify_compressed_inode(erofs_dev, sbi, inode);
 		break;
 	default:
 		ret = -EINVAL;
@@ -466,7 +483,10 @@ static int erofs_verify_inode_data(struct erofs_device erofs_dev, struct erofs_i
 	return ret;
 }
 
-static void erofs_check_inode(struct erofs_device erofs_dev, erofs_nid_t pnid, erofs_nid_t nid)
+static void erofs_check_inode(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	erofs_nid_t pnid, erofs_nid_t nid)
 {
 	int ret;
 	struct erofs_inode inode;
@@ -476,7 +496,7 @@ static void erofs_check_inode(struct erofs_device erofs_dev, erofs_nid_t pnid, e
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
 
 	inode.nid = nid;
-	ret = erofs_read_inode_from_disk(erofs_dev, &inode);
+	ret = erofs_read_inode_from_disk(erofs_dev, sbi, &inode);
 	if (ret) {
 		if (ret == -EIO)
 			erofs_err("I/O error occurred when reading nid(%llu)",
@@ -485,12 +505,12 @@ static void erofs_check_inode(struct erofs_device erofs_dev, erofs_nid_t pnid, e
 	}
 
 	/* verify xattr field */
-	ret = erofs_verify_xattr(erofs_dev,&inode);
+	ret = erofs_verify_xattr(erofs_dev, sbi, &inode);
 	if (ret)
 		goto out;
 
 	/* verify data chunk layout */
-	ret = erofs_verify_inode_data(erofs_dev, &inode);
+	ret = erofs_verify_inode_data(erofs_dev, sbi, &inode);
 	if (ret)
 		goto out;
 
@@ -506,7 +526,7 @@ static void erofs_check_inode(struct erofs_device erofs_dev, erofs_nid_t pnid, e
 
 		unsigned int nameoff;
 
-		ret = erofs_pread(erofs_dev, &inode, buf, maxsize, offset);
+		ret = erofs_pread(erofs_dev, sbi, &inode, buf, maxsize, offset);
 		if (ret) {
 			erofs_err("I/O error occurred when reading dirents @ nid %llu, block %u: %d",
 				  nid | 0ULL, block, ret);
@@ -522,7 +542,7 @@ static void erofs_check_inode(struct erofs_device erofs_dev, erofs_nid_t pnid, e
 			goto out;
 		}
 
-		ret = traverse_dirents(erofs_dev, pnid, nid, buf, block,
+		ret = traverse_dirents(erofs_dev, sbi, pnid, nid, buf, block,
 				       nameoff, maxsize);
 		if (ret)
 			goto out;
@@ -538,6 +558,7 @@ int main(int argc, char **argv)
 {
 	int err;
 	struct erofs_device erofs_dev;
+	struct erofs_sb_info sbi;
 
 	erofs_init_global_configure();
 
@@ -571,7 +592,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	erofs_check_inode(erofs_dev, sbi.root_nid, sbi.root_nid);
+	erofs_check_inode(erofs_dev, &sbi, sbi.root_nid, sbi.root_nid);
 
 	if (fsckcfg.corrupted) {
 		erofs_err("Found some filesystem corruption");
diff --git a/fuse/dir.c b/fuse/dir.c
index 494c915..b7ff635 100644
--- a/fuse/dir.c
+++ b/fuse/dir.c
@@ -10,6 +10,7 @@
 
 // defined in fuse/main.c
 extern struct erofs_device erofs_dev;
+extern struct erofs_sb_info sbi;
 
 static int erofs_fill_dentries(struct erofs_inode *dir,
 			       fuse_fill_dir_t filler, void *buf,
@@ -60,7 +61,7 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 
 	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
 
-	ret = erofs_ilookup(erofs_dev, path, &dir);
+	ret = erofs_ilookup(erofs_dev, &sbi, path, &dir);
 	if (ret)
 		return ret;
 
@@ -79,7 +80,7 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 
 		maxsize = min_t(unsigned int, EROFS_BLKSIZ,
 				dir.i_size - pos);
-		ret = erofs_pread(erofs_dev, &dir, dblk, maxsize, pos);
+		ret = erofs_pread(erofs_dev, &sbi, &dir, dblk, maxsize, pos);
 		if (ret)
 			return ret;
 
diff --git a/fuse/main.c b/fuse/main.c
index b3e1a3d..37edf46 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -14,6 +14,7 @@
 #include "erofs/io.h"
 
 struct erofs_device erofs_dev;
+struct erofs_sb_info sbi;
 
 int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
 		      off_t offset, struct fuse_file_info *fi);
@@ -40,7 +41,7 @@ static int erofsfuse_getattr(const char *path, struct stat *stbuf)
 	int ret;
 
 	erofs_dbg("getattr(%s)", path);
-	ret = erofs_ilookup(erofs_dev, path, &vi);
+	ret = erofs_ilookup(erofs_dev, &sbi, path, &vi);
 	if (ret)
 		return -ENOENT;
 
@@ -67,11 +68,11 @@ static int erofsfuse_read(const char *path, char *buffer,
 
 	erofs_dbg("path:%s size=%zd offset=%llu", path, size, (long long)offset);
 
-	ret = erofs_ilookup(erofs_dev, path, &vi);
+	ret = erofs_ilookup(erofs_dev, &sbi, path, &vi);
 	if (ret)
 		return ret;
 
-	ret = erofs_pread(erofs_dev, &vi, buffer, size, offset);
+	ret = erofs_pread(erofs_dev, &sbi, &vi, buffer, size, offset);
 	if (ret)
 		return ret;
 	if (offset >= vi.i_size)
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 73834a7..813b8e0 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -16,10 +16,12 @@
 
 int erofs_write_compressed_file(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct erofs_inode *inode);
 
 int z_erofs_compress_init(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index 0ba2b08..4880bfd 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -28,6 +28,9 @@ struct z_erofs_decompress_req {
 	bool partial_decoding;
 };
 
-int z_erofs_decompress(struct z_erofs_decompress_req *rq);
+int z_erofs_decompress(
+	struct z_erofs_decompress_req *rq,
+	struct erofs_sb_info *sbi
+	);
 
 #endif
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 5483d04..3b03482 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -12,9 +12,10 @@
 
 void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
-erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
+erofs_nid_t erofs_lookupnid(struct erofs_sb_info *sbi, struct erofs_inode *inode);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct erofs_inode *parent,
 	const char *path);
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 49a883e..ff79fe9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -68,12 +68,9 @@ struct erofs_sb_info {
 	u32 checksum;
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
@@ -253,20 +250,31 @@ struct erofs_map_blocks {
 int erofs_read_superblock(struct erofs_device devfd, struct erofs_sb_info *sbi);
 
 /* namei.c */
-int erofs_read_inode_from_disk(struct erofs_device fd, struct erofs_inode *vi);
-int erofs_ilookup(struct erofs_device devfd, const char *path, struct erofs_inode *vi);
+int erofs_read_inode_from_disk(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *vi);
+int erofs_ilookup(
+	struct erofs_device devfd,
+	struct erofs_sb_info *sbi,
+	const char *path, struct erofs_inode *vi);
 
 /* data.c */
-int erofs_pread(struct erofs_device fd, struct erofs_inode *inode, char *buf,
+int erofs_pread(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
 int erofs_map_blocks(
 		struct erofs_device erofs_dev,
+		struct erofs_sb_info *sbi,
 		struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 /* zmap.c */
-int z_erofs_fill_inode(struct erofs_inode *vi);
+int z_erofs_fill_inode(struct erofs_inode *vi, struct erofs_sb_info *sbi);
 int z_erofs_map_blocks_iter(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct erofs_inode *vi,
 	struct erofs_map_blocks *map,
 	int flags);
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index f0c4c26..c8593e1 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -42,6 +42,6 @@
 
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
-int erofs_build_shared_xattrs_from_path(const char *path);
+int erofs_build_shared_xattrs_from_path(const char *path, struct erofs_sb_info *sbi);
 
 #endif
diff --git a/lib/compress.c b/lib/compress.c
index 766b75b..1e1ffde 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -59,8 +59,10 @@ static void vle_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
-			      unsigned int count, bool raw)
+static void vle_write_indexes(
+	struct z_erofs_vle_compress_ctx *ctx,
+	struct erofs_sb_info *sbi,
+	unsigned int count, bool raw)
 {
 	unsigned int clusterofs = ctx->clusterofs;
 	unsigned int d0 = 0, d1 = (clusterofs + count) / EROFS_BLKSIZ;
@@ -89,7 +91,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 	do {
 		/* XXX: big pcluster feature should be per-inode */
-		if (d0 == 1 && erofs_sb_has_big_pcluster(&sbi)) {
+		if (d0 == 1 && erofs_sb_has_big_pcluster(sbi)) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
 					Z_EROFS_VLE_DI_D0_CBLKCNT);
@@ -122,6 +124,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 static int write_uncompressed_extent(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct z_erofs_vle_compress_ctx *ctx,
 				     unsigned int *len, char *dst)
 {
@@ -129,7 +132,7 @@ static int write_uncompressed_extent(
 	unsigned int count;
 
 	/* reset clusterofs to 0 if permitted */
-	if (!erofs_sb_has_lz4_0padding(&sbi) && ctx->clusterofs &&
+	if (!erofs_sb_has_lz4_0padding(sbi) && ctx->clusterofs &&
 	    ctx->head >= ctx->clusterofs) {
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
@@ -166,6 +169,7 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 
 static int vle_compress_one(
 		struct erofs_device erofs_dev,
+		struct erofs_sb_info *sbi,
 		struct erofs_inode *inode,
 		struct z_erofs_vle_compress_ctx *ctx,
 		bool final)
@@ -201,7 +205,7 @@ static int vle_compress_one(
 					  erofs_strerror(ret));
 			}
 nocompression:
-			ret = write_uncompressed_extent(erofs_dev, ctx, &len, dst);
+			ret = write_uncompressed_extent(erofs_dev, sbi, ctx, &len, dst);
 			if (ret < 0)
 				return ret;
 			count = ret;
@@ -210,14 +214,14 @@ nocompression:
 		} else {
 			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
 			const unsigned int padding =
-				erofs_sb_has_lz4_0padding(&sbi) && tailused ?
+				erofs_sb_has_lz4_0padding(sbi) && tailused ?
 					EROFS_BLKSIZ - tailused : 0;
 
 			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
 			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
 
 			/* zero out garbage trailing data for non-0padding */
-			if (!erofs_sb_has_lz4_0padding(&sbi))
+			if (!erofs_sb_has_lz4_0padding(sbi))
 				memset(dst + ret, 0,
 				       roundup(ret, EROFS_BLKSIZ) - ret);
 
@@ -234,7 +238,7 @@ nocompression:
 
 		ctx->head += count;
 		/* write compression indexes for this pcluster */
-		vle_write_indexes(ctx, count, raw);
+		vle_write_indexes(ctx, sbi, count, raw);
 
 		ctx->blkaddr += ctx->compressedblks;
 		len -= count;
@@ -287,7 +291,9 @@ static void *parse_legacy_indexes(struct z_erofs_compressindex_vec *cv,
 	return db + nr;
 }
 
-static void *write_compacted_indexes(u8 *out,
+static void *write_compacted_indexes(
+						 struct erofs_sb_info *sbi,
+						 u8 *out,
 				     struct z_erofs_compressindex_vec *cv,
 				     erofs_blk_t *blkaddr_ret,
 				     unsigned int destsize,
@@ -306,7 +312,7 @@ static void *write_compacted_indexes(u8 *out,
 		return ERR_PTR(-EINVAL);
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
-	update_blkaddr = erofs_sb_has_big_pcluster(&sbi);
+	update_blkaddr = erofs_sb_has_big_pcluster(sbi);
 
 	pos = 0;
 	for (i = 0; i < vcnt; ++i) {
@@ -354,7 +360,9 @@ static void *write_compacted_indexes(u8 *out,
 	return out + destsize * vcnt;
 }
 
-int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
+int z_erofs_convert_to_compacted_format(
+					struct erofs_sb_info *sbi,
+					struct erofs_inode *inode,
 					erofs_blk_t blkaddr,
 					unsigned int legacymetasize,
 					void *compressmeta)
@@ -402,7 +410,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	dummy_head = false;
 	/* prior to bigpcluster, blkaddr was bumped up once coming into HEAD */
-	if (!erofs_sb_has_big_pcluster(&sbi)) {
+	if (!erofs_sb_has_big_pcluster(sbi)) {
 		--blkaddr;
 		dummy_head = true;
 	}
@@ -410,7 +418,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	/* generate compacted_4b_initial */
 	while (compacted_4b_initial) {
 		in = parse_legacy_indexes(cv, 2, in);
-		out = write_compacted_indexes(out, cv, &blkaddr,
+		out = write_compacted_indexes(sbi, out, cv, &blkaddr,
 					      4, logical_clusterbits, false,
 					      &dummy_head);
 		compacted_4b_initial -= 2;
@@ -420,7 +428,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	/* generate compacted_2b */
 	while (compacted_2b) {
 		in = parse_legacy_indexes(cv, 16, in);
-		out = write_compacted_indexes(out, cv, &blkaddr,
+		out = write_compacted_indexes(sbi, out, cv, &blkaddr,
 					      2, logical_clusterbits, false,
 					      &dummy_head);
 		compacted_2b -= 16;
@@ -430,7 +438,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	/* generate compacted_4b_end */
 	while (compacted_4b_end > 1) {
 		in = parse_legacy_indexes(cv, 2, in);
-		out = write_compacted_indexes(out, cv, &blkaddr,
+		out = write_compacted_indexes(sbi, out, cv, &blkaddr,
 					      4, logical_clusterbits, false,
 					      &dummy_head);
 		compacted_4b_end -= 2;
@@ -440,7 +448,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	if (compacted_4b_end) {
 		memset(cv, 0, sizeof(cv));
 		in = parse_legacy_indexes(cv, 1, in);
-		out = write_compacted_indexes(out, cv, &blkaddr,
+		out = write_compacted_indexes(sbi, out, cv, &blkaddr,
 					      4, logical_clusterbits, true,
 					      &dummy_head);
 	}
@@ -464,7 +472,10 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
 }
 
-int erofs_write_compressed_file(struct erofs_device erofs_dev, struct erofs_inode *inode)
+int erofs_write_compressed_file(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh;
 	struct z_erofs_vle_compress_ctx ctx;
@@ -499,7 +510,7 @@ int erofs_write_compressed_file(struct erofs_device erofs_dev, struct erofs_inod
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	}
 
-	if (erofs_sb_has_big_pcluster(&sbi)) {
+	if (erofs_sb_has_big_pcluster(sbi)) {
 		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
@@ -530,13 +541,13 @@ int erofs_write_compressed_file(struct erofs_device erofs_dev, struct erofs_inod
 		ctx.tail += readcount;
 
 		/* do one compress round */
-		ret = vle_compress_one(erofs_dev, inode, &ctx, false);
+		ret = vle_compress_one(erofs_dev, sbi, inode, &ctx, false);
 		if (ret)
 			goto err_bdrop;
 	}
 
 	/* do the final round */
-	ret = vle_compress_one(erofs_dev, inode, &ctx, true);
+	ret = vle_compress_one(erofs_dev, sbi, inode, &ctx, true);
 	if (ret)
 		goto err_bdrop;
 
@@ -570,7 +581,7 @@ int erofs_write_compressed_file(struct erofs_device erofs_dev, struct erofs_inod
 	if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		inode->extent_isize = legacymetasize;
 	} else {
-		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
+		ret = z_erofs_convert_to_compacted_format(sbi, inode, blkaddr,
 							  legacymetasize,
 							  compressmeta);
 		DBG_BUGON(ret);
@@ -597,12 +608,15 @@ static int erofs_get_compress_algorithm_id(const char *name)
 	return -ENOTSUP;
 }
 
-int z_erofs_build_compr_cfgs(struct erofs_device erofs_dev, struct erofs_buffer_head *sb_bh)
+int z_erofs_build_compr_cfgs(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_buffer_head *sb_bh)
 {
 	struct erofs_buffer_head *bh = sb_bh;
 	int ret = 0;
 
-	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
+	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
 		struct {
 			__le16 size;
 			struct z_erofs_lz4_cfgs lz4;
@@ -610,7 +624,7 @@ int z_erofs_build_compr_cfgs(struct erofs_device erofs_dev, struct erofs_buffer_
 			.size = cpu_to_le16(sizeof(struct z_erofs_lz4_cfgs)),
 			.lz4 = {
 				.max_distance =
-					cpu_to_le16(sbi.lz4_max_distance),
+					cpu_to_le16(sbi->lz4_max_distance),
 				.max_pclusterblks = cfg.c_pclusterblks_max,
 			}
 		};
@@ -651,10 +665,14 @@ int z_erofs_build_compr_cfgs(struct erofs_device erofs_dev, struct erofs_buffer_
 	return ret;
 }
 
-int z_erofs_compress_init(struct erofs_device erofs_dev, struct erofs_buffer_head *sb_bh)
+int z_erofs_compress_init(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_buffer_head *sb_bh)
 {
 	/* initialize for primary compression algorithm */
 	int ret = erofs_compressor_init(&compresshandle,
+	sbi,
 					cfg.c_compr_alg_master);
 
 	if (ret)
@@ -666,7 +684,7 @@ int z_erofs_compress_init(struct erofs_device erofs_dev, struct erofs_buffer_hea
 	 */
 	if (!cfg.c_compr_alg_master ||
 	    (cfg.c_legacy_compress && !strcmp(cfg.c_compr_alg_master, "lz4")))
-		erofs_sb_clear_lz4_0padding(&sbi);
+		erofs_sb_clear_lz4_0padding(sbi);
 
 	if (!cfg.c_compr_alg_master)
 		return 0;
@@ -694,16 +712,16 @@ int z_erofs_compress_init(struct erofs_device erofs_dev, struct erofs_buffer_hea
 				  cfg.c_pclusterblks_max);
 			return -EINVAL;
 		}
-		erofs_sb_set_big_pcluster(&sbi);
+		erofs_sb_set_big_pcluster(sbi);
 		erofs_warn("EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
 	}
 
 	if (ret != Z_EROFS_COMPRESSION_LZ4)
-		erofs_sb_set_compr_cfgs(&sbi);
+		erofs_sb_set_compr_cfgs(sbi);
 
-	if (erofs_sb_has_compr_cfgs(&sbi)) {
-		sbi.available_compr_algs |= 1 << ret;
-		return z_erofs_build_compr_cfgs(erofs_dev, sb_bh);
+	if (erofs_sb_has_compr_cfgs(sbi)) {
+		sbi->available_compr_algs |= 1 << ret;
+		return z_erofs_build_compr_cfgs(erofs_dev, sbi, sb_bh);
 	}
 	return 0;
 }
diff --git a/lib/compressor.c b/lib/compressor.c
index 6362825..3b8d193 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -62,7 +62,10 @@ int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
 	return 0;
 }
 
-int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
+int erofs_compressor_init(
+	struct erofs_compress *c,
+	struct erofs_sb_info *sbi,
+	char *alg_name)
 {
 	int ret, i;
 
@@ -84,7 +87,7 @@ int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
 		if (alg_name && strcmp(alg_name, compressors[i]->name))
 			continue;
 
-		ret = compressors[i]->init(c);
+		ret = compressors[i]->init(c, sbi);
 		if (!ret) {
 			DBG_BUGON(!c->alg);
 			return 0;
diff --git a/lib/compressor.h b/lib/compressor.h
index 1ea2724..446c013 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -10,6 +10,7 @@
 #include "erofs/defs.h"
 
 struct erofs_compress;
+struct erofs_sb_info;
 
 struct erofs_compressor {
 	const char *name;
@@ -17,7 +18,7 @@ struct erofs_compressor {
 	int default_level;
 	int best_level;
 
-	int (*init)(struct erofs_compress *c);
+	int (*init)(struct erofs_compress *c, struct erofs_sb_info *sbi);
 	int (*exit)(struct erofs_compress *c);
 	int (*setlevel)(struct erofs_compress *c, int compression_level);
 
@@ -50,7 +51,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 			    void *dst, unsigned int dstsize);
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
-int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
+int erofs_compressor_init(struct erofs_compress *c, struct erofs_sb_info *sbi, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
 
 #endif
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index fc8c23c..ffdbb9f 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -30,10 +30,12 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_lz4_init(struct erofs_compress *c)
+static int compressor_lz4_init(
+	struct erofs_compress *c,
+	struct erofs_sb_info *sbi)
 {
 	c->alg = &erofs_compressor_lz4;
-	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
+	sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 3f68b00..f573cd2 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -36,7 +36,7 @@ static int compressor_lz4hc_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_lz4hc_init(struct erofs_compress *c)
+static int compressor_lz4hc_init(struct erofs_compress *c, struct erofs_sb_info *sbi)
 {
 	c->alg = &erofs_compressor_lz4hc;
 
@@ -44,7 +44,7 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	if (!c->private_data)
 		return -ENOMEM;
 
-	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
+	sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
diff --git a/lib/config.c b/lib/config.c
index 7488e08..7313588 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -10,7 +10,6 @@
 #include "erofs/internal.h"
 
 struct erofs_configure cfg;
-struct erofs_sb_info sbi;
 
 void erofs_init_config(struct erofs_configure *cfg)
 {
diff --git a/lib/data.c b/lib/data.c
index d9d20ec..e6fe1d6 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -10,9 +10,11 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 
-static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
-				     struct erofs_map_blocks *map,
-				     int flags)
+static int erofs_map_blocks_flatmode(
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode,
+	struct erofs_map_blocks *map,
+	int flags)
 {
 	int err = 0;
 	erofs_blk_t nblocks, lastblk;
@@ -33,7 +35,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 		map->m_plen = blknr_to_addr(lastblk) - offset;
 	} else if (tailendpacking) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
-		map->m_pa = iloc(vi->nid) + vi->inode_isize +
+		map->m_pa = iloc(sbi, vi->nid) + vi->inode_isize +
 			vi->xattr_isize + erofs_blkoff(map->m_la);
 		map->m_plen = inode->i_size - offset;
 
@@ -63,6 +65,7 @@ err_out:
 
 int erofs_map_blocks(
 		struct erofs_device erofs_dev,
+		struct erofs_sb_info *sbi,
 		struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags)
 {
@@ -82,7 +85,7 @@ int erofs_map_blocks(
 	}
 
 	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
-		return erofs_map_blocks_flatmode(inode, map, flags);
+		return erofs_map_blocks_flatmode(sbi, inode, map, flags);
 
 	if (vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(*idx);			/* chunk index */
@@ -90,7 +93,7 @@ int erofs_map_blocks(
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
 
 	chunknr = map->m_la >> vi->u.chunkbits;
-	pos = roundup(iloc(vi->nid) + vi->inode_isize +
+	pos = roundup(iloc(sbi, vi->nid) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
 	err = blk_read(erofs_dev, buf, erofs_blknr(pos), 1);
@@ -137,7 +140,10 @@ out:
 	return err;
 }
 
-static int erofs_read_raw_data(struct erofs_device erofs_dev, struct erofs_inode *inode, char *buffer,
+static int erofs_read_raw_data(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
 	struct erofs_map_blocks map = {
@@ -151,7 +157,7 @@ static int erofs_read_raw_data(struct erofs_device erofs_dev, struct erofs_inode
 		erofs_off_t eend;
 
 		map.m_la = ptr;
-		ret = erofs_map_blocks(erofs_dev, inode, &map, 0);
+		ret = erofs_map_blocks(erofs_dev, sbi, inode, &map, 0);
 		if (ret)
 			return ret;
 
@@ -188,6 +194,7 @@ static int erofs_read_raw_data(struct erofs_device erofs_dev, struct erofs_inode
 
 static int z_erofs_read_data(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct erofs_inode *inode,
 	char *buffer,
 	erofs_off_t size,
@@ -207,7 +214,7 @@ static int z_erofs_read_data(
 	while (end > offset) {
 		map.m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(erofs_dev, inode, &map, 0);
+		ret = z_erofs_map_blocks_iter(erofs_dev, sbi, inode, &map, 0);
 		if (ret)
 			break;
 
@@ -263,7 +270,7 @@ static int z_erofs_read_data(
 					.decodedlength = length,
 					.alg = algorithmformat,
 					.partial_decoding = partial
-					 });
+					 }, sbi);
 		if (ret < 0)
 			break;
 	}
@@ -272,17 +279,20 @@ static int z_erofs_read_data(
 	return ret < 0 ? ret : 0;
 }
 
-int erofs_pread(struct erofs_device fd, struct erofs_inode *inode, char *buf,
+int erofs_pread(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset)
 {
 	switch (inode->datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
-		return erofs_read_raw_data(fd, inode, buf, count, offset);
+		return erofs_read_raw_data(fd, sbi, inode, buf, count, offset);
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		return z_erofs_read_data(fd, inode, buf, count, offset);
+		return z_erofs_read_data(fd, sbi, inode, buf, count, offset);
 	default:
 		break;
 	}
diff --git a/lib/decompress.c b/lib/decompress.c
index 6a60400..483bd52 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -12,7 +12,7 @@
 #ifdef HAVE_LIBLZMA
 #include <lzma.h>
 
-static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq)
+static int z_erofs_decompress_lzma(struct z_erofs_decompress_req *rq, struct erofs_sb_info *sbi)
 {
 	int ret = 0;
 	u8 *dest = (u8 *)rq->out;
@@ -73,7 +73,7 @@ out:
 #ifdef LZ4_ENABLED
 #include <lz4.h>
 
-static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
+static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq, struct erofs_sb_info *sbi)
 {
 	int ret = 0;
 	char *dest = rq->out;
@@ -82,7 +82,7 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 	bool support_0padding = false;
 	unsigned int inputmargin = 0;
 
-	if (erofs_sb_has_lz4_0padding(&sbi)) {
+	if (erofs_sb_has_lz4_0padding(sbi)) {
 		support_0padding = true;
 
 		while (!src[inputmargin & ~PAGE_MASK])
@@ -126,7 +126,7 @@ out:
 }
 #endif
 
-int z_erofs_decompress(struct z_erofs_decompress_req *rq)
+int z_erofs_decompress(struct z_erofs_decompress_req *rq, struct erofs_sb_info *sbi)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		if (rq->inputsize != EROFS_BLKSIZ)
@@ -142,11 +142,11 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 
 #ifdef LZ4_ENABLED
 	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
-		return z_erofs_decompress_lz4(rq);
+		return z_erofs_decompress_lz4(rq, sbi);
 #endif
 #ifdef HAVE_LIBLZMA
 	if (rq->alg == Z_EROFS_COMPRESSION_LZMA)
-		return z_erofs_decompress_lzma(rq);
+		return z_erofs_decompress_lzma(rq, sbi);
 #endif
 	return -EOPNOTSUPP;
 }
diff --git a/lib/inode.c b/lib/inode.c
index d1adb49..70525fa 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -387,7 +387,10 @@ static int write_uncompressed_file_from_fd(
 	return 0;
 }
 
-int erofs_write_file(struct erofs_device erofs_dev, struct erofs_inode *inode)
+int erofs_write_file(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *inode)
 {
 	int ret, fd;
 
@@ -403,7 +406,7 @@ int erofs_write_file(struct erofs_device erofs_dev, struct erofs_inode *inode)
 	}
 
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(erofs_dev, inode);
+		ret = erofs_write_compressed_file(erofs_dev, sbi, inode);
 
 		if (!ret || ret != -ENOSPC)
 			return ret;
@@ -799,7 +802,9 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #endif
 
-static int erofs_fill_inode(struct erofs_inode *inode,
+static int erofs_fill_inode(
+					struct erofs_inode *inode,
+					struct erofs_sb_info *sbi,
 			    struct stat64 *st,
 			    const char *path)
 {
@@ -815,11 +820,11 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 
 	switch (cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
-		if (st->st_ctime < sbi.build_time)
+		if (st->st_ctime < sbi->build_time)
 			break;
 	case TIMESTAMP_FIXED:
-		inode->i_ctime = sbi.build_time;
-		inode->i_ctime_nsec = sbi.build_time_nsec;
+		inode->i_ctime = sbi->build_time;
+		inode->i_ctime_nsec = sbi->build_time_nsec;
 	default:
 		break;
 	}
@@ -865,7 +870,7 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 	return 0;
 }
 
-static struct erofs_inode *erofs_new_inode(void)
+static struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 {
 	struct erofs_inode *inode;
 
@@ -873,7 +878,7 @@ static struct erofs_inode *erofs_new_inode(void)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
+	inode->i_ino[0] = sbi->inos++;	/* inode serial number */
 	inode->i_count = 1;
 
 	init_list_head(&inode->i_subdirs);
@@ -882,7 +887,8 @@ static struct erofs_inode *erofs_new_inode(void)
 }
 
 /* get the inode from the (source) path */
-static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
+static struct erofs_inode *erofs_iget_from_path(
+	struct erofs_sb_info *sbi, const char *path, bool is_src)
 {
 	struct stat64 st;
 	struct erofs_inode *inode;
@@ -908,11 +914,11 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	}
 
 	/* cannot find in the inode cache */
-	inode = erofs_new_inode();
+	inode = erofs_new_inode(sbi);
 	if (IS_ERR(inode))
 		return inode;
 
-	ret = erofs_fill_inode(inode, &st, path);
+	ret = erofs_fill_inode(inode, sbi, &st, path);
 	if (ret) {
 		free(inode);
 		return ERR_PTR(ret);
@@ -921,7 +927,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	return inode;
 }
 
-static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
+static void erofs_fixup_meta_blkaddr(struct erofs_sb_info *sbi, struct erofs_inode *rootdir)
 {
 	const erofs_off_t rootnid_maxoffset = 0xffff << EROFS_ISLOTBITS;
 	struct erofs_buffer_head *const bh = rootdir->bh;
@@ -934,11 +940,11 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 		meta_offset = round_up(off - rootnid_maxoffset, EROFS_BLKSIZ);
 	else
 		meta_offset = 0;
-	sbi.meta_blkaddr = erofs_blknr(meta_offset);
+	sbi->meta_blkaddr = erofs_blknr(meta_offset);
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
+erofs_nid_t erofs_lookupnid(struct erofs_sb_info *sbi, struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *const bh = inode->bh;
 	erofs_off_t off, meta_offset;
@@ -949,21 +955,24 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
+	meta_offset = blknr_to_addr(sbi->meta_blkaddr);
 	DBG_BUGON(off < meta_offset);
 	return inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-static void erofs_d_invalidate(struct erofs_dentry *d)
+static void erofs_d_invalidate(
+	struct erofs_sb_info *sbi, struct erofs_dentry *d)
 {
 	struct erofs_inode *const inode = d->inode;
 
-	d->nid = erofs_lookupnid(inode);
+	d->nid = erofs_lookupnid(sbi, inode);
 	erofs_iput(inode);
 }
 
 static struct erofs_inode *erofs_mkfs_build_tree(
-	struct erofs_device erofs_dev, struct erofs_inode *dir)
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *dir)
 {
 	int ret;
 	DIR *_dir;
@@ -992,7 +1001,7 @@ static struct erofs_inode *erofs_mkfs_build_tree(
 			if (ret)
 				return ERR_PTR(ret);
 		} else {
-			ret = erofs_write_file(erofs_dev, dir);
+			ret = erofs_write_file(erofs_dev, sbi, dir);
 			if (ret)
 				return ERR_PTR(ret);
 		}
@@ -1055,14 +1064,14 @@ static struct erofs_inode *erofs_mkfs_build_tree(
 		goto err;
 
 	if (IS_ROOT(dir))
-		erofs_fixup_meta_blkaddr(dir);
+		erofs_fixup_meta_blkaddr(sbi, dir);
 
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		char buf[PATH_MAX];
 		unsigned char ftype;
 
 		if (is_dot_dotdot(d->name)) {
-			erofs_d_invalidate(d);
+			erofs_d_invalidate(sbi, d);
 			continue;
 		}
 
@@ -1073,7 +1082,7 @@ static struct erofs_inode *erofs_mkfs_build_tree(
 			goto fail;
 		}
 
-		d->inode = erofs_mkfs_build_tree_from_path(erofs_dev, dir, buf);
+		d->inode = erofs_mkfs_build_tree_from_path(erofs_dev, sbi, dir, buf);
 		if (IS_ERR(d->inode)) {
 			ret = PTR_ERR(d->inode);
 fail:
@@ -1086,7 +1095,7 @@ fail:
 		DBG_BUGON(ftype == EROFS_FT_DIR && d->type != ftype);
 		d->type = ftype;
 
-		erofs_d_invalidate(d);
+		erofs_d_invalidate(sbi, d);
 		erofs_info("add file %s/%s (nid %llu, type %d)",
 			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
 			   d->type);
@@ -1103,10 +1112,11 @@ err:
 
 struct erofs_inode *erofs_mkfs_build_tree_from_path(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct erofs_inode *parent,
 	const char *path)
 {
-	struct erofs_inode *const inode = erofs_iget_from_path(path, true);
+	struct erofs_inode *const inode = erofs_iget_from_path(sbi, path, true);
 
 	if (IS_ERR(inode))
 		return inode;
@@ -1123,5 +1133,5 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(
 	else
 		inode->i_parent = inode;	/* rootdir mark */
 
-	return erofs_mkfs_build_tree(erofs_dev, inode);
+	return erofs_mkfs_build_tree(erofs_dev, sbi, inode);
 }
diff --git a/lib/namei.c b/lib/namei.c
index 57041f5..ac65425 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -22,13 +22,16 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-int erofs_read_inode_from_disk(struct erofs_device fd, struct erofs_inode *vi)
+int erofs_read_inode_from_disk(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[sizeof(struct erofs_inode_extended)];
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
-	const erofs_off_t inode_loc = iloc(vi->nid);
+	const erofs_off_t inode_loc = iloc(sbi, vi->nid);
 
 	ret = dev_read(fd, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
@@ -114,8 +117,8 @@ int erofs_read_inode_from_disk(struct erofs_device fd, struct erofs_inode *vi)
 		vi->i_gid = le16_to_cpu(dic->i_gid);
 		vi->i_nlink = le16_to_cpu(dic->i_nlink);
 
-		vi->i_ctime = sbi.build_time;
-		vi->i_ctime_nsec = sbi.build_time_nsec;
+		vi->i_ctime = sbi->build_time;
+		vi->i_ctime_nsec = sbi->build_time_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
 		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
@@ -137,7 +140,7 @@ int erofs_read_inode_from_disk(struct erofs_device fd, struct erofs_inode *vi)
 		vi->u.chunkbits = LOG_BLOCK_SIZE +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	} else if (erofs_inode_is_data_compressed(vi->datalayout))
-		z_erofs_fill_inode(vi);
+		z_erofs_fill_inode(vi, sbi);
 	return 0;
 bogusimode:
 	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
@@ -187,7 +190,10 @@ struct nameidata {
 	unsigned int	ftype;
 };
 
-int erofs_namei(struct erofs_device fd, struct nameidata *nd,
+int erofs_namei(
+	struct erofs_device fd,
+	struct erofs_sb_info *sbi,
+	struct nameidata *nd,
 		const char *name, unsigned int len)
 {
 	erofs_nid_t nid = nd->nid;
@@ -196,7 +202,7 @@ int erofs_namei(struct erofs_device fd, struct nameidata *nd,
 	struct erofs_inode vi = { .nid = nid };
 	erofs_off_t offset;
 
-	ret = erofs_read_inode_from_disk(fd, &vi);
+	ret = erofs_read_inode_from_disk(fd, sbi, &vi);
 	if (ret)
 		return ret;
 
@@ -207,7 +213,7 @@ int erofs_namei(struct erofs_device fd, struct nameidata *nd,
 		struct erofs_dirent *de = (void *)buf;
 		unsigned int nameoff;
 
-		ret = erofs_pread(fd, &vi, buf, maxsize, offset);
+		ret = erofs_pread(fd, sbi, &vi, buf, maxsize, offset);
 		if (ret)
 			return ret;
 
@@ -233,9 +239,12 @@ int erofs_namei(struct erofs_device fd, struct nameidata *nd,
 	return -ENOENT;
 }
 
-static int link_path_walk(struct erofs_device devfd, const char *name, struct nameidata *nd)
+static int link_path_walk(
+	struct erofs_device devfd,
+	struct erofs_sb_info *sbi,
+	const char *name, struct nameidata *nd)
 {
-	nd->nid = sbi.root_nid;
+	nd->nid = sbi->root_nid;
 
 	while (*name == '/')
 		name++;
@@ -250,7 +259,7 @@ static int link_path_walk(struct erofs_device devfd, const char *name, struct na
 		} while (*p != '\0' && *p != '/');
 
 		DBG_BUGON(p <= name);
-		ret = erofs_namei(devfd, nd, name, p - name);
+		ret = erofs_namei(devfd, sbi, nd, name, p - name);
 		if (ret)
 			return ret;
 
@@ -262,15 +271,18 @@ static int link_path_walk(struct erofs_device devfd, const char *name, struct na
 	return 0;
 }
 
-int erofs_ilookup(struct erofs_device devfd, const char *path, struct erofs_inode *vi)
+int erofs_ilookup(
+	struct erofs_device devfd,
+	struct erofs_sb_info *sbi,
+	const char *path, struct erofs_inode *vi)
 {
 	int ret;
 	struct nameidata nd;
 
-	ret = link_path_walk(devfd, path, &nd);
+	ret = link_path_walk(devfd, sbi, path, &nd);
 	if (ret)
 		return ret;
 
 	vi->nid = nd.nid;
-	return erofs_read_inode_from_disk(devfd, vi);
+	return erofs_read_inode_from_disk(devfd, sbi, vi);
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index 9f16664..7a1ed9e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -564,7 +564,7 @@ static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
 	.flush = erofs_bh_flush_write_shared_xattrs,
 };
 
-int erofs_build_shared_xattrs_from_path(const char *path)
+int erofs_build_shared_xattrs_from_path(const char *path, struct erofs_sb_info *sbi)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
@@ -604,7 +604,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
-	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
+	sbi->xattr_blkaddr = off / EROFS_BLKSIZ;
 	off %= EROFS_BLKSIZ;
 	p = 0;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 69fef80..e6e9858 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -10,9 +10,9 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
-int z_erofs_fill_inode(struct erofs_inode *vi)
+int z_erofs_fill_inode(struct erofs_inode *vi, struct erofs_sb_info *sbi)
 {
-	if (!erofs_sb_has_big_pcluster(&sbi) &&
+	if (!erofs_sb_has_big_pcluster(sbi) &&
 	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
@@ -24,7 +24,10 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct erofs_device erofs_dev, struct erofs_inode *vi)
+static int z_erofs_fill_inode_lazy(
+	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
+	struct erofs_inode *vi)
 {
 	int ret;
 	erofs_off_t pos;
@@ -34,9 +37,9 @@ static int z_erofs_fill_inode_lazy(struct erofs_device erofs_dev, struct erofs_i
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
-	DBG_BUGON(!erofs_sb_has_big_pcluster(&sbi) &&
+	DBG_BUGON(!erofs_sb_has_big_pcluster(sbi) &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
-	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+	pos = round_up(iloc(sbi, vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
 	ret = dev_read(erofs_dev, buf, pos, sizeof(buf));
 	if (ret < 0)
@@ -101,11 +104,12 @@ static int z_erofs_reload_indexes(
 
 static int legacy_load_cluster_from_disk(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct z_erofs_maprecorder *m,
 	unsigned long lcn)
 {
 	struct erofs_inode *const vi = m->inode;
-	const erofs_off_t ibase = iloc(vi->nid);
+	const erofs_off_t ibase = iloc(sbi, vi->nid);
 	const erofs_off_t pos =
 		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
 					       vi->xattr_isize) +
@@ -295,12 +299,13 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 
 static int compacted_load_cluster_from_disk(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct z_erofs_maprecorder *m,
 	unsigned long lcn, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
+	const erofs_off_t ebase = round_up(iloc(sbi, vi->nid) + vi->inode_isize +
 					   vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
 	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
@@ -352,22 +357,24 @@ out:
 
 static int z_erofs_load_cluster_from_disk(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct z_erofs_maprecorder *m,
 					  unsigned int lcn, bool lookahead)
 {
 	const unsigned int datamode = m->inode->datalayout;
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
-		return legacy_load_cluster_from_disk(erofs_dev, m, lcn);
+		return legacy_load_cluster_from_disk(erofs_dev, sbi, m, lcn);
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
-		return compacted_load_cluster_from_disk(erofs_dev, m, lcn, lookahead);
+		return compacted_load_cluster_from_disk(erofs_dev, sbi, m, lcn, lookahead);
 
 	return -EINVAL;
 }
 
 static int z_erofs_extent_lookback(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
@@ -386,7 +393,7 @@ static int z_erofs_extent_lookback(
 
 	/* load extent head logical cluster if needed */
 	lcn -= lookback_distance;
-	err = z_erofs_load_cluster_from_disk(erofs_dev, m, lcn, false);
+	err = z_erofs_load_cluster_from_disk(erofs_dev, sbi, m, lcn, false);
 	if (err)
 		return err;
 
@@ -398,7 +405,7 @@ static int z_erofs_extent_lookback(
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
-		return z_erofs_extent_lookback(erofs_dev, m, m->delta[0]);
+		return z_erofs_extent_lookback(erofs_dev, sbi, m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		map->m_flags &= ~EROFS_MAP_ZIPPED;
 		/* fallthrough */
@@ -416,6 +423,7 @@ static int z_erofs_extent_lookback(
 
 static int z_erofs_get_extent_compressedlen(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct z_erofs_maprecorder *m,
 	unsigned int initial_lcn)
 {
@@ -437,7 +445,7 @@ static int z_erofs_get_extent_compressedlen(
 	if (m->compressedlcs)
 		goto out;
 
-	err = z_erofs_load_cluster_from_disk(erofs_dev, m, lcn, false);
+	err = z_erofs_load_cluster_from_disk(erofs_dev, sbi, m, lcn, false);
 	if (err)
 		return err;
 
@@ -485,6 +493,7 @@ err_bonus_cblkcnt:
 
 static int z_erofs_get_extent_decompressedlen(
 	struct erofs_device erofs_dev,
+	struct erofs_sb_info *sbi,
 	struct z_erofs_maprecorder *m)
 {
 	struct erofs_inode *const vi = m->inode;
@@ -500,7 +509,7 @@ static int z_erofs_get_extent_decompressedlen(
 			return 0;
 		}
 
-		err = z_erofs_load_cluster_from_disk(erofs_dev, m, lcn, true);
+		err = z_erofs_load_cluster_from_disk(erofs_dev, sbi, m, lcn, true);
 		if (err)
 			return err;
 
@@ -529,6 +538,7 @@ static int z_erofs_get_extent_decompressedlen(
 
 int z_erofs_map_blocks_iter(
 					struct erofs_device erofs_dev,
+					struct erofs_sb_info *sbi,
 					struct erofs_inode *vi,
 			    struct erofs_map_blocks *map,
 			    int flags)
@@ -551,7 +561,7 @@ int z_erofs_map_blocks_iter(
 		goto out;
 	}
 
-	err = z_erofs_fill_inode_lazy(erofs_dev, vi);
+	err = z_erofs_fill_inode_lazy(erofs_dev, sbi, vi);
 	if (err)
 		goto out;
 
@@ -560,7 +570,7 @@ int z_erofs_map_blocks_iter(
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(erofs_dev, &m, initial_lcn, false);
+	err = z_erofs_load_cluster_from_disk(erofs_dev, sbi, &m, initial_lcn, false);
 	if (err)
 		goto out;
 
@@ -589,7 +599,7 @@ int z_erofs_map_blocks_iter(
 		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
-		err = z_erofs_extent_lookback(erofs_dev, &m, m.delta[0]);
+		err = z_erofs_extent_lookback(erofs_dev, sbi, &m, m.delta[0]);
 		if (err)
 			goto out;
 		break;
@@ -604,12 +614,12 @@ int z_erofs_map_blocks_iter(
 	map->m_pa = blknr_to_addr(m.pblk);
 	map->m_flags |= EROFS_MAP_MAPPED;
 
-	err = z_erofs_get_extent_compressedlen(erofs_dev, &m, initial_lcn);
+	err = z_erofs_get_extent_compressedlen(erofs_dev, sbi, &m, initial_lcn);
 	if (err)
 		goto out;
 
 	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
-		err = z_erofs_get_extent_decompressedlen(erofs_dev, &m);
+		err = z_erofs_get_extent_decompressedlen(erofs_dev, sbi, &m);
 		if (!err)
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 16f8060..f7b432e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -109,7 +109,7 @@ static void usage(void)
 	print_available_compressors(stderr, ", ");
 }
 
-static int parse_extended_opts(const char *opts)
+static int parse_extended_opts(struct erofs_sb_info *sbi, const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
 	(keylen == sizeof(opt) - 1 && !memcmp(token, opt, sizeof(opt) - 1))
@@ -164,7 +164,7 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			erofs_sb_clear_sb_chksum(&sbi);
+			erofs_sb_clear_sb_chksum(sbi);
 		}
 
 		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
@@ -176,7 +176,7 @@ static int parse_extended_opts(const char *opts)
 	return 0;
 }
 
-static int mkfs_parse_options_cfg(int argc, char *argv[])
+static int mkfs_parse_options_cfg(struct erofs_sb_info *sbi, int argc, char *argv[])
 {
 	char *endptr;
 	int opt, i;
@@ -221,7 +221,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 
 		case 'E':
-			opt = parse_extended_opts(optarg);
+			opt = parse_extended_opts(sbi, optarg);
 			if (opt)
 				return opt;
 			break;
@@ -235,7 +235,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 #ifdef HAVE_LIBUUID
 		case 'U':
-			if (uuid_parse(optarg, sbi.uuid)) {
+			if (uuid_parse(optarg, sbi->uuid)) {
 				erofs_err("invalid UUID %s", optarg);
 				return -EINVAL;
 			}
@@ -343,7 +343,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  optarg);
 				return -EINVAL;
 			}
-			erofs_sb_set_chunked_file(&sbi);
+			erofs_sb_set_chunked_file(sbi);
 			break;
 		case 12:
 			quiet = true;
@@ -385,21 +385,23 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	return 0;
 }
 
-int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
+int erofs_mkfs_update_super_block(
+					struct erofs_sb_info *sbi,
+					struct erofs_buffer_head *bh,
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
 	};
 	const unsigned int sb_blksize =
@@ -409,12 +411,12 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
-	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
+	memcpy(sb.uuid, sbi->uuid, sizeof(sb.uuid));
 
-	if (erofs_sb_has_compr_cfgs(&sbi))
-		sb.u1.available_compr_algs = sbi.available_compr_algs;
+	if (erofs_sb_has_compr_cfgs(sbi))
+		sb.u1.available_compr_algs = sbi->available_compr_algs;
 	else
-		sb.u1.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance);
+		sb.u1.lz4_max_distance = cpu_to_le16(sbi->lz4_max_distance);
 
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
@@ -473,17 +475,17 @@ static int erofs_mkfs_superblock_csum_set(struct erofs_device erofs_dev)
 	return 0;
 }
 
-static void erofs_mkfs_default_options(void)
+static void erofs_mkfs_default_options(struct erofs_sb_info *sbi)
 {
 	cfg.c_legacy_compress = false;
-	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
-	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM;
+	sbi->feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	sbi->feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM;
 
 	/* generate a default uuid first */
 #ifdef HAVE_LIBUUID
 	do {
-		uuid_generate(sbi.uuid);
-	} while (uuid_is_null(sbi.uuid));
+		uuid_generate(sbi->uuid);
+	} while (uuid_is_null(sbi->uuid));
 #endif
 }
 
@@ -531,11 +533,12 @@ int main(int argc, char **argv)
 	struct timeval t;
 	char uuid_str[37] = "not available";
 	struct erofs_device erofs_dev;
+	struct erofs_sb_info sbi;
 
 	erofs_init_global_configure();
-	erofs_mkfs_default_options();
+	erofs_mkfs_default_options(&sbi);
 
-	err = mkfs_parse_options_cfg(argc, argv);
+	err = mkfs_parse_options_cfg(&sbi, argc, argv);
 	erofs_show_progs(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
@@ -620,7 +623,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = z_erofs_compress_init(erofs_dev, sb_bh);
+	err = z_erofs_compress_init(erofs_dev, &sbi, sb_bh);
 	if (err) {
 		erofs_err("Failed to initialize compressor: %s",
 			  erofs_strerror(err));
@@ -634,20 +637,20 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
-	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
+	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path, &sbi);
 	if (err) {
 		erofs_err("Failed to build shared xattrs: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 
-	root_inode = erofs_mkfs_build_tree_from_path(erofs_dev, NULL, cfg.c_src_path);
+	root_inode = erofs_mkfs_build_tree_from_path(erofs_dev, &sbi, NULL, cfg.c_src_path);
 	if (IS_ERR(root_inode)) {
 		err = PTR_ERR(root_inode);
 		goto exit;
 	}
 
-	root_nid = erofs_lookupnid(root_inode);
+	root_nid = erofs_lookupnid(&sbi, root_inode);
 	erofs_iput(root_inode);
 
 	if (cfg.c_chunkbits) {
@@ -657,7 +660,7 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
-	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
+	err = erofs_mkfs_update_super_block(&sbi, sb_bh, root_nid, &nblocks);
 	if (err)
 		goto exit;
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

