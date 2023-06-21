Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA62737854
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 02:38:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qm4PK0r8Sz30f7
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 10:38:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qm4PB5Mxhz30Nm
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 10:38:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VldXM38_1687307909;
Received: from 30.212.133.87(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VldXM38_1687307909)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 08:38:31 +0800
Message-ID: <9a8a07de-4364-3d06-4d48-2d51a74e1871@linux.alibaba.com>
Date: Wed, 21 Jun 2023 08:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: EROFS: Detecting atomic contexts
To: Sandeep Dhavale <dhavale@google.com>
References: <CAB=BE-SoekaY1oS1wn383DtHngO2BO1-gsUY-STHk9ciKA1OYA@mail.gmail.com>
 <4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com>
 <CAB=BE-QV0PiKFpCOcdEUFxS4wJHsLCcsymAw+nP72Yr3b1WMng@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-QV0PiKFpCOcdEUFxS4wJHsLCcsymAw+nP72Yr3b1WMng@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2023/6/21 04:38, Sandeep Dhavale wrote:
> Hi,
> I think we are under RCU read lock in the stack at
> blk_mq_flush_plug_list+0x2b0/0x354
> 
> blk_mq_flush_plug_list calls blk_mq_run_dispatch_ops
> which is a macro in block/blk-mq.h
> 
> /* run the code block in @dispatch_ops with rcu/srcu read lock held */
> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> do {                                                            \
>          if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {          \
>                  struct blk_mq_tag_set *__tag_set = (q)->tag_set; \
>                  int srcu_idx;                                   \
>                                                                  \
>                  might_sleep_if(check_sleep);                    \
>                  srcu_idx = srcu_read_lock(__tag_set->srcu);     \
>                  (dispatch_ops);                                 \
>                  srcu_read_unlock(__tag_set->srcu, srcu_idx);    \
>          } else {                                                \
>                  rcu_read_lock();                                \
>                  (dispatch_ops);                                 \
>                  rcu_read_unlock();                              \
>          }                                                       \
> } while (0)
> 
> #define blk_mq_run_dispatch_ops(q, dispatch_ops)                \
>          __blk_mq_run_dispatch_ops(q, true, dispatch_ops)        \
> 
> As you can see if BLK_MQ_F_BLOCKING is not set then dispatch_ops is
> called with rcu_read_lock().
> 
> rcu_read_lock()
>          __rcu_read_lock()
>                  rcu_preempt_read_enter()
> 
> In rcu_preempt_read_enter() increments the rcu_read_lock_nesting which
> is detected later during mutex_lock() as a warning.

Thanks for your analysis. That is much helpful to me.
So it seems a new path which calls end_io under rcu read lock.

> 
> Regarding use of !in_task(), that cannot detect rcu_read_lock_nesting
> as far as I can tell so that may not be sufficient.

rcu_preempt_depth is a too low level api, I'm not sure if it's a good
way but we really don't want to trigger another workqueue here,
could we just use:

"!in_task() || irqs_disabled() || rcu_read_lock_any_held()"

Or do you have better ideas?

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.
