Return-Path: <linux-erofs+bounces-734-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584CB16AEA
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Jul 2025 05:33:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsvnF5zspz2yLB;
	Thu, 31 Jul 2025 13:33:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753932817;
	cv=none; b=M65YfH8x1bdimar6APkmiOWLFmuZwSikbf4Du1ODNlAqg3pDPorTFlqOJC5xZGUt1V5yV9hgbJkJ/X9SdVtIhQg7oSf09Ybhms6KcxpyB4s1y4Moi7rec8/4ArJSQ/ft/rQNmkQQzAsV8YLXriZDWfIYYb9K5EKiwxUdLquiULMIJN2ueYbVfPyMTSA/GDz3PbXc3B9c7MnFP9BcPuK71+axiPkxa7lF1+NAj6dQsx1DxUeRLe2TXubvEyw5UVg9+Imml6ZEvRZkEQE6/ONRaVv8n2N2i4GBdvsC3pNRqNlOg9Uxd7tziK6lqf9DiL++6GII66Y1Y06eZ1NVUCsA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753932817; c=relaxed/relaxed;
	bh=izW5+R7azHA0woWtd0bwLWov0oEMY3HXyZNYRuuY9xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/BQyZmEZiaWa1La+E/k+2Tlb9YYFMkV+GjNuN0Uxl6zPy88zUokHv3EuLpvJUA/1Eq2c4Lz84JQcyHqEU2p53/6b5QmWVS1h7MSnT/Scx6ttaNQxg2G2iWiWT7UvYbPTG9FAapQ7SGF7uV2cVE4TLq0KdRYhsntpfLcYS3xH6K//NG3mtFw3VbJvWC1rakHj6SE0i7U++I0a5iz74sisBOAtDB0SMBYyrJVqAMRvnTMr2bh6rqum2HJjAeOS/2E7T3ifXo4V5BxF9h/SLydCXXJgaAcFTH6gQgzfLx6Bxy9xdXd2sr5ZvKTTGnXBSr8EP1IPov3FH5W7ZTtb+nnaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vuQFYYGS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vuQFYYGS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsvn96QWvz2yKw
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Jul 2025 13:33:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753932809; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=izW5+R7azHA0woWtd0bwLWov0oEMY3HXyZNYRuuY9xc=;
	b=vuQFYYGSzPXr5AhLQzh32//0ByDGY8z5wcEm0/hlYzQD1lyDJn4b3XE9iwAtCL6EchViS++d0uDSevU3i98CdyTMLyuvSto3FAIM4xayq9OaNyxN1Vzt16aX4onf2sXTTJKJbKVms/8ZUeE7jL3SjQQCYBEt7iHmllX7RpQBydA=
Received: from 30.221.130.231(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkWlfpD_1753932807 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 11:33:28 +0800
Message-ID: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
Date: Thu, 31 Jul 2025 11:33:27 +0800
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
Subject: Re: [RFC 2/4] erofs-utils: introduce build support for libcurl,
 openssl and libxml2 library
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com, zhurui10@huawei.com,
 songgongzheng@huawei.com, lihongbo22@huawei.com, qinbinjuan@huawei.com,
 caihaomin@huawei.com, caihe@huawei.com
References: <20250729110610.3438246-1-zhaoyifan28@huawei.com>
 <20250729110610.3438246-3-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250729110610.3438246-3-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/7/29 19:06, Yifan Zhao wrote:
> From: zhaoyifan <zhaoyifan28@huawei.com>
> 
> This patch adds additional dependencies on libcurl, openssl and libxml2 library
> for the upcoming S3 data source support, with libcurl to interact with S3 API,
> openssl to generate S3 auth signature and libxml2 to parse response body.
> 
> The newly introduced dependencies are optional, controlled by the `--enable-s3`
> configure option.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   configure.ac       | 41 +++++++++++++++++++++++++++++++++++++++++
>   include/erofs/s3.h | 10 ++++++++++

Just some source organization suggestion in advance in case
that you have time to address them.

In the future `include/erofs/` will only keep liberofs-exported
structures and functions (and I will clean up the old headers),
so if some s3 private structures are only for internal uses,
it would be better to move the header into `lib/` and rename as
`lib/liberofs_xxxxxx.h` instead.

>   lib/Makefile.am    |  5 +++++
>   lib/s3.c           |  7 +++++++

Also since we will add more remote storage (I think oci storage
too), so it would be better to move lib/s3.c to lib/remotes/s3.c

>   mkfs/Makefile.am   |  3 ++-
>   5 files changed, 65 insertions(+), 1 deletion(-)
>   create mode 100644 include/erofs/s3.h
>   create mode 100644 lib/s3.c
> 

...

> diff --git a/include/erofs/s3.h b/include/erofs/s3.h
> new file mode 100644
> index 0000000..e29bde2
> --- /dev/null
> +++ b/include/erofs/s3.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/*
> + * Copyright (C) 2025 HUAWEI, Inc.
> + *             http://www.huawei.com/
> + * Created by Yifan Zhao <zhaoyifan28@huawei.com>
> + */
> +#ifndef __EROFS_S3_H
> +#define __EROFS_S3_H
> +
> +#endif

This file is empty in this patch, so it would be better
to add in the following patch.

Thanks,
Gao Xiang

