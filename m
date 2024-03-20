Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B6488173F
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Mar 2024 19:17:02 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LlzolyLU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0GyN4g4Vz3vbN
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 05:17:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LlzolyLU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0Gy85TMNz3vY6
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 05:16:48 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1def89f0cfdso9859735ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 20 Mar 2024 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710958606; x=1711563406; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp9FyUjhx5k+46y7SMZsIyxg8t9naOYtbLz0sH05cig=;
        b=LlzolyLUyi78NAUsqgsygrgh1U1dyZlEItsJZoKP2X9wi10lgrTnuRxQ/zF1K4xYGb
         xAb1bi13NfdxF1gvCQGaI7jkcV8AgDVVgEhoyffb7K7pq1GspvK2yst8ynXlkboxIoIB
         y8fzTVtORr0Tj9XNHXimP+72Rt/15x7tD+4niwOWZNbSElTqP2SyqUbBsdBupoGuNQpe
         oocqVxKwnZvn1vPxcwCfnJWhb2cn8IKnWX8IfUYdVh9d4bIigC47JNlFnnLAKlUdx8x5
         i+lvtCYpM6D6k7REaBqMJ5x3NLpS0XxtQ/JePCYjJ/xCmj/CkGisU+/T+zaCAGzYNDyK
         wsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710958606; x=1711563406;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wp9FyUjhx5k+46y7SMZsIyxg8t9naOYtbLz0sH05cig=;
        b=B1gkp7n3nudSoaFUe4iryzglWk1rH7ncFNSrE2hkjFQkPHdkTT8JP7H0+OJtAPYoEa
         6vNPNjQVI+aZpubg4lYyyqwyyo103roqj/EtEB4eYjKrjHxoMfsBTWDzZB/RgGQtgb4s
         RzMmxDY0CTv0eZnoEwvDoZbkJul+ceLVW0Ua/B3d/NglmZ5nytc/4YFpSBuROZ3+sAGn
         fC684+/03MixEkoQF/VLfy9OMu+EGAqV6jzKNUQmku3v5Yxs8VwKDyl36v+8buV9TLBq
         Yiv0zI9lTzO/o/GXHS5JvTq2NKcoFCKUbED6hvq7bzfyFth46D99cQlPmbOXjFymVZAd
         oOlw==
X-Gm-Message-State: AOJu0YydQt9IF9J/xWv+PPYe927mrsAv3N/t8ACxLeUg39jm7ZgzSUr7
	LjvgsAqGLjXwg0+fDntE5NY3zlLcui4GpYb92S8I4lz5ldA/ToZ0bZrffhrq
X-Google-Smtp-Source: AGHT+IHH+rc2I4I3ivCqI2noAdVEMbzk+m9IIaURShzoUOK1cjYgxx8PaWozj0DsHwGKptLExrem3Q==
X-Received: by 2002:a17:902:bd42:b0:1e0:e14:b19d with SMTP id b2-20020a170902bd4200b001e00e14b19dmr427194plx.18.1710958606051;
        Wed, 20 Mar 2024 11:16:46 -0700 (PDT)
Received: from [127.0.0.1] (awork111158.netvigator.com. [203.198.94.158])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b001db9c3d6506sm14144191plb.209.2024.03.20.11.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 11:16:45 -0700 (PDT)
Message-ID: <a6f891c2-dc92-43d2-a630-661b7aac775c@gmail.com>
Date: Thu, 21 Mar 2024 02:15:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 2/2] erofs-utils: mkfs: introduce inter-file
 multi-threaded compression
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20240317144112.1445017-1-zhaoyifan@sjtu.edu.cn>
 <20240317144112.1445017-3-zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240317144112.1445017-3-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/3/17 22:41, Yifan Zhao wrote:
