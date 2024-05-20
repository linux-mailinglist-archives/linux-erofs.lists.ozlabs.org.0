Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 619EC8C98A2
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 06:21:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjPK42SDfz3cYh
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 14:11:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjPJx3KSnz30TR
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 14:11:45 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjPJj00pFz4f3jLV
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 12:11:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B00EA1A0C7E
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 12:11:38 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBF3zUpmeOWfNA--.60503S3;
	Mon, 20 May 2024 12:11:38 +0800 (CST)
Message-ID: <0867a1de-12c5-5e0f-c9e9-0d24cab37512@huaweicloud.com>
Date: Mon, 20 May 2024 12:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 01/12] cachefiles: remove request from xarry during
 flush requests
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-2-libaokun@huaweicloud.com>
 <a440cd35-18ce-4943-b370-c92f761d9bcf@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <a440cd35-18ce-4943-b370-c92f761d9bcf@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBnOBF3zUpmeOWfNA--.60503S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kuF1DXr4fKrW5XF45GFg_yoW5Gw1rpF
	WSyFy7Gry8Wr1kGr1DJF1UJry8J348J3WUXr1UXF18Jr4DAr1Yqr47Xr10gryUJrW8Jr4U
	Jr1UGr9rZryUJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/5/20 10:20, Gao Xiang wrote:
>
>
> On 2024/5/15 16:45, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>
>
> The subject line can be
> "cachefiles: remove requests from xarray during flushing requests"
Thank you very much for the correction! I will update my patch.
>
>>
>> Even with CACHEFILES_DEAD set, we can still read the requests, so in the
>> following concurrency the request may be used after it has been freed:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                                    // close dev fd
>>                                    cachefiles_flush_reqs
>> complete(&REQ_A->done)
>>     kfree(REQ_A)
>>                xa_lock(&cache->reqs);
>>                cachefiles_ondemand_select_req
>>                  req->msg.opcode != CACHEFILES_OP_READ
>>                  // req use-after-free !!!
>>                xa_unlock(&cache->reqs);
>> xa_destroy(&cache->reqs)
>>
>> Hence remove requests from cache->reqs when flushing them to avoid
>> accessing freed requests.
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking 
>> up cookie")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> Thanks,
> Gao Xiang
Thanks a lot for the review!

Cheers,
Baokun
>
>> ---
>>   fs/cachefiles/daemon.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>> index 6465e2574230..ccb7b707ea4b 100644
>> --- a/fs/cachefiles/daemon.c
>> +++ b/fs/cachefiles/daemon.c
>> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct 
>> cachefiles_cache *cache)
>>       xa_for_each(xa, index, req) {
>>           req->error = -EIO;
>>           complete(&req->done);
>> +        __xa_erase(xa, index);
>>       }
>>       xa_unlock(xa);

-- 
With Best Regards,
Baokun Li

