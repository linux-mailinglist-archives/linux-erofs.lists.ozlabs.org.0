Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AED9E8901
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Dec 2024 02:39:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y64KF0CFgz2yXd
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Dec 2024 12:39:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733708350;
	cv=none; b=eFQlU/LcSQX1l2ShI2ETP0HvTfWlL3n2nYjgGeN9/NYXKRZKfhjjCMgZGoMnVLi2sI24gumWiPwEUnkIMGSHVqZqEmpW8Q1a7JqtsHBM96bDDw20Lz3l+Sm2nhDJcPEmnK0GKNHvZOSJtYRbYtvsBQV5PyaiMa2nonFIvFDL6BCudZg7JIqHL39ayYfDaftSgRqjUbDYWlVs8P8sU0RC+r633wZEkkIv6PJ2/M6fujn2MJp7sC4MOZf+mB8/uFYJzGvEbgj9PMOuS/WSxMo8bZrPFqUarjXjZ0zg3GeykpmUT+Gh4NzznRFCIXxuP/us4SxybR2ql6l/Wl325/oPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733708350; c=relaxed/relaxed;
	bh=rmeNiofwBTRxNhP/fgR8f1+0cuEg4UfOMMHUhnZ1Z5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HWIjGyKBCZbKWmkqLrPLq7BbzYdUH6UfVgTIXgbuv/14/LlU1UZxze8gBw7k1LUYL5Kxq8ugkOhkdU+bz27usqZdU2py2iGi7UuovihORL4DVTyLMw4fIWLooAKbvHDbnERm5KdSk9a2uaDT9wsk28vt823NqYoOEF65d0+N5rT+ydcCZY0Ctn+TN1sG3ekV5KiteZOsb1Lqf7kGDu5r1tmkBzBWZbciQjE1RvBH2heppuniANOlBbUqV6Be968Sc0F09Y3aw6iQk5NaVcuIL+A3DHSFbo/r9Q5ExM+n+kHXLyOBdCbs19RjjTM0dgeqZ2ylooEqXBIGg0WKQyELxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RNpHmeFn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RNpHmeFn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y64K61Hdxz2xGF
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Dec 2024 12:39:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733708335; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rmeNiofwBTRxNhP/fgR8f1+0cuEg4UfOMMHUhnZ1Z5M=;
	b=RNpHmeFnNOD0Smfx8Yy/dIQu1ZCEWxcXNTMdNd1zd5B0vBBHQuif4ywJFyN1AaF/oAmOJfkaW1dktofTvcd+xkREMhQyPNY2pipRei3YFUUVRB9b6cnE2IYZSo7pAY62xU/Web1s3St+KFUmZWwbNSDW5EpDM6r1xcaqMKGcfTQ=
Received: from 30.221.130.234(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WL1X2bV_1733708333 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 09:38:54 +0800
Message-ID: <862cc7e1-44b9-4296-8b55-6b528814b7bb@linux.alibaba.com>
Date: Mon, 9 Dec 2024 09:38:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mounting 4k blocksize on e.g. 64k hosts
To: Ian Kent <raven@themaw.net>, linux-erofs@lists.ozlabs.org
References: <406ae215-0f60-4f19-9be9-122739682056@app.fastmail.com>
 <17b4f35e-a365-4460-b2a4-9da660ae3e95@linux.alibaba.com>
 <55ea18fb-7309-4328-a2f9-bebb5db61e87@app.fastmail.com>
 <99520f27-6080-43ae-9c60-cc30d3a8ff5f@linux.alibaba.com>
 <92d6b2fb-f06e-49ac-afe5-cccce5d75a92@themaw.net>
 <30178625-90b6-4b9d-8cb8-89e6e22ca588@linux.alibaba.com>
 <ab9af47e-1d5f-4701-bf3e-76a27d6597d6@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ab9af47e-1d5f-4701-bf3e-76a27d6597d6@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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



On 2024/12/7 21:53, Ian Kent wrote:
> On 7/12/24 15:25, Gao Xiang wrote:
>> Hi Ian,
>>
>> On 2024/12/7 09:09, Ian Kent wrote:
>>> On 7/12/24 04:21, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2024/12/7 04:10, Colin Walters wrote:
>>>>> On Fri, Dec 6, 2024, at 2:46 PM, Gao Xiang wrote:
>>>>>
>>>>>> Did you try upstream kernels? It's already supported upstream
>>>>>> since Linux 6.4.
>>>>>
>>>>> Sorry, my bad. (It should have occurred to me to check, but this one popped back up on my radar when I'm trying to do several other things at the same time).
>>>>>
>>>>> Anyways looks like the fix specifically was https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 ?
>>>>
>>>> Yes, although it has been supported for nearly two
>>>> years, but there are still many dependencies
>>>> against RHEL 9 kernel (5.14) codebase.
>>>>
>>>>>
>>>>>> I think RHEL 9 is lacking of many features.
>>>>>
>>>>> Yes, but I'll try to argue for refresh for 9.6. Thanks!
>>>>> (Just tried to cherry pick that one myself, some conflicts but looks tractable)
>>>>
>>>> Actually, the PR below has been delayed for
>>>> months:
>>>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/4123
>>>
>>> Indeed, yes.
>>>
>>>
>>> I deferred it because I thought back porting the idmap type changes that came after
>>>
>>> 5.14 was more important and the above MR was conflicting with them.
>>>
>>> That was a large change and was difficult to get merged but it's done now.
>>
>> Thanks for the reply!
>>
>> Yeah, I thought it seems to be delayed due to some
>> other high priority stuffs, but keep the codebase
>> in line with Linux v6.1 or v6.6 is helpful to
>> container use cases since I'm mainly working on
>> this area these years, such as:
>>  - large folios for better read performance;
>>  - subpage block support (>= 512-byte blocks);
>>  - FSDAX for page cache sharing into VMs;
>>  - advanced compression features;
>>  - and more.
> 
> I understand but right now I just want to get that original merge request merged.
> 
> 
> Although, now I'm back to it, and we have a request for something specific, it may
> 
> go further than 5.19. Equally, back porting feature requests will be much more straight
> 
> forward with our RHEL-9 erofs at 5.19 as a basis. We'll need to wait and see what time
> 
> we have available and what the magnitude of the changes are for the request. Whether
> 
> we have tests available for user space and kernel space is a factor as well because
> 
> everything we support needs QE test coverage if at all possible.

Totally understood, and I also agree it'd better to backport to
5.19 as a basis first.

> 
> 
> We also need to focus on the fact that RHEL-10 is in need of work on erofs and is a
> 
> priority atm. I need to spend time there too.
> 
> 
> And I should add I have been trying to find time to get an autofs release out that needs
> 
> to be back ported to both RHEL-9 and RHEL-10 (and I'm running out of time!) and a tricky
> 
> kernel fix to the autofs module as well, and that's not all I have going on.
> 
> 
> Point being, please understand it's not as simple as just doing a back port, there is due
> 
> process to follow which also takes time.

Yeah.

Thanks,
Gao Xiang

> 
> 
> Ian

