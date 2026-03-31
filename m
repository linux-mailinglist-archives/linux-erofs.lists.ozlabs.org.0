Return-Path: <linux-erofs+bounces-3136-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dpVtJ6ZFy2nSFAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3136-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 05:55:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 283A1363C49
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 05:55:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flDm15Nzmz2ybQ;
	Tue, 31 Mar 2026 14:55:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774929313;
	cv=none; b=a0loR2BCSACOnf6v4/m8+2LbFCVDR9rwuMPXQBeX6xLvUJoJODi3Um1vySHHLT0ultMq8mdmJ6jCFlESYLGFddAMXd0JQWgqdI5qNf+dlYAeTiP2JpfpwlDFINWXcOcAOIGoHHufUf6xebh5Ig8kzZqksCmevbG1sxqe6Sw7Otou1isDqEuMVbBI8nfSOzLQtOUKtcw56BAZ9/7HhsYVvp9PTThmYOaWS31ON9VVf6uOfXOHy4A+C0keqb7aRHhUIujHL7lIlJQ4mjPCy37tFl8FDm/Mp/eXS26p5zI6l9ljtsnq/lyiddlPw/e5vpPXtMz8sC4ueiYea9Ku+Aa67A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774929313; c=relaxed/relaxed;
	bh=90nLfsMsqKPNUBQhqb1+gfAb9vhKGrTCZbMIRgMjGTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV60vJXcYjq1BvK0NsKP6wOQLHz/j7H0QmEl7yyTmZKC0Vs2fhtbS0hMZDmUoAWl+4C8ny9dbML+ogw9FJlir49uZ9WVBLEqyGnEujW8PorTaokkaWczSiRraPaRuzAJyMhqBa92BvP9Ii1j2tlZvAHLEX3X3PQAXCrTHzSO5oWPJ8+hpTE+rO+EtiVbcsV8ikigJiVGjdyZyUdTaRK/cRMesVc70y+UdHnLQN0/Q//kBc+9rupKdMQRCEnu7/uFP30xxowRQ3dlWCardc56x0DQNaY9swV9WbqP/NSUDqEDkNBr4iw/4pmXzuOxPSIHuyNc/1lI1LyazanXrKge2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UV9eaiU3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UV9eaiU3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flDly6Zqbz2xlK
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 14:55:09 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774929305; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=90nLfsMsqKPNUBQhqb1+gfAb9vhKGrTCZbMIRgMjGTI=;
	b=UV9eaiU3UGQp8OWBH2oNek3G2j0/V6RtdlVDSahSekDwlp7kATasrYKxv5BrkvlDNE1fNOFRdsJi0/aUVXOpjBCc9Y6y+5Y4XBwMU7t8jcdX/wMR4V54htrku7Po36cjy3OaMsMdRMy05v/0VEw4nZ7Eyw6MdyYUp+bgtyBlmEw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X02vttY_1774929304;
Received: from 30.221.131.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X02vttY_1774929304 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 11:55:05 +0800
Message-ID: <1828ed19-e9d0-4908-926a-0e0a9c3d04af@linux.alibaba.com>
Date: Tue, 31 Mar 2026 11:55:03 +0800
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
Subject: Re: [PATCH] [PATCH v2] erofs: fix missing folio_unlock causing lock
 imbalance
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260331033300.21366-1-zhanxusheng@xiaomi.com>
 <20260331034631.21945-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260331034631.21945-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
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
	TAGGED_FROM(0.00)[bounces-3136-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 283A1363C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/31 11:46, Zhan Xusheng wrote:
> folio_trylock() in erofs_try_to_free_all_cached_folios() may
> successfully acquire the folio lock, but the subsequent check
> for erofs_folio_is_managed() can skip unlocking when the folio
> is not managed by EROFS.
> 
> As Gao Xiang pointed out, this condition should not happen in
> practice because compressed_bvecs[] only holds valid cached folios
> at this point — any non-managed folio would have already been
> detached by z_erofs_cache_release_folio() under folio lock.
> 
> Fix this by adding DBG_BUGON() to catch unexpected folios
> and ensure folio_unlock() is always called.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

emmm, the patch subject needs to be changed too, like:

[PATCH v3] erofs: ensure all folios are managed in erofs_try_to_free_all_cached_folios()

Thanks,
Gao Xiang

> ---
>   fs/erofs/zdata.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index fe8121df9ef2..b566996a0d1a 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -605,8 +605,7 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
>   			if (!folio_trylock(folio))
>   				return -EBUSY;
>   
> -			if (!erofs_folio_is_managed(sbi, folio))
> -				continue;
> +			DBG_BUGON(!erofs_folio_is_managed(sbi, folio));
>   			pcl->compressed_bvecs[i].page = NULL;
>   			folio_detach_private(folio);
>   			folio_unlock(folio);


