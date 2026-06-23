Return-Path: <linux-erofs+bounces-3733-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V6Z5DrMkOmoV2gcAu9opvQ
	(envelope-from <linux-erofs+bounces-3733-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 08:16:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17C6B467A
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 08:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=d4yWgwlC;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3733-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3733-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkvvx51S0z2y71;
	Tue, 23 Jun 2026 16:16:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782195373;
	cv=none; b=VRW7ZcUxhx0H7dlUGfVlefyFyvL0ZamsGtasuC55hOSxTGKEiEF+fVTrGEaDCnOsojdFWDdbHYouLEeT6Pw7MA9HcA2g2gJP8733HrmR/WlBFT7LWF1Fb0kJWCMa3LdRJ9J1MJICNBbGJcFHgQxTlXtR0g8l9ASmK6OQlQY5mDl8wDhpD2QlRHFqYkByJ780AjZMdGcmoZguePvWUK3XK/CFHuJvY8CPACPWgEHVvluyw/TRxTjdTxoX6HcbKQL908v4OpppCY7NvIBtU7zc14VkUDmVB15pUdACSqJXG09tQWp7nkpRdggk3MYcSJ8IwMeCR/IfVRKjR03d1RxykA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782195373; c=relaxed/relaxed;
	bh=uHj27KMJmGb9yJsUhSyQ3HPQ2wiyW/riJOs9cr4ntD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VG+X6iPbiBwoPwr/xtHIe7ohpxkxum/7B5sYtWqmOEXMrYyOsA6h0NOogyq0aG3xMdfII9eTichJOhFgFAMF6gLeVOSHpAfihxo7VEyS5TM8zsCm//rpA+9dtlAWvo4u5RtuRIZqISS47TRZuSXLTJDNTixbyTlzklDeCR6pjq/5EmpSsmnJWH0Af8Q9rYLy+UM68hqlRNHs9Z4uy21ZOH6rAl3sUV+YxF6Fcc7nMDhWIu3bzTZmOhAd3MVtHEpi1zDbsRKOIToPYGDihTvvIQQWjU+5EwAQ5AqsXYlxcu/lifK12dUSs6TihzWruKQfPBye6j05RUwnH9xQWLLB3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d4yWgwlC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkvvt5cRpz2xwL
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 16:16:09 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782195364; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uHj27KMJmGb9yJsUhSyQ3HPQ2wiyW/riJOs9cr4ntD8=;
	b=d4yWgwlCiSqfHOF7K+Bf451/nNA369xPwkbfEOFQlHBodwi+X0dVCpV1ZoAKLv6KQqXFvxIDiXG5JJ2kRzRVkvn0br2h8r/tAs96dqO8zGshWRBKpzr8c8my61sMEJqtJyRygv05W58jgIkykJ+qcVsDB2Kr/yApTW7rSaKWapI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5SxI4M_1782195362;
Received: from 30.221.132.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5SxI4M_1782195362 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 14:16:02 +0800
Message-ID: <b829f45b-68f9-42e0-8379-71fe10294d41@linux.alibaba.com>
Date: Tue, 23 Jun 2026 14:16:01 +0800
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
Subject: Re: erofs: is z_erofs_put_pcluster()'s sbi access in the same UAF
 window as 1aee05e814d2?
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Jianan Huang <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <a5230f86-74af-4fab-8806-a118a0cf3a98@linux.alibaba.com>
 <20260623033833.3440803-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260623033833.3440803-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3733-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.ozlabs.org,vger.kernel.org,xiaomi.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:jnhuang95@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A17C6B467A



On 2026/6/23 11:38, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
> 
> On 2026/6/23, Gao Xiang wrote:
>> In short, I saw some similar report from LLMs, but I think
>> erofs_shrinker_unregister() should block this from kfree(sbi)
>> by design.
> 
> Right, that's the part I'd missed: erofs_shrinker_unregister() drains
> sbi->managed_pslots (while (!xa_empty(...)) z_erofs_shrink_scan()) in
> ->put_super before erofs_sb_free(), so the in-flight pcluster keeps sbi
> pinned across z_erofs_put_pcluster(). Thanks for the clarification.

Yes, that is what I meant, also I found usually LLMs could
miss some details by chance, so IMHO we'd better to check
manually again.

Thanks,
Gao Xiang

> 
>    Zhan Xusheng


