Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BFF99455A
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 12:27:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNBzK693fz2yVt
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 21:27:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728383243;
	cv=none; b=WlWR1yh5LiPLWW+03hsKAI2otT1/cWoD0JM/aTLeoUDcQwOBr0AKzsGPwip/2WwIY/laRoAg3fwxj0hF5SP7IhW+YUnR5mwra1174Qzr1KGYz9h704857Y42hikOUlbEH2m35he3+0AZZDZBo31DEJAYGZ88Y4I/I9l1z2wAN/DQg4IOPpyumHhh74FCTgGlYksFWxLydFrSrvjq2qtvP7NGodnOKgk4l7Tc0QinMgL5pUDnvKs0KWKcNxSaM1o05w3fywF0MEKUkPM25EdEG8yFYGyNZ47/jSHkRcldDMOY6lLR2uhGbW/AeS58kZDLCKYZ3SdiVjQxhk/g7todJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728383243; c=relaxed/relaxed;
	bh=tHnjCz2MJz0TXfzHxsDg4OOuDwJEXxHMHjpWgKZM0D4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=a4c7mAbzkpOYoFAjQmvtjD4QEhjEwyWb4bqSI9JR30TGhMUa7twO5uDkUjGLYdPqoA2i1pVj/IxrL0d+LdtsyoGL7xqULYYtrEg4F7GFeUPnEZ8cOyJMPiHFSxnMaQy51t01+pxsfcqCFRVThghPLzLpPIXK+nRWcWg6ZyHkLzqu2o68kNfeRRSkpnOtNHwumZxIAS3nsgIsr0dwdFUU2eyyEGmdVNJlboiSJN6+Y8kDNwdL+BaxRwgDtX5XPpWYvO5c/KkZsmQtrvT2WeFJFybKNjw9Y1+ZuSdNVrVRv5YsQ4IjTcsmCnkjj+GqL2IJWG2ux06sGcW3itBwWBtFsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b9jD4OS4; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b9jD4OS4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNBzG2Npmz2xxr
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 21:27:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 240DE5C5A8F;
	Tue,  8 Oct 2024 10:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B033C4CEC7;
	Tue,  8 Oct 2024 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383240;
	bh=MuD6NGoWbjsHBR/1uN1gmThxtPrfTwnHR3u+TzV6hNg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=b9jD4OS4wEZLEa9Q8sDyPyuvRxyeHQoHFwelcKXG7i0ocTqsV0EqeIuHcGaFP6hZi
	 pqPF/L70o24MXQFhNecS2IM6rd+RjJWyGeBN5T0U18ORpjhRUFZHKW82vP9NYpd7pU
	 KWomKD/gxGO+A6aykHbxiZNvq9WblMsfeUQ/rkXk=
Subject: Patch "erofs: avoid hardcoded blocksize for subpage block support" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,huyue2@coolpad.com,jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 12:27:16 +0200
In-Reply-To: <20241008065708.727659-3-hsiangkao@linux.alibaba.com>
Message-ID: <2024100814-aptitude-scoop-4274@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-2.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: stable-commits@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    erofs: avoid hardcoded blocksize for subpage block support

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-avoid-hardcoded-blocksize-for-subpage-block-support.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Oct  8 08:57:34 2024
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue,  8 Oct 2024 14:57:06 +0800
Subject: erofs: avoid hardcoded blocksize for subpage block support
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20241008065708.727659-3-hsiangkao@linux.alibaba.com>

From: Jingbo Xu <jefflexu@linux.alibaba.com>

commit 3acea5fc335420ba7ef53947cf2d98d07fac39f7 upstream.

As the first step of converting hardcoded blocksize to that specified in
on-disk superblock, convert all call sites of hardcoded blocksize to
sb->s_blocksize except for:

1) use sbi->blkszbits instead of sb->s_blocksize in
erofs_superblock_csum_verify() since sb->s_blocksize has not been
updated with the on-disk blocksize yet when the function is called.

2) use inode->i_blkbits instead of sb->s_blocksize in erofs_bread(),
since the inode operated on may be an anonymous inode in fscache mode.
Currently the anonymous inode is allocated from an anonymous mount
maintained in erofs, while in the near future we may allocate anonymous
inodes from a generic API directly and thus have no access to the
anonymous inode's i_sb.  Thus we keep the block size in i_blkbits for
anonymous inodes in fscache mode.

