Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720B0363FF8
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Apr 2021 12:57:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FP3g60WKDz2xZT
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Apr 2021 20:57:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T1gJZzF3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T1gJZzF3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=T1gJZzF3; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T1gJZzF3; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FP3g30Y2Hz2xYb
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Apr 2021 20:57:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618829832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNQ4HoCyooO06IHoJbT24dMTOmm/4kN37FzSLHIT/Jc=;
 b=T1gJZzF3+dAfaU9OSg6yHy885G1t73i/RV9gZYiuXvyFpcBfMGWlCL+TweNAqv2H+bJxkk
 kP0nrG7IJ3TlueZIiKrksMXSNwAmItdXB7+/elVddOXL3X9c/gNgZl5xyfkY66ih+vgY0p
 o5VHrHC/AdPNjwSSgePohO4ioKHiHoc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618829832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNQ4HoCyooO06IHoJbT24dMTOmm/4kN37FzSLHIT/Jc=;
 b=T1gJZzF3+dAfaU9OSg6yHy885G1t73i/RV9gZYiuXvyFpcBfMGWlCL+TweNAqv2H+bJxkk
 kP0nrG7IJ3TlueZIiKrksMXSNwAmItdXB7+/elVddOXL3X9c/gNgZl5xyfkY66ih+vgY0p
 o5VHrHC/AdPNjwSSgePohO4ioKHiHoc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-8VphoDBjO-Cq4ySEdtZj5w-1; Mon, 19 Apr 2021 06:57:08 -0400
X-MC-Unique: 8VphoDBjO-Cq4ySEdtZj5w-1
Received: by mail-pj1-f69.google.com with SMTP id
 f24-20020a17090aa798b029014e704b7ff5so13137091pjq.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Apr 2021 03:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NNQ4HoCyooO06IHoJbT24dMTOmm/4kN37FzSLHIT/Jc=;
 b=PiAYGeiCm4BuZn/7r1CwJ6fRl0Va28np6JFQn/8XdabYCoP0un4vTidmPNQFebuKOZ
 tmAeWT8ffbR0BR+fhDeyZj5ZMPIFwzTk6sf3ghJcnRqwEFalKJWXDpPz/lDX4MeATYKA
 wnEA6w4sJkkFOEa2TDWCXCKDYyAZMJ3GeyzlI4l3gbSFNhGSh6hTLyIDbuk9FpzZ0w1B
 j7vLCIt0O3dsjtvxgz2FUSG7Cn6/l75rOOHEwhdtwA3RBA+si9ckLv2E3J3/0/lCBCsR
 TC82lLA9Bj0T+dKUAuwbsKJDvs5X8awWhYAGOMqcBkaEw7tTGC0+qTQ117NC9xH9DP5j
 uVjQ==
X-Gm-Message-State: AOAM530q8tgzauyaFitjAMwpMjMNXzGzLt88Qfgq47lV0mFfKgN22ng3
 rQiT/jn+18wx8QxSkcJBiz0zdaFnJd5Z/odGXPUDNV+G1LS1pHgSc6BUUeegKPuhennShYvzQJw
 7P+yWZybIVN2q5H+cPbppln6g
X-Received: by 2002:a63:dc56:: with SMTP id f22mr11366504pgj.287.1618829827074; 
 Mon, 19 Apr 2021 03:57:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuXIKNjJ8JKnSU3TQedtHadGudoMcTTbl0IYmRJ3fcX+yD2OLoLco4x57pZRJ8SysBf0abqg==
X-Received: by 2002:a63:dc56:: with SMTP id f22mr11366493pgj.287.1618829826823; 
 Mon, 19 Apr 2021 03:57:06 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d17sm12968102pfo.117.2021.04.19.03.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Apr 2021 03:57:06 -0700 (PDT)
Date: Mon, 19 Apr 2021 18:56:55 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: remove the occupied parameter from
 z_erofs_pagevec_enqueue()
Message-ID: <20210419105655.GA2677107@xiangao.remote.csb>
References: <20210419102623.2015-1-zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210419102623.2015-1-zbestahu@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com,
 zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Mon, Apr 19, 2021 at 06:26:23PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> No any behavior to variable occupied in z_erofs_attach_page() which
> is only caller to z_erofs_pagevec_enqueue().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Thanks for your patch :) the variable `occupied' also has its usage
from pagevec implementation itself. But I agree with you on this
since it's actually unused now.

As we're in final-rc of 5.12 now, I've freezed the patches for 5.13.
I'll put off this cleanup to the next merge queue...

(btw, for erofs kernel patches, could you kindly Cc: linux-kernel
 mailing list next time as well... since it's part of linux kernel
 as well.)

Thanks,
Gao Xiang

> ---
>  fs/erofs/zdata.c | 4 +---
>  fs/erofs/zpvec.h | 5 +----
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 3851e1a..e9231da 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -298,7 +298,6 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
>  			       enum z_erofs_page_type type)
>  {
>  	int ret;
> -	bool occupied;
>  
>  	/* give priority for inplaceio */
>  	if (clt->mode >= COLLECT_PRIMARY &&
> @@ -306,8 +305,7 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
>  	    z_erofs_try_inplace_io(clt, page))
>  		return 0;
>  
> -	ret = z_erofs_pagevec_enqueue(&clt->vector,
> -				      page, type, &occupied);
> +	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type);
>  	clt->cl->vcnt += (unsigned int)ret;
>  
>  	return ret ? 0 : -EAGAIN;
> diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
> index 1d67cbd..95a6207 100644
> --- a/fs/erofs/zpvec.h
> +++ b/fs/erofs/zpvec.h
> @@ -107,10 +107,8 @@ static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
>  
>  static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
>  					   struct page *page,
> -					   enum z_erofs_page_type type,
> -					   bool *occupied)
> +					   enum z_erofs_page_type type)
>  {
> -	*occupied = false;
>  	if (!ctor->next && type)
>  		if (ctor->index + 1 == ctor->nr)
>  			return false;
> @@ -125,7 +123,6 @@ static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
>  	/* should remind that collector->next never equal to 1, 2 */
>  	if (type == (uintptr_t)ctor->next) {
>  		ctor->next = page;
> -		*occupied = true;
>  	}
>  	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
>  	return true;
> -- 
> 1.9.1
> 

