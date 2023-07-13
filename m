Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F875280F
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 18:10:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=c2E9mIDJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R20211T0Wz3c5J
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 02:10:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=c2E9mIDJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=mmpgouride@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R201v4Q2Gz3c49
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 02:10:09 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66869feb7d1so607173b3a.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689264606; x=1691856606;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFA+rAOBlK7dj9RX5CVH5OmkQ4lR5Bx+d7rkJn4GaaE=;
        b=c2E9mIDJpD7t/98YIgVUOCSXxLvm/0qSytZn3/2eGApw6oqZX2WcIKKE+5i2shqh8p
         NNZqOWc117Eq+TV8BkkmptmOHhu7HqOZVm8U7GFSUuQNqNjXP9jcfR+em0HNbPBK3civ
         tEEk9rPXmpwSl8PSDJWntoY+qOfQ4o1fr5LSp2CN0Ej0LZuEsOAWsc1SFlyZDvTMpeK2
         SUBIwiUBmzaG0B6RT1zLc89W86Wd8LwW1IR0gFsJKcsndI9X+iYNG/NazP6jvmRYAs6U
         gXve7j/KEweMkY3jfXvzI/8arxAotXbzClUrVYYP9/ZWQYecAY0pOOT/w/kvDQJeXdnf
         gGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689264606; x=1691856606;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFA+rAOBlK7dj9RX5CVH5OmkQ4lR5Bx+d7rkJn4GaaE=;
        b=UETJh0LGUczFJwUx6k51Qt7Bic9thfZby4xL+DHG2fsUgLzpWyG5WpYEW8sGATR1es
         MJP66cBTbgxfjmkd8gddIWC6/5st67RJ/nB6EgawBLPavyFPp/Di0uAIuJUb+tSMyXgC
         ZcVtw5+BE6rkCVPuqP0k292L21pUjCEo/D+C7ScQ8OWwX8C8Z+d0eioYcsxyT5gVv3ba
         j3EKY0tyWNTKUEzUbHp0hH/O/jvf9Y2DOdxs2+5FKcW/a9WwXq5qYz4Z3psmPXCBBUMH
         1egCUYTU39f6uoO7E8E2jcWyxyeZT4nPzs2s5syThDymuuX6SojvMOIItx3zmedA//1k
         dh/g==
X-Gm-Message-State: ABy/qLa8Mq0G6llTA/j0MJFwh+Q1R4kL5uNBd5e67DgAUyjSgZHxfKWY
	rBI3VFF2Gxo9vfcxa20ti8c=
X-Google-Smtp-Source: APBJJlF//ZLeGR7hxcXpHjt+wbqlsryzMUKsUz5sg0f7ha+7KhPYLSQlV/dqtvVvjLCaxGfQkQPG3w==
X-Received: by 2002:a17:902:bb89:b0:1b0:2658:daf7 with SMTP id m9-20020a170902bb8900b001b02658daf7mr1271207pls.36.1689264606583;
        Thu, 13 Jul 2023 09:10:06 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709026ac500b001b8918da8d1sm6118793plt.80.2023.07.13.09.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2023 09:10:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
Date: Fri, 14 Jul 2023 00:09:27 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7D5032D-908E-4227-8A38-AF740AC86CDC@gmail.com>
References: <20230711233816.2187577-1-dhavale@google.com>
 <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
To: Joel Fernandes <joel@joelfernandes.org>
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
Cc: kernel-team@android.com, paulmck@kernel.org, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mediatek@lists.infradead.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


