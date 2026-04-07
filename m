Return-Path: <linux-erofs+bounces-3211-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD4tDaG21GnQwgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3211-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 09:47:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB63AAF4D
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 09:47:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqdb04dFrz2ygm;
	Tue, 07 Apr 2026 17:47:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775548060;
	cv=none; b=jV6QFtYQXmyurI3q97BLA++ZljSGqVC/1O47/qiDz99O25TuuiwkCtG3j1Huia3jCUvsQ0DFmcCaOmeq+4QbdXl799kvS+5ch/SjABruTZ2axmn2BNnsKDVRWFzYnXksk0n5d923mizcIOV+gOlMt3G5gtyvayBu2PK8gY3V5ouHGuYPWmsgf5obAJHBqHbPy4JaTrhPHaQGxO5yJmg4+yPStZmFBABXe+32ybb/72xd3eukCLiw8CHnjImKzKk6UYr2vNLw1n25bmvEF3Cph45r9dJ1cQTKlzkD0g+JHziMgc0w6v5/rAB8V/353tWLKfm+MVrRsXMOSdqbHvxF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775548060; c=relaxed/relaxed;
	bh=NmTuEcNySGSkr81Vqadb+QQRXtFFrTLgSY9hu8rEsZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joj3zuS1zAEIuXU49X+orSVAZ8UHlIi4F44SsFs4EL+4yzyYpgpruEFFeN1F4dzXSsS8yQpv/OAJ6ftUNcz4P386EcTrrmZlyhGCT14qezFy3/xbXdL18lXgq0bkuggSr7V1n1kQxJZdWIZ3n2nPBdZ/oSP6QIFdLAfFlIgtRm1I1tTNk9WHn00U1/YCkcnFhI1K5PyG0WDowuuduLY3S/pDTpJG3WriQOnYWa/GdKwYfbNulQRWUy2GGBZ542YZNL0Tm6TzdQco42WLaDDszWgymZF1TO6E9rIR1e/Lwx6Ce0ZAhB/TwVP4ti1vNeg/YZFA90twya885ESAsg6rtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ppvYAKDh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ppvYAKDh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqdZy2p1lz2ySS
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 17:47:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775548051; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NmTuEcNySGSkr81Vqadb+QQRXtFFrTLgSY9hu8rEsZg=;
	b=ppvYAKDh/JuU5u9GQZYGZcpQyQVkIqQ3FiMScqUsFZ++Wc2H6g+ZxK1/PSY9Gz335UQzp++aVL4V2pxCrPPchWWmRk2DaHZPF9ez3NtFApNgTYkOGfn4DbNT3OXQfJRg6WEPuhShgNtr/mpMK5kbmfHilD4MLTFMlhxVk2Pmw74=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X0b-W2X_1775548049;
Received: from 30.221.130.92(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0b-W2X_1775548049 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 15:47:30 +0800
Message-ID: <9ba9a21b-f4a4-48e5-bc89-82f50f56474f@linux.alibaba.com>
Date: Tue, 7 Apr 2026 15:47:29 +0800
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
Subject: Re: [PATCH erofs-utils v2 1/2] erofs-utils: fix swapped hi/lo in
 48-bit primary blocks read
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <12b129db-0206-44f3-a53c-9eec6fe3fda3@linux.alibaba.com>
 <20260403130546.76579-1-zhanxusheng@xiaomi.com>
 <20260403130546.76579-2-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260403130546.76579-2-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3211-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 3EBB63AAF4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/3 21:05, Zhan Xusheng wrote:
> erofs_read_superblock() combines the 48-bit primary device block count as:
>      (primarydevice_blocks << 32) | blocks_hi
> 
> This places blocks_lo in the upper 32 bits and blocks_hi in the lower
> 16 bits, which is reversed.  The correct combination is:
>        primarydevice_blocks | ((u64)blocks_hi << 32)
> 
> This is the same bug that was fixed in the Linux kernel by commit
> 0b96d9bed324 ("erofs: fix block count report when 48-bit layout is
> on").  Apply the equivalent fix to erofs-utils.
> 
> Fixes: f5b492b27e53 ("erofs-utils: add 48-bit block addressing support")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
I wonder if it's the AI hallucination.  Anyway, I fixed the
commit message as below and applied:

erofs-utils: lib: fix block count report when 48-bit layout is on

Source kernel commit: 0b96d9bed324a1c1b7d02bfb9596351ef178428d

Fixes: eeceb2289513 ("erofs-utils: implement 48-bit block addressing for unencoded inodes")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>


