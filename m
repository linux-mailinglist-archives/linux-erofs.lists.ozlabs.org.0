Return-Path: <linux-erofs+bounces-535-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238BAFAEE2
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Jul 2025 10:48:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbHvM0QxPz30Vr;
	Mon,  7 Jul 2025 18:48:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751878094;
	cv=none; b=go1v9UFpFR+wOlLmfC3oGL66XVkj3qmVVVVwFKdAk4VnnIDRVSyt6fbYCK38zt5JMHGwjF/Q6Qgnv7Z1YAOcf/MrLHxQq96wevhfj/BKIznuqRySqeblAflC3fyua7wH/7XWt3IVyVqmDZ7d4FO6eDVemRYI5Kpi33R5EuUIsSBfKejRjPdTPHxeT48fKTpWGbrdTlrae4VUuEfHX8GIuj7enX7waHBHu13Pqt6/G9ADAyxLCf/3I6nihuTsuA0x3gwso6k0byHUT+ibJ4bEmd6AZ4+/GMoak1Q2yKO/KWclXb+9kHyItqf+5i51hCc+p2utBSs9xBjoS4LDTDeuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751878094; c=relaxed/relaxed;
	bh=UHhCWiQNK5j65bHxQI2tHAQk9aat3bJIXmgVEJbG+Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hW/FntULwklw+hAooMIPickS7esmWju6hkNQ/YWPYHHQMChvpEQfvVh/tRcuJDEpAWIZJXv7TIaBY+PwO4CMkcX4pWsJZMlB6EQzeeudRychpqPwzWYbt3TxID47M6B3y9Y7s1ZqmbgvvtD7MV+mDEMwgJ1ooYViZHHYaZVNboH99dgwq/4IxeYp++2G9ZArZiHRSboWfIG+tLOq0OYWvb1HBxi0JiQXotP0thpgK8od1dSlas8miQNfhxnHP5EJp21pafmsV+XXp/aakOWM9oV/ZnRnYAupR5ssfNpglJbxOLnltw+d5G4xekuI5ynbAVHv3QbvMsxBlNs8k69dMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Md5D2fuY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Md5D2fuY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbHvL1lMJz30V7
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Jul 2025 18:48:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D854944B90;
	Mon,  7 Jul 2025 08:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D371C4CEE3;
	Mon,  7 Jul 2025 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751878091;
	bh=oVV3xpo31SuKpKGf6jP/JxKf852sahckvpzf6m9nad4=;
	h=From:To:Cc:Subject:Date:From;
	b=Md5D2fuYyaOC/J7VhAHxffG3HFIHZzoc4oa63FZXEH9pndvWVnIaM2aCvbrl0C5UT
	 r2TJ4zhTDQ/XVUDS90XObwjcjHgvJuNmlHYzp6zTN4Djjfz8mgrpDSNcI7QEOW2Sg4
	 A8cpCv2whmrZ+O8Q6w6twWJi5vR4gF+FhcavFhREJapa3i+V9uU4/HJjhYNsCn1Q2h
	 4qUjXx6atFA7JmLO0a+ZeGKMHD7cv79QvgWclwrCOzSxA30GSU+qIQbUNXZBpEXf6w
	 jVGbwlJXEA5XOACSsGy6Cdsxsb3959ib2bkdzgpmOIq4R8Jabsms24EdmilkQSy/VN
	 cxzlzfeC/yvlA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()
Date: Mon,  7 Jul 2025 16:47:23 +0800
Message-ID: <20250707084723.2725437-1-chao@kernel.org>
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
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

All below functions will do sanity check on m->type, let's move sanity
check to z_erofs_load_compact_lcluster() for cleanup.
- z_erofs_map_blocks_fo
- z_erofs_get_extent_compressedlen
- z_erofs_get_extent_decompressedlen
- z_erofs_extent_lookback

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bebc6e3a4d7..e530b152e14e 100644
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
@@ -333,17 +335,13 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		}
 		if (m->compressedblks)
 			goto out;
-	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
-		/*
-		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
-		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
-		 */
-		m->compressedblks = 1;
-		goto out;
 	}
-	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-	DBG_BUGON(1);
-	return -EFSCORRUPTED;
+
+	/*
+	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
+	 * than CBLKCNT, it's a 1 block-sized pcluster.
+	 */
+	m->compressedblks = 1;
 out:
 	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
@@ -379,11 +377,6 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
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
@@ -429,10 +422,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
-	switch (m.type) {
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
+	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		if (endoff >= m.clusterofs) {
 			m.headtype = m.type;
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -443,7 +433,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			 */
 			if (ztailpacking && end > inode->i_size)
 				end = inode->i_size;
-			break;
+			goto map_block;
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
@@ -455,19 +445,13 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 		end = (m.lcn << lclusterbits) | m.clusterofs;
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
-		fallthrough;
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
-		/* get the corresponding first chunk */
-		err = z_erofs_extent_lookback(&m, m.delta[0]);
-		if (err)
-			goto unmap_out;
-		break;
-	default:
-		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
-			  m.type, ofs, vi->nid);
-		err = -EOPNOTSUPP;
-		goto unmap_out;
 	}
+
+	/* get the corresponding first chunk */
+	err = z_erofs_extent_lookback(&m, m.delta[0]);
+	if (err)
+		goto unmap_out;
+map_block:
 	if (m.partialref)
 		map->m_flags |= EROFS_MAP_PARTIAL_REF;
 	map->m_llen = end - map->m_la;
-- 
2.49.0


