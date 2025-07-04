Return-Path: <linux-erofs+bounces-523-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E685AF9BDB
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 23:09:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYmV922kHz2xlL;
	Sat,  5 Jul 2025 07:09:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751663377;
	cv=none; b=CX5cxrrpQJi+ue7SkoNtnp/EcWOqdwGwei9F9J4pzQa4jRjWt8QdVSWIYRkI+jjJuwDtILt7L+/K4zopE0O4OYJAQHAI9bewXoBzixLI2TUTwoaEyV1GOrD9mueWxqWrwys+8tysoUgZ232QGMnal9GSIngbq1b5osiJ0bxVHmPfz7Twt7qlf2g9nIStGUTkBi7Uyb/cemCr79SKYP1uFPc8hJ65fcm8DYlCb8PgDBb15FRs0pX5TTGPlIKDHNNqbzy36233DNpPb+m7CZIanYLxX53Q0e9nkpmKkmuIJnTXoiC4CqLRf70oEw3OMzHsONvzdZL3rrAAzzJbyJxmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751663377; c=relaxed/relaxed;
	bh=AxBbZlFGJNBh/xo2Wqd2DeNZppJLe3+P4+P5zWwf9Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeBGBgqN7hMCcjU5wyqGOHRELGTlsWXNIUfoVRSdUwF6xFQiS2XOoquYHBhpG21H1omVmUYGTy3Fsv4xRsKzxZmCPdsy8VCZaSZccDNGnckSdGHTwGS9CVtB88YjoWd7XjdVpQb+BMsz2b3CQErYb98wvoAIb1Z0eVqJOSbZ6uPyYo29eniWRL+ZCalzka6jM7s3xLfuN6SEjl8a9V1bumOwYWE+4R02Wj4anyILBUQxEaEc7CRuszMoVs7ZPhhjLuchCUssXU26yonudcADbVXECvr1RIcnMF0YjPIOFyQzAA4TJyEjDb35KiZrhJFtdL8RVgo0ERD45FkBjctScQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=szcuU5Fr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=szcuU5Fr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYmV82XYKz2xd3
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 07:09:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751663372; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AxBbZlFGJNBh/xo2Wqd2DeNZppJLe3+P4+P5zWwf9Jg=;
	b=szcuU5FrD6fbmm5x3UKFb9hMTzJamR/eKk7XTuzTZytN9Jk+SHOeDh7/IdR13GU+F407T6VtUx8wTLEZjp+OqjyJw61FdcEuJGNCk+B+dGBgDlorf4X89aX+jo2bqlTIdeKQVDPoRfW1Yng6hGmX/VN/sTGac4rKFATt0LW4t0U=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhMKIBL_1751663370 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 05:09:31 +0800
Message-ID: <2e8369db-50ec-4deb-ab34-f468ffb4b96f@linux.alibaba.com>
Date: Sat, 5 Jul 2025 05:09:30 +0800
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
Subject: Re: [PATCH RFC 4/4] erofs: introduce .fadvise for page cache share
To: Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-4-0ce1f6be28ee@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250703-work-erofs-pcs-v1-4-0ce1f6be28ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/3 20:23, Christian Brauner wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> When using .fadvise to release a file's page cache, it frees page cache
> pages that were first read by this file. To achieve this, an interval
> tree is added in the inode of that file to track the segments first
> read by that inode.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Link: https://lore.kernel.org/20240902110620.2202586-5-hongzhen@linux.alibaba.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/erofs/data.c            | 38 ++++++++++++++++++++--
>   fs/erofs/internal.h        |  5 +++
>   fs/erofs/pagecache_share.c | 81 ++++++++++++++++++++++++++++++++++++++++++++--
>   fs/erofs/pagecache_share.h |  2 ++
>   fs/erofs/super.c           |  9 ++++++
>   5 files changed, 131 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fb54162f4c54..61a42a95d26b 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -7,6 +7,7 @@
>   #include "internal.h"
>   #include <linux/sched/mm.h>
>   #include <trace/events/erofs.h>
> +#include "pagecache_share.h"
>   
>   void erofs_unmap_metabuf(struct erofs_buf *buf)
>   {
> @@ -353,6 +354,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
>   #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>   	struct erofs_inode *vi = NULL;
> +	struct interval_tree_node *seg;
>   	int ret;
>   
>   	if (file && file->private_data) {
> @@ -363,8 +365,22 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>   			vi = NULL;
>   	}
>   	ret = iomap_read_folio(folio, &erofs_iomap_ops);
> -	if (vi)
> +	if (vi) {
>   		folio->mapping->host = file_inode(file);
> +		seg = erofs_pcs_alloc_seg();
> +		if (!seg)
> +			return -ENOMEM;
> +		seg->start = folio->index;
> +		seg->last = seg->start + (folio_size(folio) >> PAGE_SHIFT);
> +		if (seg->last > (vi->vfs_inode.i_size >> PAGE_SHIFT))
> +			seg->last = vi->vfs_inode.i_size >> PAGE_SHIFT;
> +		if (seg->last >= seg->start) {
> +			mutex_lock(&vi->segs_mutex);
> +			interval_tree_insert(seg, &vi->segs);
> +			mutex_unlock(&vi->segs_mutex);
> +		} else
> +			erofs_pcs_free_seg(seg);
> +	}

I don't know what Hongzhen is trying to do in this patch and
it seems too odd on my side, maybe it needs to reimplement
this patch later but we should support .fadvise().

Thanks,
Gao Xiang

> 


