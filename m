Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B3170EDC6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 08:17:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QR1FT4GPtz3cjL
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 16:17:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QR1FL4btNz2xHb
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 16:17:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjMtVRI_1684909055;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjMtVRI_1684909055)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 14:17:36 +0800
Message-ID: <058b354f-3543-bf60-4a1c-8e4bcefcd49a@linux.alibaba.com>
Date: Wed, 24 May 2023 14:17:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: remove the member readahead from struct
 z_erofs_decompress_frontend
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230524061152.30155-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230524061152.30155-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/24 23:11, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The struct member is only used to add REQ_RAHEAD during I/O submission.
> So it is cleaner to pass it as a parameter than keep it in the struct.
> 
> Also, rename function z_erofs_get_sync_decompress_policy() to
> z_erofs_is_sync_decompress() for better clarity and conciseness.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   fs/erofs/zdata.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 45f21db2303a..4522a3be2ce9 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -550,7 +550,6 @@ struct z_erofs_decompress_frontend {
>   	z_erofs_next_pcluster_t owned_head;
>   	enum z_erofs_pclustermode mode;
>   
> -	bool readahead;
>   	/* used for applying cache strategy on the fly */
>   	bool backmost;
>   	erofs_off_t headoffset;
> @@ -1106,7 +1105,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   	return err;
>   }
>   
> -static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
> +static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
>   				       unsigned int readahead_pages)
>   {
>   	/* auto: enable for read_folio, disable for readahead */
> @@ -1672,7 +1671,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
>   static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   				 struct page **pagepool,
>   				 struct z_erofs_decompressqueue *fgq,
> -				 bool *force_fg)
> +				 bool *force_fg, bool readahead)
>   {
>   	struct super_block *sb = f->inode->i_sb;
>   	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
> @@ -1763,7 +1762,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   				bio->bi_iter.bi_sector = (sector_t)cur <<
>   					(sb->s_blocksize_bits - 9);
>   				bio->bi_private = q[JQ_SUBMIT];
> -				if (f->readahead)
> +				if (readahead)
>   					bio->bi_opf |= REQ_RAHEAD;
>   				++nr_bios;
>   			}
> @@ -1799,13 +1798,14 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   }
>   
>   static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
> -			     struct page **pagepool, bool force_fg)
> +			     struct page **pagepool, bool force_fg,
> +			     bool readahead)

			     struct page **pagepool, bool force_fg, bool ra)


>   {
>   	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
>   
>   	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
>   		return;
> -	z_erofs_submit_queue(f, pagepool, io, &force_fg);
> +	z_erofs_submit_queue(f, pagepool, io, &force_fg, readahead);

	z_erofs_submit_queue(f, pagepool, io, &force_fg, ra);


Otherwise it seems ok to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
