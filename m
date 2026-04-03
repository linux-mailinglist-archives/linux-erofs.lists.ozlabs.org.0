Return-Path: <linux-erofs+bounces-3189-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNamBbFPz2mHvAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3189-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 07:27:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE5391149
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 07:27:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn6fh3q8dz2yVP;
	Fri, 03 Apr 2026 16:27:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775194028;
	cv=none; b=C+jkS8po27wVIfMG3DVt/AqLJ7LUQKIQWiI1uUPqbQbSAQ5Am4zpd8RD/fvZBUbkvg+WRWM3N/jYvIh69dIVS1N+skj/YPB1F5ZhU+bNs8c1luXa0d+QynVhOM1NEnPDNaThxTUH0qb5D4GkO+8Km7LqWj0a2Ve75rhGiVYxnpQCDXVFEGXbf6NvFwtMn7j09sLsF3rpqGrXJkZq4uIOQHoN8V1pDYhaL8lo3snxV7Ja3b7UjvnOkh7RoY3jFxGn98GPrEvPPMcWIUrAsKtOELj+rWdLyJCZvfihPYKyLNDgRa+te595cFxVOT4RlJaXrQg81eHsedKqdTBSECPuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775194028; c=relaxed/relaxed;
	bh=8FXLUe5auZS0Plf2f8ZbXlDB0X1M0R90JJpBq7zD4bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3uYAtSnWWfaRIrgoKF2IFZWG8jKrfiDK0AFasYG/cOQZYRJS9ufZ7hPt+o/dL/5uK/6j55Doxc5aiUHgrWrRK4girb4+9JCVuBLRz+7pwFW5DBSVxbeif6lM/OpD+AtAVXMzTslbO9CJQoIYgdWRKC/sXsRESD0XWgpsHN7/PMKIAawJQUOU7ZfMMGW88WdOonLf/MPHgC2fXpVacTnDLMl5GX/oha2QnWxeGaTrKqNIPGMGMzDRQzw7L1ltf2/Dscevo8P0PJltxsE5UFcLhHa4cZre0x5/0yh2Vy8FQ23iizmJ61usy3gkB10f85eeFq80+U4L1rjbnF1sNfBYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TQX5Cqzs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TQX5Cqzs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn6fd6FNKz2xln
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 16:27:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775194019; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8FXLUe5auZS0Plf2f8ZbXlDB0X1M0R90JJpBq7zD4bE=;
	b=TQX5CqzsO2aRVguy3cuRgToTvKUY4Df/Ac9N+mDk+ZaDyKCFwfYEd1GBkXl08+VhmO7PnDiyCv1ZJVL8dw84yAeeAhxRoK9qFDlHy4kkf9usxR0KjlOWdQiNMps1eyh9SvJeX6MRp4SW6x3yx89wk3AoR0xEpTxG9dYOjUR3HzA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X0J9M6W_1775194016;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0J9M6W_1775194016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 13:26:57 +0800
Message-ID: <f54ce712-9d7b-488b-8dc2-9d5e2455f80c@linux.alibaba.com>
Date: Fri, 3 Apr 2026 13:26:56 +0800
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
Subject: Re: [PATCH] erofs: handle 48-bit blocks/uniaddr for extra devices
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260403033409.70704-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260403033409.70704-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3189-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email]
X-Rspamd-Queue-Id: F0FE5391149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/3 11:34, Zhan Xusheng wrote:
> erofs_init_device() only reads blocks_lo and uniaddr_lo from the
> on-disk device slot, ignoring blocks_hi and uniaddr_hi that were
> introduced alongside the 48-bit block addressing feature.
> 
> For the primary device (dif0), erofs_read_superblock() already handles
> this correctly by combining blocks_lo with blocks_hi when 48-bit
> layout is enabled.  But the same logic was not applied to extra
> devices.
> 
> With a 48-bit EROFS image using extra devices whose uniaddr or blocks
> exceed 32-bit range, the truncated values cause erofs_map_dev() to
> compute wrong physical addresses, leading to silent data corruption.
> 
> Fix this by reading blocks_hi and uniaddr_hi in erofs_init_device()
> when 48-bit layout is enabled, consistent with the primary device
> handling.
> 
> Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Yeah, it seems that part was never implemented,

but could you fix

__le32 blocks_hi; in `struct erofs_deviceslot` to `__le16` as well?

`blocks_hi` shouldn't be `__le32`.

> ---
> Note: erofs-utils also needs corresponding fixes for the write path
> (erofs_mkfs_format_devices) and a swapped hi/lo read in
> erofs_read_superblock, which will be sent separately.
> ---
>   fs/erofs/super.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 972a0c82198d..a04e70ef4fcc 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -177,6 +177,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   
>   	dif->blocks = le32_to_cpu(dis->blocks_lo);
>   	dif->uniaddr = le32_to_cpu(dis->uniaddr_lo);
> +	if (erofs_sb_has_48bit(sbi)) {
> +		dif->blocks |= (u64)le32_to_cpu(dis->blocks_hi) << 32;
> +		dif->uniaddr |= (u64)le16_to_cpu(dis->uniaddr_hi) << 32;
> +	}

Maybe just

	bool _48bit = erofs_sb_has_48bit(sbi);

	..

	dif->blocks = le32_to_cpu(dis->blocks_lo) |
		(_48bit ? (u64)le16_to_cpu(dis->blocks_hi) << 32 : 0);
	dif->uniaddr = le32_to_cpu(dis->uniaddr_lo) |
		(_48bit ? (u64)le16_to_cpu(dis->uniaddr_hi) << 32 : 0);

Thanks,
Gao Xiang

