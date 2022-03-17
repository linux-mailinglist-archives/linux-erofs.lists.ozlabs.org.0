Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 923274DBE2D
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 06:23:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJwXW3vZjz3085
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 16:23:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJwXM4kGlz2xXZ
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 16:23:09 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=17; SR=0; TI=SMTPD_---0V7QF66W_1647494576; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7QF66W_1647494576) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Mar 2022 13:22:59 +0800
Date: Thu, 17 Mar 2022 13:22:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 21/22] erofs: implement fscache-based data readahead
Message-ID: <YjLFsCLeEU9glmNf@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-22-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-22-jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Mar 16, 2022 at 09:17:22PM +0800, Jeffle Xu wrote:
> This patch implements fscache-based data readahead. Also registers an
> individual bdi for each erofs instance to enable readahead.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/super.c   |   4 ++
>  2 files changed, 157 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 82c52b6e077e..913ca891deb9 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -10,6 +10,13 @@ struct erofs_fscache_map {
>  	u64 m_llen;
>  };
>  
> +struct erofs_fscahce_ra_ctx {

typo,  should be `erofs_fscache_ra_ctx'

> +	struct readahead_control *rac;
> +	struct address_space *mapping;
> +	loff_t start;
> +	size_t len, done;
> +};
> +
>  static struct fscache_volume *volume;
>  
>  /*
> @@ -199,12 +206,158 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  
> +static inline size_t erofs_fscache_calc_len(struct erofs_fscahce_ra_ctx *ractx,
> +					    struct erofs_fscache_map *fsmap)
> +{
> +	/*
> +	 * 1) For CHUNK_BASED layout, the output m_la is rounded down to the
> +	 * nearest chunk boundary, and the output m_llen actually starts from
> +	 * the start of the containing chunk.
> +	 * 2) For other cases, the output m_la is equal to o_la.
> +	 */
> +	size_t len = fsmap->m_llen - (fsmap->o_la - fsmap->m_la);
> +
> +	return min_t(size_t, len, ractx->len - ractx->done);
> +}
> +
> +static inline void erofs_fscache_unlock_pages(struct readahead_control *rac,
> +					      size_t len)

Can we convert them into folios in advance? it seems much
straight-forward to convert these...

Or I have to convert them later, and it seems unnecessary...


> +{
> +	while (len) {
> +		struct page *page = readahead_page(rac);
> +
> +		SetPageUptodate(page);
> +		unlock_page(page);
> +		put_page(page);
> +
> +		len -= PAGE_SIZE;
> +	}
> +}
> +
> +static int erofs_fscache_ra_hole(struct erofs_fscahce_ra_ctx *ractx,
> +				 struct erofs_fscache_map *fsmap)
> +{
> +	struct iov_iter iter;
> +	loff_t start = ractx->start + ractx->done;
> +	size_t length = erofs_fscache_calc_len(ractx, fsmap);
> +
> +	iov_iter_xarray(&iter, READ, &ractx->mapping->i_pages, start, length);
> +	iov_iter_zero(length, &iter);
> +
> +	erofs_fscache_unlock_pages(ractx->rac, length);
> +	return length;
> +}
> +
> +static int erofs_fscache_ra_noinline(struct erofs_fscahce_ra_ctx *ractx,
> +				     struct erofs_fscache_map *fsmap)
> +{
> +	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
> +	loff_t start = ractx->start + ractx->done;
> +	size_t length = erofs_fscache_calc_len(ractx, fsmap);
> +	loff_t pstart = fsmap->m_pa + (fsmap->o_la - fsmap->m_la);
> +	int ret;
> +
> +	ret = erofs_fscache_read_pages(cookie, ractx->mapping,
> +				       start, length, pstart);
> +	if (!ret) {
> +		erofs_fscache_unlock_pages(ractx->rac, length);
> +		ret = length;
> +	}
> +
> +	return ret;
> +}
> +
> +static int erofs_fscache_ra_inline(struct erofs_fscahce_ra_ctx *ractx,
> +				   struct erofs_fscache_map *fsmap)
> +{

We could fold in this, since it has the only user.

Thanks,
Gao Xiang
