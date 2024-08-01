Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AABD944B99
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 14:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722516235;
	bh=Z1ucF1NX9NHht+ZI/Y/Lmmg2sgZKjUXqx1pTEFe+Lz4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ae7VSHUoVlUt/33/uIQJshafrRC2KPrA6jJD+PfQQ+cInqdvD9OtRurOboMtxQQgT
	 oI+7+zMpLnBC569CAA9Qf6yoBOFaVzrgoFV0OvnEIaaK/e+bIS0G2KS+pxLzmDMFt8
	 nXQR4zGPnaMx6aXRTm2Qo2HL5sP1CgrNzkDryH3xnSoNEv1Cgd0DUzNURyMgJUMsKu
	 dyzpHNZVT5W5+JcpWX4OgFoh1giSEnCHeK5lUDN/9qwDkKtCeEA5lC68y5azm2/euI
	 ZQ5qk9sHXFuFc4DdpJAak9jcC4zPNwe0YTQ+fTv/TdsdcrjdDz7OYa4+0w7cDPqH2V
	 db4QyjYZEC+DQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZTDC2b3dz3dRK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 22:43:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZTD56WVyz3cLl
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 22:43:44 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZTBh6WklzncQd;
	Thu,  1 Aug 2024 20:42:36 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 07DA618006C;
	Thu,  1 Aug 2024 20:43:38 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 20:43:37 +0800
Message-ID: <5796c9ad-04ba-4226-ad28-75b265a4157b@huawei.com>
Date: Thu, 1 Aug 2024 20:43:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] erofs: apply the page cache share feature
Content-Language: en-US
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
 <20240731080704.678259-3-hongzhen@linux.alibaba.com>
In-Reply-To: <20240731080704.678259-3-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/31 16:07, Hongzhen Luo wrote:
> This modifies relevant functions to apply the page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Make adjustments based on the latest implementation.
> v1: https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/inode.c | 23 +++++++++++++++++++++++
>   fs/erofs/super.c | 23 +++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 5f6439a63af7..9f1e7332cff9 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "xattr.h"
> +#include "pagecache_share.h"
>   
>   #include <trace/events/erofs.h>
>   
> @@ -229,10 +230,22 @@ static int erofs_fill_inode(struct inode *inode)
>   	switch (inode->i_mode & S_IFMT) {
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +		erofs_pcs_fill_inode(inode);
> +#endif
>   		if (erofs_inode_is_data_compressed(vi->datalayout))
>   			inode->i_fop = &generic_ro_fops;
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +		else {
If the compress data is not support, the erofs_pcs_fill_inode should 
fill the fingerprint in this branch only.
> +			if (vi->fprt_len > 0)
> +				inode->i_fop = &erofs_pcs_file_fops;
> +			else
> +				inode->i_fop = &erofs_file_fops;
> +		}
> +#else
>   		else
>   			inode->i_fop = &erofs_file_fops;
> +#endif
>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> @@ -325,6 +338,16 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
>   			return ERR_PTR(err);
>   		}
>   		unlock_new_inode(inode);
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +		if ((inode->i_mode & S_IFMT) == S_IFREG &&may be S_ISREG macro is better.

> +		    EROFS_I(inode)->fprt_len > 0) {
Perhaps this logic need to be enclosed within unlock_new_inode.
> +			err = erofs_pcs_add(inode);
> +			if (err) {
> +				iget_failed(inode);
> +				return ERR_PTR(err);
> +			}
> +		}
> +#endif
>   	}
>   	return inode;
>   }
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 35268263aaed..a42e65ef7fc7 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -11,6 +11,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/exportfs.h>
>   #include "xattr.h"
> +#include "pagecache_share.h"
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/erofs.h>
> @@ -95,6 +96,10 @@ static struct inode *erofs_alloc_inode(struct super_block *sb)
>   
>   	/* zero out everything except vfs_inode */
>   	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	INIT_LIST_HEAD(&vi->pcs_list);
> +	init_rwsem(&vi->pcs_rwsem);
> +#endif
>   	return &vi->vfs_inode;
>   }
>   
> @@ -108,6 +113,21 @@ static void erofs_free_inode(struct inode *inode)
>   	kmem_cache_free(erofs_inode_cachep, vi);
>   }
>   
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +static void erofs_destroy_inode(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +
> +	if ((inode->i_mode & S_IFMT) == S_IFREG &&
using S_ISREG macro is better.
> +	    EROFS_I(inode)->fprt_len > 0) {
> +		if (erofs_pcs_remove(inode))
> +			erofs_err(inode->i_sb, "pcs: fail to remove inode.");
> +		kfree(vi->fprt);
> +		vi->fprt = NULL;
> +	}
> +}
> +#endif
> +
>   static bool check_layout_compatibility(struct super_block *sb,
>   				       struct erofs_super_block *dsb)
>   {
> @@ -937,6 +957,9 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   const struct super_operations erofs_sops = {
>   	.put_super = erofs_put_super,
>   	.alloc_inode = erofs_alloc_inode,
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	.destroy_inode = erofs_destroy_inode,
> +#endif
>   	.free_inode = erofs_free_inode,
>   	.statfs = erofs_statfs,
>   	.show_options = erofs_show_options,