Be noted that this patch only gets rid of the hardcoded blocksize, in
preparation for actually setting the on-disk block size in the following
patch.  The hard limit of constraining the block size to PAGE_SIZE still
exists until the next patch.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230313135309.75269-2-jefflexu@linux.alibaba.com
[ Gao Xiang: fold a patch to fix incorrect truncated offsets. ]
Link: https://lore.kernel.org/r/20230413035734.15457-1-zhujia.zj@bytedance.com
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/data.c              |   50 +++++++++++++++++++++++--------------------
 fs/erofs/decompressor.c      |    6 ++---
 fs/erofs/decompressor_lzma.c |    4 +--
 fs/erofs/dir.c               |   22 ++++++++----------
 fs/erofs/fscache.c           |    7 +++---
 fs/erofs/inode.c             |   20 +++++++++--------
 fs/erofs/internal.h          |   20 ++++++-----------
 fs/erofs/namei.c             |   14 ++++++------
 fs/erofs/super.c             |   27 +++++++++++++----------
 fs/erofs/xattr.c             |   40 ++++++++++++++++------------------
 fs/erofs/xattr.h             |   10 ++++----
 fs/erofs/zdata.c             |   16 +++++++------
 fs/erofs/zmap.c              |   29 ++++++++++++------------
 include/trace/events/erofs.h |    4 +--
 14 files changed, 137 insertions(+), 132 deletions(-)

--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -29,11 +29,15 @@ void erofs_put_metabuf(struct erofs_buf
 	buf->page = NULL;
 }
 
+/*
+ * Derive the block size from inode->i_blkbits to make compatible with
+ * anonymous inode in fscache mode.
+ */
 void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
+	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
 	struct address_space *const mapping = inode->i_mapping;
-	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
 	struct folio *folio;
