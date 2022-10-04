Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA1D5F4808
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 19:05:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhkbF4lBkz30NS
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 04:04:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=cjVXIdd0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2d; helo=mail-yb1-xb2d.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=cjVXIdd0;
	dkim-atps=neutral
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhkbC07y9z2xvr
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 04:04:54 +1100 (AEDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j7so17509262ybb.8
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Oct 2022 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=z3ETyJJd9qB02abWJeWe5y1Unu99T6kkxdjUpI44fTc=;
        b=cjVXIdd0es162KEAIKFTOHNtU9ahWA3tFDXIHfm0ZMyDgUjRMazukNu0V33W6IlhIl
         BBmE7FGZ8DnibPrQ3x3nfB6QGSY0ut3IlsKy8ckj64YmRW8SFUUMdK+n4OG1YlWRMxc3
         MhtQh280gclvB74COx3xCZFagVdPcISuoTu5gPHtqkA1Hgt9fUAejheMJIT/UNfVDww4
         ypg5RJpqGv0SWvbdGU3i9NyU6nMOTp4FUHKwuPBJVF8VqRCx33KUrETKhQHuS90TcsTs
         jLBEsKCJMKC+WGSzl/5FADfEtFzIpM95LeUWEXecIicoQIovcUtIa6FEoP6PyfEqB8Kv
         VPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=z3ETyJJd9qB02abWJeWe5y1Unu99T6kkxdjUpI44fTc=;
        b=LkIxQWX1mxXCFiU1S+xqDchaucWFrSz7f+nP/moIw9JEkl+d1h9+ChqBKtRZ7+RKVI
         rzfvMfdVNw64+kTAuJFh+cj8TziUzlgWbxhitrzl2QLn8uYH2x3zAF9ayPRNNczFs4Cu
         6fjfywvwHpj1MTjGnECJiNwEuxwGx1GZFk1A/+boF5JPBndDDgVeatbFAa4owtvg4Tos
         KVDq3ReGrTPwpKqE9k6BTJ6zn8ywlLd6+mu4FK55Jbw9X8Hk6/7DGOzh/5FC8yzPnM9K
         uwJDdxdXd/NFUaAGkOt0CTunn5eJMQDSZElobNyDWz2+cQf+gHO2vUVWGFDJWCARXjcy
         XxsA==
X-Gm-Message-State: ACrzQf0lwGWRRGSpFrntQJ+yDnmvUwuIeJ8vm/d+QfzQTlWAEcANvz3N
	PgHz329OC92h30M/hX9z6eiKCnKTgQEh45WPs2M=
X-Google-Smtp-Source: AMsMyM6XjDRWYEJVYqvpCb7euuA6Kevlt3UYolr4Fableklx7iOW/7ppNCKfRhCcLeDVgPl6D84qCegTmoZ/9kASYmo=
X-Received: by 2002:a25:beca:0:b0:6bd:5aaf:908 with SMTP id
 k10-20020a25beca000000b006bd5aaf0908mr14886252ybm.201.1664903091183; Tue, 04
 Oct 2022 10:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <YzxgPKoi9Q1scK3N@debian> <20221004164324.11481-1-naoto.yamaguchi@aisin.co.jp>
 <YzxkE6rN1KcZmF09@debian>
In-Reply-To: <YzxkE6rN1KcZmF09@debian>
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Wed, 5 Oct 2022 02:04:39 +0900
Message-ID: <CABBJnRY9PRQD6T4zLJSGGRP_MUUUtZ4D50m-+BzSHNyQgg6-Dg@mail.gmail.com>
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

Sorry I'm missing subject and commit message.
I inclement and fix commit message.

Thanks,
Naoto Yamaguchi.
a member of Automotive Grade Linux Instrument Cluster EG.

2022=E5=B9=B410=E6=9C=885=E6=97=A5(=E6=B0=B4) 1:49 Gao Xiang <xiang@kernel.=
org>:
>
> On Wed, Oct 05, 2022 at 01:43:24AM +0900, Naoto Yamaguchi wrote:
> > The erofs_super_block has volume_name field.  On the other hand,
> > mkfs.erofs is not supporting to set volume name.
> > This patch add volume-name setting support to mkfs.erofs.
> > Option keyword is similar to mkfs.vfat.
> >
> > usage:
> >   mkfs.erofs -n volume-name image-fn dir
> >
>
> commit message is not updated... also it'd be better to bump
> up the patch version in the subject line like:
>
> [PATCH v2] erofs-utils: mkfs: ...
>
> > Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> > ---
> >  include/erofs/internal.h |  1 +
> >  man/mkfs.erofs.1         |  5 +++++
> >  mkfs/main.c              | 13 ++++++++++++-
> >  3 files changed, 18 insertions(+), 1 deletion(-)
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
> > index 11e8323..b65d01b 100644
> > --- a/man/mkfs.erofs.1
> > +++ b/man/mkfs.erofs.1
> > @@ -66,6 +66,11 @@ Pack the tail part (pcluster) of compressed files in=
to its metadata to save
> >  more space and the tail part I/O. (Linux v5.17+)
> >  .RE
> >  .TP
> > +.BI "\-L " volume-label
> > +Set the volume label for the filesystem to
> > +.IR volume-label .
> > +The maximum length of the volume label is 16 bytes.
> > +.TP
> >  .BI "\-T " #
> >  Set all files to the given UNIX timestamp. Reproducible builds require=
s setting
> >  all to a specific one.
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 594ecf9..08a4215 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -84,6 +84,7 @@ static void usage(void)
> >             " -zX[,Y]               X=3Dcompressor (Y=3Dcompression lev=
el, optional)\n"
> >             " -C#                   specify the size of compress physic=
al cluster in bytes\n"
> >             " -EX[,...]             X=3Dextended options\n"
> > +           " -L volume-label        set the volume label (max 16 bytes=
).\n"
>
> Not aligned here.
>
> >             " -T#                   set a fixed UNIX timestamp # to all=
 files\n"
