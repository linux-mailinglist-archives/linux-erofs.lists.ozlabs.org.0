Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3B9481D3
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2024 20:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722883210;
	bh=xDWk9DvvhI44hQhXSYcPsHLXc+MiKNXsM8K+Nx7x/Nw=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QGK1IbGdeUrKQvZP5iiBX+GyU4rGIq4ajPRkDvbKvt7JkAX9fh+EiJx0JRu+k96sM
	 b1ra6MnsBAMmKqVJv3/H6DcOQU5eV9Oz1RwkVgWVUss3+zFMed1d3klbpVRVxgl1rN
	 B3o11Y1diPAYhCvco0VXyypMy1siZoBZhdqD2DM51yj0DQH/NnuNuEGM48XNnLpI8m
	 tSn/rZtZeukyT3QRxmzJhwJibA75q8AiXuSG22WEXIzS32PkJGDzIEetFLCGH0YmjF
	 cQGaifBIB4A+s2Da0lyYCazmEVkR0dBQgP7P3Nef2XFZTlzHECSFw3BCZ1ckzeU/DA
	 BR0lRYdnRHEPA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wd4xQ3hcNz3cbg
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 04:40:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=O82F1+5r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wd4xL69rPz3cBP
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 04:40:05 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso5924522f8f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 Aug 2024 11:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883202; x=1723488002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDWk9DvvhI44hQhXSYcPsHLXc+MiKNXsM8K+Nx7x/Nw=;
        b=RU3xZPSJkm72UNgzN6Axx1nKIy9NDI6h5znnYSjYVtd+WsDP//5YcV3vetAucuswnh
         IWJ5Tvm0JRtqOM3CMmjsEumH6gRgt8iSrItmkT98UCv2BMmWEvuZsv+z1apn0ew8brlh
         tdOpqWMRB6TLCc5f+RGC3UpzNVzL9R7J4vejcxX8qB+mybdWixA1VqgBjB2XvdPzJP1H
         8W/IdSBCsZWgZJjCrqqFqJVcQbNcdL2K4n4ZhwfjWdD8mr3Bq8N24ExkjtxTKH7HODav
         w1zEBHDhgHG9pF4038tyOGat3jEIKwocm/3C6mJ9IvKVuQQ6ZDo11sN6RJHiuA6GInQq
         Plww==
X-Gm-Message-State: AOJu0YyjIALAuadRQu/bZKdKA/bPp1R9bKzcfLGF55s9Fsz4eV9RHB/a
	/HwfqbH2peD/JwoYfrJUzlzM0jl41TheFfrMk1w2mv54tKnF8taEX31wIDbuEUnSoK90315L5GA
	slUBXjUkvoCbQi/7HIVP2a0O311HCEZv0yeDPFCRTo+LAxprYFPxJsc8=
X-Google-Smtp-Source: AGHT+IESeqbKexDsO+7mDiZrqy5yypXvk6G3erxLXLV40zV3ZfXX5F0kPSdP3l0lILm25F+JDOfwEvc7jjDNUA30tyk=
X-Received: by 2002:adf:fc8e:0:b0:367:8a3b:2098 with SMTP id
 ffacd0b85a97d-36bbc0cd4f4mr7500551f8f.3.1722883201883; Mon, 05 Aug 2024
 11:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240805032510.2637488-1-hongzhen@linux.alibaba.com>
In-Reply-To: <20240805032510.2637488-1-hongzhen@linux.alibaba.com>
Date: Mon, 5 Aug 2024 11:39:50 -0700
Message-ID: <CAB=BE-Q=wWXuai+pMgQMEBe0oODRNM7MVkzu5bZ2K60JmXZv2w@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix potential overflow issue
To: Hongzhen Luo <hongzhen@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 4, 2024 at 8:25=E2=80=AFPM Hongzhen Luo <hongzhen@linux.alibaba=
.com> wrote:
>
> Coverity-id: 502377
>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>  lib/kite_deflate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
> index a5ebd66..e52e382 100644
> --- a/lib/kite_deflate.c
> +++ b/lib/kite_deflate.c
> @@ -817,7 +817,8 @@ static const struct kite_matchfinder_cfg {
>  /* 9 */ {32, 258, 258, 4096, true},    /* maximum compression */
>  };
>
> -static int kite_mf_init(struct kite_matchfinder *mf, int wsiz, int level=
)
> +static int kite_mf_init(struct kite_matchfinder *mf, unsigned int wsiz,
> +                       int level)
>  {
>         const struct kite_matchfinder_cfg *cfg;
>
> --
> 2.43.5
>

Hi Hongzhen,
Can you please explain to me where the potential overflow is? Checkers
can be smart so easy for me to miss.
I see a below check in kitle_me_init()

    if (wsiz > kHistorySize32 || (1 << ilog2(wsiz)) !=3D wsiz)
          return -EINVAL;

So any larger value than kHistorySize32 which is (1U << 15) is already
rejected. So what overflow case is this int =3D> unsigned int type
conversion solving?

Thanks,
Sandeep.
