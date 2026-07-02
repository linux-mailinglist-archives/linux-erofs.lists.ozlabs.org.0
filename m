Return-Path: <linux-erofs+bounces-3810-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q9QxGgKsRmpobQsAu9opvQ
	(envelope-from <linux-erofs+bounces-3810-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 20:20:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 170406FBF16
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 20:20:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=ysJyI5CZ;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3810-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3810-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grlYp3zyCz2xdb;
	Fri, 03 Jul 2026 04:20:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783016446;
	cv=none; b=lSJ0YFjckOaF5VvAtQ3ezIpb5qvJbzZ/4ug2XBifnJHSzPxrUWofU6GrUyhiUXLcBNqwG2mrTrWUzlGcLMifgWX//f2YfiQ60cBKPC030c+BixlRQRJdcdv5mbpOyNEsUpxPPNC1U/9Q5zxlR3vgKq5uGI6x7+7CwH0AkBZBKfFKpX1HMnwvl6lKxielXFkDZM/hvifOOBhALuJHqckcnLwCpdLZXsB3SCVJoewbARY6gdkQnyKOD5hpK9Xmj2uzVwUXZSeQdBgK38PvCPCyayEu7b/I7g3NGqrxfe79eiquHTjiDmhFzVA65MTLrk+g8JnelLzXm1Y7mMlyk7f9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783016446; c=relaxed/relaxed;
	bh=UtOklQnkXd2hVBY7CgO90PEJph17GBCHJnKg5P8m5ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPftpWi76UW9cAadYgZQ57LN07WhdVuz01WrOcoJ3/VOUOHqUHU6gEYehHtg4HxcD82BAq5g58Eime8fj9QkJiw/AXYEJU53OXHLJFrTuaZ8fLtdzn7BF8JzlkIIAFIzwmfRUEiuyaMBxcREZOyhSRz6nK3blkghyiggzyTpiEIeWwdT9xWpLo95gEDVDwULOEM1jJyHyVhZ2n3xxL4KiaQpNzrYhPs8fQOSdk/QfYFHVMa2YkKVSyBhjyIzxq0T+cCjhnEzfVZnB0TniZMK6ZDle5ZcajNvUNEkmhDcoBsvClAkRy2Ddy4LNrNOcvCvehyIit7KgJdM+dUd/GcP8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ysJyI5CZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grlYm1SH3z2xPb
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Jul 2026 04:20:42 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783016437; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UtOklQnkXd2hVBY7CgO90PEJph17GBCHJnKg5P8m5ZQ=;
	b=ysJyI5CZDWntYo88dYtgSUgUKlm+M3EAM8dxVIj73s6CECUoQFUW9K6At1PaH28SE0oi0koKxfHTM/GnJoNNhTGXe1Why/s76YhGX/GeNfYaQMEIDNiPp7oSjfnHUC8hYRZQjyQXFvNWKCvnmF27bEuNoeVhk1CFG9VRumZHZPg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X6FihR0_1783016435;
Received: from 30.180.134.80(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6FihR0_1783016435 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 02:20:36 +0800
Message-ID: <debaf257-7222-402a-a5e1-2ac67f62ab50@linux.alibaba.com>
Date: Fri, 3 Jul 2026 02:20:35 +0800
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
To: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, hsiangkao@alibaba.com
References: <20260702081030.10038-1-nithurshen.dev@gmail.com>
 <75a94b5a-011a-4b7f-bd98-5b40d756f842@linux.alibaba.com>
 <CANRYsKjDbs6_FekTRpJeEw124m9D-mQJu-GvvUP2ms8y9uxK=Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CANRYsKjDbs6_FekTRpJeEw124m9D-mQJu-GvvUP2ms8y9uxK=Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@alibaba.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3810-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,alibaba.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 170406FBF16



On 2026/7/2 20:59, Nithurshen Karthikeyan wrote:
> On Thu, 2 Jul, 2026, 18:24 Gao Xiang, <hsiangkao@linux.alibaba.com> wrote:
> 
>>
>>
>> On 2026/7/2 16:10, Nithurshen wrote:
>>> This patch introduces a multi-threaded pipeline for fsck.erofs,
>>> combining parallel directory traversal with background pcluster
>>> decompression to significantly reduce extraction time.
>>>
>>> Key architectural changes include:
>>>
>>> - Thread-Safe State: Removes the global dirstack array and
>>>     fsckcfg.extract_path. These are replaced with per-task localized
>>>     paths and thread-local linked lists to eliminate data races.
>>> - Concurrent Traversal: Refactors erofsfsck_dirent_iter to allocate
>>>     task structures and dispatch inode processing to a background
>>>     workqueue (z_erofs_mt_wq).
>>> - Asynchronous Decompression: Introduces z_erofs_mt_read_ctx to
>>>     batch pcluster reads and decouple decompression from main I/O.
>>>     Limits batch size dynamically (32 for LZ4, 8 for compute-heavy
>>>     algorithms) to balance CPU cache hits and memory overhead.
>>> - Memory & Deadlock Safety: Implements inline backpressure during
>>>     directory iteration. If pending inodes exceed workqueue capacity,
>>>     execution falls back to synchronous processing to prevent
>>>     recursive thread-pool starvation and unbounded memory growth.
>>> - Synchronization Primitives: Adds portable condition variable
>>>     wrappers (erofs_cond_t) to ensure the main thread safely waits
>>>     for all pending background inodes before exiting.
>>>
>>> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
>>
>> What's the relationship with the previous two patches?
>>
> 
> I made then into one atomic patch, since you wanted them merged at once.

Nope, I didn't want that, I suggested you benchmark each patch.
But it doesn't mean the patches should be merged.

The merge meant merging commits to erofs-utils.

Thanks,
Gao Xiang

> 
> Thanks,
> Nithurshen
> 
> Thanks,
>> Gao Xiang
>>
> 


