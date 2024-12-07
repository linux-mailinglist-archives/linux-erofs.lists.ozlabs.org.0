Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD09E8035
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 14:54:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y58kF6njsz2yXm
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Dec 2024 00:54:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2403:5800:3:25::1001"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733579651;
	cv=none; b=Or5Qcm8RsDu/cS3neiUTs8d733uDLf09XdsFtS0/567VLMJoQAflQl8IdX3XktRl/pbXPv5qQ95OCiNnTbRFNVX9m82qw97axbN3HFjIxvucZLDe4DUKYmSIaogip5yDa/tE8CvI8zeVWnW8m86fz5oHarkX76nyu1OSrzHe3BZUCRH49huESamTlhJT1y9W7jnC4ySvrCAP0IhkBn6IWPtzt+mpUkAKPHlm/MtI0CunxgEC+Yd8+o5WvLi9yonaA9rjgFLkbkk0aOa7E77v3JfztlXWkUs4qKYUS55RP4duPMFmvMHP7e/PAwW4Eq8BraIiDrKmzPDpAR+Fbw/iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733579651; c=relaxed/relaxed;
	bh=HbFTD/gg+5bHK/t/f8ItTe6iEX6tQVED0efpXLCiStM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=daEJawooNCIQntdq2MTg4/v67SFZf01SSud6Jd76HYpQ+Wus8O8+j8KpySHnFZsh+Bhaqiw29j4H/lSmn2e5hmFPMbGIefAtX3+NFc13KLRsugDM3ftmogLpGIeCzswLe536cJJsfhvkLuvLjKKkXv6t63OkTDB2mtgcef34FJN7ZkNR/4YQgI8pC4a9v0m4Z3bgdP6wznf1nbPU4IhXxaGmGeEGairVCSQDJKCMA5/qZWUFwJEcKNA6RDqPkWFGgrMQKAWURGPa3VqQnrcmgDb6XdpGLdd2b21VkCK/FJnwPztWzVsX8sxYp3C2aX+69/Oam1oIipVUPRHWo5VGbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=neutral (client-ip=2403:5800:3:25::1001; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org) smtp.mailfrom=themaw.net
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: lists.ozlabs.org; spf=neutral (access neither permitted nor denied) smtp.mailfrom=themaw.net (client-ip=2403:5800:3:25::1001; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 45874 seconds by postgrey-1.37 at boromir; Sun, 08 Dec 2024 00:54:09 AEDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y58k95Vcrz2xpl
	for <linux-erofs@lists.ozlabs.org>; Sun,  8 Dec 2024 00:54:09 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 76F6410078B
	for <linux-erofs@lists.ozlabs.org>; Sun,  8 Dec 2024 00:54:02 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Um_FbYGveDxc for <linux-erofs@lists.ozlabs.org>;
	Sun,  8 Dec 2024 00:54:02 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 6416F100840; Sun,  8 Dec 2024 00:54:02 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=5.0 tests=SPF_HELO_NONE,SPF_NEUTRAL
	autolearn=disabled version=4.0.0
Received: from [192.168.1.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 3AA7C1006CA;
	Sun,  8 Dec 2024 00:54:00 +1100 (AEDT)
Message-ID: <ab9af47e-1d5f-4701-bf3e-76a27d6597d6@themaw.net>
Date: Sat, 7 Dec 2024 21:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mounting 4k blocksize on e.g. 64k hosts
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <406ae215-0f60-4f19-9be9-122739682056@app.fastmail.com>
 <17b4f35e-a365-4460-b2a4-9da660ae3e95@linux.alibaba.com>
 <55ea18fb-7309-4328-a2f9-bebb5db61e87@app.fastmail.com>
 <99520f27-6080-43ae-9c60-cc30d3a8ff5f@linux.alibaba.com>
 <92d6b2fb-f06e-49ac-afe5-cccce5d75a92@themaw.net>
 <30178625-90b6-4b9d-8cb8-89e6e22ca588@linux.alibaba.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <30178625-90b6-4b9d-8cb8-89e6e22ca588@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 7/12/24 15:25, Gao Xiang wrote:
> Hi Ian,
>
> On 2024/12/7 09:09, Ian Kent wrote:
>> On 7/12/24 04:21, Gao Xiang wrote:
>>>
>>>
>>> On 2024/12/7 04:10, Colin Walters wrote:
>>>> On Fri, Dec 6, 2024, at 2:46 PM, Gao Xiang wrote:
>>>>
>>>>> Did you try upstream kernels? It's already supported upstream
>>>>> since Linux 6.4.
>>>>
>>>> Sorry, my bad. (It should have occurred to me to check, but this 
>>>> one popped back up on my radar when I'm trying to do several other 
>>>> things at the same time).
>>>>
>>>> Anyways looks like the fix specifically was 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 
>>>> ?
>>>
>>> Yes, although it has been supported for nearly two
>>> years, but there are still many dependencies
>>> against RHEL 9 kernel (5.14) codebase.
>>>
>>>>
>>>>> I think RHEL 9 is lacking of many features.
>>>>
>>>> Yes, but I'll try to argue for refresh for 9.6. Thanks!
>>>> (Just tried to cherry pick that one myself, some conflicts but 
>>>> looks tractable)
>>>
>>> Actually, the PR below has been delayed for
>>> months:
>>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/4123 
>>>
>>
>> Indeed, yes.
>>
>>
>> I deferred it because I thought back porting the idmap type changes 
>> that came after
>>
>> 5.14 was more important and the above MR was conflicting with them.
>>
>> That was a large change and was difficult to get merged but it's done 
>> now.
>
> Thanks for the reply!
>
> Yeah, I thought it seems to be delayed due to some
> other high priority stuffs, but keep the codebase
> in line with Linux v6.1 or v6.6 is helpful to
> container use cases since I'm mainly working on
> this area these years, such as:
>  - large folios for better read performance;
>  - subpage block support (>= 512-byte blocks);
>  - FSDAX for page cache sharing into VMs;
>  - advanced compression features;
>  - and more.

I understand but right now I just want to get that original merge 
request merged.


Although, now I'm back to it, and we have a request for something 
specific, it may

go further than 5.19. Equally, back porting feature requests will be 
much more straight

forward with our RHEL-9 erofs at 5.19 as a basis. We'll need to wait and 
see what time

we have available and what the magnitude of the changes are for the 
request. Whether

we have tests available for user space and kernel space is a factor as 
well because

everything we support needs QE test coverage if at all possible.


We also need to focus on the fact that RHEL-10 is in need of work on 
erofs and is a

priority atm. I need to spend time there too.


And I should add I have been trying to find time to get an autofs 
release out that needs

to be back ported to both RHEL-9 and RHEL-10 (and I'm running out of 
time!) and a tricky

kernel fix to the autofs module as well, and that's not all I have going on.


Point being, please understand it's not as simple as just doing a back 
port, there is due

process to follow which also takes time.


Ian

