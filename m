Return-Path: <linux-erofs+bounces-1582-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9052CDB51D
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 05:26:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbf2J1fHmz2xqf;
	Wed, 24 Dec 2025 15:26:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766550360;
	cv=none; b=HVnKND38DKSb1PYRPx0aV4LNJ0ssxcm6YftMzw1hesittrAmg1R6Yn8yPdpDYw7qf0BUPpahnxZSmc7sFPhkHP9oc4E3airR28djSClxoZYdyihgqIEBS4TvFOEMXMa71W6RWoPvHebEmJpdsVbNPKOvetMHtww7+fEgD01rweu//MGEvpTZ11ILqEfG6ITe32j6PtVVkmplu9SYBaTE6mS61KmitisjZLUrB2GvWTNZyxP7p0X5vfVWEu8cyzj67GIwg/yquyPV0E/Vy8InJlPl2cpeJf3L8VI7oLi5hLnWV9N2qVA7vch5yD/TdcaK/HdU4N6czHcLdnry9CXt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766550360; c=relaxed/relaxed;
	bh=KBK63GOTpwsyi+9/TViMKjqeqT7DORlU7E0BXR5JHBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OutSkMwDTI9TsZdZZ2evbdC3LUEgNpicpDychO/aK1GFnXycXe2xbJ10n9LXuQw6d1TfFn+M8uKO2ZH5zZ587WqXeoe9x9XHofw0EmwDU7x5kHzN5Edq9cJTVpAGXq5dk+awlEFcF/e3RMPYBsqG1KJzdxFQjlkeOjzur0veXM0nKMoo6sxW35f5hvPjdtDWhk8SLHOSJSJKN4TaQK8C4VKYXmEHfvNlI49kaMSuxNUODAWAW1UR0mE02weyfePtcXtEk0t3CeCwJXBTJ4jS8AmACxxrzUEZQYkkxdm88tMzVf2QsfldNplC8dhTDCfaNxQbHTDjshCSVGS17DpcDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VkfLPkl7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VkfLPkl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbf2G08bkz2x99
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 15:25:57 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766550350; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KBK63GOTpwsyi+9/TViMKjqeqT7DORlU7E0BXR5JHBo=;
	b=VkfLPkl7UGrCdwUQdbsOXMhfUb6lM52TOF9j1xK6IV2AAB71Xz2Mh9gs8sfl59wsJcp30tnv1PY+QraNCASOzHavjGl/kecpR3FxFe9bc18cbkD9ZrfIcoVkC6p1yFvoxFKsEln6Nlph/rQi8kL6nclNIK0EBlSuaIvJ90PC0Wc=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvZpwLY_1766550349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 12:25:49 +0800
Message-ID: <0081b97d-4b46-4b20-9d23-18d9642881cf@linux.alibaba.com>
Date: Wed, 24 Dec 2025 12:25:48 +0800
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
Subject: Re: [PATCH v11 04/10] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>, hch@lst.de
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-5-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-5-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Are you sure this is my previous version of this one?

Could you please check carefully before sending
out the next version?

Thanks,
Gao Xiang

> ---
>   fs/erofs/fscache.c  | 13 -------------
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    | 15 +++++++++++++++
>   3 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 7a346e20f7b7..f4937b025038 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022, Alibaba Cloud
>    * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>    */
> -#include <linux/pseudo_fs.h>
>   #include <linux/fscache.h>
>   #include "internal.h"
>   
> @@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
>   static LIST_HEAD(erofs_domain_cookies_list);
>   static struct vfsmount *erofs_pseudo_mnt;
>   
> -static int erofs_anon_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type erofs_anon_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name           = "pseudo_erofs",
> -	.init_fs_context = erofs_anon_init_fs_context,
> -	.kill_sb        = kill_anon_super,
> -};
> -
>   struct erofs_fscache_io {
>   	struct netfs_cache_resources cres;
>   	struct iov_iter		iter;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index f7f622836198..98fe652aea33 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
>   	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
>   }
>   
> +extern struct file_system_type erofs_anon_fs_type;
> +
>   static inline bool erofs_is_fscache_mode(struct super_block *sb)
>   {
>   	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..2a44c4e5af4f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -11,6 +11,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/exportfs.h>
>   #include <linux/backing-dev.h>
> +#include <linux/pseudo_fs.h>
>   #include "xattr.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -936,6 +937,20 @@ static struct file_system_type erofs_fs_type = {
>   };
>   MODULE_ALIAS_FS("erofs");
>   
> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
> +static int erofs_anon_init_fs_context(struct fs_context *fc)
> +{
> +	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> +}
> +
> +struct file_system_type erofs_anon_fs_type = {
> +	.owner		= THIS_MODULE,
> +	.name           = "pseudo_erofs",
> +	.init_fs_context = erofs_anon_init_fs_context,
> +	.kill_sb        = kill_anon_super,
> +};
> +#endif
> +
>   static int __init erofs_module_init(void)
>   {
>   	int err;


