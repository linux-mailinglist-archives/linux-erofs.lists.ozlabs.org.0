Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD41A2A8D2
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR666mWz3cgM
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846255;
	cv=none; b=hnLZiznnFIl95djQ1/sSxRIuMp2H+kVv4jvEAuzu8hJIYC+ebf62LeoyHtK5PVTV9YG2eMmw0GHnoU+Pl2hLNUMdjhjAB/Scfw08l5gJe0PYcr6ON3s0s8w+Y8Ep6wMnDFMUO7xfgxUIWG/kIES1hfIpVc4e6bnERtlWQMEffpiLBWZrTqBh5GFDGSbcGxeoGRYKYGzB0KJWTRnLoqDpzzo0+5IH+kukNm7kGxBQASk/JOLScsZAG+45ChxMeS16s3AjPs7LqLJR0Usk8DIxr5Obopeqeb6gUnP+LUsbVIaXbJr+DGFsxc8IJNJ3DhV/hWG/AdVAP87SuA6c8G9gow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846255; c=relaxed/relaxed;
	bh=oxsobVu2xapyeBfasPXM9L1QehP7f0DSIRIGuWGwkbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuiChkcIa+RFz9hTWoJ4vLPsD/ONQye2evPc7qvxXG3rym8dRpmPX/xgwwFq4AvxoXyzKTcfvn8xLTjTVMVvVF0GmXREAa8wSKvZ/kCr3arttae6x/k0Q9tBpsqOR1wTG+GLO1xU6aNMr9t4oEE0+vaXda9JatVEsJhjBKZUfVvthEloxBk/0bqERC6ES33JtEFrmFD9+BIzPLhlo7yTJAcvqvgpRvI0T5+ak5uk0NULkiGfU6qyKnPgubaBCYE+RGnhOhDIKnG4EKtUGRitvUkA3rl2XYLOJwzm7sx8h6xszwu7x5VoJfKVQLRhIPM7Avq3idn+npeI6EkRuHFqZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DTPlqJTi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DTPlqJTi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcR20V8yz2xfW
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846249; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oxsobVu2xapyeBfasPXM9L1QehP7f0DSIRIGuWGwkbo=;
	b=DTPlqJTiR3ZHehF161SaYe7v3+A7pVvBYaX3hENfsYp+r3/SETSk2RBqprl3+TTWtdTrbPhps6Uuzvd47J9p1cTL7nF0txrmOrfvUZg2NZsxxsjR146WQ/HItZqL8KBZFoZPuyzes28qrVYF39VAJSpB58V4yYo8k1KvicPIqPo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl6q_1738846248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/9] erofs-utils: lib: simplify z_erofs_load_compact_lcluster()
Date: Thu,  6 Feb 2025 20:50:32 +0800
Message-ID: <20250206125034.1462966-7-hsiangkao@linux.alibaba.com>
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

Source kernel commit: 2a810ea79cd7a6d5f134ea69ca2ba726e600cbc4
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 112 ++++++++++++++++++++++-------------------------------
 1 file changed, 47 insertions(+), 65 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index c48eba4..b2aa483 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -109,17 +109,49 @@ static int get_compacted_la_distance(unsigned int lobits,
 	return d1;
 }
 
