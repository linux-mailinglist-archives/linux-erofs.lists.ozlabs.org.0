Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAFAB4711
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 07:50:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46XXJP0QTfzF44k
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 15:50:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1568699413;
	bh=wroGM2Qw1Ezw+DzHVoNhAhLcNmF53WzxZCdVT3T3P7A=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YfeeaxYKsftIFUCbj0bA1h6ysVNDOStKNFLPZPaH+GyiJfrrxXUcoO5kmlNt4RV0b
	 lBkRYiuBLsfwnhS19xgkizGur+k35P0fdhYniEwpYLuONn5SfFty7odYe2g5ZZTHK6
	 sk7XiUKuAMLzqXHB/DAC+KuJS6qbCGyi4tgM7QZAx7WHgvXHnhBnZztAaLrSiYhpip
	 UFV2rTLVCoY4BlBoaf9LTrI/dYWjIA4qXLYlDdGCw9whQJ33bFNB3umJJw6xBBsJDT
	 9oXG2yw0UOfYrxe7chSasW02feOmABmv6KQFLw5EadP/H165BJJv649kR4nJ74iWF6
	 t+hUJ0toNtnMg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="BEBvzEjL"; 
 dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46XXHy10vpzF4G7
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2019 15:49:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1568699386; bh=AkuYV7kNJdQEV4Owlx5i/Al+TeMQSYkb6/5o6ib8lmo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=BEBvzEjLBoNkjCp96bB0pQ4DeArF21F7fmu/V0f8F5x0JupV8C+o9v6PturSPQJykjoa7oxXGaabkJiJXtVWhG6XbtfiwSZFg8UHy+l6CyXOmCBqaq+u0lr2pfDRxE6h/cKS51L8N1CgdL9mAmOB1PGWvcfa639C9b6M4E+XkWUF4afTsriK3wt+5Iv5AgPROlO36+kp+ZfaGpCFC6LAS1cuL0tjCNQLQ2pvf/eY3IwJWvqeqEOLlf0lK96+BPAYqpx5AnxHWCOynfhIbjgyjSbXDm5XQbLImu+pm3x5IjlQ8ifukveArF7oWOMdcW/bPIdGWEt2jrEifaKdn40xcA==
X-YMail-OSG: jTIJXE0VM1l9gWDKEcC6A1NafhQti3HYZhTCAobEn.EgNxE2.zN0Zsl5VfEM4FI
 ecw9Ev2BRB46JB0plH2eXZ84puR0JC53cMD6LybctI44npqXV4UVSGXeQPeNrWwZ7Q6gwCQU2CvU
 okHAITJBujMgaSHwIDhotREuaFLJPCGAaziNjWjj5bTp9jvGCG9934jl7C0nKA_N9Any5.Im4joc
 q6MZ3PiJLKbl4EGiuuvr08GZx1NzbQhA4HkJb2Id3TN1cRCbOeORrO0QE11CdQq.TiT_0HmnoaJD
 5QamvYnbaCYAdZt6fqJOHM2mtWVYP88ILOHo2Hmt5cOxdVBrkxcnj7fcNsE0CgvAc68D.EfwoxeA
 yx8gtQfHEQRQsYsRPE0yvmwnOuKFOEamplLVnwunMngZ4GeBodn.DF40fX5fTr8rDOHg4O.IZ28n
 80z1JAlHChaQM5awc65eb6OFSATl_6z6ECkPIOhY2WUdBRISRU2mdnY11PwRGM5TScumSseAEqyo
 0xflJiGvDycYMn9X5OuIgSF521RYNqAabEdqhXtVup6F8dYNHN.suGzBWaauTOmjS6GFCSOoHGxx
 Wl5wobubmgqmAPLqMY.N1F_NRaMKxWgwin3F3huuwMpa7nldPTY3imxTGJh_xsSHpwebbaoqG4VN
 sQFKiX0X6F9LoMWx0HnHXAtBNQB4ksQcdRdUnqTrGphtII2XfWgVi9dLkMpF2bPP.FX7T2Mn2Bjd
 wslmx5fr6NS5UrLE_A5zOZcAqLLobLBSnRt74v.ifbGWYzZulSOUBNXIH0bVqgw0272FpPaq7jOQ
 fUGM93CN9GWHNYkA6ZDyXrucklcpZaLTcYoWTg5p2wrJsDyThq6YkvAClkAqJ4471H8Lo4yv9Me5
 HhNDIfFmIAUkdLinooGbT68CUtAg5PnDKHk1LN25KZPmwQWtg_mrYYCX_nUN1wqgczydYe8wRifh
 78XzEgXbSe_ynUxwzEcj3ACw6fTd3xWypLNugIg7RaEhWXdL_O7Vciq9fW.zpvRo41UNkvVD2lN6
 .HHpNkhF5fDd2yaJOl7dZvkJaSZmn2S7DiTapdPSZO2.6.fwAKeMlrTJqTnl.ax_FYiYl2sQ5S9d
 goY68YVnjYk5jHG9DEvrGT_.CZGlRL6ZE8alQX3PhoGlbhxXqj6QWV2G.0.038LYvIKsUFx5LTYc
 Kf3XncJEggzUhv35_V45SvNLEpjPtgL9EDYw8wim7sGFm8Dny1Vy_prCaxVqUwYe7xKhmyz89iPG
 wCfRLWIZjo4GsZr9tJBpZpl6YP3HZ0SkAbl_8fPaunO38CPN921D2AfNZx5Jfq1X0a193DOijLUG
 uKQJBN2X96nNMuLwH2x2tH8qzoobayS7RGyxVe5uvhz0-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 17 Sep 2019 05:49:46 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0ca914cfda0cd9061c391ed841b64b5d; 
 Tue, 17 Sep 2019 05:49:40 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH 3/3] erofs-utils: keep up with in-kernel ondisk format naming
