Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E32A0FFAB
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 04:44:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXFPZ6LQ0z3bhc
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 14:44:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736826288;
	cv=none; b=CKP+JGL1+e2SuMOJ7lVEpK4/AMC6jfvX7Gvi0EMFwH44e+lg8d2frQwe0KQKqspco7fWmvtGCrsJfNgDpwR3lQVrvDALnAyvGMi+1cuKKIGQDJZdp9Jbc1jHBIwl4fUKCmmpo0MiZUvm5ewdG34cU7E5FTeU833jzn/ratv7HCNYEgEsDjyu0fLoiqI7Z4PdeO8Kn/F0k0LEN8oxHgILuJRN2n5w1IARIoMoOvrKRNETPsEQFcdBoybdd8fBZLSRCGgo7j8Sex3cAMYdvKwWAqlWEMAPtNqTh2KsuJMnMA9OoxCsZ4R4uhzdpI05fDFx+QkaYpaCrSwup22OxwqWag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736826288; c=relaxed/relaxed;
	bh=NJirLwZwUJRr4MlLi0WWiFmb8wHdCtx8XOzXKbzDIdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZ4DFroiRjg01MboGqoWqm7MctkUWkcSFDeP4czZRnL2iY4+wkK69vtK3Ir9e+aftgQ+eLOP46BSPj5sKLpjH31fXvJI67cpCRxbHE5MeWwS0l2kj4t4Ymr/1yzxNBsiSIaNjYYeFEjgD0wsxurmk7gBMC455zU2HEGpC5UWXWw292H2o1J37XsUrCH5D03ToUwttdckcxgR2QspBAr0HPR/sYjhQ9yrtOFu4TQ25GanPioEYRZoP/nNlO44Rr+oqSmEUW6t7P0ZPuTJlAWXqVx76y1HK/UCKdIKi8rgAprH45I2LWjYEgzxIoP8W7zh9VlTjcADoQzSwDv+16a0AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=REtqh0tI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=REtqh0tI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXFPT2Dwbz2yyC
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jan 2025 14:44:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736826278; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NJirLwZwUJRr4MlLi0WWiFmb8wHdCtx8XOzXKbzDIdM=;
	b=REtqh0tIP2YsSR2EoKCKg+KUNY6d+7JP+wTx+mzZaReParPJUjXd6Rl0qfYAacpn8xTBwd6bcZYX+QN6sHdLIUn/6c5AgKzG2gPq2x6YU6ky3l5fwOFY2Qt5eGG0a4J0MWpCD1295Hk/CwdnrqMeKPexe0XadZhfjrBmd1qQoxA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNdPh.b_1736826272 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 11:44:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs: simplify z_erofs_load_compact_lcluster()
Date: Tue, 14 Jan 2025 11:44:26 +0800
Message-ID: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 - Get rid of unpack_compacted_index() and fold it into
   z_erofs_load_compact_lcluster();

 - Avoid a goto.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 89 ++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 4535f2f0a014..b9e35089c9b8 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -97,17 +97,48 @@ static int get_compacted_la_distance(unsigned int lobits,
 	return d1;
 }
 
-static int unpack_compacted_index(struct z_erofs_maprecorder *m,
-				  unsigned int amortizedshift,
-				  erofs_off_t pos, bool lookahead)
+static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
+					 unsigned long lcn, bool lookahead)
 {
-	struct erofs_inode *const vi = EROFS_I(m->inode);
+	struct inode *const inode = m->inode;
+	struct erofs_inode *const vi = EROFS_I(inode);
+	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
+		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int totalidx = erofs_iblks(inode);
+	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
 	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
-	bool big_pcluster;
+	bool big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	erofs_off_t pos;
 	u8 *in, type;
 	int i;
 
+	if (lcn >= totalidx || lclusterbits > 14)
+		return -EINVAL;
+
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
@@ -122,7 +153,6 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
-	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	bytes = pos & ((vcnt << amortizedshift) - 1);
@@ -207,53 +237,6 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
-					 unsigned long lcn, bool lookahead)
-{
-	struct inode *const inode = m->inode;
-	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
-		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	unsigned int totalidx = erofs_iblks(inode);
-	unsigned int compacted_4b_initial, compacted_2b;
-	unsigned int amortizedshift;
-	erofs_off_t pos;
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
-	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
-}
-
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
-- 
2.43.5

