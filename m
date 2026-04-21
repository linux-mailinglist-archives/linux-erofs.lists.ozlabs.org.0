Return-Path: <linux-erofs+bounces-3341-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHmKDgrb5mnH1QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3341-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 04:03:54 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A2435602
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 04:03:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g05Hm4bM9z2xc8;
	Tue, 21 Apr 2026 12:03:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776737028;
	cv=none; b=HOdjymzuK8wTAYsOxLfRdIBlNHGSqGa/7yTd6tJZXAX89+4cqrICvhEl2Kp5mFdflDf7QVBl4n7IWmNR3caG7N3JvF9Bo4aEX29FkAu9q6jwPDTdStCqb4o22IH36YTCUqn8rN1gd3lUBjLp0PlXpQmplEtfG8GEsh2fCVwvnuNW22yK9CKKPSC0IjouL6PDkqDQ+CrFNg2ZQ+HXZOinjDX3axCjMRREuOHje3roN69qEBb0th/QcL2J5jHn/bsOP+rgXm+9HlDydtfS1Q801Vwh6LAEZNu01b2fBSYGIS2HfKjgjBfVAMMIDIYjqeKRJpYoleI98E/JRqhp38hoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776737028; c=relaxed/relaxed;
	bh=PT9p61QumOTma43BB/QkhxMPjLowSNcnP2HWwqiAW7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cueBy8aKUjs6XyOHsqXqlRAxST3vFcMzumunnV9UTxBklGRH2M421e7m78M/YBG9WsRH/DL5xEW+E4dAe02hjOxu9L9A2AKeOWzwKwz9WV3M2l+JGYe5i+GC8M1HDPGwW2UsexJvKj2uBXpMZ9paPzGoqMw+fKABZ6NTy5p5wzKufxOWUadZTLjBEr+YD9ZL0aD+sdGYl5MtXw+SB3b9iUcyMOFYF4VeACpFuk/ZyOOm47Nuc5UbkpHU9JN0P0t6jqq6PYKRwnLZh8Au+3ktWQlfXSHF23vZQ1CipeQGVuKyFmYhUn0DMAGJJ5tx+kmr/bm5+eYoIYqF4Pa+TqWNeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e3IRNHOk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e3IRNHOk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g05Hj5TD6z2xT6
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 12:03:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776737018; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PT9p61QumOTma43BB/QkhxMPjLowSNcnP2HWwqiAW7s=;
	b=e3IRNHOkOAFEoQWlXpszyWRrZV/9e3p96YW1ze0U1t3KrvmMfKxpj8C6JwtNmYWCpyqCe6bJ26Qag/hNuIC7Egnd/Si9T8dQtiUbvTcfEJ5Hx8sNlBq7/OJ//xEBExS7GyS3AmXTB8Rs22SGyM9Vdk9o6FL4TkDAxqnx1MXhXos=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X1RNrF5_1776737016;
Received: from 30.221.132.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1RNrF5_1776737016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Apr 2026 10:03:36 +0800
Message-ID: <78d564f5-5511-4c67-b6b4-6670b3babbbf@linux.alibaba.com>
Date: Tue, 21 Apr 2026 10:03:34 +0800
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
Subject: Re: [PATCH AUTOSEL 7.0-6.12] erofs: ensure all folios are managed in
 erofs_try_to_free_all_cached_folios()
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Chunhai Guo <guochunhai@vivo.com>,
 xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260420132314.1023554-1-sashal@kernel.org>
 <20260420132314.1023554-198-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260420132314.1023554-198-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3341-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:patches@lists.linux.dev,m:stable@vger.kernel.org,m:zhanxusheng@xiaomi.com,m:guochunhai@vivo.com,m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email]
X-Rspamd-Queue-Id: E70A2435602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/20 21:19, Sasha Levin wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> [ Upstream commit 5de6951fedb29700ace53b283ccb951c8f712d12 ]
> 
> folio_trylock() in erofs_try_to_free_all_cached_folios() may
> successfully acquire the folio lock, but the subsequent check
> for erofs_folio_is_managed() can skip unlocking when the folio
> is not managed by EROFS.
> 
> As Gao Xiang pointed out, this condition should not happen in
> practice because compressed_bvecs[] only holds valid cached folios
> at this point — any non-managed folio would have already been
> detached by z_erofs_cache_release_folio() under folio lock.
> 
> Fix this by adding DBG_BUGON() to catch unexpected folios
> and ensure folio_unlock() is always called.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chunhai Guo <guochunhai@vivo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> 
> LLM Generated explanations, may be completely bogus:
> 
> Now I have a complete picture. Let me compile my analysis.

This is NOT a bugfix, but I don't mind if such random
patch backports to stable kernels.

Thanks,
Gao Xiang

