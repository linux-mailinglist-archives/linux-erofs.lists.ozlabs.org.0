Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E555B933560
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2024 04:16:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X/15aKBI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WP0134H7zz3ccX
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2024 12:16:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X/15aKBI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WP00x699hz30Np
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2024 12:16:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721182571; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VUhsb2hFpMS8mtEidcOB0y4zo0kVWkbltFQYqQsagWQ=;
	b=X/15aKBIZoNHn8EJHFK/TbGLBHCrR8WjhR11MjZUW7ILWXzZ4HCuW1+oM9uMB36k9w+HHfAD7Lf82OLbbKQspFESwRdaJVmANLlvXFwOam7hrytHW8Yxmozk2zL53xu++NvKlkE5AQb5PSCtDRWHVzIOTetqNbZtvldBx4eruSg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WAixIOh_1721182568;
Received: from 30.97.49.55(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAixIOh_1721182568)
          by smtp.aliyun-inc.com;
          Wed, 17 Jul 2024 10:16:09 +0800
Message-ID: <490feda6-8961-4543-a921-dcd109d714b3@linux.alibaba.com>
Date: Wed, 17 Jul 2024 10:16:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v2] erofs: add support for FS_IOC_GETFSSYSFSPATH
To: Huang Xiaojia <huangxiaojia2@huawei.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, yuehaibing@huawei.com
References: <20240716112939.2355999-1-huangxiaojia2@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240716112939.2355999-1-huangxiaojia2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/16 19:29, Huang Xiaojia wrote:
> FS_IOC_GETFSSYSFSPATH ioctl exposes /sys/fs path of a given filesystem,
> potentially standarizing sysfs reporting. This patch add support for
> FS_IOC_GETFSSYSFSPATH for erofs, "erofs/<dev>" will be outpt for bdev
                                                  ^ will be outputted

> case, and "erofs/[domain_id,]<fs_id>" will be output for non-bdev case.

   ^ cases,

             ^ "erofs/[domainid,]<fsid>" will be outputed for fscache cases.

> 
> Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
> ---
> v2: handle non-bdev case.
> v1: https://lore.kernel.org/all/20240624063801.2476116-1-huangxiaojia2@huawei.com/
> ---
>   fs/erofs/super.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1b91d9513013..a24b6907363c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -576,6 +576,20 @@ static const struct export_operations erofs_export_ops = {
>   	.get_parent = erofs_get_parent,
>   };
>   
> +static void erofs_set_sysfs_name(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	if (erofs_is_fscache_mode(sb)) {
> +		if (sbi->domain_id)
> +			super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id, sbi->fsid);

Overly long line.

> +		else
> +			super_set_sysfs_name_generic(sb, "%s", sbi->fsid);

How about just get rid of the else arm, like:

		...
		return;
	}
	super_set_sysfs_name_id(sb);
}

Otherwise it looks good to me, but I may need to find time to
test myself.

Thanks,
Gao Xiang


> +	} else {
> +		super_set_sysfs_name_id(sb);
> +	}
> +}
> +
>   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
>   	struct inode *inode;
> @@ -643,6 +657,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   		sb->s_flags |= SB_POSIXACL;
>   	else
>   		sb->s_flags &= ~SB_POSIXACL;
> +	erofs_set_sysfs_name(sb);
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	xa_init(&sbi->managed_pslots);
