Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A2C4E8C77
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 05:12:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KRd5p3Ksqz3c1d
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 14:11:58 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KRd5k0hXtz2ynk
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Mar 2022 14:11:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V8Kie8j_1648437104; 
Received: from 30.225.24.93(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8Kie8j_1648437104) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 28 Mar 2022 11:11:46 +0800
Message-ID: <f1455f47-dbeb-46cb-69bd-5edf193f69fe@linux.alibaba.com>
Date: Mon, 28 Mar 2022 11:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v6 12/22] erofs: add cookie context helper functions
Content-Language: en-US
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com, fannaihao@baidu.com
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-13-jefflexu@linux.alibaba.com>
 <Yj3GlpvjL3u0RTjN@B-P7TQMD6M-0146.local>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yj3GlpvjL3u0RTjN@B-P7TQMD6M-0146.local>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/25/22 9:41 PM, Gao Xiang wrote:
> Hi Jeffle,
> 
> On Fri, Mar 25, 2022 at 08:22:13PM +0800, Jeffle Xu wrote:
>> Introduce "struct erofs_fscache" for managing cookie for backinig file,
>> and helper functions for initializing and cleaning up this context
>> structure.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/erofs/internal.h | 14 +++++++++++
>>  2 files changed, 75 insertions(+)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 08cf570a0810..73235fd43bf6 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -7,6 +7,67 @@
>>  
>>  static struct fscache_volume *volume;
>>  
>> +static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
>> +{
>> +	struct fscache_cookie *cookie;
>> +
>> +	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
>> +					path, strlen(path),
>> +					NULL, 0, 0);
> 
> It'd be better to rearrange in one line?

Sure.

> 
> 					path, strlen(path), NULL, 0, 0);
> 
>> +	if (!cookie)
>> +		return -EINVAL;
>> +
>> +	fscache_use_cookie(cookie, false);
>> +	ctx->cookie = cookie;
>> +	return 0;
>> +}
>> +
>> +static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
>> +{
>> +	struct fscache_cookie *cookie = ctx->cookie;
>> +
>> +	fscache_unuse_cookie(cookie, NULL, NULL);
>> +	fscache_relinquish_cookie(cookie, false);
>> +	ctx->cookie = NULL;
>> +}
>> +
>> +/*
>> + * erofs_fscache_get - create an fscache context for blob file
>> + * @sb:		superblock
>> + * @path:	name of blob file
>> + *
>> + * Return: fscache context on success, ERR_PTR() on failure.
>> + */
>> +struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)
> 
> erofs_fscache_register?

OK.


> 
>> +{
>> +	struct erofs_fscache *ctx;
>> +	int ret;
>> +
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = erofs_fscache_init_cookie(ctx, path);
> 
> Can we fold it here? No need to introduce such simple wrapper..
> 
>> +	if (ret) {
>> +		erofs_err(sb, "failed to init cookie");
> 
> It would be better to print the path?

OK.

> 
>> +		goto err;
> 
> 		kfree(ctx);
> 		return ERR_PTR(ret);
> 
> At least for now.

Yeah, it's better.

> 
>> +	}
>> +
>> +	return ctx;
>> +err:
>> +	kfree(ctx);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +void erofs_fscache_put(struct erofs_fscache *ctx)
> 
> erofs_fscache_unregister?

OK.

> 
>> +{
>> +	if (!ctx)
>> +		return;
>> +
>> +	erofs_fscache_cleanup_cookie(ctx);
> 
> Fold it too, since such helper doesn't simplify code a lot but need
> to take one more time to redirect..

OK.

-- 
Thanks,
Jeffle
