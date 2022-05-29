Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1DD536FFE
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 08:26:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9pTS5SdKz3bkn
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 16:26:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u9zJW5in;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u9zJW5in;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9pTP4tqqz2yw0
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 16:26:17 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 30642B8085F;
	Sun, 29 May 2022 06:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C0CC385A9;
	Sun, 29 May 2022 06:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653805573;
	bh=UF+6G0/96AH95hL9450x59das5x8gxwXIY/JTdRDlwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u9zJW5inNplLlRKcX5fmLYWIkbJ6m3I8J5RY5q6YQfEV/AECd0wP6Is8IE2coQWvY
	 PCbV87akiusFFcooKNI3wTf8jKMGV7t80GsDQhO559YRGTwaagVkV1HBgshMd+aEE2
	 msOC+lnEok+LO8uTehCduUoZXO9pzf0o0l+euyS2GcfUjx9X15BezvIS1Tn2RIEsTX
	 AGju8X3aacSOAMzu7R3bMNIh2yGdjqzOOpQNA5wQVFKoS8gsx3zx3YN99JXYUBgyyL
	 ahg1drB3foK2/5gTLiTihu3ou9R8yQ9/Pu9sV2r+BJ6WYJvWOi4k9WIMpA8R929v+A
	 2Wf9l4Qj3ZWnw==
Message-ID: <fbb1ba90-a9f7-cd83-3bb4-700eff3b2497@kernel.org>
Date: Sun, 29 May 2022 14:26:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To: Hongnan Li <hongnan.li@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/5/27 15:25, Hongnan Li wrote:
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>   fs/erofs/dir.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..3015974fe2ff 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -22,11 +22,12 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>   }
>   
>   static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
> -			       void *dentry_blk, unsigned int *ofs,
> +			       void *dentry_blk, void *dentry_begin,
>   			       unsigned int nameoff, unsigned int maxsize)
>   {
> -	struct erofs_dirent *de = dentry_blk + *ofs;
> +	struct erofs_dirent *de = dentry_begin;
>   	const struct erofs_dirent *end = dentry_blk + nameoff;
> +	loff_t begin_pos = ctx->pos;
>   
>   	while (de < end) {
>   		const char *de_name;
> @@ -59,9 +60,9 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   			/* stopped by some reason */
>   			return 1;
>   		++de;
> -		*ofs += sizeof(struct erofs_dirent);
> +		ctx->pos += sizeof(struct erofs_dirent);
>   	}
> -	*ofs = maxsize;
> +	ctx->pos = begin_pos + maxsize;
>   	return 0;
>   }
>   
> @@ -110,11 +111,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   				goto skip_this;
>   		}
>   
> -		err = erofs_fill_dentries(dir, ctx, de, &ofs,
> +		err = erofs_fill_dentries(dir, ctx, de, de + ofs,
>   					  nameoff, maxsize);
>   skip_this:

I guess there are two paths may be affected in erofs_readdir():
- for EFSCORRUPTED case, how about avoiding "goto skip_this" since we
can just break there.
- for initial case, do we need to update ctx->pos as well?

Thanks,

> -		ctx->pos = blknr_to_addr(i) + ofs;
> -
>   		if (err)
>   			break;
>   		++i;
