Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F36459CE8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 08:39:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HywyM4TkJz2yZx
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 18:39:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1637653179;
	bh=8IGmIrTGJFXdwngOVVuyhGDcsTWoiOamuQBNJX5UuVQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=owJjpJQ4omqYWT83swe6Zp1YfDNJsEwUSXn1dM0U1n1c70h9ad2PvOUxOz7TgKUTP
	 i4l/c6VRXFOoG2gGc9NWRsG5Cm1+C04UKhrh16v8wPEzhckQpG2SoZsVAr+0k9HdCm
	 6id0eQQpwSjAKXsSLk6Rgo9ru5y3r2bPFRwY/RaTGWBl5woIgBp8uNs7nB2tGowzDT
	 GrFLCf8g5zgN5MAZlZ0udTiL5pD9j7TGnFIwnD6NvV9hRvXAiSqCGgbP3vt9W7hSBh
	 UJLLtkQavct/9yfdSISn5Z4olI9p7BRz8Y03xgTrgDhkFFhR3ShB4VpEL+BQJs3LIV
	 3qbYO2VYfL4FQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82d;
 helo=mail-qt1-x82d.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=qxdtWa8S; dkim-atps=neutral
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HywyH4rR8z2xDV
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 18:39:33 +1100 (AEDT)
Received: by mail-qt1-x82d.google.com with SMTP id p19so19008259qtw.12
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Nov 2021 23:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8IGmIrTGJFXdwngOVVuyhGDcsTWoiOamuQBNJX5UuVQ=;
 b=dhZO4fda6VbeAjrAa96aUYgcgiw62EUqEGSV9jYzRaw9OoWrU2UB/CXX7vGU2PmpRj
 n+ZYhl0hBkvDMr5VM0UMU2Za0NYSUDYm8IazqOEQ/KHyyLoy28kQBP2oBXCK8jxn0xqP
 y5iExuB6o/PGLT6DCLXSuElSxp0lcOYinNhb45vxmGW/F+KlvggejzQhR2O+dwukuVva
 ZEID1p6l+m95laEbtfjJ7MHJLDveOZP+4yVBk5khJE1FND391ybck9Lp0pKwRsMll2jf
 A9NQf27bJgDUnjRTNwNMm0GvrDaIT7W0ngia1WFgvaRpN2v/LlvGqLTAJOi1NQIlxqSS
 YTxA==
X-Gm-Message-State: AOAM5325DU02dmH7cvoDdxBp08GRQLKQyfPCTCD0Bsn82x2w72Hy4JL7
 mgdTvYDrWMtfIbXVYGhWi6eipkW9qYxGdiJfxnfKMQ==
X-Google-Smtp-Source: ABdhPJxr+Tp1L0oH+r6Xx9AKj9Tqi8hpWe47Z0Bv5iY2q6jVI/l374Bn3PUTjVyyDZ8rgVr4JjgoK4JqE1AKayXYY18=
X-Received: by 2002:a05:622a:11c9:: with SMTP id
 n9mr3931448qtk.385.1637653169284; 
 Mon, 22 Nov 2021 23:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20211121053920.2580751-1-zhangkelvin@google.com>
 <YZof8UmtEdO+azTa@B-P7TQMD6M-0146.local>
In-Reply-To: <YZof8UmtEdO+azTa@B-P7TQMD6M-0146.local>
Date: Mon, 22 Nov 2021 23:39:18 -0800
Message-ID: <CAOSmRzgHBseomsTNQ=+hBZ3QivyqRFajA+h_2XRXV66UxB3j3Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Make erofs-utils more library friendly
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000006bfa5205d16fd7fc"
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Chao Yu <yuchao0@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000006bfa5205d16fd7fc
Content-Type: text/plain; charset="UTF-8"

Sounds good, now that v1.4 is available on kernel.lorg, shall we start
working on the refactoring commits?

