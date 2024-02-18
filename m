Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9938859453
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Feb 2024 04:15:47 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=heEQ5NZc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TcrQb4jRdz3cGW
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Feb 2024 14:15:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=heEQ5NZc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TcrQN2wp9z3bvJ
	for <linux-erofs@lists.ozlabs.org>; Sun, 18 Feb 2024 14:15:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708226116; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cqOsry37fOCW6Y3ou1nZ7EHlwm2eSJbNTtcAmfAvy8w=;
	b=heEQ5NZcv0iPqTnyR3pC6xkzYs1z7TgAzKCLd8tEbLUZzr4i6LvN9kDM6wLPMyJIyC+/vEh/7InEjr4yuLK7wnp1t39ClU9U8pJMbf3vuysq2RN4SYcner90UBF/IFgSZhKw9Dv54+iM6CpiQEceWrN0Af5sWy8tFZhlDhYvhqU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W0kSJnS_1708226113;
Received: from 30.221.145.138(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W0kSJnS_1708226113)
          by smtp.aliyun-inc.com;
          Sun, 18 Feb 2024 11:15:13 +0800
Message-ID: <cee45d07-b885-4b4b-b9b5-d7aeedc2b2e7@linux.alibaba.com>
Date: Sun, 18 Feb 2024 11:15:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] cachefiles: fix memory leak in
 cachefiles_add_cache()
To: Baokun Li <libaokun1@huawei.com>, netfs@lists.linux.dev
References: <20240217081431.796809-1-libaokun1@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240217081431.796809-1-libaokun1@huawei.com>
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
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/17/24 4:14 PM, Baokun Li wrote:
> The following memory leak was reported after unbinding /dev/cachefiles:
> 
> ==================================================================
> unreferenced object 0xffff9b674176e3c0 (size 192):
>   comm "cachefilesd2", pid 680, jiffies 4294881224
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ea38a44b):
>     [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
>     [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
>     [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
>     [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
>     [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
>     [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
>     [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
>     [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
>     [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> ==================================================================
> 
> Put the reference count of cache_cred in cachefiles_daemon_unbind() to
> fix the problem. And also put cache_cred in cachefiles_add_cache() error
> branch to avoid memory leaks.
> 
> Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/cachefiles/cache.c  | 2 ++
>  fs/cachefiles/daemon.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
> index 7077f72e6f47..f449f7340aad 100644
> --- a/fs/cachefiles/cache.c
> +++ b/fs/cachefiles/cache.c
> @@ -168,6 +168,8 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
>  	dput(root);
>  error_open_root:
>  	cachefiles_end_secure(cache, saved_cred);
> +	put_cred(cache->cache_cred);
> +	cache->cache_cred = NULL;
>  error_getsec:
>  	fscache_relinquish_cache(cache_cookie);
>  	cache->cache = NULL;
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 3f24905f4066..6465e2574230 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -816,6 +816,7 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
>  	cachefiles_put_directory(cache->graveyard);
>  	cachefiles_put_directory(cache->store);
>  	mntput(cache->mnt);
> +	put_cred(cache->cache_cred);
>  
>  	kfree(cache->rootdirname);
>  	kfree(cache->secctx);

-- 
Thanks,
Jingbo
