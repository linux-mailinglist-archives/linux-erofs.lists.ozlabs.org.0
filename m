Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A778B6AD0
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 08:46:49 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GjHET5Pa;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VT9j269hhz3cLL
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:46:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GjHET5Pa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VT9hx2JGsz2xWS
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Apr 2024 16:46:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714459596; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SgrXizQyet6Z35s8jtxf+bISIIHpF/7qNfdlS3JYZTA=;
	b=GjHET5PaNcrsMf1lbQyS64W3uD98ItdqVHWVRud8gmVJQmm7kjg9dh7ykOvwiBcDOxdGMKaKeL8wtSvMQYkI/SfoanzFar0gFNRJSYDfjIHP/JG41Y0wr5sg78lGXBecZsERoUDFEUgpVnmGS1GLQHwRR4w/iK5uk1jAPbmTw/4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5bMAMz_1714459592;
Received: from 30.221.130.24(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5bMAMz_1714459592)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 14:46:34 +0800
Message-ID: <6a5fa61f-de92-4d66-aafc-bae9656f58e5@linux.alibaba.com>
Date: Tue, 30 Apr 2024 14:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: simplify file handling
To: Noboru Asai <asai@sijam.com>
References: <20240430063731.1013892-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240430063731.1013892-1-asai@sijam.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Noboru,

On 2024/4/30 14:37, Noboru Asai wrote:
> Opening files again when data compression doesn't save space,
> simplify file handling.
> 
> * remove dup and lseek.
> * call pthread_cond_signal once per file.
> 
> I think the probability of the above case occurring is a few percent.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>
> ---
>   lib/compress.c | 11 ++++++-----
>   lib/inode.c    | 24 ++++++++++++------------
>   2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 7fef698..4c7351f 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -1261,8 +1261,10 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
>   out:
>   	cwork->errcode = ret;
>   	pthread_mutex_lock(&ictx->mutex);
> -	++ictx->nfini;
> -	pthread_cond_signal(&ictx->cond);
> +	if (++ictx->nfini == ictx->seg_num) {
> +		close(ictx->fd);

Thanks for the patch.

I think it's better to close fd in the main writer thread
(erofs_mt_write_compressed_file) rather than some random
compression worker.

> +		pthread_cond_signal(&ictx->cond);

Could you send this fix seperately, also I'm not sure if
it could be some benefits to merge segments in advance
(maybe in bulk) without waiting all tasks finished.

But I may not have enough time to work on this for now..
If you have some interest, I think it's worth doing..

> +	}
>   	pthread_mutex_unlock(&ictx->mutex);
>   }
>   
> @@ -1406,7 +1408,6 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
>   			blkaddr - compressed_blocks, compressed_blocks);
>   
>   out:
> -	close(ictx->fd);
>   	free(ictx);
>   	return ret;
>   }
> @@ -1456,7 +1457,6 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
>   		ictx = malloc(sizeof(*ictx));
>   		if (!ictx)
>   			return ERR_PTR(-ENOMEM);
> -		ictx->fd = dup(fd);
>   	} else {
>   #ifdef EROFS_MT_ENABLED
>   		pthread_mutex_lock(&g_ictx.mutex);
> @@ -1466,8 +1466,8 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
>   		pthread_mutex_unlock(&g_ictx.mutex);
>   #endif
>   		ictx = &g_ictx;
> -		ictx->fd = fd;
>   	}
> +	ictx->fd = fd;
>   
>   	ictx->ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
>   	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
> @@ -1551,6 +1551,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
>   	init_list_head(&sctx.extents);
>   
>   	ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
> +	close(ictx->fd);
>   	if (ret)
>   		goto err_free_idata;
>   
> diff --git a/lib/inode.c b/lib/inode.c
> index 44d684f..a30975b 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1112,27 +1112,27 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
>   struct erofs_mkfs_job_ndir_ctx {
>   	struct erofs_inode *inode;
>   	void *ictx;
> -	int fd;
>   };
>   
>   static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
>   {
>   	struct erofs_inode *inode = ctx->inode;
> +	int fd;
>   	int ret;
>   
>   	if (ctx->ictx) {
>   		ret = erofs_write_compressed_file(ctx->ictx);
>   		if (ret != -ENOSPC)
> -			goto out;
> -		if (lseek(ctx->fd, 0, SEEK_SET) < 0) {
> -			ret = -errno;
> -			goto out;
> -		}
> +			return ret;
>   	}
> +
>   	/* fallback to all data uncompressed */
> -	ret = erofs_write_unencoded_file(inode, ctx->fd, 0);
> -out:
> -	close(ctx->fd);
> +	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);

At a quick glance, here we need to open i_srcpath again, I tend to
avoid it so I use dup instead.

Thanks,
Gao Xiang
