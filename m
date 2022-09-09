Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 081CC5B2DEB
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 07:04:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP3nG01Whz3bSV
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 15:04:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.18; helo=out199-18.us.a.mail.aliyun.com; envelope-from=ziyangzhang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP3nC4wTmz2xFx
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 15:04:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VP7r47l_1662699535;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VP7r47l_1662699535)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 12:58:58 +0800
From: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 3/4] erofs-utils: fuse: introduce partial-referenced pclusters
Date: Fri,  9 Sep 2022 12:58:20 +0800
Message-Id: <20220909045821.104499-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220909045821.104499-1-ZiyangZhang@linux.alibaba.com>
References: <20220909045821.104499-1-ZiyangZhang@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Due to deduplication for compressed data, pclusters can be partially
referenced with their prefixes.

Decompression algorithms should know that in advance, otherwise they
will fail out unexpectedly.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 include/erofs/internal.h | 3 +++
 include/erofs_fs.h       | 3 +++
 lib/data.c               | 3 ++-
 lib/zmap.c               | 6 ++++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2e0aae8..2ae7737 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -279,6 +279,7 @@ enum {
 	BH_Mapped,
 	BH_Encoded,
 	BH_FullMapped,
+	BH_Partialref,
 };
 
 /* Has a disk mapping */
@@ -289,6 +290,8 @@ enum {
 #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+/* The extent refers to partial compressed data */
+#define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
 
 struct erofs_map_blocks {
 	char mpage[EROFS_BLKSIZ];
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 08f9761..09f672b 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -355,6 +355,9 @@ enum {
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
+/* (noncompact, HEAD) This pcluster refers to compressed data partially */
+#define Z_EROFS_VLE_DI_PARTIAL_REF		(1 << 15)
+
 /*
  * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
  * compressed block count of a compressed extent (in logical clusters, aka.
diff --git a/lib/data.c b/lib/data.c
index ad7b2cb..9b2ab6a 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -258,7 +258,8 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		} else {
 			DBG_BUGON(end != map.m_la + map.m_llen);
 			length = map.m_llen;
-			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
+			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED) ||
+				(map.m_flags & EROFS_MAP_PARTIAL_REF);
 		}
 
 		if (map.m_la < offset) {
diff --git a/lib/zmap.c b/lib/zmap.c
index abe0d31..56efaa7 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -99,6 +99,7 @@ struct z_erofs_maprecorder {
 	u16 delta[2];
 	erofs_blk_t pblk, compressedlcs;
 	erofs_off_t nextpackoff;
+	bool partialref;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -161,6 +162,9 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		if (advise & Z_EROFS_VLE_DI_PARTIAL_REF)
+			m->partialref = true;
+
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
@@ -602,6 +606,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		goto out;
 	}
 
+	if (m.partialref)
+		map->m_flags |= EROFS_MAP_PARTIAL_REF;
 	map->m_llen = end - map->m_la;
 	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
 		vi->z_tailextent_headlcn = m.lcn;
-- 
2.27.0