Date: Tue, 17 Sep 2019 13:49:13 +0800
Message-Id: <20190917054913.24187-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917054913.24187-1-hsiangkao@aol.com>
References: <20190917054913.24187-1-hsiangkao@aol.com>
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

This patch adapts erofs-utils to the latest kernel ondisk definitions,
especially the following kernel commits:

4b66eb51d2c4 erofs: remove all the byte offset comments
60a49ba8fee1 erofs: on-disk format should have explicitly assigned numbers
b6796abd3cc1 erofs: some macros are much more readable as a function
ed34aa4a8a7d erofs: kill __packed for on-disk structures
c39747f770be erofs: update erofs_inode_is_data_compressed helper
426a930891cf erofs: use feature_incompat rather than requirements
8a76568225de erofs: better naming for erofs inode related stuffs
ea559e7b8451 erofs: update erofs_fs.h comments

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/cache.h    |   2 +-
 include/erofs/internal.h |   6 +-
 include/erofs_fs.h       | 198 ++++++++++++++++++++-------------------
 lib/compress.c           |   9 +-
 lib/config.c             |   2 +-
 lib/inode.c              |  42 ++++-----
 mkfs/main.c              |   5 +-
 7 files changed, 137 insertions(+), 127 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 108757a..71df811 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -53,7 +53,7 @@ static inline const int get_alignsize(int type, int *type_ret)
 
 	if (type == INODE) {
 		*type_ret = META;
-		return sizeof(struct erofs_inode_v1);
+		return sizeof(struct erofs_inode_compact);
 	} else if (type == XATTR) {
 		*type_ret = META;
 		return sizeof(struct erofs_xattr_entry);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b7ce6f8..07a32d2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -52,7 +52,7 @@ struct erofs_sb_info {
 	erofs_blk_t meta_blkaddr;
 	erofs_blk_t xattr_blkaddr;
 
-	u32 requirements;
+	u32 feature_incompat;
 };
 
 /* global sbi */
@@ -82,7 +82,7 @@ struct erofs_inode {
 
 	char i_srcpath[PATH_MAX + 1];
 
-	unsigned char data_mapping_mode;
+	unsigned char datalayout;
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
 	unsigned short idata_size;
@@ -100,7 +100,7 @@ struct erofs_inode {
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 {
-	return erofs_inode_is_data_compressed(inode->data_mapping_mode);
+	return erofs_inode_is_data_compressed(inode->datalayout);
 }
 
 #define IS_ROOT(x)	((x) == (x)->i_parent)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 601b477..f29aa25 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
 /*
  * erofs_utils/include/erofs_fs.h
+ * EROFS (Enhanced ROM File System) on-disk format definition
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
@@ -9,41 +10,41 @@
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
 
-/* Enhanced(Extended) ROM File System */
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
 /*
- * Any bits that aren't in EROFS_ALL_REQUIREMENTS should be
- * incompatible with this kernel version.
+ * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
+ * be incompatible with this kernel version.
  */
-#define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
-#define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
+#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
+#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
 
+/* 128-byte erofs on-disk super block */
 struct erofs_super_block {
-/*  0 */__le32 magic;           /* in the little endian */
-/*  4 */__le32 checksum;        /* crc32c(super_block) */
-/*  8 */__le32 features;        /* (aka. feature_compat) */
-/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
-/* 13 */__u8 reserved;
-
-/* 14 */__le16 root_nid;
-/* 16 */__le64 inos;            /* total valid ino # (== f_files - f_favail) */
-
-/* 24 */__le64 build_time;      /* inode v1 time derivation */
-/* 32 */__le32 build_time_nsec;
-/* 36 */__le32 blocks;          /* used for statfs */
-/* 40 */__le32 meta_blkaddr;
-/* 44 */__le32 xattr_blkaddr;
-/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
-/* 64 */__u8 volume_name[16];   /* volume name */
-/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
-
-/* 84 */__u8 reserved2[44];
-} __packed;                     /* 128 bytes */
+	__le32 magic;           /* file system magic number */
+	__le32 checksum;        /* crc32c(super_block) */
+	__le32 feature_compat;
+	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 reserved;
+
+	__le16 root_nid;	/* nid of root directory */
+	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
+
+	__le64 build_time;      /* inode v1 time derivation */
+	__le32 build_time_nsec;	/* inode v1 time derivation in nano scale */
+	__le32 blocks;          /* used for statfs */
+	__le32 meta_blkaddr;	/* start block address of metadata area */
+	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
+	__u8 uuid[16];          /* 128-bit uuid for volume */
+	__u8 volume_name[16];   /* volume name */
+	__le32 feature_incompat;
+
+	__u8 reserved2[44];
+};
 
 /*
- * erofs inode data mapping:
+ * erofs inode datalayout (i_format in on-disk inode):
  * 0 - inode plain without inline data A:
  * inode, [xattrs], ... | ... | no-holed data
  * 1 - inode VLE compression B (legacy):
@@ -55,82 +56,83 @@ struct erofs_super_block {
  * 4~7 - reserved
  */
 enum {
-	EROFS_INODE_FLAT_PLAIN,
-	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
-	EROFS_INODE_FLAT_INLINE,
-	EROFS_INODE_FLAT_COMPRESSION,
-	EROFS_INODE_LAYOUT_MAX
+	EROFS_INODE_FLAT_PLAIN			= 0,
+	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
+	EROFS_INODE_FLAT_INLINE			= 2,
+	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_DATALAYOUT_MAX
 };
 
 static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 {
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
-		return true;
-	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
+		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 }
 
 /* bit definitions of inode i_advise */
 #define EROFS_I_VERSION_BITS            1
-#define EROFS_I_DATA_MAPPING_BITS       3
+#define EROFS_I_DATALAYOUT_BITS         3
 
 #define EROFS_I_VERSION_BIT             0
-#define EROFS_I_DATA_MAPPING_BIT        1
+#define EROFS_I_DATALAYOUT_BIT          1
 
-struct erofs_inode_v1 {
-/*  0 */__le16 i_advise;
+/* 32-byte reduced form of an ondisk inode */
+struct erofs_inode_compact {
+	__le16 i_format;	/* inode format hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_nlink;
-/*  8 */__le32 i_size;
-/* 12 */__le32 i_reserved;
-/* 16 */union {
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_nlink;
+	__le32 i_size;
+	__le32 i_reserved;
+	union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
-	} i_u __packed;
-/* 20 */__le32 i_ino;           /* only used for 32-bit stat compatibility */
-/* 24 */__le16 i_uid;
-/* 26 */__le16 i_gid;
-/* 28 */__le32 i_reserved2;
-} __packed;
+	} i_u;
+	__le32 i_ino;           /* only used for 32-bit stat compatibility */
+	__le16 i_uid;
+	__le16 i_gid;
+	__le32 i_reserved2;
+};
 
 /* 32 bytes on-disk inode */
-#define EROFS_INODE_LAYOUT_V1   0
+#define EROFS_INODE_LAYOUT_COMPACT	0
 /* 64 bytes on-disk inode */
-#define EROFS_INODE_LAYOUT_V2   1
+#define EROFS_INODE_LAYOUT_EXTENDED	1
 
-struct erofs_inode_v2 {
-/*  0 */__le16 i_advise;
+/* 64-byte complete form of an ondisk inode */
+struct erofs_inode_extended {
+	__le16 i_format;	/* inode format hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_reserved;
-/*  8 */__le64 i_size;
-/* 16 */union {
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_reserved;
+	__le64 i_size;
+	union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
-	} i_u __packed;
+	} i_u;
 
 	/* only used for 32-bit stat compatibility */
-/* 20 */__le32 i_ino;
-
-/* 24 */__le32 i_uid;
-/* 28 */__le32 i_gid;
-/* 32 */__le64 i_ctime;
-/* 40 */__le32 i_ctime_nsec;
-/* 44 */__le32 i_nlink;
-/* 48 */__u8   i_reserved2[16];
-} __packed;                     /* 64 bytes */
+	__le32 i_ino;
+
+	__le32 i_uid;
+	__le32 i_gid;
+	__le64 i_ctime;
+	__le32 i_ctime_nsec;
+	__le32 i_nlink;
+	__u8   i_reserved2[16];
+};
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
@@ -152,7 +154,7 @@ struct erofs_xattr_ibody_header {
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[0];      /* shared xattr id array */
-} __packed;
+};
 
 /* Name indexes */
 #define EROFS_XATTR_INDEX_USER              1
