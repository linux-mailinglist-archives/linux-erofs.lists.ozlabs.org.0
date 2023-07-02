Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 892437452E5
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 00:16:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=d/joY9YV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvNgb5x9mz302R
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 08:16:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=d/joY9YV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=nolange79@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvNgS6gnyz2xnK
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Jul 2023 08:16:19 +1000 (AEST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40355e76338so8813011cf.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 02 Jul 2023 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688336174; x=1690928174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kyPoPPRph9/x0oRy1V2qLrUaf5m/Bp0RgKWxSicfhQY=;
        b=d/joY9YVsfZOnXMpIw+e3etzKL+9JqZTwuHNpC7Gv3mFNssn3ao31VNzAq94x60MLS
         wAdfp2sTPXaR/GuYiCI0+l4ReI0Imrb7leF0jG65U7lXXFN0V333nddmlHeXD16syHZS
         NLlZUMWU4/IDI6RW80q2S6dpR+NbT4elwpTqj0g5ikapEBdSGICSN10TXZzmnfy9JmZE
         fdR+RqR/ELbxBG/m+3Om1OO149yUdd+BuXH5wUd399zEGyyL4EGb/JadyeI2Ti2TvSz4
         tb0tCQ58EeGb/ADSU5Ecf3jTvqBCBXpezJpmX2j7N8Nlp4S00ztLkPhCyeCv5ZKMXvOf
         Ihzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688336174; x=1690928174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyPoPPRph9/x0oRy1V2qLrUaf5m/Bp0RgKWxSicfhQY=;
        b=k33mRKh6KRrYiWyB6Evv+th3AFXImkvsMh9WhlHYzfOgw9VBdsJgEez7Va87c9NvNY
         P1GuWEHHdKmvHlT2ESGsjbuMzejJp5l0PaRVLH8gFyqq04rIAnb71Zx/2adMgoqR+GCb
         SfKtbxLBrWPfq9NK4of/LmuN+Bsswhd0e3TR/3D83Rbiux9wrXGZCH7xPpVkjQrxW+iO
         eJs7GdQB5lIvUqmK8657lFPVooYZ4eNhjt1T0Vxl5kGTNqMyYWEA2CxYMqPyC7Hy+WgB
         oFwugCX0YWa/5TW9NHOCRJhy4KARQfgAM2YIht51Q/WOxcHPYl4EvRPVKs2w69BQ34A8
         1tpQ==
X-Gm-Message-State: AC+VfDxtNiS2DS5A0FYyn/s26PBtMsgPKDt+bBEr3uqKA73vlqElFaRa
	6hCQ7H1KDYdiw30IKcoDt85xBXOliNFRWM2+QaY=
X-Google-Smtp-Source: APBJJlGei6+qoWV9JZjaxL5H2RuYqanHlMQzW22tXjPmlDcQHYgzpDgcSOraHKZZ5CVjOdtmuTUrTyBYiQsyi63/oUg=
X-Received: by 2002:ac8:5cc6:0:b0:400:829e:c395 with SMTP id
 s6-20020ac85cc6000000b00400829ec395mr10431717qta.6.1688336173932; Sun, 02 Jul
 2023 15:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230702101907.5081-1-nolange79@gmail.com> <b737bdff-9f90-e8cc-84b5-a6ee24ef291b@linux.alibaba.com>
In-Reply-To: <b737bdff-9f90-e8cc-84b5-a6ee24ef291b@linux.alibaba.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Mon, 3 Jul 2023 00:16:02 +0200
Message-ID: <CADYdroNuhDhbK029bP04NUVReyf2_vOjLAAPN_a4we8eD_fSAA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: Provide identical functionality without libuuid
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
Cc: linux-erofs@lists.ozlabs.org, Huang Jianan <huangjianan@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am So., 2. Juli 2023 um 13:07 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
>
> Hi Norbert,
>
> On 2023/7/2 18:19, Norbert Lange wrote:
> > The motivation is to have standalone (statically linked) erofs binaries
> > for simple initrd images, that are nevertheless able to (re)create
> > erofs images with a given UUID.
> >
> > For this reason a few of libuuid functions have implementations added
> > directly in erofs-utils.
> > A header liberofs_uuid.h provides the new functions, which are
> > always available. A further sideeffect is that code can be simplified
> > which calls into this functionality.
> >
> > The uuid_unparse function replacement is always a private
> > implementation and split into its own file, this further restricts
> > the (optional) dependency on libuuid only to the erofs-mkfs tool.
> >
> > Signed-off-by: Norbert Lange <nolange79@gmail.com>
>
> Yeah, overall it looks good to me, some minor nits as below:
>
> (Also currently UUID makes the image nonreproducable, I wonder if we
>   could use some image hash to calculate the whole UUID instead...)

Not the usecase I am after, I need to use an already known UUID for
mounting, even if the content changed.

>
> > ---
> >   dump/Makefile.am    |   2 +-
> >   dump/main.c         |   8 +---
> >   fsck/Makefile.am    |   2 +-
> >   lib/Makefile.am     |   4 +-
> >   lib/liberofs_uuid.h |   9 ++++
> >   lib/uuid.c          | 106 ++++++++++++++++++++++++++++++++++++++++++++
> >   lib/uuid_unparse.c  |  21 +++++++++
> >   mkfs/Makefile.am    |   6 +--
> >   mkfs/main.c         |  21 ++-------
> >   9 files changed, 149 insertions(+), 30 deletions(-)
> >   create mode 100644 lib/liberofs_uuid.h
> >   create mode 100644 lib/uuid.c
> >   create mode 100644 lib/uuid_unparse.c
> >
> > diff --git a/dump/Makefile.am b/dump/Makefile.am
> > index c2bef6d..90227a5 100644
> > --- a/dump/Makefile.am
> > +++ b/dump/Makefile.am
> > @@ -7,4 +7,4 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
> >   dump_erofs_SOURCES = main.c
> >   dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
> >   dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
> > -     ${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
> > +     ${liblz4_LIBS} ${liblzma_LIBS}
> > diff --git a/dump/main.c b/dump/main.c
> > index bc4e028..40af09f 100644
> > --- a/dump/main.c
> > +++ b/dump/main.c
> > @@ -17,10 +17,8 @@
> >   #include "erofs/compress.h"
> >   #include "erofs/fragments.h"
> >   #include "../lib/liberofs_private.h"
> > +#include "../lib/liberofs_uuid.h"
> >
> > -#ifdef HAVE_LIBUUID
> > -#include <uuid.h>
> > -#endif
> >
> >   struct erofsdump_cfg {
> >       unsigned int totalshow;
> > @@ -620,9 +618,7 @@ static void erofsdump_show_superblock(void)
> >               if (feat & feature_lists[i].flag)
> >                       fprintf(stdout, "%s ", feature_lists[i].name);
> >       }
> > -#ifdef HAVE_LIBUUID
> > -     uuid_unparse_lower(sbi.uuid, uuid_str);
> > -#endif
> > +     erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
> >       fprintf(stdout, "\nFilesystem UUID:                              %s\n",
> >                       uuid_str);
> >   }
> > diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> > index e6a1fb6..4176d86 100644
> > --- a/fsck/Makefile.am
> > +++ b/fsck/Makefile.am
> > @@ -7,4 +7,4 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
> >   fsck_erofs_SOURCES = main.c
> >   fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
> >   fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
> > -     ${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
> > +     ${liblz4_LIBS} ${liblzma_LIBS}
> > diff --git a/lib/Makefile.am b/lib/Makefile.am
> > index faa7311..e243c1c 100644
> > --- a/lib/Makefile.am
> > +++ b/lib/Makefile.am
> > @@ -29,9 +29,9 @@ noinst_HEADERS += compressor.h
> >   liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
> >                     namei.c data.c compress.c compressor.c zmap.c decompress.c \
> >                     compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
> > -                   fragments.c rb_tree.c dedupe.c
> > +                   fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c
> >
> > -liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
> > +liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
> >   if ENABLE_LZ4
> >   liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> >   liberofs_la_SOURCES += compressor_lz4.c
> > diff --git a/lib/liberofs_uuid.h b/lib/liberofs_uuid.h
> > new file mode 100644
> > index 0000000..d156699
> > --- /dev/null
> > +++ b/lib/liberofs_uuid.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> > +#ifndef __EROFS_LIB_UUID_H
> > +#define __EROFS_LIB_UUID_H
> > +
> > +void erofs_uuid_generate(unsigned char *out);
> > +void erofs_uuid_unparse_lower(const unsigned char *buf, char *out);
> > +int erofs_uuid_parse(const char *in, unsigned char *uu);
> > +
> > +#endif
> > \ No newline at end of file
> > diff --git a/lib/uuid.c b/lib/uuid.c
> > new file mode 100644
> > index 0000000..acff81a
> > --- /dev/null
> > +++ b/lib/uuid.c
> > @@ -0,0 +1,106 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> > +/*
> > + * Copyright (C) 2023 Norbert Lange <nolange79@gmail.com>
> > + */
> > +
> > +#include <string.h>
> > +#include <errno.h>
> > +
> > +#include "erofs/config.h"
> > +#include "erofs/defs.h"
> > +#include "liberofs_uuid.h"
> > +
> > +#ifdef HAVE_LIBUUID
> > +#include <uuid.h>
> > +#else
> > +
> > +#include <stdlib.h>
> > +#include <sys/random.h>
> > +
> > +/* Flags to be used, will be modified if kernel does not support them */
> > +static unsigned erofs_grnd_flag =
>
> Could we switch to "unsigned int" for this?

Sure

>
> > +#ifdef GRND_INSECURE
> > +    GRND_INSECURE;
> > +#else
> > +    0x0004;
> > +#endif
> > +
> > +static int s_getrandom(void *pUid, unsigned size, bool insecure)
> > +{
> > +    unsigned kflags = erofs_grnd_flag;
> > +    unsigned flags = insecure ? kflags : 0;
>
> same here.
>
> Otherwise it looks good to me.

Found few a formatting inconsistencies as well, already fixed this locally.
Guess I will wait a bit more for feedback before posting a v2? Not sure
whats the proper order.

>
> Thanks,
> Gao Xiang

regards, Norbert
