Return-Path: <linux-erofs+bounces-314-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E0AB581F
	for <lists+linux-erofs@lfdr.de>; Tue, 13 May 2025 17:10:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zxfzz166dz2yNG;
	Wed, 14 May 2025 01:10:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747149039;
	cv=none; b=czktK4q/dtYCPkMdRSmekynyiyLF6+/xOQ12xzSkJtsD2zBLE4zbEmcZEn27YieaE9M1O/KFnoEoymojgDtqP4goGBx5L88n817v17YGwPztG+8LirYZ1WTcXbewqw4/YagqZ8WRsDffX6+JyYQq2qNlQNntNpF3XR9a+K4omwzX9y8RO2aPkJ9rhyIk7pKbzA6pITATlyzf7YlRRL7SMpm9lwSjQ2J3hXiTJIT7po7oQDF15ELqQKpNCLUuoaCbUNqSFQ2jZi3hMpFTDOS9x0gMO/0StJmxdBdIQuM1WjiN2YszDd296MhaAYu39hzIFmLx/DJ9t9iQe4vSWnT+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747149039; c=relaxed/relaxed;
	bh=m2/k5Lm51x5X9F3xqcQE2paHc6ejYuLXLzNzgw20hm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JtyqxIu+VwhsUBNC3ZY4Pcu5ruX1M7eNNDI9NXlwLYxj0+SbNLbeScEtgdO1OnveNZEEADnMq6Uv0Zvjs5jtFcFuXlIQZCNI+1ZV16neT0MEcIS2ltL+9Xzl53heABM9ll6kDrgmoWTYarUorS8Ni5xcAKBiUDe7NnMgqFehGQVMJQ+kvYmh1qTzhRIJA9QX1yaNePXN7mMdWbpFa1ekOcIGXPw3FAei0bqbfa8rVZ6RpILWZtWTZcH34Hc8mE1JiOdjpUR8l6yvwQknGsw6euZUtTJ9haZC3sDWEBpeulJJ3nqlbXK+bWkrKsKc18vxa4oPz3j/YogUlC93jYYrCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zxfzx4vFyz2xd6
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 May 2025 01:10:33 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zxftp02g1zyTpT;
	Tue, 13 May 2025 23:06:10 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 327A71402DA;
	Tue, 13 May 2025 23:10:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 May 2025 23:10:27 +0800
Message-ID: <c02f6e33-6788-412a-8622-49364d67d369@huawei.com>
Date: Tue, 13 May 2025 23:10:26 +0800
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
Subject: Re: [PATCH 2/2] erofs: avoid using multiple devices with different
 type
Content-Language: en-US
To: Sheng Yong <shengyong2021@gmail.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <zbestahu@gmail.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Sheng Yong
	<shengyong1@xiaomi.com>
References: <20250513113418.249798-1-shengyong1@xiaomi.com>
 <20250513113418.249798-2-shengyong1@xiaomi.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250513113418.249798-2-shengyong1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/13 19:34, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> For multiple devices, both primary and extra devices should be the
> same type. `erofs_init_device` has already guaranteed that if the
> primary is a file-backed device, extra devices should also be
> regular files.
> 
> However, if the primary is a block device while the extra device
> is a file-backed device, `erofs_init_device` will get an ENOTBLK,
> which is not treated as an error in `erofs_fc_get_tree`, and that
> leads to an UAF:
> 
>    erofs_fc_get_tree
>      get_tree_bdev_flags(erofs_fc_fill_super)
>        erofs_read_superblock
>          erofs_init_device  // sbi->dif0 is not inited yet,
>                             // return -ENOTBLK
>        deactivate_locked_super
>          free(sbi)
>      if (err is -ENOTBLK)
>        sbi->dif0.file = filp_open()  // sbi UAF
> 
> So if -ENOTBLK is hitted in `erofs_init_device`, it means the
> primary device must be a block device, and the extra device
> is not a block device. The error can be converted to -EINVAL.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> ---
>   fs/erofs/super.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 512877d7d855..16b5b1f66584 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -165,8 +165,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
>   				bdev_file_open_by_path(dif->path,
>   						BLK_OPEN_READ, sb->s_type, NULL);
> -		if (IS_ERR(file))
> +		if (IS_ERR(file)) {
> +			if (PTR_ERR(file) == -ENOTBLK)
> +				file = ERR_PTR(-EINVAL);
>   			return PTR_ERR(file);

Hi, Yong

Thank you, I think it is indeed a UAF problem. This fixes the problem 
introduced by fb176750266a ("erofs: add file-backed mount support"). How 
about considering adding the fixes tag?

In addition, I wonder may be we can only check the fc->s_fs_info (we can 
set it to NULL in .kill_sb) in erofs_fc_get_tree rather than change the 
error code. So this way we can reback the correct error message to user.

Thanks,
Hongbo

> +		}
>   
>   		if (!erofs_is_fileio_mode(sbi)) {
>   			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),

