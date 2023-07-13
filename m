Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ED735752D39
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 00:50:15 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VaRXLHYh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R28vS4F58z3c2m
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 08:50:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VaRXLHYh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=srs0=anto=c7=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R28vK1fQkz3c01
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 08:50:05 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E004360A70;
	Thu, 13 Jul 2023 22:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44269C433C8;
	Thu, 13 Jul 2023 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689288600;
	bh=Gh29Wb2aqyt/xe1iph8cTszJeDxWE0Roznnq+SAGWZ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VaRXLHYhtTyuD9XWDz27Rl2aO8zPRZskUvzqfJAF92vLzrkbA1Y5NUjSzFLaXNttT
	 Mq4/87sYRaDsoqYCB1UmD0lTJcgyIqf4hPkUNLIjRtWgnpKIUa0UlBohIVxoT/5OYe
	 LPI8SNUu5DQHvwaqvAeK9H//rn3lqEkzS3gYi6r7HMk5ldyULLR1XZ+1krSuvNdKrc
	 /Lh8hvIfm6qIJxaosEZ+BIjy/ii59ZQDKRYKds0z6X/Yk8YqaSViWfG2kbymfaijg4
	 WMEA8atAS8c9/yBHT2rmaq+hW5LZOgbfTHrrjdMreRm4OB5BelVlAvW9q8PaLKI/SR
	 JcMinMyrv3cSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D646ECE009E; Thu, 13 Jul 2023 15:49:59 -0700 (PDT)
Date: Thu, 13 Jul 2023 15:49:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <32b8c9d5-37da-4508-b524-fc0fd326c432@paulmck-laptop>
References: <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
 <39923da8-16a1-43a8-99f1-5e13508e4ee4@paulmck-laptop>
 <CAB=BE-QNFhOD=xe09hiZOLmDN7XQxnaxyMz1X=4EeU7SFKaRKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-QNFhOD=xe09hiZOLmDN7XQxnaxyMz1X=4EeU7SFKaRKA@mail.gmail.com>
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

On Thu, Jul 13, 2023 at 11:51:34AM -0700, Sandeep Dhavale wrote:
> > Thank you for the background.
> >
> > > Paul, Joel,
> > > Shall we fix the rcu_read_lock_*held() regardless of how erofs
> > > improves the check?
> >
> > Help me out here.  Exactly what is broken with rcu_read_lock_*held(),
> > keeping in mind their intended use for lockdep-based debugging?
> >
> Hi Paul,
> With !CONFIG_DEBUG_ALLOC_LOCK
> rcu_read_lock_held() -> Always returns 1.
> rcu_read_lock_any_held()-> returns !preemptible() so may return 0.
> 
> Now current usages for rcu_read_lock_*held() are under RCU_LOCKDEP_WARN()
> which becomes noOP with !CONFIG_DEBUG_ALLOC_LOCK
> (due to debug_lockdep_rcu_enabled()) so this inconsistency is not causing
> any problems right now. So my question was about your opinion for fixing this
> for semantics if it's worth correcting.
> 
> Also it would have been better IMO if there was a reliable API
> for rcu_read_lock_*held() than erofs trying to figure it out at a higher level.

Sorry, but the current lockdep-support functions need to stay focused
on lockdep.  They are not set up for general use, as we already saw
with rcu_is_watching().

If you get a z_erofs_wq_needed() (or whatever) upstream, and if it turns
out that there is an RCU-specific portion that has clean semantics,
then I would be willing to look at pulling that portion into RCU.
Note "look at" as opposed to "unconditionally agree to".  ;-)

> > I have no official opinion myself, but there are quite a few people
> ...
> 
> Regarding erofs trying to detect this, I understand few people can
> have different
> opinions. Not scheduling a thread while being in a thread context itself
> is reasonable in my opinion which also has shown performance gains.

You still haven't quantified the performance gains.  Presumably they
are most compelling with large numbers of small buffers to be decrypted.

But why not just make a z_erofs_wq_needed() or similar in your own
code, and push it upstream?  If the performance gains really are so
compelling, one would hope that some sort of reasonable arrangement
could be arrived at.

							Thanx, Paul

> Thanks,
> Sandeep.
> 
> 
> 
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > > Sandeep.
> > >
> > > [1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
