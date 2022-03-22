Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0454E44A8
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 18:05:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KNHsv214Wz2yXY
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 04:05:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oUZGH4/C;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=oUZGH4/C; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KNHsl0lcDz2xdN
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Mar 2022 04:04:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=e6u86QrrFQ7usesxm14f5416orKnbME+ZYyiXSDZccc=; b=oUZGH4/ColHKYt58ouWBYR/4qU
 DhTlw/fWf0BNLcfnWfLjOP+lwol/8i6f5MNDd4mZafk6PyH9wgmQ8u1ftnM8agWwcFyXl0tYNMHZh
 OSr1iOyEqQ1eJG572qgYt10ILN9c73UAgCBM9HjqB5veGHx0yVxZqPt3lnFZyLu2VlOZy3Xg7pINk
 YwFf2fVflEnxfZJA2sSrtB4XVXFW52O4dA0dyW/1pB53BMaqueAlgP7mM/fQChooMiVhiOoOcwc1z
 UKWf8Erh46pysIHK/KcwMN3zbaf+sP4OmqYTzyxLMA1g7uedqSZH0Qz0m+2xpu9QZL9NHU6F+bwbU
 a8GlfK9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nWhvy-00BmKW-HY; Tue, 22 Mar 2022 17:04:38 +0000
Date: Tue, 22 Mar 2022 17:04:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjoBpm8mUHX/w/rK@casper.infradead.org>
References: <YjiX5oXYkmN6WrA3@casper.infradead.org>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
 <YjiLACenpRV4XTcs@casper.infradead.org>
 <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
 <1035025.1647876652@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035025.1647876652@warthog.procyon.org.uk>
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
Cc: joseph.qi@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Mar 21, 2022 at 03:30:52PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Absolutely; just use xa_lock() to protect both setting & testing the
> > flag.
> 
> How should Jeffle deal with xarray dropping the lock internally in order to do
> an allocation and then taking it again (actually in patch 5)?

There are a number of ways to handle this.  I'll outline two; others
are surely possible.

option 1:

add side:

xa_lock();
if (!DEAD)
	xa_store(GFP_KERNEL);
	if (DEAD)
		xa_erase();
xa_unlock();

destroy side:

xa_lock();
set DEAD;
xa_for_each()
	xa_erase();
xa_unlock();

That has the problem (?) that it might be temporarily possible to see
a newly-added entry in a DEAD array.

If that is a problem, you can use xa_reserve() on the add side, followed
by overwriting it or removing it, depending on the state of the DEAD flag.

If you really want to, you can decompose the add side so that you always
check the DEAD flag before doing the store, ie:

do {
	xas_lock();
	if (DEAD)
		xas_set_error(-EINVAL);
	else
		xas_store();
	xas_unlock();
} while (xas_nomem(GFP_KERNEL));

