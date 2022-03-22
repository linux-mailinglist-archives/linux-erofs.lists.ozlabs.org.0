Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABD4E3A90
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 09:28:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KN4Pn70GHz2yPj
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 19:28:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KN4Ph20wbz2xsM
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 19:28:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V7v6BSf_1647937689; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7v6BSf_1647937689) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 22 Mar 2022 16:28:11 +0800
Date: Tue, 22 Mar 2022 16:28:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: xkernel.wang@foxmail.com
Subject: Re: [PATCH] erofs: fix a potential NULL dereference of alloc_pages()
Message-ID: <YjmImXwknNx4WXDb@B-P7TQMD6M-0146.local>
References: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Mar 22, 2022 at 04:08:12PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> alloc_pages() returns the page on success or NULL if allocation fails,
> while set_page_private() will dereference `newpage`. So it is better to
> catch the memory error in case other errors happen.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  fs/erofs/zdata.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 11c7a1a..36a5421 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -735,11 +735,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		struct page *const newpage =
>  				alloc_page(GFP_NOFS | __GFP_NOFAIL);
>  

It's really a nofail allocation, am I missing something?

Thanks,
Gao Xiang

> -		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> -		err = z_erofs_attach_page(clt, newpage,
> -					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
> -		if (!err)
> -			goto retry;
> +		if (!newpage) {
> +			err = -ENOMEM;
> +		} else {
> +			set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> +			err = z_erofs_attach_page(clt, newpage,
> +						Z_EROFS_PAGE_TYPE_EXCLUSIVE);
> +			if (!err)
> +				goto retry;
> +		}
>  	}
>  
>  	if (err)
> -- 
