Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2980682D
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 08:22:16 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hhRbaenX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlTPL2yDhz3cV1
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 18:22:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hhRbaenX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+2d31c4bdfe93494595b7+7409+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlTPH0dlHz2yN3
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 18:22:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qmCAsGLsB31X5J4lJ2nHtJS8+MwGW1F5WEYO0jIziI0=; b=hhRbaenXZsjRyFtp5oCl7ZLapp
	PGbBHBMazopo9x7zLycOLomgyozjMFDmXz0mBlHcwPG5BI6SfQiEYs2RFIxTkHszoMBIB5fp7RvF5
	vaqpcOeQKcUjsuqauqy5BsIY31xjg/0sVfUccDbi5kKXOZc7fS1d0vbSOWjK1ECcJERDPQIM6Icyq
	pZ82Y80XxVZAy+fiqCF56whvlLXWz/53NURq30p1NEOux+n0cJVqd1itpsG6+3wl1H+zQ95RNHzGZ
	8Wbn2E17f06JWnxiq2s6y4vOb2NT9ha36DJvWW/HkrWz3MeH9YEasxDh/aL/9GmJ56G3rYqKjOoGL
	m/NxJEIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAmDz-009HyE-2v;
	Wed, 06 Dec 2023 07:21:39 +0000
Date: Tue, 5 Dec 2023 23:21:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next RFC 02/14] xen/blkback: use bdev api in
 xen_update_blkif_status()
Message-ID: <ZXAhA0WUXoF5YEq4@infradead.org>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-3-yukuai1@huaweicloud.com>
 <ZXAMwBD8pd48qwX/@infradead.org>
 <783b5515-db42-c77f-62ab-050f7cc8ef5e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <783b5515-db42-c77f-62ab-050f7cc8ef5e@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, Christoph Hellwig <hch@infradead.org>, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, sth@linux.ibm.com, "yukuai \(C\)" <yukuai3@huawei.com>, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, li
 nux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, roger.pau@citrix.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 06, 2023 at 02:56:05PM +0800, Yu Kuai wrote:
> > > -	invalidate_inode_pages2(
> > > -			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
> > > +	invalidate_bdev(blkif->vbd.bdev_handle->bdev);
> > 
> > blkbak is a bdev exported.   I don't think it should ever call
> > invalidate_inode_pages2, through a wrapper or not.
> 
> I'm not sure about this. I'm not familiar with xen/blkback, but I saw
> that xen-blkback will open a bdev from xen_vbd_create(), hence this
> looks like a dm/md for me, hence it sounds reasonable to sync +
> invalidate the opened bdev while initialization. Please kindly correct
> me if I'm wrong.

I guess we have enough precedence for this, so the switchover here
isn't wrong.  But all this invalidating of the bdev cache seems to
be asking for trouble.

