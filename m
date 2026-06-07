Return-Path: <linux-erofs+bounces-3519-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ij8ZNYDOJGrg/QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3519-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 07 Jun 2026 03:50:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D930F64EA8B
	for <lists+linux-erofs@lfdr.de>; Sun, 07 Jun 2026 03:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="gOjqpdH/";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3519-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3519-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXyn73Y4kz2ySl;
	Sun, 07 Jun 2026 11:50:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780797051;
	cv=none; b=BFUMsofatDLZIN1a5uJdVkOktp0Py8ImgJ91O0rYRbPRb00I7VdTj6XszIB8Am8kTzzBKHpHd9GRQ+PuCQdcVD8UuazK+d2SmigIn34pJrTs2lPsZo9+e5hk1HU8pBYKFQoVv+vTNTOtPt0Dztg+YtZXyaEqVl1A5ASAU2REfPXPS/ISXK/Ai030SQR9Y6CfOw7JdVqS0mFtmOy0vmaDzeivGIM4dEOK+LPGnMTxn+H+DI1sjWThH2EjNNaiTQ9kmHffmF689eXiyg2If1jZRVwUkF4HcicDFrUJ1JluUQfxBTfij0+xIXiGfj0VflUK+r82Ntpoe7VVvca5zYEy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780797051; c=relaxed/relaxed;
	bh=nXnCeUeMmFhTqQ98wUV4c+0GFYKpCFCcfVEGz431EjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFds6bhxFcVfCHkWiyw30YlQRd/KOPxqSPFNZWeaS0I4PocOkzJGfC3EWrm/6TY+AAuVUkphGJ4CLov0Jb1mREgCawNfGoA5uXAXbAJ1AMDcXwGqEiLGt1lDS51kqp3nWeGQQSmBAObqLmLnU2GdwTTzh0ZJbbTlT6KHAqLn+Lecop8UYtEeWTU1lrO1Hd4pBddraDnYpji5/EBoLaJmaPk2IywoV2Pto2nOTvo7+GhGlHZxqYMAMLteMIcwh3iBVJqqZRJw07p5ISBrviX7tkz7JBhygmT77kfGQUSISZV+s4s9ea+3oVECZpbpwvtkk9sUYlptNYpt58ngAObSiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOjqpdH/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXyn61GXCz2xLk
	for <linux-erofs@lists.ozlabs.org>; Sun, 07 Jun 2026 11:50:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 14577423CF;
	Sun,  7 Jun 2026 01:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1968E1F00893;
	Sun,  7 Jun 2026 01:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780797046;
	bh=nXnCeUeMmFhTqQ98wUV4c+0GFYKpCFCcfVEGz431EjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gOjqpdH/GCzRO9c4j3cwBQx2W7GpJ4tc+XUyp4MbvwqYIM1+/ojdf7HsTMWc98xC5
	 W5I87EZ6/6euYEs0G4y0Svf2GGg1yoQ5986a80WOO3UgwBN1l7opShOJgJthLzgjgo
	 A7J11ThuqX+yJ/q5hS9g5O37XKE4poLM+lCscqm9MxeSoUgduWySAbtqW4w1+mXcIf
	 Q6VqPwXBXo6W9aJ5HNY4ixoa6MJE6WHarzD4EFv4oYVOsad9WoFtSYDdC4gBZWvXi7
	 6JqHyzWfnOYBD0cmEibkKtuvM8DJe6tQYt/7K2kV004Ta1YBn74pfmaeqrStRlfllZ
	 KFvdG2DbthJfQ==
Date: Sun, 7 Jun 2026 09:50:39 +0800
From: Gao Xiang <xiang@kernel.org>
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	xiang@kernel.org
Subject: Re: [PATCH 1/2] fsck.erofs: introduce multi-threaded decompression
 with static batching
Message-ID: <aiTObzdT2gThkwln@debian>
Mail-Followup-To: Nithurshen <nithurshen.dev@gmail.com>,
	linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	xiang@kernel.org
