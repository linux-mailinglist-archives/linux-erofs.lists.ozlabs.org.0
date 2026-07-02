Return-Path: <linux-erofs+bounces-3801-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TwiNI4BfRmoXSAsAu9opvQ
	(envelope-from <linux-erofs+bounces-3801-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 14:54:24 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815286F7F5C
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 14:54:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=MMYceTon;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3801-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3801-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grcK92pHLz2ynC;
	Thu, 02 Jul 2026 22:54:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782996861;
	cv=none; b=GS9TC+l0U35fAym4/l9otMOs1LzFWq5u/plQSM2xcD3PeWdBxX4y0cemaqQegzBWd9BfT02M1NBJE3W754FiK+YTw4kcrBisWNHiO3Z6EqNkiAonPFEMPuL5cb6nPaQbveo/CLRF2ev5HJI5PMDrJN/Osv+afJQa8RL/3qi2hrW8morYUUI1WMrYDMze3UCwMVioGmsZxNM96OGJhvh7wNHklk4kEyER8HadvrzIcHi4Z4Cv1FwgXvwj8lojhHQ6SLrWh6jVIjqhwWMO3bd0GvAcpnde8l/3WMn9/Qu3INWZGsWzaDeHneVpZvZYJupCCGgIjY1fXEFHSh/F5WguoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782996861; c=relaxed/relaxed;
	bh=lGnzS5hZ5Fvf5v2QvUzvF1aUNQ32G07pyG9xm60BJuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWkBW5lO4ORO/HdkOpcajPu9MJO7aXvShQ+tZmlrcuKFUO+X2Z+R7unQcr48c2aUE0OpEx63Al/1E6dI/zxyHgYSk95jyS51rswrNDiFHdVp3FHfyE52IQGXgGOoYfIr0krhJMdNjlx3XaJ3LOlNyUfRGjGeJb7fj3ObJSricH31KRgO8c7k79/ITFS0KRZVMbzCQOn4wHaQoi4qhDRWjggF3u5f1vGei5YSG0jKRbQ+IKae26soyqKQv+r4RrGo5bMMr01pPSAfgdi1TLiM+JglaYW6NiqpN+o3xvZFIDvvsrSYj4ip0iD8tN3GNQYNOzEaOkAY4LB+qFmE3P63JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MMYceTon; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grcK71zjjz2yYq
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Jul 2026 22:54:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782996853; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lGnzS5hZ5Fvf5v2QvUzvF1aUNQ32G07pyG9xm60BJuQ=;
	b=MMYceTonJPqqJEdGbxiNTiRfXX94FjfDPGcn5HgnhBsX2UyvulsbgkhqmTEC/fNS98j1L7I59cExC/YVSzqJH3WhHO4vNTWaVJSuv42B1NA0I5TRLEgPomyur+shC2q+0nAR8YKqi7bYWDr+UuykGnGwCTalRm16YhBnua/6Vxw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X6Em1iF_1782996849;
Received: from 30.180.134.80(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6Em1iF_1782996849 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 20:54:10 +0800
Message-ID: <75a94b5a-011a-4b7f-bd98-5b40d756f842@linux.alibaba.com>
Date: Thu, 2 Jul 2026 20:54:09 +0800
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
Subject: Re: [PATCH] erofs-utils: fsck: add concurrent extraction and
 decompression
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, hsiangkao@alibaba.com
References: <20260702081030.10038-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260702081030.10038-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-3801-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@alibaba.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,alibaba.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 815286F7F5C



On 2026/7/2 16:10, Nithurshen wrote:
> This patch introduces a multi-threaded pipeline for fsck.erofs,
> combining parallel directory traversal with background pcluster
> decompression to significantly reduce extraction time.
> 
> Key architectural changes include:
> 
> - Thread-Safe State: Removes the global dirstack array and
>    fsckcfg.extract_path. These are replaced with per-task localized
>    paths and thread-local linked lists to eliminate data races.
> - Concurrent Traversal: Refactors erofsfsck_dirent_iter to allocate
>    task structures and dispatch inode processing to a background
>    workqueue (z_erofs_mt_wq).
> - Asynchronous Decompression: Introduces z_erofs_mt_read_ctx to
>    batch pcluster reads and decouple decompression from main I/O.
>    Limits batch size dynamically (32 for LZ4, 8 for compute-heavy
>    algorithms) to balance CPU cache hits and memory overhead.
> - Memory & Deadlock Safety: Implements inline backpressure during
>    directory iteration. If pending inodes exceed workqueue capacity,
>    execution falls back to synchronous processing to prevent
>    recursive thread-pool starvation and unbounded memory growth.
> - Synchronization Primitives: Adds portable condition variable
>    wrappers (erofs_cond_t) to ensure the main thread safely waits
>    for all pending background inodes before exiting.
> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>

What's the relationship with the previous two patches?

Thanks,
Gao Xiang

