Return-Path: <linux-erofs+bounces-651-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A9B0830E
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jul 2025 04:45:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjHN15MYzz2yDk;
	Thu, 17 Jul 2025 12:45:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752720321;
	cv=none; b=SOYzTudiPbZ9r4mvfucMFruKu6Ubnc5CMUl/7qNN0k+bjaLMG9cO86JZJNYcXBlidSxka+DiWnKzpT7uUu1rgnqMDEI56i8i7K+2+1VRZjAa4mYZNwdFJhd4MgyeUCWVp/BZ+jIEAvPqi1k/a1MtNYTN2RFQkbBH1ZWuJf5EjB8K6jzHDTtliq+1PB28euxyQARyAp4zQkpn1dHJic8vo9mIvUOI/yaRemNsX3soCn0gUaLCPxcTT3tDXvtG7y9583/Xe1EjIhUh0WyUCSSQTG7lRG/v385+FJdVCcclcbZwrtcT1MTxDnI9xt3kGqPYQIcS3awWzB7XaTOzmdOH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752720321; c=relaxed/relaxed;
	bh=F9d/4K1zkZPJB2kB2UUc/hygJIY+cwOrg7BW+ay7QlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf1JkSIb1WmsARfW9bu4s+ueJaguCmZZ0XY6NTvT8RIOwP0auXAynVta2307pj/NLyGuhBrtlg1us/mbhpOfJAGuFrCFBfPzTklwmaRnqxwiPCoZrOFRxqZ1wQ/r+HYH82JKVVA9Dz0yo+qpbqbKDwLOOhTY8jG9lTMghXjwr3fbIeeLULX+7PBNUdqi8JS+ABS/bfa7CqylPMJCmKkVHtbFLSbhu+2dMXH0O1Clsii2KkxOFNkTxoQp9/2Zs9lwMSXc3TN2gzXsnRwOxF89fnpbGfIts2v2Uy6Y1cFwH2R1eGQKxTRxcsB7aF5ghfPQh3C8dhuRsAZFpQ9Oh4vGAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Vx01FsU3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Vx01FsU3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjHMz6ytfz2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 12:45:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752720313; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F9d/4K1zkZPJB2kB2UUc/hygJIY+cwOrg7BW+ay7QlY=;
	b=Vx01FsU3NNw4IHGitl/+eR1bcDY+kxIHXMb55i+jRSuNQ0DgsKEOmXAQDwbO+PYchs/0lh7hFmSp/tFcuGI9sYHe8Z2vBlVzHlyii8eqG2W/3NBteGddkkQp6YOAveWv/BXQrhk9tBxaWdnlYEe4wKc40YhGwxsM6xGtj6zcXDQ=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6Uh3P_1752720311 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 10:45:12 +0800
Message-ID: <c46f71ae-f04c-4aa6-99fb-cf8f8e751589@linux.alibaba.com>
Date: Thu, 17 Jul 2025 10:45:11 +0800
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
Subject: Re: [PATCH v2] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250717015848.4804-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717015848.4804-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/17 09:58, Bo Liu wrote:
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
> 
> v1: https://lore.kernel.org/linux-erofs/7a1dbee70a604583bae5a29f690f4231@inspur.com/T/#t
> 
> change since v1:
> - add Fixes commits
> ---
>   fs/erofs/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 6beeb7063871..60510a041bf1 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -147,6 +147,7 @@ config EROFS_FS_ZIP_ZSTD
>   config EROFS_FS_ZIP_ACCEL
>   	bool "EROFS hardware decompression support"
>   	depends on EROFS_FS_ZIP
> +	select CRYPTO

After testing, I think we should rely on
CRYPTO_ACOMP or CRYPTO_ACOMP2 instead.

Otherwise it will still fails.

Thanks,
Gao Xiang

