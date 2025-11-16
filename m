Return-Path: <linux-erofs+bounces-1376-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C6C613FD
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Nov 2025 12:54:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8Tnm0QsFz2xqj;
	Sun, 16 Nov 2025 22:54:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763294092;
	cv=none; b=n7Sm76eTReVQ7l3T7OISO7ZviQ5ulrK/1xoOsU0M8+5C82EYbT4fF+MhEFWp8dNFY4rys08nL5+xGyVzqJjsm1xsrjPMoJA9uyCy99kHxMdn4gnFl5tKKM26XZxGpsQAm8WDfDW9T/E89WHjjwdR7rDBrJl/2r/iZG7wXZ+X+0lG+2VQTjYgZ/ohkjVZMo0+qAd/tSwQxwUlLb1pHmtA3XU1ZI4fQED+T0SIouwhAzdVtiWHqKJn0wvDZladjLr1t3mFdmGvs6a0lJ6bJnq8/NMgQYrNrAB8XvgPWEAO6b/rbuRkUg40V1Jdq5FjLUgxNqmtI6HjqGzEcwklTugDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763294092; c=relaxed/relaxed;
	bh=4v60toLnC7F9DIrdXiLX89QoxpYhFyqY7LCwty780Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6tLOABoerwSfQtdNYaAFLZMDtny/gCFNEiDgHFMtPNuXJ3f3eYzwaTN83Cxo959ePYwALmtPdSNhtHpTP6x7kKEyfv7p0DKpT7T49K/IfGfBEA3Lf9rMVUMIrbt41nXpvPPedqdTzZXUat/Fbqob1nUQS+08NX1ZrYmkveP7HQvMJfG4FINqkBbXbT/ZRKGkRE9qYgBLzw7HXqq1MCaU/7vLwSv+qpcW/wI38ztGuX2S0au4/SJjzJYMCbg+jq5Rs4D9vWwPnixjlgS2NfMngtQNo4LGfK7UrqcAhKEHjJI1AUTJDYHQCR9u05PW99HCyYpTwQ8gmp0Kbk3sHu8Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gdw9CKmq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gdw9CKmq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8Tnl0nzPz2xlK
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Nov 2025 22:54:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763294086; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4v60toLnC7F9DIrdXiLX89QoxpYhFyqY7LCwty780Vs=;
	b=gdw9CKmqNkBUGQRtNtdatylDVCdjWR+pdUVJMhHM2PlzrCs0yoAzXw4JLJ6HYl4gA82ypjlIylQj7qowIIfXEq2ub5sgged4c303xah4yxdHirRfs7GHWXT0O0o5Iab6tRRfen2MnOgGXj8ufzrpqzmubLz2dVaOPkJhzlz/1H4=
Received: from 30.170.196.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsSHQp._1763294083 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Nov 2025 19:54:44 +0800
Message-ID: <9e121004-fa70-4461-932b-9d30fd3733cc@linux.alibaba.com>
Date: Sun, 16 Nov 2025 19:54:43 +0800
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
Subject: Re: [PATCH v8 1/9] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> It's useful to get filesystem-specific information using the
> existing private field in the @iomap_iter passed to iomap_{begin,end}
> for advanced usage for iomap buffered reads, which is much like the
> current iomap DIO.
> 
> For example, EROFS needs it to:
> 
>   - implement an efficient page cache sharing feature, since iomap
>     needs to apply to anon inode page cache but we'd like to get the
>     backing inode/fs instead, so filesystem-specific private data is
>     needed to keep such information;
> 
>   - pass in both struct page * and void * for inline data to avoid
>     kmap_to_page() usage (which is bogus).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

LGTM, and I think the case 2) is useful even without
the main feature:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

