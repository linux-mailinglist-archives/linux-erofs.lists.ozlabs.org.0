Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F331CA2A8CF
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR605Q0z3c5q
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846252;
	cv=none; b=Gh1YOT5H1YpS2zM/qyT6ef8tIA0z26GngLkKw7bRCzE+CEoZu1vY5IRFJG0azIp2KU8aEt3FWfhQNRwszo0ex1RUu9v479UU4WWhEIZ5cTt6u2A+R+IT5RM+Afyyd8CHGpDCItM6JJtmEyKbj+ZJxya2vRfTIrF038RYpjh3LfAcPAA3QWhkkxMJkWObicxuyusik5mi+dhNNO5EoilzGMqc0yB2fkuwYK9CA7YqO62NOtz+iZcqrG3ZKWhB2unald9Kumb+bHww94JQuS1t/vAvvgzXJFGb2iirk2iHdQcwP3ykajzcimMfhh6EgnPNYGDC2+UsHHUT3sBbqHxQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846252; c=relaxed/relaxed;
	bh=4I/bPyeHA+o573HJ5TThX+W0CZ/tLnF2IFYBxijKryI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYEOuqWla07m3d8eYPpO7RbV3yQ64zieQiVRHYS8IxzZwQ2CTAbHzRM9UeTj9na1tx6mOwFeyqTnGUyt45JPZAoIpfOU8QL7m/gR9SZj0VxMwK9A7Ol3yZ4FMA7u/zCZQaejT0NHemShGWBK8HtUczAZa/fKVNmHmAbdkw7LwW76wxQNzBXXPHLt/0c2xxAWDgFKnw5o/IkBoX+HdB+Ho019NMSE8Vh7IS/fXw1a+p7Xe8qP78pDdHQhNTQanTYauK2b4Cq+qj6u6tWORQhm0k2T/jQoAFmUIqr17h0zV6pvKM9EXmaTdyJcAxfMRw5NSBojY1V4b5fcVkMr33ziGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eg5cFynI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eg5cFynI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcQz62nnz30Gq
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846248; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4I/bPyeHA+o573HJ5TThX+W0CZ/tLnF2IFYBxijKryI=;
	b=eg5cFynIl/mmz4kBsS2XcpNf5OBA/dhmkMLvITALkwz/MHMJhjUoIs7kqGWpT/Siy9nY/5ujfEf8D1IYEgG164140/N0qTc/VrB0esEzPIsc5gSEEq4ijp9A1SraTQ+MZxZiGi2GDOYe0V5auDX9H1JX4Ag5jeUyiwUrMMpScv8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl5h_1738846246 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/9] erofs-utils: lib: sync up zmap.c
Date: Thu,  6 Feb 2025 20:50:30 +0800
Message-ID: <20250206125034.1462966-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
References: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 31da107fdb0a ("erofs: fold in z_erofs_reload_indexes()")
commit 53a7f9961cdd ("erofs: clean up unnecessary code and comments")
commit 9ff471800b74 ("erofs: get rid of a useless DBG_BUGON")
commit cc4efd3dd2ac ("erofs: stop parsing non-compact HEAD index if clusterofs is invalid")
commit 118a8cf504d7 ("erofs: fix inconsistent per-file compression format")
commit 9b32b063be10 ("erofs: ensure m_llen is reset to 0 if metadata is invalid")

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 91 ++++++++++++++++++++++++++----------------------------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index ee0af1f..c79424b 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -25,25 +25,6 @@ struct z_erofs_maprecorder {
 	bool partialref;
 };
 
