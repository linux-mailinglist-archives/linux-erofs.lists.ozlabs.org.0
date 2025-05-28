Return-Path: <linux-erofs+bounces-374-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B65AC6676
	for <lists+linux-erofs@lfdr.de>; Wed, 28 May 2025 11:58:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6lM84f7sz2xRq;
	Wed, 28 May 2025 19:58:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748426324;
	cv=none; b=PUCelGkUEWDm7UxEJfjiiW732cf/Qhk3HdjLY0y9s7RLosJeUlMJX23fVQhxlWsaHkwA8QfVNlK79UYGeWle2XVZ0X36moLnjIWMIKIoob6qEkOl0pjjQW2tROcAPoiDmM+lcGjIBamgXtY16DZ6e2G2yxgHs6lJkXbnZI29IULOVHQqpYfGlIDd0c5U+aPg5qkzwfUHJq+m6OKAexVisSMpYuUEnavXEWbcZjyG6bOReUUXm2HlPNc451ksktNGlIjO3WoGgSHAaejyXfDSlMk182u9X4YDz+1PGcDz2TEGWQ24PlmdFcT/ERO2U5bPDbjY6ArWp8KnCPiEj+y7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748426324; c=relaxed/relaxed;
	bh=MT3+yUs215xawarMGfAIgZQ4/GikvZj8gpvIVp5U7oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO3b9kc5M8Uc+54KndGF5VqPfxprdMRJN+ZeXLvIsmmDEwus1UQVtib1H7IAtVuVbn4xtr/HXVbze4KgZe6BLPf6GMWI8gphkBf4Ef848seL+HxkK2N+kyoxto4q6dw9KfJSjqhwu5ArFstHFAgCcKzYuIFLXLnN/IjlaT8f8ocvYe+SefXIu39mOVlFgbqcvw0QxL7Gu8mrrL7T8/iAS/FywZ+QtdkgDKNhMRh0jsHKOyigUTHs+X62lZW/2imaGs5pVP2K9Am7OvEnYv14r/qKF6J0X/Pgh+VKdtDD2sVlNUXMHOshgsNb1jYFYdSGMZvaS1N+DwsGo8QAF1sN1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=wozizhi@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=wozizhi@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6lM72J1cz2xGv
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 May 2025 19:58:41 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b6lM23X39zKHMpZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 May 2025 17:58:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E46A21A018D
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 May 2025 17:58:36 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgBXul5K3jZolIQONw--.43426S3;
	Wed, 28 May 2025 17:58:36 +0800 (CST)
Message-ID: <ee159a27-9006-4ec7-a6e9-9d9d1bdf3872@huaweicloud.com>
Date: Wed, 28 May 2025 17:58:34 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] cachefiles: Recovery concerns with on-demand loading
 after unexpected power loss
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Zizhi Wo <wozizhi@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, brauner@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, libaokun1@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, yukuai3@huawei.com
References: <20250528080759.105178-1-wozizhi@huaweicloud.com>
 <d0e08cbf-c6e4-4ecd-bcaf-40c426279c4f@linux.alibaba.com>
 <f177a0e4-c2da-40b7-9d47-8968f3c2bc50@huaweicloud.com>
 <4b8a0273-92a5-4f56-bafa-719e73828788@linux.alibaba.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <4b8a0273-92a5-4f56-bafa-719e73828788@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul5K3jZolIQONw--.43426S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1DJr45ZF4fWr17Ww17Jrb_yoW5Zw4DpF
	W5Wa4UKw4kJryftrnFvF4ruFWrtr93JrWUXrn8Wr48Ar1qyr1IqrWfKryYkFykurnrXay2
	va4jvr9rZw15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



在 2025/5/28 17:25, Gao Xiang 写道:
> 
> 
> On 2025/5/28 16:53, Zizhi Wo wrote:
>>
>>
>> 在 2025/5/28 16:35, Gao Xiang 写道:
>>> Hi Zizhi,
>>>
>>> On 2025/5/28 16:07, Zizhi Wo wrote:
>>>> Currently, in on-demand loading mode, cachefiles first calls
>>>> cachefiles_create_tmpfile() to generate a tmpfile, and only during 
>>>> the exit
>>>> process does it call 
>>>> cachefiles_commit_object->cachefiles_commit_tmpfile to
>>>> create the actual dentry and making it visible to users.
>>>>
>>>> If the cache write is interrupted unexpectedly (e.g., by system 
>>>> crash or
>>>> power loss), during the next startup process, 
>>>> cachefiles_look_up_object()
>>>> will determine that no corresponding dentry has been generated and will
>>>> recreate the tmpfile and pull the complete data again!
>>>>
>>>> The current implementation mechanism appears to provide per-file 
>>>> atomicity.
>>>> For scenarios involving large image files (where significant amount of
>>>> cache data needs to be written), this re-pulling process after an
>>>> interruption seems considerable overhead?
>>>>
>>>> In previous kernel versions, cache dentry were generated during the
>>>> LOOK_UP_OBJECT process of the object state machine. Even if power 
>>>> was lost
>>>> midway, the next startup process could continue pulling data based 
>>>> on the
>>>> previously downloaded cache data on disk.
>>>>
>>>> What would be the recommended way to handle this situation? Or am I
>>>> thinking about this incorrectly? Would appreciate any feedback and 
>>>> guidance
>>>> from the community.
>>>
>>> As you can see, EROFS fscache feature was marked as deprecated
>>> since per-content hooks already support the same use case.
>>>
>>> the EROFS fscache support will be removed after I make
>>> per-content hooks work in erofs-utils, which needs some time
>>> because currently I don't have enough time to work on the
>>> community stuff.
>>>
>>> Thanks,
>>> Gao Xiang
>>
>> Thanks for your reply.
>>
>> Indeed, the subsequent implementations have moved to using fanotify.
>> Moreover, based on evaluation, this approach could indeed lead to
>> performance improvements.
>>
>> However, in our current use case, we are still working with a kernel
>> version that only supports the fscache-based approach, so this issue
>> still exists for us. :(
> 
> Since it's deprecated (because that fscache improvement will
> take much long time to upstream and netfs dependency is
> redundant in addition to new pre-content hooks), could you
> improve it downstream directly?
> 
> Or if you have some simple proposal you could post, but no one
> avoids you to use fscache downstream but it seems pre-content
> hooks are more cleaner for this use case..
> 
> Thanks,
> Gao Xiang
> 

I understand. We'll have some internal discussions to explore possible
solutions. Our initial intention in bringing this up was also to hear if
the community has any suggestions or different perspectives on this
issue, which could help guide our future improvements (although fanotify 
is for future and fscache seems deprecated). For example, as you
mentioned fanotify — that was quite insightful.

Thanks,
Zizhi Wo

> 
>>
>> Thanks,
>> Zizhi Wo
>>
>>>
>>>>
>>>> Thanks,
>>>> Zizhi Wo
>>>
> 
> 


