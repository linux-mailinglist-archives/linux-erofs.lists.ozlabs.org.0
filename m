Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E7666B1B
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 07:12:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsvNg6VyGz3cD5
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 17:12:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsvNV14lLz3bVM
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 17:12:38 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NsvN70w95z4f3v6c
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 14:12:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAHrerGpL9jJ4AuBg--.8635S2;
	Thu, 12 Jan 2023 14:12:25 +0800 (CST)
Subject: Re: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing
 of relinquished volume
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 David Howells <dhowells@redhat.com>
References: <20221226103309.953112-2-houtao@huaweicloud.com>
 <20221226103309.953112-1-houtao@huaweicloud.com>
 <2431838.1673453170@warthog.procyon.org.uk>
 <6acd0aea-2e7b-e30e-214f-81f4c3766ead@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <087d25cc-97b6-7daf-3722-65fba86aaf1d@huaweicloud.com>
Date: Thu, 12 Jan 2023 14:12:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6acd0aea-2e7b-e30e-214f-81f4c3766ead@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAHrerGpL9jJ4AuBg--.8635S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5JF4UZw4rAF4DAry7Wrg_yoW8Gr1Dpr
	ZYga4UXFWktr42y397tw17Z3yYgw15Wrs3Cw1fGrZrCF15WrySkFn3KFs8CF1Uuan5Jr1F
	qw45A3sxtFsYvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
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

Hi,

On 1/12/2023 11:58 AM, Jingbo Xu wrote:
>
> On 1/12/23 12:06 AM, David Howells wrote:
>> Hou Tao <houtao@huaweicloud.com> wrote:
>>
>>>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
>>> +			/*
>>> +			 * Paired with barrier in wait_on_bit(). Check
>>> +			 * wake_up_bit() and waitqueue_active() for details.
>>> +			 */
>>> +			smp_mb__after_atomic();
>>>  			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
>> What two values are you applying a partial ordering to?
> Yeah Hou Tao has explained that a full barrier is needed here to avoid
> the potential reordering at the waker side.
>
> As I was also researching on this these days, I'd like to share my
> thought on this, hopefully if it could give some insight :)
>
> Without the barrier at the waker side, it may suffer from the following
> race:
>
> ```
> CPU0 - waker                    CPU1 - waiter
>
> if (waitqueue_active(wq_head)) <-- find no wq_entry in wq_head list
>     wake_up(wq_head);
>
>                                 for (;;) {
>                                    prepare_to_wait(...);
>                                         # add wq_entry into wq_head list
>
>                                     if (@cond)  <-- @cond is false
>                                         break;
>                                     schedule(); <-- wq_entry still in
>                                                     wq_head list,
>                                                     wait for next wakeup
>                                  }
>                                  finish_wait(&wq_head, &wait);
>
> @cond = true;
> ```
>
> in which case the waiter misses the wakeup for one time.
Thanks for the details annotation. It is exactly what I tried to say but failed to.
>

