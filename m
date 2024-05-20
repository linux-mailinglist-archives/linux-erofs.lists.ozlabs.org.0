Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC38C9DC3
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 15:01:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Znr4bGBp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjcwP0zg4z3cby
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 22:54:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Znr4bGBp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjcwJ6kHPz3cby
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 22:54:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716209675; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mX8hyz8zLef0rWFw+iWlMYAQS32FV3Gjv5O3p8Lau+k=;
	b=Znr4bGBp5uDom3PbYy0hfPLmZPcca8ZyvxLLvE/psofUqGGPJRUF7sMlZaHiMqHWFKUa6gVIANSmmqFKPaLvPg3kF3bOqC3fa98jxie9pLwPKAGp0XwvF4MFsa7P7h6YDLwmCrlaFABj1DBYVOM0flMQvVZCShihz17vnBskPDk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6tGmXV_1716209671;
Received: from 30.25.238.216(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6tGmXV_1716209671)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 20:54:33 +0800
Message-ID: <d82277a4-aeab-4eb7-bdfd-377edd8b8737@linux.alibaba.com>
Date: Mon, 20 May 2024 20:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] cachefiles: cyclic allocation of msg_id to avoid
 reuse
To: Baokun Li <libaokun@huaweicloud.com>, Jeff Layton <jlayton@kernel.org>,
 netfs@lists.linux.dev, dhowells@redhat.com
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-5-libaokun@huaweicloud.com>
 <f449f710b7e1ba725ec9f73cace6c1289b9225b6.camel@kernel.org>
 <d3f5d0c4-eda7-87e3-5938-487ab9ff6b81@huaweicloud.com>
 <4b1584787dd54bb95d700feae1ca498c40429551.camel@kernel.org>
 <a4d57830-2bde-901f-72c4-e1a3f714faa5@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <a4d57830-2bde-901f-72c4-e1a3f714faa5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/5/20 20:42, Baokun Li wrote:
