Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E109853E
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 22:11:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DJhq31HbzDr1j
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 06:11:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=caitlynannefinn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UXz0/pxL"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DJhg3FRxzDqNj
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 06:11:30 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id q22so7236622iog.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2DOTUim7xszpoBzU2nXJGt8etxbT3w7zmjx6UDzqbXU=;
 b=UXz0/pxLpfbJ+/8wDoB0Y7l4WEcoaALBaywsTATMPxdERmlwMg/lFGmHDRFtLLZzBz
 SkEVJMM0tF2zjSunb9BIjk0WyQLSIYZE+fFugI6txHa6/e5m7xFKE/SYZkUOq1SiYQYX
 20jLwLjbKrkpU7KjDWcbl9zUYtE4KBshRsGixr1QVBh6mtAHRanG71hgg0rr2rcjqG9f
 q9ImQndHlYpgYyj+ltasWK5K6apcl9927re5JePwF9K/8Tygzvlk6R/jc1aJAMKUrTmH
 Yb45Xbw+PgnIdmbLv+SJJgBtDod6TvhwpbpK+VveNJP1qtPBdE8TuvGg2vNYoHTVoSwQ
 VvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2DOTUim7xszpoBzU2nXJGt8etxbT3w7zmjx6UDzqbXU=;
 b=bGy0VUtIuii+8R+MLozZydrEaZiM0ZqOpKBiuRdqls1cg23Ly6B96hbwJOOb4XH7hU
 qOTyRw1+1iN4LKn220GmcjZMIK1U2MMmifIF27dJrBoyIckQ7IzEOBG4tItxExJou65g
 G+dJnEdiVe0fF0G2BYw6qrN/M4KSsWUtzPH7Lmtj+VH1RqTnhqhnMRjHTD8QZiYbFX8W
 61H2QE2HBfYea0stnlG7BXxzDcT6ZKy0qaHV1nPkmUoaWeFFo3ugSCUv8coYAbCOnmoW
 PjFumzCHx2frmWTNNSjVt3sBYS8MOsC4MqKfRerHmmEfUy8EsslmHC9fkb4xAes2LNBm
 Ob9g==
X-Gm-Message-State: APjAAAXvenGHDX1wKxRAqe99t3KSFqxPDle2+idcEylnRG+Y+DNZwBxR
 BtoxDZPINWm/plBAq68gCFwHMsmHzjqfxjoAkH0=
X-Google-Smtp-Source: APXvYqwCG+0NxvpiXWFxLs/BwtVZQxRP5BIDZQdTt/uwkeC0l2jxYg38T7Rp5jmL6lWDqWJbyLDcNugi+gNp95irp3g=
X-Received: by 2002:a5d:8ad0:: with SMTP id e16mr114649iot.262.1566418287345; 
 Wed, 21 Aug 2019 13:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
 <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
 <20190821023122.GA159802@architecture4> <20190821151241.GF12461@ares>
 <20190821155205.GB5060@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190821155205.GB5060@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Caitlyn Finn <caitlynannefinn@gmail.com>
Date: Wed, 21 Aug 2019 16:11:15 -0400
Message-ID: <CAG2TOUuM+jE2ZTGTCMpPL7U2Q_motkAH6iWZdUOJLsPY8aC8aA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
 linux-erofs@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 21, 2019 at 11:52 AM Gao Xiang <hsiangkao@aol.com> wrote:
>
> Hi Tobin,
>
> On Wed, Aug 21, 2019 at 08:13:35AM -0700, Tobin C. Harding wrote:
> > On Wed, Aug 21, 2019 at 10:31:22AM +0800, Gao Xiang wrote:
> > > On Tue, Aug 20, 2019 at 07:26:46PM -0700, Joe Perches wrote:
> > > > On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> > > > > Balanced braces to fix some checkpath warnings in inode.c and
> > > > > unzip_vle.c
> > > > []
> > > > > diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> > > > []
> > > > > @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
> > > > >         mutex_lock(&work->lock);
> > > > >         nr_pages = work->nr_pages;
> > > > >
> > > > > -       if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> > > > > +       if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
> > > > >                 pages = pages_onstack;
> > > > > -       else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > > > -                mutex_trylock(&z_pagemap_global_lock))
> > > > > +       } else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > > > > +                mutex_trylock(&z_pagemap_global_lock)) {
> > > >
> > > > Extra space after tab
> > >
> > > There is actually balanced braces in linux-next.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n762
> >
> > Which tree did these changes go in through please Gao?  I believe
> > Caitlyn was working off of the staging-next branch of Greg's staging
> > tree.
>
> I don't think so, the reason is that unzip_vle.c was renamed to zdata.c
> months ago, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs?h=staging-next
>
> so I think the patch is outdated when I first look at it.
>
> Thanks,
> Gao Xiang

Gao,

I see now that I was on an outdated revision (Linux 5.3-rc4) of the
staging-next branch of Greg's staging tree, from
before that change was merged. I'll be certain that I'm fully
up-to-date before submitting future patches.

Thanks all for your time and assistance, and Gao and Joe for the
review comments as well, I'll review and submit
an appropriate patch series at a later time.

Thanks,
Caitlyn Finn