> This patch allows parallelizing the compression process of different
> files in mkfs. Specifically, a traverser thread traverses the files and
> issues the compression task, which is handled by the workers. Then, the
> main thread consumes them and writes the compressed data to the device.
>
> To this end, the logic of erofs_write_compressed_file() has been
> modified to split the creation and completion logic of the compression
> task.
>
> Signed-off-by: Yifan Zhao<zhaoyifan@sjtu.edu.cn>
> Co-authored-by: Tong Xin<xin_tong@sjtu.edu.cn>
> ---
>   include/erofs/compress.h |  16 ++
>   include/erofs/internal.h |   3 +
>   include/erofs/list.h     |   8 +
>   include/erofs/queue.h    |  22 +++
>   lib/Makefile.am          |   2 +-
>   lib/compress.c           | 323 +++++++++++++++++++++++++--------------
>   lib/inode.c              | 242 +++++++++++++++++++++++++++--
>   lib/queue.c              |  64 ++++++++
>   8 files changed, 553 insertions(+), 127 deletions(-)
>   create mode 100644 include/erofs/queue.h
>   create mode 100644 lib/queue.c
>
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index 3253611..9bcd888 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -17,6 +17,22 @@ extern "C"
>   #define EROFS_CONFIG_COMPR_MAX_SZ	(4000 * 1024)
>   #define Z_EROFS_COMPR_QUEUE_SZ		(EROFS_CONFIG_COMPR_MAX_SZ * 2)
>   
> +#ifdef EROFS_MT_ENABLED
> +struct z_erofs_mt_file {
> +	pthread_mutex_t mutex;
> +	pthread_cond_t cond;
> +	int total;
> +	int nfini;
> +
> +	int fd;
> +	struct erofs_compress_work *head;
> +
> +	struct z_erofs_mt_file *next;
> +};
> +
> +int z_erofs_mt_reap(struct z_erofs_mt_file *desc);
> +#endif
> +
>   void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
>   int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
>   
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 4cd2059..2580588 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -250,6 +250,9 @@ struct erofs_inode {
>   #ifdef WITH_ANDROID
>   	uint64_t capabilities;
>   #endif
> +#ifdef EROFS_MT_ENABLED
> +	struct z_erofs_mt_file *mt_desc;
> +#endif
>   };
>   
>   static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
> diff --git a/include/erofs/list.h b/include/erofs/list.h
> index d7a9fee..55383ac 100644
> --- a/include/erofs/list.h
> +++ b/include/erofs/list.h
> @@ -90,6 +90,14 @@ static inline void list_splice_tail(struct list_head *list,
>   		__list_splice(list, head->prev, head);
>   }
>   
> +static inline void list_replace(struct list_head *old, struct list_head *new)
> +{
> +	new->next = old->next;
> +	new->next->prev = new;
> +	new->prev = old->prev;
> +	new->prev->next = new;
> +}
> +
>   #define list_entry(ptr, type, member) container_of(ptr, type, member)
>   
>   #define list_first_entry(ptr, type, member)                                    \
> diff --git a/include/erofs/queue.h b/include/erofs/queue.h
> new file mode 100644
> index 0000000..35d29b0
> --- /dev/null
> +++ b/include/erofs/queue.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __EROFS_QUEUE_H
> +#define __EROFS_QUEUE_H
> +
> +#include "internal.h"
> +
> +struct erofs_queue {
> +    pthread_mutex_t lock;
> +    pthread_cond_t full, empty;
> +
> +    void *buf;
> +
> +    size_t size, elem_size;
> +    size_t head, tail;
> +};
> +
> +struct erofs_queue* erofs_alloc_queue(size_t size, size_t elem_size);
> +void erofs_push_queue(struct erofs_queue *q, void *elem);
> +void *erofs_pop_queue(struct erofs_queue *q);
> +void erofs_destroy_queue(struct erofs_queue *q);
> +
> +#endif
> \ No newline at end of file
Add newline character.
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index b3bea74..e4b7096 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -55,5 +55,5 @@ liberofs_la_SOURCES += compressor_libdeflate.c
>   endif
>   if ENABLE_EROFS_MT
>   liberofs_la_LDFLAGS = -lpthread
> -liberofs_la_SOURCES += workqueue.c
> +liberofs_la_SOURCES += workqueue.c queue.c
>   endif
> diff --git a/lib/compress.c b/lib/compress.c
> index 8d88dd1..9eb40b5 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -7,6 +7,7 @@
>    */
>   #ifndef _LARGEFILE64_SOURCE
>   #define _LARGEFILE64_SOURCE
> +#include "erofs/internal.h"
>   #endif
>   #include <string.h>
>   #include <stdlib.h>
> @@ -84,6 +85,7 @@ struct erofs_compress_work {
>   	struct erofs_work work;
>   	struct z_erofs_compress_sctx ctx;
>   	struct erofs_compress_work *next;
> +	struct z_erofs_mt_file *mtfile_desc;
>   
>   	unsigned int alg_id;
>   	char *alg_name;
> @@ -95,14 +97,14 @@ struct erofs_compress_work {
>   
>   static struct {
>   	struct erofs_workqueue wq;
> -	struct erofs_compress_work *idle;
> -	pthread_mutex_t mutex;
> -	pthread_cond_t cond;
> -	int nfini;
> +	struct erofs_compress_work *work_idle;
> +	pthread_mutex_t work_mutex;
> +	struct z_erofs_mt_file *file_idle;
> +	pthread_mutex_t file_mutex;
>   } z_erofs_mt_ctrl;
>   #endif
>   
> -static bool z_erofs_mt_enabled;
> +bool z_erofs_mt_enabled;
>   
>   #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
>   
> @@ -1022,6 +1024,90 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
>   	return 0;
>   }
>   
> +int z_erofs_finalize_compression(struct z_erofs_compress_ictx *ictx,
> +				 struct erofs_buffer_head *bh,
> +				 erofs_blk_t blkaddr,
> +				 erofs_blk_t compressed_blocks)
> +{
> +	struct erofs_inode *inode = ictx->inode;
> +	struct erofs_sb_info *sbi = inode->sbi;
> +	u8 *compressmeta = ictx->metacur - Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> +	unsigned int legacymetasize;
> +	int ret = 0;
> +
> +	/* fall back to no compression mode */
> +	DBG_BUGON(compressed_blocks < !!inode->idata_size);
> +	compressed_blocks -= !!inode->idata_size;
> +
> +	z_erofs_write_indexes(ictx);
> +	legacymetasize = ictx->metacur - compressmeta;
> +	/* estimate if data compression saves space or not */
> +	if (!inode->fragment_size &&
> +	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
> +	    legacymetasize >= inode->i_size) {
> +		z_erofs_dedupe_commit(true);
> +
> +		if (inode->idata) {
> +			free(inode->idata);
> +			inode->idata = NULL;
> +		}
> +		erofs_bdrop(bh, true); /* revoke buffer */
> +		free(compressmeta);
> +		inode->compressmeta = NULL;
> +
> +		return -ENOSPC;
> +	}
> +	z_erofs_dedupe_commit(false);
> +	z_erofs_write_mapheader(inode, compressmeta);
> +
> +	if (!ictx->fragemitted)
> +		sbi->saved_by_deduplication += inode->fragment_size;
> +
> +	/* if the entire file is a fragment, a simplified form is used. */
> +	if (inode->i_size <= inode->fragment_size) {
> +		DBG_BUGON(inode->i_size < inode->fragment_size);
> +		DBG_BUGON(inode->fragmentoff >> 63);
> +		*(__le64 *)compressmeta =
> +			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
> +		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
> +		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> +	}
> +
> +	if (compressed_blocks) {
> +		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
> +		DBG_BUGON(ret != erofs_blksiz(sbi));
> +	} else {
> +		if (!cfg.c_fragments && !cfg.c_dedupe)
> +			DBG_BUGON(!inode->idata_size);
> +	}
> +
> +	erofs_info("compressed %s (%llu bytes) into %u blocks",
> +		   inode->i_srcpath, (unsigned long long)inode->i_size,
> +		   compressed_blocks);
> +
> +	if (inode->idata_size) {
> +		bh->op = &erofs_skip_write_bhops;
> +		inode->bh_data = bh;
> +	} else {
> +		erofs_bdrop(bh, false);
> +	}
> +
> +	inode->u.i_blocks = compressed_blocks;
> +
> +	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
> +		inode->extent_isize = legacymetasize;
> +	} else {
> +		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
> +							  legacymetasize,
> +							  compressmeta);
> +		DBG_BUGON(ret);
> +	}
> +	inode->compressmeta = compressmeta;
> +	if (!erofs_is_packed_inode(inode))
> +		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
> +	return 0;
> +}
> +
>   #ifdef EROFS_MT_ENABLED
>   void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
>   {
> @@ -1096,6 +1182,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
>   	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
>   	struct erofs_compress_wq_tls *tls = tlsp;
>   	struct z_erofs_compress_sctx *sctx = &cwork->ctx;
> +	struct z_erofs_mt_file *mtfile_desc = cwork->mtfile_desc;
>   	struct erofs_sb_info *sbi = sctx->ictx->inode->sbi;
>   	int ret = 0;
>   
> @@ -1121,10 +1208,10 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
>   
>   out:
>   	cwork->errcode = ret;
> -	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> -	++z_erofs_mt_ctrl.nfini;
> -	pthread_cond_signal(&z_erofs_mt_ctrl.cond);
> -	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> +	pthread_mutex_lock(&mtfile_desc->mutex);
> +	++mtfile_desc->nfini;
> +	pthread_cond_signal(&mtfile_desc->cond);
> +	pthread_mutex_unlock(&mtfile_desc->mutex);
>   }
>   
>   int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
> @@ -1158,27 +1245,49 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
>   }
>   
>   int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
> -			struct erofs_compress_cfg *ccfg,
> -			erofs_blk_t blkaddr,
> -			erofs_blk_t *compressed_blocks)
> +			struct erofs_compress_cfg *ccfg)
>   {
>   	struct erofs_compress_work *cur, *head = NULL, **last = &head;
>   	struct erofs_inode *inode = ictx->inode;
> +	struct z_erofs_mt_file *mtfile_desc;
>   	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
> -	int ret, i;
> +	int i;
> +
> +	pthread_mutex_lock(&z_erofs_mt_ctrl.file_mutex);
> +	if (z_erofs_mt_ctrl.file_idle) {
> +		mtfile_desc = z_erofs_mt_ctrl.file_idle;
> +		z_erofs_mt_ctrl.file_idle = mtfile_desc->next;
> +		mtfile_desc->next = NULL;
> +		pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
> +	} else {
> +		pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
> +		mtfile_desc = calloc(1, sizeof(*mtfile_desc));
> +		if (!mtfile_desc)
> +			goto err_free_ictx;
> +	}
Nit:

pthread_mutex_lock(&z_erofs_mt_ctrl.file_mutex);
if (z_erofs_mt_ctrl.file_idle) {
	mtfile_desc = z_erofs_mt_ctrl.file_idle;
	z_erofs_mt_ctrl.file_idle = mtfile_desc->next;
	mtfile_desc->next = NULL;
}
pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
if (!mtfile_desc)
	mtfile_desc = calloc(1, sizeof(*mtfile_desc));
	if (!mtfile_desc)
		goto err_free_ictx;
}

