Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852C47A324
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Dec 2021 01:53:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JHLg70BKnz3002
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Dec 2021 11:53:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639961603;
	bh=P+PBTWI6CpVPkHigifRnw/nZcWza1lDYFFYD541dksE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=XATWqh3bmnJXGnZRpHL1/OAYR6rY5zoVGEmRUfrpQinMTPfpY40rGh1nPe362k5o6
	 bYJ3YK0XVWx4Ze6Xt2b9eo0huoNI83YzHyRPFz3wNGm2sD73NtqEvTasnDiNqRkw9A
	 4Xb8TUmwJPj3jHxf1AS4tYTkkF3EY1wEABNAK2Z4tbMiog9ygpIJvoRjGOYbSXxqzS
	 P3NNkIXU1Ht7ccMjyPN3oHFZUk/tfcz2ksHjuUf1OVUM2Tu6P217pyjJZaI4/08dNt
	 u1uJ/DuYA8SVuzbXENz9c9Do/gTAAiJIjry2WtVgjJndyodq0537SNXrJ7Z1aDbpiR
	 yJMgZVJYNV4xw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a;
 helo=mail-qt1-x82a.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=jrx0Feb+; dkim-atps=neutral
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JHLg11bt3z2yHS
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Dec 2021 11:53:15 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id a1so8316783qtx.11
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 Dec 2021 16:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P+PBTWI6CpVPkHigifRnw/nZcWza1lDYFFYD541dksE=;
 b=zYG0bPxJwS1L1lzb3s4Ivp3nChuYc/tp2tAAjqZyNl88cqhOwDYIln9VhSD1qLcB6A
 ZRdZtxOE2jrSPBCoN0hAI0sF5RIZ9LctISK9a4xYI/tusnMZ2cc+7ubEyAk37BC8trg5
 ajpvoMdAptcXfdiCnI7jbWfwL55tsHndddWthBCPBy/EwWrL50K3fRUzF+5nC6P20G/T
 hTNO7GZGd2EgbA+M2vLXOjpHXHmnsULvuji1jsipSryGpJOLfQKifZUQi8VFydL07G6P
 Qugecj4YI2uXDPa1hMP/v7GWOWZ3vO2V4UWIrHMyL949MpjqXkXdqh68z2zMkQQ8fZ9u
 nxVQ==
X-Gm-Message-State: AOAM533mYV6u8bOaOfZI1KWgQYYmoDlxLoutXsDrW5lglvio5nFHI5Ch
 4ld01TMqJdNTVABdctr00eOamZnFYpOkIF0weOkHFQ==
X-Google-Smtp-Source: ABdhPJyXZ4eI0TiG3nDmfUApF1HI6mjtO7iQJltztfQDIicMTdI8C4S360s6uCpU/eHQ9WBxXkQgIP7ZzlgthEsyfLk=
X-Received: by 2002:a05:622a:ca:: with SMTP id
 p10mr10338123qtw.302.1639961590770; 
 Sun, 19 Dec 2021 16:53:10 -0800 (PST)
MIME-Version: 1.0
References: <YboyJ1udT7fpz5I7@B-P7TQMD6M-0146.local>
 <20211217194720.3219630-1-zhangkelvin@google.com>
 <20211217194720.3219630-2-zhangkelvin@google.com>
 <CAOSmRzgMu1otsZomU3dfLdu=N4jJLKB=MBgp5viHLCg5fub68g@mail.gmail.com>
 <Yb0tBHPnP/XF6eKK@B-P7TQMD6M-0146.local>
In-Reply-To: <Yb0tBHPnP/XF6eKK@B-P7TQMD6M-0146.local>
Date: Sun, 19 Dec 2021 19:53:00 -0500
Message-ID: <CAOSmRzh0OEQuSM8zcQSBrc=Fbbs5ad_am2_4Ga98mD76ZR22Hw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] erofs-utils: lib: add API to iterate dirs in EROFS
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000109f8a05d38950d1"
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

--000000000000109f8a05d38950d1
Content-Type: text/plain; charset="UTF-8"

I don't understand why re-using the context struct(<50 bytes) helps prevent
stack overflow, when the current implementation of erofs_iterate_dir holds
a 4096 bytes buffer on stack. If is erofs_iterate_dir called recursively,
it's probably the char buf[EROFS_BLKSIZ]; who's using up stack space.

