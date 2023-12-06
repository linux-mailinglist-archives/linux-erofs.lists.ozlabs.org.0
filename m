Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103A480733A
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 16:00:05 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ojDk7+bv;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlgYY4WNzz3cDy
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Dec 2023 02:00:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ojDk7+bv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlgYP318Nz2ykZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Dec 2023 01:59:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s+7kV2NOaPEBmhFkJpDv/pC5Llv4VXEE9i8fdKbvmjw=; b=ojDk7+bvhmkVaj86d9uPvOhQaz
	kbAJJlz3eiFA7yxHtxf02BCaqsNM5pS9C8k5lXRoPly3/N/e0u5QADIgtZKFOwGOJtwsI5ZzSsYPS
	PKyktYqelsFB3E+G8W+4/yQSFmaQ2jHSWEigX57CwcwQszQ0bDoxOOqdU2sc0+ZoE3Ff1wwcpqslV
	VWLgXJnu2MrDZGBo0sVLqXRdAvGI+d1WdlsXWEVkM0crARzZz5+nD3AR2Avd8/g6eRde0hkW/FoXX
	agEz57imZpOlmdW73T5pzua0TfxBEP/xRZ/WXwPlD7/tpJRN5cqF7OvXJrtIdGRYW6omWvwYwBXvA
	OJr6nVaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rAtMN-002zkJ-Nc; Wed, 06 Dec 2023 14:58:47 +0000
Date: Wed, 6 Dec 2023 14:58:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <ZXCMJ9skAAgPm4z3@casper.infradead.org>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205123728.1866699-2-yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, sth@linux.ibm.com, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, roger.pau@citrix.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 05, 2023 at 08:37:15PM +0800, Yu Kuai wrote:
> +struct folio *bdev_read_folio(struct block_device *bdev, pgoff_t index)
> +{
> +	return read_mapping_folio(bdev->bd_inode->i_mapping, index, NULL);
> +}
> +EXPORT_SYMBOL_GPL(bdev_read_folio);

I'm coming to the opinion that 'index' is the wrong parameter here.
Looking through all the callers of bdev_read_folio() in this patchset,
they all have a position in bytes, and they all convert it to
index for this call.  The API should probably be:

struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos)
{
	return read_mapping_folio(bdev->bd_inode->i_mapping,
			pos / PAGE_SIZE, NULL);
}

... and at some point, we'll get round to converting read_mapping_folio()
to take its argument in loff_t.

Similiarly for these two APIs:

> +struct folio *bdev_read_folio_gfp(struct block_device *bdev, pgoff_t index,
> +				  gfp_t gfp)
> +struct folio *bdev_get_folio(struct block_device *bdev, pgoff_t index)

> +struct folio *bdev_find_or_create_folio(struct block_device *bdev,
> +					pgoff_t index, gfp_t gfp)
> +{
> +	return __filemap_get_folio(bdev->bd_inode->i_mapping, index,
> +				   FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
> +}
> +EXPORT_SYMBOL_GPL(bdev_find_or_create_folio);

This one probably shouldn't exist.  I've been converting callers of
find_or_create_page() to call __filemap_get_folio; I suspect we
should expose a __bdev_get_folio and have the callers use the FGP
arguments directly, but I'm open to other opinions here.

> +void bdev_sync_readahead(struct block_device *bdev, struct file_ra_state *ra,
> +			 struct file *file, pgoff_t index,
> +			 unsigned long req_count)
> +{
> +	struct file_ra_state tmp_ra = {};
> +
> +	if (!ra) {
> +		ra = &tmp_ra;
> +		file_ra_state_init(ra, bdev->bd_inode->i_mapping);
> +	}
> +	page_cache_sync_readahead(bdev->bd_inode->i_mapping, ra, file, index,
> +				  req_count);
> +}

I think the caller should always be passing in a valid file_ra_state.
It's only cramfs that doesn't have one, and it really should!
Not entirely sure about the arguments here; part of me says "bytes",
but this is weird enough to maybe take arguments in pages.
