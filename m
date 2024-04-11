Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112F8A1299
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Apr 2024 13:10:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PBGYVFZl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VFcS10TjMz3dX4
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Apr 2024 21:10:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PBGYVFZl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VFcRv0VQZz2yt0
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Apr 2024 21:10:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712833812; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Xte64WKX4APGVVQukK8ww/shCSJQzIZn0Mf+kxjgVjk=;
	b=PBGYVFZloVgPeiZgJqehGygfZkzXK22cb3kS4q8gKLzwMTnBte+/auf1XrBCeeuIsjvbS+DN7fICA0xhL1swzfPm0RcJ3+SBQe1niieE3T0kOd4fvbhYL5s+H9TXspsU92cFgC+eylmRbdPjrG6X1pjc1D2l5ZQZiFzkzhXVnbo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W4L7Llu_1712833810;
Received: from 30.221.145.233(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W4L7Llu_1712833810)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 19:10:11 +0800
Message-ID: <163a094a-d2e7-46c8-a011-87ec80ae34a3@linux.alibaba.com>
Date: Thu, 11 Apr 2024 19:10:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix tarerofs 32-bit overflows
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240411100039.197417-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240411100039.197417-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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



On 4/11/24 6:00 PM, Gao Xiang wrote:
> Otherwise, large files won't be imported properly.
> 
> Fixes: e3dfe4b8db26 ("erofs-utils: mkfs: support tgz streams for tarerofs")
> Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>


LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  lib/tar.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/tar.c b/lib/tar.c
> index b45657d..8d606f9 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -233,7 +233,7 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
>  					  ret, erofs_strerror(-errno));
>  	}
>  	*buf = ios->buffer;
> -	ret = min_t(int, ios->tail, bytes);
> +	ret = min_t(int, ios->tail, min_t(u64, bytes, INT_MAX));
>  	ios->head = ret;
>  	return ret;
>  }
> @@ -605,10 +605,9 @@ void tarerofs_remove_inode(struct erofs_inode *inode)
>  static int tarerofs_write_file_data(struct erofs_inode *inode,
>  				    struct erofs_tarfile *tar)
>  {
> -	unsigned int j;
>  	void *buf;
>  	int fd, nread;
> -	u64 off;
> +	u64 off, j;
>  
>  	if (!inode->i_diskbuf) {
>  		inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));

-- 
Thanks,
Jingbo
