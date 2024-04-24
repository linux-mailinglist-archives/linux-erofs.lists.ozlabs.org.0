Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F88B0E7F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 17:36:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZH4v4dpp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPjkc4cHtz3cYg
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 01:36:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZH4v4dpp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPjkS5RNBz3cQf
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 01:35:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713972952; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P8o8uPcfAaVkbiupYWC3Ab55bxqVNiyML+Yfz71jYlU=;
	b=ZH4v4dpp9Tu2rqCG54Xl6eRQZ7JvVos1YWGnyOaHZRpR3KwtIaUbhdgXUBaBk7f5tpGP6y8v8bw4b6o1Ju5RiGwIKHLQahR0jLnE2RqrscHWQuAUOJkqjm3B7jtye9MSTbnoLxjqP+gsuP7IS3RGpykvAacKg2TVCiUAMqV0+RY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W5Cf2gk_1713972949;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5Cf2gk_1713972949)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 23:35:50 +0800
Message-ID: <d1956835-a3b2-4e60-a0e7-3c0413bbcb7c@linux.alibaba.com>
Date: Wed, 24 Apr 2024 23:35:49 +0800
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
 <aca97115-f26f-4970-be4c-c84db4d11e15@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aca97115-f26f-4970-be4c-c84db4d11e15@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2024/4/24 18:37, Ian Kent wrote:
> On 24/4/24 17:47, Ian Kent wrote:
>> On 23/4/24 18:34, Gao Xiang wrote:
>>> Hi Ian,
>>>
>>> On 2024/4/22 21:10, Ian Kent wrote:
>>>> On 22/4/24 17:12, Gao Xiang wrote:
>>>>> Hi Ian,
>>>>>
>>>>> (+Cc Jingbo here).
>>>>>
>>>>> On 2024/4/22 16:31, Ian Kent wrote:
>>>>>> I'm new to the list so Hi to all,
>>>>>>
>>>>>>
>>>>>> I'm working with a heavily patched 5.14 kernel and I've gathered together patches to bring erofs
>>>>>>
>>>>>> up to 5.19 and I'm trying to run the erofs and fscache tests from a checkout of the 1.7.1 repo.
>>>>>>
>>>>>> (branch experimental-tests-fscache) and I have a couple of fails I can't quite work out so I'm
>>>>>>
>>>>>> hoping for a little halp.
>>>>>
>>>>> Thanks for your interest and provide the detailed infos.
>>>>>
>>>>> I guess a modified 5.14 kernel may be originated from RHEL 9?
>>>>
>>>> Yes, that's right.
>>>>
>>>> I am working on improving erofs support in RHEL which of course goes via CentOS Stream 9.
>>>
>>> BTW, could you submit the current patches to CentOS stream 9 mainline?
>>> so I could review as well.
>>
>> CentOS Stream is meant to allow our development to be public so, yes, I would like to do that.
>>
>>
>> It will be interesting to see how it works, I'll have a look around the CentOS web site to see if I can work
>>
>> out how it looks to external people.
>>
>>
>> Timing is good too as I'm about to construct a merge request and our process requires that to be against
>>
>> the CentOS Stream repo.
>>
>>
>> That repository is located on GitLab ... so we'll need to work out how to go about that.
> 
> Looking at the CentOS web page at https://docs.centos.org/en-US/stream-contrib/quickstart/
> 
> you would need a GitLab account to take part in the merge request review process.

Yes, I have a gitlab account.

> 
> 
> If you wanted to take part in the case discussion as well you would need a Red Hat Issues
> 
> account (sign up https://issues.redhat.com/). This is only needed if you want to take part
> 
> in development/log bug reports, etc. since a Jira bug is required for each merge request.

I guess I don't need a Red Hat Issues account, since I could comment in the PR itself.

> 
> 
> As the Mandalorian would say, "this is the way".
> 
> 
> If you don't wish to do this then I can post elsewhere, perhaps a kernel.org repo. but it gets
> 
> a bit harder if we work outside of the development process.

Nope, gitlab repo is fine, and I already participated in CentOS
Stream 9 repo before.

Thanks,
Gao Xiang

> 
> 
> Ian
> 
