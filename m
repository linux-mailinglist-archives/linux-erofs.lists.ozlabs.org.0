Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF06726CF
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 06:43:12 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tjQQ1S0KzDq7F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 14:43:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="q2O6jEaH"; 
 dkim-atps=neutral
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tf402XdzzDqBM
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 12:11:59 +1000 (AEST)
Received: by mail-ed1-x536.google.com with SMTP id p15so45646952eds.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 19:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cb+x5qNA3EdsdA38L2zA0o2zKHP8PcWO+rrgDZyFQUs=;
 b=q2O6jEaHU+9SJUnZyuEvRpkK6Vbqp1F2h6Jxi1Fh69OX7AI+mPG8QH9Hl11QI3Gfev
 fOc8/KCJGwGeyrZfDDEwE20Vb8Z3PmtXpHUie4Ki5WXleb7fjUMC5xA9dtbYIW0aHOkQ
 OHBYGC819Ci1p+TH5XVEINmM/w9BHPhx8cmXY5I3dQYTFNgnCyFqmspz/2kqSJLi72WL
 7t2argFhs2jD/Z/+zXrvcM0cHGE9XPPbZtQDR73wImxhTtwVFw8/ea+PjiW5H6jIdMJA
 qgkKTOF6mnmtM8rgr1/u59AJI/OMrJ0cdwfsUGiPFCM2AnzfIV80IZSrvY1LEG++IL+m
 gB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cb+x5qNA3EdsdA38L2zA0o2zKHP8PcWO+rrgDZyFQUs=;
 b=db3iB0HABHzAMt9RWlcoBS4ti/O+TEUS0mM038D+Pk4tr/MwxSbmza4qXGtTHCHXQu
 tZT0oPkqaJdTBS4j9ZJu0bd+ym+6En5QkQ365LkTG6X/g1C3Omcd22MSV8WLgxRWy1cz
 NZkuoAYWjLO8CoOxTK0GPlRo0vHLYElIRh9Aw5Qh9+hDgwu8VXrJvJGvKQuW0QLFcjRJ
 O+ijrgp+3+pd5X7MYLYUtLwHZEWSY2lXHjATXFtyAnOEink2B2zpPs1GkPx+h5dhMQ2R
 EypSC6GSQtg+Ilg8MvhafcsknDG33zDg3sBVbKLKCpJX1P/do/H+SO6mOLtVQ6796Aq4
 rRfw==
X-Gm-Message-State: APjAAAXsyLJrgC2R+oAfbpu3cgE023Lcg21JWGTam3tSg5t430lQHRyK
 Xz8QCgg/uei5QVNp/pQzhG59NOwsI9eyHXqoprg=
X-Google-Smtp-Source: APXvYqzCQeV8CSg9qTV/tRyl3KfzPN49L2irSkyUIp6yupoSEmZ9Q8D7e3wVJ5ckYq2hs/+TfSlCtcPDLvMb08W5FJs=
X-Received: by 2002:a17:906:6986:: with SMTP id
 i6mr59891760ejr.89.1563934316472; 
 Tue, 23 Jul 2019 19:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190723200429.7132-1-pratikshinde320@gmail.com>
 <980200eb-fa95-2de2-d68c-c52a323a540b@huawei.com>
In-Reply-To: <980200eb-fa95-2de2-d68c-c52a323a540b@huawei.com>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Wed, 24 Jul 2019 07:41:44 +0530
Message-ID: <CAGu0czQQmASDKw0VF4EN=A0hR56U09+TFxnUoxeG6HHO2APcOg@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: Add missing error code handling.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000062af8d058e63d5fa"
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

--00000000000062af8d058e63d5fa
Content-Type: text/plain; charset="UTF-8"

This is stranger. Even this mail of yours is not showing up in mail
archives. Let me resend the patch


-Pratik

On Wed, 24 Jul, 2019, 7:04 AM Gao Xiang, <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> This patch isn't in erofs mailing list. I don't know what is wrong...
> Could you resend the patch? It'd be better in the mailing list....
>
> On 2019/7/24 4:04, Pratik Shinde wrote:
> > Handling error conditions that are missing in few scenarios.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  lib/inode.c | 10 ++++++++--
> >  mkfs/main.c | 10 ++++++++--
> >  2 files changed, 16 insertions(+), 4 deletions(-)
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
> > +
> > +     ret = erofs_prepare_inode_buffer(dir);
> > +     if(!ret)
> > +             goto err_closedir;
> > +
> >       if (IS_ROOT(dir))
> >               erofs_fixup_meta_blkaddr(dir);
> >
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 1348587..9c9530d 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -200,18 +200,24 @@ int main(int argc, char **argv)
> >       if (err) {
> >               if (err == -EINVAL)
> >                       usage();
> > -             return 1;
> > +             return err;
>
> current erofs-utils will return 1; when failure...
> If you suggest to return the real error code, could you fix the following
> as well?
> and it should be return -err; since a positive error code is perfered? I
> have no idea....
>
> 253 exit:
> 254         z_erofs_compress_exit();
> 255         dev_close();
> 256         erofs_exit_configure();
> 257
> 258         if (err) {
> 259                 erofs_err("\tCould not format the device : %s\n",
> 260                           erofs_strerror(err));
> 261                 return 1;
> 262         }
> 263         return err;
>
> Thanks,
> Gao Xiang
>
> >       }
> >
> >       err = dev_open(cfg.c_img_path);
> >       if (err) {
> >               usage();
> > -             return 1;
> > +             return err;
> >       }
> >
> >       erofs_show_config();
> >
> >       sb_bh = erofs_buffer_init();
> > +     if(IS_ERR(sb_bh)) {
> > +             err = PTR_ERR(sb_bh);
> > +             erofs_err("Failed to initialize super block buffer head :
> %s",
> > +                       erofs_strerror(err));
> > +             goto exit;
> > +     }
> >       err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
> >       if (err < 0) {
> >               erofs_err("Failed to balloon erofs_super_block: %s",
> >
>

--00000000000062af8d058e63d5fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">This is stranger. Even this mail of yours is not showing =
up in mail archives. Let me resend the patch<div dir=3D"auto"><br></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">-Pratik</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 24 Jul, 201=
9, 7:04 AM Gao Xiang, &lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang=
25@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Pra=
tik,<br>
<br>
This patch isn&#39;t in erofs mailing list. I don&#39;t know what is wrong.=
..<br>
Could you resend the patch? It&#39;d be better in the mailing list....<br>
<br>
On 2019/7/24 4:04, Pratik Shinde wrote:<br>
&gt; Handling error conditions that are missing in few scenarios.<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmail.com</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/inode.c | 10 ++++++++--<br>
&gt;=C2=A0 mkfs/main.c | 10 ++++++++--<br>
&gt;=C2=A0 2 files changed, 16 insertions(+), 4 deletions(-)<br>
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
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D erofs_prepare_inode_buffer(dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if(!ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_closedir;<br=
>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ROOT(dir))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_fixup_meta=
_blkaddr(dir);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; index 1348587..9c9530d 100644<br>
&gt; --- a/mkfs/main.c<br>
&gt; +++ b/mkfs/main.c<br>
&gt; @@ -200,18 +200,24 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err =3D=3D -=
EINVAL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0usage();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
<br>
current erofs-utils will return 1; when failure...<br>
If you suggest to return the real error code, could you fix the following a=
s well?<br>
and it should be return -err; since a positive error code is perfered? I ha=
ve no idea....<br>
<br>
253 exit:<br>
254=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0z_erofs_compress_exit();<br>
255=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_close();<br>
256=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_exit_configure();<br>
257<br>
258=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
259=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(=
&quot;\tCould not format the device : %s\n&quot;,<br>
260=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_strerror(err));<br>
261=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<=
br>
262=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
263=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D dev_open(cfg.c_img_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_show_config();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb_bh =3D erofs_buffer_init();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if(IS_ERR(sb_bh)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D PTR_ERR(sb_bh=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Faile=
d to initialize super block buffer head : %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0erofs_strerror(err));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D erofs_bh_balloon(sb_bh, EROFS_SUPER_=
END);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;=
Failed to balloon erofs_super_block: %s&quot;,<br>
&gt; <br>
</blockquote></div>

--00000000000062af8d058e63d5fa--
