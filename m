Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46920454390
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 10:23:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvHY90bb8z2yYl
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 20:23:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637141021;
	bh=awZqypvGT6gCEQUKfa8YIw2YEZHVcNMan683HExKo34=;
	h=To:Subject:Date:In-Reply-To:References:In-Reply-To:References:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:From:Reply-To:Cc:From;
	b=QIFrJ/iGQrU9o+bGHbMLiC8+czb86fjswSCM5HOmI7kJIVW6KBXns5qSrJcdRRnMQ
	 AgjcOq16BVK7yc+BPLxJGHPfoBO941PvylBqOUzVaZh7NlnOMHmaFLNA46t54+ofFM
	 NxZGBTFvHgkoLOPMV3CdQAveQf1ONbNVNRvx4opdbFv4w/bXLN5gOM18J3dZYuU2y2
	 qHxGTKS7bLeGdEnN0n5apTVCDcojpITf1T1TaBwzHoiOXAeDSGqTlBnIu0eaDoEp4p
	 x6pWHo9r/EW6lInfMfDyo2LD1m6Xcjh4YeuVyp+RY7nJReFoynF4DSjj422RjvSpTi
	 FTp8fdttvwd6w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=59.36.132.72; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from qq.com (smtpbg473.qq.com [59.36.132.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvHXv5LH8z2xBF
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 20:23:27 +1100 (AEDT)
X-QQ-mid: bizesmtp35t1637140934t2wf9uu6
Received: from localhost.localdomain (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 17 Nov 2021 17:22:13 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000B00C0000000
X-QQ-FEAT: OIOOx9IFrn8qh62LbyK9iv8YlFreT6vTid62IDBxtCh+UKgiw/HsXJIxrimzE
 4zCHygD83DrVsXJkPwwfaGxdFyRz9r5yMZbp8pwwL9/YEonYFavWaL/1d3xlC0OZAr1JNLm
 CqGl4VdsOpelcZxAKfufmm15Q7m1o8XGSBGM/kCTmlAo86KU8HO6ItB8x3z93VRZW+uVY8F
 bAUXu3dqFizgy6DlM/nU1EgChu4RO+0PvnAahOs3qelAmE25RNYWKBfEipquPdwc1gInclb
 bqJMPSSTmMmPw1jXlorjHatEuKI0sDquPBQrEo9qOfWQ6NhypXtYmdnFuciZjS4tDlbh0jw
 6MF64NxroRcWvEEq90PkznJRv+eGynvuUdJDNWWrzAT8FX54VJyB3OgBgyOqA==
X-QQ-GoodBg: 2
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v3 2/2] erofs-utils: fuse: support tail-packing inline
 compressed data
Date: Wed, 17 Nov 2021 17:22:01 +0800
Message-Id: <fcb5afd747456997284bbd411a68e4a19b41966f.1637140430.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b1b3b72371dd4a6b46137dce2fab04899e111df9.1637140430.git.huyue2@yulong.com>
References: <b1b3b72371dd4a6b46137dce2fab04899e111df9.1637140430.git.huyue2@yulong.com>
In-Reply-To: <cover.1637140430.git.huyue2@yulong.com>
References: <cover.1637140430.git.huyue2@yulong.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign7
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
From: Yue Hu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yue Hu <huyue2@yulong.com>
Cc: zhangwen@yulong.com, Yue Hu <huyue2@yulong.com>, geshifei@yulong.com,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add tail-packing inline compressed data support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v3:
- remove z_idata_addr, add z_idata_headlcn instead of m_taillcn.
- add bug_on for legacy if enable inline and disable big pcluster.
- extract z_erofs_do_map_blocks() instead of added
  z_erofs_map_tail_data_blocks() with similar logic.

v2:
- add tail-packing information to inode and get it on first read.
- update tail-packing checking logic.

 include/erofs/internal.h |   2 +
 lib/decompress.c         |   3 -
 lib/zmap.c               | 136 +++++++++++++++++++++++++++++++++------
 3 files changed, 120 insertions(+), 21 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 54e5939..5d1a44c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -172,6 +172,8 @@ struct erofs_inode {
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
 			uint8_t  z_physical_clusterblks;
+			uint16_t z_idata_size;
+			uint32_t z_idata_headlcn;
 		};
 	};
 #ifdef WITH_ANDROID
diff --git a/lib/decompress.c b/lib/decompress.c
index 6f4ecc2..806ac91 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -71,9 +71,6 @@ out:
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
-		if (rq->inputsize != EROFS_BLKSIZ)
-			return -EFSCORRUPTED;
-
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
 		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 458030b..42783e5 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -10,6 +10,9 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
+static int z_erofs_do_map_blocks(struct erofs_inode *vi,
+				 struct erofs_map_blocks *map);
+
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	if (!erofs_sb_has_big_pcluster() &&
@@ -18,12 +21,69 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_idata_size = 0;
 
 		vi->flags |= EROFS_I_Z_INITED;
+		DBG_BUGON(erofs_sb_has_tail_packing());
 	}
 	return 0;
 }
 
