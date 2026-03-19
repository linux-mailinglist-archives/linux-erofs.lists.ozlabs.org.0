Return-Path: <linux-erofs+bounces-2853-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAx8Ivv9u2mzqwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2853-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:45:31 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9152CC22B
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:45:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc6Qc2048z2ynW;
	Fri, 20 Mar 2026 00:45:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773927928;
	cv=none; b=BUcRG30p/nwTzR3lUpKCwWhTuR1Uhcncr0AGFxDuavkEyjc84H+MEWE1bV137ex5YQBOUvRIplm+GfxNpVAv3rSDuUoSkJxKdWm0Gnq13aTyNMr+EEoRXnJ0oDngVDcm542gHYwTcwYDQHt340wORTyGBJEnePiejbNMFlu2LBwo79FVNbYa/4BxzeaGZ7iPh0EkHXSIQ3eFyv7bk2OY0IvORoqBlpQplU4k9Pht1uklX7mNM8Ajx/xnWlRN7lnUVC8W5zYAQrPOVTJvYJFMCiHf0nKyxIMiUwn9LkcPFH9aI5z24cl6Ncgrg4IDRvEF60grx8JtMd0vwGQ+rszcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773927928; c=relaxed/relaxed;
	bh=jmThYtX+Ywp2CN+A5kyfMHB3rQPwaRVveThOn3JepwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M60ykjmIFgEo2Y8PwPddSOwP79pav661uGZ+BnOMtN8FLWOysiq23UcTqS805V9C3VWnhb0Q3l+25U2gK78j8KQ67FZG2rH4Pi7Sd9gkkkeBcWm6LwtPrFlzlya6eWhdJlBNH0TWVjY5FZa7GJP3gy29hyCRZuAUoNTykalshzNyWMWESQMAOPRwOKUk4Wv/WvjoKgliYHenxv2bwJUy4H29E2BW78f1YGEH8WtNgk1DiwNRWMTANmMrLB+42QqDX/noZHPY4rKsmqMuJperkBA/rUdO0Q6lk0DdbcbQ6h+jnRMXla6wKt8eg7mi6Tt3O3BkZwr/CME9AqU6NcANDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RU+xwlPu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RU+xwlPu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc6Qb17T1z2yLG
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 00:45:25 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773927921; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jmThYtX+Ywp2CN+A5kyfMHB3rQPwaRVveThOn3JepwE=;
	b=RU+xwlPuNYiGBqEmulxTstHlwTBg44WhYdJj+O8DUSzFsPe20C7hkZQr79ejUlGEptGGE/1nYEpFK0ALxyzTNbB37BwL6iYePBshARuZSOYymQes8rAqVnvv1ULWNKo0qicFVwIni4UOXTDgYLU/s04+IJlfRsd6iRgiYNhtIxA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.Imu5c_1773927917;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Imu5c_1773927917 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 21:45:18 +0800
Message-ID: <dc88120d-eb36-46e7-a642-78e626c97ccf@linux.alibaba.com>
Date: Thu, 19 Mar 2026 21:45:17 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: lib: fix meta_blkaddr handling for
 48-bit layout
To: Ajay Rajera <newajay.11r@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260319133948.396-1-newajay.11r@gmail.com>
 <20260319133948.396-2-newajay.11r@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260319133948.396-2-newajay.11r@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2853-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 9E9152CC22B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/19 21:39, Ajay Rajera wrote:
> Fix the FIXME in metabox.c by properly handling meta_blkaddr for 48-bit layouts. In erofs_writesb(), set meta_blkaddr to 0 on-disk when 48-bit layout is enabled since meta_blkaddr is encoded differently in that mode. Remove the now-resolved FIXME comment in metabox.c as the issue is addressed in super.c.
> 
> Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> ---
>   lib/metabox.c | 1 -
>   lib/super.c   | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/metabox.c b/lib/metabox.c
> index d6abd51..077f88b 100644
> --- a/lib/metabox.c
> +++ b/lib/metabox.c
> @@ -62,7 +62,6 @@ int erofs_metadata_init(struct erofs_sb_info *sbi)
>   		if (ret)
>   			goto err_free;
>   		sbi->m2gr = m2gr;
> -		/* FIXME: sbi->meta_blkaddr should be 0 for 48-bit layouts */

I don't think it's a valid patch, I need to find more clue why
it was a FIXME.

>   		sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
>   	}
>   
> diff --git a/lib/super.c b/lib/super.c
> index 088c9a0..99d2a24 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -209,7 +209,7 @@ int erofs_writesb(struct erofs_sb_info *sbi)
>   		.epoch     = cpu_to_le64(sbi->epoch),
>   		.build_time = cpu_to_le64(sbi->build_time),
>   		.fixed_nsec = cpu_to_le32(sbi->fixed_nsec),
> -		.meta_blkaddr  = cpu_to_le32(sbi->meta_blkaddr),
> +		.meta_blkaddr  = cpu_to_le32(erofs_sb_has_48bit(sbi) ? 0 : sbi->meta_blkaddr),
>   		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
>   		.xattr_prefix_count = sbi->xattr_prefix_count,
>   		.xattr_prefix_start = cpu_to_le32(sbi->xattr_prefix_start),


