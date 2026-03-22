Return-Path: <linux-erofs+bounces-2921-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FysCCcc6v2l7zgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2921-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 01:41:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1A2E7C4E
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 01:41:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdctn0VcFz2xlt;
	Sun, 22 Mar 2026 11:41:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774140096;
	cv=none; b=Ip1VuP5WiT4TLQx9ZaEP6lraq90/8nGYTJywf9IM00S6Dq8/e79LjoA2tLuUCRgZVWhCabXDdiZJ5oiFYhfecICpjYKL8ccVal4CBPRwZ2lyCHtN3bWv9j0/zMrhUodcq38zYVSeaRsDbl5Oh7R6DyCirR6FOpvzDrLhTT0LtYeEGgljzX7lGQTS/f7SbZiznbhBWI0MdqOQXhzJcW82hoZR/motvLrG1BO0ejcSRwxdeZ5OI/fhCZW4ayCgK6Hl459R8svGbwYxk41aQzluI8yh9P/VLOu0VxVHAeLCU0u14z2gu3PBVjxPEAfauKSwUdxR6IzCOcfxCQ3rJFC0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774140096; c=relaxed/relaxed;
	bh=y2eQfPGTI7Xo5iKZZtvDMTajRO4+saU4maeK4y9K/4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0vkDQQrRTf9XFqITtCz/VZeQ5v+O8WmyjWKUYLXhwslytHfInIpKBysuSdhj1qOmoQrR+LKT9Yo90Ag4rySyj4ub/GGZfAxDGxGs9BezHjt1nWVNqu8yxrXm6mvk/+OQxZooWMJIGTK1o6TOJ89SOIww8No0RLiYWSGY8dms1wD8el6Ld6HIK2UUvA3JLPRI5lIXDidCyGSRZceDB+NQIyVwwDUhhxA/ShDiJTuK041L9gxZj3/nFqEp4QoFl3VdNwZMRvM2NcL/XK4KpujWVudiYelJ8c2KWMUA56hjlQ5eGZ+qVBTB3F1gFDbtic3mJmuS2Med5cYcN8zNf3bjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kdpJuJ0u; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kdpJuJ0u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdctk2rPmz2xN2
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 11:41:32 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774140088; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y2eQfPGTI7Xo5iKZZtvDMTajRO4+saU4maeK4y9K/4s=;
	b=kdpJuJ0uJcq8GjR4umWdXpbpBoU9oMteQAc3iojtw79uVLqGEEKe9u887IzDlNWA0LWoimfHhm/DlHi4NTIItK96JzdkMeJtpPiuz4KcQcBtIR9uIKTae1RVpMn+PUfHeJf9e+rliSr36rgHQRrUJeny4Wa2Qv44I/HUWPM9F0k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.PoL.z_1774140086;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.PoL.z_1774140086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Mar 2026 08:41:27 +0800
Message-ID: <9fa87530-6c44-44fe-86a8-ff546d6b663e@linux.alibaba.com>
Date: Sun, 22 Mar 2026 08:41:26 +0800
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
Subject: Re: [PATCH] erofs-utils: fsck: fix directory loop tracking
To: Nithurshen <nithurshen.dev@gmail.com>, ch@vnsh.in
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20260321142852.35991-1-ch@vnsh.in>
 <20260321160551.20683-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260321160551.20683-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2921-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,vnsh.in];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:ch@vnsh.in,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 71A1A2E7C4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/22 00:05, Nithurshen wrote:
> Hi Xiang,
> 
> This patch LGTM.
> 
> I tested the fix by compiling fsck with a debug trace and running
> it against an image with a nested directory structure. I verified
> that the recursion stack now correctly pushes the current directory's
> NID (inode.nid) instead of inheriting the parent's NID, successfully
> fixing the loop tracking logic.

Please help work on a testcase too, thanks.

> 
> Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>
> Tested-by: Nithurshen <nithurshen.dev@gmail.com>


