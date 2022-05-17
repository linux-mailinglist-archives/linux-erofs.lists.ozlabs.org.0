Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB4529B9A
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 10:00:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2T7c5Yr6z3bqn
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 18:00:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2T7V302kz3bXn
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 18:00:20 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0VDT5j9R_1652774413; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VDT5j9R_1652774413) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 May 2022 16:00:14 +0800
Date: Tue, 17 May 2022 16:00:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: support idmapped mounts
Message-ID: <YoNWDHI5u76qk6TM@B-P7TQMD6M-0146.local>
References: <20220517073210.3569589-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517073210.3569589-1-chao@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao.yu@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Tue, May 17, 2022 at 03:32:10PM +0800, Chao Yu wrote:
> This patch enables idmapped mounts for erofs, since all dedicated helpers
> for this functionality existsm, so, in this patch we just pass down the
> user_namespace argument from the VFS methods to the relevant helpers.
> 
> Simple idmap example on erofs image:
> 
> 1. mkdir dir
> 2. touch dir/file
> 3. mkfs.erofs erofs.img dir
> 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> 
> 5. ls -ln /mnt/erofs/
> total 0
> -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> 
> 6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> 
> 7. ls -ln /mnt/scratch_erofs/
> total 0
> -rw-rw-r-- 1 65534 65534 0 May 17 15:26 file
> 
> Signed-off-by: Chao Yu <chao.yu@oppo.com>

Thanks, yeah, I think it's enough to enable idmapped mount for EROFS:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/inode.c | 2 +-
>  fs/erofs/super.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e8b37ba5e9ad..5320bf52c1ce 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -370,7 +370,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>  				  STATX_ATTR_IMMUTABLE);
>  
> -	generic_fillattr(&init_user_ns, inode, stat);
> +	generic_fillattr(mnt_userns, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0c4b41130c2f..7dc5f2e8ddee 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -781,7 +781,7 @@ static struct file_system_type erofs_fs_type = {
>  	.name           = "erofs",
>  	.init_fs_context = erofs_init_fs_context,
>  	.kill_sb        = erofs_kill_sb,
> -	.fs_flags       = FS_REQUIRES_DEV,
> +	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>  };
>  MODULE_ALIAS_FS("erofs");
>  
> -- 
> 2.25.1
