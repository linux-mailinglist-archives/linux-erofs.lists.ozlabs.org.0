Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64091B485
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 03:09:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W9HQh2mznz3fr1
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 11:09:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W9HQZ6gZJz3fnW
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 11:09:25 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9HQG5vqQz4f3jZ0
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 09:09:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F3B2C1A0170
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 09:09:17 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAnUn45DX5mgaIaAg--.2390S3;
	Fri, 28 Jun 2024 09:09:17 +0800 (CST)
Message-ID: <b68920cc-28ab-4e8b-994a-93f4148b4b8b@huaweicloud.com>
Date: Fri, 28 Jun 2024 09:09:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] cachefiles: flush all requests for the object that
 is being dropped
To: Christian Brauner <brauner@kernel.org>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-3-libaokun@huaweicloud.com>
 <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
 <e40b80fc-52b8-4f89-800a-3ffa0034a072@huaweicloud.com>
 <20240627-beizeiten-hecht-0efad69e0e38@brauner>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240627-beizeiten-hecht-0efad69e0e38@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAnUn45DX5mgaIaAg--.2390S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3Gr1rZr18AFy3XFyUAwb_yoW8KFyUpF
	Waya4akFW8ur17Crn2vF1YvrySy3s3ArnrXr1aqryjyrs0qrna9r1Iqr1DuF1DJrs3Gr4I
	qr4UWF93GryqyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvt
	AUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAHBV1jkHrAYQABs0
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
Cc: Baokun Li <libaokun@huaweicloud.com>, yangerkun@huawei.com, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/6/27 23:18, Christian Brauner wrote:
> On Thu, Jun 27, 2024 at 07:20:16PM GMT, Baokun Li wrote:
>> On 2024/6/27 19:01, Jeff Layton wrote:
>>> On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>
>>>> Because after an object is dropped, requests for that object are
>>>> useless,
>>>> flush them to avoid causing other problems.
>>>>
>>>> This prepares for the later addition of cancel_work_sync(). After the
>>>> reopen requests is generated, flush it to avoid cancel_work_sync()
>>>> blocking by waiting for daemon to complete the reopen requests.
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>> ---
>>>>    fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>>>> index 73da4d4eaa9b..d24bff43499b 100644
>>>> --- a/fs/cachefiles/ondemand.c
>>>> +++ b/fs/cachefiles/ondemand.c
>>>> @@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct
>>>> cachefiles_object *object)
>>>>    void cachefiles_ondemand_clean_object(struct cachefiles_object
>>>> *object)
>>>>    {
>>>> +	unsigned long index;
>>>> +	struct cachefiles_req *req;
>>>> +	struct cachefiles_cache *cache;
>>>> +
>>>>    	if (!object->ondemand)
>>>>    		return;
>>>>    	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>>>>    			cachefiles_ondemand_init_close_req, NULL);
>>>> +
>>>> +	if (!object->ondemand->ondemand_id)
>>>> +		return;
>>>> +
>>>> +	/* Flush all requests for the object that is being dropped.
>>>> */
>>> I wouldn't call this a "Flush". In the context of writeback, that
>>> usually means that we're writing out pages now in order to do something
>>> else. In this case, it looks like you're more canceling these requests
>>> since you're marking them with an error and declaring them complete.
>> Makes sense, I'll update 'flush' to 'cancel' in the comment and subject.
>>
>> I am not a native speaker of English, so some of the expressions may
>> not be accurate, thank you for correcting me.
> Can you please resend all patch series that we're supposed to take for
> this cycle, please?
Sure, I'm organising to combine the two patch series today and
send it out as v3.

-- 
With Best Regards,
Baokun Li

