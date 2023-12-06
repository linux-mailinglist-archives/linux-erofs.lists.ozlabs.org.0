Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54B80770E
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 18:55:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=BH8TRkxS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SllSD32JGz3cPf
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Dec 2023 04:55:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=BH8TRkxS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mit.edu (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=lists.ozlabs.org)
X-Greylist: delayed 176 seconds by postgrey-1.37 at boromir; Thu, 07 Dec 2023 04:55:33 AEDT
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SllS50Vx8z3bws
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Dec 2023 04:55:31 +1100 (AEDT)
Received: from cwcc.thunk.org (pool-173-48-122-214.bstnma.fios.verizon.net [173.48.122.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B6Hodj2022646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 12:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701885052; bh=VZDVHdtsTza1iBjsN4e9taxM8QQIzumJOYNTH51fhro=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BH8TRkxS2KVaitLmv0fUh5MfTnRi8kxhm2QxRnobVHqRnCkm5tdQJ4YU7KzmgN2o9
	 OrT5ijrdbqD+8Tpl+UWv5WlzoZ4FfBRwcoZtXGHipfp3BKDuVw8Wb3OV8JHdDL++WR
	 fchowN0SphtUdvT2S+alJWDJDljYoM4HhCP8Oe9wGQPXflEuR9UupnRUlKWI1Qe2kg
	 kWiBMGCDi9IQPUcNW0bRqxHb1k7h5ks+vYGOrOHkVBn6CgZz1YTgrm04q9GDpzs5AE
	 AW77xm7xSTCpwyFB4QBf7egNa0Hpu3J4Iea+sXKNE2nV9yZ8sAlE3vS7vnXmXBUfDj
	 Vli7wjfFyI1og==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id F04EC15C057B; Wed,  6 Dec 2023 12:50:38 -0500 (EST)
Date: Wed, 6 Dec 2023 12:50:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <20231206175038.GJ509422@mit.edu>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
 <ZXARKD0OmjLrvHmU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXARKD0OmjLrvHmU@infradead.org>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, sth@linux.ibm.com, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-bt
 rfs@vger.kernel.org, roger.pau@citrix.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 05, 2023 at 10:14:00PM -0800, Christoph Hellwig wrote:
> > +/*
> > + * The del_gendisk() function uninitializes the disk-specific data
> > + * structures, including the bdi structure, without telling anyone
> > + * else.  Once this happens, any attempt to call mark_buffer_dirty()
> > + * (for example, by ext4_commit_super), will cause a kernel OOPS.
> > + * This is a kludge to prevent these oops until we can put in a proper
> > + * hook in del_gendisk() to inform the VFS and file system layers.
> > + */
> > +int bdev_ejected(struct block_device *bdev)
> > +{
> > +	struct backing_dev_info *bdi = inode_to_bdi(bdev->bd_inode);
> > +
> > +	return bdi->dev == NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(bdev_ejected);
> 
> And this code in ext4 should just go away entirely.  The bdi should
> always be valid for a live bdev for years.

This was added because pulling a mounted a USB thumb drive (or a HDD
drops off the SATA bus) while the file system is mounted and actively
in use, would result in a kernel OOPS.  If that's no longer true,
that's great, but it would be good to test to make sure this is the
case....

If we really want to remove it, I'd suggest doing this as a separate
commit, so that after we see syzbot reports, or users complaining
about kernel crashes, we can revert the removal if necessary.

Cheers,

					- Ted
