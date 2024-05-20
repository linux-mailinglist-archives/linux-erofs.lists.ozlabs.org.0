Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 369938C98A1
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 06:21:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjPPW6Wn8z3cjm
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 14:15:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjPPT2vF5z3cTb
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 14:15:40 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjPP95Ldpz4f3lVw
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 12:15:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 22DC71A016E
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 12:15:36 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g5lzkpmmiWgNA--.60734S3;
	Mon, 20 May 2024 12:15:35 +0800 (CST)
Message-ID: <345904d3-7a71-1956-3ad0-4017ba4eb8b3@huaweicloud.com>
Date: Mon, 20 May 2024 12:15:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 02/12] cachefiles: remove err_put_fd tag in
 cachefiles_ondemand_daemon_read()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-3-libaokun@huaweicloud.com>
 <38b601b0-6a6d-4465-9137-85a59c6c2c71@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <38b601b0-6a6d-4465-9137-85a59c6c2c71@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAn9g5lzkpmmiWgNA--.60734S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4DJr1DuF4rGw43GrW8tFb_yoW8CFW5pF
	Z2ya4UKry8ur1xCrykAas8Xry8t3ykJ3WDXr1kXFyUAwnIqr1Fqr1Iqr1jgF1UAr4xJr47
	tF1jgF9rZ3s0y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUouWlDUUUU
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

On 2024/5/20 10:23, Gao Xiang wrote:
>
>
> On 2024/5/15 16:45, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The err_put_fd tag is only used once, so remove it to make the code more
>
> The err_put_fd label ..
>
> Also the subject line needs to be updated too.  ("C goto label")
>
Sorry about that, and thank you very much for the correction!

I will correct "tag" to "label" in the next iteration.

>> readable.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> Thanks,
> Gao Xiang
Thank you very much for your review!

Regards,
Baokun
>
>> ---
>>   fs/cachefiles/ondemand.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 4ba42f1fa3b4..fd49728d8bae 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct 
>> cachefiles_cache *cache,
>>         if (copy_to_user(_buffer, msg, n) != 0) {
>>           ret = -EFAULT;
>> -        goto err_put_fd;
>> +        if (msg->opcode == CACHEFILES_OP_OPEN)
>> +            close_fd(((struct cachefiles_open *)msg->data)->fd);
>> +        goto error;
>>       }
>>         /* CLOSE request has no reply */
>> @@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct 
>> cachefiles_cache *cache,
>>         return n;
>>   -err_put_fd:
>> -    if (msg->opcode == CACHEFILES_OP_OPEN)
>> -        close_fd(((struct cachefiles_open *)msg->data)->fd);
>>   error:
>>       xa_erase(&cache->reqs, id);
>>       req->error = ret;

-- 
With Best Regards,
Baokun Li

