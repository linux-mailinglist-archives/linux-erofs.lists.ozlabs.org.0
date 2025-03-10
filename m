Return-Path: <linux-erofs+bounces-36-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF0A59059
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:55:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBC1Z4Qpsz30WX;
	Mon, 10 Mar 2025 20:55:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741600514;
	cv=none; b=B97zgan/kQeBRBGul6mbkKJI0BVYyNEyIsw1sBdxACxYIUWJwxULGaSaeg30AX2Z/1CLowAUftFASUmKMhJKus62lpc97HqdAnOqgksRgrbcis7KyaeiIPdIm5XQCsF6NxYAY6wO4TytzwqGa9uVHfFv7gXOkUDmQRGpLtcvlgxN380puEvmp41LMWxa8xtsweY/w9PFnEW6waoUH0rMAsM+q3JxMsrDqwuhhF/C5kn91VZ0C6t1YS81g9pDJKXePjO1VEh6baTh/ucnSfNTLSoGXgrEDNyL3Uk2PyyMyP9gq8YrEww4As/1CSYilcFfEtquaJ5QuQwD8LHfiz24oA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741600514; c=relaxed/relaxed;
	bh=dPqt8cykj9yE5zj2nUPmPKdQRAButXykg1ZWEVJBkQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUrf6Wk098+7LhMwEHLxghk2t0CsM46oyS3r3U51nEFVX45XVILF4cp8mpjMH4KGzgjpwW3VRWNWpAW2CntDxT4lCm84tpFJhU97Yr6Fla7NJeEGuGQRM2K6Z+tk+7Zec8Z45sgB6UEojboagquSgx7yLQZh5v7nBjfi0mmBj/m0DMWD+qyH3FhZsGuvxFVmqOAuKqklqxRrqOXS9LtPpFl2FMRInAIem6CYAwn95adjNYSynWhZ4iJVLmi3t9ayuB0QsImavF2uaI3OEnzV+tW+dKEtfdJTEbCyyiUXDv3Vd6WHAe9TlUZvMW5IXdw5c44i6sgB5u6V1sivqKCE6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Yt3N8ESk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Yt3N8ESk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBC1W5T4Qz30Ss
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:55:11 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600507; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dPqt8cykj9yE5zj2nUPmPKdQRAButXykg1ZWEVJBkQM=;
	b=Yt3N8ESkc9Sj7RKJCX/lvQ89Kf2PrdAapduWxqHXIeUMusahYgLKxpg4OHWA2L3WbST9erJiEymH/RrO8cxs7vfcbbUDT96miigsu1R6ZE8REacDgo+vL37Br3qvMBE7qMBtrI+HOvV4WKqMlSTlGiZD2++hpDpTSrDCc5MxzZc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3yP_1741600506 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 03/10] erofs: add 48-bit block addressing on-disk support
Date: Mon, 10 Mar 2025 17:54:53 +0800
Message-ID: <20250310095459.2620647-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

The current 32-bit block addressing limits EROFS to a 16TiB maximum
volume size with 4KiB blocks.  However, several new use cases now
require larger capacity support:
 - Massive datasets for model training in order to boost random
   sampling performance for each epoch;

 - Object storage clients using EROFS direct passthrough.

This extends core on-disk structures to support 48-bit block addressing,
such as inodes, device slots, and inode chunks.

