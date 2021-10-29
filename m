Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F221C43F6D2
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 07:52:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgWlk61FGz2ybK
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 16:52:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=59.36.132.42; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from qq.com (smtpbg466.qq.com [59.36.132.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgWlc5xF4z2xXc
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 16:51:56 +1100 (AEDT)
X-QQ-mid: bizesmtp32t1635486644tqf0yko3
Received: from tj.ccdomain.com (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 29 Oct 2021 13:50:43 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000B00A0000000
X-QQ-FEAT: xoS364mEyr2ehjlcQpeWqNN6tkiZqatp9Un/cKGLkinDv8Sx00vbAnKJ4NN20
 Fzi6UrCuEeLpXkl72X6SXFfIL6/aQgYpmil5P52/SITSE7x7eHDWw5g2UuWxnJxhUjoGVaB
 r12lpJUrEY17S8CsHoJ96pa+FbOv5/kzIFCrIceOVGcfgK43tvPZE41vTfwkWveZyLf5lvX
 V535pG5/1fZWEBzddjiYKwd0TcRNegmybAYa+7+3wYJm0l2NvizWT2YSD0q9Y+ACts57QXl
 DhtYK8a7TiyReouffiW401cpG1NuretB1sUTeW8qfUus15oiNWIUOaxLuWMnb8udOrutD7k
 Cz8rBRp1Qg7X5/PrSM1uBg9GgKoPCs6IZlRvxRbCB8PT9zDOoN3L91E/1qvxQ==
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2 2/2] erofs-utils: fuse: support tail-packing inline
 compressed data
Date: Fri, 29 Oct 2021 13:49:31 +0800
Message-Id: <74588f43039bb1554d3168bf54d3b987467ce26d.1635485195.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <cover.1635485195.git.huyue2@yulong.com>
References: <cover.1635485195.git.huyue2@yulong.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign6
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
Cc: zhangwen@yulong.com, Yue Hu <huyue2@yulong.com>, geshifei@yulong.com,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add tail-packing inline compressed data support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
changes since v1:
- add tail-packing information to inode and get it on first read.
- update tail-packing checking logic.

 include/erofs/internal.h |   3 +
 lib/decompress.c         |   3 -
 lib/zmap.c               | 130 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3769c27..ce9fb40 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -165,6 +165,8 @@ struct erofs_inode {
 			uint16_t z_advise;
 			uint8_t  z_algorithmtype[2];
 			uint8_t  z_logical_clusterbits;
+			uint16_t z_idata_size;
+			uint64_t z_idata_addr;
 		};
 	};
 #ifdef WITH_ANDROID
@@ -251,6 +253,7 @@ struct erofs_map_blocks {
 
 	unsigned int m_flags;
 	erofs_blk_t index;
+	unsigned long m_taillcn;
 };
 
 /* super.c */
diff --git a/lib/decompress.c b/lib/decompress.c
index 0b6678d..ac5d126 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -73,9 +73,6 @@ out:
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
-		if (rq->inputsize != EROFS_BLKSIZ)
-			return -EFSCORRUPTED;
-
 		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
 		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 1084faa..6fcb5cd 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -12,6 +12,9 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
+static int z_erofs_map_tail_data_blocks(struct erofs_inode *vi,
+					struct erofs_map_blocks *map);
+
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
 	if (!erofs_sb_has_big_pcluster() &&
@@ -26,7 +29,68 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
+static erofs_off_t compacted_inline_data_addr(struct erofs_inode *vi)
+{
+	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
+					   vi->xattr_isize, 8) +
+					   sizeof(struct z_erofs_map_header);
+	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
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
+	addr = ebase;
+	addr += compacted_4b_initial * 4;
+	addr += compacted_2b * 2;
+	if (compacted_4b_end > 1)
+		addr += (compacted_4b_end/2) * 8;
+	if (compacted_4b_end % 2)
+		addr += 8;
+
+	return addr;
+}
+
+static erofs_off_t legacy_inline_data_addr(struct erofs_inode *vi)
+{
+	const erofs_off_t ibase = iloc(vi->nid);
+	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
+	erofs_off_t addr;
+
+	addr = Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
+					     vi->xattr_isize) +
+		totalidx * sizeof(struct z_erofs_vle_decompressed_index);
+	return addr;
+}
+
+static erofs_off_t z_erofs_inline_data_addr(struct erofs_inode *vi)
+{
+	const unsigned int datamode = vi->datalayout;
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_inline_data_addr(vi);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return legacy_inline_data_addr(vi);
+
+	return -EINVAL;
+}
+
+static int z_erofs_fill_inode_lazy(struct erofs_inode *vi,
+				   struct erofs_map_blocks *map)
 {
 	int ret;
 	erofs_off_t pos;
@@ -46,6 +110,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 
 	h = (struct z_erofs_map_header *)buf;
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
@@ -64,6 +129,15 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 			  vi->nid * 1ULL);
 		return -EFSCORRUPTED;
 	}
+	if (vi->z_advise & Z_EROFS_ADVISE_TAILPACKING)
+		vi->z_idata_addr = z_erofs_inline_data_addr(vi);
+
+	if (vi->z_idata_size) {
+		ret = z_erofs_map_tail_data_blocks(vi, map);
+		if (ret)
+			return ret;
+	}
+
 	vi->flags |= EROFS_I_Z_INITED;
 	return 0;
 }
@@ -375,6 +449,37 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
+static int z_erofs_map_tail_data_blocks(struct erofs_inode *vi,
+					struct erofs_map_blocks *map)
+{
+	struct z_erofs_maprecorder m = {
+		.inode = vi,
+		.map = map,
+		.kaddr = map->mpage,
+	};
+        unsigned long lcn;
+        unsigned int lclusterbits, endoff;
+        int err;
+
+        lclusterbits = vi->z_logical_clusterbits;
+        lcn = (vi->i_size - 1) >> lclusterbits;
+        endoff = (vi->i_size - 1) & ((1 << lclusterbits) - 1);
+
+        err = z_erofs_load_cluster_from_disk(&m, lcn);
+        if (err)
+                return err;
+
+        if (endoff >= m.clusterofs)
+                goto out;
+
+        err = z_erofs_extent_lookback(&m, 1);
+        if (err)
+                return err;
+out:
+        map->m_taillcn = m.lcn;
+        return 0;
+}
+
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 					    unsigned int initial_lcn)
 {
@@ -463,12 +568,12 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 		goto out;
 	}
 
-	err = z_erofs_fill_inode_lazy(vi);
+	ofs = map->m_la;
+	err = z_erofs_fill_inode_lazy(vi, map);
 	if (err)
 		goto out;
 
 	lclusterbits = vi->z_logical_clusterbits;
-	ofs = map->m_la;
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
@@ -511,11 +616,22 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	}
 
 	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
-	if (err)
-		goto out;
+	if (m.lcn == map->m_taillcn && vi->z_idata_size) {
+		map->m_plen = vi->z_idata_size;
+
+		if (vi->z_advise & Z_EROFS_ADVISE_TAILPACKING)
+			map->m_pa = vi->z_idata_addr;
+		else
+			map->m_pa = blknr_to_addr(m.pblk);
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		map->m_pa = blknr_to_addr(m.pblk);
+
+		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+		if (err)
+			goto out;
+	}
 	map->m_flags |= EROFS_MAP_MAPPED;
 
 out:
-- 
2.29.0



