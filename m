Return-Path: <linux-erofs+bounces-3569-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTKeFc98KmqrqwMAu9opvQ
	(envelope-from <linux-erofs+bounces-3569-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 11:15:59 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67926670505
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 11:15:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=NH2TiiTH;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3569-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3569-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbcSq6VwNz3br5;
	Thu, 11 Jun 2026 19:15:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781169355;
	cv=none; b=Ne2CBWepHAqJRuJlROAvcUBvS7CObYLQwN70NNOY3SbKGQH1N4uUZt1yy8KHO7v1lLYHf08V56eNR7SOc8slquVkDJTTqwhCMAQlujQBcVgGfCTYAHVJ+HYuWRPWSNjm7zGEQDNmcJQ0p5wtu2r/9lYjCASNvfY/mlWwIutwZHN1H3XEFrlEL7VOlAvmC1EbRf3TPoHtpVqv0DNkXMLgMAzU59GkmW2SrhVfJFFsPEF6Yn+Y1ZQ1Ru3lYGb1BnRlhBhWiOu1+A9jGO1eauvVaQBAVLbtT+zaM7ZuiK0rn3Ufem2ADjoL4S1cZkMszCq4b25w7tdMKSdFjc1H1UgUww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781169355; c=relaxed/relaxed;
	bh=S6tgzNR2qNaGmT5d85SshtWC8LBHugAl7ubxS9vxpHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uc2HrTti+BfX3I46UX952E9H3ppr7g66E+GVbWEn3s9jmz6VOfWR/369XrPn0wfbqQAqIFwyDHiYzWX0mdTEtH/wmc7K8tYgYEnkt6ioqU4qWgWi+A8p4wO2+O0l75uE2x8au9L7z3ARSbcVNgtQ7OQNSMok473iCBc4Qq2v8/yQkgi5F+EkKygHo++VrcwLW3cULe+9Z4/yXkjuH7R5bBK/HlR40j6xCX2P1lSsZAx2Y2km2i935LZwqAiKd+s4iB+zXHp7DsoM6Fe2AkK86cw5vQmQcAexf30yBI/LeASOlwxoUiYCAnNUeeLBkTmS3iunFuxItihEZb1hiUtP6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NH2TiiTH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbcSn3lf0z2xLk
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2026 19:15:51 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781169347; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S6tgzNR2qNaGmT5d85SshtWC8LBHugAl7ubxS9vxpHE=;
	b=NH2TiiTHhAGMo1STl6hnj2dDZoIfPt8ZN3DLlRZFRqLWAAP7ne+onvf1YfPSEUwYEZIpvmdHhpvYdfkb7aB4QBi+pqcQHbwg11FjcZVUg+SkbBUhF6kgKTcOSWAFL8WgWF4JZlTOepwEWLiPssjB4OG4XTK2IAtJdMHOx6YLASo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X4dFDSO_1781169345;
Received: from 30.221.131.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4dFDSO_1781169345 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 17:15:45 +0800
Message-ID: <423c662c-e8b4-4802-b7bf-34abd71a82ae@linux.alibaba.com>
Date: Thu, 11 Jun 2026 17:15:43 +0800
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
Subject: Re: [PATCH v1] fsck.erofs: implement thread-safe global LRU metadata
 cache
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260611083601.81061-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260611083601.81061-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3569-lists,linux-erofs=lfdr.de];
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
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67926670505



On 2026/6/11 16:36, Nithurshen wrote:
> This patch introduces a thread-safe metadata cache to reduce redundant
> I/O and decompression overhead during fsck extraction.
> 
> To ensure it remains highly concurrent for worker threads extracting
> pclusters, the cache utilizes a bucketed, rw-semaphore protected
> architecture modeled after the existing fragment cache.
> 
> Furthermore, to prevent out-of-memory (OOM) scenarios on exceptionally
> large EROFS images, the cache implements a strict Global Least Recently
> Used (LRU) eviction policy. The maximum cache size is dynamically
> configurable via the new '--cache-size' parameter, which defaults to a
> safe, fixed threshold of 32 MB.
> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>

why `malloc()` will prevent out-of-memory (OOM)?

First, either erofs_read_metadata_nid() or erofs_read_metadata_bdi()
will read file to the page cache; and currently there is no cache.


But you introduce another cache using malloc(), since it increases
the memory overhead, why it prevents out-of-memory (OOM)?

Thanks,
Gao Xiang

