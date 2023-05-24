Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F371470F47D
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 12:46:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QR7Bw5zBQz3f67
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 20:46:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QR7Br49Tqz3c7S
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 20:45:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjNqNUm_1684925148;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjNqNUm_1684925148)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 18:45:49 +0800
Message-ID: <4056d17c-6cdf-0248-b36f-1fbb7a3685e8@linux.alibaba.com>
Date: Wed, 24 May 2023 18:45:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: remove end parameter from
 z_erofs_pcluster_readmore()
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230524101305.22105-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230524101305.22105-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/24 03:13, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The `end` argument is pointless if it's not backmost.  And we already
> have `headoffset` in struct `*f`, so let's use this offset to get the
> `end` for backmost only instead in this function.
> 
> Also, remove linux/prefetch.h since it's not used anymore after commit
> 386292919c25 ("erofs: introduce readmore decompression strategy").
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> --->   fs/erofs/zdata.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5cd971bcf95e..b7ebdc8f2135 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2022 Alibaba Cloud
>    */
>   #include "compress.h"
> -#include <linux/prefetch.h>
>   #include <linux/psi.h>
>   #include <linux/cpuhotplug.h>
>   #include <trace/events/erofs.h>
> @@ -1825,16 +1824,16 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
>    */
>   static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>   				      struct readahead_control *rac,
> -				      erofs_off_t end,
> -				      struct page **pagepool,
> -				      bool backmost)
> +				      struct page **pagepool, bool backmost)
>   {
>   	struct inode *inode = f->inode;
>   	struct erofs_map_blocks *map = &f->map;
> -	erofs_off_t cur;
> +	erofs_off_t cur, end;
>   	int err;
>   
>   	if (backmost) {
> +		end = f->headoffset +
> +		      rac ? readahead_length(rac) : PAGE_SIZE - 1;

		could we avoid "?:" here for readability?

Thanks,
Gao Xiang
