Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D33C6A8384
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Mar 2023 14:30:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSBmq1WbFz3cNh
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 00:30:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSBmm1FpNz3cKn
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 00:30:15 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcxX7ku_1677763810;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcxX7ku_1677763810)
          by smtp.aliyun-inc.com;
          Thu, 02 Mar 2023 21:30:11 +0800
Message-ID: <415e4402-03b8-e192-0b40-08e479e510d4@linux.alibaba.com>
Date: Thu, 2 Mar 2023 21:30:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] erofs: avoid hardcoded blocksize for subpage block
 support
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230220025046.103777-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230220025046.103777-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/2/20 10:50, Jingbo Xu wrote:
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
> ---
> v3: introduce erofs_iblks() to avoid potential warning of "undefined
> reference to `__divdi3'" [1]
> 
> [1] https://lore.kernel.org/all/202302180056.Qg8HFrkU-lkp@intel.com/
> 
> v1: https://lore.kernel.org/all/20230216094745.47868-1-jefflexu@linux.alibaba.com/
> v2: https://lore.kernel.org/all/20230217055016.71462-2-jefflexu@linux.alibaba.com/
> ---
>   fs/erofs/data.c              | 48 ++++++++++++++++++++----------------
>   fs/erofs/decompressor.c      |  6 ++---
>   fs/erofs/decompressor_lzma.c |  4 +--
>   fs/erofs/dir.c               | 21 ++++++++--------
>   fs/erofs/fscache.c           |  5 ++--
>   fs/erofs/inode.c             | 20 ++++++++-------
>   fs/erofs/internal.h          | 20 ++++++---------
>   fs/erofs/namei.c             | 14 +++++------
>   fs/erofs/super.c             | 24 +++++++++---------
>   fs/erofs/xattr.c             | 40 ++++++++++++++----------------
>   fs/erofs/xattr.h             | 10 ++++----
>   fs/erofs/zdata.c             | 18 ++++++++------
>   fs/erofs/zmap.c              | 29 +++++++++++-----------
>   include/trace/events/erofs.h |  4 +--
>   14 files changed, 134 insertions(+), 129 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 032e12dccb84..5ad40734fd77 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -27,11 +27,15 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>   	buf->page = NULL;
>   }
>   
> +/*
> + * Derive the block size from inode->i_blkbits to make compatible with
> + * anonymous inode in fscache mode.
> + */
>   void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>   		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
>   {
> +	erofs_off_t offset = blkaddr << inode->i_blkbits;
>   	struct address_space *const mapping = inode->i_mapping;
> -	erofs_off_t offset = blknr_to_addr(blkaddr);
>   	pgoff_t index = offset >> PAGE_SHIFT;
>   	struct page *page = buf->page;
>   	struct folio *folio;
> @@ -79,24 +83,25 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>   	erofs_blk_t nblocks, lastblk;
>   	u64 offset = map->m_la;
>   	struct erofs_inode *vi = EROFS_I(inode);
> +	struct super_block *sb = inode->i_sb;
>   	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
>   
> -	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> +	nblocks = erofs_iblks(inode);
>   	lastblk = nblocks - tailendpacking;
>   
>   	/* there is no hole in flatmode */
>   	map->m_flags = EROFS_MAP_MAPPED;
> -	if (offset < blknr_to_addr(lastblk)) {
> -		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
> -		map->m_plen = blknr_to_addr(lastblk) - offset;
> +	if (offset < erofs_pos(sb, lastblk)) {
> +		map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
> +		map->m_plen = erofs_pos(sb, lastblk) - offset;
>   	} else if (tailendpacking) {
>   		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
> -			vi->xattr_isize + erofs_blkoff(offset);
> +			vi->xattr_isize + erofs_blkoff(sb, offset);
>   		map->m_plen = inode->i_size - offset;
>   
>   		/* inline data should be located in the same meta block */
> -		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
> -			erofs_err(inode->i_sb,
> +		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
> +			erofs_err(sb,
>   				  "inline data cross block boundary @ nid %llu",

Could we save a line for this?  I think we don't need to keep 80-char for
the print message line.


>   				  vi->nid);
>   			DBG_BUGON(1);
> @@ -104,7 +109,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>   		}
>   		map->m_flags |= EROFS_MAP_META;
>   	} else {
> -		erofs_err(inode->i_sb,
> +		erofs_err(sb,
>   			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
>   			  vi->nid, inode->i_size, map->m_la);

Same here.


>   		DBG_BUGON(1);
> @@ -148,29 +153,29 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>   	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
>   		    vi->xattr_isize, unit) + unit * chunknr;
>   
> -	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(sb, pos), EROFS_KMAP);
>   	if (IS_ERR(kaddr)) {
>   		err = PTR_ERR(kaddr);
>   		goto out;
>   	}
>   	map->m_la = chunknr << vi->chunkbits;
>   	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
> -			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
> +			round_up(inode->i_size - map->m_la, sb->s_blocksize));
>   
>   	/* handle block map */
>   	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
> -		__le32 *blkaddr = kaddr + erofs_blkoff(pos);
> +		__le32 *blkaddr = kaddr + erofs_blkoff(sb, pos);
>   
>   		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
>   			map->m_flags = 0;
>   		} else {
> -			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
> +			map->m_pa = erofs_pos(sb, le32_to_cpu(*blkaddr));
>   			map->m_flags = EROFS_MAP_MAPPED;
>   		}
>   		goto out_unlock;
>   	}
>   	/* parse chunk indexes */
> -	idx = kaddr + erofs_blkoff(pos);
> +	idx = kaddr + erofs_blkoff(sb, pos);
>   	switch (le32_to_cpu(idx->blkaddr)) {
>   	case EROFS_NULL_ADDR:
>   		map->m_flags = 0;
> @@ -178,7 +183,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>   	default:
>   		map->m_deviceid = le16_to_cpu(idx->device_id) &
>   			EROFS_SB(sb)->device_id_mask;
> -		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
> +		map->m_pa = erofs_pos(sb, le32_to_cpu(idx->blkaddr));
>   		map->m_flags = EROFS_MAP_MAPPED;
>   		break;
>   	}
> @@ -222,8 +227,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   
>   			if (!dif->mapped_blkaddr)
>   				continue;
> -			startoff = blknr_to_addr(dif->mapped_blkaddr);
> -			length = blknr_to_addr(dif->blocks);
> +			startoff = erofs_pos(sb, dif->mapped_blkaddr);
> +			length = erofs_pos(sb, dif->blocks);
>   
>   			if (map->m_pa >= startoff &&
>   			    map->m_pa < startoff + length) {
> @@ -244,6 +249,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>   {
>   	int ret;
> +	struct super_block *sb = inode->i_sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   
> @@ -258,7 +264,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		.m_deviceid = map.m_deviceid,
>   		.m_pa = map.m_pa,
>   	};
> -	ret = erofs_map_dev(inode->i_sb, &mdev);
> +	ret = erofs_map_dev(sb, &mdev);
>   	if (ret)
>   		return ret;
>   
> @@ -284,11 +290,11 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   
>   		iomap->type = IOMAP_INLINE;
> -		ptr = erofs_read_metabuf(&buf, inode->i_sb,
> -					 erofs_blknr(mdev.m_pa), EROFS_KMAP);
> +		ptr = erofs_read_metabuf(&buf, sb,
> +				erofs_blknr(sb, mdev.m_pa), EROFS_KMAP);
>   		if (IS_ERR(ptr))
>   			return PTR_ERR(ptr);
> -		iomap->inline_data = ptr + erofs_blkoff(mdev.m_pa);
> +		iomap->inline_data = ptr + erofs_blkoff(sb, mdev.m_pa);
>   		iomap->private = buf.base;
>   	} else {
>   		iomap->type = IOMAP_MAPPED;
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 51b7ac7166d9..21fc6897d225 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -42,7 +42,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>   		if (!sbi->lz4.max_pclusterblks) {
>   			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
>   		} else if (sbi->lz4.max_pclusterblks >
> -			   Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
> +			   Z_EROFS_PCLUSTER_MAX_SIZE >> sb->s_blocksize_bits) {
>   			erofs_err(sb, "too large lz4 pclusterblks %u",
>   				  sbi->lz4.max_pclusterblks);
>   			return -EINVAL;
> @@ -221,13 +221,13 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
>   		support_0padding = true;
>   		ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
>   				min_t(unsigned int, rq->inputsize,
> -				      EROFS_BLKSIZ - rq->pageofs_in));
> +				      rq->sb->s_blocksize - rq->pageofs_in));
>   		if (ret) {
>   			kunmap_atomic(headpage);
>   			return ret;
>   		}
>   		may_inplace = !((rq->pageofs_in + rq->inputsize) &
> -				(EROFS_BLKSIZ - 1));
> +				(rq->sb->s_blocksize - 1));
>   	}
>   
>   	inputmargin = rq->pageofs_in;
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 091fd5adf818..d44c377c5b69 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -166,8 +166,8 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
>   	/* 1. get the exact LZMA compressed size */
>   	kin = kmap(*rq->in);
>   	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
> -				   min_t(unsigned int, rq->inputsize,
> -					 EROFS_BLKSIZ - rq->pageofs_in));
> +			min_t(unsigned int, rq->inputsize,
> +			      rq->sb->s_blocksize - rq->pageofs_in));
>   	if (err) {
>   		kunmap(*rq->in);
>   		return err;
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 6970b09b8307..849319457181 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -50,9 +50,11 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   {
>   	struct inode *dir = file_inode(f);
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	struct super_block *sb = dir->i_sb;
> +	unsigned long bsz = sb->s_blocksize;
>   	const size_t dirsize = i_size_read(dir);
> -	unsigned int i = ctx->pos / EROFS_BLKSIZ;
> -	unsigned int ofs = ctx->pos % EROFS_BLKSIZ;
> +	unsigned int i = erofs_blknr(sb, ctx->pos);
> +	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>   	int err = 0;
>   	bool initial = true;
>   
> @@ -62,7 +64,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   
>   		de = erofs_bread(&buf, dir, i, EROFS_KMAP);
>   		if (IS_ERR(de)) {
> -			erofs_err(dir->i_sb,
> +			erofs_err(sb,


Same here,

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

>   				  "fail to readdir of logical block %u of nid %llu",
>   				  i, EROFS_I(dir)->nid);
>   			err = PTR_ERR(de);
