Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE03D5A17
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 15:11:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYL0L5q6Cz307L
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 23:11:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NIBwVE6E;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NIBwVE6E;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=NIBwVE6E; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NIBwVE6E; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYL0F1DSvz306G
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 23:11:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627305065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPL6SyJfCAcGFknIr89e6g6Y7tOrsxyCmKRCnF/Y8R0=;
 b=NIBwVE6EPsHiD8SwHPA/Mu5OtfZ0lbgi4oq6m+r2+TV9vhZZhINtVJ6cOMOXxFMF/ivvdU
 +ifIjIHASGwJ92EZHezojhDlAZ0OuLYSVXgmQpLMkQsYfDif3mAkOF4bxC+U9NWjhu/LxC
 R12HdjaeesYCqlYJcvgSFDLyBixrjqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627305065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPL6SyJfCAcGFknIr89e6g6Y7tOrsxyCmKRCnF/Y8R0=;
 b=NIBwVE6EPsHiD8SwHPA/Mu5OtfZ0lbgi4oq6m+r2+TV9vhZZhINtVJ6cOMOXxFMF/ivvdU
 +ifIjIHASGwJ92EZHezojhDlAZ0OuLYSVXgmQpLMkQsYfDif3mAkOF4bxC+U9NWjhu/LxC
 R12HdjaeesYCqlYJcvgSFDLyBixrjqk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-XQ4CC8WIN8y1EXOV848KuQ-1; Mon, 26 Jul 2021 09:11:04 -0400
X-MC-Unique: XQ4CC8WIN8y1EXOV848KuQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 v18-20020adfe2920000b029013bbfb19640so4694688wri.17
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 06:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=tPL6SyJfCAcGFknIr89e6g6Y7tOrsxyCmKRCnF/Y8R0=;
 b=gFJKW8nUo8BRBuSWNufv5PJ3h5izqcdep8arQ41yqa/7fA9FJrpNLbf/XUkqPpXnk2
 xf9jQEiUOkj/Cpl6V/gba1xOJ/NPgXx84qjytiyT3XscgaTfzxIb4rGlRQFeyEaA/JXj
 sIh49MAquHNYmle7gzGYlSTSnMqgRByYTdNkSRPzHsbdi8D+qoCTnr4oCD8xUPXW1vB7
 h8ZNaXc/+4KmqRhpTFGS0W9vXb3lHMl3AQjYCgoll60wGcvECaSjbLxeR1VG/opki1jr
 Yz4Zhc0t+WZWkvpoznN5FJ6jUD9HDuoy1g8KUW8duxGwtad+6vY5jJBuzGFFevpwAzhY
 wBeg==
X-Gm-Message-State: AOAM531SE+qpDKCg+zd8xD6zx9flYg5nO8SljVaAVApKcXTO+3LWsoty
 Ysi6I5tRCt6k4EHWpiPH+ibfGFQOiv69JwioSh6xAR8VimbEximKT5MefcjakGjJTwxRXpJiFrz
 xIlxmdK2lWYJVFb2ZhVTN02coGmjqI/ywSP5vKoeS
X-Received: by 2002:a1c:2282:: with SMTP id
 i124mr17092300wmi.166.1627305063112; 
 Mon, 26 Jul 2021 06:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyazdqGI0qehD4Mm0gUxh5ITfYFs2JsUFWs3CSE0J7pUjoTGjDY2Mt93MVWMQBRvSg882EFFsTvTDaZEHsMF0g=
X-Received: by 2002:a1c:2282:: with SMTP id
 i124mr17092287wmi.166.1627305062909; 
 Mon, 26 Jul 2021 06:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de>
 <CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com>
 <YP6vs180ThT1A2dO@B-P7TQMD6M-0146.local>
