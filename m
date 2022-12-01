Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F363ECF8
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 10:56:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNBKq6JTnz3bXK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 20:56:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3svZzPIW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3svZzPIW;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NNBKf4T6Wz30QS
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 20:56:04 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so4705540pjc.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Dec 2022 01:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVekRrjQdjKUMaBIZQzopxrszx9zpKNUBM6uhvJ2OsE=;
        b=3svZzPIWmHMSSAzdnMmv5fRVXiaXYbeXpsvk0v8hsFcFa2zH7Eenob0VJRZ25KjigD
         dFDtKke6nUald98sFnksDrNukm/UQOgD8ODPriQ7YVtU6VwM6MthJzIpMSpyXaNvSj5d
         bMlSlt4TsNqOyEZlIJI45Ui1g9Ui6rwTIXlDEoqve5OsTAKpGPoB8uvbV5xcclo3mYCi
         Sj1Rzg2nETw/J1rMgqs6S0iZT7C7y0ujY9Q4R29pT6zALI46r+yJrSs8ob7lT5ARD46x
         iF+QqG2YSZCISqoZPFu39iTSzy3dOj6XaldZJacZ757Wf+ct5QTqRTcT4LXx47QBu+uk
         p+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pVekRrjQdjKUMaBIZQzopxrszx9zpKNUBM6uhvJ2OsE=;
        b=qzQh1E1vjYvCmUHND/UFYLRpQyHLrfHU6U3N6blVhj2I38QAASlkuq3Rt3FbcdMvF+
         pHt28DhA4dvJOwqsYNhRII44n4eVSxF4F9VlXfJF9aQyNYpyGSGTDlHlzagje+/SOlp9
         ucRHn/JNhaMb3boPCC8x2htaKu06rw9KwUq0IrXoxIlEZtCuzUQkxbhcZD2yr3XvMpLr
         qBA+/hGhOpM9sb0ZRm7WJv03TcSv7t2GQZ5dahWqkQH0TOapUKSLiAQqhnuxkzZP9u8f
         x44gtGkIgQMk7Z+Kn9CpEKl2tYc0prMBBYJ0phy0R6V9AbW1xJ1I2d1F/r8rCqUZeK/P
         /5Jg==
X-Gm-Message-State: ANoB5plkxu5BJSQduPXBdMbPNEeQsOTW7NUBw8qZOs7QkqtIrhbZvurH
	E1RaHwPfajyyuxjcqpB5oajEXg==
X-Google-Smtp-Source: AA0mqf4b+NgTrfohYehkRcjPearqtYqUN6SRqTiFS/bkl5tZomJ7acZJtRIy7CoBydf7ncKR3JenRg==
X-Received: by 2002:a17:903:191:b0:186:5cda:1e01 with SMTP id z17-20020a170903019100b001865cda1e01mr48218649plg.111.1669888557302;
        Thu, 01 Dec 2022 01:55:57 -0800 (PST)
Received: from [10.255.207.68] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d33-20020a631d21000000b00477e0f7ab89sm2224771pgd.38.2022.12.01.01.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 01:55:56 -0800 (PST)
Message-ID: <31aa8381-0e70-b340-7c02-02153b222d7f@bytedance.com>
Date: Thu, 1 Dec 2022 17:55:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [Phishing Risk] [External] [PATCH v4 1/2] erofs: support large
 folios for fscache mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20221201074256.16639-1-jefflexu@linux.alibaba.com>
 <20221201074256.16639-2-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221201074256.16639-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/12/1 15:42, Jingbo Xu 写道:
> When large folios supported, one folio can be split into several slices,
> each of which may be mapped to META/UNMAPPED/MAPPED, and the folio can
> be unlocked as a whole only when all slices have completed.
> 
> Thus always allocate erofs_fscache_request for each .read_folio() or
> .readahead(), in which case the allocated request is responsible for
> unlocking folios when all slices have completed.
> 
> As described above, each folio or folio range can be mapped into several
> slices, while these slices may be mapped to different cookies, and thus
> each slice needs its own netfs_cache_resources.  Here we introduce
> chained requests to support this, where each .read_folio() or
> .readahead() calling can correspond to multiple requests.  Each request
> has its own netfs_cache_resources and thus is used to access one cookie.
> Among these requests, there's a primary request, with the others
> pointing to the primary request.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Thanks.

