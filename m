Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101149C8FF3
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 17:39:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731602381;
	bh=1HIL7rvuSph4AUXfgy8hthBDrHLyPpSBGeuQvxp14yU=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=I8QkWG3EjuJbcW2urGyYAirbC0053zYnKs5GCPDBM9WJJnUEXpJPKCn7tPWiD6uFe
	 cUs+kJQo20hMRAgP6sWhDr4TpxjIJnZ9xoBOTmQOP8Fc82MgWwbAlqt1v5XBuP262L
	 07xegS7qGSqEtEs0vmedZxU6l+O49/6baB78jZke8USiDFf1HweDQHf/Fakj9Xg42z
	 oh8CWNkI3H7HC0ekqBNaui0b/UQ7tcYW5Dczv3bJbjAtK19OCM5MICDbgsKnKnfOoY
	 1vXLu5WiCrwl+4U6w7vrjpHby+NCT8Jm1FSeD6npzHQ3y9mhXpIvxoYjjaHRny50AR
	 5NeJ58vwH7urg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xq5Tn5q8Cz30Sx
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 03:39:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731602380;
	cv=none; b=I1LH7VVYXq6TrES9upCcNYK1MRGYwf2Z6YSSjgVzmFz/1WcZRL6QSNzv5Xfk2es4HujpnQXT9CtGiIZbD/dQ96+l1emAVxDHQmZRpcnvCcfVV3VaswFk4KsUseY0xlzwhO1EsxRom/ykMoa6XqcpleL/HdedCwN6RQ5+HAW6h2cfBGhyVuWkPW7s+grgppv0qs4SNzekXenC5jBMztZ0UGGN35oAENBloLar6qa9XTI6+jcA668U3e6iwzekHW59Jho09puSvUWoPyJNGg8uXKUW6kQ75uk807LxS54y6QFgm65s/tYfx3pNZAasb8NniImDIzQU+FeI08kYIFykbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731602380; c=relaxed/relaxed;
	bh=1HIL7rvuSph4AUXfgy8hthBDrHLyPpSBGeuQvxp14yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5+TNB6yyAllcI+4qJH9OHX3o0rcEWKn+F5njwOvkZ2gVAun/0BrvuO5PyNnykIJYIKr2Wu97QKvvCubGVTPiw4XXfbRNEEAtCyMDq2ALWhlPjis05jbdIKjV4yoV9oNnIn8deuVXcXcwuLSHvucKEIXpKQPMYm6NhR5tYjXiHP1nwINJUeHJ2mcmvunxffVjQcVKp2Gv/wXefMAXZHAW9t+w9cf3/fmSApIsHXm1d2j7DDNZXtnsBZbaBmK5mv6auc1JS10GO5cAkyhfvw7MVYpWGwfQSkIo15Qrl1GTvMvzvrBhMDvl4f92UDNMudCf5IB2NkwvJSWio+UQWNM8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nN1NXCIg; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nN1NXCIg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xq5Tl0shMz2yyR
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 03:39:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 79B0DA41720;
	Thu, 14 Nov 2024 16:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF3DC4CED0;
	Thu, 14 Nov 2024 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731602374;
	bh=SUgKw9P+o1HnS6FND7Lta07yLNLbdsT2InWIXPbLQT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN1NXCIgrxJ4wk4bcHMhmOuYrCKibErARAw+zOQjDHHFuOK18Brb1h1CQ5hmnTp8V
	 KAyuHnkpDtG87QBRy9XwJlthDqNWBY202bxVt1qqw99Wzobz5thZ096hR0glKhIjII
	 /ZA3UnhDf+X4rBLnCVp0MRl2Leq42RY0Kcie0wqnm4FzsG4U61FM3ZRq+0+x7gknv3
	 FzZKNTgibcdo9cf0/5GAfT8k1ONMZ9XozEApa5Sh4ftMjfeOgROuZcus0jAnRg5D/A
	 kaXLd5qcq5VRrPOpsLSKYA5EOUNKK0ercajIivXck4U0VWWp1wDJfnDoM1SgBdANjJ
	 cZ6W8T227w59w==
