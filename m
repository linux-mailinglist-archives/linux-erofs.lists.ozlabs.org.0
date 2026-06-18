Return-Path: <linux-erofs+bounces-3667-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9yEfFUKbM2qmEAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3667-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:16:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2069E049
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:16:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=R9JyEAlP;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3667-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3667-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggsTV09YLz2xM7;
	Thu, 18 Jun 2026 17:16:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781766973;
	cv=none; b=YKyzdxDFbu5lN+vIWCMfD652X4x/gHnTC0KGnftnFeORv/KNi1TY1jaHmY0u4y1L2lW6kyOMb8YPxxrpLUCCczElaFs98xjqWp51QKU+WQoFMDQ6+BlxyGSsxWnosO3+W8kKECcc5w9jvk2owcb69IvVa+PW7O4CRcv3m+1ARpRZqFUcpwoFa3wZVCAk92SeCP2RS1tyalJhLmZR8qj7DPEfa9CMp/6E+/AWjbhu080xUJSqvSltbTTFVzE+Glx/hqwrWr2IcmkgCIbZTydD8zR6eJ2JDrVAWQrNjiEVwo2mPZpFaic3mVjmSUT4+X2EPTDZ1uJ9gKYCQh9zA0aK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781766973; c=relaxed/relaxed;
	bh=iVdMWBlT662SrcMGF8y/JgT1w7kd5zj4BN+nKS7wNos=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U+tSLQeb72F3N/7ZS6vIp3ADvakwVLzY+++wlPRrzTg5H1Ar1NdwLcEl5pPDR7Tn3tFNszWj9dx9vY68UB7i9m5unGHAEl+WAHQtpSFRKT9UIDXGaX/DptZM/YHWMbMsKztd4JD1TqI4ULsEhbUOuWx0w1Gl1gMoDVbjjf8df+w/EGCSDOCt3AJ0/3besOIK+7E9EuD+BACTkwcujYasJXMvlP6Lu02gvTKKdIyT/jBpUYEfemiv1YV4l+uGrKb4WAZZDQCXFLb/hniI7Np3XPsFXvic16I16/j6u4tG7JywwURZMnbLQJozO36z10fov1YKd2WQD7Jb3R5j9Z7q4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=R9JyEAlP; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggsTR3rFbz2xLm
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 17:16:09 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iVdMWBlT662SrcMGF8y/JgT1w7kd5zj4BN+nKS7wNos=;
	b=R9JyEAlPmRphrW7FCV665S9w6GTNpkK1q8uUkDLokTNRvccCAjTIQHD4qtCa8uKgEFtAfitt6
	BakpTY9xfKqLembS9Ixw3nAcypVhIoTw5yAEgsGsHtCuQI9HjjiJmZoE0emPodtX/pU4o6OSaoz
	9fYw46eICuzrTpIRzynliaQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ggsJ26R11zKm4B;
	Thu, 18 Jun 2026 15:08:02 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 7042540562;
	Thu, 18 Jun 2026 15:16:04 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 18 Jun 2026 15:16:03 +0800
Message-ID: <fbc281ab-09ba-4e3a-90cd-2babc708fdc4@huawei.com>
Date: Thu, 18 Jun 2026 15:16:03 +0800
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
Subject: Re: don't merge bios over iomap boundaries, was: Re: [PATCH] erofs:
 prevent buffered read bio merges across device chunks
To: Christoph Hellwig <hch@infradead.org>, Gao Xiang
	<hsiangkao@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<yekelu1@huawei.com>, <jingrui@huawei.com>, <zhukeqian1@huawei.com>, Ritesh
 Harjani <ritesh.list@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>,
	<linux-xfs@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>
References: <20260612033244.993507-1-zhaoyifan28@huawei.com>
 <58bef9af-0926-4948-b917-e38c3793f596@linux.alibaba.com>
 <aiumQL8LEWQX_Nag@infradead.org>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <aiumQL8LEWQX_Nag@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,huawei.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-3667-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:yekelu1@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:ritesh.list@gmail.com,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:joannelkoong@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_XOIP(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,lst.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85D2069E049

Hi Christoph,


This patch works well under my workload (at least correctness-wise). Thanks.


Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>


Thanks,

Yifan

On 2026/6/12 14:25, Christoph Hellwig wrote:
> On Fri, Jun 12, 2026 at 11:42:38AM +0800, Gao Xiang wrote:
>>> Reported-by: Kelu Ye <yekelu1@huawei.com>
>>> Assisted-by: Codex:GPT-5.5
>>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> I think it's an iomap bug instead, see:
>>
>> iomap_bio_read_folio_range(), we should fix iomap instead.
> Yes.  iomap should not try to build bios over iomap boundaries.
> caused various issues.  Ritesh ran into that with the ext2 port
> back in the day, and I actually ran into it again with an under
> development xfs feature.
>
> Can you try this patch?
>
> ---
>  From 297230cc3c08cbfef3670b08c4e35813c18c523e Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Sun, 7 Jun 2026 08:53:20 +0200
> Subject: iomap: submit read bio after each extent
>
> This keeps bios from crossing RTG boundaries in XFS and probably fixes
> all kinds of other stuff..
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/iomap/buffered-io.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d55b936e6986..3642a11c102f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -597,12 +597,13 @@ void iomap_read_folio(const struct iomap_ops *ops,
>   
>   	trace_iomap_readpage(iter.inode, 1);
>   
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
>   		iter.status = iomap_read_folio_iter(&iter, ctx,
>   				&bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +		if (ctx->read_ctx && ctx->ops->submit_read)
> +			ctx->ops->submit_read(&iter, ctx);
> +		ctx->read_ctx = NULL;
> +	}
>   
>   	if (ctx->cur_folio)
>   		iomap_read_end(ctx->cur_folio, bytes_submitted);
> @@ -664,12 +665,13 @@ void iomap_readahead(const struct iomap_ops *ops,
>   
>   	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>   
> -	while (iomap_iter(&iter, ops) > 0)
> +	while (iomap_iter(&iter, ops) > 0) {
>   		iter.status = iomap_readahead_iter(&iter, ctx,
>   					&cur_bytes_submitted);
> -
> -	if (ctx->read_ctx && ctx->ops->submit_read)
> -		ctx->ops->submit_read(&iter, ctx);
> +		if (ctx->read_ctx && ctx->ops->submit_read)
> +			ctx->ops->submit_read(&iter, ctx);
> +		ctx->read_ctx = NULL;
> +	}
>   
>   	if (ctx->cur_folio)
>   		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);

