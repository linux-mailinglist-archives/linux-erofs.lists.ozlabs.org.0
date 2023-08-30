Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459E78E34C
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 01:34:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rbgcm56Zpz2ys8
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 09:34:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rbgch3zZJz2yDM
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 09:34:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vqw4w7k_1693438475;
Received: from 30.27.80.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vqw4w7k_1693438475)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 07:34:36 +0800
Message-ID: <2d3a4abe-c23c-795e-2042-0033a474bd95@linux.alibaba.com>
Date: Thu, 31 Aug 2023 07:34:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] erofs-utils: Relax the hardchecks on the blocksize
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20230830231606.3783734-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230830231606.3783734-1-dhavale@google.com>
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
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2023/8/31 07:16, Sandeep Dhavale wrote:
> As erofs-utils supports different block sizes upto
> EROFS_MAX_BLOCK_SIZE, relax the checks so same tools
> can be used to create images for platforms where
> page size can be greater than 4096.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
>   lib/namei.c | 2 --
>   mkfs/main.c | 9 +++++----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/namei.c b/lib/namei.c
> index 2bb1d4c..45dbcd3 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -144,8 +144,6 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   		vi->u.chunkbits = sbi->blkszbits +
>   			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>   	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
> -		if (erofs_blksiz(vi->sbi) != EROFS_MAX_BLOCK_SIZE)
> -			return -EOPNOTSUPP;
>   		return z_erofs_fill_inode(vi);
>   	}
>   	return 0;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index c03a7a8..37bf658 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -550,10 +550,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   		cfg.c_dbg_lvl = EROFS_ERR;
>   		cfg.c_showprogress = false;
>   	}
> -	if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) != EROFS_MAX_BLOCK_SIZE) {
> -		erofs_err("compression is unsupported for now with block size %u",
> -			  erofs_blksiz(&sbi));
> -		return -EINVAL;
> +	if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) != getpagesize()) {
> +		erofs_warn("subpage blocksize with compression is not yet "
> +			"supported. Compressed image will only work with "
> +			"arch pagesize = blocksize = %u bytes",
> +			erofs_blksiz(&sbi));
>   	}

Thanks for the patches.

I'm fine to relax  EROFS_MAX_BLOCK_SIZE check, yet could we
add a check as erofs_blksiz <= EROFS_MAX_BLOCK_SIZE somewhere?

Otherwise, we could suffer from stack overflow
(if EROFS_MAX_BLOCK_SIZE is outdated or somewhat small...)

Thanks,
Gao Xiang
