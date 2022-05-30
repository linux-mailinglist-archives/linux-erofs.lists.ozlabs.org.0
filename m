Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642C537637
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 10:09:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBSjX2M77z3bXg
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 18:09:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBSjR47BJz308b
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 18:08:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VEkLGFr_1653898123;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEkLGFr_1653898123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 May 2022 16:08:45 +0800
Date: Mon, 30 May 2022 16:08:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: [PATCH] erofs: fix 'backmost' member of
 z_erofs_decompress_frontend
Message-ID: <YpR7izQ0H0DWaHzA@B-P7TQMD6M-0146.local>
References: <20220530075114.918874-1-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220530075114.918874-1-o451686892@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, May 30, 2022 at 03:51:14PM +0800, Weizhao Ouyang wrote:
> Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.
> 
> Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>


Many thanks for the in-time catching! ;)

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/zdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 95efc127b2ba..94d2cb970644 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -214,7 +214,7 @@ struct z_erofs_decompress_frontend {
>  
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
>  	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> -	.mode = COLLECT_PRIMARY_FOLLOWED }
> +	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
>  
>  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
>  static DEFINE_MUTEX(z_pagemap_global_lock);
> -- 
> 2.34.1
