Return-Path: <linux-erofs+bounces-3331-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDlZHyaW5WnrlgEAu9opvQ
	(envelope-from <linux-erofs+bounces-3331-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 04:57:42 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B2426738
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 04:57:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzVXM1wcgz2ySf;
	Mon, 20 Apr 2026 12:57:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776653859;
	cv=none; b=ENjTLyoDciB3WMPJdNGl7/2TVz0xrtYw2gyROozXGovScaeJY2waAQlxYPwDePIZLXU5h+yvgekJkHOkpLzkSc+1WGmnwAM1uONmbAxXbTOvutPKrrrWB8iqfUIzEwH5ukj+G3/xD35t6gvaitsRSsEqkLUTwmudriO6Od4UqDqGqgvvR/D+gmovHoqLq3r+7x8m4/kFlnYHEoGUZsAZxld/nL4iPVJG7Jla2toiaxzHY75egfj1PP9gVZFKhfkvb/avNGIHjuI1migUVzaJtTmT2w7Lnv7F2fLzFbwiv9qfjbuIeHH7XAu6d+vED05msgRdfDP3zGdYUuz4+KlE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776653859; c=relaxed/relaxed;
	bh=N3ooauqtkeSAFzd9PuOWi3TQb556RvJ+NP1D7m2taak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsLr1clvJvdCg/qg1jibLZ/QhHWZah6vpQUMUeCf1ybqcMAu8vAs32hsMEYx6XMHOycx7+aiK6QGRpk83+6A3dGFp0yfh0ZQVy3sRm5on2E2jUVU23YiLuhjUE0ajGOntXq408U6A5BFaXjphuOOYEc4QQJ5uoBfJIEsaYChkRcTThC1TIuWFyzq4AODDlB51AQcG6iXlsEfsjtF8hvZ92Wcg6FXLRtM5hzfcxJX7et3XOl3bv0YvFqEm+G4g7qroPFsUUKcah3GeV5TwEscODQm3U9Fwt3I8niM1r/h8Sn5LxzFYnmGeiy8dxdGvhNR/DLnv88TX6jxQ0/MMFamew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cqZPkZU7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cqZPkZU7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzVXK4T2Zz2yL8
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2026 12:57:36 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776653852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N3ooauqtkeSAFzd9PuOWi3TQb556RvJ+NP1D7m2taak=;
	b=cqZPkZU7856zLKo7fhFROKwvRYJlxm1g4TkYYnAoZdYCz7NxEBCiNn6i7Jjzx0i2Bd3W8LYezSN5eg3+II2RDyloMuwl+RTziCTNoP0P3c9H4VMuxa+ZH4IB0kGP9K5WIIr6gXm5J1I1kVxRkhQkl8Hn2wArEDBQpscvHY7qYAo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X1GlyYT_1776653850;
Received: from 30.221.130.173(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1GlyYT_1776653850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Apr 2026 10:57:31 +0800
Message-ID: <a346d73c-0c46-451c-b97c-a89c73bb8ab4@linux.alibaba.com>
Date: Mon, 20 Apr 2026 10:57:29 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: libzstd: fix undefined behavior shift in
 setdictsize
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <00f14a87-6914-4e4a-96f1-6d0f911edc4d@linux.alibaba.com>
 <20260420025023.11802-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260420025023.11802-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3331-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: A25B2426738
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/20 10:50, Nithurshen wrote:
> Hi Xiang,
> 
> I do agree that `pclustersize_max` is always greater than 0 and
> `ondisk_extradevs` is at max 65535.
> 
> My intent was to look at these functions as independent blocks.
> Even though the current upstream callers provide safe inputs, I
> wanted to make them robust against any undefined behavior in case
> they are reused in the future.

They won't be reused in any case like this.

> 
> Thanks,
> Nithurshen
> 
> Regards,
> Nithurshen


