Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB109EE33C
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 10:40:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y86sd57qlz30Wg
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 20:40:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733996451;
	cv=none; b=dW46CsFMfl4MtE6/8Hapt/l6YHntVp3yvmk/4qKqawcUjbiVaPx8ahNVWXOleDD6vQCHAhu0qK9mExN0Rck4uIYW+6gVWw4pyMbrtKh8/Z8k0hGm57E4lvsJI0dCGwQw4SFJMS8uJLh4W7NC0v6TZGHEvk/h6ckCgQqz4GnQcDYK6r9ExZNCfauDxV6Ef318Bo1+NRzJMUeCqdC5k9F5VWNOWNcoHyJxRh2vj3lx9qwCOjX5Qj9YzyHYi++PSsR/RBtKVCBdvSTvH0aNlzTy12mZj7mgsosmobcuo+R9wMwqo455TIxargesPOtSZZBiIcMFCh2ZzePhEySd/onhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733996451; c=relaxed/relaxed;
	bh=HI1oNr7CL+nnVuJgrueD6wAQ2ASByNdzUY+pTUkKu1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJZbo/+ifo1cB1z+dT/n6n7ba5VziQp6rfL/PkNcL0bPmnOrt0vVeW3I9JBVoT6BxeciNG2V1Co5lK8VM2oqbDntWfHYSzt1oUc7uEe38GyZS2zlmnjd5RdUQOEy2MqwzRPN/Yeu4/lYQ9PcjAg8WWpczyk3270c3rqUWp0/tr7yqA2jjOIzN6tb0HBngxeu7cyS8cGnSQlSe2FS2UQX4z0Q77G+mG9ajRKqQoYE950fdEB+LXlLdC3NsLjEl+j1KKDDDatLpqWtklFD4Ko9L4Hw0f2zPSWnvA3sssuJAPh2bTYUz5VYD3dmOhgwHiNuCNEn+4emTymZPuQ1dzogYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AecvAMjq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::133; helo=mail-il1-x133.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AecvAMjq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::133; helo=mail-il1-x133.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y86sZ2L77z30VM
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 20:40:48 +1100 (AEDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3a8f1c97ef1so1144175ab.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 01:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733996444; x=1734601244; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HI1oNr7CL+nnVuJgrueD6wAQ2ASByNdzUY+pTUkKu1M=;
        b=AecvAMjqNWEp9ry2cAQkmfQWbP6qXLzDIddnjfnr1i+dB+GanBG1GegG1+epRRQ7mh
         ndpnY3HEjiwowy+fbBAM2uKxh1nYgH5lFcHdplqr5T82mnt2Dqm+l0i8UmAVMAbAsis/
         JkDd8RM0AQygVmFyHcrd/t7g3cav+hEDKlTXkcDba6NIh7PDwm8ealpl5WjtRhql5Ouz
         WvKfppH+oBa1dwfti94LtRjuDuv/GmNL17LzWJ9BvYjIZ5R4NB0FCJfYwYNlRkYexn/f
         nNV138HyAVAO17NVCDdWYMbfZN7j5cN+9PfOMLCnsWJD5R4uT5T6WFmifUhqCU/uFz8L
         atPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996444; x=1734601244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HI1oNr7CL+nnVuJgrueD6wAQ2ASByNdzUY+pTUkKu1M=;
        b=FWBLNfax+7BOtxBYvH5Iubgrjft8ecNH5yqAbuPITm8sJUBgzIheWwfHBTSc5/kVa1
         6QVWObGDptgUG9k7vAvalcowIjVHfJI05nUUzNXtlefi0y4Kk1shq1i7TZkcucYnOpCS
         /Cf3MMZgAhlUMsYML3UFPRkqaZrZfEiS1Rc60DpEaU/owZCuA7oZfg7DxK8UKNpEOsGr
         SlZesZ9bbdZTCPhmMVUqjWeJSCleUyxSfM5UyeGNMX+AEoMT+V58ueEv22bqgRv+LG0Q
         B5UNKt/4tyJ3FScLvBWNHS9h2SDGwZ0pdyn2xBDbPYpXMImK4YTE1KGOvV2P5TRNoB9e
         cOwA==
X-Gm-Message-State: AOJu0YxMZY/+Fs2BAVqeNrcsEWyXWLrGegNe6BtI8Q19DcD8O+hpoXWY
	t9mpnYh0bE+GIRZ7lhuGQkHt4/nGLIIyqfS5rqt+SV2mfv5hfH/ph4nGKvjMn91u3AJgIwltqMe
	l3rq/ah+HtQt9Hqrnta7coMuIquQ=
X-Gm-Gg: ASbGnctFa4VsrlGfZQRrKHwjuTatnEmmVx8s7rGNtzT7uZDs5CLeEZRuAECA1/WYmdX
	PAVeSJ5VuBkXyETetWK13cA7O2uqRRXHW1hkK
X-Google-Smtp-Source: AGHT+IEc6J9VkheGBsE7ktfL7L+rUVRxw/zUwqJxxWQIoljC9QPoiGmoH6D2M0GMssCkVOlqhtgwRf9kWtFKsDXptcE=
X-Received: by 2002:a05:6e02:1c28:b0:3a7:fe8c:b015 with SMTP id
 e9e14a558f8ab-3ac4c58857dmr24017825ab.24.1733996443537; Thu, 12 Dec 2024
 01:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20241211150734.97830-1-katexochen0@gmail.com> <41009b11-08e2-4e48-99be-3d59666593ad@linux.alibaba.com>
In-Reply-To: <41009b11-08e2-4e48-99be-3d59666593ad@linux.alibaba.com>
From: Paul M <katexochen0@gmail.com>
Date: Thu, 12 Dec 2024 10:40:32 +0100
Message-ID: <CAGTe2AE9er2TXc0C2hBgincWXqPEmJzq8_nCzSyLTJkscYqg6w@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: add --hardlink-dereference option
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: linux-erofs@lists.ozlabs.org, Leonard Cohnen <leonard.cohnen@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

On 2024/12/11 17:11, Gao Xiang wrote:
>
> Hi Paul,
>
> On 2024/12/11 23:07, Paul Meyer wrote:
> > Add option --hardlink-dereference to dereference hardlinks when
> > creating an image. Instead of reusing the inode, hardlinks are added
> > as separate inodes. This is useful for reproducible builds, when the
> > rootfs is space-optimized using hardlinks on some machines, but not on
> > others.
>
> Thanks for the patch!
>
> Yet I fail to parse the feature, why this feature is useful
> for reproducible builds? IOWs, without this feature (or
> hardlinks are used), what's the exact impact that you don't
> want to?

Sure, here is our full use case: We are building an erofs image with Nix.
Nix stores the rootfs in the nix store (/nix/store). Now there is an option
in nix to enable store optimization via hardlinks. In case optimization is
enabled, files with identical content are turned into hardlinks to save space,
as nix store paths are read-only anyway. If I create a rootfs with
two identical files, those will be hardlinked on systems with optimization
enabled, but have different inodes on systems where optimization is disabled.
When building an erofs, the resulting image will have one inode less on
the system where files are hardlinked.
The goal is to make the image bit-by-bit reproducible on both systems.
By dereferencing hardlinks, we get the exact same image no matter whether
the system uses hardlink optimizations or not.

There is a comparable tar option with the same name.

Thanks,
Paul

>
> Thanks,
> Gao Xiang
>
> >
> > Co-authored-by: Leonard Cohnen <leonard.cohnen@gmail.com>
> > Signed-off-by: Paul Meyer <katexochen0@gmail.com>
> > ---
> >   include/erofs/config.h | 1 +
> >   lib/inode.c            | 2 +-
> >   mkfs/main.c            | 4 ++++
> >   3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > index cff4cea..8399afb 100644
> > --- a/include/erofs/config.h
> > +++ b/include/erofs/config.h
> > @@ -58,6 +58,7 @@ struct erofs_configure {
> >       bool c_extra_ea_name_prefixes;
> >       bool c_xattr_name_filter;
> >       bool c_ovlfs_strip;
> > +     bool c_hardlink_dereference;
> >
> >   #ifdef HAVE_LIBSELINUX
> >       struct selabel_handle *sehnd;
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 7e5c581..5d181b3 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -1141,7 +1141,7 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
> >        * hard-link, just return it. Also don't lookup for directories
> >        * since hard-link directory isn't allowed.
> >        */
> > -     if (!S_ISDIR(st.st_mode)) {
> > +     if (!S_ISDIR(st.st_mode) && (!cfg.c_hardlink_dereference)) {
> >               inode = erofs_iget(st.st_dev, st.st_ino);
> >               if (inode)
> >                       return inode;
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index d422787..09e39f5 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -85,6 +85,7 @@ static struct option long_options[] = {
> >       {"mkfs-time", no_argument, NULL, 525},
> >       {"all-time", no_argument, NULL, 526},
> >       {"sort", required_argument, NULL, 527},
> > +     {"hardlink-dereference", no_argument, NULL, 528},
> >       {0, 0, 0, 0},
> >   };
> >
> > @@ -846,6 +847,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >                       if (!strcmp(optarg, "none"))
> >                               erofstar.try_no_reorder = true;
> >                       break;
> > +             case 528:
> > +                     cfg.c_hardlink_dereference = true;
> > +                     break;
> >               case 'V':
> >                       version();
> >                       exit(0);
>
