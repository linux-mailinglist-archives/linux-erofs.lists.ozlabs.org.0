Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 985428BC5F0
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 04:55:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qiFDg8DY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VXmHP1jq1z30PH
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 12:55:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qiFDg8DY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VXmHD271Cz2yt0
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 12:55:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714964114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CrGqcZcLJICyMvWF8rZt/qyUDBdQ3CBU+SFKDUkHkkY=;
	b=qiFDg8DYacW9rC4fQRM9AY/rojLWYKxccoWIcZxMLlZk5tD3JmcutFE0DeehDv5Sl11aaXVOVhWpS4rQkajNcVq/mt/GvMzXGTsgWsaRdmuHB1NR/nwbmt3qa7OJF+C3R+ncgo8kv1gYB5fFGBh0e1PYoHkwixuhde6tqNJd1P0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5q-rOV_1714964110;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5q-rOV_1714964110)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 10:55:11 +0800
Message-ID: <1fef9ab5-ec33-4a14-beb3-ada41a8652b3@linux.alibaba.com>
Date: Mon, 6 May 2024 10:55:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] cachefiles: add spin_lock for
 cachefiles_ondemand_info
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-8-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-8-libaokun@huaweicloud.com>
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
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The following concurrency may cause a read request to fail to be completed
> and result in a hung:
> 
>            t1             |             t2
> ---------------------------------------------------------
>                             cachefiles_ondemand_copen
>                               req = xa_erase(&cache->reqs, id)
> // Anon fd is maliciously closed.
> cachefiles_ondemand_fd_release
>   xa_lock(&cache->reqs)
>   cachefiles_ondemand_set_object_close(object)
>   xa_unlock(&cache->reqs)
>                               cachefiles_ondemand_set_object_open
>                               // No one will ever close it again.
> cachefiles_ondemand_daemon_read
>   cachefiles_ondemand_select_req
>   // Get a read req but its fd is already closed.
>   // The daemon can't issue a cread ioctl with an closed fd, then hung.
> 
> So add spin_lock for cachefiles_ondemand_info to protect ondemand_id and
> state, thus we can avoid the above problem in cachefiles_ondemand_copen()
> by using ondemand_id to determine if fd has been released.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

This indeed looks like a reasonable scenario where the kernel side
should fix, as a non-malicious daemon could also run into this.

How about reusing &cache->reqs spinlock rather than introducing a new
spinlock, as &cache->reqs spinlock is already held when setting object
to close state in cachefiles_ondemand_fd_release()?

> ---
>  fs/cachefiles/internal.h |  1 +
>  fs/cachefiles/ondemand.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 7745b8abc3aa..45c8bed60538 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -55,6 +55,7 @@ struct cachefiles_ondemand_info {
>  	int				ondemand_id;
>  	enum cachefiles_object_state	state;
>  	struct cachefiles_object	*object;
> +	spinlock_t			lock;
>  };
>  
>  /*
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 898fab68332b..b5e6a851ef04 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -16,13 +16,16 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>  	struct cachefiles_object *object = file->private_data;
>  	struct cachefiles_cache *cache = object->volume->cache;
>  	struct cachefiles_ondemand_info *info = object->ondemand;
> -	int object_id = info->ondemand_id;
> +	int object_id;
>  	struct cachefiles_req *req;
>  	XA_STATE(xas, &cache->reqs, 0);
>  
>  	xa_lock(&cache->reqs);
> +	spin_lock(&info->lock);
> +	object_id = info->ondemand_id;
>  	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
>  	cachefiles_ondemand_set_object_close(object);
> +	spin_unlock(&info->lock);
>  
>  	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
>  	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
> @@ -127,6 +130,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  {
>  	struct cachefiles_req *req;
>  	struct fscache_cookie *cookie;
> +	struct cachefiles_ondemand_info *info;
>  	char *pid, *psize;
>  	unsigned long id;
>  	long size;
> @@ -185,6 +189,14 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  		goto out;
>  	}
>  
> +	info = req->object->ondemand;
> +	spin_lock(&info->lock);

> +	/* The anonymous fd was closed before copen ? */

I would like describe more details in the comment, e.g. put the time
sequence described in the commit message here.

> +	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
> +		spin_unlock(&info->lock);
> +		req->error = -EBADFD;
> +		goto out;
> +	}
>  	cookie = req->object->cookie;
>  	cookie->object_size = size;
>  	if (size)
> @@ -194,6 +206,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	trace_cachefiles_ondemand_copen(req->object, id, size);
>  
>  	cachefiles_ondemand_set_object_open(req->object);
> +	spin_unlock(&info->lock);
>  	wake_up_all(&cache->daemon_pollwq);
>  
>  out:
> @@ -596,6 +609,7 @@ int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
>  		return -ENOMEM;
>  
>  	object->ondemand->object = object;
> +	spin_lock_init(&object->ondemand->lock);
>  	INIT_WORK(&object->ondemand->ondemand_work, ondemand_object_worker);
>  	return 0;
>  }

-- 
Thanks,
Jingbo
