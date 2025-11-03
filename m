Return-Path: <linux-erofs+bounces-1328-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BDFC2C0E3
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 14:24:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0XPJ2fLWz2yrm;
	Tue,  4 Nov 2025 00:24:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762176276;
	cv=none; b=JZrYv3cTdhGRM6eLUrDh3/no4QCpWaxeV9MRQV3Nu2zD9/iqHJZ6tI5DORdbr0aAoDiQA4+kXpeC9Cm7vbxBrxTI5H1RnGSs8aIPXS4kpFb/r+Lu9I7dq8EPUaoFF28xU9/WZ5z5ZqQw7iZ5SIQlwKsJnLLTBosx+bmEkHsCcJJd/hlaN4ZpgzaFC5aetnPVianmjlN1gDksmxhI3tq2AiaIWue9DZ8WrQu+Ufql6Tr7oe7JhhY1BEb5ocUgQrJX7LREr1ziIRzN9IsSwavKBUI3TTwjTAyiUsfymNujsGtbkJd8iZTQT6UFhcPIzRTWU+KlMolitYUoKqXeVkKN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762176276; c=relaxed/relaxed;
	bh=0S6+1dUVKvqII667r+XW9/GENl1vb5Sqoomw0mlu3RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2HWYmLNff1zOuOlvfUG0KXDCz6wxqEhljCSAFK9HnetKMjwl9s9lgNW08iMK0HRI6h+pGQEUpzZ9fq+5ag8bPlinlZGhk19dAPKY2S52O/V18bhoQmh/oQkCQ2vYzKQzoHtzUYAz3MjnzkFnWcdCAeh6K16AblDKSH6EtS7IQynNtc1uQEHOYKwiHfvxs1E98Wwc+vY4cj18gY2j48w25TJ+C3i9tBYx/U2wOuVAuCgMraWa1VW0Ii0q+a9LS248Od6l4O02J3DQmOpCmLW+xsEOckMYjPIoDOGB3w3KKEvNFhgbPJt3kON+Lb7lb1jEtsYwrfPHzCBZXi/HrOKFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GbqitScH; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GbqitScH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0XPG5J4Xz2xS9
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 00:24:33 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b7155207964so121197366b.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 03 Nov 2025 05:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176265; x=1762781065; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S6+1dUVKvqII667r+XW9/GENl1vb5Sqoomw0mlu3RI=;
        b=GbqitScHxILZJ1gvpebqnacYNTl4EcU07xx17lxqTZ6zc1DiqtIRaojNAnlJed9D/E
         q/LNJuSoQHbJ6yzqinTM415mfIwrr4B3bgeoS5I5gfRBGC7vbVpnn+ewRHljUL6p0QUS
         0vMGo5VlxhCYranEIKrwOjMxDZhLTKseS6Wql1lm/Zvrg8wbpWEeDtz/1d2qP3uj0KnI
         S+/hcYPpYwWpVmWQLaGgBnL10qMmmraR09UNAmChWafcIWzw6hzgP+vhREzsdikpfvEc
         6Y0G66GT76xDaV4nU/AAPj3a00PfCyO8ruAbNMoww+ym0PdeCfSUH/6AE6tCBGUgIFG/
         NoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176265; x=1762781065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S6+1dUVKvqII667r+XW9/GENl1vb5Sqoomw0mlu3RI=;
        b=BCjCZcb4ppDtvo0Jl+s0irA7aEYmTfnFCno2jgfI6iBoUbMkjf0s5l0vk3tfar1Ttk
         vWOetXUFaykfrGx5Gh3Qt5l/ZNOGf6U39/K7DD6BDoZkhzf3EUuq9hwfMfAZKtzzroiV
         NmjTpvvp9z9WvAQS+PZ1vkz+k02SzypfxJezAvrPOiAbiPAyq11rk6UDtiMXyO2Bn7u0
         dR+cYyD8qTG+yBAZycMefddIwCw+sgdEdo1veWYTg97bBmAwfjws9kHJDIacwH2b7iyH
         zEYW8J7XF4CRqDNR4NNEz8M066bd9qIqTN/wWQu9A9mnRyLzd8iMY56MLWMlVykxZBV1
         ouPg==
X-Forwarded-Encrypted: i=1; AJvYcCUz3SDh9em1h9kbtKHyuJbiGqkCkrsr3HBaMInOAzdHSn3WXPR0NyFSdqzcakhpzaAm/E6M6fOSBez1lg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxrgrLOhZjStmRfxGSwPbtt6jfaIg5aioKgPg5z+Bop31IVWzul
	jIJeUqQgV3fOwr8AczKghRTN+vMgJ8MnTt9ubHwH+JapVLRv5xCojea4LnD1dhZqSyNrdDtc2G9
	WDl9gVEfwExjNUoSARHcVoOfwcBQsufQ=
X-Gm-Gg: ASbGncv5fwVsgI8fQ28JTKGV+P5Jl1wLch5/aVoGq+JBPvHxDBJsHAmuuwYKFP93t4z
	R/iPPHR0PeTIpFljAEvJWSnqzDlhieJJoEbxENYkapbwaWkQJJj+NuYYYFfpPA61mbB6PgWhBuo
	WWpv5QTTpG8RsQ1k2k7p9a451u1F2/918SPgjFMYCiEZLu1g1uPsMsIaLAPrI+b49dm0xOe/fJK
	Y9GaNcniz0EoHNllWoZmMLiubhVv0S0qB2Wx1lImD2suuj+kTy8z7UGv9HdYysN2qbMTpdMT1I7
	l1I8+np29jf23HJq3wDfbPCtaUYkNw==
