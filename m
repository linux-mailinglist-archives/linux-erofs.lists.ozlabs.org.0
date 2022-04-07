Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4924F8147
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 16:05:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ37b1LH0z2yh9
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 00:05:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y6HvBPLW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y6HvBPLW; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ37T4YVQz2yMD
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 00:05:41 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9039FB82776;
 Thu,  7 Apr 2022 14:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE5C385A7;
 Thu,  7 Apr 2022 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649340336;
 bh=h/ekb5QtQwdaE1nuKp1Ak9uQSLC0j8BMRSRfXRUcEK0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y6HvBPLWrJ06i4vlOTF8BnZ3iqItHqw/nsH/nNnEwo+N32fsRbK0SKgF5EwQsMH+9
 nvPFZqZ7FMctoEz4BWfpfOwdcQGV/g66hr+wb+2qpXqSeo5pU2cJGRZYxCHMNEfndq
 UEG9V0T3FTni5dw/r0Jd55uxSPQIfnPqxSx60c+bSgkaxtA8yILAntPnPoAS5tvbSM
 uOSoGF+r+t/Lzp7Y/LuPML8bXRgjF+voyEegUOCTM4Ku8YeS0zqz18A7fwukVcOZ69
 Z4TNP76n/xxzt9umz8R5oYeVg/FxuVoELTWeU1AKtq222UQfTpr+II4qi1xvboJoHF
 lCyCEDNDgga8g==
Date: Thu, 7 Apr 2022 22:05:26 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 13/20] erofs: add erofs_fscache_read_folios() helper
Message-ID: <Yk7vfDqd4gVoVlqz@debian>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-14-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-14-jefflexu@linux.alibaba.com>
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 06, 2022 at 03:56:05PM +0800, Jeffle Xu wrote:
> Add erofs_fscache_read_folios() helper reading from fscache. It supports
> on-demand read semantics. That is, it will make the backend prepare for
> the data when cache miss. Once data ready, it will reinitiate a read
> from the cache.
> 
> This helper can then be used to implement .readpage()/.readahead() of
> on-demand read semantics.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/fscache.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 1c88614203d2..d38a6efc8e50 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -5,6 +5,35 @@
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> +/*
> + * Read data from fscache and fill the read data into page cache described by
> + * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
> + * the start physical address in the cache file.
> + */
> +static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
> +				     struct address_space *mapping,
> +				     loff_t start, size_t len,
> +				     loff_t pstart)
> +{
> +	struct netfs_cache_resources cres;
> +	struct iov_iter iter;
> +	int ret;
> +
> +	memset(&cres, 0, sizeof(cres));
> +
> +	ret = fscache_begin_read_operation(&cres, cookie);
> +	if (ret)
> +		return ret;
> +
> +	iov_iter_xarray(&iter, READ, &mapping->i_pages, start, len);
> +
> +	ret = fscache_read(&cres, pstart, &iter,
> +			   NETFS_READ_HOLE_ONDEMAND, NULL, NULL);
> +
> +	fscache_end_operation(&cres);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
>  };
>  
> -- 
> 2.27.0
> 
