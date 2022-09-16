Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C036F5BA46F
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 04:02:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTHQ35lxXz3bc8
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 12:02:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTHPw5J81z2yQg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 12:02:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPuphHW_1663293726;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPuphHW_1663293726)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 10:02:07 +0800
Message-ID: <cf7c0f78-abaa-de56-3809-17c510018ed5@linux.alibaba.com>
Date: Fri, 16 Sep 2022 10:02:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 2/6] erofs: code clean up for fscache
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-3-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-3-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/15/22 8:42 PM, Jia Zhu wrote:

> @@ -502,12 +493,19 @@ int erofs_fscache_register_fs(struct super_block *sb)
>  	volume = fscache_acquire_volume(name, NULL, NULL, 0);
>  	if (IS_ERR_OR_NULL(volume)) {
>  		erofs_err(sb, "failed to register volume for %s", name);
> -		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> -		volume = NULL;
> +		kfree(name);
> +		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
>  	}
>  
>  	sbi->volume = volume;
>  	kfree(name);
> +
> +	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
> +	/* acquired volume will be relinquished in kill_sb() */
> +	if (IS_ERR(fscache))
> +		return PTR_ERR(fscache);
> +
> +	sbi->s_fscache = fscache;
>  	return ret;

The local variable "ret" is not used in this case.


> @@ -889,7 +885,6 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi->opt.fsid);
>  	kfree(sbi);
> @@ -909,7 +904,8 @@ static void erofs_put_super(struct super_block *sb)
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
>  #endif
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
> +	erofs_fscache_unregister_fs(sb);

> +	sbi->s_fscache = NULL;

This line is not needed since we already call
erofs_fscache_unregister_fs() here.


With these fixed:
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
