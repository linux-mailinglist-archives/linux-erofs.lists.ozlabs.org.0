Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6AFA3AA93
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 22:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739913279;
	bh=i/TFjjFVKbDA3nMhW4Nd4g/ebT5hNi/7fITiKNmhUzM=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CyxU6ccMmjBnGhwk1QLmScgv930pfNbbfZteX8Po6PifmhRap9LXLgPkKJ/tU8Fmo
	 o4MDaGGrNa0XmMrWScgcLauR+99L6YNR5VCz+TSzGziCv4xwKHfcO35X/3lnzSuI45
	 Npd9viAQYQfLeZj106GNrAhB2x+PhE2zL3Tf8jUD68AG2j/lj6mdFWUZplZBBuXr9/
	 c5p5zw9M9RajYpJWa6CtHeYgmTHXGpEqJgvjrNavXS4P+RlypdZacnAaA/zoBF/bFm
	 3roekuUxzW/wa5LWQgz0Q7b7YEorL7cJLAn2hy4HsR0tiO9xQrzwwQGRaHS9cQ99dY
	 MrfsBVM9xiw9A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyC2l3JxGz30H7
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2025 08:14:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739913277;
	cv=none; b=cU33sKXJdNPRjdefAMxBpke7SJKkKwWRlejoun0eelmpayNtPK+q/llZUv3iiDtX5ttntLm8SRhwGStEADAjOvUfpmb5Sv+42S+A1900QucObUOOWf1nRHS4uAn9klrpd0LS6kP1MZvESxuowoBZHIzamWkqCSZFwcuWDF0rORTgB86Q/CdhgumVAgwd76PA/ECFZDOY1WkhozxAMbMXifi2Jc+36/JC5TGM0nZLgjUULS22i8KwmMb3FIAQHMqQ2El0aR++RwMiTgoDHPx0waVWTIrTvPvd0VV7bwlj6FL98RswODc4M1ZJL+T7qezAJf+0grWnu1fKZFJiNvbyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739913277; c=relaxed/relaxed;
	bh=i/TFjjFVKbDA3nMhW4Nd4g/ebT5hNi/7fITiKNmhUzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzkNsWQYTHSotvpJQeD1AA/HDqt2ypWd9Iy3EkNDabBAuiU56/PmGej+fiI015ByQwh+eLdT5VVLuI37J0tuE7WwyQqE78gf0hVpG2WA9O0atdUmS4TW8PTkohVsCBUzNM1OkREbI+gM1Lwpjn56N80lNmMNVlPmqCC865zf0fLHlQrlbF+8/iPxeh719+iuXn+4E2bvCPeiv14dLHE84S3OCd9b3HDFCrce72nWK+xo1IQq6VFjmznnqoHpmmrgp0KQdG7qf90mFd1ksUBbYN1LE1uBEY/x6qiQpSgolQNsnFzjL8MGJByz2NuiPg6d4ccqM4X7xUKkOflgboV0VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ebNWed0r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=fromorbit.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ebNWed0r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyC2h39Nhz2x9g
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2025 08:14:35 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-22101839807so78892685ad.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 13:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739913273; x=1740518073; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/TFjjFVKbDA3nMhW4Nd4g/ebT5hNi/7fITiKNmhUzM=;
        b=ebNWed0rm5GN9/DMrA6gKaW9H8r/mynu7qfvTcusApkI8qQxLKJPMIZMZyC8TDFuNc
         0H1bT6u2Zy1V1bbaOIDHJxGW55GOgQIBC8deUReaS0PsEZ5TnRjYxUG07TCW0BYFehTV
         LGEV7fzl+GPZJCxo6K+AKU/aMLJpRXu4uAkZsjOn+nilG5GPn7HLHkm6yBO8dlZ0fIie
         hbGA4zqPMPoh3WgWfigsoSIWEJ6jMLZ8ery9XlYMKzqPWjSFV0kEKTvYXeK6eKSDulto
         gbjUQFoa8msGOhBxGHNEO94FMHZF6QAaFZ35i1QzA8UZEwDL1WnjsTzTRvWvPLFMpiE6
         /LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913273; x=1740518073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/TFjjFVKbDA3nMhW4Nd4g/ebT5hNi/7fITiKNmhUzM=;
        b=XQ46kiI8TaW6WhPe+aO/f/mbzzHysHU01g3K2eipqBrm4yBEjqd60fKQ3CcFZHBfgL
         jyV91HIKwEVEsxKgfL1qjXjJznyw0Ru5oWM9mK+jugRb+Hv1oDZUZIi4azf+f0idmahD
         s165ufq7qPGc+Vuuy22cwSRnRnCEzzwv/u0a1NmgyuQ4k+zQOxtLBfTm7zi0MvUrpaRi
         AlHzNgqQl8F1pCEuni7WdJ4S1+0Iuo6Mk27jey+V6Ytnn/BE6qB8JEWuXKOehA6arzhh
         x+KADYE5Gvrm02BYtnqnUZ1ycECSb3Rl4KcNfbKpjbcemEYigb0jGUYmCXHc8IwyRDQp
         G9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc3jYQuWScOkNi8L85VDDlN3NSgOUFGDI5Fd4GHxaVs5aa0wgTfgJTb3U/PBInZq2ANZsPMOULWMd6ig==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8qPxv2xEYYFRE/tZVXNxN7j8vRifRXIuaOoCCPg5Q/akKwau/
	0iudFkJDSO0K3TI/wVm5/IpW1VKLHHxAA04IZTFe1qaO2xgCD2LTXaO0iPRwKuk=
