Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA875176F
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 06:27:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XE+GxSa7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1hRD6ljQz3bwY
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 14:27:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XE+GxSa7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=srs0=anto=c7=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1hR75Pccz30PJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 14:27:31 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 12B0D60C4B;
	Thu, 13 Jul 2023 04:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAF1C433C7;
	Thu, 13 Jul 2023 04:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689222446;
	bh=CVxQG65MLrWANkYPe3SdWCOKqSZqvIhIFt2IUuuAIYA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XE+GxSa7Aqutcx0J0aBnaewBQ5svGQdYzuAI7pmkBsNkKri87aanAfeb3IQXv9aOv
	 umlmT0M216J0kZMy53hlN+SET1lJOnGJIUxu7YmDfKzDP74iTmu3OUStboDGYUfsge
	 CZ7osqLzJaMM11vdd1IWyn1k11AbPdOBrtFURjx4GqyHiFWpdLD8fCF5O77Qd1WyjY
	 20QRekqvtWFbzBIFGZ3FChfn03QTR7fPMA+qTvQXYgFm2f0qeEAVxBMcYy/yBxZwhp
	 JOcvl8PIl9HYj7IIPszTp0h8AWh5OiFWAH3gJQ2x02Pv39nX6b7vPmHKsMbsjQqHSl
	 qJgzRdwmDTXcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02DBFCE00AB; Wed, 12 Jul 2023 21:27:25 -0700 (PDT)
Date: Wed, 12 Jul 2023 21:27:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
References: <20230711233816.2187577-1-dhavale@google.com>
 <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
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
Cc: kernel-team@android.com, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 13, 2023 at 10:02:17AM +0800, Gao Xiang wrote:
> 
> 
> On 2023/7/13 08:32, Joel Fernandes wrote:
> > On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
> > [..]
> > > > As such this patch looks correct to me, one thing I noticed is that
> > > > you can check rcu_is_watching() like the lockdep-enabled code does.
> > > > That will tell you also if a reader-section is possible because in
> > > > extended-quiescent-states, RCU readers should be non-existent or
> > > > that's a bug.
> > > > 
> > > Please correct me if I am wrong, reading from the comment in
> > > kernel/rcu/update.c rcu_read_lock_held_common()
> > > ..
> > >    * The reason for this is that RCU ignores CPUs that are
> > >   * in such a section, considering these as in extended quiescent state,
> > >   * so such a CPU is effectively never in an RCU read-side critical section
> > >   * regardless of what RCU primitives it invokes.
> > > 
> > > It seems rcu will treat this as lock not held rather than a fact that
> > > lock is not held. Is my understanding correct?
> > 
> > If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe you
> > mean it is not a fact for erofs?
> 
> I'm not sure if I get what you mean, EROFS doesn't take any RCU read lock
> here:

The key point is that we need lockdep to report errors when
rcu_read_lock(), rcu_dereference(), and friends are used when RCU is
not watching.  We also need lockdep to report an error when someone
uses rcu_dereference() when RCU is not watching, but also forgets the
rcu_read_lock().

And this is the job of rcu_read_lock_held(), which is one reason why
that rcu_is_watching() is needed.

> z_erofs_decompressqueue_endio() is actually a "bio->bi_end_io", previously
> which can be called under two scenarios:
> 
>  1) under softirq context, which is actually part of device I/O compleltion;
> 
>  2) under threaded context, like what dm-verity or likewise calls.
> 
> But EROFS needs to decompress in a threaded context anyway, so we trigger
> a workqueue to resolve the case 1).
> 
> Recently, someone reported there could be some case 3) [I think it was
> introduced recently but I have no time to dig into it]:
> 
>  case 3: under RCU read lock context, which is shown by this:
> https://lore.kernel.org/r/4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com/T/#u
> 
>  and such RCU read lock is taken in __blk_mq_run_dispatch_ops().
> 
> But as the commit shown, we only need to trigger a workqueue for case 1)
> and 3) due to performance reasons.

Just out of curiosity, exactly how much is it costing to trigger the
workqueue?

> Hopefully I show it more clear.

One additional question...  What is your plan for kernels built with
CONFIG_PREEMPT_COUNT=n?  After all, in such kernels, there is no way
that I know of for code to determine whether it is in an RCU read-side
critical section, holding a spinlock, or running with preemption disabled.

						Thanx, Paul
