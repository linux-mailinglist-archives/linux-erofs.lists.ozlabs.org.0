Return-Path: <linux-erofs+bounces-22-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90829A58431
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Mar 2025 14:23:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z9ghs0WJVz2yjV;
	Mon, 10 Mar 2025 00:23:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::642"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741526636;
	cv=none; b=aati0LG/b26LkqqyRO5zFj5tpx2fVrtozGQrA2F71n6L/TymKqv++U1ienwAG9+BL5rBUjVqBdGLo+sMEcwkS8gABObrCTEtpeFJ7JtsLsfBbKvS8umkFxDM1BCo96YY5HK2asonhZitvloM8uZpPuAhAaFsIotOGLP3CDtclHjYvmmcp1qCbP08GFgBb2OIarjg+4eAV1fIj4jv3+xqTQ73s0I9kR5yAgfeqtLjdai4WZaV7zlN++2ZaMo4K5FY/0wRb9x4oNym6NMC1ZYtiO6j/zR4tinF2VriHAlMuuyuXFO8mCFKCCBxm+ySHImWJOOPU5pXRixTcU1AdAYA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741526636; c=relaxed/relaxed;
	bh=78f5GfsZLdHs7HcZYqhufn9bqBeaLB9GfsmUNDdGsAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr5VQUItSi7RhiE9/uqjuLJMXYEuypKF/S2r0BIaVK7ZWKQOI3qAkWwfCN3UGZu6DBvs0vWjnkq4LydY0R91C4DeP/Prun5n0iWfHbg0QtmHrQq3uL0p9kSvwudjaBLqRfwaWI5xweSqxedcNtq6QUcxHXUnY2lGDn+GnrmPtNs/dmgHOhEbaAk1ork4qC1W3DIRbgcBy6ZPodbHYGqnVoPhNe8BdI4G2xylsMU0KukVw0uzpmgFTwdxsAycw1AswR8l6BSCehSedD6jQyfgmT24LpOKISpSyHPQE2qlAHgEPjizGkEJNCbHuUVfQFxR3X5msFEase8u7+Dp0/93Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PJWy4bEt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=yunshenglin0825@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PJWy4bEt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=yunshenglin0825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z9ghr1GjKz2ygY
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 00:23:55 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-224171d6826so41444415ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 09 Mar 2025 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741526632; x=1742131432; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78f5GfsZLdHs7HcZYqhufn9bqBeaLB9GfsmUNDdGsAU=;
        b=PJWy4bEtYcbmPsWeblV1SF9if6pUP7XTjQ5bMLHp6h0e98APcljMdvn2VsnAlVJZa7
         Oqoz33meiCcMTOfO83meZgWheLTJV0FPA3YLGeTrD37gHANUSsZY+DxPOYAEqvb6k0Nm
         3wSQ+PnVBz2LPpA6xzlhwx8nOC5vMouFoE1qMkxAgCj7EWkRfvD5javBt2V+8V+s1Vxr
         /I21uba9XFAsNQOkfo1vgkQL9LygceX93GMeqYBw7Zuay+tql2S0HxYZblRHUQta+HCp
         iys6GzBIs0I7ncsH9rYUznvVhRfQ6pX0OxnzkjIo3T52/CSiyFchXdvPkkdR9PYXJLnG
         +wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526632; x=1742131432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78f5GfsZLdHs7HcZYqhufn9bqBeaLB9GfsmUNDdGsAU=;
        b=LbMvCyR5XfPaPBsL9uf9CHCN/3HvmBhcul5zIxcXtgInGR5ayauZyEM9EFoNtQiY6w
         +bvN13blC8ETXPms3Isb5vOemZCDIzQS8WNlLnXvwXtAqpoA/tNx/0j/LFQ8NjB2HHWK
         tOLNUiWj1lxdRWN4p0IpWURAiKuG9ukZVWbaPOeAkzuakCbQlMY3ZG6tB7JwYk3f57YU
         gLGsI1eE3XMLgaSpE1vJO6qUyW5h+2KS36t2Gg5S64A5FecUFHn6YVwThpGVHLNf0qHS
         Qo4QUnjVsh1ZT/ATPVIxyaSJiAIAxyczyB0IeSkUb9JB3ZHtkNsb4NzgftH8xpQ07+c5
         g5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI8o4KtPoBt7iBZ2402ieNtHF+0GwR51nEKZnVX4FTkVIhKQbXzU6qk91D5WC4ourgIdnbJ6BbRwZVyQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yziyw9ADVmW8ViapnABDvu0fZTX5ATEdTSMLbzBt8MHCyc/NtwJ
	dxRkI6fP/0lw9yeSv6rxiGPPvabVe0KXJJkdTML3W3FCJXvYbIFi
