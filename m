Return-Path: <linux-erofs+bounces-30-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712AA58F8E
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:25:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBBM928Vzz30Wg;
	Mon, 10 Mar 2025 20:25:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741598725;
	cv=none; b=oe7YUQN81aHK5AnmW0voNLfZKcm+RXn7Sav/yyS6bPdRe4mlpGbvUASTnaB6B1WmAcp8x3YYJ8yxvri1IY5eP3tOJ7Dt8EXzADxcelKKyGgvbJJUBI3nHs2Or7cN0BUAJtCnAynELt7yuPm9iLANHQm2gLNvECRo7ee3U1N/4k3xl8f6tB7kJT4tZyqfh7mVP8SlnN+PPrrrLITp3rYfDS0JVQA3i256Cf2IYr0s3lDQ8FDE5Pb/t3soWt6cN1aSeiaDPium8oY3fRIt0lP1EDjBKLCPFnYe3/omH9PJvZX8aLgd5tNRuT4fdBLgzZZbilB6NzI7DVSdGhWoPWY/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741598725; c=relaxed/relaxed;
	bh=/XL9bRDjfjFkgAyWu8cx3Z4iSRqt8YCQDoxF1VV/wIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyzAJrPbmyvBJNJeT331luZ0cloXnd7OtXbnTpK1uxfPBxfyWdF8acq3peGI/0WEd/SJGDFNz3MKXWFFyF3KZRYg7sB0exjyI8Z+ASSXmxZ2tqL7CG55OqH7dPViYqJf8Sl6/FYRIyroBM/zcasSPaMumKm76X0gAuZO1VJuG/uUb/OlEuiFa+E8G1EKJkQ38w35Po8/0uhiGah4Jt2jyEN+7ozLSd6e88xwybtzlwX4VruA2/UYwJz/sisDhcJhTjSCzeZhH2vgpOIzfBtWp6uaGOjGtEC7rhLYHLMPpE2V5U7pQJQO/pC+sbPrqAdyg6QJmpTs70/oKX1p3cpIXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W8jP6C0G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W8jP6C0G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBBM51R40z30Ss
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:25:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741598717; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/XL9bRDjfjFkgAyWu8cx3Z4iSRqt8YCQDoxF1VV/wIA=;
	b=W8jP6C0GBgY3znaAgwBBatqfkCE+B+YEYBeBhqQDGr+ayetaS/MBRkD9LIm9C+0U9jkJQZtKgk2ffCsSTyhyAk735TVMZddnSUXUrwRr5+TKilrMygvZal1h2LyxW4ssaHhj6Rdw0k0jXzIWz90eIWRcC8C1OmYJGJCbY77MHgs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR0RN9y_1741598713 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:25:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/7] erofs-utils: lib: sync up with the 48-bit kernel erofs_fs.h
Date: Mon, 10 Mar 2025 17:25:04 +0800
Message-ID: <20250310092508.2573532-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310092508.2573532-1-hsiangkao@linux.alibaba.com>
References: <20250310092508.2573532-1-hsiangkao@linux.alibaba.com>
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

Keep in sync with related kernel commit.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |   4 +-
 include/erofs_fs.h       | 191 ++++++++++++++++++---------------------
 lib/blobchunk.c          |  20 ++--
 lib/compress.c           |   2 +-
 lib/data.c               |   8 +-
 lib/inode.c              |   6 +-
 lib/namei.c              |   4 +-
 lib/super.c              |  16 ++--
 lib/zmap.c               |   2 +-
 9 files changed, 119 insertions(+), 134 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b1b971f..08d33b8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -59,8 +59,8 @@ struct erofs_bufmgr;
 
 struct erofs_device_info {
 	u8 tag[64];
-	u32 blocks;
-	u32 mapped_blkaddr;
+	erofs_blk_t blocks;
+	erofs_blk_t uniaddr;
 };
 
 /* all filesystem-wide lz4 configurations */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 269d302..ce319d7 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -31,25 +31,19 @@
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
+	((EROFS_FEATURE_INCOMPAT_48BIT << 1) - 1)
 
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
 
