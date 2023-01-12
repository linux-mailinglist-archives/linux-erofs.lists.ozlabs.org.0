Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B3A666B22
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 07:17:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsvVC2Ylpz3cD5
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 17:17:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=houtao@huaweicloud.com; receiver=<UNKNOWN>)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsvV73vCMz3bh4
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 17:17:35 +1100 (AEDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsvTz4jVBz4f3tRm
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 14:17:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCnXLD3pb9j6QdIBg--.57168S2;
	Thu, 12 Jan 2023 14:17:30 +0800 (CST)
Subject: Re: [PATCH v2 2/2] fscache: Add the missing smp_mb__after_atomic()
 before wake_up_bit()
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com
References: <20221226103309.953112-1-houtao@huaweicloud.com>
 <20221226103309.953112-3-houtao@huaweicloud.com>
 <8b0af045-25c1-9848-3c8c-de7da94d06da@linux.alibaba.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f70cae75-d866-f70d-1fea-4213b0fb8fef@huaweicloud.com>
Date: Thu, 12 Jan 2023 14:17:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8b0af045-25c1-9848-3c8c-de7da94d06da@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgCnXLD3pb9j6QdIBg--.57168S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Gr4fXrW3Zr1DWFW3Wrg_yoW8Ww43pr
	WkWFySga18X39Fy3yDXw17u34SgrWUKan7Gr10y3WUAr4FvrWF93WSkF98ua47A395JrWx
	Z3WUK3y3XryUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
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
Cc: David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, houtao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 1/12/2023 12:34 PM, Jingbo Xu wrote:
>
> On 12/26/22 6:33 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> fscache_create_volume_work() uses wake_up_bit() to wake up the processes
>> which are waiting for the completion of volume creation. According to
>> comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
>> needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
>> flag and waitqueue_active() before invoking wake_up_bit().
>>
>> Considering clear_bit_unlock() before wake_up_bit() is an atomic
>> operation, use smp_mb__after_atomic() instead of smp_mb() to provide
>> such guarantee.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  fs/fscache/volume.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
>> index fc3dd3bc851d..734d17f404e7 100644
>> --- a/fs/fscache/volume.c
>> +++ b/fs/fscache/volume.c
>> @@ -281,6 +281,11 @@ static void fscache_create_volume_work(struct work_struct *work)
>>  				 fscache_access_acquire_volume_end);
>>  
>>  	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
>> +	/*
>> +	 * Paired with barrier in wait_on_bit(). Check wake_up_bit() and
>> +	 * waitqueue_active() for details.
>> +	 */
>> +	smp_mb__after_atomic();
>>  	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
>>  	fscache_put_volume(volume, fscache_volume_put_create_work);
>>  }
> LGTM.
>
> Actually I'm thinking if clear_and_wake_up_bit() could be used here.
> Ditto for patch 1.
Good idea. Just find the presence of clear_and_wake_up_bit(). Will do in v3 for
both patch 1 & patch 2.
>

