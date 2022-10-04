Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B211A5F4AF5
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 23:34:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhrZ41MXDz2yPm
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 08:34:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DCQzypkZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b29; helo=mail-yb1-xb29.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DCQzypkZ;
	dkim-atps=neutral
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhrYx2znFz2xh0
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 08:34:12 +1100 (AEDT)
Received: by mail-yb1-xb29.google.com with SMTP id 63so18296465ybq.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Oct 2022 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LBtKm+4u4HqN7RsGKmv2jz2UBxR1bqKj59QJyenK8a0=;
        b=DCQzypkZrQESjI93d+VWK4hoRQFtmm5YVi59+jHs00xjLtRGGWumWSKosO7ZpFClq9
         b666OvgGtmywsORKDi+VqfCS973KDCMO1KyPcFdoPCXW3kcft4X5gcrBPRJXsnS1tz5S
         1HtXeBQO18oPFZIq97A4/o5LcYAiM/NNng/zvh6yVZsqFeObkFJ8a3AIVMPOvdTmGDzl
         k1S7q7ijvczJm6D2kcC80OrCjwKGTcrdpgOUZQXouPcZDf1JPZdWHszUkLIUwMMXMo0q
         Kfl3kKCRaHciSgAi5Y+HAOI4FA7sMdar1Q//0wMuL2mQVFqkx/zmaI/uaLqnGOz8S5+M
         SXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LBtKm+4u4HqN7RsGKmv2jz2UBxR1bqKj59QJyenK8a0=;
        b=Xhk2ojduRMeTekKWv/bwyxj1IW9JPciAzMcTB4lZx96/fxKMNMFWHGl9OlK4cX4tDz
         LK/p8d0MdAjuqN4MsJ/BFTlBbRAB4NLTxmwYGVdtiRsa8C/36mb4iZfBR7yM/IyvJFYY
         hFwgW6dySV1eJUS85mWcbJ+l4IS9RHsXPkWQNmm3lBpaHQp8XYil9PoB58fu7J4Gl5A0
         BSYDALYMALxFzHpQVUTQmd/RFHFpHI8c3SapcJ0OWtoZxsunh493DB1wghIvvPJ2mxkk
         /IAJnfZgHuDYI4FQDPOm/T770UtkueKl/ttP6sCQZnqrp850YAyAsvxad6sdu+Hg2jCR
         sjLg==
X-Gm-Message-State: ACrzQf1I8ohvaZ5SR41dj5KBYvanLBc4bBREcs7LU/pFs2BisEWQqVlZ
	XGKPb454HyLk+QkKFYUEUCY07i18CKJ2dOOEG7g=
X-Google-Smtp-Source: AMsMyM6fpaqz5FI4WTpX+oeJtlPumMHzmw4x3k6rKxe4/ui5+oqtq5vvZdgG3ODdlZfIhl+jMukzh4ZlAshcJRxBs28=
X-Received: by 2002:a05:6902:1204:b0:6bc:5ba8:f931 with SMTP id
 s4-20020a056902120400b006bc5ba8f931mr25693069ybu.567.1664919247276; Tue, 04
 Oct 2022 14:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <YzxgPKoi9Q1scK3N@debian> <20221004164324.11481-1-naoto.yamaguchi@aisin.co.jp>
 <YzxkE6rN1KcZmF09@debian> <CABBJnRY9PRQD6T4zLJSGGRP_MUUUtZ4D50m-+BzSHNyQgg6-Dg@mail.gmail.com>
 <YzxzRTg5oUeOCMr+@debian>
In-Reply-To: <YzxzRTg5oUeOCMr+@debian>
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Wed, 5 Oct 2022 06:33:55 +0900
Message-ID: <CABBJnRb-QSYacjPoFW4DyT6=JQt4Boav7A5HCaBFsO6ZTqoXYw@mail.gmail.com>
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

Thank you follow up.

Good for this patch.  I agree to this update.

Thanks,
Naoto Yamaguchi.
a member of Automotive Grade Linux Instrument Cluster EG.