@@ -169,22 +171,28 @@ struct erofs_xattr_entry {
 	__le16 e_value_size;    /* size of attribute value */
 	/* followed by e_name and e_value */
 	char   e_name[0];       /* attribute name */
-} __packed;
+};
 
-#define ondisk_xattr_ibody_size(count)	({\
-	u32 __count = le16_to_cpu(count); \
-	((__count) == 0) ? 0 : \
-	sizeof(struct erofs_xattr_ibody_header) + \
-		sizeof(__u32) * ((__count) - 1); })
+static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
+{
+	if (!i_xattr_icount)
+		return 0;
+
+	return sizeof(struct erofs_xattr_ibody_header) +
+		sizeof(__u32) * (le16_to_cpu(i_xattr_icount) - 1);
+}
 
 #define EROFS_XATTR_ALIGN(size) round_up(size, sizeof(struct erofs_xattr_entry))
-#define EROFS_XATTR_ENTRY_SIZE(entry) EROFS_XATTR_ALIGN( \
-	sizeof(struct erofs_xattr_entry) + \
-	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
 
-/* available compression algorithm types */
+static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
+{
+	return EROFS_XATTR_ALIGN(sizeof(struct erofs_xattr_entry) +
+				 e->e_name_len + le16_to_cpu(e->e_value_size));
+}
+
+/* available compression algorithm types (for h_algorithmtype) */
 enum {
-	Z_EROFS_COMPRESSION_LZ4,
+	Z_EROFS_COMPRESSION_LZ4	= 0,
 	Z_EROFS_COMPRESSION_MAX
 };
 