-static int unpack_compacted_index(struct z_erofs_maprecorder *m,
-				  unsigned int amortizedshift,
-				  erofs_off_t pos, bool lookahead)
+static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
+					 unsigned long lcn, bool lookahead)
 {
 	struct erofs_inode *const vi = m->inode;
+	struct erofs_sb_info *sbi = vi->sbi;
+	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
+		round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int totalidx = BLK_ROUND_UP(sbi, vi->i_size);
+	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
 	unsigned int vcnt, base, lo, lobits, encodebits, nblk, eofs;
-	bool big_pcluster;
+	bool big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	erofs_blk_t eblk;
+	erofs_off_t pos;
 	u8 *in, type;
-	int i;
+	int i, err;
+
+	if (lcn >= totalidx || lclusterbits > 14)
+		return -EINVAL;
 
+	m->lcn = lcn;
+	/* used to align to 32-byte (compacted_2b) alignment */
+	compacted_4b_initial = ((32 - ebase % 32) / 4) & 7;
+	compacted_2b = 0;
+	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
+	    compacted_4b_initial < totalidx)
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+
+	pos = ebase;
+	amortizedshift = 2;	/* compact_4b */
+	if (lcn >= compacted_4b_initial) {
+		pos += compacted_4b_initial * 4;
+		lcn -= compacted_4b_initial;
+		if (lcn < compacted_2b) {
+			amortizedshift = 1;
+		} else {
+			pos += compacted_2b * 2;
+			lcn -= compacted_2b;
+		}
+	}
+	pos += lcn * (1 << amortizedshift);
+
+	/* figure out the lcluster count in this pack */
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits <= 12)
@@ -127,13 +159,20 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	eblk = erofs_blknr(sbi, pos);
+	if (m->map->index != eblk) {
+		err = erofs_blk_read(sbi, 0, m->kaddr, eblk, 1);
+		if (err < 0)
+			return err;
+		m->map->index = eblk;
+	}
+
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
-	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
-	eofs = erofs_blkoff(vi->sbi, pos);
+	eofs = erofs_blkoff(sbi, pos);
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
 
@@ -201,9 +240,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 					nblk += lo & ~Z_EROFS_LI_D0_CBLKCNT;
 					continue;
 				}
+				/* bigpcluster shouldn't have plain d0 == 1 */
 				if (lo <= 1) {
 					DBG_BUGON(1);
-					/* --i; ++nblk;	continue; */
 					return -EFSCORRUPTED;
 				}
 				i -= lo - 2;
@@ -217,63 +256,6 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
-					 unsigned long lcn, bool lookahead)
-{
-	struct erofs_inode *const vi = m->inode;
-	struct erofs_sb_info *sbi = vi->sbi;
-	const erofs_off_t ebase = round_up(erofs_iloc(vi) + vi->inode_isize +
-					   vi->xattr_isize, 8) +
-		sizeof(struct z_erofs_map_header);
-	const unsigned int totalidx = BLK_ROUND_UP(sbi, vi->i_size);
-	unsigned int compacted_4b_initial, compacted_2b;
-	unsigned int amortizedshift;
-	erofs_off_t pos;
-	erofs_blk_t eblk;
-	int err;
-
-	if (lcn >= totalidx || vi->z_logical_clusterbits > 14)
-		return -EINVAL;
-
-	m->lcn = lcn;
-	/* used to align to 32-byte (compacted_2b) alignment */
-	compacted_4b_initial = (32 - ebase % 32) / 4;
-	if (compacted_4b_initial == 32 / 4)
-		compacted_4b_initial = 0;
-
-	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
-	    compacted_4b_initial < totalidx)
-		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
-	else
-		compacted_2b = 0;
-
-	pos = ebase;
-	if (lcn < compacted_4b_initial) {
-		amortizedshift = 2;
-		goto out;
-	}
-	pos += compacted_4b_initial * 4;
-	lcn -= compacted_4b_initial;
-
-	if (lcn < compacted_2b) {
-		amortizedshift = 1;
-		goto out;
-	}
-	pos += compacted_2b * 2;
-	lcn -= compacted_2b;
-	amortizedshift = 2;
-out:
-	pos += lcn * (1 << amortizedshift);
-	eblk = erofs_blknr(sbi, pos);
-	if (m->map->index != eblk) {
-		err = erofs_blk_read(sbi, 0, m->kaddr, eblk, 1);
-		if (err < 0)
-			return err;
-		m->map->index = eblk;
-	}
-	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
-}
-
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
-- 
2.43.5

