Return-Path: <linux-erofs+bounces-672-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF3B09BC5
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 08:54:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk0s80wTNz30Tm;
	Fri, 18 Jul 2025 16:54:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752821676;
	cv=none; b=M9COlDWgY3QMBoqeABruMDONWlwqsOH4usiEa792usC3Czy1WkUXstd+Dc7dVS8DL6T77Hdl0V/WzYLgbFlBIyY2BKJhTZB+QtO+G7CDYRnqAI3WOPfxLSofc20c0hi1tolaagqPySnrx1QrB0YEqyoCJE1c8nXTo2h7VHgqekDeCCD7PGlgb6TGheNr9UcPCg9dkpE9z71dG5znrs53rB0nTY+GYh+DbYb131r/f11LbD7aLKh+p7gEXSdGWf24Hh4qvBDbB5EQvEKqmvtnlJG1ApswjyqhFG/IYU0XOyWv7Dx4NXAzP2QYlHgqEcVOyFNKPDOoAR/e/W/oMHAEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752821676; c=relaxed/relaxed;
	bh=eX83/jn68u8gkB/PZr0ay+Mz10VgTGRc6BcnGbgnIJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oClfnZopTJF4uL3YEvGNUeTvH2AioCC/CR2eK8BkxB0ieeiGswRhosC1nYDahZ2XhoEeQak1J+BAfIfl2n9RC/ZcnOQuPIUiMXKjwn51pJKdZIyXO8QVkBaSX96Xpb8xbY3v/iHDt9ecimLCuSTrsGl7Uy66OIbfhzfUCyIyYLlNSvrWzmXtkA5G/Ct1NNAuY5XUuPRatJHSsRMBXptLK4AeTEg0aKusYWTxop0PoRoXGlRqGko9/OcdJBWuA6dwvxxC/kyoeYPaRV+k2J0E5c8UmM+3jqZ526ywYdlyA+yKGto5a0s/4XUZ2Nw8/ZSaFWMX4pBrRdUT4IktAcjIvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wKjJa15Z; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wKjJa15Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk0s66B2Bz30RK
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 16:54:34 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752821670; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eX83/jn68u8gkB/PZr0ay+Mz10VgTGRc6BcnGbgnIJo=;
	b=wKjJa15Z8MnsP4TIMdAaTiGVdCqXyivxyFE7nPdnbNS3cJDplda1OYZQRkh7fFFiYd/YYv3/QowrtuXFaUHeyA//3CJISDl4Sx+ujra32CS1OijJaq/FK5YjqqqM0rDAPFjOg8oyU6xvZKBU7HDeAl6eG8I/C6xTba7gvU7Nt4A=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBMlSh_1752821669 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 14:54:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 07/11] erofs-utils: lib: use meta buffers for zmap operations
Date: Fri, 18 Jul 2025 14:54:15 +0800
Message-ID: <20250718065419.3338307-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
References: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 09c543798c3cde19aae575a0f76d5fc7c130ff18

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              |  2 +-
 fsck/main.c              |  2 +-
 include/erofs/internal.h |  3 +-
 lib/data.c               |  4 +-
 lib/fragments.c          |  4 +-
 lib/rebuild.c            |  2 +-
 lib/zmap.c               | 98 ++++++++++++++--------------------------
 7 files changed, 42 insertions(+), 73 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 4e68b0ad..632075a2 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -375,7 +375,7 @@ static void erofsdump_show_fileinfo(bool show_extent)
 	char timebuf[128] = {0};
 	unsigned int extent_count = 0;
 	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
+		.buf = __EROFS_BUF_INITIALIZER,
 		.m_la = 0,
 	};
 
