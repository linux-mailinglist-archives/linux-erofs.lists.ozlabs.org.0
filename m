Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E564A8BC614
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 05:09:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P1+aXtz4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VXmbT0Mfbz30T1
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 13:09:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P1+aXtz4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VXmbK237Mz2yvl
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 13:09:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714964951; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JRlGN2mptAj2Ko2vwpIZlWC6irfwwV0f+NG6BmfBNHY=;
	b=P1+aXtz4jrRW57oqewdx7xHQ6YEz1rRx+Wyt7uPza9dkj2p8VnIeZiSMV+fQV/Z80eedJTl4ZA0K7IuG8YLYtRLezqKWnCPjVu62N887i0oyLy5z89KRBemXnJZfcvXjdabD0ikR2rz2VtgDyLjK8QwouT5+R/4UjSq0xODcrG8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5rA8vh_1714964947;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5rA8vh_1714964947)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 11:09:09 +0800
Message-ID: <625acc9e-b871-4912-965e-82fe3f9228d7@linux.alibaba.com>
Date: Mon, 6 May 2024 11:09:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] cachefiles: never get a new anon fd if ondemand_id
 is valid
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-9-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-9-libaokun@huaweicloud.com>
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
> Now every time the daemon reads an open request, it requests a new anon fd
> and ondemand_id. With the introduction of "restore", it is possible to read
> the same open request more than once, and therefore have multiple anon fd's
> for the same object.
> 
> To avoid this, allocate a new anon fd only if no anon fd has been allocated
> (ondemand_id == 0) or if the previously allocated anon fd has been closed
> (ondemand_id == -1). Returns an error if ondemand_id is valid, letting the
> daemon know that the current userland restore logic is abnormal and needs
> to be checked.

I have no obvious preference on strengthening this on kernel side or
not.  Could you explain more about what will happen if the daemon gets
several distinct anon fd corresponding to one same object?  IMHO the
daemon should expect the side effect if it issues a 'restore' command
when the daemon doesn't crash.  IOW, it's something that shall be fixed
or managed either on the kernel side, or on the daemon side.

> ---
>  fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index b5e6a851ef04..0cf63bfedc9e 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -14,11 +14,18 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>  					  struct file *file)
>  {
>  	struct cachefiles_object *object = file->private_data;
> -	struct cachefiles_cache *cache = object->volume->cache;
> -	struct cachefiles_ondemand_info *info = object->ondemand;
> +	struct cachefiles_cache *cache;
> +	struct cachefiles_ondemand_info *info;
>  	int object_id;
>  	struct cachefiles_req *req;
> -	XA_STATE(xas, &cache->reqs, 0);
> +	XA_STATE(xas, NULL, 0);
> +
> +	if (!object)
> +		return 0;
> +
> +	info = object->ondemand;
> +	cache = object->volume->cache;
> +	xas.xa = &cache->reqs;
>  
>  	xa_lock(&cache->reqs);
>  	spin_lock(&info->lock);
> @@ -269,22 +276,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  		goto err_put_fd;
>  	}
>  
> +	spin_lock(&object->ondemand->lock);
> +	if (object->ondemand->ondemand_id > 0) {
> +		spin_unlock(&object->ondemand->lock);
> +		ret = -EEXIST;
> +		/* Avoid performing cachefiles_ondemand_fd_release(). */
> +		file->private_data = NULL;
> +		goto err_put_file;
> +	}
> +
>  	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>  	fd_install(fd, file);
>  
>  	load = (void *)req->msg.data;
>  	load->fd = fd;
>  	object->ondemand->ondemand_id = object_id;
> +	spin_unlock(&object->ondemand->lock);
>  
>  	cachefiles_get_unbind_pincount(cache);
>  	trace_cachefiles_ondemand_open(object, &req->msg, load);
>  	return 0;
>  
> +err_put_file:
> +	fput(file);
>  err_put_fd:
>  	put_unused_fd(fd);
>  err_free_id:
>  	xa_erase(&cache->ondemand_ids, object_id);
>  err:
> +	spin_lock(&object->ondemand->lock);
> +	/* Avoid marking an opened object as closed. */
> +	if (object->ondemand->ondemand_id <= 0)
> +		cachefiles_ondemand_set_object_close(object);
> +	spin_unlock(&object->ondemand->lock);
>  	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
>  	return ret;
>  }
> @@ -367,10 +391,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
>  		ret = cachefiles_ondemand_get_fd(req);
> -		if (ret) {
> -			cachefiles_ondemand_set_object_close(req->object);
> +		if (ret)
>  			goto out;
> -		}
>  	}
>  
>  	msg->msg_id = xas.xa_index;

-- 
Thanks,
Jingbo
