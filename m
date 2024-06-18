Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC890C57C
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 11:50:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DDBDq2+h;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3MSQ3D9Xz3cM2
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 19:50:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DDBDq2+h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3MSK1dLtz3bqB
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 19:50:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718704220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Zbq/qawkOFhHBjZJGql3z+MzQFovOW/60CuB8vMgCRk=;
	b=DDBDq2+hOqguGx2hMKbtwE6DHqFMDgq+cO7mxl3DBMAgXLHM8hh7SgCLIpvrcCr28wLjNel45sKvn+RoVQxbM8uTBsogmpR2081/GGRSTcDjkiJWFktOBJSIUxcDEG9ELxHaHvx4gbGJZjwGwDuCOE0KN6Jx6ur1pVI6mdq2Bzk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jrIoX_1718704218;
Received: from 30.97.48.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jrIoX_1718704218)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 17:50:19 +0800
Message-ID: <244b4ac3-7c38-4f2b-a764-4a40e76ce296@linux.alibaba.com>
Date: Tue, 18 Jun 2024 17:50:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: fix the erofs_io_pread and
 erofs_io_pwrite
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240618093843.912278-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240618093843.912278-1-hongzhen@linux.alibaba.com>
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



On 2024/6/18 17:38, Hongzhen Luo wrote:
> When `vf->ops` is not null, `vf->ops->pread` returns the
> number of bytes successfully read, which is inconsistent
> with the semantics of `erofs_io_pread`. Similar situation
> occurs in `erofs_io_pwrite`. This fixes this issue.
> 
> This also fixes `erofs_dev_close`.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v1: https://lore.kernel.org/all/20240617023433.3446706-1-hongzhen@linux.alibaba.com/
> ---
>   include/erofs/internal.h |  5 ++++-
>   lib/io.c                 | 31 +++++++++++++++++++++++--------
>   2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index f8a01ce..ed1fc92 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -460,7 +460,10 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
>   static inline int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
>   				  u64 offset, size_t len)
>   {
> -	return erofs_io_pwrite(&sbi->bdev, buf, offset, len);
> +	ssize_t ret;
> +
> +	ret = erofs_io_pwrite(&sbi->bdev, buf, offset, len);
> +	return (size_t)ret == len ? 0 : (int)ret;
>   }
>   
>   static inline int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
> diff --git a/lib/io.c b/lib/io.c
> index c523f00..0149d3b 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -30,6 +30,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
>   			u64 pos, size_t len)
>   {
>   	ssize_t ret;
> +	size_t saved_len = len;
>   
>   	if (unlikely(cfg.c_dry_run))
>   		return 0;
> @@ -53,7 +54,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
>   		pos += ret;
>   	} while (len);
>   
> -	return 0;
> +	return saved_len;
>   }
>   
>   int erofs_io_fsync(struct erofs_vfile *vf)
> @@ -79,6 +80,7 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
>   {
>   	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
>   	ssize_t ret;
> +	ssize_t wret;
why not directly using ret here?

>   
>   	if (unlikely(cfg.c_dry_run))
>   		return 0;
> @@ -92,13 +94,16 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
>   		return 0;
>   #endif
>   	while (len > EROFS_MAX_BLOCK_SIZE) {
> -		ret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
> +		wret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
> +		ret = wret == EROFS_MAX_BLOCK_SIZE ? 0 : wret;
>   		if (ret)
>   			return ret;
>   		len -= EROFS_MAX_BLOCK_SIZE;
>   		offset += EROFS_MAX_BLOCK_SIZE;
>   	}
> -	return erofs_io_pwrite(vf, zero, offset, len);
> +	wret = erofs_io_pwrite(vf, zero, offset, len);
> +	ret = wret == len ? 0 : wret;

	


> +	return ret;
>   }
>   
>   int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
> @@ -126,6 +131,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
>   ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
>   {
>   	ssize_t ret;
> +	size_t saved_len = len;

I really think you need to record the data read and

You don't address:
                         if (!ret) {
                                 erofs_info("reach EOF of device");
                                 memset(buf, 0, len);
                                 return 0;
                         }

>   
>   	if (unlikely(cfg.c_dry_run))
>   		return 0;
> @@ -156,7 +162,8 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
>   		len -= ret;
>   		buf += ret;
>   	} while (len);
> -	return 0;
> +
> +	return saved_len;
>   }
>   
>   static int erofs_get_bdev_size(int fd, u64 *bytes)
> @@ -287,7 +294,8 @@ out:
>   
>   void erofs_dev_close(struct erofs_sb_info *sbi)
>   {
> -	close(sbi->bdev.fd);
> +	if (!sbi->bdev.ops)
> +		close(sbi->bdev.fd);
>   	free(sbi->devname);
>   	sbi->devname = NULL;
>   	sbi->bdev.fd = -1;
> @@ -320,11 +328,18 @@ int erofs_blob_open_ro(struct erofs_sb_info *sbi, const char *dev)
>   ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
>   		       void *buf, u64 offset, size_t len)
>   {
> -	if (device_id)
> -		return erofs_io_pread(&((struct erofs_vfile) {
> +	ssize_t ret;
> +
> +	if (device_id) {
> +		ret = erofs_io_pread(&((struct erofs_vfile) {
>   				.fd = sbi->blobfd[device_id - 1],
>   			}), buf, offset, len);
> -	return erofs_io_pread(&sbi->bdev, buf, offset, len);
> +		return ret == len ? 0 : ret;

What's the meaning if ret > 0?

> +
> +	}
> +
> +	ret =  erofs_io_pread(&sbi->bdev, buf, offset, len);
> +	return ret == len ? 0 : ret;

Same here.

Thanks,
Gao Xiang
