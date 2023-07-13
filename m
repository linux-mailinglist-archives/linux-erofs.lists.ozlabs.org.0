Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91088752547
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 16:35:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1xwJ3Vt8z3c4R
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 00:35:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1xwD0DP4z2yHT
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 00:35:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VnIKFjW_1689258886;
Received: from 30.27.122.43(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnIKFjW_1689258886)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 22:34:50 +0800
Message-ID: <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
Date: Thu, 13 Jul 2023 22:34:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
To: Joel Fernandes <joel@joelfernandes.org>
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2023/7/13 22:07, Joel Fernandes wrote:
> On Thu, Jul 13, 2023 at 12:59 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> On 2023/7/13 12:52, Paul E. McKenney wrote:
>>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
>>>>
>>>>
>>
>> ...
>>
>>>>
>>>> There are lots of performance issues here and even a plumber
>>>> topic last year to show that, see:
>>>>
>>>> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
>>>> [2] https://lore.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com
>>>> [3] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
>>>> [4] https://lpc.events/event/16/contributions/1338/
>>>> and more.
>>>>
>>>> I'm not sure if it's necessary to look info all of that,
>>>> andSandeep knows more than I am (the scheduling issue
>>>> becomes vital on some aarch64 platform.)
>>>
>>> Hmmm...  Please let me try again.
>>>
>>> Assuming that this approach turns out to make sense, the resulting
>>> patch will need to clearly state the performance benefits directly in
>>> the commit log.
>>>
>>> And of course, for the approach to make sense, it must avoid breaking
>>> the existing lockdep-RCU debugging code.
>>>
>>> Is that more clear?
>>
>> Personally I'm not working on Android platform any more so I don't
>> have a way to reproduce, hopefully Sandeep could give actually
>> number _again_ if dm-verity is enabled and trigger another
>> workqueue here and make a comparsion why the scheduling latency of
>> the extra work becomes unacceptable.
>>
> 
> Question from my side, are we talking about only performance issues or
> also a crash? It appears z_erofs_decompress_pcluster() takes
> mutex_lock(&pcl->lock);
> 
> So if it is either in an RCU read-side critical section or in an
> atomic section, like the softirq path, then it may
> schedule-while-atomic or trigger RCU warnings.
> 
> z_erofs_decompressqueue_endio
> -> z_erofs_decompress_kickoff
>   ->z_erofs_decompressqueue_work
>    ->z_erofs_decompress_queue
>     -> z_erofs_decompress_pcluster
>      -> mutex_lock
> 

Why does the softirq path not trigger a workqueue instead? why here
it triggers "schedule-while-atomic" in the softirq context?

> Per Sandeep in [1], this stack happens under RCU read-lock in:
> 
> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> [...]
>                  rcu_read_lock();
>                  (dispatch_ops);
>                  rcu_read_unlock();
> [...]
> 
> Coming from:
> blk_mq_flush_plug_list ->
>                             blk_mq_run_dispatch_ops(q,
>                                  __blk_mq_flush_plug_list(q, plug));
> 
> and __blk_mq_flush_plug_list does this:
>            q->mq_ops->queue_rqs(&plug->mq_list);
> 
> This somehow ends up calling the bio_endio and the
> z_erofs_decompressqueue_endio which grabs the mutex.
> 
> So... I have a question, it looks like one of the paths in
> __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the alternate
> path uses RCU. Why does this alternate want to block even if it is not
> supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING should
> be set? It sounds like you want to block in the "else" path even
> though BLK_MQ_F_BLOCKING is not set:

BLK_MQ_F_BLOCKING is not a flag that a filesystem can do anything with.
That is block layer and mq device driver stuffs. filesystems cannot set
this value.

As I said, as far as I understand, previously,
.end_io() can only be called without RCU context, so it will be fine,
but I don't know when .end_io() can be called under some RCU context
now.


Thanks,
Gao Xiang