Date: Thu, 14 Nov 2024 09:39:31 -0700
To: David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 28/33] netfs: Change the read result collector to only
 use one work item
Message-ID: <20241114163931.GA1928968@thelio-3990X>
References: <20241108173236.1382366-1-dhowells@redhat.com>
 <20241108173236.1382366-29-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108173236.1382366-29-dhowells@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
From: Nathan Chancellor via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Nathan Chancellor <nathan@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Fri, Nov 08, 2024 at 05:32:29PM +0000, David Howells wrote:
...
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 264f3cb6a7dc..8ca0558570c1 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -12,15 +12,8 @@
>  static void netfs_reissue_read(struct netfs_io_request *rreq,
>  			       struct netfs_io_subrequest *subreq)
>  {
> -	struct iov_iter *io_iter = &subreq->io_iter;
> -
> -	if (iov_iter_is_folioq(io_iter)) {
> -		subreq->curr_folioq = (struct folio_queue *)io_iter->folioq;
> -		subreq->curr_folioq_slot = io_iter->folioq_slot;
> -		subreq->curr_folio_order = subreq->curr_folioq->orders[subreq->curr_folioq_slot];
> -	}
> -
> -	atomic_inc(&rreq->nr_outstanding);
> +	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
> +	__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
>  	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
>  	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>  	subreq->rreq->netfs_ops->issue_read(subreq);
> @@ -33,13 +26,12 @@ static void netfs_reissue_read(struct netfs_io_request *rreq,
>  static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  {
>  	struct netfs_io_subrequest *subreq;
> -	struct netfs_io_stream *stream0 = &rreq->io_streams[0];
> -	LIST_HEAD(sublist);
> -	LIST_HEAD(queue);
> +	struct netfs_io_stream *stream = &rreq->io_streams[0];
> +	struct list_head *next;
>  
>  	_enter("R=%x", rreq->debug_id);
>  
> -	if (list_empty(&rreq->subrequests))
> +	if (list_empty(&stream->subrequests))
>  		return;
>  
>  	if (rreq->netfs_ops->retry_request)
> @@ -52,7 +44,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
>  		struct netfs_io_subrequest *subreq;
>  
> -		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
> +		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
>  			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
>  				break;
>  			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
> @@ -73,48 +65,44 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  	 * populating with smaller subrequests.  In the event that the subreq
>  	 * we just launched finishes before we insert the next subreq, it'll
>  	 * fill in rreq->prev_donated instead.
> -
> +	 *
>  	 * Note: Alternatively, we could split the tail subrequest right before
>  	 * we reissue it and fix up the donations under lock.
>  	 */
> -	list_splice_init(&rreq->subrequests, &queue);
> +	next = stream->subrequests.next;
>  
>  	do {
> -		struct netfs_io_subrequest *from;
> +		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
>  		struct iov_iter source;
>  		unsigned long long start, len;
> -		size_t part, deferred_next_donated = 0;
> +		size_t part;
>  		bool boundary = false;
>  
>  		/* Go through the subreqs and find the next span of contiguous
>  		 * buffer that we then rejig (cifs, for example, needs the
>  		 * rsize renegotiating) and reissue.
>  		 */
> -		from = list_first_entry(&queue, struct netfs_io_subrequest, rreq_link);
> -		list_move_tail(&from->rreq_link, &sublist);
> +		from = list_entry(next, struct netfs_io_subrequest, rreq_link);
> +		to = from;
>  		start = from->start + from->transferred;
>  		len   = from->len   - from->transferred;
>  
> -		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx/%zx",
> +		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx",
>  		       rreq->debug_id, from->debug_index,
> -		       from->start, from->consumed, from->transferred, from->len);
> +		       from->start, from->transferred, from->len);
>  
>  		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
>  		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
>  			goto abandon;
>  
> -		deferred_next_donated = from->next_donated;
> -		while ((subreq = list_first_entry_or_null(
> -				&queue, struct netfs_io_subrequest, rreq_link))) {
> -			if (subreq->start != start + len ||
> -			    subreq->transferred > 0 ||
> +		list_for_each_continue(next, &stream->subrequests) {
> +			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
> +			if (subreq->start + subreq->transferred != start + len ||
> +			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
>  			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
>  				break;
> -			list_move_tail(&subreq->rreq_link, &sublist);
> -			len += subreq->len;
> -			deferred_next_donated = subreq->next_donated;
> -			if (test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags))
> -				break;
> +			to = subreq;
> +			len += to->len;
>  		}
>  
>  		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
> @@ -127,36 +115,28 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  		source.count = len;
>  
>  		/* Work through the sublist. */
> -		while ((subreq = list_first_entry_or_null(
> -				&sublist, struct netfs_io_subrequest, rreq_link))) {
> -			list_del(&subreq->rreq_link);
> -
> +		subreq = from;
> +		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
> +			if (!len)
> +				break;
>  			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
>  			subreq->start	= start - subreq->transferred;
>  			subreq->len	= len   + subreq->transferred;
> -			stream0->sreq_max_len = subreq->len;
> -
>  			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> -
> -			spin_lock(&rreq->lock);
> -			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> -			subreq->prev_donated += rreq->prev_donated;
> -			rreq->prev_donated = 0;
>  			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> -			spin_unlock(&rreq->lock);
> -
> -			BUG_ON(!len);
>  
>  			/* Renegotiate max_len (rsize) */
> +			stream->sreq_max_len = subreq->len;
>  			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
>  				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
>  				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +				goto abandon;
>  			}
>  
> -			part = umin(len, stream0->sreq_max_len);
> -			if (unlikely(rreq->io_streams[0].sreq_max_segs))
> -				part = netfs_limit_iter(&source, 0, part, stream0->sreq_max_segs);
> +			part = umin(len, stream->sreq_max_len);
> +			if (unlikely(stream->sreq_max_segs))
> +				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
>  			subreq->len = subreq->transferred + part;
>  			subreq->io_iter = source;
>  			iov_iter_truncate(&subreq->io_iter, part);
> @@ -166,58 +146,106 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  			if (!len) {
>  				if (boundary)
>  					__set_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
> -				subreq->next_donated = deferred_next_donated;
>  			} else {
>  				__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
> -				subreq->next_donated = 0;
>  			}
>  
> +			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>  			netfs_reissue_read(rreq, subreq);
> -			if (!len)
> +			if (subreq == to)
>  				break;
> -
> -			/* If we ran out of subrequests, allocate another. */
> -			if (list_empty(&sublist)) {
> -				subreq = netfs_alloc_subrequest(rreq);
> -				if (!subreq)
> -					goto abandon;
> -				subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
> -				subreq->start = start;
> -
> -				/* We get two refs, but need just one. */
> -				netfs_put_subrequest(subreq, false, netfs_sreq_trace_new);
> -				trace_netfs_sreq(subreq, netfs_sreq_trace_split);
> -				list_add_tail(&subreq->rreq_link, &sublist);
> -			}
>  		}
>  
>  		/* If we managed to use fewer subreqs, we can discard the
> -		 * excess.
> +		 * excess; if we used the same number, then we're done.
>  		 */
> -		while ((subreq = list_first_entry_or_null(
> -				&sublist, struct netfs_io_subrequest, rreq_link))) {
> -			trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
> -			list_del(&subreq->rreq_link);
> -			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
> +		if (!len) {
> +			if (subreq == to)
> +				continue;
> +			list_for_each_entry_safe_from(subreq, tmp,
> +						      &stream->subrequests, rreq_link) {
> +				trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
> +				list_del(&subreq->rreq_link);
> +				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
> +				if (subreq == to)
> +					break;
> +			}
> +			continue;
>  		}
>  
> -	} while (!list_empty(&queue));
> +		/* We ran out of subrequests, so we need to allocate some more
> +		 * and insert them after.
> +		 */
> +		do {
> +			subreq = netfs_alloc_subrequest(rreq);
> +			if (!subreq) {
> +				subreq = to;
> +				goto abandon_after;
> +			}
> +			subreq->source		= NETFS_DOWNLOAD_FROM_SERVER;
> +			subreq->start		= start;
> +			subreq->len		= len;
> +			subreq->debug_index	= atomic_inc_return(&rreq->subreq_counter);
> +			subreq->stream_nr	= stream->stream_nr;
> +			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +
> +			trace_netfs_sreq_ref(rreq->debug_id, subreq->debug_index,
> +					     refcount_read(&subreq->ref),
> +					     netfs_sreq_trace_new);
> +			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
> +
> +			list_add(&subreq->rreq_link, &to->rreq_link);
> +			to = list_next_entry(to, rreq_link);
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> +
> +			stream->sreq_max_len	= umin(len, rreq->rsize);
> +			stream->sreq_max_segs	= 0;
> +			if (unlikely(stream->sreq_max_segs))
> +				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
> +
> +			netfs_stat(&netfs_n_rh_download);
> +			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
> +				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
> +				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +				goto abandon;
> +			}
> +
> +			part = umin(len, stream->sreq_max_len);
> +			subreq->len = subreq->transferred + part;
> +			subreq->io_iter = source;
> +			iov_iter_truncate(&subreq->io_iter, part);
> +			iov_iter_advance(&source, part);
> +
> +			len -= part;
> +			start += part;
> +			if (!len && boundary) {
> +				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
> +				boundary = false;
> +			}
> +
> +			netfs_reissue_read(rreq, subreq);
> +		} while (len);
> +
> +	} while (!list_is_head(next, &stream->subrequests));
>  
>  	return;
>  
> -	/* If we hit ENOMEM, fail all remaining subrequests */
> +	/* If we hit an error, fail all remaining incomplete subrequests */
> +abandon_after:
> +	if (list_is_last(&subreq->rreq_link, &stream->subrequests))
> +		return;

This change as commit 1bd9011ee163 ("netfs: Change the read result
collector to only use one work item") in next-20241114 causes a clang
warning:

  fs/netfs/read_retry.c:235:20: error: variable 'subreq' is uninitialized when used here [-Werror,-Wuninitialized]
    235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
        |                           ^~~~~~
  fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to silence this warning
     28 |         struct netfs_io_subrequest *subreq;
        |                                           ^
        |                                            = NULL

May be a shadowing issue, as adding KCFLAGS=-Wshadow shows:

  fs/netfs/read_retry.c:75:31: error: declaration shadows a local variable [-Werror,-Wshadow]
     75 |                 struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
        |                                             ^
  fs/netfs/read_retry.c:28:30: note: previous declaration is here
     28 |         struct netfs_io_subrequest *subreq;
        |                                     ^

Cheers,
Nathan

> +	subreq = list_next_entry(subreq, rreq_link);
>  abandon:
> -	list_splice_init(&sublist, &queue);
> -	list_for_each_entry(subreq, &queue, rreq_link) {
> -		if (!subreq->error)
> -			subreq->error = -ENOMEM;
> -		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +	list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
> +		if (!subreq->error &&
> +		    !test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
> +		    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
> +			continue;
> +		subreq->error = -ENOMEM;
> +		__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
>  		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  		__clear_bit(NETFS_SREQ_RETRYING, &subreq->flags);
>  	}
> -	spin_lock(&rreq->lock);
> -	list_splice_tail_init(&queue, &rreq->subrequests);
> -	spin_unlock(&rreq->lock);
>  }
>  
>  /*
> @@ -225,14 +253,19 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>   */
>  void netfs_retry_reads(struct netfs_io_request *rreq)
>  {
> -	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
> +	struct netfs_io_subrequest *subreq;
> +	struct netfs_io_stream *stream = &rreq->io_streams[0];
>  
> -	atomic_inc(&rreq->nr_outstanding);
> +	/* Wait for all outstanding I/O to quiesce before performing retries as
> +	 * we may need to renegotiate the I/O sizes.
> +	 */
> +	list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
> +		wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
> +			    TASK_UNINTERRUPTIBLE);
> +	}
>  
> +	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
>  	netfs_retry_read_subrequests(rreq);
> -
> -	if (atomic_dec_and_test(&rreq->nr_outstanding))
> -		netfs_rreq_terminated(rreq);
>  }
>  
>  /*
