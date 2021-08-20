Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3483F29B5
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 12:00:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrcbD0FXkz3cQH
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 20:00:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grcb66Jf3z30JT
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 20:00:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0UkJjDtn_1629453621; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UkJjDtn_1629453621) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 20 Aug 2021 18:00:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH v3 1/2] erofs: introduce chunk-based file on-disk format
Date: Fri, 20 Aug 2021 18:00:18 +0800
Message-Id: <20210820100019.208490-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210819063310.177035-1-hsiangkao@linux.alibaba.com>
References: <20210819063310.177035-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Eryu Guan <eguan@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, uncompressed data except for tail-packing inline is
consecutive on disk.

In order to support chunk-based data deduplication, add a new
corresponding inode data layout.

In the future, the data source of chunks can be either (un)compressed.

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v2:
 - introduce EROFS_BLOCK_MAP_ENTRY_SIZE suggested by Chao.

 Documentation/filesystems/erofs.rst | 16 ++++++++--
 fs/erofs/erofs_fs.h                 | 47 +++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 868e3972227f..d484408a90c1 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -156,13 +156,14 @@ may not. All metadatas can be now observed in two different spaces (views):
 
     Xattrs, extents, data inline are followed by the corresponding inode with
     proper alignment, and they could be optional for different data mappings.
-    _currently_ total 4 valid data mappings are supported:
+    _currently_ total 5 data layouts are supported:
 
     ==  ====================================================================
      0  flat file data without data inline (no extent);
      1  fixed-sized output data compression (with non-compacted indexes);
      2  flat file data with tail packing data inline (no extent);
-     3  fixed-sized output data compression (with compacted indexes, v5.3+).
+     3  fixed-sized output data compression (with compacted indexes, v5.3+);
+     4  chunk-based file (v5.15+).
     ==  ====================================================================
 
     The size of the optional xattrs is indicated by i_xattr_count in inode
@@ -213,6 +214,17 @@ Note that apart from the offset of the first filename, nameoff0 also indicates
 the total number of directory entries in this block since it is no need to
 introduce another on-disk field at all.
 
+Chunk-based file
+----------------
+In order to support chunk-based data deduplication, a new inode data layout has
+been supported since Linux v5.15: Files are split in equal-sized data chunks
+with ``extents`` area of the inode metadata indicating how to get the chunk
+data: these can be simply as a 4-byte block address array or in the 8-byte
+chunk index form (see struct erofs_inode_chunk_index in erofs_fs.h for more
+details.)
+
+By the way, chunk-based files are all uncompressed for now.
+
 Data compression
 ----------------
 EROFS implements LZ4 fixed-sized output compression which generates fixed-sized
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 0f8da74570b4..b0b23f41abc3 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2021, Alibaba Cloud
  */
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
@@ -19,10 +20,12 @@
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
+#define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
-	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
+	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -64,13 +67,16 @@ struct erofs_super_block {
  * inode, [xattrs], last_inline_data, ... | ... | no-holed data
  * 3 - inode compression D:
  * inode, [xattrs], map_header, extents ... | ...
- * 4~7 - reserved
+ * 4 - inode chunk-based E:
+ * inode, [xattrs], chunk indexes ... | ...
+ * 5~7 - reserved
  */
 enum {
 	EROFS_INODE_FLAT_PLAIN			= 0,
 	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
 	EROFS_INODE_FLAT_INLINE			= 2,
 	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_CHUNK_BASED			= 4,
 	EROFS_INODE_DATALAYOUT_MAX
 };
 
@@ -90,6 +96,19 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_ALL	\
 	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
 
+/* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
+#define EROFS_CHUNK_FORMAT_BLKBITS_MASK		0x001F
+/* with chunk indexes or just a 4-byte blkaddr array */
+#define EROFS_CHUNK_FORMAT_INDEXES		0x0020
+
+#define EROFS_CHUNK_FORMAT_ALL	\
+	(EROFS_CHUNK_FORMAT_BLKBITS_MASK | EROFS_CHUNK_FORMAT_INDEXES)
+
+struct erofs_inode_chunk_info {
+	__le16 format;		/* chunk blkbits, etc. */
+	__le16 reserved;
+};
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
@@ -107,6 +126,9 @@ struct erofs_inode_compact {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
 	} i_u;
 	__le32 i_ino;           /* only used for 32-bit stat compatibility */
 	__le16 i_uid;
@@ -135,6 +157,9 @@ struct erofs_inode_extended {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
 	} i_u;
 
 	/* only used for 32-bit stat compatibility */
@@ -204,6 +229,19 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 				 e->e_name_len + le16_to_cpu(e->e_value_size));
 }
 
+/* represent a zeroed chunk (hole) */
+#define EROFS_NULL_ADDR			-1
+
+/* 4-byte block address array */
+#define EROFS_BLOCK_MAP_ENTRY_SIZE	sizeof(__le32)
+
+/* 8-byte inode chunk indexes */
+struct erofs_inode_chunk_index {
+	__le16 advise;		/* always 0, don't care for now */
+	__le16 device_id;	/* back-end storage id, always 0 for now */
+	__le32 blkaddr;		/* start block address of this inode chunk */
+};
+
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
@@ -338,9 +376,14 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_info) != 4);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
+	/* keep in sync between 2 index structures for better extendibility */
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
+		     sizeof(struct z_erofs_vle_decompressed_index));
 
 	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
-- 
2.24.4

