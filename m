Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E4370E893B
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Oct 2019 14:17:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 472XFG0H9BzF36D
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Oct 2019 00:17:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52e;
 helo=mail-ed1-x52e.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAZ6eeH3"; 
 dkim-atps=neutral
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 472XDq54LnzF348
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2019 00:17:14 +1100 (AEDT)
Received: by mail-ed1-x52e.google.com with SMTP id l25so10696651edt.6
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Oct 2019 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sSyreHh/UjRpA/CEqhtTbigpjpicsO43mn5qouOrQeU=;
 b=jAZ6eeH3ywDDLkJd30NqznsbfGNWjkxYZfsww29n+yLROQJzoTBys2fQRjaVT6cJVe
 ivhyTTdUFjOP3ORcEfdm8ynaBtinAvJwSnwtd+LEL5KQVZnI9xYXcpwbjLEXXSvQG4Lc
 wpFxfQtWRn4l3Ku2lIfuzDrHwA/MDK81F4figDNDGp8GxZ/6gn6odT/jnEFFiOYoglv3
 mEWJf0MuKWE2ydzlHKfoX9gR5BdP5OccpZlituERoTQIMUN28VQvaLiact3QMN63xeXD
 QGcGLNWb3HvfIwK2NwG43Jm9LAgyQEDdIY/1X88sTUFPgYnCltubEXAsCwqI450ixpkR
 5PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sSyreHh/UjRpA/CEqhtTbigpjpicsO43mn5qouOrQeU=;
 b=GRl8RuHFQA6wjvZmNaCNWf2QP2QCZ6EH7NkcUFa+FqMerTEvgnDr7tK944+/+IZCO/
 hchoopSmJAZW7sxTD/BjN/vVjjYmUIA5qNNFi0Kx1GnRp7B6qaFQPBVRTl99eKxG+45R
 3QmGO8vf5vyYCrD6fat4ad2sF3gT41LDYVZzA0Fj6wEfSEk65WTFCvRrEu7iymLmVew/
 Li7r4buniizMzVI9OdpVIu1BWUsVQ/tDdSFk4H/cUELjJK4MIPz7aG05qO6Dv0krI2RM
 hw9v2Qiiq2toMoTNW/eDxWdW6pOrtZH+wNrVitIDqTMiJYhEkY7IEUnLet3o8YsfBle9
 +d+A==
X-Gm-Message-State: APjAAAUQAiTTeBu7UGuDnXwZOAFlYC0kYpe1A0UPhgYUKnI+8e9YX7nf
 aYDa6pRL4qvALLWGSf3nfMD99JKjtJngXF5Fe/g=
X-Google-Smtp-Source: APXvYqxNCHwoo5y0nD76XmeoGZRPjfnkbOgxe/AFL47zQes9rB03t8zwuKyoSpNZmAogtlRUFe8zigUUssOLh+UyCx0=
X-Received: by 2002:a50:fa85:: with SMTP id w5mr18856641edr.113.1572355027865; 
 Tue, 29 Oct 2019 06:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGu0czSVS4exiJJPg9SL8MpjwQahPRRuTt5Ho5s8Lcc6BK2D7w@mail.gmail.com>
 <20191026112431.GA6326@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20191026112431.GA6326@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Tue, 29 Oct 2019 18:46:56 +0530
Message-ID: <CAGu0czQfmMoSa-Sm9t+ZYf2b_YAfZ2b2-qPyTAbYvYHB5z-hDw@mail.gmail.com>
Subject: Re: New things in erofs
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="000000000000e5952d05960c6ec3"
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000e5952d05960c6ec3
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

Thanks.
I am exploring following things in erofs:
1) Sparse file support for uncompressed files.
2) erofs.fsck(erofs-utils)

I hope above items are in the development plan & patches are accepted for
them :)

--Pratik.

On Sat, Oct 26, 2019 at 4:54 PM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> On Sat, Oct 26, 2019 at 12:56:10PM +0530, Pratik Shinde wrote:
> > Hi Gao,
> >
> > Are there any new features/enhancements coming in erofs. Something that
> we
> > can contribute to?
> >
> > P. S. - I saw your erofs roadmap pdf on github.
>
> Thanks for your interest. As I mentioned before, I'm currently working on
> adding a new XZ algorithm to erofs-utils because I'd like to make the
> decompression framework more powerful and generic...
>
> And there are many TODOs in the roadmap pdf, you can pick up something
> if you have some time or you can raise up some new ideas. It's very
> helpful to make EROFS better.
>
> Thanks,
> Gao Xiang
>
> >
> > --Pratik
>

--000000000000e5952d05960c6ec3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao,</div><div><br></div><div>Thanks.</div><div>I =
am exploring following things in erofs:</div><div>1) Sparse file support fo=
r uncompressed files.</div><div>2) erofs.fsck(erofs-utils)<br></div><div><b=
r></div><div>I hope above items are in the development plan &amp; patches a=
re accepted for them :)</div><div><br></div><div>--Pratik.<br></div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat,=
 Oct 26, 2019 at 4:54 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol.com"=
>hsiangkao@aol.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi Pratik,<br>
<br>
On Sat, Oct 26, 2019 at 12:56:10PM +0530, Pratik Shinde wrote:<br>
&gt; Hi Gao,<br>
&gt; <br>
&gt; Are there any new features/enhancements coming in erofs. Something tha=
t we<br>
&gt; can contribute to?<br>
&gt; <br>
&gt; P. S. - I saw your erofs roadmap pdf on github.<br>
<br>
Thanks for your interest. As I mentioned before, I&#39;m currently working =
on<br>
adding a new XZ algorithm to erofs-utils because I&#39;d like to make the<b=
r>
decompression framework more powerful and generic...<br>
<br>
And there are many TODOs in the roadmap pdf, you can pick up something<br>
if you have some time or you can raise up some new ideas. It&#39;s very<br>
helpful to make EROFS better.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; --Pratik<br>
</blockquote></div>

--000000000000e5952d05960c6ec3--
