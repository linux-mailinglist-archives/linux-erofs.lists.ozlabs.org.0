Return-Path: <linux-erofs+bounces-238-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E9A9DEC7
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 04:56:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZlWRy4YCdz2ylr;
	Sun, 27 Apr 2025 12:56:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745722574;
	cv=none; b=hgM947mMMdlwrPpGp+kCU4j0pKcxhv0A29dsFbXT3OJAHndUPC8mzjZkocRmm88bG+jOly1GBwJa+D1OstRtfsHvK45L8DS3936EXUE/U5d4attg84S9JHvItzb/ZN8I3FR1nL54YyGGbON5L0sCpzg+gBYZVCmk5PRfIPPjriXeHnzYThKfc/TNoOGgimGR4wN5XoqMn94WcY8c+uKredDrfE7JypjiMV4zqUXSID39WmZgVbejo77Vbv67YiByY/hoqbagTULMAUomhacUHUypE+Xn4+rtFJz3lp3rwyJSFOlvJb3/YZnQoqe6i5XSagjYnn8zbOAtS7s1UH1O8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745722574; c=relaxed/relaxed;
	bh=AS7PZv+KFWrlEVBS35LTkBWF1O6+O4FJYJhPSvDRSz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ck1pY9gTd9tCvCWJfCmPWhs2Bmjq5XH1VCv/vRzcki+xK1pMtJZTuO7T1l5lABBHeS+j6YC5pZgINV17itXUg3SvV4k4dUB8rj6LrUWUby5hq5QQQJD7HtY+vvrl5xPDLKj/n4qXIZwAvVnfTidj9ypNXyOhuwQjeJgMLrIFiJs+8zpeb9ZzpYDa85VObOFRsaySMYDLrORJCQg13F9yReBfW9W1ddHNu3CSz/fnjLld3vLpgnSrJgoQYVTvRzJ3iCMaLLDbV8bXcAp4FQlbDEnj2yklRntBHK9Fr/j05E8XR56QBCR68K2UmT9QCvEI1xGeQJd2x5+LZvKMs4mqwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XwEesSrY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XwEesSrY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZlWRw1jTfz2xk5
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 12:56:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745722567; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AS7PZv+KFWrlEVBS35LTkBWF1O6+O4FJYJhPSvDRSz8=;
	b=XwEesSrYyKnxT90U1pDc0BTMQIMrakDOFiWuSVb3M/2OaLdXNF5G35U34U/KJGZ4b9opxuZW3qbkwC3RTBaE4FjjIdVBDJ80Y8A+Tl0FwXWT83dbOr5WdF8Y8Z83iV3fmfPoimt/gtHmbNo+Ozdu1H0CCrF7qZwQfC+BKWuNU/k=
Received: from 30.221.130.230(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WY7FP9M_1745722565 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Apr 2025 10:56:05 +0800
Message-ID: <cc616110-1324-4524-a690-90ebf744d932@linux.alibaba.com>
Date: Sun, 27 Apr 2025 10:56:05 +0800
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
Subject: Re: [PATCH] erofs-utils: fix `--blobdev=X`
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250427021555.99648-1-hsiangkao@linux.alibaba.com>
 <334053aa-57c9-4153-af5a-f929cf1f3a0b@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <334053aa-57c9-4153-af5a-f929cf1f3a0b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/4/27 10:49, Hongbo Li wrote:
> 
> 
> On 2025/4/27 10:15, Gao Xiang wrote:
>> Create one if the file doesn't exist.
>>
>> Fixes: b6b741d8daaf ("erofs-utils: lib: get rid of tmpfile()")
> 
> I think the real fixes should be Fixes: bbeec3c93076 ("erofs-utils: mkfs: add extra blob device support").

Prior to b6b741d8daaf, the functionality is ok since
fopen(..,"wb") will create the file too.

>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   lib/blobchunk.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>> index e6386d6..301f46a 100644
>> --- a/lib/blobchunk.c
>> +++ b/lib/blobchunk.c
>> @@ -627,7 +627,8 @@ int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
>>           blobfile = erofs_tmpfile();
>>           multidev = false;
>>       } else {
>> -        blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
>> +        blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
>> +                        O_TRUNC | O_BINARY, 0666);
> To maintain consistency, is it better to set the default permission to 0644?

I tend to switch all modes to 0666 around the codebase
in the future, since umask(022) will mask them into 0644.

Thanks,
Gao Xiang

