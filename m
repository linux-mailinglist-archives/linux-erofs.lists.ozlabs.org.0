Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798524D5965
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 05:09:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFC9t26rbz2xTr
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 15:09:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=M2Xll1QY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529;
 helo=mail-ed1-x529.google.com; envelope-from=mudongliangabcd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=M2Xll1QY; dkim-atps=neutral
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFC9n28gNz2xTr
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 15:09:16 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id t1so9245178edc.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 20:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BLdDEY0ZaXtV08Rg36rxuH62r53ycY7deqQ93QiRfkU=;
 b=M2Xll1QYLfFCslI1puy4E7DbFi50Mfa4DyPuP2UIcN6lruYTZsnvP2DdgkOMsbftQt
 g+nAd41GqKTeFujiCOfGJYcMZXgQqUfXEvXk1DZdCACBezUIUB4LFX83BMRl2OGyamQ7
 YLQtZ7eWuQP03hCnYAs1BLw5z5gIIny+E3UenHDV1bxh9mHXEtfWCunkwsql4/BDAeOO
 /7EXNl42sQT/ADxKW4qk3TLQR8yac+1DmSCgf4g2dWBQ6yrcEWwUnowJCNaXc3Heg4zf
 rPCnH6azXCPmtG1cQO4Y7wcrNMTyrVeewf36sjkGn+bUvzWrS8mOqUsybHmZjd5Ek2HW
 KFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BLdDEY0ZaXtV08Rg36rxuH62r53ycY7deqQ93QiRfkU=;
 b=ubVpVNgKoK1iB3+NdaxOhMMzGwaF5f8A0JkM+g6ayb1eLCyk+twtxj6M22NVcmnRwR
 IMx7yurZhy1BvdWN6PK4moQdbTkh30qwbXuOX4MkyGfTBpU6kcqjagDPbpC82wVY6yTO
 NPP1vZPHD40xx+c8Trf5VKryvizUh+6VbSo5w9YGlyJKyXftRJdqIo5NfIWyNV/Hu1dq
 MhEBBubeiFcXIxqN6ieqDXbM2ezqTiu+9dEyRUIBKKPjpXGTXECl0PvGV4Xt789QIRvw
 Oi58JPYrrs4LY0n4xLHulUyMeYPcIeRjT2W5dzKalXXGmu1E/v8I0XmSfbpO3GfqPu6U
 3meQ==
X-Gm-Message-State: AOAM532k0zWXUvo1JnjmCKSX6F7FLFY0gp8RLs8mzy2xV8EinONWbbGe
 e4oOTp1yjTK7X1372IKcPc6IuZuUEtQwb1YIRuk=
X-Google-Smtp-Source: ABdhPJzq8CaffWapL47XzlWwURj1LhJ6E1PXH2cq8R3GdL8tEg8TRZsz7aDMjFZmxsMdrEKRmhfQF0aM/FnOvBlSlkw=
X-Received: by 2002:a05:6402:34d5:b0:416:201f:c636 with SMTP id
 w21-20020a05640234d500b00416201fc636mr7091190edc.293.1646971749257; Thu, 10
 Mar 2022 20:09:09 -0800 (PST)
MIME-Version: 1.0
References: <CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com>
 <Yinxk7PZxu9KdKHI@B-P7TQMD6M-0146.local>
 <CAD-N9QXrx6=nMz8=wRXP2a7n8uROsH7cws5-K+pJvNHqfWWcug@mail.gmail.com>
In-Reply-To: <CAD-N9QXrx6=nMz8=wRXP2a7n8uROsH7cws5-K+pJvNHqfWWcug@mail.gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 11 Mar 2022 12:08:43 +0800
Message-ID: <CAD-N9QXNb3+RL2jLZBG3M6HoBjjA6rDP8SrXLUBZ1mN9jinifw@mail.gmail.com>
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

On Thu, Mar 10, 2022 at 10:04 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Thu, Mar 10, 2022 at 8:39 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > Hi Dongliang,
> >
> > (+ cc Jianan.)
> >
> > On Thu, Mar 10, 2022 at 06:15:20PM +0800, Dongliang Mu wrote:
> > > Hi kernel developers,
> > >
> > > I am writing to kindly ask for some suggestions on fixing "WARNING:
> > > kobject bug in erofs_unregister_sysfs".
> > >
> > > The underlying issue is in the following,
> > >
> > > erofs_fc_get_tree
> > > -> get_tree_bdev
> > >   -> fill_super
> > >     -> erofs_fc_fill_super
> > >
> >
> > Thanks for the report!
> >
> > > When erofs_register_sysfs fails in the calling kobject_init_and_add,
> > > it just returned an error code and the parent function will call
> > > deactivate_locked_super to do clean up.
> >
> > Yes, in that way we don't need to rewrite another error path (actually
> > once we had another duplicated error path but Al suggested the current
> > shape...)
> >
> > >
> > > In the following stack trace, it finally calls erofs_unregister_sysfs
> > > without knowing the execution status of erofs_register_sysfs, which
> > > leads to the kobject bug.
> > >
> > >  erofs_unregister_sysfs+0x46/0x60 fs/erofs/sysfs.c:225
> > >  erofs_put_super+0x37/0xb0 fs/erofs/super.c:771
> > >  generic_shutdown_super+0x14c/0x400 fs/super.c:465
> > >  kill_block_super+0x97/0xf0 fs/super.c:1397
> > >  erofs_kill_sb+0x60/0x190 fs/erofs/super.c:752
> > >  deactivate_locked_super+0x94/0x160 fs/super.c:335
> > >  get_tree_bdev+0x573/0x760 fs/super.c:1297
> > >
> > > I am not sure how to fix this bug. Any suggestion is appreciated.
> >
> > I think a simple way is to introduce a `sysfs_inited' boolean to
> > sbi to indicate that. Or some better suggestion is welcomed.
>
> Yes, it's an idea to use a boolean to indicate the execution status.
> Let me first try to craft a drafted patch and test it on Syzbot.

I've drafted one patch and sent it here.

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5aa2cf2c2f80..ba2db2e9e3b7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -144,6 +144,7 @@ struct erofs_sb_info {
  u32 feature_incompat;

  /* sysfs support */
+ bool sysfs_inited;
  struct kobject s_kobj; /* /sys/fs/erofs/<devname> */
  struct completion s_kobj_unregister;
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dac252bc9228..795273c15c42 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
     "%s", sb->s_id);
  if (err)
  goto put_sb_kobj;
+ sbi->sysfs_inited = true;
  return 0;

 put_sb_kobj:
@@ -221,8 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
  struct erofs_sb_info *sbi = EROFS_SB(sb);

- kobject_del(&sbi->s_kobj);
- kobject_put(&sbi->s_kobj);
+ if (sbi->sysfs_inited) {
+ kobject_del(&sbi->s_kobj);
+ kobject_put(&sbi->s_kobj);
+ sbi->sysfs_inited = false;
+ }
  wait_for_completion(&sbi->s_kobj_unregister);
 }

The compilation is fine. However, since the crash report does not have
any reproducer, I cannot test it in Syzbot or my local instance.

>
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > --
> > > My best regards to you.
> > >
> > >      No System Is Safe!
> > >      Dongliang Mu
