Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5399914902
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 13:42:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ijEhsP/v;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W75gH0PcTz3cVx
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 21:42:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ijEhsP/v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W75gB1PdNz30TZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2024 21:42:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719229358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=91PztUb6olW9yDXdtMODTjd7jcWpu4Cl0a5wQ5KLHcY=;
	b=ijEhsP/vdIc2bWeccETOiWSD4k2iuytS0ZTTeXu7p2d008UInkDa47e5FiuN6h4RLcw3EAAh4pHsUBloMucCtNkvGrvS60b0UI6QG5AFLCnP9JPaulUMru6nsX9GrK+U92/z5yI4lwukKNoyvovuOpktxqFx61ZEWgpIuKv5sbY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W99B19U_1719229355;
Received: from 30.133.32.64(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W99B19U_1719229355)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 19:42:36 +0800
Message-ID: <a05374ff-845d-4da6-89e0-83e7d5000f82@linux.alibaba.com>
Date: Mon, 24 Jun 2024 19:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: add support for FS_IOC_GETFSSYSFSPATH
To: Huang Xiaojia <huangxiaojia2@huawei.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, yuehaibing@huawei.com
References: <20240624063801.2476116-1-huangxiaojia2@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240624063801.2476116-1-huangxiaojia2@huawei.com>
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



On 2024/6/24 14:38, Huang Xiaojia wrote:
> FS_IOC_GETFSSYSFSPATH ioctl exposes /sys/fs path of a given filesystem,
> potentially standarizing sysfs reporting. This patch add support for
> FS_IOC_GETFSSYSFSPATH for erofs, "erofs/<dev>" will be outpt.
> 
> Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
> ---
>   fs/erofs/super.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1b91d9513013..19dfc1bd3666 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -643,6 +643,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   		sb->s_flags |= SB_POSIXACL;
>   	else
>   		sb->s_flags &= ~SB_POSIXACL;
> +	super_set_sysfs_name_bdev(sb);

I think you should use `super_set_sysfs_name_id()` for bdev cases,
and non-bdev cases should be handled too.

Please check out erofs_register_sysfs() for details.

Thanks,
Gao Xiang

>   
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	xa_init(&sbi->managed_pslots);
