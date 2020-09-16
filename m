Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C25F26C3BE
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Sep 2020 16:33:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bs2f00bvlzDqXq
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Sep 2020 00:33:44 +1000 (AEST)
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
 header.s=mimecast20190719 header.b=XcQ6N6A7; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XcQ6N6A7; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bs2dh3w85zDqXq
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Sep 2020 00:33:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600266798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f48/ra56w9B62BBt1KxgQmjI18k2gbv7FH5W25ynCbY=;
 b=XcQ6N6A7Q+lTCFdkD2MLVJK2meEldqYtHgnDr6qU7FqsEelFHfWhPuptfDTOwaje73vIbr
 ijMaDneSLBgVC9zPEqKQWfSWZ6boUOsjdBzbsJzyWokdxkos/qOkPduFY7QANHOyI7E8vr
 F2L2nj96La/jFT2gUryM9OPf2P6n8tc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600266798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f48/ra56w9B62BBt1KxgQmjI18k2gbv7FH5W25ynCbY=;
 b=XcQ6N6A7Q+lTCFdkD2MLVJK2meEldqYtHgnDr6qU7FqsEelFHfWhPuptfDTOwaje73vIbr
 ijMaDneSLBgVC9zPEqKQWfSWZ6boUOsjdBzbsJzyWokdxkos/qOkPduFY7QANHOyI7E8vr
 F2L2nj96La/jFT2gUryM9OPf2P6n8tc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-nl9CqglBNhO6nDFRb_UzwQ-1; Wed, 16 Sep 2020 10:33:16 -0400
X-MC-Unique: nl9CqglBNhO6nDFRb_UzwQ-1
Received: by mail-pg1-f197.google.com with SMTP id z4so3947641pgv.13
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Sep 2020 07:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=f48/ra56w9B62BBt1KxgQmjI18k2gbv7FH5W25ynCbY=;
 b=lxx4XK964kJufhGzG+hKnBBy1ArG/VMN81Vgl8v7EtANJCVFInbeRZjYGT0DJWngfW
 aBQe8tIyUgOqs7M3QvWAU4Yr5Ee/5mDWG25ydQO+Cyct2fdQrYSLRrpLe8IH60Slzo6u
 o2k9GrWO+RelCeJqFTO18en2+Y/BH06a6IT6fsxbNPfyUkUMKQDN1XVPnTMJcdRB5r5a
 uzb/m61Ag+BS4P5kTNRLIQYDpbmDgI8uvrGnIiyxqLA6K8kPuIULljKuKxTwW92n9wcM
 C4hlOvFuYrPff40Z08+jS8RZ6H1Gj/sUyoUnXvgenhZD3dvVKdreVsJoNj+Jxsea9XI/
 C7hQ==
X-Gm-Message-State: AOAM533ejQpxQ5jliWw8yucl0cut+1+STQCaRIguoaa7brRDZKD5Bqo6
 7i95kuFql6EbWGNXmlXbFG4W5UEBiiMXP+hAEDujYz97UMV4tqg+vFTCitWYyb9bkN7k9lj0+1A
 97zRd7cVf+KOui8yr4gYFAF1f
X-Received: by 2002:a17:90b:3c7:: with SMTP id
 go7mr4171152pjb.97.1600266795027; 
 Wed, 16 Sep 2020 07:33:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHH2Cu+A6m25LC2Er3YghzATjk7FFDZK//oX57Fg5jRTz7kqdKqb5euQfouEwGEccpx5K+FQ==
X-Received: by 2002:a17:90b:3c7:: with SMTP id
 go7mr4171115pjb.97.1600266794661; 
 Wed, 16 Sep 2020 07:33:14 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c22sm14544442pgb.52.2020.09.16.07.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 07:33:14 -0700 (PDT)
Date: Wed, 16 Sep 2020 22:33:04 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: remove unneeded parameter
Message-ID: <20200916143304.GA23176@xiangao.remote.csb>
References: <20200916140604.3799-1-chao@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200916140604.3799-1-chao@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Wed, Sep 16, 2020 at 10:06:04PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> In below call path, no page will be cached into @pagepool list
> or grabbed from @pagepool list:
> - z_erofs_readpage
>  - z_erofs_do_read_page
>   - preload_compressed_pages
>   - erofs_allocpage
> 
> Let's get rid of this unneeded parameter.

That would be unneeded after .readahead() is introduced recently
(so add_to_page_cache_lru() is also moved to mm code), so I agree
with you on it.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/erofs/utils.c |  2 +-
>  fs/erofs/zdata.c | 14 ++++++--------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
> index de9986d2f82f..7a6e5456b0b8 100644
> --- a/fs/erofs/utils.c
> +++ b/fs/erofs/utils.c
> @@ -11,7 +11,7 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
>  {
>  	struct page *page;
>  
> -	if (!list_empty(pool)) {
> +	if (pool && !list_empty(pool)) {
>  		page = lru_to_page(pool);
>  		DBG_BUGON(page_ref_count(page) != 1);
>  		list_del(&page->lru);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 6c939def00f9..f218f58f4159 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -153,8 +153,7 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
>  
>  static void preload_compressed_pages(struct z_erofs_collector *clt,
>  				     struct address_space *mc,
> -				     enum z_erofs_cache_alloctype type,
> -				     struct list_head *pagepool)
> +				     enum z_erofs_cache_alloctype type)
>  {
>  	const struct z_erofs_pcluster *pcl = clt->pcl;
>  	const unsigned int clusterpages = BIT(pcl->clusterbits);
> @@ -562,8 +561,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
>  }
>  
>  static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> -				struct page *page,
> -				struct list_head *pagepool)
> +				struct page *page)
>  {
>  	struct inode *const inode = fe->inode;
>  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> @@ -621,7 +619,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		cache_strategy = DONTALLOC;
>  
>  	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> -				 cache_strategy, pagepool);
> +				 cache_strategy);
>  
>  hitted:
>  	/*
> @@ -653,7 +651,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	/* should allocate an additional staging page for pagevec */
>  	if (err == -EAGAIN) {
>  		struct page *const newpage =
> -			erofs_allocpage(pagepool, GFP_NOFS | __GFP_NOFAIL);
> +			erofs_allocpage(NULL, GFP_NOFS | __GFP_NOFAIL);

Could we use allocpage instead, so erofs_allocpage modification is unneeded as well :)

Thanks,
Gao Xiang

