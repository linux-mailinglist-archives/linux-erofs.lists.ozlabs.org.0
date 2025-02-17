Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40509A38DFF
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 22:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739827924;
	bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZbIJ3v2G+sN7hLfEoOUak0YvF3o+01hqBcyrQGOJD41Jt+mvgT/vu1oXuUYvPopXs
	 NZlelGQQ6Wh9BlC2vGldIEAC1/AAsDWEw/budiMpUCRcNsiN1ghOm7+ix/vEynJnsu
	 qLeV8PXqzFBX8SARuq5ioVTGldMElZJPNRCtrcVG/sm72ObsKXgUrsfqOUWWX64+Hy
	 qXm79rEzoCoQ0KAUeevzUrGV4jq3AyO0CX+kwEQpC/wglCWYVITZI2F1TZF5WS4Yas
	 zbsV0YaeBLWzd2eNmIjwDALjhb/CoBM8EeSMaXjvZVOnlzNnKWI0VXmHisM1L3ssvi
	 T0EJdjC6G1fcQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxbTJ37pYz3blB
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 08:32:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739827922;
	cv=none; b=EvNWQYUMElCPULBg/enTZzBkJ5fTAfERoTcLazkk+Ay790Gz5Ff8+wRspSAyAjmrhLvJo4ONJudGMOg5zVGJJ/XA36XV8MgOttIsIWyKzjW5el7JVz9xyqcgyH9jSdTjGU3dpS6ZCVczygdJ/uEkfs/y4ca0Okpna3HX/b0QeirV30T/pUil7JCKZTnwrkL8Ds+Eep4MWkI/Xh/GXtfsHioke/ELxDZyIBzjQDj5rPnR7hb/eJ/shaIY/rqzRSeRv0/2nijghzNZQvKkksLTM9DrETM34+v2HhbV0aLGwQDcFarc/rj2/AYEbMJ6Aa/pel2QEjZJhyEamondvZlgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739827922; c=relaxed/relaxed;
	bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrNwNiTGFT2PIU0u3O1LUOZD5cbqfBCExWzjvza4aP5kwKOXUoFuhY8ZZ/8rXLz+R+ApKwTQcnwQfii2U3zav4TV6iAIfla8Z/bKxaRojEMajODxZNaFBBlp5UCmCSLE0c9KI1skA8P1pMZ1yy+aF2DzOzS/3SYG/kKB1+t/9xEx5jmg5XXOhtpS+h6ftHmbj+FKBzTpng4jyzIO10S9RX2/ALnHGMRScufv0wl1M+Sgi7eoo0rUnt+AQdEfORrvqdFMP9G+kpvNYt6SpzfEASGYhrLZx84IrVEOirJBnW4Wg4RVlBx0peT03JsU32tSi6Ekag4J2gi5iSlaHwJ4HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mt+sn0iN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=fromorbit.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mt+sn0iN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxbTF4gtNz2yDp
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 08:32:00 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2fc3fa00323so5063136a91.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 13:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739827919; x=1740432719; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
        b=mt+sn0iNHcwWYdtYctn1Ww1Be4DZDJUuYTGesoKNP6XGukyht++i54ujrbe6p4jcGH
         ujIEXdJ5rOWAX3J0s4rPeQQ2HW9PwvT1SwX0ArzyKkMPmBgR2ID/Hk+U8nDvwxZlZEC9
         a0s60YJ6fZVd2DL7ZXOuyblfGcZcojKUm5vy7v2O7O6Kw9tcxcdVtii8Zg7YSw84vbJU
         WbGZSbuL5+wOg13T2bEBpjpv6H5Y0xmw6GEU7Ljlt2GAFd55lA/Jp2C7yiqNAf6itMsG
         aokEhnOC1YKVfJerikcYdtut0c3FG5EmhKZM5H9HhHzDJXl2N1+fahv5K97vBrvPbee0
         Xu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827919; x=1740432719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
        b=U35Zb8vycaKdOWZ6ObTD/lns+mrwf0cT5kBolOu1Ip0EeO0z3aofr408KYv/yTI6fa
         2E4tsSSW9wZt/XnMFuW9w6Y9cCREcIH5NL+Nek5XfYkdGdgyoNT0HwPknwl5JpPNDuJe
         Os279Gtogk/CKr4hPBWBVrrDK2U+YWYjtxXgHEBIivZQWm5xiuwbXfKVuKVCJlQb2xNB
         xwQ+Q4//2+qQywdZBgjo/bjuCPdysSBeo/vIAj13TF8tPooXZfBgTDtaVnQAqTkXihMT
         u2dbS9NXa6pruHJ58dCaHDqGii3zMkOMK79DjoVrFGRJHWSWwkVyZel7Dzgy/4Jve6YS
         M7LA==
