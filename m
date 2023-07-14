Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A777542B0
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 20:41:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=YirKGceA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2gKY0L4kz3c3k
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Jul 2023 04:41:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=YirKGceA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=mmpgouride@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2gKR06Dxz301f
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Jul 2023 04:40:57 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686c74183cso2167564b3a.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689360052; x=1691952052;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaj9+8bPsLOlF6cZ7IxpC9i332ISYKV4tQnH1g2SIjg=;
        b=YirKGceAT6z8ET47AGt8osx9wUnEZwVRRCBQZHQSamFop77w665Ha9AxUvrF3adJNl
         xQDrI2u82R6zWttobX+tbyAdXsHdMLX6eNJ4KTduJ+wevcQIaKOv4AqOGQNZMvuTQJux
         /6BjrBZCVm1uoiFRKksuEyjWFoaBXNJ2xi/PMl6K36Gw8PnHSfVWeldzIE1FPyMAYd5x
         jB3vv3a7OCj/9U44WR8/sooNl71zazoxW4MafdLgPDwoCkoVGXeUg0FIlfvMj3ac8VPT
         ySq0CVxnDFoTS47wkOQlMmvZNnUmlMdvLoHv8/P3vg8VHbtrgFlCpXreed+usx5GL6JA
         C9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360052; x=1691952052;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaj9+8bPsLOlF6cZ7IxpC9i332ISYKV4tQnH1g2SIjg=;
        b=mHTfwqTHppVRh6pNNvq32YxPMSb1Ae7gSR3m3kwbINxuprrUpMRBpdGAT3l9/HUXUS
         r3LXer6ENrEhrpRYbK/F0UyOaIwkhUWL5kL2v5Wu0tFADhPj1MzFKFY/ieNU1XTlJo6u
         gtYH6VxQ8TrOyuhqTrYmr0K9Qi1C/YvyMt0pLSS0kRxHr0owHEFeSMmojn4/tI0b/anx
         /IowxT6SG0uE52sh+5Obl/zszk9dpR7nL+bQc5jqqDxoUhd+/2tAVp+tioS+y2coy968
         A89vsE0s1ZSzghksKrgmOOrATFf6jF/sWNxzRQ15bRyS77lXcwDfRZBg/fDw4Ak5mWwI
         Ug5g==
X-Gm-Message-State: ABy/qLZz2XFsU1lSxHS5uLqIl4DcXClNiikravtQ8cFjLO+5LZ1W2gow
	Re4fQUAdMm5PDbuu12O/UrA=
X-Google-Smtp-Source: APBJJlEFEoxnqbfk0Z7qSbw4sOXIFQIuh8c1Vjjrexw29TFUt/+RNDWEBlkXAmd14E+5d9isBY4EAQ==
X-Received: by 2002:a05:6a21:6da5:b0:133:1a76:6bab with SMTP id wl37-20020a056a216da500b001331a766babmr6838645pzb.47.1689360052379;
        Fri, 14 Jul 2023 11:40:52 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id ey4-20020a056a0038c400b00672401787c6sm7455354pfb.109.2023.07.14.11.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:40:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop>
Date: Sat, 15 Jul 2023 02:40:08 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
References: <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com>
 <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
 <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
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
Cc: kernel-team@android.com, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


