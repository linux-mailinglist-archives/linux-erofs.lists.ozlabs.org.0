Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78680821DCF
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jan 2024 15:38:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4Fpg1nJJz3bnv
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 01:38:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4FpX6cMTz3bPM
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 01:38:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VzqtkGi_1704206314;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzqtkGi_1704206314)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 22:38:35 +0800
Message-ID: <6ac3ff02-6c6f-4723-abd0-d162eab8b8b9@linux.alibaba.com>
Date: Tue, 2 Jan 2024 22:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: make erofs_err() and erofs_info() support NULL sb
 parameter
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240102143745.2880560-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240102143745.2880560-1-guochunhai@vivo.com>
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



On 2024/1/2 22:37, Chunhai Guo wrote:
> Make erofs_err() and erofs_info() support NULL sb parameter for more
> general usage.
> 
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/super.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3789d6224513..96a9d19de96b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -27,7 +27,11 @@ void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
>   	vaf.fmt = fmt;
>   	vaf.va = &args;
>   
> -	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> +	if (sb)
> +		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> +	else
> +		pr_err("%s: %pV", func, &vaf);
> +

redundant line, otherwise looks good to me.

Thanks,
Gao Xiang

>   	va_end(args);
>   }
>   
> @@ -41,7 +45,10 @@ void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
>   	vaf.fmt = fmt;
>   	vaf.va = &args;
>   
> -	pr_info("(device %s): %pV", sb->s_id, &vaf);
> +	if (sb)
> +		pr_info("(device %s): %pV", sb->s_id, &vaf);
> +	else
> +		pr_info("%pV", &vaf);
>   	va_end(args);
>   }
>   
