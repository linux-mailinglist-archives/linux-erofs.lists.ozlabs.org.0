Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1996D8AC6
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 00:51:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsKcn5Rz1z3f8T
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 08:51:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680735097;
	bh=dLSxfaMFCVS8468KN/z0VwXJmbpcmKd5R8VPq1b2igA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZEFjTeAphPxfrvz77pArEmvG79fQcfpkWMQCVOUCy67dEXzcqloRM/R51i+rR///p
	 +Kn9GcSAchKKbo1PoH8jaRt8PXuA4iErtOJ7eILqMrvZB3fGuOpyI01roinKABIMOz
	 JsomMuu9DRwDPFoahSEZnFEium0fODkEilLBqHvnZRRpcsAQ3YLJCbGMJWhp2h8peo
	 TzIkDNXHNbfEj2bYtcJO/XrGgPsAGjIHlFEjd7eRafBMkH5V54SOdMahZWEYrnqrde
	 WlBR9cFWDC0DgslQ+rsfTz1j8r5AkeCuekVFuTWg7s+T5zg+sQDT00NPK/cstAZgmw
	 QMbvb8d8Au6Mg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=david@fromorbit.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20210112.gappssmtp.com header.i=@fromorbit-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=DKNaEMAv;
	dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsKcj5k4Xz3chZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 08:51:31 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id bm13so10557916pfb.5
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 15:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680735089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLSxfaMFCVS8468KN/z0VwXJmbpcmKd5R8VPq1b2igA=;
        b=TpPo3SUBMXt7VVrP99xIADVMgfVx89p7U3iwoEwFZN5IJq7Bh9YyfDnwhmSMwvogPu
         saw/aBbY4SMbCzC0kv0rM4mqAFbw/08HXejTg+du+bof6AHn4rnybq7llmaYOYyApR5x
         LcX45HN7Fr3qvOdE5YuR/BuO9YMI8QmnevgC/3KARmh7ySncOXjJQtHNMfnpUVlokgCQ
         mfslDimpKLsuC/W6qFjHAoTTjlv46hNA3RtWPPwglhw05u7dYRfjL6VD3XHfLOUhi6p/
         J03DlH81DCvGXdnAFj5sjYOp/42C80Va25plhac0KVzDW6doPSsq1PhC9h7MDuxSi7D7
         xM1Q==
X-Gm-Message-State: AAQBX9cHfDPi0wEy94Toyqm1RATxd/G+cAmtq0oDE0QG1fs7n1rBOQRd
	6U6dlgIKotodSrgRlOOYeSAr8Q==
X-Google-Smtp-Source: AKy350byI2dOXAx2UUhieoBDXlt6kMcfX++CjjnLqbSOozpqmQEUOmvJ7mOnsddzMAKRV6q6VXMDHg==
X-Received: by 2002:a62:7b8b:0:b0:625:cc03:df33 with SMTP id w133-20020a627b8b000000b00625cc03df33mr7050385pfc.31.1680735088792;
        Wed, 05 Apr 2023 15:51:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id m3-20020aa79003000000b006260645f2a7sm11619498pfo.17.2023.04.05.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:51:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pkByP-00HV2h-IA; Thu, 06 Apr 2023 08:51:25 +1000
Date: Thu, 6 Apr 2023 08:51:25 +1000
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230405225125.GS3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404233224.GE1893@sol.localdomain>
 <20230405151234.sgkuasb7lwmgetzz@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405151234.sgkuasb7lwmgetzz@aalbersh.remote.csb>
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 05:12:34PM +0200, Andrey Albershteyn wrote:
> Hi Eric,
> 
> On Tue, Apr 04, 2023 at 04:32:24PM -0700, Eric Biggers wrote:
> > Hi Andrey,
> > 
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
> > > +		offset = bs * n;
> > > +		name = cpu_to_be64(((index << PAGE_SHIFT) + offset));
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
> > > +
> > > +		memcpy(page_address(page) + offset, args.value, args.valuelen);
> > > +		kmem_free(args.value);
> > > +		args.value = NULL;
> > > +	}
> > 
> > I was really hoping for a solution where the cached data can be used directly,
> > instead allocating a temporary page and copying the cached data into it every
> > time the cache is accessed.  The problem with what you have now is that every
> > time a single 32-byte hash is accessed, a full page (potentially 64KB!) will be
> > allocated and filled.  That's not very efficient.  The need to allocate the
> > temporary page can also cause ENOMEM (which will get reported as EIO).
> > 
> > Did you consider alternatives that would work more efficiently?  I think it
> > would be worth designing something that works properly with how XFS is planned
> > to cache the Merkle tree, instead of designing a workaround.
> > ->read_merkle_tree_page was not really designed for what you are doing here.
> > 
> > How about replacing ->read_merkle_tree_page with a function that takes in a
> > Merkle tree block index (not a page index!) and hands back a (page, offset) pair
> > that identifies where the Merkle tree block's data is located?  Or (folio,
> > offset), I suppose.

{kaddr, len}, please.

> > 
> > With that, would it be possible to directly return the XFS cache?
> > 
> > - Eric
> > 
> 
> Yeah, I also don't like it, I didn't want to change fs-verity much
> so went with this workaround. But as it's ok, I will look into trying
> to pass xfs buffers to fs-verity without direct use of
> ->read_merkle_tree_page(). I think it's possible with (folio,
> offset), the xfs buffers aren't xattr value align so the 4k merkle
> tree block is stored in two pages.

I don't think this is necessary to actually merge the code. We want
it to work correctly as the primary concern, performance is a
secondary concern.

Regardless, as you mention, the xfs_buf is not made up of contiguous
pages so the merkle tree block data will be split across two
(or more) pages.  AFAICT, the fsverity code doesn't work with data
structures that span multiple disjoint pages...

Another problem is that the xfs-buf might be backed by heap memory
(e.g. 4kB fs block size on 64kB PAGE_SIZE) and so it cannot be
treated like a page cache page by the fsverity merkle tree code. We
most definitely do not want to be passing pages containing heap
memory to functions expecting to be passed lru-resident page cache
pages....

That said, xfs-bufs do have a stable method of addressing the data
in the buffers, and all the XFS code uses this to access and
manipulate data directly in the buffers.

That is, xfs_buf_offset() returns a mapped kaddr that points to the
contiguous memory region containing the metadata in the buffer.  If
the xfs_buf spans multiple pages, it will return a kaddr pointing
into the contiguous vmapped memory address that maps the entire
buffer data range. If it is heap memory, it simply returns a pointer
into that heap memory. If it's a single page, then it returns the
kaddr for the data within the page.

If you move all the assumptions about how the merkle tree data is
managed out of fsverity and require the fielsystems to do the
mapping to kaddrs and reference counting to guarantee life times,
then the need for multiple different methods for reading merkle tree
data go away...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
