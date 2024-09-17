Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2B97AAFE
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 07:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726550882;
	bh=UqoAnaFjj0g05/20IdLuYc+XLZjT4bqDf94/49ZqBlk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HgcvpUEkGr7UXrP8avtqhqj8NrOnW+AdUjNiTfrfX0f5Xs2fOa8Wlcv/iTDYqfXom
	 EpAA4H0XTIWHwMRxOiBtyqhMhpzi31cnX/eHgqbSJi6mNeXrDiHvWyx2uWtPm2b3cZ
	 ppdc7t8GE+AmNgyvsHzdjPl5tzldgHh7d79wqNa+SOTNjSLctp3H1YblCoa0LZ72/F
	 Mt/Trcy1PlkC5nhUsv87TGSmOt+th86gLv5utm4Qm36GyfL7h96KLHfGAKP4OJuUNn
	 8vyiAzzFREEMNJqfODkxMiEZ67fT5oSj/zB9nWalMCr13YUO+/Qt9lfzjDdDKOr66C
	 lfu7pd+tjX7Hw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X79KZ4VLNz2yMv
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 15:28:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726550880;
	cv=none; b=QM35K8SWqQqGb5st5iySrjQgCHY4J5ekHYZoZlKclXZloTLA1i+TWrJW9wlyoqtAhZ/1PensCkujnR2X2PjdoFsnpaJs2fa/YPh/QjjHdtusBNpCS6Afe6s6bMpSIx6SZPTpjcZvhW7IND5Ll4u0ugVmGYK6lT4VZqXAza7Hey6ssiPTiaFczOwQNmS1JCmZNM9hYfv+rq367K9ZycpmWLq7ll+4thh9tUbseXDqhUmR70H/bzipbJ5iXLJTh+Dyl+Dtbrjuwh02UZbNnvi/AJVZ9jTC08HuXP5isBg2/FKPeBe6LdysQt6YqiWIPfSdyWM4L6K62V4HV5CXBAgQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726550880; c=relaxed/relaxed;
	bh=UqoAnaFjj0g05/20IdLuYc+XLZjT4bqDf94/49ZqBlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3oHLJD/C2jNxCpounmEd1ZsQuoxZhfGVrtR9TEgTS1Iue6gUO9uWqvx6j39RDaWsh61Eai5pgmROhFkd64sajmUcwBQTQPK+LUEXX2HI1BxO2C6jB0uQJv5PlRPayFwq2vQ/njkkS7q0PlFG/xQ6CWip4Ic1PBKkW5EfYxRbR8qBMnI9rV24KTOc/UdoIkLWWArgkH1yS1H2q2CyG/a/NYKZYEzMV5CMs8WeULg7UpiF6Mh7aWT6Zjwn2G9BM+EREjGF85sYfyYB63/BMPUCTx8y3Lg23utGFZY753BNOSIxtc4Vy5McchdCFKVIxSUr0rU62ldFKTmrXyN0k7NWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=lXLv26ys; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=lXLv26ys;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X79KX1XWTz2xKQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 15:28:00 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A71626982E;
	Tue, 17 Sep 2024 01:27:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726550875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UqoAnaFjj0g05/20IdLuYc+XLZjT4bqDf94/49ZqBlk=;
	b=lXLv26ysjmiyZ4/wYXdHjA/yN/rFjNJ3nx9N1P0zGIOySd6NphncUuFbURMTF9hF+727Zc
	5x9TRzpKES2GWMmYucBPjQ3rRewe3pVJW7YacN/tMHe2Z9aEio5p6pvPHx15moKaApTag0
	dNxB5WK1p9Jt4OI1eDuAbi90c4PNewEQ52oiYKV1bdiUNKAPpf9zl8jVYVUZ3Sv2cD10Av
	PF56Yb4nuXhm040Z4BMCBxYjeHiPsqgclFYTsqVtp0WpCZmfqKN11E+/MY1TulPCELeIpz
	Z/FnzhJEFh7E2o9CLUBbQMXdTNNVvBDt1wZkVfREW2PT5o5EG755Wv7pNDweCw==
Date: Tue, 17 Sep 2024 13:27:39 +0800
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <igyrm2gfmedt6v654lxcarcc7gqhc2qjkyopkwk65cdtnue3uh@rkz3m5s2qcm4>
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

C'mon, I just don't want this discussion to be heated.

I mean my original code is licensed under MIT and I've already learned
that Linux is under GPL-2.0. So i originally thought modifying it to
dual licenses can help address incompatiblity issues. According to
wikipedia, may I quote: "When software is multi-licensed, recipients
can typically choose the terms under which they want to use or
distribute the software, but the simple presence of multiple licenses
in a software package or library does not necessarily indicate that
the recipient can freely choose one or the other."[1], so according
to this, I believe putting these under a GPL-2.0 project should be
OK, since it will be forcily licensed **only** under GPL-2.0.

Since I wasn't involved in Kernel Development before, 
I just don't know you guys attitudes towards this kind of stuff.
If you guys are not pretty happy with this, I can just switch back to
GPL-2.0 and it's a big business for me.

Best Regards,
Yiyang Wu.
