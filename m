Return-Path: <linux-erofs+bounces-3706-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VnFGMonNOGpTiQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3706-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 07:52:09 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A526ACD63
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 07:52:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=C3zaaiAt;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3706-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3706-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkHQY1DHyz2yVP;
	Mon, 22 Jun 2026 15:52:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782107525;
	cv=none; b=KF72fJGm8f8D9Ua8jesYZwXuzvFeJxUyckQ11TxXHj/KbJXpy1stMGf4MO6Foqc8FpiBR7HqwKnT3jw0s9DVk+AvxwuHxRhMFCjwJxCyrc1DUPw+90NVstKQlIgRdIIcpOSpU+gtKAz/Iql1J5hndkMKv9DcZ8dzev6ccR/TdfbAKCwJdg8LlFm1fWO9J7P8PEnYoVr94qFQSoX71IZJE0OOSLfsStcx6oSidyc1wazRbsyZzE0gO+LvJO3afg67h17E/hdXFgkD6IzlG0QcK15MIpa8P9tImsGZu8dZ5MWCdWBMftijBImDqqZj7vAtiCJWRbl5Du3rg1IGagJgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782107525; c=relaxed/relaxed;
	bh=yH0G0MgETg7Oe3omWmp44CsC9IA7RpwOCBDGLc2x2XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3O05DWBrPrwzvIC3LUjpBh4dmjMd0OL+YCzIKtTLpJ8REgR3JLXw2yp8AEFqekJETK/3zh9XuF5vgU0viev0STWmZZM3pt0Blzd0wQBfuZAjbzzMLExackTiiQ24D4Yg9B6z+S2Q9HiDpU0X+kz2/QQpKK6lPh6bl3tL/j8w5RI3rfsTW6GYca6XEsF4zGNjSFdCUykMfMuei55F8m+2wW4917rC1vMKc+xVGrLEPIe//Lhc+fP6AFAFD1xqUf0KBzPpy2ErxQubmamT5fnLTXjwgiaf3ub4lfshJTJJjMH22wqq2uPqBleCKqWZymZjfoC3JAWFJI3iUbf8exrwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C3zaaiAt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkHQV3C4Fz2xwH
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 15:52:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782107506; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yH0G0MgETg7Oe3omWmp44CsC9IA7RpwOCBDGLc2x2XY=;
	b=C3zaaiAty4ycS8UP5J2022BcF2mRC74BybHQeKEd24p1xSrB6mA1QJnEOUY/3CPA9h6wJ6XKzxyu6zNfzvWZt7A6le0DGOIf4HTUpkEnYo0gnjcFFFtzTk2B1HmBLtqQ++rwVQvcR730ey2Zh2hxhDr616/WbLbQxo5yraiAKmo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X5HdX1o_1782107502;
Received: from 30.221.130.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5HdX1o_1782107502 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 13:51:43 +0800
Message-ID: <adbeabf4-8f3b-48db-bf28-de040863c04e@linux.alibaba.com>
Date: Mon, 22 Jun 2026 13:51:41 +0800
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
Subject: Re: [PATCH] iomap: submit read bio after each extent
To: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Kelu Ye <yekelu1@huawei.com>, Yifan Zhao <zhaoyifan28@huawei.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260619050105.439956-2-hch@lst.de>
 <20260619-kundgeben-hippen-abrunden-643fba56e35d@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260619-kundgeben-hippen-abrunden-643fba56e35d@brauner>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3706-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:djwong@kernel.org,m:hch@lst.de,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,lists.ozlabs.org,vger.kernel.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0A526ACD63

Hi Christian,

On 2026/6/19 18:15, Christian Brauner wrote:
> On Fri, 19 Jun 2026 07:00:53 +0200, Christoph Hellwig wrote:
>> Currently the iomap buffered read path tries to build up read context
>> (i.e. bios for the typical block based case) over multiple iomaps as
>> long as the sector matches.  This does not take into account files
>> that can map to multiple different devices.  While this could be fixed
>> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
>> over iomaps actually was a problem for the not yet merged ext2 iomap
>> port, as that does want to send out I/O at the end of an indirect
>> block mapped range.
>>
>> [...]
> 
> Applied to the vfs-7.3.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs-7.3.iomap branch should appear in linux-next soon.

btw, could we address this issue in the 7.2 cycle?

Not because that is a quite common case and needs a rush fix,
but Just because that can be reproducible under given
circumstances and users can get corrupted data.

Or if we need to hear thoughts from others, I think we could
delay one or two weeks though.

Thanks,
Gao Xiang

