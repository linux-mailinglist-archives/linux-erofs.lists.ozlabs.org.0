Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8664B3F2D3A
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 15:36:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrjMd1Mb9z3cLP
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 23:36:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=BMQ7tDFx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d29;
 helo=mail-io1-xd29.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=BMQ7tDFx; dkim-atps=neutral
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GrjMY1SB5z3bnK
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 23:36:08 +1000 (AEST)
Received: by mail-io1-xd29.google.com with SMTP id z1so12318077ioh.7
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=kyVgNd7FEiB61dYOhTecM+BHhDqxUIStPYxYh+cm3q0=;
 b=BMQ7tDFxiIPcQEXqKUXOtY/9ycotI6YBc3jq7Oy1hPFICOVTtcs4MVi/YlgOTJHlw0
 bCejSCZOmOIX7xF2SfQjq1ZG6p0dpS1X/PtQNiUHGXZ2zro/uS2gHeTa8rfBUBwCYB3p
 1uYY2pTugwJ7i5ECfUQv8RsqYEMeMgE5AYMlbm58GddHKtnyXeV+reGytbqrRG725c2c
 N8WzMNOxFDMX7sVcK+8AzgvHh9CIRQ71U/DSYj8QwWOGiT8KK9GJNT6mgFZiONmy/VNd
 2Wi6JcjAMOHy2+gek4+sL/V0s6ACaJXVRVUNMQ0r22wjN5BGbB0haKvlH3zifi6Eznh8
 uwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=kyVgNd7FEiB61dYOhTecM+BHhDqxUIStPYxYh+cm3q0=;
 b=rm38qzl12sh+blxupXmN2Nni10+z6HPUOFbIyejWeL1r22m5ZEIMP7j2EBEOrpB5cV
 GAfTyioykFROFmswGuDTtOavolLjKSGJ2xRsA39im5Je4DeicLIXlF39daT6TRAbiVt4
 D64lWuX4bXiKQy7h78xkg4CgHWwgRe6/MuQPKcdbgFxWDuBv5FD9K33N9LWt0H2X37D4
 7HvI4SFdcCScHfhKMP0AK2sHU6Pq4oFUZvgepd68Ajx2vxYYhph/1UYONfYbmArQOWZI
 k07kUTdlBJT8ACKz7GPD/u0kzF+aCiXTINOpwqsYqnPU/JiIRm963s5SBEHXmDL9EM94
 Mw8A==
X-Gm-Message-State: AOAM5336UjPPYL9lPnRcIy0D5g2hgwzU+QbfVr77WcljRdgEgphE59rZ
 64095uqGeGADlzx3xRNBUgMOj50Z8DAVYrAVZmI=
X-Google-Smtp-Source: ABdhPJw5hCZ5DKnuYodkOeNYOOyP24bfY0fnmOizpuSBi4Uv4jw+E09NyzJ/02YenlkfJK2DW9BSdBA4nyODJrQApJM=
X-Received: by 2002:a6b:3b8c:: with SMTP id i134mr8971353ioa.29.1629466563341; 
 Fri, 20 Aug 2021 06:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
 <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
 <20210820132656.GA25885@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210820132656.GA25885@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Fri, 20 Aug 2021 16:35:52 +0300
Message-ID: <CABjEcnFcM+Yib-SzNHBegabTjhoNvv7vH6WAkdZO1Vx13s-9xw@mail.gmail.com>
Subject: Re: An issue with erofsfuse
To: Igor Eisberg <igoreisberg@gmail.com>, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000ae714a05c9fdbf93"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000ae714a05c9fdbf93
Content-Type: text/plain; charset="UTF-8"

You're right, this is definitely what's missing:

>       linux-vdso.so.1 (0x00007ffeb2163000)
>        libfuse.so.2 => /lib/x86_64-linux-gnu/libfuse.so.2
> (0x00007ffb2d6b7000)
>        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
> (0x00007ffb2d694000)
>        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007ffb2d4a3000)
>        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007ffb2d49d000)
>        /lib64/ld-linux-x86-64.so.2 (0x00007ffb2d728000)
>

