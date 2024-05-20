Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1248C99EE
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 10:46:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjWF602r3z3ft0
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 18:38:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjWF22lNsz3fsd
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 18:38:45 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjWDk3BPZz4f3lVj
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 16:38:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CDE9D1A0F00
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 16:38:40 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g4MDEtmLAOxNA--.2876S3;
	Mon, 20 May 2024 16:38:40 +0800 (CST)
Message-ID: <d8154eed-98d0-9cb7-4a2c-6b68ed75b7a2@huaweicloud.com>
Date: Mon, 20 May 2024 16:38:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-4-libaokun@huaweicloud.com>
 <35561c99-c978-4cf6-82e9-d1308c82a7ff@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <35561c99-c978-4cf6-82e9-d1308c82a7ff@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAX5g4MDEtmLAOxNA--.2876S3
X-Coremail-Antispam: 1UD129KBjvJXoW3uFWDCF1rWryrGry8XryDtrb_yoWDCrWrpF
	ZayFy7Kry8WFy8CrZ7Awn8XryFy3y8A3ZrWr10qF18Arn09r1Fvr1jqr10gFy5CrWkCrsr
	t3W8uF9rZryqv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jingbo,

Thanks for your review!

On 2024/5/20 15:24, Jingbo Xu wrote:
>
> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> We got the following issue in a fuzz test of randomly issuing the restore
>> command:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0x609/0xab0
>> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
>>
>> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
>> Call Trace:
>>   kasan_report+0x94/0xc0
>>   cachefiles_ondemand_daemon_read+0x609/0xab0
>>   vfs_read+0x169/0xb50
>>   ksys_read+0xf5/0x1e0
>>
>> Allocated by task 626:
>>   __kmalloc+0x1df/0x4b0
>>   cachefiles_ondemand_send_req+0x24d/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>>
>> Freed by task 626:
>>   kfree+0xf1/0x2c0
>>   cachefiles_ondemand_send_req+0x568/0x690
>>   cachefiles_create_tmpfile+0x249/0xb30
>>   cachefiles_create_file+0x6f/0x140
>>   cachefiles_look_up_object+0x29c/0xa60
>>   cachefiles_lookup_cookie+0x37d/0xca0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>> ==================================================================
>>
>> Following is the process that triggers the issue:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>>   cachefiles_ondemand_init_object
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                REQ_A = cachefiles_ondemand_select_req
>>                cachefiles_ondemand_get_fd
>>                copy_to_user(_buffer, msg, n)
>>              process_open_req(REQ_A)
>>                                    ------ restore ------
>>                                    cachefiles_ondemand_restore
>>                                    xas_for_each(&xas, req, ULONG_MAX)
>>                                     xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>>
>>                                    cachefiles_daemon_read
>>                                     cachefiles_ondemand_daemon_read
>>                                      REQ_A = cachefiles_ondemand_select_req
>>
>>               write(devfd, ("copen %u,%llu", msg->msg_id, size));
>>               cachefiles_ondemand_copen
>>                xa_erase(&cache->reqs, id)
>>                complete(&REQ_A->done)
>>     kfree(REQ_A)
>>                                      cachefiles_ondemand_get_fd(REQ_A)
>>                                       fd = get_unused_fd_flags
>>                                       file = anon_inode_getfile
>>                                       fd_install(fd, file)
>>                                       load = (void *)REQ_A->msg.data;
>>                                       load->fd = fd;
>>                                       // load UAF !!!
>>
>> This issue is caused by issuing a restore command when the daemon is still
>> alive, which results in a request being processed multiple times thus
>> triggering a UAF. So to avoid this problem, add an additional reference
>> count to cachefiles_req, which is held while waiting and reading, and then
>> released when the waiting and reading is over.
>>
>>
>> Note that since there is only one reference count for waiting, we need to
>> avoid the same request being completed multiple times, so we can only
>> complete the request if it is successfully removed from the xarray.
> Sorry the above description makes me confused.  As the same request may
> be got by different daemon threads multiple times, the introduced
> refcount mechanism can't protect it from being completed multiple times
> (which is expected).  The refcount only protects it from being freed
> multiple times.
The idea here is that because the wait only holds one reference count,
complete(&req->done) can only be called when the req has been
successfully removed from the xarry, otherwise the following UAF may
occur:

    daemon_thread1    |    daemon_thread2
-------------------------------------------
cachefiles_ondemand_daemon_read
  xa_lock(&cache->reqs)
  // select req_A
  xa_unlock(&cache->reqs)
                     // restore req_A and read again
                     cachefiles_ondemand_daemon_read
                     xa_lock(&cache->reqs)
                     // select req_A
                     xa_unlock(&cache->reqs)
// goto error, erase success
xa_erase(&cache->reqs, id)
complete(&req_A->done)
// free req_A
                     // goto error, erase failed
                     complete(&req_A->done)
                     // req_A use-after-free

