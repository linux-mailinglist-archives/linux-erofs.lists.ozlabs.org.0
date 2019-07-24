Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5629C726C8
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 06:41:14 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tjN66kygzDqCM
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 14:41:10 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tdDm0vSRzDqBY
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 11:34:30 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F1AFEECF8AE29D77CD50
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 09:34:25 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Jul
 2019 09:34:16 +0800
Subject: Re: [PATCH] erofs-utils: Add missing error code handling.
To: Pratik Shinde <pratikshinde320@gmail.com>, <linux-erofs@lists.ozlabs.org>, 
 <bluce.liguifu@huawei.com>, <miaoxie@huawei.com>, <fangwei1@huawei.com>
References: <20190723200429.7132-1-pratikshinde320@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <980200eb-fa95-2de2-d68c-c52a323a540b@huawei.com>
Date: Wed, 24 Jul 2019 09:34:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190723200429.7132-1-pratikshinde320@gmail.com>
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

This patch isn't in erofs mailing list. I don't know what is wrong...
Could you resend the patch? It'd be better in the mailing list....

On 2019/7/24 4:04, Pratik Shinde wrote:
> Handling error conditions that are missing in few scenarios.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  lib/inode.c | 10 ++++++++--
>  mkfs/main.c | 10 ++++++++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
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
> +
> +	ret = erofs_prepare_inode_buffer(dir);
> +	if(!ret)
> +		goto err_closedir;
> +
>  	if (IS_ROOT(dir))
>  		erofs_fixup_meta_blkaddr(dir);
>  
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 1348587..9c9530d 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -200,18 +200,24 @@ int main(int argc, char **argv)
>  	if (err) {
>  		if (err == -EINVAL)
>  			usage();
> -		return 1;
> +		return err;

current erofs-utils will return 1; when failure...
If you suggest to return the real error code, could you fix the following as well?
and it should be return -err; since a positive error code is perfered? I have no idea....

253 exit:
254         z_erofs_compress_exit();
255         dev_close();
256         erofs_exit_configure();
257
258         if (err) {
259                 erofs_err("\tCould not format the device : %s\n",
260                           erofs_strerror(err));
261                 return 1;
262         }
263         return err;

Thanks,
Gao Xiang

>  	}
>  
>  	err = dev_open(cfg.c_img_path);
>  	if (err) {
>  		usage();
> -		return 1;
> +		return err;
>  	}
>  
>  	erofs_show_config();
>  
>  	sb_bh = erofs_buffer_init();
> +	if(IS_ERR(sb_bh)) {
> +		err = PTR_ERR(sb_bh);
> +		erofs_err("Failed to initialize super block buffer head : %s",
> +			  erofs_strerror(err));
> +		goto exit;
> +	}
>  	err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
>  	if (err < 0) {
>  		erofs_err("Failed to balloon erofs_super_block: %s",
> 
