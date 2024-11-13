Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F89C773E
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 16:33:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XpS3G4H9Nz2yl1
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 02:32:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731511976;
	cv=none; b=IKbTeLfLgolfH2jdk/05VJyJmxZFvHDQeHZFp47oCqvLKVcfiwO7jdTxg2NX2W3OxZWKI0/f+SJE5qs+55Ik1jBuHqHEGVvhZZ1qQDhA8aekzyCpQ3VFmrv3VQfn9BEt4Vks4jRcdt90+tvfGlWG8zvSOgLzA12WpbMlHCmR8HV0THtocOYdsBxkVUJ2Y1PvFimQoPcjn3tSDR2Tg2qcMvCMIgxo14lklMbRamDxID6UZiR5DwLnyQn3GpERE54lUU9FkGsdVk/r+kXtj73Ni2bXXc0pvRKJUqhKtYChIGpkaYxIKZG1cI/WYQ9szTR7JAAOF7pLUTZyt63ymw/3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731511976; c=relaxed/relaxed;
	bh=/WHU0tdWENVTU/cnY0uG1dijHbWIyDoyf3RBtytkpss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAmvExsvPV+//3P2AcI0uItBh6VwVFXQO89H57v01UXG56AOkCQLz1Z+sCm/RZM2HA2/wuWxB3VxXhNihNsIqJeJM198WGneeSlKvLir80Dc6MfXWwHeWDLvNQDboHU7iGkSr8y5M01bCCY/lE4XXEI24rHtXxxSP4TfF5KiRo0zs+RafgKkXLl2YDykswZPhk9rupBmf7ZmJXg8vHYzfPzYFVaIQEoSdp9VM/tRTG4vQT97zIPiy2Uk/GuhjbUEQwTdJedjWf+5tkgPZijYeOVVyXLpb1AhL0gSjXepeCR8upufLgn6d8S1frrUx/BnjJ6SDYGkVXE+8QhBp2zZtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bx4ucKE1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bx4ucKE1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XpS38440Zz2yGs
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 02:32:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731511961; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/WHU0tdWENVTU/cnY0uG1dijHbWIyDoyf3RBtytkpss=;
	b=bx4ucKE1W4PkdIJSre82gjZtxUMEKpJ29/bWGM3DP1kEuYZ6cNC6EmpJu3+etQdD/w2Hs0ZR/ABkPFijtxqUQ4PAVp5ftARAsic7BJhWp6zVxFhom4DH+lSYO4NhJRj4dToapfZNYy/Tt7Q0GCfksVNawNq2bdA/v4cbZasz3Uc=
Received: from 192.168.88.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJLUVIG_1731511958 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 23:32:38 +0800
Message-ID: <63a68526-3f21-4ef8-a782-74dc4f428272@linux.alibaba.com>
Date: Wed, 13 Nov 2024 23:32:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] erofs: simplify definition of the log functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
References: <20241113144128.16007-1-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241113144128.16007-1-gouhao@uniontech.com>
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



On 2024/11/13 22:41, Gou Hao wrote:
> Use printk instead of pr_info/err to reduce
> redundant code.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>   fs/erofs/internal.h | 14 ++++----------
>   fs/erofs/super.c    | 28 +++++++---------------------
>   2 files changed, 11 insertions(+), 31 deletions(-)
> 
> Changes:
> V2:
> - remove 'const char  *function' from _erofs_printk
> - remove pr_fmt macro, put 'erofs' prefix into printk
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..116c82588661 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -20,18 +20,12 @@
>   #include <linux/iomap.h>
>   #include "erofs_fs.h"
>   
> -/* redefine pr_fmt "erofs: " */
> -#undef pr_fmt
> -#define pr_fmt(fmt) "erofs: " fmt
> -
> -__printf(3, 4) void _erofs_err(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> +__printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
>   #define erofs_err(sb, fmt, ...)	\
> -	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
> -__printf(3, 4) void _erofs_info(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> +	_erofs_printk(sb, KERN_ERR fmt "\n", ##__VA_ARGS__)
>   #define erofs_info(sb, fmt, ...) \
> -	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
> +	_erofs_printk(sb, KERN_INFO fmt "\n", ##__VA_ARGS__)
> +
>   #ifdef CONFIG_EROFS_FS_DEBUG
>   #define DBG_BUGON               BUG_ON
>   #else
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 666873f745da..93b44b77a41c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -18,37 +18,23 @@
>   
>   static struct kmem_cache *erofs_inode_cachep __read_mostly;
>   
> -void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
> +void _erofs_printk(struct super_block *sb, const char *fmt, ...)
>   {
>   	struct va_format vaf;
>   	va_list args;
> +	int level;
>   
>   	va_start(args, fmt);
>   
> -	vaf.fmt = fmt;
> +	level = printk_get_level(fmt);
> +	vaf.fmt = printk_skip_level(fmt);
>   	vaf.va = &args;
>   
>   	if (sb)
> -		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> +		printk("%c%cerofs: (device %s): %pV",

		printk("%c%cerofs (device %s): %pV",

is preferred.

Otherwise it looks good to me.

Thanks,
Gao Xiang
