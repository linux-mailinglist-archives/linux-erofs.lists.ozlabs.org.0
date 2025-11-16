Return-Path: <linux-erofs+bounces-1378-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B5C6144B
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Nov 2025 13:03:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8TzF0mcnz2xqs;
	Sun, 16 Nov 2025 23:03:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763294585;
	cv=none; b=dw2eiwJK9LqoC0QHqCvCV1q1w1DW7zhX/bJWuWFdPX6ZPHrHk4y+gOB40PPz8NJEsIs7cLGvdpZXqeoiFqSxhqMGQcuLs/IDUULuSeZakS0GiHVpuITGYCi2imbhYGnKVdA6tBr2Zfl830vihvb/1jENP/wqOa7NG0Q+n+xOmoj9/8DXAVeObeUA5wyOCta2sWr/x8lysL8fbSD9toxuiD6zjY/UdIhywUhzrwHMAovsMKtvbC8udN4P6azvkvdlCja2T+VBXAkZKLpVSWRBRwk58+Jju4FcLk9WU/n53aBaJu+0dhyRO6BtxQ/5XhjZcI3MjQ6GIiRkPQ6oWHw2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763294585; c=relaxed/relaxed;
	bh=5zy7VPYvOOZ59Lo31U8JdU6iYnEW1IWMTLcUa7/0tfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kd+fLG2AhOZf5rZkU3ItilDH8cytfL+usobbMna2J0u9AULYaE7PwDPm3fl/Poh8jd11Gp4/AGV5Nd8hlaORjK3aV2nkJD9rBfTAEsxG4JdjCDhuA4wwKpUu0td6EQdOZnY4r8vIeL0Twta/XwT0+mEEqbHISsS347TqjgQDI6Zc33DEdPFAwUJEleXHEYVsd9xMZgNMASy0H1poFHZMY7cKiwXJD3jIHO9SWM9boacQVWld22ll7mYZ97X/nLnpLN1yVZFEFMYE4LxfqT+Evgg5XItBB0/CWmx2RYb/4RRY04jPrmXtN4oWl7YAnfFudxjR56XHwQ7qgF2ahnewpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DG49mW4v; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DG49mW4v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8TzC5tDHz2xqL
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Nov 2025 23:03:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763294579; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5zy7VPYvOOZ59Lo31U8JdU6iYnEW1IWMTLcUa7/0tfY=;
	b=DG49mW4vQF6cU3QbAiR/B4fDr4Tf2yxzPUpHekxu0Bg9M/xpW6wTRxol4OF4G9GYGGMCSMPYy0pCfmSF6OStZQke9SFPkGnlOWH6UyyV1DhxTEfSj5vkxa5Uj6bFviOZsVv4rc4OU4eszNJRm3UbAhhFYJqJT20pnG+sxknbiAw=
Received: from 30.170.196.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsSK0Ws_1763294575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Nov 2025 20:02:55 +0800
Message-ID: <3f7e3106-8ad3-46b5-ae88-3de5c6773df1@linux.alibaba.com>
Date: Sun, 16 Nov 2025 20:02:55 +0800
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
Subject: Re: [PATCH v8 3/9] erofs: move `struct erofs_anon_fs_type` to super.c
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-4-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-4-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/fscache.c  | 13 -------------
>   fs/erofs/internal.h |  4 ++++
>   fs/erofs/super.c    | 15 +++++++++++++++
>   3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 362acf828279..2d1683479fc0 100644
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
> index f7f622836198..e80b35db18e4 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -188,6 +188,10 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
>   	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
>   }
>   
> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
> +extern struct file_system_type erofs_anon_fs_type;
> +#endif

It's unnecessary to use #ifdef for "extern", otherwise
it looks good me.

Thanks,
Gao Xiang

