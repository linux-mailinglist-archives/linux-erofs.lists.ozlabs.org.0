Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136C7509B7
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 15:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689169173;
	bh=+evqX27DGBiWJkyZnqGeEHQI9QcDiX7JHwbrqFd6EpQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VcBP4ZHqYBiri+4OTjrG6hOpPh/fVoiPWi4KzjITDIK4GlXVMe4mhEhl3xqjKDCAw
	 dsXY5AeVIzEMH3c6jxszNynlSGJFViwbQ1AcXcybI0EGynmtD7SaijRuC5HfKetWO8
	 aequNBueBguZGyClbPjc3vBBkGjaeK+Nhk2Ulnnc6hZ3nPPbuhij3FeWzAjgLhveXE
	 UWy8iWk6LIllyDl9qJ+NM0NFnxH5B3oQUlPwqbF9V+Ll0mHvD/Nm4aFhWM3V33naRi
	 iHPOPKc8pRtzfT53ArbOGNFw7c7+LiquixIZtlU0RJy4MTRQ3xZTdF+kWqKMpazAp/
	 KRaYVi8QIoYoQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1JkY1zhNz3byl
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 23:39:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=HvU/baPM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=ionos.com (client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com; envelope-from=haris.iqbal@ionos.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1JkS72HHz3bsQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 23:39:25 +1000 (AEST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso11257460e87.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 06:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169161; x=1691761161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+evqX27DGBiWJkyZnqGeEHQI9QcDiX7JHwbrqFd6EpQ=;
        b=Sz3xpCWZpqGhDCY362mTSl+dbreN8065nc//4gQi1Jfxa/2PTzzwG/pMgAB+oAoaEi
         gwp4XL1yfncnxvBKJKK/3hPOAeS9cvnEreBHliSIUAdBlnX0GefNJE4kbsDqLA6BlGTa
         PeT6hT0Ja6tac5sSDxq3qh6qyiFXiujBAf9YCXTnC/qnNZZWeShT3an5NAmK862oOLsT
         PgRo0dC2H8V0h++Yo7YopkKwy8QaSXsREqhXdXNoPVsYhmrGfTqcAlgLnQSvTlHyOLFD
         FMkn6Hogaki9ykH/9ZX/tni4v+XHPpyTtfMvjtEVJ5PFdyb+g3flo7xbuAEI1/4EXf0O
         RE9A==
X-Gm-Message-State: ABy/qLZjeX5wgd8Zv8VV49M3ZTV0pqzskt72WVrx2Mca8/lKFkYKTKoi
	2nJe2r1/C1NpDQbmK+XnUKYD6u9pcBXjeawpdLnvBg==
X-Google-Smtp-Source: APBJJlEI1gyVFA9e0vzN1OZw8HqZ9LgUDYjdSVkcc/YNKBWyCbO3ruOl1C16YRvIxaIjAxVOOIhj+dxwF3VF9wwHpIo=
X-Received: by 2002:a05:6512:34cd:b0:4fb:82ac:9d23 with SMTP id
 w13-20020a05651234cd00b004fb82ac9d23mr13814794lfr.36.1689169161029; Wed, 12
 Jul 2023 06:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230629165206.383-1-jack@suse.cz> <20230704122224.16257-1-jack@suse.cz>
 <ZKbgAG5OoHVyUKOG@infradead.org>
In-Reply-To: <ZKbgAG5OoHVyUKOG@infradead.org>
Date: Wed, 12 Jul 2023 15:39:09 +0200
Message-ID: <CAJpMwyhKW23zEfMcsGrBG6Bq0Md40vZ4qj-PgDkR6KWPv8+7PQ@mail.gmail.com>
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
To: Christoph Hellwig <hch@infradead.org>
Content-Type: multipart/alternative; boundary="000000000000cf1dc906004a5728"
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
From: Haris Iqbal via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>, Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, xen-devel@lists.xenproject.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Kent Overstreet <kent.overstreet@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Jen
 s Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000cf1dc906004a5728
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 5:38=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:

> On Tue, Jul 04, 2023 at 02:21:28PM +0200, Jan Kara wrote:
> > Create struct bdev_handle that contains all parameters that need to be
> > passed to blkdev_put() and provide blkdev_get_handle_* functions that
> > return this structure instead of plain bdev pointer. This will
> > eventually allow us to pass one more argument to blkdev_put() without
> > too much hassle.
>
> Can we use the opportunity to come up with better names?  blkdev_get_*
> was always a rather horrible naming convention for something that
> ends up calling into ->open.
>
> What about:
>
> struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void
> *holder,
>                 const struct blk_holder_ops *hops);
> struct bdev_handle *bdev_open_by_path(dev_t dev, blk_mode_t mode,
>                 void *holder, const struct blk_holder_ops *hops);
> void bdev_release(struct bdev_handle *handle);
>

+1 to this.
Also, if we are removing "handle" from the function, should the name of the
structure it returns also change? Would something like bdev_ctx be better?


>
> ?
>

--000000000000cf1dc906004a5728
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 5:38=E2=80=AFP=
M Christoph Hellwig &lt;<a href=3D"mailto:hch@infradead.org">hch@infradead.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Tue, Jul 04, 2023 at 02:21:28PM +0200, Jan Kara wrote:<br>
&gt; Create struct bdev_handle that contains all parameters that need to be=
<br>
&gt; passed to blkdev_put() and provide blkdev_get_handle_* functions that<=
br>
&gt; return this structure instead of plain bdev pointer. This will<br>
&gt; eventually allow us to pass one more argument to blkdev_put() without<=
br>
&gt; too much hassle.<br>
<br>
Can we use the opportunity to come up with better names?=C2=A0 blkdev_get_*=
<br>
was always a rather horrible naming convention for something that<br>
ends up calling into -&gt;open.<br>
<br>
What about:<br>
<br>
struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *hold=
er,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct blk_ho=
lder_ops *hops);<br>
struct bdev_handle *bdev_open_by_path(dev_t dev, blk_mode_t mode,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *holder, const=
 struct blk_holder_ops *hops);<br>
void bdev_release(struct bdev_handle *handle);<br></blockquote><div><br></d=
iv><div>+1 to this.</div><div>Also, if we are removing &quot;handle&quot; f=
rom the function, should the name of the structure it returns also change? =
Would something like bdev_ctx be better?<br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
?<br>
</blockquote></div></div>

--000000000000cf1dc906004a5728--
