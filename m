Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5F9048F4
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 04:23:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u5QPpIqO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzTqY5sJwz3dWV
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 12:23:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u5QPpIqO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzTqR5j7Pz3bnt
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jun 2024 12:23:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718159006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kcpGGixx8oFc+/PSDCiF42Y0qv+UhH+FeRrTmn5fBF4=;
	b=u5QPpIqO+ocQwr8zD/OYVJFMchULWTBsfZSJkwjy9/78RrdLYBzoP78ADwVlwqU7GTCu+zLI7vV8FP/JEd/VINQSCF40P8GSFESgDGt527cgpeHExboqlFcADP9YFaflSo9sQmjLNmYKo20c9aRpW5M9p7R0fmxS1+eEHUihaA8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8ICzrO_1718159004;
Received: from 30.221.131.70(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8ICzrO_1718159004)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 10:23:25 +0800
Message-ID: <f1630c8f-6b7d-4056-a02c-7f9609797ebd@linux.alibaba.com>
Date: Wed, 12 Jun 2024 10:23:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: add I/O control for tarerofs stream via
 `erofs_vfile`
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240611111937.378214-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240611111937.378214-1-hongzhen@linux.alibaba.com>
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



On 2024/6/11 19:19, Hongzhen Luo wrote:
> This adds I/O control for tarerofs stream.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v3: Make the code cleaner.
> v2: https://lore.kernel.org/all/20240611095359.294925-1-hongzhen@linux.alibaba.com/
> v1: https://lore.kernel.org/all/20240611075445.178659-1-hongzhen@linux.alibaba.com/
> ---
>   include/erofs/io.h  |  4 ++++
>   include/erofs/tar.h |  2 +-
>   lib/io.c            | 35 +++++++++++++++++++++++++++++++++++
>   lib/tar.c           | 34 +++++-----------------------------
>   4 files changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index c82dfdf..2c91314 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -30,6 +30,8 @@ struct erofs_vfops {
>   	int (*fsync)(struct erofs_vfile *vf);
>   	int (*fallocate)(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
>   	int (*ftruncate)(struct erofs_vfile *vf, u64 length);
> +	int (*read)(struct erofs_vfile *vf, void *buf, size_t len);

	it can overflow, I think it's much better to use `ssize_t` instead.

> +	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);

	

>   };
>   
>   struct erofs_vfile {
> @@ -43,6 +45,8 @@ int erofs_io_fsync(struct erofs_vfile *vf);
>   int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
>   int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
>   int erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
> +int erofs_io_read(struct erofs_vfile *vf, void *buf, size_t len);
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
> index 2db384c..8e01948 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -420,3 +420,38 @@ out:
>   #endif
>   	return __erofs_copy_file_range(fd_in, off_in, fd_out, off_out, length);
>   }
> +
> +int erofs_io_read(struct erofs_vfile *vf, void *buf, size_t bytes)
> +{
> +	s64 i = 0;

	ssize_t i = 0;

> +
> +	if (vf->ops)
> +		return vf->ops->read(vf, buf, bytes);
> +
> +	while (bytes) {
> +		int len = bytes > INT_MAX ? INT_MAX : bytes;
> +		int ret;
> +
> +		ret = read(vf->fd, buf + i, len);
> +		if (ret < 1) {
> +			if (ret == 0) {
> +				break;
> +			} else if (errno != EINTR) {
> +				erofs_err("failed to read : %s\n",


				erofs_err("failed to read: %s",

Otherwise it looks good to me,

Thanks,
Gao Xiang
