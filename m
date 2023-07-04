Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED77476C2
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jul 2023 18:29:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rYhrvsNp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwSt74xsFz3c4M
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 02:29:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rYhrvsNp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=kbusch@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwSsS6hC3z3c4D
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 02:28:44 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1A3D9612CF;
	Tue,  4 Jul 2023 16:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8C9C433C7;
	Tue,  4 Jul 2023 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688488122;
	bh=ZbfFFniWhSahnp7jSJ3oIaV9POCcbiLvynkhKSgpXe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYhrvsNpwqCJwn41eekT5X8PaPVwBQ6ub8Netmz5zCPt/qzVPnkLxH2Kjiq9nv1Cm
	 yUeZjhUrBrMq2ThgKqf6VqdUdYp1P2/zpT5yvYD7siJiybpmyKwoPpaa5gXpr6CMMv
	 akxinQnPPwXHrxodKNqiTb/6JTMYG4lY9mmxI0dhS9y7wawVJYcWdRHa64BuE/8weJ
	 eX7co1v82fmGWp5kKAm9BaeWX8/tRjFqKX1EDWvGtKd5aZ5LCCXaAY86lmuE5eezEu
	 Ix6OVXIAm9Wp1Cia2H4ClFO9rKC6nhjukt+dwjQnGXu6F26u0+VUNsprhPIs/s+nRo
	 qHwq5/jxHTM8Q==
Date: Tue, 4 Jul 2023 10:28:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Message-ID: <ZKRItBRhm8f5Vba/@kbusch-mbp>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704122224.16257-1-jack@suse.cz>
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
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>, linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>, Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Kent Overstreet <kent.overstreet@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Trond Myklebust <trond.myklebust@hammers
 pace.com>, Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 04, 2023 at 02:21:28PM +0200, Jan Kara wrote:
> +struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
> +		void *holder, const struct blk_holder_ops *hops)
> +{
> +	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
> +					     GFP_KERNEL);

I believe 'sizeof(*handle)' is the preferred style.

> +	struct block_device *bdev;
> +
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
> +	if (IS_ERR(bdev))
> +		return ERR_CAST(bdev);

Need a 'kfree(handle)' before the error return. Or would it be simpler
to get the bdev first so you can check the mode settings against a
read-only bdev prior to the kmalloc?

> +	handle->bdev = bdev;
> +	handle->holder = holder;
> +	return handle;
> +}
> +EXPORT_SYMBOL(blkdev_get_handle_by_dev);
> +
>  /**
>   * blkdev_get_by_path - open a block device by name
>   * @path: path to the block device to open
> @@ -884,6 +902,28 @@ struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
>  }
>  EXPORT_SYMBOL(blkdev_get_by_path);
>  
> +struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
> +		void *holder, const struct blk_holder_ops *hops)
> +{
> +	struct bdev_handle *handle;
> +	dev_t dev;
> +	int error;
> +
> +	error = lookup_bdev(path, &dev);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	handle = blkdev_get_handle_by_dev(dev, mode, holder, hops);
> +	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
> +	    bdev_read_only(handle->bdev)) {
> +		blkdev_handle_put(handle);
> +		return ERR_PTR(-EACCES);
> +	}
> +
> +	return handle;
> +}
> +EXPORT_SYMBOL(blkdev_get_handle_by_path);
