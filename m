Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E12B7634E59
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Nov 2022 04:29:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NH67M5vYqz3cMk
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Nov 2022 14:29:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.16; helo=out199-16.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NH67H29rjz2xl5
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Nov 2022 14:29:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VVUtD9I_1669174159;
Received: from 30.221.128.211(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVUtD9I_1669174159)
          by smtp.aliyun-inc.com;
          Wed, 23 Nov 2022 11:29:20 +0800
Message-ID: <f03ad01c-1b7a-8f77-86bb-aa41b2a77d37@linux.alibaba.com>
Date: Wed, 23 Nov 2022 11:29:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [Linux-cachefs] [PATCH v4 1/2] fscache, cachefiles: add
 prepare_ondemand_read() callback
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org, chao@kernel.org, jlayton@kernel.org,
 linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com, dhowells@redhat.com
References: <20221117053017.21074-1-jefflexu@linux.alibaba.com>
 <20221117053017.21074-2-jefflexu@linux.alibaba.com>
In-Reply-To: <20221117053017.21074-2-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

How do you think of this patch?  It's already -rc6 and we'd like to
enable erofs large folios for Linux 6.2.

If it's possible, could you review or ack this patch?  Many thanks.


Thanks,
Jingbo Xu


On 11/17/22 1:30 PM, Jingbo Xu wrote:
> Add prepare_ondemand_read() callback dedicated for the on-demand read
> scenario, so that callers from this scenario can be decoupled from
> netfs_io_subrequest.
> 
> The original cachefiles_prepare_read() is now refactored to a generic
> routine accepting a parameter list instead of netfs_io_subrequest.
> There's no logic change, except that some debug info retrieved from
> netfs_io_subrequest is removed from trace_cachefiles_prep_read().
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/cachefiles/io.c                | 77 ++++++++++++++++++++-----------
>  include/linux/netfs.h             |  8 ++++
>  include/trace/events/cachefiles.h | 27 ++++++-----
>  3 files changed, 71 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 000a28f46e59..13648348d9f9 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -385,38 +385,35 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
>  				  term_func, term_func_priv);
>  }
>  
> -/*
> - * Prepare a read operation, shortening it to a cached/uncached
> - * boundary as appropriate.
> - */
> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
> -						      loff_t i_size)
> +static inline enum netfs_io_source
> +cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
> +			   loff_t start, size_t *_len, loff_t i_size,
> +			   unsigned long *_flags)
>  {
>  	enum cachefiles_prepare_read_trace why;
> -	struct netfs_io_request *rreq = subreq->rreq;
> -	struct netfs_cache_resources *cres = &rreq->cache_resources;
> -	struct cachefiles_object *object;
> +	struct cachefiles_object *object = NULL;
>  	struct cachefiles_cache *cache;
>  	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
>  	const struct cred *saved_cred;
>  	struct file *file = cachefiles_cres_file(cres);
>  	enum netfs_io_source ret = NETFS_DOWNLOAD_FROM_SERVER;
> +	size_t len = *_len;
>  	loff_t off, to;
>  	ino_t ino = file ? file_inode(file)->i_ino : 0;
>  	int rc;
>  
> -	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
> +	_enter("%zx @%llx/%llx", len, start, i_size);
>  
> -	if (subreq->start >= i_size) {
> +	if (start >= i_size) {
>  		ret = NETFS_FILL_WITH_ZEROES;
>  		why = cachefiles_trace_read_after_eof;
>  		goto out_no_object;
>  	}
>  
>  	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
> -		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
> +		__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
>  		why = cachefiles_trace_read_no_data;
> -		if (!test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags))
> +		if (!test_bit(NETFS_SREQ_ONDEMAND, _flags))
>  			goto out_no_object;
>  	}
>  
> @@ -437,7 +434,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>  retry:
>  	off = cachefiles_inject_read_error();
>  	if (off == 0)
> -		off = vfs_llseek(file, subreq->start, SEEK_DATA);
> +		off = vfs_llseek(file, start, SEEK_DATA);
>  	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
>  		if (off == (loff_t)-ENXIO) {
>  			why = cachefiles_trace_read_seek_nxio;
> @@ -449,21 +446,22 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>  		goto out;
>  	}
>  
> -	if (off >= subreq->start + subreq->len) {
> +	if (off >= start + len) {
>  		why = cachefiles_trace_read_found_hole;
>  		goto download_and_store;
>  	}
>  
> -	if (off > subreq->start) {
> +	if (off > start) {
>  		off = round_up(off, cache->bsize);
> -		subreq->len = off - subreq->start;
> +		len = off - start;
> +		*_len = len;
>  		why = cachefiles_trace_read_found_part;
>  		goto download_and_store;
>  	}
>  
>  	to = cachefiles_inject_read_error();
>  	if (to == 0)
> -		to = vfs_llseek(file, subreq->start, SEEK_HOLE);
> +		to = vfs_llseek(file, start, SEEK_HOLE);
>  	if (to < 0 && to >= (loff_t)-MAX_ERRNO) {
>  		trace_cachefiles_io_error(object, file_inode(file), to,
>  					  cachefiles_trace_seek_error);
> @@ -471,12 +469,13 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>  		goto out;
>  	}
>  
> -	if (to < subreq->start + subreq->len) {
> -		if (subreq->start + subreq->len >= i_size)
> +	if (to < start + len) {
> +		if (start + len >= i_size)
>  			to = round_up(to, cache->bsize);
>  		else
>  			to = round_down(to, cache->bsize);
> -		subreq->len = to - subreq->start;
> +		len = to - start;
> +		*_len = len;
>  	}
>  
>  	why = cachefiles_trace_read_have_data;
> @@ -484,12 +483,11 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>  	goto out;
>  
>  download_and_store:
> -	__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
> -	if (test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags)) {
> -		rc = cachefiles_ondemand_read(object, subreq->start,
> -					      subreq->len);
> +	__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
> +	if (test_bit(NETFS_SREQ_ONDEMAND, _flags)) {
> +		rc = cachefiles_ondemand_read(object, start, len);
>  		if (!rc) {
> -			__clear_bit(NETFS_SREQ_ONDEMAND, &subreq->flags);
> +			__clear_bit(NETFS_SREQ_ONDEMAND, _flags);
>  			goto retry;
>  		}
>  		ret = NETFS_INVALID_READ;
> @@ -497,10 +495,34 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>  out:
>  	cachefiles_end_secure(cache, saved_cred);
>  out_no_object:
> -	trace_cachefiles_prep_read(subreq, ret, why, ino);
> +	trace_cachefiles_prep_read(object, start, len, *_flags, ret, why, ino);
>  	return ret;
>  }
>  
> +/*
> + * Prepare a read operation, shortening it to a cached/uncached
> + * boundary as appropriate.
> + */
> +static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
> +						    loff_t i_size)
> +{
> +	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
> +					  subreq->start, &subreq->len, i_size,
> +					  &subreq->flags);
> +}
> +
> +/*
> + * Prepare an on-demand read operation, shortening it to a cached/uncached
> + * boundary as appropriate.
> + */
> +static enum netfs_io_source
> +cachefiles_prepare_ondemand_read(struct netfs_cache_resources *cres,
> +				 loff_t start, size_t *_len, loff_t i_size,
> +				 unsigned long *_flags)
> +{
> +	return cachefiles_do_prepare_read(cres, start, _len, i_size, _flags);
> +}
> +
>  /*
>   * Prepare for a write to occur.
>   */
> @@ -621,6 +643,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
>  	.write			= cachefiles_write,
>  	.prepare_read		= cachefiles_prepare_read,
>  	.prepare_write		= cachefiles_prepare_write,
> +	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
>  	.query_occupancy	= cachefiles_query_occupancy,
>  };
>  
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index f2402ddeafbf..95cc0397f0ee 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -267,6 +267,14 @@ struct netfs_cache_ops {
>  			     loff_t *_start, size_t *_len, loff_t i_size,
>  			     bool no_space_allocated_yet);
>  
> +	/* Prepare an on-demand read operation, shortening it to a cached/uncached
> +	 * boundary as appropriate.
> +	 */
> +	enum netfs_io_source (*prepare_ondemand_read)(struct netfs_cache_resources *cres,
> +						      loff_t start, size_t *_len,
> +						      loff_t i_size,
> +						      unsigned long *_flags);
> +
>  	/* Query the occupancy of the cache in a region, returning where the
>  	 * next chunk of data starts and how long it is.
>  	 */
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index d8d4d73fe7b6..171c0d7f0bb7 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -428,44 +428,43 @@ TRACE_EVENT(cachefiles_vol_coherency,
>  	    );
>  
>  TRACE_EVENT(cachefiles_prep_read,
> -	    TP_PROTO(struct netfs_io_subrequest *sreq,
> +	    TP_PROTO(struct cachefiles_object *obj,
> +		     loff_t start,
> +		     size_t len,
> +		     unsigned short flags,
>  		     enum netfs_io_source source,
>  		     enum cachefiles_prepare_read_trace why,
>  		     ino_t cache_inode),
>  
> -	    TP_ARGS(sreq, source, why, cache_inode),
> +	    TP_ARGS(obj, start, len, flags, source, why, cache_inode),
>  
>  	    TP_STRUCT__entry(
> -		    __field(unsigned int,		rreq		)
> -		    __field(unsigned short,		index		)
> +		    __field(unsigned int,		obj		)
>  		    __field(unsigned short,		flags		)
>  		    __field(enum netfs_io_source,	source		)
>  		    __field(enum cachefiles_prepare_read_trace,	why	)
>  		    __field(size_t,			len		)
>  		    __field(loff_t,			start		)
> -		    __field(unsigned int,		netfs_inode	)
>  		    __field(unsigned int,		cache_inode	)
>  			     ),
>  
>  	    TP_fast_assign(
> -		    __entry->rreq	= sreq->rreq->debug_id;
> -		    __entry->index	= sreq->debug_index;
> -		    __entry->flags	= sreq->flags;
> +		    __entry->obj	= obj ? obj->debug_id : 0;
> +		    __entry->flags	= flags;
>  		    __entry->source	= source;
>  		    __entry->why	= why;
> -		    __entry->len	= sreq->len;
> -		    __entry->start	= sreq->start;
> -		    __entry->netfs_inode = sreq->rreq->inode->i_ino;
> +		    __entry->len	= len;
> +		    __entry->start	= start;
>  		    __entry->cache_inode = cache_inode;
>  			   ),
>  
> -	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx ni=%x B=%x",
> -		      __entry->rreq, __entry->index,
> +	    TP_printk("o=%08x %s %s f=%02x s=%llx %zx B=%x",
> +		      __entry->obj,
>  		      __print_symbolic(__entry->source, netfs_sreq_sources),
>  		      __print_symbolic(__entry->why, cachefiles_prepare_read_traces),
>  		      __entry->flags,
>  		      __entry->start, __entry->len,
> -		      __entry->netfs_inode, __entry->cache_inode)
> +		      __entry->cache_inode)
>  	    );
>  
>  TRACE_EVENT(cachefiles_read,

-- 
Thanks,
Jingbo
