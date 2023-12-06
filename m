Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D14806825
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 08:21:26 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hj7ctWdU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlTNL1wHZz3cTm
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 18:21:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hj7ctWdU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+2d31c4bdfe93494595b7+7409+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlTNB6tJ5z3c1J
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 18:21:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3qSq0ZgSYyFQdhkNKKx+ay2VTuWMWagkFjN44scFJGI=; b=Hj7ctWdUPYGChKSXbjiG3ceuLC
	qJJdvlVYftwJ0JmFiiq7KgA3kS4RlnIA/MDhNrvJyEEBExXyzpZoszMTkmDa/0AcbWk3X3RegC55V
	7demvhkD/2Vm6MNZiLt23BUpT9dBqEkmj0CKPAbAJm+oIUuXhDVeLjwJaZkW3WPEmdGuSLkwjyd9+
	YyBHijcvKAnO2bAVJAUvyMRdWxJKRyTYJ1uvpasFg0q82cLUXzhXq4Wu/L7v1jx64IWttFDdMu/ca
	3J1JyfBFyObPGWrCPbNdP80bglMjq75SOxMB3QIX6GX/sagc2ovosgUjghAazuSh7ZC/geNc3PWxS
	jsvebKrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAmCo-009HjE-0N;
	Wed, 06 Dec 2023 07:20:26 +0000
Date: Tue, 5 Dec 2023 23:20:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <ZXAgut2MTKw50OLI@infradead.org>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
 <ZXARKD0OmjLrvHmU@infradead.org>
 <aafabc6e-fd98-f927-44d7-3ef76e2acaf8@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafabc6e-fd98-f927-44d7-3ef76e2acaf8@huaweicloud.com>
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

On Wed, Dec 06, 2023 at 02:50:56PM +0800, Yu Kuai wrote:
> I'm a litter confused, so there are 3 use cases:
> 1) use GFP_USER, default gfp from bdev_alloc.
> 2) use GFP_KERNEL
> 3) use GFP_NOFS
> 
> I understand that you're suggesting memalloc_nofs_save() to distinguish
> 2 and 3, but how can I distinguish 1?

You shouldn't.  Diverging from the default flags except for clearing
the FS or IO flags is simply a bug.  Note that things like block2mtd
should probably also ensure a noio allocation if they aren't doing that
yet.

> >   - use memalloc_nofs_save in extet instead of using
> >     mapping_gfp_constraint to clear it from the mapping flags
> >   - remove __ext4_sb_bread_gfp and just have buffer.c helper that does
> >     the right thing (either by changing the calling conventions of an
> >     existing one, or adding a new one).
> 
> Thanks for the suggestions, but I'm not sure how to do this yet, I must
> read more ext4 code.

the nofs save part should be trivial.  You can just skip the rest for
now as it's not needed for this patch series.

