Return-Path: <linux-erofs+bounces-3695-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sy+JBveVOGp0eAcAu9opvQ
	(envelope-from <linux-erofs+bounces-3695-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 03:55:03 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97C6ABFEA
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 03:55:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=Ab0lzGdj;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3695-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3695-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkB8y5tB4z2xyj;
	Mon, 22 Jun 2026 11:54:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782093298;
	cv=none; b=cAhLTUDCPOyZEkbn1KIwhZnStP1FBfQ/PwjIL84f3I+Wf7UtLy1VS+f/BdXTYADSJy9dXnWKXdCylh1k2BRoxMLqJlutl8HovMzjFpHYkjXf2DSSgHUVraDClWWWwJ2vWe12VYmQ9PXNMtq+3XlpWXukmpL4H77yk4ukQWXbFHoLgKT4tGzVHE2g8oYlE6TIUJUXLdLXO4PH8ZjCllXtlUWqw6Cn+uqzcVQVeMEmiF+aFMyBD1pyI1lEyGmbkkWwiRbqITxV8i5Y+AkL3uN2SjtNQKP6FeK+5YDiMihMQ8pgGCW7G3WcFXiYxrISZnG0rweLvJ8DcdTZIb2RZa5fNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782093298; c=relaxed/relaxed;
	bh=WrPeVR7MIZrsP4+cbsCSOYB5wpgFtNCRlMgbqdl5wfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgkKdZQq8KA+L5H3rpWLEdizKE32ucN1hW7DJW+NjT7c0xOihQGNpHXGBFblDRofGGjQMVwysWMrU9s/dBs69Z1IT1NCk1ZOzaOd+ZY+HezJzWqSrKfebPOkUau4w8F6mlAxoEbt21yugAENao/Iobi9pS0305yhdkM+kdxbIY7gIW8NJvmjn4uceNA0mbjqTORBGwZZfZLfnqKw+R/HEGy1+ZUi/DUEpldGQFlRfLJKtEGMLU22VMOjAIJbERlVBld5HJJ0fzDXDnL8CDbW7NmWojmKNPX1Rnou5nnIXpo8GfQw/bML31kim66rN2PuJmtY+JKv0hVSoci3Z7Vhww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ab0lzGdj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkB8v2HCLz2xLk
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 11:54:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782093290; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WrPeVR7MIZrsP4+cbsCSOYB5wpgFtNCRlMgbqdl5wfQ=;
	b=Ab0lzGdjl4Jq8LwrWO0Bd5LwrDj/DkhDlNp6lu7tTTWHfmt6pCOLwokj5cZpE9a6h6dH8enHg1NWh0mkxPqGxSu0zUU8xo7zMDeNhikKE7Hb+2WcJM8M+oVXP2uGTwln5JPz4OWn2odUcWEvOWoE9HTRUy5dc9y+PJjHcm+C4mM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5GYfzG_1782093287;
Received: from 30.221.148.29(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X5GYfzG_1782093287 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 09:54:47 +0800
Message-ID: <dcfc099d-f982-4a0f-ba9e-c1a27743ed4d@linux.alibaba.com>
Date: Mon, 22 Jun 2026 09:54:47 +0800
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
Subject: Re: [PATCH] erofs: remove fscache backend entirely
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>,
 Peng Tao <bergwolf@antgroup.com>, Yan Song <yansong.ys@antgroup.com>
References: <20260622013622.934174-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260622013622.934174-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3695-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:dhowells@redhat.com,m:bergwolf@antgroup.com,m:yansong.ys@antgroup.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F97C6ABFEA



On 6/22/26 9:36 AM, Gao Xiang wrote:
> EROFS over fscache was introduced to provide image lazy pulling
> functionality. After the feature landed, the fscache subsystem made
> netfs a new hard dependency, which is unexpected for a local filesystem
> and has an kernel-defined caching hierarchy which could be inflexible
> compared to the fanotify pre-content hooks. Therefore, this feature has
> been deprecated for almost two years.
> 
> As EROFS file-backed mounts and fanotify pre-content hooks both upstream
> for a while and already providing equivalent functionality (erofs-utils
> has supported fanotify pre-content hooks), let's remove the fscache
> backend now.
> 
> The main application of this feature is Nydus [1], and they plan to move
> to use fanotify pre-content hooks in the near future too.
> 
> I hope this patch can be merged into Linux 7.2, which is also motivated
> by newly found implementation issues [2][3] that are not worth
> investigating given the deprecation and limited development resources.
> The associated fscache/cachefiles cleanup patch will follow separately
> through the vfs tree (netfs) later: it seems fine since the codebase is
> isolated by CONFIG_CACHEFILES_ONDEMAND.
> 
> [1] https://github.com/dragonflyoss/nydus/blob/v2.1.0/docs/nydus-fscache.md
> [2] https://github.com/dragonflyoss/nydus/pull/1824
> [3] https://lore.kernel.org/r/20260619135800.1594811-1-michael.bommarito@gmail.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>


Acked-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
> 
> Another reason is that David once asked that if this feature can be
> removed in one or two cycles at LSF/MM/BPF 2026, so I try to kick
> off it now. 
> 
>  Documentation/filesystems/erofs.rst |   9 +-
>  fs/erofs/Kconfig                    |  21 +-
>  fs/erofs/Makefile                   |   1 -
>  fs/erofs/data.c                     |   4 +-
>  fs/erofs/fscache.c                  | 664 ----------------------------
>  fs/erofs/inode.c                    |   2 +-
>  fs/erofs/internal.h                 |  70 +--
>  fs/erofs/ishare.c                   |   2 +-
>  fs/erofs/super.c                    |  94 +---
>  fs/erofs/zdata.c                    |   6 -
>  10 files changed, 26 insertions(+), 847 deletions(-)
>  delete mode 100644 fs/erofs/fscache.c
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index e4f84ba91052..4230884fb359 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -130,12 +130,9 @@ dax                    A legacy option which is an alias for ``dax=always``.
>  device=%s              Specify a path to an extra device to be used together.
>  directio               (For file-backed mounts) Use direct I/O to access backing
>                         files, and asynchronous I/O will be enabled if supported.
> -fsid=%s                Specify a filesystem image ID for Fscache back-end.
> -domain_id=%s           Specify a trusted domain ID for fscache mode so that
> -                       different images with the same blobs, identified by blob IDs,
> -                       can share storage within the same trusted domain.
> -                       Also used for different filesystems with inode page sharing
> -                       enabled to share page cache within the trusted domain.
> +domain_id=%s           Specify a trusted domain ID. Filesystems sharing the same
> +                       domain ID can share page cache across mounts when inode
> +                       page sharing is enabled. (not shown in mountinfo output)
>  fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
>  inode_share            Enable inode page sharing for this filesystem.  Inodes with
>                         identical content within the same domain ID can share the
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 97c48ebe8458..4789b1077d8c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -3,13 +3,11 @@
>  config EROFS_FS
>  	tristate "EROFS filesystem support"
>  	depends on BLOCK
> -	select CACHEFILES if EROFS_FS_ONDEMAND
>  	select CRC32
>  	select CRYPTO if EROFS_FS_ZIP_ACCEL
>  	select CRYPTO_DEFLATE if EROFS_FS_ZIP_ACCEL
>  	select FS_IOMAP
>  	select LZ4_DECOMPRESS if EROFS_FS_ZIP
> -	select NETFS_SUPPORT if EROFS_FS_ONDEMAND
>  	select XXHASH if EROFS_FS_XATTR
>  	select XZ_DEC if EROFS_FS_ZIP_LZMA
>  	select XZ_DEC_MICROLZMA if EROFS_FS_ZIP_LZMA
> @@ -109,9 +107,6 @@ config EROFS_FS_BACKED_BY_FILE
>  	  be used to simplify error-prone lifetime management of unnecessary
>  	  virtual block devices.
>  
> -	  Note that this feature, along with ongoing fanotify pre-content
> -	  hooks, will eventually replace "EROFS over fscache."
> -
>  	  If you don't want to enable this feature, say N.
>  
>  config EROFS_FS_ZIP
> @@ -172,20 +167,6 @@ config EROFS_FS_ZIP_ACCEL
>  
>  	  If unsure, say N.
>  
> -config EROFS_FS_ONDEMAND
> -	bool "EROFS fscache-based on-demand read support (deprecated)"
> -	depends on EROFS_FS
> -	select FSCACHE
> -	select CACHEFILES_ONDEMAND
> -	help
> -	  This permits EROFS to use fscache-backed data blobs with on-demand
> -	  read support.
> -
> -	  It is now deprecated and scheduled to be removed from the kernel
> -	  after fanotify pre-content hooks are landed.
> -
> -	  If unsure, say N.
> -
>  config EROFS_FS_PCPU_KTHREAD
>  	bool "EROFS per-cpu decompression kthread workers"
>  	depends on EROFS_FS_ZIP
> @@ -207,7 +188,7 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>  
>  config EROFS_FS_PAGE_CACHE_SHARE
>  	bool "EROFS page cache share support (experimental)"
> -	depends on EROFS_FS && EROFS_FS_XATTR && !EROFS_FS_ONDEMAND
> +	depends on EROFS_FS && EROFS_FS_XATTR
>  	help
>  	  This enables page cache sharing among inodes with identical
>  	  content fingerprints on the same machine.
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index a80e1762b607..30423496786f 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -9,5 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>  erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
> -erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>  erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index cdf2e2ef8ea8..9aa48c8d67d1 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -80,9 +80,7 @@ int erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  	if (erofs_is_fileio_mode(sbi)) {
>  		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
>  		buf->mapping = buf->file->f_mapping;
> -	} else if (erofs_is_fscache_mode(sb))
> -		buf->mapping = sbi->dif0.fscache->inode->i_mapping;
> -	else
> +	} else
>  		buf->mapping = sb->s_bdev->bd_mapping;
>  	return 0;
>  }
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> deleted file mode 100644
> index 685c68774379..000000000000
> --- a/fs/erofs/fscache.c
> +++ /dev/null
> @@ -1,664 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (C) 2022, Alibaba Cloud
> - * Copyright (C) 2022, Bytedance Inc. All rights reserved.
> - */
> -#include <linux/fscache.h>
> -#include "internal.h"
> -
> -static DEFINE_MUTEX(erofs_domain_list_lock);
> -static DEFINE_MUTEX(erofs_domain_cookies_lock);
> -static LIST_HEAD(erofs_domain_list);
> -static LIST_HEAD(erofs_domain_cookies_list);
> -static struct vfsmount *erofs_pseudo_mnt;
> -
> -struct erofs_fscache_io {
> -	struct netfs_cache_resources cres;
> -	struct iov_iter		iter;
> -	netfs_io_terminated_t	end_io;
> -	void			*private;
> -	refcount_t		ref;
> -};
> -
> -struct erofs_fscache_rq {
> -	struct address_space	*mapping;	/* The mapping being accessed */
> -	loff_t			start;		/* Start position */
> -	size_t			len;		/* Length of the request */
> -	size_t			submitted;	/* Length of submitted */
> -	short			error;		/* 0 or error that occurred */
> -	refcount_t		ref;
> -};
> -
> -static bool erofs_fscache_io_put(struct erofs_fscache_io *io)
> -{
> -	if (!refcount_dec_and_test(&io->ref))
> -		return false;
> -	if (io->cres.ops)
> -		io->cres.ops->end_operation(&io->cres);
> -	kfree(io);
> -	return true;
> -}
> -
> -static void erofs_fscache_req_complete(struct erofs_fscache_rq *req)
> -{
> -	struct folio *folio;
> -	bool failed = req->error;
> -	pgoff_t start_page = req->start / PAGE_SIZE;
> -	pgoff_t last_page = ((req->start + req->len) / PAGE_SIZE) - 1;
> -
> -	XA_STATE(xas, &req->mapping->i_pages, start_page);
> -
> -	rcu_read_lock();
> -	xas_for_each(&xas, folio, last_page) {
> -		if (xas_retry(&xas, folio))
> -			continue;
> -		if (!failed)
> -			folio_mark_uptodate(folio);
> -		folio_unlock(folio);
> -	}
> -	rcu_read_unlock();
> -}
> -
> -static void erofs_fscache_req_put(struct erofs_fscache_rq *req)
> -{
> -	if (!refcount_dec_and_test(&req->ref))
> -		return;
> -	erofs_fscache_req_complete(req);
> -	kfree(req);
> -}
> -
> -static struct erofs_fscache_rq *erofs_fscache_req_alloc(struct address_space *mapping,
> -						loff_t start, size_t len)
> -{
> -	struct erofs_fscache_rq *req = kzalloc_obj(*req);
> -
> -	if (!req)
> -		return NULL;
> -	req->mapping = mapping;
> -	req->start = start;
> -	req->len = len;
> -	refcount_set(&req->ref, 1);
> -	return req;
> -}
> -
> -static void erofs_fscache_req_io_put(struct erofs_fscache_io *io)
> -{
> -	struct erofs_fscache_rq *req = io->private;
> -
> -	if (erofs_fscache_io_put(io))
> -		erofs_fscache_req_put(req);
> -}
> -
> -static void erofs_fscache_req_end_io(void *priv, ssize_t transferred_or_error)
> -{
> -	struct erofs_fscache_io *io = priv;
> -	struct erofs_fscache_rq *req = io->private;
> -
> -	if (IS_ERR_VALUE(transferred_or_error))
> -		req->error = transferred_or_error;
> -	erofs_fscache_req_io_put(io);
> -}
> -
> -static struct erofs_fscache_io *erofs_fscache_req_io_alloc(struct erofs_fscache_rq *req)
> -{
> -	struct erofs_fscache_io *io = kzalloc_obj(*io);
> -
> -	if (!io)
> -		return NULL;
> -	io->end_io = erofs_fscache_req_end_io;
> -	io->private = req;
> -	refcount_inc(&req->ref);
> -	refcount_set(&io->ref, 1);
> -	return io;
> -}
> -
> -/*
> - * Read data from fscache described by cookie at pstart physical address
> - * offset, and fill the read data into buffer described by io->iter.
> - */
> -static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
> -		loff_t pstart, struct erofs_fscache_io *io)
> -{
> -	enum netfs_io_source source;
> -	struct netfs_cache_resources *cres = &io->cres;
> -	struct iov_iter *iter = &io->iter;
> -	int ret;
> -
> -	ret = fscache_begin_read_operation(cres, cookie);
> -	if (ret)
> -		return ret;
> -
> -	while (iov_iter_count(iter)) {
> -		size_t orig_count = iov_iter_count(iter), len = orig_count;
> -		unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
> -
> -		source = cres->ops->prepare_ondemand_read(cres,
> -				pstart, &len, LLONG_MAX, &flags, 0);
> -		if (WARN_ON(len == 0))
> -			source = NETFS_INVALID_READ;
> -		if (source != NETFS_READ_FROM_CACHE) {
> -			erofs_err(NULL, "prepare_ondemand_read failed (source %d)", source);
> -			return -EIO;
> -		}
> -
> -		iov_iter_truncate(iter, len);
> -		refcount_inc(&io->ref);
> -		ret = fscache_read(cres, pstart, iter, NETFS_READ_HOLE_FAIL,
> -				   io->end_io, io);
> -		if (ret == -EIOCBQUEUED)
> -			ret = 0;
> -		if (ret) {
> -			erofs_err(NULL, "fscache_read failed (ret %d)", ret);
> -			return ret;
> -		}
> -		if (WARN_ON(iov_iter_count(iter)))
> -			return -EIO;
> -
> -		iov_iter_reexpand(iter, orig_count - len);
> -		pstart += len;
> -	}
> -	return 0;
> -}
> -
> -struct erofs_fscache_bio {
> -	struct erofs_fscache_io io;
> -	struct bio bio;		/* w/o bdev to share bio_add_page/endio() */
> -	struct bio_vec bvecs[BIO_MAX_VECS];
> -};
> -
> -static void erofs_fscache_bio_endio(void *priv, ssize_t transferred_or_error)
> -{
> -	struct erofs_fscache_bio *io = priv;
> -
> -	if (IS_ERR_VALUE(transferred_or_error))
> -		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
> -	bio_endio(&io->bio);
> -	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
> -	erofs_fscache_io_put(&io->io);
> -}
> -
> -struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
> -{
> -	struct erofs_fscache_bio *io;
> -
> -	io = kmalloc_obj(*io, GFP_KERNEL | __GFP_NOFAIL);
> -	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
> -	io->io.private = mdev->m_dif->fscache->cookie;
> -	io->io.end_io = erofs_fscache_bio_endio;
> -	refcount_set(&io->io.ref, 1);
> -	return &io->bio;
> -}
> -
> -void erofs_fscache_submit_bio(struct bio *bio)
> -{
> -	struct erofs_fscache_bio *io = container_of(bio,
> -			struct erofs_fscache_bio, bio);
> -	int ret;
> -
> -	iov_iter_bvec(&io->io.iter, ITER_DEST, io->bvecs, bio->bi_vcnt,
> -		      bio->bi_iter.bi_size);
> -	ret = erofs_fscache_read_io_async(io->io.private,
> -				bio->bi_iter.bi_sector << 9, &io->io);
> -	erofs_fscache_io_put(&io->io);
> -	if (!ret)
> -		return;
> -	bio->bi_status = errno_to_blk_status(ret);
> -	bio_endio(bio);
> -}
> -
> -static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
> -{
> -	struct erofs_fscache *ctx = folio->mapping->host->i_private;
> -	int ret = -ENOMEM;
> -	struct erofs_fscache_rq *req;
> -	struct erofs_fscache_io *io;
> -
> -	req = erofs_fscache_req_alloc(folio->mapping,
> -				folio_pos(folio), folio_size(folio));
> -	if (!req) {
> -		folio_unlock(folio);
> -		return ret;
> -	}
> -
> -	io = erofs_fscache_req_io_alloc(req);
> -	if (!io) {
> -		req->error = ret;
> -		goto out;
> -	}
> -	iov_iter_xarray(&io->iter, ITER_DEST, &folio->mapping->i_pages,
> -			folio_pos(folio), folio_size(folio));
> -
> -	ret = erofs_fscache_read_io_async(ctx->cookie, folio_pos(folio), io);
> -	if (ret)
> -		req->error = ret;
> -
> -	erofs_fscache_req_io_put(io);
> -out:
> -	erofs_fscache_req_put(req);
> -	return ret;
> -}
> -
> -static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
> -{
> -	struct address_space *mapping = req->mapping;
> -	struct inode *inode = mapping->host;
> -	struct super_block *sb = inode->i_sb;
> -	struct erofs_fscache_io *io;
> -	struct erofs_map_blocks map;
> -	struct erofs_map_dev mdev;
> -	loff_t pos = req->start + req->submitted;
> -	size_t count;
> -	int ret;
> -
> -	map.m_la = pos;
> -	ret = erofs_map_blocks(inode, &map);
> -	if (ret)
> -		return ret;
> -
> -	if (map.m_flags & EROFS_MAP_META) {
> -		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> -		struct iov_iter iter;
> -		size_t size = map.m_llen;
> -		void *src;
> -
> -		src = erofs_read_metabuf(&buf, sb, map.m_pa,
> -					 erofs_inode_in_metabox(inode));
> -		if (IS_ERR(src))
> -			return PTR_ERR(src);
> -
> -		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, PAGE_SIZE);
> -		if (copy_to_iter(src, size, &iter) != size) {
> -			erofs_put_metabuf(&buf);
> -			return -EFAULT;
> -		}
> -		iov_iter_zero(PAGE_SIZE - size, &iter);
> -		erofs_put_metabuf(&buf);
> -		req->submitted += PAGE_SIZE;
> -		return 0;
> -	}
> -
> -	count = req->len - req->submitted;
> -	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> -		struct iov_iter iter;
> -
> -		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
> -		iov_iter_zero(count, &iter);
> -		req->submitted += count;
> -		return 0;
> -	}
> -
> -	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
> -	DBG_BUGON(!count || count % PAGE_SIZE);
> -
> -	mdev = (struct erofs_map_dev) {
> -		.m_deviceid = map.m_deviceid,
> -		.m_pa = map.m_pa,
> -	};
> -	ret = erofs_map_dev(sb, &mdev);
> -	if (ret)
> -		return ret;
> -
> -	io = erofs_fscache_req_io_alloc(req);
> -	if (!io)
> -		return -ENOMEM;
> -	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
> -	ret = erofs_fscache_read_io_async(mdev.m_dif->fscache->cookie,
> -			mdev.m_pa + (pos - map.m_la), io);
> -	erofs_fscache_req_io_put(io);
> -
> -	req->submitted += count;
> -	return ret;
> -}
> -
> -static int erofs_fscache_data_read(struct erofs_fscache_rq *req)
> -{
> -	int ret;
> -
> -	do {
> -		ret = erofs_fscache_data_read_slice(req);
> -		if (ret)
> -			req->error = ret;
> -	} while (!ret && req->submitted < req->len);
> -	return ret;
> -}
> -
> -static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
> -{
> -	struct erofs_fscache_rq *req;
> -	int ret;
> -
> -	req = erofs_fscache_req_alloc(folio->mapping,
> -			folio_pos(folio), folio_size(folio));
> -	if (!req) {
> -		folio_unlock(folio);
> -		return -ENOMEM;
> -	}
> -
> -	ret = erofs_fscache_data_read(req);
> -	erofs_fscache_req_put(req);
> -	return ret;
> -}
> -
> -static void erofs_fscache_readahead(struct readahead_control *rac)
> -{
> -	struct erofs_fscache_rq *req;
> -
> -	if (!readahead_count(rac))
> -		return;
> -
> -	req = erofs_fscache_req_alloc(rac->mapping,
> -			readahead_pos(rac), readahead_length(rac));
> -	if (!req)
> -		return;
> -
> -	/* The request completion will drop refs on the folios. */
> -	while (readahead_folio(rac))
> -		;
> -
> -	erofs_fscache_data_read(req);
> -	erofs_fscache_req_put(req);
> -}
> -
> -static const struct address_space_operations erofs_fscache_meta_aops = {
> -	.read_folio = erofs_fscache_meta_read_folio,
> -};
> -
> -const struct address_space_operations erofs_fscache_access_aops = {
> -	.read_folio = erofs_fscache_read_folio,
> -	.readahead = erofs_fscache_readahead,
> -};
> -
> -static void erofs_fscache_domain_put(struct erofs_domain *domain)
> -{
> -	mutex_lock(&erofs_domain_list_lock);
> -	if (refcount_dec_and_test(&domain->ref)) {
> -		list_del(&domain->list);
> -		if (list_empty(&erofs_domain_list)) {
> -			kern_unmount(erofs_pseudo_mnt);
> -			erofs_pseudo_mnt = NULL;
> -		}
> -		fscache_relinquish_volume(domain->volume, NULL, false);
> -		mutex_unlock(&erofs_domain_list_lock);
> -		kfree_sensitive(domain->domain_id);
> -		kfree(domain);
> -		return;
> -	}
> -	mutex_unlock(&erofs_domain_list_lock);
> -}
> -
> -static int erofs_fscache_register_volume(struct super_block *sb)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	char *domain_id = sbi->domain_id;
> -	struct fscache_volume *volume;
> -	char *name;
> -	int ret = 0;
> -
> -	name = kasprintf(GFP_KERNEL, "erofs,%s",
> -			 domain_id ? domain_id : sbi->fsid);
> -	if (!name)
> -		return -ENOMEM;
> -
> -	volume = fscache_acquire_volume(name, NULL, NULL, 0);
> -	if (IS_ERR_OR_NULL(volume)) {
> -		erofs_err(sb, "failed to register volume for %s", name);
> -		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> -		volume = NULL;
> -	}
> -
> -	sbi->volume = volume;
> -	kfree(name);
> -	return ret;
> -}
> -
> -static int erofs_fscache_init_domain(struct super_block *sb)
> -{
> -	int err;
> -	struct erofs_domain *domain;
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -
> -	domain = kzalloc_obj(struct erofs_domain);
> -	if (!domain)
> -		return -ENOMEM;
> -
> -	domain->domain_id = kstrdup(sbi->domain_id, GFP_KERNEL);
> -	if (!domain->domain_id) {
> -		kfree(domain);
> -		return -ENOMEM;
> -	}
> -
> -	err = erofs_fscache_register_volume(sb);
> -	if (err)
> -		goto out;
> -
> -	if (!erofs_pseudo_mnt) {
> -		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);
> -		if (IS_ERR(mnt)) {
> -			err = PTR_ERR(mnt);
> -			goto out;
> -		}
> -		erofs_pseudo_mnt = mnt;
> -	}
> -
> -	domain->volume = sbi->volume;
> -	refcount_set(&domain->ref, 1);
> -	list_add(&domain->list, &erofs_domain_list);
> -	sbi->domain = domain;
> -	return 0;
> -out:
> -	kfree_sensitive(domain->domain_id);
> -	kfree(domain);
> -	return err;
> -}
> -
> -static int erofs_fscache_register_domain(struct super_block *sb)
> -{
> -	int err;
> -	struct erofs_domain *domain;
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -
> -	mutex_lock(&erofs_domain_list_lock);
> -	list_for_each_entry(domain, &erofs_domain_list, list) {
> -		if (!strcmp(domain->domain_id, sbi->domain_id)) {
> -			sbi->domain = domain;
> -			sbi->volume = domain->volume;
> -			refcount_inc(&domain->ref);
> -			mutex_unlock(&erofs_domain_list_lock);
> -			return 0;
> -		}
> -	}
> -	err = erofs_fscache_init_domain(sb);
> -	mutex_unlock(&erofs_domain_list_lock);
> -	return err;
> -}
> -
> -static struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
> -						char *name, unsigned int flags)
> -{
> -	struct fscache_volume *volume = EROFS_SB(sb)->volume;
> -	struct erofs_fscache *ctx;
> -	struct fscache_cookie *cookie;
> -	struct super_block *isb;
> -	struct inode *inode;
> -	int ret;
> -
> -	ctx = kzalloc_obj(*ctx);
> -	if (!ctx)
> -		return ERR_PTR(-ENOMEM);
> -	INIT_LIST_HEAD(&ctx->node);
> -	refcount_set(&ctx->ref, 1);
> -
> -	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
> -					name, strlen(name), NULL, 0, 0);
> -	if (!cookie) {
> -		erofs_err(sb, "failed to get cookie for %s", name);
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -	fscache_use_cookie(cookie, false);
> -
> -	/*
> -	 * Allocate anonymous inode in global pseudo mount for shareable blobs,
> -	 * so that they are accessible among erofs fs instances.
> -	 */
> -	isb = flags & EROFS_REG_COOKIE_SHARE ? erofs_pseudo_mnt->mnt_sb : sb;
> -	inode = new_inode(isb);
> -	if (!inode) {
> -		erofs_err(sb, "failed to get anon inode for %s", name);
> -		ret = -ENOMEM;
> -		goto err_cookie;
> -	}
> -
> -	inode->i_size = OFFSET_MAX;
> -	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
> -	mapping_set_gfp_mask(inode->i_mapping, GFP_KERNEL);
> -	inode->i_blkbits = EROFS_SB(sb)->blkszbits;
> -	inode->i_private = ctx;
> -
> -	ctx->cookie = cookie;
> -	ctx->inode = inode;
> -	return ctx;
> -
> -err_cookie:
> -	fscache_unuse_cookie(cookie, NULL, NULL);
> -	fscache_relinquish_cookie(cookie, false);
> -err:
> -	kfree(ctx);
> -	return ERR_PTR(ret);
> -}
> -
> -static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
> -{
> -	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> -	fscache_relinquish_cookie(ctx->cookie, false);
> -	iput(ctx->inode);
> -	kfree(ctx->name);
> -	kfree(ctx);
> -}
> -
> -static struct erofs_fscache *erofs_domain_init_cookie(struct super_block *sb,
> -						char *name, unsigned int flags)
> -{
> -	struct erofs_fscache *ctx;
> -	struct erofs_domain *domain = EROFS_SB(sb)->domain;
> -
> -	ctx = erofs_fscache_acquire_cookie(sb, name, flags);
> -	if (IS_ERR(ctx))
> -		return ctx;
> -
> -	ctx->name = kstrdup(name, GFP_KERNEL);
> -	if (!ctx->name) {
> -		erofs_fscache_relinquish_cookie(ctx);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	refcount_inc(&domain->ref);
> -	ctx->domain = domain;
> -	list_add(&ctx->node, &erofs_domain_cookies_list);
> -	return ctx;
> -}
> -
> -static struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> -						char *name, unsigned int flags)
> -{
> -	struct erofs_fscache *ctx;
> -	struct erofs_domain *domain = EROFS_SB(sb)->domain;
> -
> -	flags |= EROFS_REG_COOKIE_SHARE;
> -	mutex_lock(&erofs_domain_cookies_lock);
> -	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
> -		if (ctx->domain != domain || strcmp(ctx->name, name))
> -			continue;
> -		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
> -			refcount_inc(&ctx->ref);
> -		} else {
> -			erofs_err(sb, "%s already exists in domain %s", name,
> -				  domain->domain_id);
> -			ctx = ERR_PTR(-EEXIST);
> -		}
> -		mutex_unlock(&erofs_domain_cookies_lock);
> -		return ctx;
> -	}
> -	ctx = erofs_domain_init_cookie(sb, name, flags);
> -	mutex_unlock(&erofs_domain_cookies_lock);
> -	return ctx;
> -}
> -
> -struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						    char *name,
> -						    unsigned int flags)
> -{
> -	if (EROFS_SB(sb)->domain_id)
> -		return erofs_domain_register_cookie(sb, name, flags);
> -	return erofs_fscache_acquire_cookie(sb, name, flags);
> -}
> -
> -void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
> -{
> -	struct erofs_domain *domain = NULL;
> -
> -	if (!ctx)
> -		return;
> -	if (!ctx->domain)
> -		return erofs_fscache_relinquish_cookie(ctx);
> -
> -	mutex_lock(&erofs_domain_cookies_lock);
> -	if (refcount_dec_and_test(&ctx->ref)) {
> -		domain = ctx->domain;
> -		list_del(&ctx->node);
> -		erofs_fscache_relinquish_cookie(ctx);
> -	}
> -	mutex_unlock(&erofs_domain_cookies_lock);
> -	if (domain)
> -		erofs_fscache_domain_put(domain);
> -}
> -
> -int erofs_fscache_register_fs(struct super_block *sb)
> -{
> -	int ret;
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct erofs_fscache *fscache;
> -	unsigned int flags = 0;
> -
> -	if (sbi->domain_id)
> -		ret = erofs_fscache_register_domain(sb);
> -	else
> -		ret = erofs_fscache_register_volume(sb);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * When shared domain is enabled, using NEED_NOEXIST to guarantee
> -	 * the primary data blob (aka fsid) is unique in the shared domain.
> -	 *
> -	 * For non-shared-domain case, fscache_acquire_volume() invoked by
> -	 * erofs_fscache_register_volume() has already guaranteed
> -	 * the uniqueness of primary data blob.
> -	 *
> -	 * Acquired domain/volume will be relinquished in kill_sb() on error.
> -	 */
> -	if (sbi->domain_id)
> -		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
> -	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
> -	if (IS_ERR(fscache))
> -		return PTR_ERR(fscache);
> -
> -	sbi->dif0.fscache = fscache;
> -	return 0;
> -}
> -
> -void erofs_fscache_unregister_fs(struct super_block *sb)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -
> -	erofs_fscache_unregister_cookie(sbi->dif0.fscache);
> -
> -	if (sbi->domain)
> -		erofs_fscache_domain_put(sbi->domain);
> -	else
> -		fscache_relinquish_volume(sbi->volume, NULL, false);
> -
> -	sbi->dif0.fscache = NULL;
> -	sbi->volume = NULL;
> -	sbi->domain = NULL;
> -}
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index a188c570087a..1df38b7c82a7 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -255,7 +255,7 @@ static int erofs_fill_inode(struct inode *inode)
>  	}
>  
>  	mapping_set_large_folios(inode->i_mapping);
> -	aops = erofs_get_aops(inode, false);
> +	aops = erofs_get_aops(inode);
>  	if (IS_ERR(aops))
>  		return PTR_ERR(aops);
>  	inode->i_mapping->a_ops = aops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 9e2ae7b61977..580f8d9f14e7 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -43,7 +43,6 @@ typedef u64 erofs_blk_t;
>  
>  struct erofs_device_info {
>  	char *path;
> -	struct erofs_fscache *fscache;
>  	struct file *file;
>  	struct dax_device *dax_dev;
>  	u64 fsoff, dax_part_off;
> @@ -80,24 +79,6 @@ struct erofs_sb_lz4_info {
>  	u16 max_pclusterblks;
>  };
>  
> -struct erofs_domain {
> -	refcount_t ref;
> -	struct list_head list;
> -	struct fscache_volume *volume;
> -	char *domain_id;
> -};
> -
> -struct erofs_fscache {
> -	struct fscache_cookie *cookie;
> -	struct inode *inode;	/* anonymous inode for the blob */
> -
> -	/* used for share domain mode */
> -	struct erofs_domain *domain;
> -	struct list_head node;
> -	refcount_t ref;
> -	char *name;
> -};
> -
>  struct erofs_xattr_prefix_item {
>  	struct erofs_xattr_long_prefix *prefix;
>  	u8 infix_len;
> @@ -162,10 +143,6 @@ struct erofs_sb_info {
>  	struct completion s_kobj_unregister;
>  	erofs_off_t dir_ra_bytes;
>  
> -	/* fscache support */
> -	struct fscache_volume *volume;
> -	struct erofs_domain *domain;
> -	char *fsid;
>  	char *domain_id;
>  };
>  
> @@ -191,12 +168,6 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
>  
>  extern struct file_system_type erofs_anon_fs_type;
>  
> -static inline bool erofs_is_fscache_mode(struct super_block *sb)
> -{
> -	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> -			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
> -}
> -
>  enum {
>  	EROFS_ZIP_CACHE_DISABLED,
>  	EROFS_ZIP_CACHE_READAHEAD,
> @@ -413,11 +384,9 @@ struct erofs_map_dev {
>  };
>  
>  extern const struct super_operations erofs_sops;
> -
>  extern const struct address_space_operations erofs_aops;
>  extern const struct address_space_operations erofs_fileio_aops;
>  extern const struct address_space_operations z_erofs_aops;
> -extern const struct address_space_operations erofs_fscache_access_aops;
>  
>  extern const struct inode_operations erofs_generic_iops;
>  extern const struct inode_operations erofs_symlink_iops;
> @@ -430,10 +399,6 @@ extern const struct file_operations erofs_ishare_fops;
>  
>  extern const struct iomap_ops z_erofs_iomap_report_ops;
>  
> -/* flags for erofs_fscache_register_cookie() */
> -#define EROFS_REG_COOKIE_SHARE		0x0001
> -#define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
> -
>  void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
>  			  erofs_off_t *offset, int *lengthp);
>  void erofs_unmap_metabuf(struct erofs_buf *buf);
> @@ -473,7 +438,7 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>  }
>  
>  static inline const struct address_space_operations *
> -erofs_get_aops(struct inode *realinode, bool no_fscache)
> +erofs_get_aops(struct inode *realinode)
>  {
>  	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>  		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
> @@ -483,9 +448,6 @@ erofs_get_aops(struct inode *realinode, bool no_fscache)
>  			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
>  		return &z_erofs_aops;
>  	}
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
> -	    erofs_is_fscache_mode(realinode->i_sb))
> -		return &erofs_fscache_access_aops;
>  	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
>  	    erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
>  		return &erofs_fileio_aops;
> @@ -548,36 +510,6 @@ static inline struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev) { r
>  static inline void erofs_fileio_submit_bio(struct bio *bio) {}
>  #endif
>  
> -#ifdef CONFIG_EROFS_FS_ONDEMAND
> -int erofs_fscache_register_fs(struct super_block *sb);
> -void erofs_fscache_unregister_fs(struct super_block *sb);
> -
> -struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -					char *name, unsigned int flags);
> -void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
> -struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev);
> -void erofs_fscache_submit_bio(struct bio *bio);
> -#else
> -static inline int erofs_fscache_register_fs(struct super_block *sb)
> -{
> -	return -EOPNOTSUPP;
> -}
> -static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
> -
> -static inline
> -struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -					char *name, unsigned int flags)
> -{
> -	return ERR_PTR(-EOPNOTSUPP);
> -}
> -
> -static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache)
> -{
> -}
> -static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
> -static inline void erofs_fscache_submit_bio(struct bio *bio) {}
> -#endif
> -
>  #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>  int __init erofs_init_ishare(void);
>  void erofs_exit_ishare(void);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 35cbd0bc04d7..0868c12fc15b 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -45,7 +45,7 @@ bool erofs_ishare_fill_inode(struct inode *inode)
>  	struct erofs_inode_fingerprint fp;
>  	struct inode *si;
>  
> -	aops = erofs_get_aops(inode, true);
> +	aops = erofs_get_aops(inode);
>  	if (IS_ERR(aops))
>  		return false;
>  	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 579443e6acfe..86fa5c6a0c70 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -126,7 +126,6 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  			     struct erofs_device_info *dif, erofs_off_t *pos)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct erofs_fscache *fscache;
>  	struct erofs_deviceslot *dis;
>  	struct file *file;
>  	bool _48bit;
> @@ -145,12 +144,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  			return -ENOMEM;
>  	}
>  
> -	if (erofs_is_fscache_mode(sb)) {
> -		fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
> -		if (IS_ERR(fscache))
> -			return PTR_ERR(fscache);
> -		dif->fscache = fscache;
> -	} else if (!sbi->devs->flatdev) {
> +	if (!sbi->devs->flatdev) {
>  		file = erofs_is_fileio_mode(sbi) ?
>  				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
>  				bdev_file_open_by_path(dif->path,
> @@ -216,7 +210,7 @@ static int erofs_scan_devices(struct super_block *sb,
>  	if (!ondisk_extradevs)
>  		return 0;
>  
> -	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
> +	if (!sbi->devs->extra_devices)
>  		sbi->devs->flatdev = true;
>  
>  	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
> @@ -372,8 +366,6 @@ static int erofs_read_superblock(struct super_block *sb)
>  		erofs_info(sb, "EXPERIMENTAL 48-bit layout support in use. Use at your own risk!");
>  	if (erofs_sb_has_metabox(sbi))
>  		erofs_info(sb, "EXPERIMENTAL metadata compression support in use. Use at your own risk!");
> -	if (erofs_is_fscache_mode(sb))
> -		erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
>  out:
>  	erofs_put_metabuf(&buf);
>  	return ret;
> @@ -393,8 +385,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>  
>  enum {
>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> -	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
> -	Opt_inode_share,
> +	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
>  };
>  
>  static const struct constant_table erofs_param_cache_strategy[] = {
> @@ -418,7 +409,6 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>  	fsparam_flag("dax",             Opt_dax),
>  	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>  	fsparam_string("device",	Opt_device),
> -	fsparam_string("fsid",		Opt_fsid),
>  	fsparam_string("domain_id",	Opt_domain_id),
>  	fsparam_flag_no("directio",	Opt_directio),
>  	fsparam_u64("fsoffset",		Opt_fsoffset),
> @@ -509,25 +499,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  		}
>  		++sbi->devs->extra_devices;
>  		break;
> -#ifdef CONFIG_EROFS_FS_ONDEMAND
> -	case Opt_fsid:
> -		kfree(sbi->fsid);
> -		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
> -		if (!sbi->fsid)
> -			return -ENOMEM;
> -		break;
> -#endif
> -#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>  	case Opt_domain_id:
> -		kfree_sensitive(sbi->domain_id);
> -		sbi->domain_id = no_free_ptr(param->string);
> -		break;
> -#else
> -	case Opt_fsid:
> -	case Opt_domain_id:
> -		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
> +		if (!IS_ENABLED(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)) {
> +			errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
> +		} else {
> +			kfree_sensitive(sbi->domain_id);
> +			sbi->domain_id = no_free_ptr(param->string);
> +		}
>  		break;
> -#endif
>  	case Opt_directio:
>  		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE))
>  			errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
> @@ -620,12 +599,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (sbi->domain_id && sbi->fsid)
> -		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
> -					     sbi->fsid);
> -	else if (sbi->fsid)
> -		super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
> -	else if (erofs_is_fileio_mode(sbi))
> +	if (erofs_is_fileio_mode(sbi))
>  		super_set_sysfs_name_generic(sb, "%s",
>  					     bdi_dev_name(sb->s_bdi));
>  	else
> @@ -680,11 +654,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  		sb->s_blocksize = PAGE_SIZE;
>  		sb->s_blocksize_bits = PAGE_SHIFT;
>  
> -		if (erofs_is_fscache_mode(sb)) {
> -			err = erofs_fscache_register_fs(sb);
> -			if (err)
> -				return err;
> -		}
>  		err = super_setup_bdi(sb);
>  		if (err)
>  			return err;
> @@ -703,11 +672,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  		return err;
>  
>  	if (sb->s_blocksize_bits != sbi->blkszbits) {
> -		if (erofs_is_fscache_mode(sb)) {
> -			errorfc(fc, "unsupported blksize for fscache mode");
> -			return -EINVAL;
> -		}
> -
>  		if (erofs_is_fileio_mode(sbi)) {
>  			sb->s_blocksize = 1 << sbi->blkszbits;
>  			sb->s_blocksize_bits = sbi->blkszbits;
> @@ -716,14 +680,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  			return -EINVAL;
>  		}
>  	}
> -
> -	if (sbi->dif0.fsoff) {
> -		if (sbi->dif0.fsoff & (sb->s_blocksize - 1))
> -			return invalfc(fc, "fsoffset %llu is not aligned to block size %lu",
> -				       sbi->dif0.fsoff, sb->s_blocksize);
> -		if (erofs_is_fscache_mode(sb))
> -			return invalfc(fc, "cannot use fsoffset in fscache mode");
> -	}
> +	if (sbi->dif0.fsoff & (sb->s_blocksize - 1))
> +		return invalfc(fc, "fsoffset %llu is not aligned to block size %lu",
> +			       sbi->dif0.fsoff, sb->s_blocksize);
>  
>  	if (test_opt(&sbi->opt, DAX_ALWAYS) && sbi->blkszbits != PAGE_SHIFT) {
>  		erofs_info(sb, "unsupported blocksize for DAX");
> @@ -793,16 +752,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
> -	struct erofs_sb_info *sbi = fc->s_fs_info;
>  	int ret;
>  
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
> -		return get_tree_nodev(fc, erofs_fc_fill_super);
> -
>  	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
>  		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
>  			GET_TREE_BDEV_QUIET_LOOKUP : 0);
>  	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
> +		struct erofs_sb_info *sbi = fc->s_fs_info;
>  		struct file *file;
>  
>  		if (!fc->source)
> @@ -827,8 +783,8 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
>  
>  	DBG_BUGON(!sb_rdonly(sb));
>  
> -	if (new_sbi->fsid || new_sbi->domain_id)
> -		erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
> +	if (new_sbi->domain_id)
> +		erofs_info(sb, "ignoring reconfiguration for domain_id.");
>  
>  	if (test_opt(&new_sbi->opt, POSIX_ACL))
>  		fc->sb_flags |= SB_POSIXACL;
> @@ -848,8 +804,6 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
>  	fs_put_dax(dif->dax_dev, NULL);
>  	if (dif->file)
>  		fput(dif->file);
> -	erofs_fscache_unregister_cookie(dif->fscache);
> -	dif->fscache = NULL;
>  	kfree(dif->path);
>  	kfree(dif);
>  	return 0;
> @@ -867,7 +821,6 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
>  static void erofs_sb_free(struct erofs_sb_info *sbi)
>  {
>  	erofs_free_dev_context(sbi->devs);
> -	kfree(sbi->fsid);
>  	kfree_sensitive(sbi->domain_id);
>  	if (sbi->dif0.file)
>  		fput(sbi->dif0.file);
> @@ -928,14 +881,12 @@ static void erofs_kill_sb(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) ||
> -	    sbi->dif0.file)
> +	if (sbi->dif0.file)
>  		kill_anon_super(sb);
>  	else
>  		kill_block_super(sb);
>  	erofs_drop_internal_inodes(sbi);
>  	fs_put_dax(sbi->dif0.dax_dev, NULL);
> -	erofs_fscache_unregister_fs(sb);
>  	erofs_sb_free(sbi);
>  	sb->s_fs_info = NULL;
>  }
> @@ -950,7 +901,6 @@ static void erofs_put_super(struct super_block *sb)
>  	erofs_drop_internal_inodes(sbi);
>  	erofs_free_dev_context(sbi->devs);
>  	sbi->devs = NULL;
> -	erofs_fscache_unregister_fs(sb);
>  }
>  
>  static struct file_system_type erofs_fs_type = {
> @@ -962,14 +912,12 @@ static struct file_system_type erofs_fs_type = {
>  };
>  MODULE_ALIAS_FS("erofs");
>  
> -#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>  static void erofs_free_anon_inode(struct inode *inode)
>  {
>  	struct erofs_inode *vi = EROFS_I(inode);
>  
> -#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>  	kfree(vi->fingerprint.opaque);
> -#endif
>  	kmem_cache_free(erofs_inode_cachep, vi);
>  }
>  
> @@ -1099,12 +1047,6 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",dax=never");
>  	if (erofs_is_fileio_mode(sbi) && test_opt(opt, DIRECT_IO))
>  		seq_puts(seq, ",directio");
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)) {
> -		if (sbi->fsid)
> -			seq_printf(seq, ",fsid=%s", sbi->fsid);
> -		if (sbi->domain_id)
> -			seq_printf(seq, ",domain_id=%s", sbi->domain_id);
> -	}
>  	if (sbi->dif0.fsoff)
>  		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
>  	if (test_opt(opt, INODE_SHARE))
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 1c65b741b288..74520e910259 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1710,8 +1710,6 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
>  drain_io:
>  				if (erofs_is_fileio_mode(EROFS_SB(sb)))
>  					erofs_fileio_submit_bio(bio);
> -				else if (erofs_is_fscache_mode(sb))
> -					erofs_fscache_submit_bio(bio);
>  				else
>  					submit_bio(bio);
>  
> @@ -1740,8 +1738,6 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
>  			if (!bio) {
>  				if (erofs_is_fileio_mode(EROFS_SB(sb)))
>  					bio = erofs_fileio_bio_alloc(&mdev);
> -				else if (erofs_is_fscache_mode(sb))
> -					bio = erofs_fscache_bio_alloc(&mdev);
>  				else
>  					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
>  							REQ_OP_READ, GFP_NOIO);
> @@ -1770,8 +1766,6 @@ static void z_erofs_submit_queue(struct z_erofs_frontend *f,
>  	if (bio) {
>  		if (erofs_is_fileio_mode(EROFS_SB(sb)))
>  			erofs_fileio_submit_bio(bio);
> -		else if (erofs_is_fscache_mode(sb))
> -			erofs_fscache_submit_bio(bio);
>  		else
>  			submit_bio(bio);
>  	}

-- 
Thanks,
Jingbo


