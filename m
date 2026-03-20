Return-Path: <linux-erofs+bounces-2886-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GyYKP9TvWlr8gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2886-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 15:04:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B973E2DB8BA
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 15:04:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fckpM75gHz2yYy;
	Sat, 21 Mar 2026 01:04:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774015483;
	cv=none; b=GuWroqDQWcDZMdzIVnamE/M6+t2U4KG5ZydWbWsSopQClezbQKuYeHF8CKfxTsnkb/NNuhiy0wHL9bym2hYmvTVUam0fqwLsqVcpj4NNBlkLIFUmNdphiyKQlK6LrXIatF9bUMvYksPGDPu0nlgfzRytSloZNCMhR1soF/jo1Vsa0xI2G9M4kCcr5q9K2rRDSBILV6TGzwGlP/MhsWKX+khgly1l2Jz90X17OH/ikOCPRYXhFYDfv4ApI5PfzxpQoqcxggYbAPN9E9k8oLYadqulX3VHuIXMutPqSyfyIIYUQvRipX92MXfAWv5gPv4tMssPybASZhLvLUkjFKSbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774015483; c=relaxed/relaxed;
	bh=EO159A6Wy1ihusCnd5WKF0W53I3nW+EPgPAMESPutYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq+1UORmw5XwXpBxS87Ub73e0IhG3LVAJQnm8kLpVWsedwc6bN2aKo0jrPc7OYf8A5XPBSKg2p+Vh0IyQjgfavKBEDl7deyNqQ3Rb/pjKyRUfnGHp+DH7SMVsDxC341qQmx1GoOwY2Y1bo5Schr9Jt/DtWm5hDHvfvWiumrhm1/Z4StJTGRnxWyNcBxstuEZLQoxJ3z51j1Vz23OUVFbr9E0wtSlVBYjvq14kMJaOvaxEJg7JdJad4MIuW0/X4ExBoYBXmbvYkE/Kta+FCVEZiKuwsNuif6Z2iDdV6KrbVsrK10lweYBI51g7Uil70d/vowxKoc1aWmMnH2H47FZXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KHI1kfZ2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KHI1kfZ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fckpK3jLwz2yY9
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 01:04:40 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774015474; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EO159A6Wy1ihusCnd5WKF0W53I3nW+EPgPAMESPutYU=;
	b=KHI1kfZ2Jh2JMiBM73Sx2v2bvVMXO5LysZIzqWCHXm030IKpu6z8qw+E4i2AtfAbFYi2+CzCJWBMAT//bdnGyeiWLmLbgf32xsDV0Kqs4AxG3yft0SX8yQikZqiC1dKAIcHu5YgeD8TtJWNHNHFQz904baUGmSTgA/MDyGW8Rms=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.MEN28_1774015473;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.MEN28_1774015473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 22:04:34 +0800
Message-ID: <c8668fb5-a714-44e6-8cb0-dd043a45ee84@linux.alibaba.com>
Date: Fri, 20 Mar 2026 22:04:32 +0800
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
Subject: Re: [PATCH] lib/metabox: fix 48-bit layout metablock addressing
To: oz456 <reach.netway@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, zhaoyifan28@huawei.com
References: <20260320135934.67331-1-reach.netway@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260320135934.67331-1-reach.netway@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2886-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:reach.netway@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:zhaoyifan28@huawei.com,m:reachnetway@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: B973E2DB8BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/20 21:59, oz456 wrote:
> Set meta_blkaddr to 0 for 48-bit layouts instead of EROFS_META_NEW_ADDR to properly support large filesystems.
> Tested on normal and 48-bit layouts; meta_blkaddr is correct.
> 
> Signed-off-by: oz456 <reach.netway@gmail.com>

why all you guys change this line?

If you don't run into anything, could you please
not touch this if you don't know enough about the codebase?

> ---
>   lib/metabox.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/metabox.c b/lib/metabox.c
> index 12706aa..5e55cae 100644
> --- a/lib/metabox.c
> +++ b/lib/metabox.c
> @@ -62,8 +62,10 @@ int erofs_metadata_init(struct erofs_sb_info *sbi)
>   		if (ret)
>   			goto err_free;
>   		sbi->m2gr = m2gr;
> -		/* FIXME: sbi->meta_blkaddr should be 0 for 48-bit layouts */
> -		sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
> +		if (erofs_sb_has_48bit(sbi))
> +			sbi->meta_blkaddr = 0;
> +		else
> +			sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
>   	}
>   
>   	if (!sbi->mxgr && erofs_sb_has_metabox(sbi)) {


