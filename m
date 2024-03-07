Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C2874F57
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 13:43:30 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mdfo1Zf1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr89V5F7yz3cCc
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 23:43:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mdfo1Zf1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr89L4GPqz3btk
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 23:43:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709815392; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7yi/+ahlAN3gTyrOjfUZUcFZaQXrrfoVOGr09A86TCI=;
	b=mdfo1Zf18WpNL+ak7+y3WvBb+Jrn5OqjYMxve21YMRbEUXu5L4e2FJV5VnTjh+NvCl4IkRIKv2gdJt8bq1nymoDsFmu8rYp7eAbHVxjDaaA8sIm1xrsMnpziUF3kfQu46+rfKwkaEK9EtBJOn1hjOz9X/1yEWLlX7p8u6uK/GyA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W2-e7Db_1709815389;
Received: from 30.221.148.124(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W2-e7Db_1709815389)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 20:43:10 +0800
Message-ID: <532017b5-db24-481a-b2f4-e474afff07c5@linux.alibaba.com>
Date: Thu, 7 Mar 2024 20:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240307101018.2021925-1-libaokun1@huawei.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240307101018.2021925-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/7/24 6:10 PM, Baokun Li wrote:
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
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&type->s_umount_key#50/1);
>   lock(&type->s_umount_key#50/1);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by mount/396:
>  #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 			at: alloc_super+0xe3/0x3d0
>  #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
> 			at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
> 
> stack backtrace:
> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x64/0xb0
>  validate_chain+0x5c4/0xa00
>  __lock_acquire+0x6a9/0xd50
>  lock_acquire+0xcd/0x2b0
>  down_write_nested+0x45/0xd0
>  alloc_super+0xe3/0x3d0
>  sget_fc+0x62/0x2f0
>  vfs_get_super+0x21/0x90
>  vfs_get_tree+0x2c/0xf0
>  fc_mount+0x12/0x40
>  vfs_kern_mount.part.0+0x75/0x90
>  kern_mount+0x24/0x40
>  erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>  erofs_fc_fill_super+0x213/0x380 [erofs]
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

LGTM.

Reviewed-and-tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
> V1->V2:
> 	Modified as suggested by Al Viro to simplify the code.
> 
>  fs/erofs/fscache.c  | 15 ++++++++++++++-
>  fs/erofs/internal.h |  1 -
>  fs/erofs/super.c    | 30 +-----------------------------
>  3 files changed, 15 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 89a7c2453aae..122a4753ecea 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2022, Alibaba Cloud
>   * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>   */
> +#include <linux/pseudo_fs.h>
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> @@ -12,6 +13,18 @@ static LIST_HEAD(erofs_domain_list);
>  static LIST_HEAD(erofs_domain_cookies_list);
>  static struct vfsmount *erofs_pseudo_mnt;
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
>  struct erofs_fscache_request {
>  	struct erofs_fscache_request *primary;
>  	struct netfs_cache_resources cache_resources;
> @@ -381,7 +394,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>  		goto out;
>  
>  	if (!erofs_pseudo_mnt) {
> -		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
> +		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);
>  		if (IS_ERR(mnt)) {
>  			err = PTR_ERR(mnt);
>  			goto out;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 0f0706325b7b..701d4eec693a 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -385,7 +385,6 @@ struct erofs_map_dev {
>  	unsigned int m_deviceid;
>  };
>  
> -extern struct file_system_type erofs_fs_type;
>  extern const struct super_operations erofs_sops;
>  
>  extern const struct address_space_operations erofs_raw_access_aops;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9b4b66dcdd4f..6fbb1fba2d31 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -579,13 +579,6 @@ static const struct export_operations erofs_export_ops = {
>  	.get_parent = erofs_get_parent,
>  };
>  
> -static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
> -{
> -	static const struct tree_descr empty_descr = {""};
> -
> -	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
> -}
> -
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> @@ -712,11 +705,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	return 0;
>  }
>  
> -static int erofs_fc_anon_get_tree(struct fs_context *fc)
> -{
> -	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
> -}
> -
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
> @@ -789,20 +777,10 @@ static const struct fs_context_operations erofs_context_ops = {
>  	.free		= erofs_fc_free,
>  };
>  
> -static const struct fs_context_operations erofs_anon_context_ops = {
> -	.get_tree       = erofs_fc_anon_get_tree,
> -};
> -
>  static int erofs_init_fs_context(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx;
>  
> -	/* pseudo mount for anon inodes */
> -	if (fc->sb_flags & SB_KERNMOUNT) {
> -		fc->ops = &erofs_anon_context_ops;
> -		return 0;
> -	}
> -
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
> @@ -824,12 +802,6 @@ static void erofs_kill_sb(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi;
>  
> -	/* pseudo mount for anon inodes */
> -	if (sb->s_flags & SB_KERNMOUNT) {
> -		kill_anon_super(sb);
> -		return;
> -	}
> -
>  	if (erofs_is_fscache_mode(sb))
>  		kill_anon_super(sb);
>  	else
> @@ -868,7 +840,7 @@ static void erofs_put_super(struct super_block *sb)
>  	erofs_fscache_unregister_fs(sb);
>  }
>  
> -struct file_system_type erofs_fs_type = {
> +static struct file_system_type erofs_fs_type = {
>  	.owner          = THIS_MODULE,
>  	.name           = "erofs",
>  	.init_fs_context = erofs_init_fs_context,

-- 
Thanks,
Jingbo
