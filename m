Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 259A68C9AA3
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 11:46:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c5xlUxcA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjXbt2FWBz3cfT
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 19:40:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c5xlUxcA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjXbj48gxz3cYk
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 19:39:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716197995; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6mPT0eGoRhA21v6AH8L2aZwWTPQ8/DIb/G4ER9YIgYQ=;
	b=c5xlUxcAh596njqu1YdwECwaGjuRjGBhI5E8XpdhVfbvreDSCmDVsG7k4Np6SnYMVOVPJ/ETOLQAeabJW8DxKzi2lfo8L8yoRZvFWz2SmWFIQCg3dUXBVX8S6geJ6T+uZrhg/szHr1KgFpn9oRV1+ioNXLHXJq6iOqFnyEGJwwo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6qUXQb_1716197992;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6qUXQb_1716197992)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 17:39:54 +0800
Message-ID: <db7ae78c-857b-45ba-94dc-63c02757e0b2@linux.alibaba.com>
Date: Mon, 20 May 2024 17:39:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] cachefiles: defer exposing anon_fd until after
 copy_to_user() succeeds
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-10-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-10-libaokun@huaweicloud.com>
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
> After installing the anonymous fd, we can now see it in userland and close
> it. However, at this point we may not have gotten the reference count of
> the cache, but we will put it during colse fd, so this may cause a cache
> UAF.
> 
> So grab the cache reference count before fd_install(). In addition, by
> kernel convention, fd is taken over by the user land after fd_install(),
> and the kernel should not call close_fd() after that, i.e., it should call
> fd_install() after everything is ready, thus fd_install() is called after
> copy_to_user() succeeds.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index d2d4e27fca6f..3a36613e00a7 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -4,6 +4,11 @@
>  #include <linux/uio.h>
>  #include "internal.h"
>  
> +struct anon_file {
> +	struct file *file;
> +	int fd;
> +};
> +
>  static inline void cachefiles_req_put(struct cachefiles_req *req)
>  {
>  	if (refcount_dec_and_test(&req->ref))
> @@ -263,14 +268,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>  	return 0;
>  }
>  


> -static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
> +static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
> +				      struct anon_file *anon_file)


How about:

int cachefiles_ondemand_get_fd(struct cachefiles_req *req, int *fd,
struct file *file) ?

It isn't worth introducing a new structure as it is used only for
parameter passing.


>  {
>  	struct cachefiles_object *object;
>  	struct cachefiles_cache *cache;
>  	struct cachefiles_open *load;
> -	struct file *file;
>  	u32 object_id;
> -	int ret, fd;
> +	int ret;
>  
>  	object = cachefiles_grab_object(req->object,
>  			cachefiles_obj_get_ondemand_fd);
> @@ -282,16 +287,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  	if (ret < 0)
>  		goto err;
>  
> -	fd = get_unused_fd_flags(O_WRONLY);
> -	if (fd < 0) {
> -		ret = fd;
> +	anon_file->fd = get_unused_fd_flags(O_WRONLY);
> +	if (anon_file->fd < 0) {
> +		ret = anon_file->fd;
>  		goto err_free_id;
>  	}
>  
> -	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
> -				  object, O_WRONLY);
> -	if (IS_ERR(file)) {
> -		ret = PTR_ERR(file);
> +	anon_file->file = anon_inode_getfile("[cachefiles]",
> +				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
> +	if (IS_ERR(anon_file->file)) {
> +		ret = PTR_ERR(anon_file->file);
>  		goto err_put_fd;
>  	}
>  
> @@ -299,16 +304,15 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  	if (object->ondemand->ondemand_id > 0) {
>  		spin_unlock(&object->ondemand->lock);
>  		/* Pair with check in cachefiles_ondemand_fd_release(). */
> -		file->private_data = NULL;
> +		anon_file->file->private_data = NULL;
>  		ret = -EEXIST;
>  		goto err_put_file;
>  	}
>  
> -	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
> -	fd_install(fd, file);
> +	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>  
>  	load = (void *)req->msg.data;
> -	load->fd = fd;
> +	load->fd = anon_file->fd;
>  	object->ondemand->ondemand_id = object_id;
>  	spin_unlock(&object->ondemand->lock);
>  
> @@ -317,9 +321,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  	return 0;
>  
>  err_put_file:
> -	fput(file);
> +	fput(anon_file->file);
> +	anon_file->file = NULL;

When cachefiles_ondemand_get_fd() returns failure, anon_file->file is
not used, and thus I don't think it is worth resetting anon_file->file
to NULL. Or we could assign fd and struct file at the very end when all
succeed.

>  err_put_fd:
> -	put_unused_fd(fd);
> +	put_unused_fd(anon_file->fd);
> +	anon_file->fd = ret;

Ditto.

>  err_free_id:
>  	xa_erase(&cache->ondemand_ids, object_id);
>  err:
> @@ -376,6 +382,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	struct cachefiles_msg *msg;
>  	size_t n;
>  	int ret = 0;
> +	struct anon_file anon_file;
>  	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>  
>  	xa_lock(&cache->reqs);
> @@ -409,7 +416,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xa_unlock(&cache->reqs);
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
> -		ret = cachefiles_ondemand_get_fd(req);
> +		ret = cachefiles_ondemand_get_fd(req, &anon_file);
>  		if (ret)
>  			goto out;
>  	}
> @@ -417,10 +424,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	msg->msg_id = xas.xa_index;
>  	msg->object_id = req->object->ondemand->ondemand_id;
>  
> -	if (copy_to_user(_buffer, msg, n) != 0) {
> +	if (copy_to_user(_buffer, msg, n) != 0)
>  		ret = -EFAULT;
> -		if (msg->opcode == CACHEFILES_OP_OPEN)
> -			close_fd(((struct cachefiles_open *)msg->data)->fd);
> +
> +	if (msg->opcode == CACHEFILES_OP_OPEN) {
> +		if (ret < 0) {
> +			fput(anon_file.file);
> +			put_unused_fd(anon_file.fd);
> +			goto out;
> +		}
> +		fd_install(anon_file.fd, anon_file.file);
>  	}
>  out:
>  	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);

-- 
Thanks,
Jingbo
