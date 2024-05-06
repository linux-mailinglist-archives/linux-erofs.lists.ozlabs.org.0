Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105C8BC725
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 07:50:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QhPEQgf7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VXr9l2604z30TX
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 15:50:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QhPEQgf7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VXr9c3trxz2yvp
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 15:50:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714974638; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jzjYRYNv9PIVT8Vfr3RNPMl2TSVcXUpCKYYeAEqj4j4=;
	b=QhPEQgf7SbINhuehYxBQbnS6Foihw31CSZyf3TuFyxbJoe9dB289ypgeBm2JAnTSVPs/ZJ4PwKZvbezKk3oCUWADOfSnKnu/q7RpMUb1iJc+RUkdHioddzANxLkLMLffWLFdMePnbK5lewe34XIIlbCNJjzE3tipt/khxgS4izg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5tv91D_1714974635;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5tv91D_1714974635)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 13:50:36 +0800
Message-ID: <876cd180-6268-4f1a-a3bc-6b7b2aa3279f@linux.alibaba.com>
Date: Mon, 6 May 2024 13:50:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
 <6e4a20f7-263a-46be-81cc-2667353c452d@linux.alibaba.com>
 <ba40eb22-dc28-54b6-a8cb-7a8ba4464c9a@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ba40eb22-dc28-54b6-a8cb-7a8ba4464c9a@huaweicloud.com>
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
Cc: yangerkun <yangerkun@huawei.com>, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 5/6/24 11:57 AM, Baokun Li wrote:
> On 2024/5/6 11:48, Jingbo Xu wrote:
>>
>> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>>> From: Baokun Li <libaokun1@huawei.com>
>>>
>>> This prevents concurrency from causing access to a freed req.
>> Could you give more details on how the concurrent access will happen?
>> How could another process access the &cache->reqs xarray after it has
>> been flushed?
> 
> Similar logic to restore leading to UAF:
> 
>      mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>  cachefiles_ondemand_init_object
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
> 
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>               REQ_A = cachefiles_ondemand_select_req
>               cachefiles_ondemand_get_fd
>               copy_to_user(_buffer, msg, n)
>             process_open_req(REQ_A)
>                                   // close dev fd
>                                   cachefiles_flush_reqs
>                                    complete(&REQ_A->done)
>    kfree(REQ_A)


>              cachefiles_ondemand_get_fd(REQ_A)
>               fd = get_unused_fd_flags
>               file = anon_inode_getfile
>               fd_install(fd, file)
>               load = (void *)REQ_A->msg.data;
>               load->fd = fd;
>               // load UAF !!!

How could the second cachefiles_ondemand_get_fd() get called here, given
the cache has been flushed and flagged as DEAD?


> 
>>> ---
>>>   fs/cachefiles/daemon.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>>> index 6465e2574230..ccb7b707ea4b 100644
>>> --- a/fs/cachefiles/daemon.c
>>> +++ b/fs/cachefiles/daemon.c
>>> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct
>>> cachefiles_cache *cache)
>>>       xa_for_each(xa, index, req) {
>>>           req->error = -EIO;
>>>           complete(&req->done);
>>> +        __xa_erase(xa, index);
>>>       }
>>>       xa_unlock(xa);
>>>   
> 

-- 
Thanks,
Jingbo
