Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6A92B212
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 10:24:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xuqSphdp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJDY53qMcz3cLk
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 18:24:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xuqSphdp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJDXz73kCz2yvr
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 18:24:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720513437; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uXvk3J2pZ0f2j+ruTKiCSSmGL74edQg7eFvWgymAYyU=;
	b=xuqSphdpEQ6QH6cRYkx2OuKaa5A/bqJEeCNjgJcjHXPpNU4bg4dnk3mSINbLLXR4yoSVwNtbPDVzcQLJ9v5ZAY1RaN7r6P1XFFCaA1hXVypNsfkPwdubLzSU2Wk2ux34GA9w/puZv5d/MWjtVVBCu0g5ocQYYSi+ybNUq2XOJiI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAB7uaj_1720513433;
Received: from 30.97.49.57(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAB7uaj_1720513433)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 16:23:56 +0800
Message-ID: <e8466e20-6f44-4afc-b27c-c294f87f5f9e@linux.alibaba.com>
Date: Tue, 9 Jul 2024 16:23:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs-utils: fix bitops fls_long()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240709073819.3061805-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240709073819.3061805-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/9 15:38, Hongzhen Luo wrote:
> The `__builtin_clz` is for unsigned int, while it is applied
> to unsigned long. This fixes it by using `__builtin_clzl`.
> 
> It does not impact any existing use cases in the whole codebase,
> since the only caller of `fls_long` is `roundup_pow_of_two` in
> `erofs_init_devices`, and the default compile optimization level
> is O2. At this level, the argument passed to `roundup_pow_of_two`
> is optimized into a constant, bypassing the logic of `fls_long`.

`roundup_pow_of_two()` in `erofs_init_devices()` could give
wrong results although the current compiler optimization level
"-O2" covers it up.


> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

No need to resend, I will update manually.

Thanks,
Gao Xiang

> ---
> v3: Update the commit message.
> v2: https://lore.kernel.org/all/20240709050700.2911563-1-hongzhen@linux.alibaba.com/
> v1: https://lore.kernel.org/all/20240709022031.2752872-1-hongzhen@linux.alibaba.com/
> ---
>   include/erofs/defs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index e0798c8..310a6ab 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -288,7 +288,7 @@ static inline u32 get_unaligned_le64(const void *p)
>   
>   static inline unsigned int fls_long(unsigned long x)
>   {
> -	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
> +	return x ? sizeof(x) * 8 - __builtin_clzl(x) : 0;
>   }
>   
>   static inline unsigned long lowbit(unsigned long n)
