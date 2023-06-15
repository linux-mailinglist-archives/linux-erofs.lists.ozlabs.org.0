Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1A730F5C
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 08:32:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhXXQ58drz30fP
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 16:32:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhXXK3kDjz2y1b
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 16:32:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vl9Oxes_1686810740;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vl9Oxes_1686810740)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 14:32:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up zmap.c
Date: Thu, 15 Jun 2023 14:32:19 +0800
Message-Id: <20230615063219.87466-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Several trivial cleanups which aren't quite necessary to split:

 - Rename lcluster load functions as well as justify full indexes
   since they are typically used for global deduplication for
   compressed data;

 - Avoid unnecessary lines, comments for simplicity.

No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 69 +++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 920fb4dbc731..47f5a87be7b1 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -22,8 +22,8 @@ struct z_erofs_maprecorder {
 	bool partialref;
 };
 
-static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					 unsigned long lcn)
+static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
+				      unsigned long lcn)
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -226,8 +226,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					    unsigned long lcn, bool lookahead)
+static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
+					 unsigned long lcn, bool lookahead)
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -277,23 +277,23 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					  unsigned int lcn, bool lookahead)
+static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
+					   unsigned int lcn, bool lookahead)
 {
-	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
-
-	if (datamode == EROFS_INODE_COMPRESSED_FULL)
-		return legacy_load_cluster_from_disk(m, lcn);
-
-	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
-		return compacted_load_cluster_from_disk(m, lcn, lookahead);
-
-	return -EINVAL;
+	switch (EROFS_I(m->inode)->datalayout) {
+	case EROFS_INODE_COMPRESSED_FULL:
+		return z_erofs_load_full_lcluster(m, lcn);
+	case EROFS_INODE_COMPRESSED_COMPACT:
+		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
+	struct super_block *sb = m->inode->i_sb;
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 
@@ -301,21 +301,15 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		unsigned long lcn = m->lcn - lookback_distance;
 		int err;
 
-		/* load extent head logical cluster if needed */
-		err = z_erofs_load_cluster_from_disk(m, lcn, false);
+		err = z_erofs_load_lcluster_from_disk(m, lcn, false);
 		if (err)
 			return err;
 
 		switch (m->type) {
 		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
-			if (!m->delta[0]) {
-				erofs_err(m->inode->i_sb,
-					  "invalid lookback distance 0 @ nid %llu",
-					  vi->nid);
-				DBG_BUGON(1);
-				return -EFSCORRUPTED;
-			}
 			lookback_distance = m->delta[0];
+			if (!lookback_distance)
+				goto err_bogus;
 			continue;
 		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
 		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
@@ -324,16 +318,15 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
 			return 0;
 		default:
-			erofs_err(m->inode->i_sb,
-				  "unknown type %u @ lcn %lu of nid %llu",
+			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
 				  m->type, lcn, vi->nid);
 			DBG_BUGON(1);
 			return -EOPNOTSUPP;
 		}
 	}
-
-	erofs_err(m->inode->i_sb, "bogus lookback distance @ nid %llu",
-		  vi->nid);
+err_bogus:
+	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
+		  lookback_distance, lcn, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
 }
@@ -365,7 +358,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if (m->compressedblks)
 		goto out;
 
-	err = z_erofs_load_cluster_from_disk(m, lcn, false);
+	err = z_erofs_load_lcluster_from_disk(m, lcn, false);
 	if (err)
 		return err;
 
@@ -397,9 +390,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 			break;
 		fallthrough;
 	default:
-		erofs_err(m->inode->i_sb,
-			  "cannot found CBLKCNT @ lcn %lu of nid %llu",
-			  lcn, vi->nid);
+		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
+			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
@@ -407,9 +399,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
 err_bonus_cblkcnt:
-	erofs_err(m->inode->i_sb,
-		  "bogus CBLKCNT @ lcn %lu of nid %llu",
-		  lcn, vi->nid);
+	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
 	DBG_BUGON(1);
 	return -EFSCORRUPTED;
 }
@@ -430,7 +420,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			return 0;
 		}
 
-		err = z_erofs_load_cluster_from_disk(m, lcn, true);
+		err = z_erofs_load_lcluster_from_disk(m, lcn, true);
 		if (err)
 			return err;
 
@@ -477,7 +467,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
+	err = z_erofs_load_lcluster_from_disk(&m, initial_lcn, false);
 	if (err)
 		goto unmap_out;
 
@@ -535,8 +525,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
 		/* for non-compact indexes, fragmentoff is 64 bits */
-		if (fragment &&
-		    vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
+		if (fragment && vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
 			vi->z_fragmentoff |= (u64)m.pblk << 32;
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
-- 
2.24.4

