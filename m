Return-Path: <linux-erofs+bounces-3295-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPs/NyhU3mlIqQkAu9opvQ
	(envelope-from <linux-erofs+bounces-3295-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:50:16 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22F3FB7C2
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:50:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw6dK1hCqz2yVL;
	Wed, 15 Apr 2026 00:50:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776178213;
	cv=none; b=KT4NKzRXI7rTMcXhQscHPEJH0sdIsmV8LLHo6R8smh4/6bLxB54TMQJHCLO5sSQXNv0H7HkAzVn2OpjdhsyKPCcrJf4A9SX3HovDEb+duKIn5n2wFlVespxwQwdBpC4Gu1bQZEIzrLZ4/YhJ/9d27Z6rCzQfoIrVDMRsmGEmspxp3Hn0GETq8ijdH4wKBKDJIy4g8PE3XAYKcA93hrHgreoQcXWvHdZ5N7Igb8awyfBrkcA9Qi+YzdFw3Jccs3irKI5BmxItAb/Rfa5DLOXHFX4ZbVGpQI+0RAa4gRWoX136AcXHw9jkr1RizpMVOxXnfhdHiMlssnuIIGTJQxLteg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776178213; c=relaxed/relaxed;
	bh=CflZtnHAZjK7BExsXQTclcVTUxX9Hh7LzEoNUhDQh/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKR4wv5Nn9qGWsvcvYX850h/Q2GNpdOYHqEJSKjlBsTeLg+zSWYTIi2fLdidCC+QlHgYWFYyxd+AsGfgIxKAbjZWBBvNPObpFaQoLhk3FDhRfefxFqOnlvNXQMfBQ3NLNrOApXBub4JhJYKLq+H+YdUaXbXavcwWN2JaxvgHKDjkfhl3BytZcb2T5hn10YeuXyC91bBWVOgAHhy6MxRmXlCOiGoeyxs90f6WMTY0kcZNNevTvCAoFnCgctYR2+O97aJkC5jNaplaZZFpjKR/mq+gV9tybFB2blc+Xn5rlbFxJ/z42etMGqLVvrZ4KDAn/mOwvT3HoyQU2uv2687jWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KzTIT+tm; dkim-atps=neutral; spf=pass (client-ip=47.90.199.17; helo=out199-17.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KzTIT+tm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.17; helo=out199-17.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw6dF2RZcz2xMY
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 00:50:08 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776178192; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CflZtnHAZjK7BExsXQTclcVTUxX9Hh7LzEoNUhDQh/4=;
	b=KzTIT+tmbG3wwpXVrNIvljKQrvHpv4waUaAPeGDdYtMIZMvNEqb4EkafmmQZ8Lg/RJzCcuOtF/ypkEOyXiOe0Du7HOISbEfRcr6Q1vsp0E51nzrPg0pGdzNmY21o+YPRXXqbc5wPCx7te4UFkx5M/Xe8u4PLlcw51WL/BABBbLk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X11gv2H_1776178189;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X11gv2H_1776178189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 22:49:50 +0800
Message-ID: <ff3c6662-c86d-474e-8672-c4cd8ce29031@linux.alibaba.com>
Date: Tue, 14 Apr 2026 22:49:49 +0800
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
Subject: Re: [PATCH erofs-utils 0/2] tar: fix parsing issues for pax and GNU
 extensions
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
References: <fb13fd1a-e929-4c7b-a8cd-ca0cc80d0ab0@linux.alibaba.com>
 <20260414144632.46859-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260414144632.46859-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
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
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3295-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 0D22F3FB7C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zhan,

On 2026/4/14 22:46, Zhan Xusheng wrote:
> Hi Gao,
> 
> Thanks!
> 
> The issue was identified during manual code review. I occasionally
> use LLMs to help polish commit messages or double-check wording.
> 
> Thanks for adding my Signed-off-by.

For example, this:
https://lore.kernel.org/linux-erofs/20260326125406.61001-1-ch@vnsh.in

I've lost my similiar commits like this,
but I will address them all soon.

Thanks,
Gao Xiang

> 
> Best regards,
> Zhan Xusheng


