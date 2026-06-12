Return-Path: <linux-erofs+bounces-3574-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ofznBD2AK2rB+gMAu9opvQ
	(envelope-from <linux-erofs+bounces-3574-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 05:42:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9767675C
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 05:42:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=irLGz5l+;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3574-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3574-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc5213F07z3brB;
	Fri, 12 Jun 2026 13:42:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781235769;
	cv=none; b=OBQTSs0i/ApPKMuc+WG5O5d8t2oX197zH7BSbRFU/URX/fGtUCwpl2Lda0XlEWrl9LpWsoywdV/lwtxKbrCLgkhtK5tWN5lokh5C93TNoCCUuC6BVkXGuZLArFfiI3UJFYDNq1l6k/K5Tw1Zxo433L/yM3y3pkaNyl/EcPNISffkp/OYa6l3jxZf+o2kmnkjYzIT7UyS4h4Yz592/DIYEJyva9OtF+Y+viGcZOl6yzPFfuj8/+odVWzjfXFz+I0EWQdkr1QHB2EIDbIPc+3U02nH87J5QXhQ3jtsFWloPVSYnHdatNmJexGa2Napaihs6W06CEYrlsyc0YOAHPuO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781235769; c=relaxed/relaxed;
	bh=KlewREvmlKxyUSiB6UGySm1S0lQUskxigHenXGFtImY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMFsnzIQy4wtqb7lwEh5dUZ0gfPFmY1eOumvWCzOTFcZVwuGFDAG4fya9thPl8LaRAASOf7tIiUNsnF5n7T4AuM/nFGbPUdH06xFhy5DkIo93r81uhXcws0Fgby1deehKhUZaWHtLGBwtCaQUH0WEKTb31UbCnCCi4HdiqITpIIpkSYNAVepDNJhXi1xch6wqLNoKtOTOg/u1AsZM02OCgLECSMcxusvZgBmuIN55ziDqRzd0/dP1BUPlmyLg/UaVONUcCp0qU8GoaKXUlZFeLvuccCtVhznrFuBD7B8CdxgT+amPHgyZOH/EzmOX7NMkm2aKHrPEUXUGKgeGIAuIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=irLGz5l+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc51y5jrVz3bpt
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 13:42:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781235761; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KlewREvmlKxyUSiB6UGySm1S0lQUskxigHenXGFtImY=;
	b=irLGz5l+TZ6C5zoR3hDaq6+d54HSHWG4QwVUHzhHj5Jutd4E6DAJ16BujfZag38IivwxPf547x4RH4f9sFP+5cq3hA4HnOnFG6ifEG6olAndOufE7V/o97p96wgsJsBWg7NqO54krJnSOszPwRlYwls9DDwWkK86549g509HbUM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X4fy44o_1781235759;
Received: from 30.221.132.172(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4fy44o_1781235759 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Jun 2026 11:42:39 +0800
Message-ID: <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
Date: Fri, 12 Jun 2026 11:42:38 +0800
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
Subject: Re: [PATCH] erofs: prevent buffered read bio merges across device
 chunks
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, yekelu1@huawei.com, jingrui@huawei.com,
 zhukeqian1@huawei.com
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260612033244.993507-1-zhaoyifan28@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3574-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15D9767675C



On 2026/6/12 11:32, Yifan Zhao wrote:
> EROFS chunked files may place adjacent logical chunks on different
> devices. The physical block numbers are per-device, so two neighboring
> chunks can still look sector-contiguous to the generic iomap buffered
> read code.
> 
> For example:
> 
>          logical file offset
>          0          8K         16K        24K
>          +----------+----------+----------+
>          | chunk 0  | chunk 1  | chunk 2  |
>          +----------+----------+----------+
>               |          |          |
>               v          v          v
>            dev 1      dev 3      dev 3
>            sector 8   sector 24  sector 40
> 
> The transition from chunk 0 to chunk 1 crosses a device boundary, but
> iomap can still treat sector-contiguous bios as mergeable without
> checking whether they belong to the same device.
> 
> The pending bio, however, is still bound to the previous block device:
> 
>          bio->bi_bdev = dev 1
> 
>          file 0..8K   -> dev 1, sector 8
>          file 8..16K  -> dev 3, sector 24
>                           (must not be added here)
> 
> If the second range is added to the same bio, it will be submitted to
> dev 1 and read from the wrong backing device, which is easy to trigger
> with readahead.
> 
> This only affects paths using erofs_aops, where buffered reads go
> through iomap bio helpers.
> 
> Fix by install EROFS-specific iomap read ops and split the pending
> buffered read bio whenever the next mapped range belongs to a different
> bdev. After the split, fall back to the generic iomap bio read helper
> for the normal sector-based merge checks.
> 
> Reported-by: Kelu Ye <yekelu1@huawei.com>
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

I think it's an iomap bug instead, see:

iomap_bio_read_folio_range(), we should fix iomap instead.

Thanks,
Gao Xiang


