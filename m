Return-Path: <linux-erofs+bounces-2725-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDsgGrqyt2nUUQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2725-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:35:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA0295B21
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:35:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ6Lt6yz4z2xln;
	Mon, 16 Mar 2026 18:35:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773646518;
	cv=none; b=jAnZ22uaI9UNykeP+KY/UgBGaz9fnIW228Mjj+tXimT9/2LHaFD/gDET4LGMqFKFrYZH6KvvXq6OSQLj44qVbxWjF+YLpUgaKtHNNQinZZVsttKQFJw2o6Y+Xn2DTIuK0ZDC2osQ0T+g1QYTJDIG/MlM/NKjGLjTszFr8JDIf1lWBnmDWUZ0D/cYIllNngawIxjE8qysplTzMxtO9vag1afu+6uzsYjqCnNHg253Vv/onQAy2p6IOi0qfdv3b95lL8ScwkAwF4cKxxezQDK73EHbjrk9o3qd4DGkOFs9hE9YtoxUufIz9rGbganQQ3wgk+DJhAG5T/f/Fn61nutJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773646518; c=relaxed/relaxed;
	bh=MUSpDT5BuTw4GSEqpPl2WHEg+FnAIW4a3FCcz5/N91s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaFx97dZLaoivL587Uq5CU0AcWAubyOZ3jiuUBAicOlelNARNfXG4AfkC6HG8BCt/x0wxnB4aD/FGU8k0pGNSy5orexpgZOi/J1XPN1TqUf0pDeKidVu6kKEYpyAoHIRmWhgwgGaZlzfMlUkIZZgJPz+IsoXTdVnNsUhpHNz5CVKmafdigfftMdvhkqHUg+ccpApq+cSXxk0evtc2rEE/5el3w8gojBNNVq3bPmBeTtQvCrkMeR23mm4fer9gHXFX1tsT9gbiPalfekMjrLp4GzjaNBsyjSTtrUne5JZs9+Sf8yMv5NAhEMM9mA6PN53gTxi9KIM1C6H4rs9lhVe4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kn6Wlcgo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kn6Wlcgo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ6Lr2GcJz2xS5
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 18:35:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773646509; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MUSpDT5BuTw4GSEqpPl2WHEg+FnAIW4a3FCcz5/N91s=;
	b=kn6WlcgofW2iRj69Dp4zmlajXpRP/6UERzbJfiSusL3c3o/rcFBH9MdMeALJb8WD5CJNWLIyhIfbr2pZOuijMfIMgaIB+nOAv1VLEOUqmtrnt3BszMD9nqTU7Q7s0R1lzy4cYyjB4bqflPcBY7xwjAucGl0EvVX3X12kbv2w22c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.0qYID_1773646505;
Received: from 30.221.132.167(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.0qYID_1773646505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Mar 2026 15:35:08 +0800
Message-ID: <7de7aecd-1ffe-4879-b251-fa201b836655@linux.alibaba.com>
Date: Mon, 16 Mar 2026 15:35:07 +0800
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
Subject: Re: [PATCH v2 0/2] erofs-utils: lib/tar: fix PAX header parsing
 issues
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, yifan.yfzhao@foxmail.com
References: <20260316065119.21726-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260316065119.21726-1-singhutkal015@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2725-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 77CA0295B21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/16 14:51, Utkal Singh wrote:
> These two patches fix input validation bugs in the PAX extended
> header parser in lib/tar.c that can trigger crashes on malformed
> or crafted tar archives.
> 
> Patch 1 skips PAX entries with empty path= value to avoid
> out-of-bounds access on zero-length strings.
> 
> Patch 2 rejects negative size= values to prevent heap corruption
> from incorrect allocation sizes in subsequent operations.

Do you have any testcases or reproduciable tar? You can list them
in the compressed-base64 format in the commit message.

