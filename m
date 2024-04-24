Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E38B01BA
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 08:24:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPTTd6x8vz3cCb
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 16:24:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPTTV3NRrz2xFk
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 16:23:58 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPTTC42mqz4f3khK
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 14:23:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ABD551A017C
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 14:23:50 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFypShm50JCKw--.10266S3;
	Wed, 24 Apr 2024 14:23:50 +0800 (CST)
Message-ID: <82ba7a6b-97d1-a0f2-8360-91fbdba610a3@huaweicloud.com>
Date: Wed, 24 Apr 2024 14:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 5/5] cachefiles: add missing lock protection when polling
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, netfs@lists.linux.dev
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-6-libaokun@huaweicloud.com>
 <de9d403c-c4ed-46c5-a572-18dc48bbd204@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <de9d403c-c4ed-46c5-a572-18dc48bbd204@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBnOBFypShm50JCKw--.10266S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45GFyrJF4xCF4fKFyfWFg_yoW5XrWkpF
	W0yFyUJry8Cr1kuF1UXF1DXry8J34DJ3WDXr48XF1UXrnrXr1Yqr1Iqr1Ygr1DAr4xJF4U
	Jr1UGr9xZFWUA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/
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
Cc: libaokun@huaweicloud.com, Joseph Qi <joseph.qi@linux.alibaba.com>, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On 2024/4/24 12:29, Gao Xiang wrote:
> Hi Baokun,
>
> On 2024/4/24 11:34, libaokun@huaweicloud.com wrote:
>> From: Jingbo Xu <jefflexu@linux.alibaba.com>
>>
>> Add missing lock protection in poll routine when iterating xarray,
>> otherwise:
>>
>> Even with RCU read lock held, only the slot of the radix tree is
>> ensured to be pinned there, while the data structure (e.g. struct
>> cachefiles_req) stored in the slot has no such guarantee.  The poll
>> routine will iterate the radix tree and dereference cachefiles_req
>> accordingly.  Thus RCU read lock is not adequate in this case and
>> spinlock is needed here.
>>
>> Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering 
>> EPOLLIN events in ondemand mode")
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> I'm not sure why this patch didn't send upstream,
> https://gitee.com/anolis/cloud-kernel/commit/324ecaaa10fefb0e3d94b547e3170e40b90cda1f 
>
>
Yes, this issue blocks our tests, so this commit is adapted to upstream 
here.

> But since we're now working on upstreaming, so let's drop
> the previous in-house review tags..
>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> Thanks,
> Gao Xiang

Ok, thanks for the review!

Cheers,
Baokun
>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/daemon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>> index 6465e2574230..73ed2323282a 100644
>> --- a/fs/cachefiles/daemon.c
>> +++ b/fs/cachefiles/daemon.c
>> @@ -365,14 +365,14 @@ static __poll_t cachefiles_daemon_poll(struct 
>> file *file,
>>         if (cachefiles_in_ondemand_mode(cache)) {
>>           if (!xa_empty(&cache->reqs)) {
>> -            rcu_read_lock();
>> +            xas_lock(&xas);
>>               xas_for_each_marked(&xas, req, ULONG_MAX, 
>> CACHEFILES_REQ_NEW) {
>>                   if (!cachefiles_ondemand_is_reopening_read(req)) {
>>                       mask |= EPOLLIN;
>>                       break;
>>                   }
>>               }
>> -            rcu_read_unlock();
>> +            xas_unlock(&xas);
>>           }
>>       } else {
>>           if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))


