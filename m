Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B27F8BB4
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Nov 2023 15:33:11 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tb+b1AGj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ScvTd3NDtz3cSK
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Nov 2023 01:33:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tb+b1AGj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ScvTW66j1z3bq4
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Nov 2023 01:33:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CD2BD60C23;
	Sat, 25 Nov 2023 14:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF1EC433C9;
	Sat, 25 Nov 2023 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700922779;
	bh=oSd7BcOK3bP0I8DfntCNNyxB1mRx7mQJk5aYCZ56Jps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb+b1AGjl66gEFJb49YPJaFeRIASRiFOTSxrZYFb/9UEMzhBhJ7dj03XjtnQqURkF
	 TfRgGHRdUiAjOE44N/FKpf7JzCF5V8n47LggUk8mYZ6WAEYe+BIWeDP2a/vA3Woy4L
	 +jv6Fe3Kj+6ny2tml8PShu+0hReicMnk89ZJEMIM=
Date: Sat, 25 Nov 2023 14:32:55 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] block: remove field 'bd_inode' from block_device
Message-ID: <2023112544-subpanel-national-58e5@gregkh>
References: <20231125093912.141486-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125093912.141486-1-yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, hch@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, dlemoal@kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com, dsterba@suse.com, ming.lei@redhat.com, konishi.ryusuke@gmail.com, yukuai3@huawei.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, linux-erofs@lists.ozlabs.org, yangerkun@huawei.com, linux@weissschuh.net, kent.overstre
 et@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, min15.li@samsung.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Nov 25, 2023 at 05:39:12PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> block_devcie is allocated from bdev_alloc() by bdev_alloc_inode(), and
> currently block_device contains a pointer that point to the address of
> inode, while such inode is allocated together:
> 
> bdev_alloc
>  inode = new_inode()
>   // inode is &bdev_inode->vfs_inode
>  bdev = I_BDEV(inode)
>   // bdev is &bdev_inode->bdev
>  bdev->inode = inode
> 
> Add a new helper to get address of inode from bdev by add operation
> instead of memory access, which is more efficiency. Also prepare to
> add a new field 'bd_flags' in the first cacheline(64 bytes).
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bdev.c                       | 39 +++++++++++++++++-------------
>  block/blk-zoned.c                  |  4 +--
>  block/fops.c                       |  4 +--
>  block/genhd.c                      |  8 +++---
>  block/ioctl.c                      |  8 +++---
>  block/partitions/core.c            |  9 ++++---
>  drivers/block/xen-blkback/xenbus.c |  2 +-
>  drivers/md/bcache/super.c          |  2 +-
>  drivers/mtd/devices/block2mtd.c    | 12 ++++-----
>  drivers/s390/block/dasd_ioctl.c    |  2 +-
>  drivers/scsi/scsicam.c             |  2 +-
>  fs/bcachefs/util.h                 |  2 +-
>  fs/btrfs/disk-io.c                 |  6 ++---
>  fs/btrfs/volumes.c                 |  4 +--
>  fs/btrfs/zoned.c                   |  2 +-
>  fs/buffer.c                        |  8 +++---
>  fs/cramfs/inode.c                  |  2 +-
>  fs/erofs/data.c                    |  2 +-
>  fs/ext4/dir.c                      |  2 +-
>  fs/ext4/ext4_jbd2.c                |  2 +-
>  fs/ext4/super.c                    |  8 +++---
>  fs/gfs2/glock.c                    |  2 +-
>  fs/gfs2/ops_fstype.c               |  2 +-
>  fs/jbd2/journal.c                  |  3 ++-
>  fs/jbd2/recovery.c                 |  2 +-
>  fs/nilfs2/segment.c                |  2 +-
>  include/linux/blk_types.h          | 10 ++++++--
>  include/linux/blkdev.h             |  4 +--
>  include/linux/buffer_head.h        |  4 +--
>  29 files changed, 86 insertions(+), 73 deletions(-)

You should do this as a patch series, add the helper function that does
nothing, convert all the different portions of the kernel as different
patches, and _then_ change the implementation of the block layer to
handle the change in the structure.

Otherwise this is going to be hard to get accepted.

Also, one note:

> @@ -85,6 +84,13 @@ struct block_device {
>  #define bdev_kobj(_bdev) \
>  	(&((_bdev)->bd_device.kobj))
>  
> +static inline struct inode *bdev_inode(struct block_device *bdev)
> +{
> +	void *inode = bdev + 1;

That's crazy, if something changes, this will keep working yet the
kernel will break and no one will know why.

Please use container_of(), that's what it is there for, this exact type
of thing.  Or if not, are you just assuming that the memory location
right after bdev is the inode?  That's a tough assumption, how are you
going to assure it really stays there?

thanks,

greg k-h
