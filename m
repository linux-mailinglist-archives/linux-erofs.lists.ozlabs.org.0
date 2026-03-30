Return-Path: <linux-erofs+bounces-3084-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJXLM8vVyWmO2wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3084-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 03:45:47 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC38354A38
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 03:45:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkYx40lNCz2xly;
	Mon, 30 Mar 2026 12:45:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774835144;
	cv=none; b=HGBTYymnId767EeQEhZ1mKlCgOZ5MPAdzqXB3AW4ERUzcHME6XjqOUhrt1hLCkmQdREoFk2FBNjxeXi+gFKX5LUnz4MXML+j6E2FpG9ZSbUcmJ2s35iqesndYrsTIyflXeOH7/pkSUKLu1NKq6qNvoqZSNzuNO8pRY+xwQSvxmT47lfmnciv23egD2rKbkDKh+vb67bjuOM9FfNC/tCIN0y62+Fh4BAQdDtqp6y4qMe650cx5rnx9S/rEIdg5I3IaIfG3gnMJ/RGjZbPm/iKweCp/dbTYJ1faRTYhb2Z4ZxNuv4xiuqctBw2cvfdJLHFcew0XQ4TivOobDxKH5M86A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774835144; c=relaxed/relaxed;
	bh=yue2kRuUKBxWXT+eQPsYC0Q8ZWpLaD3+yheMEly2kuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QXCWUKPACryKS/uWcJNzkUmVEPayOFj1IRgZqosFFsZxpGHmUGYxA02iMb9EUfrKWRbAsCVl5qrkOy9QQWt2z66PgI5ljWdDBJ9vnilO8sZWUKDY1J9F9/CeLqir7i8G+cXafqQf8GIOD50D06r8FSSDxDIGLWZrT/dxsxE+rq9o2Mkdx7VtfWD3fcvEZ1qJxOR7+uwL4qqpYIxxvRAv8DJcPmTCnl5c5DFNH4/UCwtBsF9v61dkUOipHgTb/+zc6bMFnR5Xw1IIyO1vFzCaEwJuo8VSOcq3peD9GnKLIhjVNW+aVfFjxylhDTnaVAkJXqgxIF1Plrj3ZooUyrEpRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SbHuoiqR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SbHuoiqR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkYx30Znlz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 12:45:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774835139; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yue2kRuUKBxWXT+eQPsYC0Q8ZWpLaD3+yheMEly2kuk=;
	b=SbHuoiqRVVXU+XbcJZZ07R7+2CGmX8wCRF9JOJg5F55dPFO3Q44KjdXc8u011H53tEgJ7lRt7geaXNhb6mv42RKv0d5fkJQwuOFogwT/OuMwUcD79S0KkKs6KD/35/FlToPsMz4cNBW0eFBcnk12pNHVOXKtFMVAz1SqbxqMUrU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.tjB3s_1774835136;
Received: from 30.221.131.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.tjB3s_1774835136 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 09:45:37 +0800
Message-ID: <9ab35d87-8421-4fac-a116-829392cbc51e@linux.alibaba.com>
Date: Mon, 30 Mar 2026 09:45:36 +0800
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
Subject: Re: [PATCH] erofs-utils: fix typos and enhance installation guide
To: Ajay Rajera <newajay.11r@gmail.com>, Saksham <aghi.saksham5@gmail.com>,
 Gao Xiang <xiang@kernel.org>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20260328201555.5192-1-aghi.saksham5@gmail.com>
 <CAMhhD9gRZTgxOqVJ0np9JO4kUuNBao2e2WEMmhfGCjwzdogqiw@mail.gmail.com>
 <CAMhhD9jUqxY3H7Let-cnpaOh3vijL7jJ78=9zEjw0yDRA8F6WA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMhhD9jUqxY3H7Let-cnpaOh3vijL7jJ78=9zEjw0yDRA8F6WA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3084-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:aghi.saksham5@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:newajay11r@gmail.com,m:aghisaksham5@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
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
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: EAC38354A38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/29 09:04, Ajay Rajera wrote:
> hi,
> Also, I noticed your commit message is missing a Signed-off-by tag.
> This is required before any patch can be merged.


We will not consider any patches for the README or docs/INSTALL.md,
as most content is superseded by the website.

Instead, I hope I could find time to rephrase the README to
reference the website instead.

Thanks,
Gao Xiang


> 
> Thanks,
> Ajay Rajera

