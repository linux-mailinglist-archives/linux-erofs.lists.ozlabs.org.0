Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 596517F9A31
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 07:49:03 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=X33IAizB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sdx5823MGz3cRl
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 17:49:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=X33IAizB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sdx510mqzz3bZM
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Nov 2023 17:48:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PRdjsHwBJnTnCFJ6KWMNGkw3R1XwKUQdbL+BMJT0K70=; b=X33IAizBXxOu44K+tKNOQcX6aN
	L3R58WnMzMuH49yXIvG7omqQGa3O2DELuiG9T0RDZfJfL9RxoTFv7kUL42tZGssHxvodfBhu53zAl
	oziCAbD1I4rfcGgYF7+pmO1j4z7VlfcJSt54k/bu5RznWMw8UGAKzI85OeNE+/rj2cbLblF4OE6VJ
	eTO7WwvbpkhSAH2j8YC9xxeFsHPww+97YyGIXXbr6H0E8B8/2bjSezQMUryHuqSaucYpxVB9Oms42
	fJOuOXLDq1bOpbdO9PADT2+G/2FCegqrb+HsEfhKX3cA8yGKyYkW0zp9+6loKz3FcpZ/JElMbJsDK
	wQbg0j1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7VP7-003r7k-26;
	Mon, 27 Nov 2023 06:47:37 +0000
Date: Mon, 27 Nov 2023 06:47:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH block/for-next v2 00/16] block: remove field 'bd_inode'
 from block_device
Message-ID: <20231127064737.GH38156@ZenIV>
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org, richard@nod.at, willy@infradead.org, hch@infradead.org, xen-devel@lists.xenproject.org, yukuai3@huawei.com, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, dlemoal@kernel.org, sth@linux.ibm.com, dchinner@redhat.com, dsterba@suse.com, ming.lei@redhat.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, linux-erofs@lists.ozlabs.org, yangerkun@huawei.com, linux@weissschuh.net, kent.overstreet@gma
 il.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, min15.li@samsung.com, linux-btrfs@vger.kernel.org, roger.pau@citrix.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 27, 2023 at 02:21:00PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>  - split different portions into different patches, as greg k-h
>  suggested.
>  - use container_of() instead of "bdev + 1" to get the address of
>  bd_inode in the new helper, as grep k-h suggested.

You might have misinterpreted gregkh - in your place I would rather
do a one-patch never-rebased branch (introduction of bdev_inode() in
form that returns bdev->bd_inode), with followup in your branch that
switches it to your variant.  Then conversions of ->bd_inode users,
to be either picked by individual filesystems of staying in your branch.
Any filesystem tree could merge from your never-rebased branch, after
which they could switch their ->bd_inode uses to the new helper, without
introducing any bisection hazards or interdependencies.
After the next -rc1, once all ->bd_inode users are gone from the tree -
remove the field.
