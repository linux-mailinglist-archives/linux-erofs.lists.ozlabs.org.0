Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A836D68F9
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:36:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrYL16XL3z3cdn
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 02:36:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rn3+0QPG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rn3+0QPG;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrYKy1xCZz2xG9
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 02:36:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3D7DC636E5;
	Tue,  4 Apr 2023 16:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8443DC4339B;
	Tue,  4 Apr 2023 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680626163;
	bh=N6TABPI2++ww4VWCJkhoOBlIJk/AjRql5ITP9NRMCk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rn3+0QPGAyfXLa6eEJXEt0v2Ek2mmD3Yz7lfP5MCte5hkoRcdeR8pIipn9kYY64t3
	 yUNBvbCGIrG4p9utwYUkwt0RncGcqlGY3n+K1rI1qT+cFR/dABOSPNEMTksSjBn7Zl
	 p8Z6nevVPJHRmj3Y01koH7512dM+ExUREQ/422OPHDtcwU/TbdrN/WieMuDqJG4QIU
	 49W1rAZjWQSdu3kx5SF8toa6N9k1uqMRaflsn8wqaFMqs3wpp4M8VY6LQX+a2RUQSi
	 1epMuPGptX8meVqodKw9d0rdcpYZ/niy9ZTg8HHq9QQN63TYEvzNI38QGqNs5AlSip
	 IZg0XiXC4nYSg==