@@ -60,13 +54,14 @@ struct erofs_super_block {
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
@@ -85,7 +80,10 @@ struct erofs_super_block {
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
@@ -116,19 +114,19 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
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
+#define EROFS_I_DOT_OMITTED_BIT	4	/* (directories) omit the `.` dirent */
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
@@ -141,45 +139,40 @@ struct erofs_inode_chunk_info {
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
 
@@ -249,6 +242,7 @@ static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
 	if (!i_xattr_icount)
 		return 0;
 
+	/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
 	return sizeof(struct erofs_xattr_ibody_header) +
 		sizeof(__u32) * (le16_to_cpu(i_xattr_icount) - 1);
 }
@@ -267,11 +261,11 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
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
@@ -345,21 +339,20 @@ struct z_erofs_zstd_cfgs {
 #define Z_EROFS_ZSTD_MAX_DICT_SIZE      Z_EROFS_PCLUSTER_MAX_SIZE
 
 /*
- * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
- *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
- *                                  (4B) + 2B + (4B) if compacted 2B is on.
- * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
- * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
- * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
- * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
- * bit 5 : fragment pcluster (0 - off; 1 - on)
+ * Enable COMPACTED_2B for EROFS_INODE_COMPRESSED_COMPACT inodes:
+ *   4B (disabled) vs 4B+2B+4B (enabled)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
+/* Enable extent metadata for EROFS_INODE_COMPRESSED_FULL inodes */
+#define Z_EROFS_ADVISE_EXTENTS			0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
 #define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
 #define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0020
+/* Indicate the record size for each extent if extent metadata is used */
+#define Z_EROFS_ADVISE_EXTRECSZ_BIT		1
+#define Z_EROFS_ADVISE_EXTRECSZ_MASK		0x3
 
 #define Z_EROFS_FRAGMENT_INODE_BIT              7
 struct z_erofs_map_header {
@@ -371,45 +364,24 @@ struct z_erofs_map_header {
 			/* indicates the encoded size of tailpacking data */
 			__le16  h_idata_size;
 		};
+		__le32 h_extents_lo;	/* extent count LSB */
 	};
 	__le16	h_advise;
-	/*
-	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
-	 * bit 4-7 : algorithm type of head 2 (logical cluster type 11).
-	 */
-	__u8	h_algorithmtype;
-	/*
-	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-6 : reserved;
-	 * bit 7   : move the whole file into packed inode or not.
-	 */
-	__u8	h_clusterbits;
+	union {
+		struct {
+			/* algorithm type (bit 0-3: HEAD1; bit 4-7: HEAD2) */
+			__u8	h_algorithmtype;
+			/*
+			 * bit 0-3 : logical cluster bits - blkszbits
+			 * bit 4-6 : reserved
+			 * bit 7   : pack the whole file into packed inode
+			 */
+			__u8	h_clusterbits;
+		};
+		__le16 h_extents_hi;	/* extent count MSB */
+	};
 };
 
-/*
- * On-disk logical cluster type:
- *    0   - literal (uncompressed) lcluster
- *    1,3 - compressed lcluster (for HEAD lclusters)
- *    2   - compressed lcluster (for NONHEAD lclusters)
- *
- * In detail,
- *    0 - literal (uncompressed) lcluster,
- *        di_advise = 0
- *        di_clusterofs = the literal data offset of the lcluster
- *        di_blkaddr = the blkaddr of the literal pcluster
- *
- *    1,3 - compressed lcluster (for HEAD lclusters)
- *        di_advise = 1 or 3
- *        di_clusterofs = the decompressed data offset of the lcluster
- *        di_blkaddr = the blkaddr of the compressed pcluster
- *
- *    2 - compressed lcluster (for NONHEAD lclusters)
- *        di_advise = 2
- *        di_clusterofs =
- *           the decompressed data offset in its own HEAD lcluster
- *        di_u.delta[0] = distance to this HEAD lcluster
- *        di_u.delta[1] = distance to the next HEAD lcluster
- */
 enum {
 	Z_EROFS_LCLUSTER_TYPE_PLAIN	= 0,
 	Z_EROFS_LCLUSTER_TYPE_HEAD1	= 1,
@@ -423,11 +395,7 @@ enum {
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
 #define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
 
-/*
- * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
- * compressed block count of a compressed extent (in logical clusters, aka.
- * block count of a pcluster).
- */
+/* Set on 1st non-head lcluster to store compressed block counti (in blocks) */
 #define Z_EROFS_LI_D0_CBLKCNT		(1 << 11)
 
 struct z_erofs_lcluster_index {
@@ -436,19 +404,36 @@ struct z_erofs_lcluster_index {
 	__le16 di_clusterofs;
 
 	union {
-		/* for the HEAD lclusters */
-		__le32 blkaddr;
+		__le32 blkaddr;		/* for the HEAD lclusters */
 		/*
-		 * for the NONHEAD lclusters
 		 * [0] - distance to its HEAD lcluster
 		 * [1] - distance to the next HEAD lcluster
 		 */
-		__le16 delta[2];
+		__le16 delta[2];	/* for the NONHEAD lclusters */
 	} di_u;
 };
 
-#define Z_EROFS_FULL_INDEX_ALIGN(end)	\
-	(round_up(end, 8) + sizeof(struct z_erofs_map_header) + 8)
+#define Z_EROFS_MAP_HEADER_END(end)	\
+	(round_up(end, 8) + sizeof(struct z_erofs_map_header))
+#define Z_EROFS_FULL_INDEX_START(end)	(Z_EROFS_MAP_HEADER_END(end) + 8)
+
+#define Z_EROFS_EXTENT_PLEN_PARTIAL	BIT(27)
+#define Z_EROFS_EXTENT_PLEN_FMT_BIT	28
+#define Z_EROFS_EXTENT_PLEN_MASK	((Z_EROFS_PCLUSTER_MAX_SIZE << 1) - 1)
+struct z_erofs_extent {
+	__le32 plen;		/* encoded length */
+	__le32 pstart_lo;	/* physical offset */
+	__le32 pstart_hi;	/* physical offset MSB */
+	__le32 lstart_lo;	/* logical offset */
+	__le32 lstart_hi;	/* logical offset MSB (>= 4GiB inodes) */
+	__u8 reserved[12];	/* for future use */
+};
+
+static inline int z_erofs_extent_recsize(unsigned int advise)
+{
+	return 4 << ((advise >> Z_EROFS_ADVISE_EXTRECSZ_BIT) &
+		Z_EROFS_ADVISE_EXTRECSZ_MASK);
+}
 
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index e6386d6..799bdd2 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -160,17 +160,17 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		chunk = *(void **)(inode->chunkindexes + src);
 
 		if (chunk->blkaddr == EROFS_NULL_ADDR) {
-			idx.blkaddr = EROFS_NULL_ADDR;
+			idx.startblk_lo = EROFS_NULL_ADDR;
 		} else if (chunk->device_id) {
 			DBG_BUGON(!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES));
-			idx.blkaddr = chunk->blkaddr;
+			idx.startblk_lo = chunk->blkaddr;
 			extent_start = EROFS_NULL_ADDR;
 		} else {
-			idx.blkaddr = remapped_base + chunk->blkaddr;
+			idx.startblk_lo = remapped_base + chunk->blkaddr;
 		}
 
 		if (extent_start == EROFS_NULL_ADDR ||
-		    idx.blkaddr != extent_end) {
+		    idx.startblk_lo != extent_end) {
 			if (extent_start != EROFS_NULL_ADDR) {
 				remaining_blks -= extent_end - extent_start;
 				tarerofs_blocklist_write(extent_start,
@@ -182,15 +182,15 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 					first_extent, false);
 				first_extent = false;
 			}
-			extent_start = idx.blkaddr;
+			extent_start = idx.startblk_lo;
 			source_offset = chunk->sourceoffset;
 		}
-		extent_end = idx.blkaddr + chunkblks;
+		extent_end = idx.startblk_lo + chunkblks;
 		idx.device_id = cpu_to_le16(chunk->device_id);
-		idx.blkaddr = cpu_to_le32(idx.blkaddr);
+		idx.startblk_lo = cpu_to_le32(idx.startblk_lo);
 
 		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
-			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
+			memcpy(inode->chunkindexes + dst, &idx.startblk_lo, unit);
 		else
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
@@ -513,8 +513,8 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 		i = 0;
 		do {
 			struct erofs_deviceslot dis = {
-				.mapped_blkaddr = cpu_to_le32(nblocks),
-				.blocks = cpu_to_le32(sbi->devs[i].blocks),
+				.uniaddr_lo = cpu_to_le32(nblocks),
+				.blocks_lo = cpu_to_le32(sbi->devs[i].blocks),
 			};
 
 			memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
diff --git a/lib/compress.c b/lib/compress.c
index 1072451..97eb776 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -118,7 +118,7 @@ static struct {
 
 static bool z_erofs_mt_enabled;
 
-#define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
+#define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_START(0)
 
 static void z_erofs_fini_full_indexes(struct z_erofs_compress_ictx *ctx)
 {
diff --git a/lib/data.c b/lib/data.c
index fd9c21a..6f6db6d 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -117,14 +117,14 @@ int __erofs_map_blocks(struct erofs_inode *inode,
 	}
 	/* parse chunk indexes */
 	idx = (void *)buf + erofs_blkoff(sbi, pos);
-	switch (le32_to_cpu(idx->blkaddr)) {
+	switch (le32_to_cpu(idx->startblk_lo)) {
 	case EROFS_NULL_ADDR:
 		map->m_flags = 0;
 		break;
 	default:
 		map->m_deviceid = le16_to_cpu(idx->device_id) &
 			sbi->device_id_mask;
-		map->m_pa = erofs_pos(sbi, le32_to_cpu(idx->blkaddr));
+		map->m_pa = erofs_pos(sbi, le32_to_cpu(idx->startblk_lo));
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
 	}
@@ -154,9 +154,9 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 			erofs_off_t startoff, length;
 
 			dif = sbi->devs + id;
-			if (!dif->mapped_blkaddr)
+			if (!dif->uniaddr)
 				continue;
-			startoff = erofs_pos(sbi, dif->mapped_blkaddr);
+			startoff = erofs_pos(sbi, dif->uniaddr);
 			length = erofs_pos(sbi, dif->blocks);
 
 			if (map->m_pa >= startoff &&
diff --git a/lib/inode.c b/lib/inode.c
index ce77682..89a0985 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -604,18 +604,18 @@ int erofs_iflush(struct erofs_inode *inode)
 	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
 		u1.rdev = cpu_to_le32(inode->u.i_rdev);
 	else if (is_inode_layout_compression(inode))
-		u1.compressed_blocks = cpu_to_le32(inode->u.i_blocks);
+		u1.blocks_lo = cpu_to_le32(inode->u.i_blocks);
 	else if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
 		u1.c.format = cpu_to_le16(inode->u.chunkformat);
 	else
-		u1.raw_blkaddr = cpu_to_le32(inode->u.i_blkaddr);
+		u1.startblk_lo = cpu_to_le32(inode->u.i_blkaddr);
 
 	switch (inode->inode_isize) {
 	case sizeof(struct erofs_inode_compact):
 		u.dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
 		u.dic.i_xattr_icount = cpu_to_le16(icount);
 		u.dic.i_mode = cpu_to_le16(inode->i_mode);
-		u.dic.i_nlink = cpu_to_le16(inode->i_nlink);
+		u.dic.i_nb.nlink = cpu_to_le16(inode->i_nlink);
 		u.dic.i_size = cpu_to_le32((u32)inode->i_size);
 
 		u.dic.i_ino = cpu_to_le32(inode->i_ino[0]);
diff --git a/lib/namei.c b/lib/namei.c
index b40f092..66b8eef 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -77,7 +77,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		iu = dic->i_u;
 		vi->i_uid = le16_to_cpu(dic->i_uid);
 		vi->i_gid = le16_to_cpu(dic->i_gid);
-		vi->i_nlink = le16_to_cpu(dic->i_nlink);
+		vi->i_nlink = le16_to_cpu(dic->i_nb.nlink);
 
 		vi->i_mtime = sbi->build_time;
 		vi->i_mtime_nsec = sbi->build_time_nsec;
@@ -94,7 +94,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case S_IFREG:
 	case S_IFDIR:
 	case S_IFLNK:
-		vi->u.i_blkaddr = le32_to_cpu(iu.raw_blkaddr);
+		vi->u.i_blkaddr = le32_to_cpu(iu.startblk_lo);
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
diff --git a/lib/super.c b/lib/super.c
index 6c8fa52..00a1683 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -63,8 +63,8 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 			return ret;
 		}
 
-		sbi->devs[i].mapped_blkaddr = le32_to_cpu(dis.mapped_blkaddr);
-		sbi->devs[i].blocks = le32_to_cpu(dis.blocks);
+		sbi->devs[i].uniaddr = le32_to_cpu(dis.uniaddr_lo);
+		sbi->devs[i].blocks = le32_to_cpu(dis.blocks_lo);
 		memcpy(sbi->devs[i].tag, dis.tag, sizeof(dis.tag));
 		sbi->total_blocks += sbi->devs[i].blocks;
 		pos += EROFS_DEVT_SLOT_SIZE;
@@ -110,19 +110,19 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 			  dsb->sb_extslots);
 		return -EINVAL;
 	}
-	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
+	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks_lo);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
 	sbi->islotbits = EROFS_ISLOTBITS;
-	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
-	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+	sbi->build_time_nsec = le32_to_cpu(dsb->fixed_nsec);
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
 
@@ -161,10 +161,10 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
 		.blkszbits = sbi->blkszbits,
-		.root_nid  = cpu_to_le16(sbi->root_nid),
+		.rb.rootnid_2b  = cpu_to_le16(sbi->root_nid),
 		.inos      = cpu_to_le64(sbi->inos),
 		.build_time = cpu_to_le64(sbi->build_time),
-		.build_time_nsec = cpu_to_le32(sbi->build_time_nsec),
+		.fixed_nsec = cpu_to_le32(sbi->build_time_nsec),
 		.meta_blkaddr  = cpu_to_le32(sbi->meta_blkaddr),
 		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
 		.xattr_prefix_count = sbi->xattr_prefix_count,
@@ -181,7 +181,7 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 	int ret;
 
 	*blocks         = erofs_mapbh(sbi->bmgr, NULL);
-	sb.blocks       = cpu_to_le32(*blocks);
+	sb.blocks_lo	= cpu_to_le32(*blocks);
 	memcpy(sb.uuid, sbi->uuid, sizeof(sb.uuid));
 	memcpy(sb.volume_name, sbi->volume_name, sizeof(sb.volume_name));
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 70ff898..8e70e65 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -30,7 +30,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_sb_info *sbi = vi->sbi;
-	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(erofs_iloc(vi) +
+	const erofs_off_t pos = Z_EROFS_FULL_INDEX_START(erofs_iloc(vi) +
 			vi->inode_isize + vi->xattr_isize) +
 			lcn * sizeof(struct z_erofs_lcluster_index);
 	erofs_blk_t eblk = erofs_blknr(sbi, pos);
-- 
2.43.5


