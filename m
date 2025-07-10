Return-Path: <linux-erofs+bounces-578-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E1AFFB27
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 09:42:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd6HW6wf2z30MY;
	Thu, 10 Jul 2025 17:41:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752133319;
	cv=none; b=KrACf0UasChf+fA/0I3hOJ7V8CuhQBE6oe6C6u7E3XZckSjK9uxAT4/SjK2R/wq1ISTqTYOfeLpS3mi+/Omhv5wdCMl/cptsZ+qMC85ziveD0HPeuvQUu7dLa3Se1ISWZwtYbcEfyn/giCY3vaJwQR1re9C1u17VjM7vKiVZMg2pf5uVACzy/GkLK5FK3pkcJckWlRBuzAR2GxKy+umZVSt4qSFWt147zMZS6vi5cRBPjpXmzfBC32g3Gv3gR46ml7MUSEUHZZ6w8e2+GKzoamfYprMtbOY2ERLXg0gtQSVOQGkeqCwTeHt9MAV1BvDnraS/1OxPk219+ZI0npJC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752133319; c=relaxed/relaxed;
	bh=DMjplhNJqUQSclZDRNVMXu6TwMBThFiq5ml4fAhr1ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIHfRfhevtSrCa8xxYo3gQu8zyHZc3ibrFDqLhZQPPKeCdsDFMFfxGwd5DAR6dM6vwu227+kcuUBoi9dyEz58hCVCjl37VRfbUhlj7e8zMzlAAJhWbHIRsfUTxnL/0+LBIeHczUXohQdKAcY7Hy/jU68F9YWoKKDzN8freq1bvmH+1w98dcdqJU6tbI9TUZEiypxjZHKKqsEdj8VRDrC/i3zyVuT65fA+JGc5rtDYgZifS8fuMe62wf+y79ZN16DYICxJbaQsVsNowY0l+Cs+b1KNJpmuTdVeLCKbjOlS2Z2K5k3o56F40xN0rEsdl4TaIH8kqSZKFTSPj11RHiuwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CwwPJaz7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CwwPJaz7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd6HT6H8tz2yMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 17:41:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752133312; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DMjplhNJqUQSclZDRNVMXu6TwMBThFiq5ml4fAhr1ck=;
	b=CwwPJaz7f1O/kJoRYnFiG2RnodfSkFal/r3nWsxx+cQb0x03LGIguencbNUOlSPxZLKggVkwOnuU3gNhhZFo2kUz9sJf/BGPkUpUbUxrwWth5C9DLTqovFjg/JuqBISeIBpQofD7q3vEy/ADOrVdDfP2gJllKicNsbjCOU1Igis=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WibwoAD_1752133310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 15:41:50 +0800
Message-ID: <a4ab45c9-b3d2-4807-954d-1bd7d38b7242@linux.alibaba.com>
Date: Thu, 10 Jul 2025 15:41:49 +0800
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
Subject: Re: [PATCH 1/2] erofs: allow readdir() to be interrupted
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250710073619.4083422-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250710073619.4083422-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/10 15:36, Chao Yu wrote:
> In a quick slow device, readdir() may loop for long time in large
> directory, let's give a chance to allow it to be interrupted by
> userspace.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

> ---
>   fs/erofs/dir.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 2fae209d0274..cff61c5a172b 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -58,6 +58,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   		struct erofs_dirent *de;
>   		unsigned int nameoff, maxsize;
>   
> +		/* allow readdir() to be interrupted */

Hi Chao,

It seems that comment is unnecessary since the following code
is obvious, if you have no objection I will remove this
comment when applying.

Thanks,
Gao Xiang

