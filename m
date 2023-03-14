Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AE76B8B2B
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 07:21:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PbNhp1dlMz3cJY
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 17:21:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PbNhY4Vyyz3cCn
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Mar 2023 17:21:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdqrTE1_1678774888;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdqrTE1_1678774888)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 14:21:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 4/4] erofs-utils: support arbitary block sizes
Date: Tue, 14 Mar 2023 14:21:21 +0800
Message-Id: <20230314062121.115020-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230314062121.115020-1-hsiangkao@linux.alibaba.com>
References: <20230314062121.115020-1-hsiangkao@linux.alibaba.com>
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

 - Add a new command option for mkfs.erofs;

 - fuse/dump/fsck supports arbitary block sizes (uncompressed files).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/namei.c |  5 ++++-
 lib/super.c |  6 +++---
 mkfs/main.c | 27 +++++++++++++++++++++++----
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/lib/namei.c b/lib/namei.c
index 6ee4925..3d0cf93 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -136,8 +136,11 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		}
 		vi->u.chunkbits = sbi.blkszbits +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
-	} else if (erofs_inode_is_data_compressed(vi->datalayout))
+	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		if (erofs_blksiz() != PAGE_SIZE)
+			return -EOPNOTSUPP;
 		return z_erofs_fill_inode(vi);
+	}
 	return 0;
 bogusimode:
 	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
diff --git a/lib/super.c b/lib/super.c
index ff19493..17f849e 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -68,11 +68,11 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 
 int erofs_read_superblock(void)
 {
-	char data[EROFS_MAX_BLOCK_SIZE];
+	u8 data[EROFS_MAX_BLOCK_SIZE];
 	struct erofs_super_block *dsb;
 	int ret;
 
-	ret = blk_read(0, data, 0, 1);
+	ret = blk_read(0, data, 0, erofs_blknr(sizeof(data)));
 	if (ret < 0) {
 		erofs_err("cannot read erofs superblock: %d", ret);
 		return -EIO;
@@ -89,7 +89,7 @@ int erofs_read_superblock(void)
 
 	sbi.blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (1u << sbi.blkszbits != PAGE_SIZE) {
+	if (sbi.blkszbits < 9) {
 		erofs_err("blksize %d isn't supported on this platform",
 			  erofs_blksiz());
 		return ret;
diff --git a/mkfs/main.c b/mkfs/main.c
index b4e4c8d..f4d2330 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -82,6 +82,7 @@ static void usage(void)
 {
 	fputs("usage: [options] FILE DIRECTORY\n\n"
 	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
+	      " -b#                   set block size to # (# = page size by default)\n"
 	      " -d#                   set output message level to # (maximum 9)\n"
 	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -zX[,Y][:..]          X=compressor (Y=compression level, optional)\n"
@@ -273,7 +274,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	int opt, i;
 	bool quiet = false;
 
-	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:d:x:z:",
+	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -287,6 +288,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return i;
 			break;
 
+		case 'b':
+			i = atoi(optarg);
+			if (i < 512 || i > EROFS_MAX_BLOCK_SIZE) {
+				erofs_err("invalid block size %s", optarg);
+				return -EINVAL;
+			}
+			sbi.blkszbits = ilog2(i);
+			break;
+
 		case 'd':
 			i = atoi(optarg);
 			if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
@@ -515,7 +525,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_dbg_lvl = EROFS_ERR;
 		cfg.c_showprogress = false;
 	}
-
+	if (cfg.c_compr_alg[0] && erofs_blksiz() != PAGE_SIZE) {
+		erofs_err("compression is unsupported for now with block size %u",
+			  erofs_blksiz());
+		return -EINVAL;
+	}
 	if (pclustersize_max) {
 		if (pclustersize_max < erofs_blksiz() ||
 		    pclustersize_max % erofs_blksiz()) {
@@ -597,9 +611,10 @@ static int erofs_mkfs_superblock_csum_set(void)
 	int ret;
 	u8 buf[EROFS_MAX_BLOCK_SIZE];
 	u32 crc;
+	unsigned int len;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(0, buf, 0, 1);
+	ret = blk_read(0, buf, 0, erofs_blknr(sizeof(buf)));
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
@@ -620,7 +635,11 @@ static int erofs_mkfs_superblock_csum_set(void)
 	/* turn on checksum feature */
 	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
 					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
-	crc = erofs_crc32c(~0, (u8 *)sb, erofs_blksiz() - EROFS_SUPER_OFFSET);
+	if (erofs_blksiz() > EROFS_SUPER_OFFSET)
+		len = erofs_blksiz() - EROFS_SUPER_OFFSET;
+	else
+		len = erofs_blksiz();
+	crc = erofs_crc32c(~0, (u8 *)sb, len);
 
 	/* set up checksum field to erofs_super_block */
 	sb->checksum = cpu_to_le32(crc);
-- 
2.24.4

