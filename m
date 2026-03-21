Return-Path: <linux-erofs+bounces-2900-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIVWMhk+vmk8KgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2900-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:43:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179892E3B79
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:43:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd8yc4y6wz2yhX;
	Sat, 21 Mar 2026 17:43:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774075400;
	cv=none; b=gB+dGYGUV/4enAZKfC6832E0W9pE97Nt1M7wSzncsbJ2jAlNXiPcqOCPjUNIaN8inxBFnlx5dos5V9w9uOdEWyRuqVTRW1FlgfHSf8/XQqnOwhoJTnLTsdQzh5Z4jErKTUMcSZ0MkqIjG8PI3lpVcgvk8w61LBBpHd4Zl0Tv4+fcVydnRkNbJyx7hfA2L7YhHtshuTJyuToHDOxexEMeQv3IOCXXW7/6q8gn7BBj6ozxUEPERl6HGixPfVwnSFCuAKv/WWcDUb0or75tXkXgAAiWO9yVbvUFVkUhotjUVbHeKLf68EPpYI6pVKFIt4U4SonFiAx5uY9B27J1X6lQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774075400; c=relaxed/relaxed;
	bh=isrk1msfz6ShTLvztV+QVeC/kPKRCTb5sRdDldjlYXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmSOG6YRVxcmOgR4cuz+J0i9uYBpLUr7DntlK2GmehPgZYp21k7cRFEoAfFowg9BwmAz31wmAEcjyfBMdVt/pqf5mr4waE0fsKN1eudWurdg9zwDD9RPEIomvJ2ND1RD7/w6X7pNIZ5fKrI/ut4xK/RzhRCXyS7bN+m1Df0WnF9V2C85IF5OP+CD9+XRFYj4aUc0B3LlAmk5ZA22gq2IY2WJFOmiuFQ089Fjb5hsuAuU5nUO01lo0i+seHrgBDkUesmy+vSgAIBBwlcFxy4M7Lt54dMS52apY8Fk9ropIrfvC5hba5LPUX+YGIxj17YvpDZAr/pNnFfVaiRpo2cHIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LSFXpERb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LSFXpERb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd8yY5684z2yZN
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 17:43:17 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774075392; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=isrk1msfz6ShTLvztV+QVeC/kPKRCTb5sRdDldjlYXM=;
	b=LSFXpERb1cSqVGL8VlYYSLeGko9FaqwMX7oPlNYxFGuVfK02LiTHhsi0xGPSZ8JWPY9/JDrxSJRDeA/zn+RMAljTxw0bX1WQMOpgI6xFZ0QNm79K7e4GpWpoqh+apqLZHyja9c3y921sWCvciOpnb7gXmNeUFwaybJNQvWgg//g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.ODaKu_1774075390;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.ODaKu_1774075390 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 14:43:10 +0800
Message-ID: <cb307f5e-bb07-4456-8bb9-7d4697171d14@linux.alibaba.com>
Date: Sat, 21 Mar 2026 14:43:09 +0800
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
Subject: Re: [PATCH v2 1/2] erofs-utils: fuse: add missing return on getattr
 error
To: Ajay Rajera <newajay.11r@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260321062604.1905-1-newajay.11r@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260321062604.1905-1-newajay.11r@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2900-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 179892E3B79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/21 14:26, Ajay Rajera wrote:
> erofsfuse_getattr() calls fuse_reply_err() when erofs_read_inode_from_disk()
> fails, but does not return afterwards. This causes the function to fall through
> to erofsfuse_fill_stat() with uninitialized inode data and then call
> fuse_reply_attr(), sending a second reply to the same FUSE request.
> 
> Sending two replies to a single FUSE request is undefined behavior in libfuse
> and typically triggers an assertion failure or crash. The uninitialized inode
> data may also expose garbage values to userspace.
> 
> Fix by adding the missing return after fuse_reply_err().

Each line of the commit message should not exceed 72 chars.

> 
> Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> ---
>   fuse/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fuse/main.c b/fuse/main.c
> index 82aca8c..b634782 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -265,8 +265,10 @@ static void erofsfuse_getattr(fuse_req_t req, fuse_ino_t ino,
>   	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
>   
>   	ret = erofs_read_inode_from_disk(&vi);
> -	if (ret < 0)
> +	if (ret < 0) {
>   		fuse_reply_err(req, -ret);
> +		return;
> +	}
>   
>   	erofsfuse_fill_stat(&vi, &stbuf);
>   	stbuf.st_ino = ino;


