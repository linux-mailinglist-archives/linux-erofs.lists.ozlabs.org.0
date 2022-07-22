Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938257DC10
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 10:16:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lq2Mt2m7pz3c7M
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 18:16:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lq2Mp0bjKz302W
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 18:16:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VK4F-Js_1658477787;
Received: from 30.227.66.15(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VK4F-Js_1658477787)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 16:16:27 +0800
Message-ID: <f50081dc-a1e9-2714-77a5-9c17e2334d00@linux.alibaba.com>
Date: Fri, 22 Jul 2022 16:16:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To: Hongnan Li <hongnan.li@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
 <20220629081550.23501-1-hongnan.li@linux.alibaba.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220629081550.23501-1-hongnan.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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

The patch itself looks good to me.


On 6/29/22 4:15 PM, Hongnan Li wrote:
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>  fs/erofs/dir.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..6fc325052853 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -22,10 +22,9 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>  }
>  
>  static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
> -			       void *dentry_blk, unsigned int *ofs,
> +			       void *dentry_blk, struct erofs_dirent *de,
>  			       unsigned int nameoff, unsigned int maxsize)
>  {
> -	struct erofs_dirent *de = dentry_blk + *ofs;
>  	const struct erofs_dirent *end = dentry_blk + nameoff;
>  
>  	while (de < end) {
> @@ -59,9 +58,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>  			/* stopped by some reason */
>  			return 1;
>  		++de;
> -		*ofs += sizeof(struct erofs_dirent);
> +		ctx->pos += sizeof(struct erofs_dirent);
>  	}
> -	*ofs = maxsize;
>  	return 0;
>  }
>  
> @@ -95,7 +93,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  				  "invalid de[0].nameoff %u @ nid %llu",
>  				  nameoff, EROFS_I(dir)->nid);
>  			err = -EFSCORRUPTED;
> -			goto skip_this;
> +			break;
>  		}
>  
>  		maxsize = min_t(unsigned int,
> @@ -106,17 +104,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  			initial = false;
>  
>  			ofs = roundup(ofs, sizeof(struct erofs_dirent));
> +			ctx->pos = blknr_to_addr(i) + ofs;
>  			if (ofs >= nameoff)
>  				goto skip_this;

Besides, I thinks there's another issue with erofs_readdir() here
(though unrelated to the issue this patch wants to fix).

We need to update ctx->pos correctly if the initial file position has
exceeded nameoff. ctx->pos needs to be updated to the end of
EROFS_BLKSIZ or directory's i_size, surpassing the remaining name string
in the current EROFS block.

>  		}
>  
> -		err = erofs_fill_dentries(dir, ctx, de, &ofs,
> +		err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
>  					  nameoff, maxsize);
> -skip_this:
> -		ctx->pos = blknr_to_addr(i) + ofs;
> -
>  		if (err)
>  			break;

> +		ctx->pos = blknr_to_addr(i) + maxsize;

It's quite easy to fix the above issue. We only need to move this line
beneath skip_this label.

> +skip_this:>  		++i;
>  		ofs = 0;
>  	}

like:

	skip_this:
		ctx->pos = blknr_to_addr(i) + maxsize;
		++i;
		ofs = 0;

Thus we'd better fold this simple fix into this patch.

-- 
Thanks,
Jeffle
