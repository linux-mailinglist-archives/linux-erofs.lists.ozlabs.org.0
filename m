Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4C163A17
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 03:23:17 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MhMz3VSVzDqgP
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 13:23:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=ZnvNzleU; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MhMq6Qk3zDqCB
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 13:23:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AmBYu3mpTxz55oEbZdrXdPhOFuVVUVpBKAkDMjhC+bk=; b=ZnvNzleUFxBP7YT/XJ7y0Rz/bu
 VkddBEMMXKNPUEPIHNmeV0img3eiMCgmTDLWhnmF0LgRkhumSClEFtJ8h9QNQ1gTWJ7cQ7oYl5y2T
 LQq1+MXm3VWWly+rUeCiBOlqF7kPYFOalIjZFbqYzu76qbt0PLrQYATKJKLlxP1jWBvgL8vVEl1oK
 PZK3QLY1XvI1RwzN3cfFLeaib3/PQmj6eNOnYQSQu+wNZ3jLp3NgdPPwpBmDQq/4dju6xWjfr9B1l
 Je53RqtXvIb3d5xbLSBBBArNi+TgTTRpln+YO9xoRn4KQfP+zLPQhoOJyXxsL0Z4nCcXJHdASLsqc
 D4fDP3AQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4F0v-0003R5-2P; Wed, 19 Feb 2020 02:23:01 +0000
Date: Tue, 18 Feb 2020 18:23:00 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 09/19] mm: Add page_cache_readahead_limit
Message-ID: <20200219022300.GJ24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-16-willy@infradead.org>
 <1263603d-f446-c447-2eac-697d105fa76c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1263603d-f446-c447-2eac-697d105fa76c@nvidia.com>
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

On Tue, Feb 18, 2020 at 05:32:31PM -0800, John Hubbard wrote:
> > +			page_cache_readahead_limit(inode->i_mapping, NULL,
> > +					index, LONG_MAX, num_ra_pages, 0);
> 
> 
> LONG_MAX seems bold at first, but then again I can't think of anything smaller 
> that makes any sense, and the previous code didn't have a limit either...OK.

Probably worth looking at Dave's review of this and what we've just
negotiated on the other subthread ... LONG_MAX is gone.

> I also wondered about the NULL file parameter, and wonder if we're stripping out
> information that is needed for authentication, given that that's what the newly
> written kerneldoc says the "file" arg is for. But it seems that if we're this 
> deep in the fs code's read routines, file system authentication has long since 
> been addressed.

The authentication is for network filesystems.  Local filesystems
generally don't use the 'file' parameter, and since we're going to be
calling back into the filesystem's own readahead routine, we know it's
not needed.

> Any actually I don't yet (still working through the patches) see any authentication,
> so maybe that parameter will turn out to be unnecessary.
> 
> Anyway, It's nice to see this factored out into a single routine.

I'm kind of thinking about pushing the rac in the other direction too,
so page_cache_readahead_unlimited(rac, nr_to_read, lookahead_size).

> > +/**
> > + * page_cache_readahead_limit - Start readahead beyond a file's i_size.
> 
> 
> Maybe: 
> 
>     "Start readahead to a caller-specified end point" ?
> 
> (It's only *potentially* beyond files's i_size.)

My current tree has:
 * page_cache_readahead_exceed - Start unchecked readahead.


> > + * @mapping: File address space.
> > + * @file: This instance of the open file; used for authentication.
> > + * @offset: First page index to read.
> > + * @end_index: The maximum page index to read.
> > + * @nr_to_read: The number of pages to read.
> 
> 
> How about:
> 
>     "The number of pages to read, as long as end_index is not exceeded."

API change makes this irrelevant ;-)

> > + * @lookahead_size: Where to start the next readahead.
> 
> Pre-existing, but...it's hard to understand how a size is "where to start".
> Should we rename this arg?

It should probably be lookahead_count.

> > + *
> > + * This function is for filesystems to call when they want to start
> > + * readahead potentially beyond a file's stated i_size.  If you want
> > + * to start readahead on a normal file, you probably want to call
> > + * page_cache_async_readahead() or page_cache_sync_readahead() instead.
> > + *
> > + * Context: File is referenced by caller.  Mutexes may be held by caller.
> > + * May sleep, but will not reenter filesystem to reclaim memory.
> 
> In fact, can we say "must not reenter filesystem"? 

I think it depends which side of the API you're looking at which wording
you prefer ;-)

