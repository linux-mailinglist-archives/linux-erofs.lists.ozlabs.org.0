Return-Path: <linux-erofs+bounces-647-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6432B08285
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 03:40:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjFwh259qz2yF1;
	Thu, 17 Jul 2025 11:40:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752716404;
	cv=none; b=eQhPxpMl97x+ApG0cowxb+mjYHn6qutgSGJ7T/gT9kcahwGf1tmpqvsjMpLlOvn5QXmbbPZIuryqAwl46YRgRGJBfWNMxFS9Z9vS7ng0BD7KnuwcvnWNl6cSHctvgoXIueGDL78RdyVSf0VEuoBZUpDivi5RBRmPRALhnqFhapD3VgQNQgn8cb0cTf7sbZbXg2xr/S+nWw8NnApYKA+2Movs8HMxgqiyFjry41bpd1jhOKU3YaTA5YDyFA+pv3ibTo5Eg2saXCS8ez6XsF2sTbpWi9HcncDOwMalqDFDwCX1bgNQp0pncL4kVG2+ZT3iaVuYisodcFH058wNBzbluA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752716404; c=relaxed/relaxed;
	bh=rIDJJYj0IKdl0sdVgaOrA5B/DX1+SBnc5GnQWdJnhsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzP8B49eflSBld1MmFwywGOf80TUaCGL0Umnd1sfg1xZUiTBu5ZvgFEYjJQsTvt1CJts/2s5KIboZFQ2dSNu4Ka5DDFy6aXV2fa/3Y+vdk+QWXRUAzCIL6QI5QppQliQmR9VT+YWFN1cX912So0xwO4OTWk+HIbripNeN9U6lJSOs9V4hSV/wJ1UbYZppH0Ct3z9ubrYZyiIuMW+TfGCI3a0g7dAhwlpkb+3LKjbu0Rl1uwla9CTElnBtR92me55+od8pUNOICCwCxeOS1Q6TXZRv+mgwtExC4M6G5KjUriPiRGTDRrEOJRv19bkSKCJdLIKJUjAH7cnNYGj9metrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpoudV1c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpoudV1c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjFwf3cJnz2yDk
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 11:40:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752716397; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rIDJJYj0IKdl0sdVgaOrA5B/DX1+SBnc5GnQWdJnhsc=;
	b=lpoudV1cZrQdXsjl4fNo5RWvENY7NVxSVCbhEeLb02rYBvgePgMQ0JtoG1RPZX5VymQXbATm4SkfdcwjI/kKeldUF9bkiOh/aMS7XVsPNGIEiZZsLI1XotmPmMwhyr6fYbxPFjhoArYvSv8yGd7FumoSDeFGgOQAE3ExSA6MBgM=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6DZKg_1752716395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 09:39:55 +0800
Message-ID: <7d4b5f45-a8c1-47d6-8404-9cad88a297c1@linux.alibaba.com>
Date: Thu, 17 Jul 2025 09:39:54 +0800
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
Subject: Re: [PATCH] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250717013431.15589-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717013431.15589-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/17 09:34, Bo Liu wrote:
> fix build err:
>   ld.lld: error: undefined symbol: crypto_req_done
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
> 
>   ld.lld: error: undefined symbol: crypto_acomp_decompress
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
> 
>   ld.lld: error: undefined symbol: crypto_alloc_acomp
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in archive vmlinux.a

Could you add a `Fixes` tag for this?

> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>


Thanks, let me reconfirm if if can resolved the issue.

Thanks,
Gao Xiang

