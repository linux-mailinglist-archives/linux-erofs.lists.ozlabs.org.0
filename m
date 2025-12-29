Return-Path: <linux-erofs+bounces-1639-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50AACE6D4E
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 14:09:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfxPf3rshz2xpg;
	Tue, 30 Dec 2025 00:09:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767013750;
	cv=none; b=Nsu2vQbQCa+1Oj7ADjagr2m/RAwbkRO1/WJxYJVffnGK6lcvQVqc0cEWZxM2viBL0QOIVIiqx88q4V9tyCyy8iofSucuaIomBV8kPH31HftGha8LWe3z7amSJQuTTFk5tfeartxqzUsm1rUjbUxO1oS1skJIkokPamKequp6l+042LYmffUo4denh5mFiNUggTIiBU0344bTbs4bZdOtiMuwafBzFybbOgdLZVIDGkGTGo9y1Ii6hnN425rwbqvpjOnNVV9J/9pZ753ktPUEspGrlrFkZ++YynkSKs/wJLoe2+WeQUNHofsMgvOyIPYqqpMkAnmo3X0iozJSlTaJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767013750; c=relaxed/relaxed;
	bh=OhzIbgEf3ra+EZ8qMH0bgITbVR52rxVfV+Fycs+n8Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=REy8mKTKiRqqg63855o7WINzZ+luz2UO/tKaGF5rv+be+NRqRCmbb9PtKj1vF2UftORnHfCX5wrPiligrBh6Tna5yI/eYmnVkCKi1Xt0r/4TuMCx7rhzIWhXZTdHjO2wTmSWsuqiXuCSCo1wt6GbIiksvcnti5FGZSOBRxVXG1srGNiis3G8bTTL3u/B51g2RghCVAB5Bco2ufCfs7C42mTJz4JEjRZH53xk+Ilnpijn3dVEO5nbF0EqrB2U4xm98Zklkrt295EYp8i+V1Zz10KhWOzS6XMEl4bW/27JWJQWv5gMvETnRwpXSfW48BQ5o5enM8OuxvitLNu8ohF4bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=MQKxqyDf; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=MQKxqyDf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfxPd3q7Tz2xdV
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 00:09:09 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OhzIbgEf3ra+EZ8qMH0bgITbVR52rxVfV+Fycs+n8Q0=;
	b=MQKxqyDf/SXFoBvbGFDQNYyR80oBeFZd5CWv/5viDAL6zZtMxX8n29XKF5JErhvLEqxQ07jmD
	C0maTHqHkrurFpzXpMdLFKEeWuSOvhBHRF2xuP8lhCaAdtJyBsVvSngeNML2k7OvESgWbYmSXiA
	Wp5QcWK98qQMdlx5b/Bs2y4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dfxKw36CPzLlTV
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 21:05:56 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id CEA4F402AB
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 21:09:05 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Dec 2025 21:09:05 +0800
Message-ID: <e5a21c69-39a3-47b2-8682-81f70a6fb7e1@huawei.com>
Date: Mon, 29 Dec 2025 21:09:04 +0800
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
Subject: Re: [PATCH] erofs: remove useless src in erofs_xattr_copy_to_buffer()
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20251229100515.111287-1-mengferry@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251229100515.111287-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/29 18:05, Ferry Meng wrote:
> Use it->kaddr directly.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/xattr.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 396536d9a862..c5c481b3f32d 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -182,17 +182,15 @@ static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
>   {
>   	unsigned int slice, processed;
>   	struct super_block *sb = it->sb;
> -	void *src;
>   
>   	for (processed = 0; processed < len; processed += slice) {
>   		it->kaddr = erofs_bread(&it->buf, it->pos, true);
>   		if (IS_ERR(it->kaddr))
>   			return PTR_ERR(it->kaddr);
>   
> -		src = it->kaddr;
>   		slice = min_t(unsigned int, sb->s_blocksize -
>   				erofs_blkoff(sb, it->pos), len - processed);
> -		memcpy(it->buffer + it->buffer_ofs, src, slice);
> +		memcpy(it->buffer + it->buffer_ofs, it->kaddr, slice);
>   		it->buffer_ofs += slice;
>   		it->pos += slice;
>   	}

