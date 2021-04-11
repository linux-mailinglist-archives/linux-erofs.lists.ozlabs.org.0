Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08C35B154
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXm1YVRz3bpr
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:49:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JUgPRNn5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JUgPRNn5; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXk349Lz3bqk
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:49:10 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F1F9611C1;
 Sun, 11 Apr 2021 03:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112949;
 bh=1HYz2UaPWU6iIUwPW0smth63qR/j8fq7J5tavhrR8K4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JUgPRNn5hGOMQHjsKRdaKQ7F3Fzt5Kv0WyDHASDmFp2LftRsQXjJ7NxEIHYMh0eec
 AhSrLJFEruu7rOVl+Ot1dbnKixN0GYEfo0tRSX4c63tjhPd1/lDtc/VsY32KSkvaS2
 hf4EoUvdo0NLDcHBWZVRM7+/m+M7qVjV7h4SNiJFP/xLjFm/XLRLfwejtyPX4LUpUR
 OsM2A/PzbMzo+bdqrTeJS9uKifFijLN+/juVb1GnvfWVTYayCA2QHVlXHXTtHu1TMC
 F3ttFZybHQUQqT3lN1pctLbRVJxIJ0o8KmBqj2OIQPWW2KvuvaIIPuaO1SQE84AZlR
 vtE0LKCe/EkXQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/8] erofs-utils: fuse: support compact indexes for bigpcluster
Date: Sun, 11 Apr 2021 11:48:43 +0800
Message-Id: <20210411034844.12673-8-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210411034844.12673-1-xiang@kernel.org>
References: <20210411034844.12673-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add big pcluster compact indexes runtime support for erofsfuse,
which keeps in sync with kernel side.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/zmap.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 096fd35cdeb3..e2a54b937b7c 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -58,6 +58,14 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(
+"big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid * 1ULL);
+		return -EFSCORRUPTED;
+	}
 	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
 					((h->h_clusterbits >> 3) & 3);
 
@@ -177,6 +185,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	unsigned int vcnt, base, lo, encodebits, nblk;
 	int i;
 	u8 *in, type;
+	bool big_pcluster;
 
 	if (1 << amortizedshift == 4)
 		vcnt = 2;
@@ -185,6 +194,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
@@ -196,7 +206,15 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	m->type = type;
 	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
 		m->clusterofs = 1 << lclusterbits;
-		if (i + 1 != (int)vcnt) {
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
@@ -209,22 +227,48 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
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
+				if (lo == 1) {
+					DBG_BUGON(1);
+					/* --i; ++nblk;	continue; */
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

