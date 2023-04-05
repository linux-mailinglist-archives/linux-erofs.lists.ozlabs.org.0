Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C656D82CC
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 18:02:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps8Y11Ftgz3chl
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 02:02:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IY6JIjSa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IY6JIjSa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IY6JIjSa;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IY6JIjSa;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps8Xt5Vvyz3bVP
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 02:02:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680710553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4E5sAaKj2nRhZMpCfhlf1IVMfFLjV6lcrwFxgfc+2Uo=;
	b=IY6JIjSapKSkXGMuNcYI6g9oZj8mMi9U5SOw3mQJXVEdtjGZuEbO/vNrHHjQ6ByKwH2OFk
	irrlt9cFLG8kwm5awxp2bDDwKoW5o7GOb6C0hJQNAWTYUv5hztKjc2rPYurK9jMUI6hlxu
	nqA8TDWNulNkIT3YG3pnfizkO6bjbMY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680710553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4E5sAaKj2nRhZMpCfhlf1IVMfFLjV6lcrwFxgfc+2Uo=;
	b=IY6JIjSapKSkXGMuNcYI6g9oZj8mMi9U5SOw3mQJXVEdtjGZuEbO/vNrHHjQ6ByKwH2OFk
	irrlt9cFLG8kwm5awxp2bDDwKoW5o7GOb6C0hJQNAWTYUv5hztKjc2rPYurK9jMUI6hlxu
	nqA8TDWNulNkIT3YG3pnfizkO6bjbMY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-Jfn9pKMJOOC20QhQjj3REQ-1; Wed, 05 Apr 2023 12:02:29 -0400
X-MC-Unique: Jfn9pKMJOOC20QhQjj3REQ-1
Received: by mail-qk1-f197.google.com with SMTP id 72-20020a37064b000000b007467c5d3abeso16413937qkg.19
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 09:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E5sAaKj2nRhZMpCfhlf1IVMfFLjV6lcrwFxgfc+2Uo=;
        b=UWsssbh/M9P1Z9RZ7KKVBgOsMRO1++0/yJL3637jNyXJe1bMDydGytwp83QG4jDYmv
         W0tGfT8dYdVjWTF2dKyJUHcWZ+ITrnbLPqKnIOxd5+/z7vnJXWaH2AnRrIBb0OlzZEgC
         RlfEgb65PAP2yrNH6kJizO0qGfPbD8yk1HEl4xqD4ntBe57qHf9cRgq4jDDxGu6csPTd
         cY2AlBjmL4vkZCyqUGOsPOi2VD3grYmJ5WDXx9yWKvcUYYGIkQQ2psyqBGSafqA4O5LB
         O5K+VFN95unx/D07nl/Epdrt3dgbvKRXWNH86888KkMdN2GdIyJuIkjW2ID5OEk4wOo9
         tUHg==
X-Gm-Message-State: AAQBX9eIq5Gd6ct/zPoNbEEjTpELoB2tioA4qEaCgJG1H4zp5kUb4Ktp
	f0toJB/dGMMrE01TUzb/mW89oC0FhXqUifDKAwsYS4kTKrJwMROjU1oMaQdwxmpn+WWaIwLA+Zr
	FlAZf2dJz54dCCEt61hQjrKU=
X-Received: by 2002:ac8:5fce:0:b0:3b9:b6e3:c78e with SMTP id k14-20020ac85fce000000b003b9b6e3c78emr5645466qta.8.1680710548124;
        Wed, 05 Apr 2023 09:02:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350a9fBwBu823yNMJRRNCF/kPjd5TTa8a0sHl1G7/F6LAQ61bqbdFkGDEgXPZez2BOg5cs9V+tg==
X-Received: by 2002:ac8:5fce:0:b0:3b9:b6e3:c78e with SMTP id k14-20020ac85fce000000b003b9b6e3c78emr5645405qta.8.1680710547586;
        Wed, 05 Apr 2023 09:02:27 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id m12-20020ac8688c000000b003df7d7bbc8csm4060750qtq.75.2023.04.05.09.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:02:26 -0700 (PDT)