On Sun, Nov 21, 2021 at 2:31 AM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> Hi Kelvin,
>
> On Sat, Nov 20, 2021 at 09:39:17PM -0800, Kelvin Zhang wrote:
> > EROFS-utils contains several usage of global variables, namely
> >
> > 1. int erofs_devfd, stores the file descriptor to open'ed block devices.
> > This is referened in many places.
> > 2. struct erofs_sb_info sbi; Stores parsed super block.
> >
> > These global variables make embedding erofs library diffcult. To make
> > library usage easier, a series of 3 patches are drafted to refactor away
> > the global variables. Each patch has been built and tested by calling
> > mkfs.erofs and ensure the same output is generated.
>
> Agreed, that is mainly due to fast iterative development. If we consider
> to export liberofs as a real library, these all needs to be resolved in
> advance, and it'd be better to stablize all liberofs APIs as well.
>
> However, let's postpone this work until 1.4 is out, I have to admit I'm
> a bit delay of releasing v1.4 due to my busy work.
> Now I'm working on pre-releasing..
>
> Thanks,
> Gao Xiang
>
> >
> > Kelvin Zhang (3):
> >   Make erofs_devfd a parameter for most functions
> >   Mark certain callback function pointers as const
> >   Make super block info struct a paramater instead of globals
> >
> >  Android.bp                 |  44 +++++++-
> >  dump/main.c                |  84 ++++++++------
> >  fsck/main.c                |  90 +++++++++------
> >  fuse/dir.c                 |   8 +-
> >  fuse/main.c                |  19 ++--
> >  include/erofs/blobchunk.h  |   7 +-
> >  include/erofs/cache.h      |  15 +--
> >  include/erofs/compress.h   |  10 +-
> >  include/erofs/config.h     |  15 +--
> >  include/erofs/decompress.h |   5 +-
> >  include/erofs/defs.h       |  21 ++++
> >  include/erofs/inode.h      |   9 +-
> >  include/erofs/internal.h   |  72 ++++++------
> >  include/erofs/io.h         |  48 +++++---
> >  include/erofs/iterate.h    |  35 ++++++
> >  include/erofs/xattr.h      |   2 +-
> >  iterate/main.c             |  51 +++++++++
> >  lib/blobchunk.c            |  11 +-
> >  lib/cache.c                |  33 +++---
> >  lib/compress.c             | 104 ++++++++++-------
> >  lib/compressor.c           |   9 +-
> >  lib/compressor.h           |  13 ++-
> >  lib/compressor_liblzma.c   |   4 +-
> >  lib/compressor_lz4.c       |   8 +-
> >  lib/compressor_lz4hc.c     |   6 +-
> >  lib/config.c               |  64 ++++++-----
> >  lib/data.c                 |  54 +++++----
> >  lib/decompress.c           |  12 +-
> >  lib/inode.c                | 129 ++++++++++++---------
> >  lib/io.c                   |  74 ++++++------
> >  lib/iterate.c              | 223 +++++++++++++++++++++++++++++++++++++
> >  lib/namei.c                |  44 +++++---
> >  lib/super.c                |  28 ++---
> >  lib/xattr.c                |  10 +-
> >  lib/zmap.c                 |  92 +++++++++------
> >  mkfs/main.c                |  92 +++++++--------
> >  36 files changed, 1069 insertions(+), 476 deletions(-)
> >  create mode 100644 include/erofs/iterate.h
> >  create mode 100644 iterate/main.c
> >  create mode 100644 lib/iterate.c
> >
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
>


-- 
Sincerely,

Kelvin Zhang

