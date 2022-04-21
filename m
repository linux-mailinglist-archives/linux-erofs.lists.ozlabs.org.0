Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78C50A162
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 15:57:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkfHL6pBSz3bWR
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 23:57:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=La/QAUMN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U4fWgB6u;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=La/QAUMN; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U4fWgB6u; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkfHH3r3Hz2yZv
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Apr 2022 23:57:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650549431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wyJ48PjrvsX9JqxBm3IYuFdA5jrIuvJQc3ntFnd644o=;
 b=La/QAUMNvq/zKTD0FpDbwm3j9rUwsLyFhLJMUOym2jdNOD2QHEfN5fuwGg0q37NYHyvd2f
 GKf7LjoLrl5FZ8L1lUODIQjUY3MfVqkpsbLtYTy35aYFWeq9MOQJrcimPI1/H/Qh2dzB2x
 hI6gHObQZHXncub9gteU2WQ1w0cob0M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650549432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wyJ48PjrvsX9JqxBm3IYuFdA5jrIuvJQc3ntFnd644o=;
 b=U4fWgB6uS8j6fbcy3S2V8g+s0oHgFxrO/QWZPKIvbbWGbbl5uWuP7z099NTI2v7Wq4sP3t
 ohPisje4nQAcIpnnoyssghi42/+OSAKP1Dhfq4n3/VjfoKQMnpw7iew2zYI1BIDfJXu2c0
 IxLJgNXZvRWa6GnuQ4nuIbhO2j6odjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-xSh8CwBaOWON3J9evyzuiA-1; Thu, 21 Apr 2022 09:57:07 -0400
X-MC-Unique: xSh8CwBaOWON3J9evyzuiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF20D80A0AD;
 Thu, 21 Apr 2022 13:57:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62F2C145BA52;
 Thu, 21 Apr 2022 13:57:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-3-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v9 02/21] cachefiles: notify user daemon when looking up
 cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1444649.1650549423.1@warthog.procyon.org.uk>
Date: Thu, 21 Apr 2022 14:57:03 +0100
Message-ID: <1444650.1650549423@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	help
> +	  This permits on-demand read mode of cachefiles.  In this mode, when
> +	  cache miss, the cachefiles backend instead of netfs, is responsible
> +	  for fetching data, e.g. through user daemon.

How about:

	help
	  This permits userspace to enable the cachefiles on-demand read mode.
	  In this mode, when a cache miss occurs, responsibility for fetching
	  the data lies with the cachefiles backend instead of with the netfs
	  and is delegated to userspace.

> +	/*
> +	 * 1) Cache has been marked as dead state, and then 2) flush all
> +	 * pending requests in @reqs xarray. The barrier inside set_bit()
> +	 * will ensure that above two ops won't be reordered.
> +	 */

What set_bit()?  What "above two ops"?  And that's not how barriers work; they
provide a partial ordering relative to another pair of barriered ops.

Also, set_bit() can't be relied upon to imply a barrier - see
Documentation/memory-barriers.txt.

> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
> +	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)) {

It might be worth abstracting this into an inline function in internal.h:

	static inline bool cachefiles_in_ondemand_mode(cache)
	{
		return IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
			test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)
	}

> +#ifdef CONFIG_CACHEFILES_ONDEMAND

This looks like it ought to be superfluous, given the preceding test - though
I can see why you need it:

> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
> +	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
> +	u32				ondemand_id_next;
> +#endif

I'm tempted to say that you should just make them non-conditional.  It's not
like there's likely to be more than one or two cachefiles_cache structs on a
system.

David

