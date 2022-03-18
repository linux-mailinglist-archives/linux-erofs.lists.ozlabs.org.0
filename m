Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFFA4DD404
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 05:56:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKWtT3QBhz30D6
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 15:56:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1647579361;
	bh=GgrneSMJMWLkKBfoa8Ib3Mr1g2r+wNa/fv296IgZKEM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LYuJX4ubQhHt5P3uIGlH+pFqxKyz89IwDTtDpvg5kRLMRijpeBVcKB3mp21mAF+Vg
	 Qsyb3j1jM3vXLOIDQdX/6tW9uJAbgL9alAG1LEwMzVQMZjAuuSPBbHIqkgtnAYnGid
	 JTyvSCIi5pR3EGQPmC2KiFFIOYpLdO1nydMbEk5kGiP739W6rE0f4T3mkpSTct6SZ2
	 63uBZbsmGR5BBIdEUoQ04VYVdJRnt+FmeCf5VWI1Zn9gpkxWTmfafwFAep5d/ZhRaK
	 cadXz+WBZpOH6PDrX1sLNqAXy5htZYZofWxPkyYpiblaH5H8Uw892S7zY+IEFBrVlT
	 N6jCePh//+Ehw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::e30;
 helo=mail-vs1-xe30.google.com; envelope-from=dvander@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=o22vKnh6; dkim-atps=neutral
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKWtQ6PMFz2yLM
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 15:55:58 +1100 (AEDT)
Received: by mail-vs1-xe30.google.com with SMTP id u198so158993vsu.10
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 21:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GgrneSMJMWLkKBfoa8Ib3Mr1g2r+wNa/fv296IgZKEM=;
 b=hz2GPEjATKQmjf+tAVJDuvdYfIBpMFRgwnOpbY73JsAlteC5TYubd6jJVD0XOFfKCr
 iwWE0njNtdRXu/yOYhDz6GItb6fY/lQGisUJyePuMYRM5fsvOBVAEA8mbGW+g50Xao85
 mJOm9UIMc/6vgti6+qFxiUz0r0+ov5CrZZX98B7HIGrfL4pw4D4mv9qkjz3YVJqQV8en
 UWiPZegthlOKTUHGKgv6rN+MLe2LUnl3K/EG6vXsp+xl6vsfjE4Irz7SnTiqAd+4kzaz
 8hXAI82v4BPk+BCiXTH++PjU/vaVfhRqxbARTMDbQQxBOOysws4wv9ZeqT+QY+IbRg54
 5pUg==
X-Gm-Message-State: AOAM531PzHqyEGzdrmOuizVCNr0Tpx1RUqTaRgOQ3+9jdgOc/0hbm8DQ
 NIwaHdukSKtZee3IWNP/7IK4PHKefEYFCiaVlskSjg==
X-Google-Smtp-Source: ABdhPJzF5DfphNZZvXzFahj3zgye3V/ejlPPMMN8cH9RAQcUgMLw/Fzbm4fQbwCFDVUs/bTTMGVi+WPifaP8t4O2jac=
X-Received: by 2002:a05:6102:390f:b0:322:b576:db77 with SMTP id
 e15-20020a056102390f00b00322b576db77mr3393525vsu.29.1647579356216; Thu, 17
 Mar 2022 21:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220301041037.2271718-1-dvander@google.com>
 <Yh2sc2TOmyBdV3b7@B-P7TQMD6M-0146.local>
 <CA+FmFJB0iDzcPLqAtZsqQFj+j-pvhqs9YXmhjkmCYyqPgHpxnA@mail.gmail.com>
 <Yh25yvTzxt0aK62a@B-P7TQMD6M-0146.local>
 <CA+FmFJB39G3vDSJQW+pbC+EQVe3u51uKoASF28asHAkp0WPXSw@mail.gmail.com>
 <YirdGdAgbi9Y5NtS@B-P7TQMD6M-0146.local>
In-Reply-To: <YirdGdAgbi9Y5NtS@B-P7TQMD6M-0146.local>
Date: Thu, 17 Mar 2022 21:55:45 -0700
Message-ID: <CA+FmFJALPYgqy0MMLDjnQgXqsaEO24omY8LmzC8FiMp7S8-VOw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use extended inodes when ctime is set
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000448c1005da76f60c"
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000448c1005da76f60c
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 10, 2022 at 9:24 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> Yeah, I know what's your main point here. Ok, that's fine we
> could change the current behavior. Yet I still think the current
> behavior may benefit some use cases (e.g. metadata size is sensible,
> we need to avoid extended inodes no matter per-filetimestamp is)..
>
> So instead, how about introducing --ignore-mtime instead for the
> current behavior, and change the default behavior into using extended
> inodes?
>
>
Sounds good to me, I'll make this change.

--000000000000448c1005da76f60c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Mar 10, 2022 at 9:24 PM Gao Xiang &lt=
;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Yeah, I know what&#39;s your main point here. Ok, that&#39;s fine we<br>
could change the current behavior. Yet I still think the current<br>
behavior may benefit some use cases (e.g. metadata size is sensible,<br>
we need to avoid extended inodes no matter per-filetimestamp is)..<br>
<br>
So instead, how about introducing --ignore-mtime instead for the<br>
current behavior, and change the default behavior into using extended<br>
inodes?<br>
<br></blockquote><div><br></div><div>Sounds good to me, I&#39;ll make this =
change.</div></div></div>

--000000000000448c1005da76f60c--