> 2023=E5=B9=B47=E6=9C=8815=E6=97=A5 01:02=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 14, 2023 at 11:54:47PM +0800, Alan Huang wrote:
>>=20
>>> 2023=E5=B9=B47=E6=9C=8814=E6=97=A5 23:35=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>>=20
>>>> 2023=E5=B9=B47=E6=9C=8814=E6=97=A5 10:16=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>> On Thu, Jul 13, 2023 at 09:33:35AM -0700, Paul E. McKenney wrote:
>>>>> On Thu, Jul 13, 2023 at 11:33:24AM -0400, Joel Fernandes wrote:
>>>>>> On Thu, Jul 13, 2023 at 10:34=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>>>>>> On 2023/7/13 22:07, Joel Fernandes wrote:
>>>>>>>> On Thu, Jul 13, 2023 at 12:59=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>>>>>>>> On 2023/7/13 12:52, Paul E. McKenney wrote:
>>>>>>>>>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
>>>>>>>>>=20
>>>>>>>>> ...
>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> There are lots of performance issues here and even a plumber
>>>>>>>>>>> topic last year to show that, see:
>>>>>>>>>>>=20
>>>>>>>>>>> [1] =
https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
>>>>>>>>>>> [2] =
https://lore.kernel.org/r/CAHk-=3DwgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03=
qCOGg@mail.gmail.com
>>>>>>>>>>> [3] =
https://lore.kernel.org/r/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyU=
qFneQ@mail.gmail.com
>>>>>>>>>>> [4] https://lpc.events/event/16/contributions/1338/
>>>>>>>>>>> and more.
>>>>>>>>>>>=20
>>>>>>>>>>> I'm not sure if it's necessary to look info all of that,
>>>>>>>>>>> andSandeep knows more than I am (the scheduling issue
>>>>>>>>>>> becomes vital on some aarch64 platform.)
>>>>>>>>>>=20
>>>>>>>>>> Hmmm...  Please let me try again.
>>>>>>>>>>=20
>>>>>>>>>> Assuming that this approach turns out to make sense, the =
resulting
>>>>>>>>>> patch will need to clearly state the performance benefits =
directly in
>>>>>>>>>> the commit log.
>>>>>>>>>>=20
>>>>>>>>>> And of course, for the approach to make sense, it must avoid =
breaking
>>>>>>>>>> the existing lockdep-RCU debugging code.
>>>>>>>>>>=20
>>>>>>>>>> Is that more clear?
>>>>>>>>>=20
>>>>>>>>> Personally I'm not working on Android platform any more so I =
don't
>>>>>>>>> have a way to reproduce, hopefully Sandeep could give actually
>>>>>>>>> number _again_ if dm-verity is enabled and trigger another
>>>>>>>>> workqueue here and make a comparsion why the scheduling =
latency of
>>>>>>>>> the extra work becomes unacceptable.
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Question from my side, are we talking about only performance =
issues or
>>>>>>>> also a crash? It appears z_erofs_decompress_pcluster() takes
>>>>>>>> mutex_lock(&pcl->lock);
>>>>>>>>=20
>>>>>>>> So if it is either in an RCU read-side critical section or in =
an
>>>>>>>> atomic section, like the softirq path, then it may
>>>>>>>> schedule-while-atomic or trigger RCU warnings.
>>>>>>>>=20
>>>>>>>> z_erofs_decompressqueue_endio
>>>>>>>> -> z_erofs_decompress_kickoff
>>>>>>>> ->z_erofs_decompressqueue_work
>>>>>>>> ->z_erofs_decompress_queue
>>>>>>>>  -> z_erofs_decompress_pcluster
>>>>>>>>   -> mutex_lock
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Why does the softirq path not trigger a workqueue instead?
>>>>>>=20
>>>>>> I said "if it is". I was giving a scenario. mutex_lock() is not
>>>>>> allowed in softirq context or in an RCU-reader.
>>>>>>=20
>>>>>>>> Per Sandeep in [1], this stack happens under RCU read-lock in:
>>>>>>>>=20
>>>>>>>> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) =
\
>>>>>>>> [...]
>>>>>>>>               rcu_read_lock();
>>>>>>>>               (dispatch_ops);
>>>>>>>>               rcu_read_unlock();
>>>>>>>> [...]
>>>>>>>>=20
>>>>>>>> Coming from:
>>>>>>>> blk_mq_flush_plug_list ->
>>>>>>>>                          blk_mq_run_dispatch_ops(q,
>>>>>>>>                               __blk_mq_flush_plug_list(q, =
plug));
>>>>>>>>=20
>>>>>>>> and __blk_mq_flush_plug_list does this:
>>>>>>>>         q->mq_ops->queue_rqs(&plug->mq_list);
>>>>>>>>=20
>>>>>>>> This somehow ends up calling the bio_endio and the
>>>>>>>> z_erofs_decompressqueue_endio which grabs the mutex.
>>>>>>>>=20
>>>>>>>> So... I have a question, it looks like one of the paths in
>>>>>>>> __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the =
alternate
>>>>>>>> path uses RCU. Why does this alternate want to block even if it =
is not
>>>>>>>> supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING =
should
>>>>>>>> be set? It sounds like you want to block in the "else" path =
even
>>>>>>>> though BLK_MQ_F_BLOCKING is not set:
>>>>>>>=20
>>>>>>> BLK_MQ_F_BLOCKING is not a flag that a filesystem can do =
anything with.
>>>>>>> That is block layer and mq device driver stuffs. filesystems =
cannot set
>>>>>>> this value.
>>>>>>>=20
>>>>>>> As I said, as far as I understand, previously,
>>>>>>> .end_io() can only be called without RCU context, so it will be =
fine,
>>>>>>> but I don't know when .end_io() can be called under some RCU =
context
>>>>>>> now.
>>>>>>=20
>>>>>>> =46rom what Sandeep described, the code path is in an RCU =
reader. My
>>>>>> question is more, why doesn't it use SRCU instead since it =
clearly
>>>>>> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a =
deeper
>>>>>> dive needs to be made into that before concluding that the fix is =
to
>>>>>> use rcu_read_lock_any_held().
>>>>>=20
>>>>> How can this be solved?
>>>>>=20
>>>>> 1. Always use a workqueue.  Simple, but is said to have =
performance
>>>>> issues.
>>>>>=20
>>>>> 2. Pass a flag in that indicates whether or not the caller is in =
an
>>>>> RCU read-side critical section.  Conceptually simple, but might
>>>>> or might not be reasonable to actually implement in the code as
>>>>> it exists now. (You tell me!)
>>>>>=20
>>>>> 3. Create a function in z_erofs that gives you a decent
>>>>> approximation, maybe something like the following.
>>>>>=20
>>>>> 4. Other ideas here.
>>>>=20
>>>> 5. #3 plus make the corresponding Kconfig option select
>>>> PREEMPT_COUNT, assuming that any users needing compression in
>>>> non-preemptible kernels are OK with PREEMPT_COUNT being set.
>>>> (Some users of non-preemptible kernels object strenuously
>>>> to the added overhead from CONFIG_PREEMPT_COUNT=3Dy.)
>>>=20
>>> 6. Set one bit in bio->bi_private, check the bit and flip it in =
rcu_read_lock() path,
>>> then in z_erofs_decompressqueue_endio, check if the bit has changed.
>>=20
>> Seems bad, read and modify bi_private is a bad idea.
>=20
> Is there some other field that would work?

Maybe bio->bi_opf, btrfs uses some bits of it.

>=20
> Thanx, Paul
>=20
>>> Not sure if this is feasible or acceptable. :)
>>>=20
>>>>=20
>>>> Thanx, Paul
>>>>=20
>>>>> The following is untested, and is probably quite buggy, but it =
should
>>>>> provide you with a starting point.
>>>>>=20
>>>>> static bool z_erofs_wq_needed(void)
>>>>> {
>>>>> if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
>>>>> return true;  // RCU reader
>>>>> if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preemptible())
>>>>> return true;  // non-preemptible
>>>>> if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
>>>>> return true;  // non-preeemptible kernel, so play it safe
>>>>> return false;
>>>>> }
>>>>>=20
>>>>> You break it, you buy it!  ;-)
>>>>>=20
>>>>> Thanx, Paul