> ---
>   fs/erofs/fscache.c | 148 ++++++++++++++++++++++++---------------------
>   1 file changed, 80 insertions(+), 68 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 3e794891cd91..f14886c479bd 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -12,6 +12,7 @@ static LIST_HEAD(erofs_domain_list);
>   static struct vfsmount *erofs_pseudo_mnt;
>   
>   struct erofs_fscache_request {
> +	struct erofs_fscache_request *primary;
>   	struct netfs_cache_resources cache_resources;
>   	struct address_space	*mapping;	/* The mapping being accessed */
>   	loff_t			start;		/* Start position */
> @@ -38,6 +39,26 @@ static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_spac
>   	return req;
>   }
>   
> +static struct erofs_fscache_request *erofs_fscache_req_chain(struct erofs_fscache_request *primary,
> +					     size_t len)
> +{
> +	struct erofs_fscache_request *req;
> +
> +	/* use primary request for the first submission */
> +	if (!primary->submitted) {
> +		refcount_inc(&primary->ref);
> +		return primary;
> +	}
> +
> +	req = erofs_fscache_req_alloc(primary->mapping,
> +			primary->start + primary->submitted, len);
> +	if (!IS_ERR(req)) {
> +		req->primary = primary;
> +		refcount_inc(&primary->ref);
> +	}
> +	return req;
> +}
> +
>   static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
>   {
>   	struct folio *folio;
> @@ -56,17 +77,19 @@ static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
>   		folio_unlock(folio);
>   	}
>   	rcu_read_unlock();
> -
> -	if (req->cache_resources.ops)
> -		req->cache_resources.ops->end_operation(&req->cache_resources);
> -
> -	kfree(req);
>   }
>   
>   static void erofs_fscache_req_put(struct erofs_fscache_request *req)
>   {
> -	if (refcount_dec_and_test(&req->ref))
> -		erofs_fscache_req_complete(req);
> +	if (refcount_dec_and_test(&req->ref)) {
> +		if (req->cache_resources.ops)
> +			req->cache_resources.ops->end_operation(&req->cache_resources);
> +		if (!req->primary)
> +			erofs_fscache_req_complete(req);
> +		else
> +			erofs_fscache_req_put(req->primary);
> +		kfree(req);
> +	}
>   }
>   
>   static void erofs_fscache_subreq_complete(void *priv,
> @@ -74,8 +97,12 @@ static void erofs_fscache_subreq_complete(void *priv,
>   {
>   	struct erofs_fscache_request *req = priv;
>   
> -	if (IS_ERR_VALUE(transferred_or_error))
> -		req->error = transferred_or_error;
> +	if (IS_ERR_VALUE(transferred_or_error)) {
> +		if (req->primary)
> +			req->primary->error = transferred_or_error;
> +		else
> +			req->error = transferred_or_error;
> +	}
>   	erofs_fscache_req_put(req);
>   }
>   
> @@ -131,7 +158,6 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
>   		done += slen;
>   	}
>   	DBG_BUGON(done != len);
> -	req->submitted += len;
>   	return 0;
>   }
>   
> @@ -167,32 +193,19 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   	return ret;
>   }
>   
> -/*
> - * Read into page cache in the range described by (@pos, @len).
> - *
> - * On return, if the output @unlock is true, the caller is responsible for page
> - * unlocking; otherwise the callee will take this responsibility through request
> - * completion.
> - *
> - * The return value is the number of bytes successfully handled, or negative
> - * error code on failure. The only exception is that, the length of the range
> - * instead of the error code is returned on failure after request is allocated,
> - * so that .readahead() could advance rac accordingly.
> - */
> -static int erofs_fscache_data_read(struct address_space *mapping,
> -				   loff_t pos, size_t len, bool *unlock)
> +static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
>   {
> +	struct address_space *mapping = primary->mapping;
>   	struct inode *inode = mapping->host;
>   	struct super_block *sb = inode->i_sb;
>   	struct erofs_fscache_request *req;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
>   	struct iov_iter iter;
> +	loff_t pos = primary->start + primary->submitted;
>   	size_t count;
>   	int ret;
>   
> -	*unlock = true;
> -
>   	map.m_la = pos;
>   	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>   	if (ret)
> @@ -220,17 +233,19 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>   		}
>   		iov_iter_zero(PAGE_SIZE - size, &iter);
>   		erofs_put_metabuf(&buf);
> -		return PAGE_SIZE;
> +		primary->submitted += PAGE_SIZE;
> +		return 0;
>   	}
>   
> +	count = primary->len - primary->submitted;
>   	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> -		count = len;
>   		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
>   		iov_iter_zero(count, &iter);
> -		return count;
> +		primary->submitted += count;
> +		return 0;
>   	}
>   
> -	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
> +	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
>   	DBG_BUGON(!count || count % PAGE_SIZE);
>   
>   	mdev = (struct erofs_map_dev) {
> @@ -241,68 +256,65 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>   	if (ret)
>   		return ret;
>   
> -	req = erofs_fscache_req_alloc(mapping, pos, count);
> +	req = erofs_fscache_req_chain(primary, count);
>   	if (IS_ERR(req))
>   		return PTR_ERR(req);
>   
> -	*unlock = false;
>   	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
>   			req, mdev.m_pa + (pos - map.m_la), count);
> -	if (ret)
> -		req->error = ret;
> -
>   	erofs_fscache_req_put(req);
> -	return count;
> +	primary->submitted += count;
> +	return ret;
>   }
>   
> -static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
> +static int erofs_fscache_data_read(struct erofs_fscache_request *req)
>   {
> -	bool unlock;
>   	int ret;
>   
> -	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
> +	do {
> +		ret = erofs_fscache_data_read_slice(req);
> +		if (ret)
> +			req->error = ret;
> +	} while (!ret && req->submitted < req->len);
>   
> -	ret = erofs_fscache_data_read(folio_mapping(folio), folio_pos(folio),
> -				      folio_size(folio), &unlock);
> -	if (unlock) {
> -		if (ret > 0)
> -			folio_mark_uptodate(folio);
> +	return ret;
> +}
> +
> +static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
> +{
> +	struct erofs_fscache_request *req;
> +	int ret;
> +
> +	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +			folio_pos(folio), folio_size(folio));
> +	if (IS_ERR(req)) {
>   		folio_unlock(folio);
> +		return PTR_ERR(req);
>   	}
> -	return ret < 0 ? ret : 0;
> +
> +	ret = erofs_fscache_data_read(req);
> +	erofs_fscache_req_put(req);
> +	return ret;
>   }
>   
>   static void erofs_fscache_readahead(struct readahead_control *rac)
>   {
> -	struct folio *folio;
> -	size_t len, done = 0;
> -	loff_t start, pos;
> -	bool unlock;
> -	int ret, size;
> +	struct erofs_fscache_request *req;
>   
>   	if (!readahead_count(rac))
>   		return;
>   
> -	start = readahead_pos(rac);
> -	len = readahead_length(rac);
> +	req = erofs_fscache_req_alloc(rac->mapping,
> +			readahead_pos(rac), readahead_length(rac));
> +	if (IS_ERR(req))
> +		return;
>   
> -	do {
> -		pos = start + done;
> -		ret = erofs_fscache_data_read(rac->mapping, pos,
> -					      len - done, &unlock);
> -		if (ret <= 0)
> -			return;
> +	/* The request completion will drop refs on the folios. */
> +	while (readahead_folio(rac))
> +		;
>   
> -		size = ret;
> -		while (size) {
> -			folio = readahead_folio(rac);
> -			size -= folio_size(folio);
> -			if (unlock) {
> -				folio_mark_uptodate(folio);
> -				folio_unlock(folio);
> -			}
> -		}
> -	} while ((done += ret) < len);
> +	erofs_fscache_data_read(req);
> +	erofs_fscache_req_put(req);
>   }
>   
>   static const struct address_space_operations erofs_fscache_meta_aops = {
