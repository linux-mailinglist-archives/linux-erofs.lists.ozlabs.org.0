Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 782BD7529E6
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 19:35:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UH7d4gNK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R21wQ2RClz3c5d
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 03:35:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UH7d4gNK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=srs0=anto=c7=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R21wK3303z2yjj
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 03:35:29 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4E47F61B0A;
	Thu, 13 Jul 2023 17:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0998C433C8;
	Thu, 13 Jul 2023 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689269724;
	bh=nVjA5DBJ4Jf6ILT1G2kqYsugYxkNpdWew6RWRChpACw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UH7d4gNKL0u/IgFEobZtu+99pbkCzDViNGEtw5/owow5ZnIT5997RKaz0RL9HEcye
	 LCniBqIBWl/7yvxFEKp2p7nRfTW/UPYENSu2nrxorGWngViKrvbq6lofuc+5qI2dYI
	 aTT7ETaqJzuIXFYbvUVv5YQLWUlVtNYrClaOVRZq8BNhrKZSCSLmakQpG1Gjg7GSTn
	 dZZDux/20jEC503+r/ss5IqqngL2ZFIQaVLk5UfVnSeJEypnYgqMiBxIuGn0Y0MSzI
	 v4WYJpN6bSaWEK063CqFGJtmBOn0swyIQ6jyA7QdYXXpIi/cWNWDv/+YyqdYYZ2XZT
	 4TSi0u+CCqQ7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3847CCE009F; Thu, 13 Jul 2023 10:35:24 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:35:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <39923da8-16a1-43a8-99f1-5e13508e4ee4@paulmck-laptop>
References: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
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

On Thu, Jul 13, 2023 at 10:05:46AM -0700, Sandeep Dhavale wrote:
> Hello All,
> 
> Let me answer some of the questions raised here.
> 
> * Performance aspect
> EROFS is one of the popular filesystem of choice in Android for read
> only partitions
> as it provides 30%+ storage space savings with compression.
> In addition to microbenchmarks, boot times and cold app launch
> benchmarks are very
> important to the Android ecosystem as they directly translate to
> responsiveness from user point of view. We saw some
> performance penalty in cold app launch benchmarks in a few scenarios.
> Analysis showed that the significant variance was coming from the
> scheduling cost while decompression cost was more or less the same.
> Please see the [1] which shows scheduling costs for kthread vs kworker.
> 
> > Just out of curiosity, exactly how much is it costing to trigger the
> workqueue?
> I think the cost to trigger is not much, it's the actual scheduling latency for
> the thread is the one which we want to cut down. And if we are already in
> thread context then there is no point in incurring any extra cost if
> we can detect
> it reliably. That is what erofs check is trying to do.
> 
> >One additional question...  What is your plan for kernels built with
> CONFIG_PREEMPT_COUNT=n?
> If there is no reliable way to detect if we can block or not then in that
> case erofs has no option but to schedule the kworker.
> 
> * Regarding BLK_MQ_F_BLOCKING
> As mentioned by Gao in the thread this is a property of blk-mq device
> underneath,
> so erofs cannot control it has it has to work with different types of
> block devices.
> 
> * Regarding rcu_is_watching()
> 
> >I am assuming you mean you would grab the mutex accidentally when in an RCU
> reader, and might_sleep() presumably in the mutex internal code will scream?
> 
> Thank you Paul for explaining in detail why it is important. I can get
> the V2 going.
> >From the looking at the code at kernel/sched/core.c which only looks
> at rcu_preempt_depth(),
> I am thinking it may still get triggered IIUC.
> 
> > The following is untested, and is probably quite buggy, but it should
> provide you with a starting point.
> ..
> 
> Yes, that can fix the problem at hand as the erofs check also looks
> for rcu_preempt_depth().
> A similar approach was discarded as rcu_preempt_depth() was though to
> be low level
> and we used rcu_read_lock_any_held() which is the superset until we
> figured out inconsistency
> when ! CONFIG_DEBUG_LOCK_ALLOC.

Thank you for the background.

> Paul, Joel,
> Shall we fix the rcu_read_lock_*held() regardless of how erofs
> improves the check?

Help me out here.  Exactly what is broken with rcu_read_lock_*held(),
keeping in mind their intended use for lockdep-based debugging?

							Thanx, Paul

> Thanks,
> Sandeep.
> 
> [1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