X-Google-Smtp-Source: AGHT+IELl7DuDv5uo3bD6NZ9q582bvS2bDMma/TtRpWZCxPhIVAv9e4H0npG+fdCye/re4SlhiT2Qy0S3M2gjGw90Ag=
X-Received: by 2002:a17:907:ea7:b0:b6d:2d0b:1ec2 with SMTP id
 a640c23a62f3a-b70708315e8mr1272156366b.54.1762176265161; Mon, 03 Nov 2025
 05:24:25 -0800 (PST)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-4-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-4-a3e156839e7f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Nov 2025 14:24:13 +0100
X-Gm-Features: AWmQ_blW2akq-ipD0fIUUOxTn8zmugUgDmTC0C57BdhrsmFigJmfJvym14MPro0
Message-ID: <CAOQ4uxhW2FiVe6XjQDT_aXhzJDyT5yuna9CVaWOLyzU1J99hFg@mail.gmail.com>
Subject: Re: [PATCH 04/16] backing-file: use credential guards for writes
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Nov 3, 2025 at 12:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Use credential guards for scoped credential override with automatic
> restoration on scope exit.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/backing-file.c | 74 +++++++++++++++++++++++++++++--------------------=
------
>  1 file changed, 39 insertions(+), 35 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 4cb7276e7ead..9bea737d5bef 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -210,11 +210,47 @@ ssize_t backing_file_read_iter(struct file *file, s=
truct iov_iter *iter,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_read_iter);
>
> +static int do_backing_file_write_iter(struct file *file, struct iov_iter=
 *iter,
> +                                     struct kiocb *iocb, int flags,
> +                                     void (*end_write)(struct kiocb *, s=
size_t))
> +{
> +       struct backing_aio *aio;
> +       int ret;
> +
> +       if (is_sync_kiocb(iocb)) {
> +               rwf_t rwf =3D iocb_to_rw_flags(flags);
> +
> +               ret =3D vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
> +               if (end_write)
> +                       end_write(iocb, ret);
> +               return ret;
> +       }
> +
> +       ret =3D backing_aio_init_wq(iocb);
> +       if (ret)
> +               return ret;
> +
> +       aio =3D kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
> +       if (!aio)
> +               return -ENOMEM;
> +
> +       aio->orig_iocb =3D iocb;
> +       aio->end_write =3D end_write;
> +       kiocb_clone(&aio->iocb, iocb, get_file(file));
> +       aio->iocb.ki_flags =3D flags;
> +       aio->iocb.ki_complete =3D backing_aio_queue_completion;
> +       refcount_set(&aio->ref, 2);
> +       ret =3D vfs_iocb_iter_write(file, &aio->iocb, iter);
> +       backing_aio_put(aio);
> +       if (ret !=3D -EIOCBQUEUED)
> +               backing_aio_cleanup(aio, ret);
> +       return ret;
> +}
> +
>  ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter=
,
>                                 struct kiocb *iocb, int flags,
>                                 struct backing_file_ctx *ctx)
>  {
> -       const struct cred *old_cred;
>         ssize_t ret;
>
>         if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
> @@ -237,40 +273,8 @@ ssize_t backing_file_write_iter(struct file *file, s=
truct iov_iter *iter,
>          */
>         flags &=3D ~IOCB_DIO_CALLER_COMP;
>
> -       old_cred =3D override_creds(ctx->cred);
> -       if (is_sync_kiocb(iocb)) {
> -               rwf_t rwf =3D iocb_to_rw_flags(flags);
> -
> -               ret =3D vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
> -               if (ctx->end_write)
> -                       ctx->end_write(iocb, ret);
> -       } else {
> -               struct backing_aio *aio;
> -
> -               ret =3D backing_aio_init_wq(iocb);
> -               if (ret)
> -                       goto out;
> -
> -               ret =3D -ENOMEM;
> -               aio =3D kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL)=
;
> -               if (!aio)
> -                       goto out;
> -
> -               aio->orig_iocb =3D iocb;
> -               aio->end_write =3D ctx->end_write;
> -               kiocb_clone(&aio->iocb, iocb, get_file(file));
> -               aio->iocb.ki_flags =3D flags;
> -               aio->iocb.ki_complete =3D backing_aio_queue_completion;
> -               refcount_set(&aio->ref, 2);
> -               ret =3D vfs_iocb_iter_write(file, &aio->iocb, iter);
> -               backing_aio_put(aio);
> -               if (ret !=3D -EIOCBQUEUED)
> -                       backing_aio_cleanup(aio, ret);
> -       }
> -out:
> -       revert_creds(old_cred);
> -
> -       return ret;
> +       with_creds(ctx->cred);
> +       return do_backing_file_write_iter(file, iter, iocb, flags, ctx->e=
nd_write);
>  }

Pointing out the obvious that do_backing_file_write_iter() feels
unnecessary here.

But I am fine with keeping it for symmetry with
do_backing_file_read_iter() and in case we will want to call the sync
end_write() callback outside of creds override context as we do in the
read case.

Thanks,
Amir.

