Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F397FA683
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 17:33:40 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3w8bJekj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SfB3j4blZz3cT7
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Nov 2023 03:33:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3w8bJekj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6fdacddc1aa5db9ef0e1+7400+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SfB3Y5Tkjz2yMJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Nov 2023 03:33:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N2zDXv8N842SdWeP1QfvmzEvIcEsyQplx8msSV1RBzc=; b=3w8bJekjauD14xkhiSXsSeP1yp
	9N3b2DKZZPdBt27xj1DIEE7RXLXZrvHxDKR2sRYD21pNAAIJ3vl1ZCKZ4NFvv5G6xjzqey6N1n0KK
	ZrI0nakNUBsMEbW2Q4e4j1NRh5OeO1tyxIFUhlV8EaqwcQbah9MgH17+QPadh0DqL/pm4sqZ5f/vV
	IH1EMWIP6up9ybGx4dw0MvcLdLRClPIEOMfWizJpOcO8WEMAVnlOuY5kgUVe2HK2Xt75AhDq2qkmf
	jzAFQBFfr3qP/5tAASIdgOPBH9JmPj2A8s0x9fJ50RYVccYl2K4OsZZ71u82sMqjEZ1B5f5BIa6y8
	Lia9qiAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eXO-0030D4-22;
	Mon, 27 Nov 2023 16:32:46 +0000
Date: Mon, 27 Nov 2023 08:32:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH block/for-next v2 01/16] block: add a new helper to get
 inode from block_device
Message-ID: <ZWTErvnMf7HiO1Wj@infradead.org>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-2-yukuai1@huaweicloud.com>
 <ZWRDeQ4K8BiYnV+X@infradead.org>
 <6acdeece-7163-3219-95e2-827e54eadd0c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acdeece-7163-3219-95e2-827e54eadd0c@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, Christoph Hellwig <hch@infradead.org>, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, dlemoal@kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com, dsterba@suse.com, ming.lei@redhat.com, konishi.ryusuke@gmail.com, "yukuai \(C\)" <yukuai3@huawei.com>, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, linux-erofs@lists.ozlabs.org, yangerkun@huawei.com
 , linux@weissschuh.net, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, min15.li@samsung.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 27, 2023 at 09:07:22PM +0800, Yu Kuai wrote:
> 1) Is't okay to add a new helper to pass in bdev for following apis?


For some we already have them (e.g. bdev_nr_bytes to read the bdev)
size, for some we need to add them.  The big thing that seems to
stick out is page cache API, and I think that is where we need to
define maintainable APIs for file systems and others to use the
block device page cache.  Probably only in folio versions and not
pages once if we're touching the code anyay

> 2) For the file fs/buffer.c, there are some special usage like
> following that I don't think it's good to add a helper:
> 
> spin_lock(&bd_inode->i_mapping->private_lock);
> 
> Is't okay to move following apis from fs/buffer.c directly to
> block/bdev.c?
> 
> __find_get_block
> bdev_getblk

I'm not sure moving is a good idea, but we might end up the
some kind of low-level access from buffer.c, be that special
helpers, a separate header or something else.  Let's sort out
the rest of the kernel first.