+static erofs_off_t compacted_inline_data_addr(struct erofs_inode *vi,
+					      unsigned int totalidx)
+{
+	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
+				  vi->xattr_isize, 8) +
+				  sizeof(struct z_erofs_map_header);
+	unsigned int compacted_4b_initial, compacted_4b_end;
+	unsigned int compacted_2b;
+	erofs_off_t addr;
+
+	compacted_4b_initial = (32 - ebase % 32) / 4;
+	if (compacted_4b_initial == 32 / 4)
+		compacted_4b_initial = 0;
+
+	if (compacted_4b_initial > totalidx) {
+		compacted_4b_initial = 0;
+		compacted_2b = 0;
+	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+	} else
+		compacted_2b = 0;
+
+	compacted_4b_end = totalidx - compacted_4b_initial - compacted_2b;
+
+	addr = ebase + compacted_4b_initial * 4 + compacted_2b * 2;
+	if (compacted_4b_end > 1)
+		addr += (compacted_4b_end/2) * 8;
+	if (compacted_4b_end % 2)
+		addr += 8;
+
+	return addr;
+}
+
+static erofs_off_t legacy_inline_data_addr(struct erofs_inode *vi,
+					   unsigned int totalidx)
+{
+	return Z_EROFS_VLE_LEGACY_INDEX_ALIGN(iloc(vi->nid) + vi->inode_isize +
+					      vi->xattr_isize) +
+		totalidx * sizeof(struct z_erofs_vle_decompressed_index);
+}
+
+static erofs_off_t z_erofs_inline_data_addr(struct erofs_inode *vi)
+{
+	const unsigned int datamode = vi->datalayout;
+	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_inline_data_addr(vi, totalidx);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return legacy_inline_data_addr(vi, totalidx);
+
+	return -EINVAL;
+}
+
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
 	int ret;
@@ -44,6 +104,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 
 	h = (struct z_erofs_map_header *)buf;
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
@@ -61,6 +122,16 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 			  vi->nid * 1ULL);
 		return -EFSCORRUPTED;
 	}
+
+	if (vi->z_idata_size) {
+		struct erofs_map_blocks map = { .m_la = vi->i_size - 1 };
+
+		ret = z_erofs_do_map_blocks(vi, &map);
+		if (ret)
+			return ret;
+		vi->z_idata_headlcn = map.m_la >> vi->z_logical_clusterbits;
+	}
+
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -374,7 +445,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 }
 
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
-					    unsigned int initial_lcn)
+					    unsigned int initial_lcn,
+					    bool idatamap)
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_map_blocks *const map = m->map;
@@ -384,6 +456,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
 		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+
+	if (idatamap) {
+		map->m_plen = vi->z_idata_size;
+		return 0;
+	}
+
 	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
 		map->m_plen = 1 << lclusterbits;
@@ -440,8 +518,8 @@ err_bonus_cblkcnt:
 	return -EFSCORRUPTED;
 }
 
-int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map)
+static int z_erofs_do_map_blocks(struct erofs_inode *vi,
+				 struct erofs_map_blocks *map)
 {
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
@@ -452,18 +530,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
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
+	bool idatamap;
 
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
@@ -510,19 +577,52 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 		goto out;
 	}
 
+	/* check if mapping tail-packing data */
+	idatamap = vi->z_idata_size && (ofs == vi->i_size - 1 ||
+		   m.lcn == vi->z_idata_headlcn);
+
+	/* need to trim tail-packing data if beyond file size */
 	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
+	if (idatamap && end > vi->i_size)
+		map->m_llen -= end - vi->i_size;
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (idatamap && (vi->z_advise & Z_EROFS_ADVISE_INLINE_DATA)) {
+		map->m_pa = z_erofs_inline_data_addr(vi);
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		map->m_pa = blknr_to_addr(m.pblk);
+	}
+
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn, idatamap);
 	if (err)
 		goto out;
 	map->m_flags |= EROFS_MAP_MAPPED;
-
 out:
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
+	err = z_erofs_do_map_blocks(vi, map);
+out:
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
 }
-- 
2.17.1



