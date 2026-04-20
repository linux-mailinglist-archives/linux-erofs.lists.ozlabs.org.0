Return-Path: <linux-erofs+bounces-3328-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCw7E/GG5WnCkwEAu9opvQ
	(envelope-from <linux-erofs+bounces-3328-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 03:52:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB68426194
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 03:52:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzT5G5QJVz2yrK;
	Mon, 20 Apr 2026 11:52:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776649954;
	cv=none; b=kv0raeRZRgCk76CRbngb7+VImY4dPJo3gzWRxusrl4dcaTOx2csLUEioA6QAj13m/EsLtMq4Q1qCVqab1uIK7y4rxkfz3ksiTHp8s98oldGHWFgj7UH3m2pqftXNsQUVEFl6XVjbrHYb1BRJRIhOJ5akI+w342vVvK1Dw/1vy2n82g1rF829FxoDkQnuuPLulFRwqsyukGk/Af2TIyVFc3ay/xYMPVTXdS33saomJyhzygDiY6VXCqsRCbnV/a2uUePUOyDbs0jIq5Yyxji6t0xX/f+xfw73fa/DezwmDMVDIYFmNj6pXI33MTi6D0VjCthmNMrAW0asg4s4UYNhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776649954; c=relaxed/relaxed;
	bh=KsdauIfAR68RAruVGluBtZ6ReMPY4MnBQFFBpKbgVVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngY1NUPFMZtpRhP2Y0utjX1Q92Cila5miAayl8uD7xhjSuiatUCFM3hIrDfZVY33/A7rUpxdUEC3+8feIZC324QCnVKccUrnQ41rQm1lEjUve82Ab2e6va31mvKzC9i/j5moRhte84fXbShV4XyOdXX84LET0/bXbDeTXlfxpkVdmWH5aCOx33mUQWh1va+aDh6e9/J40oRmBCf3Rgw+kH2SKa+CDuo5VvpoT87DiVSGtV2UfXae2ZTeVMCK4io72SHSeNdaZQy7L4WvQMK0IYDMswuqqm66VbXGstVBTQsBAl9V5OBe7tsaMTyaCrbLC9MzxB2dOBri6zhtBNyaFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p3o4t93c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p3o4t93c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzT5D32cJz2xSB
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2026 11:52:31 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776649947; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KsdauIfAR68RAruVGluBtZ6ReMPY4MnBQFFBpKbgVVA=;
	b=p3o4t93cVxVCD0d43HNwIn/EAtNTX/hqXoHX3rURnco9s2NGqGivJbtFbLPoeI93rgX33mUwZ+yig5PSd1JrR/XKD4R6gXQrAXWptFFNzy7Fmzra/TUKA543clbfdNSlilP5JIEO03d+NBEsnr1rqyR12aniJQCSlwOUoqmyJ7o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X1Gaqux_1776649944;
Received: from 30.221.130.173(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1Gaqux_1776649944 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Apr 2026 09:52:25 +0800
Message-ID: <00f14a87-6914-4e4a-96f1-6d0f911edc4d@linux.alibaba.com>
Date: Mon, 20 Apr 2026 09:52:24 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: fix undefined behavior shift in
 erofs_init_devices
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260419131604.95875-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260419131604.95875-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3328-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 6EB68426194
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/19 21:16, Nithurshen wrote:
> In erofs_init_devices(), roundup_pow_of_two() can potentially trigger
> an undefined behavior shift if the incremented 'ondisk_extradevs'
> value results in an overflow or an input that leads to an
> out-of-bounds shift.

I wonder why there is "out-of-bounds shift"? why you all
think it's an issue? Can you please explain in details?

ondisk_extradevs is 65535 at most.

Thanks,
Gao Xiang


> 
> Promote the argument to u64 before the increment to ensure the
> rounding logic operates on a safe bit-width.
> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
>   lib/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/super.c b/lib/super.c
> index 088c9a0..10831a7 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -49,7 +49,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>   		return 0;
>   
>   	sbi->extra_devices = ondisk_extradevs;
> -	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
> +	sbi->device_id_mask = roundup_pow_of_two((u64)ondisk_extradevs + 1) - 1;
>   	sbi->devs = calloc(ondisk_extradevs, sizeof(*sbi->devs));
>   	if (!sbi->devs)
>   		return -ENOMEM;


