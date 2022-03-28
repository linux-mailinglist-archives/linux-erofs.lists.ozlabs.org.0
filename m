Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A604E8C53
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 04:49:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KRccL4R6Tz3c1b
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 13:49:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KRccG1kxCz2yMD
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Mar 2022 13:49:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0V8KSgjt_1648435779; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V8KSgjt_1648435779) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 28 Mar 2022 10:49:42 +0800
Date: Mon, 28 Mar 2022 10:49:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [Linux-cachefs] [PATCH v6 14/22] erofs: add
 erofs_fscache_read_folios() helper
Message-ID: <YkEiQywvozBKTExr@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 gregkh@linuxfoundation.org, fannaihao@baidu.com,
 tao.peng@linux.alibaba.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 eguan@linux.alibaba.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-15-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-15-jefflexu@linux.alibaba.com>
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
Cc: tianzichen@kuaishou.com, gregkh@linuxfoundation.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 25, 2022 at 08:22:15PM +0800, Jeffle Xu wrote:
> Add erofs_fscache_read_folios() helper reading from fscache. It supports
> on-demand read semantics. That is, it will make the backend prepare for
> the data when cache miss. Once data ready, it will reinitiate a read
> from the cache.
> 
> This helper can then be used to implement .readpage()/.readahead() of
> on-demand read semantics.
> 
> Besides also add erofs_fscache_read_folio() wrapper helper.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 30383d9adb62..6a55f7b5f883 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,6 +7,45 @@
>  
>  static struct fscache_volume *volume;
>  
> +/*
> + * erofs_fscache_read_folios - Read data from fscache.
> + *
> + * Fill the read data into page cache described by @start/len, which shall be
> + * both aligned with PAGE_SIZE. @pstart describes the corresponding physical
> + * start address in the cache file.
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
> +static inline int erofs_fscache_read_folio(struct fscache_cookie *cookie,
> +					   struct folio *folio, loff_t pstart)

I've seen two users of this helper,

 1) erofs_fscache_readpage_noinline
 2) erofs_fscache_readpage_blob

Actually, we could fold such logic in these users since this additional
helper doesn't enhance the readability but increase the overhead when
reading the code.

It'd be better to get rid of it instead.

Thanks,
Gao Xiang

> +{
> +	return erofs_fscache_read_folios(cookie, folio_file_mapping(folio),
> +					 folio_pos(folio), folio_size(folio),
> +					 pstart);
> +}
> +
>  static const struct address_space_operations erofs_fscache_blob_aops = {
>  };
>  
> -- 
> 2.27.0
> 
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
