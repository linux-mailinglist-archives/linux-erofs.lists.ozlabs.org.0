Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22B924DC4
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 04:27:13 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d0to8EWr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDNvz26ztz3cYq
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 12:27:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d0to8EWr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDNvq71bhz3bbW
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 12:27:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719973617; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V8ruLJuCXQbe/onCqsQ/T6UzcdOeVxeWpV02JcGxffk=;
	b=d0to8EWr3jQmtqidmFnv2To87ji7sTM1SaYb2Yrvd36Dmc6dIPhz84Qem7L2IlqDa0H746olLgZL5lF0uqmFOWwWdMboBVlRYVMiH3H9uPLyufPDfr8EtXpoINqWkrcNdEeS7NKrFZKeMwPBRazgpJBDExGbBLWN6ramhfTy0tM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9kQ86M_1719973615;
Received: from 30.97.49.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9kQ86M_1719973615)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 10:26:56 +0800
Message-ID: <a025f2d4-bb49-4c47-9c15-c3437b411963@linux.alibaba.com>
Date: Wed, 3 Jul 2024 10:26:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: chagne function definition of
 erofs_blocklist_open()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240702121445.2475200-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240702121445.2475200-1-hongzhen@linux.alibaba.com>
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



On 2024/7/2 20:14, Hongzhen Luo wrote:

erofs-utils: lib: change function definition of erofs_blocklist_open()

s/chagne/change/

> Modified the definition of the function `erofs_blocklist_open` to accept
> a file pointer rather than a string, for external use in liberofs.

Modify erofs_blocklist_open to accept a file pointer instead of a
file path, making it suitable for external use in liberofs.

> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Let the caller to close the block_list.
> v1: https://lore.kernel.org/all/20240702115647.2457003-1-hongzhen@linux.alibaba.com/
> ---
>   include/erofs/block_list.h |  4 ++--
>   lib/block_list.c           | 17 +++++++----------
>   mkfs/main.c                | 23 +++++++++++++++--------
>   3 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> index 9f9975e..7db4d0c 100644
> --- a/include/erofs/block_list.h
> +++ b/include/erofs/block_list.h
> @@ -13,8 +13,8 @@ extern "C"
>   
>   #include "internal.h"
>   
> -int erofs_blocklist_open(char *filename, bool srcmap);
> -void erofs_blocklist_close(void);
> +int erofs_blocklist_open(FILE *fp, bool srcmap);
> +FILE *erofs_blocklist_close(void);
>   
>   void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
>   			      erofs_off_t srcoff);
> diff --git a/lib/block_list.c b/lib/block_list.c
> index f47a746..10c7c6a 100644
> --- a/lib/block_list.c
> +++ b/lib/block_list.c
> @@ -13,23 +13,20 @@
>   static FILE *block_list_fp;
>   bool srcmap_enabled;
>   
> -int erofs_blocklist_open(char *filename, bool srcmap)
> +int erofs_blocklist_open(FILE *fp, bool srcmap)
>   {
> -	block_list_fp = fopen(filename, "w");
> -
> -	if (!block_list_fp)
> -		return -errno;
> +	if (!fp)
> +		return -ENOENT;
> +	block_list_fp = fp;
>   	srcmap_enabled = srcmap;
>   	return 0;
>   }
>   
> -void erofs_blocklist_close(void)
> +FILE *erofs_blocklist_close(void)
>   {
> -	if (!block_list_fp)
> -		return;
> -
> -	fclose(block_list_fp);
> +	FILE *ret = block_list_fp;
>   	block_list_fp = NULL;
> +	return ret;>   }
>   
>   /* XXX: really need to be cleaned up */
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 63ed877..07b4f8d 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1133,6 +1133,10 @@ int main(int argc, char **argv)
>   	erofs_blk_t nblocks;
>   	struct timeval t;
>   	FILE *packedfile = NULL;
> +	FILE  *mp_fp;
> +#ifdef WITH_ANDROID	
> +	FILE  *cfg_fp;
> +#endif
	FILE *blocklist;

>   	u32 crc;
>   
>   	erofs_init_configure();
> @@ -1173,11 +1177,13 @@ int main(int argc, char **argv)
>   		erofs_err("failed to load fs config %s", cfg.fs_config_file);
>   		return 1;
>   	}
> -
> -	if (cfg.block_list_file &&
> -	    erofs_blocklist_open(cfg.block_list_file, false)) {
> -		erofs_err("failed to open %s", cfg.block_list_file);
> -		return 1;
> +	
> +	if (cfg.block_list_file) {
> +		cfg_fp = fopen(cfg.block_list_file, "w");

		blklst = fopen(cfg.block_list_file, "w");

> +		if (!cfg_fp || erofs_blocklist_open(cfg_fp, false)) {
> +			erofs_err("failed to open %s", cfg.block_list_file);
> +			return 1;
> +		}
>   	}
>   #endif
>   	erofs_show_config();
> @@ -1210,8 +1216,9 @@ int main(int argc, char **argv)
>   		erofstar.dev = rebuild_src_count + 1;
>   
>   		if (erofstar.mapfile) {
> -			err = erofs_blocklist_open(erofstar.mapfile, true);
> -			if (err) {
> +			mp_fp = fopen(erofstar.mapfile, "w");

			blklst = fopen(erofstar.mapfile, "w");

> +			if (!mp_fp || erofs_blocklist_open(mp_fp, true)) {
> +				err = -errno;
>   				erofs_err("failed to open %s", erofstar.mapfile);
>   				goto exit;
>   			}
> @@ -1417,7 +1424,7 @@ exit:
>   		erofs_iput(root);
>   	z_erofs_compress_exit();
>   	z_erofs_dedupe_exit();
> -	erofs_blocklist_close();
> +	fclose(erofs_blocklist_close());

What if erofs_blocklist_close() returns NULL?

	blklst = erofs_blocklist_close();
	if (blklst)
		fclose(blklst);

Thanks,
Gao Xiang

>   	erofs_dev_close(&sbi);
>   	erofs_cleanup_compress_hints();
>   	erofs_cleanup_exclude_rules();
