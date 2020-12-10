Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62132D50E5
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Dec 2020 03:36:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CryjL5n5wzDqv4
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Dec 2020 13:36:38 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=eByh87gO; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eByh87gO; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CryjF1ZzqzDqnK
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Dec 2020 13:36:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607567786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCGLXGuRmo1k3B8nyMMdd3CDg7kUrDixLDWQgjMK8Gk=;
 b=eByh87gOa5DiIya0+jfDbAmxv24gUb3dz3oql4OQmVj4phWPgaFmU4L8Q28n2+Ldi8Fyhk
 QbVG9YXPHpgEs3OnvtB9/cAplJ8/zPra4AdYA42w7P/+RdLayATIqyQdHyLPK4q30MNdfh
 lakri1UQghkQAMyf/ZMxmLoSXyWmVbg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607567786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCGLXGuRmo1k3B8nyMMdd3CDg7kUrDixLDWQgjMK8Gk=;
 b=eByh87gOa5DiIya0+jfDbAmxv24gUb3dz3oql4OQmVj4phWPgaFmU4L8Q28n2+Ldi8Fyhk
 QbVG9YXPHpgEs3OnvtB9/cAplJ8/zPra4AdYA42w7P/+RdLayATIqyQdHyLPK4q30MNdfh
 lakri1UQghkQAMyf/ZMxmLoSXyWmVbg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-TPZuFHweOMaVeSWDdX2X8Q-1; Wed, 09 Dec 2020 21:36:24 -0500
X-MC-Unique: TPZuFHweOMaVeSWDdX2X8Q-1
Received: by mail-pf1-f200.google.com with SMTP id n8so2499413pfa.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 09 Dec 2020 18:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kCGLXGuRmo1k3B8nyMMdd3CDg7kUrDixLDWQgjMK8Gk=;
 b=JJuSCC9k4FvSGxNmbFgrEN3/NL+O3T4ykgWySuB0HeCmTzN9xcm8vyCGPwslCEDy8Q
 K4szLa8ROsHNo1kM4FQohKWS0T7SIE50ivxIZSIvkfZuouJi6kvj3I/fVj4wrIhZedoi
 gIOZvKCFoRcd/7wk/AP2Zgn+r41jKgHfUeEDZH33LVdqvU1508T6obMkuY77XXDlp04y
 wm50dffFjwP14aWGO90JE8Bv1xr2gyNkHs3F3Uk7q4KTv/WSHmdyZF6EUtg4N+1JfRfH
 InS5n0Onp7W9oFSg7bH9Z2qgruJT3+wgq9SFq6xxzP/x42QrQ7eBU9wH8KjwydQz+Pb6
 mDPw==
X-Gm-Message-State: AOAM530GP18/VHcMxL/wVV4DFAjO6CjNP6TiIQEHjt9G1X5t+vC4LblY
 kQldP15Ea6MDItQgmVaH4C8rIFFCcDmB8KEpRVH7OpYQPtnIfPczX/v3QfVhF6f+PCjzb5ra/C2
 dL91Nbjvo3akBGzpBZbxpngnj
X-Received: by 2002:a17:90a:df0d:: with SMTP id
 gp13mr4979748pjb.151.1607567783196; 
 Wed, 09 Dec 2020 18:36:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsTdKo7r6boXwGgpspnOJOqeh3ErWQfa94wNzATv66ZGi8zSeoIYH5d4SSDROzjJ4qZ3Itew==
X-Received: by 2002:a17:90a:df0d:: with SMTP id
 gp13mr4979727pjb.151.1607567782923; 
 Wed, 09 Dec 2020 18:36:22 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x10sm4067133pfc.157.2020.12.09.18.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 18:36:22 -0800 (PST)
Date: Thu, 10 Dec 2020 10:36:12 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v5] erofs: avoid using generic_block_bmap
Message-ID: <20201210023612.GA247374@xiangao.remote.csb>
References: <20201209115740.18802-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20201209115740.18802-1-huangjianan@oppo.com>
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

On Wed, Dec 09, 2020 at 07:57:40PM +0800, Huang Jianan wrote:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors.
> 
> In addition, considering buffer_head limits mapped size to 32-bits,
> should avoid using generic_block_bmap.
> 
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Also, I think Chao has sent his Reviewed-by in the previous reply ---
so unless some major modification happens, it needs to be attached with
all new versions as a common practice...

I will apply it later to for-next, thanks for your patch!

Thanks,
Gao Xiang

> ---
>  fs/erofs/data.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..ea4f693bee22 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -312,27 +312,12 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
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
>  
>  	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>  		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
> @@ -341,7 +326,10 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  			return 0;
>  	}
>  
> -	return generic_block_bmap(mapping, block, erofs_get_block);
> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +		return erofs_blknr(map.m_pa);
> +
> +	return 0;
>  }
>  
>  /* for uncompressed (aligned) files and raw access for other files */
> -- 
> 2.25.1
> 

