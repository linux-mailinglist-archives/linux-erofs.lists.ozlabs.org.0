Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9E64D7BC
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 09:28:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXlkb0gD7z3bSq
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 19:28:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXlkR2JHDz30QQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 19:28:45 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NXlk91ylMz4f3npl
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 16:28:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB359Sw2ppjBKcRCQ--.35114S2;
	Thu, 15 Dec 2022 16:28:36 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH] fscache: Use wake_up_var() to wake up pending volume
 acquisition
To: David Howells <dhowells@redhat.com>
References: <42b33792-50e9-77d7-4d3e-ac5ce1adeda6@huaweicloud.com>
 <20221128031929.3918348-1-houtao@huaweicloud.com>
 <2308529.1670585211@warthog.procyon.org.uk>
Message-ID: <e6a23517-63fa-6381-1f2b-80e764252e0b@huaweicloud.com>
Date: Thu, 15 Dec 2022 16:28:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2308529.1670585211@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgB359Sw2ppjBKcRCQ--.35114S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1UWF4UCryDZrWxAw4kCrg_yoW8Zw1fp3
	yj9Fyftws7X3Wqv3yDJw18uF4SgFn0yw4ru3yrCFZrC345KryfuF1fGayDCay8urs5Wr15
	tF4UG398CFyqqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, "houtao1@huawei.com" <houtao1@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

Sorry for the late reply. Busy for other business in work.

On 12/9/2022 7:26 PM, David Howells wrote:
> Hou Tao <houtao@huaweicloud.com> wrote:
>
>>>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
> Maybe this should be clear_bit_unlock() instead.
I'm not sure about that. In my understanding, clear_bit_unlock() is usually
paired with test_and_set_bit_lock() to implement bit lock to make sure the
writes before clear_bit_unlock() are visible to read access in concurrent
process, right ? But now the caller of fscache_wake_pending_volume() only modify
cursor->flags and nothing else, so I don't think it is needed here.
If its intended purpose is to provide the missing smp_mb() for wake_up_bit(), I
also don't think it is right, because the release barrier provided by
clear_bit_unlock() doesn't guarantee the order of cursor->flags and wq_head, so
I think one extra smp_mb_after_atomic() is also needed after
clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags).

If the above reasoning makes sense to you, I think we also need to add
smp_mb_after_atomic() for wake_up_bit() in fscache_create_volume_work().
> And I wonder if:
>
> 	set_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags);
>
> in fscache_hash_volume() needs a barrier before it.
I also don't get it. The barrier is used to guarantee the order between
cursor->flags and candidate->flags, right ? But the write and read of
cursor->flags and candidate->flags are protected by the same hash lock.
>
>>> -			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
>>> +			/*
>>> +			 * Paired with barrier in wait_var_event(). Check
>>> +			 * waitqueue_active() and wake_up_var() for details.
>>> +			 */
>>> +			smp_mb__after_atomic();
>>> +			wake_up_var(&cursor->flags);
> That doesn't seem right.
>
> wake_up_bit() is more selective, so should be preferred to wake_up_var().
OK. Will update fscache_wait_on_volume_collision() to use wait_on_bit() accordingly.
> David
>
>
> .

