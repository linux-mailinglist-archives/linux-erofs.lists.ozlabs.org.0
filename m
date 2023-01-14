Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4103466AC03
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 16:08:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NvMBH0vd3z3cdQ
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Jan 2023 02:08:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s+PLrJlp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s+PLrJlp;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NvMB73pPPz3c7x
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Jan 2023 02:08:47 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0F12EB80922;
	Sat, 14 Jan 2023 15:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD6DC433EF;
	Sat, 14 Jan 2023 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673708921;
	bh=5Auz8Wbp11PiCheP7gUTI6cSUz4rehq5bER29K3Mt9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+PLrJlp8S9QLNR6L5FOxySfru/TuhNMcbGasPoZZvGYMFAhJHqVuRzmxt/T0rndJ
	 d9G2hyXdpmJ9cIW5SM1EEYrp33kPUD7WSegmwuqSoOeRNw1X8u5+SNlzQLtPyHf1u5
	 qM6o4lxPsKl/ArYwFPHNk8UOmO+V6XPxFXTzEcOVF5OTUYPtrxmaA/ggo6MrUtGaEJ
	 KXgZv+Y4NZrPJ2BrqB2mOaTSH+TvwJSYp+YInE9PO/iUtD6CINT+PBwyEgkVJ4sIM6
	 Jzyg0pJtDRiS3IuVPT5wu5MniW6wS5gGsTqyC7W6QBrGILnO1TzDc3ZuRxiEobxyNK
	 md7dS2mq/wHPA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs: simplify iloc()
Date: Sat, 14 Jan 2023 23:08:23 +0800
Message-Id: <20230114150823.432069-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230114125746.399253-2-xiang@kernel.org>
References: <20230114125746.399253-2-xiang@kernel.org>
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
changes since v1:
 - fix compile errors reported by intel lkp.

 fs/erofs/data.c              |  9 +++------
 fs/erofs/inode.c             |  2 +-
 fs/erofs/internal.h          | 16 +++++++++-------
 fs/erofs/xattr.c             | 20 +++++++-------------
 fs/erofs/zmap.c              | 13 +++++--------
 include/trace/events/erofs.h |  4 ++--
 6 files changed, 27 insertions(+), 37 deletions(-)

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
index b4cc40fa3803..08ba817d6551 100644
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
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+
+	return blknr_to_addr(sbi->meta_blkaddr) +
+		(EROFS_I(inode)->nid << sbi->islotbits);
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
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 4f4c44ea3a65..e095d36db939 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -66,8 +66,8 @@ TRACE_EVENT(erofs_fill_inode,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->nid		= EROFS_I(inode)->nid;
-		__entry->blkaddr	= erofs_blknr(iloc(EROFS_I_SB(inode), __entry->nid));
-		__entry->ofs		= erofs_blkoff(iloc(EROFS_I_SB(inode), __entry->nid));
+		__entry->blkaddr	= erofs_blknr(erofs_iloc(inode));
+		__entry->ofs		= erofs_blkoff(erofs_iloc(inode));
 	),
 
 	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u",
-- 
2.30.2

