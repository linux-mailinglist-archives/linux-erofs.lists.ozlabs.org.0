Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455E4D488F
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 15:05:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDrS92dX4z3085
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 01:05:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kNDECRch;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634;
 helo=mail-ej1-x634.google.com; envelope-from=mudongliangabcd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=kNDECRch; dkim-atps=neutral
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDrS35KdMz300F
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 01:05:21 +1100 (AEDT)
Received: by mail-ej1-x634.google.com with SMTP id yy13so12365545ejb.2
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LS5qBtNcaIh+7naOLXI36GoqEScedkt622r2pngfGy0=;
 b=kNDECRchPZdge5WMXMklNmLpCo+PSdNjoHTnPs+PZHOHIEO2S46hmpqSrV2Xqekhfp
 eL9HYgTyB02znrtZhEcoyal5B8rgdC1WYeLpB4H5uwIrgmss80yGWdfc2V0+09xu1e/Q
 rSMY07O+kCnldORj4Sh6CNdB68Ib4FccgRUDm5CNMXT9HwCPWuipzqMG/BvIkD+iyEG7
 rTTHzsNSDiwq906IbAkEZmMV+zpU6aaVPWnVaTRNgJAR046bvUXvyEtN5u3BAJdBAtEF
 z0BfabA1g3osBCQbf1XHy8wZRKKUt1DEht0IujP3GSvJmu98ZrYhq7AMzXN+rLucDniW
 dO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LS5qBtNcaIh+7naOLXI36GoqEScedkt622r2pngfGy0=;
 b=P7aqoIwjLzOXikxAH9lCuHM4V8or1cMnfEH3rOCvmnn09ElJ6uP6eTUPXE3/eNTcsC
 whdLcqagKhPplf1UdBxoUgw/76YvfrkyVeDhYAe97n8eIJeI0uwCC148ASMtY53CGWSZ
 mf1qR7gA9ySywqM2EryY25Q6QeG/Sy6kv9p2xzTXeMUdy4FzgEIyobSCsm9CMAF85QDo
 6pSOoBmGIjgCll49mN6+8qRLG6Dcixax0ioG6/qUsWExumrzcpb57kgdBpDW2n5a9HO3
 G2NAT/G5SAOVrNpLF6dW7+MugxgkQ1EDWjtWoIFy85PecWUbfgsTvgqlZxMViJNetsEQ
 K0vw==
X-Gm-Message-State: AOAM5318Mxznm0OE2jPfUqpnumw1N1wTVfBkODnbhg93zlcxUdtJ237h
 XCI1L0UMyr3M2kpNqhuC7JgNW/34Hxv3M2reT1g=
X-Google-Smtp-Source: ABdhPJxCeVHtHnLN688+o4iLkDUCmjZkKEk3rom3vwjMe+ghMOGLQzlEgCBBAOSEanaQl1BMJPbZq4/FNUNQBnra+Wk=
X-Received: by 2002:a17:907:9482:b0:6da:a24e:e767 with SMTP id
 dm2-20020a170907948200b006daa24ee767mr4292907ejc.479.1646921114073; Thu, 10
 Mar 2022 06:05:14 -0800 (PST)
MIME-Version: 1.0
References: <CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com>
 <Yinxk7PZxu9KdKHI@B-P7TQMD6M-0146.local>
In-Reply-To: <Yinxk7PZxu9KdKHI@B-P7TQMD6M-0146.local>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Thu, 10 Mar 2022 22:04:47 +0800
Message-ID: <CAD-N9QXrx6=nMz8=wRXP2a7n8uROsH7cws5-K+pJvNHqfWWcug@mail.gmail.com>
Subject: Re: How to fix the bug in "WARNING: kobject bug in
 erofs_unregister_sysfs"?
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
Cc: syzbot+045796dbe294d53147e6@syzkaller.appspotmail.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Mar 10, 2022 at 8:39 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi Dongliang,
>
> (+ cc Jianan.)
>
> On Thu, Mar 10, 2022 at 06:15:20PM +0800, Dongliang Mu wrote:
> > Hi kernel developers,
> >
> > I am writing to kindly ask for some suggestions on fixing "WARNING:
> > kobject bug in erofs_unregister_sysfs".
> >
> > The underlying issue is in the following,
> >
> > erofs_fc_get_tree
> > -> get_tree_bdev
> >   -> fill_super
> >     -> erofs_fc_fill_super
> >
>
> Thanks for the report!
>
> > When erofs_register_sysfs fails in the calling kobject_init_and_add,
> > it just returned an error code and the parent function will call
> > deactivate_locked_super to do clean up.
>
> Yes, in that way we don't need to rewrite another error path (actually
> once we had another duplicated error path but Al suggested the current
> shape...)
>
> >
> > In the following stack trace, it finally calls erofs_unregister_sysfs
> > without knowing the execution status of erofs_register_sysfs, which
> > leads to the kobject bug.
> >
> >  erofs_unregister_sysfs+0x46/0x60 fs/erofs/sysfs.c:225
> >  erofs_put_super+0x37/0xb0 fs/erofs/super.c:771
> >  generic_shutdown_super+0x14c/0x400 fs/super.c:465
> >  kill_block_super+0x97/0xf0 fs/super.c:1397
> >  erofs_kill_sb+0x60/0x190 fs/erofs/super.c:752
> >  deactivate_locked_super+0x94/0x160 fs/super.c:335
> >  get_tree_bdev+0x573/0x760 fs/super.c:1297
> >
> > I am not sure how to fix this bug. Any suggestion is appreciated.
>
> I think a simple way is to introduce a `sysfs_inited' boolean to
> sbi to indicate that. Or some better suggestion is welcomed.

Yes, it's an idea to use a boolean to indicate the execution status.
Let me first try to craft a drafted patch and test it on Syzbot.

>
> Thanks,
> Gao Xiang
>
> >
> > --
> > My best regards to you.
> >
> >      No System Is Safe!
> >      Dongliang Mu
