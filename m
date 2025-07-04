Return-Path: <linux-erofs+bounces-517-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686AEAF89DE
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 09:46:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYQfq69M0z30MY;
	Fri,  4 Jul 2025 17:45:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751615155;
	cv=none; b=e+yjWW6j0AoMLXxinIkMkmw+za5czQt4n/TXrGNAVyo2X/bt5SbhhalN/SIAMhe/6s+41JDzyD1PpATeShNad6SsdJB0Nt7hK0l9SN+0dKnsUYnWgE0OulEX7AoetJSG4SmxqlcnnyTWbVB3Ci1e5YQUtW0AO5XfjuApYVW2uVxow7DG4qTLYfgr1L51JdZzpSyFZz9QVrhTqygOqoj70129boRAsx4XEii2YaK4Exsa5n1AMAyeYiwzOoujgs4cFLFBHfXzPzz7qWOW96Fqxaiag7ihhguFYF7tVd2nmuzcltS9bUoLCHvFdP7vnhFAseF6LcAW5+1Vo2mRFnFZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751615155; c=relaxed/relaxed;
	bh=ZoAgko7A4z+Hal7yz7+SfRe29zRcWZNAk/y8EEJztsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTJd50urQ4huUf60tvMrX8bdxEObjG5zvnZt9liFWludZvfRxx0sOTwdE7lvy9ko32MG0nVWXsm634hZzU1bXH8BjpA7V4kpUmT6kkpmwFPaXkPrqnfvP732oUQf/iKkB0WVmqOxETKhYKurzEBSDlLPmVIsCZOv+G29NaqpZHGC215JWg/mhewS4uCOJ8py/2C9toFV0Eg5kNFVYc92fZjhzV9QCCVN0r9Fc9RAjWICHsUEZSfTJhiebxvgCVmMuFvlWPM8Cc0ihkbb5ZwNlQ6OmWqjSEvv2gLrMNN3mg1TH5YIwLKA36gsGC+15iliQGqv1TWddDVaOK/wj/1ICA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kp9ZfVk9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kp9ZfVk9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYQfn06hcz30Pn
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 17:45:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751615149; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZoAgko7A4z+Hal7yz7+SfRe29zRcWZNAk/y8EEJztsA=;
	b=Kp9ZfVk9LKZNy7oVWFvGYZfBuI1Uv0QhYPHRbxEO3Z5Tck0hIu8ZyN24xCHCImBvfb7jtBcxbYu0TCFrof2qaV1lSWxqw99QplOaIQ64GHsA8kD8AsiFnadN63SZusiLt7XE05G9DlBSfZNn3xlQNrxQWIJCbpAylscamHjESmk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhDC7DR_1751615147 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 15:45:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 for-merge 8/9] erofs-utils: lib: implement encoded extent metadata
Date: Fri,  4 Jul 2025 15:45:34 +0800
Message-ID: <20250704074535.2308212-9-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
References: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Source kernel commit: efb2aef569b35b415c232c4e9fdecd0e540e1f60
Source kernel commit: 1d191b4ca51d73699cb127386b95ac152af2b930
Source kernel commit: 7869738b6908eec7755818aaf6f3aa068b2f0e1b
Source kernel commit: 417b8af2e30d7f131682a893ad79c506fd39c624

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c              |   2 +-
 include/erofs/internal.h |   3 +-
 lib/compress.c           |  14 ++--
 lib/zmap.c               | 176 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 164 insertions(+), 31 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 8f619a55..91c193f8 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -549,7 +549,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		}
 
 		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
