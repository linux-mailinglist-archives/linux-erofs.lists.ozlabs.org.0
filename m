Return-Path: <linux-erofs+bounces-3567-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1SZNQQSKmrgiAMAu9opvQ
	(envelope-from <linux-erofs+bounces-3567-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 03:40:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F51466DA97
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jun 2026 03:40:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=r2KiRWug;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3567-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3567-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbQM50XG7z2ysW;
	Thu, 11 Jun 2026 11:40:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781142016;
	cv=none; b=l8fyKHDCaCVXwzpH34PLTgprYMvFJMqlHqEHQx2MjYS3qSTESJKbF0RsnASJ+eQUZ50LqQYZMS+pSJAKKl7vy/ZsP4lTYr+LuDX47njUxu2qtiGxdznPc9GH+KWR250lV4VpQtWQ6FhJo0C1jlmi1cCAkLCXshwDghI5JNJ7dJIPjtorz+LFlLtIfV5Q7aoBuy0k1Oz8mLmSsqHrOaxmhxu3fTdhk8uy4YBXnFIHpRbo3/oV6SIcYA4uN01H7zEomEuJatObpUjYtvj7eRpnFXhnIbn186jiN98vztkwOyprhEI63AkOykZCuzWBlFvmuKk0B1l1lIsw9Gcc5Vobkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781142016; c=relaxed/relaxed;
	bh=RLUkCBZ6DjJynHBl/N1C3d1hqkLNKUzIPyWCGqIcDMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QTuo6moov+JKmc04Uc6L/8iFW0SdeF43DCxp+O2xAknxIKHHK6a4b+7U0qwi6pmeLnk+BHCucJX0pabN0kQhwkDWgm4sfCi2HQ3Oig3kYQzOb+rzq18+fW/gCJUh/lVepN7Szl9peAudWKB3h/VUFaZ5UtvSyOqtKm3Mpe7RDgzJyugJZ/ZrS089Doomy+JliP6BvdoQS23qHZOYfRBVU9xT4pHzKeO0UnLT72QnzxsC9G/rd6CsYhTXM9qsmY/9W0xOmtVNcStOHElxgTnwpAN27h72y+AHqkZgRf7e6UvWhmLGXz8voQpvH0Nubh+Ferxr9B/nav9FnEe203wqVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r2KiRWug; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbQM25mqbz2y8h
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2026 11:40:12 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781142008; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RLUkCBZ6DjJynHBl/N1C3d1hqkLNKUzIPyWCGqIcDMk=;
	b=r2KiRWugepgXoPKk0qrj65ybEea9FVUi8K+ZurgS0z6q0VOzq+FZ3e05X7DhdcOm0AKRp9K5cxAhhi7a90pYGJ2dLCxQUY6oessfSmO5N5rhFuHY9UUVygZDKhGjgHr4xecEvy6Xb5QUDVfEFF6Z3r/z4/2T/dKjr7rKRdjkwvc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X4bymhG_1781142006;
Received: from 30.221.131.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4bymhG_1781142006 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 09:40:06 +0800
Message-ID: <62d126e2-fbf6-4ff5-a327-5c8d7b0b59d4@linux.alibaba.com>
Date: Thu, 11 Jun 2026 09:40:04 +0800
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
Subject: Re: Vulnerability Report - 5 findings in erofs-utils
To: Tristan <TristanInSec@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAA1XrhPMekMqAnRkC-jV9rTsO4LHjzh=kxn6zQKMgBrqfrnp8A@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAA1XrhPMekMqAnRkC-jV9rTsO4LHjzh=kxn6zQKMgBrqfrnp8A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:TristanInSec@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3567-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 9F51466DA97

Hi,

On 2026/6/11 05:27, Tristan wrote:
> Hello,
> 
> I am reporting 5 vulnerabilities in erofs-utils across three versions.
> All are triggered by crafted EROFS filesystem images.
> 
> Findings summary:
> 
>    - ZSTD decompression heap OOB read (erofs-utils 8a579d4, CVSS 5.5,
> CWE-125)
>    - u64-to-u32 truncation heap overflow (erofs-utils 1.8.5, CVSS 7.8,
> CWE-190)
>    - Off-by-one heap overflow in fsck path (erofs-utils 1.9.1, CVSS 6.2,
> CWE-193)
>    - Symlink extraction integer overflow (erofs-utils 1.9.1, CVSS 7.8,
> CWE-190)
>    - Uncontrolled recursion in dump.erofs (erofs-utils 1.9.1, CVSS 5.5,
> CWE-674)
> 
> I would appreciate acknowledgement of receipt and CVE assignment.

Although I agree that some issues are obvious issues, but
would you mind provide reproducible images (in gzipped-based64)
at least?

Thanks,
Gao Xiang


> 
> Regards,
> Tristan
> 


