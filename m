Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2D99DFBE
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 09:53:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSRD172m8z3br5
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 18:53:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728978784;
	cv=none; b=Tm4+FFHk8eC0sYuwlxFuT90Wr2vXfohxGEwV0TsgtS+MyzcZbEowk8dC/zLuQEDjh5xmDEzjHWOflbudOcHrcj3k1DG7Jzw/Rm8txGIyPHG/EFc8zjI08hoQMo+z0ACRARiRvta+Rv/nSTPMapypLmWcsa7m8WzIMJbURG7y9ln0SKNASF4yXN2NbIa2dm4XP4rc/+YZCvlPFsEkru4IhYZjMUVROxnfcglKmMUL3hqEysdPodlUFBjsESbRikRIlzzEjLU76C9YHN+ktEsbBBLQYn9UcgZhruKBWNlhYyeWRCbEQ2s+xdZy38urdFL4i+sXr1KZiFq0OlQMCaBTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728978784; c=relaxed/relaxed;
	bh=XmrO3mGDMdEdy6F/vjqBqNRpe+B/XqnieplA2yVTEyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anGFav0B94T8jSqxLkGKPsmGr32m9c4JmsWEhlmA3sgid5PjInueEg7YASkGXvy15qTEIGpsqfkkMZ8ap2w5QRVzkmpeg8d/iOgefGeRWXDmMHeM9ALelmUa7p/oBVYat0OTpzsVNVj0ZEII/nT5Ypv5a6TrjoaiQ4va6ZcTz2eZtPZKz8otX9tVMyjqd9/Gd/M8AeC5gJ22L3XUP/rJiKSmav1yGxILQDqQglyQRNS8+MGr9kAkevzf5DDz1rKC/cgIOS6BYjfAPyTKwjnr7S9UwtHMYFmHdyKQOoqdn5L+ccxL67U93ZZa1NQQEnDsyeabVgmnOuWSXgeJ55rBWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vWieYohP; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vWieYohP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSRCs74xlz2xpn
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 18:52:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728978767; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XmrO3mGDMdEdy6F/vjqBqNRpe+B/XqnieplA2yVTEyY=;
	b=vWieYohPv1dG86ovFVMWuIp9ImI8gFvod+7rQt5iY/Akr3tZsU8u2hYL/kDrCU9Yp1XChT2YX5XTInD4yAtsL3wGl6T8M84/fu8E8khwMIEnSCVYrhpy6YGEuaOZbQyVIN9F1FjwUOj2C/1x+trztSg0O8vUU3cULO5zroNCAr8=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHCxYGt_1728978765 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 15:52:46 +0800
Message-ID: <b0c38bac-a682-45ae-8991-b73991ae6ddb@linux.alibaba.com>
Date: Tue, 15 Oct 2024 15:52:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix blksize < PAGE_SIZE for file-backed mounts
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241015070750.3489603-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241015070750.3489603-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/15 15:07, Hongzhen Luo wrote:
> Adjust sb->s_blocksize{,_bits} directly for file-backed
> mounts when the fs block size is smaller than PAGE_SIZE.
> 
> Previously, EROFS used sb_set_blocksize(), which caused
> a panic if bdev-backed mounts is not used.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v3: Fix trivial typos.
> v2: https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/
> v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/super.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 320d586c3896..ca45dfb17d7c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -631,7 +631,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   			errorfc(fc, "unsupported blksize for fscache mode");
>   			return -EINVAL;
>   		}
> -		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
> +
> +		if (erofs_is_fileio_mode(sbi)) {
> +			sb->s_blocksize = (1 << sbi->blkszbits);

Why needing parentheses here?

Thanks,
Gao Xiang

> +			sb->s_blocksize_bits = sbi->blkszbits;
> +		} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
>   			errorfc(fc, "failed to set erofs blksize");
>   			return -EINVAL;
>   		}

