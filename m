Return-Path: <linux-erofs+bounces-7-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDC1A4DC61
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 12:22:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6YDx4hgbz3blH;
	Tue,  4 Mar 2025 22:22:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741079874;
	cv=none; b=NdG/0IsVE01yvrbfnXOwlJ6dW6IMOP2VmYc1coMxWz7UyH5cKzlM0ZNs/7+OUYtY/GPgdH9h25i7IOaF6UDnrImMLSoUHZIj53j5DsO468frQlFgrCUpkgGIhs1kvhg7Xmhp4xllrCo9es5VlH+qTItG4H0wSqUTckdx4Qu6/i/plTTen1MdfCSEV4haGIxw9LobhGV8bdhyTNR1BKCSqwUNBVRBejQoULINkuxLzWcOBXbdBrTkdl3OwLh8KZg+Wg5FvOkEiDStjsAcowVDt8YHymUEsX9AK/aluH8CCq1E5OIMAFhZW2inU88iByiM18fj5efT6oEuikLJSeoRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741079874; c=relaxed/relaxed;
	bh=U7nVbwpLU0+lp6Hc0ee6jvbH0Pu/dJ0Otg1V1qw972I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD7bK6fqzlud1Mc3W/K4idsnRZT5Cr901hcjWvDVMfyJiLK9uLe/bK1hQAQvkZ9P8uosQLCJDhLEZWZ264u5ScB9OiRCNH96XPgWu4jkX2GcU0kLq1pSfrheTNqx473sP/FtnJn490bIKFjS272PvkF7LTbETqjUB+PD36oBwNaZCDLbd1bX3uTuM76TrynDuPgkBm1Wsf5N39EoIdRc2KvxGh22DvlwlR+7j+RyW+bHsdNf/rvmtiwB8tq/Tlni/3OqzNNy0KY+omTOO8zILyoeKIc0ni1zEFh6Qj9xOB7SkGfb3YAaYvYcekTq1eV7JGhjDbzB9nvIvzlWI8fdCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gHepfu0T; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gHepfu0T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6VTF1rYCz30WQ
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 20:17:52 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb37dso3459047a12.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Mar 2025 01:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741079869; x=1741684669; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U7nVbwpLU0+lp6Hc0ee6jvbH0Pu/dJ0Otg1V1qw972I=;
        b=gHepfu0TCdB3j2E8JRXb1oe3FVwfpYWlXzCfOcpJrJNT8bVDxw0QkCpym1sKkGQVGI
         h45O2FLJ+jKH1OYqhfW6YBCx3LldIpqbF/yPO+GehIk9kRjfelXVzLOV6OQUpvCR/hva
         gsmb3NJPeVwNJJtOe4m0OJN0aXW8redWxmNcIxwG+m1ZMK/WL8N1rxKOfaUhEUu5Ecod
         7J/77Dj3dp2zlnLvlE4nxGhubR6JBQYf77/Jmi6VAFEaTG4VykOHBCng/VEO1Lk3HWB/
         fskGWA0FS2jfx/880OXdLyduLMTH7UaoKJp1R7vV8X4JXf+yLGHbgckpOaO/YdlniM9z
         Z4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741079869; x=1741684669;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7nVbwpLU0+lp6Hc0ee6jvbH0Pu/dJ0Otg1V1qw972I=;
        b=u/PGl6FvVXu8TFmRrAbcxG6kuZc4fgakd/WSDcPlSV/lzFZH1+fkcCPSaoToyf2Tdf
         RCQQPf9uxlsWec0XRgZMXoHOuOEmaeR99LtjoGcUfTxVcA3zUJyzixOoP3mogh+5zfVp
         ZWTzqFPfPscGsQaIlJmk/kDyZ3lHt35x1w9i/sBZEz9hP0RX8FPoWpgbRX1IprwhyyFL
         wV9vxC9uAN3Qr/b3qGGKj2E1DjI0HhRNH9f3Cek8YCDWlGuN4i1EvZv+dtqPzal1PF4/
         SSSc2+SjzIf15392PFkTDGA7XafhY4vD2UMRRIOLFbgopirZRkNnP7ejTmfOdB2tGZsv
         skag==
X-Forwarded-Encrypted: i=1; AJvYcCWMfZOr/Kxi/DPqKXBxpCqDsf4yEGSziGaAagqpUNTxCBi4V8zb5o7dH+QZG3Ut2rTE3wAGnc2FxC72KA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9fBiDDZx18kaQkH1dHrJmeqNXduwx2G4561c3942jBYVlbjTK
	MxZeqZO7hLMIAMJ6azZAmFNFvoTGIIhsjF+uHjMGcuuh1dL+tyUYYmVpCU2tqhg=
