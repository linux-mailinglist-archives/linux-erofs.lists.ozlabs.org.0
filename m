Return-Path: <linux-erofs+bounces-245-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A88A9E334
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 15:05:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zlmyr3qt1z2yrF;
	Sun, 27 Apr 2025 23:05:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745759124;
	cv=none; b=fJVOvEmpGbOrglsv/Zp+G0oa/RpQ7q3HDMNL+S56Ue+bj/JiCTX1LvZj2spQ+RWFH/ZcMCwDOuqBaw9wZaVZ6r4TjBtPG7llZ01i4njbq9lMAE4P1yvYNhFJsyFrvtwLbCkPOlqDxzXwJNi/20bnI8QzvJZq8Bn8R1pfCjenf9k51ECdiOv/O82u3lzwfuz55pRbPqhYONCRE1TfbwUheMRXT3sgLTzKk9yO2xCMElDTJ/nCda6AHhClMbMf7Ut/tKq2RPgdjFCLN8hCEnYoATNko9ojqZvleEticu5Em4ahdMoO48xaRXpLRf9+cYKSNJZmGGiTYhWtSK90cCXAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745759124; c=relaxed/relaxed;
	bh=iK/POhXRcB/6hWYK7oR08n54mB7may/K4R22zJPvpDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b9o0S+KvzkTkwGsX9fwk5sH9IHqKANN3+SRsXvpXNx55KL2Uc3V53AlRYDdAQ++ve32YkKO6BfjX1/Av1qlHM0p7SSUMW1tqC98/yJbpjs/3HdWPHlkOZ8Iho+Z+CHyCGOmDVQyv5WDldxnrdrlJh0GwGlCjA2ro2Wz8Ilstm5qJhYG5yZadnZgo7FQwjElwtevPdY3xQCXUvh3jrS7jj00uS5eMtM+ZRAr5uNMjkSiDWqPeEMc+QhmsVBRpX6VZIGVBE6xgaJqvRIKQ3obqF5B2LgBf4iHoFpefIgx/SXAokHOz7ixBfjfWVa5cm6t6gBYT9QOWw/IBUYZfLZy+Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=edaOvIdz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=edaOvIdz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zlmyq2mp4z2yr0
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 23:05:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745759118; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iK/POhXRcB/6hWYK7oR08n54mB7may/K4R22zJPvpDU=;
	b=edaOvIdzEsACXMOJ+PjZqvmVjvnNjie0XvBH4FZRdPGIr3+9sSgSeO9DwUE1sHKRPebLVJfXyhwQmTZ2LYDEM2Ims8xAq+wff6D0gRxgbkcO8Fc1z0Qjxgj0qTIyneDvofPLPR4b9NRAZGQEi1bXfLGbnNnIX24u7lFRcntikjI=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WY9tES8_1745759114 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Apr 2025 21:05:15 +0800
Message-ID: <19d8fa7c-32b5-4de8-82ae-9ae2a44d6d0a@linux.alibaba.com>
Date: Sun, 27 Apr 2025 21:05:14 +0800
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
 <cc616110-1324-4524-a690-90ebf744d932@linux.alibaba.com>
 <ecd39d65-7852-439c-af2d-f28e3f979066@huawei.com>
 <d4556599-58a0-46be-89b4-5c84e3e7c696@linux.alibaba.com>
 <9e14c042-4820-4a7f-9c9e-f8916e6f02a4@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9e14c042-4820-4a7f-9c9e-f8916e6f02a4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/27 17:13, Hongbo Li wrote:
> 
> 
> On 2025/4/27 15:17, Gao Xiang wrote:
>>
>>
>> On 2025/4/27 15:04, Hongbo Li wrote:
>>>
>>>
>>> On 2025/4/27 10:56, Gao Xiang wrote:
>>
>> ...
>>
>>>>>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>>>>>> index e6386d6..301f46a 100644
>>>>>> --- a/lib/blobchunk.c
>>>>>> +++ b/lib/blobchunk.c
>>>>>> @@ -627,7 +627,8 @@ int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
>>>>>>           blobfile = erofs_tmpfile();
>>>>>>           multidev = false;
>>>>>>       } else {
>>>>>> -        blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
>>>>>> +        blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
>>>>>> +                        O_TRUNC | O_BINARY, 0666);
>>>>> To maintain consistency, is it better to set the default permission to 0644?
>>>>
>>>> I tend to switch all modes to 0666 around the codebase
>>>> in the future, since umask(022) will mask them into 0644.
>>>>
>>> but 0644 can clearly show which permissions are set (the default umask 022 won't change anything). Or if we need to enforce a specific mode, can we umask to 0 at the beginning instead of relying on the default umask?
>>
>> see fopen(3): https://man7.org/linux/man-pages/man3/fopen.3.html
>>
>> In short, I'd like to change all 0644 to 0666 since
>> there is no reason to mask off other permissions
>> unless umask is also effective.
>>
>> Or do you have other concerns?
> 
> ok, I have not other concerns.
> 
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks for the review!

Thanks,
Gao Xiang

