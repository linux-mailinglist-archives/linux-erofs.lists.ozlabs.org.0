Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB44F81E1
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 16:37:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ3qb1JpYz2ymb
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 00:36:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=prdLhdwW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=prdLhdwW; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ3qW5SS0z2xsc
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 00:36:55 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0E6C4B82737;
 Thu,  7 Apr 2022 14:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75840C385A5;
 Thu,  7 Apr 2022 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649342211;
 bh=5+bk4CcEaJUSJAT88KegWTZKhFaoE5MAk1IU5Pfy8lw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=prdLhdwWpe2/mj0TsH26rPRdwQ2O7CAJEScgSz4yZPvPj0DznoTvWdFlHoGNsHETP
 bM0xB2CvHAXc4fMNceLCKL/wL9TzKsvUyth5kRsEbBT99fBh3QIHK/vG08ZSNeNvFG
 Q45wFK8Av8QYu84lRIbD3xojYHrL/U5Cokm5hLJ4YgmkO94cdaaTessd0RFo0BCQf7
 ozdbgG5fV/fIIk/wXbPVBdtnYm/M40miSWd5iR4MzYlRBc4xos6Pb0YRZY5AI3jDZQ
 EPXXC3YU92bacJIT2byUS1vD/DDCbwJSY0jxEtMwnJlPgAowbHmvBjscDfKNSg/yL6
 UBWIO1dujRJvA==
Date: Thu, 7 Apr 2022 22:36:42 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 19/20] erofs: implement fscache-based data readahead
Message-ID: <Yk72+uwwg3/bG72X@debian>
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
 <20220406075612.60298-20-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-20-jefflexu@linux.alibaba.com>
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

On Wed, Apr 06, 2022 at 03:56:11PM +0800, Jeffle Xu wrote:
> Implement fscache-based data readahead. Also registers an individual
> bdi for each erofs instance to enable readahead.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/super.c   |  4 ++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index d32cb5840c6d..620d44210809 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -148,12 +148,106 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  
> +static inline void erofs_fscache_unlock_folios(struct readahead_control *rac,
> +					       size_t len)
> +{
> +	while (len) {
> +		struct folio *folio = readahead_folio(rac);
> +
> +		len -= folio_size(folio);
> +		folio_mark_uptodate(folio);
> +		folio_unlock(folio);
> +	}
> +}
> +
> +static void erofs_fscache_readahead(struct readahead_control *rac)
> +{
> +	struct inode *inode = rac->mapping->host;
> +	struct super_block *sb = inode->i_sb;
> +	size_t len, count, done = 0;
> +	erofs_off_t pos;
> +	loff_t start, offset;
> +	int ret;
> +
> +	if (!readahead_count(rac))
> +		return;
> +
> +	start = readahead_pos(rac);
> +	len = readahead_length(rac);
> +
> +	do {
> +		struct erofs_map_blocks map;
> +		struct erofs_map_dev mdev;
> +
> +		pos = start + done;
> +		map.m_la = pos;
> +
> +		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +		if (ret)
> +			return;
> +
> +		/*
> +		 * 1) For CHUNK_BASED layout, the output m_la is rounded down to
> +		 * the nearest chunk boundary, and the output m_llen actually
> +		 * starts from the start of the containing chunk.
> +		 * 2) For other cases, the output m_la is equal to o_la.
> +		 */

I think such comment is really unneeded, we should calculate like below
as always. Also I don't find o_la here anymore.

> +		offset = start + done;
> +		count = min_t(size_t, map.m_llen - (pos - map.m_la), len - done);
> +
> +		/* Read-ahead Hole */
> +		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +			struct iov_iter iter;
> +
> +			iov_iter_xarray(&iter, READ, &rac->mapping->i_pages,
> +					offset, count);
> +			iov_iter_zero(count, &iter);
> +
> +			erofs_fscache_unlock_folios(rac, count);
> +			ret = count;
> +			continue;
> +		}
> +
> +		/* Read-ahead Inline */

Unnecessary comment.

> +		if (map.m_flags & EROFS_MAP_META) {
> +			struct folio *folio = readahead_folio(rac);
> +
> +			ret = erofs_fscache_readpage_inline(folio, &map);
> +			if (!ret) {
> +				folio_mark_uptodate(folio);
> +				ret = folio_size(folio);
> +			}
> +
> +			folio_unlock(folio);
> +			continue;
> +		}
> +
> +		/* Read-ahead No-inline */

Same here.

Thanks,
Gao Xiang

> +		mdev = (struct erofs_map_dev) {
> +			.m_deviceid = map.m_deviceid,
> +			.m_pa = map.m_pa,
> +		};
> +		ret = erofs_map_dev(sb, &mdev);
> +		if (ret)
> +			return;
> +
> +		ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> +				rac->mapping, offset, count,
> +				mdev.m_pa + (pos - map.m_la));
> +		if (!ret) {
> +			erofs_fscache_unlock_folios(rac, count);
> +			ret = count;
> +		}
> +	} while (ret > 0 && ((done += ret) < len));
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
>  	.readpage = erofs_fscache_meta_readpage,
>  };
>  
>  const struct address_space_operations erofs_fscache_access_aops = {
>  	.readpage = erofs_fscache_readpage,
> +	.readahead = erofs_fscache_readahead,
>  };
>  
>  /*
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 8c7181cd37e6..a5e4de60a0d8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -621,6 +621,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  						    sbi->opt.fsid, true);
>  		if (err)
>  			return err;
> +
> +		err = super_setup_bdi(sb);
> +		if (err)
> +			return err;
>  	}
>  
>  	err = erofs_read_superblock(sb);
> -- 
> 2.27.0
> 
