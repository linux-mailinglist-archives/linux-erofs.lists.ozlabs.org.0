Return-Path: <linux-erofs+bounces-3881-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ratPEFeBVGrqmgMAu9opvQ
	(envelope-from <linux-erofs+bounces-3881-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 08:10:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB5747727
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 08:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=GWSKLyhn;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3881-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3881-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzBr241pbz2xlv;
	Mon, 13 Jul 2026 16:10:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783923026;
	cv=none; b=K/2iT11AF30PmrMhyKn/AYak3uu+lAsYmNZf4pPWtppj7Q3wJDzYL7KqVGTt3RNuCSUUYFaraMgJckqi/C2vk6whPhnQkB6sjou5phLqAI+l4lrugMyo+w6Cl+jZmw0qC4IMnQHLhpNqaogsq1GWDiyZPbjUQ9CvGMXiGN1kTcSarxrwEVoPc8ygTDev/Unj6yja9Wc8xEowkz+C/900qmQH2GCwO1Vw5UHkWR3RaCJnsm7St1n4RwEU0ddiZcw0AqkyVNCbiSPpA2A78LLuq0v7v1glMmyv0H+tgXLMZjT3JBFe0mlwMcK9162eDDzwezbg5Iat8AJBAmP7F3f5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783923026; c=relaxed/relaxed;
	bh=1SMTFYvRuB2vL+mgHf0VCkl/61cqdKhN04NrXntKSqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBBrS63yiqkItN0UejYaifdwDGoit5zPnzH7zuT6xARP4X1dC6YPtsq/VGDEs4HoHs4YW6G+neRheGNegGSBRDLEMdxCtsyu/rOC69qyk/g29tj5dKEDtW8cD1LmYdPfQ35rwjCL2ywOLPb6z/Kke1+s3/1oIytu+//JEZkWpddiU43VpWdmI2uL4EIkZuS+VAjbjpjCNgNBg+YCrCH1ou3YHvyR35Jf+pk7z40JS96GFxprdB/d3aEZB9Bvv/JyxiQvs86xIUZrPty7CwHnNf4qNEbU/0zX48DzWcecuIsn6qILm6Z/qLlvtxWP2D4edDTZby9K68Jfo+xbj+kwsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GWSKLyhn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzBr008phz2xjN
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 16:10:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783923019; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1SMTFYvRuB2vL+mgHf0VCkl/61cqdKhN04NrXntKSqA=;
	b=GWSKLyhnSCVE2GIAuUfx58W1VQb7pnt4xwY5a1AMEZ7OGYxTGkvlqFckERA4Q68by4tyopokL8XiuJwAh5GkgFqmvzh6Z5Hb68aj5kTsbaKtRbsW0nX5mKH1T107tSSL/llFpcolq0iASq0ntp9vA3KtltpocydrxhT/0tq0ibo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6u73ps_1783923013;
Received: from 30.221.131.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6u73ps_1783923013 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 14:10:14 +0800
Message-ID: <d8f92099-83b3-4161-9c17-ec97919f41a1@linux.alibaba.com>
Date: Mon, 13 Jul 2026 14:10:13 +0800
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
Subject: Re: [PATCH v2] erofs: cap LZMA stream pool size
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260711143419.2762894-1-michael.bommarito@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260711143419.2762894-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3881-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44BB5747727

Hi Michael,

On 2026/7/11 22:34, Michael Bommarito wrote:
> fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
> pool from num_possible_cpus() or the lzma_streams module parameter, then
> z_erofs_load_lzma_config() preallocates one image-supplied dictionary per
> stream, accepting dictionaries up to 8 MiB.  On high-CPU systems, a small
> EROFS image can pin hundreds of MiB of vmalloc-backed decoder state until
> the erofs module is unloaded.
> 
> Impact: an attacker-supplied EROFS image mounted by the system can pin up
> to 8 MiB times the LZMA stream count of kernel vmalloc memory.
> 
> Bound the LZMA stream pool by a new CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS
> option, default 16.  The default keeps the worst-case preallocated
> dictionary pool at 128 MiB while preserving the existing per-image
> dictionary limit; memory-constrained systems can lower it and large
> servers can raise it.
> 
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2: bound the pool with a Kconfig option
>      (CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS, default 16) instead of a
>      hardcoded 16, per Gao Xiang's review, so memory-constrained and
>      server deployments can size it.  Kept the EROFS_FS_ZIP_ prefix of
>      the sibling options.
> v1: https://lore.kernel.org/linux-erofs/20260710023036.3745254-1-michael.bommarito@gmail.com/
> 
>   fs/erofs/Kconfig             | 20 ++++++++++++++++++++
>   fs/erofs/decompressor_lzma.c |  7 +++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 4789b1077d8ce..3e4731dd03e7c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -131,6 +131,26 @@ config EROFS_FS_ZIP_LZMA
>   
>   	  Say N if you want to disable LZMA compression support.
>   
> +config EROFS_FS_ZIP_LZMA_MAX_STREAMS
> +	int "EROFS LZMA maximum decompression stream pool size"
> +	depends on EROFS_FS_ZIP_LZMA
> +	range 1 1024
> +	default 16
> +	help
> +	  EROFS preallocates a pool of MicroLZMA decoder streams, one per
> +	  possible CPU by default, or as set by the lzma_streams module
> +	  parameter.  Each stream can hold a dictionary of up to 8 MiB taken
> +	  from the mounted image, so on systems with a large number of CPUs a
> +	  single small image can pin a large amount of vmalloc memory until the
> +	  erofs module is unloaded.
> +
> +	  This bounds the number of preallocated streams.  The worst-case
> +	  preallocated dictionary memory is 8 MiB times this value.  Lower it on
> +	  memory-constrained or embedded systems; raise it on large servers that
> +	  decompress many EROFS images in parallel.
> +
> +	  If unsure, keep the default of 16.
> +

Currently z_erofs_lzma_nstrms is exposed as a module parameter
too, I hope if users specify a non-zero "lzma_streams", it won't
be limited to this setting.

So after a second thought, I hope "EROFS_FS_ZIP_LZMA_MAX_STREAMS"
may be called "EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS"?

And I wonder if the description can be simplified and closer to
the end users rather than the internal details.

>   config EROFS_FS_ZIP_DEFLATE
>   	bool "EROFS DEFLATE compressed data support"
>   	depends on EROFS_FS_ZIP
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index f6692d0f2f04d..882684c663f47 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -52,6 +52,13 @@ static int __init z_erofs_lzma_init(void)
>   	/* by default, use # of possible CPUs instead */
>   	if (!z_erofs_lzma_nstrms)
>   		z_erofs_lzma_nstrms = num_possible_cpus();
> +	/*
> +	 * Each stream can pin an 8 MiB image-supplied dictionary, so bound the
> +	 * module-global pool to keep the worst-case preallocation in check on
> +	 * systems with many CPUs (or a large lzma_streams request).
> +	 */

The comment here is unneeded I think since developers can just
check the description of "EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS"
I guess.

Thanks,
Gao Xiang

> +	z_erofs_lzma_nstrms = min_t(unsigned int, z_erofs_lzma_nstrms,
> +				    CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS);
>   
>   	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
>   		struct z_erofs_lzma *strm = kzalloc_obj(*strm);


