Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EB11DE65
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2019 08:05:34 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Z1s74NjMzDrCX
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2019 18:05:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::543;
 helo=mail-ed1-x543.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HasSEe2V"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Z1rw04DlzDr6f
 for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2019 18:05:19 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id r21so1228560edq.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2019 23:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D50H7pVRKBXrbrSLqa6/PswqAXmU25s3WUYs3nT/oYE=;
 b=HasSEe2VO2PjGiEYzzh+iAlXb5w2tQfZhRMDnIw6TU0dPR+mF2a+SlNTgK7Aiqcc8t
 BRHlzd1oLcqDfNdsDmJkJfz4aOt4vzVc1TWugoZulWMNJVVQNtrUbYVgG0iU5dCttBS9
 Rt9sMGjg0ydryFzK/Wz2eUxCJylLpGSTP3dCDwZIZeZwjq/QxJ/3y+mLmk1euhAU+5+b
 mYH+naoywAIy8VjSh+MCD/p3WAtGQVxtLN2RP7Ab4YOXLPnarTftNGPda85UtKvgMfaS
 350W7LP090V3sdIIOB6jjy3AaCNvxC5ExYg/Xgdw+0umM5M/A1MP0/zOgtnBUKofFScK
 nKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D50H7pVRKBXrbrSLqa6/PswqAXmU25s3WUYs3nT/oYE=;
 b=FZHFgI0fLVDTJXqMj8IkqPEiawqI8ALfxbgA5u4c2VBEK/M0jGicy4R4pGVy1ZBVJz
 u6fxRm9qSZU6IZGBRD/YH+MmeNYdr2Wi1375fcI1Havygb8xMQUNNJ2KGf+bH1YXAwEc
 kC/sXA8tjTWwTAMXWGWx0V8LJM/WrGho1v+jpCWM9O7yV6WJoVrVPdf73n/E7Ji9uTyK
 JnUP1+zy0xsTtU7iEk6ezgHstW5LROxA2mw2RfNLUPVrvZlXimQyndPQTPhr6lVFLPPu
 GQBpmY4iLrkodoA1W3PIam9fIJ71JUJ6dU+twYrN/uLGWDSpV7e7/NYPXTJp1Z8z/I3i
 MmJg==
X-Gm-Message-State: APjAAAXxqzHPZjt0/naVcW5a6lKIDVisMQ+MYJyifFjr8BhaipO74X3F
 nLf5VxsnlOrrzRv1MM01Oigsr8ktR02Uo3NGevA=
X-Google-Smtp-Source: APXvYqwSTayZkku/KfkH91HGKSmtg1iNkoXYP3t3eSnem16QLsRUMBZQZs51Ewqg6z6oXCXOMIRlJ3/h1feeyAvw+2Q=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr14278491edr.164.1576220712142; 
 Thu, 12 Dec 2019 23:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20191203140250.23793-1-pratikshinde320@gmail.com>
 <20191204022734.GA60329@architecture4>
 <CAGu0czSNv--LQwrWXuzuT6S5BYs+tnCA8vqAREv7+Z4rEBdtsg@mail.gmail.com>
 <20191209071815.GA144654@architecture4> <20191211054917.GA28738@architecture4>
In-Reply-To: <20191211054917.GA28738@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Fri, 13 Dec 2019 12:35:00 +0530
Message-ID: <CAGu0czQ3wM_1TvwLmuMxtmnqr8yrCgngsmkocp8z3MztAqRL6g@mail.gmail.com>
Subject: Re: [RFC] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000a28cd90599907b90"
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
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000a28cd90599907b90
Content-Type: text/plain; charset="UTF-8"

Gao,

just returned from holidays. Let me rethink about this approach.

--Pratik


On Wed, Dec 11, 2019, 11:14 AM Gao Xiang <gaoxiang25@huawei.com> wrote:

