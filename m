Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358B5EAAE1
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Sep 2022 17:25:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MbmmV3Crtz3c5D
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 01:25:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MbmmF6pPrz300V
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 01:25:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQoJONp_1664205929;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQoJONp_1664205929)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 23:25:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/8] erofs-utils: fuse: introduce partial-referenced pclusters
Date: Mon, 26 Sep 2022 23:25:10 +0800
Message-Id: <20220926152511.94832-8-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220926152511.94832-1-hsiangkao@linux.alibaba.com>
References: <20220926152511.94832-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Due to deduplication for compressed data, pclusters can be partially
referenced with their prefixes.

Decompression algorithms should know that in advance, otherwise they
will fail out unexpectedly.

Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h | 4 ++++
 include/erofs_fs.h       | 7 ++++++-
 lib/data.c               | 3 ++-
 lib/zmap.c               | 6 ++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6fc58f9..3bce92f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -136,6 +136,7 @@ EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
+EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -286,6 +287,7 @@ enum {
 	BH_Encoded,
 	BH_FullMapped,
 	BH_Fragment,
+	BH_Partialref,
 };
 
 /* Has a disk mapping */
@@ -298,6 +300,8 @@ enum {
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 /* Located in the special packed inode */
 #define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
+/* the extent refers to partial compressed data */
+#define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
 
 struct erofs_map_blocks {
 	char mpage[EROFS_BLKSIZ];
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index e492ad9..48ad5b5 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -26,6 +26,7 @@
 #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
+#define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -33,7 +34,8 @@
 	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
 	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
-	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
+	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
+	 EROFS_FEATURE_INCOMPAT_DEDUPE)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -371,6 +373,9 @@ enum {
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
+/* (noncompact, HEAD) This pcluster refers to compressed data partially */
+#define Z_EROFS_VLE_DI_PARTIAL_REF		(1 << 15)
+
 /*
  * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
  * compressed block count of a compressed extent (in logical clusters, aka.
diff --git a/lib/data.c b/lib/data.c
index bcb0f7e..76a6677 100644
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
index 2c2ba01..11228af 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -121,6 +121,7 @@ struct z_erofs_maprecorder {
 	u16 delta[2];
 	erofs_blk_t pblk, compressedlcs;
 	erofs_off_t nextpackoff;
+	bool partialref;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -183,6 +184,9 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		if (advise & Z_EROFS_VLE_DI_PARTIAL_REF)
+			m->partialref = true;
+
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
@@ -625,6 +629,8 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		goto out;
 	}
 
+	if (m.partialref)
+		map->m_flags |= EROFS_MAP_PARTIAL_REF;
 	map->m_llen = end - map->m_la;
 	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
 		vi->z_tailextent_headlcn = m.lcn;
-- 
2.24.4

