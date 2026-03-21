Return-Path: <linux-erofs+bounces-2894-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ZWSIKAcvmklGwMAu9opvQ
	(envelope-from <linux-erofs+bounces-2894-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 05:20:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246B2E33E9
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 05:20:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd5p24d69z2yYq;
	Sat, 21 Mar 2026 15:20:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774066842;
	cv=none; b=lqHc1ZjyoaM9sMpMckCwHWjbqqKRZ0zXNjKAiTknWs0n/7BcDngNsJ/+LnODueqnVv91b6FclIct7xuzyLZQe74mIdepUnW5riejVPrxbO8744d54HSp/MKN+Vmz1koSXGvpXTlxG5f5im0tiHOYTGKSq+wchjir4h+jw9u2TGPmzVsIWyJCO0mzOGf4m0nrzd7gVYFhGiZeu4LsyacB9VDFYx2sVEDzle1WfO33r5sCumkddVqwhOq8tx8aS7bRaxqoBWaWdQloz6QBJFbu0f9wwqn5waiaKfQvsWbdvJVxkZo1fenSk4y9gztHB+rcqhCKjzV4XW/az2b5vpRAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774066842; c=relaxed/relaxed;
	bh=ajFeoL5dYeJSusxlsuigxp7xqJJEnbugSx7q8yEaprE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CMwLvo73Q4o+OjyZBTzrl/Oa3Mqd7qARTyu3V3wPYTsmDewVeQCv9oAKu2U9fDc6KTXFBB/J91vEfCKmYQpy4Yktr6gJrkFBjvyia9ysDTWqqnC/1sn4Rgdr4eXkNmmqprevfQq+CR7SAIRSCmcuP8yhpISYYnkbEfwWztIikPreQIX/jGzgC/1zmZBFVxMBSj4OVazlf4Py4Q/exnKeod17jmT2HlexT0OZM/bdUQTbFPPeKyu+Ezl3L2h0OzTTEMM276sNNb/OfpxOVDiwZKeu/NEO4IS+w3N1k92sZHAEDD/mJAdtf5ENQaKBjYo6P1APxc/yIrUwHVdfMtQXqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RXSYz+HZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RXSYz+HZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd5nz37thz2yVt
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 15:20:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774066831; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ajFeoL5dYeJSusxlsuigxp7xqJJEnbugSx7q8yEaprE=;
	b=RXSYz+HZPNJYOYtxHEkw232bgjU2zcmm6C5Ni1Xq+Tige0a2gvP2RkhCOwUGSa/NSGoyd+iSe8IELW0QYsTtgdTXRCTgnonX3C1XkKV6lmarnfjeAYW1BQZmHS2YahE+sKL7Xh+mKWM3JtA5e80CD776mmn/VA5X2wFm/nRce+c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.Nu3v1_1774066829;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Nu3v1_1774066829 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 12:20:29 +0800
Message-ID: <85f0e47b-6554-4bbc-8167-336cfd522e6c@linux.alibaba.com>
Date: Sat, 21 Mar 2026 12:20:29 +0800
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
Subject: Re: [PATCH] ci: add workflow to mark tags as GitHub releases
To: Kamran Alam <kamranalam4555@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAF7tac4iNk5msT0A6wOfuDHTSP1gcHx1xq20uiM9fy+A4GsdiA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAF7tac4iNk5msT0A6wOfuDHTSP1gcHx1xq20uiM9fy+A4GsdiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLACK,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kamranalam4555@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2894-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[v4:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 8246B2E33E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/20 21:05, Kamran Alam wrote:
> From: Kamran Alam <kamrankhan0368@gmail.com>
> 
> This patch adds a GitHub Actions workflow that automatically creates
> a GitHub Release whenever a new tag is pushed to the repository.
> 
> This addresses issue #22 - currently tags exist but are not marked
> as GitHub Releases, making it harder for users to find and download
> specific versions.
> 
> Signed-off-by: Kamran Alam <kamrankhan0368@gmail.com>

The subject of all erofs-utils patches should be started
with "erofs-utils:"

> ---
>   .github/workflows/release.yml | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/.github/workflows/release.yml b/.github/workflows/release.yml
> new file mode 100644
> index 0000000..release
> --- /dev/null
> +++ b/.github/workflows/release.yml
> @@ -0,0 +1,20 @@
> +name: Create GitHub Release on Tag
> +
> +on:
> +  push:
> +    tags:
> +      - 'v*'
> +
> +jobs:
> +  release:
> +    runs-on: ubuntu-latest
> +    permissions:
> +      contents: write
> +    steps:
> +      - name: Checkout code
> +        uses: actions/checkout@v4
> +
> +      - name: Create GitHub Release
> +        uses: softprops/action-gh-release@v2

That is too simple, first it needs to extract the changelog
from "Changelog" and only contain the necessary content.

And it needs to generate static Linux binaries if possible.

Thanks,
Gao Xiang

> +        with:
> +          generate_release_notes: true
> 


