Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id B7A098CD5EA
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 16:36:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AQLbHO8U;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlVsj4ppSz794l
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 00:28:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AQLbHO8U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VlVsb3dJJz3dFm
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 00:28:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716474525; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9wPJMsA7uUhGJBy9UQb2/zbE2MRvDozVPDCHZoma3hs=;
	b=AQLbHO8UX0S5Kvwbu+O3vcxTrIaur2oxsEi6Z0FNGTFrutqCPC8oEDKL3W0T1Y7o1er3H+cBYGaMDIfPyX4x5/absfR7qEf3ibUuayZjHQnLBKZkBlspXaUoWi9b0/0r4BVJLPUmnj8P7QmilcMe0uoRrO68RpEsSyUCI9cWiPk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W739OVi_1716474521;
Received: from 30.39.171.189(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W739OVi_1716474521)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 22:28:43 +0800
Message-ID: <11f10862-9149-49c7-bac4-f0c1e0601b23@linux.alibaba.com>
Date: Thu, 23 May 2024 22:28:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] cachefiles: add consistency check for
 copen/cread
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-7-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240522114308.2402121-7-libaokun@huaweicloud.com>
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
> This prevents malicious processes from completing random copen/cread
> requests and crashing the system. Added checks are listed below:
> 
>   * Generic, copen can only complete open requests, and cread can only
>     complete read requests.
>   * For copen, ondemand_id must not be 0, because this indicates that the
>     request has not been read by the daemon.
>   * For cread, the object corresponding to fd and req should be the same.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index bb94ef6a6f61..898fab68332b 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -82,12 +82,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
>  }
>  
>  static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
> -					 unsigned long arg)
> +					 unsigned long id)
>  {
>  	struct cachefiles_object *object = filp->private_data;
>  	struct cachefiles_cache *cache = object->volume->cache;
>  	struct cachefiles_req *req;
> -	unsigned long id;
> +	XA_STATE(xas, &cache->reqs, id);
>  
>  	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
>  		return -EINVAL;
> @@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
>  
> -	id = arg;
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
> +	    req->object != object) {
> +		xa_unlock(&cache->reqs);
>  		return -EINVAL;
> +	}
> +	xas_store(&xas, NULL);
> +	xa_unlock(&cache->reqs);
>  
>  	trace_cachefiles_ondemand_cread(object, id);
>  	complete(&req->done);
> @@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	unsigned long id;
>  	long size;
>  	int ret;
> +	XA_STATE(xas, &cache->reqs, 0);
>  
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
> @@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	if (ret)
>  		return ret;
>  
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	xas.xa_index = id;
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
> +	    !req->object->ondemand->ondemand_id) {

For a valid opened object, I think ondemand_id shall > 0.  When the
copen is for the object which is in the reopening state, ondemand_id can
be CACHEFILES_ONDEMAND_ID_CLOSED (actually -1)?

Otherwise looks good to me.


-- 
Thanks,
Jingbo
