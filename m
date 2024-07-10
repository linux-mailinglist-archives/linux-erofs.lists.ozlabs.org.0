Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B992CBBF
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 09:15:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kmhb1foz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJpzh08hGz3cXy
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 17:15:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kmhb1foz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJpzY0FXTz30fp
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 17:15:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720595730; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w6MlYrqqH3+412KbW3xKJAuVfOZSQQLGCoZYPurlYPI=;
	b=Kmhb1foz/ReFq/vJX5gxuhnu29cQt4TtGEW5qzToN7h/Sc/QUmAusTDTisaRzR+Bwhd2zyl9ekdRHl0CF4fB8GJHfSe9bqEmVB0jxK60xQcfcqUlSj3Pp9ifoIOGpgVTmPzOzoSME2EJRDlY45fgqb/NIUmVOoeSpYeoaNKmCXY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAELlsg_1720595728;
Received: from 30.97.48.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAELlsg_1720595728)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 15:15:29 +0800
Message-ID: <bcdfba50-36df-4d8a-84fd-fdc4e94d4122@linux.alibaba.com>
Date: Wed, 10 Jul 2024 15:15:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs-utils: add per-sbi buffer support
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240710065929.114911-1-hongzhen@linux.alibaba.com>
 <20240710065929.114911-2-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240710065929.114911-2-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/10 14:59, Hongzhen Luo wrote:
> This updates all relevant function definitions and callers
> to get rid of the global g_sbi, making it suitable for external
> use in liberofs.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   include/erofs/cache.h    |  42 ++++++----
>   include/erofs/internal.h |   5 +-
>   lib/blobchunk.c          |  20 ++---
>   lib/cache.c              | 162 +++++++++++++++++++++------------------
>   lib/compress.c           |  40 +++++-----
>   lib/inode.c              |  43 ++++++-----
>   lib/super.c              |  21 ++---
>   lib/xattr.c              |  10 +--
>   mkfs/main.c              |  15 ++--
>   9 files changed, 198 insertions(+), 160 deletions(-)
> 
> diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> index 288843e..16148ea 100644
> --- a/include/erofs/cache.h
> +++ b/include/erofs/cache.h
> @@ -53,10 +53,20 @@ struct erofs_buffer_block {
>   	struct erofs_buffer_head buffers;
>   };
>   
> -static inline const int get_alignsize(int type, int *type_ret)
> -{
> -	struct erofs_sb_info *sbi = &g_sbi;
> +struct erofs_buffer_manager {
> +	struct erofs_buffer_block blkh;
> +	erofs_blk_t tail_blkaddr, erofs_metablkcnt;
> +
> +	/* buckets for all mapped buffer blocks to boost up allocation */
> +	struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
>   
> +	/* last mapped buffer block to accelerate erofs_mapbh() */
> +	struct erofs_buffer_block *last_mapped_block;
> +};
> +
> +static inline const int get_alignsize(struct erofs_sb_info *sbi, int type,
> +				      int *type_ret)
> +{
>   	if (type == DATA)
>   		return erofs_blksiz(sbi);
>   
> @@ -82,10 +92,10 @@ static inline const int get_alignsize(int type, int *type_ret)
>   extern const struct erofs_bhops erofs_drop_directly_bhops;
>   extern const struct erofs_bhops erofs_skip_write_bhops;
>   
> -static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
> +static inline erofs_off_t erofs_btell(struct erofs_sb_info *sbi,
> +				      struct erofs_buffer_head *bh, bool end)


Actually I think you could just use bh->block->buffers.fsprivate
to keep sbi, so that interfaces which involve
"struct erofs_buffer_head *" don't need to change.

>   {
>   	const struct erofs_buffer_block *bb = bh->block;
> -	struct erofs_sb_info *sbi = &g_sbi;
>   
>   	if (bb->blkaddr == NULL_ADDR)
>   		return NULL_ADDR_UL;
> @@ -101,20 +111,26 @@ static inline int erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
>   	return 0;
>   }
>   
> -void erofs_buffer_init(erofs_blk_t startblk);
> -int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
> +void erofs_buffer_init(struct erofs_sb_info *sbi, erofs_blk_t startblk);
> +int erofs_bh_balloon(struct erofs_sb_info *sbi, struct erofs_buffer_head *bh,
> +		     erofs_off_t incr);

Same here.

>   
> -struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
> +struct erofs_buffer_head *erofs_balloc(struct erofs_sb_info *sbi,
> +				       int type, erofs_off_t size,
>   				       unsigned int required_ext,
>   				       unsigned int inline_ext);
> -struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
> +struct erofs_buffer_head *erofs_battach(struct erofs_sb_info *sbi,
> +					struct erofs_buffer_head *bh,
>   					int type, unsigned int size);

Same here.

>   
> -void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
> -erofs_blk_t erofs_total_metablocks(void);
> +void erofs_bdrop(struct erofs_sb_info *sbi, struct erofs_buffer_head *bh,
> +		 bool tryrevoke);

...

Thanks,
Gao Xiang
