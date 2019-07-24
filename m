Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3EC72B33
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 11:12:22 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tqNz0xltzDqDG
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 19:12:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MF/dsBl1"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tqNt2chxzDq6q
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 19:12:14 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id x19so40535867eda.12
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VEyV2ECUU2yUb3nQFGyUme20tsFbcnPcztZRbyp2eqo=;
 b=MF/dsBl1IBxbh1l0vAQ8bjou0QwwBEDUoqE+JMOUi/IOWWevKskJClSiEoVRwDJ3lJ
 gJWWrJHaObU8DSMuAffJADV0UZPfCSqV6ECG/Zm6UKAAwTB/bS1qJeghHdStQRw4ZqBu
 SuJtYvmalnxL7sK/72QIjz4E3qV2AYvGqO4oPJkCULaWH3D1UCbZyhA5WfgVbkOZz7vd
 h3iV09KduRw7Q390sgvWfqGZyLtEIXcKIKwClniF6shQfnOl0o47PLkYu/F4nEcYSuYG
 LzBZE7d08gwEnIqpHLraQx6Nfvwxgjt5cKK7SZBPsDmi1yem7CFAeLO+74JnwUzFCTwY
 JfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VEyV2ECUU2yUb3nQFGyUme20tsFbcnPcztZRbyp2eqo=;
 b=suPfcUHV1g8XUdV8VG2WaTtDSHVtENSLuuxkzZgoUvI4jKT/oQ4DCbF/Y9a8usm7dm
 xb3Yq8KkUsF4lZigc4bwm6qYdVviGOBt514Xh/aEmlBwdbMp40uOqjGW0Z7fmtyWUYAR
 +bbeuadVVQapkQb8D9jiJbieDq6b+D7SkJ6wvk8f+sBaEqB4putxjY3d+oU+XIoZGoC8
 uYGSAhSKUm0PXjWBPCOlK9GA0cnCMGWWJpY1/4+QI+uqu5G3v4ZgAIjEJ3Sj1spIBftg
 QYoBDCqGnefI4jXqPNgfi1d9zKojs5raB6uMHtZQ3o/h5UiwoQQ65b+Igl+GtxS36MEn
 GicQ==
X-Gm-Message-State: APjAAAX5OzJR4E5+3ziOG98R2BDeUDLLysWq1w1/llRqgyXTOTtXB9RP
 TDcW8VyGdHlaDzj5qKswkZXFX8KZ6LXJh74lQqI=
X-Google-Smtp-Source: APXvYqwRZrgsNfseXqlPZiO6zgpxwoCUW9BOCIX/C1zAMT3pIBMxyj2c71pi21lUrqXsiKNnN51VYrb5U/V9Ra4ztro=
X-Received: by 2002:a17:906:e91:: with SMTP id
 p17mr62649439ejf.217.1563959530163; 
 Wed, 24 Jul 2019 02:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190724045519.8498-1-pratikshinde320@gmail.com>
 <485b94a5-969b-a90c-ad87-e7e871196ee8@huawei.com>
In-Reply-To: <485b94a5-969b-a90c-ad87-e7e871196ee8@huawei.com>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Wed, 24 Jul 2019 14:41:58 +0530
Message-ID: <CAGu0czTM7jxeJXz+juATvCa0NAgjZuh7DVHtYUUkn-BVVtGB-Q@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: Add missing error code handling.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000003d1236058e69b492"
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

--0000000000003d1236058e69b492
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

Thanks. and yes, the condition should be 'if (ret)' . Corrected it and few
others too. With the new patch I am able to create erofs image. Will send a
new patch with bumped up version.

-Pratik