@@ -84,33 +88,32 @@ static int erofs_map_blocks_flatmode(str
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
 	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
 	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
 
-	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+	nblocks = erofs_iblks(inode);
 	lastblk = nblocks - tailendpacking;
 
 	/* there is no hole in flatmode */
 	map->m_flags = EROFS_MAP_MAPPED;
-	if (offset < blknr_to_addr(lastblk)) {
-		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
-		map->m_plen = blknr_to_addr(lastblk) - offset;
+	if (offset < erofs_pos(sb, lastblk)) {
+		map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
+		map->m_plen = erofs_pos(sb, lastblk) - offset;
 	} else if (tailendpacking) {
 		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(offset);
+			vi->xattr_isize + erofs_blkoff(sb, offset);
 		map->m_plen = inode->i_size - offset;
 
 		/* inline data should be located in the same meta block */
-		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
-			erofs_err(inode->i_sb,
-				  "inline data cross block boundary @ nid %llu",
+		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
+			erofs_err(sb, "inline data cross block boundary @ nid %llu",
 				  vi->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
 		map->m_flags |= EROFS_MAP_META;
 	} else {
-		erofs_err(inode->i_sb,
-			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
+		erofs_err(sb, "internal error @ nid: %llu (size %llu), m_la 0x%llx",
 			  vi->nid, inode->i_size, map->m_la);
 		DBG_BUGON(1);
 		return -EIO;
@@ -154,29 +157,29 @@ int erofs_map_blocks(struct inode *inode
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(sb, pos), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out;
 	}
 	map->m_la = chunknr << vi->chunkbits;
 	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
-			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
+			round_up(inode->i_size - map->m_la, sb->s_blocksize));
 
 	/* handle block map */
 	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
-		__le32 *blkaddr = kaddr + erofs_blkoff(pos);
+		__le32 *blkaddr = kaddr + erofs_blkoff(sb, pos);
 
 		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
 			map->m_flags = 0;
 		} else {
-			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
+			map->m_pa = erofs_pos(sb, le32_to_cpu(*blkaddr));
 			map->m_flags = EROFS_MAP_MAPPED;
 		}
 		goto out_unlock;
 	}
 	/* parse chunk indexes */
-	idx = kaddr + erofs_blkoff(pos);
+	idx = kaddr + erofs_blkoff(sb, pos);
 	switch (le32_to_cpu(idx->blkaddr)) {
 	case EROFS_NULL_ADDR:
 		map->m_flags = 0;
@@ -184,7 +187,7 @@ int erofs_map_blocks(struct inode *inode
 	default:
 		map->m_deviceid = le16_to_cpu(idx->device_id) &
 			EROFS_SB(sb)->device_id_mask;
-		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
+		map->m_pa = erofs_pos(sb, le32_to_cpu(idx->blkaddr));
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
 	}
@@ -228,8 +231,8 @@ int erofs_map_dev(struct super_block *sb
 
 			if (!dif->mapped_blkaddr)
 				continue;
-			startoff = blknr_to_addr(dif->mapped_blkaddr);
-			length = blknr_to_addr(dif->blocks);
+			startoff = erofs_pos(sb, dif->mapped_blkaddr);
+			length = erofs_pos(sb, dif->blocks);
 
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
@@ -250,6 +253,7 @@ static int erofs_iomap_begin(struct inod
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	int ret;
+	struct super_block *sb = inode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
 
@@ -264,7 +268,7 @@ static int erofs_iomap_begin(struct inod
 		.m_deviceid = map.m_deviceid,
 		.m_pa = map.m_pa,
 	};
-	ret = erofs_map_dev(inode->i_sb, &mdev);
+	ret = erofs_map_dev(sb, &mdev);
 	if (ret)
 		return ret;
 
@@ -290,11 +294,11 @@ static int erofs_iomap_begin(struct inod
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 
 		iomap->type = IOMAP_INLINE;
-		ptr = erofs_read_metabuf(&buf, inode->i_sb,
-					 erofs_blknr(mdev.m_pa), EROFS_KMAP);
+		ptr = erofs_read_metabuf(&buf, sb,
+				erofs_blknr(sb, mdev.m_pa), EROFS_KMAP);
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
-		iomap->inline_data = ptr + erofs_blkoff(mdev.m_pa);
+		iomap->inline_data = ptr + erofs_blkoff(sb, mdev.m_pa);
 		iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -42,7 +42,7 @@ static int z_erofs_load_lz4_config(struc
 		if (!sbi->lz4.max_pclusterblks) {
 			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
 		} else if (sbi->lz4.max_pclusterblks >
-			   Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
+			   erofs_blknr(sb, Z_EROFS_PCLUSTER_MAX_SIZE)) {
 			erofs_err(sb, "too large lz4 pclusterblks %u",
 				  sbi->lz4.max_pclusterblks);
 			return -EINVAL;
@@ -221,13 +221,13 @@ static int z_erofs_lz4_decompress_mem(st
 		support_0padding = true;
 		ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
 				min_t(unsigned int, rq->inputsize,
-				      EROFS_BLKSIZ - rq->pageofs_in));
+				      rq->sb->s_blocksize - rq->pageofs_in));
 		if (ret) {
 			kunmap_local(headpage);
 			return ret;
 		}
 		may_inplace = !((rq->pageofs_in + rq->inputsize) &
-				(EROFS_BLKSIZ - 1));
+				(rq->sb->s_blocksize - 1));
 	}
 
 	inputmargin = rq->pageofs_in;
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -166,8 +166,8 @@ int z_erofs_lzma_decompress(struct z_ero
 	/* 1. get the exact LZMA compressed size */
 	kin = kmap(*rq->in);
 	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
-				   min_t(unsigned int, rq->inputsize,
-					 EROFS_BLKSIZ - rq->pageofs_in));
+			min_t(unsigned int, rq->inputsize,
+			      rq->sb->s_blocksize - rq->pageofs_in));
 	if (err) {
 		kunmap(*rq->in);
 		return err;
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -67,9 +67,11 @@ static int erofs_readdir(struct file *f,
 {
 	struct inode *dir = file_inode(f);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	struct super_block *sb = dir->i_sb;
+	unsigned long bsz = sb->s_blocksize;
 	const size_t dirsize = i_size_read(dir);
-	unsigned int i = ctx->pos / EROFS_BLKSIZ;
-	unsigned int ofs = ctx->pos % EROFS_BLKSIZ;
+	unsigned int i = erofs_blknr(sb, ctx->pos);
+	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
 	int err = 0;
 	bool initial = true;
 
@@ -79,32 +81,28 @@ static int erofs_readdir(struct file *f,
 
 		de = erofs_bread(&buf, dir, i, EROFS_KMAP);
 		if (IS_ERR(de)) {
-			erofs_err(dir->i_sb,
-				  "fail to readdir of logical block %u of nid %llu",
+			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
 				  i, EROFS_I(dir)->nid);
 			err = PTR_ERR(de);
 			break;
 		}
 
 		nameoff = le16_to_cpu(de->nameoff);
-		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= EROFS_BLKSIZ) {
-			erofs_err(dir->i_sb,
-				  "invalid de[0].nameoff %u @ nid %llu",
+		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {
+			erofs_err(sb, "invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, EROFS_I(dir)->nid);
 			err = -EFSCORRUPTED;
 			break;
 		}
 
-		maxsize = min_t(unsigned int,
-				dirsize - ctx->pos + ofs, EROFS_BLKSIZ);
+		maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
 
 		/* search dirents at the arbitrary position */
 		if (initial) {
 			initial = false;
 
 			ofs = roundup(ofs, sizeof(struct erofs_dirent));
-			ctx->pos = blknr_to_addr(i) + ofs;
+			ctx->pos = erofs_pos(sb, i) + ofs;
 			if (ofs >= nameoff)
 				goto skip_this;
 		}
@@ -114,7 +112,7 @@ static int erofs_readdir(struct file *f,
 		if (err)
 			break;
 skip_this:
-		ctx->pos = blknr_to_addr(i) + maxsize;
+		ctx->pos = erofs_pos(sb, i) + maxsize;
 		++i;
 		ofs = 0;
 	}
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -282,8 +282,8 @@ static int erofs_fscache_data_read(struc
 		void *src;
 
 		/* For tail packing layout, the offset may be non-zero. */
-		offset = erofs_blkoff(map.m_pa);
-		blknr = erofs_blknr(map.m_pa);
+		offset = erofs_blkoff(sb, map.m_pa);
+		blknr = erofs_blknr(sb, map.m_pa);
 		size = map.m_llen;
 
 		src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
@@ -333,7 +333,7 @@ static int erofs_fscache_read_folio(stru
 	bool unlock;
 	int ret;
 
-	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
+	DBG_BUGON(folio_size(folio) != PAGE_SIZE);
 
 	ret = erofs_fscache_data_read(folio_mapping(folio), folio_pos(folio),
 				      folio_size(folio), &unlock);
@@ -529,6 +529,7 @@ struct erofs_fscache *erofs_fscache_acqu
 		set_nlink(inode, 1);
 		inode->i_size = OFFSET_MAX;
 		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
+		inode->i_blkbits = EROFS_SB(sb)->blkszbits;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
 		ctx->inode = inode;
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -23,8 +23,8 @@ static void *erofs_read_inode(struct ero
 	unsigned int ifmt;
 	int err;
 
-	blkaddr = erofs_blknr(inode_loc);
-	*ofs = erofs_blkoff(inode_loc);
+	blkaddr = erofs_blknr(sb, inode_loc);
+	*ofs = erofs_blkoff(sb, inode_loc);
 
 	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
 		  __func__, vi->nid, *ofs, blkaddr);
@@ -58,11 +58,11 @@ static void *erofs_read_inode(struct ero
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 		/* check if the extended inode acrosses block boundary */
-		if (*ofs + vi->inode_isize <= EROFS_BLKSIZ) {
+		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
 			*ofs += vi->inode_isize;
 			die = (struct erofs_inode_extended *)dic;
 		} else {
-			const unsigned int gotten = EROFS_BLKSIZ - *ofs;
+			const unsigned int gotten = sb->s_blocksize - *ofs;
 
 			copied = kmalloc(vi->inode_isize, GFP_NOFS);
 			if (!copied) {
@@ -176,7 +176,7 @@ static void *erofs_read_inode(struct ero
 			err = -EOPNOTSUPP;
 			goto err_out;
 		}
-		vi->chunkbits = LOG_BLOCK_SIZE +
+		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
 	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
@@ -189,11 +189,12 @@ static void *erofs_read_inode(struct ero
 	    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
 	     vi->datalayout == EROFS_INODE_CHUNK_BASED))
 		inode->i_flags |= S_DAX;
+
 	if (!nblks)
 		/* measure inode.i_blocks as generic filesystems */
-		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
+		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 	else
-		inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
+		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
 	return kaddr;
 
 bogusimode:
@@ -211,11 +212,12 @@ static int erofs_fill_symlink(struct ino
 			      unsigned int m_pofs)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
+	unsigned int bsz = i_blocksize(inode);
 	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= EROFS_BLKSIZ || inode->i_size < 0) {
+	    inode->i_size >= bsz || inode->i_size < 0) {
 		inode->i_op = &erofs_symlink_iops;
 		return 0;
 	}
@@ -226,7 +228,7 @@ static int erofs_fill_symlink(struct ino
 
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > EROFS_BLKSIZ) {
+	if (m_pofs + inode->i_size > bsz) {
 		kfree(lnk);
 		erofs_err(inode->i_sb,
 			  "inline data cross block boundary @ nid %llu",
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -145,8 +145,8 @@ struct erofs_sb_info {
 #endif
 	u16 device_id_mask;	/* valid bits of device id to be used */
 
-	/* inode slot unit size in bit shift */
-	unsigned char islotbits;
+	unsigned char islotbits;	/* inode slot unit size in bit shift */
+	unsigned char blkszbits;
 
 	u32 sb_size;			/* total superblock size */
 	u32 build_time_nsec;
@@ -241,13 +241,6 @@ static inline int erofs_wait_on_workgrou
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
 #define LOG_BLOCK_SIZE		PAGE_SHIFT
-
-#undef LOG_SECTORS_PER_BLOCK
-#define LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9)
-
-#undef SECTORS_PER_BLOCK
-#define SECTORS_PER_BLOCK	(1 << SECTORS_PER_BLOCK)
-
 #define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
 
 #if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
@@ -269,9 +262,10 @@ struct erofs_buf {
 
 #define ROOT_NID(sb)		((sb)->root_nid)
 
-#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
-#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
-#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
+#define erofs_blknr(sb, addr)	((addr) >> (sb)->s_blocksize_bits)
+#define erofs_blkoff(sb, addr)	((addr) & ((sb)->s_blocksize - 1))
+#define erofs_pos(sb, blk)	((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
+#define erofs_iblks(i)	(round_up((i)->i_size, i_blocksize(i)) >> (i)->i_blkbits)
 
 #define EROFS_FEATURE_FUNCS(name, compat, feature) \
 static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
@@ -343,7 +337,7 @@ static inline erofs_off_t erofs_iloc(str
 {
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 
-	return blknr_to_addr(sbi->meta_blkaddr) +
+	return erofs_pos(inode->i_sb, sbi->meta_blkaddr) +
 		(EROFS_I(inode)->nid << sbi->islotbits);
 }
 
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -89,7 +89,8 @@ static struct erofs_dirent *find_target_
 static void *erofs_find_target_block(struct erofs_buf *target,
 		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
 {
-	int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
+	unsigned int bsz = i_blocksize(dir);
+	int head = 0, back = erofs_iblks(dir) - 1;
 	unsigned int startprfx = 0, endprfx = 0;
 	void *candidate = ERR_PTR(-ENOENT);
 
@@ -100,8 +101,7 @@ static void *erofs_find_target_block(str
 
 		de = erofs_bread(&buf, dir, mid, EROFS_KMAP);
 		if (!IS_ERR(de)) {
-			const int nameoff = nameoff_from_disk(de->nameoff,
-							      EROFS_BLKSIZ);
+			const int nameoff = nameoff_from_disk(de->nameoff, bsz);
 			const int ndirents = nameoff / sizeof(*de);
 			int diff;
 			unsigned int matched;
@@ -121,11 +121,10 @@ static void *erofs_find_target_block(str
 
 			dname.name = (u8 *)de + nameoff;
 			if (ndirents == 1)
-				dname.end = (u8 *)de + EROFS_BLKSIZ;
+				dname.end = (u8 *)de + bsz;
 			else
 				dname.end = (u8 *)de +
-					nameoff_from_disk(de[1].nameoff,
-							  EROFS_BLKSIZ);
+					nameoff_from_disk(de[1].nameoff, bsz);
 
 			/* string comparison without already matched prefix */
 			diff = erofs_dirnamecmp(name, &dname, &matched);
@@ -178,7 +177,8 @@ int erofs_namei(struct inode *dir, const
 		return PTR_ERR(de);
 
 	if (ndirents)
-		de = find_target_dirent(&qn, (u8 *)de, EROFS_BLKSIZ, ndirents);
+		de = find_target_dirent(&qn, (u8 *)de, i_blocksize(dir),
+					ndirents);
 
 	if (!IS_ERR(de)) {
 		*nid = le64_to_cpu(de->nid);
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -53,18 +53,21 @@ void _erofs_info(struct super_block *sb,
 
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
+	size_t len = 1 << EROFS_SB(sb)->blkszbits;
 	struct erofs_super_block *dsb;
 	u32 expected_crc, crc;
 
-	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
-		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
+	if (len > EROFS_SUPER_OFFSET)
+		len -= EROFS_SUPER_OFFSET;
+
+	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET, len, GFP_KERNEL);
 	if (!dsb)
 		return -ENOMEM;
 
 	expected_crc = le32_to_cpu(dsb->checksum);
 	dsb->checksum = 0;
 	/* to allow for x86 boot sectors and other oddities. */
-	crc = crc32c(~0, dsb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
+	crc = crc32c(~0, dsb, len);
 	kfree(dsb);
 
 	if (crc != expected_crc) {
@@ -133,11 +136,11 @@ void *erofs_read_metadata(struct super_b
 	int len, i, cnt;
 
 	*offset = round_up(*offset, 4);
-	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset), EROFS_KMAP);
+	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *offset), EROFS_KMAP);
 	if (IS_ERR(ptr))
 		return ptr;
 
-	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
+	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(sb, *offset)]);
 	if (!len)
 		len = U16_MAX + 1;
 	buffer = kmalloc(len, GFP_KERNEL);
@@ -147,14 +150,15 @@ void *erofs_read_metadata(struct super_b
 	*lengthp = len;
 
 	for (i = 0; i < len; i += cnt) {
-		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
-		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
+		cnt = min_t(int, sb->s_blocksize - erofs_blkoff(sb, *offset),
+			    len - i);
+		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *offset),
 					 EROFS_KMAP);
 		if (IS_ERR(ptr)) {
 			kfree(buffer);
 			return ptr;
 		}
-		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
+		memcpy(buffer + i, ptr + erofs_blkoff(sb, *offset), cnt);
 		*offset += cnt;
 	}
 	return buffer;
@@ -180,10 +184,10 @@ static int erofs_init_device(struct erof
 	struct block_device *bdev;
 	void *ptr;
 
-	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
+	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
-	dis = ptr + erofs_blkoff(*pos);
+	dis = ptr + erofs_blkoff(sb, *pos);
 
 	if (!dif->path) {
 		if (!dis->tag[0]) {
@@ -672,6 +676,7 @@ static int erofs_fc_fill_super(struct su
 	sbi->domain_id = ctx->domain_id;
 	ctx->domain_id = NULL;
 
+	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
 		sb->s_blocksize = EROFS_BLKSIZ;
 		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
@@ -1007,7 +1012,7 @@ static int erofs_statfs(struct dentry *d
 		id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = EROFS_BLKSIZ;
+	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = sbi->total_blocks;
 	buf->f_bfree = buf->f_bavail = 0;
 
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -68,8 +68,8 @@ static int init_inode_xattrs(struct inod
 	}
 
 	it.buf = __EROFS_BUF_INITIALIZER;
-	it.blkaddr = erofs_blknr(erofs_iloc(inode) + vi->inode_isize);
-	it.ofs = erofs_blkoff(erofs_iloc(inode) + vi->inode_isize);
+	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
+	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
 	it.kaddr = erofs_read_metabuf(&it.buf, sb, it.blkaddr, EROFS_KMAP);
@@ -92,9 +92,9 @@ static int init_inode_xattrs(struct inod
 	it.ofs += sizeof(struct erofs_xattr_ibody_header);
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
-		if (it.ofs >= EROFS_BLKSIZ) {
+		if (it.ofs >= sb->s_blocksize) {
 			/* cannot be unaligned */
-			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
+			DBG_BUGON(it.ofs != sb->s_blocksize);
 
 			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
 						      EROFS_KMAP);
@@ -139,15 +139,15 @@ struct xattr_iter_handlers {
 
 static inline int xattr_iter_fixup(struct xattr_iter *it)
 {
-	if (it->ofs < EROFS_BLKSIZ)
+	if (it->ofs < it->sb->s_blocksize)
 		return 0;
 
-	it->blkaddr += erofs_blknr(it->ofs);
+	it->blkaddr += erofs_blknr(it->sb, it->ofs);
 	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
 				       EROFS_KMAP_ATOMIC);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
-	it->ofs = erofs_blkoff(it->ofs);
+	it->ofs = erofs_blkoff(it->sb, it->ofs);
 	return 0;
 }
 
@@ -165,8 +165,8 @@ static int inline_xattr_iter_begin(struc
 
 	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
 
-	it->blkaddr = erofs_blknr(erofs_iloc(inode) + inline_xattr_ofs);
-	it->ofs = erofs_blkoff(erofs_iloc(inode) + inline_xattr_ofs);
+	it->blkaddr = erofs_blknr(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
 	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
 				       EROFS_KMAP_ATOMIC);
 	if (IS_ERR(it->kaddr))
@@ -222,8 +222,8 @@ static int xattr_foreach(struct xattr_it
 	processed = 0;
 
 	while (processed < entry.e_name_len) {
-		if (it->ofs >= EROFS_BLKSIZ) {
-			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
+		if (it->ofs >= it->sb->s_blocksize) {
+			DBG_BUGON(it->ofs > it->sb->s_blocksize);
 
 			err = xattr_iter_fixup(it);
 			if (err)
@@ -231,7 +231,7 @@ static int xattr_foreach(struct xattr_it
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
+		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      entry.e_name_len - processed);
 
 		/* handle name */
@@ -257,8 +257,8 @@ static int xattr_foreach(struct xattr_it
 	}
 
 	while (processed < value_sz) {
-		if (it->ofs >= EROFS_BLKSIZ) {
-			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
+		if (it->ofs >= it->sb->s_blocksize) {
+			DBG_BUGON(it->ofs > it->sb->s_blocksize);
 
 			err = xattr_iter_fixup(it);
 			if (err)
@@ -266,7 +266,7 @@ static int xattr_foreach(struct xattr_it
 			it->ofs = 0;
 		}
 
-		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
+		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
 			      value_sz - processed);
 		op->value(it, processed, it->kaddr + it->ofs, slice);
 		it->ofs += slice;
@@ -352,15 +352,14 @@ static int shared_getxattr(struct inode
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	unsigned int i;
 	int ret = -ENOATTR;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		erofs_blk_t blkaddr =
-			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
+			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
 
-		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
+		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
 		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
 						  EROFS_KMAP_ATOMIC);
 		if (IS_ERR(it->it.kaddr))
@@ -564,15 +563,14 @@ static int shared_listxattr(struct listx
 	struct inode *const inode = d_inode(it->dentry);
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	unsigned int i;
 	int ret = 0;
 
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		erofs_blk_t blkaddr =
-			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
+			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
 
-		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
+		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
 		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
 						  EROFS_KMAP_ATOMIC);
 		if (IS_ERR(it->it.kaddr))
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -19,21 +19,21 @@ static inline unsigned int inlinexattr_h
 		sizeof(u32) * EROFS_I(inode)->xattr_shared_count;
 }
 
-static inline erofs_blk_t xattrblock_addr(struct erofs_sb_info *sbi,
+static inline erofs_blk_t xattrblock_addr(struct super_block *sb,
 					  unsigned int xattr_id)
 {
 #ifdef CONFIG_EROFS_FS_XATTR
-	return sbi->xattr_blkaddr +
-		xattr_id * sizeof(__u32) / EROFS_BLKSIZ;
+	return EROFS_SB(sb)->xattr_blkaddr +
+		xattr_id * sizeof(__u32) / sb->s_blocksize;
 #else
 	return 0;
 #endif
 }
 
-static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
+static inline unsigned int xattrblock_offset(struct super_block *sb,
 					     unsigned int xattr_id)
 {
-	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
+	return (xattr_id * sizeof(__u32)) % sb->s_blocksize;
 }
 
 #ifdef CONFIG_EROFS_FS_XATTR
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -766,6 +766,7 @@ static int z_erofs_read_fragment(struct
 				 struct page *page, unsigned int pageofs,
 				 unsigned int len)
 {
+	struct super_block *sb = inode->i_sb;
 	struct inode *packed_inode = EROFS_I_SB(inode)->packed_inode;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	u8 *src, *dst;
@@ -777,16 +778,16 @@ static int z_erofs_read_fragment(struct
 	pos += EROFS_I(inode)->z_fragmentoff;
 	for (i = 0; i < len; i += cnt) {
 		cnt = min_t(unsigned int, len - i,
-			    EROFS_BLKSIZ - erofs_blkoff(pos));
+			    sb->s_blocksize - erofs_blkoff(sb, pos));
 		src = erofs_bread(&buf, packed_inode,
-				  erofs_blknr(pos), EROFS_KMAP);
+				  erofs_blknr(sb, pos), EROFS_KMAP);
 		if (IS_ERR(src)) {
 			erofs_put_metabuf(&buf);
 			return PTR_ERR(src);
 		}
 
 		dst = kmap_local_page(page);
-		memcpy(dst + pageofs + i, src + erofs_blkoff(pos), cnt);
+		memcpy(dst + pageofs + i, src + erofs_blkoff(sb, pos), cnt);
 		kunmap_local(dst);
 		pos += cnt;
 	}
@@ -841,7 +842,8 @@ repeat:
 		void *mp;
 
 		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
-					erofs_blknr(map->m_pa), EROFS_NO_KMAP);
+					erofs_blknr(inode->i_sb, map->m_pa),
+					EROFS_NO_KMAP);
 		if (IS_ERR(mp)) {
 			err = PTR_ERR(mp);
 			erofs_err(inode->i_sb,
@@ -1526,11 +1528,11 @@ static void z_erofs_submit_queue(struct
 
 		/* no device id here, thus it will always succeed */
 		mdev = (struct erofs_map_dev) {
-			.m_pa = blknr_to_addr(pcl->obj.index),
+			.m_pa = erofs_pos(sb, pcl->obj.index),
 		};
 		(void)erofs_map_dev(sb, &mdev);
 
-		cur = erofs_blknr(mdev.m_pa);
+		cur = erofs_blknr(sb, mdev.m_pa);
 		end = cur + pcl->pclusterpages;
 
 		do {
@@ -1564,7 +1566,7 @@ submit_bio_retry:
 
 				last_bdev = mdev.m_bdev;
 				bio->bi_iter.bi_sector = (sector_t)cur <<
-					LOG_SECTORS_PER_BLOCK;
+					(sb->s_blocksize_bits - 9);
 				bio->bi_private = q[JQ_SUBMIT];
 				if (f->readahead)
 					bio->bi_opf |= REQ_RAHEAD;
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -18,7 +18,7 @@ int z_erofs_fill_inode(struct inode *ino
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_logical_clusterbits = inode->i_sb->s_blocksize_bits;
 		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	}
 	inode->i_mapping->a_ops = &z_erofs_aops;
@@ -53,13 +53,13 @@ static int legacy_load_cluster_from_disk
 	unsigned int advise, type;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
+				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP_ATOMIC);
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 
 	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
 	m->lcn = lcn;
-	di = m->kaddr + erofs_blkoff(pos);
+	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
 
 	advise = le16_to_cpu(di->di_advise);
 	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
@@ -160,7 +160,7 @@ static int unpack_compacted_index(struct
 			 (vcnt << amortizedshift);
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
-	eofs = erofs_blkoff(pos);
+	eofs = erofs_blkoff(m->inode->i_sb, pos);
 	base = round_down(eofs, vcnt << amortizedshift);
 	in = m->kaddr + base;
 
@@ -252,7 +252,7 @@ static int compacted_load_cluster_from_d
 	struct erofs_inode *const vi = EROFS_I(inode);
 	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
 		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+	unsigned int totalidx = erofs_iblks(inode);
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
 	erofs_off_t pos;
@@ -290,7 +290,7 @@ static int compacted_load_cluster_from_d
 out:
 	pos += lcn * (1 << amortizedshift);
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
+				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP_ATOMIC);
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
@@ -360,6 +360,7 @@ static int z_erofs_extent_lookback(struc
 static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 					    unsigned int initial_lcn)
 {
+	struct super_block *sb = m->inode->i_sb;
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	struct erofs_map_blocks *const map = m->map;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
@@ -406,7 +407,7 @@ static int z_erofs_get_extent_compressed
 		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
 		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
 		 */
-		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
+		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (m->delta[0] != 1)
@@ -422,7 +423,7 @@ static int z_erofs_get_extent_compressed
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = (u64)m->compressedblks << LOG_BLOCK_SIZE;
+	map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err(m->inode->i_sb,
@@ -565,7 +566,7 @@ static int z_erofs_do_map_blocks(struct
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
 	} else {
-		map->m_pa = blknr_to_addr(m.pblk);
+		map->m_pa = erofs_pos(inode->i_sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
 		if (err)
 			goto unmap_out;
@@ -595,7 +596,7 @@ static int z_erofs_do_map_blocks(struct
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
 	     map->m_algorithmformat == Z_EROFS_COMPRESSION_LZMA &&
-	     map->m_llen >= EROFS_BLKSIZ)) {
+	     map->m_llen >= i_blocksize(inode))) {
 		err = z_erofs_get_extent_decompressedlen(&m);
 		if (!err)
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
@@ -636,13 +637,13 @@ static int z_erofs_fill_inode_lazy(struc
 		goto out_unlock;
 
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(sb, pos), EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		err = PTR_ERR(kaddr);
 		goto out_unlock;
 	}
 
-	h = kaddr + erofs_blkoff(pos);
+	h = kaddr + erofs_blkoff(sb, pos);
 	/*
 	 * if the highest bit of the 8-byte map header is set, the whole file
 	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
@@ -666,7 +667,7 @@ static int z_erofs_fill_inode_lazy(struc
 		goto out_put_metabuf;
 	}
 
-	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	vi->z_logical_clusterbits = sb->s_blocksize_bits + (h->h_clusterbits & 7);
 	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
 	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
 			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
@@ -695,7 +696,7 @@ static int z_erofs_fill_inode_lazy(struc
 		erofs_put_metabuf(&map.buf);
 
 		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
+		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
 			erofs_err(sb, "invalid tail-packing pclustersize %llu",
 				  map.m_plen);
 			err = -EFSCORRUPTED;
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -66,8 +66,8 @@ TRACE_EVENT(erofs_fill_inode,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->nid		= EROFS_I(inode)->nid;
-		__entry->blkaddr	= erofs_blknr(erofs_iloc(inode));
-		__entry->ofs		= erofs_blkoff(erofs_iloc(inode));
+		__entry->blkaddr	= erofs_blknr(inode->i_sb, erofs_iloc(inode));
+		__entry->ofs		= erofs_blkoff(inode->i_sb, erofs_iloc(inode));
 	),
 
 	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u",


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-set-block-size-to-the-on-disk-block-size.patch
queue-6.1/erofs-avoid-hardcoded-blocksize-for-subpage-block-support.patch
queue-6.1/erofs-fix-incorrect-symlink-detection-in-fast-symlink.patch
queue-6.1/erofs-get-rid-of-z_erofs_do_map_blocks-forward-declaration.patch
queue-6.1/erofs-get-rid-of-erofs_inode_datablocks.patch
