Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BF3A41F3B
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 13:38:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1gHw1X70z306x
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 23:38:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740400682;
	cv=none; b=SMs84trE1Qb3Oj30AU8cW7leskFuprFSYmuB3+vByBfARstodL7k5DrVTy/pitGXdXf4QVyoqgAq4EGDl4Jj1ch6/rinpADFqQF5fW2Pp3xMNnXfgDfxw4X3DHxW0XoBqLLjTHPjbaP6K7KdM+8lL27vmaFq9bLgpXsXaFgOsiIlZOPgAaLNK66pQk/L+sZ52utTcoqyyYqtz22O6VomwOO9e1eRVkedtJouHQ01Wvzw8rvrajIGxFJh2NJF+VQ+eutfFfl5pzQSAVwuwS6gtyR6Es9/5OGQhnmCU/I3x8p9EVZdQ2Sn+veTobHqyknKtX7dJQAkO7XZJGXN95sZag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740400682; c=relaxed/relaxed;
	bh=77wyXoRkLV4oo9tYPoFRu8JPKiM3mw/dn6Qq/i2OJjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQn2HhQj2N+QeQb3Prs84FmEtEu7RmeObLsxx6KFqEx1zJiqKJUc3x3XndnMbNrIQbZtOKuYmsI0g0YBFnCPhjnQrnQPc6BH18+34icxPbzGYnPWsVgdOSQf8xHZuy9QWPVd8rdP88OsSjGKROQ+PtR5K1Qx+gmBtjk/ZGsq7Vmu6SvQS9koBzW1EZYSdmMMzjg8ykf3uLmIAbvMpQpm3xaI51NCgbjb58bsZZIA2U+3cQBsw8YeB/ko+OJkMBFpz0/kEDD/52+yNKNv3NG7VAIWn9mbBcgRiPR1294/YHmO1CrT1AL+4ufq4e0JdsTWeFe3pI9J2GQuOTE32smkBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CY20A73/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CY20A73/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1gHr3BNRz301N
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Feb 2025 23:37:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740400675; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=77wyXoRkLV4oo9tYPoFRu8JPKiM3mw/dn6Qq/i2OJjA=;
	b=CY20A73/Xqh1GIodyhTn5oVMxxnqK51FkPIiiRMaE4Y3mPXRy4OK/UQQJXwMFGh5ZiqlgUSxGRDUjfEGiQkONyYsMWBSCcaUELASJGYgFX3wvCXfDj+CxL1BTgjg32nofRYFwYFVn7psYLm69/QVDFkKsMTBqxBSkyNZZWuRDiU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQ7msAv_1740400673 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 20:37:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs: clean up header parsing for ztailpacking and fragments
Date: Mon, 24 Feb 2025 20:37:47 +0800
Message-ID: <20250224123747.1387122-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
References: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
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
v2:
 - rebase on the previous one;

 fs/erofs/zmap.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9518d341cd82..dd120306a272 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -394,7 +394,8 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 static int z_erofs_do_map_blocks(struct inode *inode,
 				 struct erofs_map_blocks *map, int flags)
 {
-	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
 	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	bool ztailpacking = vi->z_idata_size;
 	struct z_erofs_maprecorder m = {
@@ -438,7 +439,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
+			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
 				  vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -454,7 +455,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto unmap_out;
 		break;
 	default:
-		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
+		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
 			  m.type, ofs, vi->nid);
 		err = -EOPNOTSUPP;
 		goto unmap_out;
@@ -473,10 +474,16 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		map->m_flags |= EROFS_MAP_META;
 		map->m_pa = vi->z_fragmentoff;
 		map->m_plen = vi->z_idata_size;
+		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
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
@@ -495,7 +502,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
-			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+			erofs_err(sb, "inconsistent algorithmtype %u for nid %llu",
 				  afmt, vi->nid);
 			err = -EFSCORRUPTED;
 			goto unmap_out;
@@ -596,31 +603,12 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (vi->z_idata_size) {
+	if (vi->z_idata_size ||
+	    (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
 		struct erofs_map_blocks map = {
 			.buf = __EROFS_BUF_INITIALIZER
 		};
 
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-
-		if (erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
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
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
 		err = z_erofs_do_map_blocks(inode, &map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
 		erofs_put_metabuf(&map.buf);
-- 
2.43.5

