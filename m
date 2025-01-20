Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB864A165CA
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 04:46:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ybx8h1FDyz3013
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 14:46:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737344786;
	cv=none; b=BNWSBEoPH+XIn4mNssbcI5u7mAB5QejjUpnds8/4jftPhhb4VTe/rbLig1gTsAS7GZapDOKpc3Z6fczd+IMF96mMaVrM9BczqSCj09oLkM4twY+Ojkq+2nVMVUUU/QbQdp+rKftn55XFIZxF5GZWCmOhbyPDMpxmuX5jCCMq/NqpmeQC1bHvgJBiqhRSf72GEUa+dQkpnX/b1cjuSHqYePZQyZ3JTaSPBrvAUH+zU/8hsMzBFyjtTcZo4XXkSk07hCVAKDk3Aqz9KE0jLdgckSci4BTqkurmwgpZVAVM2x9Ae9k0CD49KL0CggWjIGKF1ub9sY9JqkHnZ7zp27WBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737344786; c=relaxed/relaxed;
	bh=HyRdT1ZY48PCLWRPPhtzKY5PunqweRdWhGgguIYIX90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFX6DdS5/zXwz7HJMUTjVLGqLjvgqj0vdTsTQbIp9F2bAZx/qXCD7p5e/z3zZeIweHFBnzVizVHVWEvCJynp3215wAi38U8wBzPaPxreXDf9Db7BNFeDgm+nRaAAG2CtW2+TgqT5e4gUC0kLbXopjTrywwK4FSnL5IJeYpcKc7XWxdc51t1ByEmM8lDPj0u7A5IRtgbKmhZ+9h/clVRWh3EVQlW4Kbb18+4ebvpT+ErjUUNKdON6kOaUKN+fAWRt1UHNfw6UzZkDP02gXdYCkLHQbytAxzFwhxiaXUwez1kB1WXruqDPl383BScwX8I/FmNBSmDaPF293tArvfhr1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DnC4fdZF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DnC4fdZF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ybx8b61swz2yFB
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 14:46:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737344779; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HyRdT1ZY48PCLWRPPhtzKY5PunqweRdWhGgguIYIX90=;
	b=DnC4fdZF3b/umD0QRiOB3Txx+vKFQaoNBSEpsDoTEzu8zprHAiMG6HKP2LXj9cGV5Kfxm7ZON/4LFv3HPczJL6Zm6+se8M4Svu0hbRVisPQzXn2OWkZA6RmcTM8NSV0J20rFTV+wTL1xMyItIoq/7wsS6l++xo1wdhwEz1xBgHE=
Received: from 30.221.129.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNvSdcK_1737344777 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 11:46:17 +0800
Message-ID: <47f74598-1b2f-4308-a8b8-18fc40bafe6d@linux.alibaba.com>
Date: Mon, 20 Jan 2025 11:46:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20250115070936.119975-1-lihongbo22@huawei.com>
 <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
 <fbd5850c-e431-4914-81eb-ec3ff42419a4@huawei.com>
 <f0a6b66e-0427-4c66-8c69-20c6c362e55f@linux.alibaba.com>
 <dd9beb64-3bdb-4f49-a94b-21c039325558@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <dd9beb64-3bdb-4f49-a94b-21c039325558@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/20 11:43, Hongbo Li wrote:
> 
> 
> On 2025/1/20 11:10, Gao Xiang wrote:
>>
>>
>> On 2025/1/20 11:02, Hongbo Li wrote:
>>>
>>>
>>
>> ...
>>
>>>>>   }
>>>>> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct kiocb *iocb,
>>>>> +                  struct iov_iter *iter)
>>>>
>>>> I wonder if it's possible to just extract a folio from
>>>> `struct iov_iter` and reuse erofs_fileio_scan_folio() logic.
>>> Thanks for reviewing. Ok, I'll think about reusing the erofs_fileio_scan_folio logic in later version.
>>
>> Thanks.
>>
>>>
>>> Additionally, for the file-backed mount case, can we consider removing the erofs's page cache and just using the backend file's page cache? If in this way, it will use buffer io for reading the backend's mounted files in default, and it also can decrease the memory overhead.
>>
>> I think it's too hacky for upstreaming, since EROFS can only
>> operate its own page cache, otherwise it should only support
>> overlayfs-like per-inode sharing.
>>
>> Per-extent sharing among different filesystems is too hacky
> It just like the dax mode of erofs (but instead of the dax devices, it's a backend file). It does not share the page among the different filesystems, because there is only the backend file's page cache. I found the whole io path is similar to this direct io mode.

How do you handle a VMA which is consecutive as an
EROFS file, but actually mapping to different part
of the underlay inode, or even different underlay
inodes?

It just cause the current MM layer broken, but FSDAX
mode is a complete different story.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>> on the MM side, but if you have some detailed internal
>> requirement, you could implement downstream.
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> This is just my initial idea, for uncompressed mode, this should make sense. But for compressed layout, it needs to be verified.
>>>
>>> Thanks,
>>> Hongbo
>>>
>>>>
>>>> It simplifies the codebase a lot, and I think the performance
>>>> is almost the same.
>>>>
>>>> Otherwise currently it looks good to me.
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>

