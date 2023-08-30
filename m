Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547F78E368
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 01:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1693438876;
	bh=DNqGus77ff0e8GiY82CWTp2FtU7nPf4D2RS5HlmchSw=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NFt5q22md25vZSxRvAAKFdRjlSkt7rE3d0QlpRp8e1z3xiegVafF/twXE6N1jqux+
	 Z1aXZCXPivfZLgYsXTKuAIV63pp0W5F+jvV/AOGrtvOF0njNmTVn+r/Ho4oPYUD3+P
	 zHCOEf+v1PE98mdug3Ds2szNsvzhgCFByO1gUTdfDiPsCWL2d2SKfJspEDfJ8AzdxY
	 KrDcNX22OBB6oa+paQK7sb2bu1WSygkFJobaNicuCThvM0lK2bng0Fp/wTxEkPMREw
	 6x4IzfkLM6u8XBLth+9heuelh/SGVqJ9jBc4KstpAqChxtr8sLo2XLYqgoYCBY8Vme
	 P+vc6cnIKUAXA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RbgmD5jbFz2yNX
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 09:41:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=RuS9I2Lv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rbgm61nGdz2yDM
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 09:41:09 +1000 (AEST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so121264241.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 16:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693438866; x=1694043666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNqGus77ff0e8GiY82CWTp2FtU7nPf4D2RS5HlmchSw=;
        b=gAYMK18OPUpqNNxxUs22En8EsRdCtvioatym4y9vcvrjHYTtdEM5h5znROpYDgvpR4
         SiUZlTKg2+9G8yVJTWAumjA/2vIYQhijjctHvg5Dc44zbssQr3S4bdE1HmWsnkyErC+s
         RgL/4pAXYnWjsAUtwJfoazAdSBdiGwaDG8am3NFxHiX0irKetEc/rORVN5XFgXGEyub8
         /DkkBqNUPR8f3BrUvVsA5aB/zOaK450DSIqGwfmR/V8OHJvkRs9Af6zL8TKQstZYaZbq
         EtDgxsEizkMft8Q2gdXHgPuHGMA3PaY3elB7+RjYtumQlHSXLukdupfY7TuzMAhTSb/2
         /8oQ==
X-Gm-Message-State: AOJu0Ywkt0dVN+1J9DryK8nJErMnLfWeslw+jiTi93s8IZAIIRDUWAoe
	x+6cbPmpAC957qVpibVzTK0sKTtus5qV9v5FrHReXQ==
X-Google-Smtp-Source: AGHT+IHtRT+wF21qKjw2THKP9Pq7+L2n6MxmRa/uQF50ZcLFkV3ZLwlIDDE5HDVGaGiUT7SvY9rCOdgbhdND4Bq1XKI=
X-Received: by 2002:a67:f2d2:0:b0:44d:506c:b9c6 with SMTP id
 a18-20020a67f2d2000000b0044d506cb9c6mr630252vsn.2.1693438866012; Wed, 30 Aug
 2023 16:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231606.3783734-1-dhavale@google.com> <2d3a4abe-c23c-795e-2042-0033a474bd95@linux.alibaba.com>
In-Reply-To: <2d3a4abe-c23c-795e-2042-0033a474bd95@linux.alibaba.com>
Date: Wed, 30 Aug 2023 16:40:55 -0700
Message-ID: <CAB=BE-RWnzxzumzsPY0sOV_O4sUpyNmAK9+=nynS9ShX+ZFvRQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] erofs-utils: Relax the hardchecks on the blocksize
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 30, 2023 at 4:34=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Sandeep,
>
> On 2023/8/31 07:16, Sandeep Dhavale wrote:
> > As erofs-utils supports different block sizes upto
> > EROFS_MAX_BLOCK_SIZE, relax the checks so same tools
> > can be used to create images for platforms where
> > page size can be greater than 4096.
> >
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> > ---
> >   lib/namei.c | 2 --
> >   mkfs/main.c | 9 +++++----
> >   2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/namei.c b/lib/namei.c
> > index 2bb1d4c..45dbcd3 100644
> > --- a/lib/namei.c
> > +++ b/lib/namei.c
> > @@ -144,8 +144,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *=
vi)
> >               vi->u.chunkbits =3D sbi->blkszbits +
> >                       (vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_M=
ASK);
> >       } else if (erofs_inode_is_data_compressed(vi->datalayout)) {
> > -             if (erofs_blksiz(vi->sbi) !=3D EROFS_MAX_BLOCK_SIZE)
> > -                     return -EOPNOTSUPP;
> >               return z_erofs_fill_inode(vi);
> >       }
> >       return 0;
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index c03a7a8..37bf658 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -550,10 +550,11 @@ static int mkfs_parse_options_cfg(int argc, char =
*argv[])
> >               cfg.c_dbg_lvl =3D EROFS_ERR;
> >               cfg.c_showprogress =3D false;
> >       }
> > -     if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) !=3D EROFS_MAX_BLOCK=
_SIZE) {
> > -             erofs_err("compression is unsupported for now with block =
size %u",
> > -                       erofs_blksiz(&sbi));
> > -             return -EINVAL;
> > +     if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) !=3D getpagesize()) =
{
> > +             erofs_warn("subpage blocksize with compression is not yet=
 "
> > +                     "supported. Compressed image will only work with =
"
> > +                     "arch pagesize =3D blocksize =3D %u bytes",
> > +                     erofs_blksiz(&sbi));
> >       }
>
> Thanks for the patches.
>
> I'm fine to relax  EROFS_MAX_BLOCK_SIZE check, yet could we
> add a check as erofs_blksiz <=3D EROFS_MAX_BLOCK_SIZE somewhere?
>
> Otherwise, we could suffer from stack overflow
> (if EROFS_MAX_BLOCK_SIZE is outdated or somewhat small...)
>
Hi Gao,
There is already a check in place for -b option to validate the block
size passed is within range [512..EROFS_MAX_BLOCK_SIZE] in function
mkfs_parse_options_cfg()

Please correct me if I misunderstood your comment.

Thanks,
Sandeep.
> Thanks,
> Gao Xiang
