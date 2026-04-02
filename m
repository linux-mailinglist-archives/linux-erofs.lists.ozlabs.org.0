Return-Path: <linux-erofs+bounces-3163-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGZPNXQEzmmjkQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3163-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 07:53:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4F38433E
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 07:53:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWJ12sDyz2ySk;
	Thu, 02 Apr 2026 16:53:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775109233;
	cv=none; b=CMWl6aEEW9ag1IBteMDe0kluzoEylKsksOrZiP8khq2mZSZioKdgrK6kFyfdJ+M1L+Yn/GBzcOZt26z6wnfdqgZ06BlpelAvMFhfWz9K8i4TqJ/zzikXQDmxRNH8T6cQ45v+aWaN74IyAfSpqC33b3V2RiyhKnYPxKxJjVNmF8AMb4+XeKparf1ksxE6BBExJbq+b8Di6qIY6gLhV4BgbHfGr0m15R8z65DsS8oq5j9rR4rWh0vRgZbvkc4AHdPXcVjQbmnviNblKmeYEGQrnve22M7L4O+Jmr/yGyX+vkTF4E1ECLeCJavX+AkLT25ZHVP7St4n+t9h02jGOXjpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775109233; c=relaxed/relaxed;
	bh=6rkHdUDjQ/ndNevG1sZ1Ch+a9cB8pSr8iTDAYn0fTK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BptZMD2TZcmmrvXrfMKMqHOaJt+MthrPBZE+NsaCxziWGs8/cJKSvm28FrMbkRfLFYXXMZ8Q5bRSFeh53ZHPikBkOplHHruuNkTIWxQaxiMMzUSjk/BS7YY5zCnpxAiz3hUnYwinT8BwMwWYwQV99L5yhsB01/r2/EKnPUDEicVhDq3rse6XJSc9nLOUnTZJnXSFmS9Ef6oCynX0DIXgTPTUGquGwbV9FGTGTxBQ4seBTOCOWQnhHEPmaSrZpomZxH+2tBM7OFcSy6OvKqVZRBYxZvXs/RwFZEzoeG6PORg/jiu/+5c+7f4iUeEcY8AQyJMk6RTWZEkfI1uAJbMhCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SfW3F27t; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SfW3F27t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWHy6yQdz2xm5
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 16:53:48 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775109224; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6rkHdUDjQ/ndNevG1sZ1Ch+a9cB8pSr8iTDAYn0fTK8=;
	b=SfW3F27t7z6c56fPjNJgcNJ/NeOJGpcfLRS5oF9fbWwOWbRwqqGOUJv4HEDOyzsvbJcLE9xDP+HPzHQllkwt94F7Xq7doqq+HAgBKRe4DBPDdAn3HQeHaslRpCOniJJ77bWpPp0bhZDW05wf6NYSDWif/G4ih+fa4zJlqKjX0j0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X0G1dJH_1775109222;
Received: from 30.221.132.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0G1dJH_1775109222 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 13:53:42 +0800
Message-ID: <96bba5e7-936e-45fa-bb01-2fee4dfb843d@linux.alibaba.com>
Date: Thu, 2 Apr 2026 13:53:41 +0800
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
Subject: Re: [PATCH] erofs-utils: lib/diskbuf: fix MT data race in
 erofs_diskbuf_reserve()
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: chao@kernel.org
References: <20260402050424.24308-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260402050424.24308-1-singhutkal015@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3163-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,s:lists@lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 0FE4F38433E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/2 13:04, Utkal Singh wrote:
> Two threads calling erofs_diskbuf_reserve() concurrently can both
> observe strm->locked == false and both advance tailoffset, silently

How?

> producing an incorrect offset in the output image. Add a
> pthread_mutex_t to serialize access.
> 
> The commit path also gains the missing strm->locked = false reset;
> without it, locked was set once and never cleared, making the flag
> a latch rather than a guard.
> 
> libpthread is already a build requirement (-lpthread in
> lib/Makefile.am) and pthread_mutex_t is used identically in
> lib/workqueue.c and lib/compress.c, so no build system changes
> are required.
> 
> Fixes: 13f7268 ("erofs-utils: lib: introduce multi-threaded I/O framework")
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> ---
>   lib/diskbuf.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/diskbuf.c b/lib/diskbuf.c
> index 0bf42da..ccfeaa4 100644
> --- a/lib/diskbuf.c
> +++ b/lib/diskbuf.c
> @@ -2,6 +2,7 @@
>   #include "erofs/diskbuf.h"
>   #include "erofs/internal.h"
>   #include "erofs/print.h"
> +#include <pthread.h>
>   #include <stdio.h>
>   #include <errno.h>
>   #include <sys/stat.h>
> @@ -15,6 +16,7 @@ static struct erofs_diskbufstrm {
>   	int fd;
>   	unsigned int alignsize;
>   	bool locked;
> +	pthread_mutex_t lock;

Do you ever notice erofs_mutex_t and include/erofs/lock.h?

By the way, I sincerely hope you pay less attention
of this project since I've told you the reasons in
emails before.

It won't help with your gsoc proposal.  Thanks for
your efforts and contributions to the EROFS project.

Thanks,
Gao Xiang

