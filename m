Return-Path: <linux-erofs+bounces-2944-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBIlOprxwGkUOwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2944-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 08:54:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 118912EDE30
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 08:54:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQRC5lT8z2yds;
	Mon, 23 Mar 2026 18:53:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252439;
	cv=none; b=Kcmj5qRHFoCRLNkGzall6IdV71Ou4mzeXJ4mQOZwvN8dKIS7M0DcfI2Xw/rdvj5/esat70m5mSDAQgutgafVCKZYegosDEJ/eOlnQmCgyqTJLYe9mtuOILOGyLIaovHr3ccIHmklSue2M978tB6o+9GF5nq02r2ztxAByAzOksqLt9tCSsRuXyN5F0wDqui5QpCtvAW8HVEg53npHMMmsNsroITTH9zoUdeVE3KKblvJV6ItZRd3U47TgsTcPfhS7pl0E+E+ZtCfej9T2XSyxdj3E8uaYtTEiyUT+Rrx9QwoP6lk8AKi7AF28KjDq2qtH2QlJ5wXLucM0CKbR/bRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252439; c=relaxed/relaxed;
	bh=wJD2ZsTg6dIpYoe1fEovOgNeGSCaqIxgGZVO3kFEUcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvHgZEkkyDl0flkJ7t4cI1vGOO+5+WkUUBMtwAWPTAxek7GraE4dqbRhEIlI96FayrKo9ZpL2jtlGWt0vVBSzygNwil752JHjAwhjAKiH8PNY1ia0WMhDLiWncEzg5IyUO3DvP12G1hcyCKBz9BT9+ZZTAIZbMwVYkt237h3ajHeYoEoLv0AlWbeNGmJXHTl+4sO/voiFCaLmDMFTyQDn1Wnaqam3Y48ACB3YZiScKN98O/NU3uQ9ZoirtPC6SarAmoI/t484EKkdqDhgDo5YCEi8GPotf9p2HAKxYILPbXbCTh0ZtrLnQarwFU/U82lnpV7kNDobW7RHT+2KmgEgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QEZvJypQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QEZvJypQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQR94CXWz2yYy
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 18:53:55 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774252431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wJD2ZsTg6dIpYoe1fEovOgNeGSCaqIxgGZVO3kFEUcA=;
	b=QEZvJypQFLKJDroHTf0UO4Jo1bU9whyciJcrbIQiQ6O7M51HWBjg5EWE8Piwkc6jUYohn/jdjtkxOwpGekPL0ptB8XTIOQwWkdWKTIHdxBSc0Ag3PKSpReKq99nEu8FLjvqlwrxCT3AAGCTS3NJidtpK8I986lvCTIP4cbFziW0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.UYuOz_1774252428;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.UYuOz_1774252428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 15:53:49 +0800
Message-ID: <f9f2bd53-fc30-4606-bae3-4c8960e6c54d@linux.alibaba.com>
Date: Mon, 23 Mar 2026 15:53:47 +0800
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
Subject: Re: [PATCH 6.1 1/1] erofs: enable large folios for iomap mode
To: Denis Arefev <arefev@swemel.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260323074809.4542-1-arefev@swemel.ru>
 <20260323074809.4542-2-arefev@swemel.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323074809.4542-2-arefev@swemel.ru>
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
	TAGGED_FROM(0.00)[bounces-2944-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:arefev@swemel.ru,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:xiang@kernel.org,m:chao@kernel.org,m:huyue2@coolpad.com,m:jefflexu@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,swemel.ru:email,alibaba.com:email]
X-Rspamd-Queue-Id: 118912EDE30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Denis,

On 2026/3/23 15:48, Denis Arefev wrote:
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> commit ce529cc25b184e93397b94a8a322128fc0095cbb upstream.
> 
> Enable large folios for iomap mode.  Then the readahead routine will
> pass down large folios containing multiple pages.
> 
> Let's enable this for non-compressed format for now, until the
> compression part supports large folios later.
> 
> When large folios supported, the iomap routine will allocate iomap_page
> for each large folio and thus we need iomap_release_folio() and
> iomap_invalidate_folio() to free iomap_page when these folios get
> reclaimed or invalidated.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/r/20221130060455.44532-1-jefflexu@linux.alibaba.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

I think we have no plan to enable large folios for
Linux 6.1 kernels, if the following part is what you
need, how about just backporting the following snippet
with the updated commit message for some explanation:

> +	.release_folio = iomap_release_folio,
> +	.invalidate_folio = iomap_invalidate_folio,


Thanks,
Gao Xiang

