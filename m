Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7A807725
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 18:58:30 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jhEd/dyd;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SllWR4qpFz3cR9
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Dec 2023 04:58:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jhEd/dyd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+2d31c4bdfe93494595b7+7409+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SllWK2JLwz3c2b
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Dec 2023 04:58:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Snap78XnwhxghrXH/x5DQQflOIE581aXjQMNJjr942g=; b=jhEd/dydrVcA4CqjenXKvBzOhR
	81C86OaTSZvOMqak9GSj26Gk4YbmuiZYqP7Inoay495Qv5aZdhoCk8XtjbZygZ3zFO1MW8qKrFi2H
	jyJUerjxpHvoYivz2Tw0Fom0GZl5ibZD6cI47f6RLNKkoLSSNt8ndPXabCTs9v50CaHUmh6n8EwdV
	h3a11wO9KMQTDIeK5z9Ompws1FrJbStRk/+i8NoSwEjnMVM2d8/eYZK+A65e+FB9FyAW6cFULMbV3
	D4ZCe0VCUv3C54OOIhpqqs0icRWLiCRtInXdBESqtPRpMCqUFSNmSUQ2owjCoBA1ulhjzpRpsIDuc
	qR59KN6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAw9b-00AzA5-00;
	Wed, 06 Dec 2023 17:57:47 +0000
Date: Wed, 6 Dec 2023 09:57:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <ZXC2Gg7NPWu9MULx@infradead.org>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
 <ZXARKD0OmjLrvHmU@infradead.org>
 <20231206175038.GJ509422@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206175038.GJ509422@mit.edu>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, Christoph Hellwig <hch@infradead.org>, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, sth@linux.ibm.com, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
  linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, roger.pau@citrix.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 06, 2023 at 12:50:38PM -0500, Theodore Ts'o wrote:
> This was added because pulling a mounted a USB thumb drive (or a HDD
> drops off the SATA bus) while the file system is mounted and actively
> in use, would result in a kernel OOPS.  If that's no longer true,
> that's great, but it would be good to test to make sure this is the
> case....

And, surprise, surprise - that didn't just affect ext4.  So I ended
up fixing this properly in the block layer.

> If we really want to remove it, I'd suggest doing this as a separate
> commit, so that after we see syzbot reports, or users complaining
> about kernel crashes, we can revert the removal if necessary.

Yes, this should of course be separate, well documented commit.

