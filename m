Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17F6669D7
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 04:58:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsrPm3VgYz3c9V
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 14:58:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.1; helo=out30-1.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsrPh70SDz3c3m
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 14:58:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VZPF1qd_1673495907;
Received: from 30.221.131.229(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZPF1qd_1673495907)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 11:58:28 +0800
Message-ID: <6acd0aea-2e7b-e30e-214f-81f4c3766ead@linux.alibaba.com>
Date: Thu, 12 Jan 2023 11:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing
 of relinquished volume
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, Hou Tao <houtao@huaweicloud.com>
References: <20221226103309.953112-2-houtao@huaweicloud.com>
 <20221226103309.953112-1-houtao@huaweicloud.com>
 <2431838.1673453170@warthog.procyon.org.uk>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2431838.1673453170@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 1/12/23 12:06 AM, David Howells wrote:
> Hou Tao <houtao@huaweicloud.com> wrote:
> 
>>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
>> +			/*
>> +			 * Paired with barrier in wait_on_bit(). Check
>> +			 * wake_up_bit() and waitqueue_active() for details.
>> +			 */
>> +			smp_mb__after_atomic();
>>  			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
> 
> What two values are you applying a partial ordering to?

Yeah Hou Tao has explained that a full barrier is needed here to avoid
the potential reordering at the waker side.

As I was also researching on this these days, I'd like to share my
thought on this, hopefully if it could give some insight :)

Without the barrier at the waker side, it may suffer from the following
race:

```
CPU0 - waker                    CPU1 - waiter

if (waitqueue_active(wq_head)) <-- find no wq_entry in wq_head list
    wake_up(wq_head);

                                for (;;) {
                                   prepare_to_wait(...);
                                        # add wq_entry into wq_head list

                                    if (@cond)  <-- @cond is false
                                        break;
                                    schedule(); <-- wq_entry still in
                                                    wq_head list,
                                                    wait for next wakeup
                                 }
                                 finish_wait(&wq_head, &wait);

@cond = true;
```

in which case the waiter misses the wakeup for one time.

-- 
Thanks,
Jingbo
