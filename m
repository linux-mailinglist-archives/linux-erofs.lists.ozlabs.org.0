Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C81752D05
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 00:27:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CtEyUvbA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R28Pl66z2z3bsS
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 08:27:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CtEyUvbA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=srs0=anto=c7=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R28Ph4FLLz3bXw
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 08:27:52 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5CDBF61B45;
	Thu, 13 Jul 2023 22:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50A3C433C7;
	Thu, 13 Jul 2023 22:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689287269;
	bh=I0kzTZFnlT4bjc9zwoxuBIX+VXnchct3aq2xuHL8IYo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CtEyUvbAxF6FVHziF3TS/0lxpvj6yBjBMohtclxty9JMh/uF6UP5IKjrq5mf8gv4y
	 rxUNzs3Ae6sMV/bwrswqCYFDRzIkA10QYAv5IEUvgWHybKmm2HUaQlFaKtXyIvx1Rw
	 0A+90KhNOAFWlv4FFMGGLHtz0MNKse0SntlPnrFbE/Sizwxo5ABAT4YOfQyg2/9TEI
	 9gYOazxSQEJZfSJVjpVfONZqUMcHXjcBBuX6nSEqEJJsvCB3t4YuwMUG8PyCm9hqMy
	 d8fGCIeHhkLFBLBSNOFBV5RX1OyccAZeSg1unwaXxb+rbaFQUKX47d9EWH9l9pnO1O
	 6P71OvZO2g/Bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49328CE009E; Thu, 13 Jul 2023 15:27:49 -0700 (PDT)
Date: Thu, 13 Jul 2023 15:27:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <9467912e-dc27-4e3f-861f-d1c4117ddce5@paulmck-laptop>
References: <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <F7D5032D-908E-4227-8A38-AF740AC86CDC@gmail.com>
 <c62bd3db-5ed3-4dbf-bba9-d9dace23312c@paulmck-laptop>
 <57b07fc3-6049-6ace-2523-2d013273c456@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57b07fc3-6049-6ace-2523-2d013273c456@linux.alibaba.com>
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
Cc: kernel-team@android.com, Alan Huang <mmpgouride@gmail.com>, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 14, 2023 at 03:00:25AM +0800, Gao Xiang wrote:
> On 2023/7/14 02:14, Paul E. McKenney wrote:
> > On Fri, Jul 14, 2023 at 12:09:27AM +0800, Alan Huang wrote:
> 
> ...
> 
> > > > 
> > > >  From what Sandeep described, the code path is in an RCU reader. My
> > > > question is more, why doesn't it use SRCU instead since it clearly
> > > > does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
> > > > dive needs to be made into that before concluding that the fix is to
> > > > use rcu_read_lock_any_held().
> > > 
> > > Copied from [1]:
> > > 
> > > "Background: Historically erofs would always schedule a kworker for
> > >   decompression which would incur the scheduling cost regardless of
> > >   the context. But z_erofs_decompressqueue_endio() may not always
> > >   be in atomic context and we could actually benefit from doing the
> > >   decompression in z_erofs_decompressqueue_endio() if we are in
> > >   thread context, for example when running with dm-verity.
> > >   This optimization was later added in patch [2] which has shown
> > >   improvement in performance benchmarks.”
> > > 
> > > I’m not sure if it is a design issue.
> 
> What do you mean a design issue, honestly?  I feel uneasy to hear this.
> 
> > I have no official opinion myself, but there are quite a few people
> > who firmly believe that any situation like this one (where driver or
> > file-system code needs to query the current context to see if blocking
> > is OK) constitutes a design flaw.  Such people might argue that this
> > code path should have a clearly documented context, and that if that
> > documentation states that the code might be in atomic context, then the
> > driver/fs should assume atomic context.  Alternatively, if driver/fs
> 
> I don't think a software decoder (for example, decompression) should be
> left in the atomic context honestly.
> 
> Regardless of the decompression speed of some algorithm theirselves
> (considering very slow decompression on very slow devices), it means
> that we also don't have a way to vmap or likewise (considering
> decompression + handle extra deduplication copies) in the atomic
> context, even memory allocation has to be in an atomic way.
> 
> Especially now have more cases that decodes in the RCU reader context
> apart from softirq contexts?

Just out of curiosity, why are these cases within RCU readers happening?
Is this due to recent MM changes?  But yes, you would have the same
problem in softirq context.

> > needs the context to be non-atomic, the callers should make it so.
> > 
> > See for example in_atomic() and its comment header:
> > 
> > /*
> >   * Are we running in atomic context?  WARNING: this macro cannot
> >   * always detect atomic context; in particular, it cannot know about
> >   * held spinlocks in non-preemptible kernels.  Thus it should not be
> >   * used in the general case to determine whether sleeping is possible.
> >   * Do not use in_atomic() in driver code.
> >   */
> > #define in_atomic()	(preempt_count() != 0)
> > 
> > In the immortal words of Dan Frye, this should be good clean fun!  ;-)
> 
> Honestly, I think such helper (to show whether it's in the atomic context)
> is useful to driver users, even it could cause some false positive in some
> configuration but it's acceptable.
> 
> Anyway, I could "Always use a workqueue.", but again, the original commit
> was raised by a real vendor (OPPO), and I think if dropping this, all
> downstream users which use dm-verity will be impacted and individual end
> users will not be happy as well.

Well, given what we have discussed thus far, for some kernels, you would
always use a workqueue.  One option would be to force CONFIG_PREEMPT_COUNT
to always be enabled, but this option has not been rejected multiple
times in the past.

But you are quite free to roll your own z_erofs_wq_needed().

							Thanx, Paul
