Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C2966D58
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 02:20:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725063613;
	bh=pnTgkaw7FBT1YuA35mRpkBR8NB9M9iFw+p1sV3ijNNg=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ik5fKpHK8TG78r9Rq5ZYRYURqU6IzYjAIPz8klNyZqfXR7xFr6/TYjEETznOrDhAp
	 zko8XeliOzvEiw4bzEeSAkVVAGgUWH1bFY5wZO2Q6iOTnPoVGAMuSRUQtBll3IbPPa
	 l5g+8OihU/ofztZ94mUnihQuft/JRSFREO1zoFDLdd0xTwxtYPxKQkn+93rvfbyeE1
	 x1uu1MaAg0D3WWvik2slNr4kYvABLYV1MJ3KeHNWov7xBh0YoOa4dtQD1ijCI8fvhN
	 hQfjhQJDDERCq4QIlv4d7YZaJ6nl+M7Ju+/JuGdOOMxePV0dGD/o0IRITr44mlccyX
	 tJxCqWd7hLDTg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwbJF3nszz30V7
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 10:20:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725063608;
	cv=none; b=Ll73S2sJox8OufhT18SvLWE7LmJCGrEgzO52TeY2yQ0RiTfxysOoFEp0EzmTzOqdKXJYRTavdOEoZPlBvNw+OSTSaPwYnxg9o4DiuMOcoP0IDDrCoyDRaEQYlCqRpJJvLgHFJolJnR+wTfQvmVIqg+SbiyaiKC/xQWKHpWZTTbMGQrVQiSNmRZBHq29SU5x7CrtkZKBuO79IKdbmIisliRpIswPaHvzxfTsSZS00Gle6iyCcA7qviPbywuZ2a0KM4Qd0JnTnkz+e7wYKvQ/XkXzvfsUmVv2bPwn3VXtscXNUgBkf9sME2sYo7HCwPxgSIi4Mq708/ZQt4GNMbUVzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725063608; c=relaxed/relaxed;
	bh=pnTgkaw7FBT1YuA35mRpkBR8NB9M9iFw+p1sV3ijNNg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=W5BgFcCaJjIY/pfjwUh6wj8rUf8C574XUKZSo/593Hlo7YThXt+KPMqBA5gp7MeQrkqhVghdIm8Aa3QqgJWBeetzYRTl+UVHp1ffOUPpoRF3upN4nYI8kaOeZn8AsOSU0LLTg2av3VQh4aeXX/zWlHxCNo4iqs7Gn8Y8wUHBT6paJaMVCsU6N105Bn8l81DxWlWUd09UL7ZOQDH6lBGUFfHtmwT7f4mOL0A/miXL81Vvmioevq/0/IBQ4p4V7by85xN/qF1lbXR9M/L2oP1+/euLnAkHG9fKpeZR2SPfyetHuCHGFdI4rfqfREZd+18SKvvNSRegxt8cn9j7xRic5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=cXRetLSW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=cXRetLSW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WwbJ73gfFz30RG
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 10:20:06 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-202146e9538so20106825ad.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 17:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063604; x=1725668404; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnTgkaw7FBT1YuA35mRpkBR8NB9M9iFw+p1sV3ijNNg=;
        b=cXRetLSW7rzgqQdzImqjhU3xciWHpKQnrF1rf76a1WfT32pQVdar8mFmpDtbzbuX4J
         peXLnz/6l3rKo1bhfjyxm5ru320gxokklAsrNHeY490uUW96oCVvnSKx0MsgjputxyoR
         yF9hHo98yOWnfJYsincGuJFp8h70LsfQTCQj5P8SRdeyfIcdSFlTb6HBnkSLzCoXlkJn
         ItpvuqqUJ+111/LRasdlPAx5XbQfKrWfta9c2C+jQ/YXezyfDaePc0a2SUexRJHnu1jC
         UjrZ/kR3iK7OQIf8B5uXhkfeVrBJTCfCQ2+9aMn0g33pGWYjHhYhvLp0BYx+sZQSD400
         XhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063604; x=1725668404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnTgkaw7FBT1YuA35mRpkBR8NB9M9iFw+p1sV3ijNNg=;
        b=EXLgoodiC4+h4/qH73D2ILo2fZt+o7+I9qOgMJXowcW9yfK/MCSoyfAM+ccvZLMt0f
         XMOSCiTQ49qOuOBswY0GiJLxlwLHeznOux2+YwMU2eYr6nlCb8VHS7TPoqrmFk0Q3nK7
         60SmQZkaZF2qKeqcnoNy2NBfNtyGzO+0DuPod2Jir8XkE7jNOkec72hk0wgP8f7yhFiB
         OYfIKxloB36QQG1yDkzG7p8bMkVJp57YIK3+4XC4WBxAg9iKyIvB8M0gTx31+Hfoogq4
         N4X6c/V2bLzaBYlszxQav0PvytzNiqJb/AQccwhNoHcOg8aqE1PtbJBwqNFp5LWKb4hm
         sQgw==