> >  #ifdef HAVE_LIBUUID
> >             " -UX                   use a given filesystem UUID\n"
> > @@ -212,7 +213,7 @@ static int mkfs_parse_options_cfg(int argc, char *a=
rgv[])
> >       int opt, i;
> >       bool quiet =3D false;
> >
> > -     while ((opt =3D getopt_long(argc, argv, "C:E:T:U:d:x:z:",
> > +     while ((opt =3D getopt_long(argc, argv, "C:E:L:T:U:d:x:z:",
> >                                 long_options, NULL)) !=3D -1) {
> >               switch (opt) {
> >               case 'z':
> > @@ -255,6 +256,15 @@ static int mkfs_parse_options_cfg(int argc, char *=
argv[])
> >                       if (opt)
> >                               return opt;
> >                       break;
> > +
> > +             case 'L':
> > +                     if (optarg =3D=3D NULL || strlen(optarg) > 16) {
>
>                                         sizeof(sbi.volume_name);
>
> > +                             erofs_err("invalid volume label");
> > +                             return -EINVAL;
> > +                     }
> > +                     strncpy(sbi.volume_name, optarg, 16);
>
>                                                 sizeof(sbi.volume_name)?
>
>
> Thanks,
> Gao Xiang
>
> > +                     break;
> > +
> >               case 'T':
> >                       cfg.c_unix_timestamp =3D strtoull(optarg, &endptr=
, 0);
> >                       if (cfg.c_unix_timestamp =3D=3D -1 || *endptr !=
=3D '\0') {
> > @@ -483,6 +493,7 @@ int erofs_mkfs_update_super_block(struct erofs_buff=
er_head *bh,
> >       sb.blocks       =3D cpu_to_le32(*blocks);
> >       sb.root_nid     =3D cpu_to_le16(root_nid);
> >       memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
> > +     memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
> >
> >       if (erofs_sb_has_compr_cfgs())
> >               sb.u1.available_compr_algs =3D sbi.available_compr_algs;
> > --
> > 2.25.1
> >
