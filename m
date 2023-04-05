Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC04C6D83DC
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 18:38:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps9Lm62pDz3f47
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 02:38:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ojRVBOKt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ojRVBOKt;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps9Lg72b5z3bfk
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 02:38:51 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D87EB62489;
	Wed,  5 Apr 2023 16:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D10AC433EF;
	Wed,  5 Apr 2023 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680712728;
	bh=bdwer0ckOV0VvNBNptviSJ4Aij6q7ab6EoIjpJEkU8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojRVBOKtUGuMf5Xx6+fu11Y4x9zA1hxfzop7c1U7aQXy0Zo/c7ihZSEwjGJrezKH9
	 uPuuNm/oCDFW1l1HxFMLa6NsMeKCz5ImRAB+OugNcQlSFXRpYFnHhkKeme8Kc9ksMl
	 XqjYva7bS2OfsOhjs7ZzYd2RLH7ggh1p6f1nr6I2q70PUA4T7qDKH3K7omJkrvAYhB
	 W3kJlacbJJT6+DQNLLyAwg+QRqgf9019Zu1QLYweBb92QVlx4KBK+Rtn5+kz9IyfvL
	 wXSyP+UyTRwzO2d3TPwe/4gAvjJbgg1h+4ZxhdY9cQjprbHz/JhNd7HNx7fuAS5+fr
	 LcANAR4F5mkxg==
Date: Wed, 5 Apr 2023 09:38:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230405163847.GG303486@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
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

