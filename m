Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3DE32E272
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 07:46:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsJD152C3z30MG
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Mar 2021 17:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z5oLQgPy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z5oLQgPy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Z5oLQgPy; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z5oLQgPy; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsJD00jMcz30JD
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Mar 2021 17:46:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614926763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hj8HqudFGVHUWiSyYmBUwWyXDG72GKTMlEsdwheJpVE=;
 b=Z5oLQgPy7Ttnp3zVNtfhcyOC7B9E8clxZlXkDm8ghb+Kj2621gmP2oAc2qROUUKpvlpuHq
 zBORq5YJYIVI5TJ32Kui2FqZtF1vw4LfEGJ8TJQZ2qP7wws0jPz8JWzjHvMp+aJb3UKWhb
 XqbOU9JTfOX+hsVs0CURLxlobcAAdEI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614926763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hj8HqudFGVHUWiSyYmBUwWyXDG72GKTMlEsdwheJpVE=;
 b=Z5oLQgPy7Ttnp3zVNtfhcyOC7B9E8clxZlXkDm8ghb+Kj2621gmP2oAc2qROUUKpvlpuHq
 zBORq5YJYIVI5TJ32Kui2FqZtF1vw4LfEGJ8TJQZ2qP7wws0jPz8JWzjHvMp+aJb3UKWhb
 XqbOU9JTfOX+hsVs0CURLxlobcAAdEI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-yRElKG5rNt6PTSTq9qRlLA-1; Fri, 05 Mar 2021 01:46:01 -0500
X-MC-Unique: yRElKG5rNt6PTSTq9qRlLA-1
Received: by mail-pg1-f197.google.com with SMTP id 2so651277pgo.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 04 Mar 2021 22:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hj8HqudFGVHUWiSyYmBUwWyXDG72GKTMlEsdwheJpVE=;
 b=BGWNl7B9XUktGJ1/eaTj8zR1jQ2cRkYBEyLHGTxfC14Yj+7mr93tauFAmm1D7F/A3R
 FaiqxWuwLbscSXJieoEnydq8DQXx4iWKW2A1RME0m38msprvVBs7VRM5uPzuXz3z1oAA
 zWLgdfPEbd8ZrJhBwNBs0ylvWOt0RXS+4sXl6bVsbN9IUxV0p3DDvd8QQU1WuTu5ZZAj
 lHaAjKNHfq/oeSSQVU/32aoDhQpQTUCt198rESsJMtyQwqLddi8JPCBKe57ocixDyZ7D
 rWsVysPk6FgpD9w6qKrggo0JTfsR1QAWEpa8NJdx8VgUDR7Pc97vQLFBFrOc7Z3ZNtk8
 o5nA==
X-Gm-Message-State: AOAM531r/vU9WANk90Dy+FcrfWBnq3IBoRWcS1FU5s7z6TLzK8UifwAT
 w0UE/wREM0pK0/8gfYWsyzXd4gVSPLH2MscrGMaoC0NlbK0zn0U+Tru69BPagVp1U3yNaE6n3IW
 hrm3GvO8EA9KEjE5KJFDkc9G1
X-Received: by 2002:a17:90a:ff05:: with SMTP id
 ce5mr8586380pjb.156.1614926760001; 
 Thu, 04 Mar 2021 22:46:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlrKATqRMyJryVPF6PYEUhsb4vjq/nTU8pFKEfFuk/PZeK5jrzjcKIHOHOqgJUttIZrDLJKg==
X-Received: by 2002:a17:90a:ff05:: with SMTP id
 ce5mr8586359pjb.156.1614926759711; 
 Thu, 04 Mar 2021 22:45:59 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z3sm1330626pfn.7.2021.03.04.22.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 22:45:59 -0800 (PST)
Date: Fri, 5 Mar 2021 14:45:49 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH 1/2] erofs: avoid memory allocation failure during
 rolling decompression
Message-ID: <20210305064549.GB3093390@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20210305062219.557128-1-huangjianan@oppo.com>
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

On Fri, Mar 05, 2021 at 02:22:18PM +0800, Huang Jianan via Linux-erofs wrote:
> It should be better to ensure memory allocation during rolling
> decompression to avoid io error.

Currently, err would be treated as io error. Therefore, it'd be
better to ensure memory allocation during rolling decompression
to avoid such io error.

In the long term, we might consider adding another !Uptodate case
for such case.

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/decompressor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 49347e681a53..fb0fa4e5b9ea 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -86,7 +86,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  			victim = availables[--top];
>  			get_page(victim);
>  		} else {
> -			victim = erofs_allocpage(pagepool, GFP_KERNEL);
> +			victim = erofs_allocpage(pagepool, GFP_KERNEL | __GFP_NOFAIL);

80 char limitation.

Thanks,
Gao Xiang

>  			if (!victim)
>  				return -ENOMEM;
>  			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> -- 
> 2.25.1
> 