@@ -212,12 +220,12 @@ struct z_erofs_map_header {
 	 * bit 5-7 : (physical - logical) cluster bits of head 2.
 	 */
 	__u8	h_clusterbits;
-} __packed;
+};
 
 #define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
 
 /*
- * Z_EROFS Variable-sized Logical Extent cluster type:
+ * Fixed-sized output compression ondisk Logical Extent cluster type:
  *    0 - literal (uncompressed) cluster
  *    1 - compressed cluster (for the head logical cluster)
  *    2 - compressed cluster (for the other logical clusters)
@@ -242,10 +250,10 @@ struct z_erofs_map_header {
  *                (di_advise could be 0, 1 or 2)
  */
 enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED,
+	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
+	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
+	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
 	Z_EROFS_VLE_CLUSTER_TYPE_MAX
 };
 
@@ -267,18 +275,18 @@ struct z_erofs_vle_decompressed_index {
 		 * [1] - pointing to the tail cluster
 		 */
 		__le16 delta[2];
-	} di_u __packed;		/* 8 bytes */
-} __packed;
+	} di_u;
+};
 
 #define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
 	sizeof(struct z_erofs_vle_decompressed_index))
 
 /* dirent sorts in alphabet order, thus we can do binary search */
 struct erofs_dirent {
-	__le64 nid;     /*  0, node number */
-	__le16 nameoff; /*  8, start offset of file name */
-	__u8 file_type; /* 10, file type */
-	__u8 reserved;  /* 11, reserved */
+	__le64 nid;     /* node number */
+	__le16 nameoff; /* start offset of file name */
+	__u8 file_type; /* file type */
+	__u8 reserved;  /* reserved */
 } __packed;
 
 /* file types used in inode_info->flags */
