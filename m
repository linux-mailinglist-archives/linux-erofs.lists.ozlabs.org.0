Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F768B0111
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 07:33:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NH4SL0oN;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPSMH1fTCz3cDw
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 15:33:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NH4SL0oN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::b2f; helo=mail-yb1-xb2f.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPSMB45BGz30PD
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 15:33:25 +1000 (AEST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-dcc71031680so6038270276.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Apr 2024 22:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713936802; x=1714541602; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw7D54/P4PLzMQbjQXp5a2uvfA/dKn5oOByYxrVxu+U=;
        b=NH4SL0oNoH7sRXNulBSGj8dHakBrE44uqUlCs5qX7lR/Gdj3qKxEL0zUhBChih28d7
         9/ZRkcWKIalJPsqJfqDWYG0coXUYqC0Ue6Oi6Uggfhh1kY0pZDCeyLLVHgo2ZxGdrr2P
         AD6+IZ2QnKyHKVGP8oUr8EYQgeZ32GZMMh8CV/2Gep+7o3gcie39GK/lUSDkdVBsjmB5
         K/uDccfgjAUPFXtU0lktxuPj05YDS2DfkFNKQ5GWFXQuB1Swhavrwlyh4bYEjgSPWZtI
         yirqaBMlGYhU/dFmBxjLOd23TY3ydx7SB609jC6qtXDlLVxFO7K38HO+m35wn7L1Ph8A
         69Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713936802; x=1714541602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw7D54/P4PLzMQbjQXp5a2uvfA/dKn5oOByYxrVxu+U=;
        b=t82C3Ze79QQet57tnUWwC8OF4wma3fthaemRNpUnRgbUvcWw1HOpr/0o6JZw7zJQ5q
         odzd3My8k6KqvdeHT7y/u+XrZtmfC71QROPWpIFxEXI19PdDkYGREAjEQ+zx5Q8uFIEq
         1IJ8N2hJsdJStCoSppLGy9oGXfhxv0uCaqXadCuhT289KoaJvxMtIsIKaTMKoCDtmG3a
         Eyf77p5Rz5C7UB81zAGmXea5AQOwcuDqHxwRCJzm2nhFPQhIH7qvgbAO41PVQXB8CyYW
         PNqvfT8o0X8vOvwJkKZPqvZomGOpAFjZA9sp/rGUN9beK05tLAOUkYkAP06btFJIs4M5
         mGOA==
X-Gm-Message-State: AOJu0YxX1bKUzyznV2QbbBSmVBpVMJJHqVCOJH/RIe1SWjjS8h8dutP6
	/v9rcrLF5jbGLAB8dfa/3smtdCRTcEq4c272zmtJmsGAfXjGve+klCsxOb2gyKHmBvLM5CFztYp
	mRrcDkdeKJV5UgAFEtTxfFDnH2TyCkCn9VcQ8uI/ddgq0vhIzEGqlhw==
X-Google-Smtp-Source: AGHT+IEA6IzGb6uhWVcnitqdU/fDuDeGJbjleuWtt7YzS3LQ5RkYm0B2TFP6I3bcT7rFC9e/AmjkqtbfFHA5kHcm66U=
X-Received: by 2002:a25:b82:0:b0:de4:718c:4cea with SMTP id
 124-20020a250b82000000b00de4718c4ceamr1602783ybl.35.1713936802067; Tue, 23
 Apr 2024 22:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240424043413.90179-1-asai@sijam.com> <39f07091-6919-4fa6-86b8-cb04f3135fe6@linux.alibaba.com>
In-Reply-To: <39f07091-6919-4fa6-86b8-cb04f3135fe6@linux.alibaba.com>
From: Noboru Asai <asai@sijam.com>
Date: Wed, 24 Apr 2024 14:33:11 +0900
Message-ID: <CAFoAo-KTL+HqCQ2oDULorykd=Kv_yzixX4-9EAupPBbX92Wk9Q@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: add missing block counting
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

I think that erofs_balloc() and erofs_bh_baloon() function in
erofs_write_tail_end()
also alloc a tail block, Is it not true?

2024=E5=B9=B44=E6=9C=8824=E6=97=A5(=E6=B0=B4) 13:54 Gao Xiang <hsiangkao@li=
nux.alibaba.com>:
>
> Hi Noboru,
>
> On 2024/4/24 12:34, Noboru Asai wrote:
> > Add missing block counting when the data to be inlined is not inlined.
> >
> > Signed-off-by: Noboru Asai <asai@sijam.com>
>
>
> Thanks for catching this! Could we fixup this at
> erofs_prepare_tail_block()?
>
> since currently it the place to allocate a tail block for this.
>
> Thanks,
> Gao Xiang
>
> > ---
> >   lib/inode.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/inode.c b/lib/inode.c
> > index cf22bbe..727dcee 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -840,6 +840,7 @@ static int erofs_write_tail_end(struct erofs_inode =
*inode)
> >               inode->idata_size =3D 0;
> >               free(inode->idata);
> >               inode->idata =3D NULL;
> > +             inode->u.i_blocks +=3D 1;
> >
> >               erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(s=
bi, pos));
> >       }
