Return-Path: <linux-erofs+bounces-1817-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CADD106B0
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 04:10:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqHS53LGcz2yrb;
	Mon, 12 Jan 2026 14:10:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768187413;
	cv=none; b=Wh9JXGIXAtFpbHmtXimD86vsk1W/eUKeklwwg23eDCQ03s+X1z0bDhHZoakpzfH7GTnPBN9CdWC25aCj22QymRmNiMzNLFzbXiIf9tyfvXQ1rDcgBsS9fujnntP9fYCyBRZZJVgK+CNDy8AYBofJ4jEk84aRglcpOgUqzFMwWlv+Dos91ec2hTw3jvdDarGddB8v6gCtfv3w7q+DB8/nbcK62YPlupMErNJye1FEBD6n8l2J+o6qarFXjR+RAuiP731bXQvuV5T76GsSHnwZupbgsKvCtp9waD+Ai6qj/PT1Lzia96zQQd/H99fMT40wZOmN/w8axVQNyG9VXVUbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768187413; c=relaxed/relaxed;
	bh=xyPpPyDqNvqSCE+WxYdnUHNsDCGIo6dtiHQxTlIgmLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TO8k171h8gQA4FH3wvJki9mbmibBUUTEIWV7eKddjaYmwARiumfKfxR8Pu075B8peNynVp6a30BhQeuG2jkzxxdB8LaopdRIsX97Co4ChT245+kXJ8ZQ6zMPXlOMfoJ0nqEJk/HaS8Tkhbp75a7cgbH7vqbakUkVLtGPLhXzcz0/QCd2NCvjMx93Gy/PcpFKpMrWjVv+doDa5Wg72HDPVuAV6ZbmqzVPCGxh8/mnsTSPE+t+fPB053vgGS2rkj6HBXb00q57SaqpaZqmW2U7J0v2So3Px03yl0MEzOU/vreHHXrnXmgDBWWStUsDS34yCkyoaiw5gMyZbGqwe8l2DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VmIw+dqE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VmIw+dqE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqHS25hncz2yrS
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 14:10:09 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768187405; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xyPpPyDqNvqSCE+WxYdnUHNsDCGIo6dtiHQxTlIgmLI=;
	b=VmIw+dqE0pF8wC90gkAwqqJQGJtd0RpUr/UkJgeRMnWSUz2XsT9/gz5StG3obNsDliVyUfTSIbg6Z9PyAQtzZ/HvKATW+Tbvw7Hya98H+PcqupG58IT3L4QiOWr/yhDZk65wwZ1NAfpFDvKtFOFYV8Q2x/gO5cWd4cXwgk6dzKs=
Received: from 30.221.133.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwnqFV8_1768187402 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 11:10:03 +0800
Message-ID: <4808564e-e69d-4509-8c04-e1810eef0f90@linux.alibaba.com>
Date: Mon, 12 Jan 2026 11:10:02 +0800
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
Subject: Re: [PATCH v1] erofs-utils: lib: oci: support auto-detecting host
 platform
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
References: <20260110082732.61528-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260110082732.61528-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

On 2026/1/10 16:27, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Currently, the platform is hard-coded to "linux/amd64" if not specified.
> This patch introduces `ocierofs_get_platform_spec` helper to detect the
> host platform (OS and architecture) at compile time.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/remotes/oci.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index c8711ea..911abd5 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -1089,13 +1089,55 @@ static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
>   	return 0;
>   }
>   
> +static char *ocierofs_get_platform_spec(void)
> +{
> +#if defined(__linux__)
> +	const char *os = "linux";
> +#elif defined(__APPLE__)
> +	const char *os = "darwin";
> +#elif defined(_WIN32)
> +	const char *os = "windows";
> +#elif defined(__FreeBSD__)
> +	const char *os = "freebsd";
> +#else

Is there an unknown os annotation or we should just error out?

> +	const char *os = "linux";
> +#endif

I think it would be better to rearrange it as:
	const char *os, *platform;


#if defined(__linux__)
	os = "linux";
#elif defined(__APPLE__)
	os = "darwin"
#elif ...
#else
	return -EOPNOTSUPP;
#endif

> +
> +#if defined(__x86_64__) || defined(__amd64__)
> +	const char *arch = "amd64";
> +#elif defined(__aarch64__) || defined(__arm64__)
> +	const char *arch = "arm64";
> +#elif defined(__i386__)
> +	const char *arch = "386";
> +#elif defined(__arm__)
> +	const char *arch = "arm";
> +#elif defined(__riscv) && (__riscv_xlen == 64)
> +	const char *arch = "riscv64";
> +#elif defined(__ppc64__)
> +#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
> +	const char *arch = "ppc64le";
> +#else
> +	const char *arch = "ppc64";
> +#endif
> +#elif defined(__s390x__)
> +	const char *arch = "s390x";
> +#else
> +	const char *arch = "amd64";

Same here and
Is there an unknown platform annotation or we should just error out?

Thanks,
Gao Xiang


