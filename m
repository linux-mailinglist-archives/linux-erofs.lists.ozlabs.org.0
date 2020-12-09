Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E52D38EE
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 03:46:50 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrLzW4XYWzDqkp
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 13:46:47 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=H9JU7Wcy; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H9JU7Wcy; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrLzR0NHvzDqQG
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 13:46:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607482000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2jLB9lyGcuiqtUMQzY4BlQmh+O04HP8l3MLhgdpu/U=;
 b=H9JU7WcynherhZ921uaAnQd/BZO1zxnWStDtCJNncCIPraRGCylFUGOv5doJPMt23OvfwA
 fG2vqZ7H3ibDhiH8f29F6RehrMmHvM2kThyoYzS2BruL0i3fRia2fy6/J0mHfpkvOnbd7F
 9zKZbtXd7LU3AmwuLlFhbkqGi+ejpq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607482000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2jLB9lyGcuiqtUMQzY4BlQmh+O04HP8l3MLhgdpu/U=;
 b=H9JU7WcynherhZ921uaAnQd/BZO1zxnWStDtCJNncCIPraRGCylFUGOv5doJPMt23OvfwA
 fG2vqZ7H3ibDhiH8f29F6RehrMmHvM2kThyoYzS2BruL0i3fRia2fy6/J0mHfpkvOnbd7F
 9zKZbtXd7LU3AmwuLlFhbkqGi+ejpq0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-F8MFwh7FPRauP8J0p_IJsA-1; Tue, 08 Dec 2020 21:46:38 -0500
X-MC-Unique: F8MFwh7FPRauP8J0p_IJsA-1
Received: by mail-pg1-f199.google.com with SMTP id g24so153259pgh.14
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 18:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=s2jLB9lyGcuiqtUMQzY4BlQmh+O04HP8l3MLhgdpu/U=;
 b=PBa+WU+BK4/nkoGnvJ1D8RLJvBH2FjUnfT5TiCaJN7nmx9JPr3hLM/WBOYGHNrRdW1
 YePexTRxONf49QGNYOV3wcTiT+BA9nSd2UqsDb3Y9pfb4dMt5Ct2PYtiowi7k7QOeYmt
 WQ8m6tpMhmZDGRMV4+Wc6XfrupFFuai+8fVomZGE6aGFXEN/RMCZHqPOCK3mylhqJAm3
 jWtc0+Ci7Jv0YU4XTOl2RZH2EoVrWvi1gMDQ0kf37YpEjV0qguzBHedEmfcjeLVGFgTe
 mcMftdV8QHjgbqg2SJ/K1omEx/ygPRXSwsDvGpMv4JXvfgRXtVPjAlKFCwM811S39Y17
 w1AQ==
X-Gm-Message-State: AOAM531S6jb3A4ZKRUrJqbTbXd//LzGBUWCqOqj6ZYP3/K7q5MFysFcO
 z01Gg4OgY1UTjwfnSh4bgBenV6nncN0BeplWm3zPvNGbt5XDTrgBtJgr8LvQ9q3BOY5iUtXkOrL
 r8jK+W14PlmW5+Bl6t/3JYEVk
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id
 s17-20020a1709029891b02900d8fdf67c04mr440248plp.54.1607481996997; 
 Tue, 08 Dec 2020 18:46:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/24oMdAlXou7IwSbRByn5ZOTlVf5BsBP2Dwbvu/AJDH9tHEmv0SaJrMizo++suZQtTp3JhA==
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id
 s17-20020a1709029891b02900d8fdf67c04mr440226plp.54.1607481996675; 
 Tue, 08 Dec 2020 18:46:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j20sm199721pfd.106.2020.12.08.18.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 18:46:36 -0800 (PST)
Date: Wed, 9 Dec 2020 10:46:25 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v4] erofs: avoid using generic_block_bmap
Message-ID: <20201209024625.GB33948@xiangao.remote.csb>
References: <20201209023930.15554-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20201209023930.15554-1-huangjianan@oppo.com>
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

On Wed, Dec 09, 2020 at 10:39:30AM +0800, Huang Jianan wrote:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors.
> 
> In addition, considering buffer_head limits mapped size to 32-bits,
> should avoid using generic_block_bmap.
> 
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---

Looks good to me in general, yet see my v3 reply as below:
https://lore.kernel.org/r/20201209024415.GA33948@xiangao.remote.csb/

Thanks,
Gao Xiang


>  fs/erofs/data.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..d6ea0a216b57 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>  		submit_bio(bio);
>  }
>  
> -static int erofs_get_block(struct inode *inode, sector_t iblock,
> -			   struct buffer_head *bh, int create)
> -{
> -	struct erofs_map_blocks map = {
> -		.m_la = iblock << 9,
> -	};
> -	int err;
> -
> -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> -	if (err)
> -		return err;
> -
> -	if (map.m_flags & EROFS_MAP_MAPPED)
> -		bh->b_blocknr = erofs_blknr(map.m_pa);
> -
> -	return err;
> -}
> -
>  static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  {
>  	struct inode *inode = mapping->host;
> +	struct erofs_map_blocks map = {
> +		.m_la = blknr_to_addr(block),
> +	};
> +	sector_t blknr = 0;
>  
>  	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>  		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
>  
>  		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> -			return 0;
> +			goto out;
>  	}
>  
> -	return generic_block_bmap(mapping, block, erofs_get_block);
> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +		blknr = erofs_blknr(map.m_pa);
> +
> +out:
> +	return blknr;
>  }
>  
>  /* for uncompressed (aligned) files and raw access for other files */
> -- 
> 2.25.1
> 

