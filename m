Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91605806734
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 07:14:31 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZSLgTwnr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlRv90GwFz3cWD
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 17:14:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZSLgTwnr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+2d31c4bdfe93494595b7+7409+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlRv50SLCz3cDk
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 17:14:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4/ZwiAtDqcKncE9Sxs1fDYOC2BzoaQU34ADFgY4TSSs=; b=ZSLgTwnreLOPqcun4IeSE9ItZu
	PnTWx9UHdSzDOMw03zhM4iJWbD050LQsUFBy4f4oO/I2CEfLxgu6VKI/48QpINdzGnuBN/4jhcnWn
	T6OU37rwGxHJqPa/Z53FU9Yr3Z/lHh82wcz4yXLaNizP/+ST3MBO3FUnRt49dArLwuH65rXSylY7S
	NM9uVZ0jYQFEdnnGM7iibI2Uo0n82j5ujsUAs74TacZS+egwtqhpWfEnDXYYMvxse9S8X7lLVbUAE
	/Uc2UOgBsAQP0Wf1EQ01B4RrecJ+UvN+DuxFci/PVUUXzcCfKe+xsAO/GPTkS0EmtvxKJn5csRJAc
	38PBAwUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAlAW-009B0t-1J;
	Wed, 06 Dec 2023 06:14:00 +0000
Date: Tue, 5 Dec 2023 22:14:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <ZXARKD0OmjLrvHmU@infradead.org>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205123728.1866699-2-yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, sth@linux.ibm.com, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
  roger.pau@citrix.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> +void invalidate_bdev_range(struct block_device *bdev, pgoff_t start,
> +			   pgoff_t end)
> +{
> +	invalidate_mapping_pages(bdev->bd_inode->i_mapping, start, end);
> +}
> +EXPORT_SYMBOL_GPL(invalidate_bdev_range);

All these could probably use kerneldoc comments.

For this one I really don't like it existing at all, but we'll have to
discuss that in the btrfs patch.

> +loff_t bdev_size(struct block_device *bdev)
> +{
> +	loff_t size;
> +
> +	spin_lock(&bdev->bd_size_lock);
> +	size = i_size_read(bdev->bd_inode);
> +	spin_unlock(&bdev->bd_size_lock);
> +
> +	return size;
> +}
> +EXPORT_SYMBOL_GPL(bdev_size);

No need for this one.  The callers can simply use bdev_nr_bytes.

> +struct folio *bdev_read_folio(struct block_device *bdev, pgoff_t index)
> +{
> +	return read_mapping_folio(bdev->bd_inode->i_mapping, index, NULL);
> +}
> +EXPORT_SYMBOL_GPL(bdev_read_folio);
> +
> +struct folio *bdev_read_folio_gfp(struct block_device *bdev, pgoff_t index,
> +				  gfp_t gfp)
> +{
> +	return mapping_read_folio_gfp(bdev->bd_inode->i_mapping, index, gfp);
> +}
> +EXPORT_SYMBOL_GPL(bdev_read_folio_gfp);

I think we can just drop bdev_read_folio_gfp. Half of the callers simply
pass GPK_KERNEL, and the other half passes GFP_NOFS and could just use
memalloc_nofs_save().

> +void bdev_balance_dirty_pages_ratelimited(struct block_device *bdev)
> +{
> +	return balance_dirty_pages_ratelimited(bdev->bd_inode->i_mapping);
> +}
> +EXPORT_SYMBOL_GPL(bdev_balance_dirty_pages_ratelimited);

Hmm, this is just used for block2mtd, and feels a little too low-level
to me, as block2mtd really should be using the normal fileread/write
APIs.  I guess we'll have to live with it for now if we want to expedite
killing off bd_inode.

> +void bdev_correlate_mapping(struct block_device *bdev,
> +			    struct address_space *mapping)
> +{
> +	mapping->host = bdev->bd_inode;
> +}
> +EXPORT_SYMBOL_GPL(bdev_correlate_mapping);

Maybe associated insted of correlate?  Either way this basically
fully exposes the bdev inode again :(

> +gfp_t bdev_gfp_constraint(struct block_device *bdev, gfp_t gfp)
> +{
> +	return mapping_gfp_constraint(bdev->bd_inode->i_mapping, gfp);
> +}
> +EXPORT_SYMBOL_GPL(bdev_gfp_constraint);

The right fix here is to:

 - use memalloc_nofs_save in extet instead of using
   mapping_gfp_constraint to clear it from the mapping flags
 - remove __ext4_sb_bread_gfp and just have buffer.c helper that does
   the right thing (either by changing the calling conventions of an
   existing one, or adding a new one).

> +/*
> + * The del_gendisk() function uninitializes the disk-specific data
> + * structures, including the bdi structure, without telling anyone
> + * else.  Once this happens, any attempt to call mark_buffer_dirty()
> + * (for example, by ext4_commit_super), will cause a kernel OOPS.
> + * This is a kludge to prevent these oops until we can put in a proper
> + * hook in del_gendisk() to inform the VFS and file system layers.
> + */
> +int bdev_ejected(struct block_device *bdev)
> +{
> +	struct backing_dev_info *bdi = inode_to_bdi(bdev->bd_inode);
> +
> +	return bdi->dev == NULL;
> +}
> +EXPORT_SYMBOL_GPL(bdev_ejected);

And this code in ext4 should just go away entirely.  The bdi should
always be valid for a live bdev for years.

> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1119,6 +1119,7 @@ void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
>  	WARN_ON_ONCE(off > UINT_MAX);
>  	__bio_add_page(bio, &folio->page, len, off);
>  }
> +EXPORT_SYMBOL_GPL(bio_add_folio_nofail);

How is this realted?  The export is fine, but really should be a
separate, well-documented commit.

>  
> +static inline u8 block_bits(struct block_device *bdev)
> +{
> +	return bdev->bd_inode->i_blkbits;
> +}

Not sure we should need this.  i_blkbits comes from the blocksize
the fs set, so it should have other ways to get at it.
