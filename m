Return-Path: <linux-erofs+bounces-2896-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCNRGskpvmmtHwMAu9opvQ
	(envelope-from <linux-erofs+bounces-2896-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 06:16:57 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759C2E3531
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 06:16:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd72m4zMCz2yYq;
	Sat, 21 Mar 2026 16:16:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774070208;
	cv=none; b=not0bSXCYmuRpiO64NyYFdT9JsbPJWf7ELVkTWHcAmG9Eq3uzoRSQw+KfZvjG7tq906HV7IczRerlk7KJH5FPuLeE9hQ6OubbNnABjBxG90MhrOUpDuTcbwlUi1rKN9wEnpefnWofynk2LLA2dvkfAGKm7ji4XRTOvpEAl6p51lUib3R2oCDPAwUR137Z7rcOJURptIjgsew5bAIgI68/212G7LtcJwcf+SJ5hHA5SxpgtkST1oK7G+9RqHaVuMOytM9bESc/h8g1JZgD91UaKen/5unVePWFq2a9CM3vFIUd8ZeZiN5x3gaSOP3f1SB5+YoARWVkUAWUEFsLQsRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774070208; c=relaxed/relaxed;
	bh=gJr7YRfigAaFvoUGMhjRgt17fBZ1PHu5Dw4qTqGIyC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFMMn2a+CKvom4qBODl7Pt+scDa2xx5ZCIv8nRO04Ag2tru6gZ491mvo4fenWSHMMhvUvfySkuXtLYnx97kF29DNt+tKvLCUkpA7zDT8wwF0znU3DTmEHAgpgAyZQKTN32P0SaKTaTpop7KRUInW6YHmTNmwoJa68Rqx9LPTSVVlR0VaSjPCsjCi8qcx5IoLqglF68IPQPgRDVnHMsES8in5tIbuHegI/ZBy2qE7ioEIGBth5GFKGp61n1+yNI8ZsnupZ5pC5VQ4C7PKhGDdb/NeG5Kdfzqm/eRuZNcUfTMyBwAR5BDm1zx6jL01JcxZWQn1X/NFHZYPGt9QvhJyqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jx3QB5QH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Jx3QB5QH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd72k13mCz2xP9
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 16:16:43 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774070198; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gJr7YRfigAaFvoUGMhjRgt17fBZ1PHu5Dw4qTqGIyC8=;
	b=Jx3QB5QHgE7WVIzDCDF3vi0WMyc6g/xpo2mUskdv1AlsQ3vyt3tJo47f+Hk5X0fnNZfG2GBhxUQzlCXgpso+wiIISCchfEZJKDpAosYnZ2qw4oLoCu886UrF3/lEIm4FvzKZWgA4RxAhdpkNePOG5gwi4ersOnWuLepDxCjFvVQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.O3csY_1774070196;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.O3csY_1774070196 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 13:16:36 +0800
Message-ID: <d8e7345e-a1cb-4234-b03f-a3089f7a1c27@linux.alibaba.com>
Date: Sat, 21 Mar 2026 13:16:36 +0800
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
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on
 error paths
To: Nithurshen <nithurshen.dev@gmail.com>, newajay.11r@gmail.com
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20260320165200.1862-1-newajay.11r@gmail.com>
 <20260321050725.60268-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260321050725.60268-1-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2896-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 7759C2E3531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/21 13:07, Nithurshen wrote:
> Hi Xiang,
> 
> Both the patches LGTM.

I only see one patch here, if they are unrelated, please seperate
nto two patches intead.

> 
> I tested the missing return by truncating an image to force an I/O
> error, and the FUSE daemon now correctly aborts instead of hanging.

It seems the first one can be formed into a testcase
in experimental-tests?


> I also dynamically tested the memory leak fix using Valgrind with a
> 10MB file and an injected Z_STREAM_ERROR, confirming 0 bytes lost.
> 
> The only note is that this should be sent as 2 separate patches in
> the same thread.
> 
> Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>
> Tested-by: Nithurshen <nithurshen.dev@gmail.com>

Thanks for the test.

Thanks,
Gao Xiang

