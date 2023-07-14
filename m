Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF61753F5F
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 17:55:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=d13J78Ha;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2bfW3PPQz3c50
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Jul 2023 01:55:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=d13J78Ha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=mmpgouride@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2bfS359xz30K1
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Jul 2023 01:55:27 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1436386b3a.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689350124; x=1691942124;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqpmYVnbbHnWcNUmmhC8NRk/JXLwLEr9LrHoxThT/cY=;
        b=d13J78Hae+iUwr3wrXVIbKZGmYbkfAut0VdeD0DMDSWYuc5Ae+8BKpnTACIzYGzUSr
         xgaceyN8+odllP4SgLtjA1yGOuhSjlEklNahp9nGFh9khSJfarg4RfEGlpMjngPfDV3t
         uLMW+Z6G0NxBau/8Dw8UlB1Oeyq5BMqoWK2/sOjRU1m3vFWSshRKP+QpACOdTldQplni
         FmucbEuWy0I1djDWT32XMtsXST1X1izEqeqTKslbASkaIPNb5nnWlqkht/jdX+ZhA1xr
         m2aJniiHAH7WfQdM/JrTjGr9plc+V3BaE96BJ09aZjPfhFKSfdYNvE25DUNFatCwgG44
         4+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350124; x=1691942124;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqpmYVnbbHnWcNUmmhC8NRk/JXLwLEr9LrHoxThT/cY=;
        b=ObzSVksZijO5aJ2JLw9meae+EMIDJMIIx/fjJ/srwk8OMASNWCv2MGia9uYG7DidTe
         qw47eipH4eiyuGn9LA+iZyRQd6cn3FeQn5VJW+/BG3xN2CvNaZ6+QgCd85VZTs8srB7Y
         tavik+ZqQ7OsmP44shouZRbgx9SzhKJQdpHconVDc+EtUJCe0MtKxt0c4RZy4Aa52WKh
         pBDjlCFzFJ13yGsETxkZJLxyFa5vr/Ad/ZuvQ0rgiO4hK4XgZ0Po7Ouhx/JzMRuTsc8C
         804ggYU3hibBlUlhRi1Uhen9edOEoKQ0D0wkV2TUnB/RvWn6SBDaPyj79aGAcbDMSFvJ
         na8A==
X-Gm-Message-State: ABy/qLYHM6CpazzlVMViKNCjWktzbKcRYrVEiCueh0dfu7H964QL71se
	xBuu0RsSXO13xz7Kl6GN3Y8=
X-Google-Smtp-Source: APBJJlFLtHyaTBNofj23qOOxXXlk4tAx2QA0XgqPxV6RE2bcgC1mkUTiSZRm/PZ3ZVGkQtzOGNrZSw==
X-Received: by 2002:a05:6a20:101a:b0:12d:8d4d:27e9 with SMTP id gs26-20020a056a20101a00b0012d8d4d27e9mr3678882pzc.15.1689350124359;
        Fri, 14 Jul 2023 08:55:24 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id s4-20020a63b404000000b0055adced9e13sm7098528pgf.0.2023.07.14.08.55.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 08:55:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com>
Date: Fri, 14 Jul 2023 23:54:47 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
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
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com>
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


