Return-Path: <linux-erofs+bounces-715-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161DB14698
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Jul 2025 05:07:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4brgH73LdYz3064;
	Tue, 29 Jul 2025 13:06:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753758403;
	cv=none; b=o3bNnvYrGYxQ9U6ZtfuxTrySK6LUYRkL4OoYkuA89SRNq4V1hJbW2CNbIDFwt6yl+mKX/8i4cf9HoKyq9gadmKsCVTH9i1emiAfRE7nWWL1JkmIrS3QmYqmtB2S4pXgGQxRrH9dzoa8QlSexVwG3snciUAzW848IOmsYYq13hOYKnplhcq93OReN18NnfM3jfl+Xq807m4WH2no9ZwKvkmlR8erAo43KR571DMBsoEjAwthgBXoCj/H7QrKcP4R8ah5f1EIEZ0WfJVuVmiLU35H7ROyszqgFI6bqDcEkeaU6BLiJrgRMWm7OuVnSvh0n+QKFtAkNhcBjQvbksOy/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753758403; c=relaxed/relaxed;
	bh=dbSiZNLXK9EzRZuY5aZM6+vlJwXZqZVzp+LE7v4u1dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AahaEgvQYGb/CT9BqAN563nSqHAunfz4Q/RMIT02fw0T/UvueLxlttwveVJ+mVF7lLUX7kkcInj+EkKscwQtOT4eyRYfBO6rX0+1DtJXSkipH2e4fZrhBYIjmpIW43TyZOrbwvQNdGL6QKr+48vTTXD6wLmdsA/xCjYj6GV4FX07mLCjFuYwf2aq3BQUh8AY2aet+f12Lj1YpT8ucZLLhovj4AJnho2IbQFgeIPBpPbM78u8tU8dHOEtTVPSRVf1wddZovWQLfZ3hJXfuw7ye1r/Dr4UvRjvDx+Z+4kb2VzBkTD7ZdDmSfUJ19xneBAgsmzbAGF8d74Y/eYqLc8rFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brgH62fZ6z2xCd
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 13:06:41 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4brgCT2BrKz13MdJ;
	Tue, 29 Jul 2025 11:03:33 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B32C3180B73;
	Tue, 29 Jul 2025 11:06:37 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 11:06:37 +0800
Message-ID: <469d7d39-dde1-41f8-9d72-1c1a30a2b577@huawei.com>
Date: Tue, 29 Jul 2025 11:06:37 +0800
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
Subject: Re: [PATCH v2] erofs: Fallback to normal access if DAX is not
 supported on extra device
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>, <Yuezhang.Mo@sony.com>
References: <20250728045409.1678099-2-Yuezhang.Mo@sony.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250728045409.1678099-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


Hi Yuezhang,

On 2025/7/28 12:54, Yuezhang Mo wrote:
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
>   fs/erofs/super.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index e1020aa60771..b08016bf9d1e 100644
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
> +		errorfc(fc, "unsupported blocksize for DAX");

How about using the info log? Can we consider using infofc in this case?

Thanks,
Hongbo

> +		clear_opt(&sbi->opt, DAX_ALWAYS);
>   	}
>   
>   	sb->s_time_gran = 1;

