Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A256AB6C8
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 08:10:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVV8C2LVSz3cHm
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 18:10:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=B1jjcbwD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=B1jjcbwD;
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVV851B1rz3c71
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 18:09:56 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id i3so9237951plg.6
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Mar 2023 23:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678086592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/A1wenQxCrS4DX5Xa6HzGWUMXd/E4QqmKdMWg8NHmw=;
        b=B1jjcbwDxPPUuL+h3IIxy2mFzBsmy8ygEoje52hZc1XHYVMBXfeYZTeXBvdXKQnKvY
         M6Y7nMf/Bnzhsl2Lh98+3kE9Gh4WBXzQ0Vthh9R0Co9bKzJ6EWIEEPb0dplbHlCa6Lyu
         MX0jWkGcrEHfYrYQ2f12UiPR64gRbsBbhTA+fycatx6bxzV5GgjqsKzQHSfOJ5Tj69xp
         +JbmZD0oQIQ0j2gGyaYViSQBtrqX7IXXJCunVkcGxjuQm2rt9b8T4ZDMeRONepdfJZWW
         yUqVcBLq1qmycgk/8CgPubq/pnHezOuqvqlazhOLknGh3NaU43wF+H47WmZxv65G2c//
         p8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678086592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/A1wenQxCrS4DX5Xa6HzGWUMXd/E4QqmKdMWg8NHmw=;
        b=WNIBbxk7orpcZQdSzLOfDVNnqMIqcbEfUdxSbtgXRmOXCo3IFxIRYgxIfVPyb3+ecg
         yatG305Mqu3I+FQz6VhkQqf+Nu2pzXBzcE1vbeU9oIFMcPhD1QCm9uUQEjs5k6TdZ5Pt
         MI9jDoSC81BZxsc6lH6+nOYltcvNxvoZZpWjKC5FnGdQU8h7l32NRsAnWuoyucUWh4us
         7JT0aBzqx82tXgIzpug+Id1qfGvNKH5Zi21LIRop/gGoTFyJ15djNzIj8mjkPO9t4R26
         0yJW4WwJ9D/HPvcUGdO6FObM4/owhocWHjRmYy6hvG0a2slq8fYMG62ihTG5Ewt+Ij0P
         upqg==
X-Gm-Message-State: AO0yUKUoL4x2JChBe81cV8GsCoMOu/qcfqYIvXHebs6Tf1chmBQ/Sjb3
	v6Y/wX+k3bynfjB4db24hBY=
X-Google-Smtp-Source: AK7set+yAaDlyw9+GhQv9EXAGa2NQrQ9Zq4nA+W3Eaq/vNAk31QyQ3nmukg48l1szhR1Hp4hlDE1KQ==
X-Received: by 2002:a17:902:f7d4:b0:196:7bfb:f0d1 with SMTP id h20-20020a170902f7d400b001967bfbf0d1mr8626330plw.34.1678086592079;
        Sun, 05 Mar 2023 23:09:52 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b0019ac9c4f32esm5790693plk.309.2023.03.05.23.09.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Mar 2023 23:09:51 -0800 (PST)
Date: Mon, 6 Mar 2023 15:16:06 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 1/2] erofs: avoid hardcoded blocksize for subpage
 block support
Message-ID: <20230306151606.00000ebd.zbestahu@gmail.com>
In-Reply-To: <20230302143915.111739-2-jefflexu@linux.alibaba.com>
References: <20230302143915.111739-1-jefflexu@linux.alibaba.com>
	<20230302143915.111739-2-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu,  2 Mar 2023 22:39:14 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> As the first step of converting hardcoded blocksize to that specified in
