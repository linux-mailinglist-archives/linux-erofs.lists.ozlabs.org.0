Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC108928B1
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Mar 2024 02:12:04 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nEiRr5d0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V5zl62Cm9z3vcq
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Mar 2024 12:12:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nEiRr5d0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=vadim.fedorenko@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 485 seconds by postgrey-1.37 at boromir; Sat, 30 Mar 2024 12:11:58 AEDT
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V5zl23b9Qz3cJW
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 Mar 2024 12:11:58 +1100 (AEDT)
Message-ID: <b1dd93cb-2025-44c5-87db-17302564c040@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711760609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXiJJHZRlrxCQbjNpD/DG/Sam9Mk/EeRhDZTqjMOOdA=;
	b=nEiRr5d0ISkrWl+RgoStfXsEYYaBXkKMHJrzYX/lNHAgBPe02h6dEOPwkvTr3HEfXDaU3o
	ro9FTWY02LthEpm6/PRMqPJHmn81nw7jWZKghjOT1Yu4tyPiSQ2KJpcQGeb4WR7DoJDRZP
	CRlh1My2puEF8N8UqRBF1F80IqgE6hw=
Date: Fri, 29 Mar 2024 18:03:21 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 19/26] netfs: New writeback implementation
Content-Language: en-US
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Dominique Martinet <asmadeus@codewreck.org>
References: <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-20-dhowells@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240328163424.2781320-20-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 28/03/2024 16:34, David Howells wrote:
> The current netfslib writeback implementation creates writeback requests of
> contiguous folio data and then separately tiles subrequests over the space
> twice, once for the server and once for the cache.  This creates a few
> issues:
> 
>   (1) Every time there's a discontiguity or a change between writing to only
>       one destination or writing to both, it must create a new request.
>       This makes it harder to do vectored writes.
> 
>   (2) The folios don't have the writeback mark removed until the end of the
>       request - and a request could be hundreds of megabytes.
> 
>   (3) In future, I want to support a larger cache granularity, which will
>       require aggregation of some folios that contain unmodified data (which
>       only need to go to the cache) and some which contain modifications
>       (which need to be uploaded and stored to the cache) - but, currently,
>       these are treated as discontiguous.
> 
> There's also a move to get everyone to use writeback_iter() to extract
> writable folios from the pagecache.  That said, currently writeback_iter()
> has some issues that make it less than ideal:
> 
>   (1) there's no way to cancel the iteration, even if you find a "temporary"
>       error that means the current folio and all subsequent folios are going
>       to fail;
> 
>   (2) there's no way to filter the folios being written back - something
>       that will impact Ceph with it's ordered snap system;
> 
>   (3) and if you get a folio you can't immediately deal with (say you need
>       to flush the preceding writes), you are left with a folio hanging in
>       the locked state for the duration, when really we should unlock it and
>       relock it later.
> 
> In this new implementation, I use writeback_iter() to pump folios,
> progressively creating two parallel, but separate streams and cleaning up
> the finished folios as the subrequests complete.  Either or both streams
> can contain gaps, and the subrequests in each stream can be of variable
> size, don't need to align with each other and don't need to align with the
> folios.
> 
> Indeed, subrequests can cross folio boundaries, may cover several folios or
> a folio may be spanned by multiple folios, e.g.:
> 
>           +---+---+-----+-----+---+----------+
> Folios:  |   |   |     |     |   |          |
>           +---+---+-----+-----+---+----------+
> 
>             +------+------+     +----+----+
> Upload:    |      |      |.....|    |    |
>             +------+------+     +----+----+
> 
>           +------+------+------+------+------+
> Cache:   |      |      |      |      |      |
>           +------+------+------+------+------+
> 
> The progressive subrequest construction permits the algorithm to be
> preparing both the next upload to the server and the next write to the
> cache whilst the previous ones are already in progress.  Throttling can be
> applied to control the rate of production of subrequests - and, in any
> case, we probably want to write them to the server in ascending order,
> particularly if the file will be extended.
> 
> Content crypto can also be prepared at the same time as the subrequests and
> run asynchronously, with the prepped requests being stalled until the
> crypto catches up with them.  This might also be useful for transport
> crypto, but that happens at a lower layer, so probably would be harder to
> pull off.
> 
> The algorithm is split into three parts:
> 
>   (1) The issuer.  This walks through the data, packaging it up, encrypting
>       it and creating subrequests.  The part of this that generates
>       subrequests only deals with file positions and spans and so is usable
>       for DIO/unbuffered writes as well as buffered writes.
> 
>   (2) The collector. This asynchronously collects completed subrequests,
>       unlocks folios, frees crypto buffers and performs any retries.  This
>       runs in a work queue so that the issuer can return to the caller for
>       writeback (so that the VM can have its kswapd thread back) or async
>       writes.
> 
>   (3) The retryer.  This pauses the issuer, waits for all outstanding
>       subrequests to complete and then goes through the failed subrequests
>       to reissue them.  This may involve reprepping them (with cifs, the
>       credits must be renegotiated, and a subrequest may need splitting),
>       and doing RMW for content crypto if there's a conflicting change on
>       the server.
> 
> [!] Note that some of the functions are prefixed with "new_" to avoid
> clashes with existing functions.  These will be renamed in a later patch
> that cuts over to the new algorithm.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

[..snip..]
> +/*
> + * Begin a write operation for writing through the pagecache.
> + */
> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *iocb, size_t len)
> +{
> +	struct netfs_io_request *wreq = NULL;
> +	struct netfs_inode *ictx = netfs_inode(file_inode(iocb->ki_filp));
> +
> +	mutex_lock(&ictx->wb_lock);
> +
> +	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp,
> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
> +	if (IS_ERR(wreq))
> +		mutex_unlock(&ictx->wb_lock);
> +
> +	wreq->io_streams[0].avail = true;

in case IS_ERR(wreq) is true, the execution falls through and this
derefere is invalid.

> +	trace_netfs_write(wreq, netfs_write_trace_writethrough);

not sure if we still need trace function call in case of error

> +	return wreq;
> +}
> +

[..snip..]



