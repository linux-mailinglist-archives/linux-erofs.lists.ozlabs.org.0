Return-Path: <linux-erofs+bounces-265-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D60EAA05CA
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 10:30:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmtmg1YQZz30HB;
	Tue, 29 Apr 2025 18:30:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745915427;
	cv=none; b=ZElkr5tVanQglx4sUa+U6ZutQR7oqmHxpFEhnmxYrq0W9kmArI17Vbk8Oa1aB/r9LoOL6qXGf18W9F/URP81Mit6t7/0+nNk6YdXESnV/7o1BZv5owQKhAFheE61VtCGPhyjaxLqAt6dDlhXt0Nw221quLi8FqTIbLPY4Elgnk6pNuTaW29QrkkB/daP5KdnVaAhb1+oihwOsQRRCEOIWGMPD9zKtW8kuE1o7BwEO65u+TC/GgenDFlj8PB0a4FNiwDNJW71JcBBb9sy6NGxouXTdqVnN3hShoZ6I5oVjGHQzRzeqzXpQgVhuKo9EjR2Tld2VEKaMcc91177D5CWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745915427; c=relaxed/relaxed;
	bh=uoB0ERTa/jOsQVPOHuFHqXaZf7v2ED1/BFONbUt1JTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R376e84zAbZkvIj2c9sfuXDnJcFrjo1DeaT6jJha5AHuBnam4Oq5Ofl6NDsbf+vTfOhzu3LRluwhtgEStK3ieVvtAcVYhh9bsrnIeTKTY8m5vD06hqhACxIVQT4df6taGx8QQq3gAPOJZZO6B8QKtL9MPvUrWYzDEjriiJzM8ep6fibsYayJJpvr4Jd9a6B19O5RN75HY9qDopzZZd89Lzj3uA7wIRoo6VQ7WLnMvHRAVTJVdOFbYP6K0Enhfpmt9vqMRAWjlWDuOIzDhs9jNXMxJ1nt6EKVYWtQHBpxMhMGTjcAo5O4r9sbUlXaUIHfCjOeAw9DCgn63OhdYxb1ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmtmf1GbBz2yft
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 18:30:23 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zmtgf6CRMzvX0S
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 16:26:06 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id AA6E51402ED
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 16:30:18 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Apr 2025 16:30:18 +0800
Message-ID: <6492b5cc-092a-46ff-98b4-9cd874af3c07@huawei.com>
Date: Tue, 29 Apr 2025 16:30:17 +0800
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
Subject: Re: [PATCH v1 1/1] erofs-utils: fix endiannes issue
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250429073052.53681-1-egorenar@linux.ibm.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250429073052.53681-1-egorenar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/29 15:30, Alexander Egorenkov wrote:
> From: Super User <root@a8345034.lnxne.boe>
> 
> Macros __BYTE_ORDER, __LITTLE_ENDIAN and __BIG_ENDIAN are defined in
> user space header 'endian.h'. Not including this header results in
> the condition #if __BYTE_ORDER == __LITTLE_ENDIAN being always true, even on
> BE architectures (e.g. s390x). Due to this bug the compressor library was
> built for LE byte-order on BE arch s390x.
> 
> Fixes: bc99c763e3fe ("erofs-utils: switch to effective unaligned access")
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>   include/erofs/defs.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 051a270531ca..196dfa8191a8 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -19,6 +19,7 @@ extern "C"
>   #include <inttypes.h>
>   #include <limits.h>
>   #include <stdbool.h>
> +#include <endian.h>
>   

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

>   #ifdef HAVE_CONFIG_H
>   #include <config.h>

