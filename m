Return-Path: <linux-erofs+bounces-786-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC01B1D14D
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Aug 2025 05:48:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byCnj4MsGz30RJ;
	Thu,  7 Aug 2025 13:48:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754538537;
	cv=none; b=JBqAw4a5XLyrghOvOKS52nA+jubjmF8+JB06htnlL/KBSKRRT1YxI/ROAzzLsWJZMRaou5wvSxP06/D0LE/Syh1h3tnJ3L5Akzb4rgl1q05JHDJvJtw3y75X6qPqpe81Exd5EQ8c5imDeeSOHzCEqZd9LCnoLm3fkXlXKn/pa5SsRi3SojVRKNoQQUcl2l/CKi9VbYDgLPM12f3u43t9Ms/RUYTk6+06UTJboJDZMZrFvK9kml+Yqi/Ge4ysiDxzb9/G/fbsmDgUOxal7Ap8089cI2xnPLOoMRRPY9u5yJtCyi7PnJ0w3usuxdrXdfd6zw9sYwnZrJppso/JnY1Ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754538537; c=relaxed/relaxed;
	bh=L3sw0pbRZGSWdc2jAxKilgJfjgwheZ0mmiTCgfrLfic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKDWL2VMIl6XO/yomzuoE5YQPyfS0wawqVuhfHqFMLJpx44fcUrtTsir842IeL/SU5Lg/rjgujhKHheTMyQ4XKVFiZ1Ha6eeShKPvabAbmegOMikd6QoKllaQQ0UHapMBhWrDmXd8ACSPBkhP0r+tygDBvJeyZSrZop3+Y3eyxY6xr2bW41YbEi2c/AGV5nC58sAvawu45vh/VaX9KHRt+3EPVN2BWNkPOV7fO5KXEL31L+y2z/M8g0T/NFEGiKJwde/hXiET/vRMydeA5DCccJbxeeFTOMRRU5215W3xse/FX5m4clG+dZZOn8xXr4n6OEzBgMjKJDs3uw0ZOc8gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YaUrkNTX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YaUrkNTX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byCng6FZlz30Bd
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Aug 2025 13:48:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754538530; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L3sw0pbRZGSWdc2jAxKilgJfjgwheZ0mmiTCgfrLfic=;
	b=YaUrkNTXIf4cFSoVyDJENqAHAUwnM4uphKB2ZSBUTet3AHjLKbkqIA4VLbOTgKxy24KkvrtYJ6csGjaVWLiOddky0cQ4cxFuiGQd+Cb41u75bk6xKxSvy+O9gWwCYN90U8R8fM5Ws+LJeanvdvimFbL5rBMH8SrPqeUZ3zTES/k=
Received: from 30.221.131.19(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlCkwtd_1754538529 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 11:48:50 +0800
Message-ID: <f09a73d5-5753-4e7e-9d3d-b7262536eb04@linux.alibaba.com>
Date: Thu, 7 Aug 2025 11:48:48 +0800
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
Subject: Re: [PATCH v6 3/4] erofs-utils: mkfs: introduce --s3=... option
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250807030835.2671337-1-hsiangkao@linux.alibaba.com>
 <20250807030835.2671337-3-hsiangkao@linux.alibaba.com>
 <3f3d316c-92d8-4118-ad39-21df30ba5e7c@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3f3d316c-92d8-4118-ad39-21df30ba5e7c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/7 11:43, Hongbo Li wrote:
> Hi Xiang,
> 
> On 2025/8/7 11:08, Gao Xiang wrote:
>> From: Yifan Zhao <zhaoyifan28@huawei.com>
>>
>> It introduces configuration options for the upcoming experimental S3
>> support, including configuration parsing and `passwd_file` reading
>> logic.
>>
>> Users can specify the following options:
>>   - S3 service endpoint (required);
>>   - S3 credentials file in the format $ak:%sk (optional);
>>   - S3 API calling style (optional);
>>   - S3 API signature version (optional, only V2 is currently supported).
>>
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   lib/liberofs_s3.h |  40 ++++++++
>>   mkfs/main.c       | 226 +++++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 234 insertions(+), 32 deletions(-)
>>   create mode 100644 lib/liberofs_s3.h
>>
>> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
>> new file mode 100644
>> index 0000000..fbf2f80
>> --- /dev/null
>> +++ b/lib/liberofs_s3.h
> 
> How about moving liberofs_s3.h to `include/erofs/`? Because s3erofs_build_trees can also be exported and used in other cases.

Public APIs need to be redesigned later, current APIs
are unfriendly for external uses.

I tend to export a common api set to import data from:
  localdir
  tar / cpio / ...
  s3
  oci
  etc.

Thanks,
Gao Xiang

