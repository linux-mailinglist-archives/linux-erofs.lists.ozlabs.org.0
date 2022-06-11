Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE55474E3
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 15:44:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKzZf10whz3c2B
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 23:44:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dWFageSq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dWFageSq;
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKzZW5jFQz3bk7
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 23:44:02 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id a10so1751872pju.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ixh/tGjYEGtd9B0U4un+L2Dg2/GvxVifxx8JOO5/xxs=;
        b=dWFageSqD+a/p7/dg6peuXBetNvvozPq1OrZOQ/jnLrmOlYGPzNGQ4RjNm2jbazw9i
         u781rrcK5N+1rObNiGXHrWMqVQY7pZTTAMDXq7DNXEPeF453QBw6/bxOS0JTWBW4mEFL
         oUM/P6Tc2N9Ofg4sbBfsItn4mThyJNPYPK0dfcLnQTh5rjJPmndWQJuSTs7DAwaCi/Vx
         rL+jaeKda3xCTVgeOwll+wUPQ1XB4/3T0OO18jS1/nlZwt9iAYKwdDwzN6eMueoG9fyg
         LLwuRDA7jXNLhI6Pff6Xji5gCQ5vnnxkZEApvX0oXAyGKRCiRXSTKan8B5OV8LXdXJGh
         CGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ixh/tGjYEGtd9B0U4un+L2Dg2/GvxVifxx8JOO5/xxs=;
        b=r0DzgIrUOnQ7vpZnUcVWOoqFilunpgeOc6Y8kRtAxDECImjqWXj8qDM7Zb+1a4uqFP
         FO1L2w4yVEQsli8y93SDUm9/sBcs5zPsw+bk2YSK8SJ/CvFsGisxDhaena5LEzYJ/aRc
         FoxDjvxxayMe3oAwLLBzoSCWzG7ILkLD/YjGs35hQbejsdAxHkGHs3Mqrbr1/6dUcDdu
         S7ZcGDGSXQFMuwmKhtMNI+oFQx9bIy+7P6AqXgsXYuHtNSRLPlfsHpOwbXZ37Fqsw/Zs
         03TqauFp1PdydILy3iHUMv5UekBeBamxW93tWXUf8OmOQGTpn1kxhr24t/goATBX8JqF
         UtsA==
X-Gm-Message-State: AOAM5329XkNZWICFjRPunHfJhDsFM7bRCjFi7UBD3qi9Z/t+IaovwEcS
	VcPxuMUVL++qMu3VLq4pYHY=
X-Google-Smtp-Source: ABdhPJyVm1Qx3rpbnexbaPz3LjRNh5xdY5jWDRPJD5O1BPtSHpLAWd+II5ejGzWE9luF6mWKd4zRSA==
X-Received: by 2002:a17:902:9f96:b0:163:dc33:6b72 with SMTP id g22-20020a1709029f9600b00163dc336b72mr50033692plq.34.1654955039652;
        Sat, 11 Jun 2022 06:43:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709027e4c00b00164097a779fsm1523377pln.147.2022.06.11.06.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 06:43:58 -0700 (PDT)
Date: Sat, 11 Jun 2022 06:43:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
Message-ID: <20220611134357.GA278954@roeck-us.net>
References: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 09, 2022 at 09:07:01AM +0100, David Howells wrote:
> The maths at the end of iter_xarray_get_pages() to calculate the actual
> size doesn't work under some circumstances, such as when it's been asked to
> extract a partial single page.  Various terms of the equation cancel out
> and you end up with actual == offset.  The same issue exists in
> iter_xarray_get_pages_alloc().
> 
> Fix these to just use min() to select the lesser amount from between the
> amount of page content transcribed into the buffer, minus the offset, and
> the size limit specified.
> 
> This doesn't appear to have caused a problem yet upstream because network
> filesystems aren't getting the pages from an xarray iterator, but rather
> passing it directly to the socket, which just iterates over it.  Cachefiles
> *does* do DIO from one to/from ext4/xfs/btrfs/etc. but it always asks for
> whole pages to be written or read.
> 
> Fixes: 7ff5062079ef ("iov_iter: Add ITER_XARRAY")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Mike Marshall <hubcap@omnibond.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: devel@lists.orangefs.org
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
>  lib/iov_iter.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 834e1e268eb6..814f65fd0c42 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1434,7 +1434,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  {
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size = maxsize, actual;
> +	size_t size = maxsize;
>  	loff_t pos;
>  
>  	if (!size || !maxpages)
> @@ -1461,13 +1461,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	actual = PAGE_SIZE * nr;
> -	actual -= offset;
> -	if (nr == count && size > 0) {
> -		unsigned last_offset = (nr > 1) ? 0 : offset;
> -		actual -= PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);

This needs min_t to avoid a build error on 32-bit builds.

In file included from include/linux/kernel.h:26,
                 from include/linux/crypto.h:16,
                 from include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'iter_xarray_get_pages':
include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
...
lib/iov_iter.c:1628:16: note: in expansion of macro 'min'
 1628 |         return min(nr * PAGE_SIZE - offset, maxsize);
      |                ^~~

Guenter
