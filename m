Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 550CA96E96
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 02:55:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Cq316YWyzDrC1
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 10:55:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com;
 envelope-from=caitlynannefinn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcPpJMBI"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Cq2x3dwczDr9H
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 10:55:36 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id t3so1119256ioj.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iR8G1N2pn5zw/2pbGM5updLGGTj8m/gKgl37tcI/0dY=;
 b=GcPpJMBIVzBQNNhf/r4h8iRwRyGtXn0VwF89JpERe+MSwUHhh3CTWHesUaICHlg2WC
 TrcF0UnRnUFUM9t4wU5QIs5+igNvqBsDClqchEZBKPEn+vN6OSYIc1bFyxdx1oEZ//Bz
 QQtYl8eJk1a53QAean8Ez1Ox6KBM25WL0FYzR41MFEc8AYTC9JDUNvOQdzHpcEyR6TfM
 2yc4V3ycNINwVrAR201gazKNzzkXpGcghH1wxET15CNqBNMJLTkD0f8Y6bRAXs1jet+C
 XclEe57YBy4tgmVHNxOnXFGPmci5An9RZJ0QDhjxpsSUR7PwMAItfcinvLlA4r6H8P5a
 FYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iR8G1N2pn5zw/2pbGM5updLGGTj8m/gKgl37tcI/0dY=;
 b=S84GoIvcmbQyzP0BqWigkpTVZIR0Rn9z0vsTFbZF2ABHYP6WNLrYl3S2Yf2cnJLgPu
 2VcBkfjrhb5gbuV+tWCxlCo1YulW/5VJ5f15vSG3ikeSndWRroENlL9bOTFbkSgxJ+8n
 /kjqADFjUstDiem7+MlNhQ3+Bze/sHcU69BJQAgCBgr1UDWyF1RfWCsoXU/qcwWYFDaj
 V+6mu2UscXb7VVP8iEXnhyptJfgX5dauVM+aFLeu4NfrAVkMhjiaRyn9Uoimb5iqhTsZ
 znWr5K16e3mAH7KE4CwR7Dfv33JRvJUkbVF7q05uVCbvQsKSzGWk8VI2jZaY74g0CmCX
 gehw==
X-Gm-Message-State: APjAAAUm4LS6f7Mm78zDrGADkfZASGi88tFg1Gys/YZVcMSv8d1qdUKc
 tnUao0IOQfsW0+MZV3qKhoEXK6crE/2C9UHX7QY=
X-Google-Smtp-Source: APXvYqwN+BWZxeQ2Db43tqJE4fxuPo08rr7ubUsWlZ952Baotjyga6Hzpqrgg5NQlQybrJJKI9FRttDd9t2JRKIbq0M=
X-Received: by 2002:a02:bb8c:: with SMTP id g12mr3977162jan.116.1566348933275; 
 Tue, 20 Aug 2019 17:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
 <20190821004042.GB18606@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190821004042.GB18606@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Caitlyn Finn <caitlynannefinn@gmail.com>
Date: Tue, 20 Aug 2019 20:55:22 -0400
Message-ID: <CAG2TOUtTsQZxDLhqamanE4UfhoQ3yTk-XpqttUxm-3wWoz05BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="000000000000c3245d05909607ee"
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 "Tobin C . Harding" <me@tobin.cc>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000c3245d05909607ee
Content-Type: text/plain; charset="UTF-8"

Gao,

Thanks very much for your help and the prompt reply! Sorry for my mistake,
I will resolve and re-submit when I have an appropriate patch series.

Caitlyn Finn

On Tue, Aug 20, 2019 at 8:40 PM Gao Xiang <hsiangkao@aol.com> wrote:

