Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E7921737B1D
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 08:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1687328348;
	bh=9OpV9zauX3/PpQEMss+/hozBAK3CX2VFbgtNS1if9DU=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YMCKTWEY2OL3zm7ZCN+mN+Z3+paFJ90k21xsQqj5kplYrzfubBdyZb8/JR2Ok+RMr
	 cm6O5Tusv2tssvrWvrLM+Akle+9prXUSjzM5oDAbZhNMxM3flR0QYedjtFM87n3Yz4
	 ZRzzuMODbfPyl/YDulpvWxE9LcNi8jSz7D1iKjmVFGwKqutsLuhZiQwFxYjqVe3vxv
	 vtPRJS+JNiw/M4KC9Dk4B6jjLaj6c1IjjgyTnWG9t+ML81jkZVQ50HrtZz9ux40f7H
	 o4GS+DfvHCBrNkJPuUaUzhHIp7YkHJ+znEcYN4cSW96xwopCB7jklWZUnKrQY78St1
	 N6j15ZLQ3AZdA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmCy454Qzz30hD
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 16:19:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=tNnX14jh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmCxz6RVWz2xTR
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 16:19:02 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8fa2cf847so54267305e9.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jun 2023 23:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687328337; x=1689920337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OpV9zauX3/PpQEMss+/hozBAK3CX2VFbgtNS1if9DU=;
        b=jaDIFbpam2ROKePNhG3lWS3r31TsUdzdDl/2RVSwMmYBUhAY0N6qXt8MnGaT/DyEMf
         iAGV/gC77s2reqmRbOcgS+aUzZ3+mybppxH/HC1Jz2rUr+zeM58jT6oASF50cpyYawpE
         7jjKt+aXF3lPpIVUWroEdZK4MwjexC5KS9YIwGy/oJENVz6nJFKRsFvMtdFFoRdbjRm8
         TpT/fqLB7AYc68RqicBHhCz2rnY5juP8dbaFgspeNwnr7w+nylXQ/k6q2Orp5yz2vBx2
         7+G2Fz3thnO2W50/ZJjkp4rqs/dniIs/eppJFIFTO6H4zuAS4KiwC8JEvCLlAUFu9Qko
         oyIw==
X-Gm-Message-State: AC+VfDwDrcbfRO8AHMHHNu7noXNhSkpSHFUFUJYsgfumul4l3TznjGTD
	xEN5ESloi9+JQRE7hUGA7zX6q5cjwskMDm1WBRewlg==
X-Google-Smtp-Source: ACHHUZ5BS6LwPotQd+Xi1rDMZma446Dg0JVNffoIlLJ9p0hndl1rd6wx/UHYklC1np8noGCklZ5W3nY3hFBKhR2APP0=
X-Received: by 2002:adf:e447:0:b0:311:1c14:3e43 with SMTP id
 t7-20020adfe447000000b003111c143e43mr12061207wrm.20.1687328337019; Tue, 20
 Jun 2023 23:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=BE-SoekaY1oS1wn383DtHngO2BO1-gsUY-STHk9ciKA1OYA@mail.gmail.com>
 <4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com> <CAB=BE-QV0PiKFpCOcdEUFxS4wJHsLCcsymAw+nP72Yr3b1WMng@mail.gmail.com>
 <9a8a07de-4364-3d06-4d48-2d51a74e1871@linux.alibaba.com>
In-Reply-To: <9a8a07de-4364-3d06-4d48-2d51a74e1871@linux.alibaba.com>
Date: Tue, 20 Jun 2023 23:18:45 -0700
Message-ID: <CAB=BE-S2QpatqeiH=s+xJOV=n0J=W6CBgJY_UUtJ8JYEd7mReg@mail.gmail.com>
Subject: Re: EROFS: Detecting atomic contexts
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jun 20, 2023 at 5:38=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Sandeep,
>
> On 2023/6/21 04:38, Sandeep Dhavale wrote:
> > Hi,
> > I think we are under RCU read lock in the stack at
> > blk_mq_flush_plug_list+0x2b0/0x354
> >
> > blk_mq_flush_plug_list calls blk_mq_run_dispatch_ops
> > which is a macro in block/blk-mq.h
> >
> > /* run the code block in @dispatch_ops with rcu/srcu read lock held */
> > #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> > do {                                                            \
> >          if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {          \
> >                  struct blk_mq_tag_set *__tag_set =3D (q)->tag_set; \
> >                  int srcu_idx;                                   \
> >                                                                  \
> >                  might_sleep_if(check_sleep);                    \
> >                  srcu_idx =3D srcu_read_lock(__tag_set->srcu);     \
> >                  (dispatch_ops);                                 \
> >                  srcu_read_unlock(__tag_set->srcu, srcu_idx);    \
> >          } else {                                                \
> >                  rcu_read_lock();                                \
> >                  (dispatch_ops);                                 \
> >                  rcu_read_unlock();                              \
> >          }                                                       \
> > } while (0)
> >
> > #define blk_mq_run_dispatch_ops(q, dispatch_ops)                \
> >          __blk_mq_run_dispatch_ops(q, true, dispatch_ops)        \
> >
> > As you can see if BLK_MQ_F_BLOCKING is not set then dispatch_ops is
> > called with rcu_read_lock().
> >
> > rcu_read_lock()
> >          __rcu_read_lock()
> >                  rcu_preempt_read_enter()
> >
> > In rcu_preempt_read_enter() increments the rcu_read_lock_nesting which
> > is detected later during mutex_lock() as a warning.
>
> Thanks for your analysis. That is much helpful to me.
> So it seems a new path which calls end_io under rcu read lock.
>
> >
> > Regarding use of !in_task(), that cannot detect rcu_read_lock_nesting
> > as far as I can tell so that may not be sufficient.
>
> rcu_preempt_depth is a too low level api, I'm not sure if it's a good
> way but we really don't want to trigger another workqueue here,
> could we just use:
>
> "!in_task() || irqs_disabled() || rcu_read_lock_any_held()"
>
I think this looks good. rcu_read_lock_any_held() can detect this.

Thanks,
Sandeep.

> Or do you have better ideas?
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Sandeep.
