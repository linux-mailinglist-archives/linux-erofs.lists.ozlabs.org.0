Return-Path: <linux-erofs+bounces-2716-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FP2NoaIt2m7SAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2716-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 05:35:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E72949F4
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 05:35:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ2M540RLz2xln;
	Mon, 16 Mar 2026 15:35:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773635713;
	cv=none; b=RvXDci0cOfnE7Q636RUQvmRSvCVaiyv9VC1+geXgUS9f4DsaN2DDav8SdoaPNS06wAWl5uNWr7IQpuTeRHoB6wW+TY8DcWQg1iTGjF5geziMtrP7N0gZHNsppkmFW0LrUZhcFPpMfj37ny3APpg1w+1mdi9XTiCk9R4m77IwiPZtL/WfBgIegis33NISC3o9NaVYVdodh1K/7Cyfya4lZbHv0SNHWnHIm2biDOwE5sX7xVfMBkGvOYHIA0FoILwBb2QdtxR/Nr4a4/4NTa5OqVqaRc/yWepRcX2pTjmLI+l/3yzEQ+OgnCBAyUL3yKvLqS6PZoWvEg7HraKvrnjzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773635713; c=relaxed/relaxed;
	bh=X/Ex+L90uGBTy9QCe1FBRoWX1zvmrETLBvk4ndfxp2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jjy0bUEgH4TU3TqrED/S+jUimSZ+91RvKfPRjMovOlGXaU06TXV7Uo7kEfAyeShUDPondMMHEVVrTuXnfWFqQMevifBvJRoVH1oEdocmVD8H3x6tpEv5+2syzhB8W/5vJhCcETPzYK5zP8LtiIUrhnB2nk48ChX71SUlOFpvNXVKrqfobkOHBjRNDQurDO8mjOEtix0aW7k5iCOex5STEMoH8xcJC3NzPGRgidqCksbpICM7xnY5hX1jpNjJ8s/D4ubuqPL39K+Exw+6fIUQr3T5rTyoXxGma7sJZQs03OsAQ9FaSB+LXenmUcNpgBhltO7g5oQ6Fq+q9uN9aPgFQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rSvgMpRX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rSvgMpRX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ2M26xPtz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 15:35:08 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773635704; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=X/Ex+L90uGBTy9QCe1FBRoWX1zvmrETLBvk4ndfxp2Q=;
	b=rSvgMpRXs44ewyLD1MXgBNBOi+7tV8LE4JjfDflOmw22ZnYNmHI+8ohNp1+VD8TRgNNRYzpBHo8QWdqTg7KHRJXSZN4kq1kDGqfeNuvU1rXjd4WQYpUfRnpltStLiv/L74lpj3rp/qHUIztjk+EKmDYwv1mBafFLgKe11CRE3CQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.-ggdd_1773635703;
Received: from 30.221.132.167(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.-ggdd_1773635703 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Mar 2026 12:35:03 +0800
Message-ID: <2d26643a-6830-4667-81fe-2f03ea031f6d@linux.alibaba.com>
Date: Mon, 16 Mar 2026 12:35:02 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix potential NULL pointer dereference
 in docker_config.c
To: Sri Lasya <lasyaprathipati@gmail.com>, linux-erofs@lists.ozlabs.org,
 ChengyuZhu6 <hudson@cyzhu.com>
Cc: gaoxiang25@huawei.com
References: <20260315191422.1392-1-lasyaprathipati@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260315191422.1392-1-lasyaprathipati@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2716-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lasyaprathipati@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hudson@cyzhu.com,m:gaoxiang25@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org,cyzhu.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D01E72949F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/16 03:14, Sri Lasya wrote:
> Signed-off-by: Sri Lasya <lasyaprathipati@gmail.com>
> ---
>   lib/remotes/docker_config.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
> index 00db1bb..b346ee8 100644
> --- a/lib/remotes/docker_config.c
> +++ b/lib/remotes/docker_config.c
> @@ -38,7 +38,6 @@ static char *docker_config_path(void)
>   {
>   	const char *dir;
>   	char *path = NULL;
> -
>   	dir = getenv("DOCKER_CONFIG");
>   	if (dir) {
>   		if (!*dir)
> @@ -203,6 +202,8 @@ int erofs_docker_config_lookup(const char *registry,
>   		}
>   
>   		entry = json_object_iter_peek_value(&it);
> +                if (!entry)
> +			continue;

The patch format is broken, also Chengyu could you review it?

Thanks,
Gao Xiang

>   		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
>   			b64 = json_object_get_string(auth_field);
>   			if (b64 && *b64) {


