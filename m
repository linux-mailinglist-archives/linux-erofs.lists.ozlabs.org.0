Return-Path: <linux-erofs+bounces-3765-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /siwBAbtPWpn8ggAu9opvQ
	(envelope-from <linux-erofs+bounces-3765-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 05:07:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E056C9E64
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 05:07:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=vTQxF2Fi;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3765-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3765-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmgb50HsWz2yYd;
	Fri, 26 Jun 2026 13:07:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782443265;
	cv=none; b=DU3VcbET8YPhgU2r6c8t5UVOQCWPSZF0eagB8ILnoreA75b4XHAPKbyrQnGXvTvkspRDCKTumpxBVLvUDDGc1J4ksDDPI34xx+MyFcDM8GmmQZ//nMyn0mG1oxKnXZSRKcvGiuixxOerueRrauB5ijr7tEf8lv3wnHGuHlmDMnK5Ky2iqen5cYlG1qkhHcC0PV+/NgbhBqfcHbdJ5hSDHLrsHFxybVqg+1F3cz3cc8gQFKBeoOVZmVNPiFtui9KAXzMUI9RazFQRFg3djZgGxJv8obcG0GHyad3cBXsxMvotxXtoAJb2SPfiKOEOs56H1Srv9qu+JUlYzZ4W/Pve9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782443265; c=relaxed/relaxed;
	bh=tpvP1gTTjKO9mWiQo9mmtsd0JXKt9aUPSrs6vqyAZEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eEsw/6lt/8lV4TW2gda5PveXLx3f/tU6VyUtZGn1yjZvtfWP/CASnaNmK2gNDdZ/4QbwhWbXNpqPuVlJMM5/ENmEAyBO09Nc9GCiQKRXdUN4igUOYa/qK9TBncADNytBqYybSYwi5RzdaCPAEKsBOTJON0gxm79YChbvYVY5xvBKiGU3jXJftz/6KsZsKxRG8O/Ae6uf8hDofGqZ8rzJXjmpNfTTreqkDROKIxrcvOWgTWogTECKl1Pk9Z5KT/8Z54V8dZexh/P9pMZZQ9DQZ4Kr0+aLfRZ6HQ3Hy4lo4ne+5I7uDnFcgbi0+oBu33vRYJIoZBjTC/ncL3OGR/P2TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vTQxF2Fi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmgb23hzfz2yVv
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 13:07:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782443255; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tpvP1gTTjKO9mWiQo9mmtsd0JXKt9aUPSrs6vqyAZEw=;
	b=vTQxF2FiVRN/yfH2TUnPViJKwMUdrEuwlgbvgW+l5bKcTDrWfW4OeyDTujZmWpKHmPUbOOBtj1K/NF5v1xzMzLnyAePnrQOlZ/m5BoXQvPI5Je9LTTty0ViQwHToTcU0szJC0PF3G08NMEEg3WuQ66yDyQgevJYTKem/uz1qgzQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5dHhnu_1782443253;
Received: from 30.221.130.253(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5dHhnu_1782443253 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Jun 2026 11:07:33 +0800
Message-ID: <448694c1-40e4-471c-ba28-08fad1cc79b0@linux.alibaba.com>
Date: Fri, 26 Jun 2026 11:07:32 +0800
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
Subject: Re: [PATCH 1/2] erofs-utils: tests: register chunk-based inode test
To: Yifan Zhao <stopire@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20260626025025.805563-1-stopire@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260626025025.805563-1-stopire@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stopire@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3765-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53E056C9E64



On 2026/6/26 10:50, Yifan Zhao wrote:
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Yifan Zhao <stopire@gmail.com>
> ---
> maybe just squash it with previous patch...
> 
>   tests/Makefile.am | 3 +++
>   tests/erofs/031   | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index cd1971a..a1e31fb 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -129,6 +129,9 @@ TESTS += erofs/029
>   # 030 - regression test for NULL dentry on hardlink-to-root tar entry
>   TESTS += erofs/030
>   
> +# 031 - test chunk-based inodes
> +TESTS += erofs/031
> +
>   # NEW TEST CASE HERE
>   # TESTS += erofs/999
>   
> diff --git a/tests/erofs/031 b/tests/erofs/031
> index 3b2a059..f8ede34 100755
> --- a/tests/erofs/031
> +++ b/tests/erofs/031
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash

It shouldn't be `!/bin/bash` since other platforms
which doesn't have bash will skip this and _require_bash
is used to switch to bash mode.

>   # SPDX-License-Identifier: MIT
>   #
>   # Test chunk-based mapping with shared chunks across inodes


