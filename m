Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF58C9C1D
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 13:31:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZRWlrIKp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjZw75m30z3cj7
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 21:24:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZRWlrIKp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjZvz55Dyz3cYk
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 21:24:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716204249; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e5msGpPJDfpNozD6dX0TXGDkIn5t6CljDiGOFY3+f8E=;
	b=ZRWlrIKplW1YPjLd05G9+f+tm8g6XYzuhfjvg3YpjE61faO8TNVdmVePsn751grmQA222UszBEuvIMM9CiMIBjplNb8Zbp8YOOeHs+ujwbX0F704RA4gJjnuPqUGTLGoqCnOUlkmp3oGg/X98WSQoQMIhvRaAODS67uSQDnnLPY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6s..ub_1716204246;
Received: from 30.97.48.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6s..ub_1716204246)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 19:24:08 +0800
Message-ID: <e57ae68f-29c3-41ac-bf16-f11d546dd958@linux.alibaba.com>
Date: Mon, 20 May 2024 19:24:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if
 ondemand_id is valid
To: Baokun Li <libaokun@huaweicloud.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-9-libaokun@huaweicloud.com>
 <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
 <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
 <a3ca2292-0218-45f6-8afe-4319a10b69e2@linux.alibaba.com>
 <5b1b2719-2123-9218-97b4-ccda8b5cb3b4@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5b1b2719-2123-9218-97b4-ccda8b5cb3b4@huaweicloud.com>
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



On 2024/5/20 19:14, Baokun Li wrote:
> On 2024/5/20 17:24, Jingbo Xu wrote:
>>
>> On 5/20/24 5:07 PM, Baokun Li wrote:
>>> On 2024/5/20 16:43, Jingbo Xu wrote:
>>>> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>>
> SNIP
>>>>>
>>>>> To avoid this, allocate a new anonymous fd only if no anonymous fd has
>>>>> been allocated (ondemand_id == 0) or if the previously allocated
>>>>> anonymous
>>>>> fd has been closed (ondemand_id == -1). Moreover, returns an error if
>>>>> ondemand_id is valid, letting the daemon know that the current userland
>>>>> restore logic is abnormal and needs to be checked.
>>>>>
>>>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking
>>>>> up cookie")
>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>> The LOCs of this fix is quite under control.  But still it seems that
>>>> the worst consequence is that the (potential) malicious daemon gets
>>>> hung.  No more effect to the system or other processes.  Or does a
>>>> non-malicious daemon have any chance having the same issue?
>>> If we enable hung_task_panic, it may cause panic to crash the server.
>> Then this issue has nothing to do with this patch?  As long as a
>> malicious daemon doesn't close the anonymous fd after umounting, then I
>> guess a following attempt of mounting cookie with the same name will
>> also wait and hung there?
>>
> Yes, a daemon that only reads requests but doesn't process them will
> cause hung，but the daemon will obey the basic constraints when we
> test it.

If we'd really like to enhanace this ("hung_task_panic"), I think
you'd better to switch wait_for_completion() to
wait_for_completion_killable() at least IMHO anyway.

Thanks,
Gao Xiang

