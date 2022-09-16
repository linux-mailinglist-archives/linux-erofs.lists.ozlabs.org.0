Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BD5BA4D8
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 04:57:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTJdP1MMMz3bcF
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 12:57:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTJdK5rdCz2yWK
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 12:57:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPv9JoO_1663297022;
Received: from 30.221.130.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPv9JoO_1663297022)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 10:57:03 +0800
Message-ID: <1c2d28ba-bf4e-cef8-daf8-dc11813b0c4d@linux.alibaba.com>
Date: Fri, 16 Sep 2022 10:57:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH V4 3/6] erofs: introduce fscache-based domain
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
 <20220915124213.25767-4-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220915124213.25767-4-zhujia.zj@bytedance.com>
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

>  struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>  						     char *name, bool need_inode)
>  {
> @@ -481,27 +578,18 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  int erofs_fscache_register_fs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct fscache_volume *volume;
>  	struct erofs_fscache *fscache;
> -	char *name;
> -	int ret = 0;
> -
> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
> -	if (!name)
> -		return -ENOMEM;
> -
> -	volume = fscache_acquire_volume(name, NULL, NULL, 0);
> -	if (IS_ERR_OR_NULL(volume)) {
> -		erofs_err(sb, "failed to register volume for %s", name);
> -		kfree(name);
> -		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> -	}
> +	int ret;
>  
> -	sbi->volume = volume;
> -	kfree(name);
> +	if (sbi->opt.domain_id)
> +		ret = erofs_fscache_register_domain(sb);
> +	else
> +		ret = erofs_fscache_register_volume(sb);
> +	if (ret)
> +		return ret;
>  
> +	/* acquired domain/volume will be relinquished in kill_sb() if error occurs */

"... in kill_sb() on error" is better to make this line within 80 chars
length.


>  	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
> -	/* acquired volume will be relinquished in kill_sb() */
>  	if (IS_ERR(fscache))
>  		return PTR_ERR(fscache);
>  


-- 
Thanks,
Jingbo
