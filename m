Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39633D54FA
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 10:13:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYCP06KBmz306n
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 18:13:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=joseph.qi@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 304 seconds by postgrey-1.36 at boromir;
 Mon, 26 Jul 2021 18:13:33 AEST
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYCNs0J14z2yMG
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 18:13:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=joseph.qi@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UgzYoDR_1627286901; 
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com
 fp:SMTPD_---0UgzYoDR_1627286901) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 26 Jul 2021 16:08:22 +0800
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org
References: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <5a377153-85c0-4514-11f2-e8b0707e5acf@linux.alibaba.com>
Date: Mon, 26 Jul 2021 16:08:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/24/21 1:41 AM, Gao Xiang wrote:
> Add support for reading inline data content into the page cache from
> nonzero page-aligned file offsets.  This enables the EROFS tailpacking
> mode where the last few bytes of the file are stored right after the
> inode.
> 
> The buffered write path remains untouched since EROFS cannot be used
> for testing. It'd be better to be implemented if upcoming real users
> care and provide a real pattern rather than leave untested dead code
> around.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Looks good to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> v6: https://lore.kernel.org/r/20210722031729.51628-1-hsiangkao@linux.alibaba.com
> changes since v6:
>  - based on Christoph's reply;
>  - update commit message suggested by Darrick;
>  - disable buffered write path until some real fs users.
> 
>  fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++----------------
>  fs/iomap/direct-io.c   | 10 ++++++----
>  include/linux/iomap.h  | 14 ++++++++++++++
>  3 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..f351e1f9e3f6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> -		struct iomap *iomap)
> +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> +		struct iomap *iomap, loff_t pos)
>  {
> -	size_t size = i_size_read(inode);
> +	size_t size = iomap->length + iomap->offset - pos;
>  	void *addr;
>  
>  	if (PageUptodate(page))
> -		return;
> +		return PAGE_SIZE;
>  
> -	BUG_ON(page_has_private(page));
> -	BUG_ON(page->index);
> -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	/* inline data must start page aligned in the file */
> +	if (WARN_ON_ONCE(offset_in_page(pos)))
> +		return -EIO;
> +	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> +		return -EIO;
> +	if (WARN_ON_ONCE(page_has_private(page)))
> +		return -EIO;
>  
>  	addr = kmap_atomic(page);
> -	memcpy(addr, iomap->inline_data, size);
> +	memcpy(addr, iomap_inline_buf(iomap, pos), size);
>  	memset(addr + size, 0, PAGE_SIZE - size);
>  	kunmap_atomic(addr);
>  	SetPageUptodate(page);
> +	return PAGE_SIZE;
>  }
>  
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -246,11 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> +	if (iomap->type == IOMAP_INLINE)
> +		return iomap_read_inline_data(inode, page, iomap, pos);
>  
>  	/* zero post-eof blocks as the page may be mapped */
>  	iop = iomap_page_create(inode, page);
> @@ -589,6 +590,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  	return 0;
>  }
>  
> +static int iomap_write_begin_inline(struct inode *inode,
> +		struct page *page, struct iomap *srcmap)
> +{
> +	/* needs more work for the tailpacking case, disable for now */
> +	if (WARN_ON_ONCE(srcmap->offset != 0))
> +		return -EIO;
> +	return iomap_read_inline_data(inode, page, srcmap, 0);
> +}
> +
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> @@ -618,14 +628,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  	}
>  
>  	if (srcmap->type == IOMAP_INLINE)
> -		iomap_read_inline_data(inode, page, srcmap);
> +		status = iomap_write_begin_inline(inode, page, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
>  		status = __iomap_write_begin(inode, pos, len, flags, page,
>  				srcmap);
>  
> -	if (unlikely(status))
> +	if (unlikely(status < 0))
>  		goto out_unlock;
>  
>  	*pagep = page;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..a6aaea2764a5 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  		struct iomap_dio *dio, struct iomap *iomap)
>  {
>  	struct iov_iter *iter = dio->submit.iter;
> +	void *dst = iomap_inline_buf(iomap, pos);
>  	size_t copied;
>  
> -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> +		return -EIO;
>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		loff_t size = inode->i_size;
>  
>  		if (pos > size)
> -			memset(iomap->inline_data + size, 0, pos - size);
> -		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +			memset(iomap_inline_buf(iomap, size), 0, pos - size);
> +		copied = copy_from_iter(dst, length, iter);
>  		if (copied) {
>  			if (pos + copied > size)
>  				i_size_write(inode, pos + copied);
>  			mark_inode_dirty(inode);
>  		}
>  	} else {
> -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +		copied = copy_to_iter(dst, length, iter);
>  	}
>  	dio->size += copied;
>  	return copied;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 479c1da3e221..56b118c6d05c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -97,6 +97,20 @@ iomap_sector(struct iomap *iomap, loff_t pos)
>  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>  
> +static inline void *iomap_inline_buf(const struct iomap *iomap, loff_t pos)
> +{
> +	return iomap->inline_data - iomap->offset + pos;
> +}
> +
> +/*
> + * iomap->inline_data is a potentially kmapped page, ensure it never crosses a
> + * page boundary.
> + */
> +static inline bool iomap_inline_data_size_valid(const struct iomap *iomap)
> +{
> +	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
> +}
> +
>  /*
>   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
>   * and page_done will be called for each page written to.  This only applies to
> 
