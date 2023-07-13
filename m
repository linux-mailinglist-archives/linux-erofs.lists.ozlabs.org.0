Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F6752A3B
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 20:15:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tqNIuNvo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R22p01gD5z3c5d
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 04:15:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tqNIuNvo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=srs0=anto=c7=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R22nw2Q3nz3bv4
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 04:15:00 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4B1D761B14;
	Thu, 13 Jul 2023 18:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37F7C433C8;
	Thu, 13 Jul 2023 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689272097;
	bh=gbBaDOLW8b5zJ6t+3hNGjxenn8ggPRUMHbXlJY7MZBk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tqNIuNvoYCyzicFL7M0IuA7oO/p8oI98C4Ha0s+IRm9ZZnYmfK0BLRV4vLQaiC4eU
	 j6Q0phJZ8zXfU7jN/2u1/K/uYhEzzXG+XDM+cswy8+sRLzB82QGyczw3eN+mnoAvIG
	 SyUOARlofcgKCqei4M6SkZonkhRn1I+dtcr4tjLJEYHIxMMGiJvsklygEF2ALi6rte
	 uI0AN2u4p7sVxP4Mbjae6i3hVWGZlC9iubmvtqtZ0/SIYwrPmnriTJHknPK83Ju7bG
	 LgklYKHbfP99PjVt07Qb0lYyG7hYBEIErmi1WKzhzuq+EtxWW8JJIWQEZgW2ARSoHx
	 PzzCXkdpIMVMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 325E8CE009F; Thu, 13 Jul 2023 11:14:57 -0700 (PDT)
