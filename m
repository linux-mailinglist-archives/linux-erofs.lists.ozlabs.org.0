Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E858894E0F
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 10:57:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nYizaWOS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V81x56L99z3dRm
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 19:57:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nYizaWOS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V81x02Nt8z3cDd
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 19:57:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712048252; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kPB+6cYCu/UF/RqplbzmfyYSFMDYv+pNC6skHPehs0c=;
	b=nYizaWOSlxOh3wmi2cEZv+2TSjhmJZKMBe105dtMR0p8GZNC6dxQiHKsc74aRrnRPB9953EyDyIXxuerEydBZhSeoPta8y9S7qRPeBxiPcV1lYpGIanUW3dOo8hzzB/DHSQhJG66i/H8wledx20fowroszqzANH4anBzDX6exuc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W3nw0g2_1712048249;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3nw0g2_1712048249)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 16:57:30 +0800
Message-ID: <b904fbcd-653d-4548-b354-213f5c4563ea@linux.alibaba.com>
Date: Tue, 2 Apr 2024 16:57:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: do not use pagepool in z_erofs_gbuf_growsize()
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240402084031.2623314-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240402084031.2623314-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/2 16:40, Chunhai Guo wrote:
> Let's use alloc_pages_bulk_array() for simplicity and get rid of
> unnecessary pagepool.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/zutil.c | 64 +++++++++++++++++++++++-------------------------
>   1 file changed, 30 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index e13806681763..14440c0bf64e 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -60,61 +60,57 @@ void z_erofs_put_gbuf(void *ptr) __releases(gbuf->lock)
>   int z_erofs_gbuf_growsize(unsigned int nrpages)
>   {
>   	static DEFINE_MUTEX(gbuf_resize_mutex);
> -	struct page *pagepool = NULL;
> -	int delta, ret, i, j;
> +	struct page **tmp_pages = NULL;
> +	struct z_erofs_gbuf *gbuf;
> +	void *ptr, *old_ptr;
> +	int last, i, j;
> +	int ret = 0；

no needed.

>   
>   	mutex_lock(&gbuf_resize_mutex);
> -	delta = nrpages - z_erofs_gbuf_nrpages;
> -	ret = 0;
>   	/* avoid shrinking gbufs, since no idea how many fses rely on */
> -	if (delta <= 0)
> +	if (nrpages <= z_erofs_gbuf_nrpages)
>   		goto out;

	if (nrpages <= z_erofs_gbuf_nrpages) {
		mutex_unlock(&gbuf_resize_mutex);
		return 0;
	}

since it's a fast side path, let's bail out this directly.

>   
> +	ret = -ENOMEM;

no needed.

>   	for (i = 0; i < z_erofs_gbuf_count; ++i) {
> -		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
> -		struct page **pages, **tmp_pages;
> -		void *ptr, *old_ptr = NULL;
> -
> -		ret = -ENOMEM;
> +		gbuf = &z_erofs_gbufpool[i];
>   		tmp_pages = kcalloc(nrpages, sizeof(*tmp_pages), GFP_KERNEL);
>   		if (!tmp_pages)
> -			break;
> -		for (j = 0; j < nrpages; ++j) {
> -			tmp_pages[j] = erofs_allocpage(&pagepool, GFP_KERNEL);
> -			if (!tmp_pages[j])
> -				goto free_pagearray;
> -		}
> +			goto out;
> +
> +		for (j = 0; j < gbuf->nrpages; ++j)
> +			tmp_pages[j] = gbuf->pages[j];
> +		do {
> +			last = j;
> +			j = alloc_pages_bulk_array(GFP_KERNEL, nrpages,
> +						   tmp_pages);
> +			if (last == j)
> +				goto out;
> +		} while (j != nrpages);
> +
>   		ptr = vmap(tmp_pages, nrpages, VM_MAP, PAGE_KERNEL);
>   		if (!ptr)
> -			goto free_pagearray;
> +			goto out;
>   
> -		pages = tmp_pages;
>   		spin_lock(&gbuf->lock);
> +		kfree(gbuf->pages);
> +		gbuf->pages = tmp_pages;
>   		old_ptr = gbuf->ptr;
>   		gbuf->ptr = ptr;
> -		tmp_pages = gbuf->pages;
> -		gbuf->pages = pages;
> -		j = gbuf->nrpages;
>   		gbuf->nrpages = nrpages;
>   		spin_unlock(&gbuf->lock);
> -		ret = 0;
> -		if (!tmp_pages) {
> -			DBG_BUGON(old_ptr);
> -			continue;
> -		}
> -
>   		if (old_ptr)
>   			vunmap(old_ptr);
> -free_pagearray:
> -		while (j)
> -			erofs_pagepool_add(&pagepool, tmp_pages[--j]);
> -		kfree(tmp_pages);
> -		if (ret)
> -			break;
>   	}
> +	ret = 0;
>   	z_erofs_gbuf_nrpages = nrpages;
> -	erofs_release_pages(&pagepool);
>   out:
> +	if (ret && tmp_pages) {

	if (i < z_erofs_gbuf_count && tmp_pages) {

> +		for (j = 0; j < nrpages; ++j)
> +			if (tmp_pages[j] && tmp_pages[j] != gbuf->pages[j])
> +				__free_page(tmp_pages[j]);
> +		kfree(tmp_pages);
> +	}
>   	mutex_unlock(&gbuf_resize_mutex);
>   	return ret;

	return i < z_erofs_gbuf_count ? -ENOMEM: 0;

Otherwise it looks good to me.

Thanks,
Gao Xiang

>   }
