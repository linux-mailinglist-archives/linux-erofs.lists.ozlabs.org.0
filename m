Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B13D44FA
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 06:47:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWtvf4hlqz30FB
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 14:47:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWtvZ2Vk4z2yXh
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 14:47:04 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R931e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0UglywVI_1627102006; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UglywVI_1627102006) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 24 Jul 2021 12:46:48 +0800
Date: Sat, 24 Jul 2021 12:46:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 2/2] iomap: Support inline data with block size < page size
Message-ID: <YPubNbDS0KgUALtt@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org
References: <20210724034435.2854295-1-willy@infradead.org>
 <20210724034435.2854295-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210724034435.2854295-3-willy@infradead.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Matthew,

On Sat, Jul 24, 2021 at 04:44:35AM +0100, Matthew Wilcox (Oracle) wrote:
> Remove the restriction that inline data must start on a page boundary
> in a file.  This allows, for example, the first 2KiB to be stored out
> of line and the trailing 30 bytes to be stored inline.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7bd8e5de996d..d7d6af29af7f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -209,25 +209,23 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
>  		struct iomap *iomap, loff_t pos)
>  {
>  	size_t size = iomap->length + iomap->offset - pos;
> +	size_t poff = offset_in_page(pos);
>  	void *addr;
>  
>  	if (PageUptodate(page))
> -		return PAGE_SIZE;
> +		return PAGE_SIZE - poff;
>  
> -	/* inline data must start page aligned in the file */
> -	if (WARN_ON_ONCE(offset_in_page(pos)))
> -		return -EIO;
>  	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
>  		return -EIO;
> -	if (WARN_ON_ONCE(page_has_private(page)))
> -		return -EIO;
> +	if (poff > 0)
> +		iomap_page_create(inode, page);

Thanks for the patch!

Previously I'd like to skip the leading uptodate blocks and update the
extent it covers that is due to already exist iop. If we get rid of the
offset_in_page(pos) restriction like this, I'm not sure if we (or some
other fs users) could face something like below (due to somewhat buggy
fs users likewise):

 [0 - 4096)    plain block

 [4096 - 4608)  tail INLINE 1 (e.g. by mistake or just splitted
                                    .iomap_begin() report.)
 [4608 - 5120]  tail INLINE 2

with this code iomap_set_range_uptodate() wouldn't behave correctly.

In addition, currently EROFS cannot test such path (since EROFS is
page-sized block only for now) as Darrick said in the previous reply,
so I think it would be better together with the folio patchset and
targeted for the corresponding merge window, so I can test iomap
supported EROFS with the new folio support together (That also give
me some time to support sub-pagesized uncompressed blocks...)

>  
> -	addr = kmap_atomic(page);
> +	addr = kmap_atomic(page) + poff;
>  	memcpy(addr, iomap_inline_buf(iomap, pos), size);
> -	memset(addr + size, 0, PAGE_SIZE - size);
> +	memset(addr + size, 0, PAGE_SIZE - poff - size);
>  	kunmap_atomic(addr);

As my limited understanding, this may need to be fixed, since it
doesn't match kmap_atomic(page)...

Thanks,
Gao Xiang

> -	SetPageUptodate(page);
> -	return PAGE_SIZE;
> +	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> +	return PAGE_SIZE - poff;
>  }
>  
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> -- 
> 2.30.2
> 
