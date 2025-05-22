Return-Path: <linux-erofs+bounces-362-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2CBAC090E
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 11:52:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b33W34nlTz3c4D;
	Thu, 22 May 2025 19:52:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747907567;
	cv=none; b=GDumUIzFFltBYmorQz7vPVLegPgirvhjs8i+Gc24AOdG4vCCRkZe4BhghbW/zqEAMy6qlN7HryEC9vAMrQyHSEXzKLkppT2BVfVDCfC1+zpL2Y/mPv+uw3te8Lbbgx8ryaL9appMqj6eb0cbduRN5AXxzhbQ5f/PgUkgWXU9clQltvTEIYgxV8A9F/0TFWnlLqYkOCgXCBvzz4ECUmp8RV7cjm38+MbjXyJ0+c7wWtaxxHYLw2IZR5NKpSZAQmZNdEB1CftnorAAjt9VOlEdFKJbPp0wLnjD5I3gx6YNxx/4VUIYlwL1QYOQcBEYUC40+94PXCWmuGnl7k7Nai2V9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747907567; c=relaxed/relaxed;
	bh=eSAnloQcVa/uk9+ADt/Qeyay1jtAPm847cdU8CH03+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDrzlmzx3hgL+VRrI3uvO6h+4RdimbPSUC6O5GdVjSJ7KG2zdePC1HnWGQJRP+anAPvTm6ClNtDQo1w7Rve8NYpGj4XUXC2Yx6U6kwVAFnQT4Q0l97Ltj3jvi8gwLPEg1md0k9BE7EKlkup9G98d7MNf4WCM48+mYPOeyhgV/W90AMFqBQJGdPfz2ivvThwlgBGGK9HW66LhRT5xhXLMHSdWwfRya9l4RcZRfS+jNvYUewUnEYYJw+HYb25uf8GPDjtj9bm3eD3OVaGHAKEek/QjGNClCrCpKIGRbPHg2EsDVOOVz0ToUa1fsjmBvhMHPorrzTdHDFE6ZYPTe//Mpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r7sBcN95; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r7sBcN95;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b33W21S6lz2yfK
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 19:52:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747907562; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eSAnloQcVa/uk9+ADt/Qeyay1jtAPm847cdU8CH03+8=;
	b=r7sBcN95WPdR931WJU/u7lD3IK6z2zvkclV8Je5MV8z7woacU9rmnU/pzttxYS6iD3zBCclSHWBiRdCWnMMjkFpRPaj9UtYlWReAM8TDLHUoywHoPNlUeOMzrvQCQwy7esDdHexJLLXuiBlvdBv4mp8StB7fBB77AZJH4FeDS0g=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WbVPZFi_1747907554 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 17:52:40 +0800
Message-ID: <2f0e05c0-fe6b-4e84-9ef5-c33ecc43d81c@linux.alibaba.com>
Date: Thu, 22 May 2025 17:52:32 +0800
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
Subject: Re: [PATCH v9] erofs: support deflate decompress by using Intel QAT
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250522094931.28956-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250522094931.28956-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/22 17:49, Bo Liu wrote:
> This patch introdueces the use of the Intel QAT to decompress compressed
> data in the EROFS filesystem, aiming to improve the decompression speed
> of compressed datea.
> 
> We created a 285MiB compressed file and then used the following command to
> create EROFS images with different cluster size.
>       # mkfs.erofs -zdeflate,level=9 -C16384
> 
> fio command was used to test random read and small random read(~5%) and
> sequential read performance.
>       # fio -filename=testfile  -bs=4k -rw=read -name=job1
>       # fio -filename=testfile  -bs=4k -rw=randread -name=job1
>       # fio -filename=testfile  -bs=4k -rw=randread --io_size=14m -name=job1
> 
> Here are some performance numbers for reference:
> 
> Processors: Intel(R) Xeon(R) 6766E(144 core)
> Memory:     521 GiB
> 
> |-----------------------------------------------------------------------------|
> |           | Cluster size | sequential read | randread  | small randread(5%) |
> |-----------|--------------|-----------------|-----------|--------------------|
> | Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76 MiB/s    |
> | Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02 MiB/s    |
> | Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90 MiB/s    |
> | Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36 MiB/s    |
> | Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66 MiB/s    |
> | deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50 MiB/s    |
> | deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94 MiB/s    |
> | deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02 MiB/s    |
> | deflate   |    131072    |    452  MiB/s   | 177 MiB/s |     11.44 MiB/s    |
> | deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60 MiB/s    |
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


