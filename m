Return-Path: <linux-erofs+bounces-683-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C981B0BA97
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 04:25:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blkkq1sd3z2yFQ;
	Mon, 21 Jul 2025 12:25:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753064707;
	cv=none; b=BZIgMZFV8vaIIr3B542KCZ+HnLKye6qSo8tB+yFTCSsgZhWUGhM2NqzlegNsUMoFmrcZw51WuDdhdSbNGR/HaWWI11389wDcw9Mclx7LfL3NFjFmc1n7TAmEWeIefUM9eJeKN7E7ynGB3aC2ky0x6pBThb105bBBlYGk1M+OPvZm/y1E+bvZw8hsgXdycwWIEGPpkiv165PIoJqUaDsI2cjnEHIkJ9e9sVLMimSnmONwXktk2+bzeKgSvlIf/oO9gQRc+mmGNMpoPin0tBwlRVACYkINME5r7HnwaoPzfkz7pzDNzQfasOeair/8SOueWEQyIcYpDVvme0GXKcLy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753064707; c=relaxed/relaxed;
	bh=yrQVfN36myljSGt7KhTp+J0XIr4q1ZCI43iHYtn5FWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpfEAiOtk5B6w5O6atwLTKo6dWDgjpFxItOOG+H2MdfLrTKNVka6IquGxWGBczm3gVetn9fV8aTGpqqzcavaU+jWJZWoycdaOxFAYao2njnBxv6p35NRQsdour+ysOpaBXwsIRNl83OgS0Mu2LDH6y7IfTAfAHMEaRxFuZOLQ05gDlG/sxeRkJwiywt6dWynaSvHKiJx5n/peFtQWb1sqOUUI/bAr0J48Vzc82QXue7IDxUUBn+YS0bTypS7vvmn4Jx9B71bpL2SwV7jCozpQQP3NfuzPchiyYYN1e0y6q/PWM7Pa33oYICnNGMjvkThP7EYV6S/hh7VaCRyoe/MAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MM//zVY5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MM//zVY5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blkkn4RY5z2yFP
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 12:25:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753064700; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yrQVfN36myljSGt7KhTp+J0XIr4q1ZCI43iHYtn5FWY=;
	b=MM//zVY5uU2FigqYnfypZ33Vjykf0nQW+J6GFA45hAjSJT37HZDjAl7WTzGVkMj5DI3+4NdIsoHP7DgvDf5x5JufBJA3zIkpv2zGpQewbhkfaiqVL0ab8cvr57mBuJwzFFOBznpVE4ePMucBkpDpXJyugqN4APFkO8QghxRKLYY=
Received: from 30.221.132.193(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjIW.Ah_1753064697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 10:24:58 +0800
Message-ID: <085b2e3f-223f-4867-9fac-99cf7cb2fa21@linux.alibaba.com>
Date: Mon, 21 Jul 2025 10:24:54 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250721021352.2495371-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250721021352.2495371-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/21 10:13, Chao Yu wrote:
> This patch supports to readahead more blocks in erofs_readdir(), it can
> enhance readdir performance in large direcotry.
> 
> readdir test in a large directory which contains 12000 sub-files.
> 
> 		files_per_second
> Before:		926385.54
> After:		2380435.562
> 
> Meanwhile, let's introduces a new sysfs entry to control readahead
> bytes to provide more flexible policy for readahead of readdir().
> - location: /sys/fs/erofs/<disk>/dir_ra_bytes
> - default value: 16384
> - disable readahead: set the value to 0
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - clean up codes and comments
>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>   fs/erofs/dir.c                           | 14 ++++++++++++++
>   fs/erofs/internal.h                      |  4 ++++
>   fs/erofs/super.c                         |  2 ++
>   fs/erofs/sysfs.c                         |  2 ++
>   5 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index bf3b6299c15e..85fa56ca092c 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -35,3 +35,11 @@ Description:	Used to set or show hardware accelerators in effect
>   		and multiple accelerators are separated by '\n'.
>   		Supported accelerator(s): qat_deflate.
>   		Disable all accelerators with an empty string (echo > accel).
> +
> +What:		/sys/fs/erofs/<disk>/dir_ra_bytes
> +Date:		July 2025
> +Contact:	"Chao Yu" <chao@kernel.org>
> +Description:	Used to set or show readahead bytes during readdir(), by
> +		default the value is 16384.
> +
> +		- 0: disable readahead.
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 3e4b38bec0aa..99745c272b60 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -47,8 +47,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   	struct inode *dir = file_inode(f);
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct super_block *sb = dir->i_sb;
> +	struct file_ra_state *ra = &f->f_ra;
>   	unsigned long bsz = sb->s_blocksize;
>   	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
> +	pgoff_t ra_pages = DIV_ROUND_UP_POW2(
> +			EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
> +	pgoff_t nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>   	int err = 0;
>   	bool initial = true;
>   
> @@ -63,6 +67,16 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			break;
>   		}
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (ra_pages) {
> +			pgoff_t idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);

Can we use DIV_ROUND_UP_POW2 here too? If it's okay,
I will update the patch manually when applied.

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

