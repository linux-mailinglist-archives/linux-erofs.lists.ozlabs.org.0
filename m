Return-Path: <linux-erofs+bounces-1509-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C1CCA207
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 04:03:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWwTV6LL8z2xpg;
	Thu, 18 Dec 2025 14:03:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766026990;
	cv=none; b=RKJGmk2WClTyUlLxG7EOv2Rl1G60lSIPHOGfzNFcp87J/IVhtlAYLgy6+KeYgrFPNnMHAUnFLvv2hQwFmDe8IkI1eCKvWuxoI+QtdPmReU9bZeiR/HPClN8wV1JIXT5D1urQMYilJubboJWjW5VLpaLKMwuK1bhOMkBFZUVBADkK0NsViOM+LtSzQB4KKA54FJOtdaUx/mwHvAFKbdy90XgQBNoqSfWAby5/YOaCSyOZNTMImlI1Ysd+Hvdd1znQv2mxzyvoFkQjEHW6FTtcJkKUUFD0rcSpAAsfnh2T96hr4VFlD6INwNH+8kTx+7xVtsVKVykw3l1hs6P5iTa/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766026990; c=relaxed/relaxed;
	bh=/p9v/7P8G2nkpG33YfeBu+GqgEjXSnj2Lz7Bm8EiiFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJVlhFcEdYO6CY9J5LX8Hh5zzDXwh6bvvI8tTIccXvXRWsqO1FEXh5PeTGaFfFX5x3lAuxstFkFyBp0kMcmajf3gIDtz5En8BipZFHJ686f8KQ8e+wT6Qqd7B3tWpTpSer533FWHULs1eZPssMiK+5SL72PcdCLf5aDIZ7++6fht7YyD1diHwbWUiaYH1oiv3+Es6z6CdCoaXjyGAnA0qUw0t9ORQ1X2iD4HPR0LB7ieBYCUneI42JDc3lrgYcYJl0iRQ10aj0JBQM5G8Q3l8NGX7uLMyFwq9fGxD+ebrWMzrOCz2tfprGSG+iPPjpUq3BfT9A7onzSQ5HTNHSbH7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aqf1iPxe; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aqf1iPxe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWwTS3J3Yz2xDD
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 14:03:07 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766026976; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/p9v/7P8G2nkpG33YfeBu+GqgEjXSnj2Lz7Bm8EiiFs=;
	b=aqf1iPxeX1lF/o3ToPOllklwB46ihPtoRY2jH4jiyEo3Jxd0Cjw1c3b+IT7At1A8wnNKor6LkZ5MntZdBgU5Wz0xwwga2lFRqaCDSgJ57uNtk/h8UXjd4nIxnIEXDnIUBlnuMRqNfGsE2rrGqY4HHjQsttLlt03OaO7o8Vz8I0M=
Received: from 30.221.132.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wv6Uryb_1766026972 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 11:02:53 +0800
Message-ID: <d4a41ddd-726c-4dee-a563-12b2b83d071c@linux.alibaba.com>
Date: Thu, 18 Dec 2025 11:02:52 +0800
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
Subject: Re: [PATCH v2] erofs: simplify the code using for_each_set_bit
To: Yuwen Chen <ywen.chen@foxmail.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <tencent_9E5D8E4520DCDEE3CBAE5BE70D79F95FFD08@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_9E5D8E4520DCDEE3CBAE5BE70D79F95FFD08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/18 10:57, Yuwen Chen wrote:
> When mounting the EROFS file system, it is necessary to check the
> available compression algorithms. At this time, the for_each_set_bit
> function can be used to simplify the code logic.
> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> ---
> 
> v1 -> v2:
>      - revert the modifications to the fs/erofs/internal.h
> 
>   fs/erofs/decompressor.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 2ec9b2bb628d6..be1e19b620523 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -405,7 +405,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> -	unsigned int algs, alg;
> +	unsigned long algs, alg;
>   	erofs_off_t offset;
>   	int size, ret = 0;
>   
> @@ -423,13 +423,10 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>   
>   	erofs_init_metabuf(&buf, sb);
>   	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> -	alg = 0;
> -	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> +	algs = sbi->available_compr_algs;

Can you update as what I suggested?

Assign `algs` first, and then assign sbi->available_compr_algs.

Thanks,
Gao Xiang