2022=E5=B9=B410=E6=9C=885=E6=97=A5(=E6=B0=B4) 2:54 Gao Xiang <xiang@kernel.=
org>:
>
> Hi Naoto,
>
> On Wed, Oct 05, 2022 at 02:04:39AM +0900, Naoto Yamaguchi wrote:
> > Hi Gao
> >
> > Sorry I'm missing subject and commit message.
> > I inclement and fix commit message.
> >
>
> I've fixed some minor stuffs as below, please help check if it looks
> good to you so that I could apply this version then.
>
> Thanks,
> Gao Xiang
>
> > Thanks,
> > Naoto Yamaguchi.
> > a member of Automotive Grade Linux Instrument Cluster EG.
> >
>
> From b1114ba7b3acfc60c9ab5a707f0a5f38eb4ac825 Mon Sep 17 00:00:00 2001
> From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> Date: Wed, 5 Oct 2022 02:01:15 +0900
> Subject: [PATCH] erofs-utils: mkfs: Add volume-label setting support
>
> The on-disk erofs_super_block has the volume_name field.  On the other
> hand, mkfs.erofs doesn't support setting volume label.
>
> This patch adds volume-label setting support to mkfs.erofs.
> Option keyword is similar to mke2fs.
>
> Usage:
>   mkfs.erofs -L volume-label image-fn dir
>
> Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  include/erofs/internal.h |  1 +
>  man/mkfs.erofs.1         |  5 +++++
>  mkfs/main.c              | 15 ++++++++++++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index db7ac2d..13c691b 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -94,6 +94,7 @@ struct erofs_sb_info {
>         u64 inos;
>
>         u8 uuid[16];
> +       char volume_name[16];
>
>         u16 available_compr_algs;
>         u16 lz4_max_distance;
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 11e8323..b65d01b 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -66,6 +66,11 @@ Pack the tail part (pcluster) of compressed files into=
 its metadata to save
>  more space and the tail part I/O. (Linux v5.17+)
>  .RE
>  .TP
> +.BI "\-L " volume-label
> +Set the volume label for the filesystem to
> +.IR volume-label .
> +The maximum length of the volume label is 16 bytes.
> +.TP
>  .BI "\-T " #
>  Set all files to the given UNIX timestamp. Reproducible builds requires =
setting
>  all to a specific one.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 8b97796..00a2deb 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -86,6 +86,7 @@ static void usage(void)
>               " -zX[,Y]               X=3Dcompressor (Y=3Dcompression lev=
el, optional)\n"
>               " -C#                   specify the size of compress physic=
al cluster in bytes\n"
>               " -EX[,...]             X=3Dextended options\n"
> +             " -L volume-label       set the volume label (maximum 16)\n=
"
>               " -T#                   set a fixed UNIX timestamp # to all=
 files\n"
>  #ifdef HAVE_LIBUUID
>               " -UX                   use a given filesystem UUID\n"
> @@ -237,7 +238,7 @@ static int mkfs_parse_options_cfg(int argc, char *arg=
v[])
>         int opt, i;
>         bool quiet =3D false;
>
> -       while ((opt =3D getopt_long(argc, argv, "C:E:T:U:d:x:z:",
> +       while ((opt =3D getopt_long(argc, argv, "C:E:L:T:U:d:x:z:",
>                                   long_options, NULL)) !=3D -1) {
>                 switch (opt) {
>                 case 'z':
> @@ -280,6 +281,17 @@ static int mkfs_parse_options_cfg(int argc, char *ar=
gv[])
>                         if (opt)
>                                 return opt;
>                         break;
> +
> +               case 'L':
> +                       if (optarg =3D=3D NULL ||
> +                           strlen(optarg) > sizeof(sbi.volume_name)) {
> +                               erofs_err("invalid volume label");
> +                               return -EINVAL;
> +                       }
> +                       strncpy(sbi.volume_name, optarg,
> +                               sizeof(sbi.volume_name));
> +                       break;
> +
>                 case 'T':
>                         cfg.c_unix_timestamp =3D strtoull(optarg, &endptr=
, 0);
>                         if (cfg.c_unix_timestamp =3D=3D -1 || *endptr !=
=3D '\0') {
> @@ -510,6 +522,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer=
_head *bh,
>         sb.root_nid     =3D cpu_to_le16(root_nid);
>         sb.packed_nid    =3D cpu_to_le64(packed_nid);
>         memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
> +       memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
>
>         if (erofs_sb_has_compr_cfgs())
>                 sb.u1.available_compr_algs =3D sbi.available_compr_algs;
> --
> 2.30.2
>
