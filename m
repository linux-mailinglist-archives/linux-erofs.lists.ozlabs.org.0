Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED55FD684
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Oct 2022 10:59:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mp3P455RRz3c6T
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Oct 2022 19:59:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mp3P102mcz2yQH
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Oct 2022 19:59:32 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VS37JoU_1665651566;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VS37JoU_1665651566)
          by smtp.aliyun-inc.com;
          Thu, 13 Oct 2022 16:59:28 +0800
Date: Thu, 13 Oct 2022 16:59:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: avoid unnecessary insert behavior when not
 deduplicating
Message-ID: <Y0fTbmoezlKid246@B-P7TQMD6M-0146.local>
References: <20221013040011.31944-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013040011.31944-1-zbestahu@gmail.com>
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

Hi Yue,

On Thu, Oct 13, 2022 at 12:00:11PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> We should do nothing in dedupe inserting when it's not configured.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---

Thanks for the patch, do you observe some strange happening? 

IMO, If dedupe is not enabled, window_size will be 0 I think.
However, I think we might need to disable it explicitly like below.

So,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


>  lib/dedupe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dedupe.c b/lib/dedupe.c
> index 7962014..9cad905 100644
> --- a/lib/dedupe.c
> +++ b/lib/dedupe.c
> @@ -99,7 +99,7 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
>  {
>  	struct z_erofs_dedupe_item *di;
>  
> -	if (e->length < window_size)
> +	if (!dedupe_subtree || e->length < window_size)
>  		return 0;
>  
>  	di = malloc(sizeof(*di) + e->length - window_size);
> -- 
> 2.17.1