X-Gm-Gg: ASbGnctaBMZNmOqr3jZxIEoqwxgtw1BkDHsbvOyoEkMDKWIywrbYoPusiV8tART929U
	0PxQ2R6UD1Kno5s5fxWXKOi1rYHX+KE4XyZdzxfrS+/0vF6MaUR70rfGh9EB+VDL7s23x/Q6Rr0
	qCuY1fmXcDKz2hEibMBs316kQKal8gQfgu+nsEFavk6R0fLvIDTm2evgnNF+4DedwvpHThWvGg4
	Vii/7Pharh9o8Ng8FLZ6sOsaknlokHUxvlCSoX4odohESvKrlO4CwoPV3NJBHrSh3lDz9kkZ4yw
	H2QojKtVEpRhPN9jExnvdEqjgaGsp7Rc3J+AdTcW7iD+/wIXmlmnDoe+Vs5VSMDVlsebGyLbI80
	20s1rfuYMZeqKYw7Z1sTdjn26ReSDFAG/dR9i2l4P
X-Google-Smtp-Source: AGHT+IFtC936bSg/3HregqNsD+RiIvE+I7Cf0Sja++qaGUNlZeLkZuXJlqOzuqqV2Wpl3dx1MeKXQQ==
X-Received: by 2002:a17:902:eb81:b0:220:c86d:d7eb with SMTP id d9443c01a7336-22428ab863cmr167985465ad.36.1741526632153;
        Sun, 09 Mar 2025 06:23:52 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:c508:514a:4065:877? ([2409:8a55:301b:e120:c508:514a:4065:877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d4f20913sm597161b3a.13.2025.03.09.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 06:23:51 -0700 (PDT)
Message-ID: <7abb0e8c-f565-48f0-a393-8dabbabc3fe2@gmail.com>
Date: Sun, 9 Mar 2025 21:23:35 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: NeilBrown <neilb@suse.de>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: Qu Wenruo <wqu@suse.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, Dave Chinner
 <david@fromorbit.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org
References: <> <180818a1-b906-4a0b-89d3-34cb71cc26c9@huawei.com>
 <174138137096.33508.11446632870562394754@noble.neil.brown.name>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <174138137096.33508.11446632870562394754@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 3/8/2025 5:02 AM, NeilBrown wrote:

...

>>
>>>    allocated pages in the array - just like the current
>>>    alloc_pages_bulk().
>>
>> I guess 'the total number of allocated pages in the array ' include
>> the pages which are already in the array before calling the above
>> API?
> 
> Yes - just what the current function does.
> Though I don't know that we really need that detail.
> I think there are three interesting return values:
> 
> - hard failure - don't bother trying again soon:   maybe -ENOMEM
> - success - all pages are allocated:  maybe 0 (or 1?)
> - partial success - at least one page allocated, ok to try again
>    immediately - maybe -EAGAIN (or 0).

Yes, the above makes sense. And I guess returning '-ENOMEM' & '0' &
'-EAGAIN' seems like a more explicit value.

> 
>>

...

>>
> 
> If I were do work on this (and I'm not, so you don't have to follow my
> ideas) I would separate the bulk_alloc into several inline functions and
> combine them into the different interfaces that you want.  This will
> result in duplicated object code without duplicated source code.  The
> object code should be optimal.

Thanks for the detailed suggestion, it seems feasible.
If the 'add to a linked list' dispose was not removed in the [1],
I guess it is worth trying.
But I am not sure if it is still worth it at the cost of the above
mentioned 'duplicated object code' considering the array defragmenting
seem to be able to unify the dispose of 'add to end of array' and
'add to next hole in array'.

I guess I can try with the easier one using array defragmenting first,
and try below if there is more complicated use case.

1. 
https://lore.kernel.org/all/f1c75db91d08cafd211eca6a3b199b629d4ffe16.1734991165.git.luizcap@redhat.com/

> 
> The parts of the function are:
>   - validity checks - fallback to single page allocation
>   - select zone - fallback to single page allocation
>   - allocate multiple pages in the zone and dispose of them
>   - allocate a single page
> 
> The "dispose of them" is one of
>    - add to a linked list
>    - add to end of array
>    - add to next hole in array
> 
> These three could be inline functions that the "allocate multiple pages"
> and "allocate single page" functions call.  We can pass these as
> function arguments and the compile will inline them.
> I imagine these little function would take one page and return
> a bool indicating if any more are wanted.
> 
> The three functions: alloc_bulk_array alloc_bulk_list
> alloc_bulk_refill_array would each look like:
> 
>    validity checks: do we need to allocate anything?
> 
>    if want more than one page &&
>       am allowed to do mulipage (e.g. not __GFP_ACCOUNT) &&
>       zone = choose_zone() {
>          alloc_multi_from_zone(zone, dispose_function)
>    }
>    if nothing allocated
>       alloc_single_page(dispose_function)
> 
> Each would have a different dispose_function and the initial checks
> would be quite different, as would the return value.
> 
> Thanks for working on this.
> 
> NeilBrown
> 


