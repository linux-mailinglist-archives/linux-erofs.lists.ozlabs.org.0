Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A710269940E
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Feb 2023 13:14:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHYm417mwz3ch3
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Feb 2023 23:14:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHYly3w0Dz2yHT
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Feb 2023 23:14:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VbogEOy_1676549672;
Received: from 30.221.132.175(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbogEOy_1676549672)
          by smtp.aliyun-inc.com;
          Thu, 16 Feb 2023 20:14:33 +0800
Message-ID: <cb4fb277-0e11-290c-14ed-d5ea22b38b71@linux.alibaba.com>
Date: Thu, 16 Feb 2023 20:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: fix an error code in z_erofs_init_zip_subsystem()
To: Dan Carpenter <error27@gmail.com>, Sandeep Dhavale <dhavale@google.com>
References: <Y+4d0FRsUq8jPoOu@kili>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y+4d0FRsUq8jPoOu@kili>
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>, kernel-janitors@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/2/16 20:13, Dan Carpenter wrote:
> Return -ENOMEM if alloc_workqueue() fails.  Don't return success.
> 
> Fixes: d8a650adf429 ("erofs: add per-cpu threads for decompression as an option")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/zdata.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8ea3f5fe985e..3247d2422bea 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -475,8 +475,10 @@ int __init z_erofs_init_zip_subsystem(void)
>   
>   	z_erofs_workqueue = alloc_workqueue("erofs_worker",
>   			WQ_UNBOUND | WQ_HIGHPRI, num_possible_cpus());
> -	if (!z_erofs_workqueue)
> +	if (!z_erofs_workqueue) {
> +		err = -ENOMEM;
>   		goto out_error_workqueue_init;
> +	}
>   
>   	err = erofs_init_percpu_workers();
>   	if (err)