On Fri, Dec 17, 2021 at 7:36 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> Hi Kelvin,
>
> On Fri, Dec 17, 2021 at 02:54:09PM -0500, Kelvin Zhang wrote:
> > Hi Gao,
> >     I drafted a new patchset on top of the dev branch. Changes since v6:
> >
> >     1. block buffer moved to the heap, due to stack size concerns when
> > iterating recursively
> >     2. Added a "recursive" option to input parameters
> >     3. dname buffers are still on the heap, but allocation is done once
> per
> > directory, instead of once for each directory entry.
> >     4. Added a void* arg which will be forwarded to the callback
> function.
> >
> > I ran scripts/checkpatch.pl . Hopefully this makes your life easier.
> Thanks
> > for the reply!.
> >
> >
>
> Many thanks for your reply! I plan to take the patches in the
> experimental branch.
>
> The reason was written in include/erofs/dir.h:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/include/erofs/dir.h?h=experimenta
>
>  erofs_dir_context can be allocated on heap (in summary, by
>  the caller) and chain together in order to avoid recursion
>  totally later. I think it should benefit Android scenario to
>  avoid stack overflow due to deep level as well.
>
> Also Igor Eisberg sent a patch for a new get_pathname in the
> erofs_dir_context reuse way:
>
> https://lore.kernel.org/linux-erofs/CABjEcnE84FNBgiHFk6Q+V3d-4L-93bUFDkdfN4ftPX19kpC=ww@mail.gmail.com/
>
> I plan to polish and apply them as well.
>
> Thanks,
> Gao Xiang
>


-- 
Sincerely,

Kelvin Zhang

--000000000000109f8a05d38950d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t understand why re-using the context struct(&lt=
;50 bytes) helps prevent stack overflow, when the current implementation of=
=C2=A0<span style=3D"color:rgb(0,128,0);font-family:monospace;font-size:13.=
3333px;white-space:pre">erofs_iterate_dir</span>=C2=A0holds a 4096 bytes=C2=
=A0buffer on stack. If is=C2=A0<span style=3D"color:rgb(0,128,0);font-famil=
y:monospace;font-size:13.3333px;white-space:pre">erofs_iterate_dir </span>c=
alled recursively, it&#39;s probably the=C2=A0<span style=3D"color:rgb(0,12=
8,0);font-family:monospace;font-size:13.3333px;white-space:pre">char buf[ER=
OFS_BLKSIZ];</span>=C2=A0who&#39;s using up stack space.</div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 17, 202=
1 at 7:36 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">h=
siangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi Kelvin,<br>
<br>
On Fri, Dec 17, 2021 at 02:54:09PM -0500, Kelvin Zhang wrote:<br>
&gt; Hi Gao,<br>
&gt;=C2=A0 =C2=A0 =C2=A0I drafted a new patchset on top of the dev branch. =
Changes since v6:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A01. block buffer moved to the heap, due to stack siz=
e concerns when<br>
&gt; iterating recursively<br>
&gt;=C2=A0 =C2=A0 =C2=A02. Added a &quot;recursive&quot; option to input pa=
rameters<br>
&gt;=C2=A0 =C2=A0 =C2=A03. dname buffers are still on the heap, but allocat=
ion is done once per<br>
&gt; directory, instead of once for each directory entry.<br>
&gt;=C2=A0 =C2=A0 =C2=A04. Added a void* arg which will be forwarded to the=
 callback function.<br>
&gt; <br>
&gt; I ran scripts/<a href=3D"http://checkpatch.pl" rel=3D"noreferrer" targ=
et=3D"_blank">checkpatch.pl</a> . Hopefully this makes your life easier. Th=
anks<br>
&gt; for the reply!.<br>
&gt; <br>
&gt; <br>
<br>
Many thanks for your reply! I plan to take the patches in the<br>
experimental branch.<br>
<br>
The reason was written in include/erofs/dir.h:<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-util=
s.git/tree/include/erofs/dir.h?h=3Dexperimenta" rel=3D"noreferrer" target=
=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-uti=
ls.git/tree/include/erofs/dir.h?h=3Dexperimenta</a><br>
<br>
=C2=A0erofs_dir_context can be allocated on heap (in summary, by<br>
=C2=A0the caller) and chain together in order to avoid recursion<br>
=C2=A0totally later. I think it should benefit Android scenario to<br>
=C2=A0avoid stack overflow due to deep level as well.<br>
<br>
Also Igor Eisberg sent a patch for a new get_pathname in the<br>
erofs_dir_context reuse way:<br>
=C2=A0<a href=3D"https://lore.kernel.org/linux-erofs/CABjEcnE84FNBgiHFk6Q+V=
3d-4L-93bUFDkdfN4ftPX19kpC=3Dww@mail.gmail.com/" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/linux-erofs/CABjEcnE84FNBgiHFk6Q+V3d-4L=
-93bUFDkdfN4ftPX19kpC=3Dww@mail.gmail.com/</a><br>
<br>
I plan to polish and apply them as well.<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<div><br></div><div>K=
elvin Zhang</div></div></div>

--000000000000109f8a05d38950d1--
