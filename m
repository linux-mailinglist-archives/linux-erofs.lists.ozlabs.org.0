Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC645F8488
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Oct 2022 11:06:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MkznY0vCfz3bls
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Oct 2022 20:06:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MkznT54MQz2y8J
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Oct 2022 20:06:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VRc0d2._1665219991;
Received: from 30.221.130.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VRc0d2._1665219991)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 17:06:32 +0800
Message-ID: <4fbf60f5-4ed1-3dd8-e4d3-de796e701956@linux.alibaba.com>
Date: Sat, 8 Oct 2022 17:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 2/5] cachefiles: extract ondemand info field from
 cachefiles_object
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com, xiang@kernel.org
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-3-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818135204.49878-3-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 8/18/22 9:52 PM, Jia Zhu wrote:

>  /*
>   * Backing file state.
>   */
> @@ -67,8 +73,7 @@ struct cachefiles_object {
>  	unsigned long			flags;
>  #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
>  #ifdef CONFIG_CACHEFILES_ONDEMAND
> -	int				ondemand_id;
> -	enum cachefiles_object_state	state;
> +	void				*private;
>  #endif
>  };

Personally I would prefer

	struct cachefiles_object {
		...
	#ifdef CONFIG_CACHEFILES_ONDEMAND
		struct cachefiles_ondemand_info *private;
	#endif
	}

and

> @@ -88,6 +93,7 @@ void cachefiles_put_object(struct cachefiles_object
*object,
>  		ASSERTCMP(object->file, ==, NULL);
>
>  		kfree(object->d_name);
> + #ifdef CONFIG_CACHEFILES_ONDEMAND
> +		kfree(object->private);
> + #endif
>
>  		cache = object->volume->cache->cache;
>  		fscache_put_cookie(object->cookie,

so that we can get rid of CACHEFILES_ONDEMAND_OBJINFO() stuff, to make
the code more readable.



-- 
Thanks,
Jingbo
