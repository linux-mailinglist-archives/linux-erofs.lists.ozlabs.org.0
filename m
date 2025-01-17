Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCADA14D08
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 11:08:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFn64wXkz3cmW
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 21:08:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737108521;
	cv=none; b=gZUYjtxJ3JCMzBS6or4bExgM6Y8xEW/+f2orgb7FwvCKNK5T8kfQBCaX7HervZvHaPEaQApuYqhra7AmBXIAKEdvP69DLvmYFzvi1qmnwKXAzOXI2yVCX2qtFhUPt+tgzB4KgI9YrwBp53nEqnMXPWv7G5OTuku00GT+deXbGGcYgqZSA2URp0dVvkq3JJHtnWuMo8axhmIdRgrMg0eE47iwiowfcUBnYwHH5bxpnrkDAgm6woOCLrKwlNF54pODgiEDlytn3nNAvFISqKRG/nMK7xnVrQoCChsWJlOxbXr/tmLbX1vDP/JWZ0JgsIBdX7eIxsH1ym5mG6uC0eXl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737108521; c=relaxed/relaxed;
	bh=e3EHTj+CPpNUPdTU5v9K5KYvPWG8yi1EwhqmuizUdC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYhbBsNY/sZEM3oHhWvAqc/Wpg6DntDmZ+KcQ9rnQtRU0zntZJVux/5LMnXXTvP9jOVYA+0iNgIGPdS70aNQuxLicBPbmjko4oINxee92Z0Pf8VDnkUxk8OtL5UeP+4X2MtK76C8NHswQonZwkUwpO7zA1gT4QouPqIbVZlDqyrevcNChrCx2hKTjJRlgmPSl9r+CfpRrPmZ6Q3P5GIDZmX6bc738SSP815ugFIaU+PDNAPixqHmX0joMJHe9+FQ4M9/mZcYKY5aVDA52GVuwjHd79EAkE0yOGl0wbENj+1fJMAhW9fMLyq1mcLOssyvShxY87UORo/MMxhan0/B0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LBzZiPEi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LBzZiPEi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFn32fNGz302b
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 21:08:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737108514; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e3EHTj+CPpNUPdTU5v9K5KYvPWG8yi1EwhqmuizUdC4=;
	b=LBzZiPEidR8PCZ/JhvFpISg2VQ0ZDazPuyF+AWSmpCQbjR2ihskImMo60myjavQmyMSTuM6guFvaNdooWcewMTY6LuRWYmApmlGkfID5OqhtFxJeoAOW8Gimpl907ICQByakc4lLjmo04uZ/Dvzz+BLYDfFP/KaDr+EzW4hQCi8=
Received: from 30.41.10.74(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNoTYjm_1737108505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 18:08:32 +0800
Message-ID: <2ac05d5d-1e9d-448e-99e8-64ebefdc8c55@linux.alibaba.com>
Date: Fri, 17 Jan 2025 18:08:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
 <649afa9b-5724-4b52-8b9b-9a82a3c1468b@linux.alibaba.com>
 <640C401CAB291F86+ffb78b4f37e75faf2b4730e625b8d72d15be782a.camel@uniontech.com>
 <58cadb57-22ce-4818-af2b-9ae452c38f27@linux.alibaba.com>
 <F2BFB040EAD9A1F5+3902f0717d54a9990ffe8f042997c8586044d229.camel@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <F2BFB040EAD9A1F5+3902f0717d54a9990ffe8f042997c8586044d229.camel@uniontech.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/17 18:00, Chen Linxuan wrote:
> On Fri, 2025-01-17 at 17:54 +0800, Gao Xiang wrote:
>>
>> On 2025/1/17 17:50, Chen Linxuan wrote:
>>> On Fri, 2025-01-17 at 17:28 +0800, Gao Xiang wrote:
>>>> Hi Linxuan,
>>>>
>>>> On 2025/1/17 16:52, Chen Linxuan wrote:
>>>>> While reading erofs code, I notice that `erofs_fc_parse_param` will
>>>>> return -ENOPARAM, which means that erofs do not support this option,
>>>>> without report anything when `fs_parse` return an unknown `opt`.
>>>>>
>>>>> But if an option is unknown to erofs, I mean that option not in
>>>>> `erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
>>>>> which means that `erofs_fs_parameters` should has returned earlier.
>>>>>
>>>>> Entering `default` means `fs_parse` return something we unexpected.
>>>>> I am not sure about it but I think we should return -EINVAL here,
>>>>> just like `xfs_fs_parse_param`.
>>>>>
>>>>> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
>>>>
>>>> I think the default branch is actually deadcode here, see
>>>> erofs_fc_parse_param() -> fs_parse() -> fs_lookup_key() -> -ENOPARAM
>>>>
>>>> then vfs_parse_fs_param() will show "Unknown parameter".
>>>>
>>>> Maybe we could just kill `default:` branch...
>>>
>>> ext4 do not have a `default:` branch, but xfs return -EINVAL.
>>>
>>> I think `default:` branch can report error when `fs_parse` or
>>> `erofs_fs_parameters` goes wrong.
>>
>> How can it go wrong?
> 
> What if we forget to update the switch branch for a new option?

Then it's clearly a bug (we don't even handle the new option),
I think we shouldn't consider it as a normal case.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
>>
>>

