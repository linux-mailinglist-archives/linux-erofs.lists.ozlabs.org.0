Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1B4EEA86
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 11:36:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KVFRy3dvYz2yxS
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 20:36:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ehMc/HEY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::136;
 helo=mail-lf1-x136.google.com; envelope-from=hongyu.jin.cn@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=ehMc/HEY; dkim-atps=neutral
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KVFRv0Q4sz2yRK
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Apr 2022 20:36:42 +1100 (AEDT)
Received: by mail-lf1-x136.google.com with SMTP id bt26so3856123lfb.3
 for <linux-erofs@lists.ozlabs.org>; Fri, 01 Apr 2022 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cRXjG37eoMMDmJ84KXnvNQmhiWb0CWUjdxio6sNE4Q8=;
 b=ehMc/HEYYwRRAHvhhzFx2CmGrX7Zb1Ut2oGU/Wzt1CQqstuxTZuhEIO0d69DtXZaiK
 GXMNeZaGwAeZ2ooy1C/Z2k1xCOsmWGUGsW7wBlcYi37MBIKITfg0bh4caItIhVh/pHt/
 XG1F3eFNNHGZmML8kC/k/niDC8ocwjXzcpa492LXY+eiPAqsYIpHE9yrmgaed146WFe6
 gB9p+z/BIeFyKkWKnXLhC0ZKV6egqc4DVY3veEl1BtimID/iGwAkVKIOcv0nHbRyhdDT
 9jKsENtalQOAzXn7PzgGlM4gbbLp90m36MKg+SfFJk00DHsexC5WpOZsSPajI0ruGrqs
 VC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cRXjG37eoMMDmJ84KXnvNQmhiWb0CWUjdxio6sNE4Q8=;
 b=imcWlihHfq1Q/+rGUUs9qBSzm1NjJXaiHfNjh6VwxCKsiPRXPAvKRb/MVW6EX2z63z
 GQ2Tssba6qee9Tx79ERxjpmrYQVKLmwkF9R9pqAkJZIbjjloeu4M/o4ZKWSU03QvyQBQ
 ay7xo2gnJpGKYd5jqyd0si2MYWlPR0HJdNSPSQWXo5uS2N2EYVwVqC6pJtmrhILhQYcQ
 5JfshzA72u8d3uxr1MbJmGe9PXqSiLCbwPE/PafGaOA4RqmgzwxvUUvdjc3a7jlmXILS
 zxx9yn1RJpqdkFGsMHixrtuL3VvgdBT6w74tzsnqghniwk+2tr/XH3pH99oHAtERNu76
 xJJQ==
X-Gm-Message-State: AOAM530RoI2ig7GyJuhVbvUjVsvoYw5Jm5+6RN9DtLB5Xo5ivakZi2zJ
 XkP2yFkLRkVWPxbNndIeSNY5BYgHzSKy8/9XMeA=
X-Google-Smtp-Source: ABdhPJwOlL9xKpMDWuEyLjuEyYG2L5dSWjlxrtDwpI2zXrRHuPhRrsgD+Q46Risxg72exfyIEc6cQd7z6AygLuZjW6E=
X-Received: by 2002:a05:6512:308a:b0:44a:96cf:7ceb with SMTP id
 z10-20020a056512308a00b0044a96cf7cebmr13211890lfd.1.1648805795383; Fri, 01
 Apr 2022 02:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220401063301.3150-1-hongyu.jin.cn@gmail.com>
 <Ykah7AB8k6Abed+u@B-P7TQMD6M-0146.local>
In-Reply-To: <Ykah7AB8k6Abed+u@B-P7TQMD6M-0146.local>
From: Henry King <hongyu.jin.cn@gmail.com>
Date: Fri, 1 Apr 2022 17:36:23 +0800
Message-ID: <CAMQnb4P5c4-xajX_OY8wzhwhZBgktuijZJyQR_B9k+S4wNpo4Q@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix use-after-free of on-stack io[]
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=94 14:55=E5=86=99=E9=81=93=EF=BC=9A

>
> On Fri, Apr 01, 2022 at 02:33:01PM +0800, Hongyu Jin wrote:
> > From: Hongyu Jin <hongyu.jin@unisoc.com>
> >
> > The root cause is the race as follows(k5.4):
> > Thread #1                               Thread #2(irq ctx)
> >
> > z_erofs_submit_and_unzip()
> >   struct z_erofs_vle_unzip_io io_A[]
> >   submit bio A
> >                                         z_erofs_vle_read_endio() // bio=
 A