X-Gm-Gg: ASbGnctKE6C6Adt4XuHr31ylqBlc32F+E90qmbCkXuxaxhmecQtZ/4mo19ZdtEeWqvG
	jW5WD0hcbrcvhrMiC6lBR4mufHMm36GMzdoPwf9/yhSEN2Cvk0DKx1/jxlDsXmdjZJcMVZYCXfo
	ssnet1xOhXLBjfoC7NK+rby1Wah9Umc+XPJzmj3ewwafXRWyOaERCAbSf9/gQ734Hn3L8sa/hdF
	LjSUFmrzhMwepg8lxAnp0vbatFQOYncYJZszISiYZLTMfOBZEcBWafbPA8qGZKnBs3mucmYWPJG
	HjDsLUu0KE06OEuKZX/NxAlEeQPpxgndWmmUMD4jFqAR0g14UsQayDdX1d/Nfonxlj7Ep1IP
X-Google-Smtp-Source: AGHT+IFEBbxQyaP0/2DWYOKB8ElC0B8gdpp7QbNW8c37nqwtwNfKPMEljUeKpMeGoOykV8PZYEcmVQ==
X-Received: by 2002:a05:6402:2789:b0:5e0:52df:d569 with SMTP id 4fb4d7f45d1cf-5e4d6b852d0mr16127811a12.28.1741079868692;
        Tue, 04 Mar 2025 01:17:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9dd8sm90968655ad.57.2025.03.04.01.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:17:48 -0800 (PST)
Message-ID: <6f4017dc-2b3d-4b1a-b819-423acb42d999@suse.com>
Date: Tue, 4 Mar 2025 19:47:34 +1030
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
To: Yunsheng Lin <linyunsheng@huawei.com>, Yishai Hadas <yishaih@nvidia.com>,
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
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, Dave Chinner
 <david@fromorbit.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20250228094424.757465-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250228094424.757465-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org



在 2025/2/28 20:14, Yunsheng Lin 写道:
> As mentioned in [1], it seems odd to check NULL elements in
> the middle of page bulk allocating, and it seems caller can
> do a better job of bulk allocating pages into a whole array
> sequentially without checking NULL elements first before
> doing the page bulk allocation for most of existing users.
> 
> Through analyzing of bulk allocation API used in fs, it
> seems that the callers are depending on the assumption of
> populating only NULL elements in fs/btrfs/extent_io.c and
> net/sunrpc/svc_xprt.c while erofs and btrfs don't, see:
> commit 91d6ac1d62c3 ("btrfs: allocate page arrays using bulk page allocator")

If you want to change the btrfs part, please run full fstests with 
SCRATCH_DEV_POOL populated at least.

[...]
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f0a1da40d641..ef52cedd9873 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -623,13 +623,26 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>   			   bool nofail)
>   {
>   	const gfp_t gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
> -	unsigned int allocated;
> +	unsigned int allocated, ret;
>   
> -	for (allocated = 0; allocated < nr_pages;) {
> -		unsigned int last = allocated;
> +	/* Defragment page_array so pages can be bulk allocated into remaining
> +	 * NULL elements sequentially.
> +	 */
> +	for (allocated = 0, ret = 0; ret < nr_pages; ret++) {
> +		if (page_array[ret]) {

You just prove how bad the design is.

All the callers have their page array members to initialized to NULL, or 
do not care and just want alloc_pages_bulk() to overwrite the 
uninitialized values.

The best example here is btrfs_encoded_read_regular().
Now your code will just crash encoded read.

Read the context before doing stupid things.

I find it unacceptable that you just change the code, without any 
testing, nor even just check all the involved callers.

> +			page_array[allocated] = page_array[ret];
> +			if (ret != allocated)
> +				page_array[ret] = NULL;
> +
> +			allocated++;
> +		}
> +	}
>   
> -		allocated = alloc_pages_bulk(gfp, nr_pages, page_array);
> -		if (unlikely(allocated == last)) {
> +	while (allocated < nr_pages) {
> +		ret = alloc_pages_bulk(gfp, nr_pages - allocated,
> +				       page_array + allocated);

I see the new interface way worse than the existing one.

All btrfs usage only wants a simple retry-until-all-fulfilled behavior.

NACK for btrfs part, and I find you very unresponsible not even bother 
running any testsuit and just submit such a mess.

Just stop this, no one will ever take you serious anymore.

Thanks,
Qu