X-Gm-Message-State: AOJu0YyKYzNAPv6hOvH3XQLoLO5D3KgNQ8DBBJ16svOEZ3+G4lVM5o7v
	tqBlgajcYOc1rgzG4I6iSalAMacK2yb2ukepD+NpY0G/nEwPOjQX+4L3vZBy/icS3shbPpcIlDC
	ETj7PKS+SKPELEKbyWao2jeASXuSJWtgru9PLs3l0fifGgn+oeb13boA=
X-Google-Smtp-Source: AGHT+IF6XTKtBOAzEJx7MD6AtUrAhijeTxPzAnrvV/O3/Prkia5bkSOhQQTfiMWxnItUocbdNBp2TMQ56goqyfNkbrI=
X-Received: by 2002:a17:902:ea0a:b0:201:daee:6fae with SMTP id
 d9443c01a7336-2050c3f9cb4mr88855095ad.48.1725063603496; Fri, 30 Aug 2024
 17:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com> <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
Date: Fri, 30 Aug 2024 17:19:52 -0700
Message-ID: <CAB=BE-Q1X2ossOkSUJcW_m-GBnzQngTMnCxUWUBD=qei-J7_=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 29, 2024 at 8:29=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Since EROFS only needs to handle read requests in simple contexts,
> Just directly use vfs_iocb_iter_read() for data I/Os.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - fix redundant refcount which cause hanging on chunked inodes.
>
>  fs/erofs/Makefile   |   1 +
>  fs/erofs/data.c     |  50 +++++++++++-
>  fs/erofs/fileio.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  17 +++--
>  fs/erofs/internal.h |   7 +-
>  fs/erofs/zdata.c    |  46 ++---------
>  6 files changed, 251 insertions(+), 51 deletions(-)
>  create mode 100644 fs/erofs/fileio.c
>
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 097d672e6b14..4331d53c7109 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) +=3D decompressor.o zmap.o z=
data.o zutil.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) +=3D decompressor_lzma.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) +=3D decompressor_deflate.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) +=3D decompressor_zstd.o
> +erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) +=3D fileio.o
>  erofs-$(CONFIG_EROFS_FS_ONDEMAND) +=3D fscache.o
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0fb31c588ae0..b4c07ce7a294 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -132,7 +132,7 @@ int erofs_map_blocks(struct inode *inode, struct erof=
s_map_blocks *map)
>         if (map->m_la >=3D inode->i_size) {
>                 /* leave out-of-bound access unmapped */
>                 map->m_flags =3D 0;
> -               map->m_plen =3D 0;
> +               map->m_plen =3D map->m_llen;
>                 goto out;
>         }
>
> @@ -197,8 +197,13 @@ static void erofs_fill_from_devinfo(struct erofs_map=
_dev *map,
>                                     struct erofs_device_info *dif)
>  {
>         map->m_bdev =3D NULL;
> -       if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
> -               map->m_bdev =3D file_bdev(dif->file);
> +       map->m_fp =3D NULL;
> +       if (dif->file) {
> +               if (S_ISBLK(file_inode(dif->file)->i_mode))
> +                       map->m_bdev =3D file_bdev(dif->file);
> +               else
> +                       map->m_fp =3D dif->file;
> +       }
>         map->m_daxdev =3D dif->dax_dev;
>         map->m_dax_part_off =3D dif->dax_part_off;
>         map->m_fscache =3D dif->fscache;
> @@ -215,6 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erof=
s_map_dev *map)
>         map->m_daxdev =3D EROFS_SB(sb)->dax_dev;
>         map->m_dax_part_off =3D EROFS_SB(sb)->dax_part_off;
>         map->m_fscache =3D EROFS_SB(sb)->s_fscache;
> +       map->m_fp =3D EROFS_SB(sb)->fdev;
>
>         if (map->m_deviceid) {
>                 down_read(&devs->rwsem);
> @@ -250,6 +256,42 @@ int erofs_map_dev(struct super_block *sb, struct ero=
fs_map_dev *map)
>         return 0;
>  }
>
> +/*
> + * bit 30: I/O error occurred on this folio
> + * bit 0 - 29: remaining parts to complete this folio
> + */
> +#define EROFS_ONLINEFOLIO_EIO                  (1 << 30)
> +
> +void erofs_onlinefolio_init(struct folio *folio)
> +{
> +       union {
> +               atomic_t o;
> +               void *v;
> +       } u =3D { .o =3D ATOMIC_INIT(1) };
> +
> +       folio->private =3D u.v;   /* valid only if file-backed folio is l=
ocked */
> +}
> +
> +void erofs_onlinefolio_split(struct folio *folio)
> +{
> +       atomic_inc((atomic_t *)&folio->private);
> +}
> +
> +void erofs_onlinefolio_end(struct folio *folio, int err)
> +{
> +       int orig, v;
> +
> +       do {
> +               orig =3D atomic_read((atomic_t *)&folio->private);
> +               v =3D (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
> +       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) !=
=3D orig);
> +
> +       if (v & ~EROFS_ONLINEFOLIO_EIO)
> +               return;
> +       folio->private =3D 0;
> +       folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
> +}
> +
>  static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t =
length,
>                 unsigned int flags, struct iomap *iomap, struct iomap *sr=
cmap)
>  {
> @@ -399,7 +441,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *ioc=
b, struct iov_iter *to)
>  }
>
>  /* for uncompressed (aligned) files and raw access for other files */
> -const struct address_space_operations erofs_raw_access_aops =3D {
> +const struct address_space_operations erofs_aops =3D {
>         .read_folio =3D erofs_read_folio,
>         .readahead =3D erofs_readahead,
>         .bmap =3D erofs_bmap,
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> new file mode 100644
> index 000000000000..eab52b8abd0b
> --- /dev/null
> +++ b/fs/erofs/fileio.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include "internal.h"
> +#include <trace/events/erofs.h>
> +
> +struct erofs_fileio_rq {
> +       struct bio_vec bvecs[BIO_MAX_VECS];
> +       struct bio bio;
> +       struct kiocb iocb;
> +};
> +
> +struct erofs_fileio {
> +       struct erofs_map_blocks map;
> +       struct erofs_map_dev dev;
> +       struct erofs_fileio_rq *rq;
> +};
> +
> +static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
> +{
> +       struct erofs_fileio_rq *rq =3D
> +                       container_of(iocb, struct erofs_fileio_rq, iocb);
> +       struct folio_iter fi;
> +
> +       DBG_BUGON(rq->bio.bi_end_io);
> +       if (ret > 0) {
> +               if (ret !=3D rq->bio.bi_iter.bi_size) {
> +                       bio_advance(&rq->bio, ret);
> +                       zero_fill_bio(&rq->bio);
> +               }
> +               ret =3D 0;
> +       }
> +       bio_for_each_folio_all(fi, &rq->bio) {
> +               DBG_BUGON(folio_test_uptodate(fi.folio));
> +               erofs_onlinefolio_end(fi.folio, ret);
> +       }
> +       kfree(rq);
> +}
> +
> +static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
> +{
> +       struct iov_iter iter;
> +       int ret;
> +
> +       if (!rq)
> +               return;
> +       rq->iocb.ki_pos =3D rq->bio.bi_iter.bi_sector << 9;
> +       rq->iocb.ki_ioprio =3D get_current_ioprio();
> +       rq->iocb.ki_complete =3D erofs_fileio_ki_complete;
> +       rq->iocb.ki_flags =3D (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRE=
CT) ?
> +                               IOCB_DIRECT : 0;
Hi Gao,
Does this mean, direct IO by default if the backing file supports it
(technically filesystem where image/backing file reside)?

Thanks,
Sandeep.
> +       iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
> +                     rq->bio.bi_iter.bi_size);
> +       ret =3D vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
> +       if (ret !=3D -EIOCBQUEUED)
> +               erofs_fileio_ki_complete(&rq->iocb, ret);
> +}
> +
> +static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_de=
v *mdev)
> +{
> +       struct erofs_fileio_rq *rq =3D kzalloc(sizeof(*rq), GFP_KERNEL);
> +
> +       if (!rq)
> +               return NULL;
> +       bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
> +       rq->iocb.ki_filp =3D mdev->m_fp;
> +       return rq;
> +}
> +
> +static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio=
 *folio)
