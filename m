Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE36FA01D40
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 03:15:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRHpD36rSz305S
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 13:15:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736129730;
	cv=none; b=h/7r9AytDtEvT/QC+71HqhNmo3AS7KaH/32ZCGEd/7fTchAoW/ybXiuuleD5112Rh7l51Od2ECuH/eMtYVsM+8INRSuat9fYOTwfnoiKwTVadP4g51jpN5Og5RxMnxKaS1j/7u0hvNPsMfawlvSw/Iv2J6hOlwumwvBPUYdlzYaCOgu2S+++1D8mKXa9Gs6djCI6BsOAP62oyEYofO68sifOLaPcYoyvcxhy8orXvqXufTFxD8nDUlkYkm1O6syKA/rErkKt7IaZ7P0IIND/xZxmqnhtkDBxN3EQ9QiZHO5gnN6KJuDGuqLEi2rh2gk/Z+e7UkK7x2pdo36V/8lKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736129730; c=relaxed/relaxed;
	bh=1Scjx0e8WJu8kptreuXG60CMeDXRLZbo67QLe/C3F0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYXsMVQJbWLRN1cCnuyP/T3PqM1tBZCg2ODyNzJad6kScry3n00ge1RD74jB961G8EKQByaqwLhDVOeiMMUwmA882U46c5NAsfBjzmqmcZn4Hhh21Cg6QpMIXPiaX3IBHs9JwYZB+W8ByD7sM1k7TQn3y9cO5VYgdWglYV++lP2oucy6XzpwX/3kzuymJ9xggo/nUACU3KLz6acK260sQU5Z6VjjC2ofgUaijjilbL8HWLTTaUEhARq/rs325AMi3r+HSVfgPbTTm+ILN9w1ZiKZ6s1XSwBT8OOAlcthxHhlH0ItrODfSgqlnKdVLR9T1XYyN5yjqmCMgazuwFGpdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ptww/RaE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ptww/RaE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YRHp82JX6z2xrJ
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jan 2025 13:15:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736129720; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1Scjx0e8WJu8kptreuXG60CMeDXRLZbo67QLe/C3F0g=;
	b=ptww/RaE9vwdFm0G4NBnNeWzZlUWQ+Gi/b/w6IpeXxP77BQpwqb3x530wkISeHRALKcgxMHM/Act3IlES5tsJR6F2scXwyEJd72gq/fhhMEp869LVTPG1RNdAdMjHqh50fy6JIaDCaj8rbZ9hHOUVoRArNcYdmV36j2+GJCQszI=
Received: from 30.221.128.186(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMzsuzC_1736129718 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jan 2025 10:15:18 +0800
Message-ID: <19cfa3ca-ee9e-4017-b34b-11073064dea5@linux.alibaba.com>
Date: Mon, 6 Jan 2025 10:15:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/4] erofs: apply the page cache share feature
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
 <20250105151208.3797385-4-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250105151208.3797385-4-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/5 23:12, Hongzhen Luo wrote:

...

> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0cd6b5c4df98..fb08acbeaab6 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "internal.h"
> +#include "pagecache_share.h"
>   #include <linux/sched/mm.h>
>   #include <trace/events/erofs.h>
>   
> @@ -370,12 +371,21 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> -	return iomap_read_folio(folio, &erofs_iomap_ops);
> +	int ret, pcshr;
> +
> +	pcshr = erofs_pcshr_read_begin(file, folio);
> +	ret = iomap_read_folio(folio, &erofs_iomap_ops);
> +	erofs_pcshr_read_end(file, folio, pcshr);
> +	return ret;
>   }
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> -	return iomap_readahead(rac, &erofs_iomap_ops);
> +	int pcshr;
> +
> +	pcshr = erofs_pcshr_readahead_begin(rac);
> +	iomap_readahead(rac, &erofs_iomap_ops);
> +	erofs_pcshr_readahead_end(rac, pcshr);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d4b89407822a..0b070f4b46b8 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "xattr.h"
> +#include "pagecache_share.h"
>   #include <trace/events/erofs.h>
>   
>   static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> @@ -212,7 +213,9 @@ static int erofs_fill_inode(struct inode *inode)
>   	switch (inode->i_mode & S_IFMT) {
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
> -		if (erofs_inode_is_data_compressed(vi->datalayout))
> +		if (erofs_pcshr_fill_inode(inode) == 0)
> +			inode->i_fop = &erofs_pcshr_fops;
> +		else if (erofs_inode_is_data_compressed(vi->datalayout))
>   			inode->i_fop = &generic_ro_fops;
>   		else
>   			inode->i_fop = &erofs_file_fops;
> diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
> index 703fd17c002c..22172b5e21c7 100644
> --- a/fs/erofs/pagecache_share.c
> +++ b/fs/erofs/pagecache_share.c
> @@ -22,6 +22,7 @@ struct erofs_pcshr_counter {
>   
>   struct erofs_pcshr_private {
>   	char fprt[PCSHR_FPRT_MAXLEN];
> +	struct mutex mutex;
>   };
>   
>   static struct erofs_pcshr_counter mnt_counter = {
> @@ -84,6 +85,7 @@ static int erofs_fprt_set(struct inode *inode, void *data)
>   	if (!ano_private)
>   		return -ENOMEM;
>   	memcpy(ano_private, data, sizeof(size_t) + *(size_t *)data);
> +	mutex_init(&ano_private->mutex);
>   	inode->i_private = ano_private;
>   	return 0;
>   }
> @@ -226,3 +228,64 @@ const struct file_operations erofs_pcshr_fops = {
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
>   };
> +
> +int erofs_pcshr_read_begin(struct file *file, struct folio *folio)
> +{
> +	struct erofs_inode *vi;
> +	struct erofs_pcshr_private *ano_private;
> +
> +	if (!(file && file->private_data))
> +		return 0;
> +
> +	vi = file->private_data;
> +	if (vi->ano_inode != file_inode(file))
> +		return 0;
> +
> +	ano_private = vi->ano_inode->i_private;
> +	mutex_lock(&ano_private->mutex);
> +	folio->mapping->host = &vi->vfs_inode;

you shouldn't change `folio->mapping->host` directly.

> +	return 1;
> +}
> +
> +void erofs_pcshr_read_end(struct file *file, struct folio *folio, int pcshr)
> +{
> +	struct erofs_pcshr_private *ano_private;
> +
> +	if (pcshr == 0)
> +		return;
> +
> +	ano_private = file_inode(file)->i_private;
> +	folio->mapping->host = file_inode(file);


you shouldn't change `folio->mapping->host` directly
and then switch back.  It's too hacky.

> +	mutex_unlock(&ano_private->mutex);
> +}
> +
> +int erofs_pcshr_readahead_begin(struct readahead_control *rac)
> +{
> +	struct erofs_inode *vi;
> +	struct file *file = rac->file;
> +	struct erofs_pcshr_private *ano_private;
> +
> +	if (!(file && file->private_data))
> +		return 0;
> +
> +	vi = file->private_data;
> +	if (vi->ano_inode != file_inode(file))
> +		return 0;
> +
> +	ano_private = file_inode(file)->i_private;
> +	mutex_lock(&ano_private->mutex);
> +	rac->mapping->host = &vi->vfs_inode;

Same here.

Thanks,
Gao Xiang
