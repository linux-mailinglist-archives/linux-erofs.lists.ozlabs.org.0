Return-Path: <linux-erofs+bounces-3579-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xkSaHhGzK2rhBwQAu9opvQ
	(envelope-from <linux-erofs+bounces-3579-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 09:19:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A231467726A
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 09:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=pLyDERxz;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3579-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3579-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc9rF0v7Nz2yhY;
	Fri, 12 Jun 2026 17:19:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781248781;
	cv=none; b=YopEcgtEAgMWQ1Uq9XKUrFGuByvpEs0dzIcs1gVoLJY9spEztwi3C1CdNk0389gjI9GxfD9UYLwFaUgAH21WUjTAwqK/sHEt48kNhBSDHgISRdKiTcncYznJaIZVCIQ3KrRRj/lUL0e53heWF340rRHNcwdeaR3qxiE0QrlcUMo4FTSkre+CqZJTqh4kaY9S64QikCANDdJu1kFFb2J3X+QTw2p9LvBvoziwKZaeLFrxp1TpiOhP+uZV8wtqg8P8h5yI1yCg4qLs4dKrVr/5ZBNo6acCA3sMQyucgOXa8w0EapnSoN6//OU/QoZrZeD044wDynZciHGU9hD5yrSqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781248781; c=relaxed/relaxed;
	bh=jQ074OeHnU23SjZznyHVFk9X/huLoQVjQBSjgHjbJk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDngAGpoGzfoGC/zcDgTJmykh3sXIobJobI3XAXQCZVaLA+z15lwq4aEaXbosRMNynLYgzlAsCmXGXJoxSQVUEZ+/gnK4bkLl6U2QtmMgir93usuxAAY1B90uSDYACZFhFGCdE0ULD88fXfX0ZGvjZ54f7Wyojr9o0Ez16tfiGiGs9Hr1dd9pBwhfGGnhahkG1wos2CwQ4snJ8nMft1KaZs8WZixKj2OLTU12xen0K+aYOB3Hs2VQlH4ZqFnpS8bYLqECkDZLQxHbta2Xgk2och0vbIN21fgi4LnkkkQKPCJUzSBoAscXkNcjqRh8U2speusuKbqxEtpsQQilx8cJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pLyDERxz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc9rB6Dshz2yd7
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 17:19:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781248773; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jQ074OeHnU23SjZznyHVFk9X/huLoQVjQBSjgHjbJk8=;
	b=pLyDERxz38iz4NpyVSfnG+IAtPx5AsC7KKvTSivBwP0lr+BVbCVgD0y9y6uMefgyVEYzTuszZg+y/9oNEVPxkYL7ygj2wFc9tssq/LfDm21BUUCrZLXgxCpHKeEz5sMIeF+Gx/H/7bSmMO9qCG+XGboAEnUZ2xAeSSSL8a1opIE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X4hsroI_1781248770;
Received: from 30.221.132.172(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4hsroI_1781248770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Jun 2026 15:19:31 +0800
Message-ID: <04d8ea84-1955-4f1e-b5f2-f142fa1971ba@linux.alibaba.com>
Date: Fri, 12 Jun 2026 15:19:30 +0800
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
Subject: Re: don't merge bios over iomap boundaries, was: Re: [PATCH] erofs:
 prevent buffered read bio merges across device chunks
To: Christoph Hellwig <hch@infradead.org>
Cc: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, yekelu1@huawei.com, jingrui@huawei.com,
 zhukeqian1@huawei.com, Ritesh Harjani <ritesh.list@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
 <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
 <aiumQL8LEWQX_Nag@infradead.org>
 <62f6e9bc-cfb3-441c-a3b7-301b8649f0ae@linux.alibaba.com>
 <aiuw0QvFIhEWUPG-@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aiuw0QvFIhEWUPG-@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-3579-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:ritesh.list@gmail.com,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:joannelkoong@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[huawei.com,lists.ozlabs.org,vger.kernel.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A231467726A



On 2026/6/12 15:10, Christoph Hellwig wrote:
> On Fri, Jun 12, 2026 at 02:54:47PM +0800, Gao Xiang wrote:
>> hmm, currently erofs could return block-sized iomap (if the chunk
>> size is 4k) even it can be merged with the following chunks.
>>
>> Previously it was fairly good since consecutive chunks will be
>> added to the current bio if possible, but after this patch,
>> there will be a lot of 4k bios.
>>
>> But if iomap goes into this way, I could make iomap_begin maps
>> more chunks in one shot, but that needs more changes in erofs,
>> it's fine anyway.
>>
>> ... I was thinking the following diff (space-damaged):
> 
> That should work too for your case.  But we definitively have various
> cases where merging over iomaps is a bad idea.  You'll also end up with
> other efficiency gains by merging consecutive entries, especially for
> direct I/O and when using large folios.

Yes, optimizing erofs chunk mapping would be more
efficient, will work out one soon, but Yifan can test
your patch in parallel.

Also, if "iomap: submit read bio after each extent" is
applied, I guess some merging condition in
iomap_bio_read_folio_range() can be removed since they
won't be reached in any case. (deadcode)

Thanks,
Gao Xiang



