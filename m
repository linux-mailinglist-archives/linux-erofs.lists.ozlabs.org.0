Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B469B8AE245
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Apr 2024 12:34:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iJX7eYCq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNz5Y2p8Cz3dKp
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Apr 2024 20:34:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iJX7eYCq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNz5N4yRcz3dJ5
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Apr 2024 20:34:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713868482; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9+RaeoXs68pCj0RPnG+tuMjuu2VLcBzNQYYx1xYTlQ8=;
	b=iJX7eYCqDtymdnSZDn+WVFIvWo1vkxEispSI8miXN23u3SEqPiOzL9V4cTQpoF/0CoeJ6Ec8YJyeBFNdADdHj+VOBszRTkYMpLKsxVQsq4+A1uBCyvf041MjwhpOnvt+EoGjiytUlYtxJ0gvWQ1y6/oO80fkzOIATNxOyO6wM8A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W58n4VS_1713868479;
Received: from 30.97.48.197(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W58n4VS_1713868479)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 18:34:40 +0800
Message-ID: <10812685-acd5-4c43-abfb-79cf82615396@linux.alibaba.com>
Date: Tue, 23 Apr 2024 18:34:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trying to work with the tests
To: Ian Kent <raven@themaw.net>, linux-erofs@lists.ozlabs.org,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20d564ff-bc61-42ef-ada2-2c2433f362fa@themaw.net>
 <e81eda7a-5bc8-49dd-ab68-029f7ecab0b5@linux.alibaba.com>
 <4ea8c79f-93c1-410c-9580-8f37e84f8548@themaw.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4ea8c79f-93c1-410c-9580-8f37e84f8548@themaw.net>
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

Hi Ian,

On 2024/4/22 21:10, Ian Kent wrote:
> On 22/4/24 17:12, Gao Xiang wrote:
>> Hi Ian,
>>
>> (+Cc Jingbo here).
>>
>> On 2024/4/22 16:31, Ian Kent wrote:
>>> I'm new to the list so Hi to all,
>>>
>>>
>>> I'm working with a heavily patched 5.14 kernel and I've gathered together patches to bring erofs
>>>
>>> up to 5.19 and I'm trying to run the erofs and fscache tests from a checkout of the 1.7.1 repo.
>>>
>>> (branch experimental-tests-fscache) and I have a couple of fails I can't quite work out so I'm
>>>
>>> hoping for a little halp.
>>
>> Thanks for your interest and provide the detailed infos.
>>
>> I guess a modified 5.14 kernel may be originated from RHEL 9?
> 
> Yes, that's right.
> 
> I am working on improving erofs support in RHEL which of course goes via CentOS Stream 9.

BTW, could you submit the current patches to CentOS stream 9 mainline?
so I could review as well.

> 
> 
>>
>> I have a plan to backport the latest EROFS to CentOS stream 9, but
>> currently I'm busy in internal stuffs, so it's still a bit delayed...
> 
> Right, Eric mentioned you were keen to help out.
> 
> 
> The full back port is a bit much to do in one step, I'd like to let it settle for a minor release before considering
> 
> further back port effort. Of course any assistance is also welcome if and when you have time.

Yeah, since you've already picked to Linux 5.19.  So I think I could
also give a try if these commits are available on gitlab...

I think I can help nail down the issue (fscache/005) too.

Thanks,
Gao Xiang
