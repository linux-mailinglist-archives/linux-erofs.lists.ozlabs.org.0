Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC132100F
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Feb 2021 05:46:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DkV4b5qgQz30R1
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Feb 2021 15:46:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TESePcrN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TESePcrN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=TESePcrN; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TESePcrN; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DkV4X5r7fz30Q6
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Feb 2021 15:46:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613969161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cd7HPIL9dlAr5R+7k2bPsLA7MXZ+jz1lBX7uDhHKXsU=;
 b=TESePcrN8rorip6FY9XGvn4KT7gRKre1ztdbNx3Xitvy5CN7TiSawx/ZIafkuhZ1MMVoN4
 dVjKXiyZw4Hq/jw8v6tYQGkBmxz6wTsBQykJ+wIdDBx3ta8CFvRdFncXJA10ZW57RfNGng
 yDpXAKMVPmUj5fDr9CTMNmv+Z6ygYqA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613969161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cd7HPIL9dlAr5R+7k2bPsLA7MXZ+jz1lBX7uDhHKXsU=;
 b=TESePcrN8rorip6FY9XGvn4KT7gRKre1ztdbNx3Xitvy5CN7TiSawx/ZIafkuhZ1MMVoN4
 dVjKXiyZw4Hq/jw8v6tYQGkBmxz6wTsBQykJ+wIdDBx3ta8CFvRdFncXJA10ZW57RfNGng
 yDpXAKMVPmUj5fDr9CTMNmv+Z6ygYqA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-couHDvzRNeOUDvKQiCC0Xg-1; Sun, 21 Feb 2021 23:44:22 -0500
X-MC-Unique: couHDvzRNeOUDvKQiCC0Xg-1
Received: by mail-pj1-f72.google.com with SMTP id k92so1837176pjc.5
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Feb 2021 20:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cd7HPIL9dlAr5R+7k2bPsLA7MXZ+jz1lBX7uDhHKXsU=;
 b=JDtTphdZewP3FJJ/589YdSvYU+LMvTGdi/ewPxJJzfNBR8GdF0aTDHPSjZ2UOOZRUN
 1PQhuxJHKD3VY0JHJNTcqI1a9rZOg2IXDldrMVmQ9ssk051GRX6+JBim9dK5A6tx/HMv
 hwQkrmEYYLKWZbN/BkG5g50mXSN75kt/VT+/Ez/Je6e84/3EIaNhW9n4vbI9dbTFQir6
 3BqFQImamboANwo5bxHtGKqFhYAe2GqmWXwKV+D+SYivUM0IkELiI5R+xFE7p7GQ3V+u
 CN7Mng8qx1Bakd1TUNhm3q+IE7bLh+V5+jKdaWNXhjJ0+VPVs9bd8mB7lEKDmOqNqOhx
 3bYQ==
X-Gm-Message-State: AOAM530+bj+YxLrD6HVl6SZvQnU8rh/knVa2sBGfSKItxKuWywnlM3Vt
 I8+jYYk6y2HYqrvzAKSg2GvFRz7gS8A0IWqbK/0wjKAKNBbMGJQAbHP79XqmsZZl618WNA98zh1
 u4iY29IXWBOTXKs6rdQITkniV
X-Received: by 2002:a17:902:bb8c:b029:dc:2e5e:2b2 with SMTP id
 m12-20020a170902bb8cb02900dc2e5e02b2mr13242185pls.10.1613969060907; 
 Sun, 21 Feb 2021 20:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOa2eb4CQrT/ncR+h9iFyBY5fki5umtXxuZB9gaBTvUfQP8AGxjQHVIItflA8v5pCqvRsdFw==
X-Received: by 2002:a17:902:bb8c:b029:dc:2e5e:2b2 with SMTP id
 m12-20020a170902bb8cb02900dc2e5e02b2mr13242172pls.10.1613969060675; 
 Sun, 21 Feb 2021 20:44:20 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l11sm16495311pfd.194.2021.02.21.20.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Feb 2021 20:44:20 -0800 (PST)
Date: Mon, 22 Feb 2021 12:44:10 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs: support adjust lz4 history window size
Message-ID: <20210222044410.GA1038521@xiangao.remote.csb>
References: <20210218120049.17265-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20210218120049.17265-1-huangjianan@oppo.com>
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

On Thu, Feb 18, 2021 at 08:00:49PM +0800, Huang Jianan via Linux-erofs wrote:
> From: huangjianan <huangjianan@oppo.com>
> 
> lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> using rolling decompression, a block with a higher compression
> ratio will cause a larger memory allocation (up to 64k). It may
> cause a large resource burden in extreme cases on devices with
> small memory and a large number of concurrent IOs. So appropriately
> reducing this value can improve performance.
> 
> Decreasing this value will reduce the compression ratio (except
> when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> currently only supports 4k output, reducing this value will not
> significantly reduce the compression benefits.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/decompressor.c | 13 +++++++++----
>  fs/erofs/erofs_fs.h     |  3 ++-
>  fs/erofs/internal.h     |  3 +++
>  fs/erofs/super.c        |  3 +++
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1cb1ffd10569..94ae56b3ff71 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -36,22 +36,27 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>  	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>  					   BITS_PER_LONG)] = { 0 };
> +	unsigned int lz4_distance_pages = LZ4_MAX_DISTANCE_PAGES;
>  	void *kaddr = NULL;
>  	unsigned int i, j, top;
>  
> +	if (EROFS_SB(rq->sb)->compr_alg)
> +		lz4_distance_pages = DIV_ROUND_UP(EROFS_SB(rq->sb)->compr_alg,
> +						  PAGE_SIZE) + 1;
> +

Thanks for your patch, I agree that will reduce runtime memory
footpoint. and keep max sliding window ondisk in bytes (rather
than in blocks) is better., but could we calculate lz4_distance_pages
ahead when reading super_block?

Also, in the next cycle, I'd like to introduce a bitmap for available
algorithms (maximum 16-bit) for the next LZMA algorithm, and for each
available algorithm introduces an on-disk variable-array like below:
bitmap(16-bit)    2       1       0
                ...     LZMA    LZ4
__le16		compr_opt_off;      /* get the opt array start offset
                                       (I think also in 4-byte) */

compr alg 0 (lz4)	__le16	alg_opt_size;
	/* next opt off = roundup(off + alg_opt_size, 4); */
			__le16	lz4_max_distance;

/* 4-byte aligned */
compr alg x (if available)	u8	alg_opt_size;
				...

...

When reading sb, first, it scans the whole bitmap, and get all the
available algorithms in the image at once. And then read such compr
opts one-by-one.

Do you have some interest and extra time to implement it? :) That
makes me work less since I'm debugging mbpcluster compression now...

Thanks,
Gao Xiang

