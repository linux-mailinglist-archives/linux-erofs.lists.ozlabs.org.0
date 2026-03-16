Return-Path: <linux-erofs+bounces-2759-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFpAA79EuGmLbAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2759-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:58:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3E29EAAD
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:58:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZN9k3qpgz2yh4;
	Tue, 17 Mar 2026 04:58:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773683898;
	cv=none; b=AI7ISmMU/d7bidDovEhlrINUNuN8U6+KhHrnLjVrkFkaR+fQy2k1i7O1iuZ8vbAxLVRzd5zMtKHgwILwC6Cw088Jih7KV727cTRyhEIj3i75YlbQGOzXtPwrb15psidx979tNy760pzjJBWYlnhmZTzxDdI1YV7axwcrIQnuPPaZC8Md4nGCrSfp00mWMCDyKhEra3ftyJMs/TqrkumSYG8ek8wY4dgfPvUz/vb4JkdIAMRSRj3Rx+exjQ2MBhZqpQuGJfpuLObQx1p/rsbop/2oUNUQb1wm3/hVmle9A+0+9jeycxRZMr4F1haY/Qw1a9TfQeP0i/9gO0Kd5wHtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773683898; c=relaxed/relaxed;
	bh=JMggZwth1no8ypobjGg+VWIxmfuLqV3SkCnEPTS73HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SE8DWt1vHs0lDGCv+8o4GQSWP2jeP7XalkCryCQnAwZmL6bncvG98lVvZkTh2ZHmnON6Zd7tUGVfRsGSUX9GVq/k82BxvEgHsB0dqVmWEbpROyJfm/3k7dIs9yrdyU9xnljUcG1YA8S/WSXOf9iJGNV38Qc4v3ijvtUez2zA8wtsy1ytkIWdy8VhDy4r5LVM1dyhhQXv6Zx/iJ/TY/ymaGr5YHetjKjdygERmEINtRbhqXTYNZt9nQmpfg6I+1HsdKNDDTGAyzjm4UmHq9gV6/LxFO9K/UFkhJXtUvP2kPVGyoUqsAXd5UhcuTZ35GzzS8/7Rv/Yq2i5ZVsSkthXnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=USiBPyPj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=USiBPyPj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZN9h2NJrz2ygn
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:58:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773683890; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JMggZwth1no8ypobjGg+VWIxmfuLqV3SkCnEPTS73HY=;
	b=USiBPyPjRTPtRvxI9Pal8/IhoL7Uwt5UlHKE0a7FYGzuGT5Ay28iCvmpHsdiuwqN0XPv2vg5lDhET9ifVDtQjoFZbFvwfNTwEjJ6MAdSVatPws9cde1HuGTBNjGLxt2A2iOq4mFojplkH3lTdK/xZ5TtTpXLyzcEtBMvTiydGrE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.7HraK_1773683888;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.7HraK_1773683888 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 01:58:09 +0800
Message-ID: <6c0f9d71-e5b9-488e-ad9e-0632898c96a7@linux.alibaba.com>
Date: Tue, 17 Mar 2026 01:58:08 +0800
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
Subject: Re: [PATCH v4] erofs-utils: lib: name worker threads erofscompressor
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
 <20260316172527.90399-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260316172527.90399-1-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2759-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 13A3E29EAAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 01:25, Nithurshen wrote:

..

> diff --git a/lib/workqueue.c b/lib/workqueue.c
> index 18ee0f9..c924c1b 100644
> --- a/lib/workqueue.c
> +++ b/lib/workqueue.c
> @@ -3,6 +3,19 @@
>   #include <stdlib.h>
>   #include "erofs/workqueue.h"
>   
> +#if defined(__linux__)
> +#include <sys/prctl.h>
> +#endif
> +
> +void erofs_set_thread_name(const char *name)
> +{
> +	#if defined(__linux__)

nit: no indentation for all C macros.  Since you'd
like to contribute more, I hope you could read the
kernel code style too.

Thanks,
Gao Xiang

> +		prctl(PR_SET_NAME, name);
> +	#elif defined(__APPLE__)
> +		pthread_setname_np(name);
> +	#endif
> +}
> +
>   static void *worker_thread(void *arg)
>   {
>   	struct erofs_workqueue *wq = arg;


