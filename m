Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F9474992
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 18:36:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JD5Bx2Yxpz305L
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 04:36:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639503369;
	bh=lShec2OREh4HK1cJN5ylX5horS36z6bYXXANxdsIamA=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=G1CE6KivxoEgaZSdN6ALYgI2uh8S+QFxXIb1kTadoQkZjf+OPuyvGu7I7zzgEDqou
	 NALD3BXnprsIZubuPL8i0tUHl04YkbCaKgmH6EdG8eAi1Z1frgIN3CA2cmX3t3oaTw
	 EZVf4cfeb8RMGG2XxvdYc8Dhjahue/J4t813d+wAXV4hYztIb+TBPPfNxzlSoo2UNn
	 IXuYcZps5mjjVBZl9Sl74CZtmCM+0UQKjMbi03ZTqh5D3ALyiArp6IB7+eHbA5eH3p
	 vnUNVw/EK+f/YGtutqfyyGDGGPjFtKCbaaeaqaUVZYr7KrCfrp2cqCCnBoX+5uqlBp
	 mg5KzvNmsQTLQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::829;
 helo=mail-qt1-x829.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=N+nOJXVH; dkim-atps=neutral
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JD5Bt0zykz2ymt
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 04:36:05 +1100 (AEDT)
Received: by mail-qt1-x829.google.com with SMTP id f20so19130592qtb.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 09:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lShec2OREh4HK1cJN5ylX5horS36z6bYXXANxdsIamA=;
 b=s274+b2n5PLMUYqurYb74dD21XFTDY8fy92+ym4hbXu163sPJ+4IWd6dGnFUH/lmnX
 2e5msKZmPMBDVtdr7c93PVUzhRrJF+CBH+yAL/QPcuB41E55N22P6OE3CMiMSB6pBWPH
 fLe1VA+TJqluesVDLaqIhUn4K6MPBeLCxenDJzRUQ9osAfrBA+sGKgLFNJe30X5aTAkR
 v/Bk3RX/TIC2qFt1xE4mNGS7T6OvCmA3I178Rps0IEyftVDkPRyxClks9ydQFBbdCgfW
 uxiP3c7ZfrzUh6Q7ze5I62CVQmjlmQ5FOrM3SkJuIVRdeRNBlUQWHY0AXCrP3lDvPJYM
 44bg==
X-Gm-Message-State: AOAM5304FTlRigFl1vYOHoCOY+dpvQyz65zceuu5pJD41iLdHRXkauJI
 DJjRzED385meVQGMWOBiFs9AX0iwa9OkM706w69wtkUcLYw=
X-Google-Smtp-Source: ABdhPJz+AXgSDacPuvFP+yW7DicLvh0vCwaFgzep5STjKz+0VSXrLXMWviV0nTjGBHKePYLzCs4v8ZYHoGFSWYudLsg=
X-Received: by 2002:ac8:5703:: with SMTP id 3mr7448360qtw.113.1639503363386;
 Tue, 14 Dec 2021 09:36:03 -0800 (PST)
MIME-Version: 1.0
References: <YbgMLtaDEEH+X5/W@B-P7TQMD6M-0146.local>
 <20211214033239.1038379-1-zhangkelvin@google.com>
 <YbhTuJV55KqqNQzG@B-P7TQMD6M-0146.local>
In-Reply-To: <YbhTuJV55KqqNQzG@B-P7TQMD6M-0146.local>
Date: Tue, 14 Dec 2021 09:35:52 -0800
Message-ID: <CAOSmRzgFzc41pZo1XxVy409Z5PPbnVjfw4sQaax3vkTB_LKPTA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Add API to get full pathname of an inode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="00000000000095a3e405d31e9f17"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000095a3e405d31e9f17
Content-Type: text/plain; charset="UTF-8"

I just rebased them on top of the dev branch. Please try again now.

On Tue, Dec 14, 2021 at 12:20 AM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> On Mon, Dec 13, 2021 at 07:32:38PM -0800, Kelvin Zhang wrote:
> > Change-Id: Iba99e590f051638285d1d1949311a08f5a5f1a82
> > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
>
> I couldn't apply them to dev or experimental branch, would
> you mind rebasing them? Or some hints about the base commit
> so I could apply?
>
> Thanks,
> Gao Xiang
>


-- 
Sincerely,

Kelvin Zhang

--00000000000095a3e405d31e9f17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I just rebased them on top of the dev branch. Please try a=
gain now.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Dec 14, 2021 at 12:20 AM Gao Xiang &lt;<a href=3D"mailto:h=
siangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Dec 13, 2021=
 at 07:32:38PM -0800, Kelvin Zhang wrote:<br>
&gt; Change-Id: Iba99e590f051638285d1d1949311a08f5a5f1a82<br>
&gt; Signed-off-by: Kelvin Zhang &lt;<a href=3D"mailto:zhangkelvin@google.c=
om" target=3D"_blank">zhangkelvin@google.com</a>&gt;<br>
<br>
I couldn&#39;t apply them to dev or experimental branch, would<br>
you mind rebasing them? Or some hints about the base commit<br>
so I could apply?<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<div><br></div><div>K=
elvin Zhang</div></div></div>

--00000000000095a3e405d31e9f17--