@@ -300,8 +308,8 @@ enum {
 static inline void erofs_check_ondisk_layout_definitions(void)
 {
 	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
-	BUILD_BUG_ON(sizeof(struct erofs_inode_v1) != 32);
-	BUILD_BUG_ON(sizeof(struct erofs_inode_v2) != 64);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
diff --git a/lib/compress.c b/lib/compress.c
index 1919609..7935fce 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -120,7 +120,7 @@ static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
 	int ret;
 	unsigned int count;
 
-	if (!(sbi.requirements & EROFS_REQUIREMENT_LZ4_0PADDING)) {
+	if (!(sbi.feature_incompat & EROFS_FEATURE_INCOMPAT_LZ4_0PADDING)) {
 		/* fix up clusterofs to 0 if possable */
 		if (ctx->head >= ctx->clusterofs) {
 			ctx->head -= ctx->clusterofs;
@@ -184,7 +184,8 @@ nocompression:
 			erofs_dbg("Writing %u compressed data to block %u",
 				  count, ctx->blkaddr);
 
-			if (sbi.requirements & EROFS_REQUIREMENT_LZ4_0PADDING)
+			if (sbi.feature_incompat &
+			    EROFS_FEATURE_INCOMPAT_LZ4_0PADDING)
 				ret = blk_write(dst - (EROFS_BLKSIZ - ret),
 						ctx->blkaddr, 1);
 			else
@@ -382,7 +383,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 					      4, logical_clusterbits, true);
 	}
 	inode->extent_isize = out - (u8 *)inode->compressmeta;
-	inode->data_mapping_mode = EROFS_INODE_FLAT_COMPRESSION;
+	inode->datalayout = EROFS_INODE_FLAT_COMPRESSION;
 	return 0;
 }
 
@@ -473,7 +474,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	legacymetasize = ctx.metacur - compressmeta;
 	if (cfg.c_legacy_compress) {
 		inode->extent_isize = legacymetasize;
-		inode->data_mapping_mode = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	} else {
 		ret = z_erofs_convert_to_compacted_format(inode, blkaddr - 1,
 							  legacymetasize, 12);
diff --git a/lib/config.c b/lib/config.c
index 2e91b92..9c78142 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -21,7 +21,7 @@ void erofs_init_configure(void)
 	cfg.c_dry_run  = false;
 	cfg.c_legacy_compress = false;
 	cfg.c_compr_level_master = -1;
-	sbi.requirements = EROFS_REQUIREMENT_LZ4_0PADDING;
+	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 }
 
 void erofs_show_config(void)
diff --git a/lib/inode.c b/lib/inode.c
index c8cf847..4e1e29f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -179,7 +179,7 @@ int erofs_prepare_dir_file(struct erofs_inode *dir)
 	dir->i_size = d_size;
 
 	/* no compression for all dirs */
-	dir->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
+	dir->datalayout = EROFS_INODE_FLAT_INLINE;
 
 	/* allocate dir main data */
 	ret = __allocate_inode_bh_data(dir, erofs_blknr(d_size));
@@ -274,7 +274,7 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 	const unsigned int nblocks = erofs_blknr(inode->i_size);
 	int ret;
 
-	inode->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
+	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
 	ret = __allocate_inode_bh_data(inode, nblocks);
 	if (ret)
@@ -303,7 +303,7 @@ int erofs_write_file(struct erofs_inode *inode)
 	int ret, fd;
 
 	if (!inode->i_size) {
-		inode->data_mapping_mode = EROFS_INODE_FLAT_PLAIN;
+		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 		return 0;
 	}
 
@@ -315,7 +315,7 @@ int erofs_write_file(struct erofs_inode *inode)
 	}
 
 	/* fallback to all data uncompressed */
-	inode->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
+	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / EROFS_BLKSIZ;
 
 	ret = __allocate_inode_bh_data(inode, nblocks);
@@ -366,39 +366,39 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 	struct erofs_inode *const inode = bh->fsprivate;
 	erofs_off_t off = erofs_btell(bh, false);
 
-	/* let's support v1 currently */
-	struct erofs_inode_v1 v1 = {0};
+	/* let's support compact inode currently */
+	struct erofs_inode_compact dic = {0};
 	int ret;
 
-	v1.i_advise = cpu_to_le16(0 | (inode->data_mapping_mode << 1));
-	v1.i_mode = cpu_to_le16(inode->i_mode);
-	v1.i_nlink = cpu_to_le16(inode->i_nlink);
-	v1.i_size = cpu_to_le32((u32)inode->i_size);
+	dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
+	dic.i_mode = cpu_to_le16(inode->i_mode);
+	dic.i_nlink = cpu_to_le16(inode->i_nlink);
+	dic.i_size = cpu_to_le32((u32)inode->i_size);
 
-	v1.i_ino = cpu_to_le32(inode->i_ino[0]);
+	dic.i_ino = cpu_to_le32(inode->i_ino[0]);
 
-	v1.i_uid = cpu_to_le16((u16)inode->i_uid);
-	v1.i_gid = cpu_to_le16((u16)inode->i_gid);
+	dic.i_uid = cpu_to_le16((u16)inode->i_uid);
+	dic.i_gid = cpu_to_le16((u16)inode->i_gid);
 
 	switch ((inode->i_mode) >> S_SHIFT) {
 	case S_IFCHR:
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
-		v1.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
+		dic.i_u.rdev = cpu_to_le32(inode->u.i_rdev);
 		break;
 
 	default:
 		if (is_inode_layout_compression(inode))
-			v1.i_u.compressed_blocks =
+			dic.i_u.compressed_blocks =
 				cpu_to_le32(inode->u.i_blocks);
 		else
-			v1.i_u.raw_blkaddr =
+			dic.i_u.raw_blkaddr =
 				cpu_to_le32(inode->u.i_blkaddr);
 		break;
 	}
 
-	ret = dev_write(&v1, off, sizeof(struct erofs_inode_v1));
+	ret = dev_write(&dic, off, sizeof(struct erofs_inode_compact));
 	if (ret)
 		return false;
 	off += inode->inode_isize;
@@ -468,13 +468,13 @@ int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 	 * should use EROFS_INODE_FLAT_PLAIN data mapping mode.
 	 */
 	if (!inode->idata_size)
-		inode->data_mapping_mode = EROFS_INODE_FLAT_PLAIN;
+		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 
 	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
-		inode->data_mapping_mode = EROFS_INODE_FLAT_PLAIN;
+		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 noinline:
 		/* expend an extra block for tail-end data */
 		ret = erofs_prepare_tail_block(inode);
@@ -487,7 +487,7 @@ noinline:
 	} else if (IS_ERR(bh)) {
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
-		inode->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
+		inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
 		/* allocate inline buffer */
 		ibh = erofs_battach(bh, META, inode->idata_size);
@@ -616,7 +616,7 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
 
 	inode->i_ino[1] = st->st_ino;
-	inode->inode_isize = sizeof(struct erofs_inode_v1);
+	inode->inode_isize = sizeof(struct erofs_inode_compact);
 
 	list_add(&inode->i_hash,
 		 &inode_hashtable[st->st_ino % NR_INODE_HASHTABLE]);
diff --git a/mkfs/main.c b/mkfs/main.c
index 2dfd68e..effc26b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -69,7 +69,8 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			/* disable compacted indexes and 0padding */
 			cfg.c_legacy_compress = true;
-			sbi.requirements &= ~EROFS_REQUIREMENT_LZ4_0PADDING;
+			sbi.feature_incompat &=
+				~EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 		}
 	}
 	return 0;
@@ -155,7 +156,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.blocks = 0,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = 0,
-		.requirements = cpu_to_le32(sbi.requirements),
+		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
-- 
2.17.1

