Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D598A39F2
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 03:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712970054;
	bh=N4CTIGQ28E/yf0F23O7iJiItkGi84azQ3FrllLcjqRs=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UlcWCBdPdjDktciMwcdzduHQh6p+CW3RCOmO0x6qPE7rhvIjk8ebTZ8k1dsmM+HmO
	 4CTAkeV1PywyjAldiL33Yg4R+NveRbZJhhejG7I8tlvgF+4FplThInaxn9zAwStkZR
	 eDJF/cntdIt+jY1LNxAQXKjEzguegKNeTIWBrLxqOHYRhoL8nFbjOqDy8djh5nH3Cd
	 cd5pX5/SUtzJzNhyIQdD/7Q4b8ZkWVfupec5oo5LMXJnLd9kHnpaCPHWHMwxVYSiih
	 eitmw5ns+tLAMdUg0bnpCovF+FCsqT/YdcQirH3VrH5tpER1AEjhm+MDvzJCfZyXHI
	 CvB2MOzsIJHpg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VGZqp2lwWz3dgN
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 11:00:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=lTzYAHux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VGZql2Jrbz3cGc
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Apr 2024 11:00:51 +1000 (AEST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-346406a5fb9so1016033f8f.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 12 Apr 2024 18:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712970047; x=1713574847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4CTIGQ28E/yf0F23O7iJiItkGi84azQ3FrllLcjqRs=;
        b=EhazPFKiIFJcc456lgMdsETZu9EIEzZ65q4l8QlgaAKxLMJ5XJdUa9bl3pUHyLI5tK
         8filZ00Yk8YeN5G1oPVdd3qW7F2lQuaACo/t3TQupCcJRwvY0vFYNj4Ik18pFspLKjCQ
         +eCuZ74zCgq6PUS/GemBRhtdqogG8bHe3Nxl4RhIxc8B0xhvkUV9TwT0YflwdTFCrArd
         5P08VpkwrO6+H9GbFu2O/u8qZPnq133K+VoxfLY8l5R98WyaN3se5z1wZraFAzdpXuJl
         /7+GqaK39jMqYlRIYCSBA8Nifb/rduzxDQzWyWkVweIY5trDZC91bbvJuot9oy2rar09
         DcQA==
X-Gm-Message-State: AOJu0YxndhYWiilt+iIu19RcDIudYBKD/r9B8QStPqyCmoF/E+5DLTy3
	mFZrB/xFKdHNGANRKUpSfWCklnri2gK6FlCYWvG6qS7Sfg6hGWG66/z2pOtSqVIGx2exH+ECc2i
	mJnpdmiC2pJ8P/6VUgQ5A9dVuLx3+zNa+vl48
X-Google-Smtp-Source: AGHT+IHLOT62PZRVt1Dee++jHN5rdYhbAikrSa7NIxrzqKd8Wak5g5noKVBfcv/+0BxaFX7zI06jpO67223LedUO08A=
X-Received: by 2002:a05:6000:14e:b0:343:c3b0:67ca with SMTP id
 r14-20020a056000014e00b00343c3b067camr2714040wrx.6.1712970047119; Fri, 12 Apr
 2024 18:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240412225107.1240188-1-dhavale@google.com> <2f1c9a66-7fe2-4df3-8025-4f8075bc06a1@linux.alibaba.com>
In-Reply-To: <2f1c9a66-7fe2-4df3-8025-4f8075bc06a1@linux.alibaba.com>
Date: Fri, 12 Apr 2024 18:00:34 -0700
Message-ID: <CAB=BE-RsPmjGgWKmuguTYQzkmmxGLdrqvaGcBFWA--AcsUr8sQ@mail.gmail.com>
Subject: Re: [PATCH v1] erofs-utils: dump: print filesystem blocksize
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

On Fri, Apr 12, 2024 at 5:09=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Sandeep,
>
> On 2024/4/13 06:51, Sandeep Dhavale wrote:
> > mkfs.erofs supports creating filesystem images with different
> > blocksizes. Add filesystem blocksize in super block dump so
> > its easier to inspect the filesystem.
> >
> > The filed is added at last, so the output now looks like:
> >
> > Filesystem magic number:                      0xE0F5E1E2
> > Filesystem blocks:                            21
> > Filesystem inode metadata start block:        0
> > Filesystem shared xattr metadata start block: 0
> > Filesystem root nid:                          36
> > Filesystem lz4_max_distance:                  65535
> > Filesystem sb_extslots:                       0
> > Filesystem inode count:                       10
> > Filesystem created:                           Fri Apr 12 15:43:40 2024
> > Filesystem features:                          sb_csum mtime 0padding
> > Filesystem UUID:                              a84a2acc-08d8-4b72-8b8c-b=
811a815fa07
> > Filesystem blocksize:                         65536
> >
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
>
> Just a minor nit:
> Could we move "Filesystem blocksize:" between the line of
> "Filesystem magic number:" and "Filesystem blocks:" ?
>
> Otherwise it looks good to me, thanks for this!
>
Hi Gao,
Sure I can change the location. I didn't do it assuming someone might
have scripted around it (not that I know of!), so I added it last.
I will send V2 by moving it after magic number.

Thanks,
Sandeep.
> Thanks,
> Gao Xiang
