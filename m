Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD98B0677
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 11:52:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SH2HN8Yk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPZ6d0pWPz3cSX
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 19:52:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SH2HN8Yk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPZ6W4nF3z3cLL
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 19:52:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713952366; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WGyed6Jl+uflHuW20bMk/Ol+7UgCzkYj9PTNwaVEpdE=;
	b=SH2HN8YktTw6tF3NteiV95UfETXnAo99XxH7t9ybKeB2k3uTvvC32ko+nKGGhInejm6Dkm40uVtwJ//OVJbwB6YI4ByrzL0W/3p6eDXb7IDvL8Llhk2AytH2aZYMJJOlIK/F0or7BICGgF4jXCTkISxa0Pb1OkyAxOmFTECvJnI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W5C2HpV_1713952362;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5C2HpV_1713952362)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 17:52:44 +0800
Message-ID: <1f99cab9-d7bf-4263-94f9-9d1b886449fe@linux.alibaba.com>
Date: Wed, 24 Apr 2024 17:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trying to work with the tests
To: Ian Kent <raven@themaw.net>, linux-erofs@lists.ozlabs.org,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20d564ff-bc61-42ef-ada2-2c2433f362fa@themaw.net>
 <e81eda7a-5bc8-49dd-ab68-029f7ecab0b5@linux.alibaba.com>
 <4ea8c79f-93c1-410c-9580-8f37e84f8548@themaw.net>
 <10812685-acd5-4c43-abfb-79cf82615396@linux.alibaba.com>
 <e9c8a1be-b931-4528-a805-84a34aad5eae@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <e9c8a1be-b931-4528-a805-84a34aad5eae@themaw.net>
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



On 2024/4/24 17:47, Ian Kent wrote:
> On 23/4/24 18:34, Gao Xiang wrote:
>> Hi Ian,
>>
>> On 2024/4/22 21:10, Ian Kent wrote:
>>> On 22/4/24 17:12, Gao Xiang wrote:
>>>> Hi Ian,
>>>>
>>>> (+Cc Jingbo here).
>>>>
>>>> On 2024/4/22 16:31, Ian Kent wrote:
>>>>> I'm new to the list so Hi to all,
>>>>>
>>>>>
>>>>> I'm working with a heavily patched 5.14 kernel and I've gathered together patches to bring erofs
>>>>>
>>>>> up to 5.19 and I'm trying to run the erofs and fscache tests from a checkout of the 1.7.1 repo.
>>>>>
>>>>> (branch experimental-tests-fscache) and I have a couple of fails I can't quite work out so I'm
>>>>>
>>>>> hoping for a little halp.
>>>>
>>>> Thanks for your interest and provide the detailed infos.
>>>>
>>>> I guess a modified 5.14 kernel may be originated from RHEL 9?
>>>
>>> Yes, that's right.
>>>
>>> I am working on improving erofs support in RHEL which of course goes via CentOS Stream 9.
>>
>> BTW, could you submit the current patches to CentOS stream 9 mainline?
>> so I could review as well.
> 
> CentOS Stream is meant to allow our development to be public so, yes, I would like to do that.
> 
> 
> It will be interesting to see how it works, I'll have a look around the CentOS web site to see if I can work
> 
> out how it looks to external people.
> 
> 
> Timing is good too as I'm about to construct a merge request and our process requires that to be against
> 
> the CentOS Stream repo.
> 
> 
> That repository is located on GitLab ... so we'll need to work out how to go about that.

Yeah, so I could apply the pull request and play on my local
development machice.


> 
> 
>>
>>>
>>>
>>>>
>>>> I have a plan to backport the latest EROFS to CentOS stream 9, but
>>>> currently I'm busy in internal stuffs, so it's still a bit delayed...
>>>
>>> Right, Eric mentioned you were keen to help out.
>>>
>>>
>>> The full back port is a bit much to do in one step, I'd like to let it settle for a minor release before considering
>>>
>>> further back port effort. Of course any assistance is also welcome if and when you have time.
>>
>> Yeah, since you've already picked to Linux 5.19.  So I think I could
>> also give a try if these commits are available on gitlab...
>>
>> I think I can help nail down the issue (fscache/005) too.
> 
> Right, there are only a couple of problems with the tests so I've decided to go ahead with the merge request and
> 
> work the test problems out those out as I go.

Yes, that is more effective to the problem on my side :-)

Thanks,
Gao Xiang

> 
> 
> Ian
