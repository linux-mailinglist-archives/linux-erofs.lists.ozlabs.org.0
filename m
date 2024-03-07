Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E9874D94
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 12:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709811414;
	bh=7LS1G1BOKVJGlH8iZZx5ZS6CX6CoYUUTdaDO7u1IM6A=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=P6LuHh6GaBzdPZAyqOXYEgP0fnuNZnaFanwlD+8euYjr7JI9oub5ntXGWHjal5nwe
	 GA8Qk3b6HPD7jSFWnFq1TFYaTOcFUSDJvCR0zB8AShlqeVjDQyVKaQzoliYMc3pjuR
	 MU3R0xYtvTFytD/FToYixGEutCXgAPFq8/SIfuNecZZD70rzp1qdnRUdnvDQr7X0kf
	 tfNLZN69lM2wCYRwkpNAPuhHYU8U2k9pYkeqQkm9SEHATpGdcpAjcJ7y4FOGUuethL
	 tDVN+wax17uNrYd22ehzT9G04FcPRW/6WrSJ6XBmvn8rKy6hUkME8x9ioJSZ0wdiV3
	 GlYGxxLaBLnpw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr6hk589Jz3bPV
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 22:36:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=yangerkun@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1031 seconds by postgrey-1.37 at boromir; Thu, 07 Mar 2024 22:36:46 AEDT
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr6hZ0yP5z303d
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 22:36:42 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tr6Hm5BCnzbcjM;
	Thu,  7 Mar 2024 19:18:44 +0800 (CST)
