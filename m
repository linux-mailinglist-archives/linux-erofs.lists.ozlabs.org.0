Return-Path: <linux-erofs+bounces-1005-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA3B50D0A
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 07:15:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cM85R1Lydz3cjT;
	Wed, 10 Sep 2025 15:15:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757481307;
	cv=none; b=OQxcxoZecwhZUOHWYZK7BEkxH7kjQvr/PAixP6IF7AVVjaEaKK5Pw/GaLFm2MmdkWIINYcv+C9ho2Cq9Bt8QAGyGFO8vk7BhkMfYmGReUsOAllAyLs6rwmiAaieURo/KbOKuoQF4w/7bZWHv/Iin4og12SMGqRX7MvWQlKELqTRKZhTkKMHlB76OpfG92N20zVFDsuHNiV92cj4Zyu+vHkXeprSuECmcXtfUXUw3YuyUwnlqa8fWoePSzKxWOQ9FnKgZisBTCKgWmTsGxrGm75zI9TfemF2h5Fq82GI8bCo9oumjirkjkX9k0U0kunzGCw4EIi73E3vLu/AmgcvAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757481307; c=relaxed/relaxed;
	bh=ecPtV8F80iX/BJ7gO++d1VESS8eQFjAzOn6DogwmrpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnZU0EfdexYaiRuzFq7PCHUbDzJmCpFMVG5W1d52hc+lo5sm+tzEfHRXHxeCiV7YCNiflv1UDvyXYGXXiN4I5EIGZ/ESf+S6Sf3KOFiO5Por+ST5n1t7SgQH5fwishuAorZHfLXXkbB2UuuRKNDhguZFl54SM1dFYaXzovro4AE0uEZO74cDVf+RyDx4jCMA9mEzMwCI+FGYHxMu7KXbY/UUlo9UPC0ns/ru1Mkgn0+5zUDBAR4jlw6PdaTMHxkbUMNueNmvs0LPa2Lw/b7BIIw3ScYUaSSPJhDL16K06v57PQivP1DPYWwvMLx9FSpYhVXce8gKDKaZB678OAFJTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PjRED0zi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PjRED0zi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cM85P6Scrz3cjR
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Sep 2025 15:15:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757481300; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ecPtV8F80iX/BJ7gO++d1VESS8eQFjAzOn6DogwmrpE=;
	b=PjRED0ziPlpw1bTlgJqhTJkpfv7nM64zqnXmNRCzVzJwGOl/vS8OPio3I3HWx4cbzC9bauumSDxjwJpJi+iuSMIof0a0Tbxcv/WKIGXKT9y3W+nw7jj0bIzbM0XodVX3JHuqFddQF9e+TGdL6gifh/um5S+BDNvXH41MQ+myxzA=
Received: from 30.221.131.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WngfqHd_1757481298 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 13:14:59 +0800
Message-ID: <e0835c8b-83f3-41bf-bf67-f163b4cfb229@linux.alibaba.com>
Date: Wed, 10 Sep 2025 13:14:58 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: fix memory leaks and allocation issue
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250910050545.735649-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250910050545.735649-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/10 13:05, Yuezhang Mo wrote:
> This patch addresses 4 memory leaks and 1 allocation issue to
> ensure proper cleanup and allocation:
> 
> 1. Fixed memory leak by freeing sbi->zmgr in z_erofs_compress_exit().
> 2. Fixed memory leak by freeing inode->chunkindexes in erofs_iput().
> 3. Fixed incorrect allocation of chunk index array in
>     erofs_rebuild_write_blob_index() to ensure correct array allocation
>     and avoid out-of-bounds access.
> 4. Fixed memory leak of struct erofs_blobchunk not being freed by
>     calling erofs_blob_exit() in rebuild mode.
> 5. Fixed memory leak caused by repeated initialization of the first
>     blob device's sbi by checking whether sbi has been initialized.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   lib/compress.c |  2 ++
>   lib/inode.c    |  3 +++
>   lib/rebuild.c  | 13 ++++++++-----
>   mkfs/main.c    |  2 +-
>   4 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 622a205..dd537ec 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -2171,5 +2171,7 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
>   		}
>   #endif
>   	}
> +
> +	free(sbi->zmgr);
>   	return 0;
>   }
> diff --git a/lib/inode.c b/lib/inode.c
> index 7ee6b3d..38e2bb2 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -159,6 +159,9 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>   	} else {
>   		free(inode->i_link);
>   	}
> +
> +	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
> +		free(inode->chunkindexes);
>   	free(inode);
>   	return 0;
>   }
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index 0358567..461e18e 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -186,7 +186,7 @@ static int erofs_rebuild_write_blob_index(struct erofs_sb_info *dst_sb,
>   
>   	unit = sizeof(struct erofs_inode_chunk_index);
>   	inode->extent_isize = count * unit;
> -	idx = malloc(max(sizeof(*idx), sizeof(void *)));
> +	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
>   	if (!idx)
>   		return -ENOMEM;
>   	inode->chunkindexes = idx;
> @@ -428,10 +428,13 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
>   		erofs_uuid_unparse_lower(sbi->uuid, uuid_str);
>   		fsid = uuid_str;
>   	}
> -	ret = erofs_read_superblock(sbi);
> -	if (ret) {
> -		erofs_err("failed to read superblock of %s", fsid);
> -		return ret;
> +
> +	if (!sbi->devs) {

`sbi->devs` may be NULL if ondisk_extradevs == 0? (see
erofs_init_devices()).

I think we could just introduce a new `sbi->sb_valid`
boolean, and set up this in erofs_read_superblock()
instead in the short term.

Thanks,
Gao Xiang

> +		ret = erofs_read_superblock(sbi);
> +		if (ret) {
> +			erofs_err("failed to read superblock of %s", fsid);
> +			return ret;
> +		}
>   	}
>   
>   	inode.nid = sbi->root_nid;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 28588db..3dd5815 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1908,7 +1908,7 @@ exit:
>   	erofs_dev_close(&g_sbi);
>   	erofs_cleanup_compress_hints();
>   	erofs_cleanup_exclude_rules();
> -	if (cfg.c_chunkbits)
> +	if (cfg.c_chunkbits || source_mode == EROFS_MKFS_SOURCE_REBUILD)
>   		erofs_blob_exit();
>   	erofs_xattr_cleanup_name_prefixes();
>   	erofs_rebuild_cleanup();