On Wed, Apr 05, 2023 at 06:02:21PM +0200, Andrey Albershteyn wrote:
> Hi Darrick,
> 
> On Tue, Apr 04, 2023 at 09:36:02AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 04, 2023 at 04:53:17PM +0200, Andrey Albershteyn wrote:
> > > In case of different Merkle tree block size fs-verity expects
> > > ->read_merkle_tree_page() to return Merkle tree page filled with
> > > Merkle tree blocks. The XFS stores each merkle tree block under
> > > extended attribute. Those attributes are addressed by block offset
> > > into Merkle tree.
> > > 
> > > This patch make ->read_merkle_tree_page() to fetch multiple merkle
> > > tree blocks based on size ratio. Also the reference to each xfs_buf
> > > is passed with page->private to ->drop_page().
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > >  fs/xfs/xfs_verity.c | 74 +++++++++++++++++++++++++++++++++++----------
> > >  fs/xfs/xfs_verity.h |  8 +++++
> > >  2 files changed, 66 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> > > index a9874ff4efcd..ef0aff216f06 100644
> > > --- a/fs/xfs/xfs_verity.c
> > > +++ b/fs/xfs/xfs_verity.c
> > > @@ -134,6 +134,10 @@ xfs_read_merkle_tree_page(
> > >  	struct page		*page = NULL;
> > >  	__be64			name = cpu_to_be64(index << PAGE_SHIFT);
> > >  	uint32_t		bs = 1 << log_blocksize;
> > > +	int			blocks_per_page =
> > > +		(1 << (PAGE_SHIFT - log_blocksize));
> > > +	int			n = 0;
> > > +	int			offset = 0;
> > >  	struct xfs_da_args	args = {
> > >  		.dp		= ip,
> > >  		.attr_filter	= XFS_ATTR_VERITY,
> > > @@ -143,26 +147,59 @@ xfs_read_merkle_tree_page(
> > >  		.valuelen	= bs,
> > >  	};
> > >  	int			error = 0;
> > > +	bool			is_checked = true;
> > > +	struct xfs_verity_buf_list	*buf_list;
> > >  
> > >  	page = alloc_page(GFP_KERNEL);
> > >  	if (!page)
> > >  		return ERR_PTR(-ENOMEM);
> > >  
> > > -	error = xfs_attr_get(&args);
> > > -	if (error) {
> > > -		kmem_free(args.value);
> > > -		xfs_buf_rele(args.bp);
> > > +	buf_list = kzalloc(sizeof(struct xfs_verity_buf_list), GFP_KERNEL);
> > > +	if (!buf_list) {
> > >  		put_page(page);
> > > -		return ERR_PTR(-EFAULT);
> > > +		return ERR_PTR(-ENOMEM);
> > >  	}
> > >  
> > > -	if (args.bp->b_flags & XBF_VERITY_CHECKED)
> > > +	/*
> > > +	 * Fill the page with Merkle tree blocks. The blcoks_per_page is higher
> > > +	 * than 1 when fs block size != PAGE_SIZE or Merkle tree block size !=
> > > +	 * PAGE SIZE
> > > +	 */
> > > +	for (n = 0; n < blocks_per_page; n++) {
> > 
> > Ahah, ok, that's why we can't pass the xfs_buf pages up to fsverity.
> > 
> > > +		offset = bs * n;
> > > +		name = cpu_to_be64(((index << PAGE_SHIFT) + offset));
> > 
> > Really this ought to be a typechecked helper...
> > 
> > struct xfs_fsverity_merkle_key {
> > 	__be64	merkleoff;
> 
> Sure, thanks, will change this
> 
> > };
> > 
> > static inline void
> > xfs_fsverity_merkle_key_to_disk(struct xfs_fsverity_merkle_key *k, loff_t pos)
> > {
> > 	k->merkeloff = cpu_to_be64(pos);
> > }
> > 
> > 
> > 
> > > +		args.name = (const uint8_t *)&name;
> > > +
> > > +		error = xfs_attr_get(&args);
> > > +		if (error) {
> > > +			kmem_free(args.value);
> > > +			/*
> > > +			 * No more Merkle tree blocks (e.g. this was the last
> > > +			 * block of the tree)
> > > +			 */
> > > +			if (error == -ENOATTR)
> > > +				break;
> > > +			xfs_buf_rele(args.bp);
> > > +			put_page(page);
> > > +			kmem_free(buf_list);
> > > +			return ERR_PTR(-EFAULT);
> > > +		}
> > > +
> > > +		buf_list->bufs[buf_list->buf_count++] = args.bp;
> > > +
> > > +		/* One of the buffers was dropped */
> > > +		if (!(args.bp->b_flags & XBF_VERITY_CHECKED))
> > > +			is_checked = false;
> > 
> > If there's enough memory pressure to cause the merkle tree pages to get
> > evicted, what are the chances that the xfs_bufs survive the eviction?
> 
> The merkle tree pages are dropped after verification. When page is
> dropped xfs_buf is marked as verified. If fs-verity wants to
> verify again it will get the same verified buffer. If buffer is
> evicted it won't have verified state.
> 
> So, with enough memory pressure buffers will be dropped and need to
> be reverified.

Please excuse me if this was discussed and rejected long ago, but
perhaps fsverity should try to hang on to the merkle tree pages that
this function returns for as long as possible until reclaim comes for
them?

With the merkle tree page lifetimes extended, you then don't need to
attach the xfs_buf to page->private, nor does xfs have to extend the
buffer cache to stash XBF_VERITY_CHECKED.

Also kinda wondering why you don't allocate the page, kmap it, and then
pass that address into args->value to avoid the third memory allocation
that gets done inside xfs_attr_get?

--D

> > 
> > > +		memcpy(page_address(page) + offset, args.value, args.valuelen);
> > > +		kmem_free(args.value);
> > > +		args.value = NULL;
> > > +	}
> > > +
> > > +	if (is_checked)
> > >  		SetPageChecked(page);
> > > +	page->private = (unsigned long)buf_list;
> > >  
> > > -	page->private = (unsigned long)args.bp;
> > > -	memcpy(page_address(page), args.value, args.valuelen);
> > > -
> > > -	kmem_free(args.value);
> > >  	return page;
> > >  }
> > >  
> > > @@ -191,16 +228,21 @@ xfs_write_merkle_tree_block(
> > >  
> > >  static void
> > >  xfs_drop_page(
> > > -	struct page	*page)
> > > +	struct page			*page)
> > >  {
> > > -	struct xfs_buf *buf = (struct xfs_buf *)page->private;
> > > +	int				i = 0;
> > > +	struct xfs_verity_buf_list	*buf_list =
> > > +		(struct xfs_verity_buf_list *)page->private;
> > >  
> > > -	ASSERT(buf != NULL);
> > > +	ASSERT(buf_list != NULL);
> > >  
> > > -	if (PageChecked(page))
> > > -		buf->b_flags |= XBF_VERITY_CHECKED;
> > > +	for (i = 0; i < buf_list->buf_count; i++) {
> > > +		if (PageChecked(page))
> > > +			buf_list->bufs[i]->b_flags |= XBF_VERITY_CHECKED;
> > > +		xfs_buf_rele(buf_list->bufs[i]);
> > > +	}
> > >  
> > > -	xfs_buf_rele(buf);
> > > +	kmem_free(buf_list);
> > >  	put_page(page);
> > >  }
> > >  
> > > diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
> > > index ae5d87ca32a8..433b2f4ae3bc 100644
> > > --- a/fs/xfs/xfs_verity.h
> > > +++ b/fs/xfs/xfs_verity.h
> > > @@ -16,4 +16,12 @@ extern const struct fsverity_operations xfs_verity_ops;
> > >  #define xfs_verity_ops NULL
> > >  #endif	/* CONFIG_FS_VERITY */
> > >  
> > > +/* Minimal Merkle tree block size is 1024 */
> > > +#define XFS_VERITY_MAX_MBLOCKS_PER_PAGE (1 << (PAGE_SHIFT - 10))
> > > +
> > > +struct xfs_verity_buf_list {
> > > +	unsigned int	buf_count;
> > > +	struct xfs_buf	*bufs[XFS_VERITY_MAX_MBLOCKS_PER_PAGE];
> > 
> > So... this is going to be a 520-byte allocation on arm64 with 64k pages?
> > Even if the merkle tree block size is the same as the page size?  Ouch.
> 
> yeah, it also allocates a page and is dropped with the page, so,
> I took it as an addition to already big chunk of memory. But I
> probably will change it, viz. comment from Eric on this patch.
> 
> -- 
> - Andrey
> 
