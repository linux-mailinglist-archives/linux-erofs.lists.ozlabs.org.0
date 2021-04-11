Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1DA35B152
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXg50dyz3bwH
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:49:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IQngRuK3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IQngRuK3; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXf1xgmz3bvc
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:49:06 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2C97611AE;
 Sun, 11 Apr 2021 03:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112944;
 bh=qkmIK+GEdyDoN9R+s2fqk9bghierqyIiW6MNa7/qaYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IQngRuK3Gkw4Hf8pRyKBq1K1SJjiKaOre+gXX7EzTbiHmuGmetzfnvguRd7jBfyON
 GZO+6KoDdZZFjVHoRXTJrR5RtY+pMlEAnHddbZxgBTNHDpuQfDEyNHFUUBZqr9tVw+
 ImnitDwrylqREEHOkvFVFzBJd8KnuY77ReuVcYfm5kKQgb2gqYFGf8wAapDOUpmN+r
 i0AgCtpfmhSHg9VXvFxvGPTZNfKsG0wZKNHe1QeP/ueXHFb6qtu0Sgry11nbsrgPVR
 KOr8c6IENdIM3Fi4A5bH9PzLN7zGwd1V/NXStpJvuLDhoGmt8gAMl0vWW1SoqEuIrr
 lIjwYOrMO6CVw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/8] erofs-utils: fuse: support multiple block compression
Date: Sun, 11 Apr 2021 11:48:41 +0800
Message-Id: <20210411034844.12673-6-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210411034844.12673-1-xiang@kernel.org>
References: <20210411034844.12673-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add multiple block compression runtime support for erofsfuse.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/data.c |  4 +--
 lib/zmap.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/lib/data.c b/lib/data.c
index 56de16b3c840..31d81f3c8a2a 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -130,7 +130,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	};
 	bool partial;
 	unsigned int algorithmformat;
-	char raw[EROFS_BLKSIZ];
+	char raw[Z_EROFS_PCLUSTER_MAX_SIZE];
 
 	end = offset + size;
 	while (end > offset) {
@@ -167,7 +167,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
-		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
+		ret = dev_read(raw, map.m_pa, map.m_plen);
 		if (ret < 0)
 			return -EIO;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index ee63de74cab2..096fd35cdeb3 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -14,7 +14,8 @@
 
 int z_erofs_fill_inode(struct erofs_inode *vi)
 {
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	if (!erofs_sb_has_big_pcluster() &&
+	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -37,7 +38,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	if (vi->flags & EROFS_I_Z_INITED)
 		return 0;
 
-	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
+		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
 	ret = dev_read(buf, pos, sizeof(buf));
@@ -81,7 +83,7 @@ struct z_erofs_maprecorder {
 	u8  type;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk;
+	erofs_blk_t pblk, compressedlcs;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -130,6 +132,15 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
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
@@ -333,6 +344,51 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
+static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
+					    unsigned int initial_lcn)
+{
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn;
+	int err;
+
+	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+	if (!((map->m_flags & EROFS_MAP_ZIPPED) &&
+	      (vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1))) {
+		map->m_plen = 1 << lclusterbits;
+		return 0;
+	}
+
+	lcn = m->lcn + 1;
+	if (lcn == initial_lcn && !m->compressedlcs)
+		m->compressedlcs = 2;
+
+	if (m->compressedlcs)
+		goto out;
+
+	err = z_erofs_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		DBG_BUGON(m->delta[0] != 1);
+		if (m->compressedlcs) {
+			break;
+		}
+	default:
+		erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
+			  lcn, (unsigned long long)vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+out:
+	map->m_plen = m->compressedlcs << lclusterbits;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map)
 {
@@ -343,6 +399,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	};
 	int err = 0;
 	unsigned int lclusterbits, endoff;
+	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
 	/* when trying to read beyond EOF, leave it unmapped */
@@ -359,10 +416,10 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
-	m.lcn = ofs >> lclusterbits;
+	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
 	if (err)
 		goto out;
 
@@ -401,8 +458,11 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	}
 
 	map->m_llen = end - map->m_la;
-	map->m_plen = 1 << lclusterbits;
 	map->m_pa = blknr_to_addr(m.pblk);
+
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (err)
+		goto out;
 	map->m_flags |= EROFS_MAP_MAPPED;
 
 out:
-- 
2.20.1

