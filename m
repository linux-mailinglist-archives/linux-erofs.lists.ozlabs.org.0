Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA848B1879
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 03:34:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPz0Y1RN5z3cgk
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 11:34:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPz0P53nlz30N8
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 11:33:54 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VPz043cBVz4f3khr
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 09:33:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1714E1A016E
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 09:33:48 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBH4silm_UuKKw--.41818S3;
	Thu, 25 Apr 2024 09:33:47 +0800 (CST)
Message-ID: <178d23c8-40cc-f975-7043-68c0d5e15786@huaweicloud.com>
Date: Thu, 25 Apr 2024 09:33:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-4-libaokun@huaweicloud.com>
 <34ba3b5c-638c-4622-8bcb-a2ef74b22f69@bytedance.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <34ba3b5c-638c-4622-8bcb-a2ef74b22f69@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBnOBH4silm_UuKKw--.41818S3
X-Coremail-Antispam: 1UD129KBjvJXoW3ZrWDWw48tF4ftw18uF1Utrb_yoWDuryDpF
	ZayFy7Jry8WrykGr1UJr1UJryrJryUJ3WDXr18XFy8Ar4DAr1Yqr1UXr1jgF1UGr48Ar4U
	Jr1UGr9rZr17JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
Cc: libaokun@huaweicloud.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jia,

On 2024/4/24 22:55, Jia Zhu wrote:
>
>
> 在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> We got the following issue in a fuzz test of randomly issuing the 
>> restore
>> command:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in 
>> cachefiles_ondemand_daemon_read+0x609/0xab0
>> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
>>
>> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
>> Call Trace:
>>   kasan_report+0x94/0xc0
>>   cachefiles_ondemand_daemon_read+0x609/0xab0
>>   vfs_read+0x169/0xb50
>>   ksys_read+0xf5/0x1e0
>>
>> Allocated by task 626:
>>   __kmalloc+0x1df/0x4b0
>>   cachefiles_ondemand_send_req+0x24d/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>>
>> Freed by task 626:
>>   kfree+0xf1/0x2c0
>>   cachefiles_ondemand_send_req+0x568/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>> ==================================================================
>>
>> Following is the process that triggers the issue:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                REQ_A = cachefiles_ondemand_select_req
>>                cachefiles_ondemand_get_fd
>>                copy_to_user(_buffer, msg, n)
>>              process_open_req(REQ_A)
>>                                    ------ restore ------
>>                                    cachefiles_ondemand_restore
>>                                    xas_for_each(&xas, req, ULONG_MAX)
>>                                     xas_set_mark(&xas, 
>> CACHEFILES_REQ_NEW);
>>
>>                                    cachefiles_daemon_read
>> cachefiles_ondemand_daemon_read
>>                                      REQ_A = 
>> cachefiles_ondemand_select_req
>>
>>               write(devfd, ("copen %u,%llu", msg->msg_id, size));
>>               cachefiles_ondemand_copen
>>                xa_erase(&cache->reqs, id)
>>                complete(&REQ_A->done)
>>     kfree(REQ_A)
>> cachefiles_ondemand_get_fd(REQ_A)
>>                                       fd = get_unused_fd_flags
>>                                       file = anon_inode_getfile
>>                                       fd_install(fd, file)
>>                                       load = (void *)REQ_A->msg.data;
>>                                       load->fd = fd;
>>                                       // load UAF !!!
>>
>> This issue is caused by issuing a restore command when the daemon is 
>> still
>> alive, which results in a request being processed multiple times thus
>> triggering a UAF. So to avoid this problem, add an additional reference
>> count to cachefiles_req, which is held while waiting and reading, and 
>> then
>> released when the waiting and reading is over.
>
> Hi Baokun,
> Thank you for catching this issue. Shall we fix this by following steps:
> cachefiles_ondemand_fd_release()
>     xas_for_each(req)
>         if req is not CACHEFILES_OP_READ
>             flush
>
> cachefiles_ondemand_restore()
>     xas_for_each(req)
>         if req is not CACHEFILES_REQ_NEW && op is (OPEN or CLOSE)
>             reset req to CACHEFILES_REQ_NEW
>
> By implementing these steps:
> 1. In real daemon failover case： only pending read reqs will be
> reserved. cachefiles_ondemand_select_req will reopen the object by
> processing READ req.
> 2. In daemon alive case： Only read reqs will be reset to
> CACHEFILES_REQ_NEW.
>
This way, in the fialover case, some processes that are being mounted
will fail, which is contrary to our intention of making the user senseless.
In my opinion, it's better to keep making users senseless.

