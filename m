Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF34177B1C6
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 08:43:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPPxd40MVz309t
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 16:43:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPPxZ3Fl4z2yW5
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 16:43:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VphbHLM_1691995418;
Received: from 30.97.49.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VphbHLM_1691995418)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 14:43:40 +0800
Message-ID: <b141d8aa-c8a4-63db-3400-901492c92dd0@linux.alibaba.com>
Date: Mon, 14 Aug 2023 14:43:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 05/13] erofs-utils: lib: keep self maintained devname
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
 <20230814034239.54660-6-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230814034239.54660-6-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/8/14 11:42, Jingbo Xu wrote:
> Keep self allocated and maintained devname in erofs_sb_info.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   include/erofs/internal.h |  2 +-
>   lib/io.c                 | 14 ++++++++++++--
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index a04e6a6..892dc96 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -61,7 +61,7 @@ struct erofs_device_info {
>   
>   struct erofs_sb_info {
>   	struct erofs_device_info *devs;
> -	const char *devname;
> +	char *devname;
>   
>   	u64 total_blocks;
>   	u64 primarydevice_blocks;
> diff --git a/lib/io.c b/lib/io.c
> index 8d84de2..1545436 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -10,6 +10,7 @@
>   #ifndef _GNU_SOURCE
>   #define _GNU_SOURCE
>   #endif
> +#include <stdlib.h>
>   #include <sys/stat.h>
>   #include <sys/ioctl.h>
>   #include "erofs/io.h"
> @@ -46,6 +47,7 @@ static int dev_get_blkdev_size(int fd, u64 *bytes)
>   void dev_close(struct erofs_sb_info *sbi)
>   {
>   	close(sbi->devfd);
> +	free(sbi->devname);
>   	sbi->devname = NULL;
>   	sbi->devfd   = -1;
>   	sbi->devsz   = 0;
> @@ -95,7 +97,11 @@ int dev_open(struct erofs_sb_info *sbi, const char *dev)
>   		return -EINVAL;
>   	}
>   
> -	sbi->devname = dev;
> +	sbi->devname = strdup(dev);

Could we move sbi->devname assignment to the beginning of the function?
e.g.

	..
         sbi->devname = strdup(dev);
         if (!sbi->devname)
                 return -ENOMEM;

         fd = open(dev, O_RDWR | O_CREAT | O_BINARY, 0644);
	...


> +	if (!sbi->devname) {
> +		close(fd);
> +		return -ENOMEM;
> +	}
>   	sbi->devfd = fd;
>   
>   	erofs_info("successfully to open %s", dev);
> @@ -136,8 +142,12 @@ int dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
>   		return -errno;
>   	}
>   
> +	sbi->devname = strdup(dev);
> +	if (!sbi->devname) {
> +		close(fd);
> +		return -ENOMEM;
> +	}

Same here.

Thanks,
Gao Xiang