> On Mon, Dec 09, 2019 at 03:18:17PM +0800, Gao Xiang wrote:
> > Hi Pratik,
> >
> > On Mon, Dec 09, 2019 at 12:34:50PM +0530, Pratik Shinde wrote:
> > > Hello Gao,
> > >
> > > Did you get any chance to look at this in detail.
> >
> > I looked into your implementation weeks before.
> >
> > As my reply in the previous email, did you see it and could you check it
> out?
> >
> > Kernel emails are not top-posting so you could scroll down to the end.
> >
> > > > "variable-sized inode" isn't a problem here, which can be handled
> > > > similar to the case of "compress indexes".
> > > >
> > > > Probably no need to write linked list to the disk but generate
> linked list
> > > > in memory when writing data on the fly, and then transfer to a
> > > > variable-sized
> > > > extent array at the time of writing inode metadata (The order is
> firstly
> > > > data
> > > > and then metadata in erofs-utils so it looks practical.)
>
>
> Some feedback words here? Do you think it is unnecessary to use such
> array for limited fragmented holes (either in-memory or ondisk) as well?
>
> Thanks,
> Gao Xiang
>
>
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > --Pratik.
> > >
> > > On Wed, Dec 4, 2019, 7:52 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
> > >
> > > > Hi Pratik,
> > > >
> > > > I'll give detailed words this weekend if you have more questions
> > > > since I'm busying in other stupid intra-company stuffs now...
> > > >
> > > > On Tue, Dec 03, 2019 at 07:32:50PM +0530, Pratik Shinde wrote:
> > > > > NOTE: The patch is not fully complete yet, with this patch I just
> want to
> > > > > present rough idea of what I am trying to achieve.
> > > > >
> > > > > The patch does following :
> > > > > 1) Detect holes (of size EROFS_BLKSIZ) in uncompressed files.
> > > > > 2) Keep track of holes per file.
> > > > >
> > > > > In-order to track holes, I used an array of size = (file_size /
> > > > blocksize)
> > > > > The array basically tracks number of holes before a particular
> logical
> > > > file block.
> > > > > e.g blks[i] = 10 meaning ith block has 10 holes before it.
> > > > > If a particular block is a hole we set the index to '-1'.
> > > > >
> > > > > how read logic will change:
> > > > > 1) currently we simply map read offset to a fs block.
> > > > > 2) with holes in place the calculation of block number would be:
> > > > >
> > > > >    blkno = start_block + (offset >> block_size_shift) - (number of
> > > > >                                                        holes before
> > > > block in which offset falls)
> > > > >
> > > > > 3) If a read offset falls inside a hole (which can be found using
> above
> > > > array). We
> > > > >    fill the user buffer with '\0' on the fly.
> > > > >
> > > > > through this,block no. lookup would still be performed in constant
> time.
> > > > >
> > > > > The biggest problem with this approach is - we have to store the
> hole
> > > > tracking
> > > > > array for every file to the disk.Which doesn't seems to be
> practical.we
> > > > can use a linkedlist,
> > > > > but that will make size of inode variable.
> > > >
> > > > "variable-sized inode" isn't a problem here, which can be handled
> > > > similar to the case of "compress indexes".
> > > >
> > > > Probably no need to write linked list to the disk but generate
> linked list
> > > > in memory when writing data on the fly, and then transfer to a
> > > > variable-sized
> > > > extent array at the time of writing inode metadata (The order is
> firstly
> > > > data
> > > > and then metadata in erofs-utils so it looks practical.)
> > > >
> > > > Thanks,
> > > > Gao Xiang
> > > >
> > > > >
> > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > > ---
> > > > >  lib/inode.c | 67
> > > > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 66 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/inode.c b/lib/inode.c
> > > > > index 0e19b11..af31949 100644
> > > > > --- a/lib/inode.c
> > > > > +++ b/lib/inode.c
> > > > > @@ -38,6 +38,61 @@ static unsigned char erofs_type_by_mode[S_IFMT
> >>
> > > > S_SHIFT] = {
> > > > >
> > > > >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> > > > >
> > > > > +
> > > > > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) ==
> start &&
> > > >       \
> > > > > +                          roundup(end, EROFS_BLKSIZ) == end &&
>    \
> > > > > +                         (end - start) % EROFS_BLKSIZ == 0)
> > > > > +#define HOLE_BLK             -1
> > > > > +unsigned int erofs_detect_holes(struct erofs_inode *inode, int
> *blks)
> > > > > +{
> > > > > +     int i, fd, st, en;
> > > > > +     unsigned int nblocks;
> > > > > +     erofs_off_t data, hole, len;
> > > > > +
> > > > > +     nblocks = inode->i_size / EROFS_BLKSIZ;
> > > > > +     for (i = 0; i < nblocks; i++)
> > > > > +             blks[i] = 0;
> > > > > +     fd = open(inode->i_srcpath, O_RDONLY);
> > > > > +     if (fd < 0) {
> > > > > +             return -errno;
> > > > > +     }
> > > > > +     len = lseek(fd, 0, SEEK_END);
> > > > > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > > > > +             return -errno;
> > > > > +     data = 0;
> > > > > +     while (data < len) {
> > > > > +             hole = lseek(fd, data, SEEK_HOLE);
> > > > > +             if (hole == len)
> > > > > +                     break;
> > > > > +             data = lseek(fd, hole, SEEK_DATA);
> > > > > +             if (data < 0 || hole > data) {
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > > +             if (IS_HOLE(hole, data)) {
> > > > > +                     st = hole >> S_SHIFT;
> > > > > +                     en = data >> S_SHIFT;
> > > > > +                     nblocks -= (en - st);
> > > > > +                     for (i = st; i < en; i++)
> > > > > +                             blks[i] = HOLE_BLK;
> > > > > +             }
> > > > > +     }
> > > > > +     return nblocks;
> > > > > +}
> > > > > +
> > > > > +int erofs_fill_holedata(int *blks, unsigned int nblocks) {
> > > > > +     int i, nholes = 0;
> > > > > +     for (i = 0; i < nblocks; i++) {
> > > > > +             if (blks[i] == -1)
> > > > > +                     nholes++;
> > > > > +             else {
> > > > > +                     blks[i] = nholes;
> > > > > +                     if (nholes >= (i + 1))
> > > > > +                             return -EINVAL;
> > > > > +             }
> > > > > +     }
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  void erofs_inode_manager_init(void)
> > > > >  {
> > > > >       unsigned int i;
> > > > > @@ -305,6 +360,7 @@ static bool erofs_file_is_compressible(struct
> > > > erofs_inode *inode)
> > > > >  int erofs_write_file(struct erofs_inode *inode)
> > > > >  {
> > > > >       unsigned int nblocks, i;
> > > > > +     int *blks;
> > > > >       int ret, fd;
> > > > >
> > > > >       if (!inode->i_size) {
> > > > > @@ -322,7 +378,13 @@ int erofs_write_file(struct erofs_inode
> *inode)
> > > > >       /* fallback to all data uncompressed */
> > > > >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> > > > >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > > > > -
> > > > > +     blks = malloc(sizeof(int) * nblocks);
> > > > > +     nblocks = erofs_detect_holes(inode, blks);
> > > > > +     if (nblocks < 0)
> > > > > +             return nblocks;
> > > > > +     if ((ret = erofs_fill_holedata(blks, nblocks)) != 0) {
> > > > > +             return ret;
> > > > > +     }
> > > > >       ret = __allocate_inode_bh_data(inode, nblocks);
> > > > >       if (ret)
> > > > >               return ret;
> > > > > @@ -332,6 +394,8 @@ int erofs_write_file(struct erofs_inode *inode)
> > > > >               return -errno;
> > > > >
> > > > >       for (i = 0; i < nblocks; ++i) {
> > > > > +             if (blks[i] == HOLE_BLK)
> > > > > +                     continue;
> > > > >               char buf[EROFS_BLKSIZ];
> > > > >
> > > > >               ret = read(fd, buf, EROFS_BLKSIZ);
> > > > > @@ -962,3 +1026,4 @@ struct erofs_inode
> > > > *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> > > > >       return erofs_mkfs_build_tree(inode);
> > > > >  }
> > > > >
> > > > > +
> > > > > --
> > > > > 2.9.3
> > > > >
> > > >
>

--000000000000a28cd90599907b90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">just re=
turned from holidays. Let me rethink about this approach.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">--Pratik</div><div dir=3D"auto"><br></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, Dec 11, 2019, 11:14 AM Gao Xiang &lt;<a href=3D"mailto:gaoxiang25@=
huawei.com">gaoxiang25@huawei.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Mon, Dec 09, 2019 at 03:18:17PM +0800, Gao Xiang wrote:<br=
>
&gt; Hi Pratik,<br>
&gt; <br>
&gt; On Mon, Dec 09, 2019 at 12:34:50PM +0530, Pratik Shinde wrote:<br>
&gt; &gt; Hello Gao,<br>
&gt; &gt; <br>
&gt; &gt; Did you get any chance to look at this in detail.<br>
&gt; <br>
&gt; I looked into your implementation weeks before.<br>
&gt; <br>
&gt; As my reply in the previous email, did you see it and could you check =
it out?<br>
&gt; <br>
&gt; Kernel emails are not top-posting so you could scroll down to the end.=
<br>
&gt; <br>
&gt; &gt; &gt; &quot;variable-sized inode&quot; isn&#39;t a problem here, w=
hich can be handled<br>
&gt; &gt; &gt; similar to the case of &quot;compress indexes&quot;.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Probably no need to write linked list to the disk but genera=
te linked list<br>
&gt; &gt; &gt; in memory when writing data on the fly, and then transfer to=
 a<br>
&gt; &gt; &gt; variable-sized<br>
&gt; &gt; &gt; extent array at the time of writing inode metadata (The orde=
r is firstly<br>
&gt; &gt; &gt; data<br>
&gt; &gt; &gt; and then metadata in erofs-utils so it looks practical.)<br>
<br>
<br>
Some feedback words here? Do you think it is unnecessary to use such<br>
array for limited fragmented holes (either in-memory or ondisk) as well?<br=
>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Gao Xiang<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; --Pratik.<br>
&gt; &gt; <br>
&gt; &gt; On Wed, Dec 4, 2019, 7:52 AM Gao Xiang &lt;<a href=3D"mailto:gaox=
iang25@huawei.com" target=3D"_blank" rel=3D"noreferrer">gaoxiang25@huawei.c=
om</a>&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; Hi Pratik,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;ll give detailed words this weekend if you have more q=
uestions<br>
&gt; &gt; &gt; since I&#39;m busying in other stupid intra-company stuffs n=
ow...<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Tue, Dec 03, 2019 at 07:32:50PM +0530, Pratik Shinde wrot=
e:<br>
&gt; &gt; &gt; &gt; NOTE: The patch is not fully complete yet, with this pa=
tch I just want to<br>
&gt; &gt; &gt; &gt; present rough idea of what I am trying to achieve.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The patch does following :<br>
&gt; &gt; &gt; &gt; 1) Detect holes (of size EROFS_BLKSIZ) in uncompressed =
files.<br>
&gt; &gt; &gt; &gt; 2) Keep track of holes per file.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; In-order to track holes, I used an array of size =3D (f=
ile_size /<br>
&gt; &gt; &gt; blocksize)<br>
&gt; &gt; &gt; &gt; The array basically tracks number of holes before a par=
ticular logical<br>
&gt; &gt; &gt; file block.<br>
&gt; &gt; &gt; &gt; e.g blks[i] =3D 10 meaning ith block has 10 holes befor=
e it.<br>
&gt; &gt; &gt; &gt; If a particular block is a hole we set the index to &#3=
9;-1&#39;.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; how read logic will change:<br>
&gt; &gt; &gt; &gt; 1) currently we simply map read offset to a fs block.<b=
r>
&gt; &gt; &gt; &gt; 2) with holes in place the calculation of block number =
would be:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 blkno =3D start_block + (offset &gt;&gt; b=
lock_size_shift) - (number of<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 holes be=
fore<br>
&gt; &gt; &gt; block in which offset falls)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; 3) If a read offset falls inside a hole (which can be f=
ound using above<br>
&gt; &gt; &gt; array). We<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 fill the user buffer with &#39;\0&#39; on =
the fly.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; through this,block no. lookup would still be performed =
in constant time.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The biggest problem with this approach is - we have to =
store the hole<br>
&gt; &gt; &gt; tracking<br>
&gt; &gt; &gt; &gt; array for every file to the disk.Which doesn&#39;t seem=
s to be practical.we<br>
&gt; &gt; &gt; can use a linkedlist,<br>
&gt; &gt; &gt; &gt; but that will make size of inode variable.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &quot;variable-sized inode&quot; isn&#39;t a problem here, w=
hich can be handled<br>
&gt; &gt; &gt; similar to the case of &quot;compress indexes&quot;.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Probably no need to write linked list to the disk but genera=
te linked list<br>
&gt; &gt; &gt; in memory when writing data on the fly, and then transfer to=
 a<br>