> +{
> +       struct inode *inode =3D folio_inode(folio);
> +       struct erofs_map_blocks *map =3D &io->map;
> +       unsigned int cur =3D 0, end =3D folio_size(folio), len, attached =
=3D 0;
> +       loff_t pos =3D folio_pos(folio), ofs;
> +       struct iov_iter iter;
> +       struct bio_vec bv;
> +       int err =3D 0;
> +
> +       erofs_onlinefolio_init(folio);
> +       while (cur < end) {
> +               if (!in_range(pos + cur, map->m_la, map->m_llen)) {
> +                       map->m_la =3D pos + cur;
> +                       map->m_llen =3D end - cur;
> +                       err =3D erofs_map_blocks(inode, map);
> +                       if (err)
> +                               break;
> +               }
> +
> +               ofs =3D folio_pos(folio) + cur - map->m_la;
> +               len =3D min_t(loff_t, map->m_llen - ofs, end - cur);
> +               if (map->m_flags & EROFS_MAP_META) {
> +                       struct erofs_buf buf =3D __EROFS_BUF_INITIALIZER;
> +                       void *src;
> +
> +                       src =3D erofs_read_metabuf(&buf, inode->i_sb,
> +                                                map->m_pa + ofs, EROFS_K=
MAP);
> +                       if (IS_ERR(src)) {
> +                               err =3D PTR_ERR(src);
> +                               break;
> +                       }
> +                       bvec_set_folio(&bv, folio, len, cur);
> +                       iov_iter_bvec(&iter, ITER_DEST, &bv, 1, len);
> +                       if (copy_to_iter(src, len, &iter) !=3D len) {
> +                               erofs_put_metabuf(&buf);
> +                               err =3D -EIO;
> +                               break;
> +                       }
> +                       erofs_put_metabuf(&buf);
> +               } else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
> +                       folio_zero_segment(folio, cur, cur + len);
> +               } else {
> +                       if (io->rq && (map->m_pa + ofs !=3D io->dev.m_pa =
||
> +                                      map->m_deviceid !=3D io->dev.m_dev=
iceid)) {
> +io_retry:
> +                               erofs_fileio_rq_submit(io->rq);
> +                               io->rq =3D NULL;
> +                       }
> +
> +                       if (!io->rq) {
> +                               io->dev =3D (struct erofs_map_dev) {
> +                                       .m_pa =3D io->map.m_pa + ofs,
> +                                       .m_deviceid =3D io->map.m_devicei=
d,
> +                               };
> +                               err =3D erofs_map_dev(inode->i_sb, &io->d=
ev);
> +                               if (err)
> +                                       break;
> +                               io->rq =3D erofs_fileio_rq_alloc(&io->dev=
);
> +                               if (!io->rq) {
> +                                       err =3D -ENOMEM;
> +                                       break;
> +                               }
> +                               io->rq->bio.bi_iter.bi_sector =3D io->dev=
.m_pa >> 9;
> +                               attached =3D 0;
> +                       }
> +                       if (!attached++)
> +                               erofs_onlinefolio_split(folio);
> +                       if (!bio_add_folio(&io->rq->bio, folio, len, cur)=
)
> +                               goto io_retry;
> +                       io->dev.m_pa +=3D len;
> +               }
> +               cur +=3D len;
> +       }
> +       erofs_onlinefolio_end(folio, err);
> +       return err;
> +}
> +
> +static int erofs_fileio_read_folio(struct file *file, struct folio *foli=
o)
> +{
> +       struct erofs_fileio io =3D {};
> +       int err;
> +
> +       trace_erofs_read_folio(folio, false);
> +       err =3D erofs_fileio_scan_folio(&io, folio);
> +       erofs_fileio_rq_submit(io.rq);
> +       return err;
> +}
> +
> +static void erofs_fileio_readahead(struct readahead_control *rac)
> +{
> +       struct inode *inode =3D rac->mapping->host;
> +       struct erofs_fileio io =3D {};
> +       struct folio *folio;
> +       int err;
> +
> +       trace_erofs_readpages(inode, readahead_index(rac),
> +                             readahead_count(rac), false);
> +       while ((folio =3D readahead_folio(rac))) {
> +               err =3D erofs_fileio_scan_folio(&io, folio);
> +               if (err && err !=3D -EINTR)
> +                       erofs_err(inode->i_sb, "readahead error at folio =
%lu @ nid %llu",
> +                                 folio->index, EROFS_I(inode)->nid);
> +       }
> +       erofs_fileio_rq_submit(io.rq);
> +}
> +
> +const struct address_space_operations erofs_fileio_aops =3D {
> +       .read_folio =3D erofs_fileio_read_folio,
> +       .readahead =3D erofs_fileio_readahead,
> +};
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d05b9e59f122..4a902e6e69a5 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -258,11 +258,14 @@ static int erofs_fill_inode(struct inode *inode)
>         }
>
>         mapping_set_large_folios(inode->i_mapping);
> -       if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> -               /* XXX: data I/Os will be implemented in the following pa=
tches */
> -               err =3D -EOPNOTSUPP;
> -       } else if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +       if (erofs_inode_is_data_compressed(vi->datalayout)) {
>  #ifdef CONFIG_EROFS_FS_ZIP
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +               if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> +                       err =3D -EOPNOTSUPP;
> +                       goto out_unlock;
> +               }
> +#endif
>                 DO_ONCE_LITE_IF(inode->i_blkbits !=3D PAGE_SHIFT,
>                           erofs_info, inode->i_sb,
>                           "EXPERIMENTAL EROFS subpage compressed block su=
pport in use. Use at your own risk!");
> @@ -271,10 +274,14 @@ static int erofs_fill_inode(struct inode *inode)
>                 err =3D -EOPNOTSUPP;
>  #endif
>         } else {
> -               inode->i_mapping->a_ops =3D &erofs_raw_access_aops;
> +               inode->i_mapping->a_ops =3D &erofs_aops;
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>                 if (erofs_is_fscache_mode(inode->i_sb))
>                         inode->i_mapping->a_ops =3D &erofs_fscache_access=
_aops;
> +#endif
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +               if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
> +                       inode->i_mapping->a_ops =3D &erofs_fileio_aops;
>  #endif
>         }
>  out_unlock:
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 9bf4fb1cfa09..9bc4dcfd06d7 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -372,6 +372,7 @@ struct erofs_map_dev {
>         struct erofs_fscache *m_fscache;
>         struct block_device *m_bdev;
>         struct dax_device *m_daxdev;
> +       struct file *m_fp;
>         u64 m_dax_part_off;
>
>         erofs_off_t m_pa;
> @@ -380,7 +381,8 @@ struct erofs_map_dev {
>
>  extern const struct super_operations erofs_sops;
>
> -extern const struct address_space_operations erofs_raw_access_aops;
> +extern const struct address_space_operations erofs_aops;
> +extern const struct address_space_operations erofs_fileio_aops;
>  extern const struct address_space_operations z_erofs_aops;
>  extern const struct address_space_operations erofs_fscache_access_aops;
>
> @@ -411,6 +413,9 @@ int erofs_map_dev(struct super_block *sb, struct erof=
s_map_dev *dev);
>  int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo=
,
>                  u64 start, u64 len);
>  int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
> +void erofs_onlinefolio_init(struct folio *folio);
> +void erofs_onlinefolio_split(struct folio *folio);
> +void erofs_onlinefolio_end(struct folio *folio, int err);
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>  int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>                   struct kstat *stat, u32 request_mask,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 424f656cd765..350612f32ac6 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -122,42 +122,6 @@ static bool erofs_folio_is_managed(struct erofs_sb_i=
nfo *sbi, struct folio *fo)
>         return fo->mapping =3D=3D MNGD_MAPPING(sbi);
>  }
>
> -/*
> - * bit 30: I/O error occurred on this folio
> - * bit 0 - 29: remaining parts to complete this folio
> - */
> -#define Z_EROFS_FOLIO_EIO                      (1 << 30)
> -
> -static void z_erofs_onlinefolio_init(struct folio *folio)
> -{
> -       union {
> -               atomic_t o;
> -               void *v;
> -       } u =3D { .o =3D ATOMIC_INIT(1) };
> -
> -       folio->private =3D u.v;   /* valid only if file-backed folio is l=
ocked */
> -}
> -
> -static void z_erofs_onlinefolio_split(struct folio *folio)
> -{
> -       atomic_inc((atomic_t *)&folio->private);
> -}
> -
> -static void z_erofs_onlinefolio_end(struct folio *folio, int err)
> -{
> -       int orig, v;
> -
> -       do {
> -               orig =3D atomic_read((atomic_t *)&folio->private);
> -               v =3D (orig - 1) | (err ? Z_EROFS_FOLIO_EIO : 0);
> -       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) !=
=3D orig);
> -
> -       if (v & ~Z_EROFS_FOLIO_EIO)
> -               return;
> -       folio->private =3D 0;
> -       folio_end_read(folio, !(v & Z_EROFS_FOLIO_EIO));
> -}
> -
>  #define Z_EROFS_ONSTACK_PAGES          32
>
>  /*
> @@ -965,7 +929,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompre=
ss_frontend *f,
>         int err =3D 0;
>
>         tight =3D (bs =3D=3D PAGE_SIZE);
> -       z_erofs_onlinefolio_init(folio);
> +       erofs_onlinefolio_init(folio);
>         do {
>                 if (offset + end - 1 < map->m_la ||
>                     offset + end - 1 >=3D map->m_la + map->m_llen) {
> @@ -1024,7 +988,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompr=
ess_frontend *f,
>                         if (err)
>                                 break;
>
> -                       z_erofs_onlinefolio_split(folio);
> +                       erofs_onlinefolio_split(folio);
>                         if (f->pcl->pageofs_out !=3D (map->m_la & ~PAGE_M=
ASK))
>                                 f->pcl->multibases =3D true;
>                         if (f->pcl->length < offset + end - map->m_la) {
> @@ -1044,7 +1008,7 @@ static int z_erofs_scan_folio(struct z_erofs_decomp=
ress_frontend *f,
>                         tight =3D (bs =3D=3D PAGE_SIZE);
>                 }
>         } while ((end =3D cur) > 0);
> -       z_erofs_onlinefolio_end(folio, err);
> +       erofs_onlinefolio_end(folio, err);
>         return err;
>  }
>
> @@ -1147,7 +1111,7 @@ static void z_erofs_fill_other_copies(struct z_erof=
s_decompress_backend *be,
>                         cur +=3D len;
>                 }
>                 kunmap_local(dst);
> -               z_erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
> +               erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
>                 list_del(p);
>                 kfree(bvi);
>         }
> @@ -1302,7 +1266,7 @@ static int z_erofs_decompress_pcluster(struct z_ero=
fs_decompress_backend *be,
>
>                 DBG_BUGON(z_erofs_page_is_invalidated(page));
>                 if (!z_erofs_is_shortlived_page(page)) {
> -                       z_erofs_onlinefolio_end(page_folio(page), err);
> +                       erofs_onlinefolio_end(page_folio(page), err);
>                         continue;
>                 }
>                 if (pcl->algorithmformat !=3D Z_EROFS_COMPRESSION_LZ4) {
> --
> 2.43.5
>
