Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B740877C
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 10:49:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7KsY21gJz2yKG
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 18:49:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7KsQ0t5jz2xtT
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 18:49:06 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R621e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UoBPA7m_1631522925; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UoBPA7m_1631522925) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 13 Sep 2021 16:48:47 +0800
Date: Mon, 13 Sep 2021 16:48:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: fix compacted_{4b_initial, 2b} when
 compacted_4b_initial > totalidx
Message-ID: <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
References: <20210913072405.1128-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913072405.1128-1-zbestahu@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, zbestahu@163.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Mon, Sep 13, 2021 at 03:24:05PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
> compacted_4b_initial > totalidx, kernel should be aligned with it
> accordingly.

There is no difference between compacted_4b_initial or compacted_4b_end
for compacted 4B. Since in this way totalidx for compact 2B won't larger
than 16 (number of lclusters in a compacted 2B pack.)

So it can be handled in either compacted_4b_initial or compacted_4b_end
cases, because there are all compacted 4B.

Thanks,
Gao Xiang

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/erofs/zmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 9fb98d8..4f941b6 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -369,7 +369,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	if (compacted_4b_initial == 32 / 4)
>  		compacted_4b_initial = 0;
>  
> -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> +	if (compacted_4b_initial > totalidx) {
> +		compacted_4b_initial = 0;
> +		compacted_2b = 0;
> +	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
>  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
>  	else
>  		compacted_2b = 0;
> -- 
> 1.9.1