> On Tue, Aug 20, 2019 at 08:18:20PM -0400, Caitlyn wrote:
> > Balanced braces to fix some checkpath warnings in inode.c and
> > unzip_vle.c
> >
> > Signed-off-by: Caitlyn <caitlynannefinn@gmail.com>
> > ---
> >  drivers/staging/erofs/inode.c     |  4 ++--
> >  drivers/staging/erofs/unzip_vle.c | 12 ++++++------
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/staging/erofs/inode.c
> b/drivers/staging/erofs/inode.c
> > index 4c3d8bf..8de6fcd 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -278,9 +278,9 @@ struct inode *erofs_iget(struct super_block *sb,
> >               vi->nid = nid;
> >
> >               err = fill_inode(inode, isdir);
> > -             if (likely(!err))
> > +             if (likely(!err)) {
> >                       unlock_new_inode(inode);
>
> The only valid place is here.
>
> Thanks,
> Gao Xiang
>
> > -             else {
> > +             } else {
> >                       iget_failed(inode);
> >                       inode = ERR_PTR(err);
> >               }
> > diff --git a/drivers/staging/erofs/unzip_vle.c
> b/drivers/staging/erofs/unzip_vle.c
> > index f0dab81..f431614 100644
> > --- a/drivers/staging/erofs/unzip_vle.c
> > +++ b/drivers/staging/erofs/unzip_vle.c
> > @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block
> *sb,
> >       mutex_lock(&work->lock);
> >       nr_pages = work->nr_pages;
> >
> > -     if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> > +     if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
> >               pages = pages_onstack;
> > -     else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > -              mutex_trylock(&z_pagemap_global_lock))
> > +     } else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > +              mutex_trylock(&z_pagemap_global_lock)) {
> >               pages = z_pagemap_global;
> > -     else {
> > +     } else {
> >  repeat:
> >               pages = kvmalloc_array(nr_pages, sizeof(struct page *),
> >                                      GFP_KERNEL);
> >
> >               /* fallback to global pagemap for the lowmem scenario */
> >               if (unlikely(!pages)) {
> > -                     if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
> > +                     if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES) {
> >                               goto repeat;
> > -                     else {
> > +                     } else {
> >                               mutex_lock(&z_pagemap_global_lock);
> >                               pages = z_pagemap_global;
> >                       }
> > --
> > 2.7.4
> >
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
>

--000000000000c3245d05909607ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Gao,</div><div><br></div><div>Thanks=
 very much for your help and the prompt reply! Sorry for my mistake, I will=
 resolve and re-submit when I have an appropriate patch series.</div><div><=
br></div><div>Caitlyn Finn<br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 20, 2019 at 8:40 PM Gao Xia=
ng &lt;<a href=3D"mailto:hsiangkao@aol.com">hsiangkao@aol.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Aug 20=
, 2019 at 08:18:20PM -0400, Caitlyn wrote:<br>
&gt; Balanced braces to fix some checkpath warnings in inode.c and<br>
&gt; unzip_vle.c<br>
&gt; <br>
&gt; Signed-off-by: Caitlyn &lt;<a href=3D"mailto:caitlynannefinn@gmail.com=
" target=3D"_blank">caitlynannefinn@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/erofs/inode.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<=
br>
&gt;=C2=A0 drivers/staging/erofs/unzip_vle.c | 12 ++++++------<br>
&gt;=C2=A0 2 files changed, 8 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/ino=
de.c<br>
&gt; index 4c3d8bf..8de6fcd 100644<br>
&gt; --- a/drivers/staging/erofs/inode.c<br>
&gt; +++ b/drivers/staging/erofs/inode.c<br>
&gt; @@ -278,9 +278,9 @@ struct inode *erofs_iget(struct super_block *sb,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;nid =3D n=
id;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D fill_ino=
de(inode, isdir);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (likely(!err))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (likely(!err)) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0unlock_new_inode(inode);<br>
<br>
The only valid place is here.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0iget_failed(inode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode =3D ERR_PTR(err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs=
/unzip_vle.c<br>
&gt; index f0dab81..f431614 100644<br>
&gt; --- a/drivers/staging/erofs/unzip_vle.c<br>
&gt; +++ b/drivers/staging/erofs/unzip_vle.c<br>
&gt; @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block =
*sb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;work-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nr_pages =3D work-&gt;nr_pages;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (likely(nr_pages &lt;=3D Z_EROFS_VLE_VMAP_ONST=
ACK_PAGES))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (likely(nr_pages &lt;=3D Z_EROFS_VLE_VMAP_ONST=
ACK_PAGES)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages =3D pages_=
onstack;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else if (nr_pages &lt;=3D Z_EROFS_VLE_VMAP_GLOBAL=
_PAGES &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_trylock(&amp;z=
_pagemap_global_lock))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else if (nr_pages &lt;=3D Z_EROFS_VLE_VMAP_GLOB=
AL_PAGES &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_trylock(&amp;z=
_pagemap_global_lock)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages =3D z_page=
map_global;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 repeat:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages =3D kvmall=
oc_array(nr_pages, sizeof(struct page *),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GFP_KERNEL);=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fallback to g=
lobal pagemap for the lowmem scenario */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!pa=
ges)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (nr_pages &gt; Z_EROFS_VLE_VMAP_GLOBAL_PAGES)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (nr_pages &gt; Z_EROFS_VLE_VMAP_GLOBAL_PAGES) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto repeat;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;z_pagemap_global_l=
ock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages =3D z_pagemap_global;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; devel mailing list<br>
&gt; <a href=3D"mailto:devel@linuxdriverproject.org" target=3D"_blank">deve=
l@linuxdriverproject.org</a><br>
&gt; <a href=3D"http://driverdev.linuxdriverproject.org/mailman/listinfo/dr=
iverdev-devel" rel=3D"noreferrer" target=3D"_blank">http://driverdev.linuxd=
riverproject.org/mailman/listinfo/driverdev-devel</a><br>
</blockquote></div></div>

--000000000000c3245d05909607ee--
