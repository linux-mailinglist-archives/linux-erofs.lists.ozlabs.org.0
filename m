Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62777F9A88
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 08:10:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VRPuFgHz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SdxYW4V1wz3cRq
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Nov 2023 18:10:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VRPuFgHz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=dlemoal@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SdxYR0P4Bz3bZM
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Nov 2023 18:10:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF79F60917;
	Mon, 27 Nov 2023 07:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996CFC433C7;
	Mon, 27 Nov 2023 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701068997;
	bh=rnicohsvfFaSTeb42azhK+SpajDI1T+vJboqkZ88aAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VRPuFgHzyDdTKsrT6v2s4trEAs1zQA4cvx634pNpuoQtKkSCdvaCJbelneF1Ip3l4
	 3R2XpX9ULxFTLpvYZKC+OlVq1tQIg76lPle5uK1IXkDVPKpxfksILf6SRdY2YXiVx8
	 +7dKkjw2ixB7N6vQIrVxt9xKL7YlIHvL3xsDc8NMjznTj873bGKZp7GuQibnlnSWQy
	 ysSVDOissl1B8bF0lV/M0VJ7ULdDRCNYUqiH8Y50kpQs3OK75m1qeIPmc8MbFbLlTF
	 UDMB8ntMGz+OWj0fdv08z2PCWBrrlD9/8Y+uzFUqcbmYmX6+lodrokeIPhbDBGbkVC
	 Bn0mDn1QrfPEw==
Message-ID: <d3b87b87-2ca7-43ca-9fb4-ee3696561eb5@kernel.org>
Date: Mon, 27 Nov 2023 16:09:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH block/for-next v2 07/16] bcachefs: use new helper to get
 inode from block_device
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org,
 ming.lei@redhat.com, axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
 kent.overstreet@gmail.com, joern@lazybastard.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
 konishi.ryusuke@gmail.com, dchinner@redhat.com, linux@weissschuh.net,
 min15.li@samsung.com, yukuai3@huawei.com, willy@infradead.org,
 akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com
References: <20231127062116.2355129-1-yukuai1@huaweicloud.com>
 <20231127062116.2355129-8-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231127062116.2355129-8-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, gfs2@lists.linux.dev, linux-scsi@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 11/27/23 15:21, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Which is more efficiency, and also prepare to remove the field
> 'bd_inode' from block_device.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  fs/bcachefs/util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index 2984b57b2958..fe7ccb3a3517 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -518,7 +518,7 @@ int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
>  
>  static inline sector_t bdev_sectors(struct block_device *bdev)
>  {
> -	return bdev->bd_inode->i_size >> 9;
> +	return bdev_inode(bdev)->i_size >> 9;

shouldn't this use i_size_read() ?

I missed the history with this but why not use bdev_nr_sectors() and delete this
helper ?

>  }
>  
>  #define closure_bio_submit(bio, cl)					\

-- 
Damien Le Moal
Western Digital Research

