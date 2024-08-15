Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A13953225
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 16:02:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qcthr5/f;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wl6JP4qZlz2yhv
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 00:02:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qcthr5/f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com; envelope-from=wata2ki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wl6JF0WdDz2xnL
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 00:02:19 +1000 (AEST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-26b5173e861so586791fac.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723730536; x=1724335336; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YgxkL8ykWsJZSiXQJJC74fLjRraoVno3ZUnm+PhljUg=;
        b=Qcthr5/fb3An6W6ejJzkq6Rk0QXB6rQkVdAYTuJiQUVtakzNHPfAVzLkeXyrRVKTha
         5uJTp630eq6zDYXIxQm92HT6V0SrchY1+rsC1AFleFoHRtIMAM9Yk1Lc+nZSxktz8zkq
         Z88yzZ0kWoL+t36roxJpLMpW/PJ670wxkTq23zqhexxTI1UmmteXXZ2LCA4obgnia8BN
         iOZvfn8AqT+EHO01hQcivzHzMNGOZ1QLgda43eFTgPrnwg9d6VdLtpTjBFoIei8lRgD4
         CmRCJw/uvsmFTGkC+pgXIy4MLCR7cQbiAWeRbYhJtR/wTTsNvLLnzv/0mLFvR9Md2Hul
         L2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730536; x=1724335336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgxkL8ykWsJZSiXQJJC74fLjRraoVno3ZUnm+PhljUg=;
        b=DTHLa2Xvb6q2Tb+6vZyq/V+soTjN4cyUDmVSE/7vY6dHhgGO2/7TTvHUpo9ihHa24B
         suWIryifo83E00iOYHusDhPYqyOmm3vxWwc9La6+h3rlYMmHV8yO+JDE7+j7TuQtkHdD
         W6nQe6VT9t9TBPiaQYb8cbcv9quzsfN5gqUw/HjtbRTVAFT9UzxlZ1S/Zc9fQql1WwUx
         JiJIsuQ9/OZHXMfva4/yMRRRFjIF63sKGdJeH32L0q/DpeBzBpvQReS/N3ztgd2/ijMH
         HuY6wKerxgHlVIP8x36OGK5UdRF6H4aEHoai1BzJrE1K4uEXesTezzmLfuo4Gh5DtU3f
         vQhg==
X-Gm-Message-State: AOJu0YyGsgHNzYjxW2IHLsxchuBVQWh9dxl1a4pDVq0+196hDs0YdeMf
	MVjBch6L0vKi7AfTD0TSHMg7XIUL6jb+K2rqV5/L/oSwztqaCONYrIvYnFrTBi4JMGSDhu9nuXV
	l+STWkm5IfikQsvAFmrOmr/PU+zHK5Si/FWY=
X-Google-Smtp-Source: AGHT+IFQBaY5wwji068vlsb7PqB8goU+2E+raQws/QwCDmQSj1+0EnIg4RWn/EOjHib0K3rLZxVPk9qRkZpfAi9JLps=
X-Received: by 2002:a05:6871:814:b0:261:5ec:f79 with SMTP id
 586e51a60fabf-26fe5c15c4amr7559886fac.32.1723730536088; Thu, 15 Aug 2024
 07:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240814153256.18230-1-naoto.yamaguchi@aisin.co.jp>
 <20240814155353.19076-1-naoto.yamaguchi@aisin.co.jp> <96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com>
In-Reply-To: <96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com>
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Thu, 15 Aug 2024 23:02:05 +0900
Message-ID: <CABBJnRYcWVAMg04XsbFOb7zYZWmC17WDx4y_QEj3uVaaSPEG=Q@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: adjust volume label maximum length to the
 kernel implementation
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao.

> > ---
> >   mkfs/main.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index b7129eb..ff26c16 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -151,7 +151,7 @@ static void usage(int argc, char **argv)
> >       printf(
> >               " -C#                   specify the size of compress physical cluster in bytes\n"
> >               " -EX[,...]             X=extended options\n"
> > -             " -L volume-label       set the volume label (maximum 16)\n"
> > +             " -L volume-label       set the volume label (maximum 15 character)\n"
>
> 15 character might be ambiguous here, since there could be other encodings I guess?

I propose to...
Solution 1.
 -L volume-label       set the volume label (maximum 15 ASCII character)

Solution 2.
 -L volume-label       set the volume label (maximum 15 bytes)


Solution 3.  similar to tune2fs
-L volume-label       set the volume label
and
erofs_err("Warning: label too long, truncating.");
with truncating input string to 15 bytes.

Which is better?  Could you feedback?

Thanks.
Naoto Yamaguchi @ AGL community.
