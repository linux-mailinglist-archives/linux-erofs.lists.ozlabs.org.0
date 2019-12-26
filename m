Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AEE12AA61
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2019 06:42:42 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47jzPW3MPgzDqJq
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2019 16:42:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::533;
 helo=mail-ed1-x533.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKUGT/tM"; 
 dkim-atps=neutral
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47jzPP0FcTzDqJT
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Dec 2019 16:42:30 +1100 (AEDT)
Received: by mail-ed1-x533.google.com with SMTP id r21so21666470edq.0
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Dec 2019 21:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yS+9r1p59g3muJiWoENgNiQAQByXyviNuzi1I35ofzs=;
 b=DKUGT/tM6FaeJQMdeRtP7oixgNwWd5pF3QYegywv9ZRnawKPJPcV8uv1SPJJndmVCt
 LUu9fbBB+nmbCWAdpbbNFOK58Yw3v8RH7ZfLx9+DAt3GSYPi/+pJIjEvLI0FtqnwUHB9
 cz1WOvGxHxC5eRhHx6cCi+W9SFwhExH+NV68cl26+y69LMtvgXfYnV8zxDsJOxbhO4qX
 A1DEp1SmAYnF6t2nYv90Kpzbhb60MpFG+apu3IMPr4GiX8z/laSNzPRf++ypgHJn0NTp
 JQmU+8RKG3t1MCMYHed2mQ/wRl8VgULb+XD8iA4JUYmd6riqYh0jrQtfG3ZG5gvxvhC1
 aFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yS+9r1p59g3muJiWoENgNiQAQByXyviNuzi1I35ofzs=;
 b=cP8BGIuyc98KTrSsyZ0oqpEjO74TLpZMDJFTlI4utYmPqvrEiS5dPILfiNaQSc9rf4
 7wOhbzBrnLwuC+IBqfBHqhu391XYQG5EM9mliSxssj2W9KAd7bHImfPF39wQ86aX9U2a
 77kO3e/K+DIMZzWmi5kegfdxxRbGAcme/9feDiMnyuRwrmBXDFuTc7VJaY9RNN4l0hyX
 9+9vdyL7HYm19CroN59im5ClnrR6IlTeCyIRNUSMrmitE9mG0jQEQN/ZuEnwqo3hrCMk
 vMY7dVo8zlE9p06pyat6eSwH5mO/7vUsdZAqq9F4AsUV/1qg4n0cKWvjrEhGBtixvMz4
 6ccQ==
X-Gm-Message-State: APjAAAWD/WzJaTs9b4jgVreHvgf3RaxssITJF9FEVcLNSBZHzl/c8xfL
 YgrCh35bwWfk02V2A7oKjf9rnm48Id+8EVVwAeAdzJis
X-Google-Smtp-Source: APXvYqxaMImcUoJdn8onC+ZIfFrfUB9tY33SneKBITFNRMnJFep7unGmELu36NhAMwVFGfe2AbrjotS4xQNapTMIU8I=
X-Received: by 2002:a17:906:5e4d:: with SMTP id
 b13mr46810539eju.266.1577338941857; 
 Wed, 25 Dec 2019 21:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20191223172938.13189-1-pratikshinde320@gmail.com>
 <20191224034817.GA164058@architecture4>
 <CAGu0czSu81J3UsdUKvGKed_XXDV5ipZB8qz83+cDPx_ZB4-R1g@mail.gmail.com>
 <20191224100511.GB164058@architecture4>
 <CAGu0czTzBiT_n-13tXohNp22gbJrsdNXdY7kYDvv=WDdn2hZwA@mail.gmail.com>
 <20191224111553.GC164058@architecture4>
In-Reply-To: <20191224111553.GC164058@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Thu, 26 Dec 2019 11:12:09 +0530
Message-ID: <CAGu0czQzwunpV2pV6EujWknWKt+uALmSHKqCBPjxhxJ=BZY5gQ@mail.gmail.com>
Subject: Re: [RFCv2] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000051e260059a94d7b0"
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

--00000000000051e260059a94d7b0
Content-Type: text/plain; charset="UTF-8"

Thanks Gao.

Now I understand the purpose.
So with i_format we will be able to recognize which path to take. i.e fast
path (flat mode) or slow path(i.e to search through extent list).
I am working on it.

--Pratik.

On Tue, Dec 24, 2019 at 4:46 PM Gao Xiang <gaoxiang25@huawei.com> wrote:

