Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47603752DF4
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 01:29:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dGIlaA5A;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R29m96NKRz3c1H
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 09:28:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dGIlaA5A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=srs0=anto=c7=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R29m65pNzz300N
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 09:28:54 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C2B8861B86;
	Thu, 13 Jul 2023 23:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CB0C433C7;
	Thu, 13 Jul 2023 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689290932;
	bh=NDO2P9+RW636wRRXRtr7gwSzDOuhmqm37GP4lCYn9IY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dGIlaA5ACD0zbItZfFo5zQ6YW8m63CwBqa6iBL/EIvMwzkmxhHy+Vt3QD8Lfj7jv6
	 +fHfJHVFhTJdNfg5s5cdqxNKOIRV7F7i8HYgG/43RP555xzqsSgDENBiG7OgYpNryt
	 T4cKkUq0aiidOcxwlqsNmggDCaHZ6gHu4q5trruYmW7pRd6WVa6oau9CYZrDizqRyn
	 U4z+XzLF3eaHAqJqMD1hLDIgzF2Md6RtjNXqlwJg/lNjSqEKy7kov61csq8rWYh6nB
	 nrqqJW5OO/Gjv6m2PDxGNl1tXJkRwpzr8ff+GZi1TaqQ5k0rLy/U9s7+ZlxJWP0k3b
	 ts0UG7Hq1otEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2BA4CE009E; Thu, 13 Jul 2023 16:28:51 -0700 (PDT)
Date: Thu, 13 Jul 2023 16:28:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <906e7981-9da2-4b3d-b200-aad7c8057bef@paulmck-laptop>
References: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
 <39923da8-16a1-43a8-99f1-5e13508e4ee4@paulmck-laptop>
 <CAB=BE-QNFhOD=xe09hiZOLmDN7XQxnaxyMz1X=4EeU7SFKaRKA@mail.gmail.com>
 <32b8c9d5-37da-4508-b524-fc0fd326c432@paulmck-laptop>
 <CAB=BE-SwUTDkVvd5s3-NjEzBTqoZnHFdZg0OU-YVK+h3rxnEuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-SwUTDkVvd5s3-NjEzBTqoZnHFdZg0OU-YVK+h3rxnEuw@mail.gmail.com>
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

On Thu, Jul 13, 2023 at 04:08:29PM -0700, Sandeep Dhavale wrote:
> >
> > Sorry, but the current lockdep-support functions need to stay focused
> > on lockdep.  They are not set up for general use, as we already saw
> > with rcu_is_watching().
> >
> Ok, understood.
> 
> > If you get a z_erofs_wq_needed() (or whatever) upstream, and if it turns
> > out that there is an RCU-specific portion that has clean semantics,
> > then I would be willing to look at pulling that portion into RCU.
> > Note "look at" as opposed to "unconditionally agree to".  ;-)
> > > > I have no official opinion myself, but there are quite a few people
> > > ...
> > >
> > > Regarding erofs trying to detect this, I understand few people can
> > > have different
> > > opinions. Not scheduling a thread while being in a thread context itself
> > > is reasonable in my opinion which also has shown performance gains.
> >
> > You still haven't quantified the performance gains.  Presumably they
> > are most compelling with large numbers of small buffers to be decrypted.
> 
> Maybe you missed one of the replies. Link [1] shows the scheduling overhead
> for kworker vs high pri kthread. I think we can all see that there is non-zero
> cost associated with always scheduling vs inline decompression.

Heh!  A reply I was not CCed on back in February.  ;-)

But data like that included directly in the commit log, gathered
specifically for that commit log's patch, would be very helpful.

> > But why not just make a z_erofs_wq_needed() or similar in your own
> > code, and push it upstream?  If the performance gains really are so
> > compelling, one would hope that some sort of reasonable arrangement
> > could be arrived at.
> >
> Yes, we will incorporate additional checks in erofs.

Sounds good to me!

							Thanx, Paul

> Thanks,
> Sandeep.
> 
> [1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
