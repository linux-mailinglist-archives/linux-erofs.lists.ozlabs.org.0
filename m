Return-Path: <linux-erofs+bounces-1131-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FABA7C35
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Sep 2025 03:39:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZkPs5LpHz300F;
	Mon, 29 Sep 2025 11:39:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759109969;
	cv=none; b=b1pCtdYn+g/baTOTZ10T+BID8BI5oTn9Po7tImVsSeZoRKpR6plDefUhoCrXVBBZxbr/S7pm2F3rfRUUR5qu4tVv+fly9MPczSuRLBqPenhv3AEHANYCnZdX1Wv3cXK6eqUWXYPJrmipRe4v+dveyrOwLZiNcheN1RE/HRwHDrYD7Wij2XZgZLqDNv6Dy8+qVR3olnr7cnftgqjOZk/2lrznPpGA4TPyQuB7fTebWWHNSZe/Hl9I4E7U7wum2j73XQP02CTgEkiw1gdrmJIFIwk0BFNnnfEqKSPLOgY2+ES3u7TJ7Ujjk+SpJz5WtJK1Nwds5kUD2s8OF59WHRQicg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759109969; c=relaxed/relaxed;
	bh=zpT3mVHW65YreI0nAwmRx9QW4vxSXT2mntKY1fqxq4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKFLBeeL++vdw94P338rBarI5Nr9PKwULH7Hu9r/HCLlNH2poaDlRMwMROiCF4SCf+t/8xWwBF/NZZY7e5NzhZ5a/mPaTc5/hN/ZvVPkUkO7lI/TQkyPFVt6LRSbXpO7yN4nyfBpddIZZ/llX2UbX9+ye0s6jQ7Qz1k6bCvpHNb9WyRSYY2pKK/g+aFB/LR7aT5/7NkrIc40D0D75eTfzsj3KJVHqwZ+U+JL6JU8BpHyCQq/GbgkrseNqZMQ67xG9QCOVVF3Ya9Fxn6mUvgtawBhyYnX4G1AuRD1TB/ydrVqbWSjBNK03NByKDSxBP2ktJbdmQi6p3iQW19RPAqopQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U43x+eNu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U43x+eNu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZkPq4BJyz2yrW
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Sep 2025 11:39:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759109961; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zpT3mVHW65YreI0nAwmRx9QW4vxSXT2mntKY1fqxq4Y=;
	b=U43x+eNu5aXToPWNOmKBN/kLERnthZeUoyd4rYs1AqjtnukZcCYg4Oic56Jp/qkK3kpSMjc/8cERkEPWzFH8ChvRFyJeETQpEvqTT0upKA+RALIZFhXMSppOs/cvV8klvM93ZrcwWvGkHNYczRp4d64sflE34/ZX5WZmDdDboS0=
Received: from 30.221.130.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WozqW0M_1759109959 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Sep 2025 09:39:19 +0800
Message-ID: <9b2716ae-c5c7-4a81-9313-91d1f2998b87@linux.alibaba.com>
Date: Mon, 29 Sep 2025 09:39:18 +0800
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
Subject: Re: [PATCH v4] erofs-utils: mount: add support for standard OCI targz
 blob access
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250928033957.23867-1-hudson@cyzhu.com>
 <20250928101530.13744-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250928101530.13744-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/28 18:15, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Add support for combining tarindex files with remote OCI blobs
> through a new source mechanism. This allows local metadata
> storage while keeping OCI tgz blob data in remote registries
> 
> e.g.:
>   $ mkfs.erofs --tar=i --gzinfo=ubuntu.zinfo ubuntu.erofs \
>     13b7e9....tgz
> 
>   $ mount.erofs -t erofs.nbd -o oci.blob=13b7e9..., \
>      oci.platform=linux/amd64,oci.tarindex=ubuntu.erofs, \
>      oci.zinfo=ubuntu.zinfo ubuntu:20.04 mnt
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Applied now.

Thanks,
Gao Xiang

