Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9916FA1C6D
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 16:10:00 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K4Hm72mbzDrVN
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 00:09:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NMarhWpk"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K4CJ1Hw5zDqcj
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 00:06:03 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id a21so4183744edt.11
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2019 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MHmax9RaV/D3pn9ltZmqXl/W4rWpOqNPTmJlQcv1lRU=;
 b=NMarhWpkxcPN9iW0UPn+BKgtXgOCePdqc84Jrjh5kk8ARXbqmf+fLzHQHgPvJmbOgB
 3IS2HBzyJpXXID5150WGKQzFx0mbxR5umlIje37QTSKpz6oDVsbch3j2z5o02ER9KRYY
 YcM+5JUmcixd2HuxNSMa8xfB2Bn0dBdalmp/EyQIpoepWg5S1Q57bybmhwr28kY2dToe
 4xhFMwNaqK3jUDTw/mRG76NC80VzM5vtcyW7SI788eW2zTp0xIMScPYASdr1s9zoWV5s
 hQLmQ0GjSNRt0itmV+OVm4gYCoBAS4ypOc7NL5umj/3nSSUMx7O/kIt0NX58Z8XQfJYu
 GFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MHmax9RaV/D3pn9ltZmqXl/W4rWpOqNPTmJlQcv1lRU=;
 b=HvlAnFLhonyUCll3IBSy/DqhFYmBntnUeE0JgrXbdWSEBel7Ga6LnO/igBA1UJZR6s
 KmFnUbaJAW50pfacIeZ3EgXrWPNvYOEaTRIKhrcPjsfUwLbsUvro8PBkETuVPk4Dytd3
 tXHe5Sp0CNJx5c1jUJ9ogJD8gj9aKr8AkLeiB+4aLxPVJ7QVr/b02t67aEJzp4EIW+kI
 T6uh7azR/2ILQNMSOp7xXY1g4cbz6qlLypf7iOxBaxMUShdhkHdNtbZZishKPtXgiimT
 J/RIDXKiksDSAPJgSXC6qexMaYj7hxnX5rxUE1o5xL46WBTSc/tu43qvuUALD9IqDg/Z
 wZUg==
X-Gm-Message-State: APjAAAXNY1MGdTjyOeWhv1PqWiIemWmhNwOosbAmfAez+UyM71vEuzEX
 W2HRTUjKgCMlCr+yhJC4LHo1wnn7EyCLqzHPyuQ=
X-Google-Smtp-Source: APXvYqyZwUE9J9mgXaMbMrsRBopmrkxB1Une1bqBdWJnKgBHCKcFbCnKkM+cuM3DgVuBITWkWu5C3xvtXWkJvap70eY=
X-Received: by 2002:aa7:ce89:: with SMTP id y9mr9962385edv.135.1567087556947; 
 Thu, 29 Aug 2019 07:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190829130813.11721-1-pratikshinde320@gmail.com>
 <20190829135607.GA195010@architecture4>
In-Reply-To: <20190829135607.GA195010@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Thu, 29 Aug 2019 19:35:01 +0530
Message-ID: <CAGu0czRasWHj53uF5zAoDRjbxU2sgN6HtazN_9Y-mkK6NjO-LQ@mail.gmail.com>
Subject: Re: [PATCH] staging: erofs: using switch-case while checking the
 inode type.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000029f2440591420154"
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000029f2440591420154
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

Sorry I didn't pull the latest tree. I will do the necessary.
Anyways, don't you think it will be cleaner to have a switch case statement
rather than if-else statement.

--Pratik



