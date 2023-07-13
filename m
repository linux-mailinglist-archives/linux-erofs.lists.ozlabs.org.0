Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A9D75272C
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 17:33:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=K4aglIY7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1zCz3kLhz3c4v
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 01:33:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=K4aglIY7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=joelfernandes.org (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=joel@joelfernandes.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1zCt14j5z3c3q
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 01:33:44 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f954d7309fso1051749e87.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689262417; x=1691854417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0ym5xH/1YGuvDjsQ/zPTyHw/VcGdmnjHCR3gjE6Czs=;
        b=K4aglIY7Cjx6mxk6XXEEsWyNR84LENYDBY9kBPae4ZMDFOyBVnuSalrbABemFMPFem
         54TG8CNgqNdnNOkDQMhuIjArSJwUo+1lbxO8g3EQas0cl4Vkto0bDIYEFm7OFUPkUZmz
         j3otXi0h/k3C8lVxm/cH/Cs8P+xbH1BJwPy6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262417; x=1691854417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0ym5xH/1YGuvDjsQ/zPTyHw/VcGdmnjHCR3gjE6Czs=;
        b=QhaEjzcZ6hivvWimBTBHmto+GoQArOIJbZHZct5m2ld4tZ9zA4rm0WOlxBbFjp0Jvi
         RA7HJUBgdnQypcu/7t4+mmwRt/yKz2iYvAfrx5S7fUqiDjkyNvIcb6JbSrQeEA5GBtfa
         w6pfIsFyQgaMFozWxQv+qWppdc425N7U83Xs4rh6dh/s1eYD0ka1Od7pZgGdTkEB8Pkt
         2rA2ObvxwyW8H1dKLhYhTI8WSoTAZRLePmFGpCoaJWL/ICmEKznGLJXppvgyZ/4fICCR
         z++w5OTuOk8a2lSt0RdT498DHmmqCgRAgM66urRZLIkZeWklqnhiDeMHDI724t73qWgq
         S6bA==
X-Gm-Message-State: ABy/qLZcwKcCb/ybizsW1qs+OeMl20m9MWOMv/+PY3lqhc9UDmBN5rTu
	mq1BD9uniM3pyXV7YTTWHJkfStCJZ8nMxTphdfLonQ==
X-Google-Smtp-Source: APBJJlFjxyl5GM43S+9qdoHmVwtBI7iZnIAK+sumIQe1t1DkeZOQsRM6mJkgtaH6cAWZ+mnQo6+7BMx99zLMj2HQCQI=
X-Received: by 2002:a05:6512:3192:b0:4fb:7f45:bcb6 with SMTP id
 i18-20020a056512319200b004fb7f45bcb6mr16799lfe.16.1689262416351; Thu, 13 Jul
 2023 08:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230711233816.2187577-1-dhavale@google.com> <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com> <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop> <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop> <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com> <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
In-Reply-To: <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 13 Jul 2023 11:33:24 -0400
Message-ID: <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
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
Cc: kernel-team@android.com, paulmck@kernel.org, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Frederic Weisbecker <frederic@kernel.org>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 13, 2023 at 10:34=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2023/7/13 22:07, Joel Fernandes wrote:
> > On Thu, Jul 13, 2023 at 12:59=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >> On 2023/7/13 12:52, Paul E. McKenney wrote:
> >>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
> >>>>
> >>>>
> >>
> >> ...
> >>
> >>>>
> >>>> There are lots of performance issues here and even a plumber
> >>>> topic last year to show that, see:
> >>>>
> >>>> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
> >>>> [2] https://lore.kernel.org/r/CAHk-=3DwgE9kORADrDJ4nEsHHLirqPCZ1tGaE=
PAZejHdZ03qCOGg@mail.gmail.com
> >>>> [3] https://lore.kernel.org/r/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+=
FW8GbO6wyUqFneQ@mail.gmail.com
> >>>> [4] https://lpc.events/event/16/contributions/1338/
> >>>> and more.
> >>>>
> >>>> I'm not sure if it's necessary to look info all of that,
> >>>> andSandeep knows more than I am (the scheduling issue
> >>>> becomes vital on some aarch64 platform.)
> >>>
> >>> Hmmm...  Please let me try again.
> >>>
> >>> Assuming that this approach turns out to make sense, the resulting
> >>> patch will need to clearly state the performance benefits directly in
> >>> the commit log.
> >>>
> >>> And of course, for the approach to make sense, it must avoid breaking
> >>> the existing lockdep-RCU debugging code.
> >>>
> >>> Is that more clear?
> >>
> >> Personally I'm not working on Android platform any more so I don't
> >> have a way to reproduce, hopefully Sandeep could give actually
> >> number _again_ if dm-verity is enabled and trigger another
> >> workqueue here and make a comparsion why the scheduling latency of
> >> the extra work becomes unacceptable.
> >>
> >
> > Question from my side, are we talking about only performance issues or
> > also a crash? It appears z_erofs_decompress_pcluster() takes
> > mutex_lock(&pcl->lock);
> >
> > So if it is either in an RCU read-side critical section or in an
> > atomic section, like the softirq path, then it may
> > schedule-while-atomic or trigger RCU warnings.
> >
> > z_erofs_decompressqueue_endio
> > -> z_erofs_decompress_kickoff
> >   ->z_erofs_decompressqueue_work
> >    ->z_erofs_decompress_queue
> >     -> z_erofs_decompress_pcluster
> >      -> mutex_lock
> >
>
> Why does the softirq path not trigger a workqueue instead?

I said "if it is". I was giving a scenario. mutex_lock() is not
allowed in softirq context or in an RCU-reader.

> > Per Sandeep in [1], this stack happens under RCU read-lock in:
> >
> > #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> > [...]
> >                  rcu_read_lock();
> >                  (dispatch_ops);
> >                  rcu_read_unlock();
> > [...]
> >
> > Coming from:
> > blk_mq_flush_plug_list ->
> >                             blk_mq_run_dispatch_ops(q,
> >                                  __blk_mq_flush_plug_list(q, plug));
> >
> > and __blk_mq_flush_plug_list does this:
> >            q->mq_ops->queue_rqs(&plug->mq_list);
> >
> > This somehow ends up calling the bio_endio and the
> > z_erofs_decompressqueue_endio which grabs the mutex.
> >
> > So... I have a question, it looks like one of the paths in
> > __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the alternate
> > path uses RCU. Why does this alternate want to block even if it is not
> > supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING should
> > be set? It sounds like you want to block in the "else" path even
> > though BLK_MQ_F_BLOCKING is not set:
>
> BLK_MQ_F_BLOCKING is not a flag that a filesystem can do anything with.
> That is block layer and mq device driver stuffs. filesystems cannot set
> this value.
>
> As I said, as far as I understand, previously,
> .end_io() can only be called without RCU context, so it will be fine,
> but I don't know when .end_io() can be called under some RCU context
> now.

From what Sandeep described, the code path is in an RCU reader. My
question is more, why doesn't it use SRCU instead since it clearly
does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
dive needs to be made into that before concluding that the fix is to
use rcu_read_lock_any_held().

 - Joel
