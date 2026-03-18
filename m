Return-Path: <linux-erofs+bounces-2827-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO6NNfdkumklWAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2827-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 09:40:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB62B833D
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 09:40:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbMhz6ZlRz2ygT;
	Wed, 18 Mar 2026 19:40:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773823219;
	cv=none; b=AgsUBdaPh6vwcxt5Fnqbu1IWfmbn+JgiicIhqP2vXQJOtsr1NlMgXmI6SThkJGDM87FD0cELfd+bWpxKM4nsWWm1s8AcjiAZODlVHPNRxtD6bLPjezKNNgPmrGC8O6xmwjxQORK9xHODdwnp+ZKJ+3WX42cE2J8zp6qGelyev2zScZH6tTRVS1UedOfCIoYzvNe2rED5DDfN5PrsbUs1sU31RSgZjNM8XCSOkkbvfUSi5nJs2M9Pil3wXlyP1F5DBYUkK07rYtPHLIAJiZx6lL8Cp547Szj0qrWXOR7qlGX2OXymDXlI82LwIjNdg7a6xoCyH1sTXyfpd4+nW6AGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773823219; c=relaxed/relaxed;
	bh=0/Sks+iuRo1Ry179JHqdZSfTl04WwY+ESPWGbc5tOzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Snh4X00zg+F4R7TwbyWV8rYXhNutq7evrpJnP5woDuMeBj7KnW8K18PfFsHAq+SFAw9fAqyPqd6XX3dHLiRCz2mA+qfem24cu81fv8QvXDHRRcVfg2clPCbNLbS7nYu6IDuoyCYGGmHFMVxnjv45de/SHd4b63gFZksdkfLuZ81rJFc3+pK4ULT+TtOnzX+EWZIYsMBhTjywM6mW4nv8MefRALAyhx5FQfUOXTasdk/A+pQQYqT3Yt6I5GFQ/W6mboKggrUunuTZxtPBF9Sb/Xvrx6G6Dgcd51pJnwDTU627cZcnfPfiw+3FOe7GpEDG8C4v6QfOdNosEP50nivDwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vHgi65D3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vHgi65D3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbMhx5hx4z2xlx
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 19:40:16 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773823211; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0/Sks+iuRo1Ry179JHqdZSfTl04WwY+ESPWGbc5tOzw=;
	b=vHgi65D3gCFYSlRJ96RIYDKdPhBfMToqfK1ECQJJTExK+1GnzmFJb1pxDYngwZpsTyCYRNz91SNczNohlwWONUIMCyUFCSoNEX5MUpJeuPkL2ZZxJbHudhesV9aJKs87ZXqcJ3+oRpHey7A7eMNWiowq3RrBaHXEcJv5gEJ9vVo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X.Du1hj_1773823209;
Received: from 30.221.133.123(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Du1hj_1773823209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Mar 2026 16:40:10 +0800
Message-ID: <3fa2f826-3c2f-4868-885e-96501e2e7863@linux.alibaba.com>
Date: Wed, 18 Mar 2026 16:40:09 +0800
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
Subject: Re: [PATCH v3] erofs-utils: fix thread join loop in
 erofs_destroy_workqueue
To: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>,
 Yifan Zhao <stopire@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, "zhaoyifan (H)" <zhaoyifan28@huawei.com>
References: <20260317043307.27575-1-nithurshen.dev@gmail.com>
 <20260318060319.13191-1-nithurshen.dev@gmail.com>
 <CABra5+2gf8+T4ker-7rdABiy25VVPjPUSLjzarttxajYkjU2xg@mail.gmail.com>
 <CANRYsKjM39syDFQEv1v7NBa6OSqEVFwdYHo1+5qFQD7VVupgZw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CANRYsKjM39syDFQEv1v7NBa6OSqEVFwdYHo1+5qFQD7VVupgZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:stopire@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:zhaoyifan28@huawei.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2827-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: F0BB62B833D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/18 16:36, Nithurshen Karthikeyan wrote:
> On Wed, Mar 18, 2026 at 1:47 PM Yifan Zhao <stopire@gmail.com> wrote:
>>>

...

>>>
>>> Reviewed-by: Yifan Zhao <stopire@gmail.com>
> 
> Thanks for the review,
> It looks like the CC list was dropped on your last reply,
> so I'm adding the mailing list back.

Will apply, busy now.

Thanks,
Gao Xiang

