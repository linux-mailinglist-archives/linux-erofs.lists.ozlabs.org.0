Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4837710847A
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Nov 2019 19:30:58 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Ldyj0shPzDqY0
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Nov 2019 05:30:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::534;
 helo=mail-ed1-x534.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XBEJL9Qb"; 
 dkim-atps=neutral
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Ldyb6hyJzDqXT
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Nov 2019 05:30:47 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id n26so10441888edw.6
 for <linux-erofs@lists.ozlabs.org>; Sun, 24 Nov 2019 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5QjZ/R0xWgcUXADRcl84yOb2gq856SPneGgCZg7qzfg=;
 b=XBEJL9QbTz/UKqzBuSvuBFXxSLTLRoUV5j5Al4nnKU4dhuX0HI0TgQtFdR/IdherVC
 04BncBQ4RvCLIn70iM4K3uzrwsqrfDL+xBUt0eBFkiP47cYXDwRCESF2g2pYuAdAeeo9
 3zvStnvlM7GfLlZxVReHpk4XpjN1KzCbIGUpBt9qI8srwdCjSwd42WAOzZB5HlN1dG9P
 gqQrhTL22JIST01MVmuGzJXLCo+K9NLBd6oMsLr11cHX+mB1CE272x4lqBQdIkjNbEMl
 1oedATFsPVTnAA3C4lioZb1hNQIFU0gKAHJvlqN/iPQfesW7lCII9c8LDEpaxf+0yBvC
 RRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5QjZ/R0xWgcUXADRcl84yOb2gq856SPneGgCZg7qzfg=;
 b=RFqdWkQhTuMCPIV4kAmlSLZVP1bYCCp+5e1PDz2cTNYKQIUHVsRhMSq1dodDRzGQwc
 8CPBGu67sTi3GS0b6yK6Mdy/UaQO2QegmvYRZ5gWYVDHwjhPlDsPOvXUwxtqv6w1MPkz
 tSRkdbPh3/58IxU1tb61ulc2QHFTliWaOXL9PqiqBUDbmzguer7NRWEy/cAsPFKAyUbo
 fJIX80ewc03t5gcswq1LeRSSjJg5g4u2kWfxFVtRLDzYj6etY+Ah9S0V7IsX/exmcVJD
 ekRyp9mXzAZg0MMa4atbNlJiv9Me53XOw2ea84CfvS7KoojDC6ujHfwr1FenWZCds+Kr
 D31g==
X-Gm-Message-State: APjAAAXJiCW+C0OO/KT+5zKLbhhwHtnAvijkAJ+o7V/soKWeII2rAon9
 eYNHnfEqe/yHPnDYSAHZDKSFdPWSeq4TPJ+ACY0=
X-Google-Smtp-Source: APXvYqwOjbSipEYIutcqT1380QKxjawSk/bCKqldJW014w+wd5Ybx8iWUtxhNzEUisAbHIv3yNUWPb4GMz9HKXUyfWc=
X-Received: by 2002:a17:906:f14a:: with SMTP id
 gw10mr33683449ejb.29.1574620238848; 
 Sun, 24 Nov 2019 10:30:38 -0800 (PST)
MIME-Version: 1.0
References: <CAGu0czQOorHC=JxQVpWDB2KD0NOzh13OuHj3r_4_U5hCWkkNwQ@mail.gmail.com>
 <20191117173027.GA21516@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20191117173027.GA21516@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Mon, 25 Nov 2019 00:00:28 +0530
Message-ID: <CAGu0czTT=s8xU0uLruAE3a3jnPDd_eQS290u45OACYrb3Z3L0Q@mail.gmail.com>
Subject: Re: Support for uncompressed sparse files.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="000000000000fe2a8805981bd772"
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

--000000000000fe2a8805981bd772
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

In the current design, for uncompressed files, we only maintain the
starting block address.because rest of the data blocks will follow it
(continuous allocation).
For sparse files we have to do following
1) We don't want to allocate space for holes (Holes will be multiple of
EROFS_BLKSZ ?)
2) For read() operation on holes, return null data  = '\0'.

I have few thoughts about it:
1) Without changing the current design much, we want to keep track of holes
in file.
    e.g maintaining some table OR bitmap(per inode), to check if given
offset falls inside hole or real data.
2) Accordingly changing the readpage() aop.

Let me know you thoughts on this.

--Pratik.

On Sun, Nov 17, 2019 at 11:01 PM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> On Sun, Nov 17, 2019 at 03:40:43PM +0530, Pratik Shinde wrote:
> > Hello Gao,
> >
> > I have started working on above functionality for erofs.
> > First thing we need to do is detect sparse files & determine location of
> > holes in it.
> >
> > I was thinking of using lseek() with SEEK_HOLE & SEEK_DATA for detecting
> > holes.
> > Let me know what you think about the approach OR any other better
> approach
> > in your mind.
> >
> > PS : support for SEEK_HOLE & SEEK_DATA came in 3.4 kernel.
>
> That is a good start to detect sparse files by SEEK_HOLE & SEEK_DATA.
>
> And as the first step, we need to design the on-disk extent format
> for uncompressed sparse files. Is there some preliminary proposed
> ideas for this as well? :-) (I'm not sure whether Chao is busy in
> other stuffs now, we'd get in line with sparse on-disk format.)
>
> Thanks,
> Gao Xiang
>
>

--000000000000fe2a8805981bd772
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao,</div><div><br></div><div>In the current desig=
n, for uncompressed files, we only maintain the starting block address.beca=
use rest of the data blocks will follow it (continuous allocation).</div><d=
iv>For sparse files we have to do following</div><div>1) We don&#39;t want =
to allocate space for holes (Holes will be multiple of EROFS_BLKSZ ?)</div>=
<div>2) For read() operation on holes, return null data=C2=A0 =3D &#39;\0&#=
39;.</div><div><br></div><div>I have few thoughts about it:</div><div>1) Wi=
thout changing the current design much, we want to keep track of holes in f=
ile.</div><div>=C2=A0=C2=A0=C2=A0 e.g maintaining some table OR bitmap(per =
inode), to check if given offset falls inside hole or real data.</div><div>=
2) Accordingly changing the readpage() aop.</div><div><br></div><div>Let me=
 know you thoughts on this.</div><div><br></div><div>--Pratik.<br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Sun, Nov 17, 2019 at 11:01 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol=
.com">hsiangkao@aol.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi Pratik,<br>
<br>
On Sun, Nov 17, 2019 at 03:40:43PM +0530, Pratik Shinde wrote:<br>
&gt; Hello Gao,<br>
&gt; <br>
&gt; I have started working on above functionality for erofs.<br>
&gt; First thing we need to do is detect sparse files &amp; determine locat=
ion of<br>
&gt; holes in it.<br>
&gt; <br>
&gt; I was thinking of using lseek() with SEEK_HOLE &amp; SEEK_DATA for det=
ecting<br>
&gt; holes.<br>
&gt; Let me know what you think about the approach OR any other better appr=
oach<br>
&gt; in your mind.<br>
&gt; <br>
&gt; PS : support for SEEK_HOLE &amp; SEEK_DATA came in 3.4 kernel.<br>
<br>
That is a good start to detect sparse files by SEEK_HOLE &amp; SEEK_DATA.<b=
r>
<br>
And as the first step, we need to design the on-disk extent format<br>
for uncompressed sparse files. Is there some preliminary proposed<br>
ideas for this as well? :-) (I&#39;m not sure whether Chao is busy in<br>
other stuffs now, we&#39;d get in line with sparse on-disk format.)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
</blockquote></div>

--000000000000fe2a8805981bd772--