On Wed, 24 Jul, 2019, 12:39 PM Gao Xiang, <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> On 2019/7/24 12:55, Pratik Shinde wrote:
> > Handling error conditions that are missed in few scenarios.
> > also, mkfs command should return 1 on failure and 0 on success.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  lib/inode.c | 10 ++++++++--
> >  mkfs/main.c |  8 +++++++-
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 179aa26..08d38c0 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -752,8 +752,14 @@ struct erofs_inode *erofs_mkfs_build_tree(struct
> erofs_inode *dir)
> >       }
> >       closedir(_dir);
> >
> > -     erofs_prepare_dir_file(dir);
> > -     erofs_prepare_inode_buffer(dir);
> > +     ret = erofs_prepare_dir_file(dir);
> > +     if(!ret)
> > +             goto err_closedir;
>
> Maybe it should be "if (ret)"? Have you use this patch to generate some
> images?
>
> if(!ret)
>   ^   --- no space here
>
> > +
> > +     ret = erofs_prepare_inode_buffer(dir);
> > +     if(!ret)
> > +             goto err_closedir;
>
> ditto.
>
> > +
> >       if (IS_ROOT(dir))
> >               erofs_fixup_meta_blkaddr(dir);
> >
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 1348587..f73eb10 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -212,6 +212,12 @@ int main(int argc, char **argv)
> >       erofs_show_config();
> >
> >       sb_bh = erofs_buffer_init();
> > +     if(IS_ERR(sb_bh)) {
> > +             err = PTR_ERR(sb_bh);
> > +             erofs_err("Failed to initialize super block buffer head :
> %s",
>
> erofs_err("Failed to initialize buffers: %s",
>
> Thanks,
> Gao Xiang
>
> > +                       erofs_strerror(err));
> > +             goto exit;
> > +     }
> >       err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
> >       if (err < 0) {
> >               erofs_err("Failed to balloon erofs_super_block: %s",
> > @@ -254,5 +260,5 @@ exit:
> >                         erofs_strerror(err));
> >               return 1;
> >       }
> > -     return err;
> > +     return 0;
> >  }
> >
>

--0000000000003d1236058e69b492
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">Than=
ks. and yes, the condition should be &#39;if (ret)&#39; . Corrected it and =
few others too. With the new patch I am able to create erofs image. Will se=
nd a new patch with bumped up version.=C2=A0</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">-Pratik</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, 24 Jul, 2019, 12:39 PM Gao Xiang,=
 &lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi Pratik,<br>
<br>
On 2019/7/24 12:55, Pratik Shinde wrote:<br>
&gt; Handling error conditions that are missed in few scenarios.<br>
&gt; also, mkfs command should return 1 on failure and 0 on success.<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmail.com</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/inode.c | 10 ++++++++--<br>
&gt;=C2=A0 mkfs/main.c |=C2=A0 8 +++++++-<br>
&gt;=C2=A0 2 files changed, 15 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; index 179aa26..08d38c0 100644<br>
&gt; --- a/lib/inode.c<br>
&gt; +++ b/lib/inode.c<br>
&gt; @@ -752,8 +752,14 @@ struct erofs_inode *erofs_mkfs_build_tree(struct =
erofs_inode *dir)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0closedir(_dir);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0erofs_prepare_dir_file(dir);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0erofs_prepare_inode_buffer(dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D erofs_prepare_dir_file(dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if(!ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_closedir;<br=
>
<br>
Maybe it should be &quot;if (ret)&quot;? Have you use this patch to generat=
e some images?<br>
<br>
if(!ret)<br>
=C2=A0 ^=C2=A0 =C2=A0--- no space here<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D erofs_prepare_inode_buffer(dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if(!ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_closedir;<br=
>
<br>
ditto.<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ROOT(dir))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_fixup_meta=
_blkaddr(dir);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; index 1348587..f73eb10 100644<br>
&gt; --- a/mkfs/main.c<br>
&gt; +++ b/mkfs/main.c<br>
&gt; @@ -212,6 +212,12 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_show_config();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb_bh =3D erofs_buffer_init();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if(IS_ERR(sb_bh)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D PTR_ERR(sb_bh=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Faile=
d to initialize super block buffer head : %s&quot;,<br>
<br>
erofs_err(&quot;Failed to initialize buffers: %s&quot;,<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0erofs_strerror(err));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D erofs_bh_balloon(sb_bh, EROFS_SUPER_=
END);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;=
Failed to balloon erofs_super_block: %s&quot;,<br>
&gt; @@ -254,5 +260,5 @@ exit:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0erofs_strerror(err));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; <br>
</blockquote></div>

--0000000000003d1236058e69b492--
