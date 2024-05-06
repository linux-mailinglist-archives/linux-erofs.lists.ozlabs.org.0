Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC78BC636
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 05:25:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bG1I24fS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VXmxd3MLqz30TP
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 13:25:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bG1I24fS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VXmxT5Y7Mz2yvv
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 13:25:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714965897; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RbpIXs9H/Hma1wu6wHG4qOKSeBDxPsWHGvGGKe6YJWs=;
	b=bG1I24fS/jh+BMcCVmMIZvcD626UgDI1LLpLpGqCbQN/1r/6S+x2mdXd5i9P9uGJcM0RC3SAp6/txv9HUJG5+ZAwV3BF01x0B81uqGpYfwjT6r4xU3Md89sxt5mMnsz7tm3JgxKypJdj5ZNoMRlyWPKJE/hU3B9v0xEMq13mN4A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W5rS6Bn_1714965893;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5rS6Bn_1714965893)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 11:24:55 +0800
Message-ID: <e0fc24d5-49c5-4a75-86f9-43adc763066f@linux.alibaba.com>
Date: Mon, 6 May 2024 11:24:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] cachefiles: defer exposing anon_fd until after
 copy_to_user() succeeds
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-10-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-10-libaokun@huaweicloud.com>
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
> After installing the anonymous fd, we can now see it in userland and close
> it. However, at this point we may not have gotten the reference count of
> the cache, but we will put it during colse fd, so this may cause a cache
> UAF.

Good catch!

> 
> To avoid this, we will make the anonymous fd accessible to the userland by
> executing fd_install() after copy_to_user() has succeeded, and by this
> point we must have already grabbed the reference count of the cache.

Why we must execute fd_install() after copy_to_user() has succeeded?
Why not grab a reference to the cache before fd_install()?

> 
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 0cf63bfedc9e..7c2d43104120 100644
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
> @@ -244,14 +249,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>  	return 0;
>  }
>  
> -static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
> +static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
> +				      struct anon_file *anon_file)
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
> @@ -263,16 +268,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
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
> @@ -281,15 +286,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  		spin_unlock(&object->ondemand->lock);
>  		ret = -EEXIST;
>  		/* Avoid performing cachefiles_ondemand_fd_release(). */
> -		file->private_data = NULL;
> +		anon_file->file->private_data = NULL;
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
> @@ -298,9 +302,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  	return 0;
>  
>  err_put_file:
> -	fput(file);
> +	fput(anon_file->file);
> +	anon_file->file = NULL;
>  err_put_fd:
> -	put_unused_fd(fd);
> +	put_unused_fd(anon_file->fd);
> +	anon_file->fd = ret;
>  err_free_id:
>  	xa_erase(&cache->ondemand_ids, object_id);
>  err:
> @@ -357,6 +363,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	struct cachefiles_msg *msg;
>  	size_t n;
>  	int ret = 0;
> +	struct anon_file anon_file;
>  	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>  
>  	xa_lock(&cache->reqs);
> @@ -390,7 +397,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xa_unlock(&cache->reqs);
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
> -		ret = cachefiles_ondemand_get_fd(req);
> +		ret = cachefiles_ondemand_get_fd(req, &anon_file);
>  		if (ret)
>  			goto out;
>  	}
> @@ -398,10 +405,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
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
