Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE636619419
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 11:04:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N3bnP4MkKz3cMx
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 21:04:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N3bnK2kwDz3cF6
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Nov 2022 21:04:04 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTwZ0f5_1667556238;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTwZ0f5_1667556238)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 18:04:00 +0800
Date: Fri, 4 Nov 2022 18:03:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: get correct count for unmapped range in
 fscache mode
Message-ID: <Y2TjjsZFNYp66sNJ@B-P7TQMD6M-0146.local>
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104054028.52208-3-jefflexu@linux.alibaba.com>
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

On Fri, Nov 04, 2022 at 01:40:28PM +0800, Jingbo Xu wrote:
> For unmapped range, the returned map.m_llen is zero, and thus the
> calculated count is unexpected zero.
> 
> Prior to the refactoring introduced by commit 1ae9470c3e14 ("erofs:
> clean up .read_folio() and .readahead() in fscache mode"), only the
> readahead routine suffers from this. With the refactoring of making
> .read_folio() and .readahead() calling one common routine, both
> read_folio and readahead have this issue now.
> 
> Fix this by calculating count separately in unmapped condition.
> 
> Fixes: c665b394b9e8 ("erofs: implement fscache-based data readahead")
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/fscache.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 83559008bfa8..260fa4737fc0 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -296,15 +296,16 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>  		return PAGE_SIZE;
>  	}
>  
> -	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
> -	DBG_BUGON(!count || count % PAGE_SIZE);
> -
>  	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		count = len;
>  		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
>  		iov_iter_zero(count, &iter);
>  		return count;
>  	}
>  
> +	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
> +	DBG_BUGON(!count || count % PAGE_SIZE);
> +
>  	mdev = (struct erofs_map_dev) {
>  		.m_deviceid = map.m_deviceid,
>  		.m_pa = map.m_pa,
> -- 
> 2.19.1.6.gb485710b
