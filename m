Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 618EC7249B2
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 19:02:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QbGwv1HX7z3drv
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Jun 2023 03:02:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QbGwm1DJ7z3cfR
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Jun 2023 03:01:58 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VkXKa17_1686070904;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkXKa17_1686070904)
          by smtp.aliyun-inc.com;
          Wed, 07 Jun 2023 01:01:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: sync up erofs_fs.h
Date: Wed,  7 Jun 2023 01:01:44 +0800
Message-Id: <20230606170144.36902-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Keep in sync with kernel erofs_fs.h of commit 6a318ccd7e08
("erofs: enable long extended attribute name prefixes").

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 dump/main.c              |   6 +-
 fsck/main.c              |   4 +-
 include/erofs/internal.h |   8 +-
 include/erofs_fs.h       | 260 ++++++++++++++++++---------------------
 lib/compress.c           |  87 +++++++------
 lib/data.c               |   4 +-
 lib/fragments.c          |   2 +-
 lib/inode.c              |   5 +-
 lib/zmap.c               |  96 +++++++--------
 mkfs/main.c              |   2 +-
 10 files changed, 227 insertions(+), 247 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index efbc82b..ae1ffa0 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -93,7 +93,7 @@ struct erofsdump_feature {
 static struct erofsdump_feature feature_lists[] = {
 	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
 	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
-	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "0padding" },
+	{ false, EROFS_FEATURE_INCOMPAT_ZERO_PADDING, "0padding" },
 	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
@@ -201,8 +201,8 @@ static int erofsdump_get_occupied_size(struct erofs_inode *inode,
 		stats.uncompressed_files++;
 		*size = inode->i_size;
 		break;
-	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
-	case EROFS_INODE_FLAT_COMPRESSION:
+	case EROFS_INODE_COMPRESSED_FULL:
+	case EROFS_INODE_COMPRESSED_COMPACT:
 		stats.compressed_files++;
 		*size = inode->u.i_blocks * erofs_blksiz();
 		break;
diff --git a/fsck/main.c b/fsck/main.c
index 85df8a6..f816bec 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -389,8 +389,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	case EROFS_INODE_CHUNK_BASED:
 		compressed = false;
 		break;
-	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
-	case EROFS_INODE_FLAT_COMPRESSION:
+	case EROFS_INODE_COMPRESSED_FULL:
+	case EROFS_INODE_COMPRESSED_COMPACT:
 		compressed = true;
 		break;
 	default:
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 370cfac..ab964d4 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -123,7 +123,7 @@ static inline void erofs_sb_clear_##name(void) \
 	sbi.feature_##compat &= ~EROFS_FEATURE_##feature; \
 }
 
-EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_ZERO_PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
@@ -363,12 +363,12 @@ static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 	case EROFS_INODE_CHUNK_BASED:
 		*size = inode->i_size;
 		break;
-	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
-	case EROFS_INODE_FLAT_COMPRESSION:
+	case EROFS_INODE_COMPRESSED_FULL:
+	case EROFS_INODE_COMPRESSED_COMPACT:
 		*size = inode->u.i_blocks * erofs_blksiz();
 		break;
 	default:
-		return -ENOTSUP;
+		return -EOPNOTSUPP;
 	}
 	return 0;
 }
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9107cc5..3697882 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -3,7 +3,7 @@
  * EROFS (Enhanced ROM File System) on-disk format definition
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Copyright (C) 2021, Alibaba Cloud
  */
 #ifndef __EROFS_FS_H
@@ -12,28 +12,30 @@
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
-#define EROFS_FEATURE_COMPAT_SB_CHKSUM		0x00000001
-#define EROFS_FEATURE_COMPAT_MTIME		0x00000002
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
+#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
  */
-#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
+#define EROFS_FEATURE_INCOMPAT_ZERO_PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
+#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
 	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
 	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
 	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