X-Gm-Gg: ASbGncvVJ6u7/rOLWjcKV9TZi2/Z8u1MsMDuquW9wnCX7vpUzAKN5+KmmUAjox0YGc7
	12FtjNm3BcizMuKARla6cRb2HcDwoYiXpmr0cFal4Lvyj/uBqAJomqIyRuQ1s8b7oeBQWc2MkUz
	EQFZeEwMXkF6D8TVy0PgTPnOlN5t5XrFOTQ4fuR4kGzsbbIsu3tI3oFyMClS3cdulcjTDvYF8hQ
	WPDL3+RbRIEF/Dwn1aHv+19Z36sCVnF6DZnfaw6hG1dG9k0xTzJp+dVa6MPYRWCnyxWh++s2gtI
	VgtJQvmGB1ogEAXRv8Bbe5LCUCZ15xFto23xK2ZB9fe4IZWkhnd8qiL95f3V/ehnvBc=
X-Google-Smtp-Source: AGHT+IE4cq05OkjYUSAgnZzqAzKf40dxIlYKr7v+HOFdczvTt57phu0weZ5JY1SWVHQCE16yV/OTUA==
X-Received: by 2002:a17:902:d50e:b0:221:337:4862 with SMTP id d9443c01a7336-2217086de01mr12977035ad.15.1739913273049;
        Tue, 18 Feb 2025 13:14:33 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f34sm93829725ad.10.2025.02.18.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:14:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkUvF-00000002xpK-2NTA;
	Wed, 19 Feb 2025 08:14:29 +1100
Date: Wed, 19 Feb 2025 08:14:29 +1100
To: Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating only
 NULL elements
Message-ID: <Z7T4NZAn4wD_DLTl@dread.disaster.area>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
 <Z7Oqy2j4xew7FW9Z@dread.disaster.area>
 <cf270a65-c9fa-453a-b7a0-01708063f73e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf270a65-c9fa-453a-b7a0-01708063f73e@huawei.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: kvm@vger.kernel.org, Neil Brown <neilb@suse.de>, "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, Eric Dumazet <edumazet@google.com>, Anna Schumaker <anna@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Olga Kornievskaia <okorniev@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Josef Bacik <josef@toxicpanda.com>, virtualization@lists.linux.dev, Tom Talpey <tom@talpey.com>, Alex Williamson <alex.williamson@redhat.com>, David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, linux-xfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, linux-btrfs@vger.kernel.org, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "David S. Miller" <davem@davemloft.net>, Trond Myklebust <trondmy@kernel.org>, Luiz Capitulino <luizcap@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 18, 2025 at 05:21:27PM +0800, Yunsheng Lin wrote:
