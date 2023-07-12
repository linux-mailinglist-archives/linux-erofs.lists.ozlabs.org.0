Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 906D8750F30
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 19:03:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=cqQDuh7K;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1PFJ39QYz3c1Y
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 03:03:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=cqQDuh7K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=joelfernandes.org (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=joel@joelfernandes.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1PFC4wHsz30ft
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 03:02:53 +1000 (AEST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b74209fb60so2210871fa.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689181367; x=1691773367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvoEOajiEwYXBD3xzLluGfgCVtGjTJSaHMHQydgzNEE=;
        b=cqQDuh7KkBC7Bp6ndhg7nXNYsINnQl/XnlT+1UAc8RaZTq+BuxgRGEoG8mqoOpE6js
         XKPABgipIV5zI1bbzGToaFdttSQ9on3vO/0h7AHhN2349r+/o4nXk2tQ9zir/uj+PMqf
         7U3DT3YK7cdjRWUEqF0PhnLEVmVuRgxy0mUC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181367; x=1691773367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvoEOajiEwYXBD3xzLluGfgCVtGjTJSaHMHQydgzNEE=;
        b=fC75ku4as0A3az+0H9tXcmfT7nHKUsLgn77mzSplZEKHJ7Ief1YVubVOQJbzuKetay
         L/pkiYeCfvvLsQ1hLRnDUhwlGZUWCqgnIFYoxtcONFroHnhbw+niYLqnMh0FQuLWravb
         BvLGPWJcVTqPSnaAgl9mKeeHk01ry/57zPgb92EcAkSsMOv0tnXb4SOZ9Y/NolBK1/Dq
         ofBNWgRq1UA2PejVKpg6nxdMQjUPi4bT0VOiGnpKa6+03+k45+GtOiaB4CBXZtlgnjmK
         bRL9cgfxnwCvZ3dtTHBe0vcdqG6NY332Vwaobx8e7Wx5AHLKkjyEYlVVbNM3QxKdtEmA
         y3Zw==
X-Gm-Message-State: ABy/qLZC5m6Rqqzkf9enLguc5UgXCwnZ+kGbj6aE+QMIbZQvQEBuLrs7
	XyRo5sQ3+w8NZ6ABJSzvU6Ir/xBeKH1er1u0KdTFjg==
X-Google-Smtp-Source: APBJJlGlT858DQ/NfqPA3OlYGxIXp57HPZH8ded5Q4ToS48ybKGBOA2p1X6hcXClrEz/A6yz7yx5y/8vtOtl4ryFQpk=
X-Received: by 2002:a2e:8909:0:b0:2b6:9f5d:e758 with SMTP id
 d9-20020a2e8909000000b002b69f5de758mr19193207lji.9.1689181367032; Wed, 12 Jul
 2023 10:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230711233816.2187577-1-dhavale@google.com>
In-Reply-To: <20230711233816.2187577-1-dhavale@google.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 12 Jul 2023 13:02:35 -0400
Message-ID: <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To: Sandeep Dhavale <dhavale@google.com>
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
Cc: kernel-team@android.com, "Paul E. McKenney" <paulmck@kernel.org>, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Frederic Weisbecker <frederic@kernel.org>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 11, 2023 at 7:38=E2=80=AFPM Sandeep Dhavale <dhavale@google.com=
> wrote:
>
> Currently if CONFIG_DEBUG_LOCK_ALLOC is not set
>
> - rcu_read_lock_held() always returns 1
> - rcu_read_lock_any_held() may return 0 with CONFIG_PREEMPT_RCU
>
> This is inconsistent and it was discovered when trying a fix
> for problem reported [1] with CONFIG_DEBUG_LOCK_ALLOC is not
> set and CONFIG_PREEMPT_RCU is enabled. Gist of the problem is
> that EROFS wants to detect atomic context so it can do inline
> decompression whenever possible, this is important performance
> optimization. It turns out that z_erofs_decompressqueue_endio()
> can be called from blk_mq_flush_plug_list() with rcu lock held
> and hence fix uses rcu_read_lock_any_held() to decide to use
> sync/inline decompression vs async decompression.
>
> As per documentation, we should return lock is held if we aren't
> certain. But it seems we can improve the checks for if the lock
> is held even if CONFIG_DEBUG_LOCK_ALLOC is not set instead of
> hardcoding to always return true.
>
> * rcu_read_lock_held()
> - For CONFIG_PREEMPT_RCU using rcu_preempt_depth()
> - using preemptible() (indirectly preempt_count())
>
> * rcu_read_lock_bh_held()
> - For CONFIG_PREEMPT_RT Using in_softirq() (indirectly softirq_cont())
> - using preemptible() (indirectly preempt_count())
>
> Lastly to fix the inconsistency, rcu_read_lock_any_held() is updated
> to use other rcu_read_lock_*_held() checks.
>
> Two of the improved checks are moved to kernel/rcu/update.c because
> rcupdate.h is included from the very low level headers which do not know
> what current (task_struct) is so the macro rcu_preempt_depth() cannot be
> expanded in the rcupdate.h. See the original comment for
> rcu_preempt_depth() in patch at [2] for more information.
>
> [1]
> https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/
> [2]
> https://lore.kernel.org/all/1281392111-25060-8-git-send-email-paulmck@lin=
ux.vnet.ibm.com/
>
> Reported-by: Will Shiu <Will.Shiu@mediatek.com>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
>  include/linux/rcupdate.h | 12 +++---------
>  kernel/rcu/update.c      | 21 ++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5e5f920ade90..0d1d1d8c2360 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -319,14 +319,11 @@ int rcu_read_lock_any_held(void);
>  # define rcu_lock_acquire(a)           do { } while (0)
>  # define rcu_lock_release(a)           do { } while (0)
>
> -static inline int rcu_read_lock_held(void)
> -{
> -       return 1;
> -}
> +int rcu_read_lock_held(void);
>
>  static inline int rcu_read_lock_bh_held(void)
>  {
> -       return 1;
> +       return !preemptible() || in_softirq();
>  }
>
>  static inline int rcu_read_lock_sched_held(void)
> @@ -334,10 +331,7 @@ static inline int rcu_read_lock_sched_held(void)
>         return !preemptible();
>  }
>
> -static inline int rcu_read_lock_any_held(void)
> -{
> -       return !preemptible();
> -}
> +int rcu_read_lock_any_held(void);
>
>  static inline int debug_lockdep_rcu_enabled(void)
>  {
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 19bf6fa3ee6a..b34fc5bb96cf 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -390,8 +390,27 @@ int rcu_read_lock_any_held(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
>
> -#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> +#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>
> +int rcu_read_lock_held(void)
> +{
> +       if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +               return rcu_preempt_depth();
> +       return !preemptible();
> +}
> +EXPORT_SYMBOL_GPL(rcu_read_lock_held);
> +
> +int rcu_read_lock_any_held(void)
> +{
> +       if (rcu_read_lock_held() ||
> +           rcu_read_lock_bh_held() ||
> +           rcu_read_lock_sched_held())
> +               return 1;
> +       return !preemptible();

Actually even the original code is incorrect (the lockdep version)
since preemptible() cannot be relied upon if CONFIG_PREEMPT_COUNT is
not set. However, that's debug code. In this case, it is a real
user (the fs code). In non-preemptible kernels, we are always in an
RCU-sched section. So you can't really see if anyone called your code
under rcu_read_lock(). The rcu_read_lock/unlock() would be getting
NOOPed. In such a kernel, it will always tell your code it is in an
RCU reader. That's not ideal for that erofs code?

Also, per that erofs code:
        /* Use (kthread_)work and sync decompression for atomic contexts on=
ly */
        if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {

I guess you are also assuming that rcu_read_lock_any_held() tells you
something about atomicity but strictly speaking, it doesn't because
preemptible RCU readers are preemptible. You can't block but
preemption is possible so it is not "atomic". Maybe you meant "cannot
block"?

As such this patch looks correct to me, one thing I noticed is that
you can check rcu_is_watching() like the lockdep-enabled code does.
That will tell you also if a reader-section is possible because in
extended-quiescent-states, RCU readers should be non-existent or
that's a bug.

Could you also verify that this patch does not cause bloating of the
kernel if lockdep is disabled?

thanks,

 - Joel