Thanks,
Baokun
>
>>
>> Note that since there is only one reference count for waiting, we 
>> need to
>> avoid the same request being completed multiple times, so we can only
>> complete the request if it is successfully removed from the xarray.
>>
>> Fixes: e73fa11a356c ("cachefiles: add restore command to recover 
>> inflight ondemand read requests")
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/internal.h |  1 +
>>   fs/cachefiles/ondemand.c | 44 ++++++++++++++++++++++------------------
>>   2 files changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index d33169f0018b..7745b8abc3aa 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -138,6 +138,7 @@ static inline bool 
>> cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>>   struct cachefiles_req {
>>       struct cachefiles_object *object;
>>       struct completion done;
>> +    refcount_t ref;
>>       int error;
>>       struct cachefiles_msg msg;
>>   };
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index fd49728d8bae..56d12fe4bf73 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -4,6 +4,12 @@
>>   #include <linux/uio.h>
>>   #include "internal.h"
>>   +static inline void cachefiles_req_put(struct cachefiles_req *req)
>> +{
>> +    if (refcount_dec_and_test(&req->ref))
>> +        kfree(req);
>> +}
>> +
>>   static int cachefiles_ondemand_fd_release(struct inode *inode,
>>                         struct file *file)
>>   {
>> @@ -299,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct 
>> cachefiles_cache *cache,
>>   {
>>       struct cachefiles_req *req;
>>       struct cachefiles_msg *msg;
>> -    unsigned long id = 0;
>>       size_t n;
>>       int ret = 0;
>>       XA_STATE(xas, &cache->reqs, cache->req_id_next);
>> @@ -330,41 +335,39 @@ ssize_t cachefiles_ondemand_daemon_read(struct 
>> cachefiles_cache *cache,
>>         xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>>       cache->req_id_next = xas.xa_index + 1;
>> +    refcount_inc(&req->ref);
>>       xa_unlock(&cache->reqs);
>>   -    id = xas.xa_index;
>> -
>>       if (msg->opcode == CACHEFILES_OP_OPEN) {
>>           ret = cachefiles_ondemand_get_fd(req);
>>           if (ret) {
>> cachefiles_ondemand_set_object_close(req->object);
>> -            goto error;
>> +            goto out;
>>           }
>>       }
>>   -    msg->msg_id = id;
>> +    msg->msg_id = xas.xa_index;
>>       msg->object_id = req->object->ondemand->ondemand_id;
>>         if (copy_to_user(_buffer, msg, n) != 0) {
>>           ret = -EFAULT;
>>           if (msg->opcode == CACHEFILES_OP_OPEN)
>>               close_fd(((struct cachefiles_open *)msg->data)->fd);
>> -        goto error;
>>       }
>> -
>> -    /* CLOSE request has no reply */
>> -    if (msg->opcode == CACHEFILES_OP_CLOSE) {
>> -        xa_erase(&cache->reqs, id);
>> -        complete(&req->done);
>> +out:
>> +    /* Remove error request and CLOSE request has no reply */
>> +    if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>> +        xas_reset(&xas);
>> +        xas_lock(&xas);
>> +        if (xas_load(&xas) == req) {
>> +            req->error = ret;
>> +            complete(&req->done);
>> +            xas_store(&xas, NULL);
>> +        }
>> +        xas_unlock(&xas);
>>       }
>> -
>> -    return n;
>> -
>> -error:
>> -    xa_erase(&cache->reqs, id);
>> -    req->error = ret;
>> -    complete(&req->done);
>> -    return ret;
>> +    cachefiles_req_put(req);
>> +    return ret ? ret : n;
>>   }
>>     typedef int (*init_req_fn)(struct cachefiles_req *req, void 
>> *private);
>> @@ -394,6 +397,7 @@ static int cachefiles_ondemand_send_req(struct 
>> cachefiles_object *object,
>>           goto out;
>>       }
>>   +    refcount_set(&req->ref, 1);
>>       req->object = object;
>>       init_completion(&req->done);
>>       req->msg.opcode = opcode;
>> @@ -455,7 +459,7 @@ static int cachefiles_ondemand_send_req(struct 
>> cachefiles_object *object,
>>       wake_up_all(&cache->daemon_pollwq);
>>       wait_for_completion(&req->done);
>>       ret = req->error;
>> -    kfree(req);
>> +    cachefiles_req_put(req);
>>       return ret;
>>   out:
>>       /* Reset the object to close state in error handling path.


