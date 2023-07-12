Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C4751291
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 23:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689196880;
	bh=tZTUnI6d8S8lOCvLIZaV/WnDbZOnjxlpdLIn7J7T5Ws=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=U3hOjQ2lZd0Kr/4IwXqew7hjG4cjsBHa8GK7ZTm133KlDoxPbS+qeTgcpeaDcCbQb
	 3ngLJU/OVQCAau8yVc0Z8v7Odomt8f5jrE+sA/70/G2b7Ku+9Hot++kNz8zRNO2mti
	 2KQMDEPybZznSmp/pvtYkA+jNEPnAYI73boHQZyhZycPtWt6W6uT5IUoIliMNmor+i
	 ZJSO6g4VI4RD/Dz6UV0ldhruxgRgESUqHqFhMUnJjFB7Eb8XG5UBDuq1AN93VmR2mK
	 siLUJjEzTydUC/NjlkNt5ImVEF2vek3+WOxLBkZ7pcrr5HlVg1I0tKKQBW8KGgip7M
	 RvzvnQwmxT2Yw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1VzN5p8Gz3c26
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 07:21:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=riVOxBRs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1VzJ3Jybz30P3
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 07:21:15 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso76750295e9.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 14:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196868; x=1691788868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZTUnI6d8S8lOCvLIZaV/WnDbZOnjxlpdLIn7J7T5Ws=;
        b=choDRYLtEE+9ymZv0olp4V/YiM2E4M5c/V+m5ksH6b9B06vwUzkHWdDSE6vrjuYkb/
         Y/WMboglNHfByfcHRtVETcDva6jsE2o+oNu4M64iF3ZYi2Qi7hnxGtvWXz/EqZg3VbEW
         /bUjid1x/6cVF1RJ1/UgfP7FExkPyUhbAC4EczGi6qJlgc207GzEKAG4Emh+aIoWBhOn
         vNfIe5XTn7sAaBYrrgjyNENsOQ55o3+WuN2HnXQojzkdtiZQEwc0eHd5t/JeVFF3SGui
         OImv94tJtlilUvTkhYtOdrgoetOmPtvr4z0JobPjaBmGNow6+Nicid7wiEtQlFAgIhMm
         DWRw==
X-Gm-Message-State: ABy/qLbXDiKBW2+6GU1G2rZrhwmYMGn39arQ5odU8CcAyudlJLOhWx2P
	swjlJyjNEK7wK1N9iSFW2bQXl3JuwrAeekuBCBBRRg==
X-Google-Smtp-Source: APBJJlF02gY8bEC0+lYROMVW41NJjfAkJDC91HvoX0ewa2c+XazwQOw0ZGwvXcadoBMYjI5IXT+IOvbvZzU0knL3QpU=
X-Received: by 2002:a05:600c:2295:b0:3f8:facf:7626 with SMTP id
 21-20020a05600c229500b003f8facf7626mr17690397wmf.20.1689196867941; Wed, 12
 Jul 2023 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230711233816.2187577-1-dhavale@google.com> <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
In-Reply-To: <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
Date: Wed, 12 Jul 2023 14:20:56 -0700
Message-ID: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To: Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: kernel-team@android.com, "Paul E. McKenney" <paulmck@kernel.org>, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Frederic Weisbecker <frederic@kernel.org>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Joel,
Thank you for the review!
> Actually even the original code is incorrect (the lockdep version)
> since preemptible() cannot be relied upon if CONFIG_PREEMPT_COUNT is
> not set. However, that's debug code. In this case, it is a real
> user (the fs code). In non-preemptible kernels, we are always in an
> RCU-sched section. So you can't really see if anyone called your code
> under rcu_read_lock(). The rcu_read_lock/unlock() would be getting
> NOOPed. In such a kernel, it will always tell your code it is in an
> RCU reader. That's not ideal for that erofs code?
>
> Also, per that erofs code:
>         /* Use (kthread_)work and sync decompression for atomic contexts only */
>         if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
>
> I guess you are also assuming that rcu_read_lock_any_held() tells you
> something about atomicity but strictly speaking, it doesn't because
> preemptible RCU readers are preemptible. You can't block but
> preemption is possible so it is not "atomic". Maybe you meant "cannot
> block"?
>
Yes, you are correct. For decompression erofs needs to grab pcluster mutex lock,
erofs wants to know if we can or cannot block to decide sync vs async
decompression.

Good point about !CONFIG_PREEMPT_COUNT. Yes, in that case erofs
will always do async decompression which is less than ideal. Maybe
erofs check can be modified to account for !CONFIG_PREEMPT_COUNT.

> As such this patch looks correct to me, one thing I noticed is that
> you can check rcu_is_watching() like the lockdep-enabled code does.
> That will tell you also if a reader-section is possible because in
> extended-quiescent-states, RCU readers should be non-existent or
> that's a bug.
>
Please correct me if I am wrong, reading from the comment in
kernel/rcu/update.c rcu_read_lock_held_common()
..
  * The reason for this is that RCU ignores CPUs that are
 * in such a section, considering these as in extended quiescent state,
 * so such a CPU is effectively never in an RCU read-side critical section
 * regardless of what RCU primitives it invokes.

It seems rcu will treat this as lock not held rather than a fact that
lock is not held. Is my understanding correct?
The reason I chose not to consult rcu_is_watching() in this version
is because check "sleeping function called from invalid context"
will still get triggered (please see kernel/sched/core.c __might_resched())
as it does not consult rcu_is_watching() instead looks at
rcu_preempt_depth() which will be non-zero if rcu_read_lock()
was called (only when CONFIG_PREEMPT_RCU is enabled).

> Could you also verify that this patch does not cause bloating of the
> kernel if lockdep is disabled?
>
Sure, I will do the comparison and send the details.

Thanks,
Sandeep.

> thanks,
>
>  - Joel
