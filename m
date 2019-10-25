Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3C7E41EE
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2019 05:02:48 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46zpnf2LDTzDqlr
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2019 14:02:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571972566;
	bh=SBPYLr0cUXe4i+5lYAclNwT50GMdNkBHz8pA1GzyFso=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NgvzmpRbhtBxwxcD//KbucwY75RWiyVxRAeyHX3cIUeROGa7PP8owUAp+/g9iUu9O
	 1nARBo2qp52uPOuQraSrSWnmRFDb0Okb5iLvot0zM4vePcC1FKFVP1C1XhAt7gc2Gj
	 4VQXMUq/+I/H7Z5kI4yXIO39Bz6SQO070FENwSNTtqaMzcjOTkFyMzAJqzklMJMzHY
	 jPcaNbF7zYOnGS/1fsiaCqUuxBuvisa0t0Pt70LKVEljuw6DsYrqa5vmv0aGmetqyi
	 VMD6ok+CTrB4HWUApyztYSKcSWdOZ4s/wz3rxMpjOky1VumMRld5adcX8B+ViOjxli
	 mDI9vPBEWEThg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::b43;
 helo=mail-yb1-xb43.google.com; envelope-from=groeck@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="O4RqogSx"; 
 dkim-atps=neutral
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46zpnW26sNzDql0
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2019 14:02:30 +1100 (AEDT)
Received: by mail-yb1-xb43.google.com with SMTP id 4so351401ybq.9
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Oct 2019 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SBPYLr0cUXe4i+5lYAclNwT50GMdNkBHz8pA1GzyFso=;
 b=O4RqogSxnZZbGQUbr98DXr2ZOxl4MzcALfBUga+Mo5LOluGtu9TeeEEni1AINSENW9
 SeXW0CfmccXSg5vpGznjAlHP8cr/PCRm5Gt4GVagrsJXXtgrDdRrhdWYMMsea8WPH+lw
 jOZCEM60HM26N+hQK5vsU5GU7qgTIOPp1RhokHM8HAQf4PJjlUxMcroo26lfaonKEnTa
 YMkyOdGU8edwOXaJchoG1i7g6Kl4M0sYNzHKpKB41r7V/T7d6Ltxlmal0XUX7kMCXkb6
 +wDfcOuynpZqWDSMfWkB8oPnJArk+tcaDfoakFXpg3WKyEoMUEmdJuCC9SJ+I46ZL0xj
 oRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SBPYLr0cUXe4i+5lYAclNwT50GMdNkBHz8pA1GzyFso=;
 b=XjCGBdO09aP86mK0UYhVUyMNJBP1BkCDA0dWQ8vDjcrVc5qtOd4ABGYw5J+uEJPFWz
 zBRUAqPlStY35gmxfBlz5xTi4GDzT+jtJ1XZLzi12JiKJd+LnXPJokPOif68vegMbPiO
 mjuDXTDx8vuMtxe7S83+NX1jYNYXl74HIyCLZgzVeG0ltwYsrHY81FS28MLV9qVM5fvn
 G/4QoCVoBLTsd8L0wOV+JtF/EOgux/QZTgSeQmjSPfFHPLCwoc1O3noJ8geSlEV2HHoY
 4McIcBdMGyRHWfFAEjfsX0C+x4FD/Qn5pi6mM0u47K7iyVku6NoY9Zj7+MnAWUeAi4Y0
 Vg3g==
X-Gm-Message-State: APjAAAVR/sE17qKSat2OI8OKMYZYSsVRoAE54jot7/2yxujrkqWs+HNz
 IH5v/IWytZzEFhVwC1zP41vh9da/5pQVEVEM1pCPcA==
X-Google-Smtp-Source: APXvYqzH/9/F3FGZ1Hd8vUBRgGUrDVU7wcvy1pa5llm4C0Km0Vw5SfJOJoKOSW4kJt++beCIBf+n/JRxBkSgRMBZJ9M=
X-Received: by 2002:a25:50c8:: with SMTP id e191mr1284832ybb.152.1571972545897; 
 Thu, 24 Oct 2019 20:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191018010846.186484-1-pliard@google.com>
 <20191025004531.89978-1-pliard@google.com>
 <20191025025334.GA210047@architecture4>
