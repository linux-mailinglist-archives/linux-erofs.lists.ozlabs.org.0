Return-Path: <linux-erofs+bounces-3587-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X+jML/xZL2ob+wQAu9opvQ
	(envelope-from <linux-erofs+bounces-3587-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 03:48:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5C682C9B
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 03:48:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=GbYu6ogB;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3587-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3587-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdtLv5dZ4z2yT0;
	Mon, 15 Jun 2026 11:48:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781488119;
	cv=none; b=YfOIFcNmJxfayilEGZ71/Kugcql3eLoEqBApUJ4XQLZ8a4wwhS33xBqOhepM/uNnnaFYywCDaLGiqsyhBvs/uIMYZmIDVjTjX3TyIIlGfy6kL2+J8K+3mN01MB7ssmRCsOOWk7iLWrcOAw97QrhA3kEz3Vex03rzkHjkuim05QxTIZxnV3Nl6slkeQwKnPxVVgULCx7Ha6fDe5gKMidz633Lc0Dxi0E3LdgauMrxbr9mLAdoTQ9HZI4bRy7g96g6S7QDF7S9MPULVPTvgEIMGknKJJmVEd34F3Rvw1dWu6GmyHuzoKwiZxdTXKiqaKJO7L8QA2NY8idwxMwdbC8reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781488119; c=relaxed/relaxed;
	bh=6e2ar3eQRlEx3kixdwmw+YpE0tNSl9Wm2mAa1feuOik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vln4MEDILYjSGMbHwWQtB07rEzpVB9Wr8xRVtR6HcaoueDSpAqowEr6goL6JKR27DDuds7G5wVsK7GXtfpNFrMhdi00ryOFAwSUky9Ns9ndotwrRwT5BUIpu8nV1ys5SCl0Mw2Vd8TQDHeZ68wBeQWqJl1uFKhjcBlEc/If9yveonA9UQJp2St/B6lNY6+IFCPa5kK+wSMeWrVwNuVipc5z0ajFgflejvAV2uHGpPoIry+ANzFr/vvSPLZpkwNFStmS483nVhbknOXgyp7/iD1ljFjlHD4JO/1wnLZRjzgfEbEyBWebBxl9AP/PT9ROeJ6373MdnIOzbUGFCo0qQCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GbYu6ogB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdtLs2Ycnz2yFc
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2026 11:48:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781488106; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6e2ar3eQRlEx3kixdwmw+YpE0tNSl9Wm2mAa1feuOik=;
	b=GbYu6ogBRz/nkwJZEHXvNFfKN2hltQW336H0oJyUkswyLFj3u+s+5By/ToiKnGrqhUHeTNz68SSo+Bhb7XlWzrrLByruMyWQQ13iagVUWVF9xkjY0WzwveRr+oLbCOZW5vZcHc/4PGjddWDQeYx4MwsmPXGPLrbVwUg1wYOEohE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X4oaiq-_1781488104;
Received: from 30.221.132.227(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4oaiq-_1781488104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Jun 2026 09:48:25 +0800
Message-ID: <555d6eec-7ddf-451e-98a3-70f7612a98c6@linux.alibaba.com>
Date: Mon, 15 Jun 2026 09:48:23 +0800
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
Subject: Re: [PATCH v1] fsck.erofs: implement thread-safe global LRU metadata
 cache
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <423c662c-e8b4-4802-b7bf-34abd71a82ae@linux.alibaba.com>
 <20260613101038.86333-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260613101038.86333-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3587-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68B5C682C9B



On 2026/6/13 18:10, Nithurshen wrote:
> Hi Xiang,
> 
> What if rather than caching the raw metadata bytes, the userspace
> cache will focus on caching the parsed structures (such as the
> computed erofs_map_blocks mappings) to save the worker threads
> from redundantly parsing chunk indexes and calculating offsets.
> 
> Can I replace this malloc-based raw buffer approach and focus v3
> patch on an LRU cache for the parsed block mappings to reduce the
> CPU overhead during the concurrent directory traversal?

I don't think it's worth unless you provide enough number to show
which really reduces the CPU overhead.

decompressed metadata cache is only useful for metabox, but I don't
think it's prioritized for now.

Thanks,
Gao Xiang

> 
> Thanks,
> Nithurshen


