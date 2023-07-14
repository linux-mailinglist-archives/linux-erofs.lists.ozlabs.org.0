Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF3752FD8
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 05:17:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2Gqb5DgSz3c1q
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 13:17:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2GqY265Dz3031
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 13:17:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VnK7oAI_1689304613;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnK7oAI_1689304613)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 11:16:56 +0800
Message-ID: <058e7ee9-0380-eb1b-d9a8-b184cba6ed53@linux.alibaba.com>
Date: Fri, 14 Jul 2023 11:16:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
To: paulmck@kernel.org, Sandeep Dhavale <dhavale@google.com>
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: kernel-team@android.com, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/14 10:16, Paul E. McKenney wrote:
> On Thu, Jul 13, 2023 at 09:33:35AM -0700, Paul E. McKenney wrote:
>> On Thu, Jul 13, 2023 at 11:33:24AM -0400, Joel Fernandes wrote:

...

>>>
>>> >From what Sandeep described, the code path is in an RCU reader. My
>>> question is more, why doesn't it use SRCU instead since it clearly
>>> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
>>> dive needs to be made into that before concluding that the fix is to
>>> use rcu_read_lock_any_held().
>>
>> How can this be solved?
>>
>> 1.	Always use a workqueue.  Simple, but is said to have performance
>> 	issues.
>>
>> 2.	Pass a flag in that indicates whether or not the caller is in an
>> 	RCU read-side critical section.  Conceptually simple, but might
>> 	or might not be reasonable to actually implement in the code as
>> 	it exists now.	(You tell me!)
>>
>> 3.	Create a function in z_erofs that gives you a decent
>> 	approximation, maybe something like the following.
>>
>> 4.	Other ideas here.
> 
> 5.	#3 plus make the corresponding Kconfig option select
> 	PREEMPT_COUNT, assuming that any users needing compression in
> 	non-preemptible kernels are OK with PREEMPT_COUNT being set.
> 	(Some users of non-preemptible kernels object strenuously
> 	to the added overhead from CONFIG_PREEMPT_COUNT=y.)

I'm not sure if it's a good idea, we need to work on
CONFIG_PREEMPT_COUNT=n (why not?), we could just always trigger a
workqueue for this.

Anyway, before we proceed, I also think it'd be better to get some
performance numbers first for this (e.g. with dm-verity) and record
the numbers in the commit message to justify this.  Otherwise, I guess
the same question will be raised again and again.

Thanks,
Gao Xiang
