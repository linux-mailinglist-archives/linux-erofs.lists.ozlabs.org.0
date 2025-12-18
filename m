Return-Path: <linux-erofs+bounces-1514-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF4CCB2A8
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 10:26:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dX4zt59tYz2xqr;
	Thu, 18 Dec 2025 20:26:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766049994;
	cv=none; b=GSXoJ0bom2axIEG40ulhGa6/r/LrMYUaDLH2K/hveXaw2jqAIU/P+m1g1A8H4BevXNBiBSNCjKVzYaYVE/eWWj2SLSiU5SEsff69UHk19v5ah02GJ8Dbxk3x/TaKC+Kty7fuo6/uhkt9QGqWnXSqzFBzLlgHaAx3Re3oHxV0zToGGzz3OFvLcEvFoYO3oLFoIYXs9Qnvba7/th4mgYShuBLJfm+APcg/9/77IwA7mt+AuMBoSJplmNXsH+0FxEVoHMKNrHJlH7gaiH7YhcmoE/4l4jr2dEygSCK8vUXeTzWMH4cO+4OlnJ2CYEHRFKdq1/hsONuCpbkJEa/eEKY6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766049994; c=relaxed/relaxed;
	bh=yclqDNv4o6yDJJ1KXJuwB2HoSmBNcCWwAEwF4mEkXRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvyVnGajn8BuqjlL9XtJWd06ypGOuVLcI15qTBy2RnKHjBPhtpzHZ6/CztP1aQlHo1+3YOyUG7KzpvNW2zsqRriugokaqtfesmmvZirPamX4UXrl/YOyA4tDtWXqFdcPxwL1NUR9RFQ3ZiYqHkSOLTCii6hRnHS/ui++JbEwWafEO72Jxlhw0KSNNngctwPqQNu7VySW7TsKvAOHmEKqEzQEsxeDTDgDZ1QgrMI6bl/GQJPy5H3x7bPjLaV5t/XwXt5+KAgE9h/F2VzWa6O96kPazabBFcQufSUV5m/0rCb9rXr5UqXRR/IP+thA5OG0A7mMWSCwvjqg9vOmoNUXfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EASqW3FL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EASqW3FL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dX4zr0rG2z2xqm
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 20:26:30 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766049980; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yclqDNv4o6yDJJ1KXJuwB2HoSmBNcCWwAEwF4mEkXRo=;
	b=EASqW3FL72rRSNUMa75ULP+aUJSathlQGVoxHUWKqxp51kJkAhEaO9wOvHo5eGcETob8SH4gWgPQHmnWZo651XAg4jnNctl1Tg5CFxVjjdepBsbbdLN2ucNFh/2ycmj+j4tjpAjBo+tadPBGqs1EKehAGyj81dG8jxO/0kwNUA8=
Received: from 30.221.132.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wv7xdSS_1766049654 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 17:20:55 +0800
Message-ID: <5d9e758d-ed9e-45f2-a909-40093ac8e29f@linux.alibaba.com>
Date: Thu, 18 Dec 2025 17:20:54 +0800
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
Subject: Re: [PATCH v3] erofs: simplify the code using for_each_set_bit
To: Yuwen Chen <ywen.chen@foxmail.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <tencent_2F5DAC4517DCA2E354AE3BE70379BF5F9108@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_2F5DAC4517DCA2E354AE3BE70379BF5F9108@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/18 12:19, Yuwen Chen wrote:
> When mounting the EROFS file system, it is necessary to check the
> available compression algorithms. At this time, the for_each_set_bit
> function can be used to simplify the code logic.
> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> ---
> 
> v2 -> v3:
>      - rebase the patch
>      - remove the unnecessary judgment logic
> 
> v1 -> v2:
>      - revert the modifications to the fs/erofs/internal.h
> 
>   fs/erofs/decompressor.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)

LGTM,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

