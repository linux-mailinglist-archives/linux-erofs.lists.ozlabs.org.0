Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3AD4F81B1
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 16:32:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ3k21GtHz2ymS
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 00:32:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=inxngaAv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=inxngaAv; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ3jy6R6Dz2xsc
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 00:32:06 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D6982B81D07;
 Thu,  7 Apr 2022 14:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DF6C385A0;
 Thu,  7 Apr 2022 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649341922;
 bh=1mo8AG4FIR1/02YpFR4zJU4OcpMYkIGir1YVgUBVtjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=inxngaAvGk4ci4lL9D9ebkrGzcMpUuh0DxcHhPClkg9ctSXRjUR+WDfkTT1nVwwAt
 hTrjaa7ywrI4/z+Mzm+XFo7OKykHYTfaUGj9wY6tvuuVo5glndB2vBfM/6JZonyuAx
 us5csSm0foMRHB+fOnpT5tBy1jPaDO5maUHCK/jHcRUVWv2veIyZCSIvWSH3/Vly0Z
 WCZLy6y3URLTMcrRfaTGyhEWrYjAAMEMMcWdXEuMlADTwGpCHCb/gx9Ir3dgYHZiLg
 ouQpoqYiFYo4txOAeu9SJj2Jhc++HixksTam/lMcrGo9TaGLIFS002BA17+j2kcood
 8fQvGjtOcWTCg==
Date: Thu, 7 Apr 2022 22:31:54 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 18/20] erofs: implement fscache-based data read for
 inline layout
Message-ID: <Yk712oM2xrEUmbhZ@debian>
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
 <20220406075612.60298-19-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-19-jefflexu@linux.alibaba.com>
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

On Wed, Apr 06, 2022 at 03:56:10PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading data from data blobs over fscache
> for inline layout.
> 
> For the heading non-inline part, the data plane for non-inline layout is
> reused, while only the tail packing part needs special handling.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 65de1c754e80..d32cb5840c6d 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -60,6 +60,40 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	return ret;
>  }
>  
> +static int erofs_fscache_readpage_inline(struct folio *folio,
> +					 struct erofs_map_blocks *map)
> +{
> +	struct inode *inode = folio_file_mapping(folio)->host;
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	erofs_blk_t blknr;
> +	size_t offset, len;
> +	void *src, *dst;
> +
> +	/*
> +	 * For inline (tail packing) layout, the offset may be non-zero, which
> +	 * can be calculated from corresponding physical address directly.
> +	 */
> +	offset = erofs_blkoff(map->m_pa);
> +	blknr = erofs_blknr(map->m_pa);
> +	len = map->m_llen;
> +
> +	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
> +	if (IS_ERR(src))
> +		return PTR_ERR(src);
> +
> +	DBG_BUGON(folio_size(folio) != PAGE_SIZE);
> +
> +	dst = kmap(folio_page(folio, 0));

kmap_local_folio?

> +	memcpy(dst, src + offset, len);
> +	memset(dst + len, 0, PAGE_SIZE - len);
> +	kunmap(folio_page(folio, 0));
> +
> +	erofs_put_metabuf(&buf);
> +
> +	return 0;
> +}
> +
>  static int erofs_fscache_readpage(struct file *file, struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
> @@ -85,6 +119,12 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  		goto out_uptodate;
>  	}
>  
> +	/* inline readpage */

I think the code below is self-explained.

> +	if (map.m_flags & EROFS_MAP_META) {
> +		ret = erofs_fscache_readpage_inline(folio, &map);
> +		goto out_uptodate;
> +	}
> +
>  	/* no-inline readpage */

Same here.

Thanks,
Gao Xiang

>  	mdev = (struct erofs_map_dev) {
>  		.m_deviceid = map.m_deviceid,
> -- 
> 2.27.0
> 
