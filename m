Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 990542D26D6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 10:04:37 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqvPt4mkgzDqWT
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 20:04:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Cfs76im6; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cfs76im6; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqvNW46BkzDqZ2
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 20:03:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607418199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+FXiid657VRgk+GfcDrWpQTBHVBt+A+sNz2LADUxiI=;
 b=Cfs76im60du9IkSrsXbpuJfHUcCeX+NCT88DIX9tXV3R3357xxk6kp/cRi+NkuueDII4pc
 xgkIuWSkJuS/T6vvLz+ZSVSOShYhfmZHXkLU21rvtU3MHjaNQKA57lnS2kl9LDUxXsA4Bw
 5pGEEbi96pmr/R10xp1idKTDZqiw2qM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607418199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+FXiid657VRgk+GfcDrWpQTBHVBt+A+sNz2LADUxiI=;
 b=Cfs76im60du9IkSrsXbpuJfHUcCeX+NCT88DIX9tXV3R3357xxk6kp/cRi+NkuueDII4pc
 xgkIuWSkJuS/T6vvLz+ZSVSOShYhfmZHXkLU21rvtU3MHjaNQKA57lnS2kl9LDUxXsA4Bw
 5pGEEbi96pmr/R10xp1idKTDZqiw2qM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-VvYR9nVFMGmPUgSKCLFO7A-1; Tue, 08 Dec 2020 04:03:15 -0500
X-MC-Unique: VvYR9nVFMGmPUgSKCLFO7A-1
Received: by mail-pg1-f197.google.com with SMTP id j30so11400543pgj.17
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 01:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C+FXiid657VRgk+GfcDrWpQTBHVBt+A+sNz2LADUxiI=;
 b=PeOF34P4IJcyn7tridpmoVZYAsZAdf4avoL3mA4NHyzAzKTSF+YlE6bxz+JuS6/0o1
 Qt7/nXEVtpEOlX92GZxtv/CvQYlwKa35QC+HvcKULcoHxOgO3QT4BoY5q8tu2roLuaZy
 rdy9ESvGAAct7YNM5MW2KpEODQ3uikZQsnlEXxmi60NxN3D/CQ5wBKpDqiKuQ9Fp+bTW
 BI56UIkPwS6P2nydrhgVX9iVBrHo7j4RqZKCedf7RLnZbvf6EPNP8ksj6I8HvIHMtFIx
 q6i1NbxP3iLTHoKy+o1Xh4CpvwI1sP9UmVfAtdqZrXrGWtaAwUH48V9kpdTneHtMrNv3
 kxOA==
X-Gm-Message-State: AOAM5307CuUTYbt3W8SlCkIJp2Rpu1JkeSONt/RIWm4UXP1LNX1DHAWc
 LMqNfMYoDpKuCUXYlhFVKXTYngESL6dOiL50svh8Oe84cKvPLj3LKotUbSjijxDFag8boXVd9BN
 GJnZZIRxIDy8+I9x2k+B1JTJW
X-Received: by 2002:a63:100e:: with SMTP id f14mr22253725pgl.8.1607418194173; 
 Tue, 08 Dec 2020 01:03:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj3zuFP6ZKE0YZVlHxAWsjtD8aWQKCQyE6pvzeacJKyWmhvE60rqBlB0jfGwG4ezmPWPz6Rw==
X-Received: by 2002:a63:100e:: with SMTP id f14mr22253700pgl.8.1607418193870; 
 Tue, 08 Dec 2020 01:03:13 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k16sm7430620pfi.131.2020.12.08.01.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 01:03:13 -0800 (PST)
Date: Tue, 8 Dec 2020 17:03:03 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs: fix wrong address in erofs_get_block
Message-ID: <20201208090303.GA3062064@xiangao.remote.csb>
References: <20201208084750.5469-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20201208084750.5469-1-huangjianan@oppo.com>
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Tue, Dec 08, 2020 at 04:47:50PM +0800, Huang Jianan wrote:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors, fix it.
> 
> If the data has a disk mapping, map_bh should be used to read the
> correct data from the device.
> 
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..1415fee10180 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -316,7 +316,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
>  			   struct buffer_head *bh, int create)
>  {
>  	struct erofs_map_blocks map = {
> -		.m_la = iblock << 9,
> +		.m_la = iblock << blknr_to_addr(iblock),

Sorry I don't get the point although I think the problem may exist....
I mean is that correct? since it equals to iblocks << (iblock * EROFS_BLKSIZE) ....

Thanks,
Gao Xiang


>  	};
>  	int err;
>  
> @@ -325,7 +325,7 @@ static int erofs_get_block(struct inode *inode, sector_t iblock,
>  		return err;
>  
>  	if (map.m_flags & EROFS_MAP_MAPPED)
> -		bh->b_blocknr = erofs_blknr(map.m_pa);
> +		map_bh(bh, inode->i_sb, erofs_blknr(map.m_pa));
>  
>  	return err;
>  }
> -- 
> 2.25.1
> 

