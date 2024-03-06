Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA51872F03
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Mar 2024 07:52:11 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uByIMMDk;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TqNQd4NFbz3dWZ
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Mar 2024 17:52:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uByIMMDk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TqNQX42tRz3cZL
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Mar 2024 17:52:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709707917; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c5yBu7adoqwvK7GV/nwnjKRKfn1zteyqa+I2+Qq4dDo=;
	b=uByIMMDkTTBtyiMFijM4qh9lVTIogLTvvJwfo1HJGwIMYHYVhN3QpyEsmUxRZnhcRofKd+reQEHFA0J+4zP62pTCltFmR8uAJvpYDr/TfaA2QoxrmoAvUQV4fNR8VMaGxI9DcjPtqvq9J8RlDVTWRSGLJOL/QcmDf3/ly7cegXA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1wOZdo_1709707914;
Received: from 30.97.48.227(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1wOZdo_1709707914)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 14:51:55 +0800
Message-ID: <30300dc7-3063-4e09-bb21-22951ec23a38@linux.alibaba.com>
Date: Wed, 6 Mar 2024 14:51:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: apply proper VMA alignment for memory mapped files
 on THP
To: linux-erofs@lists.ozlabs.org
References: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240306053138.2240206-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/6 13:31, Gao Xiang wrote:
> There are mainly two reasons that thp_get_unmapped_area() should be
> used for EROFS as other filesystems:
> 
>   - It's needed to enable PMD mappings as a FSDAX filesystem, see
>     commit 74d2fad1334d ("thp, dax: add thp_get_unmapped_area for pmd
>     mappings");
> 
>   - It's useful together with CONFIG_READ_ONLY_THP_FOR_FS which enables
>     THPs for read-only mmapped files (e.g. shared libraries) even without
>     FSDAX.  See commit 1854bc6e2420 ("mm/readahead: Align file mappings
>     for non-DAX").

Refine this part as

  - It's useful together with large folios and CONFIG_READ_ONLY_THP_FOR_FS
    which enable THPs for mmapped files (e.g. shared libraries) even without
    ...

> 
> Fixes: 06252e9ce05b ("erofs: dax support for non-tailpacking regular file")

Fixes: ce529cc25b18 ("erofs: enable large folios for iomap mode")
Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")

> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index c98aeda8abb2..3d9721b3faa8 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -447,5 +447,6 @@ const struct file_operations erofs_file_fops = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= erofs_file_read_iter,
>   	.mmap		= erofs_file_mmap,
> +	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
>   };