--0000000000006bfa5205d16fd7fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sounds good, now that v1.4 is available on kernel.lorg, sh=
all we start working on the refactoring commits?</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 21, 2021 at 2:3=
1 AM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao=
@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi Kelvin,<br>
<br>
On Sat, Nov 20, 2021 at 09:39:17PM -0800, Kelvin Zhang wrote:<br>
&gt; EROFS-utils contains several usage of global variables, namely<br>
&gt; <br>
&gt; 1. int erofs_devfd, stores the file descriptor to open&#39;ed block de=
vices.<br>
&gt; This is referened in many places.<br>
&gt; 2. struct erofs_sb_info sbi; Stores parsed super block.<br>
&gt; <br>
&gt; These global variables make embedding erofs library diffcult. To make<=
br>
&gt; library usage easier, a series of 3 patches are drafted to refactor aw=
ay<br>
&gt; the global variables. Each patch has been built and tested by calling<=
br>
&gt; mkfs.erofs and ensure the same output is generated.<br>
<br>
Agreed, that is mainly due to fast iterative development. If we consider<br=
>
to export liberofs as a real library, these all needs to be resolved in<br>
advance, and it&#39;d be better to stablize all liberofs APIs as well.<br>
<br>
However, let&#39;s postpone this work until 1.4 is out, I have to admit I&#=
39;m<br>
a bit delay of releasing v1.4 due to my busy work.<br>
Now I&#39;m working on pre-releasing..<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Kelvin Zhang (3):<br>
&gt;=C2=A0 =C2=A0Make erofs_devfd a parameter for most functions<br>
&gt;=C2=A0 =C2=A0Mark certain callback function pointers as const<br>
&gt;=C2=A0 =C2=A0Make super block info struct a paramater instead of global=
s<br>
&gt; <br>
&gt;=C2=A0 Android.bp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 44 +++++++-<br>
&gt;=C2=A0 dump/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 84 ++++++++------<br>
&gt;=C2=A0 fsck/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 90 +++++++++------<br>
&gt;=C2=A0 fuse/dir.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 fuse/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 19 ++--<br>
&gt;=C2=A0 include/erofs/blobchunk.h=C2=A0 |=C2=A0 =C2=A07 +-<br>
&gt;=C2=A0 include/erofs/cache.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 15 +--<br>
&gt;=C2=A0 include/erofs/compress.h=C2=A0 =C2=A0|=C2=A0 10 +-<br>
&gt;=C2=A0 include/erofs/config.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 15 +--<br>
&gt;=C2=A0 include/erofs/decompress.h |=C2=A0 =C2=A05 +-<br>
&gt;=C2=A0 include/erofs/defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 ++++<b=
r>
&gt;=C2=A0 include/erofs/inode.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-<br>
&gt;=C2=A0 include/erofs/internal.h=C2=A0 =C2=A0|=C2=A0 72 ++++++------<br>
&gt;=C2=A0 include/erofs/io.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 48 +=
++++---<br>
&gt;=C2=A0 include/erofs/iterate.h=C2=A0 =C2=A0 |=C2=A0 35 ++++++<br>
&gt;=C2=A0 include/erofs/xattr.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 iterate/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 51 +++++++++<br>
&gt;=C2=A0 lib/blobchunk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 11 +-<br>
&gt;=C2=A0 lib/cache.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 33 +++---<br>
&gt;=C2=A0 lib/compress.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
104 ++++++++++-------<br>
&gt;=C2=A0 lib/compressor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A09 +-<br>
&gt;=C2=A0 lib/compressor.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 13 ++-<br>
&gt;=C2=A0 lib/compressor_liblzma.c=C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 lib/compressor_lz4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +=
-<br>
&gt;=C2=A0 lib/compressor_lz4hc.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 lib/config.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 64 ++++++-----<br>
&gt;=C2=A0 lib/data.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 54 +++++----<br>
&gt;=C2=A0 lib/decompress.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 12 +-<br>
&gt;=C2=A0 lib/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 129 ++++++++++++---------<br>
&gt;=C2=A0 lib/io.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 74 ++++++------<br>
&gt;=C2=A0 lib/iterate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
223 +++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 lib/namei.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 44 +++++---<br>
&gt;=C2=A0 lib/super.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 28 ++---<br>
&gt;=C2=A0 lib/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 10 +-<br>
&gt;=C2=A0 lib/zmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 92 +++++++++------<br>
&gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 92 +++++++--------<br>
&gt;=C2=A0 36 files changed, 1069 insertions(+), 476 deletions(-)<br>
&gt;=C2=A0 create mode 100644 include/erofs/iterate.h<br>
&gt;=C2=A0 create mode 100644 iterate/main.c<br>
&gt;=C2=A0 create mode 100644 lib/iterate.c<br>
&gt; <br>
&gt; -- <br>
&gt; 2.34.0.rc2.393.gf8c9666880-goog<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<div><br></div><div>K=
elvin Zhang</div></div></div>

--0000000000006bfa5205d16fd7fc--
