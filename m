Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0390990A2EC
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jun 2024 05:42:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V/qIb3jj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W2bKl64CBz3cND
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jun 2024 13:42:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V/qIb3jj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W2bKg2J3vz30Tk
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Jun 2024 13:41:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718595713; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3oS6DckOHa8L6y1HyDu6cf3t6/c2M95QKlrEzkdFpC8=;
	b=V/qIb3jjcoUhjIiQPly6WcGLisw/LNyMt/EykUCZVCQR6/hTCBD/YnS2OydgQmDXQK5dtVqqpFI1kM1JIYfKIANqAo25ggokewbnNLPjS9QR51mOKfc/qLMHVjsN47K0oU6i7FVHAehSWNWoQ5OJfMes12RFhch/rO40OXzMF+0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8X5zLk_1718595710;
Received: from 30.97.48.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8X5zLk_1718595710)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 11:41:51 +0800
Message-ID: <00872cd1-722c-4c7b-b69c-284d941d08ec@linux.alibaba.com>
Date: Mon, 17 Jun 2024 11:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fix the erofs_io_pread and erofs_io_pwrite
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240617023433.3446706-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240617023433.3446706-1-hongzhen@linux.alibaba.com>
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



On 2024/6/17 10:34, Hongzhen Luo wrote:
> When `vf->ops` is not null, `vf->ops->pread` returns the
> number of bytes successfully read, which is inconsistent
> with the semantics of `erofs_io_pread`. Similar situation
> occurs in `erofs_io_pwrite`. This fixes this issue.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

I think virtual files don't need to handle short read/write
(or they need to handle those themselves.)


> ---
>   lib/io.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/io.c b/lib/io.c
> index c523f00..52a74dc 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -34,15 +34,18 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
>   	if (unlikely(cfg.c_dry_run))
>   		return 0;

But I think we might need to fix those return values for
non-virtual files (return the written bytes.)

>   
> -	if (vf->ops)
> -		return vf->ops->pwrite(vf, buf, pos, len);
> -
>   	pos += vf->offset;
>   	do {
>   #ifdef HAVE_PWRITE64
> -		ret = pwrite64(vf->fd, buf, len, (off64_t)pos);
> +		if (vf->ops)
> +			ret = vf->ops->pwrite(vf, buf, pos, len);
> +		else
> +			ret = pwrite64(vf->fd, buf, len, (off64_t)pos);
>   #else
> -		ret = pwrite(vf->fd, buf, len, (off_t)pos);
> +		if (vf->ops)
> +			ret = vf->ops->pwrite(vf, buf, pos, len);
> +		else
> +			ret = pwrite(vf->fd, buf, len, (off_t)pos);
>   #endif
>   		if (ret <= 0) {
>   			erofs_err("failed to write: %s", strerror(errno));
> @@ -130,15 +133,18 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
>   	if (unlikely(cfg.c_dry_run))
>   		return 0;

Same here.

Thanks,
Gao Xiang

>   
> -	if (vf->ops)
> -		return vf->ops->pread(vf, buf, pos, len);
> -
>   	pos += vf->offset;
>   	do {
>   #ifdef HAVE_PREAD64
> -		ret = pread64(vf->fd, buf, len, (off64_t)pos);
> +		if (vf->ops)
> +			ret = vf->ops->pread(vf, buf, pos, len);
> +		else
> +			ret = pread64(vf->fd, buf, len, (off64_t)pos);
>   #else
> -		ret = pread(vf->fd, buf, len, (off_t)pos);
> +		if (vf->ops)
> +			ret = vf->ops->pread(vf, buf, pos, len);
> +		else
> +			ret = pread(vf->fd, buf, len, (off_t)pos);
>   #endif
>   		if (ret <= 0) {
>   			if (!ret) {
