Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA783593D
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 03:08:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJDCC4bdxz2ykn
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 13:08:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJDC225bVz30h8
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 13:07:56 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.03HLg_1705889268;
Received: from 30.97.48.216(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.03HLg_1705889268)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 10:07:49 +0800
Message-ID: <cd64ee05-e8b2-4cd0-93e5-6bf787774d1f@linux.alibaba.com>
Date: Mon, 22 Jan 2024 10:07:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: relaxed temporary buffers allocation on
 readahead
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240120145551.1941483-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240120145551.1941483-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/1/20 22:55, Chunhai Guo wrote:
> Even with inplace decompression, sometimes extra temporary buffers are
> still needed for decompression.  In low-memory scenarios, it would be
> better to try to allocate with GFP_NOWAIT on readahead first. That can
> help reduce the time spent on page allocation under memory pressure.
> 
> There is an average reduction of 21% in page allocation time under

It would be better to add a table to show the absolute numbers too
(like what you did in the global pool commit.)  If it's possible, there
is no need to send a update version for this, just reply the updated
commit message and I will update the commit manually.

Otherwise it looks good to me,

Thanks,
Gao Xiang

> multi-app launch benchmark workload [1] on ARM64 Android devices running
> the 5.15 kernel with an 8-core CPU and 8GB of memory.
> 
> [1] https://lore.kernel.org/r/20240109074143.4138783-1-guochunhai@vivo.com
> 
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/compress.h             |  5 ++---
>   fs/erofs/decompressor.c         |  5 +++--
>   fs/erofs/decompressor_deflate.c | 19 +++++++++++++------
>   fs/erofs/decompressor_lzma.c    | 17 ++++++++++++-----
>   fs/erofs/zdata.c                | 16 ++++++++++++----
>   5 files changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 279933e007d2..7cc5841577b2 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -11,13 +11,12 @@
>   struct z_erofs_decompress_req {
>   	struct super_block *sb;
>   	struct page **in, **out;
> -
>   	unsigned short pageofs_in, pageofs_out;
>   	unsigned int inputsize, outputsize;
>   
> -	/* indicate the algorithm will be used for decompression */
> -	unsigned int alg;
> +	unsigned int alg;       /* the algorithm for decompression */
>   	bool inplace_io, partial_decoding, fillgaps;
> +	gfp_t gfp;      /* allocation flags for extra temporary buffers */
>   };
>   
>   struct z_erofs_decompressor {
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1d65b9f60a39..ef2b08ec9830 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -111,8 +111,9 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
>   			victim = availables[--top];
>   			get_page(victim);
>   		} else {
> -			victim = erofs_allocpage(pagepool,
> -						 GFP_KERNEL | __GFP_NOFAIL);
> +			victim = erofs_allocpage(pagepool, rq->gfp);
> +			if (!victim)
> +				return -ENOMEM;
>   			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
>   		}
>   		rq->out[i] = victim;
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
> index 4a64a9c91dd3..b98872058abe 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -95,7 +95,7 @@ int z_erofs_load_deflate_config(struct super_block *sb,
>   }
>   
>   int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
> -			       struct page **pagepool)
> +			       struct page **pgpl)
>   {
>   	const unsigned int nrpages_out =
>   		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
> @@ -158,8 +158,12 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>   			strm->z.avail_out = min_t(u32, outsz, PAGE_SIZE - pofs);
>   			outsz -= strm->z.avail_out;
>   			if (!rq->out[no]) {
> -				rq->out[no] = erofs_allocpage(pagepool,
> -						GFP_KERNEL | __GFP_NOFAIL);
> +				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
> +				if (!rq->out[no]) {
> +					kout = NULL;
> +					err = -ENOMEM;
> +					break;
> +				}
>   				set_page_private(rq->out[no],
>   						 Z_EROFS_SHORTLIVED_PAGE);
>   			}
> @@ -211,8 +215,11 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>   
>   			DBG_BUGON(erofs_page_is_managed(EROFS_SB(sb),
>   							rq->in[j]));
> -			tmppage = erofs_allocpage(pagepool,
> -						  GFP_KERNEL | __GFP_NOFAIL);
> +			tmppage = erofs_allocpage(pgpl, rq->gfp);
> +			if (!tmppage) {
> +				err = -ENOMEM;
> +				goto failed;
> +			}
>   			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
>   			copy_highpage(tmppage, rq->in[j]);
>   			rq->in[j] = tmppage;
> @@ -230,7 +237,7 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>   			break;
>   		}
>   	}
> -
> +failed:
>   	if (zlib_inflateEnd(&strm->z) != Z_OK && !err)
>   		err = -EIO;
>   	if (kout)
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index 2dd14f99c1dc..6ca357d83cfa 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -148,7 +148,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
>   }
>   
>   int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
> -			    struct page **pagepool)
> +			    struct page **pgpl)
>   {
>   	const unsigned int nrpages_out =
>   		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
> @@ -215,8 +215,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
>   						   PAGE_SIZE - pageofs);
>   			outlen -= strm->buf.out_size;
>   			if (!rq->out[no] && rq->fillgaps) {	/* deduped */
> -				rq->out[no] = erofs_allocpage(pagepool,
> -						GFP_KERNEL | __GFP_NOFAIL);
> +				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
> +				if (!rq->out[no]) {
> +					err = -ENOMEM;
> +					break;
> +				}
>   				set_page_private(rq->out[no],
>   						 Z_EROFS_SHORTLIVED_PAGE);
>   			}
> @@ -258,8 +261,11 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
>   
>   			DBG_BUGON(erofs_page_is_managed(EROFS_SB(rq->sb),
>   							rq->in[j]));
> -			tmppage = erofs_allocpage(pagepool,
> -						  GFP_KERNEL | __GFP_NOFAIL);
> +			tmppage = erofs_allocpage(pgpl, rq->gfp);
> +			if (!tmppage) {
> +				err = -ENOMEM;
> +				goto failed;
> +			}
>   			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
>   			copy_highpage(tmppage, rq->in[j]);
>   			rq->in[j] = tmppage;
> @@ -277,6 +283,7 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
>   			break;
>   		}
>   	}
> +failed:
>   	if (no < nrpages_out && strm->buf.out)
>   		kunmap(rq->out[no]);
>   	if (ni < nrpages_in)
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 692c0c39be63..a293de2a60ed 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -82,6 +82,9 @@ struct z_erofs_pcluster {
>   	/* L: indicate several pageofs_outs or not */
>   	bool multibases;
>   
> +	/* L: whether extra buffer allocations are best-effort */
> +	bool besteffort;
> +
>   	/* A: compressed bvecs (can be cached or inplaced pages) */
>   	struct z_erofs_bvec compressed_bvecs[];
>   };
> @@ -964,7 +967,7 @@ static int z_erofs_read_fragment(struct super_block *sb, struct page *page,
>   }
>   
>   static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> -				struct page *page)
> +				struct page *page, bool ra)
>   {
>   	struct inode *const inode = fe->inode;
>   	struct erofs_map_blocks *const map = &fe->map;
> @@ -1014,6 +1017,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   		err = z_erofs_pcluster_begin(fe);
>   		if (err)
>   			goto out;
> +		fe->pcl->besteffort |= !ra;
>   	}
>   
>   	/*
> @@ -1280,7 +1284,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   					.inplace_io = overlapped,
>   					.partial_decoding = pcl->partial,
>   					.fillgaps = pcl->multibases,
> +					.gfp = pcl->besteffort ?
> +						GFP_KERNEL | __GFP_NOFAIL :
> +						GFP_NOWAIT | __GFP_NORETRY
>   				 }, be->pagepool);
> +	pcl->besteffort = false;
>   
>   	/* must handle all compressed pages before actual file pages */
>   	if (z_erofs_is_inline_pcluster(pcl)) {
> @@ -1785,7 +1793,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>   			if (PageUptodate(page))
>   				unlock_page(page);
>   			else
> -				(void)z_erofs_do_read_page(f, page);
> +				(void)z_erofs_do_read_page(f, page, !!rac);
>   			put_page(page);
>   		}
>   
> @@ -1806,7 +1814,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   	f.headoffset = (erofs_off_t)folio->index << PAGE_SHIFT;
>   
>   	z_erofs_pcluster_readmore(&f, NULL, true);
> -	err = z_erofs_do_read_page(&f, &folio->page);
> +	err = z_erofs_do_read_page(&f, &folio->page, false);
>   	z_erofs_pcluster_readmore(&f, NULL, false);
>   	z_erofs_pcluster_end(&f);
>   
> @@ -1847,7 +1855,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   		folio = head;
>   		head = folio_get_private(folio);
>   
> -		err = z_erofs_do_read_page(&f, &folio->page);
> +		err = z_erofs_do_read_page(&f, &folio->page, true);
>   		if (err && err != -EINTR)
>   			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
>   				  folio->index, EROFS_I(inode)->nid);
