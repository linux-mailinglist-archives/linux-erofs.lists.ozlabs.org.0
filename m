Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7DCC468
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Oct 2019 22:47:10 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46lMPP6X4fzDqgP
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Oct 2019 06:47:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570222025;
	bh=wC2bxsyS0UYSk13lE860WDcydnLp2TBaZ4QN4kRfQcI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KHk9m7zLi+vNwOt9MEBYznzmQmEyHrJ9wV7AytnK0Z2QueDapstbbSwEr0bvB1ABg
	 ECXspYOzMYCNlOW7gIVwWPhXiS3pDEBPCjcM51aStw8VHtLNI+xkLkOsmxjxQ70nJh
	 ygVIe1UqGmTM/i2gnOaOpQp2QEq14dsD5v+NBBTdBIdE79llmkG8G3i69jho/bYlYY
	 e0BVqpGwoIy+cwMktynbTqXMsLdsyrbgS7GjxL3noIhxT59mCrWcCcg/WP/asZ06Iu
	 Ggzp3mthaFk/F9BsxCMRx0etVOJfPYiir4iAC416BflwFd+1Z7qHyTZbOwecTG0r9p
	 qhUHmqAo5UKiA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.31; helo=sonic315-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="YqnRErXH"; 
 dkim-atps=neutral