diff --git a/fsck/main.c b/fsck/main.c
index 04370f46..96096a91 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -499,7 +499,7 @@ out:
 static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 {
 	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
+		.buf = __EROFS_BUF_INITIALIZER,
 	};
 	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
 	int ret = 0;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b61fe716..0a49394d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -390,7 +390,7 @@ enum {
 #define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
 
 struct erofs_map_blocks {
-	char mpage[EROFS_MAX_BLOCK_SIZE];
+	struct erofs_buf buf;
 
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
@@ -398,7 +398,6 @@ struct erofs_map_blocks {
 	unsigned short m_deviceid;
 	char m_algorithmformat;
 	unsigned int m_flags;
-	erofs_blk_t index;
 };
 
 /*
diff --git a/lib/data.c b/lib/data.c
index d2558254..83cc5d5d 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -197,7 +197,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
 	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
+		.buf = __EROFS_BUF_INITIALIZER,
 	};
 	int ret;
 	erofs_off_t ptr = offset;
@@ -300,7 +300,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 {
 	erofs_off_t end, length, skip;
 	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
+		.buf = __EROFS_BUF_INITIALIZER,
 	};
 	bool trimmed;
 	unsigned int bufsize = 0;
diff --git a/lib/fragments.c b/lib/fragments.c
index 3278f473..887c2530 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -569,9 +569,7 @@ int erofs_packedfile_read(struct erofs_sb_info *sbi,
 	struct erofs_inode pi = {
 		.sbi = sbi,
 	};
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
-	};
+	struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };
 	unsigned int bsz = erofs_blksiz(sbi);
 	erofs_off_t end = pos + len;
 	char *buffer = NULL;
diff --git a/lib/rebuild.c b/lib/rebuild.c
index c580f81f..33857fd6 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -194,7 +194,7 @@ static int erofs_rebuild_write_blob_index(struct erofs_sb_info *dst_sb,
 	for (i = 0; i < count; i++) {
 		struct erofs_blobchunk *chunk;
 		struct erofs_map_blocks map = {
-			.index = UINT_MAX,
+			.buf = __EROFS_BUF_INITIALIZER,
 		};
 
 		map.m_la = i << chunkbits;
diff --git a/lib/zmap.c b/lib/zmap.c
index 917ee010..db8561be 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -13,7 +13,6 @@
 struct z_erofs_maprecorder {
 	struct erofs_inode *inode;
 	struct erofs_map_blocks *map;
-	void *kaddr;
 
 	unsigned long lcn;
 	/* compression extent information gathered */
@@ -33,18 +32,12 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	const erofs_off_t pos = Z_EROFS_FULL_INDEX_START(erofs_iloc(vi) +
 			vi->inode_isize + vi->xattr_isize) +
 			lcn * sizeof(struct z_erofs_lcluster_index);
-	erofs_blk_t eblk = erofs_blknr(sbi, pos);
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
-	int err;
 
-	if (m->map->index != eblk) {
-		err = erofs_blk_read(sbi, 0, m->kaddr, eblk, 1);
-		if (err < 0)
-			return err;
-		m->map->index = eblk;
-	}
-	di = m->kaddr + erofs_blkoff(sbi, pos);
+	di = erofs_read_metabuf(&m->map->buf, sbi, pos);
+	if (IS_ERR(di))
+		return PTR_ERR(di);
 	m->lcn = lcn;
 	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 
@@ -118,12 +111,11 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	const unsigned int lclusterbits = vi->z_lclusterbits;
 	const unsigned int totalidx = BLK_ROUND_UP(sbi, vi->i_size);
 	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
-	unsigned int vcnt, base, lo, lobits, encodebits, nblk, eofs;
+	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
 	bool big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
-	erofs_blk_t eblk;
 	erofs_off_t pos;
 	u8 *in, type;
-	int i, err;
+	int i;
 
 	if (lcn >= totalidx || lclusterbits > 14)
 		return -EINVAL;
@@ -158,24 +150,18 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
-	eblk = erofs_blknr(sbi, pos);
-	if (m->map->index != eblk) {
-		err = erofs_blk_read(sbi, 0, m->kaddr, eblk, 1);
-		if (err < 0)
-			return err;
-		m->map->index = eblk;
-	}
+	in = erofs_read_metabuf(&m->map->buf, sbi, pos);
+	if (IS_ERR(in))
+		return PTR_ERR(in);
 
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
-	eofs = erofs_blkoff(sbi, pos);
-	base = round_down(eofs, vcnt << amortizedshift);
-	in = m->kaddr + base;
-
-	i = (eofs - base) >> amortizedshift;
+	bytes = pos & ((vcnt << amortizedshift) - 1);
+	in -= bytes;
+	i = bytes >> amortizedshift;
 
 	lo = decode_compactedbits(lobits, in, encodebits * i, &type);
 	m->type = type;
@@ -420,7 +406,6 @@ static int z_erofs_map_blocks_fo(struct erofs_inode *vi,
 	struct z_erofs_maprecorder m = {
 		.inode = vi,
 		.map = map,
-		.kaddr = map->mpage,
 	};
 	int err = 0;
 	unsigned int endoff, afmt;
@@ -558,23 +543,16 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 				   vi->inode_isize + vi->xattr_isize), recsz);
 	erofs_off_t lend = vi->i_size;
 	erofs_off_t l, r, mid, pa, la, lstart;
-	erofs_blk_t eblk;
 	struct z_erofs_extent *ext;
 	unsigned int fmt;
 	bool last;
-	int err;
 
 	map->m_flags = 0;
 	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
 		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
-			eblk = erofs_blknr(sbi, pos);
-			if (map->index != eblk) {
-				err = erofs_blk_read(sbi, 0, map->mpage, eblk, 1);
-				if (err < 0)
-					return err;
-				map->index = eblk;
-			}
-			ext = (void *)(map->mpage + erofs_blkoff(sbi, pos));
+			ext = erofs_read_metabuf(&map->buf, sbi, pos);
+			if (IS_ERR(ext))
+				return PTR_ERR(ext);
 			pa = le64_to_cpu(*(__le64 *)ext);
 			pos += sizeof(__le64);
 			lstart = 0;
@@ -584,14 +562,9 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 		}
 
 		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
