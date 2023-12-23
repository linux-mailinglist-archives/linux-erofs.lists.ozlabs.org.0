Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299081D623
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Dec 2023 19:47:50 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mLUUfEd7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SyCpS4KRmz3c84
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Dec 2023 05:47:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mLUUfEd7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b7; helo=out-183.mta1.migadu.com; envelope-from=kent.overstreet@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 463 seconds by postgrey-1.37 at boromir; Sun, 24 Dec 2023 05:47:37 AEDT
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SyCpK3Ycjz2yhT
	for <linux-erofs@lists.ozlabs.org>; Sun, 24 Dec 2023 05:47:37 +1100 (AEDT)
Date: Sat, 23 Dec 2023 13:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703356772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nl8KqWKpD6wWjbvJJznLUba3EPd6rpJb9056eV80EZI=;
	b=mLUUfEd7gfPYDe3oleQ9tbdyTO5xnWBH1tZ17cgI4qqbATl0NNgyxkk9s86/LqjribMhXF
	icSGv6krf/Bb8nP/Rk+sLamzbNdocnFQ0i9s/yQOF2bzXjM3YAZVaDOCpBwjSIvilLWEoR
	/klCC3TPr9UUNblk28yYvK2TJLs04lQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v3 for-6.8/block 09/17] btrfs: use bdev apis
Message-ID: <j52xmye4qmjqv4mq524ppvqr7naicobnwn2qfcvftbj4zoowga@t6klttrjtq2d>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-10-yukuai1@huaweicloud.com>
 <ZYcZi5YYvt5QHrG9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYcZi5YYvt5QHrG9@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, linux-er
 ofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Dec 23, 2023 at 05:31:55PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 21, 2023 at 04:57:04PM +0800, Yu Kuai wrote:
> > @@ -3674,16 +3670,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> >  		 * Drop the page of the primary superblock, so later read will
> >  		 * always read from the device.
> >  		 */
> > -		invalidate_inode_pages2_range(mapping,
> > -				bytenr >> PAGE_SHIFT,
> > +		invalidate_bdev_range(bdev, bytenr >> PAGE_SHIFT,
> >  				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
> >  	}
> >  
> > -	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> > -	if (IS_ERR(page))
> > -		return ERR_CAST(page);
> > +	nofs_flag = memalloc_nofs_save();
> > +	folio = bdev_read_folio(bdev, bytenr);
> > +	memalloc_nofs_restore(nofs_flag);
> 
> This is the wrong way to use memalloc_nofs_save/restore.  They should be
> used at the point that the filesystem takes/releases whatever lock is
> also used during reclaim.  I don't know btrfs well enough to suggest
> what lock is missing these annotations.

Yes, but considering this is a cross-filesystem cleanup I wouldn't want
to address that in this patchset. And the easier, more incremental
approach for the conversion would be to first convert every GFP_NOFS
usage  to memalloc_nofs_save() like this patch does, as small local
changes, and then let the btrfs people combine them and move them to the
approproate location in a separate patchstet.