@@ -42,12 +44,9 @@
 #define EROFS_SB_EXTSLOT_SIZE	16
 
 struct erofs_deviceslot {
-	union {
-		u8 uuid[16];		/* used for device manager later */
-		u8 userdata[64];	/* digest(sha256), etc. */
-	} u;
-	__le32 blocks;			/* total fs blocks of this device */
-	__le32 mapped_blkaddr;		/* map starting at mapped_blkaddr */
+	u8 tag[64];		/* digest(sha256), etc. */
+	__le32 blocks;		/* total fs blocks of this device */
+	__le32 mapped_blkaddr;	/* map starting at mapped_blkaddr */
 	u8 reserved[56];
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
@@ -57,14 +56,14 @@ struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c(super_block) */
 	__le32 feature_compat;
-	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 blkszbits;         /* filesystem block size in bit shift */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
 
 	__le16 root_nid;	/* nid of root directory */
 	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
 
-	__le64 build_time;      /* inode v1 time derivation */
-	__le32 build_time_nsec;	/* inode v1 time derivation in nano scale */
+	__le64 build_time;      /* compact inode time derivation */
+	__le32 build_time_nsec;	/* compact inode time derivation in ns scale */
 	__le32 blocks;          /* used for statfs */
 	__le32 meta_blkaddr;	/* start block address of metadata area */
 	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
@@ -79,7 +78,7 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved;
+	__u8 dirblkbits;	/* directory block size in bit shift */
 	__u8 xattr_prefix_count;	/* # of long xattr name prefixes */
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
@@ -87,35 +86,30 @@ struct erofs_super_block {
 };
 
 /*
- * erofs inode datalayout (i_format in on-disk inode):
- * 0 - inode plain without inline data A:
- * inode, [xattrs], ... | ... | no-holed data
- * 1 - inode VLE compression B (legacy):
- * inode, [xattrs], extents ... | ...
- * 2 - inode plain with inline data C:
- * inode, [xattrs], last_inline_data, ... | ... | no-holed data
- * 3 - inode compression D:
- * inode, [xattrs], map_header, extents ... | ...
- * 4 - inode chunk-based E:
- * inode, [xattrs], chunk indexes ... | ...
+ * EROFS inode datalayout (i_format in on-disk inode):
+ * 0 - uncompressed flat inode without tail-packing inline data:
+ * 1 - compressed inode with non-compact indexes:
+ * 2 - uncompressed flat inode with tail-packing inline data:
+ * 3 - compressed inode with compact indexes:
+ * 4 - chunk-based inode with (optional) multi-device support:
  * 5~7 - reserved
  */
 enum {
 	EROFS_INODE_FLAT_PLAIN			= 0,
-	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
+	EROFS_INODE_COMPRESSED_FULL		= 1,
 	EROFS_INODE_FLAT_INLINE			= 2,
-	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_COMPRESSED_COMPACT		= 3,
 	EROFS_INODE_CHUNK_BASED			= 4,
 	EROFS_INODE_DATALAYOUT_MAX
 };
 
 static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 {
-	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
-		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+	return datamode == EROFS_INODE_COMPRESSED_COMPACT ||
+		datamode == EROFS_INODE_COMPRESSED_FULL;
 }
 
-/* bit definitions of inode i_advise */
+/* bit definitions of inode i_format */
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATALAYOUT_BITS         3
 
@@ -133,11 +127,30 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_CHUNK_FORMAT_ALL	\
 	(EROFS_CHUNK_FORMAT_BLKBITS_MASK | EROFS_CHUNK_FORMAT_INDEXES)
 
+/* 32-byte on-disk inode */
+#define EROFS_INODE_LAYOUT_COMPACT	0
+/* 64-byte on-disk inode */
+#define EROFS_INODE_LAYOUT_EXTENDED	1
+
 struct erofs_inode_chunk_info {
 	__le16 format;		/* chunk blkbits, etc. */
 	__le16 reserved;
 };
 
+union erofs_inode_i_u {
+	/* total compressed blocks for compressed inodes */
+	__le32 compressed_blocks;
+
+	/* block address for uncompressed flat inodes */
+	__le32 raw_blkaddr;
+
+	/* for device files, used to indicate old/new device # */
+	__le32 rdev;
+
+	/* for chunk-based files, it contains the summary info */
+	struct erofs_inode_chunk_info c;
+};
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
@@ -148,28 +161,14 @@ struct erofs_inode_compact {
 	__le16 i_nlink;
 	__le32 i_size;
 	__le32 i_reserved;
-	union {
-		/* file total compressed blocks for data mapping 1 */
-		__le32 compressed_blocks;
-		__le32 raw_blkaddr;
-
-		/* for device files, used to indicate old/new device # */
-		__le32 rdev;
+	union erofs_inode_i_u i_u;
 
-		/* for chunk-based files, it contains the summary info */
-		struct erofs_inode_chunk_info c;
-	} i_u;
-	__le32 i_ino;           /* only used for 32-bit stat compatibility */
+	__le32 i_ino;		/* only used for 32-bit stat compatibility */
 	__le16 i_uid;
 	__le16 i_gid;
 	__le32 i_reserved2;
 };
 
-/* 32 bytes on-disk inode */
-#define EROFS_INODE_LAYOUT_COMPACT	0
-/* 64 bytes on-disk inode */
-#define EROFS_INODE_LAYOUT_EXTENDED	1
-
 /* 64-byte complete form of an ondisk inode */
 struct erofs_inode_extended {
 	__le16 i_format;	/* inode format hints */
@@ -179,21 +178,9 @@ struct erofs_inode_extended {
 	__le16 i_mode;
 	__le16 i_reserved;
 	__le64 i_size;
-	union {
-		/* file total compressed blocks for data mapping 1 */
-		__le32 compressed_blocks;
-		__le32 raw_blkaddr;
-
-		/* for device files, used to indicate old/new device # */
-		__le32 rdev;
-
-		/* for chunk-based files, it contains the summary info */
-		struct erofs_inode_chunk_info c;
-	} i_u;
-
-	/* only used for 32-bit stat compatibility */
-	__le32 i_ino;
+	union erofs_inode_i_u i_u;
 
+	__le32 i_ino;		/* only used for 32-bit stat compatibility */
 	__le32 i_uid;
 	__le32 i_gid;
 	__le64 i_mtime;
@@ -202,10 +189,6 @@ struct erofs_inode_extended {
 	__u8   i_reserved2[16];
 };
 
-#define EROFS_MAX_SHARED_XATTRS         (128)
-/* h_shared_count between 129 ... 255 are special # */
-#define EROFS_SHARED_XATTR_EXTENT       (255)
-
 /*
  * inline xattrs (n == i_xattr_icount):
  * erofs_xattr_ibody_header(1) + (n - 1) * 4 bytes
@@ -248,10 +231,10 @@ struct erofs_xattr_entry {
 	char   e_name[0];       /* attribute name */
 };
 
-/* long xattr name prefixes */
+/* long xattr name prefix */
 struct erofs_xattr_long_prefix {
 	__u8   base_index;	/* short xattr name prefix index */
-	char   infix[];		/* infix apart from short prefix */
+	char   infix[0];	/* infix apart from short prefix */
 };
 
 static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
@@ -284,6 +267,29 @@ struct erofs_inode_chunk_index {
 	__le32 blkaddr;		/* start block address of this inode chunk */
 };
 
+/* dirent sorts in alphabet order, thus we can do binary search */
+struct erofs_dirent {
+	__le64 nid;     /* node number */
+	__le16 nameoff; /* start offset of file name */
+	__u8 file_type; /* file type */
+	__u8 reserved;  /* reserved */
+} __packed;
+
+/* file types used in inode_info->flags */
+enum {
+	EROFS_FT_UNKNOWN,
+	EROFS_FT_REG_FILE,
+	EROFS_FT_DIR,
+	EROFS_FT_CHRDEV,
+	EROFS_FT_BLKDEV,
+	EROFS_FT_FIFO,
+	EROFS_FT_SOCK,
+	EROFS_FT_SYMLINK,
+	EROFS_FT_MAX
+};
+
+#define EROFS_NAME_LEN      255
+
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
@@ -293,7 +299,7 @@ enum {
 	Z_EROFS_COMPRESSION_LZMA	= 1,
 	Z_EROFS_COMPRESSION_MAX
 };
-#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
+#define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
 
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
@@ -308,6 +314,7 @@ struct z_erofs_lzma_cfgs {
 	__le16 format;
 	u8 reserved[8];
 } __packed;
+
 #define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
 
 /*
@@ -327,15 +334,15 @@ struct z_erofs_lzma_cfgs {
 #define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
 #define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0020
 
-#define Z_EROFS_FRAGMENT_INODE_BIT		7
+#define Z_EROFS_FRAGMENT_INODE_BIT              7
 struct z_erofs_map_header {
 	union {
 		/* fragment data offset in the packed inode */
-		__le32	h_fragmentoff;
+		__le32  h_fragmentoff;
 		struct {
 			__le16  h_reserved1;
 			/* indicates the encoded size of tailpacking data */
-			__le16	h_idata_size;
+			__le16  h_idata_size;
 		};
 	};
 	__le16	h_advise;
@@ -352,105 +359,79 @@ struct z_erofs_map_header {
 	__u8	h_clusterbits;
 };
 
-#define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
-
 /*
- * Fixed-sized output compression ondisk Logical Extent cluster type:
- *    0 - literal (uncompressed) cluster
- *    1 - compressed cluster (for the head logical cluster)
- *    2 - compressed cluster (for the other logical clusters)
+ * On-disk logical cluster type:
+ *    0   - literal (uncompressed) lcluster
+ *    1,3 - compressed lcluster (for HEAD lclusters)
+ *    2   - compressed lcluster (for NONHEAD lclusters)
  *
  * In detail,
- *    0 - literal (uncompressed) cluster,
+ *    0 - literal (uncompressed) lcluster,
  *        di_advise = 0
- *        di_clusterofs = the literal data offset of the cluster
- *        di_blkaddr = the blkaddr of the literal cluster
+ *        di_clusterofs = the literal data offset of the lcluster
+ *        di_blkaddr = the blkaddr of the literal pcluster
  *
- *    1 - compressed cluster (for the head logical cluster)
- *        di_advise = 1
- *        di_clusterofs = the decompressed data offset of the cluster
- *        di_blkaddr = the blkaddr of the compressed cluster
+ *    1,3 - compressed lcluster (for HEAD lclusters)
+ *        di_advise = 1 or 3
+ *        di_clusterofs = the decompressed data offset of the lcluster
+ *        di_blkaddr = the blkaddr of the compressed pcluster
  *
- *    2 - compressed cluster (for the other logical clusters)
+ *    2 - compressed lcluster (for NONHEAD lclusters)
  *        di_advise = 2
  *        di_clusterofs =
- *           the decompressed data offset in its own head cluster
- *        di_u.delta[0] = distance to its corresponding head cluster
- *        di_u.delta[1] = distance to its corresponding tail cluster
- *                (di_advise could be 0, 1 or 2)
+ *           the decompressed data offset in its own HEAD lcluster
+ *        di_u.delta[0] = distance to this HEAD lcluster
+ *        di_u.delta[1] = distance to the next HEAD lcluster
  */
 enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
-	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
-	Z_EROFS_VLE_CLUSTER_TYPE_MAX
+	Z_EROFS_LCLUSTER_TYPE_PLAIN	= 0,
+	Z_EROFS_LCLUSTER_TYPE_HEAD1	= 1,
+	Z_EROFS_LCLUSTER_TYPE_NONHEAD	= 2,
+	Z_EROFS_LCLUSTER_TYPE_HEAD2	= 3,
+	Z_EROFS_LCLUSTER_TYPE_MAX
 };
 