> 2023=E5=B9=B47=E6=9C=8813=E6=97=A5 23:33=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 13, 2023 at 10:34=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>=20
>>=20
>>=20
>> On 2023/7/13 22:07, Joel Fernandes wrote:
>>> On Thu, Jul 13, 2023 at 12:59=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>>> On 2023/7/13 12:52, Paul E. McKenney wrote:
>>>>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
>>>>>>=20
>>>>>>=20
>>>>=20
>>>> ...
>>>>=20
>>>>>>=20
>>>>>> There are lots of performance issues here and even a plumber
>>>>>> topic last year to show that, see:
>>>>>>=20
>>>>>> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
>>>>>> [2] =
https://lore.kernel.org/r/CAHk-=3DwgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03=
qCOGg@mail.gmail.com
>>>>>> [3] =
https://lore.kernel.org/r/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyU=
qFneQ@mail.gmail.com
>>>>>> [4] https://lpc.events/event/16/contributions/1338/
>>>>>> and more.
>>>>>>=20
>>>>>> I'm not sure if it's necessary to look info all of that,
>>>>>> andSandeep knows more than I am (the scheduling issue
>>>>>> becomes vital on some aarch64 platform.)
>>>>>=20
>>>>> Hmmm...  Please let me try again.
>>>>>=20
>>>>> Assuming that this approach turns out to make sense, the resulting
>>>>> patch will need to clearly state the performance benefits directly =
in
>>>>> the commit log.
>>>>>=20
>>>>> And of course, for the approach to make sense, it must avoid =
breaking
>>>>> the existing lockdep-RCU debugging code.
>>>>>=20
>>>>> Is that more clear?
>>>>=20
>>>> Personally I'm not working on Android platform any more so I don't
>>>> have a way to reproduce, hopefully Sandeep could give actually
>>>> number _again_ if dm-verity is enabled and trigger another
>>>> workqueue here and make a comparsion why the scheduling latency of
>>>> the extra work becomes unacceptable.
>>>>=20
>>>=20
>>> Question from my side, are we talking about only performance issues =
or
>>> also a crash? It appears z_erofs_decompress_pcluster() takes
>>> mutex_lock(&pcl->lock);
>>>=20
>>> So if it is either in an RCU read-side critical section or in an
>>> atomic section, like the softirq path, then it may
>>> schedule-while-atomic or trigger RCU warnings.
>>>=20
>>> z_erofs_decompressqueue_endio
>>> -> z_erofs_decompress_kickoff
>>>  ->z_erofs_decompressqueue_work
>>>   ->z_erofs_decompress_queue
>>>    -> z_erofs_decompress_pcluster
>>>     -> mutex_lock
>>>=20
>>=20
>> Why does the softirq path not trigger a workqueue instead?
>=20
> I said "if it is". I was giving a scenario. mutex_lock() is not
> allowed in softirq context or in an RCU-reader.
>=20
>>> Per Sandeep in [1], this stack happens under RCU read-lock in:
>>>=20
>>> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
>>> [...]
>>>                 rcu_read_lock();
>>>                 (dispatch_ops);
>>>                 rcu_read_unlock();
>>> [...]
>>>=20
>>> Coming from:
>>> blk_mq_flush_plug_list ->
>>>                            blk_mq_run_dispatch_ops(q,
>>>                                 __blk_mq_flush_plug_list(q, plug));
>>>=20
>>> and __blk_mq_flush_plug_list does this:
>>>           q->mq_ops->queue_rqs(&plug->mq_list);
>>>=20
>>> This somehow ends up calling the bio_endio and the
>>> z_erofs_decompressqueue_endio which grabs the mutex.
>>>=20
>>> So... I have a question, it looks like one of the paths in
>>> __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the alternate
>>> path uses RCU. Why does this alternate want to block even if it is =
not
>>> supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING =
should
>>> be set? It sounds like you want to block in the "else" path even
>>> though BLK_MQ_F_BLOCKING is not set:
>>=20
>> BLK_MQ_F_BLOCKING is not a flag that a filesystem can do anything =
with.
>> That is block layer and mq device driver stuffs. filesystems cannot =
set
>> this value.
>>=20
>> As I said, as far as I understand, previously,
>> .end_io() can only be called without RCU context, so it will be fine,
>> but I don't know when .end_io() can be called under some RCU context
>> now.
>=20
> =46rom what Sandeep described, the code path is in an RCU reader. My
> question is more, why doesn't it use SRCU instead since it clearly
> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
> dive needs to be made into that before concluding that the fix is to
> use rcu_read_lock_any_held().

Copied from [1]:

"Background: Historically erofs would always schedule a kworker for
 decompression which would incur the scheduling cost regardless of
 the context. But z_erofs_decompressqueue_endio() may not always
 be in atomic context and we could actually benefit from doing the
 decompression in z_erofs_decompressqueue_endio() if we are in
 thread context, for example when running with dm-verity.
 This optimization was later added in patch [2] which has shown
 improvement in performance benchmarks.=E2=80=9D

I=E2=80=99m not sure if it is a design issue.


[1] =
https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/

>=20
> - Joel