> on-disk superblock, convert all call sites of hardcoded blocksize to
> sb->s_blocksize except for:
> 
> 1) use sbi->blkszbits instead of sb->s_blocksize in
> erofs_superblock_csum_verify() since sb->s_blocksize has not been
> updated with the on-disk blocksize yet when the function is called.
> 
> 2) use inode->i_blkbits instead of sb->s_blocksize in erofs_bread(),
> since the inode operated on may be an anonymous inode in fscache mode.
> Currently the anonymous inode is allocated from an anonymous mount
> maintained in erofs, while in the near future we may allocate anonymous
> inodes from a generic API directly and thus have no access to the
> anonymous inode's i_sb.  Thus we keep the block size in i_blkbits for
> anonymous inodes in fscache mode.
> 
> Be noted that this patch only gets rid of the hardcoded blocksize, in
> preparation for actually setting the on-disk block size in the following
> patch.  The hard limit of constraining the block size to PAGE_SIZE still
> exists until the next patch.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c              | 50 +++++++++++++++++++-----------------
>  fs/erofs/decompressor.c      |  6 ++---
>  fs/erofs/decompressor_lzma.c |  4 +--
>  fs/erofs/dir.c               | 22 ++++++++--------
>  fs/erofs/fscache.c           |  5 ++--
>  fs/erofs/inode.c             | 20 ++++++++-------
>  fs/erofs/internal.h          | 20 +++++----------
>  fs/erofs/namei.c             | 14 +++++-----
>  fs/erofs/super.c             | 24 +++++++++--------
>  fs/erofs/xattr.c             | 40 ++++++++++++++---------------
>  fs/erofs/xattr.h             | 10 ++++----
>  fs/erofs/zdata.c             | 18 +++++++------
>  fs/erofs/zmap.c              | 29 +++++++++++----------
>  include/trace/events/erofs.h |  4 +--
>  14 files changed, 134 insertions(+), 132 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 032e12dccb84..01a0a59feac9 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -27,11 +27,15 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>  	buf->page = NULL;
>  }
>  
> +/*
> + * Derive the block size from inode->i_blkbits to make compatible with
> + * anonymous inode in fscache mode.
> + */
>  void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>  		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
>  {
> +	erofs_off_t offset = blkaddr << inode->i_blkbits;
>  	struct address_space *const mapping = inode->i_mapping;
> -	erofs_off_t offset = blknr_to_addr(blkaddr);
>  	pgoff_t index = offset >> PAGE_SHIFT;
>  	struct page *page = buf->page;
>  	struct folio *folio;
> @@ -79,33 +83,32 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	erofs_blk_t nblocks, lastblk;
>  	u64 offset = map->m_la;
>  	struct erofs_inode *vi = EROFS_I(inode);
> +	struct super_block *sb = inode->i_sb;
>  	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
>  
> -	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> +	nblocks = erofs_iblks(inode);
>  	lastblk = nblocks - tailendpacking;
>  
>  	/* there is no hole in flatmode */
>  	map->m_flags = EROFS_MAP_MAPPED;
> -	if (offset < blknr_to_addr(lastblk)) {
> -		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
> -		map->m_plen = blknr_to_addr(lastblk) - offset;
> +	if (offset < erofs_pos(sb, lastblk)) {
> +		map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
> +		map->m_plen = erofs_pos(sb, lastblk) - offset;
>  	} else if (tailendpacking) {
>  		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
> -			vi->xattr_isize + erofs_blkoff(offset);
> +			vi->xattr_isize + erofs_blkoff(sb, offset);
>  		map->m_plen = inode->i_size - offset;
>  
>  		/* inline data should be located in the same meta block */
> -		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
> -			erofs_err(inode->i_sb,
> -				  "inline data cross block boundary @ nid %llu",
> +		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
> +			erofs_err(sb, "inline data cross block boundary @ nid %llu",
>  				  vi->nid);
>  			DBG_BUGON(1);
>  			return -EFSCORRUPTED;
>  		}
>  		map->m_flags |= EROFS_MAP_META;
>  	} else {
> -		erofs_err(inode->i_sb,
> -			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
> +		erofs_err(sb, "internal error @ nid: %llu (size %llu), m_la 0x%llx",
>  			  vi->nid, inode->i_size, map->m_la);
>  		DBG_BUGON(1);
>  		return -EIO;
> @@ -148,29 +151,29 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>  	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
>  		    vi->xattr_isize, unit) + unit * chunknr;
>  
> -	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(sb, pos), EROFS_KMAP);
>  	if (IS_ERR(kaddr)) {
>  		err = PTR_ERR(kaddr);
>  		goto out;
>  	}
>  	map->m_la = chunknr << vi->chunkbits;
>  	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
> -			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
> +			round_up(inode->i_size - map->m_la, sb->s_blocksize));
>  
>  	/* handle block map */
>  	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
> -		__le32 *blkaddr = kaddr + erofs_blkoff(pos);
> +		__le32 *blkaddr = kaddr + erofs_blkoff(sb, pos);
>  
>  		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
>  			map->m_flags = 0;
>  		} else {
> -			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
> +			map->m_pa = erofs_pos(sb, le32_to_cpu(*blkaddr));
>  			map->m_flags = EROFS_MAP_MAPPED;
>  		}
>  		goto out_unlock;
>  	}
>  	/* parse chunk indexes */
> -	idx = kaddr + erofs_blkoff(pos);
> +	idx = kaddr + erofs_blkoff(sb, pos);
>  	switch (le32_to_cpu(idx->blkaddr)) {
>  	case EROFS_NULL_ADDR:
>  		map->m_flags = 0;
> @@ -178,7 +181,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>  	default:
>  		map->m_deviceid = le16_to_cpu(idx->device_id) &
>  			EROFS_SB(sb)->device_id_mask;
> -		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
> +		map->m_pa = erofs_pos(sb, le32_to_cpu(idx->blkaddr));
>  		map->m_flags = EROFS_MAP_MAPPED;
>  		break;
>  	}
> @@ -222,8 +225,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  
>  			if (!dif->mapped_blkaddr)
>  				continue;
> -			startoff = blknr_to_addr(dif->mapped_blkaddr);
> -			length = blknr_to_addr(dif->blocks);
> +			startoff = erofs_pos(sb, dif->mapped_blkaddr);
> +			length = erofs_pos(sb, dif->blocks);
>  
>  			if (map->m_pa >= startoff &&
>  			    map->m_pa < startoff + length) {
> @@ -244,6 +247,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	int ret;
> +	struct super_block *sb = inode->i_sb;
>  	struct erofs_map_blocks map;
>  	struct erofs_map_dev mdev;
>  
> @@ -258,7 +262,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		.m_deviceid = map.m_deviceid,
>  		.m_pa = map.m_pa,
>  	};
> -	ret = erofs_map_dev(inode->i_sb, &mdev);
> +	ret = erofs_map_dev(sb, &mdev);
>  	if (ret)
>  		return ret;
>  
> @@ -284,11 +288,11 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  
>  		iomap->type = IOMAP_INLINE;
> -		ptr = erofs_read_metabuf(&buf, inode->i_sb,
> -					 erofs_blknr(mdev.m_pa), EROFS_KMAP);
> +		ptr = erofs_read_metabuf(&buf, sb,
> +				erofs_blknr(sb, mdev.m_pa), EROFS_KMAP);
>  		if (IS_ERR(ptr))
>  			return PTR_ERR(ptr);
> -		iomap->inline_data = ptr + erofs_blkoff(mdev.m_pa);
> +		iomap->inline_data = ptr + erofs_blkoff(sb, mdev.m_pa);
>  		iomap->private = buf.base;
>  	} else {
>  		iomap->type = IOMAP_MAPPED;
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 51b7ac7166d9..21fc6897d225 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -42,7 +42,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>  		if (!sbi->lz4.max_pclusterblks) {
>  			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
>  		} else if (sbi->lz4.max_pclusterblks >
> -			   Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
> +			   Z_EROFS_PCLUSTER_MAX_SIZE >> sb->s_blocksize_bits) {

erofs_blknr(sb, Z_EROFS_PCLUSTER_MAX_SIZE)?

>  			erofs_err(sb, "too large lz4 pclusterblks %u",
>  				  sbi->lz4.max_pclusterblks);
>  			return -EINVAL;
> @@ -221,13 +221,13 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
>  		support_0padding = true;
>  		ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
>  				min_t(unsigned int, rq->inputsize,
> -				      EROFS_BLKSIZ - rq->pageofs_in));
> +				      rq->sb->s_blocksize - rq->pageofs_in));
>  		if (ret) {
>  			kunmap_atomic(headpage);
>  			return ret;
>  		}
>  		may_inplace = !((rq->pageofs_in + rq->inputsize) &
> -				(EROFS_BLKSIZ - 1));
> +				(rq->sb->s_blocksize - 1));
>  	}
>  
>  	inputmargin = rq->pageofs_in;
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 091fd5adf818..d44c377c5b69 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -166,8 +166,8 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
>  	/* 1. get the exact LZMA compressed size */
>  	kin = kmap(*rq->in);
>  	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
> -				   min_t(unsigned int, rq->inputsize,
> -					 EROFS_BLKSIZ - rq->pageofs_in));
> +			min_t(unsigned int, rq->inputsize,
> +			      rq->sb->s_blocksize - rq->pageofs_in));
>  	if (err) {
>  		kunmap(*rq->in);
>  		return err;
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 6970b09b8307..963bbed0b699 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -50,9 +50,11 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  {
>  	struct inode *dir = file_inode(f);
>  	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	struct super_block *sb = dir->i_sb;
> +	unsigned long bsz = sb->s_blocksize;
>  	const size_t dirsize = i_size_read(dir);
> -	unsigned int i = ctx->pos / EROFS_BLKSIZ;
> -	unsigned int ofs = ctx->pos % EROFS_BLKSIZ;
> +	unsigned int i = erofs_blknr(sb, ctx->pos);
> +	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>  	int err = 0;
>  	bool initial = true;
>  
> @@ -62,32 +64,28 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  
>  		de = erofs_bread(&buf, dir, i, EROFS_KMAP);
>  		if (IS_ERR(de)) {
> -			erofs_err(dir->i_sb,
> -				  "fail to readdir of logical block %u of nid %llu",
> +			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
>  				  i, EROFS_I(dir)->nid);
>  			err = PTR_ERR(de);
>  			break;
>  		}
>  
>  		nameoff = le16_to_cpu(de->nameoff);
> -		if (nameoff < sizeof(struct erofs_dirent) ||
> -		    nameoff >= EROFS_BLKSIZ) {
> -			erofs_err(dir->i_sb,
> -				  "invalid de[0].nameoff %u @ nid %llu",
> +		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {
> +			erofs_err(sb, "invalid de[0].nameoff %u @ nid %llu",
>  				  nameoff, EROFS_I(dir)->nid);
>  			err = -EFSCORRUPTED;
>  			break;
>  		}
>  
> -		maxsize = min_t(unsigned int,
> -				dirsize - ctx->pos + ofs, EROFS_BLKSIZ);
> +		maxsize = min_t(unsigned int, dirsize - ctx->pos + ofs, bsz);
>  
>  		/* search dirents at the arbitrary position */
>  		if (initial) {
>  			initial = false;
>  
>  			ofs = roundup(ofs, sizeof(struct erofs_dirent));
> -			ctx->pos = blknr_to_addr(i) + ofs;
> +			ctx->pos = erofs_pos(sb, i) + ofs;
>  			if (ofs >= nameoff)
>  				goto skip_this;
>  		}
> @@ -97,7 +95,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  		if (err)
>  			break;
>  skip_this:
> -		ctx->pos = blknr_to_addr(i) + maxsize;
> +		ctx->pos = erofs_pos(sb, i) + maxsize;
>  		++i;
>  		ofs = 0;
>  	}
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8e9170c777d8..f7a1e147d0f4 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -218,8 +218,8 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
>  		void *src;
>  
>  		/* For tail packing layout, the offset may be non-zero. */
> -		offset = erofs_blkoff(map.m_pa);
> -		blknr = erofs_blknr(map.m_pa);
> +		offset = erofs_blkoff(sb, map.m_pa);
> +		blknr = erofs_blknr(sb, map.m_pa);
>  		size = map.m_llen;
>  
>  		src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
> @@ -469,6 +469,7 @@ static struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb
>  	inode->i_size = OFFSET_MAX;
>  	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
>  	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +	inode->i_blkbits = EROFS_SB(sb)->blkszbits;
>  	inode->i_private = ctx;
>  
>  	ctx->cookie = cookie;
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d7e87d41f7bf..de26dac4e07e 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -23,8 +23,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  	unsigned int ifmt;
>  	int err;
>  
> -	blkaddr = erofs_blknr(inode_loc);
> -	*ofs = erofs_blkoff(inode_loc);
> +	blkaddr = erofs_blknr(sb, inode_loc);
> +	*ofs = erofs_blkoff(sb, inode_loc);
>  
>  	erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
>  		  __func__, vi->nid, *ofs, blkaddr);
> @@ -58,11 +58,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  	case EROFS_INODE_LAYOUT_EXTENDED:
>  		vi->inode_isize = sizeof(struct erofs_inode_extended);
>  		/* check if the extended inode acrosses block boundary */
> -		if (*ofs + vi->inode_isize <= EROFS_BLKSIZ) {
> +		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
>  			*ofs += vi->inode_isize;
>  			die = (struct erofs_inode_extended *)dic;
>  		} else {
> -			const unsigned int gotten = EROFS_BLKSIZ - *ofs;
> +			const unsigned int gotten = sb->s_blocksize - *ofs;
>  
>  			copied = kmalloc(vi->inode_isize, GFP_NOFS);
>  			if (!copied) {
> @@ -176,7 +176,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  			err = -EOPNOTSUPP;
>  			goto err_out;
>  		}
> -		vi->chunkbits = LOG_BLOCK_SIZE +
> +		vi->chunkbits = sb->s_blocksize_bits +
>  			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>  	}
>  	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
> @@ -188,11 +188,12 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
>  	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
>  		inode->i_flags |= S_DAX;
> +
>  	if (!nblks)
>  		/* measure inode.i_blocks as generic filesystems */
> -		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
> +		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
>  	else
> -		inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
> +		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
>  	return kaddr;
>  
>  bogusimode:
> @@ -210,11 +211,12 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>  			      unsigned int m_pofs)
>  {
>  	struct erofs_inode *vi = EROFS_I(inode);
> +	unsigned int bsz = i_blocksize(inode);
>  	char *lnk;
>  
>  	/* if it cannot be handled with fast symlink scheme */
>  	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= EROFS_BLKSIZ || inode->i_size < 0) {
> +	    inode->i_size >= bsz || inode->i_size < 0) {
>  		inode->i_op = &erofs_symlink_iops;
>  		return 0;
>  	}
> @@ -225,7 +227,7 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>  
>  	m_pofs += vi->xattr_isize;
>  	/* inline symlink data shouldn't cross block boundary */
> -	if (m_pofs + inode->i_size > EROFS_BLKSIZ) {
> +	if (m_pofs + inode->i_size > bsz) {
>  		kfree(lnk);
>  		erofs_err(inode->i_sb,
>  			  "inline data cross block boundary @ nid %llu",
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 39f259acf887..d8019d835405 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -147,8 +147,8 @@ struct erofs_sb_info {
>  #endif
>  	u16 device_id_mask;	/* valid bits of device id to be used */
>  
> -	/* inode slot unit size in bit shift */
> -	unsigned char islotbits;
> +	unsigned char islotbits;	/* inode slot unit size in bit shift */
> +	unsigned char blkszbits;
>  
>  	u32 sb_size;			/* total superblock size */
>  	u32 build_time_nsec;
> @@ -242,13 +242,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>  
>  /* we strictly follow PAGE_SIZE and no buffer head yet */
>  #define LOG_BLOCK_SIZE		PAGE_SHIFT
> -
> -#undef LOG_SECTORS_PER_BLOCK
> -#define LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9)
> -
> -#undef SECTORS_PER_BLOCK
> -#define SECTORS_PER_BLOCK	(1 << SECTORS_PER_BLOCK)
> -
>  #define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
>  
>  #if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
> @@ -269,9 +262,10 @@ struct erofs_buf {
>  
>  #define ROOT_NID(sb)		((sb)->root_nid)
>  
> -#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
> -#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
> -#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
> +#define erofs_blknr(sb, addr)	((addr) >> (sb)->s_blocksize_bits)
> +#define erofs_blkoff(sb, addr)	((addr) & ((sb)->s_blocksize - 1))
> +#define erofs_pos(sb, blk)	((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
> +#define erofs_iblks(i)	(round_up((i)->i_size, i_blocksize(i)) >> (i)->i_blkbits)
>  
>  #define EROFS_FEATURE_FUNCS(name, compat, feature) \
>  static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
> @@ -343,7 +337,7 @@ static inline erofs_off_t erofs_iloc(struct inode *inode)
>  {
>  	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
>  
> -	return blknr_to_addr(sbi->meta_blkaddr) +
> +	return erofs_pos(inode->i_sb, sbi->meta_blkaddr) +
>  		(EROFS_I(inode)->nid << sbi->islotbits);
>  }
>  
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index 966eabc61c13..f091e9a0f0a1 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -89,7 +89,8 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
>  static void *erofs_find_target_block(struct erofs_buf *target,
>  		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
>  {
> -	int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
> +	unsigned int bsz = i_blocksize(dir);
> +	int head = 0, back = erofs_iblks(dir) - 1;
>  	unsigned int startprfx = 0, endprfx = 0;
>  	void *candidate = ERR_PTR(-ENOENT);
>  
> @@ -100,8 +101,7 @@ static void *erofs_find_target_block(struct erofs_buf *target,
>  
>  		de = erofs_bread(&buf, dir, mid, EROFS_KMAP);
>  		if (!IS_ERR(de)) {
> -			const int nameoff = nameoff_from_disk(de->nameoff,
> -							      EROFS_BLKSIZ);
> +			const int nameoff = nameoff_from_disk(de->nameoff, bsz);
>  			const int ndirents = nameoff / sizeof(*de);
>  			int diff;
>  			unsigned int matched;
> @@ -121,11 +121,10 @@ static void *erofs_find_target_block(struct erofs_buf *target,
>  
>  			dname.name = (u8 *)de + nameoff;
>  			if (ndirents == 1)
> -				dname.end = (u8 *)de + EROFS_BLKSIZ;
> +				dname.end = (u8 *)de + bsz;
>  			else
>  				dname.end = (u8 *)de +
> -					nameoff_from_disk(de[1].nameoff,
> -							  EROFS_BLKSIZ);
> +					nameoff_from_disk(de[1].nameoff, bsz);
>  
>  			/* string comparison without already matched prefix */
>  			diff = erofs_dirnamecmp(name, &dname, &matched);
> @@ -178,7 +177,8 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
>  		return PTR_ERR(de);
>  
>  	if (ndirents)
> -		de = find_target_dirent(&qn, (u8 *)de, EROFS_BLKSIZ, ndirents);
> +		de = find_target_dirent(&qn, (u8 *)de, i_blocksize(dir),
> +					ndirents);
>  
>  	if (!IS_ERR(de)) {
>  		*nid = le64_to_cpu(de->nid);
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 19b1ae79cec4..c97615c96ef8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -52,18 +52,18 @@ void _erofs_info(struct super_block *sb, const char *function,
>  
>  static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
>  {
> +	size_t len = (1 << EROFS_SB(sb)->blkszbits) - EROFS_SUPER_OFFSET;
>  	struct erofs_super_block *dsb;
>  	u32 expected_crc, crc;
>  
> -	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
> -		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
> +	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET, len, GFP_KERNEL);
>  	if (!dsb)
>  		return -ENOMEM;
>  
>  	expected_crc = le32_to_cpu(dsb->checksum);
>  	dsb->checksum = 0;
>  	/* to allow for x86 boot sectors and other oddities. */
> -	crc = crc32c(~0, dsb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
> +	crc = crc32c(~0, dsb, len);
>  	kfree(dsb);
>  
>  	if (crc != expected_crc) {
> @@ -132,11 +132,11 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
>  	int len, i, cnt;
>  
>  	*offset = round_up(*offset, 4);
> -	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset), EROFS_KMAP);
> +	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *offset), EROFS_KMAP);
>  	if (IS_ERR(ptr))
>  		return ptr;
>  
> -	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
> +	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(sb, *offset)]);
>  	if (!len)
>  		len = U16_MAX + 1;
>  	buffer = kmalloc(len, GFP_KERNEL);
> @@ -146,14 +146,15 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
>  	*lengthp = len;
>  
>  	for (i = 0; i < len; i += cnt) {
> -		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
> -		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
> +		cnt = min_t(int, sb->s_blocksize - erofs_blkoff(sb, *offset),
> +			    len - i);
> +		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *offset),
>  					 EROFS_KMAP);
>  		if (IS_ERR(ptr)) {
>  			kfree(buffer);
>  			return ptr;
>  		}
> -		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
> +		memcpy(buffer + i, ptr + erofs_blkoff(sb, *offset), cnt);
>  		*offset += cnt;
>  	}
>  	return buffer;
> @@ -228,10 +229,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  	struct block_device *bdev;
>  	void *ptr;
>  
> -	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
> +	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
>  	if (IS_ERR(ptr))
>  		return PTR_ERR(ptr);
> -	dis = ptr + erofs_blkoff(*pos);
> +	dis = ptr + erofs_blkoff(sb, *pos);
>  
>  	if (!dif->path) {
>  		if (!dis->tag[0]) {
> @@ -733,6 +734,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sbi->domain_id = ctx->domain_id;
>  	ctx->domain_id = NULL;
>  
> +	sbi->blkszbits = PAGE_SHIFT;
>  	if (erofs_is_fscache_mode(sb)) {
>  		sb->s_blocksize = EROFS_BLKSIZ;
>  		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
> @@ -1060,7 +1062,7 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  		id = huge_encode_dev(sb->s_bdev->bd_dev);
>  
>  	buf->f_type = sb->s_magic;
> -	buf->f_bsize = EROFS_BLKSIZ;
> +	buf->f_bsize = sb->s_blocksize;
>  	buf->f_blocks = sbi->total_blocks;
>  	buf->f_bfree = buf->f_bavail = 0;
>  
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 60729b1220b6..459caa3cd65d 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -68,8 +68,8 @@ static int init_inode_xattrs(struct inode *inode)
>  	}
>  
>  	it.buf = __EROFS_BUF_INITIALIZER;
> -	it.blkaddr = erofs_blknr(erofs_iloc(inode) + vi->inode_isize);
> -	it.ofs = erofs_blkoff(erofs_iloc(inode) + vi->inode_isize);
> +	it.blkaddr = erofs_blknr(sb, erofs_iloc(inode) + vi->inode_isize);
> +	it.ofs = erofs_blkoff(sb, erofs_iloc(inode) + vi->inode_isize);
>  
>  	/* read in shared xattr array (non-atomic, see kmalloc below) */
>  	it.kaddr = erofs_read_metabuf(&it.buf, sb, it.blkaddr, EROFS_KMAP);
> @@ -92,9 +92,9 @@ static int init_inode_xattrs(struct inode *inode)
>  	it.ofs += sizeof(struct erofs_xattr_ibody_header);
>  
>  	for (i = 0; i < vi->xattr_shared_count; ++i) {
> -		if (it.ofs >= EROFS_BLKSIZ) {
> +		if (it.ofs >= sb->s_blocksize) {
>  			/* cannot be unaligned */
> -			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
> +			DBG_BUGON(it.ofs != sb->s_blocksize);
>  
>  			it.kaddr = erofs_read_metabuf(&it.buf, sb, ++it.blkaddr,
>  						      EROFS_KMAP);
> @@ -139,15 +139,15 @@ struct xattr_iter_handlers {
>  
>  static inline int xattr_iter_fixup(struct xattr_iter *it)
>  {
> -	if (it->ofs < EROFS_BLKSIZ)
> +	if (it->ofs < it->sb->s_blocksize)
>  		return 0;
>  
> -	it->blkaddr += erofs_blknr(it->ofs);
> +	it->blkaddr += erofs_blknr(it->sb, it->ofs);
>  	it->kaddr = erofs_read_metabuf(&it->buf, it->sb, it->blkaddr,
>  				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
>  		return PTR_ERR(it->kaddr);
> -	it->ofs = erofs_blkoff(it->ofs);
> +	it->ofs = erofs_blkoff(it->sb, it->ofs);
>  	return 0;
>  }
>  
> @@ -165,8 +165,8 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
>  
>  	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
>  
> -	it->blkaddr = erofs_blknr(erofs_iloc(inode) + inline_xattr_ofs);
> -	it->ofs = erofs_blkoff(erofs_iloc(inode) + inline_xattr_ofs);
> +	it->blkaddr = erofs_blknr(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
> +	it->ofs = erofs_blkoff(it->sb, erofs_iloc(inode) + inline_xattr_ofs);
>  	it->kaddr = erofs_read_metabuf(&it->buf, inode->i_sb, it->blkaddr,
>  				       EROFS_KMAP);
>  	if (IS_ERR(it->kaddr))
> @@ -222,8 +222,8 @@ static int xattr_foreach(struct xattr_iter *it,
>  	processed = 0;
>  
>  	while (processed < entry.e_name_len) {
> -		if (it->ofs >= EROFS_BLKSIZ) {
> -			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
> +		if (it->ofs >= it->sb->s_blocksize) {
> +			DBG_BUGON(it->ofs > it->sb->s_blocksize);
>  
>  			err = xattr_iter_fixup(it);
>  			if (err)
> @@ -231,7 +231,7 @@ static int xattr_foreach(struct xattr_iter *it,
>  			it->ofs = 0;
>  		}
>  
> -		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
> +		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
>  			      entry.e_name_len - processed);
>  
>  		/* handle name */
> @@ -257,8 +257,8 @@ static int xattr_foreach(struct xattr_iter *it,
>  	}
>  
>  	while (processed < value_sz) {
> -		if (it->ofs >= EROFS_BLKSIZ) {
> -			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
> +		if (it->ofs >= it->sb->s_blocksize) {
> +			DBG_BUGON(it->ofs > it->sb->s_blocksize);
>  
>  			err = xattr_iter_fixup(it);
>  			if (err)
> @@ -266,7 +266,7 @@ static int xattr_foreach(struct xattr_iter *it,
>  			it->ofs = 0;
>  		}
>  
> -		slice = min_t(unsigned int, EROFS_BLKSIZ - it->ofs,
> +		slice = min_t(unsigned int, it->sb->s_blocksize - it->ofs,
>  			      value_sz - processed);
>  		op->value(it, processed, it->kaddr + it->ofs, slice);
>  		it->ofs += slice;
> @@ -352,15 +352,14 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
>  	struct super_block *const sb = inode->i_sb;
> -	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>  	unsigned int i;
>  	int ret = -ENOATTR;
>  
>  	for (i = 0; i < vi->xattr_shared_count; ++i) {
>  		erofs_blk_t blkaddr =
> -			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
> +			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
>  
> -		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
> +		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
>  						  EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
> @@ -564,15 +563,14 @@ static int shared_listxattr(struct listxattr_iter *it)
>  	struct inode *const inode = d_inode(it->dentry);
>  	struct erofs_inode *const vi = EROFS_I(inode);
>  	struct super_block *const sb = inode->i_sb;
> -	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>  	unsigned int i;
>  	int ret = 0;
>  
>  	for (i = 0; i < vi->xattr_shared_count; ++i) {
>  		erofs_blk_t blkaddr =
> -			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
> +			xattrblock_addr(sb, vi->xattr_shared_xattrs[i]);
>  
> -		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
> +		it->it.ofs = xattrblock_offset(sb, vi->xattr_shared_xattrs[i]);
>  		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb, blkaddr,
>  						  EROFS_KMAP);
>  		if (IS_ERR(it->it.kaddr))
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index 0a43c9ee9f8f..f7a21aaa9755 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -19,21 +19,21 @@ static inline unsigned int inlinexattr_header_size(struct inode *inode)
>  		sizeof(u32) * EROFS_I(inode)->xattr_shared_count;
>  }
>  
> -static inline erofs_blk_t xattrblock_addr(struct erofs_sb_info *sbi,
> +static inline erofs_blk_t xattrblock_addr(struct super_block *sb,
>  					  unsigned int xattr_id)
>  {
>  #ifdef CONFIG_EROFS_FS_XATTR
> -	return sbi->xattr_blkaddr +
> -		xattr_id * sizeof(__u32) / EROFS_BLKSIZ;
> +	return EROFS_SB(sb)->xattr_blkaddr +
> +		xattr_id * sizeof(__u32) / sb->s_blocksize;
>  #else
>  	return 0;
>  #endif
>  }
>  
> -static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
> +static inline unsigned int xattrblock_offset(struct super_block *sb,
>  					     unsigned int xattr_id)
>  {
> -	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
> +	return (xattr_id * sizeof(__u32)) % sb->s_blocksize;
>  }
>  
>  #ifdef CONFIG_EROFS_FS_XATTR
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 3247d2422bea..f759152feffa 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -807,7 +807,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  
>  	if (ztailpacking) {
>  		pcl->obj.index = 0;	/* which indicates ztailpacking */
> -		pcl->pageofs_in = erofs_blkoff(map->m_pa);
> +		pcl->pageofs_in = erofs_blkoff(fe->inode->i_sb, map->m_pa);
>  		pcl->tailpacking_size = map->m_plen;
>  	} else {
>  		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
> @@ -930,6 +930,7 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
>  				 struct page *page, unsigned int pageofs,
>  				 unsigned int len)
>  {
> +	struct super_block *sb = inode->i_sb;
>  	struct inode *packed_inode = EROFS_I_SB(inode)->packed_inode;
>  	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	u8 *src, *dst;
> @@ -941,16 +942,16 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
>  	pos += EROFS_I(inode)->z_fragmentoff;
>  	for (i = 0; i < len; i += cnt) {
>  		cnt = min_t(unsigned int, len - i,
> -			    EROFS_BLKSIZ - erofs_blkoff(pos));
> +			    sb->s_blocksize - erofs_blkoff(sb, pos));
>  		src = erofs_bread(&buf, packed_inode,
> -				  erofs_blknr(pos), EROFS_KMAP);
> +				  erofs_blknr(sb, pos), EROFS_KMAP);
>  		if (IS_ERR(src)) {
>  			erofs_put_metabuf(&buf);
>  			return PTR_ERR(src);
>  		}
>  
>  		dst = kmap_local_page(page);
> -		memcpy(dst + pageofs + i, src + erofs_blkoff(pos), cnt);
> +		memcpy(dst + pageofs + i, src + erofs_blkoff(sb, pos), cnt);
>  		kunmap_local(dst);
>  		pos += cnt;
>  	}
> @@ -1005,7 +1006,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		void *mp;
>  
>  		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
> -					erofs_blknr(map->m_pa), EROFS_NO_KMAP);
> +					erofs_blknr(inode->i_sb, map->m_pa),
> +					EROFS_NO_KMAP);
>  		if (IS_ERR(mp)) {
>  			err = PTR_ERR(mp);
>  			erofs_err(inode->i_sb,
> @@ -1726,11 +1728,11 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  
>  		/* no device id here, thus it will always succeed */
>  		mdev = (struct erofs_map_dev) {
> -			.m_pa = blknr_to_addr(pcl->obj.index),
> +			.m_pa = erofs_pos(sb, pcl->obj.index),
>  		};
>  		(void)erofs_map_dev(sb, &mdev);
>  
> -		cur = erofs_blknr(mdev.m_pa);
> +		cur = erofs_blknr(sb, mdev.m_pa);
>  		end = cur + pcl->pclusterpages;
>  
>  		do {
> @@ -1764,7 +1766,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  
>  				last_bdev = mdev.m_bdev;
>  				bio->bi_iter.bi_sector = (sector_t)cur <<
> -					LOG_SECTORS_PER_BLOCK;
> +					(sb->s_blocksize_bits - 9);
>  				bio->bi_private = q[JQ_SUBMIT];
>  				if (f->readahead)
>  					bio->bi_opf |= REQ_RAHEAD;
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 8bf6d30518b6..d066c4da87a5 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -18,7 +18,7 @@ int z_erofs_fill_inode(struct inode *inode)
>  		vi->z_advise = 0;
>  		vi->z_algorithmtype[0] = 0;
>  		vi->z_algorithmtype[1] = 0;
> -		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
> +		vi->z_logical_clusterbits = inode->i_sb->s_blocksize_bits;
>  		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
>  	}
>  	inode->i_mapping->a_ops = &z_erofs_aops;
> @@ -53,13 +53,13 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	unsigned int advise, type;
>  
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), EROFS_KMAP);
> +				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  
>  	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
>  	m->lcn = lcn;
> -	di = m->kaddr + erofs_blkoff(pos);
> +	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
>  
>  	advise = le16_to_cpu(di->di_advise);
>  	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
> @@ -156,7 +156,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>  			 (vcnt << amortizedshift);
>  	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
>  	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
> -	eofs = erofs_blkoff(pos);
> +	eofs = erofs_blkoff(m->inode->i_sb, pos);
>  	base = round_down(eofs, vcnt << amortizedshift);
>  	in = m->kaddr + base;
>  
> @@ -249,7 +249,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
>  	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
>  		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
> -	const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> +	unsigned int totalidx = erofs_iblks(inode);
>  	unsigned int compacted_4b_initial, compacted_2b;
>  	unsigned int amortizedshift;
>  	erofs_off_t pos;
> @@ -290,7 +290,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  out:
>  	pos += lcn * (1 << amortizedshift);
>  	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> -				      erofs_blknr(pos), EROFS_KMAP);
> +				      erofs_blknr(inode->i_sb, pos), EROFS_KMAP);
>  	if (IS_ERR(m->kaddr))
>  		return PTR_ERR(m->kaddr);
>  	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
> @@ -360,6 +360,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  					    unsigned int initial_lcn)
>  {
> +	struct super_block *sb = m->inode->i_sb;
>  	struct erofs_inode *const vi = EROFS_I(m->inode);
>  	struct erofs_map_blocks *const map = m->map;
>  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> @@ -406,7 +407,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>  		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
>  		 */
> -		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
> +		m->compressedblks = 1 << (lclusterbits - sb->s_blocksize_bits);
>  		break;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
>  		if (m->delta[0] != 1)
> @@ -422,7 +423,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  		return -EFSCORRUPTED;
>  	}
>  out:
> -	map->m_plen = (u64)m->compressedblks << LOG_BLOCK_SIZE;
> +	map->m_plen = (u64)m->compressedblks << sb->s_blocksize_bits;

erofs_pos(sb, m->compressedblks)?

>  	return 0;
>  err_bonus_cblkcnt:
>  	erofs_err(m->inode->i_sb,
> @@ -565,7 +566,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>  	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
>  		map->m_flags |= EROFS_MAP_FRAGMENT;
>  	} else {
> -		map->m_pa = blknr_to_addr(m.pblk);
> +		map->m_pa = erofs_pos(inode->i_sb, m.pblk);
>  		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
>  		if (err)
>  			goto unmap_out;
> @@ -592,7 +593,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>  	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
>  	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
>  	     map->m_algorithmformat == Z_EROFS_COMPRESSION_LZMA &&
> -	     map->m_llen >= EROFS_BLKSIZ)) {
> +	     map->m_llen >= i_blocksize(inode))) {
>  		err = z_erofs_get_extent_decompressedlen(&m);
>  		if (!err)
>  			map->m_flags |= EROFS_MAP_FULL_MAPPED;
> @@ -633,13 +634,13 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		goto out_unlock;
>  
>  	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
> -	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(sb, pos), EROFS_KMAP);
>  	if (IS_ERR(kaddr)) {
>  		err = PTR_ERR(kaddr);
>  		goto out_unlock;
>  	}
>  
> -	h = kaddr + erofs_blkoff(pos);
> +	h = kaddr + erofs_blkoff(sb, pos);
>  	/*
>  	 * if the highest bit of the 8-byte map header is set, the whole file
>  	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
> @@ -663,7 +664,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		goto out_put_metabuf;
>  	}
>  
> -	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
> +	vi->z_logical_clusterbits = sb->s_blocksize_bits + (h->h_clusterbits & 7);
>  	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
>  	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
>  			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
> @@ -692,7 +693,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		erofs_put_metabuf(&map.buf);
>  
>  		if (!map.m_plen ||
> -		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
> +		    erofs_blkoff(sb, map.m_pa) + map.m_plen > sb->s_blocksize) {
>  			erofs_err(sb, "invalid tail-packing pclustersize %llu",
>  				  map.m_plen);
>  			err = -EFSCORRUPTED;
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index cf4a0d28b178..71dbe8bfa7db 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -71,8 +71,8 @@ TRACE_EVENT(erofs_fill_inode,
>  	TP_fast_assign(
>  		__entry->dev		= inode->i_sb->s_dev;
>  		__entry->nid		= EROFS_I(inode)->nid;
> -		__entry->blkaddr	= erofs_blknr(erofs_iloc(inode));
> -		__entry->ofs		= erofs_blkoff(erofs_iloc(inode));
> +		__entry->blkaddr	= erofs_blknr(inode->i_sb, erofs_iloc(inode));
> +		__entry->ofs		= erofs_blkoff(inode->i_sb, erofs_iloc(inode));
>  	),
>  
>  	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u",

