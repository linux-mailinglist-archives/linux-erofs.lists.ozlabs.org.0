Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6112116753
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Dec 2019 08:05:17 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47WZ2f6TWnzDqPy
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Dec 2019 18:05:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::544;
 helo=mail-ed1-x544.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2+dTlsg"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47WZ2V6L9hzDqPf
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 Dec 2019 18:05:06 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id dc19so11709364edb.10
 for <linux-erofs@lists.ozlabs.org>; Sun, 08 Dec 2019 23:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qL7rIBafrVoWFDCKVBDYeMErygHwSb86CHDkMfZeZMo=;
 b=U2+dTlsg9SH4wfQjlRNyla2iJ71GFbfEJ3bd5b/VXoIJ55WE1Qldmmxm16khWTWyVp
 u6Uj5RK3PC7ddQ9d2z6kpvEiy1pbUxdtebhE6UYMEto8ZX25GoHAIZnQgaPODQfVoNJS
 Z3dDkK/tZFyNbiTqOXF2mKQdaXSi7Ima1r7te7hMot8q9CmOQ/BRd5kjYSywEpxh3g5j
 8fo49wKefei1dwpodvrSBdCPLgCJD1QZF3hcqvXCIwy/zjYQu5MvLO0N1FDCLh9Vc3Q6
 KGiI8UxtNu8c7hmoQGuaod2DhoaAlqULHjxGRnXuDZ+Gi49IPEsLmbuatDhHgW17J3S/
 ETDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qL7rIBafrVoWFDCKVBDYeMErygHwSb86CHDkMfZeZMo=;
 b=RxvtBzwojvM7W2fwrXKQfrC92DMqxmbqA8nzxzRfGU3pcVOlgAmVdsMzunscVdHoTK
 9wc3oN+L1fP1LwzupxUxzpMa6a+BQJRn0iqLzQ/dtLHjnKx+VpvPnmAaOo80RQHOTOqz
 oDXeZ6qd/WP2wY2xSQ3Hg7Av5n0/VJanBV2tlr5G7TdPlGb9AvUJGYbRQcoz7TbL+3kP
 V/wDSa18u9BTzTKLi0JLxz9fr05YThdUZIm9IXUEgbMS/ReKiChLaBcCbegmsivbH7rV
 jBSPHBYT8yn94Kg+jxdypo4NfUxcAvbL7XrbKMLlUEi3yw1Q7KIBBYbfqfbR8pIb1nBN
 DcLw==
X-Gm-Message-State: APjAAAXYc9TTsjR6Sa6zfZsIizp+d4I0gbwcEziqw9vYEiQthyreXh5i
 IsO9/lbITAUmNguqQHnq1ki61JeZaUkiVZUkzJU=
X-Google-Smtp-Source: APXvYqz6H3Wgfd0e692ilX0EPb1+Cy33vgwe02vbqc28k7nq8iV+L0hAPhqD+ac9s9gb2fSFBChPsZ1b/8sC17rAj3U=
X-Received: by 2002:a17:907:11cc:: with SMTP id
 va12mr29268486ejb.164.1575875102295; 
 Sun, 08 Dec 2019 23:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20191203140250.23793-1-pratikshinde320@gmail.com>
 <20191204022734.GA60329@architecture4>
In-Reply-To: <20191204022734.GA60329@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Mon, 9 Dec 2019 12:34:50 +0530
Message-ID: <CAGu0czSNv--LQwrWXuzuT6S5BYs+tnCA8vqAREv7+Z4rEBdtsg@mail.gmail.com>
Subject: Re: [RFC] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000aeca960599400383"
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

--000000000000aeca960599400383
Content-Type: text/plain; charset="UTF-8"

Hello Gao,

Did you get any chance to look at this in detail.

--Pratik.

