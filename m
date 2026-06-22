Return-Path: <linux-erofs+bounces-3696-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m/YJH0uZOGoxeQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3696-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 04:09:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CCD6AC03A
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 04:09:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=aTC+dwlI;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3696-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3696-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkBTL6V7Fz2yVP;
	Mon, 22 Jun 2026 12:09:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782094150;
	cv=none; b=imc9U5Nhl0ugtJjrSrelHLCmMvJBLZ11jreg0qwTVZnw+WHswcDSlqJcV4qbmgXDimslLClr/h35+yaTwu8g0cuBDZiXzP/V40ZjI7tFW/gsS44PKMZNhGayYuKIkGvSfBWyaKxkzkABE3pO9g9eD55VLbIpC96BZgHqrWEaY9gyXlS/x9nhfgV2rL8C4ZnvWihAb52IKoMk3DUoVDqdcec/IL9112i8MergFuU8NBmOVqhL+iP/iiBofdfuHD5Kfsnp2ho4kn82qE4XWADZrfl5qYl+E5KtijenX+Uj+yJ+QDIYk0TiBy4LSSh/CaQaD6HvVOzXQoQX3vU/yIOyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782094150; c=relaxed/relaxed;
	bh=4G7aYuIE8sz46qDshdTwd5df5VmLwEQiST4bbQDyBeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf+SNxy1nD1JmvbdX+MEPcM0xXF75zeohZzEkZLMTGSqoD33heS5ry3bW7DJfKM+4OztAMK8q5JFE++sFEwJMUlBXQIOSIZQ3rfET7TlJ0ewnXFWbLVO3/uVTSxn7cblun1w/dZGXI1w++MYMCy/DC31FBkfm1fB9H7Wrcu8ePF2IT1ycMi/+6u0fGMMa79fSG8tXfNQc9c7tfojk0DhD+B0sVUyPUFO8ABpUQG0xM8+qFA9Zqmp3CT3mlOVhtFL7YhwZ8X50KqTOrVY+C09T+5yn83wJ6hqCESBDqaBLchSVX9OXu4yHL9E26S8T+/isP0mD3hqJJMs/LIZq61jVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aTC+dwlI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkBTJ3GKTz2xwH
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 12:09:06 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782094142; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4G7aYuIE8sz46qDshdTwd5df5VmLwEQiST4bbQDyBeA=;
	b=aTC+dwlIgjO16bbS72TS9O0fnCNZIFrgyQnjsYVnyPejm9rcyOIfg6uONt4e/v2LDCOJ+Jsq/abTHh8TQ+xhqHUBs2E893qX1rSP6cYZy6bFexRVI0db608HStle767K36lGev6qK+9WbDhnkvzGhaVfkMgwkugXyyp0heqi25M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5GbjKq_1782094140;
Received: from 30.221.130.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5GbjKq_1782094140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 10:09:00 +0800
Message-ID: <6d8549f5-552d-4a81-b77c-72d63b4c8728@linux.alibaba.com>
Date: Mon, 22 Jun 2026 10:08:59 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fsck.erofs: add multi-threaded decompression
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260621120121.73114-1-nithurshen.dev@gmail.com>
 <20260621120121.73114-2-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260621120121.73114-2-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3696-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64CCD6AC03A

Hi Nithurshen,

