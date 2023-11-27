Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC8C7F9AD9
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 08:23:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HmhTUB6B;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SdxrT55Jsz3cRq
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 18:23:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=198.137.202.133; helo=bombadil.infradead.org; envelope-from=batv+6fdacddc1aa5db9ef0e1+7400+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sdxr60l4Bz2xl6
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Nov 2023 18:22:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bbFcmB19INmvUTx5j+M9jRyJXBnU+PmCLplmYes7xKg=; b=HmhTUB6Bgh7OnZuv3MNiTVnfXC
	c22YIG8T5br8hsKMu41mjZ9/cx++C8wVTWDYSvUAH36xMkip5/yiTG260lY2rrIM/r+C0G+isp9uF
	etkeNOURS8fQD6aPmSdyzSSGKWF+pTqcC1ZGT7oZVvUTVk9QpHYUf0FBUrJw19CADdPVngmSrijuO
	IOMUdcJcEkdHTqMAdFx1L+mfGJd3fWDG081TsGYrqYpe4ADrF5w0LuzxW+1HqJjso+aXzjyCht+N2
	tYj8ta2d171C20L5JBM/BAzza5S6Fp5sV5ukto8ZE9jI63+MJW0c2xIdTP/sw0+cxDdqp7qdN9Sak
	f2DjTQ3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Vvt-001iAl-0W;
	Mon, 27 Nov 2023 07:21:29 +0000
Date: Sun, 26 Nov 2023 23:21:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH block/for-next v2 01/16] block: add a new helper to get
 inode from block_device
Message-ID: <ZWRDeQ4K8BiYnV+X@infradead.org>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127062116.2355129-2-yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org, richard@nod.at, willy@infradead.org, hch@infradead.org, xen-devel@lists.xenproject.org, yukuai3@huawei.com, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, dlemoal@kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com, dsterba@suse.com, ming.lei@redhat.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, linux-erofs@lists.ozlabs.org, yangerkun@huawei.com, linux@weissschuh.net, kent.overstre
 et@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, min15.li@samsung.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 27, 2023 at 02:21:01PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> block_devcie is allocated from bdev_alloc() by bdev_alloc_inode(), and
> currently block_device contains a pointer that point to the address of
> inode, while such inode is allocated together:

This is going the wrong way.  Nothing outside of core block layer code
should ever directly use the bdev inode.  We've been rather sloppy
and added a lot of direct reference to it, but they really need to
go away and be replaced with well defined high level operation on
struct block_device.  Once that is done we can remove the bd_inode
pointer, but replacing it with something that pokes even more deeply
into bdev internals is a bad idea.
