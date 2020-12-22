Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A573B2E0AAA
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 14:31:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0cgg0NtgzDqRy
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 00:31:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=apkr5f9a; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T3Kj/HXr; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0cSC0rQGzDqQm
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 00:21:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608643302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bdryUCYmuCIWhvhpUE/OQc73WJE93eW750eMifhQAGI=;
 b=apkr5f9akCnSuCdUBB3yn6eM8zgCEyWQb3UEiolsTgqTF9zN0TbQKscktRTiLaYOl8YXHZ
 LNwRyMtV86dtDdO4Qe876LjTqHOCcDC87RQops4RRBZTID9/WsBy4pZaARprUqdkNTpQ6F
 31wfjgiHFK4iF5Obi927sE9VSLFtvMU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608643303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bdryUCYmuCIWhvhpUE/OQc73WJE93eW750eMifhQAGI=;
 b=T3Kj/HXrgLsdv03D+0PGJ/OQqIyQyiUR7iMCktytFUHGhP5UPakU2pILqOEsVPwaAJpSpF
 Dtb7b8PJRB5uXhjovwPKzoF5EKnYG+YjedGAkqI2dsrY13ueVooiqNr6EzP7alqGdtQrSh
 zy3H1C5RZ3y8/04TkD6f4oeTimmjfZA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Bh0IUXi5NIWnT_qbqIqN1w-1; Tue, 22 Dec 2020 08:21:40 -0500
X-MC-Unique: Bh0IUXi5NIWnT_qbqIqN1w-1
Received: by mail-pf1-f200.google.com with SMTP id f3so6792095pfa.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 05:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bdryUCYmuCIWhvhpUE/OQc73WJE93eW750eMifhQAGI=;
 b=AzKv7eykj3T9DwpEQkKi24zZTCviOkyG2oi7haOfEOrERxPyneUUUiWljGV66T7r7S
 +vR22fgMPjQoCo3WJYVEDBFJo5PjkqxvMt4mEIi82yusJ2aUzk+WjqySgYKYif92rXLU
 GF5RNYdlGY/wKVQ4YgMEamrl1RAiegPApkhveCX9W7zQZopxnpisTHxZIMO8vU4cbHFT
 k56+UrBcHmQh3nfeAvLmB/jzBFl4H5kE9neikSwj/iPnLdWFqPxc1S+iAmFTnILmxuBq
 xCZv6xpGegSZIjglGAiscrnHSk/Tgi2xD7eoF7x4S/XC/HKYuuVZ+BzAv6nE+NgLMx2U
 zX4g==
X-Gm-Message-State: AOAM533npRjWTN8eVpK6rZCVT51HNVVioj2njO10jHvMiM7mBL32r0vE
 6ReCDdrpNCWWeJjQiPic5rlJoWBzU3FTH0T1foOuvdyN279pbnF6pW82iPpogPqjz8Ou4/5CAZx
 WkBcFRAQ0x5dbuztHQl0zROo7
X-Received: by 2002:a17:902:8b87:b029:dc:3c87:722a with SMTP id
 ay7-20020a1709028b87b02900dc3c87722amr10101583plb.47.1608643298904; 
 Tue, 22 Dec 2020 05:21:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzebaf0lcytn3IB/zKjocApFENCKd/pu5322hbOoUiUsohHm9WVacAEUzy1ZQAd+D6z+mSc4g==
X-Received: by 2002:a17:902:8b87:b029:dc:3c87:722a with SMTP id
 ay7-20020a1709028b87b02900dc3c87722amr10101556plb.47.1608643298579; 
 Tue, 22 Dec 2020 05:21:38 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s10sm20579305pgg.76.2020.12.22.05.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 05:21:38 -0800 (PST)
Date: Tue, 22 Dec 2020 21:21:27 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201222132127.GC1831635@xiangao.remote.csb>
References: <20201214140428.44944-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20201214140428.44944-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Mon, Dec 14, 2020 at 10:04:27PM +0800, Huang Jianan wrote:
> direct IO is useful in certain scenarios for uncompressed files.
> For example, it can avoid double pagecache when use the uncompressed
> file to mount upper layer filesystem.
> 
> In addition, another patch adds direct IO test for the stress tool
> which was mentioned here:
> https://lore.kernel.org/linux-erofs/20200206135631.1491-1-hsiangkao@aol.com/
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/data.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index ea4f693bee22..3067aa3defff 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -6,6 +6,8 @@
>   */
>  #include "internal.h"
>  #include <linux/prefetch.h>
> +#include <linux/uio.h>
> +#include <linux/blkdev.h>
>  
>  #include <trace/events/erofs.h>
>  
> @@ -312,6 +314,60 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>  		submit_bio(bio);
>  }
>  
> +static int erofs_get_block(struct inode *inode, sector_t iblock,
> +			   struct buffer_head *bh, int create)
> +{
> +	struct erofs_map_blocks map = {
> +		.m_la = blknr_to_addr(iblock),
> +	};
> +	int err;
> +
> +	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (err)
> +		return err;
> +
> +	if (map.m_flags & EROFS_MAP_MAPPED)
> +		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
> +
> +	return err;
> +}
> +
> +static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
> +			   loff_t offset)
> +{
> +	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);

It would be better to fold in check_direct_IO, also the READ_ONCE above
is somewhat weird...

No rush here, since 5.11-rc1 haven't be out yet, we have >= 2 months to
work it out.

Thanks,
Gao Xiang

> +	unsigned blkbits = i_blkbits;
> +	unsigned blocksize_mask = (1 << blkbits) - 1;
> +	unsigned long align = offset | iov_iter_alignment(iter);
> +	struct block_device *bdev = inode->i_sb->s_bdev;
> +
> +	if (align & blocksize_mask) {
> +		if (bdev)
> +			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +		blocksize_mask = (1 << blkbits) - 1;
> +		if (align & blocksize_mask)
> +			return -EINVAL;
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t erofs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct address_space *mapping = iocb->ki_filp->f_mapping;
> +	struct inode *inode = mapping->host;
> +	loff_t offset = iocb->ki_pos;
> +	int err;
> +
> +	err = check_direct_IO(inode, iter, offset);
> +	if (err)
> +		return err < 0 ? err : 0;
> +
> +	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
> +				    erofs_get_block, NULL, NULL,
> +				    DIO_LOCKING | DIO_SKIP_HOLES);
> +}
> +
>  static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  {
>  	struct inode *inode = mapping->host;
> @@ -336,6 +392,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  const struct address_space_operations erofs_raw_access_aops = {
>  	.readpage = erofs_raw_access_readpage,
>  	.readahead = erofs_raw_access_readahead,
> +	.direct_IO = erofs_direct_IO,
>  	.bmap = erofs_bmap,
>  };
>  
> -- 
> 2.25.1
> 

