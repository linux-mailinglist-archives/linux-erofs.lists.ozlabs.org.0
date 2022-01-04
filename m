Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD9484390
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 15:41:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSwKd33dNz2yp5
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 01:41:25 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSwKX1wJpz2x9K
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 01:41:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R601e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0V0y0W7N_1641307254; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0y0W7N_1641307254) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 04 Jan 2022 22:40:56 +0800
Date: Tue, 4 Jan 2022 22:40:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v1 13/23] erofs: implement fscache-based data read
Message-ID: <YdRcdqIUkqIIw6EP@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
 gerry@linux.alibaba.com, eguan@linux.alibaba.com,
 linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-14-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-14-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 27, 2021 at 08:54:34PM +0800, Jeffle Xu wrote:
> This patch implements the data plane of reading data from bootstrap blob
> file over fscache.
> 
> Be noted that currently compressed layout is not supported yet.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  6 ++-
>  fs/erofs/internal.h |  1 +
>  3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 325f5663836b..bfcec831d58a 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -65,6 +65,97 @@ struct page *erofs_readpage_from_fscache(struct erofs_cookie_ctx *ctx,
>  	return page;
>  }
>  
> +static inline void do_copy_page(struct page *from, struct page *to,
> +				size_t offset, size_t len)
> +{
> +	char *vfrom, *vto;
> +
> +	vfrom = kmap_atomic(from);
> +	vto = kmap_atomic(to);
> +	memcpy(vto, vfrom + offset, len);
> +	kunmap_atomic(vto);
> +	kunmap_atomic(vfrom);
> +}
> +
> +static int erofs_fscache_do_readpage(struct file *file, struct page *page)
> +{
> +	struct inode *inode = page->mapping->host;
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_map_blocks map;
> +	erofs_off_t o_la, pa;
> +	size_t offset, len;
> +	struct page *ipage;
> +	int ret;
> +
> +	if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +		erofs_info(sb, "compressed layout not supported yet");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	o_la = page_offset(page);
> +	map.m_la = o_la;
> +
> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (ret)
> +		return ret;
> +
> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		zero_user(page, 0, PAGE_SIZE);
> +		return 0;
> +	}
> +
> +	/*
> +	 * 1) For FLAT_PLAIN/FLAT_INLINE layout, the output map.m_la shall be
> +	 * equal to o_la, and the output map.m_pa is exactly the physical
> +	 * address of o_la.
> +	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
> +	 * nearest chunk boundary, and the output map.m_pa is actually the
> +	 * physical address of this chunk boundary. So we need to recalculate
> +	 * the actual physical address of o_la.
> +	 */
> +	pa = map.m_pa + o_la - map.m_la;
> +
> +	ipage = erofs_get_meta_page(sb, erofs_blknr(pa));
> +	if (IS_ERR(ipage))
> +		return PTR_ERR(ipage);
> +
> +	/*
> +	 * @offset refers to the page offset inside @ipage.
> +	 * 1) Except for the inline layout, the offset shall all be 0, and @pa
> +	 * shall be aligned with EROFS_BLKSIZ in this case. Thus we can
> +	 * conveniently get the offset from @pa.
> +	 * 2) While for the inline layout, the offset may be non-zero. Since
> +	 * currently only flat layout supports inline, we can calculate the
> +	 * offset from the corresponding physical address.
> +	 */
> +	offset = erofs_blkoff(pa);
> +	len = min_t(u64, map.m_llen, PAGE_SIZE);
> +
> +	do_copy_page(ipage, page, offset, len);

If my understanding is correct, I still have no idea why we need to
copy data here even if fscache can do direct I/O for us without extra
efforts.

I think the only case would be tail-packing inline (which should go
through metadata path), otherwise, all data is block-aligned. So
fscache can handle it directly.

Thanks,
Gao Xiang