> +	inode->mt_desc = mtfile_desc;
>   
> -	z_erofs_mt_ctrl.nfini = 0;
> +	mtfile_desc->fd = ictx->fd;
> +	mtfile_desc->total = nsegs;
> +	mtfile_desc->nfini = 0;
> +	pthread_mutex_init(&mtfile_desc->mutex, NULL);
> +	pthread_cond_init(&mtfile_desc->cond, NULL);
>   
>   	for (i = 0; i < nsegs; i++) {
> -		if (z_erofs_mt_ctrl.idle) {
> -			cur = z_erofs_mt_ctrl.idle;
> -			z_erofs_mt_ctrl.idle = cur->next;
> +		pthread_mutex_lock(&z_erofs_mt_ctrl.work_mutex);
> +		if (z_erofs_mt_ctrl.work_idle) {
> +			cur = z_erofs_mt_ctrl.work_idle;
> +			z_erofs_mt_ctrl.work_idle = cur->next;
>   			cur->next = NULL;
> +			pthread_mutex_unlock(&z_erofs_mt_ctrl.work_mutex);
>   		} else {
> +			pthread_mutex_unlock(&z_erofs_mt_ctrl.work_mutex);
Same here.
>   			cur = calloc(1, sizeof(*cur));
>   			if (!cur)
> -				return -ENOMEM;
> +				goto err_free_cwork;
>   		}
> +		if (i == 0)
> +			mtfile_desc->head = cur;
>   		*last = cur;
>   		last = &cur->next;
>   
> @@ -1202,21 +1311,40 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
>   		cur->comp_level = ccfg->handle.compression_level;
>   		cur->dict_size = ccfg->handle.dict_size;
>   
> +		cur->mtfile_desc = mtfile_desc;
>   		cur->work.fn = z_erofs_mt_workfn;
>   		erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
>   	}
>   
> -	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
> -	while (z_erofs_mt_ctrl.nfini != nsegs)
> -		pthread_cond_wait(&z_erofs_mt_ctrl.cond,
> -				  &z_erofs_mt_ctrl.mutex);
> -	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
> +	return 0;
>   
> -	ret = 0;
> +err_free_cwork:
>   	while (head) {
>   		cur = head;
>   		head = cur->next;
> +		free(cur);
> +	}
> +	free(mtfile_desc);
> +err_free_ictx:
> +	free(ictx);
Better to free in the outer function erofs_write_compressed_file.
> +	return -ENOMEM;
> +}
> +
> +int z_erofs_mt_reap(struct z_erofs_mt_file *desc) {
> +	struct erofs_buffer_head *bh = NULL;
> +	struct erofs_compress_work *cur = desc->head, *tmp;
> +	struct z_erofs_compress_ictx *ictx = cur->ctx.ictx;
> +	erofs_blk_t blkaddr, compressed_blocks = 0;
> +	int ret = 0;
> +
> +	bh = erofs_balloc(DATA, 0, 0, 0);
> +	if (IS_ERR(bh)) {
> +		ret = PTR_ERR(bh);
> +		goto out;
> +	}
> +	blkaddr = erofs_mapbh(bh->block);
>   
> +	while (cur) {
>   		if (cur->errcode) {
>   			ret = cur->errcode;
>   		} else {
> @@ -1227,13 +1355,30 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
>   			if (ret2)
>   				ret = ret2;
>   
> -			*compressed_blocks += cur->ctx.blkaddr - blkaddr;
> +			compressed_blocks += cur->ctx.blkaddr - blkaddr;
>   			blkaddr = cur->ctx.blkaddr;
>   		}
>   
> -		cur->next = z_erofs_mt_ctrl.idle;
> -		z_erofs_mt_ctrl.idle = cur;
> +		tmp = cur->next;
> +		pthread_mutex_lock(&z_erofs_mt_ctrl.work_mutex);
> +		cur->next = z_erofs_mt_ctrl.work_idle;
> +		z_erofs_mt_ctrl.work_idle = cur;
> +		pthread_mutex_unlock(&z_erofs_mt_ctrl.work_mutex);
> +		cur = tmp;
>   	}
> +	if (ret)
> +		goto out;
> +
> +	ret = z_erofs_finalize_compression(
> +		ictx, bh, blkaddr - compressed_blocks, compressed_blocks);
> +
> +out:
> +	free(ictx);
> +	pthread_mutex_lock(&z_erofs_mt_ctrl.file_mutex);
> +	desc->next = z_erofs_mt_ctrl.file_idle;
> +	z_erofs_mt_ctrl.file_idle = desc;
> +	pthread_mutex_unlock(&z_erofs_mt_ctrl.file_mutex);
> +
>   	return ret;
>   }
>   #endif
> @@ -1246,9 +1391,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>   	static struct z_erofs_compress_sctx sctx;
>   	struct erofs_compress_cfg *ccfg;
>   	erofs_blk_t blkaddr, compressed_blocks = 0;
> -	unsigned int legacymetasize;
>   	int ret;
> -	bool ismt = false;
>   	struct erofs_sb_info *sbi = inode->sbi;
>   	u8 *compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
>   				  sizeof(struct z_erofs_lcluster_index) +
> @@ -1257,11 +1400,17 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>   	if (!compressmeta)
>   		return -ENOMEM;
>   
> -	/* allocate main data buffer */
> -	bh = erofs_balloc(DATA, 0, 0, 0);
> -	if (IS_ERR(bh)) {
> -		ret = PTR_ERR(bh);
> -		goto err_free_meta;
> +	if (!z_erofs_mt_enabled) {
> +		/* allocate main data buffer */
> +		bh = erofs_balloc(DATA, 0, 0, 0);
> +		if (IS_ERR(bh)) {
> +			ret = PTR_ERR(bh);
> +			goto err_free_meta;
> +		}
> +		blkaddr = erofs_mapbh(bh->block); /* start_blkaddr */
> +	} else {
> +		bh = NULL;
> +		blkaddr = EROFS_NULL_ADDR;
>   	}
>   
>   	/* initialize per-file compression setting */
> @@ -1310,7 +1459,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>   			goto err_bdrop;
>   	}
>   
> -	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
>   	ctx.inode = inode;
>   	ctx.pclustersize = z_erofs_get_max_pclustersize(inode);
>   	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> @@ -1327,11 +1475,22 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>   		if (ret)
>   			goto err_free_idata;
>   #ifdef EROFS_MT_ENABLED
> -	} else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_size) {
> -		ismt = true;
> -		ret = z_erofs_mt_compress(&ctx, ccfg, blkaddr, &compressed_blocks);
> +	} else if (z_erofs_mt_enabled) {
> +		struct z_erofs_compress_ictx *l_ictx;
> +
> +		l_ictx = malloc(sizeof(*l_ictx));
> +		if (!l_ictx) {
> +			ret = -ENOMEM;
> +			goto err_free_idata;
> +		}
> +
> +		memcpy(l_ictx, &ctx, sizeof(*l_ictx));
> +		init_list_head(&l_ictx->extents);
> +
> +		ret = z_erofs_mt_compress(l_ictx, ccfg);
>   		if (ret)
>   			goto err_free_idata;
> +		return 0;
>   #endif
>   	} else {
>   		sctx.queue = g_queue;
> @@ -1348,10 +1507,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>   		compressed_blocks = sctx.blkaddr - blkaddr;
>   	}
>   
> -	/* fall back to no compression mode */
> -	DBG_BUGON(compressed_blocks < !!inode->idata_size);
> -	compressed_blocks -= !!inode->idata_size;
> -
>   	/* generate an extent for the deduplicated fragment */
>   	if (inode->fragment_size && !ctx.fragemitted) {
>   		struct z_erofs_extent_item *ei;
> @@ -1373,69 +1528,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>   		z_erofs_commit_extent(&sctx, ei);
>   	}
>   	z_erofs_fragments_commit(inode);
> +	list_splice_tail(&sctx.extents, &ctx.extents);
>   
> -	if (!ismt)
> -		list_splice_tail(&sctx.extents, &ctx.extents);
> -
> -	z_erofs_write_indexes(&ctx);
> -	legacymetasize = ctx.metacur - compressmeta;
> -	/* estimate if data compression saves space or not */
> -	if (!inode->fragment_size &&
> -	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
> -	    legacymetasize >= inode->i_size) {
> -		z_erofs_dedupe_commit(true);
> -		ret = -ENOSPC;
> -		goto err_free_idata;
> -	}
> -	z_erofs_dedupe_commit(false);
> -	z_erofs_write_mapheader(inode, compressmeta);
> -
> -	if (!ctx.fragemitted)
> -		sbi->saved_by_deduplication += inode->fragment_size;
> -
> -	/* if the entire file is a fragment, a simplified form is used. */
> -	if (inode->i_size <= inode->fragment_size) {
> -		DBG_BUGON(inode->i_size < inode->fragment_size);
> -		DBG_BUGON(inode->fragmentoff >> 63);
> -		*(__le64 *)compressmeta =
> -			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
> -		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
> -		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> -	}
> -
> -	if (compressed_blocks) {
> -		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
> -		DBG_BUGON(ret != erofs_blksiz(sbi));
> -	} else {
> -		if (!cfg.c_fragments && !cfg.c_dedupe)
> -			DBG_BUGON(!inode->idata_size);
> -	}
> -
> -	erofs_info("compressed %s (%llu bytes) into %u blocks",
> -		   inode->i_srcpath, (unsigned long long)inode->i_size,
> -		   compressed_blocks);
> -
> -	if (inode->idata_size) {
> -		bh->op = &erofs_skip_write_bhops;
> -		inode->bh_data = bh;
> -	} else {
> -		erofs_bdrop(bh, false);
> -	}
> -
> -	inode->u.i_blocks = compressed_blocks;
> -
> -	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
> -		inode->extent_isize = legacymetasize;
> -	} else {
> -		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
> -							  legacymetasize,
> -							  compressmeta);
> -		DBG_BUGON(ret);
> -	}
> -	inode->compressmeta = compressmeta;
> -	if (!erofs_is_packed_inode(inode))
> -		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
> -	return 0;
> +	return z_erofs_finalize_compression(&ctx, bh, blkaddr,
> +					    compressed_blocks);
>   
>   err_free_idata:
>   	if (inode->idata) {
> @@ -1443,7 +1539,8 @@ err_free_idata:
>   		inode->idata = NULL;
>   	}
>   err_bdrop:
> -	erofs_bdrop(bh, true);	/* revoke buffer */
> +	if (bh)
> +		erofs_bdrop(bh, true);	/* revoke buffer */
>   err_free_meta:
>   	free(compressmeta);
>   	inode->compressmeta = NULL;
> @@ -1594,8 +1691,6 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
>   	z_erofs_mt_enabled = false;
>   #ifdef EROFS_MT_ENABLED
>   	if (cfg.c_mt_workers > 1) {
> -		pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
> -		pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
Initialize work_mutex and file_mutex ?
>   		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
>   					    cfg.c_mt_workers,
>   					    cfg.c_mt_workers << 2,
> @@ -1622,11 +1717,17 @@ int z_erofs_compress_exit(void)
>   		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
>   		if (ret)
>   			return ret;
> -		while (z_erofs_mt_ctrl.idle) {
> +		while (z_erofs_mt_ctrl.work_idle) {
>   			struct erofs_compress_work *tmp =
> -				z_erofs_mt_ctrl.idle->next;
> -			free(z_erofs_mt_ctrl.idle);
> -			z_erofs_mt_ctrl.idle = tmp;
> +				z_erofs_mt_ctrl.work_idle->next;
> +			free(z_erofs_mt_ctrl.work_idle);
> +			z_erofs_mt_ctrl.work_idle = tmp;
> +		}
> +		while (z_erofs_mt_ctrl.file_idle) {
> +			struct z_erofs_mt_file *tmp =
> +				z_erofs_mt_ctrl.file_idle->next;
> +			free(z_erofs_mt_ctrl.file_idle);
> +			z_erofs_mt_ctrl.file_idle = tmp;
>   		}
>   #endif
>   	}
> diff --git a/lib/inode.c b/lib/inode.c
> index 8460344..d7ef444 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -27,8 +27,13 @@
>   #include "erofs/compress_hints.h"
>   #include "erofs/blobchunk.h"
>   #include "erofs/fragments.h"
> +#ifdef EROFS_MT_ENABLED
> +#include "erofs/queue.h"
> +#endif
>   #include "liberofs_private.h"
>   
> +extern bool z_erofs_mt_enabled;
> +
>   #define S_SHIFT                 12
>   static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
>   	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
> @@ -1036,6 +1041,9 @@ struct erofs_inode *erofs_new_inode(void)
>   	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
>   	inode->i_count = 1;
>   	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> +#ifdef EROFS_MT_ENABLED
> +	inode->mt_desc = NULL;
> +#endif
>   
>   	init_list_head(&inode->i_hash);
>   	init_list_head(&inode->i_subdirs);
> @@ -1100,6 +1108,10 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
>   	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
>   }
>   
> +#ifdef EROFS_MT_ENABLED
> +#define EROFS_MT_QUEUE_SIZE 256
> +struct erofs_queue *z_erofs_mt_queue;
> +#endif
>   
>   static int erofs_mkfs_handle_symlink(struct erofs_inode *inode)
>   {
> @@ -1143,14 +1155,69 @@ static int erofs_mkfs_handle_file(struct erofs_inode *inode)
>   	return 0;
>   }
>   
> +static int erofs_mkfs_issue_compress(struct erofs_inode *inode)
> +{
> +	if (!inode->i_size)
> +		return 0;
> +
> +	if (!S_ISLNK(inode->i_mode) && cfg.c_compr_opts[0].alg &&
> +	    erofs_file_is_compressible(inode)) {

Nit:

if (!inode->i_size || S_ISLNK(inode->i_mode))
	return 0;

if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode))
	...