X-Forwarded-Encrypted: i=1; AJvYcCW/IgYk62o40r1rNpQeBU6ougEQ85mEgIss1xD1hQnvcf3TmIME8Fiditcq1tsFcPrtz6zXbze414e1cQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydXaC/OyOeAfQHtP1+Nu53JicKfsYaJipvWsV5CR3bZ9bHoW6P
	ntTE4GHj6PGeyKR/kJBDOJWcQt3vyVm5FHfb7tJLPgfw8xjPQDz5UFU5KbfDUfg=
X-Gm-Gg: ASbGncsDS0j9akgfc5nlhjBAkkaz7GgtlhxS4IGBRs8KgH3EuXJsj+hSnGpUQ8FHTxp
	+J3PVRi3xUrrBaOYbh6nsZWh6ZP3/HSHUSHbzOFdG6liYnkArmSH3aFygNUhwl2zbJrK6EEDmwL
	TXhHotM/Kff49biDm6J6jpaQnXmdzBkRDKeOHMZrWdYca0H1895Zv+fTpvfvZVdZkK+fIwCMdX6
	Kr9cOMfU2pP45uXLpW65SIL2tcv+qwryEn5aU6Dxq/4jtRDBo/Wxh0XWvIgxzh/66R6dO7agcpy
	9aFpOCGtmcuZq9t3jhXFayrvQOgHNXQ1w9kpiI8n9ZBkbdvjC3qP1a62lh4qNJeH4RU=
X-Google-Smtp-Source: AGHT+IGWbBJAtL2UtKSWCS6Jd9Ns/0Md8Y1s79IB++xb28sgasLU0+0/qaH46F3zNCw25wym7QqlJQ==
X-Received: by 2002:a17:90b:3b4b:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2fc4115087fmr15333822a91.31.1739827918683;
        Mon, 17 Feb 2025 13:31:58 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491d4sm76091525ad.4.2025.02.17.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 13:31:58 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tk8iZ-00000002XxN-2C1Y;
	Tue, 18 Feb 2025 08:31:55 +1100
Date: Tue, 18 Feb 2025 08:31:55 +1100
To: Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating only
 NULL elements
Message-ID: <Z7Oqy2j4xew7FW9Z@dread.disaster.area>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217123127.3674033-1-linyunsheng@huawei.com>
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

On Mon, Feb 17, 2025 at 08:31:23PM +0800, Yunsheng Lin wrote:
> As mentioned in [1], it seems odd to check NULL elements in
> the middle of page bulk allocating, and it seems caller can
> do a better job of bulk allocating pages into a whole array
> sequentially without checking NULL elements first before
> doing the page bulk allocation.
....

IMO, the new API is a poor one, and you've demonstrated it clearly
in this patch.

.....

> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 15bb790359f8..9e1ce0ab9c35 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -377,16 +377,17 @@ xfs_buf_alloc_pages(
>  	 * least one extra page.
>  	 */
>  	for (;;) {
> -		long	last = filled;
> +		long	alloc;
>  
> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
> -					  bp->b_pages);
> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> +					 bp->b_pages + refill);
> +		refill += alloc;
>  		if (filled == bp->b_page_count) {
>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
>  			break;
>  		}
>  
> -		if (filled != last)
> +		if (alloc)
>  			continue;

You didn't even compile this code - refill is not defined
anywhere.

Even if it did complile, you clearly didn't test it. The logic is
broken (what updates filled?) and will result in the first
allocation attempt succeeding and then falling into an endless retry
loop.

i.e. you stepped on the API landmine of your own creation where
it is impossible to tell the difference between alloc_pages_bulk()
returning "memory allocation failed, you need to retry" and
it returning "array is full, nothing more to allocate". Both these
cases now return 0.

The existing code returns nr_populated in both cases, so it doesn't
matter why alloc_pages_bulk() returns with nr_populated != full, it
is very clear that we still need to allocate more memory to fill it.

The whole point of the existing API is to prevent callers from
making stupid, hard to spot logic mistakes like this. Forcing
callers to track both empty slots and how full the array is itself,
whilst also constraining where in the array empty slots can occur
greatly reduces both the safety and functionality that
alloc_pages_bulk() provides. Anyone that has code that wants to
steal a random page from the array and then refill it now has a heap
more complex code to add to their allocator wrapper.

IOWs, you just demonstrated why the existing API is more desirable
than a highly constrained, slightly faster API that requires callers
to get every detail right. i.e. it's hard to get it wrong with the
existing API, yet it's so easy to make mistakes with the proposed
API that the patch proposing the change has serious bugs in it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
