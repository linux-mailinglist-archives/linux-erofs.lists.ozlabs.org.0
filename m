Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB618A41F3C
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 13:38:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1gHw5MwMz30Vl
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 23:38:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740400682;
	cv=none; b=ZXQxmU06zuV6GLBV4qUeUUndjeCHIKV8hReL11yrakUY+kdinHPmFEdkQqM2XsRn6BgCjE0Tfj0c7Vz7C9DvBewE6FlkoXT6lGBktsZvvzRXXl41dwGr+yUBeH4zJiFx7dprKvRoAQKAaWTMzQVVlZmMgSImJtOSg7YY3tWacBVxcqO3Rp+SmWVtaQu6DhhzO3l2OmuQq5rRBp75U/NdPU8H9QhAnu0lkdGYzFyeONpkm9bCpkhTTcLg5c+0RUW/lNSRLAzTUU+A8sWQPSvRqqzOJYDh+SJ0dTWdBqn66j/221lz+Ul6hMqGcOQ5M8JfsBJ/2pNukLF1T1Du/vgqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740400682; c=relaxed/relaxed;
	bh=kmX+/KBPQc3cQhROjOMmtM1SZ96Zp/Yb5gAWSXOJdx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nawt/Dkv4ZyUESRIGHlrQuzC73iE+wq2C4iw2YbtnAHLLDBOS6RR9PeD/eWzkRvxX1dmNcnzESaw1t21HOUe1RhYchlFen3tjzZiy6VqDy5loXr5vJp29t957Ckhp6biq74ClZzksQn6NVYSkN0oowi+LxiyXx7SjiDCS77egL1XU/gFzjhAkHkgeXhRU1G3lk1LwDPCuKSyNSSoqMMibx5X1Mje0aSNdno7T4XUmeq+MCAZ/DP4JQyWY1reOpn7Sxg0EQpYC76/TyzyHzgHA5By5dwprgcHZayWhJtV0dkKFcSe+Ws7EdIf92Bx5/eVGBzedTP5cAkdYoOOIjWe8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jz6NvqAW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jz6NvqAW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1gHr1NNpz2yRM
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Feb 2025 23:37:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740400674; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kmX+/KBPQc3cQhROjOMmtM1SZ96Zp/Yb5gAWSXOJdx8=;
	b=jz6NvqAWqbuN2Xh8q2z70EcRF7xQ+jzXXphOUymKMqEPUuMc2vlfNl3b24Nz5Z0JdUYr24hd+tuTzYes5sNF+zATBP+VNbI5LsZRSh9f3zTWJqBEkNUK1QqjBOuRQSam7RZ8NAW/N+PXL6VmpfjtYEXLtZ5Vr9iPnBIu9v6GFNo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQ7ms9G_1740400668 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 20:37:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs: simplify tail inline pcluster handling
Date: Mon, 24 Feb 2025 20:37:46 +0800
Message-ID: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
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

Commit ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline
support") introduced the flag `Z_EROFS_ADVISE_INLINE_PCLUSTER`, which is
redundant because `h_idata_size != 0` serves the same purpose.

Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
features are mutually exclusive for a given inode.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
new patch.

 fs/erofs/internal.h |  9 ++-------
 fs/erofs/zmap.c     | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f955793146f4..afce4b03f586 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -265,13 +265,8 @@ struct erofs_inode {
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
 			unsigned long  z_tailextent_headlcn;
-			union {
-				struct {
-					erofs_off_t    z_idataoff;
-					unsigned short z_idata_size;
-				};
-				erofs_off_t z_fragmentoff;
-			};
+			erofs_off_t    z_fragmentoff;
+			unsigned short z_idata_size;
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a0c1c6450a55..9518d341cd82 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -395,8 +395,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
 		.inode = inode,
 		.map = map,
@@ -415,9 +415,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	if (err)
 		goto unmap_out;
 
-	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
-		vi->z_idataoff = m.nextpackoff;
-
+	if ((flags & EROFS_GET_BLOCKS_FINDTAIL) && ztailpacking)
+		vi->z_fragmentoff = m.nextpackoff;
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
@@ -472,7 +471,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	}
 	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_META;
-		map->m_pa = vi->z_idataoff;
+		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
@@ -565,6 +564,10 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_advise = le16_to_cpu(h->h_advise);
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+	else
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
 	headnr = 0;
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
@@ -593,18 +596,16 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+	if (vi->z_idata_size) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
 
-		if (!map.m_plen ||
-		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
+		if (erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
 			erofs_err(sb, "invalid tail-packing pclustersize %llu",
 				  map.m_plen);
 			err = -EFSCORRUPTED;
-- 
2.43.5

