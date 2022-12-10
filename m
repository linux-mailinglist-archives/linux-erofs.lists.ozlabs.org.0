Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A164907A
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 20:50:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NTz4p6SZJz3bgv
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Dec 2022 06:50:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Cy2nEgSf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Cy2nEgSf;
	dkim-atps=neutral
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NTz4h1W1Rz3bSp
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Dec 2022 06:49:55 +1100 (AEDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1433ef3b61fso3816168fac.10
        for <linux-erofs@lists.ozlabs.org>; Sat, 10 Dec 2022 11:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxFcDp+HqpL96RX0+RxPB2V181zGP/joJ6HEQT2NXVs=;
        b=Cy2nEgSf4zZ1fR6ozBMRUm8llh055j5fxuCK9z32NUUAYuHJBgYV2tmTw51lzCDMx8
         5SMcuorl7uqLspWKSlOB3O5+N5DLEKnLXxFx4B21FVq0rvzisT5l6gC/9oOL0xJeGNGC
         xrWRyy+Qzsn5r4sd+5ECaTAU1/SsFlmm9xs+/0D7AzVAaLMeJ+gYFg7ll+P35WA6UlUC
         eNkhlaTMHMk6VgCuerixj11pDA0C+wu/WIrCwn1YV/47MY0ady98eV0SdlIdwotmrKQy
         Vw9OcknmH+anaIvkwT+B0EgCfvkepoUwWxLIyJTNu095Ks+n9uKb12hn92zstOvQQtRe
         OVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFcDp+HqpL96RX0+RxPB2V181zGP/joJ6HEQT2NXVs=;
        b=z6kLZiUKpamkJEvOEz/eKcthwCIR3TQK/ApHgvR0k5J5cZ9nL5JlyK697Ueg8DV0Bk
         D0zqqFFqASLRCecVCirCFsCUDlA5yiHjLhiL2SFsthVC4XMBfCUqHh4ZdDujiJjtlKO2
         1V/JbZxaVtIVMNeJxOISmgj+tLeKW3V5Bt8q18aHUlAxJ1Zd+TZf1KJ0GGnR4fQhneBI
         vUVagLVawathHQrQBUH3l4jUJ25wOAx+AIW1P7DI6UoKFYQ06Esu0WsY9Rjf+mZCLU7U
         mOOBDWTVGzTfGaNO8a5fKtLHF8/CCav1jgY/3msa2hSM6xAr3g1yzULNuoMzY90lix+P
         MHTg==
X-Gm-Message-State: ANoB5plAO95YqqNEhmENTEFmZZF5feVe2J83ogXCihPJ7WmXxdZ1iyz6
	shMAhVn1b0VW94vKGiP/mSMinfzNWo5lqzfagB8=
X-Google-Smtp-Source: AA0mqf6e8/DfEuhY1I0wdkvl2ON7RJJkRhkVbKICsM05YuhU4hmdh4LfkBCymAmrv4wVL7tAP/GSCXSx45mjHc1EX6w=
X-Received: by 2002:a05:6870:9d98:b0:144:e1eb:419 with SMTP id
 pv24-20020a0568709d9800b00144e1eb0419mr3736785oab.262.1670701791344; Sat, 10
 Dec 2022 11:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20221208085335.2884608-1-raj.khem@gmail.com> <20221208085335.2884608-2-raj.khem@gmail.com>
 <Y5HySDMzY8CSLQeJ@debian> <CAMKF1srO6o=RAt_HUTTJ5fQXHErUHJ=oZ2yjw5pE7B4tV6s7Gg@mail.gmail.com>
 <Y5SfrbgaHgFxk/Dg@debian>
In-Reply-To: <Y5SfrbgaHgFxk/Dg@debian>
From: Khem Raj <raj.khem@gmail.com>
Date: Sat, 10 Dec 2022 11:49:25 -0800
Message-ID: <CAMKF1spkK0e6CehNkx7003v=rsSWRcms8MARqedjsno-4dk-2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] erofs_fs.h: Make LFS mandatory for all usecases
To: Khem Raj <raj.khem@gmail.com>, linux-erofs@lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Dec 10, 2022 at 7:03 AM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Khem,
>
> On Fri, Dec 09, 2022 at 06:20:12PM -0800, Khem Raj wrote:
> > On Thu, Dec 8, 2022 at 6:18 AM Gao Xiang <xiang@kernel.org> wrote:
> > >
> > > Hi Khem,
> > >
> > > On Thu, Dec 08, 2022 at 12:53:34AM -0800, Khem Raj wrote:
> > > > erosfs depend on the consistent use of a 64bit offset
> > >
> > > Thanks for your patch!
> > >
> > >   ^ erofs
> >
> > Done in v2
> >
> > >
> > > > type, force downstreams to use transparent LFS (_FILE_OFFSET_BITS=64),
> > > > so that it becomes impossible for them to use 32bit interfaces.
> > > >
> > > > include autoconf'ed config.h to get definition of _FILE_OFFSET_BITS
> > > > which was detected by configure. This header needs to be included
> > > > before any system headers are included to ensure they see the correct
> > > > definition of _FILE_OFFSET_BITS for the platform
> > > >
> > > > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > > > ---
> > >
> > > ...
> > >
> > > > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > > > index 6a70f11..9cc20a8 100644
> > > > --- a/include/erofs/internal.h
> > > > +++ b/include/erofs/internal.h
> > > > @@ -12,6 +12,7 @@ extern "C"
> > > >  {
> > > >  #endif
> > > >
> > > > +#include <config.h>
> > >
> > > could we use alternative way? since I'd like to make include/ as
> > > liberofs later, and "config.h" autoconf seems weird to me...
> > >
> >
> > I am using the AC_SYS_LARGEFILE macro from autoconf to enable support for
> > largefile support during configure. configure will generate config.h
> > in build dir which
> > will contain the essential macros which we use e.g. _FILE_OFFSET_BITS defined
> > to right values. Alternate way is to pass it _always_ or demand it to
> > be passed from
> > user. Which in a way it will do with internal.h check added in this
> > series. I am fine
> > if you do not want to depend on autoconf support to enable LFS. Let me know.
> >
> > > >  #include "list.h"
> > > >  #include "err.h"
> > > >
> > > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > > index 08f9761..a3bd93c 100644
> > > > --- a/include/erofs_fs.h
> > > > +++ b/include/erofs_fs.h
> > > > @@ -9,6 +9,8 @@
> > > >  #ifndef __EROFS_FS_H
> > > >  #define __EROFS_FS_H
> > > >
> > > > +#include <sys/types.h>
> > >
> > > Could you give more hints why we need this here?
> >
> > Its needed to get off_t defined, I have added a comment here
> > in v2i
>
> but we don't use off_t in erofs_fs.h?

the new check I added does use it.

>
> > >
> > > > +
> > > >  #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
> > > >  #define EROFS_SUPER_OFFSET      1024
> > > >
> > > > @@ -410,6 +412,10 @@ enum {
> > > >
> > > >  #define EROFS_NAME_LEN      255
> > > >
> > > > +
> > > > +/* make sure that any user of the erofs headers has atleast 64bit off_t type */
> > > > +extern int eros_assert_largefile[sizeof(off_t)-8];
> > >
> > > erofs? also you could add this into erofs/internal.h...
> > >
> > > This file is just the on-disk definition...
> >
> > yeah moved the check to internal.h in v2
> >
> > >
> > > > +
> > > >  /* check the EROFS on-disk layout strictly at compile time */
> > > >  static inline void erofs_check_ondisk_layout_definitions(void)
> > > >  {
> > > > diff --git a/lib/Makefile.am b/lib/Makefile.am
> > > > index 3fad357..88400ed 100644
> > > > --- a/lib/Makefile.am
> > > > +++ b/lib/Makefile.am
> > > > @@ -28,7 +28,7 @@ noinst_HEADERS += compressor.h
> > > >  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
> > > >                     namei.c data.c compress.c compressor.c zmap.c decompress.c \
> > > >                     compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
> > > > -liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
> > > > +liberofs_la_CFLAGS = -Wall -I$(top_builddir) -I$(top_srcdir)/include -include config.h
> > >
> > > same here too...
> >
> > as said above if we are ok to pass it always then we can add -D
> > _FILE_OFFSET_BITS=64 via toplevel Makefile.am
> > it will only be needed on 32bit systems though, so maybe we do not
> > define it and demand it from users via CFLAGS
> > if they compile it for 32bit systems.
> >
>
> I think use -D _FILE_OFFSET_BITS=64 would be a better choice...
>

OK I will rework it in v3.

> Thanks,
> Gao Xiang
