Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3785C6EEE11
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 08:09:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q5pND0chkz3cjB
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Apr 2023 16:09:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q5pN96WXtz2xJ6
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 16:08:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vh1oidN_1682489329;
Received: from 30.97.49.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vh1oidN_1682489329)
          by smtp.aliyun-inc.com;
          Wed, 26 Apr 2023 14:08:51 +0800
Message-ID: <a5a39900-9569-59e8-296f-c5f99b737adc@linux.alibaba.com>
Date: Wed, 26 Apr 2023 14:08:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] erofs: get rid of name from struct
 z_erofs_decompressor
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <a0c8b87b5c165750107bbaad6b014c02311b610d.1682481589.git.huyue2@coolpad.com>
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



On 2023/4/26 12:10, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> There are no users of the name and we can get this via ->alg if needed.
> Also, move struct z_erofs_decompressor into decompressor.c which is the
> only one to use it.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

I'd like to avoid z_erofs_decompress() function instead honestly.
name strings might be useful if users would like to get runtime
supported algorithms.

Thanks,
Gao Xiang

> ---
>   fs/erofs/compress.h     | 6 ------
>   fs/erofs/decompressor.c | 9 +++++----
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 26fa170090b8..d161683bda03 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -20,12 +20,6 @@ struct z_erofs_decompress_req {
>   	bool inplace_io, partial_decoding, fillgaps;
>   };
>   
> -struct z_erofs_decompressor {
> -	int (*decompress)(struct z_erofs_decompress_req *rq,
> -			  struct page **pagepool);
> -	char *name;
> -};
> -
>   /* some special page->private (unsigned long, see below) */
>   #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
>   #define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 7021e2cf6146..f416ebd6f0dc 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -363,23 +363,24 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   	return 0;
>   }
>   
> +struct z_erofs_decompressor {
> +	int (*decompress)(struct z_erofs_decompress_req *rq,
> +			  struct page **pagepool);
> +};
> +
>   static struct z_erofs_decompressor decompressors[] = {
>   	[Z_EROFS_COMPRESSION_SHIFTED] = {
>   		.decompress = z_erofs_transform_plain,
> -		.name = "shifted"
>   	},
>   	[Z_EROFS_COMPRESSION_INTERLACED] = {
>   		.decompress = z_erofs_transform_plain,
> -		.name = "interlaced"
>   	},
>   	[Z_EROFS_COMPRESSION_LZ4] = {
>   		.decompress = z_erofs_lz4_decompress,
> -		.name = "lz4"
>   	},
>   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
>   	[Z_EROFS_COMPRESSION_LZMA] = {
>   		.decompress = z_erofs_lzma_decompress,
> -		.name = "lzma"
>   	},
>   #endif
>   };
