Return-Path: <linux-erofs+bounces-221-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5CDA99D12
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 02:40:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjcZG6bBcz2ykX;
	Thu, 24 Apr 2025 10:40:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745455206;
	cv=none; b=M/XIwQwL0z7I4zBwyVf/FsEpEHfm+pQW99OW8rZsjid/rm85Kr4fL2nL1jir9q/+Wufg/VGC+e77WTqfsUMnhW4kizYJAodf5Uguyb67HCYgzC4mDCYhnWd7vvTrOKyKYpvOwYDEWkCIpOkh10A3aaQVyghvEgKBbsqbKfrDgxbfaIWEcbYTg6Glkd334Yliy2aryNI05bup2VbLAS+L6ErD89ssK0C/3+8nnxr2PuWxLLUq6Pjs41Cs4UuoAfra5hFhXb55GbVf+UAqxLgJs5bi8QI2lkvp/zMjX08/XYjNPYEk5l58DrkCUfjs/ySvhR0bcxVEpiSDRk1x65ZdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745455206; c=relaxed/relaxed;
	bh=KrasVHKeX0M1f6t3pOw5wX2ePphli8GZb/0iP/2r4iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErMX1VqE/A+BYOCwwdqgqnf3Ar16a9u6wjJFVcqy8D//5VxTlNXC0xQjPnYvjFyLqgDLUlOCnLdBgNxIDWpgiOBeH83TuScT+BoiZyMo0XotrE6CubRF9nrQexuz1DfeOhv5z/5SOYjhinj9PnHt4ILY+2N68FjtW6G9U6m1+mPf0894uQ1SZmOwbRBK41W5tCYht83ImgzVh8qgVugMt0BpIyuVdRuj+RVy7suw1U27sHMhXdkY+eDE1JIRDUSi8VRurLBE29jcdrB+iDYlYm9CCSw/9as/FB16FHciTcrTQJK1GUpo5UJUGmC+WeFWODQYbzjp34wf7eBrONS8Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MRz2J4BX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MRz2J4BX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjcZD5Phcz2xRv
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 10:40:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745455199; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KrasVHKeX0M1f6t3pOw5wX2ePphli8GZb/0iP/2r4iI=;
	b=MRz2J4BXtrPJN6FrVyvj5M7pzjWl4xIBhWN1a2qS5pEFI724hI3ZK6ZakGh2Rqa7uLCgR5KfKEabXN2U7o/K5MlmWWjdXCdsvS6Pg943bDm4OXGLdn/AUliFMS6qPxedqegkEQylld4/CHGjrsBzkiyJa/MEpmdPmtxAyyUN72c=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WXw3bPW_1745455197 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 08:39:58 +0800
Message-ID: <bcf043d2-e96b-4f8d-b83b-de2b5ad4657e@linux.alibaba.com>
Date: Thu, 24 Apr 2025 08:39:57 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] erofs-utils: Add --meta_fix and --meta_only
 format options
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250422123612.261764-1-lihongbo22@huawei.com>
 <2408568f-a9e6-4e32-83b2-e79aee83a55a@linux.alibaba.com>
 <406b4b4e-1a1e-4618-87b8-7b104838770f@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <406b4b4e-1a1e-4618-87b8-7b104838770f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/22 22:37, Hongbo Li wrote:
> 
> 
> On 2025/4/22 21:50, Gao Xiang wrote:
>> Hi Hongbo,
>>
>> On 2025/4/22 20:36, Hongbo Li wrote:
>>> In this patchset, we have added two formatting options --meta_fix and
>>> --meta_only to extend the ability of EROFS. In the case of using OBS,
>>> we can convert the directory tree structure from OBS into the erofs
>>> image and implement on-demand loading logic based on this. Since OBS
>>> objects are often large, we need to separate the metadata area from
>>> the data area, which is the reason we introduce the --meta_fix option.
>>> To accelerate the formatting process, we can skip the formatting of
>>> the raw data by adding --meta_only option.
>>
>> Thanks for the patches!
>>
>> I wonder if it's possible to reuse blobchunk.c codebase for
>> such usage in the short term.
>>
> Our initial plan was to reuse the blobchunk.c logic, but we found that the chunk-based layout has some minor issues when handling contiguous blocks—it would result in multiple elements in the chunk index array (whereas blobraw expects only oversized chunks).

Sorry for late reply.

It seems blobchunk bugs? Could you submit fixes for this?

Thanks,
Gao Xiang