-#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
-#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
+#define Z_EROFS_LI_LCLUSTER_TYPE_BITS        2
+#define Z_EROFS_LI_LCLUSTER_TYPE_BIT         0
 
 /* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
-#define Z_EROFS_VLE_DI_PARTIAL_REF		(1 << 15)
+#define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
 
 /*
  * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
  * compressed block count of a compressed extent (in logical clusters, aka.
  * block count of a pcluster).
  */
-#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+#define Z_EROFS_LI_D0_CBLKCNT		(1 << 11)
 
-struct z_erofs_vle_decompressed_index {
+struct z_erofs_lcluster_index {
 	__le16 di_advise;
-	/* where to decompress in the head cluster */
+	/* where to decompress in the head lcluster */
 	__le16 di_clusterofs;
 
 	union {
-		/* for the head cluster */
+		/* for the HEAD lclusters */
 		__le32 blkaddr;
 		/*
-		 * for the rest clusters
-		 * eg. for 4k page-sized cluster, maximum 4K*64k = 256M)
-		 * [0] - pointing to the head cluster
-		 * [1] - pointing to the tail cluster
+		 * for the NONHEAD lclusters
+		 * [0] - distance to its HEAD lcluster
+		 * [1] - distance to the next HEAD lcluster
 		 */
 		__le16 delta[2];
 	} di_u;
 };
 
-#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
-	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
-	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
-
-#define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
-	sizeof(struct z_erofs_vle_decompressed_index))
-
-/* dirent sorts in alphabet order, thus we can do binary search */
-struct erofs_dirent {
-	__le64 nid;     /* node number */
-	__le16 nameoff; /* start offset of file name */
-	__u8 file_type; /* file type */
-	__u8 reserved;  /* reserved */
-} __packed;
-
-/* file types used in inode_info->flags */
-enum {
-	EROFS_FT_UNKNOWN,
-	EROFS_FT_REG_FILE,
-	EROFS_FT_DIR,
-	EROFS_FT_CHRDEV,
-	EROFS_FT_BLKDEV,
-	EROFS_FT_FIFO,
-	EROFS_FT_SOCK,
-	EROFS_FT_SYMLINK,
-	EROFS_FT_MAX
-};
-
-#define EROFS_NAME_LEN      255
+#define Z_EROFS_FULL_INDEX_ALIGN(end)	\
+	(round_up(end, 8) + sizeof(struct z_erofs_map_header) + 8)
 
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
 {
+	const __le64 fmh __maybe_unused =
+		*(__le64 *)&(struct z_erofs_map_header) {
+			.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
+		};
+
 	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
@@ -459,15 +440,18 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_info) != 4);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
-	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
+	BUILD_BUG_ON(sizeof(struct z_erofs_lcluster_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
 	/* keep in sync between 2 index structures for better extendibility */
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
-		     sizeof(struct z_erofs_vle_decompressed_index));
+		     sizeof(struct z_erofs_lcluster_index));
 	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