Date: Thu, 13 Jul 2023 11:14:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Huang <mmpgouride@gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <c62bd3db-5ed3-4dbf-bba9-d9dace23312c@paulmck-laptop>
References: <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <F7D5032D-908E-4227-8A38-AF740AC86CDC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F7D5032D-908E-4227-8A38-AF740AC86CDC@gmail.com>
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
Reply-To: paulmck@kernel.org
Cc: kernel-team@android.com, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 14, 2023 at 12:09:27AM +0800, Alan Huang wrote:
> 
> > 2023年7月13日 23:33，Joel Fernandes <joel@joelfernandes.org> 写道：
> > 
> > On Thu, Jul 13, 2023 at 10:34 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >> 
> >> 
> >> 
> >> On 2023/7/13 22:07, Joel Fernandes wrote:
> >>> On Thu, Jul 13, 2023 at 12:59 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >>>> On 2023/7/13 12:52, Paul E. McKenney wrote:
> >>>>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
> >>>>>> 
> >>>>>> 
> >>>> 
> >>>> ...
> >>>> 
> >>>>>> 
> >>>>>> There are lots of performance issues here and even a plumber
> >>>>>> topic last year to show that, see:
> >>>>>> 
> >>>>>> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
> >>>>>> [2] https://lore.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com
> >>>>>> [3] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> >>>>>> [4] https://lpc.events/event/16/contributions/1338/
> >>>>>> and more.
> >>>>>> 
> >>>>>> I'm not sure if it's necessary to look info all of that,
> >>>>>> andSandeep knows more than I am (the scheduling issue
> >>>>>> becomes vital on some aarch64 platform.)
> >>>>> 
> >>>>> Hmmm...  Please let me try again.
> >>>>> 
> >>>>> Assuming that this approach turns out to make sense, the resulting
> >>>>> patch will need to clearly state the performance benefits directly in
> >>>>> the commit log.
> >>>>> 
> >>>>> And of course, for the approach to make sense, it must avoid breaking
> >>>>> the existing lockdep-RCU debugging code.
> >>>>> 
> >>>>> Is that more clear?
> >>>> 
> >>>> Personally I'm not working on Android platform any more so I don't
> >>>> have a way to reproduce, hopefully Sandeep could give actually
> >>>> number _again_ if dm-verity is enabled and trigger another
> >>>> workqueue here and make a comparsion why the scheduling latency of
> >>>> the extra work becomes unacceptable.
> >>>> 
> >>> 
> >>> Question from my side, are we talking about only performance issues or
> >>> also a crash? It appears z_erofs_decompress_pcluster() takes
> >>> mutex_lock(&pcl->lock);
> >>> 
> >>> So if it is either in an RCU read-side critical section or in an
> >>> atomic section, like the softirq path, then it may
> >>> schedule-while-atomic or trigger RCU warnings.
> >>> 
> >>> z_erofs_decompressqueue_endio
> >>> -> z_erofs_decompress_kickoff
> >>>  ->z_erofs_decompressqueue_work
> >>>   ->z_erofs_decompress_queue
> >>>    -> z_erofs_decompress_pcluster
> >>>     -> mutex_lock
> >>> 
> >> 
> >> Why does the softirq path not trigger a workqueue instead?
> > 
> > I said "if it is". I was giving a scenario. mutex_lock() is not
> > allowed in softirq context or in an RCU-reader.
> > 
> >>> Per Sandeep in [1], this stack happens under RCU read-lock in:
> >>> 
> >>> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> >>> [...]
> >>>                 rcu_read_lock();
> >>>                 (dispatch_ops);
> >>>                 rcu_read_unlock();
> >>> [...]
> >>> 
> >>> Coming from:
> >>> blk_mq_flush_plug_list ->
> >>>                            blk_mq_run_dispatch_ops(q,
> >>>                                 __blk_mq_flush_plug_list(q, plug));
> >>> 
> >>> and __blk_mq_flush_plug_list does this:
> >>>           q->mq_ops->queue_rqs(&plug->mq_list);
> >>> 
> >>> This somehow ends up calling the bio_endio and the
> >>> z_erofs_decompressqueue_endio which grabs the mutex.
> >>> 
> >>> So... I have a question, it looks like one of the paths in
> >>> __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the alternate
> >>> path uses RCU. Why does this alternate want to block even if it is not
> >>> supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING should
> >>> be set? It sounds like you want to block in the "else" path even
> >>> though BLK_MQ_F_BLOCKING is not set:
> >> 
> >> BLK_MQ_F_BLOCKING is not a flag that a filesystem can do anything with.
> >> That is block layer and mq device driver stuffs. filesystems cannot set
> >> this value.
> >> 
> >> As I said, as far as I understand, previously,
> >> .end_io() can only be called without RCU context, so it will be fine,
> >> but I don't know when .end_io() can be called under some RCU context
> >> now.
> > 
> > From what Sandeep described, the code path is in an RCU reader. My
> > question is more, why doesn't it use SRCU instead since it clearly
> > does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
> > dive needs to be made into that before concluding that the fix is to
> > use rcu_read_lock_any_held().
> 
> Copied from [1]:
> 
> "Background: Historically erofs would always schedule a kworker for
>  decompression which would incur the scheduling cost regardless of
>  the context. But z_erofs_decompressqueue_endio() may not always
>  be in atomic context and we could actually benefit from doing the
>  decompression in z_erofs_decompressqueue_endio() if we are in
>  thread context, for example when running with dm-verity.
>  This optimization was later added in patch [2] which has shown
>  improvement in performance benchmarks.”
> 
> I’m not sure if it is a design issue.

I have no official opinion myself, but there are quite a few people
who firmly believe that any situation like this one (where driver or
file-system code needs to query the current context to see if blocking
is OK) constitutes a design flaw.  Such people might argue that this
code path should have a clearly documented context, and that if that
documentation states that the code might be in atomic context, then the
driver/fs should assume atomic context.  Alternatively, if driver/fs
needs the context to be non-atomic, the callers should make it so.

See for example in_atomic() and its comment header:

/*
 * Are we running in atomic context?  WARNING: this macro cannot
 * always detect atomic context; in particular, it cannot know about
 * held spinlocks in non-preemptible kernels.  Thus it should not be
 * used in the general case to determine whether sleeping is possible.
 * Do not use in_atomic() in driver code.
 */
#define in_atomic()	(preempt_count() != 0)

In the immortal words of Dan Frye, this should be good clean fun!  ;-)

							Thanx, Paul

> [1] https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/
> 
> > 
> > - Joel
> 
> 
