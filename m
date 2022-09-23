Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFF85E7191
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 03:49:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYZp95TFxz3c2N
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 11:49:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYZp253gDz2xk6
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Sep 2022 11:49:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQUVO-6_1663897756;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQUVO-6_1663897756)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 09:49:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: introduce partial-referenced pclusters
Date: Fri, 23 Sep 2022 09:49:15 +0800
Message-Id: <20220923014915.4362-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Due to deduplication for compressed data, pclusters can be partially
referenced with their prefixes.

Together with the user-space implementation, it enables EROFS
variable-length global compressed data deduplication with rolling
hash.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor_lzma.c | 3 +++
 fs/erofs/erofs_fs.h          | 7 ++++++-
 fs/erofs/internal.h          | 4 ++++
 fs/erofs/super.c             | 2 ++
 fs/erofs/sysfs.c             | 2 ++
 fs/erofs/zdata.c             | 1 +
 fs/erofs/zmap.c              | 6 +++++-
 7 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 5e59b3f523eb..091fd5adf818 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -217,6 +217,9 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			strm->buf.out_size = min_t(u32, outlen,
 						   PAGE_SIZE - pageofs);
 			outlen -= strm->buf.out_size;
+			if (!rq->out[no] && rq->fillgaps)	/* deduped */
+				rq->out[no] = erofs_allocpage(pagepool,
+						GFP_KERNEL | __GFP_NOFAIL);
 			if (rq->out[no])
 				strm->buf.out = kmap(rq->out[no]) + pageofs;
 			pageofs = 0;
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 5d8fefd8b3fb..0e6c6a234438 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -26,6 +26,7 @@
 #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
+#define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -34,7 +35,8 @@
 	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
 	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
-	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
+	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
+	 EROFS_FEATURE_INCOMPAT_DEDUPE)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -371,6 +373,9 @@ enum {
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
+/* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
+#define Z_EROFS_VLE_DI_PARTIAL_REF		(1 << 15)
+
 /*
  * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
  * compressed block count of a compressed extent (in logical clusters, aka.
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9f89c1da6229..db8466f2a918 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -291,6 +291,7 @@ EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
+EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -392,6 +393,7 @@ enum {
 	BH_Encoded = BH_PrivateStart,
 	BH_FullMapped,
 	BH_Fragment,
+	BH_Partialref,
 };
 
 /* Has a disk mapping */
@@ -404,6 +406,8 @@ enum {
 #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 /* Located in the special packed inode */
 #define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
+/* the extent refers to partial compressed data */
+#define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
 
 struct erofs_map_blocks {
 	struct erofs_buf buf;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 4a55908ad37b..6bc45403ea5e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -424,6 +424,8 @@ static int erofs_read_superblock(struct super_block *sb)
 		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
 	if (erofs_sb_has_fragments(sbi))
 		erofs_info(sb, "EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
+	if (erofs_sb_has_dedupe(sbi))
+		erofs_info(sb, "EXPERIMENTAL global deduplication feature in use. Use at your own risk!");
 out:
 	erofs_put_metabuf(&buf);
 	return ret;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dd6eb7eccf9a..783bb7b21b51 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -77,6 +77,7 @@ EROFS_ATTR_FEATURE(compr_head2);
 EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
+EROFS_ATTR_FEATURE(dedupe);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -88,6 +89,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(sb_chksum),
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
+	ATTR_LIST(dedupe),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c92a72f5bca6..cce56dde135c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -814,6 +814,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		fe->pcl->multibases = true;
 
 	if ((map->m_flags & EROFS_MAP_FULL_MAPPED) &&
+	    !(map->m_flags & EROFS_MAP_PARTIAL_REF) &&
 	    fe->pcl->length == map->m_llen)
 		fe->pcl->partial = false;
 	if (fe->pcl->length < offset + end - map->m_la) {
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 6830999529d7..5ce63326aa7d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -167,6 +167,7 @@ struct z_erofs_maprecorder {
 	u16 delta[2];
 	erofs_blk_t pblk, compressedblks;
 	erofs_off_t nextpackoff;
+	bool partialref;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -225,6 +226,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
+		if (advise & Z_EROFS_VLE_DI_PARTIAL_REF)
+			m->partialref = true;
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
@@ -688,7 +691,8 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		err = -EOPNOTSUPP;
 		goto unmap_out;
 	}
-
+	if (m.partialref)
+		map->m_flags |= EROFS_MAP_PARTIAL_REF;
 	map->m_llen = end - map->m_la;
 
 	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
-- 
2.24.4

