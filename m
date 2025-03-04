Return-Path: <linux-erofs+bounces-5-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF858A4DC31
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 12:16:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6Y5r1llZz3blR;
	Tue,  4 Mar 2025 22:16:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741076321;
	cv=none; b=IgXdvUKXHZP7IuA9Db2DZds1OROYajnN4I/zW0pbJRZ1hpYUs4BF/olPB5F0Gq09Hs4/ohS/SXl5zU/299kKW1IgWrdx+yPT0yC4n6fUCuXH3/94CR8ZX7ug1dP5ICl9DRLBmdXcXki+0+kbLGAjRrIBfoKTiCLheSKAiwszqoK9bZ8bp8/wQ3Onz7pmS0MtQkFDqtt+scijPkjmSVvE+NWp65EqTm5KnCenivjS356RLUV9Zqvvtg2oxfdmKo15i9VDK0RuVBvYzJ8wZpC5cELRmWSaZz6keBgMu38n+5LgjQjKx5J34PxwMskqHWr1POwgR8X+B4hmQqfPq4rfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741076321; c=relaxed/relaxed;
	bh=Gc0xsYnTUQhvWodmw2ejFo3Ab0lc47BeE7G2ofWx65Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZI0Exp2LCa5+0bSTKopxojkO1Eba3OTlKfdDw8soFdwj4N6M+Y7dPXxqsFSEIq473D5/GO3y+Mwpl98pPfr3mUqKuLF2MRJtkuCXew2rm+07SnxoSPTeoQ9fxZ+fw8E8w6x754R2C7eY15zkYPTJVUdA229tJXeiK93XOhjzZqXO8SNwsfFofbdmaRMvHw/Z1r21AAH3n2lXOl6jKd4o0lXU1NkVNtTsfc1RJ6bMPUkWxwDXOXmdRgJj0XmRSt964ifHOkg5R+LpH/tZMU80wCl7FSEMOUr6gWE8+OY4UZl9uakTA+BiYWcunmeCnTccOVDoU1ZR9ISyxZV48UXAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=wB/vzZ+g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=fromorbit.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=wB/vzZ+g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6T8w4NRrz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 19:18:39 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2feae68f835so7557099a91.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Mar 2025 00:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741076317; x=1741681117; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc0xsYnTUQhvWodmw2ejFo3Ab0lc47BeE7G2ofWx65Q=;
        b=wB/vzZ+gpvTk0DFpv6tHtIL/yLTa+xRb9WL4fYBAIlIUsYa1btsHgzWo1L9N57aesO
         3n1USPD/c6Hf5lapjTe7z24xiK4t2ePxs3Qo460+r+rJR6CgcMemyg8qVBgYdFGLCNt+
         nmILNdcXxWZq+bqE3jeUCK0G+vE5KeYIZkdUYonq9SRtC85ujAVxR8v0M90bVPBvDJtF
         +6Dr1c33bjOn39B/EJAZsAIo9HCBQCs0dxngmc/o/ipyHQDY8cOYgAaEB+tkLWT1thYm
         vGhqFT1Vq9cWLggCZl4KI2uznyh08gmns+YcTvbAZCaby5ZkrdHqsLmzNibukQfp/CEd
         Pomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076317; x=1741681117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc0xsYnTUQhvWodmw2ejFo3Ab0lc47BeE7G2ofWx65Q=;
        b=QNkNmZOe/xzRvCeL0IargpzqS9b0AEkvaLbOPn0EAHly4CAyzY/ARmKFzy2jfkBjDF
         rNuOu+bIZEuy4ZYbxK2vKJE4hcZ+BxTBtBIURfNoHc+oGfyR3//UNTOuEv/8U0nb9OVH
         xYvnm+dSNEx6Av6S1KVpXOl9U7wTzpAGgOJyI9NO96GWRoAo5O6qEVwjSkyy9Dn9djQT
         xfkIIJF4FRCV+i5iN9uYa9ANeE5+uCF+2Axal/2fFNr/pHTpCAtpjv754srkeV9/NvqE
         EaK05w0riLMeebWeSgmlxISqznMSuf9dFJxnr3jvNliPH/BlQjnN0Wc89fOsUw0npPbt
         xTqg==
X-Forwarded-Encrypted: i=1; AJvYcCWr0mDVDdjJpGiU79b7DmVjJbegRSIAwuu9JUpI2u6+WRdO/uDH/rD3VBCWpHgDSq8teh5fAza+nbV2ng==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFidj8LVxhoelnOrFdttwvvxgJAy07mrKE3+s5v7YK4oEXepqr
	IGZyMOQxhImlMvKSA6yF0hRZXy7nTmSCf22W02nVnU60AE+j0UgfoVm5T0LmB4E=