-	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
-		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
+	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
+		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
+	/* exclude old compiler versions like gcc 7.5.0 */
+	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
+		     fmh != cpu_to_le64(1ULL << 63) : 0);
 }
 
 #endif
diff --git a/lib/compress.c b/lib/compress.c
index e943056..14d228f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -47,28 +47,27 @@ struct z_erofs_vle_compress_ctx {
 	bool fragemitted;
 };
 
-#define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
-	(sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
+#define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
 static unsigned int vle_compressmeta_capacity(erofs_off_t filesize)
 {
 	const unsigned int indexsize = BLK_ROUND_UP(filesize) *
-		sizeof(struct z_erofs_vle_decompressed_index);
+		sizeof(struct z_erofs_lcluster_index);
 
 	return Z_EROFS_LEGACY_MAP_HEADER_SIZE + indexsize;
 }
 
 static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 {
-	const unsigned int type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
-	struct z_erofs_vle_decompressed_index di;
+	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
+	struct z_erofs_lcluster_index di;
 
 	if (!ctx->clusterofs)
 		return;
 
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 	di.di_u.blkaddr = 0;
-	di.di_advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
+	di.di_advise = cpu_to_le16(type << Z_EROFS_LI_LCLUSTER_TYPE_BIT);
 
 	memcpy(ctx->metacur, &di, sizeof(di));
 	ctx->metacur += sizeof(di);
@@ -80,7 +79,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	unsigned int clusterofs = ctx->clusterofs;
 	unsigned int count = ctx->e.length;
 	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz();
-	struct z_erofs_vle_decompressed_index di;
+	struct z_erofs_lcluster_index di;
 	unsigned int type, advise;
 
 	if (!count)
@@ -97,12 +96,12 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		 */
 		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking && !cfg.c_fragments);
 		DBG_BUGON(ctx->e.partial);
-		type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
-			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
-		advise = type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT;
+		type = ctx->e.raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
+			Z_EROFS_LCLUSTER_TYPE_HEAD1;
+		advise = type << Z_EROFS_LI_LCLUSTER_TYPE_BIT;
 		di.di_advise = cpu_to_le16(advise);
 
-		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY &&
+		if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 		    !ctx->e.compressedblks)
 			di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
 		else
