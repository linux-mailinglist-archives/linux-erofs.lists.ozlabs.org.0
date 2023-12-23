Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210C81D55B
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Dec 2023 18:33:49 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=n5ecZBTz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SyB933KJqz3c3v
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Dec 2023 04:33:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=n5ecZBTz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SyB8r2wbhz30ht
	for <linux-erofs@lists.ozlabs.org>; Sun, 24 Dec 2023 04:33:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cxs7b1r/Fe+mA08T4R0mNQ1fxv7+YhK2lTuot6SaQik=; b=n5ecZBTziYZYMztlj2287d4czK
	ml7cm9aw1T+0iVgkbnWKxaTTXKBcb46wrTtLR2cpZ6JzPt87e/ZOk+YN+BcmHpGceFYQwbG6TCmUn
	2/VVFTmvky5olmxAfDG+0qZ8z+LPPpf8u70Ai7d5Slq1K484QQZDKCm7dBvsESdFibfIkn0wHOZFA
	dZJMlBYBjYa9hkvZpbAVrPS56AMkvhhCeNeu4AfGdy+6akR7Z9BIJQ6lfh3OOUC9V+pNhgGo/mfiK
	S401NuO0YUaMlRsvZHgjfMbObBG2ZmuSJGS1ljZCYKmYCBguSKNIaneuWlwbS7egy1SGKjDV3fGW4
	digukkoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rH5qt-00BIro-7V; Sat, 23 Dec 2023 17:31:55 +0000
Date: Sat, 23 Dec 2023 17:31:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 09/17] btrfs: use bdev apis
Message-ID: <ZYcZi5YYvt5QHrG9@casper.infradead.org>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-10-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085712.1766333-10-yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, linux-erofs@lists.ozlabs.org, linux-btrfs@v
 ger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 21, 2023 at 04:57:04PM +0800, Yu Kuai wrote:
> @@ -3674,16 +3670,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>  		 * Drop the page of the primary superblock, so later read will
>  		 * always read from the device.
>  		 */
> -		invalidate_inode_pages2_range(mapping,
> -				bytenr >> PAGE_SHIFT,
> +		invalidate_bdev_range(bdev, bytenr >> PAGE_SHIFT,
>  				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>  	}
>  
> -	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> -	if (IS_ERR(page))
> -		return ERR_CAST(page);
> +	nofs_flag = memalloc_nofs_save();
> +	folio = bdev_read_folio(bdev, bytenr);
> +	memalloc_nofs_restore(nofs_flag);

This is the wrong way to use memalloc_nofs_save/restore.  They should be
used at the point that the filesystem takes/releases whatever lock is
also used during reclaim.  I don't know btrfs well enough to suggest
what lock is missing these annotations.