> +		int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> +		if (fd < 0)
> +			return -errno;
> +		return erofs_write_compressed_file(inode, fd);
> +	}
> +
> +	return 0;
> +}
> +
>   static int erofs_mkfs_handle_dir(struct erofs_inode *dir,
> -				 struct list_head *dirs)
> +				 struct list_head *dirs, bool ismt)
>   {
>   	int ret;
>   	DIR *_dir;
>   	struct dirent *dp;
>   	struct erofs_dentry *d;
> -	unsigned int nr_subdirs = 0, i_nlink;
> +	unsigned int nr_subdirs, i_nlink;
> +
> +	ret = erofs_scan_file_xattrs(dir);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = erofs_prepare_xattr_ibody(dir);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!S_ISDIR(dir->i_mode)) {
redundant branches.
> +		if (S_ISLNK(dir->i_mode)) {
> +			char *const symlink = malloc(dir->i_size);
> +
> +			if (!symlink)
> +				return -ENOMEM;
> +			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
> +			if (ret < 0) {
> +				free(symlink);
> +				return -errno;
> +			}
> +			ret = erofs_write_file_from_buffer(dir, symlink);
> +			free(symlink);
> +		} else if (dir->i_size) {
> +			int fd = open(dir->i_srcpath, O_RDONLY | O_BINARY);
> +			if (fd < 0)
> +				return -errno;
> +
> +			ret = erofs_write_file(dir, fd, 0);
> +			close(fd);
> +		} else {
> +			ret = 0;
> +		}
> +		if (ret)
> +			return ret;
> +
> +		erofs_prepare_inode_buffer(dir);
> +		erofs_write_tail_end(dir);
> +		return 0;
> +	}
>   
>   	_dir = opendir(dir->i_srcpath);
>   	if (!_dir) {
> @@ -1195,13 +1262,15 @@ static int erofs_mkfs_handle_dir(struct erofs_inode *dir,
>   	if (ret)
>   		return ret;
>   
> -	ret = erofs_prepare_inode_buffer(dir);
> -	if (ret)
> -		return ret;
> -	dir->bh->op = &erofs_skip_write_bhops;
> +	if (!ismt) {
> +		ret = erofs_prepare_inode_buffer(dir);
> +		if (ret)
> +			return ret;
> +		dir->bh->op = &erofs_skip_write_bhops;
>   
> -	if (IS_ROOT(dir))
> -		erofs_fixup_meta_blkaddr(dir);
> +		if (IS_ROOT(dir))
> +			erofs_fixup_meta_blkaddr(dir);
> +	}
>   
>   	i_nlink = 0;
>   	list_for_each_entry(d, &dir->i_subdirs, d_child) {
> @@ -1286,7 +1355,7 @@ static void erofs_mkfs_dumpdir(struct erofs_inode *dumpdir)
>   }
>   
>   static int erofs_mkfs_build_tree(struct erofs_inode *dir,
> -				 struct list_head *dirs)
> +				 struct list_head *dirs, bool ismt)
>   {
>   	int ret;
>   
> @@ -1299,12 +1368,15 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir,
>   		return ret;
>   
>   	if (S_ISDIR(dir->i_mode))
> -		return erofs_mkfs_handle_dir(dir, dirs);
> +		return erofs_mkfs_handle_dir(dir, dirs, ismt);
> +	else if (ismt)
> +		return erofs_mkfs_issue_compress(dir);
>   	else
>   		return erofs_mkfs_handle_file(dir);
>   }
>   
> -struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> +struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path,
> +						      bool ismt)
>   {
>   	LIST_HEAD(dirs);
>   	struct erofs_inode *inode, *root, *dumpdir;
> @@ -1325,23 +1397,163 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
>   		list_del(&inode->i_subdirs);
>   		init_list_head(&inode->i_subdirs);
>   
> -		erofs_mkfs_print_progressinfo(inode);
> +		if (!ismt)

ismt has the same function as z_erofs_mt_enable, maybe merged into 
z_erofs_mt_ctrl ?

> +			erofs_mkfs_print_progressinfo(inode);
>   
> -		err = erofs_mkfs_build_tree(inode, &dirs);
> +		err = erofs_mkfs_build_tree(inode, &dirs, ismt);
>   		if (err) {
>   			root = ERR_PTR(err);
>   			break;
>   		}
>   
> +		if (!ismt) {
> +			if (S_ISDIR(inode->i_mode)) {
> +				inode->next_dirwrite = dumpdir;
> +				dumpdir = inode;
> +			} else {
> +				erofs_iput(inode);
> +			}
> +#ifdef EROFS_MT_ENABLED
> +		} else {
> +			erofs_push_queue(z_erofs_mt_queue, &inode);
> +#endif

Many branches use EROFS_MT_ENABLED for isolation, how about:

#ifdef EROFS_MT_ENABLED
void erofs_push_queue(struct erofs_queue *q, void *elem);
#else
void erofs_push_queue(struct erofs_queue *q, void *elem) {};

#endif

> +		}
> +	} while (!list_empty(&dirs));
> +
> +	if (!ismt)
> +		erofs_mkfs_dumpdir(dumpdir);
> +#ifdef EROFS_MT_ENABLED
> +	else
> +		erofs_push_queue(z_erofs_mt_queue, &dumpdir);
> +#endif
> +	return root;
> +}
> +
> +#ifdef EROFS_MT_ENABLED
> +pthread_t z_erofs_mt_traverser;
> +
> +void *z_erofs_mt_traverse_task(void *path)
> +{
> +	pthread_exit((void *)__erofs_mkfs_build_tree_from_path(path, true));
> +}
> +
> +static int z_erofs_mt_reap_compressed(struct erofs_inode *inode)
> +{
> +	struct z_erofs_mt_file *desc = inode->mt_desc;
> +	int fd = desc->fd;
> +	int ret = 0;
> +
> +	pthread_mutex_lock(&desc->mutex);
> +	while (desc->nfini != desc->total)
> +		pthread_cond_wait(&desc->cond, &desc->mutex);
> +	pthread_mutex_unlock(&desc->mutex);
> +
> +	ret = z_erofs_mt_reap(desc);
> +	if (ret == -ENOSPC) {
> +		ret = lseek(fd, 0, SEEK_SET);
> +		if (ret < 0)
> +			return -errno;
> +
> +		ret = write_uncompressed_file_from_fd(inode, fd);
> +	}
> +
> +	close(fd);
> +	return ret;
> +}
> +
> +static int z_erofs_mt_reap_inodes()
> +{
> +	struct erofs_inode *inode, *dumpdir;
> +	int ret = 0;
> +
> +	dumpdir = NULL;
> +	while (true) {
> +		inode = *(struct erofs_inode **)erofs_pop_queue(
> +			z_erofs_mt_queue);
> +		if (!inode)
> +			break;
> +
> +		erofs_mkfs_print_progressinfo(inode);
> +
>   		if (S_ISDIR(inode->i_mode)) {
> +			ret = erofs_prepare_inode_buffer(inode);
> +			if (ret)
> +				goto out;
> +			inode->bh->op = &erofs_skip_write_bhops;
> +
> +			if (IS_ROOT(inode))
> +				erofs_fixup_meta_blkaddr(inode);
> +
>   			inode->next_dirwrite = dumpdir;
>   			dumpdir = inode;
> +			continue;
> +		}
> +
> +		if (inode->mt_desc) {
> +			ret = z_erofs_mt_reap_compressed(inode);
> +		} else if (S_ISLNK(inode->i_mode)) {
> +			ret = erofs_mkfs_handle_symlink(inode);
> +		} else if (!inode->i_size) {
> +			ret = 0;
>   		} else {
> -			erofs_iput(inode);
> +			int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> +			if (fd < 0)
> +				return -errno;
> +
> +			if (cfg.c_chunkbits)
> +				ret = erofs_write_chunked_file(inode, fd, 0);
> +			else
> +				ret = write_uncompressed_file_from_fd(inode,
> +								      fd);
> +			close(fd);
>   		}
> -	} while (!list_empty(&dirs));
> +		if (ret)
> +			goto out;
> +
> +		erofs_prepare_inode_buffer(inode);
> +		erofs_write_tail_end(inode);
> +		erofs_iput(inode);
> +	}
>   
>   	erofs_mkfs_dumpdir(dumpdir);
> +
> +out:
> +	return ret;
> +}
> +#endif
> +
> +struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> +{
> +#ifdef EROFS_MT_ENABLED
> +	int err;
> +#endif
> +	struct erofs_inode *root = NULL;
> +
> +	if (!z_erofs_mt_enabled)
> +		return __erofs_mkfs_build_tree_from_path(path, false);
> +
> +#ifdef EROFS_MT_ENABLED
> +	z_erofs_mt_queue = erofs_alloc_queue(EROFS_MT_QUEUE_SIZE,
> +					     sizeof(struct erofs_inode *));
> +	if (IS_ERR(z_erofs_mt_queue))
> +		return ERR_CAST(z_erofs_mt_queue);
> +
> +	err = pthread_create(&z_erofs_mt_traverser, NULL,
> +			     z_erofs_mt_traverse_task, (void *)path);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	err = z_erofs_mt_reap_inodes();
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	err = pthread_join(z_erofs_mt_traverser, (void *)&root);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	erofs_destroy_queue(z_erofs_mt_queue);
> +#endif
> +
>   	return root;
>   }
>   
> diff --git a/lib/queue.c b/lib/queue.c
> new file mode 100644
> index 0000000..f40ed1d
> --- /dev/null
> +++ b/lib/queue.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include "erofs/err.h"
> +#include <stdlib.h>
> +#include "erofs/queue.h"
> +
> +struct erofs_queue *erofs_alloc_queue(size_t size, size_t elem_size)
> +{
> +	struct erofs_queue *q = malloc(sizeof(*q));
> +
> +	pthread_mutex_init(&q->lock, NULL);
> +	pthread_cond_init(&q->empty, NULL);
> +	pthread_cond_init(&q->full, NULL);
> +
> +	q->size = size;
> +	q->elem_size = elem_size;
> +	q->head = 0;
> +	q->tail = 0;
> +	q->buf = calloc(size, elem_size);
> +	if (!q->buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return q;
> +}
> +
> +void erofs_push_queue(struct erofs_queue *q, void *elem)
> +{
> +	pthread_mutex_lock(&q->lock);
> +
> +	while ((q->tail + 1) % q->size == q->head)
> +		pthread_cond_wait(&q->full, &q->lock);
> +
> +	memcpy(q->buf + q->tail * q->elem_size, elem, q->elem_size);
> +	q->tail = (q->tail + 1) % q->size;
> +
> +	pthread_cond_signal(&q->empty);
> +	pthread_mutex_unlock(&q->lock);
> +}
> +
> +void *erofs_pop_queue(struct erofs_queue *q)
> +{
> +    void *elem;
> +
> +    pthread_mutex_lock(&q->lock);
> +
> +    while (q->head == q->tail)
> +        pthread_cond_wait(&q->empty, &q->lock);
> +
> +    elem = q->buf + q->head * q->elem_size;
> +    q->head = (q->head + 1) % q->size;
> +
> +    pthread_cond_signal(&q->full);
> +    pthread_mutex_unlock(&q->lock);
> +
> +    return elem;
> +}
> +
> +void erofs_destroy_queue(struct erofs_queue *q)
> +{
> +	pthread_mutex_destroy(&q->lock);
> +	pthread_cond_destroy(&q->empty);
> +	pthread_cond_destroy(&q->full);
> +	free(q->buf);
> +	free(q);
> +}
> \ No newline at end of file
Add newline character.


Thanks,

Jianan

