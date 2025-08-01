Return-Path: <linux-erofs+bounces-746-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B132B17F28
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 11:22:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btgTd6F1fz2yfL;
	Fri,  1 Aug 2025 19:22:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754040165;
	cv=none; b=DA5MKHuGQsV8KAlE5veRugabxBq232yuobKT2NYMi8low1eG4RBDkJS0UI6zkEcKB86bMalHXIj58VQwdx+OU/5yTrfVPLx0QIAoOouyEfMARZ1s7ovJuPHLFM4vupdTWLNpRIXBlby9f/ZkLY9LlyiZ5SxhHCxG9rhBhdO7GMUeecReAKx0mQPYOgoMk/AUEuz0EhbZRjof+4HmDoxrz7VjO7dmZYEq9xwLdbkqbnHDI58KdM9ABCqb8MESp6nZ9NSIl/P2mvp1mlPzlRIEFafEGl36oLucHyay/fM/HKrTLUpZvOrdIMleYNrHghNHmczJHSF9vi9UOFYNLtxtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754040165; c=relaxed/relaxed;
	bh=1SuA755APwUmG64EnyUC3WuD67x3j576lmGoYrafBZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdz7D2uIMQacm09IBxXe2a6Z7ECIpdQEM1mzb+M5AxubYoHL8vnDhd2DfVfW4uRPvDSPGJj9UcqQP3N4aLvEg90Zk1hVf4CE80ZOh+cYBodJOBYXQKpf6e1QQR7L7LA7P+SWenq9g8U2ZeVGZForGA2bVszoX5S2wN2lPMRd5GqZHtS2cEfNGIwynNNxzjCRUoGFEqRCv64JJWPtnbd83UuuXn4fhHK0w9yFWf2xCQUFAMIAgkzI+ha1/LS6Z6MwqqEJgXI16mHpkQpy1lx+Iomn2lQvNTFBZ0X6iNTz/mQkC9iQ3zb7CQVOvDg5ZM3q0IJGzz7x/rNFJ915oRVPaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mf0gqpDA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mf0gqpDA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btgTc1vsTz2y82
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 19:22:42 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754040159; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1SuA755APwUmG64EnyUC3WuD67x3j576lmGoYrafBZw=;
	b=mf0gqpDAAbVfB1OXQ/F4dygDRdF4TG8VdQrAcTiu/l+9d1Jgh53O2/V+B/8EuFTvHSC5Baetvnv/9U4ok/kiOGBGbzCq5TdAYVhYqxVkeMedEDdd6PIF/3DXgg5Y2OeZG1RG5QXHsNdUIAqA9fOV2EWgIi9wXVr8ak4H2R3up2s=
Received: from 30.221.131.201(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WketWmT_1754040157 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Aug 2025 17:22:37 +0800
Message-ID: <482a1414-752d-484b-a818-9858a83854bd@linux.alibaba.com>
Date: Fri, 1 Aug 2025 17:22:35 +0800
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
Subject: Re: [PATCH v2 3/4] erofs-utils: mkfs: introduce `--s3=...` option
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, Yifan Zhao <zhaoyifan28@huawei.com>
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
 <20250801073046.1900016-2-zhaoyifan28@huawei.com>
 <26bee370-2cd1-43d3-b83e-af6e91253939@linux.alibaba.com>
 <7cf57bb4-caff-4d27-af23-d69ca3b3b75b@huawei.com>
 <0f00d052-f7e5-4006-89ba-4fdbd1453269@linux.alibaba.com>
 <2383c973-3072-4a39-bcab-097f5a5a46b1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2383c973-3072-4a39-bcab-097f5a5a46b1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/1 17:10, Hongbo Li wrote:
> 
> 
> On 2025/8/1 16:37, Gao Xiang wrote:
>> Hi Hongbo,
>>
>> On 2025/8/1 16:31, Hongbo Li wrote:
>>
>> ...
>>
>>>>> +#ifdef HAVE_S3
>>>>
>>>> HAVE_S3 is a bit odd, how about using
>>>> S3_ENABLED (like LZ4_ENABLED?)
>>>>
>>>>
>>>>> +        " --s3=X                generate an index-only image from s3-compatible object store backend\n"
>>>>> +        "   [,passwd_file=Y]    X=endpoint, Y=s3 credentials file\n"
>>>>
>>>> What's s3 credentials file? Is it documented
>>>> somewhere? Why is it named as passwd_file?
>>>>
>>>> Can we have an option to pass in accesskey
>>>> too?
>>>
>>> This follows the format of s3fs-fuse. Storing the ak/sk in a file is for security purposes. The file permission is set to 600 to prevent non-root users from accessing the ak/sk.
>>
>> Understood, I wonder if the format is documented in
>> the AWS website or somewhere?
> 
> AFAIK, the user should download the file which records ak/sk at the first time when access the target console page. The ak/sk may be saved in the csv format file. And the AWS website only shows the way to help user to obtain the ak/sk, such as [1]?
> 
> [1] https://docs.aws.amazon.com/IAM/latest/UserGuide/access-key-self-managed.html

I found this:
https://github.com/s3fs-fuse/s3fs-fuse/blob/master/doc/man/s3fs.1.in#L25

Ok, anyway, let's considering document the s3 mode later
in mkfs.erofs.

Thanks,
Gao Xiang


> 
> Thanks,
> Hongbo

