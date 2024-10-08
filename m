Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B2C993EB2
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 08:30:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN5jZ5VQbz2xmh
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 17:30:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728369009;
	cv=none; b=YxLjNCybHNt38ruKPb7xPDnoukp1dEVfKPpjEacfcI7AXbiDizdCwPJNru2k/IPrSImDJEa2g9MMd83oID27LTEzsMU/E5LGwyuuEf0roksyzd8XALUIvR7FhGAZkby+30a0xJhLwAPTM/EQt5PrXVle/raZVU+uL/xAm3e3G+AyryrD/6joahQG9xguAMV9ObWCGM3BD8+41NuGyuJjN+n/BO3gdAs05VmhUVrq/Yf4XGdcDVyJiMiGK+jjrsBquRW7WwuoCJ4rAGlFhAbswohc6gn1YeQFcNherPyzu6RgReuVxhxK43xie1K0vLukLdIBMHem99Rk4qotdTs6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728369009; c=relaxed/relaxed;
	bh=vFAYrJRGDjWGRjJcmQqEIOSMAlcDU2c32HSRkzW1Ogg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VyrR+5EQ6lo+bBbTSpPudEWPtuw8zJvlsHV+i3fwlVFlpQcs09cT/RjSUJ4Y0MgtuZk/OkTPttgUxgNWTjJZ8jdYZSfgSIsm+Z+ribtZvy1YHvlRXhMTsMHuYHpVQocIXsAgFrMrWb6q9iKjzB7Bh697RFuPzZzU2Bta58Gd65XwoePFWWht6K0ZOMdlv34Din8NQr+dPV/GVnXh3RACxPUfwAATOb/2p49sIeGDZ84XceD51S7j6jsMgjO4Br1djfhnOdsPt82LOJHIkybOTnBWvTksb9KWEjO/JEEQ1Sy9PqNG/F09xmhUX98JN3wQ0Lj6cu5XQktV9Nf7t6v49w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aqbpay/N; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aqbpay/N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN5jT478Cz2xHr
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 17:30:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728368997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vFAYrJRGDjWGRjJcmQqEIOSMAlcDU2c32HSRkzW1Ogg=;
	b=aqbpay/N/0q4uInWCv+pP7yFJH1p12ZAm08YLgRTlBh3A+xbjJDU2tkIst4pTtInkrnTJL2OszQBdT6G4hZmMGI4qv5Pso8tm/kc3MATl4vNks8S/Yjuzry+Hv9FTwyogIlBF9lnUmBCDxkWqM9iYNHufEIr1kj+w6Eq75+OEus=
Received: from 30.221.129.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGaY5fC_1728368995)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 14:29:56 +0800
Message-ID: <af11d948-553f-486b-a1fb-cdfc18b3c514@linux.alibaba.com>
Date: Tue, 8 Oct 2024 14:29:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: Explicitly include <pthread.h> where
 used
To: Satoshi Niwa <niwa@google.com>, linux-erofs@lists.ozlabs.org
References: <20241008060819.2442945-1-niwa@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241008060819.2442945-1-niwa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Hi Satoshi,

On 2024/10/8 14:08, Satoshi Niwa via Linux-erofs wrote:
> compress.c and inode.c use pthread functions but do not explicitly include <pthread.h>.
> This causes build failures with the Android build system,
> which throws "error: implicit declaration of function pthread_*".
> > Signed-off-by: Satoshi Niwa <niwa@google.com>

Thanks for catching this!
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   lib/compress.c | 3 +++
>   lib/inode.c    | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 17e7112..5d6fb2a 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -8,6 +8,9 @@
>   #ifndef _LARGEFILE64_SOURCE
>   #define _LARGEFILE64_SOURCE
>   #endif
> +#ifdef EROFS_MT_ENABLED
> +#include <pthread.h>
> +#endif
>   #include <string.h>
>   #include <stdlib.h>
>   #include <unistd.h>
> diff --git a/lib/inode.c b/lib/inode.c
> index 7958d43..48f46b1 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -6,6 +6,9 @@
>    * with heavy changes by Gao Xiang <xiang@kernel.org>
>    */
>   #define _GNU_SOURCE
> +#ifdef EROFS_MT_ENABLED
> +#include <pthread.h>
> +#endif
>   #include <string.h>
>   #include <stdlib.h>
>   #include <stdio.h>

