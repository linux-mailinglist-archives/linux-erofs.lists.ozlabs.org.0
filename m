Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEB6EFFBB
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 05:14:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q6LSf6SQTz3cj5
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 13:14:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q6LSY10y7z3bhY
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Apr 2023 13:14:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vh5kO3u_1682565269;
Received: from 30.97.48.233(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vh5kO3u_1682565269)
          by smtp.aliyun-inc.com;
          Thu, 27 Apr 2023 11:14:30 +0800
Message-ID: <f42cb722-cdbe-4c87-1afb-3a81470a243c@linux.alibaba.com>
Date: Thu, 27 Apr 2023 11:14:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: do not build pcpubuf.c for uncompressed data
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230427030346.5624-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230427030346.5624-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/27 11:03, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The function of pcpubuf.c is just for low-latency decompression
> algorithms (e.g. lz4).
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>


Subject: erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


> ---
>   fs/erofs/Makefile   |  4 ++--
>   fs/erofs/internal.h | 12 +++++++-----
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 99bbc597a3e9..a3a98fc3e481 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -1,8 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_EROFS_FS) += erofs.o
> -erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
> +erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
> -erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
> +erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index af0431a40647..65dbfa76f854 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -472,11 +472,6 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>   	return NULL;
>   }
>   
> -void *erofs_get_pcpubuf(unsigned int requiredpages);
> -void erofs_put_pcpubuf(void *ptr);
> -int erofs_pcpubuf_growsize(unsigned int nrpages);
> -void __init erofs_pcpubuf_init(void);
> -void erofs_pcpubuf_exit(void);
>   
>   int erofs_register_sysfs(struct super_block *sb);
>   void erofs_unregister_sysfs(struct super_block *sb);
> @@ -512,6 +507,11 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>   			    struct z_erofs_lz4_cfgs *lz4, int len);
>   int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
>   			    int flags);
> +void *erofs_get_pcpubuf(unsigned int requiredpages);
> +void erofs_put_pcpubuf(void *ptr);
> +int erofs_pcpubuf_growsize(unsigned int nrpages);
> +void __init erofs_pcpubuf_init(void);
> +void erofs_pcpubuf_exit(void);
>   #else
>   static inline void erofs_shrinker_register(struct super_block *sb) {}
>   static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> @@ -529,6 +529,8 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
>   	}
>   	return 0;
>   }
> +static inline void erofs_pcpubuf_init(void) {}
> +static inline void erofs_pcpubuf_exit(void) {}
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
>   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
