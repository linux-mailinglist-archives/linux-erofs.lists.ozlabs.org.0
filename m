Return-Path: <linux-erofs+bounces-1939-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD1D2ECF6
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 10:34:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsvnP40Spz2xSN;
	Fri, 16 Jan 2026 20:34:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768556057;
	cv=none; b=YC6W7mAe5VgWjWhPjkK+0KD+KYq3ynsSpCr5WQzUOELLLREQ6Y9DAGXhHBwLU++mBHCDiMYYffeYkAHe7hwv+zNOufQLe7VQHrDhhoyQ72lFKCx6UdDmpfGjLcpZdAfkb+zbfGusHr8f34PI5iNTXYdSm7/AdGfWLjxRi2JoHBuoVcbIRFf2NBYn3AbvHPjcNGvBzn7w59gagKXV/PmpibCY0j46WaNY3FGlaL5A7My3S0yP3BzB5eIVPaT/VTVDt0czC4FEiUG3ahuuwzxwYERdlRxY3ui2RwtrwkqdwReYiuhJ0DMMaTpcEo3KDQBP/KvDPtyh7jGsIafQuioGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768556057; c=relaxed/relaxed;
	bh=X+7YPDRrsJoSuwHPr3sa1dACsR0GMblOOEvfFI2UzHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzjMJQVC2glK0cJnNmYUWp+MVUVPifVuU3tDnMJGF4d71rWMmIobQMWfj/YEOApLryPO9K/CaIKi6b41+ElwhRG5dztt6h9Qmr814SegyJH20jHGKNuXPSmna/i3dliyVjk9OrGhtYku0qWCGvqVqXmXQIFaKkPxBzjc80A3+fGiYL/NxoKr7bx7THmANFgZev4aOgFAxGB76jfwaIIEdbT8mIjmOpZc2jM+hA66F+RWlGqVxEfIGwLAPIhgv43pl1e+/PB3xqTGM6Vl7PibNTJxXdof5uHnNAxyKjcl0hR7Y/ugiyU19902j7dE0+xqNg+m5gutvj2/fztJjVaXCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yGuUoHNw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yGuUoHNw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsvnM0KWFz2xPL
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 20:34:13 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768556047; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=X+7YPDRrsJoSuwHPr3sa1dACsR0GMblOOEvfFI2UzHc=;
	b=yGuUoHNwpu36+ug22I9L9iCzGsopaaPk3H+l/FwyLVnwvy5Hnc9Uv0mJ+LsWNJP8krW/2xfkYVnVc+GNScslb8/W/2xJlutWNFHVPyvrxIeXAEWrClXhuDJOtSUiQqbwPXt2apq4ZAweMaLxw8nfgEjg4NnZpimMkuSVmr0MdDA=
Received: from 30.221.132.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx9nqnn_1768556043 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 Jan 2026 17:34:04 +0800
Message-ID: <392a98d3-5e31-494c-a013-030f858067ad@linux.alibaba.com>
Date: Fri, 16 Jan 2026 17:34:03 +0800
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
Subject: Re: [PATCH v3] erofs-utils: lib: fix incorrect mtime under
 -Edot-omitted
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <b8540497-50c2-4d4f-8025-060ae6352229@linux.alibaba.com>
 <20260116092340.3691124-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116092340.3691124-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/16 17:23, Yifan Zhao wrote:
> `-Edot-omitted` enables `-E48bits`, which requires specific
> configurations for g_sbi.{epoch, build_time}. Currently, the call to
> `erofs_sb_set_48bit()` occurs too late in the execution flow, causing
> the aforementioned logic to be bypassed and resulting in incorrect
> mtimes for all inodes.
> 
> This patch moves time initialization logic into `erofs_importer_init()`
> to resolve this issue.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   lib/importer.c | 17 +++++++++++++++++
>   mkfs/main.c    | 15 ---------------
>   2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/importer.c b/lib/importer.c
> index 958a433..b62ec20 100644
> --- a/lib/importer.c
> +++ b/lib/importer.c
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> +#include <sys/time.h>
>   #include "erofs/importer.h"
>   #include "erofs/config.h"
>   #include "erofs/dedupe.h"
> @@ -43,6 +44,8 @@ int erofs_importer_init(struct erofs_importer *im)
>   	struct erofs_sb_info *sbi = im->sbi;
>   	struct erofs_importer_params *params = im->params;
>   	const char *subsys = NULL;
> +	struct timeval t;
> +	s64 mkfs_time = 0;
>   	int err;
>   
>   	erofs_importer_global_init();
> @@ -83,6 +86,20 @@ int erofs_importer_init(struct erofs_importer *im)
>   
>   	if (params->dot_omitted)
>   		erofs_sb_set_48bit(sbi);
> +
> +	sbi->fixed_nsec = 0;
> +	if (cfg.c_unix_timestamp != -1) {
> +		mkfs_time = cfg.c_unix_timestamp;

I mean we could

	if (params->mkfs_time != -1) {
		mkfs_time = params->mkfs_time;
		if (erofs_sb_has_48bit(sbi)) {
			sbi->epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
			sbi->build_time = mkfs_time - sbi->epoch;
		} else {
			sbi->epoch = mkfs_time;
		}

	}

> +	} else if (!gettimeofday(&t, NULL)) {
> +		mkfs_time = t.tv_sec;
> +	}
> +	if (erofs_sb_has_48bit(sbi)) {
> +		sbi->epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
> +		sbi->build_time = mkfs_time - sbi->epoch;
> +	} else {
> +		sbi->epoch = mkfs_time;
> +	}
> +
>   	return 0;
>   
>   out_err:
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 620b1ed..6ee7f54 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1710,9 +1710,7 @@ int main(int argc, char **argv)
>   	};
>   	struct erofs_inode *root = NULL;
>   	bool tar_index_512b = false;
> -	struct timeval t;
>   	FILE *blklst = NULL;
> -	s64 mkfs_time = 0;
>   	int err;
>   	u32 crc;
>   
> @@ -1736,19 +1734,6 @@ int main(int argc, char **argv)
>   		goto exit;
>   	}
>   
> -	g_sbi.fixed_nsec = 0;
> -	if (cfg.c_unix_timestamp != -1) {
> -		mkfs_time = cfg.c_unix_timestamp;
> -	} else if (!gettimeofday(&t, NULL)) {
> -		mkfs_time = t.tv_sec;
> -	}
> -	if (erofs_sb_has_48bit(&g_sbi)) {
> -		g_sbi.epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
> -		g_sbi.build_time = mkfs_time - g_sbi.epoch;
> -	} else {
> -		g_sbi.epoch = mkfs_time;
> -	}

And here

	if (cfg.c_unix_timestamp != -1) {
		params->mkfs_time = cfg.c_unix_timestamp;
	else
		params->mkfs_time = !gettimeofday(&t, NULL) ...

	}

Thanks,
Gao Xiang

> -
>   	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
>   				(incremental_mode ? 0 : O_TRUNC));
>   	if (err) {


