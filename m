Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBED934301
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2024 22:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721247125;
	bh=bBRFPq02/1Hq6ldkmB3yGHjVaOEzt65Aq2iwYUwuE6Q=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=G6SpAZf449rKh94LEydQd3esHkMWbdsiJ2Gd9jmRTc+p6OpR0RqzkbqmXUNrcZQJs
	 UBxo+MscAAMuM5n6Do6S+XqGFkWUMBKejZLV79mNa5djZ5odYG711Lai3zUr/+eFw0
	 nvRk10InFlvduSz8muuVYfWKOUKRHlm+KVF+9zNScfj+u45oe63Sm1s8dsU0NRmRHT
	 9qw47z68nE2GzkQc8n95CmlHUt2+o3WWyjYfG7weO6XrTPlM1hatwLloP2+cKljfxH
	 KJ9y1vjcdXth9NmnCrEJZUK7D48lPapM8xvXjBdqrQsN8LE7iD86JzM6LThbHPOoqI
	 IpS0qLgODJAaQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPRtF25L9z3cWY
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 06:12:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=eMKKcu/i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPRt91Flkz3cFN
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 06:12:00 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-367a3d1a378so81446f8f.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2024 13:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721247112; x=1721851912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBRFPq02/1Hq6ldkmB3yGHjVaOEzt65Aq2iwYUwuE6Q=;
        b=muEPUiX/ltefzO8wa6nLNpn1LaVn4i+7qsD1h3RKiDO0/HQUW7WPsWgs+eOzqUWkcA
         6kIQZm9No0RrxyDdPTEy8AZb7OdE2vwdgzwuA4RuRKqu83+WGYamWCn9Xep1ygZQB5pj
         wWNl6i14vOOPViQghmCsjhNt2WSxAW3dWjhDuKzzieN9+52UvhLSAxpLwcS3+CbkVVRS
         UdZLT51T3WdDK92rbE4eLCFwZs9uP8ppLssDow1mPKo5a/wFeXV5sWQ7Pw9ZHwR8MREj
         jno3Idq5FFeNZKNIiOfqcqJiEwXPq6hPlQ4eFA/9CecW/K/ZzT7q48Jl9kd4A1ADAWDe
         qgPg==
X-Forwarded-Encrypted: i=1; AJvYcCWF9ZX6vTHSc9Wyz3B8aAJQFStif3FoWWTusZWIMaT3D7ra6lFCZd5SJktwE218T0TfTHmhhMy+1aqvUoTdpZa0yC8cIFLugy8Mj18t
X-Gm-Message-State: AOJu0Yx6GtsdI/Uz6IH5DOg9k03oZgB5KBDRg+wvZvydDHAghzFCA1O6
	tTLB1Jain31HfN4i9M+3JqmDEWuaM+v+lrZ/o6Ls7dJmbuExK9RrYJcYGOZagvEXoaakFVBZ7EV
	qaYICJYE4+WD16Zi334uBdU56vpLyN0HRDyNM
X-Google-Smtp-Source: AGHT+IHeghYkNK6hKS+C4EqCKnvBY/ORSUpRsPF/1ZClupIsL84TMa6jYpxdOzGuyk0i6KujR+MpD7AqjNLVu8Jis8A=
X-Received: by 2002:a5d:5987:0:b0:368:69d:5acf with SMTP id
 ffacd0b85a97d-3683173029bmr2586465f8f.42.1721247111315; Wed, 17 Jul 2024
 13:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <0a71474744854fcf967e99666e8eab38@xiaomi.com> <f630cbad-d653-44e7-8d31-3cbb90899401@linux.alibaba.com>
In-Reply-To: <f630cbad-d653-44e7-8d31-3cbb90899401@linux.alibaba.com>
Date: Wed, 17 Jul 2024 13:11:40 -0700
Message-ID: <CAB=BE-RKg1sV7BdCOQi-q90U-EdepBYVE2JXGurrbQXD+DLgZA@mail.gmail.com>
Subject: Re: Issue of erofs use zstd
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 15, 2024 at 12:43=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2024/7/15 15:33, =E8=82=96=E6=B7=BC=E6=A3=AE via Linux-erofs wrote:
> > Hi GaoXiang,
> >
> >
> > We just update the last erofs version, and want to test the zstd compre=
ss feature.
> >
> > But it will throw some error when using the mkfs.erofs making the new i=
mage, could you help to check? thanks!
>
> Please fix your own environment issue yourself, thanks.
>
> This mailing list is not used for discussing such out-of-topic issue.
>
> Thanks,
> Gao Xiang
This may be due to having multiple versions of zstd lib available in
your environment. Please check which one it is linking with and which
one it is loading.

Thanks,
Sandeep.
