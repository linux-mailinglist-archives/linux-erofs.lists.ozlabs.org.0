Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435D9A195F
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 05:40:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTYWN3Ng9z3bjL
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 14:40:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729136410;
	cv=none; b=MoV2G6slWcDlbSvZbS07WQ2isaLqxoaW8S3eaD7hrys9jH29a65UEhwivcYIbwG18xb1R68UPCQM0MSkEl6rBA7CHn+XO7zeRYdmUY/tOpF8yo7sc7JoW5uunWPCLnhXM+nFnJEX7cpAVrZkLCGxV3ZL31lQhBxrK1DhcbEHJ05vsb21VP5OQnEvcL10TFO3brBCBLBfTnhi1VNGdBTckpFvWDvpmsOyflA0msOS7gKvtitzH/BK4/pCJ03kFm5U0Y+boDI8Ne1br9qjO3YcN+ma2+6VXHjO3TkOxdC4yrfwa/iRI1bUm6JN0vSp5b4UXkI7yDggGUwE/nQ8PDT8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729136410; c=relaxed/relaxed;
	bh=BEdFcsWdIAk9ivYlkVbjLUq7w2ocbRx/r+bMp0elD6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvtA8Ou3so3CdsWnxj8KY4vPceKHNpebjSvMyNyn7afozV4do4+Hufzf4uwJu0VZcpV96I7Bt3OO5Xf4QnRd3rC0j0Sl7B7iWdi8bCnuouwJbiTCctXFsgunCT3w7bIgo1PR7cPg2wEH2jvUHSqwbnZW85b99wd8BbPhV67APlXNlHL7Q6uGDXht6jdEJjJ2Et4IiOUjw/ldJvOzbN6gqrN64TZMmRgzDeIzCHzmzO9h9slF7Ohhlv0QhaeilJMHlemwF36GEt5VPc4IWlaqSm6aKM24IfoPKiuCL3H6j7IhN7LdebenkQNxaVNpAN3l+DnDkEobrqrbv/5VcUSyKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dtdFxrdU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dtdFxrdU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTYW81yGNz2yyR
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 14:40:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729136395; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BEdFcsWdIAk9ivYlkVbjLUq7w2ocbRx/r+bMp0elD6k=;
	b=dtdFxrdUsINW/5mDySBV3oUgaSH+/08jyIULowecDyS9KbTL+NmKldviz/qZNFBIgeA0LOamrs+CU/LPhwirjLZP1J1kDU8seOtUyYQZycoGm3Bi9jswhu8p2i177asXHn7wAQ1xVIlIHj8ux94vCtyZhXEXO/qSIGOsNzgKAzI=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHJR1ca_1729136393 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 11:39:54 +0800
Message-ID: <e5843bc0-4157-4bbb-908d-2997e95e6007@linux.alibaba.com>
Date: Thu, 17 Oct 2024 11:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: using macro instead of definition of log
 functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
References: <20241016152430.3456-1-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241016152430.3456-1-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: gouhaojake@163.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hao,

On 2024/10/16 23:24, Gou Hao wrote:
> No functional change intended.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>   fs/erofs/super.c | 51 ++++++++++++++++++------------------------------
>   1 file changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 666873f745da..b04f888c8123 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -18,39 +18,26 @@
>   
>   static struct kmem_cache *erofs_inode_cachep __read_mostly;
>   
> -void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	if (sb)
> -		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> -	else
> -		pr_err("%s: %pV", func, &vaf);
> -	va_end(args);
> -}
> -
> -void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> +#define _erofs_log_def(name) \
> +	void _erofs_##name(struct super_block *sb, const char *func, const char *fmt, ...) \
> +	{ \
> +		struct va_format vaf; \
> +		va_list args; \
> +		\
> +		va_start(args, (fmt)); \
> +		\
> +		vaf.fmt = (fmt); \
> +		vaf.va = &args; \
> +		\
> +		if ((sb)) \
> +			pr_##name("(device %s): %s: %pV", (sb)->s_id, (func), &vaf); \
> +		else \
> +			pr_##name("%s: %pV", (func), &vaf); \
> +		va_end(args); \
> +	}

Thanks for the patch!

Although code simplicity is quite important for EROFS, but
I'm not sure introducing unnecessary macro definitions (which
can be avoided) is better for code readability.

I wonder if we can put this into another way, like the current
_btrfs_printk() and _f2fs_printk() if we really need to work
on this.

Thanks,
Gao Xiang
