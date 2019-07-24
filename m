Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC3728CD
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 09:07:17 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tmcf3Qg7zDqLN
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 17:07:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tmcY2mRgzDq60
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 17:07:07 +1000 (AEST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6864CB5E9EAA4E08A6BA
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 15:07:03 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Jul
 2019 15:06:53 +0800
Subject: Re: [PATCH v2] erofs-utils: Add missing error code handling.
To: Pratik Shinde <pratikshinde320@gmail.com>, <linux-erofs@lists.ozlabs.org>, 
 <bluce.liguifu@huawei.com>, <miaoxie@huawei.com>, <fangwei1@huawei.com>
References: <20190724045519.8498-1-pratikshinde320@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <485b94a5-969b-a90c-ad87-e7e871196ee8@huawei.com>
Date: Wed, 24 Jul 2019 15:06:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190724045519.8498-1-pratikshinde320@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On 2019/7/24 12:55, Pratik Shinde wrote:
> Handling error conditions that are missed in few scenarios.
> also, mkfs command should return 1 on failure and 0 on success.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  lib/inode.c | 10 ++++++++--
>  mkfs/main.c |  8 +++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 179aa26..08d38c0 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -752,8 +752,14 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  	}
>  	closedir(_dir);
>  
> -	erofs_prepare_dir_file(dir);
> -	erofs_prepare_inode_buffer(dir);
> +	ret = erofs_prepare_dir_file(dir);
> +	if(!ret)
> +		goto err_closedir;

Maybe it should be "if (ret)"? Have you use this patch to generate some images?

if(!ret)
  ^   --- no space here

> +
> +	ret = erofs_prepare_inode_buffer(dir);
> +	if(!ret)
> +		goto err_closedir;

ditto.

> +
>  	if (IS_ROOT(dir))
>  		erofs_fixup_meta_blkaddr(dir);
>  
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 1348587..f73eb10 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -212,6 +212,12 @@ int main(int argc, char **argv)
>  	erofs_show_config();
>  
>  	sb_bh = erofs_buffer_init();
> +	if(IS_ERR(sb_bh)) {
> +		err = PTR_ERR(sb_bh);
> +		erofs_err("Failed to initialize super block buffer head : %s",

erofs_err("Failed to initialize buffers: %s",

Thanks,
Gao Xiang

> +			  erofs_strerror(err));
> +		goto exit;
> +	}
>  	err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
>  	if (err < 0) {
>  		erofs_err("Failed to balloon erofs_super_block: %s",
> @@ -254,5 +260,5 @@ exit:
>  			  erofs_strerror(err));
>  		return 1;
>  	}
> -	return err;
> +	return 0;
>  }
> 
