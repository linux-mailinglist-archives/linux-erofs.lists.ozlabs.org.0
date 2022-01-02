Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD9482A87
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 08:48:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JRWGL3CT6z301K
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 18:48:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com; envelope-from=bo.liu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JRWG9343qz2xDC
 for <linux-erofs@lists.ozlabs.org>; Sun,  2 Jan 2022 18:48:32 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=bo.liu@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0YRFiA_1641109686; 
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0V0YRFiA_1641109686) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 02 Jan 2022 15:48:06 +0800
Date: Sun, 2 Jan 2022 15:48:06 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 1/5] erofs: introduce meta buffer operations
Message-ID: <20220102074806.GC40650@rsjd01523.et2sqa>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102040017.51352-2-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: bo.liu@linux.alibaba.com
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Jan 02, 2022 at 12:00:13PM +0800, Gao Xiang wrote:
> In order to support subpage and folio for all uncompressed files,
> introduce meta buffer descriptors, which can be effectively stored
> on stack, in place of meta page operations.
> 
> This converts the uncompressed data path to meta buffers.
>

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 97 +++++++++++++++++++++++++++++++++++----------
>  fs/erofs/internal.h | 13 ++++++
>  2 files changed, 89 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 4f98c76ec043..6495e16a50a9 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -22,6 +22,56 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
>  	return page;
>  }
>  
> +void erofs_unmap_metabuf(struct erofs_buf *buf)
> +{
> +	if (buf->kmap_type == EROFS_KMAP)
> +		kunmap(buf->page);
> +	else if (buf->kmap_type == EROFS_KMAP_ATOMIC)
> +		kunmap_atomic(buf->base);
> +	buf->kmap_type = EROFS_NO_KMAP;
> +}
> +
> +void erofs_put_metabuf(struct erofs_buf *buf)
> +{
> +	if (!buf->page)
> +		return;
> +	erofs_unmap_metabuf(buf);
> +	put_page(buf->page);
> +	buf->page = NULL;
> +}
> +
> +void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
> +			erofs_blk_t blkaddr, enum erofs_kmap_type type)
> +{
> +	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
> +	erofs_off_t offset = blknr_to_addr(blkaddr);
> +	pgoff_t index = offset >> PAGE_SHIFT;
> +	struct page *page = buf->page;
> +
> +	if (!page || page->index != index) {
> +		erofs_put_metabuf(buf);
> +		page = read_cache_page_gfp(mapping, index,
> +				mapping_gfp_constraint(mapping, ~__GFP_FS));
> +		if (IS_ERR(page))
> +			return page;
> +		/* should already be PageUptodate, no need to lock page */
> +		buf->page = page;
> +	}
> +	if (buf->kmap_type == EROFS_NO_KMAP) {
> +		if (type == EROFS_KMAP)
> +			buf->base = kmap(page);
> +		else if (type == EROFS_KMAP_ATOMIC)
> +			buf->base = kmap_atomic(page);
> +		buf->kmap_type = type;
> +	} else if (buf->kmap_type != type) {
> +		DBG_BUGON(1);
> +		return ERR_PTR(-EFAULT);
> +	}
> +	if (type == EROFS_NO_KMAP)
> +		return NULL;
> +	return buf->base + (offset & ~PAGE_MASK);
> +}
> +
>  static int erofs_map_blocks_flatmode(struct inode *inode,
>  				     struct erofs_map_blocks *map,
>  				     int flags)
> @@ -31,7 +81,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	struct erofs_inode *vi = EROFS_I(inode);
>  	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
>  
> -	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> +	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
>  	lastblk = nblocks - tailendpacking;
>  
>  	/* there is no hole in flatmode */
> @@ -72,10 +122,11 @@ static int erofs_map_blocks(struct inode *inode,
>  	struct super_block *sb = inode->i_sb;
>  	struct erofs_inode *vi = EROFS_I(inode);
>  	struct erofs_inode_chunk_index *idx;
> -	struct page *page;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  	u64 chunknr;
>  	unsigned int unit;
>  	erofs_off_t pos;
> +	void *kaddr;
>  	int err = 0;
>  
>  	trace_erofs_map_blocks_enter(inode, map, flags);
> @@ -101,9 +152,9 @@ static int erofs_map_blocks(struct inode *inode,
>  	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
>  		    vi->xattr_isize, unit) + unit * chunknr;
>  
> -	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
> -	if (IS_ERR(page)) {
> -		err = PTR_ERR(page);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
> +	if (IS_ERR(kaddr)) {
> +		err = PTR_ERR(kaddr);
>  		goto out;
>  	}
>  	map->m_la = chunknr << vi->chunkbits;
> @@ -112,7 +163,7 @@ static int erofs_map_blocks(struct inode *inode,
>  
>  	/* handle block map */
>  	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
> -		__le32 *blkaddr = page_address(page) + erofs_blkoff(pos);
> +		__le32 *blkaddr = kaddr + erofs_blkoff(pos);
>  
>  		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
>  			map->m_flags = 0;
> @@ -123,7 +174,7 @@ static int erofs_map_blocks(struct inode *inode,
>  		goto out_unlock;
>  	}
>  	/* parse chunk indexes */
> -	idx = page_address(page) + erofs_blkoff(pos);
> +	idx = kaddr + erofs_blkoff(pos);
>  	switch (le32_to_cpu(idx->blkaddr)) {
>  	case EROFS_NULL_ADDR:
>  		map->m_flags = 0;
> @@ -136,8 +187,7 @@ static int erofs_map_blocks(struct inode *inode,
>  		break;
>  	}
>  out_unlock:
> -	unlock_page(page);
> -	put_page(page);
> +	erofs_put_metabuf(&buf);
>  out:
>  	if (!err)
>  		map->m_llen = map->m_plen;
> @@ -226,16 +276,16 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	}
>  
>  	if (map.m_flags & EROFS_MAP_META) {
> -		struct page *ipage;
> +		void *ptr;
> +		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>  
>  		iomap->type = IOMAP_INLINE;
> -		ipage = erofs_get_meta_page(inode->i_sb,
> -					    erofs_blknr(mdev.m_pa));
> -		if (IS_ERR(ipage))
> -			return PTR_ERR(ipage);
> -		iomap->inline_data = page_address(ipage) +
> -					erofs_blkoff(mdev.m_pa);
> -		iomap->private = ipage;
> +		ptr = erofs_read_metabuf(&buf, inode->i_sb,
> +					 erofs_blknr(mdev.m_pa), EROFS_KMAP);
> +		if (IS_ERR(ptr))
> +			return PTR_ERR(ptr);
> +		iomap->inline_data = ptr + erofs_blkoff(mdev.m_pa);
> +		iomap->private = buf.base;
>  	} else {
>  		iomap->type = IOMAP_MAPPED;
>  		iomap->addr = mdev.m_pa;
> @@ -246,12 +296,17 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>  		ssize_t written, unsigned int flags, struct iomap *iomap)
>  {
> -	struct page *ipage = iomap->private;
> +	void *ptr = iomap->private;
> +
> +	if (ptr) {
> +		struct erofs_buf buf = {
> +			.page = kmap_to_page(ptr),
> +			.base = ptr,
> +			.kmap_type = EROFS_KMAP,
> +		};
>  
> -	if (ipage) {
>  		DBG_BUGON(iomap->type != IOMAP_INLINE);
> -		unlock_page(ipage);
> -		put_page(ipage);
> +		erofs_put_metabuf(&buf);
>  	} else {
>  		DBG_BUGON(iomap->type == IOMAP_INLINE);
>  	}
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index fca3747d97be..7053f1c4171d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -251,6 +251,19 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>  #error erofs cannot be used in this platform
>  #endif
>  
> +enum erofs_kmap_type {
> +	EROFS_NO_KMAP,		/* don't map the buffer */
> +	EROFS_KMAP,		/* use kmap() to map the buffer */
> +	EROFS_KMAP_ATOMIC,	/* use kmap_atomic() to map the buffer */
> +};
> +
> +struct erofs_buf {
> +	struct page *page;
> +	void *base;
> +	enum erofs_kmap_type kmap_type;
> +};
> +#define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
> +
>  #define ROOT_NID(sb)		((sb)->root_nid)
>  
>  #define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
> -- 
> 2.24.4
