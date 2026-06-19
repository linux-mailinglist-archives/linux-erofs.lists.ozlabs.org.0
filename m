Return-Path: <linux-erofs+bounces-3689-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QjllIRFvNWoUwQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3689-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 18:32:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920396A7108
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 18:32:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=tJChjHLI;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3689-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3689-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghjmX31CKz3bqM;
	Sat, 20 Jun 2026 02:32:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781886732;
	cv=none; b=lYcsK8Efm+7lVXNdCiXoeCqOBEPnKB8ZCnFWKqslH6Zt2lJ3ui3qg3bGNJDu/L8Fgi7C8/ZmbxFDpS1dz7GtPz5ahxdejyBOC975hG42LXbUXMTqYceyrXl4s8Wt+HLYXb9OhhS4237Z1zXs/xnk+CL2j6EtQj/KSwz2P+M+A5QzYg+K/wRzMBa3owqQPIu0tqOVV+c/bB+THWXv4HbxEPj/KSzJRUMzLrnv5q9ZTgrA+MlaQFqLsxTN3sXHQcahmPn/7xtpFlYObnbab2KE1clsGN4LX/r4zFloo1ZcBBr5vnmpk8+2/zhos7jf31196MJuVpojdB8XkqQIymH/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781886732; c=relaxed/relaxed;
	bh=GQ5NCQJ48zlDZ6QI1bTvxz8N867xlcMzmYl0qy8Ug9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJflJo9c8U6ryI3OkNcO1/ueDuRYvYlE18PQW8RUhrdSU2kMLUiHj9FPEQLF5Lkbx/Zii0wDBSCIWKJSsm2vRFgS6LfU6kHhWKAZ8wG+mTJUNxDW90E+LbyPNFVkK3yw/1Q/T0qRRNM3fClWvE9tO9NdKNavYyEZImwr1W2QjJiESiH3pyaSECEeTwmwP7MbHe1Uz/QWAqbXYE824tY+wXdVm2BvbSXKpE1FdVe4DmhuOp90mxdpJ55LvM6vbBAOnLt9dyZolFS0f8RXjoSaMifmVPeaw2G7xB9DoJ5MzbUiNpyP23+u/qQO3+bhv8niXjbvxEl52waNGO0pOIPPNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tJChjHLI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghjmV3lbrz3bpm
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jun 2026 02:32:08 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781886723; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GQ5NCQJ48zlDZ6QI1bTvxz8N867xlcMzmYl0qy8Ug9o=;
	b=tJChjHLI6QFTAog5PTD8/Du6+gfVXlwDIDm9ML1bYGI/xCaMCSV+nmE178W6A+HaxiO1xcwpYHd9R8dUVAItpYtvKcrcgAXxMX8q0BvvtRVIVub44jHiaYjQIlrTqk3KgzALkZ5EWs4HUOmCDIj/7NHV1KG9580S+ghN+BEilPc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X5A7CyP_1781886721;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5A7CyP_1781886721 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 20 Jun 2026 00:32:02 +0800
Message-ID: <ee412c09-dd3f-4918-88de-3bedf6f25122@linux.alibaba.com>
Date: Sat, 20 Jun 2026 00:32:01 +0800
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
Subject: Re: [PATCH] erofs: complete fscache pseudo-bio once when a read is
 split
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260619135800.1594811-1-michael.bommarito@gmail.com>
 <bffc5b69-2f90-41f5-9b93-fe527da63f64@linux.alibaba.com>
 <CAJJ9bXws=fnBgMMbGcuWdhSRRe2yNb-QjFP-CKW=vaA0dWd+-g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJJ9bXws=fnBgMMbGcuWdhSRRe2yNb-QjFP-CKW=vaA0dWd+-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3689-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 920396A7108



On 2026/6/20 00:21, Michael Bommarito wrote:
> On Fri, Jun 19, 2026 at 10:20 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>> fscache is already deprecated, I will remove this path
>> in this or the next cycle: it's not worth to improve
>> this, and bio_inc_remaining is suspicious since I never
>> tend to introduce chain pseudo-bios.
> 
> I didn't chase a POC for this one, but I can't rule out an LPE on the
> or at least helpful shaping from this.
> 
> I know it's not relevant going forward, but the UAF / double free will
> live forever unless stable@ gets something.

It's already _deprecate_ for almost two years: and
I believe there should be more serious issues all
over the kernel, why just focus on a deprecated
feature?

Or please provide an accurate reproducible way first
so that I can play with that myself, I think I can
fix it in a cleaner way. If it's really necessary,
it will be fixed to the stable kernels only later,
but this feature will be removed in the near future
upstream instead.

Thanks,
Gao Xiang

> 
> Thanks,
> Mike


