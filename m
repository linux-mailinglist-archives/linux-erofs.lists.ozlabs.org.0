Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C86118A1CD0
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Apr 2024 19:57:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aI/Km0ji;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VFnT96Tqmz3vXM
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Apr 2024 03:57:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aI/Km0ji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b4; helo=out-180.mta1.migadu.com; envelope-from=kent.overstreet@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 411 seconds by postgrey-1.37 at boromir; Fri, 12 Apr 2024 03:56:53 AEST
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VFnT12FMfz3dX4
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Apr 2024 03:56:52 +1000 (AEST)
Date: Thu, 11 Apr 2024 13:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712857769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/TZdE1FK3O4qkESTbUB1nUL6z8CdzrLZmjris90VHw=;
	b=aI/Km0jiSMVL4A1tCs8hlsrV66vbuWxJKZ+EgkonCW2LmuJAGBaIivtgu4+3HhSKhbSBh3
	uS3+3l/YqK0GsHToDiJSOy8jQgouByPKNokiyLYxRwngjkex1lryU/nDL4TDH7+GmcHLtc
	35AcbG0Y+MpEd8VLadpzkGxeP5lZ1Bo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 07/17] bcachefs: remove dead
 function bdev_sectors()
Message-ID: <2pat6ombemqnq5wjl6eb4lbip2pfgg5tkubmbwqphvcvpdc6cu@poiexziaa2q4>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-8-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085712.1766333-8-yukuai1@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, yukuai3@huawei.com, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, linux-erofs@lists.ozla
 bs.org, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 21, 2023 at 04:57:02PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> bdev_sectors() is not used hence remove it.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  fs/bcachefs/util.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index 2984b57b2958..22a0acc1704f 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -516,11 +516,6 @@ static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
>  void bch2_bio_map(struct bio *bio, void *base, size_t);
>  int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
>  
> -static inline sector_t bdev_sectors(struct block_device *bdev)
> -{
> -	return bdev->bd_inode->i_size >> 9;
> -}
> -
>  #define closure_bio_submit(bio, cl)					\
>  do {									\
>  	closure_get(cl);						\
> -- 
> 2.39.2
> 
