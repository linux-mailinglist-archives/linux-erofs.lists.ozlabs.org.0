Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA35597E61
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 08:10:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M7ZHH1xR2z3bvZ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Aug 2022 16:10:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M7ZHB3nGYz2xHF
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Aug 2022 16:09:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VMZbOe5_1660802988;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VMZbOe5_1660802988)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 14:09:50 +0800
Date: Thu, 18 Aug 2022 14:09:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: zbestahu@gmail.com
Subject: Re: [PATCH] erofs-utils: mkfs: clear 'h_idata_size' when drop inline
 pcluster
Message-ID: <Yv3XrF2AyHV9qjy1@B-P7TQMD6M-0146.local>
References: <20220818023509.8698-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220818023509.8698-1-huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 18, 2022 at 10:35:09AM +0800, zbestahu@gmail.com wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The value of 'h_idata_size' should be zero if no inline pcluster.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  lib/compress.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index ee3b856..2453d0a 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -565,6 +565,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
>  
>  	h->h_advise = cpu_to_le16(le16_to_cpu(h->h_advise) &
>  				  ~Z_EROFS_ADVISE_INLINE_PCLUSTER);
> +	h->h_idata_size = 0;
>  	if (!inode->eof_tailraw)
>  		return;
>  	DBG_BUGON(inode->compressed_idata != true);
> -- 
> 2.17.1
