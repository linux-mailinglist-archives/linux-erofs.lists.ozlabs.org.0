Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76FA38432
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 14:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739798044;
	bh=gzJ2YG6weSz+CFbCyKl4mnY+VTrcTl16Wh/C2tZm7So=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nQfzM+n4wc2zYwrXzX2EVuDNtK2ShJJYoRF0Q0hcwXY0lF1Mtiz6F7wKjR0zoTIF1
	 wgsyNb1ceVGYi3Z3FhMRy7WJNLfq0JcqQUahSNA43o2djYjSbc8p2T6Cq/NSn5Yccm
	 Wou1aXWAasKsMVtLNNmva7KORsmWVx1ZOwTOPcjmLX7zcs1NCdkO2ne4E039kYbv/s
	 gheKDVF6bBi7a6OxjxC6MH/Giqp6/HNi2CyyavjxCwRewVE0RhRT5qh7XtboH28Gk+
	 77HZqGRl11GDh+uhGzuuztPKRXJ7ZxDyCYilQqDNB+TTzbHKPJdJFD94p3Pjd91K99
	 HyDsQeTz21Q1A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxNQh38Gsz30Vb
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 00:14:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.104.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739798042;
	cv=none; b=aMohGQK7A5gf5U+WZGkGMXdttT05/0Im+a0Qp1ydvQHw3iofU6Rf0Rohu88TRWJIIsdwh7U7ELS+35VT4LdOxPyFp0ac9gZYfGu1hIVyDaBS/aiY9YlS9mj3d/cJG7dnGggVoCFFDrUTkOPSSUISr0gVujIjted01RbbemlHKIUi2iEw2choAvkK/lzozY0g88BSSwsoACT1YtgFteWXHOjqv7gRfuZmhyv5ezCIGfqKze7FpvlexEcm/90JPSZI2ucH4yXR7+HcZoy5ffA1y3rntB7HSTLy1Ysl7ZvZ3zOj1EpLsoNjqWVtP6BTCk13lDSSuKdBRgKi7+im0HOILg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739798042; c=relaxed/relaxed;
	bh=gzJ2YG6weSz+CFbCyKl4mnY+VTrcTl16Wh/C2tZm7So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdlrYP6O3Vb29tQGSwoFxiHJmXrvilPxDuStGwe4phUjoeI1rJ+ZpfwcdqP9bgdur6KwKcsoKAYI8Gm/paGqI3BmlMh7yeW/U2Edd2cCV80pR0JMA3JlM/hmCEM/GsJiku51SKfGwkUkF0Z4P4qAToDJz4iJBX/an8fUwggEVZBG885U+u2F/KrjViCZ6ffBN7L64sv6nC0UzHh116eHhFBgzvpjdQsxe1XWT8e5elKJhKgxHA3Xs48JP7DDiuYNabne/6oJ27PLjY9+5G0sFOfuIeRJIyOhRPwMqHiN2nwkZ6jQzAT0kpe9SB3e+xilqSrjJpLMuuSr49v4GhlapQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; unprotected) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Hr76/uRW; dkim-atps=neutral; spf=pass (client-ip=148.135.104.50; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=Hr76/uRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.104.50; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
X-Greylist: delayed 315 seconds by postgrey-1.37 at boromir; Tue, 18 Feb 2025 00:14:01 AEDT
Received: from mail.tlmp.cc (unknown [148.135.104.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxNQd1sXwz2yjR
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 00:14:01 +1100 (AEDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4759F5F587;
	Mon, 17 Feb 2025 08:08:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1739797721; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=gzJ2YG6weSz+CFbCyKl4mnY+VTrcTl16Wh/C2tZm7So=;
	b=Hr76/uRWkKlFnJ9mXitWgfsKCR5bkSaoSUi28tvfsejgjGS7BsOSdwwTTBRJ2aMhY84EvA
	Z1GmO8cvlB684BYprLOXvewp9WqhhBHQWOoFcsRkxFbFGbAi57FqGbl1AozUC+JU+9WIa3
	yId6kAVXF+SKz8jn8vA53vqzQHdibStxZmf0dXPvMqHff39grxtCH/o72AmCiiWEXVBQel
	uxHJTSm6BdZT1jAyg02UE4lSjPM3uAo6bUshW2HKEJIJ5ojz3y6eM1BnXR/yA1Nt+kAbiA
	LHuOAVPMVCvQ5Bloss2LMlUtOnj1icsD4L7xjpZMC0Dcsoqz1XrNrqx6a38WlA==
Date: Mon, 17 Feb 2025 21:08:21 +0800
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Rust in FS, Storage, MM
Message-ID: <g5tqgpda4wbhpmi5ahh5btujwajy5dolcouhk2hx6qo2fg5nwr@ua2wnnuvxmeb>
References: <87ldu9uiyo.fsf@kernel.org>
 <0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Level: *
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: 0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com
Cc: Yiyang Wu <toolmanp@tlmp.cc>, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 17, 2025 at 06:41:32PM +0800, Gao Xiang wrote:
> 
> 
> On 2025/2/14 14:41, Andreas Hindborg wrote:
> > Hi All,
> > 
> > On behalf of the Linux kernel Rust subsystem team, I would like to suggest a
> > general plenary session focused on Rust. Based on audience interest we would
> > discuss:
> > 
> >   - Status of rust adoption in each subsystem - what did we achieve since last
> >     LSF?
> >   - Insights from the maintainers of subsystems that have merged Rust - how was
> >     the experience?
> >   - A reflection on process - does the current approach work or should we change
> >     something?
> >   - General Q&A
> 
> Last year Yiyang worked on an experimental Rust EROFS codebase and
> ran into some policy issue (c+rust integration), although Rust
> adaption is not the top priority stuff in our entire TODO list but
> we'd like to see it could finally get into shape and landed as an
> alternative part to replace some C code (maybe finally the whole
> part) if anyone really would like to try to switch to the new one.
> 
> Hopefully some progress could be made this year (by Yiyang), but
> unfortunately I have no more budget to travel this year, yet
> that is basically the current status anyway.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Please note that unfortunately I will be the only representative from the Rust
> > subsystem team on site this year.
> > 
> > Best regards,
> > Andreas Hindborg
> > 
> 

Since i'm cued in, I'd like to share some of my thoughts on the Rust.

I've worked on the EROFS Rust codebase so far. I may have insights on
the current status of Rust subsystem progress. On the Filesystem level,
there still left a lot of yet to be determined especially.

Reimplementing the core functionality of a filesystem is already ok,
though not from perfect, and certainly we need a better abstraction
to model the filesystem correctly in rust language.A lot of helpers (MM,
BDev, Network Application Layer for NFS, etc.)

are still left in the wild to be completed and it requires a lot of
coordination from other subsystem maintainer and rust maintainer
to abstract the C-API into Rust code a way that all parties can hold on to.
I guess it's not the right time to do so in general, we can use rust in
some specific filesystems but generally before other subsystems's API
are stabilized, it's not a good idea to refactor the whole VFS codebase
and abstract the API into Rust one.

Filesystem should be free from memory corruption and rust is
definitely worth the efforts to refactor some of the codebase. 
That means that we may need restrict the flexibility or somehow refactor
the object model that current VFS uses and this certainly requires the
original team that implements the VFS to be involved, at least express
some willingness and interest to refactor instead of gatekeeping the
whole codebase and shutting down the whole discussion (i don't mean to
make criticism here BTW since we should be pretty cautionous on the
original code and don't introduce certain regression issues.) But i guess the
whole community is somehow polarized on this issue, it may not be an
easy job to begin with, alas.

Best Regards,
Yiyang
