Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A526E4034
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 08:53:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q0HnL57kZz3cM6
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 16:53:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q0HnH2Hg2z3bWC
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 16:53:06 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgELZVh_1681714379;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgELZVh_1681714379)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 14:53:00 +0800
Message-ID: <26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
Date: Mon, 17 Apr 2023 14:52:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
To: Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20230417064136.5890-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230417064136.5890-1-zbestahu@gmail.com>
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



On 2023/4/17 14:41, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The icur field is only used in z_erofs_try_inplace_io(). Let's just use
> a local variable instead. And no need to check if the pcluster is inline
> when setting icur since inline page cannot be used for inplace I/O.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Nope, it's a behavior change.
Other users could feed more inplace I/O pages before I/O submission
to reduce memory consumption, it's common when applying stress model
in low memory scenarios.

Thanks,
Gao Xiang

> ---
>   fs/erofs/zdata.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index f759152feffa..f8bf2b227942 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -554,9 +554,6 @@ struct z_erofs_decompress_frontend {
>   	/* used for applying cache strategy on the fly */
>   	bool backmost;
>   	erofs_off_t headoffset;
> -
> -	/* a pointer used to pick up inplace I/O pages */
> -	unsigned int icur;
>   };
>   
>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
> @@ -707,11 +704,13 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
>   				   struct z_erofs_bvec *bvec)
>   {
>   	struct z_erofs_pcluster *const pcl = fe->pcl;
> +	/* file-backed online pages are traversed in reverse order */
> +	unsigned int icur = pcl->pclusterpages;
>   
> -	while (fe->icur > 0) {
> -		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> +	while (icur > 0) {
> +		if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
>   			     NULL, bvec->page)) {
> -			pcl->compressed_bvecs[fe->icur] = *bvec;
> +			pcl->compressed_bvecs[icur] = *bvec;
>   			return true;
>   		}
>   	}
> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>   	}
>   	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>   				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
> -	/* since file-backed online pages are traversed in reverse order */
> -	fe->icur = z_erofs_pclusterpages(fe->pcl);
>   	return 0;
>   }
>   