@@ -119,12 +118,12 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		advise = 0;
 		/* XXX: big pcluster feature should be per-inode */
 		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
-			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
+			type = Z_EROFS_LCLUSTER_TYPE_NONHEAD;
 			di.di_u.delta[0] = cpu_to_le16(ctx->e.compressedblks |
-					Z_EROFS_VLE_DI_D0_CBLKCNT);
+						       Z_EROFS_LI_D0_CBLKCNT);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else if (d0) {
-			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
+			type = Z_EROFS_LCLUSTER_TYPE_NONHEAD;
 
 			/*
 			 * If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
@@ -137,17 +136,17 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 			 * To solve this, we replace d0 with
 			 * Z_EROFS_VLE_DI_D0_CBLKCNT-1.
 			 */
-			if (d0 >= Z_EROFS_VLE_DI_D0_CBLKCNT)
+			if (d0 >= Z_EROFS_LI_D0_CBLKCNT)
 				di.di_u.delta[0] = cpu_to_le16(
-						Z_EROFS_VLE_DI_D0_CBLKCNT - 1);
+						Z_EROFS_LI_D0_CBLKCNT - 1);
 			else
 				di.di_u.delta[0] = cpu_to_le16(d0);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else {
-			type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
-				Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
+			type = ctx->e.raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
+				Z_EROFS_LCLUSTER_TYPE_HEAD1;
 
-			if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY &&
+			if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 			    !ctx->e.compressedblks)
 				di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
 			else
