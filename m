Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 59737730E04
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 06:20:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhTcK21s4z304q
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 14:20:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhTcG44jDz30PD
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 14:20:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vl9-ymZ_1686802839;
Received: from 30.221.149.215(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl9-ymZ_1686802839)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 12:20:41 +0800
Message-ID: <62aa21a7-283a-4860-2a0a-b23ed38e6424@linux.alibaba.com>
Date: Thu, 15 Jun 2023 12:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] erofs: remove unnecessary goto
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
References: <20230615034539.14286-1-frank.li@vivo.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230615034539.14286-1-frank.li@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 6/15/23 11:45 AM, Yangtao Li wrote:
> It's redundant, let's remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/super.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 811ab66d805e..f48ce692094d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -1016,10 +1016,8 @@ static int __init erofs_module_init(void)
>  					       sizeof(struct erofs_inode), 0,
>  					       SLAB_RECLAIM_ACCOUNT,
>  					       erofs_inode_init_once);
> -	if (!erofs_inode_cachep) {
> -		err = -ENOMEM;
> -		goto icache_err;
> -	}
> +	if (!erofs_inode_cachep)
> +		return -ENOMEM;
>  
>  	err = erofs_init_shrinker();
>  	if (err)
> @@ -1054,7 +1052,6 @@ static int __init erofs_module_init(void)
>  	erofs_exit_shrinker();
>  shrinker_err:
>  	kmem_cache_destroy(erofs_inode_cachep);
> -icache_err:
>  	return err;
>  }
>  

-- 
Thanks,
Jingbo
