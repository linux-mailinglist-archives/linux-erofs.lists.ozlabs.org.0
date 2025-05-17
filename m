Return-Path: <linux-erofs+bounces-338-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEBABA7FB
	for <lists+linux-erofs@lfdr.de>; Sat, 17 May 2025 05:28:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzqCr5ykYz2yf3;
	Sat, 17 May 2025 13:28:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747452504;
	cv=none; b=NovVWNogXoLCPNUsa6zBakQOYjId7rzRuEo2j9T8sksR4ws3tnE5V73KJZmlJTufZuKVHAYmEJWYYISNjvmB/W6b50moC0J8WTfaKvDeR8exUCZLJXt6+hwrJ5tlsLkAb4JGIJniCnnMr4W0vHswpANAcopW18RCyPJFsVYC9PzxR18CCXhnQeltk8TKblp3EYkPiQ86awoJa1pY8bYlRhF6mhh0nfpCCrEgiroQhoPsavjM47aPls6dFQM3N44Tqh00iHJ/j3Hr11h7OeQLGnuUUpmhe6R1D8uwBuwarjMapliuVEGW/ZmcGfyFIIHMKq/nqSRQfPgxRsCZV/KeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747452504; c=relaxed/relaxed;
	bh=KZQjIna8AYdipvVJHml0zLyucTarm+OWKdxXSAdKhm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iedKEyCl4guPOq0rTRAH0V/zLmhW2c/wz9WMF3dCfcCI7BUttz3cnp44XduW9LxBeIZBeWF/ugp1qBetgYR2B5NuF87okqObHKIas9/PkdMWqMB2aTPtFF75Si5/xQx20b+46PhUkXgMrGoBxGEK6S7BOTE9hcY6UciTCtZe+yyCCkhsWEKm3HanC4X/LyNifHdU5m2udQ3SPnPPvJ9g+80QAsVRF7T8ssgIc29/ghwE53fc0vEBAnqTPgc2VkuK3iT23PnvNKCvDzr5sXQmzCnaFg3EG0bRUH9AunET6KHQxFaIJhjHWD/TuJmt9TphFqeeJ3HgfMjpwLXXnLdIHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tYvZCnTs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tYvZCnTs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZzqCn74kZz2y82
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 13:28:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747452496; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KZQjIna8AYdipvVJHml0zLyucTarm+OWKdxXSAdKhm4=;
	b=tYvZCnTsrblJ3bveaz5zlxf/VbB0IQp+q30xAG4inaBfVWH3luGSIZoQf91RkSr89s+BbkPXmSjessJZ8eQGzRXJGG54K+XPC4MT+jL2MgrUNVjAoGfoFlVlhfzcU0OK0qESEN00PlckW1vihCQfO7ZgFec8gnEnxvCswZyBbaY=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Waya2sm_1747452494 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 May 2025 11:28:14 +0800
Message-ID: <2e076b62-0b6a-4af3-a8c2-babade16fa6d@linux.alibaba.com>
Date: Sat, 17 May 2025 11:28:14 +0800
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
Subject: Re: [PATCH v3] erofs: support deflate decompress by using Intel QAT
To: Eric Biggers <ebiggers@kernel.org>, Bo Liu <liubo03@inspur.com>
Cc: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250516082634.3801-1-liubo03@inspur.com>
 <20250516163857.GA1241@sol>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250516163857.GA1241@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Eric,

On 2025/5/17 00:38, Eric Biggers wrote:
> On Fri, May 16, 2025 at 04:26:34AM -0400, Bo Liu wrote:
>> +config EROFS_FS_ZIP_CRYPTO
>> +	bool "EROFS hardware decompression support (crypto interface)"
>> +	depends on EROFS_FS_ZIP
>> +	help
>> +	  Saying Y here includes support for reading EROFS file systems
>> +	  containing crypto compressed data.  It gives better decompression
>> +	  speed than the software-implemented compression, and it costs
>> +	  lower CPU overhead.
>> +
>> +	  Crypto support is an experimental feature for now and so most
>> +	  file systems will be readable without selecting this option.
>> +
>> +	  If unsure, say N.
> 
> I recommend not including the word "crypto" in any user facing part of this.
> 
> Compression algorithms are not cryptographic algorithms.  The fact that the
> interface to access hardware compression accelerators is currently the "Crypto
> API" is an implementation quirk.  It could be a different interface in the
> future.
> 
> Call it something clear like "hardware decompression".

Totally agreed on this since it's just an implementation detail,
and I will try to make some extra time to polish this commit myself
to fix some minor issues later.

Thanks,
Gao Xiang


> 
> - Eric


