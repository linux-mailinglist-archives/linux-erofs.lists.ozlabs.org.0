Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358212A02E
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 11:46:20 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47htDn42pTzDqNF
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 21:46:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::531;
 helo=mail-ed1-x531.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="D/ViblFP"; 
 dkim-atps=neutral
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47htDd11FRzDqN1
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 21:46:06 +1100 (AEDT)
Received: by mail-ed1-x531.google.com with SMTP id t17so17633865eds.6
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 02:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jcwbvuEPEe4HkXyV1/QXpUfTaSl+8RPCorDthPlAMFw=;
 b=D/ViblFPH42cku6evW9Xu/rXFADRaTmSTGLPTmcKaLuaP5a90iQgQTv1ZTOYxXdlHb
 f1dW4YgUdEzu/dRt+vTPBEnUA7G0br2o/8Vez75MZ4ba7CHvIqxtCp00KFyNJqh/SOPB
 Y0Gacl0AOt0eO2eHVNF3wJFCutBg0aM3L9BvorbmBFTwOwU8c4b/zYgLnwC8In/B+vC8
 SHKmklE3RSBvP1K7t+IEKzj+tlSnY7pm5gQRtTwjQ6NSl1QMAPdjIu/0XrkfMCpAEMzi
 E/g9vqoKprlBJhAKP5GZnMHAm+YSHs+I5qp1SD7tgPEmJpUlXJqphLHZWCv3ASmQwo+M
 dGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jcwbvuEPEe4HkXyV1/QXpUfTaSl+8RPCorDthPlAMFw=;
 b=TbdgDrEUQa7QmavT6mYaYsbVO7mM/RWh7j7P1ZLO+4FBy2WQIIqTvXWrMA0790oDQw
 P9VwXhoN4cy12o9YGhEnZu97fd1nKgqV75daBM5qSvcwfohpoFX1PtV0W5qyAnbLQLgx
 u5xAUTtI83/56zmcgCDqOhRskj8Pva7s7y26uWQFl2dBAS7bul2fISyTn70fAimlVH2X
 yifK762Bpw/bg9SDG2aXVUb3CZKeLr7PacnQjqq2/FUjr9I/Hhtpkd8tdCu4m8YNhcbz
 urdoEWVBOwk9IGYw+jqDVPumC/uKyiJu1xqUC4uhxLMqAhUsm3HUEV7BmcQpJIOfdS3P
 iedw==
X-Gm-Message-State: APjAAAXKCNWkymbyr1lWdvYqGknhvaTEq2tMS647/wlthd90xlrsgJfs
 MN09Ci46dDlYfRu0IhZNLPEN5bTac690CYVHTBA=
X-Google-Smtp-Source: APXvYqywWgwEAF6+h51aPmlrMVIK81l+3/CuFAGt/CkYNHZ/IYPAu09I/GlyX+iRUQQ3g/4dPSRkKjELY1Q+nsEvezg=
X-Received: by 2002:a17:906:a84a:: with SMTP id
 dx10mr36606580ejb.61.1577184359821; 
 Tue, 24 Dec 2019 02:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20191223172938.13189-1-pratikshinde320@gmail.com>
 <20191224034817.GA164058@architecture4>
 <CAGu0czSu81J3UsdUKvGKed_XXDV5ipZB8qz83+cDPx_ZB4-R1g@mail.gmail.com>
 <20191224100511.GB164058@architecture4>
In-Reply-To: <20191224100511.GB164058@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Tue, 24 Dec 2019 16:15:47 +0530
Message-ID: <CAGu0czTzBiT_n-13tXohNp22gbJrsdNXdY7kYDvv=WDdn2hZwA@mail.gmail.com>
Subject: Re: [RFCv2] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000008337d9059a70d9ee"
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000008337d9059a70d9ee
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

No no. What I am saying is - in the current code (excluding all my changes)
the block lookup will happens in constant time. with only hole list it
won't be O(1) time but rather we have to traverse the holes list. (say in
binary search way).
what I don't understand is - what is the purpose of tracking data extents.
hope you get it.

--Pratik.



On Tue, Dec 24, 2019, 3:35 PM Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> On Tue, Dec 24, 2019 at 03:05:53PM +0530, Pratik Shinde wrote:
> > Hello Gao,
> >
> > Thanks for the review.
> > If I understand correctly , you wish to keep track of every extent
> assigned
> > to the file.
> > in case of file without any holes in it, there will single extent
> > representing the entire file.
> >
> > Also, the current block no. lookup happens in constant time. (since we
> only
> > record the start blk no.)
> > If we use extent record for finding given block no. it can't be done in
> > constant time correct ? (maybe in LogN)
>
>
> Could I ask a question?
> In short, how can we use the proposal approach to read random blocks
> in constant time O(1)?
>
> e.g.
>  if you have two holes 2...4  7...10 in a file with 12 blocks.
>
>  if we want to random access block 11, only block number 1,5,6,11 were
>  saved one by one (maybe p1,p2,p3,p4).
>
>  How can we get the physical address (p4) of block 11 directly without
>  scanning the previous holes?
>
> Thanks,
> Gao Xiang
>
>
> >
> > I think I don't fully understand reason for recording extents assigned
> to a
> > file.Since the current design
> > is already time and space optimized & there are no deletions happening.
> > Is it for some future requirement ?
> >
> > --Pratik.
>
>

--0000000000008337d9059a70d9ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">No n=
o. What I am saying is - in the current code (excluding all my changes) the=
 block lookup will happens in constant time. with only hole list it won&#39=
;t be O(1) time but rather we have to traverse the holes list. (say in bina=
ry search way).</div><div dir=3D"auto">what I don&#39;t understand is - wha=
t is the purpose of tracking data extents.</div><div dir=3D"auto">hope you =
get it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">--Pratik.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 24, 2019=
, 3:35 PM Gao Xiang &lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25=
@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Prati=
k,<br>
<br>
On Tue, Dec 24, 2019 at 03:05:53PM +0530, Pratik Shinde wrote:<br>
&gt; Hello Gao,<br>
&gt; <br>
&gt; Thanks for the review.<br>
&gt; If I understand correctly , you wish to keep track of every extent ass=
igned<br>
&gt; to the file.<br>
&gt; in case of file without any holes in it, there will single extent<br>
&gt; representing the entire file.<br>
&gt; <br>
&gt; Also, the current block no. lookup happens in constant time. (since we=
 only<br>
&gt; record the start blk no.)<br>
&gt; If we use extent record for finding given block no. it can&#39;t be do=
ne in<br>
&gt; constant time correct ? (maybe in LogN)<br>
<br>
<br>
Could I ask a question?<br>
In short, how can we use the proposal approach to read random blocks<br>
in constant time O(1)?<br>
<br>
e.g.<br>
=C2=A0if you have two holes 2...4=C2=A0 7...10 in a file with 12 blocks.<br=
>
<br>
=C2=A0if we want to random access block 11, only block number 1,5,6,11 were=
<br>
=C2=A0saved one by one (maybe p1,p2,p3,p4).<br>
<br>
=C2=A0How can we get the physical address (p4) of block 11 directly without=
<br>
=C2=A0scanning the previous holes?<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
<br>
&gt; <br>
&gt; I think I don&#39;t fully understand reason for recording extents assi=
gned to a<br>
&gt; file.Since the current design<br>
&gt; is already time and space optimized &amp; there are no deletions happe=
ning.<br>
&gt; Is it for some future requirement ?<br>
&gt; <br>
&gt; --Pratik.<br>
<br>
</blockquote></div>

--0000000000008337d9059a70d9ee--
