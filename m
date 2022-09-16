Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 299CA5BA58A
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 05:45:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTKj41BbGz2xrH
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 13:45:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.18; helo=out199-18.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTKhz6x1Tz3023
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 13:45:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPvH1tx_1663299912;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPvH1tx_1663299912)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 11:45:14 +0800
Message-ID: <1ccf326e-dd47-d5cf-02ab-5f033892a7d4@linux.alibaba.com>
Date: Fri, 16 Sep 2022 11:45:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 5/6] erofs: Support sharing cookies in the same domain
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-6-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-6-zhujia.zj@bytedance.com>
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

> +static
> +struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
> +							char *name, bool need_inode)
> +{
> +	int err;
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_domain *domain = EROFS_SB(sb)->domain;
> +
> +	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
> +	if (IS_ERR(ctx))
> +		return ctx;
> +
> +	ctx->name = kstrdup(name, GFP_KERNEL);
> +	if (!ctx->name) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> +	if (!inode) {
> +		kfree(ctx->name);
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ctx->domain = domain;
> +	ctx->anon_inode = inode;
> +	inode->i_private = ctx;
> +	refcount_inc(&domain->ref);
> +	return ctx;
> +out:
> +	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> +	fscache_relinquish_cookie(ctx->cookie, false);
> +	if (need_inode)
> +		iput(ctx->inode);
> +	kfree(ctx);
> +	return ERR_PTR(err);

Could you please abstract the cleanup logic into one helper? like:

erofs_fscache_relinquish_cookie()
{
	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
	fscache_relinquish_cookie(ctx->cookie, false);
	iput(ctx->inode);
	kfree(ctx->name);
	kfree(ctx);
}

which could also be called in erofs_fscache_unregister_cookie().


>  void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  {
> +	bool drop;
> +	struct erofs_domain *domain;
> +
>  	if (!ctx)
>  		return;
> +	domain = ctx->domain;
> +	if (domain) {
> +		mutex_lock(&erofs_domain_cookies_lock);
> +		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
> +		iput(ctx->anon_inode);
> +		mutex_unlock(&erofs_domain_cookies_lock);
> +		if (!drop)
> +			return;
> +	}
>  
>  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>  	fscache_relinquish_cookie(ctx->cookie, false);
> +	erofs_fscache_domain_put(domain);
>  	iput(ctx->inode);
> +	kfree(ctx->name);
>  	kfree(ctx);
>  }


-- 
Thanks,
Jingbo
