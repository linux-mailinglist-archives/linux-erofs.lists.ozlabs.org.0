Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720CB47EA23
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Dec 2021 02:24:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JKq9Z2Vmbz2yZt
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Dec 2021 12:24:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JKq9V0rGnz2xtQ
 for <linux-erofs@lists.ozlabs.org>; Fri, 24 Dec 2021 12:24:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R321e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V.Zdgkx_1640309049; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.Zdgkx_1640309049) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 24 Dec 2021 09:24:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 1/2] erofs-utils: fuse: support tail-packing inline
 compressed data
Date: Fri, 24 Dec 2021 09:24:04 +0800
Message-Id: <20211224012405.43553-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211224012316.42929-1-hsiangkao@linux.alibaba.com>
References: <20211224012316.42929-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Add tail-packing inline compressed data support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |   5 ++
 include/erofs_fs.h       |  10 +++-
 lib/decompress.c         |   5 +-
 lib/namei.c              |   2 +-
 lib/zmap.c               | 101 +++++++++++++++++++++++++++++----------
 5 files changed, 94 insertions(+), 29 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2c7b611..39bb171 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -131,6 +131,7 @@ EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
+EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -192,6 +193,9 @@ struct erofs_inode {
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
 			uint8_t  z_physical_clusterblks;
+			uint16_t z_idata_size;
+			uint32_t z_idata_headlcn;
+			uint32_t z_idataoff;
 		};
 	};
 #ifdef WITH_ANDROID
@@ -295,6 +299,7 @@ struct erofs_map_blocks {
  * approach instead if possible since it's more metadata lightweight.)
  */
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
+#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9a91877..59d9bbb 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -23,12 +23,14 @@
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
+#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
-	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE)
+	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -290,13 +292,17 @@ struct z_erofs_lzma_cfgs {
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
+ * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
+#define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
 
 struct z_erofs_map_header {
-	__le32	h_reserved1;
+	__le16	h_reserved1;
+	/* record the size of tailpacking data */
+	__le16  h_idata_size;
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
diff --git a/lib/decompress.c b/lib/decompress.c
index 359dae7..1661f91 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -110,6 +110,9 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 					  rq->decodedlength);
 
 	if (ret != (int)rq->decodedlength) {
+		erofs_err("failed to %s decompress %d in[%u, %u] out[%u]",
+			  rq->partial_decoding ? "partial" : "full",
+			  ret, rq->inputsize, inputmargin, rq->decodedlength);
 		ret = -EIO;
 		goto out;
 	}
@@ -129,7 +132,7 @@ out:
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
-		if (rq->inputsize != EROFS_BLKSIZ)
+		if (rq->inputsize > EROFS_BLKSIZ)
 			return -EFSCORRUPTED;
 
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
diff --git a/lib/namei.c b/lib/namei.c
index 4124170..97f0f80 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -137,7 +137,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->u.chunkbits = LOG_BLOCK_SIZE +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	} else if (erofs_inode_is_data_compressed(vi->datalayout))
-		z_erofs_fill_inode(vi);
+		return z_erofs_fill_inode(vi);
 	return 0;
 bogusimode:
 	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
