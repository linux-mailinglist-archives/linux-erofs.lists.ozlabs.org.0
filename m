Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88A4AC7BF
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Feb 2022 18:39:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jstfw0Nrkz30R0
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 04:39:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1644255544;
	bh=B88LRLAclEkM9TCnyPgwwmkE47LUP94VBs7izWY2HRQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oYBrKfxaYAj10QHtmczH+5FyhBnmizQV6j4Oi9+xR6mpoBEv4w6nZkVszhLvprVJB
	 JUOl2u2idhHLA+GzhB+LO3aQFFj9LRTj03dvuiE1cXWrcsbppZiOD7ga+CibkeiHD0
	 hldx+tkf30XXd0bVqZrBOjNBCoY4yXg1JCQiD10JMKhdroswdq5zfuObSsW+wokjHC
	 zSWZ3HAYoi6Lq6278OJsVC9rZbmSKOa6EYgeOCjWT51vUdDP5SpgKhD0bK/B+qqrvX
	 2WvOFmEN0jvGb8GNhFBpoL6m7MF9k9Di/ikZOiJwiu21i/46QOu/1JKGLyM/1r3Ryq
	 Ol7tfNxoAHcbw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82e;
 helo=mail-qt1-x82e.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=ERX76O+1; dkim-atps=neutral
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jstfr0Wrqz2xBl
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Feb 2022 04:38:59 +1100 (AEDT)
Received: by mail-qt1-x82e.google.com with SMTP id t17so12396423qto.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 07 Feb 2022 09:38:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B88LRLAclEkM9TCnyPgwwmkE47LUP94VBs7izWY2HRQ=;
 b=XA4cxLYIJ1kAAgJrVSwWVueAZ0Mm2uwk5YvFm50SARIyiHmYT7Ua3vUnL++N0RM7jg
 +6Cf2WY4RkjswRGRjeVgxBqJ//Hn9H9q5ERyP+UlFgR7U67LGulyNrIXjfGC6bu2H+r5
 wSmaz+QOYuopNhTY32oW5WeJ40dnSzEppoDsyTgbUZ4bC4L/vuFCP3xF0oDd/D2XIc3T
 D7abDoqm7OCp4KHRFoF5BOqw2DY35GlMyvx7F90L4jlN2u/gM4z0ACPlxwVQUT9Uog2j
 bPyJQzOLfQZZV8SZQ0y/VYQcf3bNrrbI9ZWl+1R0R2bwmN4nEyzqZJIOuGH0u7wuKzN3
 nEXw==
X-Gm-Message-State: AOAM5325LjPGlc+Gt97an/Op/NEb0GKsgq7XzIGUvCsEOsabjiCU/ocR
 lQ1PXf2osL5mxx8V7sQolae1JGVgOha/0Yil2ADg8w==
X-Google-Smtp-Source: ABdhPJwJVHnxvMdOzziBnA61VCtPIqTPUJqQWKDPglPbLFL7nAkwryV9iNxU7PuDtsyPcA2gDtWXmjIDRNm1MZHpHCQ=
X-Received: by 2002:ac8:509:: with SMTP id u9mr440370qtg.530.1644255536716;
 Mon, 07 Feb 2022 09:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20211222020307.273150-1-zhangkelvin@google.com>
 <YgBg9mjAxi5aPSW6@B-P7TQMD6M-0146.local>
 <YgB+/+xCCjqT6AQO@B-P7TQMD6M-0146.local>
In-Reply-To: <YgB+/+xCCjqT6AQO@B-P7TQMD6M-0146.local>
Date: Mon, 7 Feb 2022 09:38:45 -0800
Message-ID: <CAOSmRzjGFpxq4MUAKC0TFeRP_R8=gZUtA0J2yefWhdmij-8FhA@mail.gmail.com>
Subject: Re: [PATCH v1] erofs-utils: lib: Fix 8MB bug on uncompressed extent
 size
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

-1

