Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B371F9E1
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 08:08:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXXct3Xk7z3dxj
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 16:08:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXXcp72CMz3cF6
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 16:08:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vk8hd7M_1685686113;
Received: from 30.97.48.207(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk8hd7M_1685686113)
          by smtp.aliyun-inc.com;
          Fri, 02 Jun 2023 14:08:34 +0800
Message-ID: <9712ed04-a5ae-4c1f-7275-405e2e92f083@linux.alibaba.com>
Date: Fri, 2 Jun 2023 14:08:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: limit pclustersize in
 z_erofs_fixup_deduped_fragment()
To: huyue2@coolpad.com
References: <20230602052039.615632-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230602052039.615632-1-asai@sijam.com>
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
Cc: linux-erofs@lists.ozlabs.org, =?UTF-8?B?5a2Z5aOr5p2w?= <sunshijie@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2023/6/2 13:20, Noboru Asai wrote:
> The variable 'ctx->pclustersize' could be larger than max pclustersize.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>

Please take a look at this patch.
+Cc Shijie Sun.

Thanks,
Gao Xiang

> ---
>   lib/compress.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 2e1dfb3..e943056 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -359,8 +359,9 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
>   
>   	/* try to fix again if it gets larger (should be rare) */
>   	if (inode->fragment_size < newsize) {
> -		ctx->pclustersize = roundup(newsize - inode->fragment_size,
> -					    erofs_blksiz());
> +		ctx->pclustersize = min(z_erofs_get_max_pclusterblks(inode) * erofs_blksiz(),
> +					roundup(newsize - inode->fragment_size,
> +						erofs_blksiz()));
>   		return false;
>   	}
>   