> >                                         z_erofs_vle_unzip_kickoff()
> >                                         spin_lock_irqsave()
> >                                         atomic_add_return()
> >   wait_event()
> >   [end of function]
> > z_erofs_submit_and_unzip() // bio B
> >                                         wake_up_locked(io_A[]) // crash
> >   struct z_erofs_vle_unzip_io io_B[]
> >   submit bio B
> >   wait_event()
>
> Thanks, good catch!
> Yet could you turn the race above into the current function names?
ok, I will chang it.
>
> >
> > Backtrace in kernel5.4:
> > [   10.129413] 8<--- cut here ---
> > [   10.129422] Unable to handle kernel paging request at virtual addres=
s eb0454a4
> > [   10.364157] CPU: 0 PID: 709 Comm: getprop Tainted: G        WC O    =
  5.4.147-ab09225 #1
> > [   11.556325] [<c01b33b8>] (__wake_up_common) from [<c01b3300>] (__wak=
e_up_locked+0x40/0x48)
> > [   11.565487] [<c01b3300>] (__wake_up_locked) from [<c044c8d0>] (z_ero=
fs_vle_unzip_kickoff+0x6c/0xc0)
> > [   11.575438] [<c044c8d0>] (z_erofs_vle_unzip_kickoff) from [<c044c854=
>] (z_erofs_vle_read_endio+0x16c/0x17c)
> > [   11.586082] [<c044c854>] (z_erofs_vle_read_endio) from [<c06a80e8>] =
(clone_endio+0xb4/0x1d0)
> > [   11.595428] [<c06a80e8>] (clone_endio) from [<c04a1280>] (blk_update=
_request+0x150/0x4dc)
> > [   11.604516] [<c04a1280>] (blk_update_request) from [<c06dea28>] (mmc=
_blk_cqe_complete_rq+0x144/0x15c)
> > [   11.614640] [<c06dea28>] (mmc_blk_cqe_complete_rq) from [<c04a5d90>]=
 (blk_done_softirq+0xb0/0xcc)
> > [   11.624419] [<c04a5d90>] (blk_done_softirq) from [<c010242c>] (__do_=
softirq+0x184/0x56c)
> > [   11.633419] [<c010242c>] (__do_softirq) from [<c01051e8>] (irq_exit+=
0xd4/0x138)
> > [   11.641640] [<c01051e8>] (irq_exit) from [<c010c314>] (__handle_doma=
in_irq+0x94/0xd0)
> > [   11.650381] [<c010c314>] (__handle_domain_irq) from [<c04fde70>] (gi=
c_handle_irq+0x50/0xd4)
> > [   11.659641] [<c04fde70>] (gic_handle_irq) from [<c0101b70>] (__irq_s=
vc+0x70/0xb0)
> >
> > Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> > ---
> >  fs/erofs/zdata.c | 12 ++++--------
> >  fs/erofs/zdata.h |  2 +-
> >  2 files changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 11c7a1aaebad..4c26faa817a3 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -782,12 +782,9 @@ static void z_erofs_decompress_kickoff(struct z_er=
ofs_decompressqueue *io,
> >
> >       /* wake up the caller thread for sync decompression */
> >       if (sync) {
> > -             unsigned long flags;
> > -
> > -             spin_lock_irqsave(&io->u.wait.lock, flags);
> >               if (!atomic_add_return(bios, &io->pending_bios))
> > -                     wake_up_locked(&io->u.wait);
> > -             spin_unlock_irqrestore(&io->u.wait.lock, flags);
> > +                     complete(&io->u.done);
> > +
> >               return;
> >       }
> >
> > @@ -1207,7 +1204,7 @@ jobqueue_init(struct super_block *sb,
> >       } else {
> >  fg_out:
> >               q =3D fgq;
> > -             init_waitqueue_head(&fgq->u.wait);
> > +             init_completion(&fgq->u.done);
> >               atomic_set(&fgq->pending_bios, 0);
> >       }
> >       q->sb =3D sb;
> > @@ -1370,8 +1367,7 @@ static void z_erofs_runqueue(struct super_block *=
sb,
> >               return;
> >
> >       /* wait until all bios are completed */
> > -     io_wait_event(io[JQ_SUBMIT].u.wait,
> > -                   !atomic_read(&io[JQ_SUBMIT].pending_bios));
> > +     wait_for_completion_io(&io[JQ_SUBMIT].u.done);
>
> Thanks, good catch!
>
> What if pending_bios is always 0 (nr_bios =3D=3D 0), is it possible?
The pending_bios isn't always 0.  If bio is completed faster before
io_wait_event() called, the value of pending_bios from 1 to 0,
when enter io_wait_event(), it will not acquire lock and return immediately=
.
>
> Thanks,
> Gao Xiang
