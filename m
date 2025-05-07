Return-Path: <linux-erofs+bounces-294-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58522AADBE9
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 11:53:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsrF00mjxz2xl6;
	Wed,  7 May 2025 19:53:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746611620;
	cv=none; b=SHa66yGQ9I/le9PRctbsQXlbaBjhdtP2C+YDSu3z5hZYzf94PiJiwKuuLg3v2B3J8uJ8vDs3mE14jQX6RqhLLFAYnUBc4Iq8qT8xj1vwMX/GycRXT7W+XWojxZguXxxf9xpg24Qt/AADsl87yVHnTwkob82vQr/VVwgO1edkgyzL2loM0sYjEPY7osCKfTIG3Vd/uQtwcGcF+vxqI4Kxmj1coISBkkipMOj0WOwUtB0XaugI1ej65CpCofbFTVgPGY3CizCX6QXVEe37dNSTxCpxogR7LId+XhuVT/tZVh6HY3QxP70/sjH5nzeO8YdkiTpN9ZC5oXuDVcLNtnUOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746611620; c=relaxed/relaxed;
	bh=K/K9ZQrp6RJWFVqJ4FVoweUjEosncZSPX7H6tvOPHBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f1FYUk01tBLBNkV9Tn95+F7fA5+bUL0Yql/qCQ2pC6S6UWEvZ7dN4bXzwia3XwHn10CxULiRcOHzih/aSEnZUp0PnFGL2Xqz24iMo/CRQrb3N774LtXunVW2G8osp1AM87j1QSlwlCZnhV2CLh6BVlOVEStLPP/i/5BLzs1LAObRW0C3FZyomwFT3AM5+AEC6YCi9XtdnQ+AEilzkONABCwQBijJI8+6Gnke6zT1p15Dzw+eohJigYxohmHDySMOG9ZmxKEnu4WRk8KKql4+MaKTKsBzMstWn0X6B/QNtS4ZOBbqvUugRXLRxb6hpzMUPzDNA9ck92yD/6jJPLibDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsrDz3DDnz2xQ5
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 19:53:39 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZsrBS64cWz1R7l7
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 17:51:28 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id CAF4D14011B
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 17:53:34 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 17:53:34 +0800
Message-ID: <965ef294-6137-4a16-9fc9-d29f75da6852@huawei.com>
Date: Wed, 7 May 2025 17:53:33 +0800
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
To: <linux-erofs@lists.ozlabs.org>
References: <20250507085236.1947828-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250507085236.1947828-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/7 16:52, Gao Xiang wrote:
> Fixes: b08e804b1dd1 ("erofs-utils: lib: wrap up zeropadding calculation")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   lib/decompress.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/decompress.c b/lib/decompress.c
> index 3f553a8..1f9daea 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -9,9 +9,9 @@
>   #include "erofs/err.h"
>   #include "erofs/print.h"
>   
> -static unsigned int z_erofs_fixup_insize(const u8 *padbuf, unsigned int padbufsize)
> +static inline u32 z_erofs_fixup_insize(const u8 *padbuf, u32 padbufsize)
>   {
How about using macro to constrain it? Like I send in [1].

[1] 
https://lore.kernel.org/all/20250422123612.261764-5-lihongbo22@huawei.com/

Thanks,
Hongbo

> -	unsigned int inputmargin;
> +	u32 inputmargin;
>   
>   	for (inputmargin = 0; inputmargin < padbufsize &&
>   	     !padbuf[inputmargin]; ++inputmargin);

