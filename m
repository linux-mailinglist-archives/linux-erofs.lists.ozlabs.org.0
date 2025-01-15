Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CE0A11E95
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:51:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1Tg3x4Gz3bdH
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:51:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934662;
	cv=none; b=NGVUAQarzWjUbBatIgDi6kkqjxuonq6MGxfXb+yEy4uFK4VfHR23evMrhuilNjc5MbZ8KX5oWVQ9Dbd4TdZAJgnME1g28NTC3BUDGrWTUwkVgnqg0QqFy7ADBTxts9mPFOLyZp0qUFllBmSvIW+OCA1SbHQNQnCle12Q33/zIv0YnjjlrA3sJ0OX9+/2jcvKsE0wKpKJ/ChssVzjT4DO38QugKdVZZ6qSjQDocTndVLrS1tlOT2iDn4huJe/SetA96aejNmOR36eiWH9DB86j9v5fHUaSM5qumNQLSMuWh40M2uzVdkV19Q7D2m9NGThQ+v9p1u+rr+7nfpUGcGnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934662; c=relaxed/relaxed;
	bh=VR21y66wZtGjzfcu84sgyeIvsBUYRdhrRaBnH6r6e/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkMum8M7Es7JVSSuFM+DxypCR9+vEeQS/56CD46qicdVDe59gPKh4UodFlG4dURK89ug99vcQJqU8xpPZ3p/zcwCRixxh0egnGOlJf19zcmaPaYG2oOp0AQURXpEOE/OMApvxKFqLiNaY9uSq5LvgX9N4Vlxnu37krr2zxoRK9fcjrGBuuLAVaGPTGA8u/7yV0ZTK8L2AGFAHHfIhEaohsJPmhLigYAE9cd7Uk/RxtdvbLhiu08qavOsPheVPuVe54lHmMGefvUqI9I1dqOMZ23F9THSeBa5n5JVoQr4/pzF7GN3IJ8fdDMJJwO6YLYgpMgIS0hDMSq+1NmrJSfJxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gdkhIvNE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gdkhIvNE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1Tc6p4dz301N
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:51:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736934657; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VR21y66wZtGjzfcu84sgyeIvsBUYRdhrRaBnH6r6e/s=;
	b=gdkhIvNEjGG9W1GgMo/rL6KP/wMB33iHQ4s3uuH7duwv3Td9n/JcDo+WuclwScCERtBHuwSOFGjG50lEN9JSgMPq2R7BsGKu9WwS7Vlg+tfFzXaKwgovum8ugUK7tG8hp2l+kAgwt5h8/Yl3kbiT4oRXn+i1PKVsDWhj12Nfrus=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNi9trq_1736934649 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 17:50:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] erofs: tidy up EROFS on-disk naming
Date: Wed, 15 Jan 2025 17:50:47 +0800
Message-ID: <20250115095048.2845612-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 1c7f49a76773bcf95d3c840cff6cd449114ddf56 upstream.

 - Get rid of all "vle" (variable-length extents) expressions
   since they only expand overall name lengths unnecessarily;
 - Rename COMPRESSION_LEGACY to COMPRESSED_FULL;
 - Move on-disk directory definitions ahead of compression;
 - Drop unused extended attribute definitions;
 - Move inode ondisk union `i_u` out as `union erofs_inode_i_u`.

