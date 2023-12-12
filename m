Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3680ED70
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 14:26:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=picipgXF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SqKBQ428xz3bsS
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Dec 2023 00:26:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=picipgXF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f90c2f2ff3264e7ff81+7415+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SqKBL5vbmz30Np
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Dec 2023 00:26:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b0EJSjGbwEr2b4Ml7A+chJ8+pEiLc4/B8ooSTDiYxzk=; b=picipgXFbvzoUhEoBG/zPnQX1q
	HE6smIRBy5a89R9akhr+qXOZgV2ZWsX5XPLxtAEgCavvFg2RD1Nd4bY6y3UtqlfS5bvjWd1FYs03a
	CEKxQcI96bW9kVZcHP+cYaV8hEgMc7fElg/c9Fc75ryish62M2PDTmzUmPs5fvjFZ8ka06osdMRpf
	ASMKxc6mHhCj37Uwwthec0X8EOQOG/hGGGWoR9QRV2Bnh4w97sL+F2xaXO4b3Qr1y31RDun14/d27
	LpamT9Qvnaapt6jca0mzWu9EovPM8+74IynFRKTN08S2sDe2pXO4Td8t8oHiM29FNbbe9flIcdz3n
	3xcYUrag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rD2lJ-00BnAr-2I;
	Tue, 12 Dec 2023 13:25:25 +0000
Date: Tue, 12 Dec 2023 05:25:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH RFC v2 for-6.8/block 15/18] buffer: add a new helper to
 read sb block
Message-ID: <ZXhfRdocHfrViOos@infradead.org>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140753.975297-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211140753.975297-1-yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, gfs2@lists.linux.dev, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, agruenba@redhat.com, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, r
 oger.pau@citrix.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 11, 2023 at 10:07:53PM +0800, Yu Kuai wrote:
> +static __always_inline int buffer_uptodate_or_error(struct buffer_head *bh)
> +{
> +	/*
> +	 * If the buffer has the write error flag, data was failed to write
> +	 * out in the block. In this case, set buffer uptodate to prevent
> +	 * reading old data.
> +	 */
> +	if (buffer_write_io_error(bh))
> +		set_buffer_uptodate(bh);
> +	return buffer_uptodate(bh);
> +}

So - risking this blows up into a lot of nasty work: Why do we even
clear the uptodate flag on write errors?  Doing so makes not sense to
me as the data isn't any less uptodate just because we failed to write
it..

