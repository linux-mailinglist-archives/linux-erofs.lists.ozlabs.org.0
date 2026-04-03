Return-Path: <linux-erofs+bounces-3195-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPY4GwZ6z2mvwgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3195-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 10:27:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B0739212F
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 10:27:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnBg402lQz2yVP;
	Fri, 03 Apr 2026 19:27:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775204863;
	cv=none; b=mR+PvNj+7pn7ZKZn1+ufhypM0bX6k880VqQ6AiP92xeRS5sjAc4E76y0Viwmazv5BzNolGajR24nz+i+Ssycg7CF9Duf9uA7bp2hGTJDn31n75Rt24MB+rzY2vZTC4ivkCe8Q1P7JEbXIXZTCiqiUyHFLsWaGiTmZhz6lLXNFuSMq+clcPb+j9D/SbzWwiiA7ftu0kziNvYcbR7zLfT+wIvh20G3RNNxH6GnBALPE15QW228MgR/Lx7SP8f++Bwx6UsTv98kI7FPZx8/IKXPazC58q2Slq4Legh66HK+ECHG4H/uUG16J5GiCJF50ENm/c8AVKe4l/dSoRkUk7lMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775204863; c=relaxed/relaxed;
	bh=WwIVq++6ZGZSOsvQFz6ZBP7JWcltK+ZVE+dMkEeDzmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BELIR1peF+Gin3Mx18VPecyQXXWOLvA9dP9/ZclOoUtC6R+do5bvFvJvPG6mP/KpiQLJm3eXSZrCaaSbv+/7beTRR77/QUeKDwpkxtpDIn1J4a3OsO79gVhMvDOG4BgHjxDCssXgYoP9E2kvqh8XZ9odd82O97JGVNI04sh3jz55OhHrj5o6XJT5SBgql2F30GoqJl+BbmOszSFh12JWLodLfVqSMXnO05fGnVCAQNrm2agAi/o7MPdQrNsMRxGGWyXnqkx2mBAtXAoB3KD9Q1fmzvVQN0bt2OmlUKZZB0+xTM52xdSCUX8BvGMCSbWxCr8LMYmRPrRz4IWOERrbUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L6aJ2lkS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L6aJ2lkS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnBg13PSxz2xln
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 19:27:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775204854; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WwIVq++6ZGZSOsvQFz6ZBP7JWcltK+ZVE+dMkEeDzmM=;
	b=L6aJ2lkSgnWfv47HiS/OR0B5DPcAlWNMgZVqQjjEI6dNR+u/SOw371D7PppCI2bZYeQ1tk4ri7GFNU5T33wZE7xt1vVNC9PcG2O3rHVg1TUf2FO1grJMESovxyA+54Jc8/e40LG6wHRGYFIFBJbzVm+2U6cDW4fZitHm0Ze53sk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X0JhcaF_1775204851;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0JhcaF_1775204851 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 16:27:32 +0800
Message-ID: <bc326e0f-dbfd-43a0-9311-00fc72efb4c3@linux.alibaba.com>
Date: Fri, 3 Apr 2026 16:27:31 +0800
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
Subject: Re: [PATCH v2] erofs: handle 48-bit blocks/uniaddr for extra devices
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <f54ce712-9d7b-488b-8dc2-9d5e2455f80c@linux.alibaba.com>
 <20260403063658.72140-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260403063658.72140-1-zhanxusheng@xiaomi.com>
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
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-3195-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 84B0739212F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/3 14:36, Zhan Xusheng wrote:
> erofs_init_device() only reads blocks_lo and uniaddr_lo from the
> on-disk device slot, ignoring blocks_hi and uniaddr_hi that were
> introduced alongside the 48-bit block addressing feature.
> 
> For the primary device (dif0), erofs_read_superblock() already handles
> this correctly by combining blocks_lo with blocks_hi when 48-bit
> layout is enabled.  But the same logic was not applied to extra
> devices.
> 
> With a 48-bit EROFS image using extra devices whose uniaddr or blocks
> exceed 32-bit range, the truncated values cause erofs_map_dev() to
> compute wrong physical addresses, leading to silent data corruption.
> 
> Fix this by reading blocks_hi and uniaddr_hi in erofs_init_device()
> when 48-bit layout is enabled, consistent with the primary device
> handling.  Also fix the erofs_deviceslot on-disk definition where
> blocks_hi was incorrectly declared as __le32 instead of __le16.
> 
> Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Thanks,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

