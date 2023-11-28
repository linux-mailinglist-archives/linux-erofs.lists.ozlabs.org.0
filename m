Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DFC7FB18D
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Nov 2023 06:49:22 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zxF6+s0S;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SfWjm4cFmz3cP7
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Nov 2023 16:49:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zxF6+s0S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+011e5a6fe4263adb6d23+7401+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SfWjc49wZz3bYc
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Nov 2023 16:49:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=piX6sU8uUfRdM3HI4C5o5RtKyEk7LebUsWmX5nAnS9s=; b=zxF6+s0SCn2mTM1F5sDGatwdiD
	r+J5EdNg/JbVc8/TEwBGrSiUOrPltOv0SB5DHqEzye3x5UYQ3y43F+9CYP+YH9zZju4MAnIxN7jLr
	52H6aTiRg9m6ogsTbJ455qxXjn6rKf3EheShZA+8TlQ0nbft+l3Lre4a0bU7FkEs+H18O/xb4HfZ2
	DcIkdp3IB1Vc74yjq/SGmA7ZBc/H0ChYb2skCnNlw+1loprwzCvOOZXqJXWMJW983aVx/FvifwWE8
	GXy6mVkavESjy4cQk0Ees741WqX1/u5t1i6oo5VnA69qG8fgQUNZnB/k4V2ZDGbJGb/SxQnB+AlVf
	iSo+n9HA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7qxI-004BPZ-2N;
	Tue, 28 Nov 2023 05:48:20 +0000
Date: Mon, 27 Nov 2023 21:48:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH block/for-next v2 01/16] block: add a new helper to get
 inode from block_device
Message-ID: <ZWV/JBxrrGXzY0gr@infradead.org>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-2-yukuai1@huaweicloud.com>
 <ZWRDeQ4K8BiYnV+X@infradead.org>
 <6acdeece-7163-3219-95e2-827e54eadd0c@huaweicloud.com>
 <ZWTErvnMf7HiO1Wj@infradead.org>
 <bc64da80-e9bd-84cb-f173-876623303131@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc64da80-e9bd-84cb-f173-876623303131@huaweicloud.com>
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

On Tue, Nov 28, 2023 at 09:35:56AM +0800, Yu Kuai wrote:
> Thanks for the advice! In case I'm understanding correctly, do you mean
> that all other fs/drivers that is using pages versions can safely switch
> to folio versions now?

If you never allocate a high-order folio pages are identical to folios.
So yes, we can do folio based interfaces only, and also use that as
an opportunity to convert over the callers.

> By the way, my orginal idea was trying to add a new field 'bd_flags'
> in block_devcie, and then add a new bit so that bio_check_ro() will
> only warn once for each partition. Now that this patchset will be quite
> complex, I'll add a new bool field 'bd_ro_warned' to fix the above
> problem first, and then add 'bd_flags' once this patchset is done.

Yes, please do a minimal version if you can find space where the
rmw cycles don't cause damage to neighbouring fields.  Or just leave
the current set of warnings in if it's too hard.

