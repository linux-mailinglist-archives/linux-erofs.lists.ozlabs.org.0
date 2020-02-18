Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA80163666
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 23:48:37 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MbcM0pRrzDqc7
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 09:48:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mail104.syd.optusnet.com.au (client-ip=211.29.132.246;
 helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fromorbit.com
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au
 [211.29.132.246])
 by lists.ozlabs.org (Postfix) with ESMTP id 48MbcG1qHNzDqNX
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 09:48:30 +1100 (AEDT)
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D144F7E9387;
 Wed, 19 Feb 2020 09:48:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j4BfJ-0003lA-7e; Wed, 19 Feb 2020 09:48:29 +1100
Date: Wed, 19 Feb 2020 09:48:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 04/19] mm: Rearrange readahead loop
Message-ID: <20200218224829.GU10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-5-willy@infradead.org>
 <20200218050824.GJ10776@dread.disaster.area>
 <20200218135736.GP7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218135736.GP7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=alOI8opFAFPe2SRtgw8A:9
 a=xQkswpi2j_EUEYvS:21 a=GSRXKHwoUNCfdhKr:21 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 18, 2020 at 05:57:36AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 04:08:24PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:45AM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Move the declaration of 'page' to inside the loop and move the 'kick
> > > off a fresh batch' code to the end of the function for easier use in
> > > subsequent patches.
> > 
> > Stale? the "kick off" code is moved to the tail of the loop, not the
> > end of the function.
> 
> Braino; I meant to write end of the loop.
> 
> > > @@ -183,14 +183,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
> > >  		page = xa_load(&mapping->i_pages, page_offset);
> > >  		if (page && !xa_is_value(page)) {
> > >  			/*
> > > -			 * Page already present?  Kick off the current batch of
> > > -			 * contiguous pages before continuing with the next
> > > -			 * batch.
> > > +			 * Page already present?  Kick off the current batch
> > > +			 * of contiguous pages before continuing with the
> > > +			 * next batch.  This page may be the one we would
> > > +			 * have intended to mark as Readahead, but we don't
> > > +			 * have a stable reference to this page, and it's
> > > +			 * not worth getting one just for that.
> > >  			 */
> > > -			if (readahead_count(&rac))
> > > -				read_pages(&rac, &page_pool, gfp_mask);
> > > -			rac._nr_pages = 0;
> > > -			continue;
> > > +			goto read;
> > >  		}
> > >  
> > >  		page = __page_cache_alloc(gfp_mask);
> > > @@ -201,6 +201,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
> > >  		if (page_idx == nr_to_read - lookahead_size)
> > >  			SetPageReadahead(page);
> > >  		rac._nr_pages++;
> > > +		continue;
> > > +read:
> > > +		if (readahead_count(&rac))
> > > +			read_pages(&rac, &page_pool, gfp_mask);
> > > +		rac._nr_pages = 0;
> > >  	}
> > 
> > Also, why? This adds a goto from branched code that continues, then
> > adds a continue so the unbranched code doesn't execute the code the
> > goto jumps to. In absence of any explanation, this isn't an
> > improvement and doesn't make any sense...
> 
> I thought I was explaining it ... "for easier use in subsequent patches".

Sorry, my braino there. :) I commented on the problem with the first
part of the sentence, then the rest of the sentence completely
failed to sink in.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
