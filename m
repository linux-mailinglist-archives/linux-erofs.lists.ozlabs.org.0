Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F71B97AB1C
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 07:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726551608;
	bh=/rNsH8fwqQ99fQIkyXWrjp4kESfkbqMuFCS7j+lnONE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=AZDcbDaMFOEEu53cmltM90TDHxixgwiPOHadaq62Yui4gtc4IyzX3lZ1g1+KBB7ja
	 fCH3pqSYP+xRoyw3nF7gX8CUxphauyfEkLZLgGwGydS6/EaZg60RfbEqYVtxWbd2LR
	 sKmD+JCzOjaD7qELrorDHeSLU9HV0ZS0g+W552TuBpLB/x9xg7lYVWSVJWIgeIVIQG
	 2WjjmZ9O60XQdfqiUNJOurMqE7sMnwfLJRP3OKJY9YUp7HyRxwJvN7ZMkSqsl981+z
	 avF3RBX3Y1/lLH3T4GwBn9IivUs9bFRTk8V+tTm5Jf4t40sg4W0bOmzzEjgKprsRbk
	 z1cS+RiGWsN9Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X79bX3BFgz2yMv
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 15:40:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726551605;
	cv=none; b=Qj845iy9p/7HI7cx70yB6y+UJMGS3DVpYYxeAILzuFUxeDIuh0D4iesdJPBdmvsVw94jdzFJyH+fJhZ9tQosB9s7DbxhQXwgK8GXatfTZtr2CGpdHxSGoaPSh0XWtP6Rbo6miMFM9y4DDNWfCDkuFkRKCRBlEcyLUBIOM8dg7tc4bxDSl0nK3a0m0lHpXlfH2qit2Y8Fb2ev+DB/2x4BqgyvAmGD2vgpgAO9C0odQuG2gGc3HzMVhJND0fpAgs+CZQSFud4cN5xgJu5WyczEAPCKmXXUGftw9JoKo3RV0daaQBLNfsrbAqHhchCVuGDc4gh9C2ty7sVbDL1YsUUefA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726551605; c=relaxed/relaxed;
	bh=/rNsH8fwqQ99fQIkyXWrjp4kESfkbqMuFCS7j+lnONE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky6XctOniKbi+ER6kofJIUt99310ECVrYTTg1lNoepatUBhlG+aohhN1yWmlJdNcVf7hdIl5lB8jNiEunxhzEu/D/MOE+DkMYNbfMyMMg5NnsQtiWv7NQv1Rr7ZPDGL+WR2lDh7OFOm6IWy4SMzPb896s/ZXbLTPqCF2jkScrnXftvEF+AQYJG+zxHw6h44ZeTIEz50XRvXXxZxHRFRkdzl1shE2vFu1/97Md+cHaGRAcaiCmPqIF+MbqmzqyUN9V6fUWqM094dIA2XSsbHr7QXDu+H9VCIg5QjkoLYAUYb6BPOtUSICn1RzVc4dynUepBYMpVFgRNGHGiUngDMsjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=knXtipmy; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=knXtipmy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X79bT48Wqz2xHw
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 15:40:05 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06E2269910;
	Tue, 17 Sep 2024 01:40:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726551603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/rNsH8fwqQ99fQIkyXWrjp4kESfkbqMuFCS7j+lnONE=;
	b=knXtipmypuDuPGLEVzoNibIPS2gDWwWjmkNpJMzYwTO3Hh47ACEfpfjUxhRng8tSdRQaDP
	lzedY/Ngjowq6P31HJ+o8k+QeI10bYs7ZtXYC5o1MxE39GNcv75xT9VBP98IqwLhcRr73u
	iYeQQmeBKqEgdOC/0xJoPA3dOdMclL1wdbFOR0AD0txHUCgqoeKH0ShTLK1pzCFr9MblH1
	Ku48QZEryboHPyxFaPMJzAQuK2IeLtc4luuECSui2+PqvVOwTEK60yOE8eJoT8SoIk26WS
	5cSRZL0qErwO0mgkIe6tWVxGn47VkVUfDZN25faZTAi6ac5aJWEgRkgIRRLZEg==
Date: Tue, 17 Sep 2024 13:39:57 +0800
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <fleabfstkn2ciljoszwoqwpatanznrjlpkowrldqybn44xp4pq@kqsssm5uujuq>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091655-sneeze-pacify-cf28@gregkh>
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 16, 2024 at 07:55:43PM GMT, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
> > diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> > new file mode 100644
> > index 000000000000..0f1400175fc2
> > --- /dev/null
> > +++ b/fs/erofs/rust/erofs_sys.rs
> > @@ -0,0 +1,22 @@
> > +#![allow(dead_code)]
> > +// Copyright 2024 Yiyang Wu
> > +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> 
> Sorry, but I have to ask, why a dual license here?  You are only linking
> to GPL-2.0-only code, so why the different license?  Especially if you
> used the GPL-2.0-only code to "translate" from.
> 
> If you REALLY REALLY want to use a dual license, please get your
> lawyers to document why this is needed and put it in the changelog for
> the next time you submit this series when adding files with dual
> licenses so I don't have to ask again :)
> 
> thanks,
> 
> greg k-h

C'Mon, I have no intension to make this discussion look heated.

I mean what I original code is under MIT and i've learned that Linux
is GPL-2.0, so I naively thought it's OK to dual licensed this to
support flexibility according the Wikipedia, should I quote: "When
software is multi-licensed, recipients can typically choose the terms
under which they want to use or distribute the software, but the simple
presence of multiple licenses in a software package or library does not
necessarily indicate that the recipient can 
freely choose one or the other. "[1]. Since it says multiple licenses
does not necessarily indicate that the recipient can freely choose one
or other,I thought the strictest license applies here and it should
GPL-2.0-only in this case.

I don't have any previous experience in Kernel Development so I really
just have no ideas about you guys attitude towards this kind of issue.
If insisted on switching back to GPL-2.0-only code, It's fine for me
and i'llchange this in the next version. Again I don't have this kind
of knowledge in advance, and if multi-license is inspected case-by-case,
project-by-project, then I will take notes and never make this
kind of mistakes again.

Best Regards,
Yiyang Wu.
