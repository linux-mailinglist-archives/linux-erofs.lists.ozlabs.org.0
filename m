Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4A350D16
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 05:30:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pbh62Kkz30Bk
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:30:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BcnnrZQ+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BcnnrZQ+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9pbf4J2cz3bdF
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 14:30:22 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E839610CE;
 Thu,  1 Apr 2021 03:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617247821;
 bh=VuzJfsLKCu3ztTmmJNTWgwcNnTy0COao5kL8OfuxNVY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BcnnrZQ+OA+rtJLFxJA5V9XvQPT9h5969mLZAWcn4dHGaXIZwKdAAADlkp7YF3s8M
 o+3SlhFptvi+OpQiUI95ZSa3MPYccyj0VXDfxrG2Sd9AURhEGMXcw5nCjkzw5zanev
 lEVG7G4vLNgQdE2kLGzQh53dSaQaJxYyV247gQCzHbXKliVGQ0+HJwQe03ZWOTi28G
 sxIzvLiER2XJ/pBmC3UJiMgPZBusAXjhDb5HIcu07wTIYg2HHBXqJID2i63uAIJ7Kw
 8qq8kgvZxnlEky9S5PnnMzRD5x7S+lwQgqE+7vNYTRPaj2HgYjafnVuWEJ3cwR05L8
 kla/qTkqsuR2Q==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 08/10] erofs: support parsing big pcluster compact indexes
Date: Thu,  1 Apr 2021 11:29:52 +0800
Message-Id: <20210401032954.20555-9-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
MIME-Version: 1.0
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Different from non-compact indexes, several lclusters are packed
as the compact form at once and an unique base blkaddr is stored for
each pack, so each lcluster index would take less space on avarage
(e.g. 2 bytes for COMPACT_2B.) btw, that is also why BIG_PCLUSTER
switch should be consistent for compact head0/1.

Prior to big pcluster, the size of all pclusters is 1 lcluster.
Therefore, when a new HEAD lcluster was scanned, blkaddr would be
bumped by 1 lcluster. However, that way doesn't work anymore for
big pcluster since we actually don't know the compressed size of
pclusters in advance (before reading CBLKCNT).

So, instead, let blkaddr of each pack be the first pcluster blkaddr
with a valid CBLKCNT, in detail,

 1) if CBLKCNT starts at the pack, this first valid pcluster is
    itself, e.g.
  _____________________________________________________________
 |_CBLKCNT0_|_NONHEAD_| .. |_HEAD_|_CBLKCNT1_| ... |_HEAD_| ...
 ^ = blkaddr base          ^ += CBLKCNT0           ^ += CBLKCNT1

 2) if CBLKCNT doesn't start at the pack, the first valid pcluster
    is the next pcluster, e.g.
  _________________________________________________________
 | NONHEAD_| .. |_HEAD_|_CBLKCNT0_| ... |_HEAD_|_HEAD_| ...
                ^ = blkaddr base        ^ += CBLKCNT0
                                               ^ += 1

When a CBLKCNT is found, blkaddr will be increased by CBLKCNT
lclusters, or a new HEAD is found immediately, bump blkaddr by 1
instead (see the picture above.)

Also noted if CBLKCNT is the end of the pack, instead of storing
delta1 (distance of the next HEAD lcluster) as normal NONHEADs,
it still stores the compressed block count (delta0) since delta1
can be calculated indirectly but the block count can't.

Adjust decoding logic to fit big pcluster compact indexes as well.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zmap.c | 63 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index d34ff810cc15..545cd5989e6a 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -77,6 +77,13 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid);
+		return -EFSCORRUPTED;
+	}
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
@@ -207,6 +214,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	unsigned int vcnt, base, lo, encodebits, nblk;
 	int i;
 	u8 *in, type;
+	bool big_pcluster;
 
 	if (1 << amortizedshift == 4)
 		vcnt = 2;
@@ -215,6 +223,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
@@ -226,7 +235,15 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	m->type = type;
 	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
-		if (i + 1 != vcnt) {
+		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (!big_pcluster) {
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->delta[0] = 1;
+			return 0;
+		} else if (i + 1 != (int)vcnt) {
 			m->delta[0] = lo;
 			return 0;
 		}
@@ -239,22 +256,48 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 					  in, encodebits * (i - 1), &type);
 		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
 			lo = 0;
+		else if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT)
+			lo = 1;
 		m->delta[0] = lo + 1;
 		return 0;
 	}
 	m->clusterofs = lo;
 	m->delta[0] = 0;
 	/* figout out blkaddr (pblk) for HEAD lclusters */
-	nblk = 1;
-	while (i > 0) {
-		--i;
-		lo = decode_compactedbits(lclusterbits, lomask,
-					  in, encodebits * i, &type);
-		if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
-			i -= lo;
-
-		if (i >= 0)
+	if (!big_pcluster) {
+		nblk = 1;
+		while (i > 0) {
+			--i;
+			lo = decode_compactedbits(lclusterbits, lomask,
+						  in, encodebits * i, &type);
+			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+				i -= lo;
+
+			if (i >= 0)
+				++nblk;
+		}
+	} else {
+		nblk = 0;
+		while (i > 0) {
+			--i;
+			lo = decode_compactedbits(lclusterbits, lomask,
+						  in, encodebits * i, &type);
+			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+				if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+					--i;
+					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+					continue;
+				}
+				/* bigpcluster shouldn't have plain d0 == 1 */
+				if (lo <= 1) {
+					DBG_BUGON(1);
+					return -EFSCORRUPTED;
+				}
+				i -= lo - 2;
+				continue;
+			}
 			++nblk;
+		}
 	}
 	in += (vcnt << amortizedshift) - sizeof(__le32);
 	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
-- 
2.20.1

