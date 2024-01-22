Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A949A835BDB
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 08:43:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJMdh4Cv0z3cR1
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 18:43:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJMd86tZCz3byP
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 18:42:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.3muj._1705909349;
Received: from 30.97.48.216(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.3muj._1705909349)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 15:42:30 +0800
Message-ID: <d99929c8-9bf2-4a99-8507-617eb3419b98@linux.alibaba.com>
Date: Mon, 22 Jan 2024 15:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: make iov_iter describe target buffer when read
 from fscache
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20240122071253.119004-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240122071253.119004-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jingbo,

On 2024/1/22 15:12, Jingbo Xu wrote:
> So far the fscache mode supports uncompressed data only, and the data
> read from fscache is put directly into the target page cache.  As the
> support for compressed data in fscache mode is going to be introduced,
> refactor the interface of reading fscache so that the following
> compressed part could make the raw data read from fscache be directed to
> the target buffer it wants, decompress the raw data, and finally fill
> the page cache with the decompressed data.
> 
> As the first step, a new structure, i.e. erofs_fscache_io (cio), is

I'd suggest just using io instead of cio here.

.. i.e. erofs_fscache_io (io) ...

> introduced to describe a generic read request from the fscache, while
> the caller can specify the target buffer it wants in the iov_iter
> structure (cio->iter).  Besides, the caller can also specify its

.. structure (io->iter) ...

> completion callback and private data through cio, which will be called
> to make further handling, e.g. unlocking the page cache for uncompressed
> data or decompressing the read raw data, when the read request from the
> fscache completes.  Now erofs_fscache_read_io_async() serves as a
> generic interface for reading raw data from fscache for both compressed
> and uncompressed data.
> 
> The erofs_fscache_request structure is kept to describe a request to
> fill the page cache in the specified range.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/fscache.c | 219 ++++++++++++++++++++++++---------------------
>   1 file changed, 118 insertions(+), 101 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index bc12030393b2..10709f20bef5 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -13,8 +13,6 @@ static LIST_HEAD(erofs_domain_cookies_list);
>   static struct vfsmount *erofs_pseudo_mnt;
>   
>   struct erofs_fscache_request {
> -	struct erofs_fscache_request *primary;
> -	struct netfs_cache_resources cache_resources;
>   	struct address_space	*mapping;	/* The mapping being accessed */
>   	loff_t			start;		/* Start position */
>   	size_t			len;		/* Length of the request */
> @@ -23,42 +21,13 @@ struct erofs_fscache_request {
>   	refcount_t		ref;
>   };
>   
> -static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
> -					     loff_t start, size_t len)
> -{
> -	struct erofs_fscache_request *req;
> -
> -	req = kzalloc(sizeof(struct erofs_fscache_request), GFP_KERNEL);
> -	if (!req)
> -		return ERR_PTR(-ENOMEM);
> -
> -	req->mapping = mapping;
> -	req->start   = start;
> -	req->len     = len;
> -	refcount_set(&req->ref, 1);
> -
> -	return req;
> -}
> -
> -static struct erofs_fscache_request *erofs_fscache_req_chain(struct erofs_fscache_request *primary,
> -					     size_t len)
> -{
> -	struct erofs_fscache_request *req;
> -
> -	/* use primary request for the first submission */
> -	if (!primary->submitted) {
> -		refcount_inc(&primary->ref);
> -		return primary;
> -	}
> -
> -	req = erofs_fscache_req_alloc(primary->mapping,
> -			primary->start + primary->submitted, len);
> -	if (!IS_ERR(req)) {
> -		req->primary = primary;
> -		refcount_inc(&primary->ref);
> -	}
> -	return req;
> -}
> +struct erofs_fscache_io {
> +	struct netfs_cache_resources cache_resources;

	struct netfs_cache_resources cres;

> +	struct iov_iter		iter;
> +	netfs_io_terminated_t	end_io;
> +	void			*private;
> +	refcount_t		ref;
> +};
>   
>   static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
>   {
> @@ -83,82 +52,116 @@ static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
>   static void erofs_fscache_req_put(struct erofs_fscache_request *req)
>   {
>   	if (refcount_dec_and_test(&req->ref)) {
> -		if (req->cache_resources.ops)
> -			req->cache_resources.ops->end_operation(&req->cache_resources);
> -		if (!req->primary)
> -			erofs_fscache_req_complete(req);
> -		else
> -			erofs_fscache_req_put(req->primary);
> +		erofs_fscache_req_complete(req);
>   		kfree(req);
>   	}
>   }
>   
> -static void erofs_fscache_subreq_complete(void *priv,
> +static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
> +						loff_t start, size_t len)
> +{
> +	struct erofs_fscache_request *req;
> +
> +	req = kzalloc(sizeof(*req), GFP_KERNEL);
> +	if (req) {
> +		req->mapping = mapping;
> +		req->start = start;
> +		req->len = len;
> +		refcount_set(&req->ref, 1);
> +	}
> +	return req;

The following part may be better? to save an indentation:

	req = kzalloc(sizeof(*req), GFP_KERNEL);
	if (!req)
		return NULL;
	req->mapping = mapping;
	req->start = start;
	req->len = len;
	refcount_set(&req->ref, 1);
	return req;

> +}
> +
> +static bool erofs_fscache_io_put(struct erofs_fscache_io *cio)
> +{
> +	if (refcount_dec_and_test(&cio->ref)) {
> +		if (cio->cache_resources.ops)
> +			cio->cache_resources.ops->end_operation(&cio->cache_resources);
> +		kfree(cio);
> +		return true;
> +	}
> +	return false;


	if (!refcount_dec_and_test(&io->ref))
		return false;
	if (io->cres.ops)
		io->cres.ops->end_operation(&io->cres);
	kfree(io);
	return true;

> +}
> +
> +static void erofs_fscache_req_io_put(struct erofs_fscache_io *cio)

cio -> io

> +{
> +	struct erofs_fscache_request *req = cio->private;
> +
> +	if (erofs_fscache_io_put(cio))
> +		erofs_fscache_req_put(req);
> +}
> +
> +static void erofs_fscache_req_end_io(void *priv,
>   		ssize_t transferred_or_error, bool was_async)
>   {
> -	struct erofs_fscache_request *req = priv;
> +	struct erofs_fscache_io *cio = priv;
> +	struct erofs_fscache_request *req = cio->private;
> +
> +	if (IS_ERR(transferred_or_error))
> +		req->error = transferred_or_error;
> +	erofs_fscache_req_io_put(cio);
> +}
> +
> +static struct erofs_fscache_io *erofs_fscache_req_io_alloc(struct erofs_fscache_request *req)
> +{
> +	struct erofs_fscache_io *cio;
>   
> -	if (IS_ERR_VALUE(transferred_or_error)) {
> -		if (req->primary)
> -			req->primary->error = transferred_or_error;
> -		else
> -			req->error = transferred_or_error;
> +	cio = kzalloc(sizeof(*cio), GFP_KERNEL);
> +	if (cio) {
> +		cio->end_io = erofs_fscache_req_end_io;
> +		cio->private = req;
> +		refcount_inc(&req->ref);
> +		refcount_set(&cio->ref, 1);
>   	}
> -	erofs_fscache_req_put(req);
> +	return cio;


	io = kzalloc(sizeof(*io), GFP_KERNEL);
	if (!io)
		return NULL;
	io->end_io = erofs_fscache_req_end_io;
	io->private = req;
	refcount_inc(&req->ref);
	refcount_set(&io->ref, 1);
	return io;

Thanks,
Gao Xiang
