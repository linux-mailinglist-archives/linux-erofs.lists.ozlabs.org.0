Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FAE4CB5D3
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 05:11:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K8Hc55L69z3bpX
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 15:11:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=NRRxcvOA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=NRRxcvOA; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K8Hby0X16z3bNs
 for <linux-erofs@lists.ozlabs.org>; Thu,  3 Mar 2022 15:11:24 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id c1so3431954pgk.11
 for <linux-erofs@lists.ozlabs.org>; Wed, 02 Mar 2022 20:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/0gmcJoxVGLhp8QjDoOGXIW850+VpROypODCpoc/l/Y=;
 b=NRRxcvOAULZfW0eDMpnk22dYL2quKs0XFau2xaVDEEvhMi34Jvduh3PQboaYRvBH4S
 dzPai7HNhY+NT8SizIuMrOiTfrzWdxZDPqjVjx1yAaFJNY3mrlbN1cmJZf+g5jeHa38l
 V2KK/QHnfrp6LY+pD5qGL3lgymtKTcm4/68ql7YssnIpZTIm24eJrpSLb4/dZZJGTRkL
 OhnzEdLN9PqLP5efR8Y5PCF2mO/ds1wiqh/+6MCXOkCxr0GWkX3sHjVuMpLYHIGXmMF/
 xxucgaoLdyAxm7D4oF/Ord2Tm84d2tR16ee7pF/F/8Bu33uIQ3rS+ieOB/cnnp2xs4h0
 7RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/0gmcJoxVGLhp8QjDoOGXIW850+VpROypODCpoc/l/Y=;
 b=DJoSTZEV6igWA99HQmAEyEDXpwy+gjdryJ3uRpQCIMMGTBO2ZTlxMjm0eZGZINqjck
 Drpq/S+gEIjvU+kWuB9Fya9oc3DlpLBTea5TUF2i+XJi/KD6hZlX24cptZhEL4ZVKACf
 UC92i/ssoxUILmoNOaHss5J7dlpxOa2BO8MhMPXcBajsDVHvKOh1DTdv8sza6c6x4JOE
 UFOY3+JRcfpQFndL7x8GY8R1S57edE92mXdnKv2WD+9/1dEp60fxiLWezFf3yIZsEsQY
 d3uJBXsjjNP8SwSGLnGd94NgYny7MvMuhj8y0whpIgQ+fCrUYGYP+1COFMKa6wV5eoTs
 H8gQ==
X-Gm-Message-State: AOAM533gePqhkOPZlKrCO/sjhAqQTNQ0VerBGDRUDQrEZ4yirGmpk+aq
 s12n8m1SFBFOOJIk8DbchmI=
X-Google-Smtp-Source: ABdhPJxD3zIUdv9FDDVS3XTBezqyk7zhzKfvGQNUBsrrwAQeG/w8Ht1BpAIT3dcuCmW1TxXo03YtVA==
X-Received: by 2002:a05:6a00:26e2:b0:4e1:296b:f24e with SMTP id
 p34-20020a056a0026e200b004e1296bf24emr36402283pfw.49.1646280682661; 
 Wed, 02 Mar 2022 20:11:22 -0800 (PST)
Received: from localhost ([103.220.76.197]) by smtp.gmail.com with ESMTPSA id
 j17-20020a634a51000000b00378f9c90e66sm634379pgl.39.2022.03.02.20.11.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Mar 2022 20:11:22 -0800 (PST)
Date: Thu, 3 Mar 2022 12:09:55 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: clean up preload_compressed_pages()
Message-ID: <20220303120955.00002c81.zbestahu@gmail.com>
In-Reply-To: <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
 <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed,  2 Mar 2022 03:49:51 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Rename preload_compressed_pages() as z_erofs_bind_cache()
> since we're try to prepare for adapting folios.
> 
> Also, add a comment for the gfp setting. No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 2673fc105861..59aecf42e45c 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -219,13 +219,17 @@ struct z_erofs_decompress_frontend {
>  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
>  static DEFINE_MUTEX(z_pagemap_global_lock);
>  
> -static void preload_compressed_pages(struct z_erofs_decompress_frontend *fe,
> -				     struct address_space *mc,
> -				     enum z_erofs_cache_alloctype type,
> -				     struct page **pagepool)
> +static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
> +			       enum z_erofs_cache_alloctype type,
> +			       struct page **pagepool)
>  {
> +	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
>  	struct z_erofs_pcluster *pcl = fe->pcl;
>  	bool standalone = true;
> +	/*
> +	 * optimistic allocation without direct reclaim since inplace I/O
> +	 * can be used if low memory otherwise.
> +	 */
>  	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
>  			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>  	struct page **pages;
> @@ -703,17 +707,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		WRITE_ONCE(fe->pcl->compressed_pages[0], fe->map.buf.page);
>  		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
>  	} else {
> -		/* preload all compressed pages (can change mode if needed) */
> +		/* bind cache first when cached decompression is preferred */
>  		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
>  					       map->m_la))
>  			cache_strategy = TRYALLOC;
>  		else
>  			cache_strategy = DONTALLOC;
>  
> -		preload_compressed_pages(fe, MNGD_MAPPING(sbi),
> -					 cache_strategy, pagepool);
> +		z_erofs_bind_cache(fe, cache_strategy, pagepool);
>  	}
> -
>  hitted:
>  	/*
>  	 * Ensure the current partial page belongs to this submit chain rather

Reviewed-by: Yue Hu <huyue2@coolpad.com>