-			eblk = erofs_blknr(sbi, pos);
-			if (map->index != eblk) {
-				err = erofs_blk_read(sbi, 0, map->mpage, eblk, 1);
-				if (err < 0)
-					return err;
-				map->index = eblk;
-			}
-			ext = (void *)(map->mpage + erofs_blkoff(sbi, pos));
+			ext = erofs_read_metabuf(&map->buf, sbi, pos);
+			if (IS_ERR(ext))
+				return PTR_ERR(ext);
 			map->m_plen = le32_to_cpu(ext->plen);
 			if (pa != EROFS_NULL_ADDR) {
 				map->m_pa = pa;
@@ -608,14 +581,11 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 		lstart = lend;
 		for (l = 0, r = vi->z_extents; l < r; ) {
 			mid = l + (r - l) / 2;
-			eblk = erofs_blknr(sbi, pos + mid * recsz);
-			if (map->index != eblk) {
-				err = erofs_blk_read(sbi, 0, map->mpage, eblk, 1);
-				if (err < 0)
-					return err;
-				map->index = eblk;
-			}
-			ext = (void *)(map->mpage + erofs_blkoff(sbi, pos + mid * recsz));
+			ext = erofs_read_metabuf(&map->buf, sbi,
+						 pos + mid * recsz);
+			if (IS_ERR(ext))
+				return PTR_ERR(ext);
+
 			la = le32_to_cpu(ext->lstart_lo);
 			pa = le32_to_cpu(ext->pstart_lo) |
 				(u64)le32_to_cpu(ext->pstart_hi) << 32;
@@ -669,24 +639,22 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 	return 0;
 }
 
-
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
-	erofs_off_t pos;
-	struct z_erofs_map_header *h;
-	char buf[sizeof(struct z_erofs_map_header)];
 	struct erofs_sb_info *sbi = vi->sbi;
 	int err, headnr;
+	erofs_off_t pos;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	struct z_erofs_map_header *h;
 
 	if (erofs_atomic_read(&vi->flags) & EROFS_I_Z_INITED)
 		return 0;
 
 	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
-	err = erofs_dev_read(sbi, 0, buf, pos, sizeof(buf));
-	if (err < 0)
-		return -EIO;
+	h = erofs_read_metabuf(&buf, sbi, pos);
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
-	h = (struct z_erofs_map_header *)buf;
 	/*
 	 * if the highest bit of the 8-byte map header is set, the whole file
 	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
@@ -718,7 +686,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
 		erofs_err("unknown HEAD%u format %u for nid %llu",
 			  headnr + 1, vi->z_algorithmtype[0], vi->nid | 0ULL);
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto out_put_metabuf;
 	}
 
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
@@ -726,12 +695,13 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
 		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
 			  vi->nid * 1ULL);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto out_put_metabuf;
 	}
 
 	if (vi->z_idata_size ||
 	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
+		struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };
 
 		err = z_erofs_map_blocks_fo(vi, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
@@ -740,6 +710,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	}
 done:
 	erofs_atomic_set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
+out_put_metabuf:
+	erofs_put_metabuf(&buf);
 	return 0;
 }
 
-- 
2.43.5


