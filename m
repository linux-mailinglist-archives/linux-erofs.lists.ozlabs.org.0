Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C84F8186
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 16:24:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ3Y122HZz2yh9
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 00:24:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TAywI+Gp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TAywI+Gp; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ3Xz14J0z2yMD
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 00:24:19 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 52D2FB82735;
 Thu,  7 Apr 2022 14:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C17C385A4;
 Thu,  7 Apr 2022 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649341455;
 bh=w14ZPYdK01Rmbqc8luZ4J6X6VeW7r2KK5+F7YTyBwz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TAywI+GpgGL/Hf8yI/GiNlm9V0dtjIj9Bvl5Gu4n2WRg/h7qkd/wJYaCSqlt9cqQe
 fmNv865oCZado3Q6vyk2+lOqad6zUlSl/UsBVWG0hNDkQvL4wDTOrnXozI8fHJggof
 rs1HdivX/eU+DNFyI7xMA/CKAls9YF/shkA24ZcFnDaOTQOtB3RLxQHyvsUNMLoq2Z
 l5djZGerUM2bENo/OBKaLrS8agNtgFPak3QAFtgFBUHj5QJmaVTySEvpWKXKVdUwkr
 D28tWH1kajSkzEUI+goASr/y2KNmCtXje9f+geWHPshF6yubJii+Gb9xHwC3PJ7N5Z
 BgMvOFK3AWovA==
Date: Thu, 7 Apr 2022 22:24:05 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 17/20] erofs: implement fscache-based data read for
 non-inline layout
Message-ID: <Yk70BTzzoaOvET5c@debian>
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
 <20220406075612.60298-18-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-18-jefflexu@linux.alibaba.com>
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

On Wed, Apr 06, 2022 at 03:56:09PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading data from data blobs over fscache
> for non-inline layout.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  5 +++++
>  fs/erofs/internal.h |  2 ++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 158cc273f8fb..65de1c754e80 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -60,10 +60,62 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	return ret;
>  }
>  
> +static int erofs_fscache_readpage(struct file *file, struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct inode *inode = folio_file_mapping(folio)->host;
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_map_blocks map;
> +	struct erofs_map_dev mdev;
> +	erofs_off_t pos;
> +	loff_t pstart;
> +	int ret = 0;
> +
> +	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
> +
> +	pos = folio_pos(folio);
> +	map.m_la = pos;
> +
> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		folio_zero_range(folio, 0, folio_size(folio));
> +		goto out_uptodate;
> +	}
> +
> +	/* no-inline readpage */
> +	mdev = (struct erofs_map_dev) {
> +		.m_deviceid = map.m_deviceid,
> +		.m_pa = map.m_pa,
> +	};
> +
> +	ret = erofs_map_dev(sb, &mdev);
> +	if (ret)
> +		goto out_unlock;
> +
> +	pstart = mdev.m_pa + (pos - map.m_la);
> +	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> +			folio_file_mapping(folio), folio_pos(folio),
> +			folio_size(folio), pstart);
> +
> +out_uptodate:
> +	if (!ret)
> +		folio_mark_uptodate(folio);
> +out_unlock:
> +	folio_unlock(folio);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
>  	.readpage = erofs_fscache_meta_readpage,
>  };
>  
> +const struct address_space_operations erofs_fscache_access_aops = {
> +	.readpage = erofs_fscache_readpage,
> +};
> +
>  /*
>   * Get the page cache of data blob at the index offset.
>   * Return: up to date page on success, ERR_PTR() on failure.
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e8b37ba5e9ad..88b51b5fb53f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -296,7 +296,12 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
>  		err = z_erofs_fill_inode(inode);
>  		goto out_unlock;
>  	}
> +

unnecessary modification.

Otherwise looks good:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +	if (erofs_is_fscache_mode(inode->i_sb))
> +		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> +#endif
>  
>  out_unlock:
>  	erofs_put_metabuf(&buf);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index e186051f0640..336d19647c96 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -642,6 +642,8 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
>  
>  struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index);
> +
> +extern const struct address_space_operations erofs_fscache_access_aops;
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
>  static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
> -- 
> 2.27.0
> 
