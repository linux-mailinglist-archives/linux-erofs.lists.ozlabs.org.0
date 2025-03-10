Return-Path: <linux-erofs+bounces-40-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EF3A5905D
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:55:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBC1c5sH1z3bVW;
	Mon, 10 Mar 2025 20:55:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741600516;
	cv=none; b=ELPL+OC9Gg0F+SpxywaQk0vx2HjeuxnoIW2kmxgCN4oTWieWVVC6AkRl0On/CGXxZstZINde3y7spc52KoH1gZLL/iZ5pMv0finD2yq296kgzAtbPArK4VGB+dU7utgSI0ff4bxrh/RUBhbrpBoR90EigThLUcdGpCQnFVQwgbkTmyt6DpHKRXqeNwxX0aL3J8S476cgYuvUTF1GZAoEP6z8WvyuWorNbkG6DmK3qqgeYJ/6QhebKntFuoik9QfixfLDipDKF0l6xWpdRhi9SU+Bj3Iwn+EDKDdUW9YjkdK3SJO1iSMA7DGN5HrqqYv79MJirSneNlLcJ0u5THH/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741600516; c=relaxed/relaxed;
	bh=Br4pjoIxe+WJd9+NNsPcX3mCBJZE87gP9k5YlaGbaj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFujhUvx1a+daLzHZqaljAhS+MDxZ8UcpPlXAWOiJHwezpaD2wWpS5dcy/UazYe5mHFb/vmNSUkXjzvgf07VYAH3Z8eVz5/2ya74tQMJEwuI9AfpVXGQP19iPgAuUPkPO90VNdiodWDOhfTY+brkzTIwX/C2mNpN1xX0k+fWM8e38Wv/ovyMdv9V8PLDES+FpW22j4z5dHXo83r/xsG0Z8y7GHF4EVs4sm4kURCxBvHBBTMGvh3KXeuzdVFxOlQfS0Jnc85SC6sGWwUf97fEImPacbZBLbE5Gz5R6NQdsB+v3/ZZc/fN4XuzLlrnnti3iqbZqKH0nf0vr/KdQcSlww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G9wo558R; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G9wo558R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBC1b4PBvz30Wg
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:55:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600511; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Br4pjoIxe+WJd9+NNsPcX3mCBJZE87gP9k5YlaGbaj0=;
	b=G9wo558RE7dh+RJTregB4HOD1DDeZP0sXWg165piOENk84trVl/9Bu5Iddjh8XwgpZf5QaI6gjZ/06xGIF+hF6baIvQU9OqM7568LH8xCWmmPQhSgHjCJ8AJU0QtfdKpW9ZX3GioJ7eFYj3pQiUNE+b6oOtTpdufjNSoFzjyLZI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F4-I_1741600510 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 07/10] erofs: add encoded extent on-disk definition
Date: Mon, 10 Mar 2025 17:54:57 +0800
Message-ID: <20250310095459.2620647-8-hsiangkao@linux.alibaba.com>
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

Previously, EROFS provided both (non-)compact compressed indexes to
keep necessary hints for each logical block, enabling O(1) random
indexing.  This approach was originally designed for small compression
units (e.g., 4KiB), where compressed data is strictly block-aligned via
fixed-sized output compression.

However, EROFS now supports big pclusters up to 1MiB and many users use
large configurations to minimize image sizes.  For such configurations,
the total number of extents decreases significantly (e.g., only 1,024
extents for a 1GiB file using 1MiB pclusters), then runtime metadata
overhead becomes negligible compared to data I/O and decoding costs.

Additionally, some popular compression algorithm (mainly Zstd) still
lacks native fixed-sized output compression support (although it's
planned by their authors).  Instead of just waiting for compressor
improvements, let's adopt byte-oriented extents, allowing these
compressors to retain their current methods.

For example, it speeds up Zstd compression a lot:
Processor: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz * 96
Dataset:   enwik9
Build time Size       Type Command Line
3m52.339s  266653696  FO   -C524288 -zzstd,22
3m48.549s  266174464  FO   -E48bit -C524288 -zzstd,22
0m12.821s  272134144  FI   -E48bit -C1048576 --max-extent-bytes=1048576 -zzstd,22

0m14.528s  248987648  FO   -C1048576 -zlzma,9
0m14.605s  248504320  FO   -E48bit -C1048576 -zlzma,9

Encoded extents are structured as an array of `struct z_erofs_extent`,
sorted by logical address in ascending order:
   __le32 plen       // encoded length, algorithm id and flags
   __le32 pstart_lo  // physical offset LSB
   __le32 pstart_hi  // physical offset MSB
   __le32 lstart_lo  // logical offset
   __le32 lstart_hi  // logical offset MSB
   ..

