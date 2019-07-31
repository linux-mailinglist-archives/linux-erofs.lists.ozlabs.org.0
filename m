Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874897BBA0
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 10:27:30 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45z63z2ln9zDqZb
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 18:27:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45z63v2zrmzDqZL
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jul 2019 18:27:22 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CADC370938954F5AD41F;
 Wed, 31 Jul 2019 16:27:17 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 16:27:08 +0800
Subject: Re: [PATCH 13/22] staging: erofs: kill CONFIG_EROFS_FS_USE_VM_MAP_RAM
To: Gao Xiang <gaoxiang25@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-14-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <20868d59-a563-a14c-7dca-8e2a15bdb9d6@huawei.com>
Date: Wed, 31 Jul 2019 16:27:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729065159.62378-14-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
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
Cc: weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/7/29 14:51, Gao Xiang wrote:
> Turn into a module parameter ("use_vmap") as it
> can be set at runtime.
> 
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/Kconfig        |  8 ------
>  drivers/staging/erofs/decompressor.c | 37 +++++++++++++++-------------
>  2 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
> index 747e9eebfaa5..788beebf3f7d 100644
> --- a/drivers/staging/erofs/Kconfig
> +++ b/drivers/staging/erofs/Kconfig
> @@ -63,14 +63,6 @@ config EROFS_FS_SECURITY
>  
>  	  If you are not using a security module, say N.
>  
> -config EROFS_FS_USE_VM_MAP_RAM
> -	bool "EROFS VM_MAP_RAM Support"
> -	depends on EROFS_FS
> -	help
> -	  use vm_map_ram/vm_unmap_ram instead of vmap/vunmap.
> -
> -	  If you don't know what these are, say N.
> -
>  config EROFS_FAULT_INJECTION
>  	bool "EROFS fault injection facility"
>  	depends on EROFS_FS
> diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
> index 744c43a456e9..5352a50981cb 100644
> --- a/drivers/staging/erofs/decompressor.c
> +++ b/drivers/staging/erofs/decompressor.c
> @@ -7,6 +7,7 @@
>   * Created by Gao Xiang <gaoxiang25@huawei.com>
>   */
>  #include "compress.h"
> +#include <linux/module.h>
>  #include <linux/lz4.h>
>  
>  #ifndef LZ4_DISTANCE_MAX	/* history window size */
> @@ -29,6 +30,10 @@ struct z_erofs_decompressor {
>  	char *name;
>  };
>  
> +static bool use_vmap;
> +module_param(use_vmap, bool, 0444);
> +MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");

This should be documented in erofs.txt simply.

> +
>  static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>  				 struct list_head *pagepool)
>  {
> @@ -219,29 +224,27 @@ static void copy_from_pcpubuf(struct page **out, const char *dst,
>  
>  static void *erofs_vmap(struct page **pages, unsigned int count)
>  {
> -#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
> -	int i = 0;
> -
> -	while (1) {
> -		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
> -		/* retry two more times (totally 3 times) */
> -		if (addr || ++i >= 3)
> -			return addr;
> -		vm_unmap_aliases();
> +	if (!use_vmap) {

Minor thing.

if (use_vmap)
	return vmap(pages, count, VM_MAP, PAGE_KERNEL);

while (1) {
}

return NULL;

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> +		int i = 0;
> +
> +		while (1) {
> +			void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
> +			/* retry two more times (totally 3 times) */
> +			if (addr || ++i >= 3)
> +				return addr;
> +			vm_unmap_aliases();
> +		}
> +		return NULL;
>  	}
> -	return NULL;
> -#else
>  	return vmap(pages, count, VM_MAP, PAGE_KERNEL);
> -#endif
>  }
>  
>  static void erofs_vunmap(const void *mem, unsigned int count)
>  {
> -#ifdef CONFIG_EROFS_FS_USE_VM_MAP_RAM
> -	vm_unmap_ram(mem, count);
> -#else
> -	vunmap(mem);
> -#endif
> +	if (!use_vmap)
> +		vm_unmap_ram(mem, count);
> +	else
> +		vunmap(mem);
>  }
>  
>  static int decompress_generic(struct z_erofs_decompress_req *rq,
> 