-			if (compressed) {
+			if (compressed && !(map.m_flags & EROFS_MAP_FRAGMENT)) {
 				erofs_err("invalid pcluster size %" PRIu64 " @ offset %" PRIu64 " of nid %" PRIu64,
 					  map.m_plen, map.m_la,
 					  inode->nid | 0ULL);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a35b9e79..14a8e30d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -266,11 +266,12 @@ struct erofs_inode {
 		struct {
 			uint16_t z_advise;
 			uint8_t  z_algorithmtype[2];
-			uint8_t  z_logical_clusterbits;
+			uint8_t  z_lclusterbits;
 			uint8_t  z_physical_clusterblks;
 			union {
 				uint64_t z_tailextent_headlcn;
 				erofs_off_t fragment_size;
+				u64		z_extents;
 			};
 			union {
 				erofs_off_t	fragmentoff;
diff --git a/lib/compress.c b/lib/compress.c
index 6e7b5241..5d4d47f9 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -289,7 +289,7 @@ static void z_erofs_commit_extent(struct z_erofs_compress_sctx *ctx,
 static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 {
 	struct erofs_inode *inode = ctx->ictx->inode;
-	const unsigned int lclustermask = (1 << inode->z_logical_clusterbits) - 1;
+	const unsigned int lclustermask = (1 << inode->z_lclusterbits) - 1;
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_extent_item *ei = ctx->pivot;
 
@@ -422,7 +422,7 @@ static int write_uncompressed_extents(struct z_erofs_compress_sctx *ctx,
 				      char *dst)
 {
 	struct erofs_inode *inode = ctx->ictx->inode;
-	unsigned int lclustersize = 1 << inode->z_logical_clusterbits;
+	unsigned int lclustersize = 1 << inode->z_lclusterbits;
 	struct z_erofs_extent_item *ei;
 	int count;
 
@@ -889,7 +889,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	const unsigned int totalidx = (legacymetasize -
 			Z_EROFS_LEGACY_MAP_HEADER_SIZE) /
 				sizeof(struct z_erofs_lcluster_index);
-	const unsigned int logical_clusterbits = inode->z_logical_clusterbits;
+	const unsigned int logical_clusterbits = inode->z_lclusterbits;
 	u8 *out, *in;
 	struct z_erofs_compressindex_vec cv[16];
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -998,7 +998,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
-		.h_clusterbits = inode->z_logical_clusterbits - sbi->blkszbits,
+		.h_clusterbits = inode->z_lclusterbits - sbi->blkszbits,
 	};
 
 	if (inode->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
@@ -1025,8 +1025,8 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	if (inode->fragment_size && inode->fragmentoff >> 32) {
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 	} else if (!cfg.c_legacy_compress && !ctx->dedupe &&
-	    inode->z_logical_clusterbits <= 14) {
-		if (inode->z_logical_clusterbits <= 12)
+	    inode->z_lclusterbits <= 14) {
+		if (inode->z_lclusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
 		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
 	} else {
@@ -1631,7 +1631,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
-	inode->z_logical_clusterbits = sbi->blkszbits;
+	inode->z_lclusterbits = sbi->blkszbits;
 	if (cfg.c_fragments && !cfg.c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
diff --git a/lib/zmap.c b/lib/zmap.c
index 83833859..3adc762e 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -51,7 +51,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	advise = le16_to_cpu(di->di_advise);
 	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
 	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-		m->clusterofs = 1 << vi->z_logical_clusterbits;
+		m->clusterofs = 1 << vi->z_lclusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
 		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!(vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
@@ -66,7 +66,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
+		if (m->clusterofs >= 1 << vi->z_lclusterbits) {
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
@@ -115,7 +115,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	struct erofs_sb_info *sbi = vi->sbi;
 	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
 		round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lclusterbits = vi->z_lclusterbits;
 	const unsigned int totalidx = BLK_ROUND_UP(sbi, vi->i_size);
 	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
 	unsigned int vcnt, base, lo, lobits, encodebits, nblk, eofs;
@@ -272,7 +272,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 				   unsigned int lookback_distance)
 {
 	struct erofs_inode *const vi = m->inode;
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lclusterbits = vi->z_lclusterbits;
 
 	while (m->lcn >= lookback_distance) {
 		unsigned long lcn = m->lcn - lookback_distance;
@@ -320,7 +320,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if ((m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD1 && !bigpcl1) ||
 	    ((m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
 	      m->headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) && !bigpcl2) ||
-	    (lcn << vi->z_logical_clusterbits) >= vi->i_size)
+	    (lcn << vi->z_lclusterbits) >= vi->i_size)
 		m->compressedblks = 1;
 
 	if (m->compressedblks)
@@ -371,7 +371,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_map_blocks *map = m->map;
-	unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned int lclusterbits = vi->z_lclusterbits;
 	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
 	int err;
 
@@ -409,25 +409,33 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 	return 0;
 }
 
-static int z_erofs_do_map_blocks(struct erofs_inode *vi,
+static int z_erofs_map_blocks_fo(struct erofs_inode *vi,
 				 struct erofs_map_blocks *map,
 				 int flags)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	bool ztailpacking = vi->z_idata_size;
+	unsigned int lclusterbits = vi->z_lclusterbits;
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
 		.kaddr = map->mpage,
 	};
 	int err = 0;
-	unsigned int lclusterbits, endoff, afmt;
+	unsigned int endoff, afmt;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
-	lclusterbits = vi->z_logical_clusterbits;
 	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? vi->i_size - 1 : map->m_la;
+	if (fragment && !(flags & EROFS_GET_BLOCKS_FINDTAIL) &&
+	    !vi->z_tailextent_headlcn) {
+		map->m_la = 0;
+		map->m_llen = vi->i_size;
+		map->m_flags = EROFS_MAP_MAPPED |
+			EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+		return 0;
+	}
 	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
@@ -541,6 +549,128 @@ out:
 	return err;
 }
 
+static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
+				  struct erofs_map_blocks *map, int flags)
+{
+	struct erofs_sb_info *sbi = vi->sbi;
+	bool interlaced = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
+	unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
+	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(vi) +
+				   vi->inode_isize + vi->xattr_isize), recsz);
+	erofs_off_t lend = vi->i_size;
+	erofs_off_t l, r, mid, pa, la, lstart;
+	erofs_blk_t eblk;
+	struct z_erofs_extent *ext;
+	unsigned int fmt;
+	bool last;
+	int err;
+
+	map->m_flags = 0;
+	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
+		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
+			eblk = erofs_blknr(sbi, pos);
+			if (map->index != eblk) {
+				err = erofs_blk_read(sbi, 0, map->mpage, eblk, 1);
+				if (err < 0)
+					return err;
+				map->index = eblk;
+			}
+			ext = (void *)(map->mpage + erofs_blkoff(sbi, pos));
+			pa = le64_to_cpu(*(__le64 *)ext);
+			pos += sizeof(__le64);
+			lstart = 0;
+		} else {
+			lstart = map->m_la >> vi->z_lclusterbits;
+			pa = EROFS_NULL_ADDR;
+		}
+
+		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
+			eblk = erofs_blknr(sbi, pos);
+			if (map->index != eblk) {
+				err = erofs_blk_read(sbi, 0, map->mpage, eblk, 1);
+				if (err < 0)
+					return err;
+				map->index = eblk;
+			}
+			ext = (void *)(map->mpage + erofs_blkoff(sbi, pos));
+			map->m_plen = le32_to_cpu(ext->plen);
+			if (pa != EROFS_NULL_ADDR) {
+				map->m_pa = pa;
+				pa += map->m_plen & Z_EROFS_EXTENT_PLEN_MASK;
+			} else {
+				map->m_pa = le32_to_cpu(ext->pstart_lo);
+			}
+			pos += recsz;
+		}
+		last = (lstart >= round_up(lend, 1 << vi->z_lclusterbits));
+		lend = min(lstart, lend);
+		lstart -= 1 << vi->z_lclusterbits;
+	} else {
+		lstart = lend;
+		for (l = 0, r = vi->z_extents; l < r; ) {
+			mid = l + (r - l) / 2;
+			eblk = erofs_blknr(sbi, pos + mid * recsz);
+			if (map->index != eblk) {
+				err = erofs_blk_read(sbi, 0, map->mpage, eblk, 1);
+				if (err < 0)
+					return err;
+				map->index = eblk;
+			}
+			ext = (void *)(map->mpage + erofs_blkoff(sbi, pos + mid * recsz));
+			la = le32_to_cpu(ext->lstart_lo);
+			pa = le32_to_cpu(ext->pstart_lo) |
+				(u64)le32_to_cpu(ext->pstart_hi) << 32;
+			if (recsz > offsetof(struct z_erofs_extent, lstart_hi))
+				la |= (u64)le32_to_cpu(ext->lstart_hi) << 32;
+
+			if (la > map->m_la) {
+				r = mid;
+				if (la > lend) {
+					DBG_BUGON(1);
+					return -EFSCORRUPTED;
+				}
+				lend = la;
+			} else {
+				l = mid + 1;
+				if (map->m_la == la)
+					r = min(l + 1, r);
+				lstart = la;
+				map->m_plen = le32_to_cpu(ext->plen);
+				map->m_pa = pa;
+			}
+		}
+		last = (l >= vi->z_extents);
+	}
+
+	if (lstart < lend) {
+		map->m_la = lstart;
+		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
+			map->m_flags |= EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+			vi->z_fragmentoff = map->m_plen;
+			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
+				vi->z_fragmentoff |= map->m_pa << 32;
+		} else if (map->m_plen) {
+			map->m_flags |= EROFS_MAP_MAPPED |
+				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
+			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
+			if (fmt)
+				map->m_algorithmformat = fmt - 1;
+			else if (interlaced && !erofs_blkoff(sbi, map->m_pa))
+				map->m_algorithmformat =
+					Z_EROFS_COMPRESSION_INTERLACED;
+			else
+				map->m_algorithmformat =
+					Z_EROFS_COMPRESSION_SHIFTED;
+			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
+				map->m_flags |= EROFS_MAP_PARTIAL_REF;
+			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
+		}
+	}
+	map->m_llen = lend - map->m_la;
+	return 0;
+}
+
+
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
 	erofs_off_t pos;
@@ -566,10 +696,17 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
 		vi->z_tailextent_headlcn = 0;
-		goto out;
+		goto done;
 	}
 
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_lclusterbits = sbi->blkszbits + (h->h_clusterbits & 15);
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
+	    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
+		vi->z_extents = le32_to_cpu(h->h_extents_lo) |
+			((u64)le16_to_cpu(h->h_extents_hi) << 32);
+		goto done;
+	}
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
@@ -585,7 +722,6 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return -EOPNOTSUPP;
 	}
 
-	vi->z_logical_clusterbits = sbi->blkszbits + (h->h_clusterbits & 7);
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
@@ -598,12 +734,12 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 		struct erofs_map_blocks map = { .index = UINT_MAX };
 
-		err = z_erofs_do_map_blocks(vi, &map,
+		err = z_erofs_map_blocks_fo(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		if (err < 0)
 			return err;
 	}
-out:
+done:
 	erofs_atomic_set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	return 0;
 }
@@ -620,15 +756,11 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 	} else {
 		err = z_erofs_fill_inode_lazy(vi);
 		if (!err) {
-			if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
-			    !vi->z_tailextent_headlcn) {
-				map->m_la = 0;
-				map->m_llen = vi->i_size;
-				map->m_flags = EROFS_MAP_MAPPED |
-					EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
-			} else {
-				err = z_erofs_do_map_blocks(vi, map, flags);
-			}
+			if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
+			    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS))
+				err = z_erofs_map_blocks_ext(vi, map, flags);
+			else
+				err = z_erofs_map_blocks_fo(vi, map, flags);
 		}
 		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
 		    __erofs_unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
-- 
2.43.5


