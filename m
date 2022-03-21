Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6614E2C05
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 16:21:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMdcq1QgGz30M3
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 02:21:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pM6u9L8P;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=pM6u9L8P; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMdcf5nZbz2xKT
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 02:21:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yjHmNUrTcsfBaaW2FV8OWLDc9yEfNnCQ4g7zaOGPWqs=; b=pM6u9L8P999sXYeV/U2ZFRYDSN
 SpEi168deMKZu9jl3PQ2+oOchdAFGkGuEC8zT6guPBzxs5YkCKUmjvKUW9zwv8NvHCPKYaEiecS6t
 7VDVjvBg6ESSZ7MQQSSqB+OuszsrOOcQ14kdJXG6liG6oe206cC7QFz1vnR8MkQVWicnRzRQGHMkm
 KVQrS63cEIfBON47cvlquRNC6Q8lsctQWTLO3kSRia4x42KS8uZKD+iflz4S52GmkYIpS8C1LJEWU
 frUF02UGLNlLqQ483T3LkqrTp9wKwK6BcXpsUOb61xFDTBMJAcp2KcnNDS6QpmMBXA2tqs1xBARiC
 FbIDCPkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nWJqI-00Ah2w-Dv; Mon, 21 Mar 2022 15:21:10 +0000
Date: Mon, 21 Mar 2022 15:21:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjiX5oXYkmN6WrA3@casper.infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
 <YjiLACenpRV4XTcs@casper.infradead.org>
 <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
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

On Mon, Mar 21, 2022 at 11:18:05PM +0800, JeffleXu wrote:
> >> Besides, IMHO read-write lock shall be more performance friendly, since
> >> most cases are the read side.
> > 
> > That's almost never true.  rwlocks are usually a bad idea because you
> > still have to bounce the cacheline, so you replace lock contention
> > (which you can see) with cacheline contention (which is harder to
> > measure).  And then you have questions about reader/writer fairness
> > (should new readers queue behind a writer if there's one waiting, or
> > should a steady stream of readers be able to hold a writer off
> > indefinitely?)
> 
> Interesting, I didn't notice it before. Thanks for explaining it.

No problem.  It's hard to notice.

> BTW what I want is just
> 
> ```
> PROCESS 1		PROCESS 2
> =========		=========
> #lock			#lock
> set DEAD state		if (not DEAD)
> flush xarray		   enqueue into xarray
> #unlock			#unlock
> ```
> 
> I think it is a generic paradigm. So it seems that the spinlock inside
> xarray is already adequate for this job?

Absolutely; just use xa_lock() to protect both setting & testing the
flag.