> On 2024/5/20 18:04, Jeff Layton wrote:
>> On Mon, 2024-05-20 at 12:06 +0800, Baokun Li wrote:
>>> Hi Jeff,
>>>
>>> Thank you very much for your review!
>>>
>>> On 2024/5/19 19:11, Jeff Layton wrote:
>>>> On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
>>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>>
>>>>> Reusing the msg_id after a maliciously completed reopen request may cause
>>>>> a read request to remain unprocessed and result in a hung, as shown below:
>>>>>
>>>>>          t1       |      t2       |      t3
>>>>> -------------------------------------------------
>>>>> cachefiles_ondemand_select_req
>>>>>    cachefiles_ondemand_object_is_close(A)
>>>>>    cachefiles_ondemand_set_object_reopening(A)
>>>>>    queue_work(fscache_object_wq, &info->work)
>>>>>                   ondemand_object_worker
>>>>>                    cachefiles_ondemand_init_object(A)
>>>>>                     cachefiles_ondemand_send_req(OPEN)
>>>>>                       // get msg_id 6
>>>>>                       wait_for_completion(&req_A->done)
>>>>> cachefiles_ondemand_daemon_read
>>>>>    // read msg_id 6 req_A
>>>>>    cachefiles_ondemand_get_fd
>>>>>    copy_to_user
>>>>>                                   // Malicious completion msg_id 6
>>>>>                                   copen 6,-1
>>>>>                                   cachefiles_ondemand_copen
>>>>>                                    complete(&req_A->done)
>>>>>                                    // will not set the object to close
>>>>>                                    // because ondemand_id && fd is valid.
>>>>>
>>>>>                   // ondemand_object_worker() is done
>>>>>                   // but the object is still reopening.
>>>>>
>>>>>                                   // new open req_B
>>>>>                                   cachefiles_ondemand_init_object(B)
>>>>>                                    cachefiles_ondemand_send_req(OPEN)
>>>>>                                    // reuse msg_id 6
>>>>> process_open_req
>>>>>    copen 6,A.size
>>>>>    // The expected failed copen was executed successfully
>>>>>
>>>>> Expect copen to fail, and when it does, it closes fd, which sets the
>>>>> object to close, and then close triggers reopen again. However, due to
>>>>> msg_id reuse resulting in a successful copen, the anonymous fd is not
>>>>> closed until the daemon exits. Therefore read requests waiting for reopen
>>>>> to complete may trigger hung task.
>>>>>
>>>>> To avoid this issue, allocate the msg_id cyclically to avoid reusing the
>>>>> msg_id for a very short duration of time.
>>>>>
>>>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>>> ---
>>>>>    fs/cachefiles/internal.h |  1 +
>>>>>    fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
>>>>>    2 files changed, 17 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>>>>> index 8ecd296cc1c4..9200c00f3e98 100644
>>>>> --- a/fs/cachefiles/internal.h
>>>>> +++ b/fs/cachefiles/internal.h
>>>>> @@ -128,6 +128,7 @@ struct cachefiles_cache {
>>>>>        unsigned long            req_id_next;
>>>>>        struct xarray            ondemand_ids;    /* xarray for ondemand_id allocation */
>>>>>        u32                ondemand_id_next;
>>>>> +    u32                msg_id_next;
>>>>>    };
>>>>>    static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>>>>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>>>>> index f6440b3e7368..b10952f77472 100644
>>>>> --- a/fs/cachefiles/ondemand.c
>>>>> +++ b/fs/cachefiles/ondemand.c
>>>>> @@ -433,20 +433,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>>>>            smp_mb();
>>>>>            if (opcode == CACHEFILES_OP_CLOSE &&
>>>>> -            !cachefiles_ondemand_object_is_open(object)) {
>>>>> +            !cachefiles_ondemand_object_is_open(object)) {
>>>>>                WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
>>>>>                xas_unlock(&xas);
>>>>>                ret = -EIO;
>>>>>                goto out;
>>>>>            }
>>>>> -        xas.xa_index = 0;
>>>>> +        /*
>>>>> +         * Cyclically find a free xas to avoid msg_id reuse that would
>>>>> +         * cause the daemon to successfully copen a stale msg_id.
>>>>> +         */
>>>>> +        xas.xa_index = cache->msg_id_next;
>>>>>            xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
>>>>> +        if (xas.xa_node == XAS_RESTART) {
>>>>> +            xas.xa_index = 0;
>>>>> +            xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
>>>>> +        }
>>>>>            if (xas.xa_node == XAS_RESTART)
>>>>>                xas_set_err(&xas, -EBUSY);
>>>>> +
>>>>>            xas_store(&xas, req);
>>>>> -        xas_clear_mark(&xas, XA_FREE_MARK);
>>>>> -        xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>>>>> +        if (xas_valid(&xas)) {
>>>>> +            cache->msg_id_next = xas.xa_index + 1;
>>>> If you have a long-standing stuck request, could this counter wrap
>>>> around and you still end up with reuse?
>>> Yes, msg_id_next is declared to be of type u32 in the hope that when
>>> xa_index == UINT_MAX, a wrap around occurs so that msg_id_next
>>> goes to zero. Limiting xa_index to no more than UINT_MAX is to avoid
>>> the xarry being too deep.
>>>
>>> If msg_id_next is equal to the id of a long-standing stuck request
>>> after the wrap-around, it is true that the reuse in the above problem
>>> may also occur.
>>>
>>> But I feel that a long stuck request is problematic in itself, it means
>>> that after we have sent 4294967295 requests, the first one has not
>>> been processed yet, and even if we send a million requests per
>>> second, this one hasn't been completed for more than an hour.
>>>
>>> We have a keep-alive process that pulls the daemon back up as
>>> soon as it exits, and there is a timeout mechanism for requests in
>>> the daemon to prevent the kernel from waiting for long periods
>>> of time. In other words, we should avoid the situation where
>>> a request is stuck for a long period of time.
>>>
>>> If you think UINT_MAX is not enough, perhaps we could raise
>>> the maximum value of msg_id_next to ULONG_MAX?
>>>> Maybe this should be using
>>>> ida_alloc/free instead, which would prevent that too?
>>>>
>>> The id reuse here is that the kernel has finished the open request
>>> req_A and freed its id_A and used it again when sending the open
>>> request req_B, but the daemon is still working on req_A, so the
>>> copen id_A succeeds but operates on req_B.
>>>
>>> The id that is being used by the kernel will not be allocated here
>>> so it seems that ida _alloc/free does not prevent reuse either,
>>> could you elaborate a bit more how this works?
>>>
>> ida_alloc and free absolutely prevent reuse while the id is in use.
>> That's sort of the point of those functions. Basically it uses a set of
>> bitmaps in an xarray to track which IDs are in use, so ida_alloc only
>> hands out values which are not in use. See the comments over
>> ida_alloc_range() in lib/idr.c.
>>
> Thank you for the explanation!
> 
> The logic now provides the same guarantees as ida_alloc/free.
> The "reused" id, indeed, is no longer in use in the kernel, but it is still
> in use in the userland, so a multi-threaded daemon could be handling
> two different requests for the same msg_id at the same time.
> 
> Previously, the logic for allocating msg_ids was to start at 0 and look
> for a free xas.index, so it was possible for an id to be allocated to a
> new request just as the id was being freed.
> 
> With the change to cyclic allocation, the kernel will not use the same
> id again until INT_MAX requests have been sent, and during the time
> it takes to send requests, the daemon has enough time to process
> requests whose ids are still in use by the daemon, but have already
> been freed in the kernel.

Again, If I understand correctly, I think the main point
here is

wait_for_completion(&req_A->done)

which could hang due to some malicious deamon.  But I think it
should be switched to wait_for_completion_killable() instead.
It's up to users to kill the mount instance if there is a
malicious user daemon.

So in that case, hung task will not be triggered anymore, and
you don't need to care about cyclic allocation too.

Thanks,
Gao Xiang

> 
> Regards,
> Baokun
>>>>> +            xas_clear_mark(&xas, XA_FREE_MARK);
>>>>> +            xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>>>>> +        }
>>>>>            xas_unlock(&xas);
>>>>>        } while (xas_nomem(&xas, GFP_KERNEL));
>>>>>