-static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
-				  erofs_blk_t eblk)
-{
-	int ret;
-	struct erofs_map_blocks *const map = m->map;
-	char *mpage = map->mpage;
-
-	if (map->index == eblk)
-		return 0;
-
-	ret = erofs_blk_read(m->inode->sbi, 0, mpage, eblk, 1);
-	if (ret < 0)
-		return -EIO;
-
-	map->index = eblk;
-
-	return 0;
-}
-
 static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 				      unsigned long lcn)
 {
@@ -53,17 +34,20 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(ibase +
 			vi->inode_isize + vi->xattr_isize) +
 		lcn * sizeof(struct z_erofs_lcluster_index);
+	erofs_blk_t eblk = erofs_blknr(sbi, pos);
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 	int err;
 
-	err = z_erofs_reload_indexes(m, erofs_blknr(sbi, pos));
-	if (err)
-		return err;
-
-	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
-	m->lcn = lcn;
+	if (m->map->index != eblk) {
+		err = erofs_blk_read(sbi, 0, m->kaddr, eblk, 1);
+		if (err < 0)
+			return err;
+		m->map->index = eblk;
+	}
 	di = m->kaddr + erofs_blkoff(sbi, pos);
+	m->lcn = lcn;
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 
 	advise = le16_to_cpu(di->di_advise);
 	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
@@ -72,18 +56,21 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
-					      Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
+					Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedblks = m->delta[0] &
-				~Z_EROFS_LI_D0_CBLKCNT;
+			m->compressedblks = m->delta[0] & ~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 	}
 	return 0;
@@ -129,9 +116,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	struct erofs_inode *const vi = m->inode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	unsigned int vcnt, base, lo, lobits, encodebits, nblk, eofs;
-	int i;
-	u8 *in, type;
 	bool big_pcluster;
+	u8 *in, type;
+	int i;
 
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
@@ -242,6 +229,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
 	erofs_off_t pos;
+	erofs_blk_t eblk;
 	int err;
 
 	if (lcn >= totalidx)
@@ -276,9 +264,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	amortizedshift = 2;
 out:
 	pos += lcn * (1 << amortizedshift);
-	err = z_erofs_reload_indexes(m, erofs_blknr(sbi, pos));
-	if (err)
-		return err;
+	eblk = erofs_blknr(sbi, pos);
+	if (m->map->index != eblk) {
+		err = erofs_blk_read(sbi, 0, m->kaddr, eblk, 1);
+		if (err < 0)
+			return err;
+		m->map->index = eblk;
+	}
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
@@ -472,7 +464,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		.kaddr = map->mpage,
 	};
 	int err = 0;
-	unsigned int lclusterbits, endoff;
+	unsigned int lclusterbits, endoff, afmt;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
@@ -490,6 +482,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
+
 	switch (m.type) {
 	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
 	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
@@ -518,7 +511,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		m.delta[0] = 1;
 		/* fallthrough */
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
-		/* get the correspoinding first chunk */
+		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
 			goto out;
@@ -532,6 +525,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 	if (m.partialref)
 		map->m_flags |= EROFS_MAP_PARTIAL_REF;
 	map->m_llen = end - map->m_la;
+
 	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
 		/* for non-compact indexes, fragmentoff is 64 bits */
@@ -557,17 +551,20 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 			err = -EFSCORRUPTED;
 			goto out;
 		}
-		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_INTERLACED;
-		else
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_SHIFTED;
-	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
-		map->m_algorithmformat = vi->z_algorithmtype[1];
+		afmt = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER ?
+			Z_EROFS_COMPRESSION_INTERLACED :
+			Z_EROFS_COMPRESSION_SHIFTED;
 	} else {
-		map->m_algorithmformat = vi->z_algorithmtype[0];
+		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
+			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
+		if (!(sbi->available_compr_algs & (1 << afmt))) {
+			erofs_err("inconsistent algorithmtype %u for nid %llu",
+				  afmt, vi->nid);
+			err = -EFSCORRUPTED;
+			goto out;
+		}
 	}
+	map->m_algorithmformat = afmt;
 
 	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
 		err = z_erofs_get_extent_decompressedlen(&m);
@@ -662,8 +659,7 @@ out:
 }
 
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-			    struct erofs_map_blocks *map,
-			    int flags)
+			    struct erofs_map_blocks *map, int flags)
 {
 	int err = 0;
 
@@ -690,6 +686,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 
 	err = z_erofs_do_map_blocks(vi, map, flags);
 out:
-	DBG_BUGON(err < 0 && err != -ENOMEM);
+	if (err)
+		map->m_llen = 0;
 	return err;
 }
-- 
2.43.5

