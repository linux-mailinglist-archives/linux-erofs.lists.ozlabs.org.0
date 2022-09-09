Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D635B34A1
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 11:55:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPBFj1tJdz3bYS
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 19:55:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPBFd5S7mz2xgN
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 19:55:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VP9-zDX_1662717341;
Received: from 30.221.130.74(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VP9-zDX_1662717341)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:55:42 +0800
Message-ID: <3f75d266-7ccd-be6d-657c-fe0633b25687@linux.alibaba.com>
Date: Fri, 9 Sep 2022 17:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 4/5] erofs: remove duplicated unregister_cookie
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-5-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220902105305.79687-5-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/2/22 6:53 PM, Jia Zhu wrote:
> In erofs umount scenario, erofs_fscache_unregister_cookie() is called
> twice in kill_sb() and put_super().
> 
> It works for original semantics, cause 'ctx' will be set to NULL in
> put_super() and will not be unregister again in kill_sb().
> However, in shared domain scenario, we use refcount to maintain the
> lifecycle of cookie. Unregister the cookie twice will cause it to be
> released early.
> 
> For the above reasons, this patch removes duplicate unregister_cookie
> and move fscache_unregister_* before shotdown_super() to prevent busy
> inode(ctx->inode) when umount.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/super.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 69de1731f454..667a78f0ee70 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -919,19 +919,20 @@ static void erofs_kill_sb(struct super_block *sb)
>  		kill_litter_super(sb);
>  		return;
>  	}
> -	if (erofs_is_fscache_mode(sb))
> -		generic_shutdown_super(sb);
> -	else
> -		kill_block_super(sb);
> -
>  	sbi = EROFS_SB(sb);
>  	if (!sbi)
>  		return;
>  
> +	if (erofs_is_fscache_mode(sb)) {
> +		erofs_fscache_unregister_cookie(&sbi->s_fscache);
> +		erofs_fscache_unregister_fs(sb);
> +		generic_shutdown_super(sb);

Generally we can't do clean ups before generic_shutdown_super(), since
generic_shutdown_super() may trigger IO, e.g. in sync_filesystem(),
though it's not the case for erofs (read-only).

How about embedding erofs_fscache_unregister_cookie() into
erofs_fscache_unregister_fs(), and thus we can check domain_id in
erofs_fscache_unregister_fs()?

> +	} else {
> +		kill_block_super(sb);
> +	}
> +
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
> -	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi->opt.fsid);
>  	kfree(sbi->opt.domain_id);
>  	kfree(sbi);
> @@ -951,7 +952,6 @@ static void erofs_put_super(struct super_block *sb)
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
>  #endif
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  }
>  
>  struct file_system_type erofs_fs_type = {

-- 
Thanks,
Jingbo
