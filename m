Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC99753E35
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 16:56:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2ZLP1l2wz3c5P
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Jul 2023 00:56:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=srs0=m2l4=da=goodmis.org=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2ZLJ52XCz3c4F
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Jul 2023 00:56:24 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4CC61D47;
	Fri, 14 Jul 2023 14:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6CC433C7;
	Fri, 14 Jul 2023 14:56:18 +0000 (UTC)
Date: Fri, 14 Jul 2023 10:56:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <20230714105615.1ff9b8d2@gandalf.local.home>
In-Reply-To: <fccca41d-8a72-27cf-e589-409f54cd5811@linux.alibaba.com>
References: <20230713003201.GA469376@google.com>
	<161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
	<0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
	<f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
	<87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
	<f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
	<CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
	<894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
	<CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
	<58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
	<7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
	<058e7ee9-0380-eb1b-d9a8-b184cba6ed53@linux.alibaba.com>
	<CAEXW_YQCpUsPz24H4Mux6wOH1=RFRR-gsXLFTbJ37MgUJo3kCw@mail.gmail.com>
	<fccca41d-8a72-27cf-e589-409f54cd5811@linux.alibaba.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: kernel-team@android.com, paulmck@kernel.org, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 14 Jul 2023 21:51:16 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> >> we need to work on
> >> CONFIG_PREEMPT_COUNT=n (why not?), we could just always trigger a
> >> workqueue for this.
> >>  
> > 
> > So CONFIG_PREEMPT_COUNT=n users don't deserve good performance? ;-)  
> 
> I'm not sure if non-preemptible kernel users really care about
> such sensitive latencies, I don't know, my 2 cents.

CONFIG_PREEMPT_COUNT=n is for *performance* but not for *latency*. That is,
they care about the overall performance (batch processing) but not
interactive performance.

-- Steve
