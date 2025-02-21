Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E782A3F09F
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2025 10:41:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzlWG2Nfmz30Vb
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2025 20:41:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740130872;
	cv=none; b=bJp5l2NUE+yrUTwWvJvRmTmSVuso7o3kf8jYsMRvoJJhr7DZB9ir/sjDEs7mbHMdIi4nnrnzP1yeS9kTBNka9gKw10n+32OkYMIKpgCobTD4bTNrF8hZDWPxrzq/X0Kd6gb8QK9xmTNq3JQrpKDhNyaMds9OKv2kgOwfwEXP4orxr3PAO+QtGhv/UQVcMT88yCKiL5RZvBIJlZaN7bTSmCr0QY8H0V/r21wmg2OXMEUH7HHY/HlPbYiwVhPZjRFhI3VDMv1Ert9mgH7vFu2fUxxrXJzu4AeYP4SchgwY/PTXBWA7Zu5Nm3YiQUKTI40sBJpvvhMVamjkZ9Sip4IDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740130872; c=relaxed/relaxed;
	bh=TfkidDMxPMlQA/XL/XYnY8kMut3kWfLopLNxuBD/amA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEXixTFwUDq0aY7o4/BvImyoDGGM6672HB1Ua6F6upMbKWf6x6s6dzg+Rv1xErsa7JRjE94O150AWRVf3lqQTCMNFjrvtJvoMhHVdY2OcL0WYjS/XJpED3cljYlT/Psp6pszkz90vGSGz1SM8sDbYSEPTxqtuDa7O7qdHY/aAAcuzYD5i6ONxOa7beJB2kc6Uu3s1ifzFKLKK2bA/hdjdSSrNaD9ElCO27ke0xz2Tt9ozs1myLQODfQAsvAD7iSIajczWlmADLHgiVHYugRbZZY5/P8Y3efnhvY9izmuNKwRNhtGzcWqRXTM5Qb2oV4usXlW5f6W1uuXqZErY2I54w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FAMFFCM3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FAMFFCM3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzlW93kdKz2xCd
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2025 20:41:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740130862; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TfkidDMxPMlQA/XL/XYnY8kMut3kWfLopLNxuBD/amA=;
	b=FAMFFCM3Hj8LtZsTLeq7zUBgV61FrnoU5ARjzehcsQeuSjCXNBr0L+fwKR+TztZ6myeNVwTlDtP4kxhlKVHJ4Kn/BbI6eoHwhBqwmGkqql3pHQD+OWlmckXjEFAVtbsZragjlDyVckvoFhkHpBnE9Ra87apa1xnUPi8yJeoOui4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPvxQPd_1740130856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 17:41:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up header parsing for ztailpacking and fragments
Date: Fri, 21 Feb 2025 17:40:55 +0800
Message-ID: <20250221094055.4014984-1-hsiangkao@linux.alibaba.com>
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

Simplify the logic in z_erofs_fill_inode_lazy() by combining the
handling of ztailpacking and fragments, as they are mutually exclusive.

Note that `h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT` is handled
above, so no need to duplicate the check.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index a0c1c6450a55..bdac20800ded 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -394,7 +394,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
-	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
 	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	struct z_erofs_maprecorder m = {
@@ -439,7 +440,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
+			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -455,7 +456,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
+		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
 			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
@@ -474,10 +475,17 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_idataoff;
 		map->m_plen = vi->z_idata_size;
+		if (!map->m_plen ||
+		    erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
+			erofs_err(sb, "invalid tail-packing pclustersize %llu",
+				  map->m_plen);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
-		map->m_pa = erofs_pos(inode->i_sb, m.pblk);
+		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 		if (err)
 			goto unmap_out;
@@ -496,7 +504,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
-			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+			erofs_err(sb, "inconsistent algorithmtype %u for nid %llu",
 				  afmt, vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -593,33 +601,16 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-
-		if (!map.m_plen ||
-		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
-			erofs_err(sb, "invalid tail-packing pclustersize %llu",
-				  map.m_plen);
-			err = -EFSCORRUPTED;
-		}
-		if (err < 0)
-			goto out_put_metabuf;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+	if (vi->z_advise & (Z_EROFS_ADVISE_INLINE_PCLUSTER |
+			    Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
+			vi->z_idata_size = le16_to_cpu(h->h_idata_size);
+		else
+			vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
-- 
2.43.5

