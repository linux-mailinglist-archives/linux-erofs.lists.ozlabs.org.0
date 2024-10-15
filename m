Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1C99DEDF
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 08:57:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSQ052Kggz3cG8
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 17:57:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728975459;
	cv=none; b=YB2yl437E9nR/PUCCuqxjpSqzYpbRUBhu99kgfRm/qobqMRc6ms3APzt/aVde5ZyWN980K2jdtugm3nsbHl2xD1sahjr90pFRRwECgu+eybSCD5bJ8R6H4YFxWjO3y+HdLigc1JuJ+sao1UDNCBSt9dMRM1HFnoHOHClpyl5TXCK7OCtCOnqi9JVoUPaj4hvT7V7amao1M8pG/lD2ya1y2f2iI32PbFg20nnIhU+EWrRhcgslHthj4AbSgHPG1QZANNmyStgLR0+TeKYYNRwpyawF006/5AwUr30Z5XFqvvVkgE2pKADDNpA6eUAhEZLikufA/mBCXTM7LpJFYD80w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728975459; c=relaxed/relaxed;
	bh=B8nxFyU5YMoHcqu1ZHV4lDe6X80IG0w/RG5iDyYGDEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7Wbtn5MgnfjxsWgcUEQDa/voCV8SYA6w+1+Y45xKtWF7XBTMZrz1MGoasQR8iTP0cSQbh1nIV4BRT/43Gsw6ULxCX9TElH9mMm27FGgJV9qR23MpCTAL5LsJpYxYXdzkx6ANsRxLA+UCUnRfOidRi3UET/gzwuNc1pNUyELhz7i4tBr6h10JN1WpnH+mU8C3hYanF+u0jJRWhp3ZFlzGyOuX8UKFoKRINnXF/0rkxRF0f6NtPlx+q0bvBQGMvzNqXt07vQShT9IZTLjpPTVVBgZRhctPGxOF80M+1qIBF1/Cnpokd9iMbmlv4AI2qLyjXWENZy6BaHAFPWPPcC39g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lRp2p7f8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lRp2p7f8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSPzy1ZCgz3br7
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 17:57:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728975448; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B8nxFyU5YMoHcqu1ZHV4lDe6X80IG0w/RG5iDyYGDEA=;
	b=lRp2p7f8DzTymk7GEAc/nM5/0/bm+ASyxcRpCwLqy7CT43nR1wknOs6TMOLt2JLzquoWCsyO4Y/Fd/9S6aZBOf2wrFomdtwumVktbCD4jlMvtFxBZxrZ/MSnyYiHl7kcptwFXDEFQ0W5Z8fRewmRz0Wecn1TVM728zmswvzDnr8=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHCKdPH_1728975447 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 14:57:27 +0800
Message-ID: <f14d3bf9-ae99-40fb-ac4f-a0bd905259e6@linux.alibaba.com>
Date: Tue, 15 Oct 2024 14:57:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix blksize < PAGE_SIZE in fileio mode
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241015064007.3449582-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241015064007.3449582-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/15 14:40, Hongzhen Luo wrote:
> In fileio mode, when blcksize is not equal to PAGE_SIZE,
> erofs will attempt to set the block size of sb->s_bdev,
> which will trigger a panic. This patch fixes this.

Please fix trivial typos:

erofs: fix blksize < PAGE_SIZE for file-backed mounts


Adjust sb->s_blocksize{,_bits} directly for file-backed
mounts when the fs block size is smaller than PAGE_SIZE.

Previously, EROFS used sb_set_blocksize(), which caused
a panic if bdev-backed mounts is not used.

> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> 

Unnecessary blank line.

> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Add support for blocksize < PAGE_SIZE in file-backed mount mode.
> v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/super.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 320d586c3896..abe2d85512dd 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -631,9 +631,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   			errorfc(fc, "unsupported blksize for fscache mode");
>   			return -EINVAL;
>   		}
> -		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
> -			errorfc(fc, "failed to set erofs blksize");
> -			return -EINVAL;
> +
> +		if (erofs_is_fileio_mode(sbi)) {
> +			sb->s_blocksize = (1 << sbi->blkszbits);
> +			sb->s_blocksize_bits = sbi->blkszbits;
> +		} else {
> +			if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
> +				errorfc(fc, "failed to set erofs blksize");
> +				return -EINVAL;
> +			}

Please use

		} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
			errorfc(fc, "failed to set erofs blksize");
			return -EINVAL;
		}
Here.

Thanks,
Gao Xiang

>   		}
>   	}
>   

