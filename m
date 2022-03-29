Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7974EA7B7
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Mar 2022 08:14:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KSK6R3RCzz2xrg
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Mar 2022 17:14:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KSK6L5bMBz2xBf
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Mar 2022 17:14:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R621e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8XENYr_1648534472; 
Received: from 30.225.24.46(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8XENYr_1648534472) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 29 Mar 2022 14:14:34 +0800
Message-ID: <597372bf-06dc-defa-0628-a1c140235c1e@linux.alibaba.com>
Date: Tue, 29 Mar 2022 14:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [Linux-cachefs] [PATCH v6 03/22] cachefiles: notify user daemon
 with anon_fd when looking up cookie
Content-Language: en-US
From: JeffleXu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-4-jefflexu@linux.alibaba.com>
In-Reply-To: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/25/22 8:22 PM, Jeffle Xu wrote:

> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index e80673d0ab97..8a0f1b691aca 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -15,6 +15,8 @@
>  
> +/*
> + * ondemand.c
> + */
> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
> +					       char __user *_buffer,
> +					       size_t buflen);
> +
> +extern int cachefiles_ondemand_cinit(struct cachefiles_cache *cache,
> +				     char *args);
> +
> +extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
> +
> +#else

> +ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
> +					char __user *_buffer, size_t buflen)

Needs to be declared as static inline ...

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int cachefiles_ondemand_init_object(struct cachefiles_object *object)
> +{
> +	return 0;
> +}
> +#endif


-- 
Thanks,
Jeffle
