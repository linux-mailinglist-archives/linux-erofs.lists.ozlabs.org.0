Return-Path: <linux-erofs+bounces-2420-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEk6Ku+rn2m1dAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2420-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:11:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97151A00AD
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:11:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLw226KZFz30BR;
	Thu, 26 Feb 2026 13:11:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772071914;
	cv=none; b=EQfCqAuvN8BHk5XdHXNYinyrj3IqL9vRVH3tzAUrpB/QIV3VbundsEbhL4/5uSPuHnOYq9Wl32pb9H4949mkrs0IzTqlUOgJyuOxh64AMqkDHOkTlOkdyBBHhJ4wBz8/l49Y2pOksWj977X/o+O9Xjzd9CQlb+NklvMXupOz1eNm09IAMOviguMz2LBPRoiycoB7Jd/Oit3xtSQ8HUmWsZNTevBxa9ZKNqIVJ2Qbb6NoEI0ehiCPMqeKWUPmVp6us/SpTRmM0kzerpCjS5ZQEOK/7Rxd72+64i+i6TsfrricXKKTVLNwT4SbEGEadyCUk+XBMMjHFILtdbBthLgIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772071914; c=relaxed/relaxed;
	bh=Q0NZOonOhmHDsNJYKHppYF7FAcDgRVzhjKo1vEwS7d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAplaRFE8Sf3+ADiozdzN/mRNyIwRCKUINu1K2LF8EvtUpcPhdE+674ITlSfV+tjXplWn3Tk/VxEDIrir6hyklA7Wgp8mBVjLD8p9jsan64YmcSAk7/TkZgc5FUbKByWJiMclEIs7S9mfNgIKdiIltoEbVq7o9ED1bpZIEru1L+7YCosfHVahI50xpHRcTNgaS66kJ3GSUNRSj3uH9aPkf7OasaGt1H8XH2Pj5KFZ3vbE+GhTu4f/cNHR1/0uqHnPpVMv9xz+usSg8INXICqFBLK874uw9rcaP6QcNzR5DFz+awo0fT/QBGABFoSoqHYaXH5QXmIGZo20DfdeyHa6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HZireu14; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HZireu14;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLw205Z60z309y
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 13:11:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772071906; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q0NZOonOhmHDsNJYKHppYF7FAcDgRVzhjKo1vEwS7d4=;
	b=HZireu14t/mlHQGQoNI8jxwysZD0dms/U3i8xktG3gVKkLjdX5N9ceOru+phuWsEYc06IINyWsa4Bw92JtuLRc0O9CnNJGl7nMEqF+uZ8ysuMhz8aTvA4QqJ8UnPFmtNE7i3xxB1abXsADEeJRaP+q3LGqxLod4n77DQhB4lW4E=
Received: from 30.221.131.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzpdnIw_1772071904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 10:11:45 +0800
Message-ID: <af0ac18b-7358-4e6e-a07a-474e1a664dd0@linux.alibaba.com>
Date: Thu, 26 Feb 2026 10:11:44 +0800
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
Subject: Re: [PATCH v2] erofs-utils: dump: add missing compat features and
 separate feature display
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com, zhukeqian1@huawei.com
References: <9acfc376-f200-40a0-ab21-87b6221b3b31@linux.alibaba.com>
 <20260225100640.554705-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260225100640.554705-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2420-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A97151A00AD
X-Rspamd-Action: no action



On 2026/2/25 18:06, Yifan Zhao wrote:
> Add three missing EROFS_FEATURE_COMPAT_* entries to feature_lists:
> - EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX
> - EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX
> - EROFS_FEATURE_COMPAT_ISHARE_XATTRS
> 
> Also separate the feature output into two lines:
> 'Filesystem features(compatible)' and
> 'Filesystem features(incompatible)' for better readability.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

Applied with some modification.

Thanks,
Gao Xiang