And actually when running configure, I notice this:

> checking lz4.h usability... no
> checking lz4.h presence... no
> checking for lz4.h... no
>

Not sure what I'm missing here though...

$ apt list --installed | grep lz4
> liblz4-1/now 1.9.3-2 amd64 [installed,local]
> lz4/now 1.9.3-2 amd64 [installed,local]
>

On Fri, 20 Aug 2021 at 16:27, Gao Xiang <xiang@kernel.org> wrote:

> On Fri, Aug 20, 2021 at 04:16:20PM +0300, Igor Eisberg wrote:
> > You're quicker than expected, thanks for answering.
> > Not sure how to check if lz4 was builtin, but considering that erofsfuse
> is
> > only about 34.5KB (stripped) I would guess not?
> > Here's the output of erofsfuse -d (it prints this but never exists back
> to
> > shell unless I do Ctrl+C):
>
> Yeah, it will run erofsfuse in foreground, and you need to access the
> erofs compressed files, and then check the printed result.
>
> But I think there is a easier way to check if lz4 was linked, just type
> ldd <your erofsfuse program>
>
> if lz4 was linked, it will print some message like below:
>         linux-vdso.so.1 (0x00007ffee176e000)
>         libfuse.so.2 =&gt; /lib/x86_64-linux-gnu/libfuse.so.2
> (0x00007f8e21f24000)
>         liblz4.so.1 =&gt; /lib/x86_64-linux-gnu/liblz4.so.1
> (0x00007f8e21f01000)
>         libpthread.so.0 =&gt; /lib/x86_64-linux-gnu/libpthread.so.0
> (0x00007f8e21ee0000)
>         libc.so.6 =&gt; /lib/x86_64-linux-gnu/libc.so.6
> (0x00007f8e21d1f000)
>         libdl.so.2 =&gt; /lib/x86_64-linux-gnu/libdl.so.2
> (0x00007f8e21d1a000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007f8e21f91000)
>
> Thanks,
> Gao Xiang
>
> >
> > erofsfuse 1.3
> > >
> > > disk: product.img
> > >
> > > mountpoint: product-mnt
> > >
> > > dbglevel: 7
> > >
> > > FUSE library version: 2.9.9
> > >
> > > nullpath_ok: 0
> > >
> > > nopath: 0
> > >
> > > utime_omit_ok: 0
> > >
> > > unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
> > >
> > > INIT: 7.27
> > >
> > > flags=0x003ffffb
> > >
> > > max_readahead=0x00020000
> > >
> > > EROFS: erofsfuse_init() Line[23] Using FUSE protocol 7.27
> > >
> > >    INIT: 7.19
> > >
> > >    flags=0x00000011
> > >
> > >    max_readahead=0x00020000
> > >
> > >    max_write=0x00020000
> > >
> > >    max_background=0
> > >
> > >    congestion_threshold=0
> > >
> > >    unique: 1, success, outsize: 40
> > >
> > >
> > On Fri, 20 Aug 2021 at 15:49, Gao Xiang <xiang@kernel.org> wrote:
> >
> > > Hi Igor,
> > >
> > > On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:
> > > > Hey there, getting straight to the point.
> > > > Our team is using Debian 10, in which erofs mounting is not
> supported and
> > > > we have no option of updating the kernel, nor do we have sudo
> permissions
> > > > on this server.
> > > >
> > > > Our only choice is to use erofsfuse to mount an Android image
> > > (compression
> > > > was used on that image), for the sole purpose of extracting its
> contents
> > > to
> > > > another folder for processing.
> > > > Tried on Debian 10, pop_OS! and even the latest Kubuntu (where native
> > > > mounting is supported), but on all of them I could not copy files
> which
> > > are
> > > > compressed from the mounted image to another location (ext4 file
> system).
> > > >
> > > > The error I'm getting is: "Operation not supported (95)"
> > > >
> > >
> > > Thanks for your feedback.
> > >
> > > Could you check if lz4 was built-in when building erofsfuse? I guess
> > > that is the reason (lack of lz4 support builtin).
> > >
> > > If not, could you add -d to erofsfuse when starting up?
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > > Notes:
> > > > * Only extremely small (< 1 KB) files which are stored uncompressed
> are
> > > > copied successfully.
> > > > * Copying works perfectly when mounting the image with "sudo mount"
> on
> > > the
> > > > latest Kubuntu, so it has to be something with erofsfuse.
> > > >
> > > > Anything you can do to help resolve this?
> > > >
> > > > Best,
> > > > Igor.
> > >
>

