Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC88C99F6
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 10:51:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xwxpqFtj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjWM50bcGz3cZr
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 18:44:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xwxpqFtj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjWLx4HZXz30T0
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 18:43:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716194626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Np2sVsTSSvQj7+GPf2otiNPwpNHK1fdVkxle3DY2244=;
	b=xwxpqFtjEGwmzjgLzn0yedJ0KjMjvpHRMAwZ0Y36ls3iYMZQH1HCctmWnua5ha5ZLQ5EfDMF6HmD5xlA+khRLJWN7l5wDRG547e8G/5XoazLwOckwLjADTGqQu1K01PPNWlTqJ+CXixmXHb6a+l3/Dsrj2fLvMO9Q7coMHPTpm4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6pD3Jj_1716194622;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6pD3Jj_1716194622)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 16:43:44 +0800
Message-ID: <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
Date: Mon, 20 May 2024 16:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if
 ondemand_id is valid
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-9-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-9-libaokun@huaweicloud.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Now every time the daemon reads an open request, it gets a new anonymous fd
> and ondemand_id. With the introduction of "restore", it is possible to read
> the same open request more than once, and therefore an object can have more
> than one anonymous fd.
> 
> If the anonymous fd is not unique, the following concurrencies will result
> in an fd leak:
> 
>      t1     |         t2         |          t3
> ------------------------------------------------------------
>  cachefiles_ondemand_init_object
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>               REQ_A = cachefiles_ondemand_select_req
>               cachefiles_ondemand_get_fd
>                 load->fd = fd0
>                 ondemand_id = object_id0
>                                   ------ restore ------
>                                   cachefiles_ondemand_restore
>                                    // restore REQ_A
>                                   cachefiles_daemon_read
>                                    cachefiles_ondemand_daemon_read
>                                     REQ_A = cachefiles_ondemand_select_req
>                                       cachefiles_ondemand_get_fd
>                                         load->fd = fd1
>                                         ondemand_id = object_id1
>              process_open_req(REQ_A)
>              write(devfd, ("copen %u,%llu", msg->msg_id, size))
>              cachefiles_ondemand_copen
>               xa_erase(&cache->reqs, id)
>               complete(&REQ_A->done)
>    kfree(REQ_A)
>                                   process_open_req(REQ_A)
>                                   // copen fails due to no req
>                                   // daemon close(fd1)
>                                   cachefiles_ondemand_fd_release
>                                    // set object closed
>  -- umount --
>  cachefiles_withdraw_cookie
>   cachefiles_ondemand_clean_object
>    cachefiles_ondemand_init_close_req
>     if (!cachefiles_ondemand_object_is_open(object))
>       return -ENOENT;
>     // The fd0 is not closed until the daemon exits.
> 
> However, the anonymous fd holds the reference count of the object and the
> object holds the reference count of the cookie. So even though the cookie
> has been relinquished, it will not be unhashed and freed until the daemon
> exits.
> 
> In fscache_hash_cookie(), when the same cookie is found in the hash list,
> if the cookie is set with the FSCACHE_COOKIE_RELINQUISHED bit, then the new
> cookie waits for the old cookie to be unhashed, while the old cookie is
> waiting for the leaked fd to be closed, if the daemon does not exit in time
> it will trigger a hung task.
> 
> To avoid this, allocate a new anonymous fd only if no anonymous fd has
> been allocated (ondemand_id == 0) or if the previously allocated anonymous
> fd has been closed (ondemand_id == -1). Moreover, returns an error if
> ondemand_id is valid, letting the daemon know that the current userland
> restore logic is abnormal and needs to be checked.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

The LOCs of this fix is quite under control.  But still it seems that
the worst consequence is that the (potential) malicious daemon gets
hung.  No more effect to the system or other processes.  Or does a
non-malicious daemon have any chance having the same issue?

> ---
>  fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index d04ddc6576e3..d2d4e27fca6f 100644
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
> @@ -288,22 +295,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  		goto err_put_fd;
>  	}
>  
> +	spin_lock(&object->ondemand->lock);
> +	if (object->ondemand->ondemand_id > 0) {
> +		spin_unlock(&object->ondemand->lock);
> +		/* Pair with check in cachefiles_ondemand_fd_release(). */
> +		file->private_data = NULL;
> +		ret = -EEXIST;
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
> @@ -386,10 +410,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
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