X-Gm-Gg: ASbGncuRMuzK+n46JvDN0SB2KHdy6zaziyMF6lIT3pfLbNX6aJ0xzj5CZL1eNnRlw9s
	lRD09sGaMC8vWKGjxaZZjcC69//W17dv7czwPjsY2GaVglNWRJrVzLTTw14bVwf1FRIlKaa9TmQ
	mt+N/TZWzEVunHGlGxdXbubBr/5RmAra10UjczmvUyjmMDMWpfxCvycH76sI+tGzCM4BnWT1UkM
	xGVe+tzM2Ao3RycDVqJByj3Hh0yxSwjkMt66P07gocScCUH8/G6+1U+A/uZ3QoAeYyYcRnjCpWi
	aYSqgKUhyOW6R+BuJrjTh48W0CAruLecftmXnt/jy24RmjPhX8oGTovFD1CcgShZqBoanZDLrAR
	r42Tq/yDhus9iUDlEwins
X-Google-Smtp-Source: AGHT+IFtDzCgImtuz8L9+GYRCY4LVCLrXbK0Bo8kgf88DL3yFokQ0qmw0lddBixblhsY0xBrKZj7tQ==
X-Received: by 2002:a05:6a20:734a:b0:1ee:c390:58ad with SMTP id adf61e73a8af0-1f2f4e014f9mr29817034637.34.1741076317276;
        Tue, 04 Mar 2025 00:18:37 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19d3fsm9497416a12.18.2025.03.04.00.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:18:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpNU1-00000008fSI-4AHP;
	Tue, 04 Mar 2025 19:18:34 +1100
Date: Tue, 4 Mar 2025 19:18:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
Message-ID: <Z8a3WSOrlY4n5_37@dread.disaster.area>
References: <20250228094424.757465-1-linyunsheng@huawei.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228094424.757465-1-linyunsheng@huawei.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On Fri, Feb 28, 2025 at 05:44:20PM +0800, Yunsheng Lin wrote:
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
> commit d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
> commit c9fa563072e1 ("xfs: use alloc_pages_bulk_array() for buffers")
> commit f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
> 
> Change SUNRPC and btrfs to not depend on the assumption.
> Other existing callers seems to be passing all NULL elements
> via memset, kzalloc, etc.
> 
> Remove assumption of populating only NULL elements and treat
> page_array as output parameter like kmem_cache_alloc_bulk().
> Remove the above assumption also enable the caller to not
> zero the array before calling the page bulk allocating API,
> which has about 1~2 ns performance improvement for the test
> case of time_bench_page_pool03_slow() for page_pool in a
> x86 vm system, this reduces some performance impact of
> fixing the DMA API misuse problem in [2], performance
> improves from 87.886 ns to 86.429 ns.

How much slower did you make btrfs and sunrpc by adding all the
defragmenting code there?

> 
> 1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawei.com/
> 2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawei.com/
> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> CC: Luiz Capitulino <luizcap@redhat.com>
> CC: Mel Gorman <mgorman@techsingularity.net>
> CC: Dave Chinner <david@fromorbit.com>
> CC: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
> V2:
> 1. Drop RFC tag and rebased on latest linux-next.
> 2. Fix a compile error for xfs.

And you still haven't tested the code changes to XFS, because
this patch is also broken.

> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 5d560e9073f4..b4e95b2dd0f0 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -319,16 +319,17 @@ xfs_buf_alloc_pages(
>  	 * least one extra page.
>  	 */
>  	for (;;) {
> -		long	last = filled;
> +		long	alloc;
>  
> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
> -					  bp->b_pages);
> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - filled,
> +					 bp->b_pages + filled);
> +		filled += alloc;
>  		if (filled == bp->b_page_count) {
>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
>  			break;
>  		}
>  
> -		if (filled != last)
> +		if (alloc)
>  			continue;

alloc_pages_bulk() now returns the number of pages allocated in the
array. So if we ask for 4 pages, then get 2, filled is now 2. Then
we loop, ask for another 2 pages, get those two pages and it returns
4. Now filled is 6, and we continue.

Now we ask alloc_pages_bulk() for -2 pages, which returns 4 pages...

Worse behaviour: second time around, no page allocation succeeds
so it returns 2 pages. Filled is now 4, which is the number of pages
we need, so we break out of the loop with only 2 pages allocated.
There's about to be kernel crashes occur.....

Once is a mistake, twice is compeltely unacceptable.  When XFS stops
using alloc_pages_bulk (probably 6.15) I won't care anymore. But
until then, please stop trying to change this code.

NACK.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

