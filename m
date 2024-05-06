Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D28BC616
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 05:12:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VXmgP5Gtdz30TP
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 13:12:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VXmgG0fFMz2yvy
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 13:12:41 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXmg20XmPz4f3prT
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 11:12:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5250B1A058D
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 11:12:35 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGfSjhm3U+ILw--.31636S3;
	Mon, 06 May 2024 11:12:35 +0800 (CST)
Message-ID: <48ed81b9-0386-ba2c-b11a-1531d4f1e376@huaweicloud.com>
Date: Mon, 6 May 2024 11:12:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 06/12] cachefiles: add consistency check for copen/cread
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-7-libaokun@huaweicloud.com>
 <75566e68-bb5f-4458-8140-a59f263cc98a@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <75566e68-bb5f-4458-8140-a59f263cc98a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgCXaBGfSjhm3U+ILw--.31636S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rCr4fWr45tw1xZF4fZrb_yoWrZr4rpF
	WayayakFW8WF4IgrZ7JFW5Wa4Fy3s7AFnrWr93ta45A3sxuryrZrW3Kry5uF1UZwn5tr4x
	tr1jgF9rGw1qyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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
Cc: libaokun@huaweicloud.com, yangerkun <yangerkun@huawei.com>, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jingbo,

Thank you very much for the review!

On 2024/5/6 10:31, Jingbo Xu wrote:
> Hi Baokun,
>
> Thanks for improving on this!
>
> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> This prevents malicious processes from completing random copen/cread
>> requests and crashing the system. Added checks are listed below:
>>
>>    * Generic, copen can only complete open requests, and cread can only
>>      complete read requests.
>>    * For copen, ondemand_id must not be 0, because this indicates that the
>>      request has not been read by the daemon.
>>    * For cread, the object corresponding to fd and req should be the same.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
>>   1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index bb94ef6a6f61..898fab68332b 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -82,12 +82,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
>>   }
>>   
>>   static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>> -					 unsigned long arg)
>> +					 unsigned long id)
>>   {
>>   	struct cachefiles_object *object = filp->private_data;
>>   	struct cachefiles_cache *cache = object->volume->cache;
>>   	struct cachefiles_req *req;
>> -	unsigned long id;
>> +	XA_STATE(xas, &cache->reqs, id);
>>   
>>   	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
>>   		return -EINVAL;
>> @@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>>   	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>>   		return -EOPNOTSUPP;
>>   
>> -	id = arg;
>> -	req = xa_erase(&cache->reqs, id);
>> -	if (!req)
>> +	xa_lock(&cache->reqs);
>> +	req = xas_load(&xas);
>> +	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
>> +	    req->object != object) {
>> +		xa_unlock(&cache->reqs);
>>   		return -EINVAL;
>> +	}
>> +	xas_store(&xas, NULL);
>> +	xa_unlock(&cache->reqs);
>>   
>>   	trace_cachefiles_ondemand_cread(object, id);
>>   	complete(&req->done);
>> @@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	unsigned long id;
>>   	long size;
>>   	int ret;
>> +	XA_STATE(xas, &cache->reqs, 0);
>>   
>>   	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>>   		return -EOPNOTSUPP;
>> @@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	if (ret)
>>   		return ret;
>>   
>> -	req = xa_erase(&cache->reqs, id);
>> -	if (!req)
>> +	xa_lock(&cache->reqs);
>> +	xas.xa_index = id;
>> +	req = xas_load(&xas);
>> +	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
>> +	    !req->object->ondemand->ondemand_id) {
>> +		xa_unlock(&cache->reqs);
>>   		return -EINVAL;
>> +	}
>> +	xas_store(&xas, NULL);
>> +	xa_unlock(&cache->reqs);
>>   
>>   	/* fail OPEN request if copen format is invalid */
>>   	ret = kstrtol(psize, 0, &size);
> The code looks good to me, but I still have some questions.
>
> First, what's the worst consequence if the daemon misbehaves like
> completing random copen/cread requests? I mean, does that affect other
> processes on the system besides the direct users of the ondemand mode,
> e.g. will the misbehavior cause system crash?
This can lead to system crashes, which can lead to a lot of problems.
For example, on reopen, to finish the read request, we might UAF in
ondemand_object_worker();
Or we might UAF in cachefiles_ondemand_daemon_read() when we
haven't added reference counts to the req yet.
Even though these issues are completely resolved in other ways,
I think some basic consistency checks are still necessary.
>
> Besides, it seems that the above security improvement is only "best
> effort".  It can not completely prevent a malicious misbehaved daemon
> from completing random copen/cread requests, right?
>
Yes, this doesn't solve the problem completely, we still can't
distinguish between the following cases:

1) different read reqs of the same object reusing the req id.
2) open reqs of different objects.

Ideally, we would calculate a checksum from
timestamps + struct cachefiles_msg to check if the requests
are consistent, but this breaks the uapi.

Thanks,
Baokun