Note that prefixed reduced records can be used to minimize metadata for
specific cases (e.g. lstart less than 32 bits, then 32 to 16 bytes).

If the logical lengths of all encoded extents are the same, 4-byte
(plen) and 8-byte (plen, pstart_lo) records can be used. Or, 16-byte
(plen .. lstart_lo) and 32-byte full records have to be used instead.

If 16-byte and 32-byte records are used, the total number of extents
is kept in `struct z_erofs_map_header`, and binary search can be
applied on them.  Note that `eytzinger order` is not considerd because
data sequential access is important.

If 4-byte records are used, 8-byte start physical offset is between
`struct z_erofs_map_header` and the `plen` array.

In addition, 64-bit physical offsets can be applied with new encoded
extent format to match full 48-bit block addressing.

Remove redundant comments around `struct z_erofs_lcluster_index` too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 99 +++++++++++++++++++++------------------------
 fs/erofs/internal.h |  2 +-
 fs/erofs/zmap.c     | 24 +++++------
 3 files changed, 58 insertions(+), 67 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 791124b3f57c..6d461be790bd 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -331,21 +331,20 @@ struct z_erofs_zstd_cfgs {
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
@@ -357,45 +356,24 @@ struct z_erofs_map_header {
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
@@ -409,11 +387,7 @@ enum {
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
@@ -422,19 +396,36 @@ struct z_erofs_lcluster_index {
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
-	(ALIGN(end, 8) + sizeof(struct z_erofs_map_header) + 8)
+#define Z_EROFS_MAP_HEADER_END(end)	\
+	(ALIGN(end, 8) + sizeof(struct z_erofs_map_header))
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
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b35742cf9431..f26191fe148b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -262,7 +262,7 @@ struct erofs_inode {
 		struct {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
-			unsigned char  z_logical_clusterbits;
+			unsigned char  z_lclusterbits;
 			unsigned long  z_tailextent_headlcn;
 			erofs_off_t    z_fragmentoff;
 			unsigned short z_idata_size;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 87f933268ac7..25d3fa8e70d8 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -25,7 +25,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(erofs_iloc(inode) +
+	const erofs_off_t pos = Z_EROFS_FULL_INDEX_START(erofs_iloc(inode) +
 			vi->inode_isize + vi->xattr_isize) +
 			lcn * sizeof(struct z_erofs_lcluster_index);
 	struct z_erofs_lcluster_index *di;
@@ -40,7 +40,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	advise = le16_to_cpu(di->di_advise);
 	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
 	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-		m->clusterofs = 1 << vi->z_logical_clusterbits;
+		m->clusterofs = 1 << vi->z_lclusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
@@ -55,7 +55,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
+		if (m->clusterofs >= 1 << vi->z_lclusterbits) {
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
@@ -102,9 +102,9 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
-		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const erofs_off_t ebase = Z_EROFS_MAP_HEADER_END(erofs_iloc(inode) +
+			vi->inode_isize + vi->xattr_isize);
+	const unsigned int lclusterbits = vi->z_lclusterbits;
 	const unsigned int totalidx = erofs_iblks(inode);
 	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
 	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
@@ -255,7 +255,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 {
 	struct super_block *sb = m->inode->i_sb;
 	struct erofs_inode *const vi = EROFS_I(m->inode);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lclusterbits = vi->z_lclusterbits;
 
 	while (m->lcn >= lookback_distance) {
 		unsigned long lcn = m->lcn - lookback_distance;
@@ -304,7 +304,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1 && !bigpcl1) ||
 	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
 	      m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) && !bigpcl2) ||
-	    (lcn << vi->z_logical_clusterbits) >= inode->i_size)
+	    (lcn << vi->z_lclusterbits) >= inode->i_size)
 		m->compressedblks = 1;
 
 	if (m->compressedblks)
@@ -354,7 +354,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	struct inode *inode = m->inode;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_map_blocks *map = m->map;
-	unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned int lclusterbits = vi->z_lclusterbits;
 	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
 	int err;
 
@@ -398,16 +398,16 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	struct super_block *sb = inode->i_sb;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	bool ztailpacking = vi->z_idata_size;
+	unsigned int lclusterbits = vi->z_lclusterbits;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
 	};
 	int err = 0;
-	unsigned int lclusterbits, endoff, afmt;
+	unsigned int endoff, afmt;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
-	lclusterbits = vi->z_logical_clusterbits;
 	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? inode->i_size - 1 : map->m_la;
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
@@ -569,6 +569,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto done;
 	}
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_lclusterbits = sb->s_blocksize_bits + (h->h_clusterbits & 15);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
@@ -585,7 +586,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	vi->z_logical_clusterbits = sb->s_blocksize_bits + (h->h_clusterbits & 7);
 	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
 	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
 			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-- 
2.43.5