On Wed, Dec 4, 2019, 7:52 AM Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> I'll give detailed words this weekend if you have more questions
> since I'm busying in other stupid intra-company stuffs now...
>
> On Tue, Dec 03, 2019 at 07:32:50PM +0530, Pratik Shinde wrote:
> > NOTE: The patch is not fully complete yet, with this patch I just want to
> > present rough idea of what I am trying to achieve.
> >
> > The patch does following :
> > 1) Detect holes (of size EROFS_BLKSIZ) in uncompressed files.
> > 2) Keep track of holes per file.
> >
> > In-order to track holes, I used an array of size = (file_size /
> blocksize)
> > The array basically tracks number of holes before a particular logical
> file block.
> > e.g blks[i] = 10 meaning ith block has 10 holes before it.
> > If a particular block is a hole we set the index to '-1'.
> >
> > how read logic will change:
> > 1) currently we simply map read offset to a fs block.
> > 2) with holes in place the calculation of block number would be:
> >
> >    blkno = start_block + (offset >> block_size_shift) - (number of
> >                                                        holes before
> block in which offset falls)
> >
> > 3) If a read offset falls inside a hole (which can be found using above
> array). We
> >    fill the user buffer with '\0' on the fly.
> >
> > through this,block no. lookup would still be performed in constant time.
> >
> > The biggest problem with this approach is - we have to store the hole
> tracking
> > array for every file to the disk.Which doesn't seems to be practical.we
> can use a linkedlist,
> > but that will make size of inode variable.
>
> "variable-sized inode" isn't a problem here, which can be handled
> similar to the case of "compress indexes".
>
> Probably no need to write linked list to the disk but generate linked list
> in memory when writing data on the fly, and then transfer to a
> variable-sized
> extent array at the time of writing inode metadata (The order is firstly
> data
> and then metadata in erofs-utils so it looks practical.)
>
> Thanks,
> Gao Xiang
>
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  lib/inode.c | 67
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 0e19b11..af31949 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -38,6 +38,61 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
> S_SHIFT] = {
> >
> >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> >
> > +
> > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&
>       \
> > +                          roundup(end, EROFS_BLKSIZ) == end &&       \
> > +                         (end - start) % EROFS_BLKSIZ == 0)
> > +#define HOLE_BLK             -1
> > +unsigned int erofs_detect_holes(struct erofs_inode *inode, int *blks)
> > +{
> > +     int i, fd, st, en;
> > +     unsigned int nblocks;
> > +     erofs_off_t data, hole, len;
> > +
> > +     nblocks = inode->i_size / EROFS_BLKSIZ;
> > +     for (i = 0; i < nblocks; i++)
> > +             blks[i] = 0;
> > +     fd = open(inode->i_srcpath, O_RDONLY);
> > +     if (fd < 0) {
> > +             return -errno;
> > +     }
> > +     len = lseek(fd, 0, SEEK_END);
> > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > +             return -errno;
> > +     data = 0;
> > +     while (data < len) {
> > +             hole = lseek(fd, data, SEEK_HOLE);
> > +             if (hole == len)
> > +                     break;
> > +             data = lseek(fd, hole, SEEK_DATA);
> > +             if (data < 0 || hole > data) {
> > +                     return -EINVAL;
> > +             }
> > +             if (IS_HOLE(hole, data)) {
> > +                     st = hole >> S_SHIFT;
> > +                     en = data >> S_SHIFT;
> > +                     nblocks -= (en - st);
> > +                     for (i = st; i < en; i++)
> > +                             blks[i] = HOLE_BLK;
> > +             }
> > +     }
> > +     return nblocks;
> > +}
> > +
> > +int erofs_fill_holedata(int *blks, unsigned int nblocks) {
> > +     int i, nholes = 0;
> > +     for (i = 0; i < nblocks; i++) {
> > +             if (blks[i] == -1)
> > +                     nholes++;
> > +             else {
> > +                     blks[i] = nholes;
> > +                     if (nholes >= (i + 1))
> > +                             return -EINVAL;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> >  void erofs_inode_manager_init(void)
> >  {
> >       unsigned int i;
> > @@ -305,6 +360,7 @@ static bool erofs_file_is_compressible(struct
> erofs_inode *inode)
> >  int erofs_write_file(struct erofs_inode *inode)
> >  {
> >       unsigned int nblocks, i;
> > +     int *blks;
> >       int ret, fd;
> >
> >       if (!inode->i_size) {
> > @@ -322,7 +378,13 @@ int erofs_write_file(struct erofs_inode *inode)
> >       /* fallback to all data uncompressed */
> >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > -
> > +     blks = malloc(sizeof(int) * nblocks);
> > +     nblocks = erofs_detect_holes(inode, blks);
> > +     if (nblocks < 0)
> > +             return nblocks;
> > +     if ((ret = erofs_fill_holedata(blks, nblocks)) != 0) {
> > +             return ret;
> > +     }
> >       ret = __allocate_inode_bh_data(inode, nblocks);
> >       if (ret)
> >               return ret;
> > @@ -332,6 +394,8 @@ int erofs_write_file(struct erofs_inode *inode)
> >               return -errno;
> >
> >       for (i = 0; i < nblocks; ++i) {
> > +             if (blks[i] == HOLE_BLK)
> > +                     continue;
> >               char buf[EROFS_BLKSIZ];
> >
> >               ret = read(fd, buf, EROFS_BLKSIZ);
> > @@ -962,3 +1026,4 @@ struct erofs_inode
> *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> >       return erofs_mkfs_build_tree(inode);
> >  }
> >
> > +
> > --
> > 2.9.3
> >
>

--000000000000aeca960599400383
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">D=
id you get any chance to look at this in detail.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">--Pratik.</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 4, 2019, 7:52 AM Gao Xi=
ang &lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Pratik,<br>
<br>
I&#39;ll give detailed words this weekend if you have more questions<br>
since I&#39;m busying in other stupid intra-company stuffs now...<br>
<br>
On Tue, Dec 03, 2019 at 07:32:50PM +0530, Pratik Shinde wrote:<br>
&gt; NOTE: The patch is not fully complete yet, with this patch I just want=
 to<br>
&gt; present rough idea of what I am trying to achieve.<br>
&gt; <br>
&gt; The patch does following :<br>
&gt; 1) Detect holes (of size EROFS_BLKSIZ) in uncompressed files.<br>
&gt; 2) Keep track of holes per file.<br>
&gt; <br>
&gt; In-order to track holes, I used an array of size =3D (file_size / bloc=
ksize)<br>
&gt; The array basically tracks number of holes before a particular logical=
 file block.<br>
&gt; e.g blks[i] =3D 10 meaning ith block has 10 holes before it.<br>
&gt; If a particular block is a hole we set the index to &#39;-1&#39;.<br>
&gt; <br>
&gt; how read logic will change:<br>
&gt; 1) currently we simply map read offset to a fs block.<br>
&gt; 2) with holes in place the calculation of block number would be:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 blkno =3D start_block + (offset &gt;&gt; block_size_shift=
) - (number of <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 holes before block in =
which offset falls)<br>
&gt; <br>
&gt; 3) If a read offset falls inside a hole (which can be found using abov=
e array). We<br>
&gt;=C2=A0 =C2=A0 fill the user buffer with &#39;\0&#39; on the fly.<br>
&gt; <br>
&gt; through this,block no. lookup would still be performed in constant tim=
e.<br>
&gt; <br>
&gt; The biggest problem with this approach is - we have to store the hole =
tracking<br>
&gt; array for every file to the disk.Which doesn&#39;t seems to be practic=
al.we can use a linkedlist,<br>
&gt; but that will make size of inode variable.<br>
<br>
&quot;variable-sized inode&quot; isn&#39;t a problem here, which can be han=
dled<br>
similar to the case of &quot;compress indexes&quot;.<br>
<br>
Probably no need to write linked list to the disk but generate linked list<=
br>
in memory when writing data on the fly, and then transfer to a variable-siz=
ed<br>
extent array at the time of writing inode metadata (The order is firstly da=
ta<br>
and then metadata in erofs-utils so it looks practical.)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmail.com</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/inode.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++-<br>
&gt;=C2=A0 1 file changed, 66 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; index 0e19b11..af31949 100644<br>
&gt; --- a/lib/inode.c<br>
&gt; +++ b/lib/inode.c<br>
&gt; @@ -38,6 +38,61 @@ static unsigned char erofs_type_by_mode[S_IFMT &gt;=
&gt; S_SHIFT] =3D {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct list_head inode_hashtable[NR_INODE_HASHTABLE];<br>
&gt;=C2=A0 <br>
&gt; +<br>
&gt; +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) =3D=3D star=
t &amp;&amp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 roundup(end, EROFS_BLKSIZ) =3D=3D end &amp;&amp;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(end - start) % EROFS_BLKSIZ =3D=3D 0)<br>
&gt; +#define HOLE_BLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-1<br=
>
&gt; +unsigned int erofs_detect_holes(struct erofs_inode *inode, int *blks)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i, fd, st, en;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nblocks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_off_t data, hole, len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size / EROFS_BLKSIZ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; i++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blks[i] =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O_RDONLY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0len =3D lseek(fd, 0, SEEK_END);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (lseek(fd, 0, SEEK_SET) =3D=3D -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (data &lt; len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hole =3D lseek(fd, da=
ta, SEEK_HOLE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hole =3D=3D len)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D lseek(fd, ho=
le, SEEK_DATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data &lt; 0 || ho=
le &gt; data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_HOLE(hole, dat=
a)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0st =3D hole &gt;&gt; S_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0en =3D data &gt;&gt; S_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nblocks -=3D (en - st);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0for (i =3D st; i &lt; en; i++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blks[i] =3D HOLE_BLK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return nblocks;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int erofs_fill_holedata(int *blks, unsigned int nblocks) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i, nholes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (blks[i] =3D=3D -1=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nholes++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0blks[i] =3D nholes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (nholes &gt;=3D (i + 1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void erofs_inode_manager_init(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; @@ -305,6 +360,7 @@ static bool erofs_file_is_compressible(struct erof=
s_inode *inode)<br>
&gt;=C2=A0 int erofs_write_file(struct erofs_inode *inode)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int *blks;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode-&gt;i_size) {<br>
&gt; @@ -322,7 +378,13 @@ int erofs_write_file(struct erofs_inode *inode)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fallback to all data uncompressed */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datalayout =3D EROFS_INODE_FLAT_IN=
LINE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size / EROFS_BLKSIZ;=
<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0blks =3D malloc(sizeof(int) * nblocks);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nblocks =3D erofs_detect_holes(inode, blks);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (nblocks &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nblocks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((ret =3D erofs_fill_holedata(blks, nblocks)) =
!=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode, nblo=
cks);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; @@ -332,6 +394,8 @@ int erofs_write_file(struct erofs_inode *inode)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (blks[i] =3D=3D HO=
LE_BLK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[EROFS_B=
LKSIZ];<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D read(fd,=
 buf, EROFS_BLKSIZ);<br>
&gt; @@ -962,3 +1026,4 @@ struct erofs_inode *erofs_mkfs_build_tree_from_pa=
th(struct erofs_inode *parent,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_mkfs_build_tree(inode);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--000000000000aeca960599400383--
