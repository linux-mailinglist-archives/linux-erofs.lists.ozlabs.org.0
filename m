Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD51B619412
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 11:03:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N3bmY5f1Lz3cMx
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 21:03:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N3bmS2fZDz3cF6
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Nov 2022 21:03:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTwgtpI_1667556191;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTwgtpI_1667556191)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 18:03:13 +0800
Date: Fri, 4 Nov 2022 18:03:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: put metabuf in error path in fscache mode
Message-ID: <Y2TjX/xJYenOEb6k@B-P7TQMD6M-0146.local>
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104054028.52208-2-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Nov 04, 2022 at 01:40:27PM +0800, Jingbo Xu wrote:
> For tail packing layout, put metabuf when error is encountered.
> 
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/fscache.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..83559008bfa8 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -287,8 +287,10 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>  			return PTR_ERR(src);
>  
>  		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
> -		if (copy_to_iter(src + offset, size, &iter) != size)
> +		if (copy_to_iter(src + offset, size, &iter) != size) {
> +			erofs_put_metabuf(&buf);
>  			return -EFAULT;
> +		}
>  		iov_iter_zero(PAGE_SIZE - size, &iter);
>  		erofs_put_metabuf(&buf);
>  		return PAGE_SIZE;
> -- 
> 2.19.1.6.gb485710b
