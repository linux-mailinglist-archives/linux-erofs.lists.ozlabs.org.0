Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53A822C9E
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 13:04:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4pLW4jc9z3cYv
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 23:04:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4pLS2Ybwz3cVr
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 23:04:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vzu6-Fh_1704283479;
Received: from 30.222.32.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vzu6-Fh_1704283479)
          by smtp.aliyun-inc.com;
          Wed, 03 Jan 2024 20:04:40 +0800
Message-ID: <ceccfc3f-3e0a-4c1f-817f-b89aeeeb06e3@linux.alibaba.com>
Date: Wed, 3 Jan 2024 20:04:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: make erofs_err() and erofs_info() support NULL
 sb parameter
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240103121140.3049732-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240103121140.3049732-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/1/3 20:11, Chunhai Guo wrote:
> Make erofs_err() and erofs_info() support NULL sb parameter for more
> general usage.
> 
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> V2 -> V3: convert pr_err() to erofs_err() in erofs codebase
> V1 -> V2: add erofs_info()
> ---
>   fs/erofs/decompressor_deflate.c |  2 +-
>   fs/erofs/super.c                | 10 ++++++++--
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
> index daf3c1bdeab8..ad3d69eb6fc2 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -70,7 +70,7 @@ int __init z_erofs_deflate_init(void)
>   	return 0;
>   
>   out_failed:
> -	pr_err("failed to allocate zlib workspace\n");
> +	erofs_err(NULL, "failed to allocate zlib workspace\n");

'\n' here needs to be droped.

I will apply this patch later, busying in other stuffs...

Thanks,
Gao Xiang
