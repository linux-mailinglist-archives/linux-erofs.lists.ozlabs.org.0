Return-Path: <linux-erofs+bounces-157-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB52A7F3DD
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 06:59:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWv4n1ppfz2ygY;
	Tue,  8 Apr 2025 14:59:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744088361;
	cv=none; b=f8EEigzlYYIwMg8eYn1K23BTKW3XKUOqMnyeFx1I0QM0B5SId+FXjojVnMcirH4MlKc4SKeoUijjghSkwiXe1kPED2OLXSMfs9FmKlbXtsWNd8PD0FZyKRpVjF42iv6AY5WcuEeWUpD8R3No8L6W+9YtQhsriCJnLI1L7/9rIvO3l/QrO31X1HZSqTyEcC60H7HJGKHCGiCLXa7XE0rmyH6bqKrY9ifeZKegtovbiBzgRnNpuInpqJId8ZjZB1XBrSCwokjMBF21VMVnRy445D8Ox4WAIrqIBTfsGKI2thsXZRbSrd6tYeE1KcwIUXSSD6dKjWrfVR6E2VV1pcxFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744088361; c=relaxed/relaxed;
	bh=lPyKFL6EYtrBQlINHjnofiBgH1A/3A3RrizKk2o/+FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwMT4FnjR1QKNmdvlPOtYGGjhsxp8UtXLl+Nlun4FsUeaF7wOJQA5dnnYImYAbEv+73kTsGsQxMLISixLVbajrTqbhj2KWjAVazHi2Tgpz/4J4Wv47O+l2Bdt9faKStjOjoGKmiR+mfDbsFBNm3lKDa5fbt8QdC7fkGQGFjxt98u5Wv85+X+3ON9Bde220eLh0smiRl0hTpO2EwfcdiuKYQ5VUHLizV56l25kCtjw+S78+xKhOXwkqc1EiQwu65RqrVqE78tI48IZ3G010EIKpebd7Ve703OsrIOkSaLpYO03NH8ZC8PqvVYB7TpzQDyGuyeeaIX9KV1y9uDKfJK1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=WGFlEwUL; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=WGFlEwUL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWv4l2Pnzz2yft
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 14:59:18 +1000 (AEST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so627574866b.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Apr 2025 21:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744088355; x=1744693155; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPyKFL6EYtrBQlINHjnofiBgH1A/3A3RrizKk2o/+FQ=;
        b=WGFlEwULbmf2tAZUKIYm/I0V1ZYtChlz7/F5np3PGga2y1feCyAeqB4jPXgskNfxSW
         1KiXLP2yFnASZM81ygb/KF1gFbkn48hhJIKzD7V4oAJ62ooDEs/OtnNSb0hG2+ktRGJa
         71KFuPaH5crtFrCzoUPO6ONflBFmnGN3qdyJV0IrNa1CGKGUMvihpuicSXN+6HDkaQRE
         moO/Rm8pdK3ejz8L5AjDBfqL39IV31YBzDKtXpQ/oGPxt7EFdh+Nf2k6m8NidTqU/95V
         0juPeZQZxLVVgmVYTX+KgW9g22aoDOK2GpOREQCzBUVXOGv11nZppChkvgYQhP2Tw04I
         goeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744088355; x=1744693155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPyKFL6EYtrBQlINHjnofiBgH1A/3A3RrizKk2o/+FQ=;
        b=TBEBdG3sTsW9F88dLIQP4kbmEEzH5S6r3Kzp9OulUgx6nSPEsL9grYAL93cUtyboIl
         m3OZD8Z9tqCMQ9amw6laQoRgKBbEtaAhT7RMVMswa8bab1LebJ3LeokpXnrCTfzmaVDv
         CwGHdYBBA4XGFC78qs01VLkphPwyXoG28E5m1kvdWVaJqYRbFWXQexy0lHDem5zijcXk
         CnQY8Xz/QtSMEL8jzk3cMcF7Lwqwaqk8sRvJ0q3TODjXFVPz5NHMuMnuTG/b2FRkZcT3
         d/T2fcVrVY8OU/vGF4kAUmnA0KQvoAUpR7HPzIRpKbtZq8vWYnrHopa0+MPVwGXHW6NM
         NPlg==
X-Gm-Message-State: AOJu0YwaCJ/x+0J93qN0QwuSp0QE4M9GZPkNzNVtnswUo88ZwKvrWSgk
	0i972RCvORTLVnMOIYQUPA4hZz9Kwdhb0Q3OS4tVrwrfBjqTYc3b7VrT2C2kBnitjnyvv3kMcrk
	xxHYoPnfQBQ+PHeYv0gctptb3OsVfBKehgJMG
X-Gm-Gg: ASbGncs0wCbmu7rRIg9LGp/0TIvUKDp3vi7PGXwBhKq+POIgcFPsLMZdkN6J4U/huv+
	Dyy0WA36qHVfaVn5uqgigzwvkojE61jMaqnXTcKR4joDtfqnV4Miay/pJgJDQ38HZKYjBtPSBsA
	l79k//LiKDDwQnfg+ousC+JQ==
X-Google-Smtp-Source: AGHT+IHMBU+wq6W4T0NSttj+q7k5OMgLNQuKpd0k4v5A7VJLj6wPKTL5/A69Xh6L5iIW/4Jk2sxylEsG5cY8WRJ7HAs=
X-Received: by 2002:a17:907:3f24:b0:ac7:7f14:f31b with SMTP id
 a640c23a62f3a-ac7d1824971mr1478492866b.3.1744088355421; Mon, 07 Apr 2025
 21:59:15 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <20250402202728.2157627-1-dhavale@google.com> <CAB=BE-TzPKSsHo_nvMuGkB_4JbbP8OZ81ce=76y-28nAeZiniQ@mail.gmail.com>
 <da085862-1c82-4b3e-82ea-b54e2432d96d@linux.alibaba.com>
In-Reply-To: <da085862-1c82-4b3e-82ea-b54e2432d96d@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 7 Apr 2025 21:59:03 -0700
X-Gm-Features: ATxdqUH2xMaLI3V97urZLNZW_D7772R4FJJb9-wv2H5MVDeiqjePJE35yusKzi0
Message-ID: <CAB=BE-T7s7zgExm+A1zqbUFE3SOdB_YzJZgsp4sYBBt2V_EA5Q@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Apr 7, 2025 at 8:07=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Sandeep,
>
Hi Gao,
> On 2025/4/8 10:53, Sandeep Dhavale wrote:
> > Hi,
> > Gentle ping for review in case this slipped through the list.
>
> I'm working on internal stuffs (unrelated to erofs,
> currently I have to handle erofs stuffs totally in my
> spare time), also does it really need to be resolved now?
>
I totally understand.

> It's not like a bugfix, if it's not urgent it will be
> landed upstream in the next merge window.
>
Yes, the next merge window is fine. I was just making sure that I
collect feedback in case you think this needs any more refinements.

Thanks,
Sandeep.

> Thanks,
> Gao Xiang
> >
> > Thanks,
> > Sandeep.
>

