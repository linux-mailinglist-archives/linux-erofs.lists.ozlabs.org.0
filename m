Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 472058C9D4D
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 14:31:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjcCM1728z3cjt
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 22:22:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjcCC4VG7z3cZ9
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 22:22:30 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjcBt1mcHz4f3m79
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 20:22:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A0EBB1A0199
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 20:22:24 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ58QEtm8V6_NA--.25640S3;
	Mon, 20 May 2024 20:22:24 +0800 (CST)
Message-ID: <df69d0b3-bac3-fc70-bb65-d4fbecfc249a@huaweicloud.com>
Date: Mon, 20 May 2024 20:22:20 +0800
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
 <d8154eed-98d0-9cb7-4a2c-6b68ed75b7a2@huaweicloud.com>
 <d0e6d1f6-002f-4255-a481-6bd17f3da7fc@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <d0e6d1f6-002f-4255-a481-6bd17f3da7fc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHZQ58QEtm8V6_NA--.25640S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rXrW5Kw48KF4kKw4fAFb_yoWxXry8pF
	93JFyxJry5GrykJr1Utr1UJryUtr1UJ3WUXr18JF18Jr4qyr1Yqr1UXr1qgryUGr48Ar1U
	Jr1UJry7Zr1UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5sjjDUUUU
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

On 2024/5/20 17:10, Jingbo Xu wrote:
>
> On 5/20/24 4:38 PM, Baokun Li wrote:
>> Hi Jingbo,
>>
>> Thanks for your review!
>>
>> On 2024/5/20 15:24, Jingbo Xu wrote:
>>> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> We got the following issue in a fuzz test of randomly issuing the
>>>> restore
>>>> command:
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: slab-use-after-free in
>>>> cachefiles_ondemand_daemon_read+0x609/0xab0
>>>> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
>>>>
>>>> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
>>>> Call Trace:
>>>>    kasan_report+0x94/0xc0
>>>>    cachefiles_ondemand_daemon_read+0x609/0xab0
>>>>    vfs_read+0x169/0xb50
>>>>    ksys_read+0xf5/0x1e0
>>>>
>>>> Allocated by task 626:
>>>>    __kmalloc+0x1df/0x4b0
>>>>    cachefiles_ondemand_send_req+0x24d/0x690
>>>>    cachefiles_create_tmpfile+0x249/0xb30
>>>>    cachefiles_create_file+0x6f/0x140
>>>>    cachefiles_look_up_object+0x29c/0xa60
>>>>    cachefiles_lookup_cookie+0x37d/0xca0
>>>>    fscache_cookie_state_machine+0x43c/0x1230
>>>>    [...]
>>>>
>>>> Freed by task 626:
>>>>    kfree+0xf1/0x2c0
>>>>    cachefiles_ondemand_send_req+0x568/0x690
>>>>    cachefiles_create_tmpfile+0x249/0xb30
>>>>    cachefiles_create_file+0x6f/0x140
>>>>    cachefiles_look_up_object+0x29c/0xa60
>>>>    cachefiles_lookup_cookie+0x37d/0xca0
>>>>    fscache_cookie_state_machine+0x43c/0x1230
>>>>    [...]
>>>> ==================================================================
>>>>
>>>> Following is the process that triggers the issue:
>>>>
>>>>        mount  |   daemon_thread1    |    daemon_thread2
>>>> ------------------------------------------------------------
>>>>    cachefiles_ondemand_init_object
>>>>     cachefiles_ondemand_send_req
>>>>      REQ_A = kzalloc(sizeof(*req) + data_len)
>>>>      wait_for_completion(&REQ_A->done)
>>>>
>>>>               cachefiles_daemon_read
>>>>                cachefiles_ondemand_daemon_read
>>>>                 REQ_A = cachefiles_ondemand_select_req
>>>>                 cachefiles_ondemand_get_fd
>>>>                 copy_to_user(_buffer, msg, n)
>>>>               process_open_req(REQ_A)
>>>>                                     ------ restore ------
>>>>                                     cachefiles_ondemand_restore
>>>>                                     xas_for_each(&xas, req, ULONG_MAX)
>>>>                                      xas_set_mark(&xas,
>>>> CACHEFILES_REQ_NEW);
>>>>
>>>>                                     cachefiles_daemon_read
>>>>                                      cachefiles_ondemand_daemon_read
>>>>                                       REQ_A =
>>>> cachefiles_ondemand_select_req
>>>>
>>>>                write(devfd, ("copen %u,%llu", msg->msg_id, size));
>>>>                cachefiles_ondemand_copen
>>>>                 xa_erase(&cache->reqs, id)
>>>>                 complete(&REQ_A->done)
>>>>      kfree(REQ_A)
>>>>                                       cachefiles_ondemand_get_fd(REQ_A)
>>>>                                        fd = get_unused_fd_flags
>>>>                                        file = anon_inode_getfile
>>>>                                        fd_install(fd, file)
>>>>                                        load = (void *)REQ_A->msg.data;
>>>>                                        load->fd = fd;
>>>>                                        // load UAF !!!
>>>>
>>>> This issue is caused by issuing a restore command when the daemon is
>>>> still
>>>> alive, which results in a request being processed multiple times thus
>>>> triggering a UAF. So to avoid this problem, add an additional reference
>>>> count to cachefiles_req, which is held while waiting and reading, and
>>>> then
>>>> released when the waiting and reading is over.
>>>>
>>>>
>>>> Note that since there is only one reference count for waiting, we
>>>> need to
>>>> avoid the same request being completed multiple times, so we can only
>>>> complete the request if it is successfully removed from the xarray.
>>> Sorry the above description makes me confused.  As the same request may
>>> be got by different daemon threads multiple times, the introduced
>>> refcount mechanism can't protect it from being completed multiple times
>>> (which is expected).  The refcount only protects it from being freed
>>> multiple times.
>> The idea here is that because the wait only holds one reference count,
>> complete(&req->done) can only be called when the req has been
>> successfully removed from the xarry, otherwise the following UAF may
>> occur:
>
> "complete(&req->done) can only be called when the req has been
> successfully removed from the xarry ..."
>
> How this is done? since the following xarray_erase() following the first
> xarray_erase() will fail as the xarray slot referred by the same id has
> already been erased?

Sorry just forgot to reply to this！

Yes, after loading the xas, the entry (aka req) is checked to see if it 
meets
expectations, and only when it does do we null the xas and complete the 
request.


-- 
With Best Regards,
Baokun Li