Received: from kwepemd200008.china.huawei.com (unknown [7.221.188.40])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F610140134;
	Thu,  7 Mar 2024 19:19:27 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemd200008.china.huawei.com (7.221.188.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 19:19:26 +0800
Message-ID: <c8b3e730-343c-e1ca-0190-7006c7ad2cf6@huawei.com>
Date: Thu, 7 Mar 2024 19:19:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
To: Baokun Li <libaokun1@huawei.com>, <linux-erofs@lists.ozlabs.org>
References: <20240307101018.2021925-1-libaokun1@huawei.com>
In-Reply-To: <20240307101018.2021925-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200008.china.huawei.com (7.221.188.40)
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
From: yangerkun via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: yangerkun <yangerkun@huawei.com>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

在 2024/3/7 18:10, Baokun Li 写道:
> Lockdep reported the following issue when mounting erofs with a domain_id:
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.8.0-rc7-xfstests #521 Not tainted
> --------------------------------------------
> mount/396 is trying to acquire lock:
> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 						at: alloc_super+0xe3/0x3d0
> 
> but task is already holding lock:
> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 						at: alloc_super+0xe3/0x3d0
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&type->s_umount_key#50/1);
>    lock(&type->s_umount_key#50/1);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 2 locks held by mount/396:
>   #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 			at: alloc_super+0xe3/0x3d0
>   #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
> 			at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
> 
> stack backtrace:
> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x64/0xb0
>   validate_chain+0x5c4/0xa00
>   __lock_acquire+0x6a9/0xd50
>   lock_acquire+0xcd/0x2b0
>   down_write_nested+0x45/0xd0
>   alloc_super+0xe3/0x3d0
>   sget_fc+0x62/0x2f0
>   vfs_get_super+0x21/0x90
>   vfs_get_tree+0x2c/0xf0
>   fc_mount+0x12/0x40
>   vfs_kern_mount.part.0+0x75/0x90
>   kern_mount+0x24/0x40
>   erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>   erofs_fc_fill_super+0x213/0x380 [erofs]
> 
> This is because the file_system_type of both erofs and the pseudo-mount
> point of domain_id is erofs_fs_type, so two successive calls to
> alloc_super() are considered to be using the same lock and trigger the
> warning above.
> 
> Therefore add a nodev file_system_type called erofs_anon_fs_type in
> fscache.c to silence this complaint. Because kern_mount() takes a
> pointer to struct file_system_type, not its (string) name. So we don't
> need to call register_filesystem(). In addition, call init_pseudo() in
> erofs_anon_init_fs_context() as suggested by Al Viro, so that we can
> remove erofs_fc_fill_pseudo_super(), erofs_fc_anon_get_tree(), and
> erofs_anon_context_ops.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Modified as suggested by Al Viro to simplify the code.
> 
>   fs/erofs/fscache.c  | 15 ++++++++++++++-
>   fs/erofs/internal.h |  1 -
>   fs/erofs/super.c    | 30 +-----------------------------
>   3 files changed, 15 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 89a7c2453aae..122a4753ecea 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2022, Alibaba Cloud
>    * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>    */
> +#include <linux/pseudo_fs.h>
>   #include <linux/fscache.h>
>   #include "internal.h"
>   
> @@ -12,6 +13,18 @@ static LIST_HEAD(erofs_domain_list);
>   static LIST_HEAD(erofs_domain_cookies_list);
>   static struct vfsmount *erofs_pseudo_mnt;
>   
> +static int erofs_anon_init_fs_context(struct fs_context *fc)
> +{
> +	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> +}
> +
> +static struct file_system_type erofs_anon_fs_type = {
> +	.owner		= THIS_MODULE,
> +	.name           = "pseudo_erofs",
> +	.init_fs_context = erofs_anon_init_fs_context,
> +	.kill_sb        = kill_anon_super,
> +};
> +
>   struct erofs_fscache_request {
>   	struct erofs_fscache_request *primary;
>   	struct netfs_cache_resources cache_resources;
> @@ -381,7 +394,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>   		goto out;
>   
>   	if (!erofs_pseudo_mnt) {
> -		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
> +		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);
>   		if (IS_ERR(mnt)) {
>   			err = PTR_ERR(mnt);
>   			goto out;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 0f0706325b7b..701d4eec693a 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -385,7 +385,6 @@ struct erofs_map_dev {
>   	unsigned int m_deviceid;
>   };
>   
> -extern struct file_system_type erofs_fs_type;
>   extern const struct super_operations erofs_sops;
>   
>   extern const struct address_space_operations erofs_raw_access_aops;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9b4b66dcdd4f..6fbb1fba2d31 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -579,13 +579,6 @@ static const struct export_operations erofs_export_ops = {
>   	.get_parent = erofs_get_parent,
>   };
>   
> -static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
> -{
> -	static const struct tree_descr empty_descr = {""};
> -
> -	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
> -}
> -
>   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
>   	struct inode *inode;
> @@ -712,11 +705,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	return 0;
>   }
>   
> -static int erofs_fc_anon_get_tree(struct fs_context *fc)
> -{
> -	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
> -}
> -
>   static int erofs_fc_get_tree(struct fs_context *fc)
>   {
>   	struct erofs_fs_context *ctx = fc->fs_private;
> @@ -789,20 +777,10 @@ static const struct fs_context_operations erofs_context_ops = {
>   	.free		= erofs_fc_free,
>   };
>   
> -static const struct fs_context_operations erofs_anon_context_ops = {
> -	.get_tree       = erofs_fc_anon_get_tree,
> -};
> -
>   static int erofs_init_fs_context(struct fs_context *fc)
>   {
>   	struct erofs_fs_context *ctx;
>   
> -	/* pseudo mount for anon inodes */
> -	if (fc->sb_flags & SB_KERNMOUNT) {
> -		fc->ops = &erofs_anon_context_ops;
> -		return 0;
> -	}
> -
>   	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return -ENOMEM;
> @@ -824,12 +802,6 @@ static void erofs_kill_sb(struct super_block *sb)
>   {
>   	struct erofs_sb_info *sbi;
>   
> -	/* pseudo mount for anon inodes */
> -	if (sb->s_flags & SB_KERNMOUNT) {
> -		kill_anon_super(sb);
> -		return;
> -	}
> -
>   	if (erofs_is_fscache_mode(sb))
>   		kill_anon_super(sb);
>   	else
> @@ -868,7 +840,7 @@ static void erofs_put_super(struct super_block *sb)
>   	erofs_fscache_unregister_fs(sb);
>   }
>   
> -struct file_system_type erofs_fs_type = {
> +static struct file_system_type erofs_fs_type = {
>   	.owner          = THIS_MODULE,
>   	.name           = "erofs",
>   	.init_fs_context = erofs_init_fs_context,
