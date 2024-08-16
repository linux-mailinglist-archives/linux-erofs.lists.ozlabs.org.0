Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B21C9547A1
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 13:12:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="::1"
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gYeXurtm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlfTv4z0Lz2ynn
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 21:12:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=145.40.73.55
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gYeXurtm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlfTr4XNDz2yR5
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 21:12:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 35CF9CE1FA0;
	Fri, 16 Aug 2024 11:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCC8C32782;
	Fri, 16 Aug 2024 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806749;
	bh=Xvhko6m4gXDcrQOr/bnImNG8IdOv4SrzCD327herT1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYeXurtmdnv5fR0Lvxwg11Rmuc4ghH5uPedjp9RUF9ZTVRnFe2KEe0exw3cCImVFK
	 rCaAS7BmZxAY/8WKFqSPpuApwA/YreEZ9JZ14QNkvArFFGle3hRED2RvbCpLyCba2l
	 rIPVVL5acPzqM+YeW9LejtpG8c61dmocnDYvshJQKqGbPQJB2fbGcmY9H6N30CodvY
	 inuJJ0QRj7hpszFcgk6KmUmw7RkjTNRCuLb4pQX2F0ynh6meOkJZNOwdlryD6Dy8zV
	 g7Vy8wfyyWx8LeA3HgxdqtkuHQaZe/I9xJVOX78DNQ2ZR0Dft1NVeuF8t5cTsweIxv
	 AbnNlysFgTzuQ==
Date: Fri, 16 Aug 2024 12:12:22 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <20240816111222.GT632411@kernel.org>
References: <20240814203850.2240469-1-dhowells@redhat.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814203850.2240469-20-dhowells@redhat.com>
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

On Wed, Aug 14, 2024 at 09:38:39PM +0100, David Howells wrote:
> Improve the efficiency of buffered reads in a number of ways:
> 
>  (1) Overhaul the algorithm in general so that it's a lot more compact and
>      split the read submission code between buffered and unbuffered
>      versions.  The unbuffered version can be vastly simplified.
> 
>  (2) Read-result collection is handed off to a work queue rather than being
>      done in the I/O thread.  Multiple subrequests can be processes
>      simultaneously.
> 
>  (3) When a subrequest is collected, any folios it fully spans are
>      collected and "spare" data on either side is donated to either the
>      previous or the next subrequest in the sequence.
> 
> Notes:
> 
>  (*) Readahead expansion is massively slows down fio, presumably because it
>      causes a load of extra allocations, both folio and xarray, up front
>      before RPC requests can be transmitted.
> 
>  (*) RDMA with cifs does appear to work, both with SIW and RXE.
> 
>  (*) PG_private_2-based reading and copy-to-cache is split out into its own
>      file and altered to use folio_queue.  Note that the copy to the cache
>      now creates a new write transaction against the cache and adds the
>      folios to be copied into it.  This allows it to use part of the
>      writeback I/O code.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

...

> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c

...

> @@ -334,9 +344,8 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  	struct ceph_client *cl = fsc->client;
>  	struct ceph_osd_request *req = NULL;
>  	struct ceph_vino vino = ceph_vino(inode);
> -	struct iov_iter iter;
> -	int err = 0;
> -	u64 len = subreq->len;
> +	int err;

Hi David,

err is set conditionally in various places in this function, and then read
unconditionally near the end of this function. With this change isn't
entirely clear that err is always initialised by the end of the function.

Flagged by Smatch.

> +	u64 len;
>  	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
>  	u64 off = subreq->start;
>  	int extent_cnt;

...

> @@ -410,17 +423,19 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  	req->r_inode = inode;
>  	ihold(inode);
>  
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
>  	ceph_osdc_start_request(req->r_osdc, req);
>  out:
>  	ceph_osdc_put_request(req);
>  	if (err)
> -		netfs_subreq_terminated(subreq, err, false);
> +		netfs_read_subreq_terminated(subreq, err, false);
>  	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
>  }

...

> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c

...

