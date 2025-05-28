Return-Path: <linux-erofs+bounces-373-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2537EAC65D6
	for <lists+linux-erofs@lfdr.de>; Wed, 28 May 2025 11:25:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6kct5gSDz2xGv;
	Wed, 28 May 2025 19:25:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748424334;
	cv=none; b=NkDNca1RLVqThnT84718Ia2WUOtx1Zl1GBelSFfserwdmR90cyZkly+KbkSmAzvXu2yf6Me55OyXbzLA69F4UQbTRU01t5sZ2qPCqlohF3fCXs9jXUml5G8h6nPMVm1d/6ttWJGb5vLuiycuHQAeJfjpMpcW/RHNuVXsqwrfGlofnA1zdjCmDSi+ssvVbNaorwSlFwVEsg94xeQ8Vid8ASftxoqwRmoz8p92jDwZeUJFHjFeWNySnkkCP8YbaJv15co04CrvQRzKwtlOPm/EFO8LpE9kM1/QDiTRzWY0zInKCKbhEkBBSiCXw9ZOXttwEMnJsR6SJPTC83ah5K07bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748424334; c=relaxed/relaxed;
	bh=RqprY+g1l59D1pr1yuCrzP+m/b/mIv1Qp17gecL4d0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Flcp0JaCaFxImkBhVwFK1h/twhzvHHJSwCR4QgqZaMIQTvUk6dNy5wAaG0D11u6NJ4gvz7g7XQNNoSLlQXZF6jPlHF0AFj4a6qo3uAiC9eI2Nu8wXfXQNI7C4Z+7oyNAvYCwtTHBP/zs4EOBn6Sa9/633kVhWlFJ3PVkDg/NG8UXt7KZjLbi21epykCwdkeakUeTJSzlZ2B4sfOJfPOhoXz2LWlzK/HyNe8mlGeSQyfBYMYZCKv6yRYXHh1CZtgCdPG49FMwG/f+YWhre74ox0pyfpjdwx5Vv9wB7QcAo6pR5G+0ArWV3OGwTibNr8wuMfSHtGoIdREmFdOlfkPfQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WDwugLW+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WDwugLW+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6kcr2DYRz2xGF
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 May 2025 19:25:30 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748424327; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RqprY+g1l59D1pr1yuCrzP+m/b/mIv1Qp17gecL4d0w=;
	b=WDwugLW+2WhPggwpJhvbxvBZ3SdHKOWOWikY3sOGQksUAVJzHeTDtkSsipeC3cKP8lYgvfOLHHBzzZdPAFDcFVGEEqzS/rofLtbbs6ebv3PRGais+mtNCUXysBZRh0vJ5XP3dUhGlsN2J+8x/ctNQtj+jQEQTjOnvFGRX5vMXkI=
Received: from 30.221.130.248(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WcCsI6O_1748424324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 May 2025 17:25:25 +0800
Message-ID: <4b8a0273-92a5-4f56-bafa-719e73828788@linux.alibaba.com>
Date: Wed, 28 May 2025 17:25:24 +0800
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
To: Zizhi Wo <wozizhi@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, brauner@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, libaokun1@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, yukuai3@huawei.com
References: <20250528080759.105178-1-wozizhi@huaweicloud.com>
 <d0e08cbf-c6e4-4ecd-bcaf-40c426279c4f@linux.alibaba.com>
 <f177a0e4-c2da-40b7-9d47-8968f3c2bc50@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <f177a0e4-c2da-40b7-9d47-8968f3c2bc50@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/28 16:53, Zizhi Wo wrote:
> 
> 
> 在 2025/5/28 16:35, Gao Xiang 写道:
>> Hi Zizhi,
>>
>> On 2025/5/28 16:07, Zizhi Wo wrote:
>>> Currently, in on-demand loading mode, cachefiles first calls
>>> cachefiles_create_tmpfile() to generate a tmpfile, and only during the exit
>>> process does it call cachefiles_commit_object->cachefiles_commit_tmpfile to
>>> create the actual dentry and making it visible to users.
>>>
>>> If the cache write is interrupted unexpectedly (e.g., by system crash or
>>> power loss), during the next startup process, cachefiles_look_up_object()
>>> will determine that no corresponding dentry has been generated and will
>>> recreate the tmpfile and pull the complete data again!
>>>
>>> The current implementation mechanism appears to provide per-file atomicity.
>>> For scenarios involving large image files (where significant amount of
>>> cache data needs to be written), this re-pulling process after an
>>> interruption seems considerable overhead?
>>>
>>> In previous kernel versions, cache dentry were generated during the
>>> LOOK_UP_OBJECT process of the object state machine. Even if power was lost
>>> midway, the next startup process could continue pulling data based on the
>>> previously downloaded cache data on disk.
>>>
>>> What would be the recommended way to handle this situation? Or am I
>>> thinking about this incorrectly? Would appreciate any feedback and guidance
>>> from the community.
>>
>> As you can see, EROFS fscache feature was marked as deprecated
>> since per-content hooks already support the same use case.
>>
>> the EROFS fscache support will be removed after I make
>> per-content hooks work in erofs-utils, which needs some time
>> because currently I don't have enough time to work on the
>> community stuff.
>>
>> Thanks,
>> Gao Xiang
> 
> Thanks for your reply.
> 
> Indeed, the subsequent implementations have moved to using fanotify.
> Moreover, based on evaluation, this approach could indeed lead to
> performance improvements.
> 
> However, in our current use case, we are still working with a kernel
> version that only supports the fscache-based approach, so this issue
> still exists for us. :(

Since it's deprecated (because that fscache improvement will
take much long time to upstream and netfs dependency is
redundant in addition to new pre-content hooks), could you
improve it downstream directly?

Or if you have some simple proposal you could post, but no one
avoids you to use fscache downstream but it seems pre-content
hooks are more cleaner for this use case..

Thanks,
Gao Xiang


> 
> Thanks,
> Zizhi Wo
> 
>>
>>>
>>> Thanks,
>>> Zizhi Wo
>>


