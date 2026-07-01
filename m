Return-Path: <linux-erofs+bounces-3795-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uZjFEVJiRGrKtwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3795-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 02:41:54 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813AD6E8F0A
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 02:41:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="ZWQQvAG/";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3795-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3795-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqh6N1Rsfz2ySJ;
	Wed, 01 Jul 2026 10:41:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782866508;
	cv=none; b=cy5NoEMOnBc7HtWu/nrPl77fakDjivRy5PciEW/KDOofj2v+KPw5UdVI3P/hLeGgpkrt6AQb9abquhJr6tWa8FW08eigTCcihQMhSP0rZvlrvfOKzijDOj92P7TM3KNVLcpqPvapWCPoC7tuIrz3WFskXfFkKcDwWjyOgWsvDjVzdp6Yocc5nltOdz2CXhM8SHuWuX5cDc0PzDGOiKgfEi4ZpbsOhlsuVWrQLqBn9sACsZqUcwRyvB53lGy7EQKS1nLSLbCzA9wjSxYxOQ1kMRZBT4tA/3qn05kfQBOGxWIZYVlyK5d9eapAdjRUZMgfyqL1Y9TaFQQ1hsrfQWXTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782866508; c=relaxed/relaxed;
	bh=7SebsUrP572pH+7YRkYMc1j6oC+t3eFqawA4JMbNhLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkU+bveHNSjV4WNd2IHw24hSss0COdz3Uj5cAXEqNoD/yj1YMxsevhks8g0R/RxO8sWS53a3FW8YpMglVy5U2ZEzeV24Pd76XSfUSrYlNEdjzdeVCcNdJvigdGPVemR0meosG/ieT0/cRwbleIDRgpBDqZcj3WEKNdBHfkVaQIRHoclc7+c52ZRFaewnnSEgmSAztDFVX4pVdF81HnGxrrk3hdRWz/cPTJhgDoSDLc2dahS3vtz5vcHTkLsJOdmSXxAHxVeZKRukZ7lZe5oklkZLSMU8cWgUP/wV7Z2c9/nJfqvgiw8sUGJiTd/g0/MJGyZPIpd/Tr59jwg5ElL/vA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZWQQvAG/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqh6K2Lmdz2yQG
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Jul 2026 10:41:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782866499; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7SebsUrP572pH+7YRkYMc1j6oC+t3eFqawA4JMbNhLY=;
	b=ZWQQvAG/WMZd2jC2Q88WQyrPzObRJxf68MZqIo7pa7+qOZjGFEYQAQw3QQzd5GS0N16GohhhetOPwVjbdNaVRw+GcI0OthZ7wGC4NwBAvkg59hqNc5BP7IPTFt3RzsHp4ARQX7KRATeRw/fJTz4VUgEsLrQdDvFCCTq/8JAIOjc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X61.QAe_1782866494;
Received: from 30.180.134.80(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X61.QAe_1782866494 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Jul 2026 08:41:37 +0800
Message-ID: <ea10d591-6372-4a14-a613-2c1e921755aa@linux.alibaba.com>
Date: Wed, 1 Jul 2026 08:41:32 +0800
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
Subject: Re: [PATCH v2 07/18] erofs: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org, hch@lst.de
Cc: djwong@kernel.org, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>,
 "open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-8-joannelkoong@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260701000949.1666714-8-joannelkoong@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lst.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:willy@infradead.org,m:linux-fsdevel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3795-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 813AD6E8F0A



On 2026/7/1 08:09, Joanne Koong wrote:
> Convert erofs iomap_ops to the new ->iomap_next() callback. This uses the
> iomap_process() helper, which finishes the previous mapping if needed
> and produces the next one. No functional changes are intended.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

