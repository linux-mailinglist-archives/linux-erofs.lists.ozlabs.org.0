Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826C430AFB
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 18:57:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXR5V4KV0z2ynS
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 03:57:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QUBWxfE4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QUBWxfE4; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXR5N09Ywz2yg8
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 03:57:43 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B0EE60FE3;
 Sun, 17 Oct 2021 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634489860;
 bh=i65g2Y8KtWtfpwM+2KwneRAYUabQyR1gqfyZXHyVTgA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QUBWxfE4pJY7Z1XFqvOkf8unI+keDI3KbXTdlt+2WQbuTZ5kTPfOtLAvujlTUd/r4
 GgtjLHV8NNga2DgZ2POO6aAWxcHYlKyAqlA1GZ3ZFDOaNwG/tJr/hH4M5ZxPXu1a8X
 Gqlh/omEgHPOOiBNl91MlaJEAMfK7Vf5kkuS3Y8WM5P4ozZSEJtUW7GxRbVzLL3VL6
 rGNjYVjhWiJRRYJ0dEAaTMq3JURb720KI8N9IsSitBP3x6eILNq8fPrrEftLc2XEGX
 lllEi0l1PFWebUG9kTQdJ/JTVagjBLXpbFXGh1ZbpH8+aCdzTBKOB2fpOotM7sKtE8
 rvOlg2L9sLcIA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 2/3] erofs: introduce the secondary compression head
Date: Mon, 18 Oct 2021 00:57:21 +0800
Message-Id: <20211017165721.2442-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211009181209.23041-1-xiang@kernel.org>
References: <20211009181209.23041-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
lcluster to indicate whether the whole pcluster is compressed or not.

In this patch, a new HEAD2 head type is introduced to specify another
compression algorithm other than the primary algorithm for each
compressed file, which can be used for upcoming LZMA compression and
LZ4 range dictionary compression for various data patterns.

It has been stayed in the EROFS roadmap for years. Complete it now!

Reviewed-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v3:
 - update comments about on-disk lclusters suggested by Chao.

 fs/erofs/erofs_fs.h | 39 ++++++++++++++++++++-------------------
 fs/erofs/zmap.c     | 41 ++++++++++++++++++++++++++++-------------
 2 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index e480b3854d88..87736cbf18cc 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -22,12 +22,14 @@
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
+#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
-	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE)
+	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -303,35 +305,34 @@ struct z_erofs_map_header {
 #define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
 
 /*
- * Fixed-sized output compression ondisk Logical Extent cluster type:
- *    0 - literal (uncompressed) cluster
- *    1 - compressed cluster (for the head logical cluster)
- *    2 - compressed cluster (for the other logical clusters)
+ * Fixed-sized output compression on-disk logical cluster type:
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
+ *    2 - compressed cluster (for NONHEAD lclusters)
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
 	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
 	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
-	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
 	Z_EROFS_VLE_CLUSTER_TYPE_MAX
 };
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 1c3b068e5a42..85d0289429b3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -28,7 +28,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
-	int err;
+	int err, headnr;
 	erofs_off_t pos;
 	struct page *page;
 	void *kaddr;
@@ -68,9 +68,11 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown compression format %u for nid %llu, please upgrade kernel",
-			  vi->z_algorithmtype[0], vi->nid);
+	headnr = 0;
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
+	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
+			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_done;
 	}
@@ -178,7 +180,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
-			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
+					Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
@@ -189,7 +192,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
@@ -446,7 +450,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		}
 		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		m->headtype = m->type;
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
@@ -470,13 +475,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	int err;
 
 	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
-		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 &&
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD2);
+	DBG_BUGON(m->type != m->headtype);
+
 	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1) &&
+	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
+	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
+	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 		map->m_plen = 1 << lclusterbits;
 		return 0;
 	}
-
 	lcn = m->lcn + 1;
 	if (m->compressedlcs)
 		goto out;
@@ -498,7 +508,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	switch (m->type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		/*
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
@@ -553,7 +564,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			DBG_BUGON(!m->delta[1] &&
 				  m->clusterofs != 1 << lclusterbits);
 		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
-			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
+			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD1 ||
+			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
 			/* go on until the next HEAD lcluster */
 			if (lcn != headlcn)
 				break;
@@ -613,7 +625,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	switch (m.type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -654,6 +667,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
 		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+	else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2)
+		map->m_algorithmformat = vi->z_algorithmtype[1];
 	else
 		map->m_algorithmformat = vi->z_algorithmtype[0];
 
-- 
2.20.1

