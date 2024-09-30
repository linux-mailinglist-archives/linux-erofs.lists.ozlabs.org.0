Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A9598A6E8
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 16:23:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHNZz5gJ1z303K
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2024 00:23:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.219.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727706184;
	cv=none; b=FOuXnHgMeZQsWLwsLJwfiIzESnq1+yh90gH67XrkP9NDlP12UoCMmUhTcfCIjtR8OtSBUrQ8wP7n8KBe7OSGUeVXClK02run0M/nlMyuiIOEVpwaHMMepUoTDFkDFK87eZ2FX8Z1QcTz1ZFI9lPrts8Hq6L39iGsKd3lTu6Q001onezAnNjzPwXtw7vaGGewigLNXVuQX6Pv7yQFMbFC0WODjrSWTXKim28nhFh1uhwfJLqNGCmvpVk7lffkKXN7/0ic/ImcBIA5z51R7Ne/0OTY1Pjs/vTRSXvOGosq7BuYLzo9lO0P9eOPPhLh//9csu3L2ZbqT1hQFqjAEQW67g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727706184; c=relaxed/relaxed;
	bh=Cr/EtosCTi+osAYF0gtgC9Zdrd07pNfm4NnYKdP5ZWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oerqK+Vayh7mkA3R57hAUHL08c2f1nx1ceagBhsCHVPFW1vsJPQdzX5jzv//NnAuHA/Hsf1aNMQUbVuz353JqMkpqs5ZBPVDsEn5rLubRFiUDQ/71FbCahdPf5kn8PdLc6TsyxeYBl4YgMMAa/JWFiLS2BGw0ybcErBPmTAUawf4MK9/kDMkJCrbTIqEMWqc7Sd/5vt0eoGn9bP0BKDYk0eJmcH1mvUg7rFqt3ZC/R9XSlrLvvPMnMvfKP2IMXKhOYXGjFJiGKwWZS+ELkUgnFlovRHQpslJEfrJxJC4kLidlN6ZmZNHw4W7V6tRtWRgEXqNjg/AaPp2Wl4ZvQSbmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.219.181; helo=mail-yb1-f181.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.219.181; helo=mail-yb1-f181.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHNZv5ftsz2ywq
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2024 00:23:03 +1000 (AEST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso4189124276.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 07:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706180; x=1728310980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr/EtosCTi+osAYF0gtgC9Zdrd07pNfm4NnYKdP5ZWs=;
        b=FSHq6EG0loGDQV4irSb09VW6qZWobikoKpqFeUVDG1o9RkzKsIbejrHWQHaSBIWPes
         X6cMp24+W2lcjtGLSiuXGpZUL3yiZtabI5pQY5Iao+TjarqQW/CpcxDcxOmrzdh9h5BH
         9n7jFkBVIPpnpbtUKSNHI4CAWK6ixvhDvxhi7AIiGchXIneVVGEI1Im4zs543z5PLpe8
         MlXx1KuzkCzQS7/vCHX7W4JwMxXeKNM58lx/1XqNeOJcr9FFc+6mD6yJCZQFnfrTyq96
         yxEjVlmFytef64KPnGQBiUt2HWLq6ySAkjbEMZfCoaVxQUX+xDy2zjY9caDfidzH/plb
         dqVA==
X-Forwarded-Encrypted: i=1; AJvYcCWX8mTQVn+tBg2kGSfuSm8mwkLj9WcRWGoI2FSB0+lb5NNagOo1aF3Qbs1wWWn86n3im9Icpb/YR5X+vw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyd0eR8omul8aT6/PGstx8A0CE5BZBKsqDDPCk9jpJMV42XuBw6
	1ICCXLpTuP07Px2rGeoGD1Orln97KhMwd4ZslrhJ2qNChKP2NkgOCW59fOMB
X-Google-Smtp-Source: AGHT+IH7zup4HFf7wwKThODihLIjARDmpIdT2d2VZ7OI3gZT54+XSEiFPe9+NyqAOrgSx3B7hHIDzg==
X-Received: by 2002:a05:690c:f83:b0:6e2:451c:df02 with SMTP id 00721157ae682-6e245386068mr103229077b3.16.1727706180257;
        Mon, 30 Sep 2024 07:23:00 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e245388345sm13894557b3.110.2024.09.30.07.23.00
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 07:23:00 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1d4368ad91so4361981276.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Sep 2024 07:23:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmESGjw93LWtK5Ld2JSfv2B9f4BzhCMxw0j0z5iATo9tWW59D2vcRVnyW/lMxvw8oe5C2tizMynuxnXw==@lists.ozlabs.org
X-Received: by 2002:a05:690c:55c6:b0:6dd:c6a8:5778 with SMTP id
 00721157ae682-6e245386765mr82710077b3.14.1727706179826; Mon, 30 Sep 2024
 07:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com> <20240930141819.tabcwa3nk5v2mkwu@quack3>
In-Reply-To: <20240930141819.tabcwa3nk5v2mkwu@quack3>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 16:22:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8chLLwxMqwm8DE6_6894q1w=ePJ=hgD34HmNQfJE0PQ@mail.gmail.com>
Message-ID: <CAMuHMdU8chLLwxMqwm8DE6_6894q1w=ePJ=hgD34HmNQfJE0PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
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
Cc: Christian Brauner <brauner@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jan,

On Mon, Sep 30, 2024 at 4:18=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Tue 24-09-24 11:21:59, Geert Uytterhoeven wrote:
> > On Fri, Aug 30, 2024 at 5:29=E2=80=AFAM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> > > It actually has been around for years: For containers and other sandb=
ox
> > > use cases, there will be thousands (and even more) of authenticated
> > > (sub)images running on the same host, unlike OS images.
> > >
> > > Of course, all scenarios can use the same EROFS on-disk format, but
> > > bdev-backed mounts just work well for OS images since golden data is
> > > dumped into real block devices.  However, it's somewhat hard for
> > > container runtimes to manage and isolate so many unnecessary virtual
> > > block devices safely and efficiently [1]: they just look like a burde=
n
> > > to orchestrators and file-backed mounts are preferred indeed.  There
> > > were already enough attempts such as Incremental FS, the original
> > > ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> > > for current EROFS users, ComposeFS, containerd and Android APEXs will
> > > be directly benefited from it.
> > >
> > > On the other hand, previous experimental feature "erofs over fscache"
> > > was once also intended to provide a similar solution (inspired by
> > > Incremental FS discussion [2]), but the following facts show file-bac=
ked
> > > mounts will be a better approach:
> > >  - Fscache infrastructure has recently been moved into new Netfslib
> > >    which is an unexpected dependency to EROFS really, although it
> > >    originally claims "it could be used for caching other things such =
as
> > >    ISO9660 filesystems too." [3]
> > >
> > >  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
> > >    enhancements.  For example, the failover feature took more than
> > >    one year, and the deamonless feature is still far behind now;
> > >
> > >  - Ongoing HSM "fanotify pre-content hooks" [4] together with this wi=
ll
> > >    perfectly supersede "erofs over fscache" in a simpler way since
> > >    developers (mainly containerd folks) could leverage their existing
> > >    caching mechanism entirely in userspace instead of strictly follow=
ing
> > >    the predefined in-kernel caching tree hierarchy.
> > >
> > > After "fanotify pre-content hooks" lands upstream to provide the same
> > > functionality, "erofs over fscache" will be removed then (as an EROFS
> > > internal improvement and EROFS will not have to bother with on-demand
> > > fetching and/or caching improvements anymore.)
> > >
> > > [1] https://github.com/containers/storage/pull/2039
> > > [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=3Dw_A=
eM6YM=3DzVixsUfQ@mail.gmail.com
> > > [3] https://docs.kernel.org/filesystems/caching/fscache.html
> > > [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.c=
om
> > >
> > > Closes: https://github.com/containers/composefs/issues/144
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >
> > Thanks for your patch, which is now commit fb176750266a3d7f
> > ("erofs: add file-backed mount support").
> >
> > > ---
> > > v2:
> > >  - should use kill_anon_super();
> > >  - add O_LARGEFILE to support large files.
> > >
> > >  fs/erofs/Kconfig    | 17 ++++++++++
> > >  fs/erofs/data.c     | 35 ++++++++++++---------
> > >  fs/erofs/inode.c    |  5 ++-
> > >  fs/erofs/internal.h | 11 +++++--
> > >  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++--------------=
--
> > >  5 files changed, 100 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> > > index 7dcdce660cac..1428d0530e1c 100644
> > > --- a/fs/erofs/Kconfig
> > > +++ b/fs/erofs/Kconfig
> > > @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
> > >
> > >           If you are not using a security module, say N.
> > >
> > > +config EROFS_FS_BACKED_BY_FILE
> > > +       bool "File-backed EROFS filesystem support"
> > > +       depends on EROFS_FS
> > > +       default y
> >
> > I am a bit reluctant to have this default to y, without an ack from
> > the VFS maintainers.
>
> Well, we generally let filesystems do whatever they decide to do unless i=
t
> is a affecting stability / security / maintainability of the whole system=
.
> In this case I don't see anything that would be substantially different
> than if we go through a loop device. So although the feature looks somewh=
at
> unusual I don't see a reason to nack it or otherwise interfere with
> whatever the fs maintainer wants to do. Are you concerned about a
> particular problem?

I was just wondering if there are any issues with accessing files directly.
If you're fine with it, I am, too.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
