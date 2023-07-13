Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 145EE752979
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 19:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689267974;
	bh=ZyYOdDl3xwqmWSMjOherr+Wl4DKR7ur8sLJjiZ8B/A8=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=b693kSzTjK8nLe5uNp5j4dCu0g6xji97N7+CETk76D059s3h53h7MqSis0rHuzT1e
	 3xv97OJAYubMAis8i7xX9EmEidPmvXtom1ykpL4Af0lOaQ3sagqT+GT0AMdTikQ3Io
	 4x+zdDO9KobitJtGY/lfJ1ooOnW3y34G8Xjgoq3K6och6QmIOhupVwgQGNAximf2pk
	 XRO6xQZavdGbs+gYpvxO0640t6+v2geUX+4Mzmi6gi8hcZ/gfQel4h+oL2OojSQHsl
	 Pj4UR5GIXTC8jgp7ehWxwum1QrnkjoW8y+hQ6zQc6PRN/Ge6zFdYveWwnIblVMT7U5
	 89EyMCsgBuQAg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R21GY6qfRz3c3t
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 03:06:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=ISi2RxOz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R21GR0rflz30PW
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 03:06:05 +1000 (AEST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-314319c0d3eso978707f8f.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 10:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267958; x=1691859958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyYOdDl3xwqmWSMjOherr+Wl4DKR7ur8sLJjiZ8B/A8=;
        b=TcA0pdPE/6VAQdxz5wo/T/irA52vSZUYNyA5mj2pJ96aL8PrmyCT5mvtrjQSYwTcz9
         hkA5DH4WSB9jiSESSZWGyz1gqh+fi7kjDjzdhzsOR17wAu5ZM7ZNqohYaXBHpeNA4Bow
         OlRt7myDrP6ltkXyehm/uQaWDPlejQt8NbiGGnASgLmXlZl+gjRuDb3IDBtl224yZk5o
         g00hWWZ88Va3o1jzmTmj73VrxAMm7wAfl/GDxNsUqnn3nIx2MUJU0Og1bd/vk5c1qItT
         7FULJVLcwacKewOI2dRPaftth9hOeVia2zeMyO77+sQXoQspYCiJmL8bHGl08AsNgrr5
         KPCw==
X-Gm-Message-State: ABy/qLZaw5AvVF1YpE53BFnVzt2sDgRFoimjo0acP274EgNNoJbTaQGm
	TIRXIvaWGvGztSY1jOEaXdyLof1ZYH6SD1XUGDnTNQ==
X-Google-Smtp-Source: APBJJlFyLvmhQCX5nI+rcMbwxp+/tcnDtwevbdff0qrkn1BHI5o5JXj5DeDKLsClwiabVGsQxskCQa+dsFm1gWGhye4=
X-Received: by 2002:adf:e483:0:b0:314:db7:d132 with SMTP id
 i3-20020adfe483000000b003140db7d132mr2106439wrm.61.1689267957936; Thu, 13 Jul
 2023 10:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com> <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop> <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop> <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com> <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
In-Reply-To: <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
Date: Thu, 13 Jul 2023 10:05:46 -0700
Message-ID: <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To: paulmck@kernel.org
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
Cc: kernel-team@android.com, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello All,

Let me answer some of the questions raised here.

* Performance aspect
EROFS is one of the popular filesystem of choice in Android for read
only partitions
as it provides 30%+ storage space savings with compression.
In addition to microbenchmarks, boot times and cold app launch
benchmarks are very
important to the Android ecosystem as they directly translate to
responsiveness from user point of view. We saw some
performance penalty in cold app launch benchmarks in a few scenarios.
Analysis showed that the significant variance was coming from the
scheduling cost while decompression cost was more or less the same.
Please see the [1] which shows scheduling costs for kthread vs kworker.

> Just out of curiosity, exactly how much is it costing to trigger the
workqueue?
I think the cost to trigger is not much, it's the actual scheduling latency for
the thread is the one which we want to cut down. And if we are already in
thread context then there is no point in incurring any extra cost if
we can detect
it reliably. That is what erofs check is trying to do.

>One additional question...  What is your plan for kernels built with
CONFIG_PREEMPT_COUNT=n?
If there is no reliable way to detect if we can block or not then in that
case erofs has no option but to schedule the kworker.

* Regarding BLK_MQ_F_BLOCKING
As mentioned by Gao in the thread this is a property of blk-mq device
underneath,
so erofs cannot control it has it has to work with different types of
block devices.

* Regarding rcu_is_watching()

>I am assuming you mean you would grab the mutex accidentally when in an RCU
reader, and might_sleep() presumably in the mutex internal code will scream?

Thank you Paul for explaining in detail why it is important. I can get
the V2 going.
From the looking at the code at kernel/sched/core.c which only looks
at rcu_preempt_depth(),
I am thinking it may still get triggered IIUC.

> The following is untested, and is probably quite buggy, but it should
provide you with a starting point.
..

Yes, that can fix the problem at hand as the erofs check also looks
for rcu_preempt_depth().
A similar approach was discarded as rcu_preempt_depth() was though to
be low level
and we used rcu_read_lock_any_held() which is the superset until we
figured out inconsistency
when ! CONFIG_DEBUG_LOCK_ALLOC.

Paul, Joel,
Shall we fix the rcu_read_lock_*held() regardless of how erofs
improves the check?

Thanks,
Sandeep.

[1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
