Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617C4E2A8F
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 15:26:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMcP71T33z30M3
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 01:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=G51pkFK/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=G51pkFK/; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMcP42vbpz2yxV
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 01:26:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=q2baNzMLIXfSGSiUmbqX3eLXrnYx71EZPdk4mLBGa7c=; b=G51pkFK/0LvtxH3jQVMGNb9cjr
 X3DGF1Rlnqj8lTf5AaDGuw8eN3ttTz1lumhhA6ojURBAIiR9RlI4JWC5dzqIh43hY2X9i2CxX2sn4
 7sNnz+n7LWGPiP0TIhhoPg58eBXsgYVauXw3fjjuIncQxXdishY+6W1Ez3f87f1OrlEY/Z6Z08dQF
 g9ZMaK4Bo0fFlZZ1ovtiS1WEJdl/xwFwjfEN7KEWS2opZVsMxRpEnor6XzBw57mpkQZGB0px+sEOx
 MDp5mGP1ch3ZqNzKMEM7TgggQum7c1BgZ4okLyGpGZh0xECpYegoJoJp0W6p7V+Kxe/euOVIExhrV
 hC4v3n0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nWIz2-00AeF9-B8; Mon, 21 Mar 2022 14:26:08 +0000
Date: Mon, 21 Mar 2022 14:26:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjiLACenpRV4XTcs@casper.infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Mar 21, 2022 at 10:08:47PM +0800, JeffleXu wrote:
> reqs_lock is also used to protect the check of cache->flags. Please
> refer to patch 4 [1] of this patchset.

Yes, that's exactly what I meant by "bad idea".

> ```
> +	/*
> +	 * Enqueue the pending request.
> +	 *
> +	 * Stop enqueuing the request when daemon is dying. So we need to
> +	 * 1) check cache state, and 2) enqueue request if cache is alive.
> +	 *
> +	 * The above two ops need to be atomic as a whole. @reqs_lock is used
> +	 * here to ensure that. Otherwise, request may be enqueued after xarray
> +	 * has been flushed, in which case the orphan request will never be
> +	 * completed and thus netfs will hang there forever.
> +	 */
> +	read_lock(&cache->reqs_lock);
> +
> +	/* recheck dead state under lock */
> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		read_unlock(&cache->reqs_lock);
> +		ret = -EIO;
> +		goto out;
> +	}

So this is an error path.  We're almost always going to take the xa_lock
immediately after taking the read_lock.  In other words, you've done two
atomic operations instead of one.

> +	xa_lock(xa);
> +	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
> +	if (!ret)
> +		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
> +	xa_unlock(xa);
> +
> +	read_unlock(&cache->reqs_lock);
> ```
> 
> It's mainly used to protect against the xarray flush.
> 
> Besides, IMHO read-write lock shall be more performance friendly, since
> most cases are the read side.

That's almost never true.  rwlocks are usually a bad idea because you
still have to bounce the cacheline, so you replace lock contention
(which you can see) with cacheline contention (which is harder to
measure).  And then you have questions about reader/writer fairness
(should new readers queue behind a writer if there's one waiting, or
should a steady stream of readers be able to hold a writer off
indefinitely?)
