Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7566AB6D
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 13:58:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NvJHh6D9hz3cC4
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 23:58:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P8kcW9Fa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P8kcW9Fa;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NvJHb5Ybcz3cgq
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jan 2023 23:58:19 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1ADA16091F;
	Sat, 14 Jan 2023 12:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19278C433D2;
	Sat, 14 Jan 2023 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673701095;
	bh=/LYB2TwpC+HPUPWYl+FMF4k9ra4MQtGSeEtXZo29/rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8kcW9Fa7n9kWGIFVlbyX6iV4O5zELbms8nkLKF2tQyKUM1Vu5TjzGIhkTV1qCq9+
	 mhXACSG1qlEA8Hohi6zp2X82+DVdu8rXW+pjAygfPPw2VT4jfgVwZFWLR7efrp++AV
	 dPwPVREG1FA+PNvKEcf4pmF3cE4uQl8uC0nKFgI3WZ57Qc74Z56kLpctVtzNBn54TW
	 kmHKdLWx4PW0TCEV+ZJoSd71wzJomb/hkMGeN9NB2mrOMUaxpOpgn3kZu9wcRpz2PY
	 xrg1kEJTc/UR6bBE5+kWYrHvgdskqh6Yjx4IpB/0MRt7Ka7eLKSSA7wW0vp4xdJGJB
	 br5+8C0kfToIQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: simplify iloc()
Date: Sat, 14 Jan 2023 20:57:46 +0800
Message-Id: <20230114125746.399253-2-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230114125746.399253-1-xiang@kernel.org>
References: <20230114125746.399253-1-xiang@kernel.org>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Actually we could pass in inodes directly to clean up all callers.
Also rename iloc() as erofs_iloc().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     |  9 +++------
 fs/erofs/inode.c    |  2 +-
 fs/erofs/internal.h | 16 +++++++++-------
 fs/erofs/xattr.c    | 20 +++++++-------------
 fs/erofs/zmap.c     | 13 +++++--------
 5 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f57f921683d7..2713257ee718 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -91,11 +91,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
 		map->m_plen = blknr_to_addr(lastblk) - offset;
 	} else if (tailendpacking) {
-		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
-		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-
-		map->m_pa = iloc(sbi, vi->nid) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(map->m_la);
+		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
+			vi->xattr_isize + erofs_blkoff(offset);
 		map->m_plen = inode->i_size - offset;
 
 		/* inline data should be located in the same meta block */
@@ -150,7 +147,7 @@ int erofs_map_blocks(struct inode *inode,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
 
 	chunknr = map->m_la >> vi->chunkbits;
-	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
+	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
 	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 57328691582e..d7e87d41f7bf 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -14,7 +14,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_inode *vi = EROFS_I(inode);
-	const erofs_off_t inode_loc = iloc(sbi, vi->nid);
+	const erofs_off_t inode_loc = erofs_iloc(inode);
 
 	erofs_blk_t blkaddr, nblks = 0;
 	void *kaddr;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b4cc40fa3803..b7291691be68 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -270,11 +270,6 @@ struct erofs_buf {
 #define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
 #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
 
-static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
-{
-	return blknr_to_addr(sbi->meta_blkaddr) + (nid << sbi->islotbits);
-}
-
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
 static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 { \
@@ -339,8 +334,15 @@ struct erofs_inode {
 	struct inode vfs_inode;
 };
 
-#define EROFS_I(ptr)	\
-	container_of(ptr, struct erofs_inode, vfs_inode)
+#define EROFS_I(ptr)	container_of(ptr, struct erofs_inode, vfs_inode)
+
+static inline erofs_off_t erofs_iloc(struct inode *inode)
+{
+	struct erofs_sb_info *sbi = EROFS_I_SB(sbi);
+
+	return blknr_to_addr(sbi->meta_blkaddr) +
+		(EROFS_I(nid) << sbi->islotbits);
+}
 
 static inline unsigned long erofs_inode_datablocks(struct inode *inode)
 {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a62fb8a3318a..60729b1220b6 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -22,8 +22,7 @@ static int init_inode_xattrs(struct inode *inode)
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
-	struct super_block *sb;
-	struct erofs_sb_info *sbi;
+	struct super_block *sb = inode->i_sb;
 	int ret = 0;
 
 	/* the most case is that xattrs of this inode are initialized. */
@@ -52,15 +51,14 @@ static int init_inode_xattrs(struct inode *inode)
 	 *    undefined right now (maybe use later with some new sb feature).
 	 */
 	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
-		erofs_err(inode->i_sb,
+		erofs_err(sb,
 			  "xattr_isize %d of nid %llu is not supported yet",
 			  vi->xattr_isize, vi->nid);
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
 		if (vi->xattr_isize) {
-			erofs_err(inode->i_sb,
-				  "bogus xattr ibody @ nid %llu", vi->nid);
+			erofs_err(sb, "bogus xattr ibody @ nid %llu", vi->nid);
 			DBG_BUGON(1);
 			ret = -EFSCORRUPTED;
 			goto out_unlock;	/* xattr ondisk layout error */
@@ -69,11 +67,9 @@ static int init_inode_xattrs(struct inode *inode)
 		goto out_unlock;
 	}
 
-	sb = inode->i_sb;
-	sbi = EROFS_SB(sb);
 	it.buf = __EROFS_BUF_INITIALIZER;
-	it.blkaddr = erofs_blknr(iloc(sbi, vi->nid) + vi->inode_isize);
-	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
+	it.blkaddr = erofs_blknr(erofs_iloc(inode) + vi->inode_isize);
+	it.ofs = erofs_blkoff(erofs_iloc(inode) + vi->inode_isize);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
 	it.kaddr = erofs_read_metabuf(&it.buf, sb, it.blkaddr, EROFS_KMAP);
@@ -159,7 +155,6 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 				   struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
-	struct erofs_sb_info *const sbi = EROFS_SB(inode->i_sb);
 	unsigned int xattr_header_sz, inline_xattr_ofs;
 
 	xattr_header_sz = inlinexattr_header_size(inode);
@@ -170,9 +165,8 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 
 	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
 
-	it->blkaddr = erofs_blknr(iloc(sbi, vi->nid) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
-
+	it->blkaddr = erofs_blknr(erofs_iloc(inode) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(erofs_iloc(inode) + inline_xattr_ofs);
 	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
 				       EROFS_KMAP);
 	if (IS_ERR(it->kaddr))
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 98fb90b9af71..3aeffc762b2f 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -55,8 +55,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
-	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
-		    vi->xattr_isize, 8);
+	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
@@ -169,10 +168,9 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
 	const erofs_off_t pos =
-		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
-					       vi->xattr_isize) +
+		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(erofs_iloc(inode) +
+				vi->inode_isize + vi->xattr_isize) +
 		lcn * sizeof(struct z_erofs_vle_decompressed_index);
 	struct z_erofs_vle_decompressed_index *di;
 	unsigned int advise, type;
@@ -372,9 +370,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
-					vi->inode_isize + vi->xattr_isize, 8) +
-		sizeof(struct z_erofs_map_header);
+	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
+		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
-- 
2.30.2

