Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2829592EC0
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 14:14:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M5tWf45Stz30D0
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 22:14:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M5tWW1pT9z2xGG
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Aug 2022 22:14:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMJKe7S_1660565679;
Received: from 30.227.73.152(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VMJKe7S_1660565679)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 20:14:40 +0800
Message-ID: <9dc534eb-e083-f2cd-404e-9fb56230def2@linux.alibaba.com>
Date: Mon, 15 Aug 2022 20:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
Content-Language: en-US
To: Sun Ke <sunke32@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20220815034829.3940803-1-sunke32@huawei.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220815034829.3940803-1-sunke32@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 8/15/22 11:48 AM, Sun Ke via Linux-erofs wrote:
> If erofs_fscache_alloc_request fail and then goto out, it will return 0.
> it should return a negative error code instead of 0.
> 
> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
>  fs/erofs/fscache.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8e01d89c3319..b5fd9d71e67f 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -222,8 +222,10 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>  
>  	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
>  				folio_pos(folio), folio_size(folio));
> -	if (IS_ERR(rreq))
> +	if (IS_ERR(rreq)) {
> +		ret = PTR_ERR(rreq);
>  		goto out;
> +	}
>  
>  	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
>  				rreq, mdev.m_pa);
> @@ -301,8 +303,10 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>  
>  	rreq = erofs_fscache_alloc_request(folio_mapping(folio),
>  				folio_pos(folio), folio_size(folio));
> -	if (IS_ERR(rreq))
> +	if (IS_ERR(rreq)) {
> +		ret = PTR_ERR(rreq);
>  		goto out_unlock;
> +	}
>  
>  	pstart = mdev.m_pa + (pos - map.m_la);
>  	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,

-- 
Thanks,
Jingbo
