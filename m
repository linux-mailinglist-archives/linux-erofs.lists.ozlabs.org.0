Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0388173D
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Mar 2024 19:16:57 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Eb6/KwtW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0GyG5xZnz3vZ4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 05:16:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Eb6/KwtW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0Gy765x2z3vY6
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 05:16:45 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1def142ae7bso636735ad.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 20 Mar 2024 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710958602; x=1711563402; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jISY2bXNYjG0kUwbJio4yu9/aDqzP7fp7HEKrLZntiQ=;
        b=Eb6/KwtW+aZ7731P2dXEWt7Mc4gIovuZtsHNkYTkolNj/SlVyH17rj0hdjXeuVf0U0
         /GoMUKxOKgYxppG1DgCtIa7GCL/PlrSw1LGsr82EfuNJ74RHTrKObCzv8J6KGSXOfS2K
         3zoSGGnb2RyumaMsuUU+FQwFSz1Pwj1xEX3ejA9whdFM4KG0HzqCK/CePPvEF0uW0coH
         jrCDArKbPoyWbFibEyZ033JSxVCLblNh+4TEcgppHy4cKwQVwmXd+oHEpHvT+vf+wJTb
         GJl9F3K3JhJtXcsmQYTHP6lzXjshCLCRhKyTICHCeZJ1x54lHO5wnV1ewNzSuB65Itc7
         UGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710958602; x=1711563402;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jISY2bXNYjG0kUwbJio4yu9/aDqzP7fp7HEKrLZntiQ=;
        b=RKHHbYo2a544WTRAItBLVQ1za0zDAWgyDz3/flpibJXmp0WTJmQab+WrwSXE/uxj0z
         yd5afwh+o9A/DrEBteuG664NpNmzZpJJceTr/OjlmnyGdpAKMu976yCif/Sk9lU5s/Al
         cO6JbwyaT5nnVD05FOJO1PamQESzQDkd+0eS1uMhFVae0n+IvCojJnQeOqeodNkkm/kN
         9dYjcdTEqMEj3bzFY+Mywi4C1Q7IVmpBlqykZ8jgKJEwp7ZzCMyblxtGq7xw9Xz9nMxf
         Xu/wSgADlIr80RoDBz5M2UuPWRi/Arsmw3hT4HAZ875YCydLoIMqnD2SRklqV3ALo3T9
         w9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnv4yzkG63m8uZIxVL8T09oxXjD0a0w9PBTEDT3gXRzOlj4t0MBn4nnw9W8+1pr+hMqiG2RcG1ephukkYzUXfYh25+jFXRa9yKQYXI
X-Gm-Message-State: AOJu0YxMr0SvDZdWMxRRCsDxaPiYpbq6URAUXt3i4RUzI0KufWt18ZDy
	h80gniyMgXNG/I1O4AwouS2m2RODlsNiCdoPnMXVcOSdCjOAZjHj
X-Google-Smtp-Source: AGHT+IFSiKUobPrI7wuGAQbcGSejF1YIg82GzAnyQZ+UKxdTDtSVcio5aw7AXiIbHHBl714A0IN5rA==
X-Received: by 2002:a17:902:ea0c:b0:1de:ec0f:2ec7 with SMTP id s12-20020a170902ea0c00b001deec0f2ec7mr20325313plg.6.1710958602368;
        Wed, 20 Mar 2024 11:16:42 -0700 (PDT)
Received: from [127.0.0.1] (awork111158.netvigator.com. [203.198.94.158])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b001db9c3d6506sm14144191plb.209.2024.03.20.11.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 11:16:42 -0700 (PDT)
Message-ID: <1c82cf0e-be69-4480-ba13-744d4ddf9251@gmail.com>
Date: Thu, 21 Mar 2024 02:15:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v7 2/5] erofs-utils: add a helper to get available
 processors
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
 <20240315011019.610442-2-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240315011019.610442-2-hsiangkao@linux.alibaba.com>
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/3/15 9:10, Gao Xiang wrote:

> In order to prepare for multi-threaded decompression.

multi-threaded compression.

Thanks,
Jianan

> Signed-off-by: Yifan Zhao<zhaoyifan@sjtu.edu.cn>
> Signed-off-by: Gao Xiang<hsiangkao@linux.alibaba.com>
> ---
>   configure.ac           |  1 +
>   include/erofs/config.h |  1 +
>   lib/config.c           | 12 ++++++++++++
>   3 files changed, 14 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 3ccd6bb..2e69260 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -256,6 +256,7 @@ AC_CHECK_FUNCS(m4_flatten([
>   	strerror
>   	strrchr
>   	strtoull
> +	sysconf
>   	tmpfile64
>   	utimensat]))
>   
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index eecf575..73e3ac2 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -109,6 +109,7 @@ static inline int erofs_selabel_open(const char *file_contexts)
>   
>   void erofs_update_progressinfo(const char *fmt, ...);
>   char *erofs_trim_for_progressinfo(const char *str, int placeholder);
> +unsigned int erofs_get_available_processors(void);
>   
>   #ifdef __cplusplus
>   }
> diff --git a/lib/config.c b/lib/config.c
> index 1096cd1..947a183 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -14,6 +14,9 @@
>   #ifdef HAVE_SYS_IOCTL_H
>   #include <sys/ioctl.h>
>   #endif
> +#ifdef HAVE_UNISTD_H
> +#include <unistd.h>
> +#endif
>   
>   struct erofs_configure cfg;
>   struct erofs_sb_info sbi;
> @@ -177,3 +180,12 @@ void erofs_update_progressinfo(const char *fmt, ...)
>   	fputs(msg, stdout);
>   	fputc('\n', stdout);
>   }
> +
> +unsigned int erofs_get_available_processors(void)
> +{
> +#if defined(HAVE_UNISTD_H) && defined(HAVE_SYSCONF)
> +	return sysconf(_SC_NPROCESSORS_ONLN);
> +#else
> +	return 0;
> +#endif
> +}
