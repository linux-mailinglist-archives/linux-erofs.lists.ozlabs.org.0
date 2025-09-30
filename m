Return-Path: <linux-erofs+bounces-1147-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B57BAC481
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 11:35:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbXwj5yShz3cZt;
	Tue, 30 Sep 2025 19:35:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759224933;
	cv=none; b=TnYR/LzFjSVlhKPxMe1XJSHnGnd+KRo6YyVSnLqvGuLrAawa4JF8Ax94UQQCE2PHee9hZIjSiVCTy4UTVLuZAPTX3CQRj8RW+WjY7NUhMUrGdoz36oDy/vRrRxF81nRm0ZNaIsl2qiVIA8AjPu0xty7oH4PSHndgElb+yUhHq/YEOuIXcT4MvfH57b3orQOVrd0d2GsEngMdcYKaWDAlPJfsspRoY8wNtNEW6BB7KuFnnw0QKv3qp75TX0+V6CIe5LrQWxewk1emnDvquU+w6LFdBKDwpFgUKW2Mo0P25qk2vcxEMfp0Z3x7LDxR1Rt+ILLkV6QBXGCbeYKDfgqhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759224933; c=relaxed/relaxed;
	bh=G28M0mfGKKbSLKQKWXbEvQMtiMjJagP5W9b8Iq7uiqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVVLnYSM1vvLX5Nnbktdzh643VzgKYW0dhmLYqLIJzxWTnZFGHR916StMLNtftvVmCxZcacw1VSoibWNrHcEjrMA7FtMfjIAkIJAmF+HZgATn4iumRCbJYf8GsuiIq4CNboGACmUHQ8D7drAI0vk19RoKWliRkIFpkIZfIbX24RKIVV3mz1SEHBOfgNksyRHPQg3j6NQkqhQL6WqHs+CE+D5oCgTearb91voXGygW5hbxGjUXKUJKJrcdiCJZeq+KPUXqm+t7yZ82B7z1F5sM3VPqLgyUZp6KHiOsmGR3gx34L2LSoPi0OnTM6zuArf4ZEzc2uM0sApKYxRqRB0pyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E1Z+qvth; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E1Z+qvth;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbXwh1TWVz3cZ5
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 19:35:31 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759224927; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G28M0mfGKKbSLKQKWXbEvQMtiMjJagP5W9b8Iq7uiqY=;
	b=E1Z+qvthSQZFAeN2XLgy/jwD3QHE4ix5bfJjTRy9AXvlNgj6/qIjN/Ks07N6IE9Bp1m1e594JSMjx+RV6bO9trPchgJgdaYs1ZhGkF4qXiMRWDzBS3qWX+ENJqWqnLZEtFAXP9qD1U7McIUTSnHhIFJbzWauI7KX4vI0s4ROsAM=
Received: from 30.221.129.112(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpB.5HC_1759224926 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 17:35:26 +0800
Message-ID: <b12cda24-71a2-4a59-8c69-5c5575b30af5@linux.alibaba.com>
Date: Tue, 30 Sep 2025 17:35:26 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: simplify s3erofs_prepare_url logic
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20250930084056.170447-1-zhaoyifan28@huawei.com>
 <8c2c314c-3088-4e25-ab20-63ac6402b004@linux.alibaba.com>
 <e3784812-ca18-4537-ae33-38813a5a6b4b@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <e3784812-ca18-4537-ae33-38813a5a6b4b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/30 17:25, zhaoyifan (H) wrote:
> 
> On 2025/9/30 17:06, Gao Xiang wrote:
>> Hi Yifan,
>>
>> On 2025/9/30 16:40, Yifan Zhao wrote:
>>> From: zhaoyifan <zhaoyifan28@huawei.com>
>>>
>>> `mkfs.erofs` failed to generate image from Huawei OBS with the following command:
>>>
>>>     mkfs.erofs --s3=<endpoint>,urlstyle=vhost,sig=2 s3.erofs test-bucket
>>>
>>> because it mistakenly generated a url with repeated '/':
>>>
>>> https://test-bucket.<endpoint>//<keyname>
>>>
>>> In fact, the splitting of bucket name and path has already been performed prior
>>> to the call to `s3erofs_prepare_url`, and this function does not need to handle
>>> this logic. This patch simplifies this part accordingly and fixes the problem.
>>>
>>> Fixes: 29728ba8f6f6 ("erofs-utils: mkfs: support EROFS meta-only image generation from S3")
>>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>> ---
>>>   lib/remotes/s3.c | 35 ++++++++++-------------------------
>>>   1 file changed, 10 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
>>> index 2e7763e..2bd5322 100644
>>> --- a/lib/remotes/s3.c
>>> +++ b/lib/remotes/s3.c
>>> @@ -41,17 +41,16 @@ struct s3erofs_curl_request {
>>>     static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
>>>                      const char *endpoint,
>>> -                   const char *path, const char *key,
>>
>> I really think we should at least add a unittest for this.
>>
> Hi Xiang,
> 
> 
> I agree that adding unit tests is necessary, but the issue is that it's difficult for us to verify the validity of the URL (and accompanying request headers) unless we actually make a request to a remote S3 service. For example, the issue described in this patch only occurs with Huawei Cloud OBS, not with Alibaba Cloud OSS.
> 
> I suggest that as a first step, we could perform basic rule-based validation of the URL in unit tests—such as checking whether the canonical query matches the URI, etc. And I will do it before submitting any patches modifying the url perparation logic in s3erofs implementaion.

I think we could just add some simple basic patterns first,
which we are all in agree that it should be generated as-is
to avoid stupid regression due to code changes.

Otherwise if there is lack of some unit tests, this piece
could be broken later.

Thanks,
Gao Xiang

> 
> In the future, we could integrate tools that simulate an S3 service (e.g., https://github.com/adobe/S3Mock) as part of our CI testing pipeline (although this still isn't sufficient to cover the compatibility differences across various cloud providers' S3 interfaces.... )
> 
> What's your opinion?
> 
> 
> Thanks,
> 
> Yifan
> 
> 
>> you could simply add
>>
>> #ifdef TEST
>> int main(int argc, char argv[])
>> {
>>     testfunc1();        // and use assert() if test fails
>>     testfunc2();
>> }
>> #endif
>>
>> and use gcc -o s3_test -Iinclude -lcurl lib/remote/s3.c to generate a test program.
>>
>> Thanks,
>> Gao Xiang
>>


