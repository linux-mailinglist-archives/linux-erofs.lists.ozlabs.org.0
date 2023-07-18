Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574275798D
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 12:50:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4whr2tDVz2ykZ
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 20:50:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4whl46ppz2xwH
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jul 2023 20:50:31 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VnhfSQa_1689677425;
Received: from 30.75.128.123(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnhfSQa_1689677425)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 18:50:26 +0800
Message-ID: <26407933-e821-90bb-5b12-0651729a72dd@linux.alibaba.com>
Date: Tue, 18 Jul 2023 18:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] erofs-utils: inline vle_compressmeta_capacity()
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230718052101.124039-1-jefflexu@linux.alibaba.com>
 <20230718052101.124039-4-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230718052101.124039-4-jefflexu@linux.alibaba.com>
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



On 2023/7/18 13:21, Jingbo Xu wrote:
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   lib/compress.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 6fb63cb..a871322 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -49,14 +49,6 @@ struct z_erofs_vle_compress_ctx {
>   
>   #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
>   
> -static unsigned int vle_compressmeta_capacity(erofs_off_t filesize)
> -{
> -	const unsigned int indexsize = BLK_ROUND_UP(filesize) *
> -		sizeof(struct z_erofs_lcluster_index);
> -
> -	return Z_EROFS_LEGACY_MAP_HEADER_SIZE + indexsize;
> -}
> -
>   static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
>   {
>   	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
> @@ -843,7 +835,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>   	erofs_blk_t blkaddr, compressed_blocks;
>   	unsigned int legacymetasize;
>   	int ret;
> -	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
> +	u8 *compressmeta = malloc(BLK_ROUND_UP(inode->i_size) *
> +				  sizeof(struct z_erofs_lcluster_index) +
> +				  Z_EROFS_LEGACY_MAP_HEADER_SIZE);
>   
>   	if (!compressmeta)
>   		return -ENOMEM;
