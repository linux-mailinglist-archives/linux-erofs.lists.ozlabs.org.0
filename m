Return-Path: <linux-erofs+bounces-295-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6DAADBF0
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 11:55:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsrHY2McNz2xQD;
	Wed,  7 May 2025 19:55:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746611753;
	cv=none; b=GKTryuwflX5byjQSl9oA5eTJfJ4gxxma30fZdHhSuPhef4bm6ckSlBCgHIas7WX31Iy7E4CT6aHfxdQI6KnNQmKl6yCo6gvudpqxEjDl20FaxzMu/cI5h85VoiuAe1GohpIyMJWfXLf7h+3q7ZDLwIVLlAYNONiCSvJksNgDfFopFkviHqUDrfLVLyP4e7PAJxS5NbRLv7V4AFCXgFjUn46Mue3RqI6qsAaURmR9GtXeHOJNAEO9C2/3uBcqvOGgmdcwZj4jZtg6PluYx/AHSXQxKX+QoZgYFFmLxWbxu5q81p4VFjuRPC/yVL6Eu2qXtV+jUhGSs18TnzhgBmcJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746611753; c=relaxed/relaxed;
	bh=Us+o0j2TIpVQay1WydJANAD1//k1xEtf+KZBu87dYZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/uZg4NhRGc7Et8SrL3zynAFGjWKh67/Rel09HzrNQTvIfOzR7vW1FlJvlnQ5TLAGAQm8V9p5zkGErvy8bZC5uwwzi2G3bKKHAwxArd4bXb62FdxYE5EGi/hAomNMSxXUgJ0K7g1q2pokwylz8zk77oZs9hdgkKqCZrKjtBkQzGMO2HyqPOhUxLfGL2SDh6ODZ0QTdMeSXaT1oGWDNH7F32/g1HpQXU3UnOnym4OE1fQIh0A+PGv8jKussLrG99etUL+Ji5woYIGtkUf9lx6jAAOhPTRstq0Qh59DBMraNtRI0Y9NdvED9Fm/JuNDx/9mlD3n+w098bFk359aBeKDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g3fTtN3r; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g3fTtN3r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsrHW4GhLz2xQ5
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 19:55:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746611745; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Us+o0j2TIpVQay1WydJANAD1//k1xEtf+KZBu87dYZQ=;
	b=g3fTtN3r/RNjHRuhNgv+feZoHGNWChKS8DbrtHDxriZYst0n8yc9d38YxOoTjSdsKbLIYPhv5KswYhphscNSgQKoLjzeZiSISYWUj2/8VAyihY7VhNiEzZiJEolpdUe9zpcjAewUfWjTkVogRObanMQ2QTUIYNDLH6ocfpgDU+k=
Received: from 30.221.131.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZpIKqw_1746611742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 17:55:43 +0800
Message-ID: <556cdf04-f083-4ee7-a6ef-61e0e8957a58@linux.alibaba.com>
Date: Wed, 7 May 2025 17:55:42 +0800
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
Subject: Re: [PATCH] erofs-utils: fix `z_erofs_fixup_insize` defined but not
 used
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250507085236.1947828-1-hsiangkao@linux.alibaba.com>
 <965ef294-6137-4a16-9fc9-d29f75da6852@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <965ef294-6137-4a16-9fc9-d29f75da6852@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/7 17:53, Hongbo Li wrote:
> 
> 
> On 2025/5/7 16:52, Gao Xiang wrote:
>> Fixes: b08e804b1dd1 ("erofs-utils: lib: wrap up zeropadding calculation")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   lib/decompress.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/decompress.c b/lib/decompress.c
>> index 3f553a8..1f9daea 100644
>> --- a/lib/decompress.c
>> +++ b/lib/decompress.c
>> @@ -9,9 +9,9 @@
>>   #include "erofs/err.h"
>>   #include "erofs/print.h"
>> -static unsigned int z_erofs_fixup_insize(const u8 *padbuf, unsigned int padbufsize)
>> +static inline u32 z_erofs_fixup_insize(const u8 *padbuf, u32 padbufsize)
>>   {
> How about using macro to constrain it? Like I send in [1].

There are too many macros related to this, you could check..

> 
> [1] https://lore.kernel.org/all/20250422123612.261764-5-lihongbo22@huawei.com/
> 
> Thanks,
> Hongbo
> 
>> -    unsigned int inputmargin;
>> +    u32 inputmargin;
>>       for (inputmargin = 0; inputmargin < padbufsize &&
>>            !padbuf[inputmargin]; ++inputmargin);


