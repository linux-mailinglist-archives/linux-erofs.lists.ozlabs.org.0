Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA5439668
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 14:34:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HdDsx6f6nz2yHw
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 23:34:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=113.96.223.73; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
X-Greylist: delayed 70 seconds by postgrey-1.36 at boromir;
 Mon, 25 Oct 2021 23:34:19 AEDT
Received: from qq.com (smtpbg411.qq.com [113.96.223.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HdDsl5669z2xh0
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Oct 2021 23:34:19 +1100 (AEDT)
X-QQ-mid: bizesmtp46t1635165111twmfu5cn
Received: from tj.ccdomain.com (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 25 Oct 2021 20:31:50 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000000A0000000
X-QQ-FEAT: eTtJes0duVsW/yPD1J1qESmHjc4sNA5jOzd5Wl/YXgtuh7LQHE3M1BLFUXjL0
 CzoPFw77UYXv8UYkxX9lYluD7ebA4Or2QELxkUz8iT+O55oRPMjXABV8tglz7izx5UnLP4v
 fJprDOXGrtya+NcLRfMFobMNVvk0Fi1+TTy1HA+0Z8q1SHRmDzQf2xaufeCGq300jJYSIxd
 tA48/XqAGCeJRu7dmjTtdNNeWcnIuKb2q9ydwSyMGD5i8tSVmnXyWmZacSFO9jwkv/GYh+P
 i4/jqXV+MoXqkdmpTttGxX7IigN2LZ9+LLdfLYKTKRaSn+Yk6ByGxJO9KaOoHTyR6HzqQl+
 rhAxVJE6U20P2uMtUkZci8fk5XnlX4NxHhMRWGuTCrfPTAbTPWIeYUZ2p+vNg==
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 2/2] erofs-utils: fuse: support tail-packing inline
 compressed data
Date: Mon, 25 Oct 2021 20:30:44 +0800
Message-Id: <c7855cbdd82f62fbc84d36d9fb3c892cfa569128.1635162978.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <cover.1635162978.git.huyue2@yulong.com>
References: <cover.1635162978.git.huyue2@yulong.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: huyue2@yulong.com, geshifei@yulong.com, zhangwen@yulong.com,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add tail-packing inline compressed data support for erofsfuse.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 lib/zmap.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 1084faa..de79f03 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -442,6 +442,66 @@ err_bonus_cblkcnt:
 	return -EFSCORRUPTED;
 }
 
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
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map)
 {
@@ -454,6 +514,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	unsigned int lclusterbits, endoff;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
+	bool tailpacking;
 
 	/* when trying to read beyond EOF, leave it unmapped */
 	if (map->m_la >= vi->i_size) {
@@ -467,6 +528,8 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	if (err)
 		goto out;
 
+	tailpacking = vi->z_advise & Z_EROFS_ADVISE_TAILPACKING;
+
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
 	initial_lcn = ofs >> lclusterbits;
@@ -478,6 +541,9 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 
 	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
 	end = (m.lcn + 1ULL) << lclusterbits;
+
+	map->m_flags &= ~EROFS_MAP_META;
+
 	switch (m.type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		if (endoff >= m.clusterofs)
@@ -485,6 +551,16 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		if (endoff >= m.clusterofs) {
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			if (tailpacking &&
+			    end == round_up(vi->i_size, 1<<lclusterbits)) {
+				end = vi->i_size;
+				map->m_flags |= EROFS_MAP_META;
+			}
+			if (tailpacking &&
+			    end == round_down(vi->i_size, 1<<lclusterbits) &&
+			    vi->i_size - map->m_la <= EROFS_BLKSIZ) {
+				map->m_flags |= EROFS_MAP_META;
+			}
 			break;
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
@@ -495,7 +571,10 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			goto out;
 		}
 		end = (m.lcn << lclusterbits) | m.clusterofs;
-		map->m_flags |= EROFS_MAP_FULL_MAPPED;
+		if (tailpacking && end == vi->i_size)
+			map->m_flags |= EROFS_MAP_META;
+		else
+			map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
@@ -511,11 +590,17 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	}
 
 	map->m_llen = end - map->m_la;
-	map->m_pa = blknr_to_addr(m.pblk);
 
-	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
-	if (err)
-		goto out;
+	if (map->m_flags & EROFS_MAP_META) {
+		map->m_pa = z_erofs_inline_data_addr(vi);
+		map->m_plen = EROFS_BLKSIZ;
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



