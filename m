Return-Path: <linux-erofs+bounces-2308-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG8BAMuZjWnU5AAAu9opvQ
	(envelope-from <linux-erofs+bounces-2308-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 10:13:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4912BCA2
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 10:13:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBV3C6Sj6z2yFm;
	Thu, 12 Feb 2026 20:13:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770887623;
	cv=none; b=XZ0m7KyHcBN6zwC8ppGeMHn4Z2cvo94ywiHzrD+sz8NybGBEYKIH1pddQ/rFR/CJ0SgeLZLwRu3kOzEdazhOfObPs6y6eANRxO5B52Tmp6/mU/pO/CAWV/pyz+7O0371QKRIgOxw9xyMgNVui+sOq8uXMf8z8xfKukF6UwSuzmidGP+s+ky+Kkp9uvY5WwnfBbriXj5EMwuvk9fOYL2IP0dXEhGxRnQwWByG+3BtCdPloQItTJEe0UR7hcsX5UdTTdPlrHFnnozdBHvyvbzcFk2s5Z8vCaYcIDvM7ZSai8nzaoPrjyT3lbFtHTvVtYPRBdhD4ooSydEnfPBYCEKXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770887623; c=relaxed/relaxed;
	bh=T5vDesjdOoGhx56ZacyCk6H9qHoYR/+fLyNaMI3C8lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAr6eZgzSGdMEyI+IjanNf64u7kCKcZH9iZ5RHJmAvseWa98DuzxuLqNRu/TPvdcU0vJkE+KqiswUjQH79gIgz/AvEoaqtdOj/Gbtk99GkpaRbkGYxWD5ozOOStpW6GWJ4Z8ZR/GBYCPJYjivh17jr9BDKUxiQse5gNxY2YKQHZfewpYSLmMMFsXW2In55Soef7cwlfYZ9sfhFc3HdaK+RaIpkr7xrmBhHms6tX2Odjc06j+87ub3sdyFYvMyXeNUkPL3A+416jtiZcYprKsRa96m42pF+c6QKQZLm33UYi1U5G2dx3PZzJA86+TatjfE5ezYTkFNjiNUBbYIEM0Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eBkk5Zhi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eBkk5Zhi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBV39291cz2xlh
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Feb 2026 20:13:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770887613; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=T5vDesjdOoGhx56ZacyCk6H9qHoYR/+fLyNaMI3C8lY=;
	b=eBkk5Zhi7NXreyqqx/1QfFqeXSanfkkMuEMERcj6KTnH3tpIuMJ+OKRHPv9YofrCcO3v781RTMFXssfuxRAfuN1FjkBDoi9Rnqi61p+F2rA+4w4TTHm5rPKo3solZJUrlhNSh+8sY7EbdaCh5a7b13ospxTG4PiP31lb9KSWz58=
Received: from 30.42.35.106(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wz4WUyF_1770887611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Feb 2026 17:13:31 +0800
Message-ID: <a4712179-0675-464d-8991-301e260f15bb@linux.alibaba.com>
Date: Thu, 12 Feb 2026 17:13:31 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: relax erofs_write_device_table() device
 table check
To: Jonathan Calmels <jcalmels@nvidia.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org
References: <20260212001302.72193-2-jcalmels@nvidia.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260212001302.72193-2-jcalmels@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2308-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jcalmels@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 24B4912BCA2
X-Rspamd-Action: no action

Hi Jonathan,

On 2026/2/12 08:13, Jonathan Calmels wrote:
> Avoid returning an error in erofs_write_device_table()
> if a new device slot table hasn't been allocated.
> Rationale is to allow erofs_importer_flush_all() to succeed when
> dealing with images with pre-existing device slots.
> 
> Signed-off-by: Jonathan Calmels <jcalmels@nvidia.com>

Thanks for the patch, could you elaborate how to use this?

A detailed command line usage would be better.

(Also honestly I will try to release erofs-utils 1.9 in
  a few days for the upcoming ubuntu LTS, so I have to
  finish erofs fsmerge feature for compression layout
  after the version is released...)

Thanks,
Gao Xiang

> ---
>   lib/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/super.c b/lib/super.c
> index a203f96..d38396f 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -392,7 +392,7 @@ int erofs_write_device_table(struct erofs_sb_info *sbi)
>   	if (!sbi->extra_devices)
>   		goto out;
>   	if (!bh)
> -		return -EINVAL;
> +		goto out;
>   
>   	pos = erofs_btell(bh, false);
>   	if (pos == EROFS_NULL_ADDR) {


