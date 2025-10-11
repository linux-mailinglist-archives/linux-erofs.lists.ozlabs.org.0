Return-Path: <linux-erofs+bounces-1174-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70809BCF2D3
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Oct 2025 11:10:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ckHs12nkBz2yhX;
	Sat, 11 Oct 2025 20:10:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760173845;
	cv=none; b=fLmemD0BIQ9aMCeHbAFmqi9yHnQygfK5BojkXZ8/sHU9tX/Jw+sKXy9u2EDpVuACw/OxhbfZ0qmRwj6PVi/5zdDIzkzUKtm2KIw2myVx/fuyDvF0IK4/qRWJ1Ue3uzcC8odZ7OkYicH/uDPPq1tXHxfwnzFyZvGvbwCHBoQPBQrY+8QXkUsBkGieqCtap+8rIPM8x7fPUPrFaMNFQpAz8qdIqKH/sW9tqxMWco7IpFnCxuySb9OIJnH8fSRH+gkiwH4f+UmqBYeIdIKfW0Yqx9viXQCauj1UhhkVfLrcbLQxyQ6fdFXbvAS10jXBAXIPMr/u89BbKx7t251s0hAe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760173845; c=relaxed/relaxed;
	bh=wYkdpRjGiPA89V1LCR/0vIq9U1HappgburPLfAhJv9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iH2Iv5XGUwOMuq0ZBGjPOXkQeThXR/8as7S3dye/7jlo/YOVvSy/gB0pLiVZcaKzy+RiLYp8RXj30nRrAi+rRq1hZ4qUDwDlpmbAKqoFBnOX4HVCy6AkRhcRn051z/dqIXLq7nMBYA8eH7fSsEmi9DDHVLk7iiiioSskvkMehE0XWZWday/GFGzQdZ+C7jjPL6gXz5XizbitMs/MbWwE5QjmSSlmNcoM6xbulxRQWAq/Gxjltj4H7rwgTMcYQkcc8yXuZ59tPPbcfHp/adlyuV6vZuerlQhW117zVl2sIa1WpBM+0CcMNz4tl9yTzFDQe48eDhWlBOqSpEBHyt2cAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=etNa4FZN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=etNa4FZN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ckHrz2gtyz2xlQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 20:10:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760173837; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wYkdpRjGiPA89V1LCR/0vIq9U1HappgburPLfAhJv9o=;
	b=etNa4FZN3nxNAg3R/OkYnKcajZmODKDJsUmZM50SIhZoIR6ABi+SjGOrkp2p/9vWaJZ6ZvOQ+x0JfNIniQK3+vlSECfQLsPJFOSxJePAwrssQJGPmGSLpCgXSpk7TACRYjK5hMhmFVFxlBD+c/wrUx1Tpe21ClXlUeDOc0x/nRc=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wpw3kYZ_1760173835 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 17:10:36 +0800
Message-ID: <2cda3cc5-f837-4627-9587-051ed10839b9@linux.alibaba.com>
Date: Sat, 11 Oct 2025 17:10:34 +0800
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
Subject: Re: [PATCH] erofs: fix crafted invalid cases for encoded extents
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
References: <20251011025252.1714898-1-hsiangkao@linux.alibaba.com>
 <0a7abd75-86d5-4c38-bc25-0d20df8747ff@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0a7abd75-86d5-4c38-bc25-0d20df8747ff@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/10/11 15:37, Hongbo Li wrote:
> Hi Xiang,
> 

...

>> @@ -732,6 +733,10 @@ static int z_erofs_map_sanity_check(struct inode *inode,
>>       if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
>>                map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
>>           return -EOPNOTSUPP;
>> +    /* Filesystems beyond 48-bit physical addresses are invalid */
>> +    if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
>> +             pend >= BIT_ULL(48)))
> 
> Should we consider the non 48-bit block layout which the max is BIT_ULL(32) ?

Non-48bit block layout is strictly limited by the on-disk
__le32, so it's totally impossible to get >= 32-bit
addresses I think it's unnecessary.

but btw, this part is actually wrong, it should be
(pend >> sbi->blkszbits) >= BIT_ULL(48)

I will fix it soon.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>> +        return -EFSCORRUPTED;
>>       return 0;
>>   }


