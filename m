Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FEC998176
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 11:04:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPP3C28hsz3c3K
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 20:04:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728551093;
	cv=none; b=EOKRInvay1+A1MwV/Q1w6QwryWuhyK8OTcix50b5HKAKfFwJo2pYFt47H/WpWOqOcOaofWkkfVDHRH33QAF+fHTYt2HXTSrhkusu/8RY0JEuhdE37NICx12kznHeeYPQp6uqoPml6qZsPXgNPA+Lf/bw4Nfjnuw7n859rJMvXLpwNta5v9+spDP6CpjLvEEg9XOavlRsAi+R8rDkxKHrYN5E+7jch+Hol4X6LzIz0L68Kt8RYsUsc4EDNHu4OagTCS8WkXOO9AKMEj+m9CIMWsoUDpd35tBJ3JjpAQFoZcWY5iWaUFxruE78rCIt7PgFkXDwr9eRiKHHevLwftp/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728551093; c=relaxed/relaxed;
	bh=rY5VPsaO1H3ZA4xnMlRJLB6Hi8aGa4Y6EA1p+XeRCfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM99DHckUULrXp19KKa8WcXaSMDyAmbWc7LyKpZBVpYLhnrGoauad34UASHmBv9OsewDzYw8DV7n1OPlTKKpERnnb6UsItjp6vmdCwWavx7gqKRU2oWiG9AVtCTX4bBuwxtQ4Grn7Jn3xWgJl/TprOuJEQJ/sDeCJfckn43rdzUBna/uOquly7CryhPPU8iuFavLpMmxlF3gb+e+N1Rx3l1TnmVV35zBTbvwgDPYYhqByvYu8TVdQRxNZU9HybNrJ11iRywXsy7aWgOVaal8+4dEo9QbSLmYuryaxSOKw5/fnJIzOuZ7N6HqZR0KWwcTtQPpIpbvPLVMiKZ3NIVzRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aB2Nhsaq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aB2Nhsaq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPP360VyBz3bnr
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 20:04:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728551085; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rY5VPsaO1H3ZA4xnMlRJLB6Hi8aGa4Y6EA1p+XeRCfQ=;
	b=aB2Nhsaqcr2gQrUP8xeHoxXQpaEQ1nggvP+4ZltBxDMCKos787i+Zs8qZzjiE0NaR3kgjIh2Z1gIxo6J54dedjFiFxL4Qc0mQlZIBLjNm7WZDLirFqKeslDD/bWDO9IkwPfIWMuzGfvmpn1oy3k4VxBJLajkLfKF/Q1MIO4aqvI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGlkE6t_1728551079 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:04:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: get rid of kaddr in `struct z_erofs_maprecorder`
Date: Thu, 10 Oct 2024 17:04:20 +0800
Message-ID: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
References: <20241010090420.405871-1-hsiangkao@linux.alibaba.com>
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

`kaddr` becomes useless after switching to metabuf.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e980e29873a5..d329a38de1b9 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -10,8 +10,6 @@
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
-	void *kaddr;
-
 	unsigned long lcn;
 	/* compression extent information gathered */
 	u8  type, headtype;
@@ -33,14 +31,11 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      pos, EROFS_KMAP);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
-
-	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, EROFS_KMAP);
+	if (IS_ERR(di))
+		return PTR_ERR(di);
 	m->lcn = lcn;
-	di = m->kaddr;
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 
 	advise = le16_to_cpu(di->di_advise);
 	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
@@ -53,8 +48,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedblks = m->delta[0] &
-				~Z_EROFS_LI_D0_CBLKCNT;
+			m->compressedblks = m->delta[0] & ~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
@@ -110,9 +104,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
-	int i;
-	u8 *in, type;
 	bool big_pcluster;
+	u8 *in, type;
+	int i;
 
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
@@ -121,6 +115,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, EROFS_KMAP);
+	if (IS_ERR(in))
+		return PTR_ERR(in);
+
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
@@ -128,9 +126,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	bytes = pos & ((vcnt << amortizedshift) - 1);
-
-	in = m->kaddr - bytes;
-
+	in -= bytes;
 	i = bytes >> amortizedshift;
 
 	lo = decode_compactedbits(lobits, in, encodebits * i, &type);
@@ -226,7 +222,6 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	if (lcn >= totalidx)
 		return -EINVAL;
 
-	m->lcn = lcn;
 	/* used to align to 32-byte (compacted_2b) alignment */
 	compacted_4b_initial = (32 - ebase % 32) / 4;
 	if (compacted_4b_initial == 32 / 4)
@@ -254,11 +249,8 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	lcn -= compacted_2b;
 	amortizedshift = 2;
 out:
+	m->lcn = lcn;
 	pos += lcn * (1 << amortizedshift);
-	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      pos, EROFS_KMAP);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-- 
2.43.5

