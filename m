Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C94471995
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Dec 2021 11:33:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JBgw95Mkkz30G6
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Dec 2021 21:33:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=113.96.223.98; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from qq.com (smtpbg415.qq.com [113.96.223.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JBgw15Njsz2x9g
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Dec 2021 21:33:21 +1100 (AEDT)
X-QQ-mid: bizesmtp38t1639305136trkng1pb
Received: from localhost.localdomain (unknown [49.65.247.231])
 by esmtp6.qq.com (ESMTP) with 
 id ; Sun, 12 Dec 2021 18:31:32 +0800 (CST)
X-QQ-SSF: 01400000002000Z0Z000B00A0000000
X-QQ-FEAT: FCUjxTjsuSL4XbXGrTE7NRlHB6FNnmmq36tcVrPujRLWXb3Owaok1wzYv3PVg
 ERD6eoj4pKp9TIiF9RQ2N4Q+OoNlPQA1CBEHIjQW7k4J+revVHD+va13BDIdHL8zpbev/kD
 DV3TLmzj6qz+HDJ7TgDp2WLiqnHT1kwNPhul/jdTAeuXRmeGlkpRH58N0tpo5FDjAh75tu3
 udVnS7lmvT/d/DmV81MnTt8J0/eBlZvYsV6MsHic06u8ipsBLOZN1O7/Rs/IfxXv5fdWsDK
 blm0Via2ehZxCcV2GRD0bcAK5ldlWtUbhLlMfQKrO2KI3FnvPFpGHZMLtm/PqQm9DtKS5JJ
 77GpFp27DamkAYbI/VK5SPgvnldlaKjdYCu6N+Lb+g8mSEE7A0=
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	bluce.lee@aliyun.com
Subject: [RFC PATCH v4 1/2] erofs-utils: fuse: support tail-packing inline
 compressed data
Date: Sun, 12 Dec 2021 18:31:28 +0800
Message-Id: <4333936bf0811f2ecb1ad89d72911d7f1f638c90.1639303144.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1639303144.git.huyue2@yulong.com>
References: <cover.1639303144.git.huyue2@yulong.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
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
Cc: geshifei@coolpad.com, zhangwen@coolpad.com, Yue Hu <huyue2@yulong.com>,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add tail-packing inline compressed data support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v4:
- introduce EROFS_GET_BLOCKS_FINDTAIL suggested by Xiang.
- remove 3 functions about calculation to inline data address
  and calculate it directly when reload index.
- add m_nxtioff/z_idataoff to help get/record the inline data address.
- add on-disk feature related.

v3:
- remove z_idata_addr, add z_idata_headlcn instead of m_taillcn.
- add bug_on for legacy if enable inline and disable big pcluster.
- extract z_erofs_do_map_blocks() instead of added
  z_erofs_map_tail_data_blocks() with similar logic.

v2:
- add tail-packing information to inode and get it on first read.
- update tail-packing checking logic.

 include/erofs/internal.h |  8 ++++
 include/erofs_fs.h       | 10 +++-
 lib/decompress.c         |  2 +-
 lib/namei.c              |  2 +-
 lib/zmap.c               | 99 ++++++++++++++++++++++++++++++++--------
 5 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 8b154ed..1c92a27 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -110,6 +110,7 @@ EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
+EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -171,6 +172,9 @@ struct erofs_inode {
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
 			uint8_t  z_physical_clusterblks;
+			uint16_t z_idata_size;
+			uint32_t z_idata_headlcn;
+			uint64_t z_idataoff;
 		};
 	};
 #ifdef WITH_ANDROID
@@ -257,8 +261,12 @@ struct erofs_map_blocks {
 
 	unsigned int m_flags;
 	erofs_blk_t index;
+
+	u16 m_nxtioff;
 };
 
+#define EROFS_GET_BLOCKS_FINDTAIL	0x0001
+
 /* super.c */
 int erofs_read_superblock(void);
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 66a68e3..0e87e85 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -22,11 +22,13 @@
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
+#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
-	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
+	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
+	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -266,13 +268,17 @@ struct z_erofs_lz4_cfgs {
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
+ * bit 3 : tailpacking inline data
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
+#define Z_EROFS_ADVISE_INLINE_DATA		0x0008
 
 struct z_erofs_map_header {
-	__le32	h_reserved1;
+	__le16	h_reserved1;
+	/* record the size of tailpacking data */
+	__le16  h_idata_size;
 	__le16	h_advise;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
diff --git a/lib/decompress.c b/lib/decompress.c
index 2ee1439..9b90d18 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -67,7 +67,7 @@ out:
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
-		if (rq->inputsize != EROFS_BLKSIZ)
+		if (rq->inputsize > EROFS_BLKSIZ)
 			return -EFSCORRUPTED;
 
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
diff --git a/lib/namei.c b/lib/namei.c
index b4bdabf..481b33e 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -137,7 +137,7 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->u.chunkbits = LOG_BLOCK_SIZE +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	} else if (erofs_inode_is_data_compressed(vi->datalayout))
-		z_erofs_fill_inode(vi);
+		return z_erofs_fill_inode(vi);
 	return 0;
 bogusimode:
 	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
diff --git a/lib/zmap.c b/lib/zmap.c
index 458030b..aa51b61 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -10,6 +10,10 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
+static int z_erofs_do_map_blocks(struct erofs_inode *vi,
+				 struct erofs_map_blocks *map,
+				 int flags);
+
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	if (!erofs_sb_has_big_pcluster() &&
@@ -18,8 +22,13 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_idata_size = 0;
 
 		vi->flags |= EROFS_I_Z_INITED;
+		if (erofs_sb_has_ztailpacking()) {
+			erofs_err("unsupported, plz enable big pcluster for legacy compression inline");
+			return -EOPNOTSUPP;
+		}
 	}
 	return 0;
 }
@@ -44,6 +53,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 
 	h = (struct z_erofs_map_header *)buf;
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
@@ -61,6 +71,16 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 			  vi->nid * 1ULL);
 		return -EFSCORRUPTED;
 	}
