Return-Path: <linux-erofs+bounces-1061-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB3B91C63
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Sep 2025 16:43:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVm7w3VXfz2yrr;
	Tue, 23 Sep 2025 00:43:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758552220;
	cv=none; b=H6ujlGQVR31gg97mkbXqou1cIjK97/hk2O7HxHQ2SYOU5E+n7c+aERkDVt+Va6j4R/xbVPde9Pw0JIxXtiv3p5kwzw5LedaCO0zdIU7Wg83kbmkTe6N7AZY61sgg9GKD0a5+5rhqY8mNxy5i14N+7sab7nF9JcwboD4QCdjcSWNbPWf1H0E9PzDxDJz8fOuWo8gbI0sazarHy9UFN88iFh6YfBO2H8/se+3dYC3kWQG849XVlFJKy6fVMyA9tf3HsyzbRQvvRLmesBt8JCAV//NnBpJM2D0zGNFb5QwOtFnuNnScCe/uhdQQEasbbCSxW/3cqfe11qAqHNv8nvrbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758552220; c=relaxed/relaxed;
	bh=tKRMGh/qtU8jojR46arwg1WPw+eqAIS0mauPXhHXKBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOanzRGrDenmNZDkTcc67DOkuuK+XyYevhxow886C6r3jCZCzZXKsXasBPYr5fXz7iGtvoqjpXqIPD7HuV5/1Qp3IMS5ljZxLO2tdoUBOL7oFQ0d4w3/jHC2n3dAZNqpnOc+P0uckAM46/ikHMhjeHrTCtp/Ffs17mO4XJua2W/OYzR5kE9eTtLzJ5OOqc/MIfXNb4aOJtTdjOLsGw86aHaghkbtVxp9J+4f0H9jbTJJJZELta3Adouug1b3KrGkV08rh2ZJMz9F29FeQiXOUTbXjpUc9RexaiGKDSN9btFy+2G4QiktQ9cEEd8pjSCYAUGRDfs99+oxlVxPX1SM4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=moY8sQCJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=moY8sQCJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVm7t2SsVz2yr1
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 00:43:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758552212; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tKRMGh/qtU8jojR46arwg1WPw+eqAIS0mauPXhHXKBc=;
	b=moY8sQCJineIXyc6GX0tY8VfGUOMC41vNqmv4ZHe0LicOFegw3Tr5QjUe29JXIaO8ryTL5URK7vb3nAKUZjF66a+oQ0zKsfsd+5btrmcCI9ZKRHnH33EKOGKjLYTv4YuxvXzYxwKJANw+JZDKEliSN6cdVtM4jmoHWcOgpHzowQ=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoZpElR_1758552209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 22:43:30 +0800
Message-ID: <7f41c935-c352-45c5-8a24-d690755d67d3@linux.alibaba.com>
Date: Mon, 22 Sep 2025 22:43:29 +0800
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
Subject: Re: [PATCH] erofs: add direct I/O support for compressed data
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250922124304.489419-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250922124304.489419-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chunhai,

On 2025/9/22 20:43, Chunhai Guo wrote:
> Direct I/O is particularly useful in memory-sensitive scenarios, as it
> provides more predictable performance by avoiding unnecessary page cache
> overheads. For example, when accessing large files such as AI model files
> that are typically read only once, buffered I/O introduces redundant page
> cache usage and extra page copies, leading to unstable performance and
> increased CPU load due to memory reclaim. While Direct I/O can avoid these.
> 
> The table below shows that the performance of direct I/O is up to 54.6%
> higher than buffered I/O in the low-memory scenario. The results were
> obtained using the fio benchmark with 8 threads, each thread read a 2.5GB
> file, on ARM64 Android devices running the 6.6 kernel with an 8-core CPU
> and 12GB of memory.
> 
> +--------------------------------------------------------------------------+
> | fio benchmark       | buffered I/O (MiB/s) | direct I/O (MiB/s) |  diff  |
> |---------------------+----------------------+--------------------+--------|
> | normal scenario     |        2629.8        |       3648.7       | +38.7% |
> |---------------------+----------------------+--------------------+--------|
> | low memory scenario |        2350.0        |       3633.9       | +54.6% |
> +--------------------------------------------------------------------------+

Thanks for your patch!

Yes, avoid page cache by using direct I/O for read-once data (e.g.
distributing huge LLM model) actually makes sense on my side and your test
result is impressive.

I will look into your implementation later, since it's too late for v6.18.
Let's address this feature for the v6.19 cycle.

Thanks,
Gao Xiang

> 
> This patch does not support the following two cases. They will fall back to
> buffered I/O:
> (1) large folios, which will be supported in a follow-up patch.
> (2) folios with private data attached, as the private data is required by
> this direct I/O implementation.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>


