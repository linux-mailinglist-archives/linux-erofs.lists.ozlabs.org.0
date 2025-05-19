Return-Path: <linux-erofs+bounces-347-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A71BABC01E
	for <lists+linux-erofs@lfdr.de>; Mon, 19 May 2025 16:03:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1KCD3gZXz2yhG;
	Tue, 20 May 2025 00:03:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747663384;
	cv=none; b=oPkv9m+mfUvuT3J/YP79g4AmNXR5od0797PbmFiL71xL13k/OdxnhdEcfpYSUEIvxnAO3M+WpokHsHjyclj7QdSCAx55k74IACbT7z8osMpVWUY1BUvz5bvBAtshcP6xfWGIWnHRKXBDn2ehwn9gq6zy7iZCs2L0ZLAAZTCXT88xFerCFOOggDEImHG2SMm9l+Rc28Ih75oGP71VYDjw4LJFcyWdzWaxDvm38cgLtUabJQwdt75WzE3mcEFDQ+R7tz6EQiSOv9PuGUpOZcBC93nNXZHXGuX42cKOB9iSrI2+KD7WxLlcSPfj2ifSXkCHmWFnStmT/A+sKSucvzYd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747663384; c=relaxed/relaxed;
	bh=5QyEeXHW+LLCrXKmkRkigUDMsRJ6BYgLsPoeIV4VRvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=Dg25+cNM3Tm8D969ggtBs+YNwl8vEkZSysXqhFFhZbNNr2iAje73/ieFIEIsBsaojuGHX8gF1nGc3aY9VbJBghYcbIyMWXsRETeykuaon+euF3wNfIkTVhCDw0k10PLrnO7H+LaEt5eYVhbGeY0qLLUKvByLIbUzLKIaMerAcX6+83SjKP9pJUWdR/SeooG6U+yW9fhnjIJKF/tnTCy2Ou1tJ4OvbGBw065lwyhIHxbNUK6N1U5OPYOoHlbDOr5NIV4vi5GeBu5X7o7hN/VEoi0KrUgLbez4QMY4DwhU4WhhPbbOFcUuGUh2nYv8ooQBj/KBaKt48IMiN4s1iihU9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1KCC1zXZz2xd5
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 May 2025 00:03:01 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b1K6n1KxXz1Z1xR;
	Mon, 19 May 2025 21:59:13 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 76773180477;
	Mon, 19 May 2025 22:02:54 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 22:02:53 +0800
Message-ID: <eaab881c-086d-47b0-993e-0312f0bbf1e2@huawei.com>
Date: Mon, 19 May 2025 22:02:53 +0800
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
Subject: Re: [PATCH v7] erofs: add 'fsoffset' mount option to specify
 filesystem offset
Content-Language: en-US
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250517090544.2687651-1-shengyong1@xiaomi.com>
 <aCqrceu67F3rh3JM@debian>
CC: Sheng Yong <shengyong2021@gmail.com>, <hsiangkao@linux.alibaba.com>,
	<chao@kernel.org>, <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Wang Shuai <wangshuai12@xiaomi.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <aCqrceu67F3rh3JM@debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/19 11:54, Gao Xiang wrote:
> Hi Yong,
> 
> On Sat, May 17, 2025 at 05:05:43PM +0800, Sheng Yong wrote:
>> From: Sheng Yong <shengyong1@xiaomi.com>
>>
>> When attempting to use an archive file, such as APEX on android,
>> as a file-backed mount source, it fails because EROFS image within
>> the archive file does not start at offset 0. As a result, a loop
>> or a dm device is still needed to attach the image file at an
>> appropriate offset first. Similarly, if an EROFS image within a
>> block device does not start at offset 0, it cannot be mounted
>> directly either.
>>
>> To address this issue, this patch adds a new mount option `fsoffset=x'
>> to accept a start offset for the primary device. The offset should be
>> aligned to the block size. EROFS will add this offset before performing
>> read requests.
>>
>> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
>> Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
> 
> I applied the following diff to fulfill the Hongbo's previous suggestion
> and refine an error message:
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 11b0f8635f04..d93b30287110 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,7 +128,7 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> -fsoffset=%lu           Specify image offset for the primary device.
> +fsoffset=%lu           Specify block-aligned filesystem offset for the primary device.

Thanks,

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3185bb90f549..e1e9f06e8342 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -654,9 +654,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	}
>   
>   	if (sbi->dif0.fsoff) {
> -		if (sbi->dif0.fsoff & ((1 << sbi->blkszbits) - 1))
> -			return invalfc(fc, "fsoffset %llu not aligned to block size",
> -				       sbi->dif0.fsoff);
> +		if (sbi->dif0.fsoff & (sb->s_blocksize - 1))
> +			return invalfc(fc, "fsoffset %llu is not aligned to block size %lu",
> +				       sbi->dif0.fsoff, sb->s_blocksize);
>   		if (erofs_is_fscache_mode(sb))
>   			return invalfc(fc, "cannot use fsoffset in fscache mode");
>   	}

