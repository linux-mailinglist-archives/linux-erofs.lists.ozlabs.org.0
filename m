Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21B904972
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 05:19:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=veaI1J8z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzW4V4YDqz3dX1
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 13:19:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=veaI1J8z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzW4Q23zsz30Tv
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jun 2024 13:19:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718162384; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bfikEZ3kt7M5FWYzRHlgfFFLnOx2TxAJw4D24xiArnU=;
	b=veaI1J8zt9g8PaXb6j1pifr3A5hu/OfJ0bUpiJvADGEzE2Qg1GsmaU5tJMSjbXvwCCisEXUXf5Fo6x+Y77q3YLvWLVA+1mTSCLpIOSgyZTQc5aVu/SubIiRjDNQLGvYLmi3c2nzX1Wcm24DwwACQH/ePDLDbPdAlkyCC1TcgamA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8INfdg_1718162381;
Received: from 30.221.131.70(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8INfdg_1718162381)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 11:19:42 +0800
Message-ID: <06094df4-2f5b-4a05-a47d-ed05a079382b@linux.alibaba.com>
Date: Wed, 12 Jun 2024 11:19:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs-utils: add I/O control for tarerofs stream via
 `erofs_vfile`
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240612031124.1227558-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240612031124.1227558-1-hongzhen@linux.alibaba.com>
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



On 2024/6/12 11:11, Hongzhen Luo wrote:
> This adds I/O control for tarerofs stream.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v4: Modify the function definition to prevent overflow.
> v3: https://lore.kernel.org/all/20240611111937.378214-1-hongzhen@linux.alibaba.com/
> v2: https://lore.kernel.org/all/20240611095359.294925-1-hongzhen@linux.alibaba.com/
> v1: https://lore.kernel.org/all/20240611075445.178659-1-hongzhen@linux.alibaba.com/
> ---
>   include/erofs/internal.h |  2 +-
>   include/erofs/io.h       | 14 ++++++++-----
>   include/erofs/tar.h      |  2 +-
>   lib/io.c                 | 45 +++++++++++++++++++++++++++++++++++-----
>   lib/tar.c                | 34 +++++-------------------------
>   5 files changed, 56 insertions(+), 41 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index f1d85be..2ab0958 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -453,7 +453,7 @@ void erofs_dev_close(struct erofs_sb_info *sbi);
>   void erofs_blob_closeall(struct erofs_sb_info *sbi);
>   int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev);
>   
> -int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
> +ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
>   		   void *buf, u64 offset, size_t len);

This line lacks space alignment.

>   
>   static inline int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index c82dfdf..f24a563 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -25,11 +25,13 @@ extern "C"
>   struct erofs_vfile;
>   
>   struct erofs_vfops {
> -	int (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
> -	int (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
> +	ssize_t (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
> +	ssize_t (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
>   	int (*fsync)(struct erofs_vfile *vf);
>   	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
>   	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
> +	ssize_t (*read)(struct erofs_vfile *vf, void *buf, size_t len);
> +	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
>   };
>   
>   struct erofs_vfile {
> @@ -38,11 +40,13 @@ struct erofs_vfile {
>   	int fd;
>   };
>   
> -int erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
> +ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t len);
>   int erofs_io_fsync(struct erofs_vfile *vf);
> -int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
> +ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
>   int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
> -int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
> +ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
> +ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t len);
> +off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence);
>   
>   ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
>   			      size_t length);
> diff --git a/include/erofs/tar.h b/include/erofs/tar.h
> index b5c966b..e1de0df 100644
> --- a/include/erofs/tar.h
> +++ b/include/erofs/tar.h
> @@ -39,7 +39,7 @@ struct erofs_iostream_liblzma {
>   
>   struct erofs_iostream {
>   	union {
> -		int fd;			/* original fd */
> +		struct erofs_vfile vf;
>   		void *handler;
>   #ifdef HAVE_LIBLZMA
>   		struct erofs_iostream_liblzma *lzma;
> diff --git a/lib/io.c b/lib/io.c
> index 2db384c..4cf88b2 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -26,7 +26,7 @@
>   #define EROFS_MODNAME	"erofs_io"
>   #include "erofs/print.h"
>   
> -int erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
> +ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
>   		    u64 pos, size_t len)

Same here.

>   {
>   	ssize_t ret;
> @@ -74,11 +74,11 @@ int erofs_io_fsync(struct erofs_vfile *vf)
>   	return 0;
>   }
>   
> -int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
> +ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
>   		       size_t len, bool zeroout)

Same here.

>   {
>   	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
> -	int ret;
> +	ssize_t ret;
>   
>   	if (unlikely(cfg.c_dry_run))
>   		return 0;
> @@ -123,7 +123,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
>   	return ftruncate(vf->fd, length);
>   }
>   
> -int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
> +ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
>   {
>   	ssize_t ret;
>   
> @@ -317,7 +317,7 @@ int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
>   	return 0;
>   }
>   
> -int erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
> +ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
>   		   void *buf, u64 offset, size_t len)

Same here.

I will fix manually, but please take care of alignment next time.

Thanks,
Gao Xiang

>   {
>   	if (device_id)
> @@ -420,3 +420,38 @@ out:
>   #endif
>   	return __erofs_copy_file_range(fd_in, off_in, fd_out, off_out, length);
>   }
