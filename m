Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9494360D
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2024 21:08:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TWMZ8XiV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZ1nl3pDxz3dD2
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 05:07:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TWMZ8XiV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZ1nh1y1Lz3cZ1
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 05:07:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C7669CE178E;
	Wed, 31 Jul 2024 19:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42DDC116B1;
	Wed, 31 Jul 2024 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722452869;
	bh=YTJqim0DwenqHbETPgEIkYE+eKzhmSBxJKna7V14c88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWMZ8XiVsdFpB2wB2rnLFXNdQzkrcLVPjXcXwkxgJW8VRcgu6drXc85rGKXng+alJ
	 T8HZhq2izBGLGuW49uDcyh78ihxbSGGEqZn5oRu8s5iYVea9hwrsuON29lAUlorAc3
	 1M71dgq6328PB5sEe2ZmEI2j2KCd42n9imIm/b7EXuKDrUEvL4AjI4VzqBg9GqxgZV
	 UhrxVz0oDS5PMLME2rZyRwLHgymXaCA9slNVPtCYun/a5HZYGjFdT98li/6FJ/6TlI
	 R+C1r5OuojGmwXfK83JVQjh4H7o7UogSv/axh0xjPI/9QzrS4vl5PUo9S0HPjakyAv
	 yev7NmQSyuhGw==
Date: Wed, 31 Jul 2024 20:07:42 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 18/24] netfs: Speed up buffered reading
Message-ID: <20240731190742.GS1967603@kernel.org>
References: <20240729162002.3436763-1-dhowells@redhat.com>
 <20240729162002.3436763-19-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729162002.3436763-19-dhowells@redhat.com>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 29, 2024 at 05:19:47PM +0100, David Howells wrote:

...

> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c

...

> +/*
> + * Perform a read to the pagecache from a series of sources of different types,
> + * slicing up the region to be read according to available cache blocks and
> + * network rsize.
> + */
> +static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
> +{
> +	struct netfs_inode *ictx = netfs_inode(rreq->inode);
> +	unsigned long long start = rreq->start;
> +	ssize_t size = rreq->len;
> +	int ret = 0;
> +
> +	atomic_inc(&rreq->nr_outstanding);
> +
> +	do {
> +		struct netfs_io_subrequest *subreq;
> +		enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
> +		ssize_t slice;
> +
> +		subreq = netfs_alloc_subrequest(rreq);
> +		if (!subreq) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		subreq->start	= start;
> +		subreq->len	= size;
> +
> +		atomic_inc(&rreq->nr_outstanding);
> +		spin_lock_bh(&rreq->lock);
> +		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> +		subreq->prev_donated = rreq->prev_donated;
> +		rreq->prev_donated = 0;
> +		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
> +		spin_unlock_bh(&rreq->lock);
> +
> +		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
> +		subreq->source = source;
> +		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
> +			unsigned long long zp = umin(ictx->zero_point, rreq->i_size);
> +			size_t len = subreq->len;
> +
> +			if (subreq->start >= zp) {
> +				subreq->source = source = NETFS_FILL_WITH_ZEROES;
> +				goto fill_with_zeroes;
> +			}
> +
> +			if (len > zp - subreq->start)
> +				len = zp - subreq->start;
> +			if (len == 0) {
> +				pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%zx s=%llx z=%llx i=%llx",
> +				       rreq->debug_id, subreq->debug_index,
> +				       subreq->len, size,
> +				       subreq->start, ictx->zero_point, rreq->i_size);
> +				break;
> +			}
> +			subreq->len = len;
> +
> +			netfs_stat(&netfs_n_rh_download);
> +			if (rreq->netfs_ops->prepare_read) {
> +				ret = rreq->netfs_ops->prepare_read(subreq);
> +				if (ret < 0) {
> +					atomic_dec(&rreq->nr_outstanding);
> +					netfs_put_subrequest(subreq, false,
> +							     netfs_sreq_trace_put_cancel);
> +					break;
> +				}
> +				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
> +			}
> +
> +			slice = netfs_prepare_read_iterator(subreq);
> +			if (slice < 0) {
> +				atomic_dec(&rreq->nr_outstanding);
> +				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
> +				ret = slice;
> +				break;
> +			}
> +
> +			rreq->netfs_ops->issue_read(subreq);
> +			goto done;
> +		}
> +
> +	fill_with_zeroes:
> +		if (source == NETFS_FILL_WITH_ZEROES) {
> +			subreq->source = NETFS_FILL_WITH_ZEROES;
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> +			netfs_stat(&netfs_n_rh_zero);
> +			slice = netfs_prepare_read_iterator(subreq);
> +			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> +			netfs_read_subreq_terminated(subreq, 0, false);
> +			goto done;
> +		}
> +
> +		if (source == NETFS_READ_FROM_CACHE) {
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> +			slice = netfs_prepare_read_iterator(subreq);
> +			netfs_read_cache_to_pagecache(rreq, subreq);
> +			goto done;
> +		}
> +
> +		if (source == NETFS_INVALID_READ)
> +			break;

Hi David,

I feel a sense of deja vu here. So apologies if this was already
discussed in the past.

If the code ever reaches this line, then slice will be used
uninitialised below.

Flagged by W=1 allmodconfig builds on x86_64 with Clang 18.1.8.

> +
> +	done:
> +		size -= slice;
> +		start += slice;
> +		cond_resched();
> +	} while (size > 0);
> +
> +	if (atomic_dec_and_test(&rreq->nr_outstanding))
> +		netfs_rreq_terminated(rreq, false);
> +
> +	/* Defer error return as we may need to wait for outstanding I/O. */
> +	cmpxchg(&rreq->error, 0, ret);
> +}

...

> +/*
> + * Unlock any folios that are now completely read.  Returns true if the
> + * subrequest is removed from the list.
> + */
> +static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was_async)
> +{
> +	struct netfs_io_subrequest *prev, *next;
> +	struct netfs_io_request *rreq = subreq->rreq;
> +	struct folio_queue *folioq = subreq->curr_folioq;
> +	size_t avail, prev_donated, next_donated, fsize, part, excess;
> +	loff_t fpos, start;
> +	loff_t fend;
> +	int slot = subreq->curr_folioq_slot;
> +
> +	if (WARN(subreq->transferred > subreq->len,
> +		 "Subreq overread: R%x[%x] %zu > %zu",
> +		 rreq->debug_id, subreq->debug_index,
> +		 subreq->transferred, subreq->len))
> +		subreq->transferred = subreq->len;
> +
> +next_folio:
> +	fsize = PAGE_SIZE << subreq->curr_folio_order;
> +	fpos = round_down(subreq->start + subreq->consumed, fsize);
> +	fend = fpos + fsize;
> +
> +	if (WARN_ON_ONCE(!folioq) ||
> +	    WARN_ON_ONCE(!folioq_folio(folioq, slot)) ||
> +	    WARN_ON_ONCE(folioq_folio(folioq, slot)->index != fpos / PAGE_SIZE)) {
> +		pr_err("R=%08x[%x] s=%llx-%llx ctl=%zx/%zx/%zx sl=%u\n",
> +		       rreq->debug_id, subreq->debug_index,
> +		       subreq->start, subreq->start + subreq->transferred - 1,
> +		       subreq->consumed, subreq->transferred, subreq->len,
> +		       slot);
> +		if (folioq) {
> +			struct folio *folio = folioq_folio(folioq, slot);
> +
> +			pr_err("folioq: %02x%02x%02x%02x\n",
> +			       folioq->orders[0], folioq->orders[1],
> +			       folioq->orders[2], folioq->orders[3]);
> +			if (folio)
> +				pr_err("folio: %llx-%llx ix=%llx o=%u qo=%u\n",
> +				       fpos, fend - 1, folio_pos(folio), folio_order(folio),
> +				       folioq_folio_order(folioq, slot));
> +		}
> +	}
> +
> +donation_changed:
> +	/* Try to consume the current folio if we've hit or passed the end of
> +	 * it.  There's a possibility that this subreq doesn't start at the
> +	 * beginning of the folio, in which case we need to donate to/from the
> +	 * preceding subreq.
> +	 *
> +	 * We also need to include any potential donation back from the
> +	 * following subreq.
> +	 */
> +	prev_donated = READ_ONCE(subreq->prev_donated);
> +	next_donated =  READ_ONCE(subreq->next_donated);
> +	if (prev_donated || next_donated) {
> +		spin_lock_bh(&rreq->lock);
> +		prev_donated = subreq->prev_donated;
> +		next_donated =  subreq->next_donated;
> +		subreq->start -= prev_donated;
> +		subreq->len += prev_donated;
> +		subreq->transferred += prev_donated;
> +		prev_donated = subreq->prev_donated = 0;
> +		if (subreq->transferred == subreq->len) {
> +			subreq->len += next_donated;
> +			subreq->transferred += next_donated;
> +			next_donated = subreq->next_donated = 0;
> +		}
> +		trace_netfs_sreq(subreq, netfs_sreq_trace_add_donations);
> +		spin_unlock_bh(&rreq->lock);
> +	}
> +
> +	avail = subreq->transferred;
> +	if (avail == subreq->len)
> +		avail += next_donated;
> +	start = subreq->start;
> +	if (subreq->consumed == 0) {
> +		start -= prev_donated;
> +		avail += prev_donated;
> +	} else {
> +		start += subreq->consumed;
> +		avail -= subreq->consumed;
> +	}
> +	part = umin(avail, fsize);
> +
> +	trace_netfs_progress(subreq, start, avail, part);
> +
> +	if (start + avail >= fend) {
> +		if (fpos == start) {
> +			/* Flush, unlock and mark for caching any folio we've just read. */
> +			subreq->consumed = fend - subreq->start;
> +			netfs_unlock_read_folio(subreq, rreq, folioq_folio(folioq, slot));

Earlier and later in this function it was assumed that folioq may be NULL.
But here it appears to be used dereferenced unconditionally
by folioq_folio().

Flagged by Smatch.

> +			folioq_mark2(folioq, slot);
> +			if (subreq->consumed >= subreq->len)
> +				goto remove_subreq;
> +		} else if (fpos < start) {
> +			excess = fend - subreq->start;
> +
> +			spin_lock_bh(&rreq->lock);
> +			/* If we complete first on a folio split with the
> +			 * preceding subreq, donate to that subreq - otherwise
> +			 * we get the responsibility.
> +			 */
> +			if (subreq->prev_donated != prev_donated) {
> +				spin_unlock_bh(&rreq->lock);
> +				goto donation_changed;
> +			}
> +
> +			if (list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
> +				spin_unlock_bh(&rreq->lock);
> +				pr_err("Can't donate prior to front\n");
> +				goto bad;
> +			}
> +
> +			prev = list_prev_entry(subreq, rreq_link);
> +			WRITE_ONCE(prev->next_donated, prev->next_donated + excess);
> +			subreq->start += excess;
> +			subreq->len -= excess;
> +			subreq->transferred -= excess;
> +			trace_netfs_donate(rreq, subreq, prev, excess,
> +					   netfs_trace_donate_tail_to_prev);
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
> +
> +			if (subreq->consumed >= subreq->len)
> +				goto remove_subreq_locked;
> +			spin_unlock_bh(&rreq->lock);
> +		} else {
> +			pr_err("fpos > start\n");
> +			goto bad;
> +		}
> +
> +		/* Advance the rolling buffer to the next folio. */
> +		slot++;
> +		if (slot >= folioq_nr_slots(folioq)) {
> +			slot = 0;
> +			folioq = folioq->next;
> +			subreq->curr_folioq = folioq;
> +		}
> +		subreq->curr_folioq_slot = slot;
> +		if (folioq && folioq_folio(folioq, slot))
> +			subreq->curr_folio_order = folioq->orders[slot];
> +		if (!was_async)
> +			cond_resched();
> +		goto next_folio;
> +	}
> +
> +	/* Deal with partial progress. */
> +	if (subreq->transferred < subreq->len)
> +		return false;
> +
> +	/* Donate the remaining downloaded data to one of the neighbouring
> +	 * subrequests.  Note that we may race with them doing the same thing.
> +	 */
> +	spin_lock_bh(&rreq->lock);
> +
> +	if (subreq->prev_donated != prev_donated ||
> +	    subreq->next_donated != next_donated) {
> +		spin_unlock_bh(&rreq->lock);
> +		cond_resched();
> +		goto donation_changed;
> +	}
> +
> +	/* Deal with the trickiest case: that this subreq is in the middle of a
> +	 * folio, not touching either edge, but finishes first.  In such a
> +	 * case, we donate to the previous subreq, if there is one, so that the
> +	 * donation is only handled when that completes - and remove this
> +	 * subreq from the list.
> +	 *
> +	 * If the previous subreq finished first, we will have acquired their
> +	 * donation and should be able to unlock folios and/or donate nextwards.
> +	 */
> +	if (!subreq->consumed &&
> +	    !prev_donated &&
> +	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
> +		prev = list_prev_entry(subreq, rreq_link);
> +		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
> +		subreq->start += subreq->len;
> +		subreq->len = 0;
> +		subreq->transferred = 0;
> +		trace_netfs_donate(rreq, subreq, prev, subreq->len,
> +				   netfs_trace_donate_to_prev);
> +		trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
> +		goto remove_subreq_locked;
> +	}
> +
> +	/* If we can't donate down the chain, donate up the chain instead. */
> +	excess = subreq->len - subreq->consumed + next_donated;
> +
> +	if (!subreq->consumed)
> +		excess += prev_donated;
> +
> +	if (list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
> +		rreq->prev_donated = excess;
> +		trace_netfs_donate(rreq, subreq, NULL, excess,
> +				   netfs_trace_donate_to_deferred_next);
> +	} else {
> +		next = list_next_entry(subreq, rreq_link);
> +		WRITE_ONCE(next->prev_donated, excess);
> +		trace_netfs_donate(rreq, subreq, next, excess,
> +				   netfs_trace_donate_to_next);
> +	}
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_next);
> +	subreq->len = subreq->consumed;
> +	subreq->transferred = subreq->consumed;
> +	goto remove_subreq_locked;
> +
> +remove_subreq:
> +	spin_lock_bh(&rreq->lock);
> +remove_subreq_locked:
> +	subreq->consumed = subreq->len;
> +	list_del(&subreq->rreq_link);
> +	spin_unlock_bh(&rreq->lock);
> +	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_consumed);
> +	return true;
> +
> +bad:
> +	/* Errr... prev and next both donated to us, but insufficient to finish
> +	 * the folio.
> +	 */
> +	printk("R=%08x[%x] s=%llx-%llx %zx/%zx/%zx\n",
> +	       rreq->debug_id, subreq->debug_index,
> +	       subreq->start, subreq->start + subreq->transferred - 1,
> +	       subreq->consumed, subreq->transferred, subreq->len);
> +	printk("folio: %llx-%llx\n", fpos, fend - 1);
> +	printk("donated: prev=%zx next=%zx\n", prev_donated, next_donated);
> +	printk("s=%llx av=%zx part=%zx\n", start, avail, part);
> +	BUG();
> +}

...