@@ -155,10 +154,10 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 
 			if (ctx->e.partial) {
 				DBG_BUGON(ctx->e.raw);
-				advise |= Z_EROFS_VLE_DI_PARTIAL_REF;
+				advise |= Z_EROFS_LI_PARTIAL_REF;
 			}
 		}
-		advise |= type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT;
+		advise |= type << Z_EROFS_LI_LCLUSTER_TYPE_BIT;
 		di.di_advise = cpu_to_le16(advise);
 
 		memcpy(ctx->metacur, &di, sizeof(di));
@@ -218,7 +217,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 
 		/* fall back to noncompact indexes for deduplication */
 		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 		erofs_sb_set_dedupe();
 
 		if (delta) {
@@ -575,18 +574,18 @@ struct z_erofs_compressindex_vec {
 static void *parse_legacy_indexes(struct z_erofs_compressindex_vec *cv,
 				  unsigned int nr, void *metacur)
 {
-	struct z_erofs_vle_decompressed_index *const db = metacur;
+	struct z_erofs_lcluster_index *const db = metacur;
 	unsigned int i;
 
 	for (i = 0; i < nr; ++i, ++cv) {
-		struct z_erofs_vle_decompressed_index *const di = db + i;
+		struct z_erofs_lcluster_index *const di = db + i;
 		const unsigned int advise = le16_to_cpu(di->di_advise);
 
-		cv->clustertype = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
-			((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+		cv->clustertype = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
+			((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
 		cv->clusterofs = le16_to_cpu(di->di_clusterofs);
 
-		if (cv->clustertype == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		if (cv->clustertype == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			cv->u.delta[0] = le16_to_cpu(di->di_u.delta[0]);
 			cv->u.delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		} else {
@@ -622,9 +621,9 @@ static void *write_compacted_indexes(u8 *out,
 		unsigned int offset, v;
 		u8 ch, rem;
 
-		if (cv[i].clustertype == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
-			if (cv[i].u.delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
-				cblks = cv[i].u.delta[0] & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+		if (cv[i].clustertype == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+			if (cv[i].u.delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
+				cblks = cv[i].u.delta[0] & ~Z_EROFS_LI_D0_CBLKCNT;
 				offset = cv[i].u.delta[0];
 				blkaddr += cblks;
 				*dummy_head = false;
@@ -669,12 +668,12 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 					unsigned int legacymetasize,
 					void *compressmeta)
 {
-	const unsigned int mpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
-							   inode->xattr_isize) +
+	const unsigned int mpos = roundup(inode->inode_isize +
+					  inode->xattr_isize, 8) +
 				  sizeof(struct z_erofs_map_header);
 	const unsigned int totalidx = (legacymetasize -
 			Z_EROFS_LEGACY_MAP_HEADER_SIZE) /
-				sizeof(struct z_erofs_vle_decompressed_index);
+				sizeof(struct z_erofs_lcluster_index);
 	const unsigned int logical_clusterbits = inode->z_logical_clusterbits;
 	u8 *out, *in;
 	struct z_erofs_compressindex_vec cv[16];
@@ -792,7 +791,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 {
-	const unsigned int type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
+	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_map_header *h = inode->compressmeta;
 
 	h->h_advise = cpu_to_le16(le16_to_cpu(h->h_advise) &
@@ -803,15 +802,15 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	DBG_BUGON(inode->compressed_idata != true);
 
 	/* patch the EOF lcluster to uncompressed type first */
-	if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
-		struct z_erofs_vle_decompressed_index *di =
+	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
+		struct z_erofs_lcluster_index *di =
 			(inode->compressmeta + inode->extent_isize) -
-			sizeof(struct z_erofs_vle_decompressed_index);
+			sizeof(struct z_erofs_lcluster_index);
 		__le16 advise =
-			cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
+			cpu_to_le16(type << Z_EROFS_LI_LCLUSTER_TYPE_BIT);
 
 		di->di_advise = advise;
-	} else if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION) {
+	} else if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
 		/* handle the last compacted 4B pack */
 		unsigned int eofs, base, pos, v, lo;
 		u8 *out;
@@ -862,14 +861,14 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	if (!cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
 		if (inode->z_logical_clusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION;
+		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
 	} else {
-		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 	}
 
 	if (erofs_sb_has_big_pcluster()) {
 		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
-		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
+		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
 	}
 	if (cfg.c_fragments && !cfg.c_dedupe)
@@ -971,7 +970,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		DBG_BUGON(inode->fragmentoff >> 63);
 		*(__le64 *)compressmeta =
 			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
-		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	}
 
@@ -996,7 +995,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 
 	inode->u.i_blocks = compressed_blocks;
 
-	if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		inode->extent_isize = legacymetasize;
 	} else {
 		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
diff --git a/lib/data.c b/lib/data.c
index 211cdb5..612112a 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -356,8 +356,8 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
 		return erofs_read_raw_data(inode, buf, count, offset);
-	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
-	case EROFS_INODE_FLAT_COMPRESSION:
+	case EROFS_INODE_COMPRESSED_FULL:
+	case EROFS_INODE_COMPRESSED_COMPACT:
 		return z_erofs_read_data(inode, buf, count, offset);
 	default:
 		break;
diff --git a/lib/fragments.c b/lib/fragments.c
index bf4dc19..1d243d3 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -226,7 +226,7 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
 	 * will be recorded by switching to the noncompact layout anyway.
 	 */
 	if (inode->fragmentoff >> 32)
-		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 
 	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	erofs_sb_set_fragments();
diff --git a/lib/inode.c b/lib/inode.c
index 6861b99..f1401d0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -578,7 +578,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 				return false;
 		} else {
 			/* write compression metadata */
-			off = Z_EROFS_VLE_EXTENT_ALIGN(off);
+			off = roundup(off, 8);
 			ret = dev_write(inode->compressmeta, off,
 					inode->extent_isize);
 			if (ret)
@@ -627,8 +627,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	inodesize = inode->inode_isize + inode->xattr_isize;
 	if (inode->extent_isize)
-		inodesize = Z_EROFS_VLE_EXTENT_ALIGN(inodesize) +
-			    inode->extent_isize;
+		inodesize = roundup(inodesize, 8) + inode->extent_isize;
 
 	/* TODO: tailpacking inline of chunk-based format isn't finalized */
 	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
diff --git a/lib/zmap.c b/lib/zmap.c
index 6d9b033..7492e5d 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -18,7 +18,7 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	if (!erofs_sb_has_big_pcluster() &&
 	    !erofs_sb_has_ztailpacking() && !erofs_sb_has_fragments() &&
-	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -67,7 +67,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	}
 
 	vi->z_logical_clusterbits = sbi.blkszbits + (h->h_clusterbits & 7);
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
 		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
@@ -144,11 +144,10 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = m->inode;
 	const erofs_off_t ibase = iloc(vi->nid);
-	const erofs_off_t pos =
-		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
-					       vi->xattr_isize) +
-		lcn * sizeof(struct z_erofs_vle_decompressed_index);
-	struct z_erofs_vle_decompressed_index *di;
+	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(ibase +
+			vi->inode_isize + vi->xattr_isize) +
+		lcn * sizeof(struct z_erofs_lcluster_index);
+	struct z_erofs_lcluster_index *di;
 	unsigned int advise, type;
 	int err;
 
@@ -156,31 +155,31 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (err)
 		return err;
 
-	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(pos);
 
 	advise = le16_to_cpu(di->di_advise);
-	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
-		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
+		((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
 	switch (type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
-		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
 			m->compressedblks = m->delta[0] &
-				~Z_EROFS_VLE_DI_D0_CBLKCNT;
+				~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
-		if (advise & Z_EROFS_VLE_DI_PARTIAL_REF)
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+		if (advise & Z_EROFS_LI_PARTIAL_REF)
 			m->partialref = true;
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
@@ -218,13 +217,13 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
 		lo = decode_compactedbits(lclusterbits, lomask,
 					  in, encodebits * i, &type);
 
-		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			return d1;
 		++d1;
 	} while (++i < vcnt);
 
-	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
-	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
+	/* vcnt - 1 (Z_EROFS_LCLUSTER_TYPE_NONHEAD) item */
+	if (!(lo & Z_EROFS_LI_D0_CBLKCNT))
 		d1 += lo - 1;
 	return d1;
 }
@@ -262,19 +261,19 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	lo = decode_compactedbits(lclusterbits, lomask,
 				  in, encodebits * i, &type);
 	m->type = type;
-	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+	if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
 
 		/* figure out lookahead_distance: delta[1] if needed */
 		if (lookahead)
 			m->delta[1] = get_compacted_la_distance(lclusterbits,
 						encodebits, vcnt, in, i);
-		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+		if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!big_pcluster) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->compressedblks = lo & ~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 			return 0;
 		} else if (i + 1 != (int)vcnt) {
@@ -288,9 +287,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		 */
 		lo = decode_compactedbits(lclusterbits, lomask,
 					  in, encodebits * (i - 1), &type);
-		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			lo = 0;
-		else if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT)
+		else if (lo & Z_EROFS_LI_D0_CBLKCNT)
 			lo = 1;
 		m->delta[0] = lo + 1;
 		return 0;
@@ -304,7 +303,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			--i;
 			lo = decode_compactedbits(lclusterbits, lomask,
 						  in, encodebits * i, &type);
-			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 				i -= lo;
 
 			if (i >= 0)
@@ -316,10 +315,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			--i;
 			lo = decode_compactedbits(lclusterbits, lomask,
 						  in, encodebits * i, &type);
-			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
-				if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+				if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 					--i;
-					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+					nblk += lo & ~Z_EROFS_LI_D0_CBLKCNT;
 					continue;
 				}
 				if (lo <= 1) {
@@ -398,10 +397,10 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	const unsigned int datamode = m->inode->datalayout;
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+	if (datamode == EROFS_INODE_COMPRESSED_FULL)
 		return legacy_load_cluster_from_disk(m, lcn);
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
 		return compacted_load_cluster_from_disk(m, lcn, lookahead);
 
 	return -EINVAL;
@@ -430,7 +429,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		return err;
 
 	switch (m->type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (!m->delta[0]) {
 			erofs_err("invalid lookback distance 0 @ nid %llu",
 				  (unsigned long long)vi->nid);
@@ -438,8 +437,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			return -EFSCORRUPTED;
 		}
 		return z_erofs_extent_lookback(m, m->delta[0]);
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
 		m->headtype = m->type;
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
@@ -461,10 +460,10 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	unsigned long lcn;
 	int err;
 
-	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1);
 
-	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
+	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
 		map->m_plen = 1 << lclusterbits;
 		return 0;
@@ -487,18 +486,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	 * BUG_ON in the debugging mode only for developers to notice that.
 	 */
 	DBG_BUGON(lcn == initial_lcn &&
-		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
+		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
 	switch (m->type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
 		m->compressedblks = 1 << (lclusterbits - sbi.blkszbits);
 		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
 		if (m->compressedblks)
@@ -539,11 +538,11 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 		if (err)
 			return err;
 
-		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			DBG_BUGON(!m->delta[1] &&
 				  m->clusterofs != 1 << lclusterbits);
-		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
+		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1) {
 			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
 				break;
@@ -593,8 +592,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 	switch (m.type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -611,7 +610,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
 		/* fallthrough */
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
@@ -629,8 +628,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
 		/* for non-compact indexes, fragmentoff is 64 bits */
-		if (fragment &&
-		    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		if (fragment && vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
 			vi->fragmentoff |= (u64)m.pblk << 32;
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
@@ -646,7 +644,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 			goto out;
 	}
 
-	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+	if (m.headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN) {
 		if (map->m_llen > map->m_plen) {
 			DBG_BUGON(1);
 			err = -EFSCORRUPTED;
diff --git a/mkfs/main.c b/mkfs/main.c
index a6a2d0e..ac208e5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -671,7 +671,7 @@ static void erofs_mkfs_default_options(void)
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
 	sbi.blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
-	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
 
-- 
2.24.4

