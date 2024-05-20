Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id C90BD8C989E
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 06:16:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjPCl6zcLz3cWR
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 14:07:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjPCY4gRhz3cTx
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 14:07:01 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VjPC80Px9z4f3jrh
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 12:06:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E1ACD1A08F8
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 12:06:52 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFWzEpmwZWfNA--.8326S3;
	Mon, 20 May 2024 12:06:50 +0800 (CST)
Message-ID: <d3f5d0c4-eda7-87e3-5938-487ab9ff6b81@huaweicloud.com>
Date: Mon, 20 May 2024 12:06:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 4/5] cachefiles: cyclic allocation of msg_id to avoid
 reuse
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
 dhowells@redhat.com
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-5-libaokun@huaweicloud.com>
 <f449f710b7e1ba725ec9f73cace6c1289b9225b6.camel@kernel.org>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <f449f710b7e1ba725ec9f73cace6c1289b9225b6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAX6RFWzEpmwZWfNA--.8326S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1fJr4UGrWxWry5WryfJFb_yoW7uw17pF
	WakFy7KFy8WF12krZ7ZF4UJrW8K34DZFnrWrWFqry0ywn0vr1Fvryjgr1YgFyUArWxWr42
	qF48uasIyw12yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeff,

Thank you very much for your review!

On 2024/5/19 19:11, Jeff Layton wrote:
> On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Reusing the msg_id after a maliciously completed reopen request may cause
>> a read request to remain unprocessed and result in a hung, as shown below:
>>
>>         t1       |      t2       |      t3
>> -------------------------------------------------
>> cachefiles_ondemand_select_req
>>   cachefiles_ondemand_object_is_close(A)
>>   cachefiles_ondemand_set_object_reopening(A)
>>   queue_work(fscache_object_wq, &info->work)
>>                  ondemand_object_worker
>>                   cachefiles_ondemand_init_object(A)
>>                    cachefiles_ondemand_send_req(OPEN)
>>                      // get msg_id 6
>>                      wait_for_completion(&req_A->done)
>> cachefiles_ondemand_daemon_read
>>   // read msg_id 6 req_A
>>   cachefiles_ondemand_get_fd
>>   copy_to_user
>>                                  // Malicious completion msg_id 6
>>                                  copen 6,-1
>>                                  cachefiles_ondemand_copen
>>                                   complete(&req_A->done)
>>                                   // will not set the object to close
>>                                   // because ondemand_id && fd is valid.
>>
>>                  // ondemand_object_worker() is done
>>                  // but the object is still reopening.
>>
>>                                  // new open req_B
>>                                  cachefiles_ondemand_init_object(B)
>>                                   cachefiles_ondemand_send_req(OPEN)
>>                                   // reuse msg_id 6
>> process_open_req
>>   copen 6,A.size
>>   // The expected failed copen was executed successfully
>>
>> Expect copen to fail, and when it does, it closes fd, which sets the
>> object to close, and then close triggers reopen again. However, due to
>> msg_id reuse resulting in a successful copen, the anonymous fd is not
>> closed until the daemon exits. Therefore read requests waiting for reopen
>> to complete may trigger hung task.
>>
>> To avoid this issue, allocate the msg_id cyclically to avoid reusing the
>> msg_id for a very short duration of time.
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/internal.h |  1 +
>>   fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
>>   2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index 8ecd296cc1c4..9200c00f3e98 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -128,6 +128,7 @@ struct cachefiles_cache {
>>   	unsigned long			req_id_next;
>>   	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
>>   	u32				ondemand_id_next;
>> +	u32				msg_id_next;
>>   };
>>   
>>   static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index f6440b3e7368..b10952f77472 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -433,20 +433,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>   		smp_mb();
>>   
>>   		if (opcode == CACHEFILES_OP_CLOSE &&
>> -			!cachefiles_ondemand_object_is_open(object)) {
>> +		    !cachefiles_ondemand_object_is_open(object)) {
>>   			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
>>   			xas_unlock(&xas);
>>   			ret = -EIO;
>>   			goto out;
>>   		}
>>   
>> -		xas.xa_index = 0;
>> +		/*
>> +		 * Cyclically find a free xas to avoid msg_id reuse that would
>> +		 * cause the daemon to successfully copen a stale msg_id.
>> +		 */
>> +		xas.xa_index = cache->msg_id_next;
>>   		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
>> +		if (xas.xa_node == XAS_RESTART) {
>> +			xas.xa_index = 0;
>> +			xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
>> +		}
>>   		if (xas.xa_node == XAS_RESTART)
>>   			xas_set_err(&xas, -EBUSY);
>> +
>>   		xas_store(&xas, req);
>> -		xas_clear_mark(&xas, XA_FREE_MARK);
>> -		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>> +		if (xas_valid(&xas)) {
>> +			cache->msg_id_next = xas.xa_index + 1;
> If you have a long-standing stuck request, could this counter wrap
> around and you still end up with reuse?
Yes, msg_id_next is declared to be of type u32 in the hope that when
xa_index == UINT_MAX, a wrap around occurs so that msg_id_next
goes to zero. Limiting xa_index to no more than UINT_MAX is to avoid
the xarry being too deep.

If msg_id_next is equal to the id of a long-standing stuck request
after the wrap-around, it is true that the reuse in the above problem
may also occur.

But I feel that a long stuck request is problematic in itself, it means
that after we have sent 4294967295 requests, the first one has not
been processed yet, and even if we send a million requests per
second, this one hasn't been completed for more than an hour.

We have a keep-alive process that pulls the daemon back up as
soon as it exits, and there is a timeout mechanism for requests in
the daemon to prevent the kernel from waiting for long periods
of time. In other words, we should avoid the situation where
a request is stuck for a long period of time.

If you think UINT_MAX is not enough, perhaps we could raise
the maximum value of msg_id_next to ULONG_MAX?
> Maybe this should be using
> ida_alloc/free instead, which would prevent that too?
>
The id reuse here is that the kernel has finished the open request
req_A and freed its id_A and used it again when sending the open
request req_B, but the daemon is still working on req_A, so the
copen id_A succeeds but operates on req_B.

The id that is being used by the kernel will not be allocated here
so it seems that ida _alloc/free does not prevent reuse either,
could you elaborate a bit more how this works?

>
>> +			xas_clear_mark(&xas, XA_FREE_MARK);
>> +			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>> +		}
>>   		xas_unlock(&xas);
>>   	} while (xas_nomem(&xas, GFP_KERNEL));
>>   

Thanks again!

-- 
With Best Regards,
Baokun Li