In-Reply-To: <20191025025334.GA210047@architecture4>
Date: Thu, 24 Oct 2019 20:02:14 -0700
Message-ID: <CABXOdTeQTapfvKqGrqZME8JACeJhaHram_ZWk7ZZX2VWvYORaw@mail.gmail.com>
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000325ac50595b361a3"
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
From: Guenter Roeck via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guenter Roeck <groeck@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Philippe Liard <pliard@google.com>, Guenter Roeck <groeck@chromium.org>,
 phillip@squashfs.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000325ac50595b361a3
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 24, 2019 at 7:51 PM Gao Xiang <gaoxiang25@huawei.com> wrote:

> On Fri, Oct 25, 2019 at 09:45:31AM +0900, Philippe Liard wrote:
> > > Personally speaking, just for Android related use cases, I'd suggest
> > > latest EROFS if you care more about system overall performance more
> > > than compression ratio, even https://lkml.org/lkml/2017/9/22/814 is
> > > applied (you can do benchmark), we did much efforts 3 years ago.
> > >
> > > And that is not only performance but noticable memory overhead (a lot
> > > of extra memory allocations) and heavy page cache thrashing in low
> > > memory scenarios (it's very common [1].)
> >
> > Thanks for the suggestion. EROFS is on our radar and we will
> > (re)consider it once it goes out of staging. But we will most likely
> > stay on squashfs until this happens.
>
> EROFS is already out of staging in mainline right now,
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/
>
> If you agree on that, I'd suggest you try it right now
> since it's widely (200+ million devices on the market)
> deployed for our Android smartphones and fully open source
> and open community. I think this is not a regrettable
> attempt and we can response any question.
>
> https://lore.kernel.org/r/20191024033259.GA2513@hsiangkao-HP-ZHAN-66-Pro-G1
>
> In my personal opinion, just for Android use cases,
> I think it is worth taking some time.
>
> All well said. The question, though, is if that is a reason to reject
squashfs performance improvements. I argue that it is not. The decision to
switch to erofs or not is completely orthogonal to squashfs performance
improvements, and one doesn't preclude the other.

Guenter

--000000000000325ac50595b361a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Oct 24, 2019 at 7:51 PM Gao Xiang=
 &lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>&gt;=
 wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Fri, Oct 25, 2019 at 09:45:31AM +0900, Philippe Liard=
 wrote:<br>
&gt; &gt; Personally speaking, just for Android related use cases, I&#39;d =
suggest<br>
&gt; &gt; latest EROFS if you care more about system overall performance mo=
re<br>
&gt; &gt; than compression ratio, even <a href=3D"https://lkml.org/lkml/201=
7/9/22/814" rel=3D"noreferrer" target=3D"_blank">https://lkml.org/lkml/2017=
/9/22/814</a> is<br>
&gt; &gt; applied (you can do benchmark), we did much efforts 3 years ago.<=
br>
&gt; &gt;<br>
&gt; &gt; And that is not only performance but noticable memory overhead (a=
 lot<br>
&gt; &gt; of extra memory allocations) and heavy page cache thrashing in lo=
w<br>
&gt; &gt; memory scenarios (it&#39;s very common [1].)<br>
&gt; <br>
&gt; Thanks for the suggestion. EROFS is on our radar and we will<br>
&gt; (re)consider it once it goes out of staging. But we will most likely<b=
r>
&gt; stay on squashfs until this happens.<br>
<br>
EROFS is already out of staging in mainline right now,<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/fs/erofs/" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/</a><br>
<br>
If you agree on that, I&#39;d suggest you try it right now<br>
since it&#39;s widely (200+ million devices on the market)<br>
deployed for our Android smartphones and fully open source<br>
and open community. I think this is not a regrettable<br>
attempt and we can response any question.<br>
<br>
<a href=3D"https://lore.kernel.org/r/20191024033259.GA2513@hsiangkao-HP-ZHA=
N-66-Pro-G1" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/r=
/20191024033259.GA2513@hsiangkao-HP-ZHAN-66-Pro-G1</a><br>
<br>
In my personal opinion, just for Android use cases,<br>
I think it is worth taking some time.<br>
<br></blockquote><div>All well said. The question, though, is if that is a =
reason to reject squashfs performance improvements. I argue that it is not.=
 The decision to switch to erofs or not is completely orthogonal to squashf=
s performance improvements, and one doesn&#39;t preclude the other.</div><d=
iv><br></div><div>Guenter</div><div><br></div></div></div>

--000000000000325ac50595b361a3--
