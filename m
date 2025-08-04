Return-Path: <linux-erofs+bounces-756-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3FB1A024
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 13:05:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwYcC1Psxz30Yb;
	Mon,  4 Aug 2025 21:04:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754305499;
	cv=none; b=IgSToqeeXR1YLfJvta0sgZN6CpTcd3LfRi+6vCPvSsoZTukaEpMuhHLd5XaCEqsSMmtBtki94PRb1deVDxwa5PYoPYuSGuVJ+3m1QxMXU5AcDtbRuC88S1YwyV/CagFBK2J+urEciZh7UpOLVllCnwQlebtMoQoTEe2FJnx9ylHO6VswJeWdH3Ga1KBR+3NajWOQsG1hLGg4Mkwc4jbYKgenpa6+DoaRoE6dyHFhjHLka/JoaIfx0QUKR1EueUOJcRFYRrdePUJVR6ZeyjtrUsMlTXpJ4UguIFFAqm7SqcaxI5qduTqn1FxV5kAPeQfDDQhwvf6FVJlHSQw/cN8Unw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754305499; c=relaxed/relaxed;
	bh=ZKgen/cpSzyg1ubdB2zkbbV4/c0clOsR2OaqPMJcCEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=Fsw6X7EKDc6LehNgZBhjV6JNVvvnFapcXKHF2AmiwIvu245QtlkTvH3AAMHIvRaBJ/m8Ix/Htf/wKXrlKtJXyB88uGXM1A4JnWKoejYZpI1LARJM+bSvDsRZUp+j+gn5th3c6n1Ci4ew0e9Rp1ZfUDskMEtco2D0aD+Y1dirlQQoRbZGDPk8ZFrDoaxCMYhsCox+2CEefY3hoPdXvaYIqB0aWd1j1By0PQeOzsXoT0YUVGfIVcK7MS5MHQspMhhuPj4JbAZfc2SICK06zZQspxeFtOUKv50i2za2T9LINy67khuQBvYa5WHaC3PokGeEuEHvE2m5ZVW/C3M1N0hnJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwYc96PzYz2yLJ
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Aug 2025 21:04:55 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bwYZs1Hx1ztT3W;
	Mon,  4 Aug 2025 19:03:49 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F3F45140118;
	Mon,  4 Aug 2025 19:04:50 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 19:04:50 +0800
Message-ID: <0fb82330-ab7d-40f1-bac5-8c54fa83bc3c@huawei.com>
Date: Mon, 4 Aug 2025 19:04:50 +0800
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
Subject: Re: [PATCH v3] erofs: Fallback to normal access if DAX is not
 supported on extra device
To: <linux-erofs@lists.ozlabs.org>
References: <20250804082030.3667257-2-Yuezhang.Mo@sony.com>
Content-Language: en-US
CC: <Yuezhang.Mo@sony.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250804082030.3667257-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/4 16:20, Yuezhang Mo wrote:
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

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
> 
> Changes of v3:
>    - uniformly use erofs_info() to output the logs of turning off DAX
> 
> Changes of v2:
>    - fix the indentation alignment of `dif->path`
>    - remove the unnecessary comment
> 
>   fs/erofs/super.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index e1020aa60771..8c7a5985b4ee 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -174,6 +174,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   		if (!erofs_is_fileio_mode(sbi)) {
>   			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
>   					&dif->dax_part_off, NULL, NULL);
> +			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
> +				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
> +					   dif->path);
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
> @@ -338,7 +348,6 @@ static int erofs_read_superblock(struct super_block *sb)
>   	if (ret < 0)
>   		goto out;
>   
> -	/* handle multiple devices */
>   	ret = erofs_scan_devices(sb, dsb);
>   
>   	if (erofs_sb_has_48bit(sbi))
> @@ -671,14 +680,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
> +		erofs_info(sb, "unsupported blocksize for DAX");
> +		clear_opt(&sbi->opt, DAX_ALWAYS);
>   	}
>   
>   	sb->s_time_gran = 1;

