Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075D915B70
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 03:02:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FUS1bQto;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W7RQQ3Rn4z3cZn
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 11:02:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FUS1bQto;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W7RQJ72DWz2xjL
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2024 11:02:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719277362; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Lwl4mROnTtmAvWH/rz1uCxV8+8BE7k/ToLx83D9L/Dg=;
	b=FUS1bQtoSgIIudFTI6Ylf2YJh2cGDSFIxk4YwGRRVZ1fEZif2JzvQg72fXRXAKBinSvk6OG1TN9vCLy25Cr1Ys75tXr2Leiqo7Mi3dYIC9Reu9D9aTrm7llsogK1XtTrD5+SkUqyfCQPff6kWDvRH9QxnxftOq5a6EBU7u4abnw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9DR4Ql_1719277360;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9DR4Ql_1719277360)
          by smtp.aliyun-inc.com;
          Tue, 25 Jun 2024 09:02:41 +0800
Message-ID: <00e92d3f-7bdd-44b8-8a2f-ea07fd47d040@linux.alibaba.com>
Date: Tue, 25 Jun 2024 09:02:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: fix possible memory leak in z_erofs_gbuf_exit()
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <20240624220206.3373197-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240624220206.3373197-1-dhavale@google.com>
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/25 06:02, Sandeep Dhavale wrote:
> Because we incorrectly reused of variable `i` in `z_erofs_gbuf_exit()`
> for inner loop, we may exit early from outer loop resulting in memory
> leak. Fix this by using separate variable for iterating through inner loop.
> 
> Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/zutil.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 036024bce9f7..b80f612867c2 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -148,7 +148,7 @@ int __init z_erofs_gbuf_init(void)
>   
>   void z_erofs_gbuf_exit(void)
>   {
> -	int i;
> +	int i, j;
>   
>   	for (i = 0; i < z_erofs_gbuf_count + (!!z_erofs_rsvbuf); ++i) {
>   		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
> @@ -161,9 +161,9 @@ void z_erofs_gbuf_exit(void)
>   		if (!gbuf->pages)
>   			continue;
>   
> -		for (i = 0; i < gbuf->nrpages; ++i)
> -			if (gbuf->pages[i])
> -				put_page(gbuf->pages[i]);
> +		for (j = 0; j < gbuf->nrpages; ++j)
> +			if (gbuf->pages[j])
> +				put_page(gbuf->pages[j]);
>   		kfree(gbuf->pages);
>   		gbuf->pages = NULL;
>   	}
