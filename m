Return-Path: <linux-erofs+bounces-744-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D59B17E65
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 10:37:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btfTs16Pqz2yfL;
	Fri,  1 Aug 2025 18:37:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754037473;
	cv=none; b=LPZ6tPs/2Y5UjMB5WJpUJlAR570apD/smd3w7T3V1rcf6xvARH8wEGdOytHApLDB50lXhBLJ6VAQqyerhAdP5n9QA383D8K3Z9Xa1NjRny0sroPPRu/JX2dguBMQHdhuPuT/tSELskuyk/BpclL0rQao1zEIhVGGQ/9Hm4s55s9tUiKgYcIL+xfG7vZGl63m//BkNgXeIAq5xY75/EurwNkI/PCFumOJfXUmVZkAbZ9IxC4z/BQd6PY9DoBRnbuBOg7Nz4eFJo510MF5U9hXkPARm4oKK2TNjKWWxAONIZB2iXFVuML1JwTTeAmBfEiI0GJg+xWnvU3uZsav4CCSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754037473; c=relaxed/relaxed;
	bh=2u6HJAuWwQk7yiY4mZMfIwoscojl6KSzE6Jssbh1E78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3CLf5xdLoCh4dyXyur0lYW3RtXDPqdnW8IaioPihOf1xUHIJ9XYpWqUzTqm/TPMijKepY8aRXbVXbCdPHVzAbbJoPryUa41raCwGO9j3OlDCao0JmAEK/2pZH67neFK4fDnhUn5rf8ChJ8C6zfB0F5+rutKmSQHLxBVB98glK33HPZAYZ0Tk6JGJkzj4HNfuscN6a7m9XlJd80A4EXxoFInOFPjLY9OREfrvJbWzXflh031SoHv6FnareB3eYGh0d+aYyeYI3N5xeOxfkOblVu1mc01ZNwx9nwIo2BI98m+FlC/0V3UKhPzhimfmdm1ckVzV/BhRUowbpoCxGFcpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YKm1NQsO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YKm1NQsO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btfTq2mlcz2y82
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 18:37:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754037466; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2u6HJAuWwQk7yiY4mZMfIwoscojl6KSzE6Jssbh1E78=;
	b=YKm1NQsOIpG+mVKkn1zK2UKrE0my1c1T7UOdhkUvmFTf1E/J54qQBO99mJAibeXb01OVRjHzn0x4airbNpYtTzIGaAlQ/6CDXop0p+0+SaS6MYIwmJWCuyV7oHVG+tEL8seId2cL8D8HN+Id1J43boOvVVhjlYznFqqDGzbkPy8=
Received: from 30.221.131.201(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wkdm5fL_1754037464 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Aug 2025 16:37:45 +0800
Message-ID: <0f00d052-f7e5-4006-89ba-4fdbd1453269@linux.alibaba.com>
Date: Fri, 1 Aug 2025 16:37:43 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7cf57bb4-caff-4d27-af23-d69ca3b3b75b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/8/1 16:31, Hongbo Li wrote:

...

>>> +#ifdef HAVE_S3
>>
>> HAVE_S3 is a bit odd, how about using
>> S3_ENABLED (like LZ4_ENABLED?)
>>
>>
>>> +        " --s3=X                generate an index-only image from s3-compatible object store backend\n"
>>> +        "   [,passwd_file=Y]    X=endpoint, Y=s3 credentials file\n"
>>
>> What's s3 credentials file? Is it documented
>> somewhere? Why is it named as passwd_file?
>>
>> Can we have an option to pass in accesskey
>> too?
> 
> This follows the format of s3fs-fuse. Storing the ak/sk in a file is for security purposes. The file permission is set to 600 to prevent non-root users from accessing the ak/sk.

Understood, I wonder if the format is documented in
the AWS website or somewhere?

If it's only an implementation in s3fs-fuse, we might
need to document the format in the mkfs.erofs manpage
for example. (Although it's not needed in this patch,
maybe a follow-up patch.)

Also even I agree it's useful for security purposes,
it's still useful to have an _alternative_ way to
pass in plain ak/sk if possible.

`passwd_file` makes sense to me now since s3fs-fuse
uses this name too!

Thanks,
Gao Xiang

> 
> [1] https://github.com/s3fs-fuse/s3fs-fuse
> 
> Thanks,
> Hongbo
> 

