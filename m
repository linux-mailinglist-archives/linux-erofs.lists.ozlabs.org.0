Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4F944CFDD
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 03:12:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HqQFz0TB6z2yNY
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 13:12:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HqQFr494nz2xt0
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 13:11:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UvzWQhe_1636596698; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UvzWQhe_1636596698) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 11 Nov 2021 10:11:40 +0800
Date: Thu, 11 Nov 2021 10:11:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs-utils: mkfs: fix integer overflow in
 erofs_blob_remap
Message-ID: <YYx72rN3ISRcABAI@B-P7TQMD6M-0146.local>
References: <20211111015527.2717076-1-dvander@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211111015527.2717076-1-dvander@google.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Thu, Nov 11, 2021 at 01:55:27AM +0000, David Anderson via Linux-erofs wrote:
> When using --chunksize, partitions greater than 2GiB can fail to build
> due to integer overflow in erofs_blob_remap.
> 
> Signed-off-by: David Anderson <dvander@google.com>

Thanks for the report! good catch! Will apply this later.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(however, I think it needs several loops for 32-bit platforms.
 I will fix it later...)

Thanks,
Gao Xiang

> ---
>  include/erofs/io.h |  6 +++---
>  lib/blobchunk.c    |  2 +-
>  lib/io.c           | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 2597c5c..9d73adc 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -27,9 +27,9 @@ u64 dev_length(void);
>  
>  extern int erofs_devfd;
>  
> -int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
> -                          int fd_out, erofs_off_t *off_out,
> -                          size_t length);
> +ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
> +			      int fd_out, erofs_off_t *off_out,
> +			      size_t length);
>  
>  static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
>  			    u32 nblocks)
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 661c5d0..a0ff79c 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -179,7 +179,7 @@ int erofs_blob_remap(void)
>  	struct erofs_buffer_head *bh;
>  	ssize_t length;
>  	erofs_off_t pos_in, pos_out;
> -	int ret;
> +	ssize_t ret;
>  
>  	fflush(blobfile);
>  	length = ftell(blobfile);
> diff --git a/lib/io.c b/lib/io.c
> index cfc062d..279c7dd 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -259,9 +259,9 @@ int dev_read(void *buf, u64 offset, size_t len)
>  	return 0;
>  }
>  
> -static int __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
> -				   int fd_out, erofs_off_t *off_out,
> -				   size_t length)
> +static ssize_t __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
> +				       int fd_out, erofs_off_t *off_out,
> +				       size_t length)
>  {
>  	size_t copied = 0;
>  	char buf[8192];
> @@ -331,9 +331,9 @@ static int __erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
>  	return copied;
>  }
>  
> -int erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
> -			  int fd_out, erofs_off_t *off_out,
> -			  size_t length)
> +ssize_t erofs_copy_file_range(int fd_in, erofs_off_t *off_in,
> +			      int fd_out, erofs_off_t *off_out,
> +			      size_t length)
>  {
>  #ifdef HAVE_COPY_FILE_RANGE
>  	off64_t off64_in = *off_in, off64_out = *off_out;
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog
