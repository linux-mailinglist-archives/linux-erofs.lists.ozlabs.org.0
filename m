Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A6355FC8
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 01:54:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFPWf0l2Rz302m
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 09:54:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L2KsMbGc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L2KsMbGc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=L2KsMbGc; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L2KsMbGc; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFPWb2cT3z2ydJ
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 09:54:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617753256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9Bynhk5jx9PpUNdN9ForbiWm+KTPR+Iguq3N1bBzvE=;
 b=L2KsMbGcy0Po0DMLxH6Q/j2VhBbC60kjw1WKl8/orDDyTIg0+HQJex1mqjempGoG6NY6iw
 wGWX38H7zsyjBN1bMW2Dhq7Pyku0klm5O+WZa04Euu0OOMoAd/kZGji1sSdU9ZPnU5r92I
 sxYNVnry6IjzSt+g/RR1s3fiBwJGmLY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617753256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9Bynhk5jx9PpUNdN9ForbiWm+KTPR+Iguq3N1bBzvE=;
 b=L2KsMbGcy0Po0DMLxH6Q/j2VhBbC60kjw1WKl8/orDDyTIg0+HQJex1mqjempGoG6NY6iw
 wGWX38H7zsyjBN1bMW2Dhq7Pyku0klm5O+WZa04Euu0OOMoAd/kZGji1sSdU9ZPnU5r92I
 sxYNVnry6IjzSt+g/RR1s3fiBwJGmLY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-_MLpg3rIOvukZlXi3bukgQ-1; Tue, 06 Apr 2021 19:54:14 -0400
X-MC-Unique: _MLpg3rIOvukZlXi3bukgQ-1
Received: by mail-pf1-f199.google.com with SMTP id g6so11594821pfc.14
 for <linux-erofs@lists.ozlabs.org>; Tue, 06 Apr 2021 16:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Z9Bynhk5jx9PpUNdN9ForbiWm+KTPR+Iguq3N1bBzvE=;
 b=nChsUUpW0KanVlGVrU+4dt2YY8T9GTieiurDMX2NWClRRIqeYei5BveKScWmkKhgQT
 thaQ+bPR29CxIwKUJqj8yIsi7YmDFdUmR3P6K+oShJJdoYU+FkOE+AroXvRDNRw5HNFw
 LUkePXsmXu7ykJVb/UtMyBYXajU2WVMD7QJJSgIORTvstFzFPryhrihX5wEmO0wDjYtq
 X8un+1m9gLREjxg1wsgDPL2ntHwLcdcW9h8xc9Bz4Owhx7/Ax/2CoVeSF0/w0V7E6E1k
 u6IORzoC82zFZa6X0CmLY/L0u4xNJaKM7KNKeRO+fWYrHXwFwwxFVzWZRkU+ROGJAqeW
 V1kw==
X-Gm-Message-State: AOAM533YDsj3SU0t3AklW+4XhP+mwybt2Lw+VzWPrO+sGfa0VacBrqo9
 xFPYdJYpGpFbpJmnS/5JUJZUnlIhlpwYo9yrv/k5LjG4UJdlHchszVsmutqhTF0+8DZxGQbKwPR
 MSLSP8UvFZxq11Lqtw3E97yZ9
X-Received: by 2002:a17:90a:8907:: with SMTP id
 u7mr607120pjn.114.1617753253130; 
 Tue, 06 Apr 2021 16:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvaMBT8JgaLEReC0ssyotJOmen93GjLT0Sh1CDVdMUhYnY+Tzw3Y4/zdNqq/R55VEG7Om6rw==
X-Received: by 2002:a17:90a:8907:: with SMTP id
 u7mr607098pjn.114.1617753252878; 
 Tue, 06 Apr 2021 16:54:12 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u17sm3263331pjx.10.2021.04.06.16.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 16:54:12 -0700 (PDT)
Date: Wed, 7 Apr 2021 07:54:01 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][next] erofs: fix uninitialized variable i used in a
 while-loop
Message-ID: <20210406235401.GA210667@xiangao.remote.csb>
References: <20210406162718.429852-1-colin.king@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20210406162718.429852-1-colin.king@canonical.com>
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
Cc: kernel-janitors@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Colin,

On Tue, Apr 06, 2021 at 05:27:18PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The while-loop iterates until src is non-null or i is 3, however, the
> loop counter i is not intinitialied to zero, causing incorrect iteration
> counts.  Fix this by initializing it to zero.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 1aa5f2e2feed ("erofs: support decompress big pcluster for lz4 backend")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thank you very much for catching this! It looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

(btw, may I fold this into the original patchset? since such big pcluster
 patchset is just applied to for-next for further integration testing, and
 the commit id is not stable yet..)

Thanks,
Gao Xiang

> ---
>  fs/erofs/decompressor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index fe46a9c34923..8687ff81406b 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -154,6 +154,7 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
>  	}
>  	kunmap_atomic(inpage);
>  	might_sleep();
> +	i = 0;
>  	while (1) {
>  		src = vm_map_ram(rq->in, nrpages_in, -1);
>  		/* retry two more times (totally 3 times) */
> -- 
> 2.30.2
> 

