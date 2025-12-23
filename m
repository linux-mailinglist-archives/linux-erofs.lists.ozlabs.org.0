Return-Path: <linux-erofs+bounces-1560-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6DCD8958
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 10:29:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db8pP5p0Pz2xlP;
	Tue, 23 Dec 2025 20:29:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766482141;
	cv=none; b=KYP6rht2Q7f82xtlw5MvRmPaVI02/0d+v9j474LJTuL6N8Ww+S3mo1Kt3CP8dkmOAJa1/iY6eovoHIhWUvqMhetqTQgTaK3sbW+M+qgZhYD+QPpsRQVzmg2TvzkqQq9z6F2ppUzxBrm4KRE4S8mv8EUOROTd4d1ov9fxqNQ7dxLez4OK/vi19e0PJPR+78k11AhSHUplg3EM5DeDsi9ZCecK/GqX/d6Cwlg33PbzrAW62kjriHZtsss4Uiylo+LRWxOdUKYxorwp9xh3XvrACudWydMOhmyIgmDSFDPaYsufbG/tUeGThrrUt2h7p9e/yc684OuM/7Zlk57rJW0zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766482141; c=relaxed/relaxed;
	bh=biXRUoUPC2Tm/gU10rm+4sU3o5Ggrr1QY2Mb8VOyiRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kFoJl/6378lUOlj7hf/Er1fwhzXgTaBXw/6ceflRHYCmjY7Oj51zYf37rBHccRXJWmqbIV1JEVyC9NazC+Q4Xjbn3LP+HThGuGsbegsnnHKjgLddsgDOwUE+5YEIApl3lA9WitnEs/LUY6U/kv2VqULdXTgF9/h7Sf1ilJHZqXP2ioQwIUhOjaVB0Fp6C44j17/F3KpcN6/CT2HHb6jYmDA0r2OcpMHkBx0BsLXS05Nzwb8BPCMtchf/vjnJhkiYi0k0kOGk46DCYyJEBbQbEoqHy0Er41YtgzKgxtAM/JT32ANVw0JVCRDfY6E/KGhP8g8fEuTh7xf0MnxZaZEVJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=z6VVGkYf; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=z6VVGkYf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db8pL3Y0sz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 20:28:56 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=biXRUoUPC2Tm/gU10rm+4sU3o5Ggrr1QY2Mb8VOyiRI=;
	b=z6VVGkYfsY2hiZSmViPrcCeKsXZR85NZPWJtwdwHNA9HghT1FQ9Rm+e0QXIqJE4jiyMus+X+n
	JDTWy4agbtw36AGpI28PjW5JQqlEAYBdOo4/SWJCZOOzYZKwmOEC8WFS2Zg1Uv+eUe2RMW1+wny
	zZiCUICkElR2X/sZL507NqE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4db8kY4CCnz1prM3;
	Tue, 23 Dec 2025 17:25:41 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id ED2594036C;
	Tue, 23 Dec 2025 17:28:49 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 17:28:49 +0800
Message-ID: <6714fff0-b931-4238-b656-62551ee1e202@huawei.com>
Date: Tue, 23 Dec 2025 17:28:48 +0800
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
Subject: Re: [PATCH v10 04/10] erofs: move `struct erofs_anon_fs_type` to
 super.c
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein
	<amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-5-lihongbo22@huawei.com>
 <79c97f96-bb07-46f3-8c9a-5e3c867f6cab@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <79c97f96-bb07-46f3-8c9a-5e3c867f6cab@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 16:30, Gao Xiang wrote:
> 
> 
> On 2025/12/23 09:56, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Move the `struct erofs_anon_fs_type` to the super.c and
>> expose it in preparation for the upcoming page cache share
>> feature.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Can you just replace this one with the following patch?
> 

Sure, I will add this in the next version.

Thanks,
Hongbo

> 
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date: Tue, 23 Dec 2025 16:27:17 +0800
> Subject: [PATCH] erofs: decouple `struct erofs_anon_fs_type`
> 
>   - Move the `struct erofs_anon_fs_type` to super.c and expose it
>     in preparation for the upcoming page cache share feature;
> 
>   - Remove the `.owner` field, as they are all internal mounts and
>     fully managed by EROFS.  Retaining `.owner` would unnecessarily
>     increment module reference counts, preventing the EROFS kernel
>     module from being unloaded.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/fscache.c  | 13 -------------
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    | 14 ++++++++++++++
>   3 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 7a346e20f7b7..f4937b025038 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022, Alibaba Cloud
>    * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>    */
> -#include <linux/pseudo_fs.h>
>   #include <linux/fscache.h>
>   #include "internal.h"
> 
> @@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
>   static LIST_HEAD(erofs_domain_cookies_list);
>   static struct vfsmount *erofs_pseudo_mnt;
> 
> -static int erofs_anon_init_fs_context(struct fs_context *fc)
> -{
> -    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type erofs_anon_fs_type = {
> -    .owner        = THIS_MODULE,
> -    .name           = "pseudo_erofs",
> -    .init_fs_context = erofs_anon_init_fs_context,
> -    .kill_sb        = kill_anon_super,
> -};
> -
>   struct erofs_fscache_io {
>       struct netfs_cache_resources cres;
>       struct iov_iter        iter;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index f7f622836198..98fe652aea33 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct 
> erofs_sb_info *sbi)
>       return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
>   }
> 
> +extern struct file_system_type erofs_anon_fs_type;
> +
>   static inline bool erofs_is_fscache_mode(struct super_block *sb)
>   {
>       return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..f18f43b78fca 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -11,6 +11,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/exportfs.h>
>   #include <linux/backing-dev.h>
> +#include <linux/pseudo_fs.h>
>   #include "xattr.h"
> 
>   #define CREATE_TRACE_POINTS
> @@ -936,6 +937,19 @@ static struct file_system_type erofs_fs_type = {
>   };
>   MODULE_ALIAS_FS("erofs");
> 
> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
> +static int erofs_anon_init_fs_context(struct fs_context *fc)
> +{
> +    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> +}
> +
> +struct file_system_type erofs_anon_fs_type = {
> +    .name           = "pseudo_erofs",
> +    .init_fs_context = erofs_anon_init_fs_context,
> +    .kill_sb        = kill_anon_super,
> +};
> +#endif
> +
>   static int __init erofs_module_init(void)
>   {
>       int err;
> -- 
> 2.43.5
> 

