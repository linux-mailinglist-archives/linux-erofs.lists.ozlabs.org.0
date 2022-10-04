Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543625F4788
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 18:26:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhjkX0T9sz306m
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:26:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=p46gr6yN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=p46gr6yN;
	dkim-atps=neutral
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhjkN1rWjz2xHT
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 03:26:03 +1100 (AEDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3573ed7cc15so95975367b3.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Oct 2022 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Htl2/UOtuakFj+rlRmSs6Rtjfw7RhKB4bWx+dQUTEgU=;
        b=p46gr6yN5POSHLCbttGPUu5e55GsSRrw1poIcXN7+ya0k0OQUjrlZNX/kbmdbRTVNP
         A6hzuJCqwzdsG3CAz/FcxJBWc8PnXmL+CDm/pQcFxzhTJmqj9132s50FlWiK5vhrradG
         ROCapmMEa/uUzO/3JVxTivmzN6rdG6vLnmhjqXeNh3fRp1IabiWCtEQFFrKgwqblIDJ1
         RZk43aXruEBjr06H5TyOweZ4h6wbRvp9XaztFwufhRjHqiCguEdZzsMzALjqunem1sWp
         fnWS+mlFiGaGVaiwp8iPY9EjTT/aD6apR+NAZTpPeWckEvBXIo8S51h25G0KiRMamyyN
         WRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Htl2/UOtuakFj+rlRmSs6Rtjfw7RhKB4bWx+dQUTEgU=;
        b=PAqhypuuSohTQtaOG5TK2xfrKtL641UQPQ8zR/WgDOk3RIQN5tT0yCmjT16lypcAfP
         elLiYS3mxhouDVB60RNDYk/AfpF3EGolW4gmqLnGaFc/C0wSbOvf4TuA0gLf/VcPUNm0
         m2lkSe5+fL9bhw9UGv/CkyFanqRE18dIUU0eeeBoWlO4IH68qonX2igeUaBAHhhAl7nt
         4dzBM5qSli04HwkOkq4M1EDmZc8IpyvE9Kte+iXY0o9kMVMNLL0GfMbGWwDDHdppf0hT
         1YgASR7tgMUxFTVFXJV9xnIV/BF85ZqIw4uziR/GaPkG32nTIA0LZlbbr+tGFyUZSm5z
         hJsA==
X-Gm-Message-State: ACrzQf16WCg4Sq2nWViz16Y3EW9o4Y5AIuvNIF5W5JIPI8cbpFa9tcSi
	V/d2Cp5nydmlwPpimOrISIJq7+L4ymwMBBEo8go=
X-Google-Smtp-Source: AMsMyM41mQUt/lvz3jF1f2sp8F2r5+pWEgbFR+A5CIyWT8fNxYC0nRnbVkxZvfwWQODF23i8l9RJkv3jyAXVbzGDakc=
X-Received: by 2002:a81:c95:0:b0:358:ece4:7a58 with SMTP id
 143-20020a810c95000000b00358ece47a58mr12327703ywm.302.1664900759779; Tue, 04
 Oct 2022 09:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221004160237.10849-1-naoto.yamaguchi@aisin.co.jp> <YzxcOcJK+8gB8psP@debian>
In-Reply-To: <YzxcOcJK+8gB8psP@debian>
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Wed, 5 Oct 2022 01:25:48 +0900
Message-ID: <CABBJnRa6S87f9uwuUEfR55rKHwnhkpDVtfPvX0tcoZWc_2vgow@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Add volume-name setting support
To: Naoto Yamaguchi <wata2ki@gmail.com>, linux-erofs@lists.ozlabs.org, 
	Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Gao

Thank you feedback!

>1) How about following mke2fs by using "-L volume-label" ?
>https://www.man7.org/linux/man-pages/man8/mke2fs.8.html

The mkfs.extX is using "-L volume-label".
The mkfs.vfat is using "-n volume-name".
I think both better.
You commented to "-L" is more better, I will change it.

>2) If possible, how about adding a kernel ioctl for this if you have more =
interest?
>I mean FS_IOC_GETFSLABEL.

It's interesting feature.  I will try to work it.

Thanks,
Naoto Yamaguchi.
a member of Automotive Grade Linux Instrument Cluster EG.

2022=E5=B9=B410=E6=9C=885=E6=97=A5(=E6=B0=B4) 1:15 Gao Xiang <xiang@kernel.=
org>:
>
> Hi Naoto,
>
> On Wed, Oct 05, 2022 at 01:02:37AM +0900, Naoto Yamaguchi wrote:
> > The erofs_super_block has volume_name field.  On the other hand,
> > mkfs.erofs is not supporting to set volume name.
> > This patch add volume-name setting support to mkfs.erofs.
> > Option keyword is similar to mkfs.vfat.
> >
> > usage:
> >   mkfs.erofs -n volume-name image-fn dir
>
> Thanks for your patch! The patch itself generally looks good to me.
>
>
> Just two minor ideas:
>
> 1) How about following mke2fs by using "-L volume-label" ?
> https://www.man7.org/linux/man-pages/man8/mke2fs.8.html
>
> 2) If possible, how about adding a kernel ioctl for this if you have
> more interest?  I mean FS_IOC_GETFSLABEL.
>
> >
> > Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> > ---
> >  include/erofs/internal.h |  1 +
> >  man/mkfs.erofs.1         |  4 ++++
> >  mkfs/main.c              | 13 ++++++++++++-
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 2e0aae8..7dc42eb 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -92,6 +92,7 @@ struct erofs_sb_info {
> >       u64 inos;
> >
> >       u8 uuid[16];
> > +     char volume_name[16];
> >
> >       u16 available_compr_algs;
> >       u16 lz4_max_distance;
> > diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> > index 11e8323..fb98505 100644
> > --- a/man/mkfs.erofs.1
> > +++ b/man/mkfs.erofs.1
> > @@ -32,6 +32,10 @@ big pcluster feature if needed (Linux v5.13+).
> >  Specify the level of debugging messages. The default is 2, which shows=
 basic
> >  warning messages.
> >  .TP
> > +.BI "\-n " volume-name
> > +Set the volume name for the filesystem to volume-name.  The maximum le=
ngth of
> > +the volume name is 16 bytes.
> > +.TP
> >  .BI "\-x " #
> >  Specify the upper limit of an xattr which is still inlined. The defaul=
t is 2.
> >  Disable storing xattrs if < 0.
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 594ecf9..613ee46 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -80,6 +80,7 @@ static void usage(void)
> >       fputs("usage: [options] FILE DIRECTORY\n\n"
> >             "Generate erofs image from DIRECTORY to FILE, and [options]=
 are:\n"
> >             " -d#                   set output message level to # (maxi=
mum 9)\n"
> > +           " -n volume-name        set the volume name (max 16 bytes).=
\n"
>
> ...
>
> >             " -x#                   set xattr tolerance to # (< 0, disa=
ble xattrs; default 2)\n"
> >             " -zX[,Y]               X=3Dcompressor (Y=3Dcompression lev=
el, optional)\n"
> >             " -C#                   specify the size of compress physic=
al cluster in bytes\n"
>
>
>               " -L volume-label       set the volume label (maximum 12)\n=
"
>
> Thanks,
> Gao Xiang