On 2026/6/21 20:01, Nithurshen wrote:
> Currently, fsck.erofs extracts files synchronously. When decompressing
> heavily packed images, the main thread spends the majority of its time
> blocked on a combination of synchronous vfs_write() syscalls and
> decompression routines, bottlenecking overall extraction speed.
> 
> This patch introduces a scalable, multi-threaded decompression framework
> using the existing erofs_workqueue infrastructure to decouple compute
> from the main thread's I/O.
> 
> To prevent massive scheduling overhead (futex contention) where worker
> threads spend more CPU time waking up than actually decompressing small
> clusters, this implementation introduces a batching context. Because
> different compression algorithms exhibit vastly different scheduling
> thresholds, the batch size is algorithm-aware:
> - Fast algorithms like LZ4 utilize a larger batch limit (up to 32
>    pclusters) to effectively hide synchronization overhead.
> - Compute-heavy algorithms like LZMA or ZSTD trigger at a lower
>    threshold (8 pclusters) to prevent memory bloat and thread starvation.
> 
> Key details of this implementation:
> - The worker pool is dynamically sized based on available system CPUs.
> - Decompression tasks take strict ownership of the raw and output
>    buffers (safely tracking memory via a `free_out` flag) to prevent
>    data races and memory leaks.
> - Output buffers are explicitly zero-initialized via calloc() to
>    prevent trailing garbage bytes from leaking into extracted files.
> - Tail-end packed fragments are processed synchronously by the main
>    thread, as their minimal overhead does not benefit from asynchronous
>    offloading.
> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
>   fsck/main.c              | 150 ++++++++++++---------------
>   include/erofs/cond.h     |  31 ++++++
>   include/erofs/internal.h |  20 +++-
>   include/erofs/lock.h     |   3 +
>   lib/data.c               | 216 +++++++++++++++++++++++++++++----------
>   5 files changed, 277 insertions(+), 143 deletions(-)
>   create mode 100644 include/erofs/cond.h
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 16cc627..ffe7e29 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -8,14 +8,18 @@
>   #include <time.h>
>   #include <utime.h>
>   #include <unistd.h>
> +#include "erofs/lock.h"
>   #include <sys/stat.h>
>   #include "erofs/print.h"
>   #include "erofs/decompress.h"
>   #include "erofs/dir.h"
>   #include "erofs/xattr.h"
> +#include "erofs/workqueue.h"
>   #include "../lib/compressor.h"
>   #include "../lib/liberofs_compress.h"
>   
> +extern struct erofs_workqueue erofs_wq;
> +
>   static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
>   
>   struct erofsfsck_dirstack {
> @@ -505,44 +509,36 @@ out:
>   
>   static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   {
> -	struct erofs_map_blocks map = {
> -		.buf = __EROFS_BUF_INITIALIZER,
> -	};
> +	struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };

If it's unrelated to the change, let's not touch it.

>   	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
>   	int ret = 0;
> -	bool compressed;
> +	bool compressed = erofs_inode_is_data_compressed(inode->datalayout);
>   	erofs_off_t pos = 0;
>   	u64 pchunk_len = 0;
> -	unsigned int raw_size = 0, buffer_size = 0;
> -	char *raw = NULL, *buffer = NULL;
>   
> -	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
> -		  inode->nid | 0ULL, inode->datalayout);
> +	struct z_erofs_read_ctx ctx = {

maybe rename it as z_erofs_mt_read_ctx since it relates to multi-threading.

> +		.pending_tasks = 0,
> +		.final_err = 0,
> +		.outfd = outfd,
> +		.free_out = true,
> +		.current_task = NULL
> +	};
> +	erofs_mutex_init(&ctx.lock);
> +	erofs_cond_init(&ctx.cond);
>   
> -	compressed = erofs_inode_is_data_compressed(inode->datalayout);
> -	while (pos < inode->i_size) {
> -		unsigned int alloc_rawsize;
> +	erofs_dbg("verify data chunk of nid(%llu): type(%d)", inode->nid | 0ULL, inode->datalayout);

Can we move this to the original position? Unnecessary diff.

>   
> +	while (pos < inode->i_size) {
>   		map.m_la = pos;
>   		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
> -		if (ret)
> -			goto out;
> -
> -		if (!compressed && map.m_llen != map.m_plen) {
> -			erofs_err("broken chunk length m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
> -				  map.m_la, map.m_llen, map.m_plen);
> -			ret = -EFSCORRUPTED;
> -			goto out;
> -		}
> +		if (ret) goto out;

The code style is still wrong here.

>   
> -		/* the last lcluster can be divided into 3 parts */
>   		if (map.m_la + map.m_llen > inode->i_size)
>   			map.m_llen = inode->i_size - map.m_la;
>   
>   		pchunk_len += map.m_plen;
>   		pos += map.m_llen;
>   
> -		/* should skip decomp? */
>   		if (map.m_la >= inode->i_size || !needdecode)
>   			continue;
>   
> @@ -555,85 +551,53 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   			continue;
>   		}
>   
> -		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
> -			if (compressed && !(map.m_flags & __EROFS_MAP_FRAGMENT)) {
> -				erofs_err("invalid pcluster size %" PRIu64 " @ offset %" PRIu64 " of nid %" PRIu64,
> -					  map.m_plen, map.m_la,
> -					  inode->nid | 0ULL);
> -				ret = -EFSCORRUPTED;
> -				goto out;
> -			}
> -			alloc_rawsize = Z_EROFS_PCLUSTER_MAX_SIZE;
> -		} else {
> -			alloc_rawsize = map.m_plen;
> -		}
> -
> -		if (alloc_rawsize > raw_size) {
> -			char *newraw = realloc(raw, alloc_rawsize);
> -
> -			if (!newraw) {
> +		if (compressed) {
> +			char *raw = malloc(map.m_plen);
> +			size_t buffer_size = map.m_llen > erofs_blksiz(inode->sbi) ? map.m_llen : erofs_blksiz(inode->sbi);

Please avoid overly long lines (< 80 chars recommended, but should
less than 100 chars)

> +			char *buffer = calloc(1, buffer_size);

			I hope it could be:

			char *raw, *buffers;

			raw = malloc(map.m_plen);
			buffer = calloc(1, buffer_size);

> +			
> +			if (!raw || !buffer) {
> +				free(raw); free(buffer);
>   				ret = -ENOMEM;
>   				goto out;
>   			}
> -			raw = newraw;
> -			raw_size = alloc_rawsize;
> -		}
>   
> -		if (compressed) {
> -			if (map.m_llen > buffer_size) {
> -				char *newbuffer;
> -
> -				buffer_size = map.m_llen;
> -				newbuffer = realloc(buffer, buffer_size);
> -				if (!newbuffer) {
> -					ret = -ENOMEM;
> -					goto out;
> -				}
> -				buffer = newbuffer;
> -			}
> -			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
> -						    0, map.m_llen, false);
> -			if (ret)
> +			ret = z_erofs_read_one_data(inode, &map, raw, buffer, 0, map.m_llen, false, map.m_la, &ctx);

Same code styling issue here.

> +			if (ret) {
> +				/* DO NOT free(raw) or free(buffer) here. z_erofs_read_one_data took ownership! */
>   				goto out;
> -
> -			if (outfd >= 0 && write(outfd, buffer, map.m_llen) < 0)
> -				goto fail_eio;
> +			}
>   		} else {
> -			u64 p = 0;
> -
> -			do {
> -				u64 count = min_t(u64, alloc_rawsize,
> -						  map.m_llen);
> -
> -				ret = erofs_read_one_data(inode, &map, raw, p, count);
> -				if (ret)
> -					goto out;
> -
> -				if (outfd >= 0 && write(outfd, raw, count) < 0)
> -					goto fail_eio;
> -				map.m_llen -= count;
> -				p += count;
> -			} while (map.m_llen);
> +			char *raw = calloc(1, map.m_llen);
> +			ret = erofs_read_one_data(inode, &map, raw, 0, map.m_llen);
> +			if (ret >= 0 && outfd >= 0)
> +				pwrite(outfd, raw, map.m_llen, map.m_la);
> +			free(raw);
> +			if (ret) goto out;
>   		}
>   	}
> +	z_erofs_read_ctx_enqueue(&ctx);

