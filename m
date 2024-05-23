Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id C700A8CD5D5
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 16:31:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VXoB57rL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlVjK62Ncz3vgk
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 00:21:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VXoB57rL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VlVjD2fsMz3fny
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 00:21:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716474090; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P7HnNkBnQuCqmu8zTIccJJaTZgTQr1fKN1BShJAXcUA=;
	b=VXoB57rLN8pcoA3CtVnc5vNcUytl3+MInkItdEcbzL5NtONVCKSqbYjcI4tX0J4cvIIJO/Svgbm7DrVuVV+q5XLFvrma7xGl3oejuauVSyOXSQ6s+js2BThfEew4uY7ktWOUZSY11j1ewdps2kd0p140ZVSXmN7lc2fWK3KGUQs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W739MMQ_1716474086;
Received: from 30.39.171.189(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W739MMQ_1716474086)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 22:21:27 +0800
Message-ID: <9945b390-3572-4808-b08f-56af9cd3918e@linux.alibaba.com>
Date: Thu, 23 May 2024 22:21:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] cachefiles: remove err_put_fd label in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-6-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240522114308.2402121-6-libaokun@huaweicloud.com>
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



On 5/22/24 7:43 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The err_put_fd label is only used once, so remove it to make the code
> more readable. In addition, the logic for deleting error request and
> CLOSE request is merged to simplify the code.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/cachefiles/ondemand.c | 45 ++++++++++++++--------------------------
>  1 file changed, 16 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 3dd002108a87..bb94ef6a6f61 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -305,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  {
>  	struct cachefiles_req *req;
>  	struct cachefiles_msg *msg;
> -	unsigned long id = 0;
>  	size_t n;
>  	int ret = 0;
>  	XA_STATE(xas, &cache->reqs, cache->req_id_next);
> @@ -340,49 +339,37 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
>  	xa_unlock(&cache->reqs);
>  
> -	id = xas.xa_index;
> -
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
>  		ret = cachefiles_ondemand_get_fd(req);
>  		if (ret) {
>  			cachefiles_ondemand_set_object_close(req->object);
> -			goto error;
> +			goto out;
>  		}
>  	}
>  
> -	msg->msg_id = id;
> +	msg->msg_id = xas.xa_index;
>  	msg->object_id = req->object->ondemand->ondemand_id;
>  
>  	if (copy_to_user(_buffer, msg, n) != 0) {
>  		ret = -EFAULT;
> -		goto err_put_fd;
> -	}
> -
> -	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
> -	/* CLOSE request has no reply */
> -	if (msg->opcode == CACHEFILES_OP_CLOSE) {
> -		xa_erase(&cache->reqs, id);
> -		complete(&req->done);
> +		if (msg->opcode == CACHEFILES_OP_OPEN)
> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
>  	}
> -
> -	cachefiles_req_put(req);
> -	return n;
> -
> -err_put_fd:
> -	if (msg->opcode == CACHEFILES_OP_OPEN)
> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
> -error:
> +out:
>  	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
> -	xas_reset(&xas);
> -	xas_lock(&xas);
> -	if (xas_load(&xas) == req) {
> -		req->error = ret;
> -		complete(&req->done);
> -		xas_store(&xas, NULL);
> +	/* Remove error request and CLOSE request has no reply */
> +	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			req->error = ret;
> +			complete(&req->done);
> +			xas_store(&xas, NULL);
> +		}
> +		xas_unlock(&xas);
>  	}
> -	xas_unlock(&xas);
>  	cachefiles_req_put(req);
> -	return ret;
> +	return ret ? ret : n;
>  }
>  
>  typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);

-- 
Thanks,
Jingbo
