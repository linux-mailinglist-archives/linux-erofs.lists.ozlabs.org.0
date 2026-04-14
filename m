Return-Path: <linux-erofs+bounces-3293-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIR8LfxM3mkzqAkAu9opvQ
	(envelope-from <linux-erofs+bounces-3293-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:19:40 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C63FB0BC
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:19:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw5y12Mftz2yVL;
	Wed, 15 Apr 2026 00:19:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776176377;
	cv=none; b=Eiz3zA8YZgWrY6nLrFFK4APusBsAxdGgXSJtD1X9plngr08kisKpeGLzwTfIbayE0+mzkbGi1NqprGJyFeNNAorgI/B9NMPt412rR65UY96z/9SXB3+zerw9p3NnsQ8xNzyNm89vDi7zFLn5sE6mu6yX7FUU8Pn4CjTKmuLDMy6uelTtQxsy70UtfTe/Gg5V/eA44MMcKw1w5YPOmf/xbub4i5IZxbGPaLHvwtK8763MhvYzv5cuyeYTHi0edCi+dSX4HIsuhLGm941qs+0tTc/3YjbhFWR3QALlwa3wcWEQ/K780XmlVoufMocJ6b7iEFHVpl3AySI7u1RzCIJ7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776176377; c=relaxed/relaxed;
	bh=otoATAnx7qhArAffWjEtTUnGtqcy79ewhelw1QrtjLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY55pGKILrLb1i79sqB7zxv/GrVhfd2Psm+eZAocfcMxGVRe2WDBel9IxZZ93K9VH7kuOmwBuKWTOcQxU47a32t6Cak/E2MiasQ3Dk7V/pt0jAYQKaTrubgadECEg/ZWeambsczPdmr+7YV6F4RK/eXieoolWFb/8s9Ka8c4Oz5UNFqNzbl61GwDfSryZgKH+qYsZZ+xqWGSVWTBtaRE4tpOtR9FmOaWpep2J9LYfKMVRJTBCA/6D5dyyePHcQweZg/Hpo8UsazpJOfZ0E/HsSDGlFmtn7E/BaBnI8IAblnkFaHAqARhTtX0uyf12lbt4XwcB1PXmQinGeDHIxEKfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nSRaf9Om; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nSRaf9Om;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw5xz3SBfz2ySS
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 00:19:34 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776176369; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=otoATAnx7qhArAffWjEtTUnGtqcy79ewhelw1QrtjLQ=;
	b=nSRaf9Oma1Vo22LCTII7I5RoK9syBthhrEJXlat0N3UJB807w1lR2zraAMy76x9JGZVYMB/LqLdSrPLGXaZ4sFG9vkz1TXSCv/s0ujAuGkhPG+EuifEo7f8+8b0wJNPooaYm/esvNaVS3yNtzA5EAXUIekG0vMN15PBWwSkH6vQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X11g4Jr_1776176366;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X11g4Jr_1776176366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 22:19:27 +0800
Message-ID: <fb13fd1a-e929-4c7b-a8cd-ca0cc80d0ab0@linux.alibaba.com>
Date: Tue, 14 Apr 2026 22:19:26 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: tar: fix out-of-bounds access when
 trimming pax path
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260414141313.46575-1-zhanxusheng@xiaomi.com>
 <20260414141313.46575-2-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260414141313.46575-2-zhanxusheng@xiaomi.com>
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
	TAGGED_FROM(0.00)[bounces-3293-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
X-Rspamd-Queue-Id: D96C63FB0BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 2026/4/14 22:13, Zhan Xusheng wrote:
> When a PAX extended header contains a path consisting entirely of '/'
> characters (e.g., "path=/"), the trailing-slash trimming loop in
> tarerofs_parse_pax_header() decrements j to 0, then accesses
> eh->path[-1] which is an out-of-bounds heap read.
> 
> The tar header path trimming had a similar issue fixed by commit
> dcd06f421003 ("erofs-utils: mkfs: tar: fix SIGSEGV on `/` entry"),
> but the PAX header path trimming was not addressed.
> 
> Add a j > 0 guard to the while condition.
> 
> Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

That was addressed by others before: I think I will add
your `Signed-off-by:` into the original patch.

BTW, are you using LLM to discover bugs too?

Thanks,
Gao Xiang

> ---
>   lib/tar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tar.c b/lib/tar.c
> index eca29f5..3d92f48 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -509,7 +509,7 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
>   				int j = p - 1 - value;
>   				free(eh->path);
>   				eh->path = strdup(value);
> -				while (eh->path[j - 1] == '/')
> +				while (j > 0 && eh->path[j - 1] == '/')
>   					eh->path[--j] = '\0';
>   			} else if (!strncmp(kv, "linkpath=",
>   					sizeof("linkpath=") - 1)) {


