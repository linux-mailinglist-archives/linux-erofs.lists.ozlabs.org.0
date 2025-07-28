Return-Path: <linux-erofs+bounces-712-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F06AB13937
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Jul 2025 12:50:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4brFcr5XbPz2xd6;
	Mon, 28 Jul 2025 20:50:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753699836;
	cv=none; b=fBgP3TPoGDOIuOiDXIll0uEG4oizI27erpocRQTk7Q/pOaFlq2NNVoSJar4j+GFuhaK4ukySA8Tip7KEka3VxYOTxEADNIoFsvczCf2H97KmWz/m4Rlq1IyrS/Fqv7V7q2zQWkuCQcZhizH7y9B4HluHAlbZ9JHK7FjCUS5syQuxCaiqBBz9/mXA2TQhof1l6dumNW+5TRVV2duLdyGPI9yYJW/uixIptwIwau1npc1aSDWn5ZWVzQx3RVGWUSTzaqR8RGe2+vb0u+mjJYDZgqOnsaF4QQUtDftqgo/g1iAnEzaXCoBfA6BGrsz+W/ClX35qXPPbJrYqexzto21rkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753699836; c=relaxed/relaxed;
	bh=clvb/I/qhGSwiGFjr7ogRsfBlh7eqMKU+TDtbtFYnyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HD/D55QqY5zZn7uF2J4KyHraY4w62K2jFgPacjQrcfdLrcjoYuf+ZClQjBe0EZ9iNxOkj9zzy8TPEXFDqWmwr6QT3+0pOOQIwsVgwnipNf5jIiEsTzPA++cWADzy7ZIXCYAeusYpw2E04Lyd/ddhm6Qd/lE2rWnkSAzV9XK+uu1OgBmU2KpCk/07GMLGBjoTjn5KFGAlIcZpcDqZWXy2/f8m4xwcTZY5wDVnEckyz0aHMtTgXNdhV0X9HhYv5M2rntezyjiFcpEQnecjs8qgFg5MX9JUkomrz7sn1qJE4vk3pydD/HyxGcBgQltaOfH3/7bUyJgxkB7bBNSqGF4vcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brFcp5f9Yz2xTh
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 20:50:32 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4brFds2RNyz27j7Q
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 18:51:29 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AD5B1A0188
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Jul 2025 18:50:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 18:50:27 +0800
Message-ID: <78fe79f9-627c-4f8b-98c6-f01be34871d7@huawei.com>
Date: Mon, 28 Jul 2025 18:50:28 +0800
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
Subject: Re: [PATCH v1] erofs: Fallback to normal access if DAX is not
 supported on extra device
To: <linux-erofs@lists.ozlabs.org>
References: <20250728014920.1658799-2-Yuezhang.Mo@sony.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250728014920.1658799-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/28 9:49, Yuezhang Mo wrote:
> If using multiple devices, we should check if the extra device support
> DAX instead of checking the primary device when deciding if to use DAX
> to access a file.
> 
> If an extra device does not support DAX we should fallback to normal
> access otherwise the data on that device will be inaccessible.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Jacky Cao <jacky.cao@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   fs/erofs/super.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index e1020aa60771..ad1578bb0f7b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -174,6 +174,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   		if (!erofs_is_fileio_mode(sbi)) {
>   			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
>   					&dif->dax_part_off, NULL, NULL);
> +			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
> +				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
> +						dif->path);
> +				clear_opt(&sbi->opt, DAX_ALWAYS);
> +			}
>   		} else if (!S_ISREG(file_inode(file)->i_mode)) {
>   			fput(file);
>   			return -EINVAL;
> @@ -210,8 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
>   			  ondisk_extradevs, sbi->devs->extra_devices);
>   		return -EINVAL;
>   	}
> -	if (!ondisk_extradevs)
> +	if (!ondisk_extradevs) {
> +		if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
> +			erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
> +			clear_opt(&sbi->opt, DAX_ALWAYS);
> +		}
>   		return 0;
> +	}
>   
>   	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
>   		sbi->devs->flatdev = true;
> @@ -671,14 +681,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   			return invalfc(fc, "cannot use fsoffset in fscache mode");
>   	}
>   
> -	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
> -		if (!sbi->dif0.dax_dev) {
> -			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
> -			clear_opt(&sbi->opt, DAX_ALWAYS);
> -		} else if (sbi->blkszbits != PAGE_SHIFT) {
> -			errorfc(fc, "unsupported blocksize for DAX");
> -			clear_opt(&sbi->opt, DAX_ALWAYS);
> -		}
> +	if (test_opt(&sbi->opt, DAX_ALWAYS) && sbi->blkszbits != PAGE_SHIFT) {
> +		errorfc(fc, "unsupported blocksize for DAX");

How about using the info log? Can we consider using infofc in this case?

Thanks,
Hongbo

> +		clear_opt(&sbi->opt, DAX_ALWAYS);
>   	}
>   
>   	sb->s_time_gran = 1;

