Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92186163B83
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 04:43:34 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Mk8g4MTczDqdZ
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 14:43:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mail105.syd.optusnet.com.au (client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fromorbit.com
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by lists.ozlabs.org (Postfix) with ESMTP id 48Mk8Z0cdxzDqbq
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 14:43:25 +1100 (AEDT)
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 880BB3A1C09;
 Wed, 19 Feb 2020 14:43:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j4GGi-0005Z3-WB; Wed, 19 Feb 2020 14:43:25 +1100
Date: Wed, 19 Feb 2020 14:43:24 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 19/19] mm: Use memalloc_nofs_save in readahead path
Message-ID: <20200219034324.GG10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-33-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8
 a=EUu7BJ-CshYY2WUz2RUA:9 a=Ins956pMss7IOATM:21 a=TqZTP-Om_uFHSJHF:21
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: linux-xfs@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 17, 2020 at 10:46:13AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Ensure that memory allocations in the readahead path do not attempt to
> reclaim file-backed pages, which could lead to a deadlock.  It is
> possible, though unlikely this is the root cause of a problem observed
> by Cong Wang.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/readahead.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 94d499cfb657..8f9c0dba24e7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -22,6 +22,7 @@
>  #include <linux/mm_inline.h>
>  #include <linux/blk-cgroup.h>
>  #include <linux/fadvise.h>
> +#include <linux/sched/mm.h>
>  
>  #include "internal.h"
>  
> @@ -174,6 +175,18 @@ void page_cache_readahead_limit(struct address_space *mapping,
>  		._nr_pages = 0,
>  	};
>  
> +	/*
> +	 * Partway through the readahead operation, we will have added
> +	 * locked pages to the page cache, but will not yet have submitted
> +	 * them for I/O.  Adding another page may need to allocate memory,
> +	 * which can trigger memory reclaim.  Telling the VM we're in
> +	 * the middle of a filesystem operation will cause it to not
> +	 * touch file-backed pages, preventing a deadlock.  Most (all?)
> +	 * filesystems already specify __GFP_NOFS in their mapping's
> +	 * gfp_mask, but let's be explicit here.
> +	 */
> +	unsigned int nofs = memalloc_nofs_save();
> +

So doesn't this largely remove the need for all the gfp flag futzing
in the readahead path? i.e. almost all readahead allocations are now
going to be GFP_NOFS | GFP_NORETRY | GFP_NOWARN ?

If so, shouldn't we just strip all the gfp flags and masking out of
the readahead path altogether?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
