Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56B98B1B46
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 08:53:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ64z04ylz3dHm
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 16:53:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ64q5xDJz3cmg
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 16:53:12 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VQ64V3lM1z4f3khX
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 14:52:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 211231A058D
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 14:53:06 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7O_Slm4WOeKw--.49376S3;
	Thu, 25 Apr 2024 14:53:05 +0800 (CST)
Message-ID: <7f379fde-a34d-163c-d965-651563e98327@huaweicloud.com>
Date: Thu, 25 Apr 2024 14:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/5] cachefiles: flush ondemand_object_worker during clean
 object
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, netfs@lists.linux.dev
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-4-libaokun@huaweicloud.com>
 <8572a732-ca12-48d7-817c-d8218d536c0c@bytedance.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <8572a732-ca12-48d7-817c-d8218d536c0c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAX5g7O_Slm4WOeKw--.49376S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDtr4rWF1UGryDAw48Crg_yoW5Cw15pF
	WfAFyUGry8Wr1kGr1DXF1UJry8tryUJ3WDXF1YqFyUJrn8Jr1jqr1UXr1qgF1UJr48Jr47
	Jr4UCr9rZr1UJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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
Cc: libaokun@huaweicloud.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jia,

On 2024/4/25 13:41, Jia Zhu wrote:
> Thanks for catching this. How about adding a Fixes tag.
>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
>
>
Ok, I will add the Fixes tag in the next iteration.
Thank you very much for your review!

Cheers!
Baokun
> 在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When queuing ondemand_object_worker() to re-open the object,
>> cachefiles_object is not pinned. The cachefiles_object may be freed when
>> the pending read request is completed intentionally and the related
>> erofs is umounted. If ondemand_object_worker() runs after the object is
>> freed, it will incur use-after-free problem as shown below.
>>
>> process A  processs B  process C  process D
>>
>> cachefiles_ondemand_send_req()
>> // send a read req X
>> // wait for its completion
>>
>>             // close ondemand fd
>>             cachefiles_ondemand_fd_release()
>>             // set object as CLOSE
>>
>>                         cachefiles_ondemand_daemon_read()
>>                         // set object as REOPENING
>>                         queue_work(fscache_wq, &info->ondemand_work)
>>
>>                                  // close /dev/cachefiles
>>                                  cachefiles_daemon_release
>>                                  cachefiles_flush_reqs
>>                                  complete(&req->done)
>>
>> // read req X is completed
>> // umount the erofs fs
>> cachefiles_put_object()
>> // object will be freed
>> cachefiles_ondemand_deinit_obj_info()
>> kmem_cache_free(object)
>>                         // both info and object are freed
>>                         ondemand_object_worker()
>>
>> When dropping an object, it is no longer necessary to reopen the object,
>> so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
>> to complete.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index d24bff43499b..f6440b3e7368 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -589,6 +589,9 @@ void cachefiles_ondemand_clean_object(struct 
>> cachefiles_object *object)
>>           }
>>       }
>>       xa_unlock(&cache->reqs);
>> +
>> +    /* Wait for ondemand_object_worker() to finish to avoid UAF. */
>> + cancel_work_sync(&object->ondemand->ondemand_work);
>>   }
>>     int cachefiles_ondemand_init_obj_info(struct cachefiles_object 
>> *object,


