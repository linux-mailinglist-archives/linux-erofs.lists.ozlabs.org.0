Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A3264D625
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 06:27:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXghk55L5z3c3W
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 16:27:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DWRUka20;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DWRUka20;
	dkim-atps=neutral
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXghf04cBz3bW6
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 16:26:57 +1100 (AEDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-14455716674so19631367fac.7
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Dec 2022 21:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugi43+CxnCVzs61mUFggN+cBksdQ5zTojIwwIBBVgzI=;
        b=DWRUka20XascrOiVBk5hiC6DYy2dtWWqvvvx57LXyaP9iPZAu3JheJ2a/M+mKdxxuh
         f3P5fFM/zi8yRk+YX8rFlBwFJBwRrDZRi78SlfN+EQ21QS/xC0s/6ZFrd7Bj8wWAUh2X
         8IriowqNKbxXO3BHHKOMKqdwUWt5umqEwtPc20+AdCuTd70P+79zFC2HWwdPHNowA7vW
         3HdqppbpDIC1afAfwuOOgZLbqbSJKBsZhTdsJdzWAMSREM7SX1ka7rVroosqeUW19NMK
         STfgtS//smxo1A3d4VnBtODxVvtS1d2Ktql1U5XUcWDfBpD1svH5aCloAFVC7U+0cu10
         pFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ugi43+CxnCVzs61mUFggN+cBksdQ5zTojIwwIBBVgzI=;
        b=ao/ed4dAszeFyNwm0dU49c2fvBUZ6FSM5+RVQTvG61qcHMpTJj7eVlD3cPBTlsHSVr
         dj5VVI1u53EduVHfREZonL4xIKCi42buI3rRglc0LCdkr33YKthyIbHdIfOyxbLWkLms
         uwSd9f5aDHOe83b+EQbTDHmUoY74eEbVlx/Xm2zwFI2RqzmQyhaoUNl2LTu0xU8Q8/Hm
         OkHkQGphiUSwuPK2UVmdTpMlCp2aFFnr4I+VRLptbtrkhN5VJPravkiKnjyVRMw+69E8
         s1RehW2rgxEnWGkaobhlyblywt5Y1RJagCCrq8o+41FDNO3a4ELbdq/7AdVSpkFjF1lV
         CoYQ==
X-Gm-Message-State: ANoB5pnAwdqBypZJBMfCJCIob4ookRpdv6nmM/lAgLXmZtoFCpOHoB5U
	a7HBeelCN2SiZbqdEZ/RraQtvFW/5UEbtAS92Ww27I6C
X-Google-Smtp-Source: AMrXdXtI6KzwQxr/n3y8O+jE93ArwgqPII6RwpaVWiBNxk9q/jfVf3IRg33eGxDwyEOqgQkV0c7i1LkKC6FXad+tKOA=
X-Received: by 2002:a05:6870:9f09:b0:144:e1eb:419 with SMTP id
 xl9-20020a0568709f0900b00144e1eb0419mr65461oab.262.1671082007776; Wed, 14 Dec
 2022 21:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20221208085335.2884608-1-raj.khem@gmail.com> <20221208085335.2884608-2-raj.khem@gmail.com>
 <Y5HySDMzY8CSLQeJ@debian> <CAMKF1srO6o=RAt_HUTTJ5fQXHErUHJ=oZ2yjw5pE7B4tV6s7Gg@mail.gmail.com>
 <Y5SfrbgaHgFxk/Dg@debian> <CAMKF1spkK0e6CehNkx7003v=rsSWRcms8MARqedjsno-4dk-2Q@mail.gmail.com>
 <Y5qeuUqlvwVcbbEL@B-P7TQMD6M-0146.local>
In-Reply-To: <Y5qeuUqlvwVcbbEL@B-P7TQMD6M-0146.local>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 14 Dec 2022 21:26:21 -0800
Message-ID: <CAMKF1sqqcgz=sxmWKDXfK-ENaBaz3F49U48MSTFFK2RhyUVkXw@mail.gmail.com>
Subject: Re: [PATCH 2/3] erofs_fs.h: Make LFS mandatory for all usecases
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 14, 2022 at 8:12 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi Khem,
>
> On Sat, Dec 10, 2022 at 11:49:25AM -0800, Khem Raj wrote:
>
> ...
>
> > > >
> > > > as said above if we are ok to pass it always then we can add -D
> > > > _FILE_OFFSET_BITS=64 via toplevel Makefile.am
> > > > it will only be needed on 32bit systems though, so maybe we do not
> > > > define it and demand it from users via CFLAGS
> > > > if they compile it for 32bit systems.
> > > >
> > >
> > > I think use -D _FILE_OFFSET_BITS=64 would be a better choice...
> > >
> >
> > OK I will rework it in v3.
>
> Do you still have some interest to work on this?
> (I'm about to release erofs-utils 1.6 in a month.. It would be helpful
>  to clean up such stuff in this version.)

Yes, I am testing a build of v3 today, and I will send out the v3
patchset soon after that.

>
> Thanks,
> Gao Xiang
>
> >
> > > Thanks,
> > > Gao Xiang
