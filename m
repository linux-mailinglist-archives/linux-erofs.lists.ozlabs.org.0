Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDF39A196A
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 05:42:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTYYj6Vrgz3bjb
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 14:42:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729136536;
	cv=none; b=eo+wwNktaNPCIhxJVS4a7QaUS/5pR3gimXo/28JA98h0TT2lUGnOKx1XAgUiPwiwIT1t6umYiTs6t6PE52S5Pxf8qgzuJxQHTt9HW9RHQFrNPQYFqC24/yPBgSGf9BALr4rx9nrNebaxailCs++iJvPfs1bSaRBCJrV5wQ30H0lPnZtAyeDHMuiPpXHtfpQX54HqkaEHK+3XgpgaEGyH7J93ZI5LAbHMN4+nPzjMk4GAZJDhdP5dmBCXhI+11lGP1K9I75E1mDMzFMGIPOBVgEbgtVcfGCzPTn9T7dHqwHTiwhxDztPZoYQjJB1HsgTbsWnJVlEMfl4/KwOJ7CUOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729136536; c=relaxed/relaxed;
	bh=DA4Z1yCinxSZ8HRe2Rh9XoWLg0ulprtNnoYyidfLapE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2FmRhJG2pL82qf6BTYQdn9DioqJo1J3sOTNP9JlyZFcfb/Z1wMyYOBj2B2SDlJ0ShFTbF9H0EtYGznqczZRCVJE2XxJ8Ur7haJkfHB2hGnxe47HZi/A10o2CWlaVlmk2X+z6l1cLVay+KPAXq2dtZggB2t7qh6J4x5Z5+LYSGlMV0MIT3q+rbMcWm04krrqE1QOjJN0jMkjsAazKd5Zt4aREgcnLhYXTpzBjidYsM33SNuEok8YiIguiZ/UAgzp3dZCyiHn8nlXEVk9PmZyXV9IH90UItbHMNei66tanC0GJBPQxe/atDnip+D0NMi+9CvTiHClOW9lR2NnDce20Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FfgH/GHk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FfgH/GHk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTYYg1Qqjz2yZ7
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 14:42:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729136531; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DA4Z1yCinxSZ8HRe2Rh9XoWLg0ulprtNnoYyidfLapE=;
	b=FfgH/GHkeoY7/C9ggrhYaYXv5rDDHLUUBXteWf1PahPSrg3gL2TJ/domVFfhyNkEyoE/VmrJXai7+s9nNAAz38wUGQ3MeKHrBjA5o9i+cJlNHuOQY5eMJf18uPz2/B877jYik0SNn2rZ5XDCUHU6Pa3kbWC7EeEOTOGsidI0U5s=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHJGx75_1729136529 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 11:42:09 +0800
Message-ID: <714b8a53-587f-4cee-bff7-330cf0b32f7f@linux.alibaba.com>
Date: Thu, 17 Oct 2024 11:42:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: simplify declaration of the log functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
References: <20241016152430.3456-1-gouhao@uniontech.com>
 <20241016152430.3456-2-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241016152430.3456-2-gouhao@uniontech.com>
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



On 2024/10/16 23:24, Gou Hao wrote:
> remove the macro of the log declarations.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>   fs/erofs/internal.h | 13 +++++--------
>   fs/erofs/super.c    | 12 ++++++------
>   2 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..0c3d6b9f85b5 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -24,14 +24,11 @@
>   #undef pr_fmt
>   #define pr_fmt(fmt) "erofs: " fmt
>   
> -__printf(3, 4) void _erofs_err(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> -#define erofs_err(sb, fmt, ...)	\
> -	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
> -__printf(3, 4) void _erofs_info(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> -#define erofs_info(sb, fmt, ...) \
> -	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
> +#define erofs_log_declare(name) \
> +	__printf(2, 3) void erofs_##name(struct super_block *sb, const char *fmt, ...)
> +erofs_log_declare(err);
> +erofs_log_declare(info);

I guess it will make the code harder to read IMHO..

Thanks,
Gao Xiang
