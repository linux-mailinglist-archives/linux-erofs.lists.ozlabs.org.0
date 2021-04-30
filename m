Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E736FE5C
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 18:17:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWyFg3nQmz2yyC
	for <lists+linux-erofs@lfdr.de>; Sat,  1 May 2021 02:17:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1619799463;
	bh=oYeSDdRSuaE1ok1zRjYzp5riR0a3AythaYU3H3IUsz0=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=cn3yT4+F2+y+lXm64ZK2xHJnfqtBSzHCr0iH5iK4ZucsoFU5m1ZqTp+b3p8rowYhg
	 hAvDCn+SJDCC0U3KtvIokMYgkHn0X2Uqia2vKV6R8X/aaV4i0YcUBfLfiHIdDpi90l
	 lQuRhI6MOEkwBUBKQbwehlBdNu8cdQ0Ho+/nQksx2dpatz4VNGyTOChKEJAbuorxM3
	 WJWVbCGhPuqdrnAOsSdyr+ipglZt42Osv5JCWIZ6rzgfQOCyoXty+oCgFmvjuKWOaj
	 sm4RuZSJcA64/yXQ0YmsX0ZTzLl7Bwx5msY/kBU6co2VtGfgusTJ4XRd97E+c9Pv3S
	 z15EtLifRypCw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.53;
 helo=out30-53.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=Kz5VOSVI; dkim-atps=neutral
Received: from out30-53.freemail.mail.aliyun.com
 (out30-53.freemail.mail.aliyun.com [115.124.30.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWyFc5YcLz2xZG
 for <linux-erofs@lists.ozlabs.org>; Sat,  1 May 2021 02:17:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08431681|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.072268-0.00309946-0.924633;
 FP=0|0|0|0|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=3; RT=3; SR=0;
 TI=SMTPD_---0UXHr6or_1619799444; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UXHr6or_1619799444) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 01 May 2021 00:17:24 +0800
Subject: Re: [PATCH v4 4/5] erofs-utils: zero out garbage trailing data for
 non-0padding cases
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Li Guifu <bluce.liguifu@huawei.com>
References: <20210430040345.17120-1-xiang@kernel.org>
 <20210430040345.17120-4-xiang@kernel.org>
Message-ID: <ea990fb8-1aae-b697-b766-aab8592f46d2@aliyun.com>
Date: Sat, 1 May 2021 00:17:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430040345.17120-4-xiang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/4/30 12:03, Gao Xiang wrote:
> When "-E legacy-compress" is used, lz4 0padding feature will be
> disabled by default in order to support old kernels (< Linux v5.3).
> 
> In that case, the current mkfs leaves previous garbage data after
> valid compressed data if the length becomes shorter. This doesn't
> matter for kernels >= v5.0 since LZ4_decompress_safe_partial() is used.
> 
> However, for staging erofs v4.19, it used an in-house customized
> lz4 implemention due to LZ4_decompress_safe_partial() didn't work
> as expected at that time, yet it doesn't allow trailing random
> data in practice or decompression failure could happen.
> 
> I don't think it really matters since "obsoleted_mkfs" works perfectly
> for such old staging versions (v4.19). Anyway, trailing garbage data
> sounds unreasonable, so let's zero out it now.
> 
> Fixes: 66653ef10a7f ("erofs-utils: introduce compression for regular files")
> Signed-off-by: Gao Xiang <xiang@kernel.org>
> ---
>  lib/compress.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
