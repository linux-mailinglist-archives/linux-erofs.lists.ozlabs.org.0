Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0C377D0C
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 09:23:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fdswd5512z2yxW
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 17:23:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QoAE+Wuz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QoAE+Wuz; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fdswb2QL0z2yjL
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 May 2021 17:23:27 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78278613CF;
 Mon, 10 May 2021 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620631405;
 bh=Z3gYfjj3Lq9U3t+36AOGy6d3wfN5dJe6ww4NjLrHjxM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QoAE+WuzY9tDLLm706JZIb7nMXJmouOUqYsy3Vl+CfC295ptlX0aIFiJfusckOmv9
 pA8v88OOFGdxrUKzpFbM1wDVS14Hi08EqM5PVZnaq/xdpsCqKhmiH3/9/KZaFhQ6Y6
 Y1MnSELVuKwDQ5mtkVlVyx3Mm/IRi+jeMZCmgn0Q/4PwBsHQIS99G0YVXCfUPjy2SW
 sCisftaRFSlsnzQtlr6SdIPz1MD1P1B5yUC9P0jhZh4cE74XcRybLuUAH5SOpZ/YKp
 G/zPCRaXKxlETZV2cF3LrNGV6KXqR1AkIPEPqoPQFymsRfS8DI379IkOU/EAHZJSHy
 UFcQ0xtWG5bqQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH 4/4] erofs-utils: sync up z_erofs_get_extent_compressedlen()
Date: Mon, 10 May 2021 15:23:03 +0800
Message-Id: <20210510072303.4628-5-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510072303.4628-1-xiang@kernel.org>
References: <20210510072303.4628-1-xiang@kernel.org>
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

Sync up with in-kernel z_erofs_get_extent_compressedlen(), mainly
fix 1 lcluster-sized pcluster for big pcluster.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/zmap.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 0c5c4f52bbd0..1084faa6e489 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -386,16 +386,13 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 
 	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
 		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
-	if (!((map->m_flags & EROFS_MAP_ZIPPED) &&
-	      (vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1))) {
+	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
 		map->m_plen = 1 << lclusterbits;
 		return 0;
 	}
 
 	lcn = m->lcn + 1;
-	if (lcn == initial_lcn && !m->compressedlcs)
-		m->compressedlcs = 2;
-
 	if (m->compressedlcs)
 		goto out;
 
@@ -403,21 +400,46 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	if (err)
 		return err;
 
+	/*
+	 * If the 1st NONHEAD lcluster has already been handled initially w/o
+	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
+	 * an internal implemenatation error is detected.
+	 *
+	 * The following code can also handle it properly anyway, but let's
+	 * BUG_ON in the debugging mode only for developers to notice that.
+	 */
+	DBG_BUGON(lcn == initial_lcn &&
+		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
+
 	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		/*
+		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
+		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
+		 */
+		m->compressedlcs = 1;
+		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		DBG_BUGON(m->delta[0] != 1);
-		if (m->compressedlcs) {
+		if (m->delta[0] != 1)
+			goto err_bonus_cblkcnt;
+		if (m->compressedlcs)
 			break;
-		}
+		/* fallthrough */
 	default:
 		erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
-			  lcn, (unsigned long long)vi->nid);
+			  lcn, vi->nid | 0ULL);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
 out:
 	map->m_plen = m->compressedlcs << lclusterbits;
 	return 0;
+err_bonus_cblkcnt:
+	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
+		  lcn, vi->nid | 0ULL);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 }
 
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-- 
2.20.1

