Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE7875249D
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 16:07:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=JQ7KiJhW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1xJT3BFpz3bc0
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 00:07:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=JQ7KiJhW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=joelfernandes.org (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=joel@joelfernandes.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1xJL50Wdz30hn
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 00:07:28 +1000 (AEST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b700e85950so11276831fa.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689257242; x=1691849242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VetRvpfHAl+7aT62estFL8urvYkxAXvxSJOfEqVowI0=;
        b=JQ7KiJhWMJXnO2cYjxA24xph8LHGaEdN6qv+8ng7hb6Gd5MBB1YNyRdzG9N6x2GKFk
         mnEoDcl4UDekzSWKbHb1mXBBOaqhDs61+6NW3D0O7pXVH1qdtM/8Mjc6QJkxcXWT42Yi
         rsPagD4NO4Xo7ozcn+D/6Atc5J8bqyg9ptvWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257242; x=1691849242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VetRvpfHAl+7aT62estFL8urvYkxAXvxSJOfEqVowI0=;
        b=D++RAGtUHADxVGL8JkV4Waqarh/jJFLF/t4NLM0TOaZaSzpHZv/HsdJ+Rko131QTdg
         bgkFA6wqAIi8SG+uVKWlq8URp/IK2XFUFX7p5WFkXgc9pgP8Pz7XxKhjeVgZps0gCwHK
         ZOKqylcb6EsKUo3TrSkzcAbitwzKPjdSQuJWngmombm7zf9vgf7TNJCzxHOtDnfvxhjR
         7OLD6gBA7qjdg4ldBDTlq+UDhoB46ZNJ7rCHerLmEiN6+ibGh33sRg+7RjFSDsAIiW/1
         RHh49Xr9G7Af47VbrsgOB5/r+5VcE3diIjkWUrvNkZX/kA+eD1ojDpWFHGUQbtXiYKQT
         jY0A==
X-Gm-Message-State: ABy/qLYVbBb1ouRQzqPEHIG+M2ACJV/9gxPfqkwQ6TYyvRmCJD1mDZR7
	FFdyCbamgIzYrrxc7SXV0wJ2/Z3OPXnQe2SdEy2XkA==
X-Google-Smtp-Source: APBJJlHakzTakvWuXTE4xEig/uKU7qpHZKFcIXnENVYBM0J8b9VWGVpFowyZJ3Mg87cTgBlaqEaAQLBFKYdOYqAgMOU=
X-Received: by 2002:a2e:9054:0:b0:2b6:a22f:9fb9 with SMTP id
 n20-20020a2e9054000000b002b6a22f9fb9mr1513875ljg.27.1689257242317; Thu, 13
 Jul 2023 07:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230711233816.2187577-1-dhavale@google.com> <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com> <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop> <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop> <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
In-Reply-To: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 13 Jul 2023 10:07:10 -0400
Message-ID: <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: kernel-team@android.com, paulmck@kernel.org, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Frederic Weisbecker <frederic@kernel.org>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 13, 2023 at 12:59=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
> On 2023/7/13 12:52, Paul E. McKenney wrote:
> > On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
> >>
> >>
>
> ...
>
> >>
> >> There are lots of performance issues here and even a plumber
> >> topic last year to show that, see:
> >>
> >> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
> >> [2] https://lore.kernel.org/r/CAHk-=3DwgE9kORADrDJ4nEsHHLirqPCZ1tGaEPA=
ZejHdZ03qCOGg@mail.gmail.com
> >> [3] https://lore.kernel.org/r/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW=
8GbO6wyUqFneQ@mail.gmail.com
> >> [4] https://lpc.events/event/16/contributions/1338/
> >> and more.
> >>
> >> I'm not sure if it's necessary to look info all of that,
> >> andSandeep knows more than I am (the scheduling issue
> >> becomes vital on some aarch64 platform.)
> >
> > Hmmm...  Please let me try again.
> >
> > Assuming that this approach turns out to make sense, the resulting
> > patch will need to clearly state the performance benefits directly in
> > the commit log.
> >
> > And of course, for the approach to make sense, it must avoid breaking
> > the existing lockdep-RCU debugging code.
> >
> > Is that more clear?
>
> Personally I'm not working on Android platform any more so I don't
> have a way to reproduce, hopefully Sandeep could give actually
> number _again_ if dm-verity is enabled and trigger another
> workqueue here and make a comparsion why the scheduling latency of
> the extra work becomes unacceptable.
>

Question from my side, are we talking about only performance issues or
also a crash? It appears z_erofs_decompress_pcluster() takes
mutex_lock(&pcl->lock);

So if it is either in an RCU read-side critical section or in an
atomic section, like the softirq path, then it may
schedule-while-atomic or trigger RCU warnings.

z_erofs_decompressqueue_endio
-> z_erofs_decompress_kickoff
 ->z_erofs_decompressqueue_work
  ->z_erofs_decompress_queue
   -> z_erofs_decompress_pcluster
    -> mutex_lock

Per Sandeep in [1], this stack happens under RCU read-lock in:

#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
[...]
                rcu_read_lock();
                (dispatch_ops);
                rcu_read_unlock();
[...]

Coming from:
blk_mq_flush_plug_list ->
                           blk_mq_run_dispatch_ops(q,
                                __blk_mq_flush_plug_list(q, plug));

and __blk_mq_flush_plug_list does this:
          q->mq_ops->queue_rqs(&plug->mq_list);

This somehow ends up calling the bio_endio and the
z_erofs_decompressqueue_endio which grabs the mutex.

So... I have a question, it looks like one of the paths in
__blk_mq_run_dispatch_ops() uses SRCU.  Where are as the alternate
path uses RCU. Why does this alternate want to block even if it is not
supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING should
be set? It sounds like you want to block in the "else" path even
though BLK_MQ_F_BLOCKING is not set:

/* run the code block in @dispatch_ops with rcu/srcu read lock held */
#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
do {                                                            \
        if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {          \
                struct blk_mq_tag_set *__tag_set =3D (q)->tag_set; \
                int srcu_idx;                                   \
                                                                \
                might_sleep_if(check_sleep);                    \
                srcu_idx =3D srcu_read_lock(__tag_set->srcu);     \
                (dispatch_ops);                                 \
                srcu_read_unlock(__tag_set->srcu, srcu_idx);    \
        } else {                                                \
                rcu_read_lock();                                \
                (dispatch_ops);                                 \
                rcu_read_unlock();                              \
        }                                                       \
} while (0);

It seems quite incorrect to me that erofs wants to block even though
clearly BLK_MQ_F_BLOCKING is not set. Did I miss something? I believe
it may be more beneficial to correct this properly now, rather than
maintaining the appearance of non-blocking operations and potentially
having to manage atomicity detection with preempt counters at a later
stage.

thanks,

 - Joel

[1] https://lore.kernel.org/all/CAB=3DBE-QV0PiKFpCOcdEUFxS4wJHsLCcsymAw+nP7=
2Yr3b1WMng@mail.gmail.com/