diff --git a/lib/zmap.c b/lib/zmap.c
index abc8bab..ccd9bce 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -10,9 +10,13 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
+static int z_erofs_do_map_blocks(struct erofs_inode *vi,
+				 struct erofs_map_blocks *map,
+				 int flags);
+
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
-	if (!erofs_sb_has_big_pcluster() &&
+	if (!erofs_sb_has_big_pcluster() && !erofs_sb_has_ztailpacking() &&
 	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
@@ -35,6 +39,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return 0;
 
 	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
+		  !erofs_sb_has_ztailpacking() &&
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
@@ -61,6 +66,21 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 			  vi->nid * 1ULL);
 		return -EFSCORRUPTED;
 	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		vi->idata_size = le16_to_cpu(h->h_idata_size);
+		if (!vi->idata_size || vi->idata_size > EROFS_BLKSIZ) {
+			erofs_err("invalid tail-packing pclustersize %u",
+				  vi->idata_size);
+			return -EFSCORRUPTED;
+		}
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (ret)
+			return ret;
+	}
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -76,6 +96,7 @@ struct z_erofs_maprecorder {
 	u16 clusterofs;
 	u16 delta[2];
 	erofs_blk_t pblk, compressedlcs;
+	erofs_off_t nextpackoff;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -113,6 +134,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
+	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
 
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(pos);
@@ -186,12 +208,12 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
 
 static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				  unsigned int amortizedshift,
-				  unsigned int eofs, bool lookahead)
+				  erofs_off_t pos, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const unsigned int lomask = (1 << lclusterbits) - 1;
-	unsigned int vcnt, base, lo, encodebits, nblk;
+	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
 	int i;
 	u8 *in, type;
 	bool big_pcluster;
@@ -203,8 +225,12 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	m->nextpackoff = rounddown(pos, vcnt << amortizedshift) +
+			 (vcnt << amortizedshift);
+
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	eofs = erofs_blkoff(pos);
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
 
@@ -341,7 +367,7 @@ out:
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
-	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
+	return unpack_compacted_index(m, amortizedshift, pos,
 				      lookahead);
 }
 
@@ -415,6 +441,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
 		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+
 	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
 		map->m_plen = 1 << lclusterbits;
@@ -513,9 +540,9 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	return 0;
 }
 
-int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map,
-			    int flags)
+static int z_erofs_do_map_blocks(struct erofs_inode *vi,
+				 struct erofs_map_blocks *map,
+				 int flags)
 {
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
@@ -527,20 +554,8 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
-	/* when trying to read beyond EOF, leave it unmapped */
-	if (map->m_la >= vi->i_size) {
-		map->m_llen = map->m_la + 1 - vi->i_size;
-		map->m_la = vi->i_size;
-		map->m_flags = 0;
-		goto out;
-	}
-
-	err = z_erofs_fill_inode_lazy(vi);
-	if (err)
-		goto out;
-
 	lclusterbits = vi->z_logical_clusterbits;
-	ofs = map->m_la;
+	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? vi->i_size - 1 : map->m_la;
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
@@ -548,6 +563,9 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	if (err)
 		goto out;
 
+	if (flags == EROFS_GET_BLOCKS_FINDTAIL)
+		vi->z_idataoff = m.nextpackoff;
+
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 	switch (m.type) {
@@ -582,12 +600,23 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 		goto out;
 	}
 
-	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
-
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
-	if (err)
+	if (flags == EROFS_GET_BLOCKS_FINDTAIL) {
+		vi->z_idata_headlcn = m.lcn;
 		goto out;
+	}
+
+	map->m_llen = end - map->m_la;
+	if ((vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) &&
+	    (m.lcn == vi->z_idata_headlcn)) {
+		map->m_flags |= EROFS_MAP_META;
+		map->m_pa = vi->z_idataoff;
+		map->m_plen = vi->idata_size;
+	} else {
+		map->m_pa = blknr_to_addr(m.pblk);
+		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+		if (err)
+			goto out;
+	}
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
 		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
@@ -604,7 +633,29 @@ out:
 	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
 		  map->m_la, map->m_pa,
 		  map->m_llen, map->m_plen, map->m_flags);
+	return err;
+}
+
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+			    struct erofs_map_blocks *map,
+			    int flags)
+{
+	int err;
 
+	/* when trying to read beyond EOF, leave it unmapped */
+	if (map->m_la >= vi->i_size) {
+		map->m_llen = map->m_la + 1 - vi->i_size;
+		map->m_la = vi->i_size;
+		map->m_flags = 0;
+		return 0;
+	}
+
+	err = z_erofs_fill_inode_lazy(vi);
+	if (err)
+		goto out;
+
+	err = z_erofs_do_map_blocks(vi, map, flags);
+out:
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
-- 
2.24.4