--000000000000ae714a05c9fdbf93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>You&#39;re right, this is definitely what&#39;s missi=
ng:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><span style=
=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0);background-color=
:rgb(255,255,255)"> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-vdso.so.1 (0x00007=
ffeb2163000)
</span><br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libfuse.so.2 =3D&gt; =
/lib/x86_64-linux-gnu/libfuse.so.2 (0x00007ffb2d6b7000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libpthread.so.0 =3D&gt; /lib=
/x86_64-linux-gnu/libpthread.so.0 (0x00007ffb2d694000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libc.so.6 =3D&gt; /lib/x86_6=
4-linux-gnu/libc.so.6 (0x00007ffb2d4a3000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0libdl.so.2 =3D&gt; /lib/x86_=
64-linux-gnu/libdl.so.2 (0x00007ffb2d49d000)
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/lib64/ld-linux-x86-64.so.2 =
(0x00007ffb2d728000)<br></span></div></blockquote><div><br></div><div>And a=
ctually when running configure, I notice this:</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div><span style=3D"font-family:monospace"><span=
 style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)">checking lz4.=
h usability... no
</span><br>checking lz4.h presence... no
<br>checking for lz4.h... no<br></span></div></blockquote><div><br></div><d=
iv>Not sure what I&#39;m missing here though...</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div><span style=3D"font-family:=
monospace"><span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255=
)">$ apt list --installed | grep lz4
</span><br>lib<span style=3D"font-weight:bold;color:rgb(255,84,84);backgrou=
nd-color:rgb(255,255,255)">lz4</span><span style=3D"color:rgb(0,0,0);backgr=
ound-color:rgb(255,255,255)">-1/now 1.9.3-2 amd64 [installed,local]
</span><br><span style=3D"font-weight:bold;color:rgb(255,84,84);background-=
color:rgb(255,255,255)">lz4</span><span style=3D"color:rgb(0,0,0);backgroun=
d-color:rgb(255,255,255)">/now 1.9.3-2 amd64 [installed,local]</span><br></=
span></div></blockquote></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, 20 Aug 2021 at 16:27, Gao Xiang &lt;<a href=
=3D"mailto:xiang@kernel.org">xiang@kernel.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On Fri, Aug 20, 2021 at 04:16:=
20PM +0300, Igor Eisberg wrote:<br>
&gt; You&#39;re quicker than expected, thanks for answering.<br>
&gt; Not sure how to check if lz4 was builtin, but considering that erofsfu=
se is<br>
&gt; only about 34.5KB (stripped) I would guess not?<br>
&gt; Here&#39;s the output of erofsfuse -d (it prints this but never exists=
 back to<br>
&gt; shell unless I do Ctrl+C):<br>
<br>
Yeah, it will run erofsfuse in foreground, and you need to access the<br>
erofs compressed files, and then check the printed result.<br>
<br>
But I think there is a easier way to check if lz4 was linked, just type<br>
ldd &lt;your erofsfuse program&gt;<br>
<br>
if lz4 was linked, it will print some message like below:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 linux-vdso.so.1 (0x00007ffee176e000)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 libfuse.so.2 =3D&amp;gt; /lib/x86_64-linux-gnu/=
libfuse.so.2 (0x00007f8e21f24000)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 liblz4.so.1 =3D&amp;gt; /lib/x86_64-linux-gnu/l=
iblz4.so.1 (0x00007f8e21f01000)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 libpthread.so.0 =3D&amp;gt; /lib/x86_64-linux-g=
nu/libpthread.so.0 (0x00007f8e21ee0000)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 libc.so.6 =3D&amp;gt; /lib/x86_64-linux-gnu/lib=
c.so.6 (0x00007f8e21d1f000)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 libdl.so.2 =3D&amp;gt; /lib/x86_64-linux-gnu/li=
bdl.so.2 (0x00007f8e21d1a000)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /lib64/ld-linux-x86-64.so.2 (0x00007f8e21f91000=
)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; erofsfuse 1.3<br>
&gt; &gt;<br>
&gt; &gt; disk: product.img<br>
&gt; &gt;<br>
&gt; &gt; mountpoint: product-mnt<br>
&gt; &gt;<br>
&gt; &gt; dbglevel: 7<br>
&gt; &gt;<br>
&gt; &gt; FUSE library version: 2.9.9<br>
&gt; &gt;<br>
&gt; &gt; nullpath_ok: 0<br>
&gt; &gt;<br>
&gt; &gt; nopath: 0<br>
&gt; &gt;<br>
&gt; &gt; utime_omit_ok: 0<br>
&gt; &gt;<br>
&gt; &gt; unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0<br>
&gt; &gt;<br>
&gt; &gt; INIT: 7.27<br>
&gt; &gt;<br>
&gt; &gt; flags=3D0x003ffffb<br>
&gt; &gt;<br>
&gt; &gt; max_readahead=3D0x00020000<br>
&gt; &gt;<br>
&gt; &gt; EROFS: erofsfuse_init() Line[23] Using FUSE protocol 7.27<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 INIT: 7.19<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 flags=3D0x00000011<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 max_readahead=3D0x00020000<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 max_write=3D0x00020000<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 max_background=3D0<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 congestion_threshold=3D0<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 unique: 1, success, outsize: 40<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; On Fri, 20 Aug 2021 at 15:49, Gao Xiang &lt;<a href=3D"mailto:xiang@ke=
rnel.org" target=3D"_blank">xiang@kernel.org</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi Igor,<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:<br>
&gt; &gt; &gt; Hey there, getting straight to the point.<br>
&gt; &gt; &gt; Our team is using Debian 10, in which erofs mounting is not =
supported and<br>
&gt; &gt; &gt; we have no option of updating the kernel, nor do we have sud=
o permissions<br>
&gt; &gt; &gt; on this server.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Our only choice is to use erofsfuse to mount an Android imag=
e<br>
&gt; &gt; (compression<br>
&gt; &gt; &gt; was used on that image), for the sole purpose of extracting =
its contents<br>
&gt; &gt; to<br>
&gt; &gt; &gt; another folder for processing.<br>
&gt; &gt; &gt; Tried on Debian 10, pop_OS! and even the latest Kubuntu (whe=
re native<br>
&gt; &gt; &gt; mounting is supported), but on all of them I could not copy =
files which<br>
&gt; &gt; are<br>
&gt; &gt; &gt; compressed from the mounted image to another location (ext4 =
file system).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The error I&#39;m getting is: &quot;Operation not supported =
(95)&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks for your feedback.<br>
&gt; &gt;<br>
&gt; &gt; Could you check if lz4 was built-in when building erofsfuse? I gu=
ess<br>
&gt; &gt; that is the reason (lack of lz4 support builtin).<br>
&gt; &gt;<br>
&gt; &gt; If not, could you add -d to erofsfuse when starting up?<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt;<br>
&gt; &gt; &gt; Notes:<br>
&gt; &gt; &gt; * Only extremely small (&lt; 1 KB) files which are stored un=
compressed are<br>
&gt; &gt; &gt; copied successfully.<br>
&gt; &gt; &gt; * Copying works perfectly when mounting the image with &quot=
;sudo mount&quot; on<br>
&gt; &gt; the<br>
&gt; &gt; &gt; latest Kubuntu, so it has to be something with erofsfuse.<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Anything you can do to help resolve this?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Best,<br>
&gt; &gt; &gt; Igor.<br>
&gt; &gt;<br>
</blockquote></div>

--000000000000ae714a05c9fdbf93--
