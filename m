Return-Path: <linux-erofs+bounces-729-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F7B1636C
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 17:12:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsbLc2S3Fz2yRn;
	Thu, 31 Jul 2025 01:12:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753888376;
	cv=none; b=gCdAMSpAKrX3PpB+WIrevVBauka7JFmTEo7cus0Nu5Y7NjlLhtuEjzDTM37pSX71eS9tC7Q6wC0is6Fy/uXpVLRwOiEYR/NbZpoMfdBBU2xhG7BU3j19XXCyDjb5th9ctczS2q+m7tzTMfdcYWJCH7ks2/idWbYGVJNB+P/cIC+j53BVvnP1bRoeeItplFPy/Q8vwHq/QvTUn93fIgQcaL13uv5MQxcCGbrHhaxFkH8BdQ4dg2+mki1SYEYDhEPHv08B9GuRAk1FXSYtMrBcogQNDtBUCr0iZHgkmpOs0p+nfSKSVYejtNcJrYkb29WnguPWBqK9bh2IisRmUpfHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753888376; c=relaxed/relaxed;
	bh=6sT7aVW3MQBG7miFtEu5bR6UM9le1ET/SznYRdA7Jy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgEOsuuFZBTA6r+BR34rHLi1wBJbJgOrizex436+yG7U7WNq6xdFkqFpJltADQDFXUIo19Dyc7BiOgYwN4EHeJK0SsPNydYpbmKb8tdP7G3yi6iYH6CMXHQGBw0nkWA7ORhN6HcjpGX/urKIHjqNP4cWU5iOfEs2919giWchf+JqjDJBwLrq7e0aNNolcxLIDLhql8huGjsqXK0sqzNLfBdh0fwDxWkCUKpLgY4oAz2ajelahhkd/5cYEim4soIeIUnh6cJaw6yDLtcFIyiPfc6YXnVkHsvmsD48+k/eBioyeZH38pxhqkznWT8SbsWPp2zhu4VqdLOZqQNIlVpZVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iNYgOyep; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iNYgOyep;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsbLZ2tQHz2xtt
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Jul 2025 01:12:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753888368; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6sT7aVW3MQBG7miFtEu5bR6UM9le1ET/SznYRdA7Jy0=;
	b=iNYgOyepszTMlHhdNDF0/Oc94/z1TdF2zYKmTkD31S9KatwVIm0Puc1qBvvKdYRdwK2/zjG9wA5VKi/i0j05aBMrC606kNdWeFIOqxq99yBDV/Bqqu4T8uGeef7jrInl1nrSTkyziP0IpnuPSCKzZzMTpbCZ1OuWcuKmeVcKthY=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkV9HNb_1753888365 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Jul 2025 23:12:46 +0800
Message-ID: <d744137b-11b4-4ce9-a4c1-ba10e24adb9a@linux.alibaba.com>
Date: Wed, 30 Jul 2025 23:12:45 +0800
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
Subject: Re: [PATCH] erofs: Do not select tristate symbols from bool symbols
To: Geert Uytterhoeven <geert+renesas@glider.be>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Bo Liu <liubo03@inspur.com>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <da1b899e511145dd43fd2d398f64b2e03c6a39e7.1753879351.git.geert+renesas@glider.be>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <da1b899e511145dd43fd2d398f64b2e03c6a39e7.1753879351.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Greet,

On 2025/7/30 20:44, Geert Uytterhoeven wrote:
> The EROFS filesystem has many configurable options, controlled through
> boolean Kconfig symbols.  When enabled, these options may need to enable
> additional library functionality elsewhere.  Currently this is done by
> selecting the symbol for the additional functionality.  However, if
> EROFS_FS itself is modular, and the target symbol is a tristate symbol,
> the additional functionality is always forced built-in.
> 
> Selecting tristate symbols from a tristate symbol does keep modular
> transitivity.  Hence fix this by moving selects of tristate symbols to
> the main EROFS_FS symbol.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Triggered by noticing that commit 5e0bf36fd156b8d9 ("erofs: fix build
> error with CONFIG_EROFS_FS_ZIP_ACCEL=y") caused CONFIG_CRYPTO_DEFLATE
> and CONFIG_ZLIB_DEFLATE to change from m to y in m68k/allmodconfig.
> 
> Unfortunately Kconfig cannot be changed easily to detect this
> automatically, as it cannot distinguish between a "bool" symbol
> representing a configurable option in a module, and a driver that cannot
> be a module.
> ---

Thanks, it looks good to me, will upstream in this cycle:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

