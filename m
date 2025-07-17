Return-Path: <linux-erofs+bounces-657-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC69B0846D
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 07:57:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjMf85kJtz2yDk;
	Thu, 17 Jul 2025 15:57:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752731872;
	cv=none; b=J1llFb/OAQemAYCMveU8+Gh+WC+Zl2TVG7iBaY4avg+B/aU74xE/KquobPD1DR0ZtS/HrHlk2i06bNKedB7TiYpdQPtorCKW9wNBCDoFk8UeyMZKCgRGnwItCetT9yPFbfWsJdy0U2YlnQT2NyGmc3rQFsQyDRtpz5mocwssz3LVeQz7rCGRsJLUxiuijEqA543Wy8P3BwwXoQJu8T/ntpTA7J2lCy7gtcrqO8svaW/y+8GXdrouRO2Bh2tK3lJUstawRaXVQJCliqvjQynMR5ZPWDOJDj2s3FhLExkNnAd0GTMo2KsEfFTKvIxKtIzVAUSR8702cRw7xoMXs6qKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752731872; c=relaxed/relaxed;
	bh=aj9BSuaE7p+6r1rAbiSYzDfAMXCrPeCl4NXzz/D5Ee0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6senwfkMmQTJaD2RHhktctqXY/vAvdYj4Rwlh4nPBUtwYLnjZHPYGO3yCmYU4l+ZlweAgoPbByT+uTrzG8YTLl30USqpJwr3iq5rGXNdw4qZO9Qrf83ABKRMHUowzXujmlIu1uKJPRD+ZlsofmEZbd+WfF8wwgD+ZwoTztb0IOEb79KXscg75UjvZqkxcwIAGiS+GYB/Q3561BtxwXm6mAOvMoR4MCjmu/4Ksxm3Qc+KKLilA1xkC2NPJFeubUp6KQWxt4CSKpr9PNdAeWne6is1k6Rx+bE/jjTmarWOiKfTH49IFgJBl5gVaGSkdR6sBP5yeYOWE3gbBOLfDOunQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m1o3LsKA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m1o3LsKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjMf70Jbhz2xlL
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 15:57:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752731865; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aj9BSuaE7p+6r1rAbiSYzDfAMXCrPeCl4NXzz/D5Ee0=;
	b=m1o3LsKAMAQbsyX9FCuxo1+b+KXmJV9vouS3C6M+wGDg281GJP8Kw3tEF8G0bHzaeLfnLBYPi8KUSoD2WRvGjKRIeNE+DufPdcmijBvawFqFPJn68N2zyyDlkRw656i0uaOmqowiqlJZ7tzpWlxQHHu5SXC0y/3UyALBG+uaQjA=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6wI23_1752731863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 13:57:44 +0800
Message-ID: <6248842e-3641-42a2-b8da-bcce3c0bc793@linux.alibaba.com>
Date: Thu, 17 Jul 2025 13:57:43 +0800
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
Subject: Re: [PATCH v3] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250717053724.65995-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717053724.65995-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/17 13:37, Bo Liu wrote:
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
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.com/
> Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using Intel QAT")
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

