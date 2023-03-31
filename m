Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617CF6D15B8
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 04:44:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pnl3d3BZhz3fRS
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Mar 2023 13:43:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pnl3W5Rcwz3cNN
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Mar 2023 13:43:50 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vf0Oh9r_1680230623;
Received: from 30.221.134.33(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vf0Oh9r_1680230623)
          by smtp.aliyun-inc.com;
          Fri, 31 Mar 2023 10:43:45 +0800
Message-ID: <10420fbe-a0f2-fd3f-8c04-068c7ce9faab@linux.alibaba.com>
Date: Fri, 31 Mar 2023 10:43:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/8] erofs: simplify erofs_xattr_generic_get()
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
 <20230330082910.125374-4-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230330082910.125374-4-jefflexu@linux.alibaba.com>
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



On 2023/3/30 16:29, Jingbo Xu wrote:
> erofs_xattr_generic_get() won't be called from xattr handlers other than
> user/trusted/security xattr handler, and thus there's no need of extra
> checking.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I plan to apply these three patches to -next first, and then look into
the rests.

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index dc36a0c0919c..d76b74ece2e5 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -432,20 +432,9 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
>   				   const char *name, void *buffer, size_t size)
>   {
> -	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> -
> -	switch (handler->flags) {
> -	case EROFS_XATTR_INDEX_USER:
> -		if (!test_opt(&sbi->opt, XATTR_USER))
> -			return -EOPNOTSUPP;
> -		break;
> -	case EROFS_XATTR_INDEX_TRUSTED:
> -		break;
> -	case EROFS_XATTR_INDEX_SECURITY:
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	if (handler->flags == EROFS_XATTR_INDEX_USER &&
> +	    !test_opt(&EROFS_I_SB(inode)->opt, XATTR_USER))
> +		return -EOPNOTSUPP;
>   
>   	return erofs_getxattr(inode, handler->flags, name, buffer, size);
>   }
