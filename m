Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396668AFFA9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 05:29:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vU9Pf8Z4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPPcV2LMbz3c0H
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 13:29:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vU9Pf8Z4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPPcN25bXz2xqq
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 13:29:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713929373; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6+3vy5RW94Ou/P4a51UJp53U0IfxqdYqVf/uzowYFLE=;
	b=vU9Pf8Z4Souqdsrz79+lf1Lg/uPbteXg1ktHvxgmGmerLHCoKYsPFqT7hnUbdBPE75PCAh0A9vxf8lqHRZ9UuOPQUabu9DhJHVSDGqP5koxEqiSi4FyjXhFSx538mO6N9iJ4nL59NcpximtnAK/CSiM2vdOmknj+/8X9U2nfo+E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5Alj4X_1713929369;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5Alj4X_1713929369)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 11:29:30 +0800
Message-ID: <871467f7-1218-4c13-ae47-13e89bbbe0cc@linux.alibaba.com>
Date: Wed, 24 Apr 2024 11:29:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: modify the error message when
 prepare_ondemand_read failed
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20240424023945.420828-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240424023945.420828-1-lihongbo22@huawei.com>
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
Cc: huyue2@coolpad.com, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


(+cc linux-erofs & LKML)

On 2024/4/24 10:39, Hongbo Li wrote:
> When prepare_ondemand_read failed, wrong error message is printed.
> The prepare_read is also implemented in cachefiles, so we amend it.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Could you resend the patch with proper mailing list cced with my
"reviewed-by:" tag?  So I could apply with "b4" tool.

Thanks,
Gao Xiang

> ---
>   fs/erofs/fscache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8aff1a724805..62da538d91cb 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -151,7 +151,7 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
>   		if (WARN_ON(len == 0))
>   			source = NETFS_INVALID_READ;
>   		if (source != NETFS_READ_FROM_CACHE) {
> -			erofs_err(NULL, "prepare_read failed (source %d)", source);
> +			erofs_err(NULL, "prepare_ondemand_read failed (source %d)", source);
>   			return -EIO;
>   		}
>   
