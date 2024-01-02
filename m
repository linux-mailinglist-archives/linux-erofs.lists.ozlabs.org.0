Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0A821E62
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jan 2024 16:10:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4GW514Nnz3bn6
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 02:10:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4GVx5Y70z2xQ7
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 02:10:15 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vzqx7a8_1704208210;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vzqx7a8_1704208210)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 23:10:11 +0800
Message-ID: <759b1080-1a1c-4eb8-b2f2-cec303ebda7d@linux.alibaba.com>
Date: Tue, 2 Jan 2024 23:10:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: make erofs_err() and erofs_info() support NULL
 sb parameter
Content-Language: en-US
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240102150158.2886981-1-guochunhai@vivo.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240102150158.2886981-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Chunhai,

Thanks for the commit.

On 1/2/24 11:01 PM, Chunhai Guo wrote:
> Make erofs_err() and erofs_info() support NULL sb parameter for more
> general usage.
> 
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>  fs/erofs/super.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3789d6224513..5f60f163bd56 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -27,7 +27,10 @@ void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> +	if (sb)
> +		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> +	else
> +		pr_err("%s: %pV", func, &vaf);
>  	va_end(args);
>  }
>  
> @@ -41,7 +44,10 @@ void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	pr_info("(device %s): %pV", sb->s_id, &vaf);
> +	if (sb)
> +		pr_info("(device %s): %pV", sb->s_id, &vaf);
> +	else
> +		pr_info("%pV", &vaf);
>  	va_end(args);
>  }
>  

May I ask in which case the input sb parameter will be NULL?  In that
case, why don't we call pr_err() or pr_info() directly?

-- 
Thanks,
Jingbo