Maybe just call it as `z_erofs_mt_read_enqueue(&ctx);`

> +
> +out:
> +	erofs_mutex_lock(&ctx.lock);
> +	while (ctx.pending_tasks > 0)
> +		erofs_cond_wait(&ctx.cond, &ctx.lock);
> +	if (ctx.final_err < 0 && ret >= 0)
> +		ret = ctx.final_err;
> +	erofs_mutex_unlock(&ctx.lock);
>   
>   	if (fsckcfg.print_comp_ratio) {
>   		if (!erofs_is_packed_inode(inode))
>   			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->sbi, inode->i_size);
>   		fsckcfg.physical_blocks += BLK_ROUND_UP(inode->sbi, pchunk_len);
>   	}
> -out:
> -	if (raw)
> -		free(raw);
> -	if (buffer)
> -		free(buffer);
> -	return ret < 0 ? ret : 0;
>   
> -fail_eio:
> -	erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
> -		  inode->nid | 0ULL);
> -	ret = -EIO;
> -	goto out;
> +	if (outfd >= 0 && ret >= 0)
> +		ftruncate(outfd, inode->i_size);
> +	
> +	erofs_mutex_destroy(&ctx.lock);
> +	erofs_cond_destroy(&ctx.cond);
> +	return ret < 0 ? ret : 0;
>   }
>   
>   static inline int erofs_extract_dir(struct erofs_inode *inode)
> @@ -1043,10 +1007,21 @@ int erofsfsck_fuzz_one(int argc, char *argv[])
>   int main(int argc, char *argv[])
>   #endif
>   {
> +
>   	int err;
> +#ifdef EROFS_MT_ENABLED
> +	int workers;
> +#endif
>   
>   	erofs_init_configure();
>   
> +#ifdef EROFS_MT_ENABLED
> +	workers = erofs_get_available_processors();
> +	if (workers < 1)
> +		workers = 1;
> +	erofs_alloc_workqueue(&erofs_wq, workers, 256, NULL, NULL);
> +#endif

It shouldn't be worked as this, we should have a helper
in liberofs to wrap up the initialization.

And erofs_wq naming is ambigious.

> +
>   	fsckcfg.physical_blocks = 0;
>   	fsckcfg.logical_blocks = 0;
>   	fsckcfg.extract_path = NULL;
> @@ -1181,6 +1156,9 @@ exit_dev_close:
>   exit:
>   	erofs_blob_closeall(&g_sbi);
>   	erofs_exit_configure();
> +#ifdef EROFS_MT_ENABLED
> +	erofs_destroy_workqueue(&erofs_wq);
> +#endif

Same here.

>   	return err ? 1 : 0;
>   }
>   
> diff --git a/include/erofs/cond.h b/include/erofs/cond.h
> new file mode 100644
> index 0000000..90ec838
> --- /dev/null
> +++ b/include/erofs/cond.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +#ifndef __EROFS_COND_H
> +#define __EROFS_COND_H
> +
> +#include "lock.h"
> +
> +#if defined(HAVE_PTHREAD_H) && defined(EROFS_MT_ENABLED)
> +#include <pthread.h>
> +
> +typedef pthread_cond_t erofs_cond_t;
> +
> +static inline void erofs_cond_init(erofs_cond_t *cond)
> +{
> +	pthread_cond_init(cond, NULL);
> +}
> +#define erofs_cond_wait		pthread_cond_wait
> +#define erofs_cond_signal	pthread_cond_signal
> +#define erofs_cond_broadcast	pthread_cond_broadcast
> +#define erofs_cond_destroy	pthread_cond_destroy
> +
> +#else
> +typedef struct {} erofs_cond_t;
> +
> +static inline void erofs_cond_init(erofs_cond_t *cond) {}
> +static inline int erofs_cond_wait(erofs_cond_t *cond, erofs_mutex_t *mutex) { return 0; }
> +static inline int erofs_cond_signal(erofs_cond_t *cond) { return 0; }
> +static inline int erofs_cond_broadcast(erofs_cond_t *cond) { return 0; }
> +static inline int erofs_cond_destroy(erofs_cond_t *cond) { return 0; }
> +#endif
> +
> +#endif
> \ No newline at end of file
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 671880f..94f14da 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -25,6 +25,8 @@ typedef unsigned short umode_t;
>   #ifdef HAVE_PTHREAD_H
>   #include <pthread.h>
>   #endif
> +#include <erofs/lock.h>
> +#include "erofs/cond.h"
>   #include <stdlib.h>
>   #include <string.h>
>   #include "atomic.h"
> @@ -62,6 +64,7 @@ struct erofs_buf {
>   #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
>   #define BLK_ROUND_UP(sbi, addr)	\
>   	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
> +#define Z_EROFS_PCLUSTER_MAX_BATCH_SIZE 32
>   
>   struct erofs_buffer_head;
>   struct erofs_bufmgr;
> @@ -442,6 +445,20 @@ struct z_erofs_paramset {
>   	char *extraopts;
>   };
>   
> +struct z_erofs_decompress_task;
> +
> +struct z_erofs_read_ctx {
> +	erofs_mutex_t lock;
> +	erofs_cond_t cond;
> +	int pending_tasks;
> +	int final_err;
> +	int outfd;
> +	bool free_out;
> +	struct z_erofs_decompress_task *current_task;
> +};

Is it necessary to expose the internal structure fields
to users?

> +
> +void z_erofs_read_ctx_enqueue(struct z_erofs_read_ctx *ctx);

z_erofs_mt_read_enqueue

> +
>   int liberofs_global_init(void);
>   void liberofs_global_exit(void);
>   
> @@ -478,7 +495,8 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
>   			char *buffer, u64 offset, size_t len);
>   int z_erofs_read_one_data(struct erofs_inode *inode,
>   			struct erofs_map_blocks *map, char *raw, char *buffer,
> -			erofs_off_t skip, erofs_off_t length, bool trimmed);
> +			erofs_off_t skip, erofs_off_t length, bool trimmed,
> +			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx);
>   void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
>   			  erofs_off_t *offset, int *lengthp);
>   int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb);
> diff --git a/include/erofs/lock.h b/include/erofs/lock.h
> index c6e3093..2e79d52 100644
> --- a/include/erofs/lock.h
> +++ b/include/erofs/lock.h
> @@ -15,6 +15,7 @@ static inline void erofs_mutex_init(erofs_mutex_t *lock)
>   }
>   #define erofs_mutex_lock	pthread_mutex_lock
>   #define erofs_mutex_unlock	pthread_mutex_unlock
> +#define erofs_mutex_destroy	pthread_mutex_destroy
>   
>   #define EROFS_DEFINE_MUTEX(lock)	\
>   	erofs_mutex_t lock = PTHREAD_MUTEX_INITIALIZER
> @@ -29,12 +30,14 @@ static inline void erofs_init_rwsem(erofs_rwsem_t *lock)
>   #define erofs_down_write	pthread_rwlock_wrlock
>   #define erofs_up_read		pthread_rwlock_unlock
>   #define erofs_up_write		pthread_rwlock_unlock
> +
>   #else
>   typedef struct {} erofs_mutex_t;
>   
>   static inline void erofs_mutex_init(erofs_mutex_t *lock) {}
>   static inline void erofs_mutex_lock(erofs_mutex_t *lock) {}
>   static inline void erofs_mutex_unlock(erofs_mutex_t *lock) {}
> +static inline void erofs_mutex_destroy(erofs_mutex_t *lock) {}
>   
>   #define EROFS_DEFINE_MUTEX(lock)	\
>   	erofs_mutex_t lock = {}
> diff --git a/lib/data.c b/lib/data.c
> index 6fd1389..e9d2218 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -9,6 +9,73 @@
>   #include "erofs/trace.h"
>   #include "erofs/decompress.h"
>   #include "liberofs_fragments.h"
> +#include "erofs/workqueue.h"
> +#include "erofs/lock.h"
> +
> +struct erofs_workqueue erofs_wq;
> +
> +struct z_erofs_decompress_item {
> +	struct z_erofs_decompress_req req;
> +	char *raw_buf;
> +	char *out_buf;
> +	erofs_off_t out_offset;
> +	unsigned int out_length;
> +};
> +
> +struct z_erofs_decompress_task {
> +	struct erofs_work work;
> +	struct z_erofs_read_ctx *ctx;
> +	struct z_erofs_decompress_item items[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
> +	unsigned int nr_reqs;
> +};
> +
> +static void z_erofs_decompress_worker(struct erofs_work *work, void *tlsp)
> +{
> +	struct z_erofs_decompress_task *task = (struct z_erofs_decompress_task *)work;
> +	struct z_erofs_read_ctx *ctx = task->ctx;
> +	int i, ret = 0, first_err = 0;
> +
> +	for (i = 0; i < task->nr_reqs; ++i) {
> +		struct z_erofs_decompress_item *item = &task->items[i];
> +		ret = z_erofs_decompress(&item->req);
> +
> +		if (ret >= 0 && ctx && ctx->outfd >= 0) {
> +			if (pwrite(ctx->outfd, item->out_buf,
> +				   item->out_length, item->out_offset) < 0)
> +				ret = -errno;
> +		}
> +
> +		if (ret < 0 && first_err == 0)

We don't use first_err == 0 style, it should be !first_err.

> +			first_err = ret;
> +
> +		free(item->raw_buf);
> +		if (ctx && ctx->free_out)
> +			free(item->out_buf);
> +	}
> +
> +	if (ctx) {
> +		erofs_mutex_lock(&ctx->lock);
> +		if (first_err < 0 && ctx->final_err == 0)
> +			ctx->final_err = first_err;
> +		ctx->pending_tasks--;
> +		if (ctx->pending_tasks == 0)

Same here.

> +			erofs_cond_signal(&ctx->cond);
> +		erofs_mutex_unlock(&ctx->lock);
> +	}
> +	free(task);
> +}
> +
> +void z_erofs_read_ctx_enqueue(struct z_erofs_read_ctx *ctx)
> +{
> +	if (ctx && ctx->current_task) {
> +#ifdef EROFS_MT_ENABLED
> +		erofs_queue_work(&erofs_wq, &ctx->current_task->work);
> +#else
> +		z_erofs_decompress_worker(&ctx->current_task->work, NULL);
> +#endif
> +		ctx->current_task = NULL;
> +	}
> +}
>   
>   void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
>   {
> @@ -277,7 +344,8 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   
>   int z_erofs_read_one_data(struct erofs_inode *inode,
>   			struct erofs_map_blocks *map, char *raw, char *buffer,
> -			erofs_off_t skip, erofs_off_t length, bool trimmed)
> +			erofs_off_t skip, erofs_off_t length, bool trimmed,
> +			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx)
>   {
>   	struct erofs_sb_info *sbi = inode->sbi;
>   	struct erofs_map_dev mdev;
> @@ -285,77 +353,107 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
>   
>   	if (map->m_flags & __EROFS_MAP_FRAGMENT) {
>   		if (__erofs_unlikely(inode->nid == sbi->packed_nid)) {
> -			erofs_err("fragment should not exist in the packed inode %llu",
> -				  sbi->packed_nid | 0ULL);
> -			return -EFSCORRUPTED;
> +			ret = -EFSCORRUPTED;
> +			goto err_out;
> +		}
> +		ret = erofs_packedfile_read(sbi, buffer, length - skip,
> +					   inode->fragmentoff + skip);
> +		
> +		if (ret >= 0 && ctx && ctx->outfd >= 0) {
> +			if (pwrite(ctx->outfd, buffer, length - skip, out_offset) < 0)
> +				ret = -errno;
>   		}
> -		return erofs_packedfile_read(sbi, buffer, length - skip,
> -				   inode->fragmentoff + skip);
> +		goto err_out;
>   	}
>   
> -	/* no device id here, thus it will always succeed */
> -	mdev = (struct erofs_map_dev) {
> -		.m_pa = map->m_pa,
> -	};
> +	mdev = (struct erofs_map_dev) { .m_pa = map->m_pa };

Please don't change unrelated code.

>   	ret = erofs_map_dev(sbi, &mdev);
> -	if (ret) {
> -		DBG_BUGON(1);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_out;
>   
>   	ret = erofs_dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
>   	if (ret < 0)
> -		return ret;
> +		goto err_out;
> +	struct z_erofs_decompress_task *task = ctx->current_task;
> +	if (!task) {
> +		task = calloc(1, sizeof(*task));
> +		task->ctx = ctx;
> +		task->work.fn = z_erofs_decompress_worker;
> +		ctx->current_task = task;
> +
> +		erofs_mutex_lock(&ctx->lock);
> +		ctx->pending_tasks++;
> +		erofs_mutex_unlock(&ctx->lock);
> +	}
>   
> -	ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> -			.sbi = sbi,
> -			.in = raw,
> -			.out = buffer,
> -			.decodedskip = skip,
> -			.interlaced_offset =
> -				map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
> -					erofs_blkoff(sbi, map->m_la) : 0,
> -			.inputsize = map->m_plen,
> -			.decodedlength = length,
> -			.alg = map->m_algorithmformat,
> -			.partial_decoding = trimmed ? true :
> -				!(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
> -					(map->m_flags & EROFS_MAP_PARTIAL_REF),
> -			 });
> -	if (ret < 0)
> -		return ret;
> +	int idx = task->nr_reqs++;
> +	struct z_erofs_decompress_item *item = &task->items[idx];

Definitions should be at the beginning of the code blocks.

> +
> +	item->req = (struct z_erofs_decompress_req) {
> +		.sbi = sbi,
> +		.in = raw,
> +		.out = buffer,
> +		.decodedskip = skip,
> +		.interlaced_offset =
> +			map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
> +				erofs_blkoff(sbi, map->m_la) : 0,
> +		.inputsize = map->m_plen,
> +		.decodedlength = length,
> +		.alg = map->m_algorithmformat,
> +		.partial_decoding = trimmed ? true :
> +			!(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
> +				(map->m_flags & EROFS_MAP_PARTIAL_REF),
> +	};
> +	item->raw_buf = raw;
> +	item->out_buf = buffer;
> +	item->out_offset = out_offset;
> +	item->out_length = length;
> +
> +	int batch_limit = (map->m_algorithmformat == Z_EROFS_COMPRESSION_LZ4) ?
> +						Z_EROFS_PCLUSTER_MAX_BATCH_SIZE : 8;

Same here.

> +
> +	if (task->nr_reqs >= batch_limit) {
> +		z_erofs_read_ctx_enqueue(ctx);
> +	}
>   	return 0;
> +
> +err_out:
> +	if (ctx && ctx->free_out) free(buffer);

Wrong style, please fix them all.

> +	free(raw);
> +	return ret;
>   }
>   
>   static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
> -			     erofs_off_t size, erofs_off_t offset)
> +				 erofs_off_t size, erofs_off_t offset)
>   {
>   	erofs_off_t end, length, skip;
>   	struct erofs_map_blocks map = {
>   		.buf = __EROFS_BUF_INITIALIZER,
>   	};
>   	bool trimmed;
> -	unsigned int bufsize = 0;
> -	char *raw = NULL;
>   	int ret = 0;
>   
> +	struct z_erofs_read_ctx ctx = {
> +		.pending_tasks = 0,
> +		.final_err = 0,
> +		.outfd = -1,
> +		.free_out = false,
> +		.current_task = NULL
> +	};
> +	erofs_mutex_init(&ctx.lock);
> +	erofs_cond_init(&ctx.cond);
> +
>   	end = offset + size;
>   	while (end > offset) {
>   		map.m_la = end - 1;
>   
>   		ret = z_erofs_map_blocks_iter(inode, &map, 0);
> -		if (ret)
> -			break;
> +		if (ret) break;

Wrong style again.

Thanks,
Gao Xiang

