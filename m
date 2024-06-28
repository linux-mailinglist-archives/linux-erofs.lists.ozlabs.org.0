Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE091BD93
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 13:37:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W9YMB4xRCz3cXR
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 21:37:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W9YM622t3z30fM
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 21:37:20 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9YLn2lGCz4f3kkD
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 19:37:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8BCD71A0572
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 19:37:12 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBXgHxjoH5mMEhDAg--.18518S3;
	Fri, 28 Jun 2024 19:37:10 +0800 (CST)
Message-ID: <3536f485-e496-4042-a231-c43a567cee7b@huaweicloud.com>
Date: Fri, 28 Jun 2024 19:37:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cachefiles: random bugfixes
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <ce6a7e15-5bea-413a-951e-b252319e1dfd@linux.alibaba.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ce6a7e15-5bea-413a-951e-b252319e1dfd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgBXgHxjoH5mMEhDAg--.18518S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDuF4UJrW5Aw4UCw1DGFg_yoW5CF4rpF
	Wakay5KFWkWry0kws2yr4xtF4Fy3yxXFnrGr1rWr1UC3s8XF1IyrZakw1Yvas5Cr4fGw4a
	vr4jvas3AryqyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvt
	AUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBV1jkIANfAAAsT
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
Cc: Christian Brauner <brauner@kernel.org>, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com, Baokun Li <libaokun@huaweicloud.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On 2024/6/28 15:39, Gao Xiang wrote:
> Hi Baokun,
>
> On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Hi all!
>>
>> This is the third version of this patch series, in which another 
>> patch set
>> is subsumed into this one to avoid confusing the two patch sets.
>> (https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)
>>
>> Thank you, Jia Zhu, Gao Xiang, Jeff Layton, for the feedback in the
>> previous version.
>>
>> We've been testing ondemand mode for cachefiles since January, and we're
>> almost done. We hit a lot of issues during the testing period, and this
>> patch series fixes some of the issues. The patches have passed internal
>> testing without regression.
>>
>> The following is a brief overview of the patches, see the patches for
>> more details.
>>
>> Patch 1-2: Add fscache_try_get_volume() helper function to avoid
>> fscache_volume use-after-free on cache withdrawal.
>>
>> Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
>> concurrency causing cachefiles_volume use-after-free.
>>
>> Patch 4: Propagate error codes returned by vfs_getxattr() to avoid
>> endless loops.
>>
>> Patch 5-7: A read request waiting for reopen could be closed maliciously
>> before the reopen worker is executing or waiting to be scheduled. So
>> ondemand_object_worker() may be called after the info and object and 
>> even
>> the cache have been freed and trigger use-after-free. So use
>> cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
>> reopen worker or wait for it to finish. Since it makes no sense to wait
>> for the daemon to complete the reopen request, to avoid this pointless
>> operation blocking cancel_work_sync(), Patch 1 avoids request generation
>> by the DROPPING state when the request has not been sent, and Patch 2
>> flushes the requests of the current object before cancel_work_sync().
>>
>> Patch 8: Cyclic allocation of msg_id to avoid msg_id reuse misleading
>> the daemon to cause hung.
>>
>> Patch 9: Hold xas_lock during polling to avoid dereferencing reqs 
>> causing
>> use-after-free. This issue was triggered frequently in our tests, and we
>> found that anolis 5.10 had fixed it. So to avoid failing the test, this
>> patch is pushed upstream as well.
>>
>> Comments and questions are, as always, welcome.
>> Please let me know what you think.
>
> Patch 4-9 looks good to me, and they are independent to patch 1-3
> so personally I guess they could go upstream in advance.

Thank you for your review!

Indeed, the first three patches have no dependencies on the later
ones, and the later ones can be merged in first.
>
> I hope the way to fix cachefiles in patch 1-4 could be also
> confirmed by David and Jeff since they relates the generic
> cachefiles logic anyway.
Yes, the first four patches modify the generic process for cachefiles,
and it would be great if David and Jeff could take a look at those.
The logic for patches 2 and 3 is a bit more complex, so the review
may take some time.

Cheers,
Baokun

