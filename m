Return-Path: <linux-erofs+bounces-551-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0933AFC92A
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 13:10:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbz0V2wPWz3bcW;
	Tue,  8 Jul 2025 21:10:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751973002;
	cv=none; b=U3FA6VjCw4rHjLJr8B2RwSLhJl8GmWmVnzZ/Xt65gN07s4Tw2MZoXMPsD/7YiwPBb8cSDYhWKbeo5p1lxZ+GE2P1l77GUsRWy2ofXPBnAc12vPESoQOxibf22dTTsMF6m23ecXizQS7QFMhCUWRgB3UQbYIoTX8Yg8Dko7kDMnfzPb7ya7jKaQMPtSa+IJ0AGraTI1qwFM9AVb6MKvOahyPb95HAw7ob4p25lztjPOimv3S6c7a6UtKKxOYr2UY6Am10SsX1Jm1LSg/X3F2n//+NN3HUexmy9YqDoK3pgD0D83CU6yBrS6WffwVb+XBigJQeePnKGR5akApCIo2xZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751973002; c=relaxed/relaxed;
	bh=7MVMqz/WAD5z3rSJOHwQTerGEHdlN5c3dH3AAILDd6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeexwiZAib0zn1V9w8kdWEKxnQrlyY1u5uUFTItRPnPertVto2Bdz46Tcet8UZ/VNxuEodc1CKpHp/EOwySVvPUlZ9gwKeV5a5za2lIpWTCSex1I285Un87J0oGfSeDrMQS7G2Q+QRqlyOnPZ0QcHtnMleYeF0l621JT6Xh5osWs2XQY5eJtdf6HPWk28J+XqipXHCqjuFfrGX4LbMfZayQ/PNi6lptxaUskXCRZdI33/A57gWnuAxV4O7bs/4/U3MPRnFf5oLM2XGkIAkjHuYiZ3v0a5UxTwNz0UAGwc3A9lWOYfBxPKne4Sn3UIWfgraM7ba7PcbsGPyM/sOnl3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iv7UV2GP; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iv7UV2GP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbz0T3bblz3bVW
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 21:10:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4CC4B5C5ABB;
	Tue,  8 Jul 2025 11:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC886C4CEED;
	Tue,  8 Jul 2025 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751972999;
	bh=dzheaSPee36sOXHJUq2zZC2pzBfsWvT3LybX/c1YjKI=;
	h=From:To:Cc:Subject:Date:From;
	b=iv7UV2GPxeslN/c+dWo2tlE6eeBbe6ESxV1+PppBsNhs+MUET4Fo1KhD2kdyZiqPG
	 OLOXYF1G4KqiqeYkujK82qFUKO8n/LcKz8KOHxuFZFgubSuclYP0jgeMc4wcKGpeb1
	 aT59nNUz4hy9iz9+PemFLUlvnitzu50lJbq+xmKjnxMPtN8wdL71nKfQ0gOl+KByoZ
	 8PWLxlzjgL0Rg09qD+tUX0crYZsfBL6rLPZrGqUBMzm29IRM1o0q6ulmFMl23+k27m
	 K/Pog/L3CrlZV2IQW9pbRIAQ9sr+aLLc1SsiNsUr7achFNDDVYWoxiuaIA0TRDjZXi
	 y7FjQugVXwQEg==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()
Date: Tue,  8 Jul 2025 19:09:28 +0800
Message-ID: <20250708110928.3110375-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

All below functions will do sanity check on m->type, let's move sanity
check to z_erofs_load_compact_lcluster() for cleanup.
- z_erofs_map_blocks_fo
- z_erofs_get_extent_compressedlen
- z_erofs_get_extent_decompressedlen
- z_erofs_extent_lookback

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- include Xiang's cleanup diff.
 fs/erofs/zmap.c | 103 +++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 62 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bebc6e3a4d7..431199452542 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
+	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
+				m->type, lcn, EROFS_I(m->inode)->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+
 	switch (EROFS_I(m->inode)->datalayout) {
 	case EROFS_INODE_COMPRESSED_FULL:
 		return z_erofs_load_full_lcluster(m, lcn);
@@ -265,12 +272,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;
 
-		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
-		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
 			if (!lookback_distance)
 				break;
@@ -325,25 +327,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	DBG_BUGON(lcn == initial_lcn &&
 		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
 
-	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-		if (m->delta[0] != 1) {
-			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		if (m->compressedblks)
-			goto out;
-	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
-		/*
-		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
-		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
-		 */
-		m->compressedblks = 1;
-		goto out;
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD && m->delta[0] != 1) {
+		erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
-	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-	DBG_BUGON(1);
-	return -EFSCORRUPTED;
+
+	/*
+	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
+	 * than CBLKCNT, it's a 1 block-sized pcluster.
+	 */
+	if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD || !m->compressedblks)
+		m->compressedblks = 1;
 out:
 	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
@@ -379,11 +374,6 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			if (lcn != headlcn)
 				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
-		} else {
-			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 		lcn += m->delta[1];
 	}
@@ -429,44 +419,33 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
-	switch (m.type) {
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
-		if (endoff >= m.clusterofs) {
-			m.headtype = m.type;
-			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
-			/*
-			 * For ztailpacking files, in order to inline data more
-			 * effectively, special EOF lclusters are now supported
-			 * which can have three parts at most.
-			 */
-			if (ztailpacking && end > inode->i_size)
-				end = inode->i_size;
-			break;
-		}
-		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-		if (!m.lcn) {
-			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
-				  vi->nid);
-			err = -EFSCORRUPTED;
-			goto unmap_out;
+	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD && endoff >= m.clusterofs) {
+		m.headtype = m.type;
+		map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+		/*
+		 * For ztailpacking files, in order to inline data more
+		 * effectively, special EOF lclusters are now supported
+		 * which can have three parts at most.
+		 */
+		if (ztailpacking && end > inode->i_size)
+			end = inode->i_size;
+	} else {
+		if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+			/* m.lcn should be >= 1 if endoff < m.clusterofs */
+			if (!m.lcn) {
+				erofs_err(sb, "invalid logical cluster 0 at nid %llu",
+					  vi->nid);
+				err = -EFSCORRUPTED;
+				goto unmap_out;
+			}
+			end = (m.lcn << lclusterbits) | m.clusterofs;
+			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+			m.delta[0] = 1;
 		}
-		end = (m.lcn << lclusterbits) | m.clusterofs;
-		map->m_flags |= EROFS_MAP_FULL_MAPPED;
-		m.delta[0] = 1;
-		fallthrough;
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
 			goto unmap_out;
-		break;
-	default:
-		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
-			  m.type, ofs, vi->nid);
-		err = -EOPNOTSUPP;
-		goto unmap_out;
 	}
 	if (m.partialref)
 		map->m_flags |= EROFS_MAP_PARTIAL_REF;
-- 
2.49.0