This is also why error requests and CLOSE requests are handled
together and why xas_load(&xas) == req is checked.
>> Fixes: e73fa11a356c ("cachefiles: add restore command to recover inflight ondemand read requests")
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/cachefiles/internal.h |  1 +
>>   fs/cachefiles/ondemand.c | 44 ++++++++++++++++++++++------------------
>>   2 files changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index d33169f0018b..7745b8abc3aa 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -138,6 +138,7 @@ static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>>   struct cachefiles_req {
>>   	struct cachefiles_object *object;
>>   	struct completion done;
>> +	refcount_t ref;
>>   	int error;
>>   	struct cachefiles_msg msg;
>>   };
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index fd49728d8bae..56d12fe4bf73 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -4,6 +4,12 @@
>>   #include <linux/uio.h>
>>   #include "internal.h"
>>   
>> +static inline void cachefiles_req_put(struct cachefiles_req *req)
>> +{
>> +	if (refcount_dec_and_test(&req->ref))
>> +		kfree(req);
>> +}
>> +
>>   static int cachefiles_ondemand_fd_release(struct inode *inode,
>>   					  struct file *file)
>>   {
>> @@ -299,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   {
>>   	struct cachefiles_req *req;
>>   	struct cachefiles_msg *msg;
>> -	unsigned long id = 0;
>>   	size_t n;
>>   	int ret = 0;
>>   	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>> @@ -330,41 +335,39 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   
>>   	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>>   	cache->req_id_next = xas.xa_index + 1;
>> +	refcount_inc(&req->ref);
>>   	xa_unlock(&cache->reqs);
>>   
>> -	id = xas.xa_index;
>> -
>>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>>   		ret = cachefiles_ondemand_get_fd(req);
>>   		if (ret) {
>>   			cachefiles_ondemand_set_object_close(req->object);
>> -			goto error;
>> +			goto out;
>>   		}
>>   	}
>>   
>> -	msg->msg_id = id;
>> +	msg->msg_id = xas.xa_index;
>>   	msg->object_id = req->object->ondemand->ondemand_id;
>>   
>>   	if (copy_to_user(_buffer, msg, n) != 0) {
>>   		ret = -EFAULT;
>>   		if (msg->opcode == CACHEFILES_OP_OPEN)
>>   			close_fd(((struct cachefiles_open *)msg->data)->fd);
>> -		goto error;
>>   	}
>> -
>> -	/* CLOSE request has no reply */
>> -	if (msg->opcode == CACHEFILES_OP_CLOSE) {
>> -		xa_erase(&cache->reqs, id);
>> -		complete(&req->done);
>> +out:
>> +	/* Remove error request and CLOSE request has no reply */
>> +	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>> +		xas_reset(&xas);
>> +		xas_lock(&xas);
>> +		if (xas_load(&xas) == req) {
> Just out of curiosity... How could xas_load(&xas) doesn't equal to req?

As mentioned above, the req may have been deleted or even the id

may have been reused.

>
>> +			req->error = ret;
>> +			complete(&req->done);
>> +			xas_store(&xas, NULL);
>> +		}
>> +		xas_unlock(&xas);
>>   	}
>> -
>> -	return n;
>> -
>> -error:
>> -	xa_erase(&cache->reqs, id);
>> -	req->error = ret;
>> -	complete(&req->done);
>> -	return ret;
>> +	cachefiles_req_put(req);
>> +	return ret ? ret : n;
>>   }
> This is actually a combination of a fix and a cleanup which combines the
> logic of removing error request and the CLOSE requests into one place.
> Also it relies on the cleanup made in patch 2 ("cachefiles: remove
> err_put_fd tag in cachefiles_ondemand_daemon_read()"), making it
> difficult to be atomatically back ported to the stable (as patch 2 is
> not marked as "Fixes").
>
> Thus could we make the fix first, and then make the cleanup.
I don't think that's necessary, stable automatically backports the
relevant dependency patches in case of backport patch conflicts,
and later patches modify the logic here as well.
Or add Fixes tag for patch 2?
>>   
>>   typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
>> @@ -394,6 +397,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>   		goto out;
>>   	}
>>   
>> +	refcount_set(&req->ref, 1);
>>   	req->object = object;
>>   	init_completion(&req->done);
>>   	req->msg.opcode = opcode;
>> @@ -455,7 +459,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>   	wake_up_all(&cache->daemon_pollwq);
>>   	wait_for_completion(&req->done);
>>   	ret = req->error;
>> -	kfree(req);
>> +	cachefiles_req_put(req);
>>   	return ret;
>>   out:
>>   	/* Reset the object to close state in error handling path.
>
> Don't we need to also convert "kfree(req)" to cachefiles_req_put(req)
> for the error path of cachefiles_ondemand_send_req()?
>
> ```
> out:
> 	/* Reset the object to close state in error handling path.
> 	 * If error occurs after creating the anonymous fd,
> 	 * cachefiles_ondemand_fd_release() will set object to close.
> 	 */
> 	if (opcode == CACHEFILES_OP_OPEN)
> 		cachefiles_ondemand_set_object_close(object);
> 	kfree(req);
> 	return ret;
> ```
When "goto out;" is called in cachefiles_ondemand_send_req(),
it means that the req is unallocated/failed to be allocated/failed to
be inserted into the xarry, and therefore the req can only be accessed
by the current function, so there is no need to consider concurrency
and reference counting.

Thanks!

-- 
With Best Regards,
Baokun Li

