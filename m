Return-Path: <linux-erofs+bounces-240-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D03A9E059
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 09:17:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZldFd4706z2yqp;
	Sun, 27 Apr 2025 17:17:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745738261;
	cv=none; b=itwUBRI2BJ21/idEGWQRpO+iQKUpFAqe+nUzKmCJQwBkwZNuDhfCpvq9MYz8aJSsoR9V4m+Icht/hECY+kLYEg6ke39OwO0Bi2fRSk/os8qspBBmi14Q0G4vQe8ly4kUm8NpMNz51elXpVCURdALqzXggnairpYgbCYXBzdIPqpfcKqHmJE92Lcq+XyIUu14/lrO8OcTNY0dL1c7pXITdt9oSICOy/YZfmLfVzcVuTbqOI96mMA7G3IX7+9ei69+/lW8uyR5YnqyJtdDqRMSbufBRPMon07J1x1g7KB3M50EwREBEXoIrfNuMGvJzZLGQHbWwSxCQ0Mf4BGgKG3xeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745738261; c=relaxed/relaxed;
	bh=+rIVT+TDZ9CiAtwza9QNWz6awW6KVcuINJqMDBM0GLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S/J5D8f7IThWMpdjhxI1clP7LwV0AwCJLFldMvQ53HX9yhNiexaljVnrgg4XkwFhm+UlKelZSaaK+oKAbCO8WoTAAqOUhqG3KmBiKMV1LkPUsUyg8/TbZLZ7Mk5DFM3RfTSFIEpRPyVE1WKnUNtZuI1ex3D3cgX7c6Pytl3x9xQRHjHQlHtR9OdBhBLNsCoN//QQ6TVaMcbNWozfHS+qZctLYz/z1F9mtqA13tyoO5WS2RSAiTguc4uT8wbyBkp+9sjsKKeV8GWBOPnm73ahnfX/rgm9gUrdLilRwLihx811I7PV6KVD4K9L9AYxECu62KK/ecVhtJgxRw/NhLBIaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sLp0ByS8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sLp0ByS8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZldFb1LKvz2ynh
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 17:17:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745738251; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+rIVT+TDZ9CiAtwza9QNWz6awW6KVcuINJqMDBM0GLU=;
	b=sLp0ByS8H5qN7wN4ntM8pxO3YmD3foCy+fEXgvjsj/WL/wExjroF4340icLgOQOZCe+7zj0NSJaKVx5Zui1dL0WfQ30cHMLjoUSQDof7mkQBovgBFMXdbv9mluXqz0jllT2ZR6BCbYKpgvI0UPO+wTgQkLIKfmZJ0yMkUfWAglo=
Received: from 30.221.130.230(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WY8848A_1745738248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Apr 2025 15:17:29 +0800
Message-ID: <d4556599-58a0-46be-89b4-5c84e3e7c696@linux.alibaba.com>
Date: Sun, 27 Apr 2025 15:17:28 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ecd39d65-7852-439c-af2d-f28e3f979066@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/27 15:04, Hongbo Li wrote:
> 
> 
> On 2025/4/27 10:56, Gao Xiang wrote:

...

>>>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>>>> index e6386d6..301f46a 100644
>>>> --- a/lib/blobchunk.c
>>>> +++ b/lib/blobchunk.c
>>>> @@ -627,7 +627,8 @@ int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
>>>>           blobfile = erofs_tmpfile();
>>>>           multidev = false;
>>>>       } else {
>>>> -        blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
>>>> +        blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
>>>> +                        O_TRUNC | O_BINARY, 0666);
>>> To maintain consistency, is it better to set the default permission to 0644?
>>
>> I tend to switch all modes to 0666 around the codebase
>> in the future, since umask(022) will mask them into 0644.
>>
> but 0644 can clearly show which permissions are set (the default umask 022 won't change anything). Or if we need to enforce a specific mode, can we umask to 0 at the beginning instead of relying on the default umask?

see fopen(3): https://man7.org/linux/man-pages/man3/fopen.3.html

In short, I'd like to change all 0644 to 0666 since
there is no reason to mask off other permissions
unless umask is also effective.

Or do you have other concerns?

> 
> By the way, I have another doubt (just occurred to me when seeing O_TRUNC, though it might be unrelated to this change): the chunk-based format can't be used together with the "--increase" option. Should we add a warning for that?

Why?

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>> Thanks,
>> Gao Xiang


