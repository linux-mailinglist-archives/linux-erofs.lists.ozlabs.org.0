Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF074736E
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Jun 2019 09:01:13 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45RQH91br7zDqjp
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Jun 2019 17:01:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45RQH31mlFzDqJT
 for <linux-erofs@lists.ozlabs.org>; Sun, 16 Jun 2019 17:01:01 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3276A39927F579A48215;
 Sun, 16 Jun 2019 15:00:50 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 16 Jun
 2019 15:00:43 +0800
Subject: Re: [PATCH v3 1/2] staging: erofs: add requirements field in
 superblock
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190611024220.86121-1-gaoxiang25@huawei.com>
 <20190613083541.67091-1-gaoxiang25@huawei.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <a4d587eb-c4f0-b9e5-7ece-1ac38c2735f3@huawei.com>
Date: Sun, 16 Jun 2019 15:00:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190613083541.67091-1-gaoxiang25@huawei.com>
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

Sorry for annoying... Could you help merge these two fixes? Thanks in advance...
decompression inplace optimization needs these two patches and I will integrate
erofs decompression inplace optimization later for linux-next 5.3, and try to start 
making effort on moving to fs/ directory on kernel 5.4...

Thanks,
Gao Xiang

On 2019/6/13 16:35, Gao Xiang wrote:
> There are some backward incompatible features pending
> for months, mainly due to on-disk format expensions.
> 
> However, we should ensure that it cannot be mounted with
> old kernels. Otherwise, it will causes unexpected behaviors.
> 
> Fixes: ba2b77a82022 ("staging: erofs: add super block operations")
> Cc: <stable@vger.kernel.org> # 4.19+
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> change log v3:
>  - record requirements in erofs_sb_info for runtime use as well;
> 
> change log v2:
>  - update printed message
> 
>  drivers/staging/erofs/erofs_fs.h | 13 ++++++++++---
>  drivers/staging/erofs/internal.h |  2 ++
>  drivers/staging/erofs/super.c    | 19 +++++++++++++++++++
>  3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
> index fa52898df006..8ddb2b3e7d39 100644
> --- a/drivers/staging/erofs/erofs_fs.h
> +++ b/drivers/staging/erofs/erofs_fs.h
> @@ -17,10 +17,16 @@
>  #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
>  #define EROFS_SUPER_OFFSET      1024
>  
> +/*
> + * Any bits that aren't in EROFS_ALL_REQUIREMENTS should be
> + * incompatible with this kernel version.
> + */
> +#define EROFS_ALL_REQUIREMENTS  0
> +
>  struct erofs_super_block {
>  /*  0 */__le32 magic;           /* in the little endian */
>  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> -/*  8 */__le32 features;
> +/*  8 */__le32 features;        /* (aka. feature_compat) */
>  /* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
>  /* 13 */__u8 reserved;
>  
> @@ -34,9 +40,10 @@ struct erofs_super_block {
>  /* 44 */__le32 xattr_blkaddr;
>  /* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
>  /* 64 */__u8 volume_name[16];   /* volume name */
> +/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
>  
> -/* 80 */__u8 reserved2[48];     /* 128 bytes */
> -} __packed;
> +/* 84 */__u8 reserved2[44];
> +} __packed;                     /* 128 bytes */
>  
>  /*
>   * erofs inode data mapping:
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 911333cdeef4..fc732c86ecd8 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -115,6 +115,8 @@ struct erofs_sb_info {
>  
>  	u8 uuid[16];                    /* 128-bit uuid for volume */
>  	u8 volume_name[16];             /* volume name */
> +	u32 requirements;
> +
>  	char *dev_name;
>  
>  	unsigned int mount_opt;
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index f580d4ef77a1..cadbcc11702a 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -71,6 +71,22 @@ static void free_inode(struct inode *inode)
>  	kmem_cache_free(erofs_inode_cachep, vi);
>  }
>  
> +static bool check_layout_compatibility(struct super_block *sb,
> +				       struct erofs_super_block *layout)
> +{
> +	const unsigned int requirements = le32_to_cpu(layout->requirements);
> +
> +	EROFS_SB(sb)->requirements = requirements;
> +
> +	/* check if current kernel meets all mandatory requirements */
> +	if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
> +		errln("unidentified requirements %x, please upgrade kernel version",
> +		      requirements & ~EROFS_ALL_REQUIREMENTS);
> +		return false;
> +	}
> +	return true;
> +}
> +
>  static int superblock_read(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi;
> @@ -104,6 +120,9 @@ static int superblock_read(struct super_block *sb)
>  		goto out;
>  	}
>  
> +	if (!check_layout_compatibility(sb, layout))
> +		goto out;
> +
>  	sbi->blocks = le32_to_cpu(layout->blocks);
>  	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
>  #ifdef CONFIG_EROFS_FS_XATTR
> 
