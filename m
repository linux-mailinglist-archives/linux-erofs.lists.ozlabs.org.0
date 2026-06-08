Return-Path: <linux-erofs+bounces-3527-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iHr/Lk9gJmp6VgIAu9opvQ
	(envelope-from <linux-erofs+bounces-3527-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 08:25:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4683B6531C1
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 08:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="Ypn/TE4m";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3527-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3527-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYhqG2N7nz2ysb;
	Mon, 08 Jun 2026 16:25:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780899914;
	cv=none; b=egHFrN790ogcnqKX4u99FuXR0fUfyj/NXwZ9NB7ga1bukopeahDEY26T/cFm4iSdXMj/0invI2WCgANafIrs440Ti7jp4AlMHMGQA6j0hckwvdgnhPzARhZRIjKOxI6Z22wtq0avVeco2srgQW6hfZ2tSDa1q+UoMVJ9FMODtma7bw3uD3L3UyU79/PM+Eal7HQlA3ODm228vTgcDZWIZFfRclgNyf6gwyuzXI+O/LcbQTP2z0duOZVgc0jgcpE5Ip/4LEc1D7/NUo8IgEuNjF+2KLi6yh5kEt4JbUlFKHxGHrGpIHEdpGLHxUf9OLjPLtvGJ3mxgZiTlt3asY+BHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780899914; c=relaxed/relaxed;
	bh=tIElADRphneLY6E7UxlbPbV+/fYH95wBATIWWcgG/9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C57vW2ar6TSoVDAJW1UmNa7eJmgAGbz7ALk4H5vMKZ3KbSKMiKcdN5G55W0vFnFXdNxy/Mjg2Wv8YZ84DEb/azL9CHVvyxaje8QXmkabmFnRDjfAtsnppQopJQrLMhuyY0MkUfWSAQbW8etleEw3r/DVlopgowysj6/KpVUVRLLXDZP3Mkb2bj5z7nvC3TRH5YpkfTt2MoEZAN4K6ce6G4TLk9rqthTMT0vIfy/6UltqPPP/z2EJH5KLa4eV3yi0EkSUHofxj9JtNHmEDSGkhUr3nVTUz2ZE1Lvea3sLM8f5QFQSNzu4WjgEhZFoWiMQdN+kFn+dn5SG6JrC2XNejQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ypn/TE4m; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYhqD0rCvz2yR5
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Jun 2026 16:25:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780899906; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tIElADRphneLY6E7UxlbPbV+/fYH95wBATIWWcgG/9Y=;
	b=Ypn/TE4m4FMDv8tZ9HqAS+f29x7HmLh7BIHMwEAd50UVyRIKVNvaWyRtIyoeVXQ7olFp/lzOc7VBZ7oXy0g5plty5dgVr4b+b/Gq42Go9zr9n546QyChrITYoNEnZ19mCTcFRvCAsBsEO4ecFCDG4BloyATYj+aiMfsNrZX/uok=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X4KLFwU_1780899904;
Received: from 30.221.133.92(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4KLFwU_1780899904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Jun 2026 14:25:05 +0800
Message-ID: <6889ebe7-9733-4152-8f9b-35d7c9b797a4@linux.alibaba.com>
Date: Mon, 8 Jun 2026 14:25:04 +0800
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
Subject: Re: [PATCH v2 1/2] fsck.erofs: introduce multi-threaded decompression
 with static batching
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20260523003757.13078-1-nithurshen.dev@gmail.com>
 <20260608050711.30648-1-nithurshen.dev@gmail.com>
 <20260608050711.30648-2-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260608050711.30648-2-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3527-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,linux.alibaba.com:mid,linux.alibaba.com:from_mime,linux.alibaba.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4683B6531C1



On 2026/6/8 13:07, Nithurshen wrote:
> Currently, fsck.erofs extracts files synchronously. When decompressing
> heavily packed images (like LZ4HC with 4K pclusters), the main thread
> spends the majority of its time blocked on a combination of synchronous
> vfs_write() syscalls and LZ4_decompress_safe(), bottlenecking overall
> extraction speed.
> 
> This patch introduces a scalable, multi-threaded decompression framework
> using the existing erofs_workqueue infrastructure to decouple compute
> from the main thread's I/O.
> 
> To prevent massive scheduling overhead (futex contention) where worker
> threads spend more CPU time waking up than actually decompressing small
> 4KB clusters, this implementation introduces a batching context. The
> main thread collects an array of sequential pclusters (temporarily hard-
> capped at Z_EROFS_PCLUSTER_BATCH_SIZE = 32) before submitting a single
> erofs_work unit.
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
>   fsck/main.c              | 239 ++++++++++++++++++---------------------
>   include/erofs/internal.h |  19 +++-
>   include/erofs/lock.h     |  22 ++++
>   lib/data.c               | 207 +++++++++++++++++++++++----------
>   4 files changed, 298 insertions(+), 189 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 16cc627..de6ab4d 100644
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
> @@ -505,135 +509,95 @@ out:
>   
>   static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   {
> -	struct erofs_map_blocks map = {
> -		.buf = __EROFS_BUF_INITIALIZER,
> -	};
> -	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
> -	int ret = 0;
> -	bool compressed;
> -	erofs_off_t pos = 0;
> -	u64 pchunk_len = 0;
> -	unsigned int raw_size = 0, buffer_size = 0;
> -	char *raw = NULL, *buffer = NULL;
> -
> -	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
> -		  inode->nid | 0ULL, inode->datalayout);
> -
> -	compressed = erofs_inode_is_data_compressed(inode->datalayout);
> -	while (pos < inode->i_size) {
> -		unsigned int alloc_rawsize;
> -
> -		map.m_la = pos;
> -		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
> -		if (ret)
> -			goto out;
> -
> -		if (!compressed && map.m_llen != map.m_plen) {
> -			erofs_err("broken chunk length m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
> -				  map.m_la, map.m_llen, map.m_plen);
> -			ret = -EFSCORRUPTED;
> -			goto out;
> -		}
> -
> -		/* the last lcluster can be divided into 3 parts */
> -		if (map.m_la + map.m_llen > inode->i_size)
> -			map.m_llen = inode->i_size - map.m_la;
> -
> -		pchunk_len += map.m_plen;
> -		pos += map.m_llen;
> -
> -		/* should skip decomp? */
> -		if (map.m_la >= inode->i_size || !needdecode)
> -			continue;
> -
> -		if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
> -			ret = lseek(outfd, map.m_llen, SEEK_CUR);
> -			if (ret < 0) {
> -				ret = -errno;
> -				goto out;
> -			}
> -			continue;
> -		}
> -
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
> +    struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };

Please use tab instead of spaces.

> +    bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
> +    int ret = 0;
> +    bool compressed = erofs_inode_is_data_compressed(inode->datalayout);
> +    erofs_off_t pos = 0;
> +    u64 pchunk_len = 0;
> +
> +    struct z_erofs_read_ctx ctx = {
> +        .pending_tasks = 0,
> +        .final_err = 0,
> +        .outfd = outfd,
> +		.free_out = true,
> +        .current_task = NULL
> +    };

Honestly, I don't like `z_erofs_read_ctx` naming,
but I don't have a better suggestion.

> +    erofs_mutex_init(&ctx.lock);
> +    erofs_cond_init(&ctx.cond);
> +

...

> +
> +#ifdef EROFS_MT_ENABLED
> +    workers = sysconf(_SC_NPROCESSORS_ONLN);

why erofs_get_available_processors() doesn't work?

> +    if (workers < 1) workers = 1;

Please leave the single statement in the next line;

> +    erofs_alloc_workqueue(&erofs_wq, workers, 256, NULL, NULL);
> +#endif
>   
>   	fsckcfg.physical_blocks = 0;
>   	fsckcfg.logical_blocks = 0;
> @@ -1179,9 +1153,12 @@ exit_put_super:

...

> diff --git a/include/erofs/lock.h b/include/erofs/lock.h
> index c6e3093..a2e1b60 100644
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
> @@ -29,12 +30,25 @@ static inline void erofs_init_rwsem(erofs_rwsem_t *lock)
>   #define erofs_down_write	pthread_rwlock_wrlock
>   #define erofs_up_read		pthread_rwlock_unlock
>   #define erofs_up_write		pthread_rwlock_unlock
> +
> +typedef pthread_cond_t erofs_cond_t;

I think erofs_cond_t should be in a seperate .h

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
> @@ -46,5 +60,13 @@ static inline void erofs_down_write(erofs_rwsem_t *lock) {}
>   static inline void erofs_up_read(erofs_rwsem_t *lock) {}
>   static inline void erofs_up_write(erofs_rwsem_t *lock) {}
>   
> +typedef struct {} erofs_cond_t;
> +
> +static inline void erofs_cond_init(erofs_cond_t *cond) {}
> +static inline int erofs_cond_wait(erofs_cond_t *cond, erofs_mutex_t *mutex) { return 0; }
> +static inline int erofs_cond_signal(erofs_cond_t *cond) { return 0; }
> +static inline int erofs_cond_broadcast(erofs_cond_t *cond) { return 0; }
> +static inline int erofs_cond_destroy(erofs_cond_t *cond) { return 0; }
> +
>   #endif
>   #endif
> diff --git a/lib/data.c b/lib/data.c
> index 6fd1389..26fdb43 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -9,6 +9,68 @@
>   #include "erofs/trace.h"
>   #include "erofs/decompress.h"
>   #include "liberofs_fragments.h"
> +#include "erofs/workqueue.h"
> +#include "erofs/lock.h"
> +
> +struct erofs_workqueue erofs_wq;
> +
> +struct z_erofs_decompress_task {
> +	struct erofs_work work;
> +	struct z_erofs_read_ctx *ctx;
> +	struct z_erofs_decompress_req reqs[Z_EROFS_PCLUSTER_BATCH_SIZE];
> +	char *raw_bufs[Z_EROFS_PCLUSTER_BATCH_SIZE];
> +	char *out_bufs[Z_EROFS_PCLUSTER_BATCH_SIZE];
> +	erofs_off_t out_offsets[Z_EROFS_PCLUSTER_BATCH_SIZE];
> +	unsigned int out_lengths[Z_EROFS_PCLUSTER_BATCH_SIZE];
> +	unsigned int nr_reqs;
> +};

Why not adding `struct z_erofs_decompress_task_item`
and make req/raw_buf/out_buf/.. in it.

> +
> +static void z_erofs_decompress_worker(struct erofs_work *work, void *tlsp)
> +{
> +	struct z_erofs_decompress_task *task = (struct z_erofs_decompress_task *)work;
> +	struct z_erofs_read_ctx *ctx = task->ctx;
> +	int i, ret = 0, first_err = 0;
> +
> +	for (i = 0; i < task->nr_reqs; ++i) {
> +		ret = z_erofs_decompress(&task->reqs[i]);
> +
> +		if (ret >= 0 && ctx && ctx->outfd >= 0) {
> +			if (pwrite(ctx->outfd, task->out_bufs[i],
> +				   task->out_lengths[i], task->out_offsets[i]) < 0)
> +				ret = -errno;
> +		}
> +
> +		if (ret < 0 && first_err == 0)
> +			first_err = ret;
> +
> +		free(task->raw_bufs[i]);
> +		if (ctx && ctx->free_out)
> +			free(task->out_bufs[i]);
> +	}
> +
> +	if (ctx) {
> +		erofs_mutex_lock(&ctx->lock);
> +		if (first_err < 0 && ctx->final_err == 0)
> +			ctx->final_err = first_err;
> +		ctx->pending_tasks--;
> +		if (ctx->pending_tasks == 0)
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
> @@ -277,7 +339,8 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   
>   int z_erofs_read_one_data(struct erofs_inode *inode,
>   			struct erofs_map_blocks *map, char *raw, char *buffer,
> -			erofs_off_t skip, erofs_off_t length, bool trimmed)
> +			erofs_off_t skip, erofs_off_t length, bool trimmed,
> +			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx)
>   {
>   	struct erofs_sb_info *sbi = inode->sbi;
>   	struct erofs_map_dev mdev;
> @@ -285,77 +348,101 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
>   
>   	if (map->m_flags & __EROFS_MAP_FRAGMENT) {
>   		if (__erofs_unlikely(inode->nid == sbi->packed_nid)) {
> -			erofs_err("fragment should not exist in the packed inode %llu",
> -				  sbi->packed_nid | 0ULL);
> -			return -EFSCORRUPTED;
> +			ret = -EFSCORRUPTED;
> +			goto err_out;
>   		}
> -		return erofs_packedfile_read(sbi, buffer, length - skip,
> -				   inode->fragmentoff + skip);
> +		ret = erofs_packedfile_read(sbi, buffer, length - skip,
> +					   inode->fragmentoff + skip);
> +		
> +		if (ret >= 0 && ctx && ctx->outfd >= 0) {
> +			if (pwrite(ctx->outfd, buffer, length - skip, out_offset) < 0)
> +				ret = -errno;
> +		}
> +		goto err_out;
>   	}
>   
> -	/* no device id here, thus it will always succeed */
> -	mdev = (struct erofs_map_dev) {
> -		.m_pa = map->m_pa,
> -	};
> +	mdev = (struct erofs_map_dev) { .m_pa = map->m_pa };
>   	ret = erofs_map_dev(sbi, &mdev);
> -	if (ret) {
> -		DBG_BUGON(1);
> -		return ret;
> -	}
> +	if (ret) goto err_out;

Bad style here too.

>   
>   	ret = erofs_dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
> -	if (ret < 0)
> -		return ret;
> +	if (ret < 0) goto err_out;

Ditto.

Thanks,
Gao Xiang

