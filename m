Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF88C9A5D
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 11:31:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ui+pmk9Q;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjXFX72BGz3cZw
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 19:24:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ui+pmk9Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjXFQ37mkz3cXZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 19:24:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716197044; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ypw9L8vrY/zJiXV/6qIjcOg86oiLiLLexz5cMQSyyW4=;
	b=ui+pmk9QC8QNoF4XAjNz8kh8n8y3sEjaf/8XT2Bk8WsthOiWcnQ2Fwb+IplM9kcLoAFwJD8IHvfuWTCgOtHcczimJusoM1Y92ARl1xyTWzxpkf5mmvAKZn9/bTSSfIIcICep+Y86/HxkqmYhu5bOXL6Ki0TrLCx4ioli7ZtZhDo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6qKcWT_1716197041;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6qKcWT_1716197041)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 17:24:03 +0800
Message-ID: <a3ca2292-0218-45f6-8afe-4319a10b69e2@linux.alibaba.com>
Date: Mon, 20 May 2024 17:24:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if
 ondemand_id is valid
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-9-libaokun@huaweicloud.com>
 <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
 <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 5/20/24 5:07 PM, Baokun Li wrote:
> On 2024/5/20 16:43, Jingbo Xu wrote:
>>
>> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>>> From: Baokun Li <libaokun1@huawei.com>
>>>
>>> Now every time the daemon reads an open request, it gets a new
>>> anonymous fd
>>> and ondemand_id. With the introduction of "restore", it is possible
>>> to read
>>> the same open request more than once, and therefore an object can
>>> have more
>>> than one anonymous fd.
>>>
>>> If the anonymous fd is not unique, the following concurrencies will
>>> result
>>> in an fd leak:
>>>
>>>       t1     |         t2         |          t3
>>> ------------------------------------------------------------
>>>   cachefiles_ondemand_init_object
>>>    cachefiles_ondemand_send_req
>>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>>     wait_for_completion(&REQ_A->done)
>>>              cachefiles_daemon_read
>>>               cachefiles_ondemand_daemon_read
>>>                REQ_A = cachefiles_ondemand_select_req
>>>                cachefiles_ondemand_get_fd
>>>                  load->fd = fd0
>>>                  ondemand_id = object_id0
>>>                                    ------ restore ------
>>>                                    cachefiles_ondemand_restore
>>>                                     // restore REQ_A
>>>                                    cachefiles_daemon_read
>>>                                     cachefiles_ondemand_daemon_read
>>>                                      REQ_A =
>>> cachefiles_ondemand_select_req
>>>                                        cachefiles_ondemand_get_fd
>>>                                          load->fd = fd1
>>>                                          ondemand_id = object_id1
>>>               process_open_req(REQ_A)
>>>               write(devfd, ("copen %u,%llu", msg->msg_id, size))
>>>               cachefiles_ondemand_copen
>>>                xa_erase(&cache->reqs, id)
>>>                complete(&REQ_A->done)
>>>     kfree(REQ_A)
>>>                                    process_open_req(REQ_A)
>>>                                    // copen fails due to no req
>>>                                    // daemon close(fd1)
>>>                                    cachefiles_ondemand_fd_release
>>>                                     // set object closed
>>>   -- umount --
>>>   cachefiles_withdraw_cookie
>>>    cachefiles_ondemand_clean_object
>>>     cachefiles_ondemand_init_close_req
>>>      if (!cachefiles_ondemand_object_is_open(object))
>>>        return -ENOENT;
>>>      // The fd0 is not closed until the daemon exits.
>>>
>>> However, the anonymous fd holds the reference count of the object and
>>> the
>>> object holds the reference count of the cookie. So even though the
>>> cookie
>>> has been relinquished, it will not be unhashed and freed until the
>>> daemon
>>> exits.
>>>
>>> In fscache_hash_cookie(), when the same cookie is found in the hash
>>> list,
>>> if the cookie is set with the FSCACHE_COOKIE_RELINQUISHED bit, then
>>> the new
>>> cookie waits for the old cookie to be unhashed, while the old cookie is
>>> waiting for the leaked fd to be closed, if the daemon does not exit
>>> in time
>>> it will trigger a hung task.
>>>
>>> To avoid this, allocate a new anonymous fd only if no anonymous fd has
>>> been allocated (ondemand_id == 0) or if the previously allocated
>>> anonymous
>>> fd has been closed (ondemand_id == -1). Moreover, returns an error if
>>> ondemand_id is valid, letting the daemon know that the current userland
>>> restore logic is abnormal and needs to be checked.
>>>
>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking
>>> up cookie")
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> The LOCs of this fix is quite under control.  But still it seems that
>> the worst consequence is that the (potential) malicious daemon gets
>> hung.  No more effect to the system or other processes.  Or does a
>> non-malicious daemon have any chance having the same issue?
> If we enable hung_task_panic, it may cause panic to crash the server.

Then this issue has nothing to do with this patch?  As long as a
malicious daemon doesn't close the anonymous fd after umounting, then I
guess a following attempt of mounting cookie with the same name will
also wait and hung there?

-- 
Thanks,
Jingbo
