Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A42A74096E
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 08:30:05 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Rf34AQ3S;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrWsP3lmtz30Ky
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 16:30:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Rf34AQ3S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrWsG304dz2xdt
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 16:29:52 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666edfc50deso454496b3a.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687933787; x=1690525787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phnago+xzA34WP8EE3UKK7H8eHuABENEW5hNL2bsXgo=;
        b=Rf34AQ3SyUxDh5/NakzYjzWoF3lNk+M8I9oxWiCn/1AIPJZr+ilobnH5zzVIpONcT8
         JPrG8pdW010my4xLl96N8Govm5c32rk4FpI79TCcPw99u6Xq5SNtHkeNXKVyjXpLyXhC
         rGTbT/XZ5gyxDeGMR9ts0twHRVOTIXVGaPuFbqqb0kPJMVvK4g6M1y+MfDcE16qbK1bH
         UPDb0VnLCafeAp+Cfd4aCpBUtJGzhHtNTBssdmAL8yXtiFZIGs3IVSPw5K3fivrXaebI
         KW72REL9gXJ8I1PR82usdX06HcLHCK+sqqltS6XRC3JXwDow4JQ6epmKw0szmYVDfIjH
         TSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687933787; x=1690525787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phnago+xzA34WP8EE3UKK7H8eHuABENEW5hNL2bsXgo=;
        b=JX5ftjLRV9toPHNB0ZOB5aA5905xN4cwk8K8sLIQz3o/9jYGd/Z6V1Syx/LYPP4lqW
         OFIPtYt8MKG84IwpwCSGly4YpPuivlFAaUiDWwCHTByQrp55w8ApkK7av7BERd2Ireft
         LQkbYOoE7B0xcvUsTbyWtBlrBFZYQeDuV6ue1xERSq7yu0bOFP4C5V8CAmBz5AuTH91P
         oKGh5GJu9pFcmIM+w46N30JSi09jsdohUE8FBwB8TTlyzG0ReiLb2qJ/x8eXDw8M4tOK
         XC/Qx5j36vpfpxup+Vka2B8naiOxyvWFsSb/djt/d45UR66+1RqKrwnfwF6Hl88ivtBm
         zLmg==
X-Gm-Message-State: AC+VfDy54aJXzvvQnf0GOh/yaWEgfF+az9dNTcSL3ExmKUjlZ/Uq8O9V
	ifUc4CP1b3bukwqrGjBs3nw=
X-Google-Smtp-Source: ACHHUZ6d3pfVKObgk4siK5Lfysl0LC//sE6BdgoH94VJaOHujpnL0KaZh3s8HVVzfMUVJL14DMjXOg==
X-Received: by 2002:a05:6a20:7d9a:b0:12b:d525:2cac with SMTP id v26-20020a056a207d9a00b0012bd5252cacmr705356pzj.17.1687933786661;
        Tue, 27 Jun 2023 23:29:46 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b00666e649ca46sm748799pfn.101.2023.06.27.23.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Jun 2023 23:29:46 -0700 (PDT)
Date: Wed, 28 Jun 2023 14:38:30 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: simplify z_erofs_transform_plain()
Message-ID: <20230628143830.0000186f.zbestahu@gmail.com>
In-Reply-To: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
	<20230627161240.331-2-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 28 Jun 2023 00:12:40 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Use memcpy_to_page() instead of open-coding them.
> 
> In addition, add a missing flush_dcache_page() even though almost all
> modern architectures clear `PG_dcache_clean` flag for new file cache
> pages so that it doesn't change anything in practice.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
> preliminary tested with silesia dataset.
> 
>  fs/erofs/decompressor.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index ad53cf52d899..cfad1eac7fd9 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -328,7 +328,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  	const unsigned int lefthalf = rq->outputsize - righthalf;
>  	const unsigned int interlaced_offset =
>  		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
> -	unsigned char *src, *dst;
> +	u8 *src;
>  
>  	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
>  		DBG_BUGON(1);
> @@ -341,22 +341,19 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  	}
>  
>  	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
> -	if (rq->out[0]) {
> -		dst = kmap_local_page(rq->out[0]);
> -		memcpy(dst + rq->pageofs_out, src + interlaced_offset,
> -		       righthalf);
> -		kunmap_local(dst);
> -	}
> +	if (rq->out[0])
> +		memcpy_to_page(rq->out[0], rq->pageofs_out,
> +			       src + interlaced_offset, righthalf);
>  
>  	if (outpages > inpages) {
>  		DBG_BUGON(!rq->out[outpages - 1]);
>  		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
> -			dst = kmap_local_page(rq->out[outpages - 1]);
> -			memcpy(dst, interlaced_offset ? src :
> -					(src + righthalf), lefthalf);
> -			kunmap_local(dst);
> +			memcpy_to_page(rq->out[outpages - 1], 0, src +
> +					(interlaced_offset ? 0 : righthalf),
> +				       lefthalf);
>  		} else if (!interlaced_offset) {
>  			memmove(src, src + righthalf, lefthalf);
> +			flush_dcache_page(rq->in[inpages - 1]);
>  		}
>  	}
>  	kunmap_local(src);

