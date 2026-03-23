Return-Path: <linux-erofs+bounces-2961-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAc9LDJRwWnqSAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2961-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 15:41:54 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C21992F502A
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 15:41:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffbTq04qmz2yWK;
	Tue, 24 Mar 2026 01:41:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774276910;
	cv=none; b=dOcaYq6kZI8d6lhAHBS5DNgym5SSAT47cHRULoO8NlfWdkzN4yVzft1efzokKJFyAAOZTrUNXIQHLe4p5IE9FZSga1Z+5o/F3Q0oH9C+49LLCI7+cQr5/9Q4W3i7HL6Mgb+C8e7ReHYzbeVjdrxO1sFUwdcRxPukmVIhtgpF/sA+gWWGHP/BXdvCiml/Fs8Gv1JIvKby3G47+7SiVzvo7h9sPuB+snwJ+lPXpKrg4I/1lAJZ2m/XzZeGtdNirURvnDGavj66pdQHj4zz/C68yL7aBZTQoyOXWHp81N07LFAbi0xm+4Ye23GJtK4FLVMKrbA2YMO8ObdyMrf7lIlVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774276910; c=relaxed/relaxed;
	bh=0MLXON+tffXeSNtv8HxcDcXnRXOeI/mVCRcpRJJJa3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBfu43RHDyvJISmygig+8zN489qR7Z03xkOmJntvmunzoc3Vh0tp3pz4/cS4xEM9FOs5LI05GgzEpQwmcTcDugol+xJujf2f0VRkOAFgn7U94x3+vu4DmlmNVgF+4HIUIXFILKg33BU75/reiD8oWf3hlprRRVxiTUhRKan3SC/8GBuqMQ07RpcuEZ9i0XkMY3q1tV/VtWR+WjFuXbDDMYR5ztltg4l1GOpHi9qtqw3oiVHxD9Zuxd9WFp/ldjLfTdkBjk5Hhi9zq76qKpvJDHb4y3iyJy2erBVje6oMzbe/vcUQuYX0uLOVHi/8gbBPvha4gpV0p3YWwPKbALNRig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ImxOzGz6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ImxOzGz6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffbTl5Qgjz2yFb
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 01:41:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774276899; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0MLXON+tffXeSNtv8HxcDcXnRXOeI/mVCRcpRJJJa3E=;
	b=ImxOzGz6Sg49LTobg40OXNbhqmR0vrD9chNjjnxi/5hzDx3uSbWDHSvg8ScmZnvYoET4pctESwkP6sXcQAwWGPH3tffK3crc/mw5x7xWH+3GDsb8np1u9N//ObBUTe/ZGAzt80Jt+Bgj2g/qGPE6dxNRfAa3XwOMurPTHUB7FiI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X.YqmWQ_1774276895;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.YqmWQ_1774276895 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 22:41:36 +0800
Message-ID: <b761dcf1-db25-47f3-8ef6-096c7a2f0493@linux.alibaba.com>
Date: Mon, 23 Mar 2026 22:41:35 +0800
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
Subject: Re: [PATCH 1/4] fs/erofs: align the malloc'ed data
To: Michael Walle <mwalle@kernel.org>, Huang Jianan <jnhuang95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
References: <20260323134305.2675822-1-mwalle@kernel.org>
 <20260323134305.2675822-2-mwalle@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323134305.2675822-2-mwalle@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,konsulko.com];
	TAGGED_FROM(0.00)[bounces-2961-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mwalle@kernel.org,m:jnhuang95@gmail.com,m:trini@konsulko.com,m:linux-erofs@lists.ozlabs.org,m:u-boot@lists.denx.de,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: C21992F502A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On 2026/3/23 21:42, Michael Walle wrote:
> The data buffers are used to transfer from or to hardware peripherals.
> Often, there are restrictions on addresses, i.e. they have to be aligned
> at a certain size. Thus, allocate the data on the heap instead of the
> stack (at a random address alignment). Use malloc_cache_aligned() to get
> an aligned buffer.

Many thanks for the patch, I wonder if it's possible to
submit the patches to erofs-utils first (even make
malloc_cache_aligned() as another malloc() for example)?

Since I'd like to make u-boot codebase following
erofs-utils, but I don't think Jianan have the
bandwidth now, but if you have some use cases,
you could help syncing up a bit.

Or at least, let's keep these four patches in sync
between erofs-utils and u-boot.

Many thanks!
Gao Xiang

> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   fs/erofs/data.c     | 11 ++++-------
>   fs/erofs/internal.h |  1 +
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index b58ec6fcc66..61dbae51a9a 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -319,15 +319,13 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   		}
>   
>   		if (map.m_plen > bufsize) {
> -			char *tmp;
> -
>   			bufsize = map.m_plen;
> -			tmp = realloc(raw, bufsize);
> -			if (!tmp) {
> +			free(raw);
> +			raw = malloc_cache_aligned(bufsize);
> +			if (!raw) {
>   				ret = -ENOMEM;
>   				break;
>   			}
> -			raw = tmp;
>   		}
>   
>   		ret = z_erofs_read_one_data(inode, &map, raw,
> @@ -336,8 +334,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   		if (ret < 0)
>   			break;
>   	}
> -	if (raw)
> -		free(raw);
> +	free(raw);
>   	return ret < 0 ? ret : 0;
>   }
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1875f37fcd2..13c862325a6 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -11,6 +11,7 @@
>   #include <linux/printk.h>
>   #include <linux/log2.h>
>   #include <inttypes.h>
> +#include <memalign.h>
>   #include "erofs_fs.h"
>   
>   #define erofs_err(fmt, ...)	\


