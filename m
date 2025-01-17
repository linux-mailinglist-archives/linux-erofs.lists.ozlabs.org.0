Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE36A14C27
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 10:28:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZDtm1X4nz3clK
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 20:28:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737106110;
	cv=none; b=A7xwpJmfeNu8L/US4/d/ugV8wALz0YgBvkD/UeKuqzSfD7lZhE7D3VQQFE/cORuqfa8Yzxo2CVSA83EnYkvixxOZN6YfayXVUblDxiyFrhc4Y0dTSxUkAZNwv6lLTKPIQlg75ukWl85d20PSk4i/EuUZc+yNWyjGnkqvxaEBz7J3QVAC6Ud3v9I5iPgnKbBuSI4ta+kIbWvkySL2Xa506hO6uQtfSXNcCeH7S/Ngo5r10eMcF/iw0QZrYBhSghQXpGjveLN47HXhVVW/C3v2CF4usXiu3gCg7AEnbpyWAP8Q45S28+cDGMD3djeOpT+/qQTl6sC0Jaj7UgU0WuMaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737106110; c=relaxed/relaxed;
	bh=Iz21gsIr5e0wBKPF6pWFNo5BSeIFGVssbdWYguDsET8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLweUt6ttooXHZtRWbosriPpr+4wwT9mLZexRtbclwEYUzNHCP63G4n+bPtF4EfBNwmTwPtmezyM8wPBIuTxSP2RQr4+u+z9c6RqQ/On79izXznIN+FsNANY/+vShDGvuV7wOxv4RBRLFqhmTuTOuOaUfKdoMSiHpbTyt/fskHvsLFPPp/DT9YDcLz0W9+20Eu+DmLrQPlvCLxQv0QnIyYujjoUbmGPcZihyvaoCM3a3SRq9FGXRsKwc3J6NT8xKmLVUUEQNpGI99EI2fKadwC/oZIoJOOKTigbvO3UmaFq2FpoCWDCHWJyo22N2oi5tDiljopwQ5H8PhvSQ/vQhdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L9t41OiP; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L9t41OiP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZDtj0Kk2z30TQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 20:28:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737106103; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Iz21gsIr5e0wBKPF6pWFNo5BSeIFGVssbdWYguDsET8=;
	b=L9t41OiP1Z5NunZcYbG7KVbFG9YhfP/2ymGb2z5YMyy8wDV9N0093KUHjKv+RyqbEPbHJnuOYhdsLhhojI3Qao6/GpWXTPmdmHvT7as4SbKCvzAbUyxM8Yb9Ik3gAdz3tUzuSB45TNDRTWqtiqhqptmmYWo2GeW9Kt3XPKYqEag=
Received: from 30.41.10.74(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNoJmAa_1737106094 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 17:28:21 +0800
Message-ID: <649afa9b-5724-4b52-8b9b-9a82a3c1468b@linux.alibaba.com>
Date: Fri, 17 Jan 2025 17:28:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
To: Chen Linxuan <chenlinxuan@uniontech.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linxuan,

On 2025/1/17 16:52, Chen Linxuan wrote:
> While reading erofs code, I notice that `erofs_fc_parse_param` will
> return -ENOPARAM, which means that erofs do not support this option,
> without report anything when `fs_parse` return an unknown `opt`.
> 
> But if an option is unknown to erofs, I mean that option not in
> `erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
> which means that `erofs_fs_parameters` should has returned earlier.
> 
> Entering `default` means `fs_parse` return something we unexpected.
> I am not sure about it but I think we should return -EINVAL here,
> just like `xfs_fs_parse_param`.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

I think the default branch is actually deadcode here, see
erofs_fc_parse_param() -> fs_parse() -> fs_lookup_key() -> -ENOPARAM

then vfs_parse_fs_param() will show "Unknown parameter".

Maybe we could just kill `default:` branch...

Thanks,
Gao Xiang


> ---
>   fs/erofs/super.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1fc5623c3a4d..67fc4c1deb98 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -509,7 +509,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   #endif
>   		break;
>   	default:
> -		return -ENOPARAM;
> +		errorfc(fc, "%s option not supported", param->key);
> +		return -EINVAL;
>   	}
>   	return 0;
>   }

