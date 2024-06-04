Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C678FB24F
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 14:33:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EDOZOP6k;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vtqkq1sT9z3cWm
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jun 2024 22:33:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EDOZOP6k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vtqkf1PbYz3cTP
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jun 2024 22:33:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717504388; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vxIG2R55s4yY7prg9Nc5naXQ08DlMj845U2a75WllnY=;
	b=EDOZOP6knsuNszA63IZsg19B00+HD9bqhk1dkxX6TNwNSjBcZLFnq4cyGNNqn9l93XoK4pDBly+l87cmeNkcWfNtd3Gp7jk+OI3EywQikGJlToi4q+eqN6hgPYcdoL+BLvMW1w3/qkzN0y9pMv+d+VSEAxUHc4ayOdplVYwVnAM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7r6a2G_1717504385;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7r6a2G_1717504385)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 20:33:06 +0800
Message-ID: <2911d7ae-1724-49e1-9ac3-3cc0801fdbcb@linux.alibaba.com>
Date: Tue, 4 Jun 2024 20:33:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9.y] erofs: avoid allocating DEFLATE streams before
 mounting
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

ping? Do these backport fixes miss the 6.6, 6.8, 6.9 queues..

Thanks,
Gao XIang

On 2024/5/30 17:21, Gao Xiang wrote:
> commit 80eb4f62056d6ae709bdd0636ab96ce660f494b2 upstream.
> 
> Currently, each DEFLATE stream takes one 32 KiB permanent internal
> window buffer even if there is no running instance which uses DEFLATE
> algorithm.
> 
> It's unexpected and wasteful on embedded devices with limited resources
> and servers with hundreds of CPU cores if DEFLATE is enabled but unused.
> 
> Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
> Cc: <stable@vger.kernel.org> # 6.6+
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Link: https://lore.kernel.org/r/20240520090106.2898681-1-hsiangkao@linux.alibaba.com
> ---
>   fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
> index 81e65c453ef0..3a3461561a3c 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -46,39 +46,15 @@ int __init z_erofs_deflate_init(void)
>   	/* by default, use # of possible CPUs instead */
>   	if (!z_erofs_deflate_nstrms)
>   		z_erofs_deflate_nstrms = num_possible_cpus();
> -
> -	for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
> -	     ++z_erofs_deflate_avail_strms) {
> -		struct z_erofs_deflate *strm;
> -
> -		strm = kzalloc(sizeof(*strm), GFP_KERNEL);
> -		if (!strm)
> -			goto out_failed;
> -
> -		/* XXX: in-kernel zlib cannot shrink windowbits currently */
> -		strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
> -		if (!strm->z.workspace) {
> -			kfree(strm);
> -			goto out_failed;
> -		}
> -
> -		spin_lock(&z_erofs_deflate_lock);
> -		strm->next = z_erofs_deflate_head;
> -		z_erofs_deflate_head = strm;
> -		spin_unlock(&z_erofs_deflate_lock);
> -	}
>   	return 0;
> -
> -out_failed:
> -	erofs_err(NULL, "failed to allocate zlib workspace");
> -	z_erofs_deflate_exit();
> -	return -ENOMEM;
>   }
>   
>   int z_erofs_load_deflate_config(struct super_block *sb,
>   			struct erofs_super_block *dsb, void *data, int size)
>   {
>   	struct z_erofs_deflate_cfgs *dfl = data;
> +	static DEFINE_MUTEX(deflate_resize_mutex);
> +	static bool inited;
>   
>   	if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
>   		erofs_err(sb, "invalid deflate cfgs, size=%u", size);
> @@ -89,9 +65,36 @@ int z_erofs_load_deflate_config(struct super_block *sb,
>   		erofs_err(sb, "unsupported windowbits %u", dfl->windowbits);
>   		return -EOPNOTSUPP;
>   	}
> +	mutex_lock(&deflate_resize_mutex);
> +	if (!inited) {
> +		for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
> +		     ++z_erofs_deflate_avail_strms) {
> +			struct z_erofs_deflate *strm;
> +
> +			strm = kzalloc(sizeof(*strm), GFP_KERNEL);
> +			if (!strm)
> +				goto failed;
> +			/* XXX: in-kernel zlib cannot customize windowbits */
> +			strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
> +			if (!strm->z.workspace) {
> +				kfree(strm);
> +				goto failed;
> +			}
>   
> +			spin_lock(&z_erofs_deflate_lock);
> +			strm->next = z_erofs_deflate_head;
> +			z_erofs_deflate_head = strm;
> +			spin_unlock(&z_erofs_deflate_lock);
> +		}
> +		inited = true;
> +	}
> +	mutex_unlock(&deflate_resize_mutex);
>   	erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your own risk!");
>   	return 0;
> +failed:
> +	mutex_unlock(&deflate_resize_mutex);
> +	z_erofs_deflate_exit();
> +	return -ENOMEM;
>   }
>   
>   int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
