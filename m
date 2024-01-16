Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C9A82E4C3
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 01:25:31 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lm9Thyr5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TDVCY3dH7z3cT7
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 11:25:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lm9Thyr5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TDVBc6h4Gz3cJW
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jan 2024 11:24:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E1DDCE18CA;
	Tue, 16 Jan 2024 00:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03146C43394;
	Tue, 16 Jan 2024 00:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364676;
	bh=+kzaSbn5AcNZV9Az1XS8nKvGSGd1PbX1+x3zuomJV7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lm9Thyr5fxidnMcSLTljK+1H79WmiwF7/m6Y/ICLgSV7f5c8ApR+YC1Q7K0PBD9XJ
	 3TaYcLw5JyDLTXKTZb0AulgJGgi8kBTIgu0ojZAWAq8IO112fr/d9uUqd06iEA/Y4/
	 QJ5AdsB47xeqVXopxxe8o8k5KUeGRna+mJwZ3qKYRZ0y0rzGt+fTbKbX8TlcneH8Qi
	 fPfId1JfiUsqQGY6cwLWb8iqDDT9w3gWpR9y+7ucqDix9i+2b94veNvJP7w7NN3+b0
	 w4HrBfBQTnFXrQmP3tmeyPVqblTyyce1khTCmFwjC55jhMmHiwo3H9GW89QIbsVPS3
	 YVF1gc7S9M3fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/19] erofs: fix up compacted indexes for block size < 4096
Date: Mon, 15 Jan 2024 19:23:45 -0500
Message-ID: <20240116002413.215163-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002413.215163-1-sashal@kernel.org>
References: <20240116002413.215163-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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

