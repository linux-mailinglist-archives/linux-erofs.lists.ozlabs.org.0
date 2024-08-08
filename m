Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5394C3F7
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 19:55:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723139727;
	bh=UaC7DGgUJUA3z8l43hD6hFJjOkpVgE/4JjVTBWtAlfA=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=hbqxicoSIo9hfaLP8154gieqz9apIV6Y3dn3OXs0GNhkMEH7gaIhoapDCxsUAg7iW
	 U+zBSt29mB4MA+ITpsqr898QJh52Zijb08S3aOwnsrisENmjFX+tK43A3QBggfCLzV
	 6KKcpsmeyAIH9QavMf4BAzje/oezGpuJlpT64kRVodDht+sHwnmBjP762iDkmkTR3l
	 X/D4O0kVvlRQR+l8oApYO40eGjzMo8LsG95JcjAAcAYc1D7KtqGCPEJGPvDP0eRaCa
	 xRx0o8h3BXuJEwX4po58M1DfkEi7CZgkOAWprk6jkcnJw5sMIiduPBQvyJ+D9b3j7H
	 FKdcJsD5BwGrw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfvpR10KVz2y8h
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 03:55:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=yxzXM5t3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfvpL758Rz2xnH
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Aug 2024 03:55:22 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso9131245e9.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Aug 2024 10:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723139718; x=1723744518;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaC7DGgUJUA3z8l43hD6hFJjOkpVgE/4JjVTBWtAlfA=;
        b=gP+1YmgbSP/3Vlusv9fdl8Nwr/XBdMftOjfCeiSX/Rbl+hWm9DkdDLhiygYLgVoSbV
         huXfY+6n1XR3hchFBRXAwnxOySyqkgU4bNZtoX6aKkuAqbITXkz8V16woB7g+8jwxFwu
         sy1Gmon+J4v5cPMpE79Xfnkd1iW8FpvK+5m7GtHkIyF2lEBRsuypL7daMMvEPS4vEXuG
         dr4gSaIgIEnqHBcZIJa13yhBAv1KjQP6gA1zeHKi3y2sAd/kpObBwz0ReKdfejATmdS4
         5ZWeCcwgHuqdbv37p7wUEXj5DA57af2NBJ0hOj+hQxKvJEefO7SkcqQyTgO+KrewQQVY
         DZYg==
X-Forwarded-Encrypted: i=1; AJvYcCWM7FxqFDsJXNSXkg/YCYkpIOfIw1fijclRHWvtI7vDkuTAWkF3MAiJu5mDdW0fq1sKzGMIt0jQgXQvlw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvoCG6Jgo3iFjA7nKtUXW0HXAqzHSEYm+UBfieVIa6HJtlixxS
	YZAAtZaXYvh5OuQK4I4fIDYz27kihr6VXrvNnWBfnS8UdiwH7YwnFAKCkGG02bwz+AFGbJLdqVv
	xVkTbX9eyjCbc8bDcxTWLH8ZZxP/yiW3eWC9gSF23EBckhEqVr5i0
X-Google-Smtp-Source: AGHT+IExx6p0gc8ZNO852hFCr247SrWiOwXZ9IcZ4pHwRbH0VeTKlKX3C2ugUyBEvsD5UvaqLJ3AOnjuBNxniU/pYkE=
X-Received: by 2002:a05:6000:2a6:b0:368:12ef:92d0 with SMTP id
 ffacd0b85a97d-36d2758163cmr2729516f8f.51.1723139718014; Thu, 08 Aug 2024
 10:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240808160343.2544426-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-T-d-vjad6Q1kLeQbSr5pcSQCfX15vKxYvQJOqPncG32A@mail.gmail.com> <ZrUEEtnKg4N8DeDc@debian>
In-Reply-To: <ZrUEEtnKg4N8DeDc@debian>
Date: Thu, 8 Aug 2024 10:55:06 -0700
Message-ID: <CAB=BE-Tefs970WhMnEQ4ynrM04rY4o3caoj5vBSCXVzJXpjQCg@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix global-buffer-overflow due to
 invalid device
To: Sandeep Dhavale <dhavale@google.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	linux-erofs@lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 8, 2024 at 10:45=E2=80=AFAM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Sandeep,
>
> On Thu, Aug 08, 2024 at 10:15:31AM -0700, Sandeep Dhavale via Linux-erofs=
 wrote:
> > On Thu, Aug 8, 2024 at 9:04=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> > >
> > > Fuzzer generates an image with crafted chunks of some invalid device.
> > > Also refine the printed message of EOD.
> > >
> > > Closes: https://github.com/erofs/erofsnightly/actions/runs/1017257626=
9/job/28135408276
> > > Closes: https://github.com/erofs/erofs-utils/issues/11
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > >  lib/io.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/io.c b/lib/io.c
> > > index 6bfae69..fbeff03 100644
> > > --- a/lib/io.c
> > > +++ b/lib/io.c
> > > @@ -342,6 +342,10 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi=
, int device_id,
> > >         ssize_t read;
> > >
> > >         if (device_id) {
> > > +               if (device_id >=3D sbi->nblobs) {
> > > +                       erofs_err("invalid device id %u", device_id);
> > > +                       return -EIO;
> > > +               }
> > >                 read =3D erofs_io_pread(&((struct erofs_vfile) {
> > >                                 .fd =3D sbi->blobfd[device_id - 1],
> > >                         }), buf, offset, len);
> > > @@ -352,7 +356,8 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi,=
 int device_id,
> > >         if (read < 0)
> > >                 return read;
> > >         if (read < len) {
> > > -               erofs_info("reach EOF of device, pading with zeroes")=
;
> > > +               erofs_info("reach EOF of device @ %llu, pading with z=
eroes",
> > > +                          offset | 0ULL);
> > nit: typo carried over from previous log. s/pading/padding
>
> Thanks for catching this!
>
> >
> > >                 memset(buf + read, 0, len - read);
> > >         }
> > >         return 0;
> > > --
> > > 2.43.5
> > >
> >
> > Reviewed-by: Sandeep Dhavale <dhavale@google.com>
>
> I'm about to releasing erofs-utils 1.8 today (it already takes much
> long time than expected, I don't want to hold it anymore), so the
> code is freezed for now.
>
Hi Gao,
No problem. Just caught my eyes, it's only cosmetic anyways.

> I will tag v1.8 soon, and write an announcement mail hours later.
>
Thank you!

Regards,
Sandeep.

> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Sandeep.
