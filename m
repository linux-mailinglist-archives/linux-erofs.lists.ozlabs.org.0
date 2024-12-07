Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EAE9E7EB1
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 08:26:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y506Z5QXWz2yjR
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 18:26:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733556372;
	cv=none; b=M382iy1JnDC5ukeGm0MFCtKi1seIGH+9jU6mO+eLdS6STZBF/RMTyOYdOZU4j6f0hSDc9ijkbgY2v5hWW/O0kGqNXcBdKYxG95pmajyK2f40Bs8DwD7ie8XjKrrmzCdYRN853s9If7d2xjD0zkABh1DDIKx2PoaEMAoA69PGLdcuCLAbjXhTpMvHhjc53jTWBPif4R1b/AmZAgd7Lv7kVc0OUAkE3wE3CO6v1+U6kGFd3Gzz0nYfjUL8phTHOLL33pkuDHvqBOceCNBu+T/Io8lHlfgwu4ioe6EvNfEwkB34ssbn3zgB/ryafbURGRPBSShT8FJzRzOuJaa5VkX/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733556372; c=relaxed/relaxed;
	bh=y+oO9bIIHn18zc5198NYDKQPj592/F4jQ6VWAm0ByBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YbQJySwxGx/73a13koN4BhKKtqqu7LoDcsQPncoyZeQOUD6T49RShOfnIaimF7DAsV1cA95icVLyLKvK4xC25wpnPNgKu+1nvM6GDoJsdOmdTto5wkjW0wUN9uOvgsr677lu5EYY5cd33asLKacXOTfZ7yt1G7zoyjuahKk4foB92mE2Rs5u54fuwkPLA0dcoX4wIo/xfzqBPG6bFY5T1EAHDQeh31FjbME8EhK6alRDJtqECl5+R1/D014enicUmymqXwBpHLepQve6Szw2mPOqBwLY01lyW6rDRXsKI/4VVG8OiqSEDz/o/EhHBCSWyG88vvp+ZLOjUAsoq9hdVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J/1mXCBG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J/1mXCBG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y506P1Ybxz2y66
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Dec 2024 18:25:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733556353; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y+oO9bIIHn18zc5198NYDKQPj592/F4jQ6VWAm0ByBY=;
	b=J/1mXCBGPH5W7SkcaBzBEsZW65wqmuD7JSMwbrWcMcMw7IYndzl1qiRH2M69LJbQjKE9509ZAmJfvSrMF/nX3WAYunfWCOhwurPhvwcrO0/zTknyqXxsqjdg+kpH1uCvG69IRpM4C/j5o7IQD0KZ89air1qn6Yed9ydBJxvKuYU=
Received: from 30.170.86.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKyt4iy_1733556345 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Dec 2024 15:25:50 +0800
Message-ID: <30178625-90b6-4b9d-8cb8-89e6e22ca588@linux.alibaba.com>
Date: Sat, 7 Dec 2024 15:25:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mounting 4k blocksize on e.g. 64k hosts
To: Ian Kent <raven@themaw.net>, linux-erofs@lists.ozlabs.org
References: <406ae215-0f60-4f19-9be9-122739682056@app.fastmail.com>
 <17b4f35e-a365-4460-b2a4-9da660ae3e95@linux.alibaba.com>
 <55ea18fb-7309-4328-a2f9-bebb5db61e87@app.fastmail.com>
 <99520f27-6080-43ae-9c60-cc30d3a8ff5f@linux.alibaba.com>
 <92d6b2fb-f06e-49ac-afe5-cccce5d75a92@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <92d6b2fb-f06e-49ac-afe5-cccce5d75a92@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Ian,

On 2024/12/7 09:09, Ian Kent wrote:
> On 7/12/24 04:21, Gao Xiang wrote:
>>
>>
>> On 2024/12/7 04:10, Colin Walters wrote:
>>> On Fri, Dec 6, 2024, at 2:46 PM, Gao Xiang wrote:
>>>
>>>> Did you try upstream kernels? It's already supported upstream
>>>> since Linux 6.4.
>>>
>>> Sorry, my bad. (It should have occurred to me to check, but this one popped back up on my radar when I'm trying to do several other things at the same time).
>>>
>>> Anyways looks like the fix specifically was https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 ?
>>
>> Yes, although it has been supported for nearly two
>> years, but there are still many dependencies
>> against RHEL 9 kernel (5.14) codebase.
>>
>>>
>>>> I think RHEL 9 is lacking of many features.
>>>
>>> Yes, but I'll try to argue for refresh for 9.6. Thanks!
>>> (Just tried to cherry pick that one myself, some conflicts but looks tractable)
>>
>> Actually, the PR below has been delayed for
>> months:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/4123
> 
> Indeed, yes.
> 
> 
> I deferred it because I thought back porting the idmap type changes that came after
> 
> 5.14 was more important and the above MR was conflicting with them.
> 
> That was a large change and was difficult to get merged but it's done now.

Thanks for the reply!

Yeah, I thought it seems to be delayed due to some
other high priority stuffs, but keep the codebase
in line with Linux v6.1 or v6.6 is helpful to
container use cases since I'm mainly working on
this area these years, such as:
  - large folios for better read performance;
  - subpage block support (>= 512-byte blocks);
  - FSDAX for page cache sharing into VMs;
  - advanced compression features;
  - and more.

> 
> 
>>
>> I think it's not quite easy to just cherry-pick
>> random commits due to twisted codebase cleanups,
>> rolling the codebase to upstream v6.4 is a good
>> choise for RHEL 9 long term maintainence.
> 
> Yes, cherry-picking commits is often hard to do and error prone.
> 
> 
> I can't remember now how far I went with the above MR but I'll review
> 
> that when I look at getting this into RHEL for Colin.
> 
> If I need help I'll certainly reach out here, thanks very much offering to help.

Thank you!

Thanks,
Gao Xiang

> 
> 
> Ian

