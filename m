Return-Path: <linux-erofs+bounces-1638-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE2CE6D48
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 14:08:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfxNz4J2Vz2xpg;
	Tue, 30 Dec 2025 00:08:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767013715;
	cv=none; b=YaJFwA+HTMcmFEDeoRT5jHHNEQ7Kt/USskuXwo0mip6XFnumT6EtEbwOdu1nhkgcRSiVGkt/uF+a2Btj4kL8HkbfBy/3xvIjXaRp/b1oj9aWBPCPqTiTyJVraifSVa6/7sykHXEwzKhiRqZ4Cji/OhWcYJrfvKSHCRejALRY+Y4vKzEsRcVYWoL7QIddVVEdzB/gO8CYSwgXWmJnl3dBeIF0yTjyjn3HWgczS4A9t8FJWJmNtWLCNq4r+SDXfPbFBxENbXW+/UrFhDfrxbAo91Z7kxh3oW16daUcrqPUUXhSFEsWw03th/8nfx9XDd5+3OY7beemfJfVbaXlY+mnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767013715; c=relaxed/relaxed;
	bh=gZN1RDu52sHT9kQefV8QC/HvhaG4u7hpn17KA9U5Vyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R+DON9MUBbt6VM4wsackMZzMFpOkK0gkHfzP+UuR3UhEsX+2oXACHpn/pBNSBsZ8gt5I7AiK5dAEtrPGwVPch7rFMlzXKV0iZ5YqDwdQRTsy4gQSeNd0jhsnNaAnh1jr25jBF33iOfU+gpcw6Zk67vECbwUdXP5+gcR7i4PEeDY3hpJhrAAPdOZFD3yyPpRoAiazqJVnbubbbMAANTlR5SEjrw/2Aczyd64a67b6IgFihS/Yqf5TAADDndpCbv5YLEWFIkqFeBZKamNw9SbdByrh7yVb01SkMr4vaefkOlASqPJEIuyiU2knwqWJK6x4QjnJvgx/1JrGwVtYEIsJiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OYutr1La; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OYutr1La;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfxNx1xWfz2xdV
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 00:08:32 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gZN1RDu52sHT9kQefV8QC/HvhaG4u7hpn17KA9U5Vyw=;
	b=OYutr1LarxweYmJaCJ0BojUq5Mh70tZas4BN+lvo0u8UQz3cKj1LVx2hQ59+vjPxh1a34b7jF
	eHVBQeGORVIRLaOqFvGCZI6kEhdSb3lFyQ9nWeWhp0rutwCOPuyzswRlq7lYk+86NgcEZ2Wl7IC
	rpX1xq2aLCkUzOGpt0CT4Po=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dfxKD5xFBz1K968
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 21:05:20 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id D192140563
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 21:08:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Dec 2025 21:08:28 +0800
Message-ID: <2568ceaf-0d94-4a9a-a5af-133487595a7a@huawei.com>
Date: Mon, 29 Dec 2025 21:08:27 +0800
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
Subject: Re: [PATCH 2/4] erofs: fix incorrect early exits in volume label
 handling
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
 <20251229092949.2316075-2-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251229092949.2316075-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/29 17:29, Gao Xiang wrote:
> Crafted EROFS images containing valid volume labels can trigger
> incorrect early returns, leading to folio reference leaks.
> 
> However, this does not cause system crashes or other severe issues.
> 
> Fixes: 1cf12c717741 ("erofs: Add support for FS_IOC_GETFSLABEL")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/super.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 2e4d0ea2ffa1..0d4f736ae1f1 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -347,8 +347,10 @@ static int erofs_read_superblock(struct super_block *sb)
>   	if (dsb->volume_name[0]) {
>   		sbi->volume_name = kstrndup(dsb->volume_name,
>   					    sizeof(dsb->volume_name), GFP_KERNEL);
> -		if (!sbi->volume_name)
> -			return -ENOMEM;
> +		if (!sbi->volume_name) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>   	}
>   
>   	/* parse on-disk compression configurations */

