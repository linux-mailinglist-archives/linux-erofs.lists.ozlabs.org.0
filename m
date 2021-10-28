Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DD943DF3E
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 12:50:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hg2QD1Qz0z304v
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 21:50:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hg2Q745sXz2xD7
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 21:50:07 +1100 (AEDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hg2J33VCTzbnSH;
 Thu, 28 Oct 2021 18:44:51 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 18:49:31 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 18:49:30 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2 1/5] erofs-utils: add support for the full decompressed
 length
Date: Thu, 28 Oct 2021 18:57:44 +0800
Message-ID: <20211028105748.3586231-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
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
Cc: daeho43@gmail.com, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Previously, there is no need to get the full decompressed length since
EROFS supports partial decompression. However for some other cases
such as fiemap, the full decompressed length is necessary for iomap to
make it work properly.

This patch adds a way to get the full decompressed length. Note that
it takes more metadata overhead and it'd be avoided if possible in the
performance sensitive scenario.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/internal.h |  8 +++-
 lib/data.c               |  2 +-
 lib/zmap.c               | 99 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 8b154ed..a487871 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -259,6 +259,12 @@ struct erofs_map_blocks {
 	erofs_blk_t index;
 };
 
+/*
+ * Used to get the exact decompressed length, e.g. fiemap (consider lookback
+ * approach instead if possible since it's more metadata lightweight.)
+ */
+#define EROFS_GET_BLOCKS_FIEMAP	0x0002
+
 /* super.c */
 int erofs_read_superblock(void);
 
@@ -271,7 +277,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map);
+			    struct erofs_map_blocks *map, int flags);
 
 #ifdef EUCLEAN
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
diff --git a/lib/data.c b/lib/data.c
index 641d840..30e7312 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -201,7 +201,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	while (end > offset) {
 		map.m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(inode, &map);
+		ret = z_erofs_map_blocks_iter(inode, &map, 0);
 		if (ret)
 			break;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 458030b..f6a8ccf 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -159,9 +159,34 @@ static unsigned int decode_compactedbits(unsigned int lobits,
 	return lo;
 }
 
+static int get_compacted_la_distance(unsigned int lclusterbits,
+				     unsigned int encodebits,
+				     unsigned int vcnt, u8 *in, int i)
+{
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int lo, d1 = 0;
+	u8 type;
+
+	DBG_BUGON(i >= vcnt);
+
+	do {
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * i, &type);
+
+		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			return d1;
+		++d1;
+	} while (++i < vcnt);
+
+	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
+	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
+		d1 += lo - 1;
+	return d1;
+}
+
 static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 				  unsigned int amortizedshift,
-				  unsigned int eofs)
+				  unsigned int eofs, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
@@ -190,6 +215,11 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	m->type = type;
 	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
+
+		/* figure out lookahead_distance: delta[1] if needed */
+		if (lookahead)
+			m->delta[1] = get_compacted_la_distance(lclusterbits,
+						encodebits, vcnt, in, i);
 		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
 			if (!big_pcluster) {
 				DBG_BUGON(1);
@@ -260,7 +290,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 }
 
 static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					    unsigned long lcn)
+					    unsigned long lcn, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
@@ -310,11 +340,12 @@ out:
 	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
 	if (err)
 		return err;
-	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
+	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
+				      lookahead);
 }
 
 static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					  unsigned int lcn)
+					  unsigned int lcn, bool lookahead)
 {
 	const unsigned int datamode = m->inode->datalayout;
 
@@ -322,7 +353,7 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		return legacy_load_cluster_from_disk(m, lcn);
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
-		return compacted_load_cluster_from_disk(m, lcn);
+		return compacted_load_cluster_from_disk(m, lcn, lookahead);
 
 	return -EINVAL;
 }
@@ -345,7 +376,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 
 	/* load extent head logical cluster if needed */
 	lcn -= lookback_distance;
-	err = z_erofs_load_cluster_from_disk(m, lcn);
+	err = z_erofs_load_cluster_from_disk(m, lcn, false);
 	if (err)
 		return err;
 
@@ -394,7 +425,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if (m->compressedlcs)
 		goto out;
 
-	err = z_erofs_load_cluster_from_disk(m, lcn);
+	err = z_erofs_load_cluster_from_disk(m, lcn, false);
 	if (err)
 		return err;
 
@@ -440,8 +471,50 @@ err_bonus_cblkcnt:
 	return -EFSCORRUPTED;
 }
 
+static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
+{
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *map = m->map;
+	unsigned int lclusterbits = vi->z_logical_clusterbits;
+	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
+	int err;
+
+	do {
+		/* handle the last EOF pcluster (no next HEAD lcluster) */
+		if ((lcn << lclusterbits) >= vi->i_size) {
+			map->m_llen = vi->i_size - map->m_la;
+			return 0;
+		}
+
+		err = z_erofs_load_cluster_from_disk(m, lcn, true);
+		if (err)
+			return err;
+
+		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+			DBG_BUGON(!m->delta[1] &&
+				  m->clusterofs != 1 << lclusterbits);
+		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
+			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
+			/* go on until the next HEAD lcluster */
+			if (lcn != headlcn)
+				break;
+			m->delta[1] = 1;
+		} else {
+			erofs_err("unknown type %u @ lcn %lu of nid %llu",
+				  m->type, lcn, (unsigned long long)vi->nid);
+			DBG_BUGON(1);
+			return -EOPNOTSUPP;
+		}
+		lcn += m->delta[1];
+	} while (m->delta[1]);
+
+	map->m_llen = (lcn << lclusterbits) + m->clusterofs - map->m_la;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map)
+			    struct erofs_map_blocks *map,
+			    int flags)
 {
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
@@ -470,7 +543,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
 	if (err)
 		goto out;
 
@@ -512,11 +585,17 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 
 	map->m_llen = end - map->m_la;
 	map->m_pa = blknr_to_addr(m.pblk);
+	map->m_flags |= EROFS_MAP_MAPPED;
 
 	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 	if (err)
 		goto out;
-	map->m_flags |= EROFS_MAP_MAPPED;
+
+	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
+		err = z_erofs_get_extent_decompressedlen(&m);
+		if (!err)
+			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+	}
 
 out:
 	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
-- 
2.31.1