> +/*
> + * Go through the list of failed/short reads, retrying all retryable ones.  We
> + * need to switch failed cache reads to network downloads.
> + */
> +static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +	struct netfs_io_stream *stream0 = &rreq->io_streams[0];
> +	LIST_HEAD(sublist);
> +	LIST_HEAD(queue);
> +
> +	_enter("R=%x", rreq->debug_id);
> +
> +	if (list_empty(&rreq->subrequests))
> +		return;
> +
> +	if (rreq->netfs_ops->retry_request)
> +		rreq->netfs_ops->retry_request(rreq, NULL);
> +
> +	/* If there's no renegotiation to do, just resend each retryable subreq
> +	 * up to the first permanently failed one.
> +	 */
> +	if (!rreq->netfs_ops->prepare_read &&
> +	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
> +		struct netfs_io_subrequest *subreq;
> +
> +		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
> +			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
> +				break;
> +			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
> +				netfs_reset_iter(subreq);
> +				netfs_reissue_read(rreq, subreq);
> +			}
> +		}
> +		return;
> +	}
> +
> +	/* Okay, we need to renegotiate all the download requests and flip any
> +	 * failed cache reads over to being download requests and negotiate
> +	 * those also.  All fully successful subreqs have been removed from the
> +	 * list and any spare data from those has been donated.
> +	 *
> +	 * What we do is decant the list and rebuild it one subreq at a time so
> +	 * that we don't end up with donations jumping over a gap we're busy
> +	 * populating with smaller subrequests.  In the event that the subreq
> +	 * we just launched finishes before we insert the next subreq, it'll
> +	 * fill in rreq->prev_donated instead.
> +
> +	 * Note: Alternatively, we could split the tail subrequest right before
> +	 * we reissue it and fix up the donations under lock.
> +	 */
> +	list_splice_init(&rreq->subrequests, &queue);
> +
> +	do {
> +		struct netfs_io_subrequest *from;
> +		struct iov_iter source;
> +		unsigned long long start, len;
> +		size_t part, deferred_next_donated = 0;
> +		bool boundary = false;
> +
> +		/* Go through the subreqs and find the next span of contiguous
> +		 * buffer that we then rejig (cifs, for example, needs the
> +		 * rsize renegotiating) and reissue.
> +		 */
> +		from = list_first_entry(&queue, struct netfs_io_subrequest, rreq_link);
> +		list_move_tail(&from->rreq_link, &sublist);
> +		start = from->start + from->transferred;
> +		len   = from->len   - from->transferred;
> +
> +		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx/%zx",
> +		       rreq->debug_id, from->debug_index,
> +		       from->start, from->consumed, from->transferred, from->len);
> +
> +		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
> +		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
> +			goto abandon;
> +
> +		deferred_next_donated = from->next_donated;
> +		while ((subreq = list_first_entry_or_null(
> +				&queue, struct netfs_io_subrequest, rreq_link))) {
> +			if (subreq->start != start + len ||
> +			    subreq->transferred > 0 ||
> +			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
> +				break;
> +			list_move_tail(&subreq->rreq_link, &sublist);
> +			len += subreq->len;
> +			deferred_next_donated = subreq->next_donated;
> +			if (test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags))
> +				break;
> +		}
> +
> +		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
> +
> +		/* Determine the set of buffers we're going to use.  Each
> +		 * subreq gets a subset of a single overall contiguous buffer.
> +		 */
> +		netfs_reset_iter(from);
> +		source = from->io_iter;
> +		source.count = len;
> +
> +		/* Work through the sublist. */
> +		while ((subreq = list_first_entry_or_null(
> +				&sublist, struct netfs_io_subrequest, rreq_link))) {
> +			list_del(&subreq->rreq_link);
> +
> +			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
> +			subreq->start	= start - subreq->transferred;
> +			subreq->len	= len   + subreq->transferred;
> +			stream0->sreq_max_len = subreq->len;
> +
> +			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> +			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +
> +			spin_lock_bh(&rreq->lock);
> +			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> +			subreq->prev_donated += rreq->prev_donated;
> +			rreq->prev_donated = 0;
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> +			spin_unlock_bh(&rreq->lock);
> +
> +			BUG_ON(!len);
> +
> +			/* Renegotiate max_len (rsize) */
> +			if (rreq->netfs_ops->prepare_read(subreq) < 0) {

Earlier in this function it is assumed that prepare_read may be NULL.
Can that also be the case here?

Also flagged by Smatch.

> +				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
> +				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +			}

...