Date: Tue, 4 Apr 2023 09:36:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230404163602.GC109974@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-22-aalbersh@redhat.com>
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
Cc: fsverity@lists.linux.dev, hch@infradead.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 04, 2023 at 04:53:17PM +0200, Andrey Albershteyn wrote:
> In case of different Merkle tree block size fs-verity expects
> ->read_merkle_tree_page() to return Merkle tree page filled with
> Merkle tree blocks. The XFS stores each merkle tree block under
> extended attribute. Those attributes are addressed by block offset
> into Merkle tree.
> 
> This patch make ->read_merkle_tree_page() to fetch multiple merkle
> tree blocks based on size ratio. Also the reference to each xfs_buf
> is passed with page->private to ->drop_page().
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_verity.c | 74 +++++++++++++++++++++++++++++++++++----------
>  fs/xfs/xfs_verity.h |  8 +++++
>  2 files changed, 66 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> index a9874ff4efcd..ef0aff216f06 100644
> --- a/fs/xfs/xfs_verity.c
> +++ b/fs/xfs/xfs_verity.c
> @@ -134,6 +134,10 @@ xfs_read_merkle_tree_page(
>  	struct page		*page = NULL;
>  	__be64			name = cpu_to_be64(index << PAGE_SHIFT);
>  	uint32_t		bs = 1 << log_blocksize;
> +	int			blocks_per_page =
> +		(1 << (PAGE_SHIFT - log_blocksize));
> +	int			n = 0;
> +	int			offset = 0;
>  	struct xfs_da_args	args = {
>  		.dp		= ip,
>  		.attr_filter	= XFS_ATTR_VERITY,
> @@ -143,26 +147,59 @@ xfs_read_merkle_tree_page(
>  		.valuelen	= bs,
>  	};
>  	int			error = 0;
> +	bool			is_checked = true;
> +	struct xfs_verity_buf_list	*buf_list;
>  
>  	page = alloc_page(GFP_KERNEL);
>  	if (!page)
>  		return ERR_PTR(-ENOMEM);
>  
> -	error = xfs_attr_get(&args);
> -	if (error) {
> -		kmem_free(args.value);
> -		xfs_buf_rele(args.bp);
> +	buf_list = kzalloc(sizeof(struct xfs_verity_buf_list), GFP_KERNEL);
> +	if (!buf_list) {
>  		put_page(page);
> -		return ERR_PTR(-EFAULT);
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	if (args.bp->b_flags & XBF_VERITY_CHECKED)
> +	/*
> +	 * Fill the page with Merkle tree blocks. The blcoks_per_page is higher
> +	 * than 1 when fs block size != PAGE_SIZE or Merkle tree block size !=
> +	 * PAGE SIZE
> +	 */
> +	for (n = 0; n < blocks_per_page; n++) {

Ahah, ok, that's why we can't pass the xfs_buf pages up to fsverity.

> +		offset = bs * n;
> +		name = cpu_to_be64(((index << PAGE_SHIFT) + offset));

Really this ought to be a typechecked helper...

struct xfs_fsverity_merkle_key {
	__be64	merkleoff;
};

static inline void
xfs_fsverity_merkle_key_to_disk(struct xfs_fsverity_merkle_key *k, loff_t pos)
{
	k->merkeloff = cpu_to_be64(pos);
}



> +		args.name = (const uint8_t *)&name;
> +
> +		error = xfs_attr_get(&args);
> +		if (error) {
> +			kmem_free(args.value);
> +			/*
> +			 * No more Merkle tree blocks (e.g. this was the last
> +			 * block of the tree)
> +			 */
> +			if (error == -ENOATTR)
> +				break;
> +			xfs_buf_rele(args.bp);
> +			put_page(page);
> +			kmem_free(buf_list);
> +			return ERR_PTR(-EFAULT);
> +		}
> +
> +		buf_list->bufs[buf_list->buf_count++] = args.bp;
> +
> +		/* One of the buffers was dropped */
> +		if (!(args.bp->b_flags & XBF_VERITY_CHECKED))
> +			is_checked = false;

If there's enough memory pressure to cause the merkle tree pages to get
evicted, what are the chances that the xfs_bufs survive the eviction?

> +		memcpy(page_address(page) + offset, args.value, args.valuelen);
> +		kmem_free(args.value);
> +		args.value = NULL;
> +	}
> +
> +	if (is_checked)
>  		SetPageChecked(page);
> +	page->private = (unsigned long)buf_list;
>  
> -	page->private = (unsigned long)args.bp;
> -	memcpy(page_address(page), args.value, args.valuelen);
> -
> -	kmem_free(args.value);
>  	return page;
>  }
>  
> @@ -191,16 +228,21 @@ xfs_write_merkle_tree_block(
>  
>  static void
>  xfs_drop_page(
> -	struct page	*page)
> +	struct page			*page)
>  {
> -	struct xfs_buf *buf = (struct xfs_buf *)page->private;
> +	int				i = 0;
> +	struct xfs_verity_buf_list	*buf_list =
> +		(struct xfs_verity_buf_list *)page->private;
>  
> -	ASSERT(buf != NULL);
> +	ASSERT(buf_list != NULL);
>  
> -	if (PageChecked(page))
> -		buf->b_flags |= XBF_VERITY_CHECKED;
> +	for (i = 0; i < buf_list->buf_count; i++) {
> +		if (PageChecked(page))
> +			buf_list->bufs[i]->b_flags |= XBF_VERITY_CHECKED;
> +		xfs_buf_rele(buf_list->bufs[i]);
> +	}
>  
> -	xfs_buf_rele(buf);
> +	kmem_free(buf_list);
>  	put_page(page);
>  }
>  
> diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
> index ae5d87ca32a8..433b2f4ae3bc 100644
> --- a/fs/xfs/xfs_verity.h
> +++ b/fs/xfs/xfs_verity.h
> @@ -16,4 +16,12 @@ extern const struct fsverity_operations xfs_verity_ops;
>  #define xfs_verity_ops NULL
>  #endif	/* CONFIG_FS_VERITY */
>  
> +/* Minimal Merkle tree block size is 1024 */
> +#define XFS_VERITY_MAX_MBLOCKS_PER_PAGE (1 << (PAGE_SHIFT - 10))
> +
> +struct xfs_verity_buf_list {
> +	unsigned int	buf_count;
> +	struct xfs_buf	*bufs[XFS_VERITY_MAX_MBLOCKS_PER_PAGE];

So... this is going to be a 520-byte allocation on arm64 with 64k pages?
Even if the merkle tree block size is the same as the page size?  Ouch.

--D

> +};
> +
>  #endif	/* __XFS_VERITY_H__ */
> -- 
> 2.38.4
> 
