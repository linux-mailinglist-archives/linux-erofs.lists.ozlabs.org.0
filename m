Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16C547525
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 16:01:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKzyB6nfXz3bxr
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jun 2022 00:01:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=J5ILuXUY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=J5ILuXUY;
	dkim-atps=neutral
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKzy45NPHz3bx5
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Jun 2022 00:00:58 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 123so1673625pgb.5
        for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c9HBwLp0Uv5MjgxnDuQRISysx2V5J/58czPWYFl7Y+c=;
        b=J5ILuXUYWMfQjDH4S2msyhgkPRceCZoVKL6RHwfqAlOBIL3InHqK7wcsqLhDuwhGTZ
         GsjxoYTI3nxq09rAthVavpFmZpRa+WedvYuXMvFelYFG3anGgzlvOOBCY+ZykdsLpO47
         h1m8c9Tcc7+0Lauceew5EJJAFiqE3YeTfZNkBsc29H0tpyHmPqrWyRoJ32cuqoshLtVO
         zgGt03epVWoeR0d70Oj2+9baQg1u7RWDjy9RJ4Y+9prhr5JI7fEHU/Z0P83Aevjfpsvr
         GduSckWxvPbVquHtRFul5qZ4pcxW88Gt5KPQHgjN1kPTnzQ1hujOcnEWnAZ9NFOac9S3
         EWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c9HBwLp0Uv5MjgxnDuQRISysx2V5J/58czPWYFl7Y+c=;
        b=GCS/3ES3AaTDdOJ5Yfy0tpV9oXk5NVnD6XykVJeC3EeqjuUKn/bHsKTmBy//qpJv8k
         cPyEq0JASHj3vr3/DpXPJvds1nv2tdPgN+8balEvOu8/Eydmb5NMKxnHfH4h8Ib4b6tm
         8kEyVGOkVujx9Zr49ItKaaVqzqqG+rO2wKt4et/9CfpvBl4FyLZr7xcO7sRu/V+oofkN
         cpzTNoyAhLAIU+OPozqQ3tf0J7KKYs637jqjAIMx1Ma9KmFh65GFoIRbH29vXVjEEJor
         0E405OBw5Yoysjq3SqSdA56VUktvId0QKW1fFkAk4XqfA6EGe9TqRLl4KE2TX1Bk2Rmb
         5M1A==
X-Gm-Message-State: AOAM5326FH+/offYEjjuXpvijk3hlqAVZgbcJzDSs0afID+k2ykGmFWA
	jPtigKXvz8eWC42k94QTDvo=
X-Google-Smtp-Source: ABdhPJx8aXzG7lARTjf0DGMNWJ7cU2i9+ckERmOuVpIwDU+ICn1bZ2jiI0zO6THloqk9kmx74bkHfg==
X-Received: by 2002:a63:2a0c:0:b0:3fc:9b04:541d with SMTP id q12-20020a632a0c000000b003fc9b04541dmr44653939pgq.546.1654956054512;
        Sat, 11 Jun 2022 07:00:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902d5ca00b00163d4dc6e95sm1528126plh.307.2022.06.11.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 07:00:54 -0700 (PDT)
Date: Sat, 11 Jun 2022 07:00:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <20220611140052.GA288528@roeck-us.net>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
 <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jun 11, 2022 at 12:56:27PM +0000, Al Viro wrote:
> On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> > On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> > 
> > 
> > > At a guess, should be
> > > 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > > 
> > > in both places.  I'm more than half-asleep right now; could you verify that it
> > > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > > builds correctly?
> > 
> > No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> > On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> > OK (both have the same range there), but it triggers the tests.  Try 
> > 
> > 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> > 
> > there (both places).
> 
> The reason we can't overflow on multiplication there, BTW, is that we have
> nr <= count, and count has come from weirdly open-coded
> 	DIV_ROUND_UP(size + offset, PAGE_SIZE)

That is often done to avoid possible overflows. Is size + offset
guaranteed to be smaller than ULONG_MAX ?

Guenter

> IMO we'd better make it explicit, so how about the following:
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index dda6d5f481c1..150dbd314d25 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1445,15 +1445,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	offset = pos & ~PAGE_MASK;
>  	*_start_offset = offset;
>  
> -	count = 1;
> -	if (size > PAGE_SIZE - offset) {
> -		size -= PAGE_SIZE - offset;
> -		count += size >> PAGE_SHIFT;
> -		size &= ~PAGE_MASK;
> -		if (size)
> -			count++;
> -	}
> -
> +	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
>  	if (count > maxpages)
>  		count = maxpages;
>  
> @@ -1461,7 +1453,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	return min(nr * PAGE_SIZE - offset, maxsize);
> +	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
>  }
>  
>  /* must be done on non-empty ITER_IOVEC one */
> @@ -1607,15 +1599,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
>  	offset = pos & ~PAGE_MASK;
>  	*_start_offset = offset;
>  
> -	count = 1;
> -	if (size > PAGE_SIZE - offset) {
> -		size -= PAGE_SIZE - offset;
> -		count += size >> PAGE_SHIFT;
> -		size &= ~PAGE_MASK;
> -		if (size)
> -			count++;
> -	}
> -
> +	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
>  	p = get_pages_array(count);
>  	if (!p)
>  		return -ENOMEM;
> @@ -1625,7 +1609,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	return min(nr * PAGE_SIZE - offset, maxsize);
> +	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
>  }
>  
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
