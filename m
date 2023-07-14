Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D427542BC
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 20:44:23 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gn+DOEFc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2gPK511hz3c3R
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Jul 2023 04:44:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gn+DOEFc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=srs0=cecs=da=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2gPC1WzJz3bSj
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Jul 2023 04:44:15 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 59E6761DCD;
	Fri, 14 Jul 2023 18:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E94C433C8;
	Fri, 14 Jul 2023 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689360246;
	bh=asCo0dd5mxRE4px5f2OcxTb7m6Zaxpvf3NvcR8uu61U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gn+DOEFcqLlkcY/4WoNax0oKj6ls87rLsFfTTD8WPgySn3vvfMtKPn+ZX3JgPGNCd
	 FDm5Ru12kqKyEtQrpw8eWhZHEiMzjezQtAxWJqdrLSOw7DZaip8ChsOhcVh4XLlwlX
	 /Lv4JvjO4R3Xf7fM/4Ex3qeIsneiy75F6Eu5G3XK4ggLCx6b28BobahgmwhU0Tl4Gy
	 s0pz5u2QfVrnJOeioAXRIFecdDNn/usfOcjlOLvra00R6w4n4ADI0cITSLwW5ovXLO
	 5q5AKGMNfILldBZ3L64L3VQzTGpYJSUIfoJ6wKutfTSPPLSRnsLlsvurNEkfVPwzQ0
	 3I4CQNucM7vBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 45F3ACE03B3; Fri, 14 Jul 2023 11:44:06 -0700 (PDT)
Date: Fri, 14 Jul 2023 11:44:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Huang <mmpgouride@gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <453bcbbd-94f4-46da-98f6-c9fa5f931231@paulmck-laptop>
References: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com>
 <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
 <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop>
 <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
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

On Sat, Jul 15, 2023 at 02:40:08AM +0800, Alan Huang wrote:
> > 2023年7月15日 01:02，Paul E. McKenney <paulmck@kernel.org> 写道：
> > On Fri, Jul 14, 2023 at 11:54:47PM +0800, Alan Huang wrote:
> >>> 2023年7月14日 23:35，Alan Huang <mmpgouride@gmail.com> 写道：
> >>>> 2023年7月14日 10:16，Paul E. McKenney <paulmck@kernel.org> 写道：

[ . . . ]

> >>>>> How can this be solved?
> >>>>> 
> >>>>> 1. Always use a workqueue.  Simple, but is said to have performance
> >>>>> issues.
> >>>>> 
> >>>>> 2. Pass a flag in that indicates whether or not the caller is in an
> >>>>> RCU read-side critical section.  Conceptually simple, but might
> >>>>> or might not be reasonable to actually implement in the code as
> >>>>> it exists now. (You tell me!)
> >>>>> 
> >>>>> 3. Create a function in z_erofs that gives you a decent
> >>>>> approximation, maybe something like the following.
> >>>>> 
> >>>>> 4. Other ideas here.
> >>>> 
> >>>> 5. #3 plus make the corresponding Kconfig option select
> >>>> PREEMPT_COUNT, assuming that any users needing compression in
> >>>> non-preemptible kernels are OK with PREEMPT_COUNT being set.
> >>>> (Some users of non-preemptible kernels object strenuously
> >>>> to the added overhead from CONFIG_PREEMPT_COUNT=y.)
> >>> 
> >>> 6. Set one bit in bio->bi_private, check the bit and flip it in rcu_read_lock() path,
> >>> then in z_erofs_decompressqueue_endio, check if the bit has changed.
> >> 
> >> Seems bad, read and modify bi_private is a bad idea.
> > 
> > Is there some other field that would work?
> 
> Maybe bio->bi_opf, btrfs uses some bits of it.

Sandeep, thoughts?


							Thanx, Paul

> >>> Not sure if this is feasible or acceptable. :)
> >>> 
> >>>> 
> >>>> Thanx, Paul
> >>>> 
> >>>>> The following is untested, and is probably quite buggy, but it should
> >>>>> provide you with a starting point.
> >>>>> 
> >>>>> static bool z_erofs_wq_needed(void)
> >>>>> {
> >>>>> if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
> >>>>> return true;  // RCU reader
> >>>>> if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preemptible())
> >>>>> return true;  // non-preemptible
> >>>>> if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> >>>>> return true;  // non-preeemptible kernel, so play it safe
> >>>>> return false;
> >>>>> }
> >>>>> 
> >>>>> You break it, you buy it!  ;-)
> >>>>> 
> >>>>> Thanx, Paul
> 
> 
