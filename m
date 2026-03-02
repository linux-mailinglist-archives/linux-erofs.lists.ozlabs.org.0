Return-Path: <linux-erofs+bounces-2465-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG7zOkqypWk8EgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2465-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:52:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A91DC30C
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 16:52:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPk3C05Kzz3blr;
	Tue, 03 Mar 2026 02:52:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772466758;
	cv=none; b=LOKQxX9jcVVRazXvgyK2epWtkLEnPp4SH83bsuTJmo7JO9t25BhBGdmgqiBOgCiA1SW2UKEfj42pmMXrQcDtiudgm4ASUOqo2uUhNnG6dWUTLNKUYaTxsvLr6YG0O0lbIQStqE/pFLN53gd9ZOByqIHMexRWh368ohhB2ouUpqBG/aQJXOHp25Yun5ApqH76MD2HEvaoQzQZYlDRYN9SwkHPDKjAL/d3Dr3ChLKYXvK7FtxaHRxNbjenWaNFS3zjwlVOLPbIxzm3BFT8AnMIvnwIGY1ufpSF9ZCukGd6+PXGD6GSFl505Z7O6/5ufhDV6LtvppvH7To9H70fAueObg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772466758; c=relaxed/relaxed;
	bh=4laKLaCR4ZDEc+0tet5f48eBk6SE45W/YU9QOQR1/Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8FiGnqGmIg+t7vrG4vX8Et9KAvO7bUOg+IGF6cOrKPzJ08j+XyuMpoqxjs0Pbxsi/wwVMt0ySYXDugjEBL+OLuXv2bITbQzypgodcTKei7EAox80S/ecTc0H9o7gt1x/uIKchstMHNWJF/+OLmMEiVK+ncpWiRhvobDuD6cub7YA6wbSnrhjyPAB3zFmP7PmFwkkebqh6HZo304SgqaRq5IZom0q6pO4u7ZggejdlxwMLyWEuJrRlXYoZOe9/pii5lHKB0DURotL18oVIb7M9H1sMIdJm34+PUn0ssLkDfhUCo+vzMIeOIEw658Od9CSbcwCAVQSFvJzPhZiLb7Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dkfrxUBH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dkfrxUBH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPk391gLjz3bkL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 02:52:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772466751; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4laKLaCR4ZDEc+0tet5f48eBk6SE45W/YU9QOQR1/Nw=;
	b=dkfrxUBH0zluk+iBAgjvFtFpJT3GAbU2kdZjlv2ydL2Cd85I3gTYYc4Nrgm+45a6iwEGyf0lH/jPn2a8xflltCBNUdsrt+rGdG7lHMgHjjGJVqb/I0jBYduemjv/7HrHRhbDyck2CHPwCEF4Yr8Oez7khH2ZM5dxSQSxxsaL7F4=
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-5wOy2_1772466748 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 23:52:29 +0800
Message-ID: <1415c632-7a4f-40e6-af3d-09ca2c02244c@linux.alibaba.com>
Date: Mon, 2 Mar 2026 23:52:28 +0800
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
Subject: Re: [PATCH] fsck.erofs: introduce multi-threaded decompression PoC
 with pcluster batching
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260302073216.94384-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260302073216.94384-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: C95A91DC30C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-2465-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Hi Nithurshen,

On 2026/3/2 15:32, Nithurshen wrote:
> This is a Proof of Concept to introduce a scalable, multi-threaded
> decompression framework into fsck.erofs to reduce extraction time.
> 
> Baseline Profiling:
> Using the Linux 6.7 kernel source packed with LZ4HC (4K pclusters),
> perf showed a strictly synchronous execution path. The main thread
> spent ~52% of its time in LZ4_decompress_safe, heavily blocked by
> synchronous I/O (~32% in el0_svc/vfs_read).
> 
> First Iteration (Naive Workqueue):
> A standard producer-consumer workqueue overlapping compute with pwrite()
> suffered massive scheduling overhead. For 4KB LZ4 clusters, workers
> spent ~44% of CPU time spinning on __arm64_sys_futex and try_to_wake_up.
> 
> Current PoC (Dynamic Pcluster Batching):
> To eliminate lock contention, this patch introduces a batching context.
> Instead of queuing 1 pcluster per task, the main thread collects an
> array of sequential pclusters (Z_EROFS_PCLUSTER_BATCH_SIZE = 32) before
> submitting a single erofs_work unit.
> 
> Results:
> - Scheduling overhead (futex) dropped significantly.
> - Workers stay cache-hot, decompressing 32 blocks per wakeup.
> - LZ4_decompress_safe is successfully offloaded to background cores
>    (~18.8% self-execution time), completely decoupled from main thread I/O.

Glad to see the improvements, I think there are more room
to be improved anyway.

Also there are still some follow-up works, I'm busy these
two days, but I will release a formal gsoc page later.

Thanks,
Gao Xiang

