Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F86D678E
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 17:37:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrX246bzJz3cgm
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 01:37:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ahkq88G6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+8568051c7530f6265d9e+7163+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ahkq88G6;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrX1y3j1yz3cCF
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 01:37:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RdOI5GFBXvz2+CG+FGj78+ixvujqTitirHZIon4ASxI=; b=Ahkq88G655jnqkQwTcWuEN6RRq
	h8yjZsKe+Ya6vZx2aj5qznyop6e9Fzt7P3UjXbJv3YvhdNnBewCyzgwcmFuLfVIeeo8HxJITi6zqF
	VoJUTlDJH5weysUFBompr1TeaFJM8Cz/IkuTB8joY0PeYjQN3d5QSaNxM/Z9JSHb6bQ7wMMntt34l
	7HaqQ/BUxGKLrBBoO7LliRbNqk1tsSJOHBjuMuQ7qPPZJPANfHUxtfGJ6ugxXpXKnJP4ZjWXMUpqq
	uLWr5qtFE8Do8CSM76bQ0+Ns9i69roqtrrCuU0gAnh3o2vzYHSwZCxKjZFPcpTofIEqLTRS34odrA
	LrFUS5OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pjiiU-0021sG-0G;
	Tue, 04 Apr 2023 15:37:02 +0000
Date: Tue, 4 Apr 2023 08:37:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 09/23] iomap: allow filesystem to implement read path
 verification
Message-ID: <ZCxEHkWayQyGqnxL@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-10-aalbersh@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

>  	if (iomap_block_needs_zeroing(iter, pos)) {
>  		folio_zero_range(folio, poff, plen);
> +		if (iomap->flags & IOMAP_F_READ_VERITY) {

Wju do we need the new flag vs just testing that folio_ops and
folio_ops->verify_folio is non-NULL?

> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> +				REQ_OP_READ, GFP_NOFS, &iomap_read_ioend_bioset);

All other callers don't really need the larger bioset, so I'd avoid
the unconditional allocation here, but more on that later.

> +		ioend = container_of(ctx->bio, struct iomap_read_ioend,
> +				read_inline_bio);
> +		ioend->io_inode = iter->inode;
> +		if (ctx->ops && ctx->ops->prepare_ioend)
> +			ctx->ops->prepare_ioend(ioend);
> +

So what we're doing in writeback and direct I/O, is to:

 a) have a submit_bio hook
 b) allow the file system to then hook the bi_end_io caller
 c) (only in direct O/O for now) allow the file system to provide
    a bio_set to allocate from

I wonder if that also makes sense and keep all the deferral in the
file system.  We'll need that for the btrfs iomap conversion anyway,
and it seems more flexible.  The ioend processing would then move into
XFS.

> @@ -156,6 +160,11 @@ struct iomap_folio_ops {
>  	 * locked by the iomap code.
>  	 */
>  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +
> +	/*
> +	 * Verify folio when successfully read
> +	 */
> +	bool (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);

Why isn't this in iomap_readpage_ops?