&gt; &gt; &gt; variable-sized<br>
&gt; &gt; &gt; extent array at the time of writing inode metadata (The orde=
r is firstly<br>
&gt; &gt; &gt; data<br>
&gt; &gt; &gt; and then metadata in erofs-utils so it looks practical.)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; Gao Xiang<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:prat=
ikshinde320@gmail.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320=
@gmail.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 lib/inode.c | 67<br>
&gt; &gt; &gt; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
-<br>
&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 66 insertions(+), 1 deletion(-)<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; &gt; &gt; &gt; index 0e19b11..af31949 100644<br>
&gt; &gt; &gt; &gt; --- a/lib/inode.c<br>
&gt; &gt; &gt; &gt; +++ b/lib/inode.c<br>
&gt; &gt; &gt; &gt; @@ -38,6 +38,61 @@ static unsigned char erofs_type_by_m=
ode[S_IFMT &gt;&gt;<br>
&gt; &gt; &gt; S_SHIFT] =3D {<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 struct list_head inode_hashtable[NR_INODE_HASHTAB=
LE];<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKS=
IZ) =3D=3D start &amp;&amp;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 roundup(end, EROFS_BLKSIZ) =3D=3D en=
d &amp;&amp;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(end - start) % EROFS_BLKSIZ =3D=3D 0=
)<br>
&gt; &gt; &gt; &gt; +#define HOLE_BLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0-1<br>
&gt; &gt; &gt; &gt; +unsigned int erofs_detect_holes(struct erofs_inode *in=
ode, int *blks)<br>
&gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int i, fd, st, en;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nblocks;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_off_t data, hole, len;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size / ERO=
FS_BLKSIZ;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; i++)=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blks[i=
] =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O=
_RDONLY);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -errno;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0len =3D lseek(fd, 0, SEEK_END);<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (lseek(fd, 0, SEEK_SET) =3D=3D =
-1)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -errno;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0data =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0while (data &lt; len) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hole =
=3D lseek(fd, data, SEEK_HOLE);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ho=
le =3D=3D len)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =
=3D lseek(fd, hole, SEEK_DATA);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (da=
ta &lt; 0 || hole &gt; data) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS=
_HOLE(hole, data)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0st =3D hole &gt;&gt; S_SHIFT;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0en =3D data &gt;&gt; S_SHIFT;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0nblocks -=3D (en - st);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D st; i &lt; en; i++)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blks[i] =3D HOLE_BLK;<b=
r>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return nblocks;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +int erofs_fill_holedata(int *blks, unsigned int nblock=
s) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int i, nholes =3D 0;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; i++)=
 {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bl=
ks[i] =3D=3D -1)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0nholes++;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {=
<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0blks[i] =3D nholes;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (nholes &gt;=3D (i + 1))<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 void erofs_inode_manager_init(void)<br>
&gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; &gt; &gt; &gt; @@ -305,6 +360,7 @@ static bool erofs_file_is_compressi=
ble(struct<br>
&gt; &gt; &gt; erofs_inode *inode)<br>
&gt; &gt; &gt; &gt;=C2=A0 int erofs_write_file(struct erofs_inode *inode)<b=
r>
&gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int *blks;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode-&gt;i_size) {<br>
&gt; &gt; &gt; &gt; @@ -322,7 +378,13 @@ int erofs_write_file(struct erofs_=
inode *inode)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fallback to all data uncom=
pressed */<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datalayout =3D EROF=
S_INODE_FLAT_INLINE;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size =
/ EROFS_BLKSIZ;<br>
&gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0blks =3D malloc(sizeof(int) * nblo=
cks);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0nblocks =3D erofs_detect_holes(ino=
de, blks);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (nblocks &lt; 0)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 nblocks;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if ((ret =3D erofs_fill_holedata(b=
lks, nblocks)) !=3D 0) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 ret;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_d=
ata(inode, nblocks);<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn ret;<br>
&gt; &gt; &gt; &gt; @@ -332,6 +394,8 @@ int erofs_write_file(struct erofs_i=
node *inode)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn -errno;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks;=
 ++i) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bl=
ks[i] =3D=3D HOLE_BLK)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
har buf[EROFS_BLKSIZ];<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
et =3D read(fd, buf, EROFS_BLKSIZ);<br>
&gt; &gt; &gt; &gt; @@ -962,3 +1026,4 @@ struct erofs_inode<br>
&gt; &gt; &gt; *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,=
<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_mkfs_build_tree(=
inode);<br>
&gt; &gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; 2.9.3<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
</blockquote></div>

--000000000000a28cd90599907b90--