Received: from sonic315-55.consmr.mail.gq1.yahoo.com
 (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46lMP6520VzDqf0
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Oct 2019 06:46:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570222007; bh=WA/K27eGBBjTm317LQ8NxPXyt/oK9yhUK+ZcoxWd8bg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=YqnRErXHP+TIrtcixr5RUxx0O95yaQpByag35gZo5mjG4mvx9jrOdpuHNl29aD5yunRaknI2PpDG+73X7yS8FRnQ2FNvS9C+Hfe6sFqRlK8FUHn06wTb/Agp/kazLFCQ5OIda7Bizg2aaY/qleMGh9JncO/oW15JgQK30EgkmuALk05gSA9xBm3XUgVurt3uq3SLQJ/kq3w+zqJUI03GcQ5hdxOQGB2V0IUxqJEWSPR+WDw+tvgcZUDQgG3uVEMWv50OzdyO/ew336S+T2g0NQ/JhzL7x/zv2CQIteS71ZiOgKlUAliuijuVpQZUyNclK0WV+dZMInkIHEZdEWSDMw==
X-YMail-OSG: kCm0FroVM1lFWZlOe6D9d5cqO0ldaNfkvNKDpqo74hlhTFEtu.yu_lBzdk5yLfY
 n7h6.ArqYlKIm3GCKeWdlQ17fK0V6zuK.nwIaCmUbauvtkn8j_ked94eJ76DgWYwapGkIW1Pr__o
 BnBoWpKSBYhFxNS8rlT7CURHMPtZj.NeQGFbWyHIuUP.bDJhqEI.MwslSDHyeDu5ZVh3zH7sddIX
 lSXt0B9pvQ21yLEHr7E38ZSv7Jql5Dwyfeqew3GrGaDAX8SA2NKcP5xbgDSJvM0e6JV31_jzLEeN
 EFL41HApXHiTPBEHY1R0N1WilQYJK0y6OSdluR10MfYmGqym2FPhU0eW.0.UijcphqTmH1pa9tNt
 bFrHlzc60wsmjRKqYXBY2SRIGcJY.QLGw5uYtTNdqDf26cUQQmr0tV_NcUo.mj4EgUfbVO2pFl1k
 4lWUYrGAVOEBr3t_D9yExEprSapo_qYJB0d6VDxRT18jRzmvBPdShwhZzYbIMqtjgAkxirmukNO4
 arJuC4u6qlVBqi7SUXJXiTo6qhsPMxMUUZDNWC3tUnQCAFAk5Kfmvw27JVH0iAT20LB0WmzzLrS_
 u7fJ7va0W6I77Eg9Y8RKJz1ciihOxbhYvCegsNfPtduTpkq8aA_o32_F3pPHkifS0tkIXOSMrkyR
 1jYosDDaK9_7eyvBevbpuvPukf694wj4id1MmqwEo1DUF14OB2lKt25XfQw0dLS4wJNXWeMbOFLO
 YIXgh7cJRBSSmu.JEPZSYpSWe2O8QhwFblMKbFqvE52CF9L9JtkZOoV3OBU5PBEn2PQj4GvhHLaj
 sjUu_1vXGBfuGSQoQ6ApWUg_al.43ympjdyiHQKbgQG6yEO409pGmD4wBS0wnCXKE4LZ9S1wzY28
 AGlUS6FHbMTej6QaZHQ7vW8eWEH9SL0Ibg9rY6zqQV_87NmIv6BWbHGjzyNJ5SX3kpYu4cz6R9r7
 v.T7rGV5W4Pngd4z9E7HTK8FPM4kJ_xSeI.gK.dgSw4OA_7KqaonM77GdASQ8CKxxMGhDZulVZx9
 N.U53aElmP94e1ShO6RbdoZBx_QBl8wgGdearsBDJh5WVM.TgKYkWYzK4OHAlDNtHXpoCgcmWGIO
 wCvkPiCNiX_xmPXL3H0BpppfH88c1R_u9GRSK6Vg7KFaUKPy3AQ43j_X0QCnV1FiLBVjg50G3q5P
 pIgN8yp6w6biPcvFflBsFnkGcXgjlQEv8x67yRNDMEBTe8DHCV7JaAzk5LtptU41QgDRPpANi3.E
 UFLte7Q4t6Xkk7cKYUAFa_RsGF8tApzuQnGddG6OyEvxAuPL47QAPruOlUmOBaBl4jmyZSm_i34I
 Mo_YPNgCp2K7u
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Fri, 4 Oct 2019 20:46:47 +0000
Received: by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID deb090a1363bdefbed1275484c094855; 
 Fri, 04 Oct 2019 20:46:45 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: complete extended inode support
Date: Sat,  5 Oct 2019 04:46:30 +0800
Message-Id: <20191004204630.22696-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004204630.22696-1-hsiangkao@aol.com>
References: <20191004204630.22696-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

There is no requirement to use extended inode (v2)
for Android, but it's obviously useful for wider
use cases.

extended inode was partially supported by obsoleted_mkfs,
complete for new erofs-utils as well.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/config.h   |   6 ++
 include/erofs/internal.h |   2 +
 lib/compress.c           |   4 +-
 lib/config.c             |   1 +
 lib/inode.c              | 119 +++++++++++++++++++++++++++++++--------
 mkfs/main.c              |  26 +++++++--
 6 files changed, 125 insertions(+), 33 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 05fe6b2..8b09430 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -11,6 +11,11 @@
 
 #include "defs.h"
 
+enum {
+	FORCE_INODE_COMPACT = 1,
+	FORCE_INODE_EXTENDED,
+};
+
 struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
@@ -22,6 +27,7 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
+	int c_force_inodeversion;
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 07a32d2..5384946 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -53,6 +53,8 @@ struct erofs_sb_info {
 	erofs_blk_t xattr_blkaddr;
 
 	u32 feature_incompat;
+	u64 build_time;
+	u32 build_time_nsec;
 };
 
 /* global sbi */
diff --git a/lib/compress.c b/lib/compress.c
index 7935fce..7f65e5e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -423,8 +423,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	remaining = inode->i_size;
 
 	while (remaining) {
-		const uint readcount = min_t(uint, remaining,
-					     sizeof(ctx.queue) - ctx.tail);
+		const u64 readcount = min_t(u64, remaining,
+					    sizeof(ctx.queue) - ctx.tail);
 
 		ret = read(fd, ctx.queue + ctx.tail, readcount);
 		if (ret != readcount) {
diff --git a/lib/config.c b/lib/config.c
index 9c78142..110c8b6 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -22,6 +22,7 @@ void erofs_init_configure(void)
 	cfg.c_legacy_compress = false;
 	cfg.c_compr_level_master = -1;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	cfg.c_force_inodeversion = 0;
 }
 
 void erofs_show_config(void)
diff --git a/lib/inode.c b/lib/inode.c
index 4e1e29f..d1f294a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -8,6 +8,7 @@
  * with heavy changes by Gao Xiang <gaoxiang25@huawei.com>
  */
 #define _GNU_SOURCE
+#include <limits.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -365,40 +366,81 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
 	erofs_off_t off = erofs_btell(bh, false);
-
-	/* let's support compact inode currently */
-	struct erofs_inode_compact dic = {0};
+	union {
+		struct erofs_inode_compact dic;
+		struct erofs_inode_extended die;
+	} u = { {0}, };
 	int ret;
 
-	dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
-	dic.i_mode = cpu_to_le16(inode->i_mode);
-	dic.i_nlink = cpu_to_le16(inode->i_nlink);
-	dic.i_size = cpu_to_le32((u32)inode->i_size);
+	switch (inode->inode_isize) {
+	case sizeof(struct erofs_inode_compact):
+		u.dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
+		u.dic.i_mode = cpu_to_le16(inode->i_mode);
+		u.dic.i_nlink = cpu_to_le16(inode->i_nlink);
+		u.dic.i_size = cpu_to_le32((u32)inode->i_size);
 
-	dic.i_ino = cpu_to_le32(inode->i_ino[0]);
+		u.dic.i_ino = cpu_to_le32(inode->i_ino[0]);
 
-	dic.i_uid = cpu_to_le16((u16)inode->i_uid);
-	dic.i_gid = cpu_to_le16((u16)inode->i_gid);
+		u.dic.i_uid = cpu_to_le16((u16)inode->i_uid);
+		u.dic.i_gid = cpu_to_le16((u16)inode->i_gid);
 
-	switch ((inode->i_mode) >> S_SHIFT) {
-	case S_IFCHR:
-	case S_IFBLK:
-	case S_IFIFO:
-	case S_IFSOCK:
-		dic.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
+		switch ((inode->i_mode) >> S_SHIFT) {
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
+			u.dic.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
+			break;
+
+		default:
+			if (is_inode_layout_compression(inode))
+				u.dic.i_u.compressed_blocks =
+					cpu_to_le32(inode->u.i_blocks);
+			else
+				u.dic.i_u.raw_blkaddr =
+					cpu_to_le32(inode->u.i_blkaddr);
+			break;
+		}
 		break;
+	case sizeof(struct erofs_inode_extended):
+		u.die.i_format = cpu_to_le16(1 | (inode->datalayout << 1));
+		u.die.i_mode = cpu_to_le16(inode->i_mode);
+		u.die.i_nlink = cpu_to_le32(inode->i_nlink);
+		u.die.i_size = cpu_to_le64(inode->i_size);
+
+		u.die.i_ino = cpu_to_le32(inode->i_ino[0]);
+
+		u.die.i_uid = cpu_to_le16(inode->i_uid);
+		u.die.i_gid = cpu_to_le16(inode->i_gid);
+
+		u.die.i_ctime = cpu_to_le64(inode->i_ctime);
+		u.die.i_ctime_nsec = cpu_to_le32(inode->i_ctime_nsec);
+
+		switch ((inode->i_mode) >> S_SHIFT) {
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
+			u.die.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
+			break;
 
-	default:
-		if (is_inode_layout_compression(inode))
-			dic.i_u.compressed_blocks =
-				cpu_to_le32(inode->u.i_blocks);
-		else
-			dic.i_u.raw_blkaddr =
-				cpu_to_le32(inode->u.i_blkaddr);
+		default:
+			if (is_inode_layout_compression(inode))
+				u.die.i_u.compressed_blocks =
+					cpu_to_le32(inode->u.i_blocks);
+			else
+				u.die.i_u.raw_blkaddr =
+					cpu_to_le32(inode->u.i_blkaddr);
+			break;
+		}
 		break;
+	default:
+		erofs_err("unsupported on-disk inode version of nid %llu",
+			  (unsigned long long)inode->nid);
+		BUG_ON(1);
 	}
 
-	ret = dev_write(&dic, off, sizeof(struct erofs_inode_compact));
+	ret = dev_write(&u, off, inode->inode_isize);
 	if (ret)
 		return false;
 	off += inode->inode_isize;
@@ -578,6 +620,21 @@ out:
 	return 0;
 }
 
+bool erofs_should_use_inode_extended(struct erofs_inode *inode)
+{
+	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
+		return true;
+	if (inode->i_size > UINT_MAX)
+		return true;
+	if (inode->i_uid > USHRT_MAX)
+		return true;
+	if (inode->i_gid > USHRT_MAX)
+		return true;
+	if (inode->i_nlink > USHRT_MAX)
+		return true;
+	return false;
+}
+
 static u32 erofs_new_encode_dev(dev_t dev)
 {
 	const unsigned int major = major(dev);
@@ -593,6 +650,8 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_mode = st->st_mode;
 	inode->i_uid = st->st_uid;
 	inode->i_gid = st->st_gid;
+	inode->i_ctime = sbi.build_time;
+	inode->i_ctime_nsec = sbi.build_time_nsec;
 	inode->i_nlink = 1;	/* fix up later if needed */
 
 	switch (inode->i_mode & S_IFMT) {
@@ -616,7 +675,17 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
 
 	inode->i_ino[1] = st->st_ino;
-	inode->inode_isize = sizeof(struct erofs_inode_compact);
+
+	if (erofs_should_use_inode_extended(inode)) {
+		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+			erofs_err("file %s cannot be in compact form",
+				  inode->i_srcpath);
+			return -EINVAL;
+		}
+		inode->inode_isize = sizeof(struct erofs_inode_extended);
+	} else {
+		inode->inode_isize = sizeof(struct erofs_inode_compact);
+	}
 
 	list_add(&inode->i_hash,
 		 &inode_hashtable[st->st_ino % NR_INODE_HASHTABLE]);
diff --git a/mkfs/main.c b/mkfs/main.c
index effc26b..4b279c0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -72,6 +72,18 @@ static int parse_extended_opts(const char *opts)
 			sbi.feature_incompat &=
 				~EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 		}
+
+		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
+		}
+
+		if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
+		}
 	}
 	return 0;
 }
@@ -153,6 +165,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
 		.blkszbits = LOG_BLOCK_SIZE,
 		.inos   = 0,
+		.build_time = cpu_to_le64(sbi.build_time),
+		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
 		.blocks = 0,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
@@ -161,12 +175,6 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
 	char *buf;
-	struct timeval t;
-
-	if (!gettimeofday(&t, NULL)) {
-		sb.build_time      = cpu_to_le64(t.tv_sec);
-		sb.build_time_nsec = cpu_to_le32(t.tv_usec);
-	}
 
 	*blocks         = erofs_mapbh(NULL, true);
 	sb.blocks       = cpu_to_le32(*blocks);
@@ -193,6 +201,7 @@ int main(int argc, char **argv)
 	erofs_nid_t root_nid;
 	struct stat64 st;
 	erofs_blk_t nblocks;
+	struct timeval t;
 
 	erofs_init_configure();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
@@ -214,6 +223,11 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (!gettimeofday(&t, NULL)) {
+		sbi.build_time      = t.tv_sec;
+		sbi.build_time_nsec = t.tv_usec;
+	}
+
 	err = dev_open(cfg.c_img_path);
 	if (err) {
 		usage();
-- 
2.17.1