No actual logical change.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230331063149.25611-1-hsiangkao@linux.alibaba.com
[ A backport dependency to resolve minor conflicts to fix CVE-2024-53234. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 145 +++++++++++++++++++-------------------------
 fs/erofs/zmap.c     | 116 +++++++++++++++++------------------
 2 files changed, 119 insertions(+), 142 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 44876a97cabd..1a4a614895c6 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -82,32 +82,27 @@ struct erofs_super_block {
 };
 
 /*
- * erofs inode datalayout (i_format in on-disk inode):
+ * EROFS inode datalayout (i_format in on-disk inode):
  * 0 - uncompressed flat inode without tail-packing inline data:
- * inode, [xattrs], ... | ... | no-holed data
  * 1 - compressed inode with non-compact indexes:
- * inode, [xattrs], [map_header], extents ... | ...
  * 2 - uncompressed flat inode with tail-packing inline data:
- * inode, [xattrs], tailpacking data, ... | ... | no-holed data
  * 3 - compressed inode with compact indexes:
- * inode, [xattrs], map_header, extents ... | ...
  * 4 - chunk-based inode with (optional) multi-device support:
- * inode, [xattrs], chunk indexes ... | ...
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
 
 /* bit definitions of inode i_format */
@@ -128,11 +123,30 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
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
@@ -143,29 +157,14 @@ struct erofs_inode_compact {
 	__le16 i_nlink;
 	__le32 i_size;
 	__le32 i_reserved;
-	union {
-		/* total compressed blocks for compressed inodes */
-		__le32 compressed_blocks;
-		/* block address for uncompressed flat inodes */
-		__le32 raw_blkaddr;
-
-		/* for device files, used to indicate old/new device # */
-		__le32 rdev;
-
-		/* for chunk-based files, it contains the summary info */
-		struct erofs_inode_chunk_info c;
-	} i_u;
-	__le32 i_ino;           /* only used for 32-bit stat compatibility */
+	union erofs_inode_i_u i_u;
+
+	__le32 i_ino;		/* only used for 32-bit stat compatibility */
 	__le16 i_uid;
 	__le16 i_gid;
 	__le32 i_reserved2;
 };
 
-/* 32-byte on-disk inode */
-#define EROFS_INODE_LAYOUT_COMPACT	0
-/* 64-byte on-disk inode */
-#define EROFS_INODE_LAYOUT_EXTENDED	1
-
 /* 64-byte complete form of an ondisk inode */
 struct erofs_inode_extended {
 	__le16 i_format;	/* inode format hints */
@@ -175,22 +174,9 @@ struct erofs_inode_extended {
 	__le16 i_mode;
 	__le16 i_reserved;
 	__le64 i_size;
-	union {
-		/* total compressed blocks for compressed inodes */
-		__le32 compressed_blocks;
-		/* block address for uncompressed flat inodes */
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
@@ -199,10 +185,6 @@ struct erofs_inode_extended {
 	__u8   i_reserved2[16];
 };
 
-#define EROFS_MAX_SHARED_XATTRS         (128)
-/* h_shared_count between 129 ... 255 are special # */
-#define EROFS_SHARED_XATTR_EXTENT       (255)
-
 /*
  * inline xattrs (n == i_xattr_icount):
  * erofs_xattr_ibody_header(1) + (n - 1) * 4 bytes
@@ -268,6 +250,22 @@ struct erofs_inode_chunk_index {
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
+/*
+ * EROFS file types should match generic FT_* types and
+ * it seems no need to add BUILD_BUG_ONs since potential
+ * unmatchness will break other fses as well...
+ */
+
+#define EROFS_NAME_LEN      255
+
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
@@ -337,10 +335,8 @@ struct z_erofs_map_header {
 	__u8	h_clusterbits;
 };
 
-#define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
-
 /*
- * Fixed-sized output compression on-disk logical cluster type:
+ * On-disk logical cluster type:
  *    0   - literal (uncompressed) lcluster
  *    1,3 - compressed lcluster (for HEAD lclusters)
  *    2   - compressed lcluster (for NONHEAD lclusters)
@@ -364,27 +360,27 @@ struct z_erofs_map_header {
  *        di_u.delta[1] = distance to the next HEAD lcluster
  */
 enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
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
 	/* where to decompress in the head lcluster */
 	__le16 di_clusterofs;
@@ -401,25 +397,8 @@ struct z_erofs_vle_decompressed_index {
 	} di_u;
 };
 
-#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
-	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
-	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
-
-/* dirent sorts in alphabet order, thus we can do binary search */
-struct erofs_dirent {
-	__le64 nid;     /* node number */
-	__le16 nameoff; /* start offset of file name */
-	__u8 file_type; /* file type */
-	__u8 reserved;  /* reserved */
-} __packed;
-
-/*
- * EROFS file types should match generic FT_* types and
- * it seems no need to add BUILD_BUG_ONs since potential
- * unmatchness will break other fses as well...
- */
-
-#define EROFS_NAME_LEN      255
+#define Z_EROFS_FULL_INDEX_ALIGN(end)	\
+	(ALIGN(end, 8) + sizeof(struct z_erofs_map_header) + 8)
 
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
@@ -436,15 +415,15 @@ static inline void erofs_check_ondisk_layout_definitions(void)
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
 	/* exclude old compiler versions like gcc 7.5.0 */
 	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
 		     fmh != cpu_to_le64(1ULL << 63) : 0);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 183e7a4b8259..046eaaf16dad 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -14,7 +14,7 @@ int z_erofs_fill_inode(struct inode *inode)
 
 	if (!erofs_sb_has_big_pcluster(sbi) &&
 	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
-	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -45,11 +45,10 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t pos =
-		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(erofs_iloc(inode) +
-				vi->inode_isize + vi->xattr_isize) +
-		lcn * sizeof(struct z_erofs_vle_decompressed_index);
-	struct z_erofs_vle_decompressed_index *di;
+	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(erofs_iloc(inode) +
+			vi->inode_isize + vi->xattr_isize) +
+			lcn * sizeof(struct z_erofs_lcluster_index);
+	struct z_erofs_lcluster_index *di;
 	unsigned int advise, type;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
@@ -57,33 +56,33 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 
-	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
 
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
 			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
 					Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
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
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
-		if (advise & Z_EROFS_VLE_DI_PARTIAL_REF)
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+		if (advise & Z_EROFS_LI_PARTIAL_REF)
 			m->partialref = true;
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
@@ -125,13 +124,13 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
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
@@ -169,19 +168,19 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
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
@@ -195,9 +194,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
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
@@ -211,7 +210,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 			--i;
 			lo = decode_compactedbits(lclusterbits, lomask,
 						  in, encodebits * i, &type);
-			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 				i -= lo;
 
 			if (i >= 0)
@@ -223,10 +222,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
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
 				/* bigpcluster shouldn't have plain d0 == 1 */
@@ -301,10 +300,10 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+	if (datamode == EROFS_INODE_COMPRESSED_FULL)
 		return legacy_load_cluster_from_disk(m, lcn);
 
-	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
 		return compacted_load_cluster_from_disk(m, lcn, lookahead);
 
 	return -EINVAL;
@@ -326,7 +325,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			return err;
 
 		switch (m->type) {
-		case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 			if (!m->delta[0]) {
 				erofs_err(m->inode->i_sb,
 					  "invalid lookback distance 0 @ nid %llu",
@@ -336,9 +335,9 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			}
 			lookback_distance = m->delta[0];
 			continue;
-		case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 			m->headtype = m->type;
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
@@ -367,15 +366,15 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	unsigned long lcn;
 	int err;
 
-	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1 &&
+		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD2);
 	DBG_BUGON(m->type != m->headtype);
 
-	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
+	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
-	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
+	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 		map->m_plen = 1ULL << lclusterbits;
 		return 0;
@@ -397,19 +396,19 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	 * BUG_ON in the debugging mode only for developers to notice that.
 	 */
 	DBG_BUGON(lcn == initial_lcn &&
-		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
+		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
 	switch (m->type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
 		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
 		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
 			goto err_bonus_cblkcnt;
 		if (m->compressedblks)
@@ -453,12 +452,12 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 		if (err)
 			return err;
 
-		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			DBG_BUGON(!m->delta[1] &&
 				  m->clusterofs != 1 << lclusterbits);
-		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
+		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
+			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
 			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
 				break;
@@ -477,8 +476,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 }
 
 static int z_erofs_do_map_blocks(struct inode *inode,
-				 struct erofs_map_blocks *map,
-				 int flags)
+				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
@@ -508,9 +506,9 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	end = (m.lcn + 1ULL) << lclusterbits;
 
 	switch (m.type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
+	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -535,7 +533,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
 		fallthrough;
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
@@ -556,7 +554,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		vi->z_tailextent_headlcn = m.lcn;
 		/* for non-compact indexes, fragmentoff is 64 bits */
 		if (fragment &&
-		    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		    vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
 			vi->z_fragmentoff |= (u64)m.pblk << 32;
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
@@ -572,7 +570,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 	}
 
-	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+	if (m.headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN) {
 		if (map->m_llen > map->m_plen) {
 			DBG_BUGON(1);
 			err = -EFSCORRUPTED;
@@ -582,7 +580,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			Z_EROFS_COMPRESSION_INTERLACED :
 			Z_EROFS_COMPRESSION_SHIFTED;
 	} else {
-		afmt = m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2 ?
+		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
 			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
@@ -676,7 +674,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto out_put_metabuf;
 	}
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
 		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
-- 
2.43.5