> On Tue, Dec 24, 2019 at 04:15:47PM +0530, Pratik Shinde wrote:
> > Hi Gao,
> >
> > No no. What I am saying is - in the current code (excluding all my
> changes)
> > the block lookup will happens in constant time. with only hole list it
>
> Not only lookup but other interfaces such as fiemap, that is why called
> flat mode and fast path.
>
> > won't be O(1) time but rather we have to traverse the holes list. (say in
> > binary search way).
> > what I don't understand is - what is the purpose of tracking data
> extents.
> > hope you get it.
>
> Mode plain and inline are called flat modes, which is the most common
> case of regular and dir files. You can see that's the fastest path for
> most file accesses (minimum metadata).
>
> The reason why don't extend the flat modes but introduce another new
> sparse mode for 3 main reasons:
>  1) introduce a complete enhanced new extent table (or later B+-tree);
>  2) we don't even know how many holes in the file if we only read
>     inode base metadata, some extra header (no matter extent or hole
>     header) need to be readed in advance;
>  3) Old kernel backward compatibility need to be considered, not all
>     files are sparsed, and we need to get them work properly, and rest
>     files are sparsed, we need to block such files from accessed by
>     old kernels;
>
> Note that i_format is for such use, so we can introduce sparse mode
> with some enhanced on-disk representation (but with more metadata
> read amplification than flat modes).
>
> So if files without holes it should be considered as flat modes (fast
> path), and then considering the slow path --- upcoming sparse mode.
>
> The purpose of tracking data extents is we could then use it
> for deduping, repeated data or data redirect. Hole can only be 0
> though.
>
> Thanks,
> Gao Xiang
>
> >
> > --Pratik.
> >
>

--00000000000051e260059a94d7b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Gao.</div><div><br></div><div>Now I understand=
 the purpose.</div><div>So with i_format we will be able to recognize which=
 path to take. i.e fast path (flat mode) or slow path(i.e to search through=
 extent list).</div><div>I am working on it.</div><div><br></div><div>--Pra=
tik.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Dec 24, 2019 at 4:46 PM Gao Xiang &lt;<a href=3D"ma=
ilto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Dec 24, 2019 at 04=
:15:47PM +0530, Pratik Shinde wrote:<br>
&gt; Hi Gao,<br>
&gt; <br>
&gt; No no. What I am saying is - in the current code (excluding all my cha=
nges)<br>
&gt; the block lookup will happens in constant time. with only hole list it=
<br>
<br>
Not only lookup but other interfaces such as fiemap, that is why called<br>
flat mode and fast path.<br>
<br>
&gt; won&#39;t be O(1) time but rather we have to traverse the holes list. =
(say in<br>
&gt; binary search way).<br>
&gt; what I don&#39;t understand is - what is the purpose of tracking data =
extents.<br>
&gt; hope you get it.<br>
<br>
Mode plain and inline are called flat modes, which is the most common<br>
case of regular and dir files. You can see that&#39;s the fastest path for<=
br>
most file accesses (minimum metadata).<br>
<br>
The reason why don&#39;t extend the flat modes but introduce another new<br=
>
sparse mode for 3 main reasons:<br>
=C2=A01) introduce a complete enhanced new extent table (or later B+-tree);=
<br>
=C2=A02) we don&#39;t even know how many holes in the file if we only read<=
br>
=C2=A0 =C2=A0 inode base metadata, some extra header (no matter extent or h=
ole<br>
=C2=A0 =C2=A0 header) need to be readed in advance;<br>
=C2=A03) Old kernel backward compatibility need to be considered, not all<b=
r>
=C2=A0 =C2=A0 files are sparsed, and we need to get them work properly, and=
 rest<br>
=C2=A0 =C2=A0 files are sparsed, we need to block such files from accessed =
by<br>
=C2=A0 =C2=A0 old kernels;<br>
<br>
Note that i_format is for such use, so we can introduce sparse mode<br>
with some enhanced on-disk representation (but with more metadata<br>
read amplification than flat modes).<br>
<br>
So if files without holes it should be considered as flat modes (fast<br>
path), and then considering the slow path --- upcoming sparse mode.<br>
<br>
The purpose of tracking data extents is we could then use it<br>
for deduping, repeated data or data redirect. Hole can only be 0<br>
though.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; --Pratik.<br>
&gt; <br>
</blockquote></div>

--00000000000051e260059a94d7b0--
