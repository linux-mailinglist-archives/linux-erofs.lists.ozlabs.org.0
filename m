Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 013CD350D15
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 05:30:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pbd6qCdz30MK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:30:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YQacv8jE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YQacv8jE; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9pbb6BDyz304G
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 14:30:19 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F105F610CF;
 Thu,  1 Apr 2021 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617247818;
 bh=DmGQHcQluO1kUCAFwFzuc7yW9Zmxyq5ucgVUne1Q0FU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YQacv8jEO1FnPNQZvGsK8itds6xJ1EARBmjw4vpoXQYc3Np67L+M8wXAP8+pP39bC
 4jIdPWMhcDzk17Ziug4y+qJo6R8zecnmVIaOrMXw1JQO1elsdKWPaXE8fuGfNlj/k1
 VF4WiIFuNrcxd2vzqcFsEgISvDOT/19guXUed/5b6Ftc9R4C831sa5eD6deiiT5TFa
 xea8ku26tu3DgXb2diN8V3Vv5upchiG6mZKIuyMRwWntzncENacdPAFmKV7Awh75/A
 VOpYnoU44IHrfCYRZv1azFWXCuyL6cQw5dmvwaR5YzWpCMf7Tb6Dbg+lU56G3ZY5rM
 0cZNqqiZWBhww==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 07/10] erofs: support parsing big pcluster compress indexes
Date: Thu,  1 Apr 2021 11:29:51 +0800
Message-Id: <20210401032954.20555-8-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

When INCOMPAT_BIG_PCLUSTER sb feature is enabled, legacy compress indexes
will also have the same on-disk header compact indexes to keep per-file
configurations instead of leaving it zeroed.

If ADVISE_BIG_PCLUSTER is set for a file, CBLKCNT will be loaded for each
pcluster in this file by parsing 1st non-head lcluster.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zmap.c | 79 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bd7e10c2fdd3..d34ff810cc15 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -11,8 +11,10 @@
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	if (!erofs_sb_has_big_pcluster(sbi) &&
+	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -49,7 +51,8 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
-	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+	DBG_BUGON(!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
 		    vi->xattr_isize, 8);
@@ -96,7 +99,7 @@ struct z_erofs_maprecorder {
 	u8  type;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk;
+	erofs_blk_t pblk, compressedlcs;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -159,6 +162,15 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
+		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			m->compressedlcs = m->delta[0] &
+				~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->delta[0] = 1;
+		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
@@ -366,6 +378,58 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
+static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
+					    unsigned int initial_lcn)
+{
+	struct erofs_inode *const vi = EROFS_I(m->inode);
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn;
+	int err;
+
+	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+		map->m_plen = 1 << lclusterbits;
+		return 0;
+	}
+
+	lcn = m->lcn + 1;
+	if (m->compressedlcs)
+		goto out;
+	if (lcn == initial_lcn)
+		goto err_bonus_cblkcnt;
+
+	err = z_erofs_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		if (m->delta[0] != 1)
+			goto err_bonus_cblkcnt;
+		if (m->compressedlcs)
+			break;
+		fallthrough;
+	default:
+		erofs_err(m->inode->i_sb,
+			  "cannot found CBLKCNT @ lcn %lu of nid %llu",
+			  lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+out:
+	map->m_plen = m->compressedlcs << lclusterbits;
+	return 0;
+err_bonus_cblkcnt:
+	erofs_err(m->inode->i_sb,
+		  "bogus CBLKCNT @ lcn %lu of nid %llu",
+		  lcn, vi->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
+}
+
 int z_erofs_map_blocks_iter(struct inode *inode,
 			    struct erofs_map_blocks *map,
 			    int flags)
@@ -377,6 +441,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	};
 	int err = 0;
 	unsigned int lclusterbits, endoff;
+	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
 	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
@@ -395,10 +460,10 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
-	m.lcn = ofs >> lclusterbits;
+	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
 	if (err)
 		goto unmap_out;
 
@@ -442,10 +507,12 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	}
 
 	map->m_llen = end - map->m_la;
-	map->m_plen = 1 << lclusterbits;
 	map->m_pa = blknr_to_addr(m.pblk);
 	map->m_flags |= EROFS_MAP_MAPPED;
 
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (err)
+		goto out;
 unmap_out:
 	if (m.kaddr)
 		kunmap_atomic(m.kaddr);
-- 
2.20.1

