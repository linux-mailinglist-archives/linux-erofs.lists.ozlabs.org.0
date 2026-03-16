Return-Path: <linux-erofs+bounces-2712-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEatL2Zht2l5QgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2712-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 02:48:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC82939F6
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 02:48:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYyfT0Pskz2xS6;
	Mon, 16 Mar 2026 12:48:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773625696;
	cv=none; b=P74YKYqH1Qj+3eu5Tz7CEvuwrxijL0r1h2m8gFjH4p5WIiCRJy6EfZUaoPVaS1KaNY2ojDsQhLgpoSEIpAamns1zCDyDMF7JXHRguzRYxNuXEXjPZ4H8HibHm4jdRkrm1wkIeqFpCEhhTL80hVzu3XCMpkgi5N03Bu14cW67FVjhDzLpFCcagl0bdZ1J11snMw2EOxsZWuOXSX/n1FV2ca7VTEwC8E1SCRePLvY2rVjtZEzekBJYssC0tYCQ/8KYkXUelTQjtW+v6SGdQzQ2K+NtuAnpxYWSKXogcbMTfMJZ1f1o5ITatkCMu2TheA1sCpNPAP/1yGe57LWGhAZkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773625696; c=relaxed/relaxed;
	bh=tjYSyouWdxg21ivOI9ueYUjH+6ofFYM/3eeTjSwkKn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRpuvLtJqOIz6BI3EMrutc6VN3oVpjeTqLnxF7RzkyikeSCclEB24Vl8g4Y+xHqdbnJPEzhxOEYmYbLafSzJutvqB2SbfVL3WsgIibA96I1K8JkehSjf1APoBld/by9mGxLz1np/lG98/dIQ2roHY09sIEUwwhXDwM57XHYOiFAU/ddVmVFbhwhJGJgOXLghGqwem1c6xAu5NpYG9C4guqhjMlcvYFEnyvxiRauW0UYXHAxU3bBs1Y7jQcFwb7lgw8wI1609Ou8d4d9ooA1Bv0SEF3+wHI1BWodmfSBFnFXngtrEFEJtjPNXNo5pSKw701fTCNywB1RnPjDDKcXdFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ujPLHblu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ujPLHblu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYyfQ5Rt9z2xQD
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 12:48:12 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773625687; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tjYSyouWdxg21ivOI9ueYUjH+6ofFYM/3eeTjSwkKn4=;
	b=ujPLHbludxQd1mUplmAwU6sGLfWvYDRKie17AXqOF8kLS6qUb8rfrAJ77ZssXZz747Q4efmInw0skRz2G+/RUKuz+ZBfIzUvaZ5Rwq3reJgyciTelpV8CahpQ3QZ6LDeJgSI82hw1fkdQrrggdzlWKyNVqZIx6gD6qGstCWKUDM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.-F3MH_1773625686;
Received: from 30.221.132.167(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.-F3MH_1773625686 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Mar 2026 09:48:07 +0800
Message-ID: <3781ee92-cdc9-47df-a8f1-7f5b514907f5@linux.alibaba.com>
Date: Mon, 16 Mar 2026 09:48:06 +0800
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
Subject: Re: [GSoC] Inquiries regarding manifest format and implementation
 strategy
To: Sri Lasya Prathipati <lasyaprathipati@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
References: <CABDnCWmf7NkT75a5zHAzixbLxpKSdK1s35GBC8d1s=-YosBncA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CABDnCWmf7NkT75a5zHAzixbLxpKSdK1s35GBC8d1s=-YosBncA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-2712-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:lasyaprathipati@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 36EC82939F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/16 03:34, Sri Lasya Prathipati wrote:
> Hi Gao and the EROFS Community,
> 
> As I am finalizing my GSoC 2026 proposal for the project "Support
> generating filesystems from manifests," I have been researching the
> various manifest formats mentioned in the project ideas.
> 
> To ensure my proposal aligns with the community's vision for
> erofs-utils, I have two specific questions:
> 
> Format Priority: Should the initial focus be on implementing a parser
> for Unix-style proto files (similar to genext2fs), or is there a
> stronger preference for supporting composefs-dump style manifests from
> the start?

I think you could finish `composefs-dump` style first, and then
Unix-style proto files.

As written in the idea page, it should support two formats at
least.

> 
> Integration Path: In mkfs.erofs, do you envision the manifest parser
> acting as a "virtual source" that replaces the standard directory
> crawling logic, or should it coexist as a hybrid approach?

I think it's up to you, the hybird approach won't be hard if you support
the pure "virtual source" one.

Thanks,
Gao Xiang

> 
> I believe clarifying these points will help me provide a more accurate
> and realistic timeline in my application. I've already begun looking
> into the mkfs source to see where the insertion point for a new input
> frontend would be most efficient.
> 
> Looking forward to your guidance!
> 
> Best regards,
> Sri Lasya prathipati