+
+	if (vi->z_idata_size) {
+		struct erofs_map_blocks map = { .index = UINT_MAX };
+
+		ret = z_erofs_do_map_blocks(vi, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		if (ret)
+			return ret;
+	}
+
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -113,6 +133,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
+	m->map->m_nxtioff = erofs_blkoff(pos) +
+			    sizeof(struct z_erofs_vle_decompressed_index);
 
 	m->lcn = lcn;
 	di = m->kaddr + erofs_blkoff(pos);
@@ -285,7 +307,9 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (compacted_4b_initial == 32 / 4)
 		compacted_4b_initial = 0;
 
-	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+	if (compacted_4b_initial > totalidx)
+		compacted_4b_initial = compacted_2b = 0;
+	else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
 		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
 	else
 		compacted_2b = 0;
@@ -310,6 +334,9 @@ out:
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
+	m->map->m_nxtioff = erofs_blkoff(pos) +
+			((1 << amortizedshift == 2) ? 2 : ((lcn % 2) ? 4 : 8));
+
 	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
 }
 
@@ -374,7 +401,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 }
 
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
-					    unsigned int initial_lcn)
+					    unsigned int initial_lcn,
+					    bool is_idata)
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_map_blocks *const map = m->map;
@@ -384,6 +412,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
 		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+
+	if (is_idata) {
+		map->m_plen = vi->z_idata_size;
+		return 0;
+	}
+
 	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
 		map->m_plen = 1 << lclusterbits;
@@ -440,8 +474,9 @@ err_bonus_cblkcnt:
 	return -EFSCORRUPTED;
 }
 
-int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map)
+static int z_erofs_do_map_blocks(struct erofs_inode *vi,
+				 struct erofs_map_blocks *map,
+				 int flags)
 {
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
@@ -452,21 +487,10 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	unsigned int lclusterbits, endoff;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
-
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
+	bool is_idata;
 
 	lclusterbits = vi->z_logical_clusterbits;
-	ofs = map->m_la;
+	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? vi->i_size - 1 : map->m_la;
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
@@ -474,6 +498,9 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	if (err)
 		goto out;
 
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
+		vi->z_idataoff = blknr_to_addr(map->index) + map->m_nxtioff;
+
 	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
 	end = (m.lcn + 1ULL) << lclusterbits;
 	switch (m.type) {
@@ -510,10 +537,23 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 		goto out;
 	}
 
+	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
+		vi->z_idata_headlcn = m.lcn;
+		goto out;
+	}
+
+	is_idata = vi->z_idata_size && m.lcn == vi->z_idata_headlcn;
+
 	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (is_idata && (vi->z_advise & Z_EROFS_ADVISE_INLINE_DATA)) {
+		map->m_pa = vi->z_idataoff;
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		map->m_pa = blknr_to_addr(m.pblk);
+	}
+
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn, is_idata);
 	if (err)
 		goto out;
 	map->m_flags |= EROFS_MAP_MAPPED;
@@ -522,7 +562,28 @@ out:
 	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
 		  map->m_la, map->m_pa,
 		  map->m_llen, map->m_plen, map->m_flags);
+	return err;
+}
+
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+			    struct erofs_map_blocks *map)
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
+	err = z_erofs_do_map_blocks(vi, map, 0);
+out:
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
-- 
2.17.1



