Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C530B82E4AF
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 01:24:32 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dpZy0nH9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TDVBQ4z7Bz3bfS
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 11:24:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dpZy0nH9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TDV9N3qsQz3bhc
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jan 2024 11:23:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 526C3CE18BA;
	Tue, 16 Jan 2024 00:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5942C43394;
	Tue, 16 Jan 2024 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364615;
	bh=+kzaSbn5AcNZV9Az1XS8nKvGSGd1PbX1+x3zuomJV7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpZy0nH9Wm/HvuqhvtE78RQ47AzIAX8uhUncjBv8p29kXh6RRSIf3SwsVvW/CgsR6
	 TwxN8RRoFRwuHoyy1LtsTtcZLvaQl8srdyBhT3ZV4DvXUNKNAtyAd5ryzuXXyv5Alu
	 1oJeh0+cCwDCi3tzqdGjiKl8/Vo34auVO5A3/wAtnwLrprsI/MjOvvrxgYep+8CO6f
	 WGPZXX+NwZnQjeS1WHRmgGPqvNmS1C5cFeU4hPDDATfhiB12hX8udyuJby5Z/GrN5W
	 UOz33Dr2Gn23g+2WamdRRHoSvk84hHNDt7sAUiZyxsEe+CxlNlQJRm+9vdYWohzB5C
	 2aavuETMeC4QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 10/19] erofs: fix up compacted indexes for block size < 4096
Date: Mon, 15 Jan 2024 19:22:46 -0500
Message-ID: <20240116002311.214705-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002311.214705-1-sashal@kernel.org>
References: <20240116002311.214705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
Cc: Sasha Levin <sashal@kernel.org>, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 8d2517aaeea3ab8651bb517bca8f3c8664d318ea ]

Previously, the block size always equaled to PAGE_SIZE, therefore
`lclusterbits` couldn't be less than 12.

Since sub-page compressed blocks are now considered, `lobits` for
a lcluster in each pack cannot always be `lclusterbits` as before.
Otherwise, there is no enough room for the special value
`Z_EROFS_LI_D0_CBLKCNT`.

To support smaller block sizes, `lobits` for each compacted lcluster is
now calculated as:
   lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1)

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231206091057.87027-4-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7b55111fd533..9753875e41cb 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -82,29 +82,26 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 }
 
 static unsigned int decode_compactedbits(unsigned int lobits,
-					 unsigned int lomask,
 					 u8 *in, unsigned int pos, u8 *type)
 {
 	const unsigned int v = get_unaligned_le32(in + pos / 8) >> (pos & 7);
-	const unsigned int lo = v & lomask;
+	const unsigned int lo = v & ((1 << lobits) - 1);
 
 	*type = (v >> lobits) & 3;
 	return lo;
 }
 
-static int get_compacted_la_distance(unsigned int lclusterbits,
+static int get_compacted_la_distance(unsigned int lobits,
 				     unsigned int encodebits,
 				     unsigned int vcnt, u8 *in, int i)
 {
-	const unsigned int lomask = (1 << lclusterbits) - 1;
 	unsigned int lo, d1 = 0;
 	u8 type;
 
 	DBG_BUGON(i >= vcnt);
 
 	do {
-		lo = decode_compactedbits(lclusterbits, lomask,
-					  in, encodebits * i, &type);
+		lo = decode_compactedbits(lobits, in, encodebits * i, &type);
 
 		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			return d1;
@@ -123,15 +120,14 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const unsigned int lomask = (1 << lclusterbits) - 1;
-	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
+	unsigned int vcnt, base, lo, lobits, encodebits, nblk, eofs;
 	int i;
 	u8 *in, type;
 	bool big_pcluster;
 
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
-	else if (1 << amortizedshift == 2 && lclusterbits == 12)
+	else if (1 << amortizedshift == 2 && lclusterbits <= 12)
 		vcnt = 16;
 	else
 		return -EOPNOTSUPP;
@@ -140,6 +136,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	eofs = erofs_blkoff(m->inode->i_sb, pos);
 	base = round_down(eofs, vcnt << amortizedshift);
@@ -147,15 +144,14 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 
 	i = (eofs - base) >> amortizedshift;
 
-	lo = decode_compactedbits(lclusterbits, lomask,
-				  in, encodebits * i, &type);
+	lo = decode_compactedbits(lobits, in, encodebits * i, &type);
 	m->type = type;
 	if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
 
 		/* figure out lookahead_distance: delta[1] if needed */
 		if (lookahead)
-			m->delta[1] = get_compacted_la_distance(lclusterbits,
+			m->delta[1] = get_compacted_la_distance(lobits,
 						encodebits, vcnt, in, i);
 		if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 			if (!big_pcluster) {
@@ -174,8 +170,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		 * of which lo saves delta[1] rather than delta[0].
 		 * Hence, get delta[0] by the previous lcluster indirectly.
 		 */
-		lo = decode_compactedbits(lclusterbits, lomask,
-					  in, encodebits * (i - 1), &type);
+		lo = decode_compactedbits(lobits, in,
+					  encodebits * (i - 1), &type);
 		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 			lo = 0;
 		else if (lo & Z_EROFS_LI_D0_CBLKCNT)
@@ -190,8 +186,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		nblk = 1;
 		while (i > 0) {
 			--i;
-			lo = decode_compactedbits(lclusterbits, lomask,
-						  in, encodebits * i, &type);
+			lo = decode_compactedbits(lobits, in,
+						  encodebits * i, &type);
 			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD)
 				i -= lo;
 
@@ -202,8 +198,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 		nblk = 0;
 		while (i > 0) {
 			--i;
-			lo = decode_compactedbits(lclusterbits, lomask,
-						  in, encodebits * i, &type);
+			lo = decode_compactedbits(lobits, in,
+						  encodebits * i, &type);
 			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 				if (lo & Z_EROFS_LI_D0_CBLKCNT) {
 					--i;
-- 
2.43.0