On Thu, 29 Aug, 2019, 7:27 PM Gao Xiang, <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> On Thu, Aug 29, 2019 at 06:38:13PM +0530, Pratik Shinde wrote:
> > while filling the linux inode, using switch-case statement to check
> > the type of inode.
> > switch-case statement looks more clean.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
>
> No, that is not the case, see __ext4_iget() in fs/ext4/inode.c.
> and could you write patches based on latest staging tree?
> erofs is now in "fs/" rather than "drivers/staging".
> and I will review it then.
>
> p.s. if someone argues here or there, there will be endless
> issues since there is no standard at all.
>
> Thanks,
> Gao Xiang
>
> > ---
> >  drivers/staging/erofs/inode.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/erofs/inode.c
> b/drivers/staging/erofs/inode.c
> > index 4c3d8bf..2d2d545 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -190,22 +190,28 @@ static int fill_inode(struct inode *inode, int
> isdir)
> >       err = read_inode(inode, data + ofs);
> >       if (!err) {
> >               /* setup the new inode */
> > -             if (S_ISREG(inode->i_mode)) {
> > +             switch (inode->i_mode & S_IFMT) {
> > +             case S_IFREG:
> >                       inode->i_op = &erofs_generic_iops;
> >                       inode->i_fop = &generic_ro_fops;
> > -             } else if (S_ISDIR(inode->i_mode)) {
> > +                     break;
> > +             case S_IFDIR:
> >                       inode->i_op = &erofs_dir_iops;
> >                       inode->i_fop = &erofs_dir_fops;
> > -             } else if (S_ISLNK(inode->i_mode)) {
> > +                     break;
> > +             case S_IFLNK:
> >                       /* by default, page_get_link is used for symlink */
> >                       inode->i_op = &erofs_symlink_iops;
> >                       inode_nohighmem(inode);
> > -             } else if (S_ISCHR(inode->i_mode) ||
> S_ISBLK(inode->i_mode) ||
> > -                     S_ISFIFO(inode->i_mode) ||
> S_ISSOCK(inode->i_mode)) {
> > +                     break;
> > +             case S_IFCHR:
> > +             case S_IFBLK:
> > +             case S_IFIFO:
> > +             case S_IFSOCK:
> >                       inode->i_op = &erofs_generic_iops;
> >                       init_special_inode(inode, inode->i_mode,
> inode->i_rdev);
> >                       goto out_unlock;
> > -             } else {
> > +             default:
> >                       err = -EIO;
> >                       goto out_unlock;
> >               }
> > --
> > 2.9.3
> >
>

--00000000000029f2440591420154
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">Sorr=
y I didn&#39;t pull the latest tree. I will do the necessary.=C2=A0</div><d=
iv dir=3D"auto">Anyways, don&#39;t you think it will be cleaner to have a s=
witch case statement rather than if-else statement.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">--Pratik</div><div dir=3D"auto"><div dir=3D"aut=
o"><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div></div></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
hu, 29 Aug, 2019, 7:27 PM Gao Xiang, &lt;<a href=3D"mailto:gaoxiang25@huawe=
i.com">gaoxiang25@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi Pratik,<br>
<br>
On Thu, Aug 29, 2019 at 06:38:13PM +0530, Pratik Shinde wrote:<br>
&gt; while filling the linux inode, using switch-case statement to check<br=
>
&gt; the type of inode.<br>
&gt; switch-case statement looks more clean.<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmail.com</a>&=
gt;<br>
<br>
No, that is not the case, see __ext4_iget() in fs/ext4/inode.c.<br>
and could you write patches based on latest staging tree?<br>
erofs is now in &quot;fs/&quot; rather than &quot;drivers/staging&quot;.<br=
>
and I will review it then.<br>
<br>
p.s. if someone argues here or there, there will be endless<br>
issues since there is no standard at all.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/erofs/inode.c | 18 ++++++++++++------<br>
&gt;=C2=A0 1 file changed, 12 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/ino=
de.c<br>
&gt; index 4c3d8bf..2d2d545 100644<br>
&gt; --- a/drivers/staging/erofs/inode.c<br>
&gt; +++ b/drivers/staging/erofs/inode.c<br>
&gt; @@ -190,22 +190,28 @@ static int fill_inode(struct inode *inode, int i=
sdir)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D read_inode(inode, data + ofs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* setup the new=
 inode */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (S_ISREG(inode-&gt=
;i_mode)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (inode-&gt;i_m=
ode &amp; S_IFMT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFREG:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode-&gt;i_op =3D &amp;erofs_generic_iops;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode-&gt;i_fop =3D &amp;generic_ro_fops;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (S_ISDIR(in=
ode-&gt;i_mode)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFDIR:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode-&gt;i_op =3D &amp;erofs_dir_iops;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode-&gt;i_fop =3D &amp;erofs_dir_fops;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (S_ISLNK(in=
ode-&gt;i_mode)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFLNK:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* by default, page_get_link is used for symlink */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode-&gt;i_op =3D &amp;erofs_symlink_iops;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode_nohighmem(inode);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (S_ISCHR(in=
ode-&gt;i_mode) || S_ISBLK(inode-&gt;i_mode) ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0S_ISFIFO(inode-&gt;i_mode) || S_ISSOCK(inode-&gt;i_mode)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFCHR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFBLK:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFIFO:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case S_IFSOCK:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode-&gt;i_op =3D &amp;erofs_generic_iops;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0init_special_inode(inode, inode-&gt;i_mode, inode-&gt;i_rdev);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto out_unlock;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0err =3D -EIO;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto out_unlock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--00000000000029f2440591420154--