> On 2025/2/18 5:31, Dave Chinner wrote:
> 
> ...
> 
> > .....
> > 
> >> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> >> index 15bb790359f8..9e1ce0ab9c35 100644
> >> --- a/fs/xfs/xfs_buf.c
> >> +++ b/fs/xfs/xfs_buf.c
> >> @@ -377,16 +377,17 @@ xfs_buf_alloc_pages(
> >>  	 * least one extra page.
> >>  	 */
> >>  	for (;;) {
> >> -		long	last = filled;
> >> +		long	alloc;
> >>  
> >> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
> >> -					  bp->b_pages);
> >> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> >> +					 bp->b_pages + refill);
> >> +		refill += alloc;
> >>  		if (filled == bp->b_page_count) {
> >>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
> >>  			break;
> >>  		}
> >>  
> >> -		if (filled != last)
> >> +		if (alloc)
> >>  			continue;
> > 
> > You didn't even compile this code - refill is not defined
> > anywhere.
> > 
> > Even if it did complile, you clearly didn't test it. The logic is
> > broken (what updates filled?) and will result in the first
> > allocation attempt succeeding and then falling into an endless retry
> > loop.
> 
> Ah, the 'refill' is a typo, it should be 'filled' instead of 'refill'.
> The below should fix the compile error:
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -379,9 +379,9 @@ xfs_buf_alloc_pages(
>         for (;;) {
>                 long    alloc;
> 
> -               alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> -                                        bp->b_pages + refill);
> -               refill += alloc;
> +               alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - filled,
> +                                        bp->b_pages + filled);
> +               filled += alloc;
>                 if (filled == bp->b_page_count) {
>                         XFS_STATS_INC(bp->b_mount, xb_page_found);
>                         break;
> 
> > 
> > i.e. you stepped on the API landmine of your own creation where
> > it is impossible to tell the difference between alloc_pages_bulk()
> > returning "memory allocation failed, you need to retry" and
> > it returning "array is full, nothing more to allocate". Both these
> > cases now return 0.
> 
> As my understanding, alloc_pages_bulk() will not be called when
> "array is full" as the above 'filled == bp->b_page_count' checking
> has ensured that if the array is not passed in with holes in the
> middle for xfs.

You miss the point entirely. Previously, alloc_pages_bulk() would
return a value that would tell us the array is full, even if we
call it with a full array to begin with.

Now it fails to tell us that the array is full, and we have to track
that precisely ourselves - it is impossible to tell the difference
between "array is full" and "allocation failed". Not being able to
determine from the allocation return value whether the array is
ready for use or whether another go-around to fill it is needed is a
very poor API choice, regardless of anything else.

You've already demonstrated this: tracking array usage in every
caller is error-prone and much harder to get right than just having
alloc_pages_bulk() do everything for us.

> > The existing code returns nr_populated in both cases, so it doesn't
> > matter why alloc_pages_bulk() returns with nr_populated != full, it
> > is very clear that we still need to allocate more memory to fill it.
> 
> I am not sure if the array will be passed in with holes in the
> middle for the xfs fs as mentioned above, if not, it seems to be
> a typical use case like the one in mempolicy.c as below:
> 
> https://elixir.bootlin.com/linux/v6.14-rc1/source/mm/mempolicy.c#L2525

That's not "typical" usage. That is implementing "try alloc" fast
path that avoids memory reclaim with a slow path fallback to fill
the rest of the array when the fast path fails.

No other users of alloc_pages_bulk() is trying to do this.

Indeed, it looks somewhat pointless to do this here (i.e. premature
optimisation!), because the only caller of
alloc_pages_bulk_mempolicy_noprof() has it's own fallback slowpath
for when alloc_pages_bulk() can't fill the entire request.

> > IOWs, you just demonstrated why the existing API is more desirable
> > than a highly constrained, slightly faster API that requires callers
> > to get every detail right. i.e. it's hard to get it wrong with the
> > existing API, yet it's so easy to make mistakes with the proposed
> > API that the patch proposing the change has serious bugs in it.
> 
> IMHO, if the API is about refilling pages for the only NULL elements,
> it seems better to add a API like refill_pages_bulk() for that, as
> the current API seems to be prone to error of not initializing the
> array to zero before calling alloc_pages_bulk().

How is requiring a well defined initial state for API parameters
"error prone"?  What code is failing to do the well known, defined
initialisation before calling alloc_pages_bulk()?

Allowing uninitialised structures in an API (i.e. unknown initial
conditions) means we cannot make assumptions about the structure
contents within the API implementation.  We cannot assume that all
variables are zero on the first use, nor can we assume that anything
that is zero has a valid state.

Again, this is poor API design - structures passed to interfaces
-should- have a well defined initial state, either set by a *_init()
function or by defining the initial state to be all zeros (i.e. via
memset, kzalloc, etc).

Performance and speed is not an excuse for writing fragile, easy to
break code and APIs.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