On Sun, Feb 6, 2022 at 6:08 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Mon, Feb 07, 2022 at 07:59:50AM +0800, Gao Xiang wrote:
> > Hi Kelvin,
> >
> > On Tue, Dec 21, 2021 at 06:03:07PM -0800, Kelvin Zhang wrote:
> > > Previously, uncompressed extent can be at most 8MB before mkfs.erofs
> > > crashes on some error condition. This is due to a minor bug in how
> > > compressed indices are encoded. This patch fixes the issue.
> > >
> > > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> > > ---
> > >  include/erofs_fs.h |  2 +-
> > >  lib/compress.c     | 21 ++++++++++++++++++++-
> > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > index 9a91877..13eaf24 100644
> > > --- a/include/erofs_fs.h
> > > +++ b/include/erofs_fs.h
> > > @@ -353,7 +353,7 @@ enum {
> > >   * compressed block count of a compressed extent (in logical clusters, aka.
> > >   * block count of a pcluster).
> > >   */
> > > -#define Z_EROFS_VLE_DI_D0_CBLKCNT          (1 << 11)
> > > +#define Z_EROFS_VLE_DI_D0_CBLKCNT          (1U << 11)
> >
> > If erofs_fs.h update is necessary, I prefer to update in-kernel
> > header first. Would you mind making a kernel patch for this if needed?

Reverted erofs_fs.h change.

> >
> > >
> > >  struct z_erofs_vle_decompressed_index {
> > >     __le16 di_advise;
> > > diff --git a/lib/compress.c b/lib/compress.c
> > > index 98be7a2..23e571c 100644
> > > --- a/lib/compress.c
> > > +++ b/lib/compress.c
> > > @@ -97,7 +97,26 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
> > >             } else if (d0) {
> > >                     type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
> > >
> > > -                   di.di_u.delta[0] = cpu_to_le16(d0);
> > > +                   /* If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
> > > +                    * will interpret |delta[0]| as size of pcluster, rather
> > > +                    * than distance to last head cluster. Normally this
> > > +                    * isn't a problem, because uncompressed extent size are
> > > +                    * below Z_EROFS_VLE_DI_D0_CBLKCNT * BLOCK_SIZE = 8MB.
> > > +                    * But with large pcluster it's possible to go over this
> > > +                    * number, resulting in corrupted compressed indices.
> > > +                    * To solve this, we use Z_EROFS_VLE_DI_D0_CBLKCNT-1 if
> > > +                    * the uncompressed extent size goes above 8MB. This is
> > > +                    * OK because if kernel sees another non-head cluster
> > > +                    * after going back by |delta[0]| blocks, kernel will
> > > +                    * just keep looking back.
> > > +                    */
> >
> > Would you mind updating this into the kernel comment style, I mean
> > /*
> >  * ...
> >  */
> > Instead?

Done

> >
> > > +                   if (d0 & Z_EROFS_VLE_DI_D0_CBLKCNT) {
> > > +                           di.di_u.delta[0] = max(
> > > +                                   d0 & (~Z_EROFS_VLE_DI_D0_CBLKCNT),
> > > +                                   Z_EROFS_VLE_DI_D0_CBLKCNT-1);
> >
> > May I ask if it's actually tested with big pcluster feature? It's
> > lack of cpu_to_le16() convert and even the original
> > Z_EROFS_VLE_DI_D0_CBLKCNT flag.

Sorry.. It was tested on a Little Endian machine, so I didn't discover
the missing cpu_to_le16. Added now.

>
> Sorry this part shouldn't have Z_EROFS_VLE_DI_D0_CBLKCNT flag.
>
> Btw, I think a proper change for this might be just:
>         if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT - 1)
>                 di.di_u.delta[0] = le16_to_cpu(Z_EROFS_VLE_DI_D0_CBLKCNT - 1);
>         else
>                 di.di_u.delta[0] = cpu_to_le16(d0);
> Or using max() to simplify above even more a bit.

This would work, but it's not optimal. For example,
Z_EROFS_VLE_DI_D0_CBLKCNT << 1
is greater than Z_EROFS_VLE_DI_D0_CBLKCNT, but it does not have the
11th bit set.
Using Z_EROFS_VLE_DI_D0_CBLKCNT-1 in this case would cause the kernel to
take more hops than necessary when finding the head cluster. A better
change would be:

        if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT - 1)
                di.di_u.delta[0] = le16_to_cpu(largest number smaller
than d0 that does not have Z_EROFS_VLE_DI_D0_CBLKCNT bit set);
        else
                di.di_u.delta[0] = cpu_to_le16(d0);

But how do we find "largest number smaller than d0 that does not have
Z_EROFS_VLE_DI_D0_CBLKCNT bit set" ?
Simple, clear the Z_EROFS_VLE_DI_D0_CBLKCNT bit, and set all bits
before that to 1. In code:
d0 & (~ Z_EROFS_VLE_DI_D0_CBLKCNT) | (Z_EROFS_VLE_DI_D0_CBLKCNT-1)

So final answer:

        if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT - 1)
                di.di_u.delta[0] = le16_to_cpu(d0 & (~
Z_EROFS_VLE_DI_D0_CBLKCNT) | (Z_EROFS_VLE_DI_D0_CBLKCNT-1));
        else
                di.di_u.delta[0] = cpu_to_le16(d0);



>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Gao Xiang



-- 
Sincerely,

Kelvin Zhang
