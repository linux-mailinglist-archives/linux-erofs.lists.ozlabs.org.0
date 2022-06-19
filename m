Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E86D5507A9
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Jun 2022 02:19:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LQYLf292fz3bs0
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Jun 2022 10:19:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lpwSoKfT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lpwSoKfT;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LQYLW6kfLz3bhf
	for <linux-erofs@lists.ozlabs.org>; Sun, 19 Jun 2022 10:19:31 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 41DE160AE7;
	Sun, 19 Jun 2022 00:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C371BC3411A;
	Sun, 19 Jun 2022 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655597967;
	bh=O+ZM0Cqi3Uuf67Id2quo+Fg1yOGML3ldASAxDhGo5Rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lpwSoKfTLpwYlyWtUcBvaxcEx57QevVx86/RiKuwR1uZKMNsxCAmAL29HhlNP9N2G
	 VsI9bWwIRCOmgKYr8uYXIUI5Q0HDTlkPCoDN9w4XTW1NrMqTWk8NA24g1y1ymIuq0Z
	 x5L8FGe6Hb5qmNrbOXcBbSXGCKbsT2ElamEty7/wsSt9aQKWahwwDQsUiJH1l4z+AI
	 zgmTyaEdqkrkhmBO3I2nsXteph/IDSj4BErcMC4VArtJryvHB30fPWEAhQtQ4kbhCW
	 ioyyLa8xOHr5GzkIEdEk9zjtYJ87uePMP6zNtNbbS78MGNmeChQxU/ub2dwixVCBdi
	 Sy+FUECcrDfSw==
Message-ID: <0c139517-e976-5017-8e7a-d34c38f0f6bb@kernel.org>
Date: Sun, 19 Jun 2022 08:19:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To: Hongnan Li <hongnan.li@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
 <20220609034006.76649-1-hongnan.li@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220609034006.76649-1-hongnan.li@linux.alibaba.com>
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

On 2022/6/9 11:40, Hongnan Li wrote:
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>   fs/erofs/dir.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..94ef5287237a 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -22,10 +22,9 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>   }
>   
>   static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
> -			       void *dentry_blk, unsigned int *ofs,
> +			       void *dentry_blk, struct erofs_dirent *de,
>   			       unsigned int nameoff, unsigned int maxsize)
>   {
> -	struct erofs_dirent *de = dentry_blk + *ofs;
>   	const struct erofs_dirent *end = dentry_blk + nameoff;
>   
>   	while (de < end) {
> @@ -59,9 +58,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>   			/* stopped by some reason */
>   			return 1;
>   		++de;
> -		*ofs += sizeof(struct erofs_dirent);
> +		ctx->pos += sizeof(struct erofs_dirent);
>   	}
> -	*ofs = maxsize;
>   	return 0;
>   }
>   
> @@ -95,7 +93,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   				  "invalid de[0].nameoff %u @ nid %llu",
>   				  nameoff, EROFS_I(dir)->nid);
>   			err = -EFSCORRUPTED;
> -			goto skip_this;
> +			break;
>   		}
>   
>   		maxsize = min_t(unsigned int,
> @@ -106,17 +104,19 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			initial = false;
>   
>   			ofs = roundup(ofs, sizeof(struct erofs_dirent));
> -			if (ofs >= nameoff)
> +			if (ofs >= nameoff) {
> +				ctx->pos = blknr_to_addr(i) + ofs;
>   				goto skip_this;
> +			}
>   		}
>   
> -		err = erofs_fill_dentries(dir, ctx, de, &ofs,
> -					  nameoff, maxsize);
> -skip_this:
>   		ctx->pos = blknr_to_addr(i) + ofs;

Why updating ctx->pos before erofs_fill_dentries()?

Thanks,

> -
> +		err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
> +					  nameoff, maxsize);
>   		if (err)
>   			break;
> +		ctx->pos = blknr_to_addr(i) + maxsize;
> +skip_this:
>   		++i;
>   		ofs = 0;
>   	}
