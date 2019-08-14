Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B68C9F5
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 05:53:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467bKB0N9CzDqZp
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 13:53:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDUzjZzm"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467bK160QzzDqWn
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2019 13:53:09 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id f22so5847110edt.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 20:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eFTwxVAuuVTeOrfNBrtNY1A96R72MYG/avRbGm83rfM=;
 b=YDUzjZzm6WN4PknJMsnNYBW+BENAHzRSUoHx/QItj/EaIWHjJRukTh8eDHoqTzYyWt
 7pTvUZP2gJNhWNNn7jPiErcexXW1ki4IQxStXO1DISbS8hsJpnS48l4zoSxn8Ws+VZzt
 aoX94GsTqOsgyrOOL4MVyv6kejLnjJ2MNDfk++7+1TlqsEvBwlz50W0nSB3mPs/wrek2
 13h9iN4ear2AVtQdr+C5Os6XPQ7IleV3BxgV0qpx/LQl1HNVUicQFX0k2H2tFmmGhWGq
 rzOyqvCrNo+pmm7SVvZ5qy1a50WU68/ADa+0eneFCTjXI4+w3F3KoVYyXnF1VIF7Gi/7
 rnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eFTwxVAuuVTeOrfNBrtNY1A96R72MYG/avRbGm83rfM=;
 b=lqhCnRrCpmxrHwmnDKjHvAqDBoRENbA6EoqE9URNtVYBwW3PWZYmlwUuUTzPoIPDKi
 PngShyhTSX/Dzr61PaYj4EboPV7lkvafVunbdEviRyGsdHkS6CdDM+TsTXbvRyroD01o
 3NA2uEsYGPkTWOe2X35/w0GASR6JRWj2Ok9XVNFRhmBVfd6+US5pIJTxYvuSKKi30My3
 rOULYhD4Fuv/4jt+acgg+OLorTEEjS2S17fbpV1ZGdPOJ3rm+o4UKFBVOrEyNALiwLdO
 bWE2vy596sEcI4bYFMG7p854pnMMItApLuIqoDm7ltMkZUUbEYkgFHvf4wDscKvfNgb6
 kGQg==
X-Gm-Message-State: APjAAAU30y/cvtHzAnMWDQusPsdcKwCvwlKPrI6WUQY1fT20jcCxcQc/
 rF7ngvJ9dqE74j4sMPE7T+pt6543QqVDzxVb17g=
X-Google-Smtp-Source: APXvYqwusFRit3vB456zVM1T9JttA6KdKIFNRDWIt5KmvatOsmVMvvRWIFNsnT4sL8rjsNjzRZR4pZDZxsl2oJBKOTw=
X-Received: by 2002:a17:906:a3c4:: with SMTP id
 ca4mr38329116ejb.5.1565754784841; 
 Tue, 13 Aug 2019 20:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190813203840.13782-1-pratikshinde320@gmail.com>
 <20190814015944.GA11254@138> <418907b6-0b6b-3b08-c6fd-939a206f061f@huawei.com>
 <20190814022442.GA28602@138>
In-Reply-To: <20190814022442.GA28602@138>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Wed, 14 Aug 2019 09:22:53 +0530
Message-ID: <CAGu0czT2z3Rx_PFot1mgZJ=X75N3pZoDeNDk5DNkyTcfZ7PBcg@mail.gmail.com>
Subject: Re: [PATCH] staging: erofs: removing an extra call to iloc() in
 fill_inode()
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000c1830d05900bb160"
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

--000000000000c1830d05900bb160
Content-Type: text/plain; charset="UTF-8"

Yes.since we already have a function with same name (and we are using it in
same context).
'inode_loc' was the most meaningful name I could come up with :)

--Pratik.

On Wed, Aug 14, 2019 at 7:37 AM Gao Xiang <gaoxiang25@huawei.com> wrote:

> On Wed, Aug 14, 2019 at 09:56:09AM +0800, Chao Yu wrote:
> > On 2019/8/14 9:59, Gao Xiang wrote:
> > > Hi Pratik,
> > >
> > > On Wed, Aug 14, 2019 at 02:08:40AM +0530, Pratik Shinde wrote:
> > >> in fill_inode() we call iloc() twice.Avoiding the extra call by
> > >> storing the result.
> > >>
> > >> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > >
> > > I have no objection of this patch, but I'd like to
> > > hear Chao/Greg's idea about this...
> >
> > It looks more clean. :)
> >
> > Nitpick, maybe change 'inode_loc' to shorter 'iloc' will be better.
>
> iloc is the name of static inline helper function in internal.h
> used for shorter lines...
>
> Thanks,
> Gao Xiang
>
> >
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >
> > Thanks,
> >
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > >> ---
> > >>  drivers/staging/erofs/inode.c | 7 ++++---
> > >>  1 file changed, 4 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/staging/erofs/inode.c
> b/drivers/staging/erofs/inode.c
> > >> index 4c3d8bf..d82ba6c 100644
> > >> --- a/drivers/staging/erofs/inode.c
> > >> +++ b/drivers/staging/erofs/inode.c
> > >> @@ -167,11 +167,12 @@ static int fill_inode(struct inode *inode, int
> isdir)
> > >>    int err;
> > >>    erofs_blk_t blkaddr;
> > >>    unsigned int ofs;
> > >> +  erofs_off_t inode_loc;
> > >>
> > >>    trace_erofs_fill_inode(inode, isdir);
> > >> -
> > >> -  blkaddr = erofs_blknr(iloc(sbi, vi->nid));
> > >> -  ofs = erofs_blkoff(iloc(sbi, vi->nid));
> > >> +  inode_loc = iloc(sbi, vi->nid);
> > >> +  blkaddr = erofs_blknr(inode_loc);
> > >> +  ofs = erofs_blkoff(inode_loc);
> > >>
> > >>    debugln("%s, reading inode nid %llu at %u of blkaddr %u",
> > >>            __func__, vi->nid, ofs, blkaddr);
> > >> --
> > >> 2.9.3
> > >>
> > > .
> > >
>

--000000000000c1830d05900bb160
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yes.since we already have a function with same name (=
and we are using it in same context).</div><div>&#39;inode_loc&#39; was the=
 most meaningful name I could come up with :)</div><div><br></div><div>--Pr=
atik.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Aug 14, 2019 at 7:37 AM Gao Xiang &lt;<a href=3D"ma=
ilto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Aug 14, 2019 at 09=
:56:09AM +0800, Chao Yu wrote:<br>
&gt; On 2019/8/14 9:59, Gao Xiang wrote:<br>
&gt; &gt; Hi Pratik,<br>
&gt; &gt; <br>
&gt; &gt; On Wed, Aug 14, 2019 at 02:08:40AM +0530, Pratik Shinde wrote:<br=
>
&gt; &gt;&gt; in fill_inode() we call iloc() twice.Avoiding the extra call =
by<br>
&gt; &gt;&gt; storing the result.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshin=
de320@gmail.com" target=3D"_blank">pratikshinde320@gmail.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; I have no objection of this patch, but I&#39;d like to<br>
&gt; &gt; hear Chao/Greg&#39;s idea about this...<br>
&gt; <br>
&gt; It looks more clean. :)<br>
&gt; <br>
&gt; Nitpick, maybe change &#39;inode_loc&#39; to shorter &#39;iloc&#39; wi=
ll be better.<br>
<br>
iloc is the name of static inline helper function in internal.h<br>
used for shorter lines...<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Reviewed-by: Chao Yu &lt;<a href=3D"mailto:yuchao0@huawei.com" target=
=3D"_blank">yuchao0@huawei.com</a>&gt;<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt; <br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 drivers/staging/erofs/inode.c | 7 ++++---<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/=
erofs/inode.c<br>
&gt; &gt;&gt; index 4c3d8bf..d82ba6c 100644<br>
&gt; &gt;&gt; --- a/drivers/staging/erofs/inode.c<br>
&gt; &gt;&gt; +++ b/drivers/staging/erofs/inode.c<br>
&gt; &gt;&gt; @@ -167,11 +167,12 @@ static int fill_inode(struct inode *ino=
de, int isdir)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 int err;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 erofs_blk_t blkaddr;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 unsigned int ofs;<br>
&gt; &gt;&gt; +=C2=A0 erofs_off_t inode_loc;<br>
&gt; &gt;&gt;=C2=A0 <br>
&gt; &gt;&gt;=C2=A0 =C2=A0 trace_erofs_fill_inode(inode, isdir);<br>
&gt; &gt;&gt; -<br>
&gt; &gt;&gt; -=C2=A0 blkaddr =3D erofs_blknr(iloc(sbi, vi-&gt;nid));<br>
&gt; &gt;&gt; -=C2=A0 ofs =3D erofs_blkoff(iloc(sbi, vi-&gt;nid));<br>
&gt; &gt;&gt; +=C2=A0 inode_loc =3D iloc(sbi, vi-&gt;nid);<br>
&gt; &gt;&gt; +=C2=A0 blkaddr =3D erofs_blknr(inode_loc);<br>
&gt; &gt;&gt; +=C2=A0 ofs =3D erofs_blkoff(inode_loc);<br>
&gt; &gt;&gt;=C2=A0 <br>
&gt; &gt;&gt;=C2=A0 =C2=A0 debugln(&quot;%s, reading inode nid %llu at %u o=
f blkaddr %u&quot;,<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, vi-&gt;nid=
, ofs, blkaddr);<br>
&gt; &gt;&gt; -- <br>
&gt; &gt;&gt; 2.9.3<br>
&gt; &gt;&gt;<br>
&gt; &gt; .<br>
&gt; &gt; <br>
</blockquote></div>

--000000000000c1830d05900bb160--
