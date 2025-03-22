Return-Path: <linux-erofs+bounces-102-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB104A6C6D6
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Mar 2025 02:09:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZKLnS4xc9z30VQ;
	Sat, 22 Mar 2025 12:09:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742605772;
	cv=none; b=BCX67Oebon3uxinqVwq/BSavUNQV7NOl7Vr06QpcJIp9DGud5JLWmTsoHAEH+QIcPTREW0FzSTZnOfaDAeIoXE+NOG0D1Zd5cKKcJcXE1NdyVDD9M12mEj6iDhenxlyKEY6VU1bbtK++xMaVd4nIOt25SpEqR82RE06yjsrXKlzJFlbgWiG6jZKy5B5hZ/jZxTf/XjG7dFLpg+20LvPKypJ9+y6Z0EceGoZkDixFA5uUw9rVKbavX5D1cgRi81VQquHhpPk8pHFgQNbxlCyc1VX7s+STOnBWPooR4IrQadpij2rFrsWF/0bzhgYh8O+jv7/7vGop4MmL88rYXazsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742605772; c=relaxed/relaxed;
	bh=jyMnudIWYGkCySVkZrRQrpqAkjeCHDqkMzqrjbZVebE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AIzmB/JVLkx3Ks8JAnh0gy5i14jh8vtQGJFE9qVeYtF9868VQVCLTo7773U8/tsS0yit8ggtPti/NYb6o64+ln4NtJMu7nYTyhbyICBzYTAH+h8IWLXnWC1511uHorzNygsWyVXqKldItpCKqpq/nHwFNA4wpY6knE5u3LiUae88EKe/7NRvsXUHSOStTLZUQH/0ANjoKX0xLOFL362leyIsVrHCMyaerVSHZpIRDOHxcgcjOLSBBSdj4IHutxUFBfHsZkeh3oYPBud8AJrN9dHfrjloeEwpGVUq5EwQTRcp0oUtcBpc3nEpxfZacz+9g5+8FfvNanwblanA+aJw6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 921 seconds by postgrey-1.37 at boromir; Sat, 22 Mar 2025 12:09:31 AEDT
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZKLnR0Xz3z2yMD
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Mar 2025 12:09:28 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZKLM315P7zvWrq;
	Sat, 22 Mar 2025 08:50:07 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F39791800B2;
	Sat, 22 Mar 2025 08:54:01 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Mar 2025 08:54:01 +0800
Message-ID: <b235f795-3e1d-4a91-88dd-651bf9d75a17@huawei.com>
Date: Sat, 22 Mar 2025 08:54:00 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 1/7] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <linux-kernel@vger.kernel.org>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
 <20250301145002.2420830-2-hongzhen@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250301145002.2420830-2-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/1 22:49, Hongzhen Luo wrote:
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Looks good. Feel free to add:

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

> ---
>   fs/erofs/fscache.c  | 13 -------------
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    | 13 +++++++++++++
>   3 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index ce3d8737df85..ae7bd9ebff38 100644
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
> index 686d835eb533..47004eb89838 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -379,6 +379,8 @@ extern const struct file_operations erofs_dir_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> +extern struct file_system_type erofs_anon_fs_type;
> +
>   /* flags for erofs_fscache_register_cookie() */
>   #define EROFS_REG_COOKIE_SHARE		0x0001
>   #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 827b62665649..eb052a770088 100644
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
> @@ -850,6 +851,18 @@ static struct file_system_type erofs_fs_type = {
>   };
>   MODULE_ALIAS_FS("erofs");
>   
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
> +
>   static int __init erofs_module_init(void)
>   {
>   	int err;