In-Reply-To: <YP6vs180ThT1A2dO@B-P7TQMD6M-0146.local>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 26 Jul 2021 15:10:51 +0200
Message-ID: <CAHc6FU6t84w-RoV7jyQmVAdvjEk6AcVVL6YkhBr10rNKs8DOrQ@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Huang Jianan <huangjianan@oppo.com>,
 linux-erofs@lists.ozlabs.org, 
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=agruenba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jul 26, 2021 at 2:51 PM Gao Xiang <hsiangkao@linux.alibaba.com> wro=
te:
> Hi Andreas, Christoph,
>
> On Mon, Jul 26, 2021 at 02:27:12PM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Mo., 26. Juli 2021 um 14:17 Uhr schrieb Christoph Hellwig <hch@lst.d=
e>:
> > >
> > > > Subject: iomap: Support tail packing
> > >
> > > I can't say I like this "tail packing" language here when we have the
> > > perfectly fine inline wording.  Same for various comments in the actu=
al
> > > code.
> > >
> > > > +     /* inline and tail-packed data must start page aligned in the=
 file */
> > > > +     if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > > > +             return -EIO;
> > > > +     if (WARN_ON_ONCE(size > PAGE_SIZE - offset_in_page(iomap->inl=
ine_data)))
> > > > +             return -EIO;
> > >
> > > Why can't we use iomap_inline_data_size_valid here?
> >
> > We can now. Gao, can you change that?
>
> Thank you all taking so much time on this! much appreciated.
>
> I'm fine to update that.
>
> >
> > > That is how can size be different from iomap->length?
> >
> > Quoting from my previous reply,
> >
> > "In the iomap_readpage case (iomap_begin with flags =3D=3D 0),
> > iomap->length will be the amount of data up to the end of the inode.
>
> For tail-packing cases, iomap->length is just the length of tail-packing
> inline extent.
>
> > In the iomap_file_buffered_write case (iomap_begin with flags =3D=3D
> > IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
> > (For extending writes, we need to write beyond the current end of
> > inode.) So iomap->length isn't all that useful for
> > iomap_read_inline_data."
>
> Ok, now it seems I get your point. For the current gfs2 inline cases:
>   iomap_write_begin
>     iomap_write_begin_inline
>       iomap_read_inline_data
>
> here, gfs2 passes a buffer instead with "iomap->length", maybe it
> could be larger than i_size_read(inode) for gfs2. Is that correct?
>
>         loff_t max_size =3D gfs2_max_stuffed_size(ip);
>
>         iomap->length =3D max_size;
>
> If that is what gfs2 currently does, I think it makes sense to
> temporarily use as this, but IMO, iomap->inline_bufsize is not
> iomap->length. These are 2 different concepts.
>
> >
> > > Shouldn't the offset_in_page also go into iomap_inline_data_size_vali=
d,
> > > which should probably be called iomap_inline_data_valid then?
> >
> > Hmm, not sure what you mean: iomap_inline_data_size_valid does take
> > offset_in_page(iomap->inline_data) into account.
> >
> > > >       if (iomap->type =3D=3D IOMAP_INLINE) {
> > > > +             int ret =3D iomap_read_inline_data(inode, page, iomap=
);
> > > > +             return ret ?: PAGE_SIZE;
> >
> > > The ?: expression without the first leg is really confuing.  Especial=
ly
> > > if a good old if is much more readable here.
> >
> > I'm sure Gao can change this.
> >
> > >                 int ret =3D iomap_read_inline_data(inode, page, iomap=
);
> > >
> > >                 if (ret)
> > >                         return ret;
> > >                 return PAGE_SIZE;
>
> I'm fine to update it if no strong opinion.
>
> > >
> > > > +             copied =3D copy_from_iter(iomap_inline_data(iomap, po=
s), length, iter);
> > >
> > >
> > > > +             copied =3D copy_to_iter(iomap_inline_data(iomap, pos)=
, length, iter);
> > >
> > > Pleae avoid the overly long lines.
> >
> > I thought people were okay with 80 character long lines?
>
> Christoph mentioned before as below:
> https://lore.kernel.org/linux-fsdevel/YPVe41YqpfGLNsBS@infradead.org/
>
> We also need to take the offset into account for the write side.
> I guess it would be nice to have a local variable for the inline
> address to not duplicate that calculation multiple times.

Fair enough, we could add a local variable:

  void *inline_data =3D iomap_inline_data(iomap, pos);

and use that in the copy_from_iter and copy_to_iter. Why not.

Thanks,
Andreas