References: <20260523003757.13078-1-nithurshen.dev@gmail.com>
 <20260523003757.13078-2-nithurshen.dev@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260523003757.13078-2-nithurshen.dev@gmail.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3519-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[debian:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D930F64EA8B

Hi Nithurshen,

On Sat, May 23, 2026 at 06:07:56AM +0530, Nithurshen wrote:
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
>   buffers (safely tracking memory via a `free_out` flag) to prevent
>   data races and memory leaks.
> - Output buffers are explicitly zero-initialized via calloc() to
>   prevent trailing garbage bytes from leaking into extracted files.
> - Tail-end packed fragments are processed synchronously by the main
>   thread, as their minimal overhead does not benefit from asynchronous
>   offloading.
> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
>  fsck/main.c              | 234 +++++++++++++++++----------------------
>  include/erofs/internal.h |  18 ++-
>  lib/data.c               | 203 +++++++++++++++++++++++----------
>  3 files changed, 265 insertions(+), 190 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 16cc627..d7810e8 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -8,14 +8,18 @@
>  #include <time.h>
>  #include <utime.h>
>  #include <unistd.h>
> +#include <pthread.h>
>  #include <sys/stat.h>
>  #include "erofs/print.h"
>  #include "erofs/decompress.h"
>  #include "erofs/dir.h"
>  #include "erofs/xattr.h"
> +#include "erofs/workqueue.h"
>  #include "../lib/compressor.h"
>  #include "../lib/liberofs_compress.h"
>  
> +extern struct erofs_workqueue erofs_wq;
> +
>  static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
>  
>  struct erofsfsck_dirstack {
> @@ -505,135 +509,95 @@ out:
>  
>  static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>  {
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
> +    struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };
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
> +    pthread_mutex_init(&ctx.lock, NULL);
> +    pthread_cond_init(&ctx.cond, NULL);

Please avoid barely used pthread interface.

For example, erofs_mutex_t is needed for erofs-utils
instead of pthread_mutex_t;

pthread_cond_init needs to be replaced by an abstract
too.

Also, I may forget to mention that, your new
implementation should be workable for both EROFS_MT_ENABLED
and !EROFS_MT_ENABLED, not only EROFS_MT_ENABLED.

> +
> +    erofs_dbg("verify data chunk of nid(%llu): type(%d)", inode->nid | 0ULL, inode->datalayout);
> +
> +    while (pos < inode->i_size) {
> +        map.m_la = pos;
> +        ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
> +        if (ret) goto out;
> +
> +        if (map.m_la + map.m_llen > inode->i_size)
> +            map.m_llen = inode->i_size - map.m_la;
> +
> +        pchunk_len += map.m_plen;
> +        pos += map.m_llen;
> +
> +        if (map.m_la >= inode->i_size || !needdecode)
> +            continue;
> +
> +        if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
> +            ret = lseek(outfd, map.m_llen, SEEK_CUR);
> +            if (ret < 0) {
> +                ret = -errno;
> +                goto out;
> +            }
> +            continue;
> +        }
> +
> +        if (compressed) {
> +            char *raw = malloc(map.m_plen);
> +            size_t buffer_size = map.m_llen > erofs_blksiz(inode->sbi) ? map.m_llen : erofs_blksiz(inode->sbi);
> +            char *buffer = calloc(1, buffer_size);
> +            
> +            if (!raw || !buffer) {
> +                free(raw); free(buffer);
> +                ret = -ENOMEM;
> +                goto out;
> +            }
> +
> +            ret = z_erofs_read_one_data(inode, &map, raw, buffer, 0, map.m_llen, false, map.m_la, &ctx);
> +            if (ret) {
> +                /* DO NOT free(raw) or free(buffer) here. z_erofs_read_one_data took ownership! */
> +                goto out;
> +            }
> +        } else {
> +            char *raw = calloc(1, map.m_llen);
> +            ret = erofs_read_one_data(inode, &map, raw, 0, map.m_llen);
> +            if (ret >= 0 && outfd >= 0)
> +                pwrite(outfd, raw, map.m_llen, map.m_la);
> +            free(raw);
> +            if (ret) goto out;
> +        }

I think the file read should be multithreaded too, especially the inode
could be large.

Thanks,
Gao Xiang

