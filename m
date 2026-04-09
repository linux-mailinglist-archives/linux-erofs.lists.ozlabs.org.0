Return-Path: <linux-erofs+bounces-3231-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFEDKCNV12kFMggAu9opvQ
	(envelope-from <linux-erofs+bounces-3231-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 09:28:35 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C82CD3C7075
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 09:28:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frs4031vVz2yVt;
	Thu, 09 Apr 2026 17:28:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775719712;
	cv=none; b=cLqlT7oFzKJZxDX9FNxh2IZGHjZJYy9MMf0Fyt1neQQjA0eJHlXqdOqQka+SntOs6mogpddVT9QV5DzBD5k2kKRn6zcbEajQO7RtISVyHLRkFrV8jiyfOw2/rlLHC7qajN2PTzwj3IO91OFzXIKsqWUM/mj5kGl1Lgdc/Be4b14+6oBj6WVJmDoSAFkYib1AenI75muIL5Dfr6uTFpv4oaN8mXTs2kSmXncQqO1RYQ/iJ3W2H3A7NZhCWHVnKmw5v0U+nqPpBpRgsKVNAZUOFabP3LS7q5C1Mp0JddCE3BguV864g1bS7SkOrN6vy02uztyqBKs85//zx1v8wiMMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775719712; c=relaxed/relaxed;
	bh=kJ7vJ+oFAlZFw8EfHMuaHDk+cVLH8+ocGz5ZHIMeP74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8o3ZiYF344pQAlrTrX1nd0gxqlX10c8/zuMs40oIIbXQAxbFTeANyU7ZV3qRh49gBCymu2ObPxq5UaeijWiLtW0KW6/ZifXIXvLAoA25sR0bUxPYJ707zOWYTCF/7LPASZTivE8l4OuoeD/Y3bsWsfH7JNlQ73gwOx51f2PihHKJuvBCUj3m4Ek+9/NE82E3lKQ0LGyAa89X0+M1Sv4Le5vhDjYBTiaWWqjH+EyNc1UBkJ748YIFIS+x6MQV+Gvj3ku4DaLRZmOTIPjIxuroev+t9bc7PvWJq22EqDBfN/L72I/ISnILLKPOKm4skudy0ySSDUPcLcjCD6J6eIC5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dPI48kF8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dPI48kF8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frs3x1W5Xz2xTh
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 17:28:28 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775719704; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kJ7vJ+oFAlZFw8EfHMuaHDk+cVLH8+ocGz5ZHIMeP74=;
	b=dPI48kF8zT8f9K1WuS+HV1Anc56g5vTqTLnLAExbL2z76ndU+OorJy0ne2ayGfY5OvU6Cm4xg2K65tt0+XUBW0SR3DUldpTP/YXOdDUPila7YQncHidn3XZy5ejLFVtKi3ZrzV/pY6ZQnw1noEJv5abo08yFG6wPdEft5ngTRok=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0hg9id_1775719701;
Received: from 30.221.132.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0hg9id_1775719701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 15:28:22 +0800
Message-ID: <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
Date: Thu, 9 Apr 2026 15:28:21 +0800
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
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3231-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: C82CD3C7075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 14:57, Junrui Luo wrote:
> In z_erofs_lz4_handle_overlap(), the index expression
> "rq->outpages - rq->inpages + i" is computed in unsigned arithmetic.
> If outpages < inpages, the subtraction wraps to a large value and
> the subsequent rq->out[] access reads past the decompressed_pages
> array.
> 
> z_erofs_map_sanity_check() does not enforce m_plen <= m_llen, so a
> crafted image declaring m_plen > m_llen can produce outpages < inpages.

For this kind of stuff, do you have a reproducer?

`m_plen > m_llen` can happen on partial decoding only.

> 
> The in-place branch is currently unreachable: it requires both
> partial_decoding == false and omargin > 0, but these are mutually
> exclusive. partial_decoding == false requires pcl->length == m_llen,
> which in turn requires (offset + end == m_la + m_llen) where
> offset + end is page-aligned from folio boundaries. This forces

I'm not sure what you're saying, but I don't think
you really understand the entire logic.

> m_la + m_llen to be page-aligned, making oend page-aligned and
> omargin zero.

`m_la + m_llen` should not be page-aligned for typical
erofs images, you can just mkfs.erofs -zlz4hc with some
file and check it yourself.

BTW, I just check upstream, and the inplace branch
works prefectly.

Thanks,
Gao Xiang