Date: Wed, 5 Apr 2023 18:02:21 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20230404163602.GC109974@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Darrick,

On Tue, Apr 04, 2023 at 09:36:02AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 04, 2023 at 04:53:17PM +0200, Andrey Albershteyn wrote:
> > In case of different Merkle tree block size fs-verity expects
> > ->read_merkle_tree_page() to return Merkle tree page filled with
> > Merkle tree blocks. The XFS stores each merkle tree block under
> > extended attribute. Those attributes are addressed by block offset
> > into Merkle tree.
> > 
> > This patch make ->read_merkle_tree_page() to fetch multiple merkle
> > tree blocks based on size ratio. Also the reference to each xfs_buf
> > is passed with page->private to ->drop_page().
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/xfs/xfs_verity.c | 74 +++++++++++++++++++++++++++++++++++----------
> >  fs/xfs/xfs_verity.h |  8 +++++
> >  2 files changed, 66 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> > index a9874ff4efcd..ef0aff216f06 100644
> > --- a/fs/xfs/xfs_verity.c
> > +++ b/fs/xfs/xfs_verity.c
> > @@ -134,6 +134,10 @@ xfs_read_merkle_tree_page(
> >  	struct page		*page = NULL;
> >  	__be64			name = cpu_to_be64(index << PAGE_SHIFT);
> >  	uint32_t		bs = 1 << log_blocksize;
> > +	int			blocks_per_page =
> > +		(1 << (PAGE_SHIFT - log_blocksize));
> > +	int			n = 0;
> > +	int			offset = 0;
> >  	struct xfs_da_args	args = {
> >  		.dp		= ip,
> >  		.attr_filter	= XFS_ATTR_VERITY,
> > @@ -143,26 +147,59 @@ xfs_read_merkle_tree_page(
> >  		.valuelen	= bs,
> >  	};
> >  	int			error = 0;
> > +	bool			is_checked = true;
> > +	struct xfs_verity_buf_list	*buf_list;
> >  
> >  	page = alloc_page(GFP_KERNEL);
> >  	if (!page)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	error = xfs_attr_get(&args);
> > -	if (error) {
> > -		kmem_free(args.value);
> > -		xfs_buf_rele(args.bp);
> > +	buf_list = kzalloc(sizeof(struct xfs_verity_buf_list), GFP_KERNEL);
> > +	if (!buf_list) {
> >  		put_page(page);
> > -		return ERR_PTR(-EFAULT);
> > +		return ERR_PTR(-ENOMEM);
> >  	}
> >  
> > -	if (args.bp->b_flags & XBF_VERITY_CHECKED)
> > +	/*
> > +	 * Fill the page with Merkle tree blocks. The blcoks_per_page is higher
> > +	 * than 1 when fs block size != PAGE_SIZE or Merkle tree block size !=
> > +	 * PAGE SIZE
> > +	 */
> > +	for (n = 0; n < blocks_per_page; n++) {
> 
> Ahah, ok, that's why we can't pass the xfs_buf pages up to fsverity.
> 
> > +		offset = bs * n;
> > +		name = cpu_to_be64(((index << PAGE_SHIFT) + offset));
> 
> Really this ought to be a typechecked helper...
> 
> struct xfs_fsverity_merkle_key {
> 	__be64	merkleoff;

Sure, thanks, will change this

> };
> 
> static inline void
> xfs_fsverity_merkle_key_to_disk(struct xfs_fsverity_merkle_key *k, loff_t pos)
> {
> 	k->merkeloff = cpu_to_be64(pos);
> }
> 
> 
> 
> > +		args.name = (const uint8_t *)&name;
> > +
> > +		error = xfs_attr_get(&args);
> > +		if (error) {
> > +			kmem_free(args.value);
> > +			/*
> > +			 * No more Merkle tree blocks (e.g. this was the last
> > +			 * block of the tree)
> > +			 */
> > +			if (error == -ENOATTR)
> > +				break;
> > +			xfs_buf_rele(args.bp);
> > +			put_page(page);
> > +			kmem_free(buf_list);
> > +			return ERR_PTR(-EFAULT);
> > +		}
> > +
> > +		buf_list->bufs[buf_list->buf_count++] = args.bp;
> > +
> > +		/* One of the buffers was dropped */
> > +		if (!(args.bp->b_flags & XBF_VERITY_CHECKED))
> > +			is_checked = false;
> 
> If there's enough memory pressure to cause the merkle tree pages to get
> evicted, what are the chances that the xfs_bufs survive the eviction?

The merkle tree pages are dropped after verification. When page is
dropped xfs_buf is marked as verified. If fs-verity wants to
verify again it will get the same verified buffer. If buffer is
evicted it won't have verified state.

So, with enough memory pressure buffers will be dropped and need to
be reverified.

> 
> > +		memcpy(page_address(page) + offset, args.value, args.valuelen);
> > +		kmem_free(args.value);
> > +		args.value = NULL;
> > +	}
> > +
> > +	if (is_checked)
> >  		SetPageChecked(page);
> > +	page->private = (unsigned long)buf_list;
> >  
> > -	page->private = (unsigned long)args.bp;
> > -	memcpy(page_address(page), args.value, args.valuelen);
> > -
> > -	kmem_free(args.value);
> >  	return page;
> >  }
> >  
> > @@ -191,16 +228,21 @@ xfs_write_merkle_tree_block(
> >  
> >  static void
> >  xfs_drop_page(
> > -	struct page	*page)
> > +	struct page			*page)
> >  {
> > -	struct xfs_buf *buf = (struct xfs_buf *)page->private;
> > +	int				i = 0;
> > +	struct xfs_verity_buf_list	*buf_list =
> > +		(struct xfs_verity_buf_list *)page->private;
> >  
> > -	ASSERT(buf != NULL);
> > +	ASSERT(buf_list != NULL);
> >  
> > -	if (PageChecked(page))
> > -		buf->b_flags |= XBF_VERITY_CHECKED;
> > +	for (i = 0; i < buf_list->buf_count; i++) {
> > +		if (PageChecked(page))
> > +			buf_list->bufs[i]->b_flags |= XBF_VERITY_CHECKED;
> > +		xfs_buf_rele(buf_list->bufs[i]);
> > +	}
> >  
> > -	xfs_buf_rele(buf);
> > +	kmem_free(buf_list);
> >  	put_page(page);
> >  }
> >  
> > diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
> > index ae5d87ca32a8..433b2f4ae3bc 100644
> > --- a/fs/xfs/xfs_verity.h
> > +++ b/fs/xfs/xfs_verity.h
> > @@ -16,4 +16,12 @@ extern const struct fsverity_operations xfs_verity_ops;
> >  #define xfs_verity_ops NULL
> >  #endif	/* CONFIG_FS_VERITY */
> >  
> > +/* Minimal Merkle tree block size is 1024 */
> > +#define XFS_VERITY_MAX_MBLOCKS_PER_PAGE (1 << (PAGE_SHIFT - 10))
> > +
> > +struct xfs_verity_buf_list {
> > +	unsigned int	buf_count;
> > +	struct xfs_buf	*bufs[XFS_VERITY_MAX_MBLOCKS_PER_PAGE];
> 
> So... this is going to be a 520-byte allocation on arm64 with 64k pages?
> Even if the merkle tree block size is the same as the page size?  Ouch.

yeah, it also allocates a page and is dropped with the page, so,
I took it as an addition to already big chunk of memory. But I
probably will change it, viz. comment from Eric on this patch.

-- 
- Andrey

