Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA026898CA3
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 18:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712249590;
	bh=lukGodkgaYVYbTt/4JvbhA8hSgtItlJ9ey7hkl9DSZo=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oAj8DlH8DXNF2rWNhuaOBBDJtzbbPLKNASPZ5nGdBQAjlmccThW+WRaUOZqaFY9v/
	 ch1cCJxHy27Dt9+7rlStNzcBNPs54AQxpqIse7t2xxM1bgUygcFgSfLPCTuHNvDPf0
	 5WnSqdnvcxatLFjq0HThIdMVyBw8lgh2mcV3ttonO2kGPDXvpSi+GmNP3FmE4oUpNI
	 PLOdr1HaYEGWNAzCtcLI/RsqK000FHsvZz091/Gda3by21VG5XliEyTkuFCJnLIMHa
	 yqngv/SVjwV87tw7UdZaqkjkxRdrpxT249wDArgNK+JdKuo2fL+j6aSuz5c4OGxlBf
	 cf0tDah0htsmw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V9SNk58tWz3dhR
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Apr 2024 03:53:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=hSNB98Kv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V9SNb0MHJz3dTm
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Apr 2024 03:53:02 +1100 (AEDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so18327761fa.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 04 Apr 2024 09:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249575; x=1712854375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lukGodkgaYVYbTt/4JvbhA8hSgtItlJ9ey7hkl9DSZo=;
        b=CNO7KxaK1jCHHXZAWFrmBsktg50S+HCd6GDMzgLXxt85wThj35E/jZndmpFgUQm+Sf
         BryUXinATLRho2UOqudquyM/W+ZhIRz789Ojl2nKoHhuyUV4az2ivZzrpE5hpvZH+NDp
         fgApTQIwOGAE/My11gBeXhudQazi/oWyDTi7K3Vm34vtq2Hwp1qf+xQIHdBqZ/oCBJim
         iqGSoY+orpHcZUH8hHIVjFIwvIovrRBvDinNXP+TEskOJ9Jdkj2KN1LNBEdSM5OYmP5i
         HkPyHIK56h1m6xoHuU2jtPizBqRglqQBEMPpOGFA1G26mIRBJGYqHMraF2MXkDRoKpgb
         W8lQ==
X-Gm-Message-State: AOJu0YxIn7rjC/4quRXQ47Ts9ojNL9RGAjJyBaKAxdfnUzBevvAdfJJM
	6T5yPzJEDq0/bcV72zx7ECfv1rQmNwxnUnqKSDHSNvGZHpym5HPu5oILYYJlThVY/wF+Td3Rx8F
	4NKb1PWqkYzc+WqdMlzxGJjjq2r3y+Qw0edp/
X-Google-Smtp-Source: AGHT+IGsSlknYuQ/sgwXPYfofY7zsxqpGwQ/n0wn7ltFMEG0xdCZXPvVJtH5x4QFFYutgev99U91fiT3l85/+G3+sNY=
X-Received: by 2002:a2e:a371:0:b0:2d4:1fa4:9eb8 with SMTP id
 i17-20020a2ea371000000b002d41fa49eb8mr2349208ljn.40.1712249574412; Thu, 04
 Apr 2024 09:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240403235724.1919539-1-dhavale@google.com> <20240403235724.1919539-2-dhavale@google.com>
 <7681743f-ea33-49d4-9769-53895e5355dc@linux.alibaba.com>
In-Reply-To: <7681743f-ea33-49d4-9769-53895e5355dc@linux.alibaba.com>
Date: Thu, 4 Apr 2024 09:52:41 -0700
Message-ID: <CAB=BE-RJq=Zt7X7BHfMuWU_w-ssRBWWdrt4+zWQNN-JZTdv7hA@mail.gmail.com>
Subject: Re: [PATCH 1/1] erofs-utils: lib: treat data blocks filled with 0s as
 a hole
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

On Thu, Apr 4, 2024 at 7:00=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Sandeep,
>
> On 2024/4/4 07:57, Sandeep Dhavale wrote:
> > Add optimization to treat data blocks filled with 0s as a hole.
> > Even though diskspace savings are comparable to chunk based or dedupe,
> > having no block assigned saves us redundant disk IOs during read.
> >
> > This patch detects if the block is filled with zeros and marks
> > chunk as erofs_holechunk so there is no physical block assigned.
> >
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> > ---
> >   lib/blobchunk.c | 25 ++++++++++++++++++++++++-
> >   1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> > index 641e3d4..8535058 100644
> > --- a/lib/blobchunk.c
> > +++ b/lib/blobchunk.c
> > @@ -232,6 +232,21 @@ static void erofs_update_minextblks(struct erofs_s=
b_info *sbi,
> >               *minextblks =3D lb;
> >   }
> >
> > +static bool erofs_is_buf_zeros(void *buf, unsigned long len)
> > +{
> > +     int i, words;
> > +     const unsigned long *words_buf =3D buf;
> > +     words =3D len / sizeof(unsigned long);
> > +
> > +     DBG_BUGON(len % sizeof(unsigned long));
> > +
> > +     for (i =3D 0; i < words; i++) {
> > +             if (words_buf[i])
> > +                     return false;
> > +     }
> > +     return true;
> > +}
> > +
> >   int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
> >                                 erofs_off_t startoff)
> >   {
> > @@ -323,7 +338,15 @@ int erofs_blob_write_chunked_file(struct erofs_ino=
de *inode, int fd,
> >                       ret =3D -EIO;
> >                       goto err;
> >               }
> > -
> > +             if (len =3D=3D chunksize && erofs_is_buf_zeros(chunkdata,=
 len)) {
> > +                     /* if data is all zeros, treat this block as hole=
 */
> > +                     *(void **)idx++ =3D &erofs_holechunk;
> > +                     erofs_update_minextblks(sbi, interval_start, pos,
> > +                                             &minextblks);
> > +                     interval_start =3D pos + len;
> > +                     lastch =3D NULL;
> > +                     continue;
> > +             }
> >               chunk =3D erofs_blob_getchunk(sbi, chunkdata, len);
>
> Yes, it's a valid opt.  Yet, I guess we could calculate the unique hash v=
alue
> of all zeroes (with chunksize) in advance (e.g. when initialization).
>
> And compare the buf hash and the all-zeroed hash in erofs_blob_getchunk()=
, if
> they are the same, let's just compare all data then (or not compare since
> it's little chance to have such collision. In that case, erofs_blob_getch=
unk
> returns erofs_holechunk.
>
> Does it sound a good idea to you?
>
Hi Gao,
Sure, I will re-work this in v2.

Thanks,
Sandeep.

> Thanks,
> Gao Xiang
>
> >               if (IS_ERR(chunk)) {
> >                       ret =3D PTR_ERR(chunk);