Additionally:
 - Expand superblock root NID to 8-byte `rootnid_8b` to enable full
   out-of-place update incremental builds;

 - Introduce `epoch` field in the superblock as well as add `mtime`
   field to 32-byte compact inodes for basic timestamp support.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 15 ++++----
 fs/erofs/erofs_fs.h | 91 +++++++++++++++++++++------------------------
 fs/erofs/inode.c    |  6 +--
 fs/erofs/internal.h |  6 +--
 fs/erofs/super.c    | 12 +++---
 5 files changed, 61 insertions(+), 69 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2f45e39ce8c7..3c4a4eaffe8c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -95,7 +95,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 
 		map->m_flags = EROFS_MAP_MAPPED;
 		if (map->m_la < pos) {
-			map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
+			map->m_pa = erofs_pos(sb, vi->startblk) + map->m_la;
 			map->m_llen = pos - map->m_la;
 		} else {
 			map->m_pa = erofs_iloc(inode) + vi->inode_isize +
@@ -124,7 +124,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	map->m_llen = min_t(erofs_off_t, 1UL << vi->chunkbits,
 			    round_up(inode->i_size - map->m_la, blksz));
 	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
-		startblk = le32_to_cpu(idx->blkaddr);
+		startblk = le32_to_cpu(idx->startblk_lo);
 		if (startblk != EROFS_NULL_ADDR) {
 			map->m_deviceid = le16_to_cpu(idx->device_id) &
 				EROFS_SB(sb)->device_id_mask;
@@ -168,7 +168,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 {
 	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
 	struct erofs_device_info *dif;
-	erofs_off_t startoff, length;
+	erofs_off_t startoff;
 	int id;
 
 	erofs_fill_from_devinfo(map, sb, &EROFS_SB(sb)->dif0);
@@ -181,7 +181,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			return -ENODEV;
 		}
 		if (devs->flatdev) {
-			map->m_pa += erofs_pos(sb, dif->mapped_blkaddr);
+			map->m_pa += erofs_pos(sb, dif->uniaddr);
 			up_read(&devs->rwsem);
 			return 0;
 		}
@@ -190,13 +190,12 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
-			if (!dif->mapped_blkaddr)
+			if (!dif->uniaddr)
 				continue;
 
-			startoff = erofs_pos(sb, dif->mapped_blkaddr);
-			length = erofs_pos(sb, dif->blocks);
+			startoff = erofs_pos(sb, dif->uniaddr);
 			if (map->m_pa >= startoff &&
-			    map->m_pa < startoff + length) {
+			    map->m_pa < startoff + erofs_pos(sb, dif->blocks)) {
 				map->m_pa -= startoff;
 				erofs_fill_from_devinfo(map, sb, dif);
 				break;
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 199395ed1c1f..8330ca3b18d3 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -30,25 +30,19 @@
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
+#define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
-	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
-	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
-	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
-	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
-	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
-	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
-	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
-	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
-	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES)
+	((EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
 struct erofs_deviceslot {
 	u8 tag[64];		/* digest(sha256), etc. */
-	__le32 blocks;		/* total fs blocks of this device */
-	__le32 mapped_blkaddr;	/* map starting at mapped_blkaddr */
-	u8 reserved[56];
+	__le32 blocks_lo;	/* total blocks count of this device */
+	__le32 uniaddr_lo;	/* unified starting block of this device */
+	__le32 blocks_hi;	/* total blocks count MSB */
+	__le16 uniaddr_hi;	/* unified starting block MSB */
+	u8 reserved[50];
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
 
@@ -59,13 +53,14 @@ struct erofs_super_block {
 	__le32 feature_compat;
 	__u8 blkszbits;         /* filesystem block size in bit shift */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
-
-	__le16 root_nid;	/* nid of root directory */
+	union {
+		__le16 rootnid_2b;	/* nid of root directory */
+		__le16 blocks_hi;	/* (48BIT on) blocks count MSB */
+	} rb;
 	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
-
-	__le64 build_time;      /* compact inode time derivation */
-	__le32 build_time_nsec;	/* compact inode time derivation in ns scale */
-	__le32 blocks;          /* used for statfs */
+	__le64 epoch;		/* base seconds used for compact inodes */
+	__le32 fixed_nsec;	/* fixed nanoseconds for compact inodes */
+	__le32 blocks_lo;	/* blocks count LSB */
 	__le32 meta_blkaddr;	/* start block address of metadata area */
 	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
 	__u8 uuid[16];          /* 128-bit uuid for volume */
@@ -84,7 +79,10 @@ struct erofs_super_block {
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved2[23];
+	__u8 reserved[3];
+	__le32 build_time;	/* seconds added to epoch for mkfs time */
+	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
+	__u8 reserved2[8];
 };
 
 /*
@@ -115,19 +113,18 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_MASK            0x01
 #define EROFS_I_DATALAYOUT_MASK         0x07
 
-#define EROFS_I_VERSION_BIT             0
-#define EROFS_I_DATALAYOUT_BIT          1
-#define EROFS_I_ALL_BIT			4
-
-#define EROFS_I_ALL	((1 << EROFS_I_ALL_BIT) - 1)
+#define EROFS_I_VERSION_BIT	0
+#define EROFS_I_DATALAYOUT_BIT	1
+#define EROFS_I_NLINK_1_BIT	4	/* non-directory compact inodes only */
+#define EROFS_I_ALL		((1 << (EROFS_I_NLINK_1_BIT + 1)) - 1)
 
 /* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
 #define EROFS_CHUNK_FORMAT_BLKBITS_MASK		0x001F
-/* with chunk indexes or just a 4-byte blkaddr array */
+/* with chunk indexes or just a 4-byte block array */
 #define EROFS_CHUNK_FORMAT_INDEXES		0x0020
+#define EROFS_CHUNK_FORMAT_48BIT		0x0040
 
-#define EROFS_CHUNK_FORMAT_ALL	\
-	(EROFS_CHUNK_FORMAT_BLKBITS_MASK | EROFS_CHUNK_FORMAT_INDEXES)
+#define EROFS_CHUNK_FORMAT_ALL	((EROFS_CHUNK_FORMAT_48BIT << 1) - 1)
 
 /* 32-byte on-disk inode */
 #define EROFS_INODE_LAYOUT_COMPACT	0
@@ -140,45 +137,40 @@ struct erofs_inode_chunk_info {
 };
 
 union erofs_inode_i_u {
-	/* total compressed blocks for compressed inodes */
-	__le32 compressed_blocks;
-
-	/* block address for uncompressed flat inodes */
-	__le32 raw_blkaddr;
-
-	/* for device files, used to indicate old/new device # */
-	__le32 rdev;
-
-	/* for chunk-based files, it contains the summary info */
+	__le32 blocks_lo;	/* total blocks count (if compressed inodes) */
+	__le32 startblk_lo;	/* starting block number (if flat inodes) */
+	__le32 rdev;		/* device ID (if special inodes) */
 	struct erofs_inode_chunk_info c;
 };
 
+union erofs_inode_i_nb {
+	__le16 nlink;		/* if EROFS_I_NLINK_1_BIT is unset */
+	__le16 blocks_hi;	/* total blocks count MSB */
+	__le16 startblk_hi;	/* starting block number MSB */
+};
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
-
-/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
 	__le16 i_xattr_icount;
 	__le16 i_mode;
-	__le16 i_nlink;
+	union erofs_inode_i_nb i_nb;
 	__le32 i_size;
-	__le32 i_reserved;
+	__le32 i_mtime;
 	union erofs_inode_i_u i_u;
 
 	__le32 i_ino;		/* only used for 32-bit stat compatibility */
 	__le16 i_uid;
 	__le16 i_gid;
-	__le32 i_reserved2;
+	__le32 i_reserved;
 };
 
 /* 64-byte complete form of an ondisk inode */
 struct erofs_inode_extended {
 	__le16 i_format;	/* inode format hints */
-
-/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
 	__le16 i_xattr_icount;
 	__le16 i_mode;
-	__le16 i_reserved;
+	union erofs_inode_i_nb i_nb;
 	__le64 i_size;
 	union erofs_inode_i_u i_u;
 
@@ -248,6 +240,7 @@ static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
 	if (!i_xattr_icount)
 		return 0;
 
+	/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
 	return sizeof(struct erofs_xattr_ibody_header) +
 		sizeof(__u32) * (le16_to_cpu(i_xattr_icount) - 1);
 }
@@ -266,11 +259,11 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 /* 4-byte block address array */
 #define EROFS_BLOCK_MAP_ENTRY_SIZE	sizeof(__le32)
 
-/* 8-byte inode chunk indexes */
+/* 8-byte inode chunk index */
 struct erofs_inode_chunk_index {
-	__le16 advise;		/* always 0, don't care for now */
+	__le16 startblk_hi;	/* starting block number MSB */
 	__le16 device_id;	/* back-end storage id (with bits masked) */
-	__le32 blkaddr;		/* start block address of this inode chunk */
+	__le32 startblk_lo;	/* starting block number of this chunk */
 };
 
 /* dirent sorts in alphabet order, thus we can do binary search */
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index c8ede541c239..e74c0c00aa26 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -108,7 +108,7 @@ static int erofs_read_inode(struct inode *inode)
 		iu = dic->i_u;
 		i_uid_write(inode, le16_to_cpu(dic->i_uid));
 		i_gid_write(inode, le16_to_cpu(dic->i_gid));
-		set_nlink(inode, le16_to_cpu(dic->i_nlink));
+		set_nlink(inode, le16_to_cpu(dic->i_nb.nlink));
 		inode_set_mtime(inode, sbi->build_time, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
@@ -129,7 +129,7 @@ static int erofs_read_inode(struct inode *inode)
 	case S_IFREG:
 	case S_IFDIR:
 	case S_IFLNK:
-		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
+		vi->startblk = le32_to_cpu(iu.startblk_lo);
 		if(S_ISLNK(inode->i_mode)) {
 			err = erofs_fill_symlink(inode, ptr, ofs);
 			if (err)
@@ -152,7 +152,7 @@ static int erofs_read_inode(struct inode *inode)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout))
-		inode->i_blocks = le32_to_cpu(iu.compressed_blocks) <<
+		inode->i_blocks = le32_to_cpu(iu.blocks_lo) <<
 					(sb->s_blocksize_bits - 9);
 	else
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b357cbbce764..58e401131c75 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,8 +47,8 @@ struct erofs_device_info {
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
-	u32 blocks;
-	u32 mapped_blkaddr;
+	erofs_blk_t blocks;
+	erofs_blk_t uniaddr;
 };
 
 enum {
@@ -252,7 +252,7 @@ struct erofs_inode {
 	unsigned int *xattr_shared_xattrs;
 
 	union {
-		erofs_blk_t raw_blkaddr;
+		erofs_blk_t startblk;
 		struct {
 			unsigned short	chunkformat;
 			unsigned char	chunkbits;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19e52ffa34c5..a64f9765e95e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -178,8 +178,8 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		dif->file = file;
 	}
 
-	dif->blocks = le32_to_cpu(dis->blocks);
-	dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
+	dif->blocks = le32_to_cpu(dis->blocks_lo);
+	dif->uniaddr = le32_to_cpu(dis->uniaddr_lo);
 	sbi->total_blocks += dif->blocks;
 	*pos += EROFS_DEVT_SLOT_SIZE;
 	return 0;
@@ -299,7 +299,7 @@ static int erofs_read_superblock(struct super_block *sb)
 			  sbi->sb_size);
 		goto out;
 	}
-	sbi->dif0.blocks = le32_to_cpu(dsb->blocks);
+	sbi->dif0.blocks = le32_to_cpu(dsb->blocks_lo);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
@@ -308,12 +308,12 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
-	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
-	sbi->build_time = le64_to_cpu(dsb->build_time);
-	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+	sbi->build_time = le64_to_cpu(dsb->epoch);
+	sbi->build_time_nsec = le32_to_cpu(dsb->fixed_nsec);
 
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
 
-- 
2.43.5


