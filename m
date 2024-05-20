Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id A04448C9A12
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 11:06:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjWf60q91z3fts
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 18:57:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjWf040zGz3ftW
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 18:56:56 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjWdn369Zz4f3jZ0
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 16:56:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2801F1A06D6
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 16:56:51 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5PEEtmqiyyNA--.3335S3;
	Mon, 20 May 2024 16:56:50 +0800 (CST)
Message-ID: <556ca8a0-68a6-eeb4-3aa2-a6d613c232e7@huaweicloud.com>
Date: Mon, 20 May 2024 16:56:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 04/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_daemon_read()
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-5-libaokun@huaweicloud.com>
 <a4cb6b6b-0105-4ba5-b43d-662ef96fbec6@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <a4cb6b6b-0105-4ba5-b43d-662ef96fbec6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAX5g5PEEtmqiyyNA--.3335S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF45Gw4rAw47Jr4fWr1rJFb_yoW7ArW7pF
	ZIyFyxtry8WrW8Cr97ZFn8Jr1rJ3yqyFnrX340qr1xAws8Zr1rZr17tF1FqF98Cry7Ars7
	t3WUuF9xtryjy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
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
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/5/20 15:36, Jingbo Xu wrote:
>
> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> We got the following issue in a fuzz test of randomly issuing the restore
>> command:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0xb41/0xb60
>> Read of size 8 at addr ffff888122e84088 by task ondemand-04-dae/963
>>
>> CPU: 13 PID: 963 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #564
>> Call Trace:
>>   kasan_report+0x93/0xc0
>>   cachefiles_ondemand_daemon_read+0xb41/0xb60
>>   vfs_read+0x169/0xb50
>>   ksys_read+0xf5/0x1e0
>>
>> Allocated by task 116:
>>   kmem_cache_alloc+0x140/0x3a0
>>   cachefiles_lookup_cookie+0x140/0xcd0
>>   fscache_cookie_state_machine+0x43c/0x1230
>>   [...]
>>
>> Freed by task 792:
>>   kmem_cache_free+0xfe/0x390
>>   cachefiles_put_object+0x241/0x480
>>   fscache_cookie_state_machine+0x5c8/0x1230
>>   [...]
>> ==================================================================
>>
>> Following is the process that triggers the issue:
>>
>>       mount  |   daemon_thread1    |    daemon_thread2
>> ------------------------------------------------------------
>> cachefiles_withdraw_cookie
>>   cachefiles_ondemand_clean_object(object)
>>    cachefiles_ondemand_send_req
>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>     wait_for_completion(&REQ_A->done)
>>
>>              cachefiles_daemon_read
>>               cachefiles_ondemand_daemon_read
>>                REQ_A = cachefiles_ondemand_select_req
>>                msg->object_id = req->object->ondemand->ondemand_id
>>                                    ------ restore ------
>>                                    cachefiles_ondemand_restore
>>                                    xas_for_each(&xas, req, ULONG_MAX)
>>                                     xas_set_mark(&xas, CACHEFILES_REQ_NEW)
>>
>>                                    cachefiles_daemon_read
>>                                     cachefiles_ondemand_daemon_read
>>                                      REQ_A = cachefiles_ondemand_select_req
>>                copy_to_user(_buffer, msg, n)
>>                 xa_erase(&cache->reqs, id)
>>                 complete(&REQ_A->done)
>>                ------ close(fd) ------
>>                cachefiles_ondemand_fd_release
>>                 cachefiles_put_object
>>   cachefiles_put_object
>>    kmem_cache_free(cachefiles_object_jar, object)
>>                                      REQ_A->object->ondemand->ondemand_id
>>                                       // object UAF !!!
>>
>> When we see the request within xa_lock, req->object must not have been
>> freed yet, so grab the reference count of object before xa_unlock to
>> avoid the above issue.
>>
>> Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/cachefiles/ondemand.c          | 2 ++
>>   include/trace/events/cachefiles.h | 6 +++++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 56d12fe4bf73..bb94ef6a6f61 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -336,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>>   	cache->req_id_next = xas.xa_index + 1;
>>   	refcount_inc(&req->ref);
>> +	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
>>   	xa_unlock(&cache->reqs);
>>   
>>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>> @@ -355,6 +356,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   			close_fd(((struct cachefiles_open *)msg->data)->fd);
>>   	}
>>   out:
>> +	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
>>   	/* Remove error request and CLOSE request has no reply */
>>   	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>>   		xas_reset(&xas);
>> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
>> index cf4b98b9a9ed..119a823fb5a0 100644
>> --- a/include/trace/events/cachefiles.h
>> +++ b/include/trace/events/cachefiles.h
>> @@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
>>   	cachefiles_obj_see_withdrawal,
>>   	cachefiles_obj_get_ondemand_fd,
>>   	cachefiles_obj_put_ondemand_fd,
>> +	cachefiles_obj_get_read_req,
>> +	cachefiles_obj_put_read_req,
> How about cachefiles_obj_[get|put]_ondemand_read, so that it could be
> easily identified as ondemand mode at the first glance?
The ondemand_read tends to confuse whether it's
ondemand_daemon_read or ondemand_data_read. I think it's better
to emphasise the read request, and currently only the ondemand
mode has a cachefiles req.
>>   };
>>   
>>   enum fscache_why_object_killed {
>> @@ -127,7 +129,9 @@ enum cachefiles_error_trace {
>>   	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
>>   	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>>   	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
>> -	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
>> +	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
>> +	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
>> +	E_(cachefiles_obj_put_read_req,		"PUT read_req")
> Ditto.
>
>
> Otherwise, LGTM.
>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>
Thank you very much for your review!

-- 
With Best Regards,
Baokun Li

