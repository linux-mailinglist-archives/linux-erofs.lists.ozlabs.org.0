Return-Path: <linux-erofs+bounces-326-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0357AB7C1B
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 05:09:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyZvF6r6yz3000;
	Thu, 15 May 2025 13:09:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747278585;
	cv=none; b=W8Rax/yo/p22SRptR2M4I9TvTx33cs70kT+fwYMwJrzsShuzBsYGOgHxqm9zHCBs/XiC9tjYw6+WMLhXkBz2GjNer47Zr/kRzyZcxuFhqlXZKGeBrXPvVlULqEa3WRytSV2ELkXGvOh2DWwVjMbg6r6ncouajoFoqJX796IuXjupK3iZpb1Tpb/QR38SEgOoAv8tixtvER0DYhWCne8K0RTVGZJEew1Z4KxjRk7U3QGu7IUA+7o8bNzsW7VMz6FuoB8GpNqCiiGs2EkKleiAh+QIfNCVNtLcJwA97YJzC4FSwxrhuwFf85Aalu6rWb+8q1HCiPHVoyNZse89HIYuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747278585; c=relaxed/relaxed;
	bh=bMbW4dRFOdXYHEEnhnvqfZqM32y9xl2lT5nLCBxnUCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eOQ4oqtVPPJ7DCRtIs7k/GPfYtzuutcjaht5LP2nFR+s624dANv0X7ECHjT2d72/wQD64GNknU7T9eyyvn2AvfyOklz8/tcD4hahpu50zjjtjJrV9S+KYOSyY9DjRuGM+Ka1PCC8KopwA6FStpccPDnx/vBrSaNnS8VNhvtzMt1y8/2B9/aCTAVrxriIQpL21oNxBSKKyUHT490KNZ8aQEWPq/P7tF1FR77hP8iu+FgXFPM73jfiTo4aT70x6y2R+8j+DtJGLV6UJsINYRYVcywGJ8TkqK37FoLZZDoRWJXsioXsgEZ29c7Ce2wrB6yI2Gz6Tamc5zJxZ201cdWJuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyZvF2CdJz2yvk
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 13:09:45 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZyZtK1j2yzsTNS;
	Thu, 15 May 2025 11:08:57 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C7381A016C;
	Thu, 15 May 2025 11:09:42 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 11:09:41 +0800
Message-ID: <a91486e6-83ae-43b0-8d62-84dd526bd916@huawei.com>
Date: Thu, 15 May 2025 11:09:41 +0800
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
Subject: Re: [PATCH v2] erofs: avoid using multiple devices with different
 type
Content-Language: en-US
To: Sheng Yong <shengyong2021@gmail.com>, <xiang@kernel.org>,
	<hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <zbestahu@gmail.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Sheng Yong
	<shengyong1@xiaomi.com>
References: <20250515014837.3315886-1-shengyong1@xiaomi.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250515014837.3315886-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/15 9:48, Sheng Yong wrote:
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
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> ---
>   fs/erofs/super.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 512877d7d855..6b998a49b61e 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -165,8 +165,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
>   				bdev_file_open_by_path(dif->path,
>   						BLK_OPEN_READ, sb->s_type, NULL);
> -		if (IS_ERR(file))
> +		if (IS_ERR(file)) {
> +			if (file == ERR_PTR(-ENOTBLK))
> +				return -EINVAL;
>   			return PTR_ERR(file);
> +		}

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo
>   
>   		if (!erofs_is_fileio_mode(sbi)) {
>   			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),