> 2023=E5=B9=B47=E6=9C=8814=E6=97=A5 23:35=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>>=20
>> 2023=E5=B9=B47=E6=9C=8814=E6=97=A5 10:16=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> On Thu, Jul 13, 2023 at 09:33:35AM -0700, Paul E. McKenney wrote:
>>> On Thu, Jul 13, 2023 at 11:33:24AM -0400, Joel Fernandes wrote:
>>>> On Thu, Jul 13, 2023 at 10:34=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>>>> On 2023/7/13 22:07, Joel Fernandes wrote:
>>>>>> On Thu, Jul 13, 2023 at 12:59=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>>>>>> On 2023/7/13 12:52, Paul E. McKenney wrote:
>>>>>>>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
>>>>>>>=20
>>>>>>> ...
>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> There are lots of performance issues here and even a plumber
>>>>>>>>> topic last year to show that, see:
>>>>>>>>>=20
>>>>>>>>> [1] =
https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
>>>>>>>>> [2] =
https://lore.kernel.org/r/CAHk-=3DwgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03=
qCOGg@mail.gmail.com
>>>>>>>>> [3] =
https://lore.kernel.org/r/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyU=
qFneQ@mail.gmail.com
>>>>>>>>> [4] https://lpc.events/event/16/contributions/1338/
>>>>>>>>> and more.
>>>>>>>>>=20
>>>>>>>>> I'm not sure if it's necessary to look info all of that,
>>>>>>>>> andSandeep knows more than I am (the scheduling issue
>>>>>>>>> becomes vital on some aarch64 platform.)
>>>>>>>>=20
>>>>>>>> Hmmm...  Please let me try again.
>>>>>>>>=20
>>>>>>>> Assuming that this approach turns out to make sense, the =
resulting
>>>>>>>> patch will need to clearly state the performance benefits =
directly in
>>>>>>>> the commit log.
>>>>>>>>=20
>>>>>>>> And of course, for the approach to make sense, it must avoid =
breaking
>>>>>>>> the existing lockdep-RCU debugging code.
>>>>>>>>=20
>>>>>>>> Is that more clear?
>>>>>>>=20
>>>>>>> Personally I'm not working on Android platform any more so I =
don't
>>>>>>> have a way to reproduce, hopefully Sandeep could give actually
>>>>>>> number _again_ if dm-verity is enabled and trigger another
>>>>>>> workqueue here and make a comparsion why the scheduling latency =
of
>>>>>>> the extra work becomes unacceptable.
>>>>>>>=20
>>>>>>=20
>>>>>> Question from my side, are we talking about only performance =
issues or
>>>>>> also a crash? It appears z_erofs_decompress_pcluster() takes
>>>>>> mutex_lock(&pcl->lock);
>>>>>>=20
>>>>>> So if it is either in an RCU read-side critical section or in an
>>>>>> atomic section, like the softirq path, then it may
>>>>>> schedule-while-atomic or trigger RCU warnings.
>>>>>>=20
>>>>>> z_erofs_decompressqueue_endio
>>>>>> -> z_erofs_decompress_kickoff
>>>>>> ->z_erofs_decompressqueue_work
>>>>>>  ->z_erofs_decompress_queue
>>>>>>   -> z_erofs_decompress_pcluster
>>>>>>    -> mutex_lock
>>>>>>=20
>>>>>=20
>>>>> Why does the softirq path not trigger a workqueue instead?
>>>>=20
>>>> I said "if it is". I was giving a scenario. mutex_lock() is not
>>>> allowed in softirq context or in an RCU-reader.
>>>>=20
>>>>>> Per Sandeep in [1], this stack happens under RCU read-lock in:
>>>>>>=20
>>>>>> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
>>>>>> [...]
>>>>>>                rcu_read_lock();
>>>>>>                (dispatch_ops);
>>>>>>                rcu_read_unlock();
>>>>>> [...]
>>>>>>=20
>>>>>> Coming from:
>>>>>> blk_mq_flush_plug_list ->
>>>>>>                           blk_mq_run_dispatch_ops(q,
>>>>>>                                __blk_mq_flush_plug_list(q, =
plug));
>>>>>>=20
>>>>>> and __blk_mq_flush_plug_list does this:
>>>>>>          q->mq_ops->queue_rqs(&plug->mq_list);
>>>>>>=20
>>>>>> This somehow ends up calling the bio_endio and the
>>>>>> z_erofs_decompressqueue_endio which grabs the mutex.
>>>>>>=20
>>>>>> So... I have a question, it looks like one of the paths in
>>>>>> __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the =
alternate
>>>>>> path uses RCU. Why does this alternate want to block even if it =
is not
>>>>>> supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING =
should
>>>>>> be set? It sounds like you want to block in the "else" path even
>>>>>> though BLK_MQ_F_BLOCKING is not set:
>>>>>=20
>>>>> BLK_MQ_F_BLOCKING is not a flag that a filesystem can do anything =
with.
>>>>> That is block layer and mq device driver stuffs. filesystems =
cannot set
>>>>> this value.
>>>>>=20
>>>>> As I said, as far as I understand, previously,
>>>>> .end_io() can only be called without RCU context, so it will be =
fine,
>>>>> but I don't know when .end_io() can be called under some RCU =
context
>>>>> now.
>>>>=20
>>>>> =46rom what Sandeep described, the code path is in an RCU reader. =
My
>>>> question is more, why doesn't it use SRCU instead since it clearly
>>>> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a =
deeper
>>>> dive needs to be made into that before concluding that the fix is =
to
>>>> use rcu_read_lock_any_held().
>>>=20
>>> How can this be solved?
>>>=20
>>> 1. Always use a workqueue.  Simple, but is said to have performance
>>> issues.
>>>=20
>>> 2. Pass a flag in that indicates whether or not the caller is in an
>>> RCU read-side critical section.  Conceptually simple, but might
>>> or might not be reasonable to actually implement in the code as
>>> it exists now. (You tell me!)
>>>=20
>>> 3. Create a function in z_erofs that gives you a decent
>>> approximation, maybe something like the following.
>>>=20
>>> 4. Other ideas here.
>>=20
>> 5. #3 plus make the corresponding Kconfig option select
>> PREEMPT_COUNT, assuming that any users needing compression in
>> non-preemptible kernels are OK with PREEMPT_COUNT being set.
>> (Some users of non-preemptible kernels object strenuously
>> to the added overhead from CONFIG_PREEMPT_COUNT=3Dy.)
>=20
> 6. Set one bit in bio->bi_private, check the bit and flip it in =
rcu_read_lock() path,
> then in z_erofs_decompressqueue_endio, check if the bit has changed.

Seems bad, read and modify bi_private is a bad idea.

>=20
> Not sure if this is feasible or acceptable. :)
>=20
>>=20
>> Thanx, Paul
>>=20
>>> The following is untested, and is probably quite buggy, but it =
should
>>> provide you with a starting point.
>>>=20
>>> static bool z_erofs_wq_needed(void)
>>> {
>>> if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
>>> return true;  // RCU reader
>>> if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preemptible())
>>> return true;  // non-preemptible
>>> if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
>>> return true;  // non-preeemptible kernel, so play it safe
>>> return false;
>>> }
>>>=20
>>> You break it, you buy it!  ;-)
>>>=20
>>> Thanx, Paul


