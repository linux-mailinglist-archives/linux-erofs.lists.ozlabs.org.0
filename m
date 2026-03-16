Return-Path: <linux-erofs+bounces-2755-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAubLnI4uGmpagEAu9opvQ
	(envelope-from <linux-erofs+bounces-2755-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:05:54 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D609629DCD8
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:05:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZM1C2VpLz2ygl;
	Tue, 17 Mar 2026 04:05:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773680751;
	cv=none; b=iOnolbhMlkJHM2fb20PCDrtNKLB4khGZMFIIEmcWUnJwrJRrwk+NNvrkMXEFLdu3CmspLkiftTnTRxlpgqdu1m6YVJX9F9llhAbxc7FR6Rt1TEu2zrFmQBcJgRHHFP12ovCr4/F8IttdsFt9xocEPCzgc2F+oD8pW5EdwSOp8Ryg3sjeAItPkRFb5k6spqEfJE8Ny9q0NwuiK7AEj0P3vRBhYsxB06+innU1a7em/8Pv5IbNV+IS/HeCu12urG6ncDLEYsOOT/XJPzQATEEcfR3Wr0d/ImXWvqgc88ehKZalexYd/EC0hNaKEw23p+GWdTmOqQLMss/cqbtRad+vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773680751; c=relaxed/relaxed;
	bh=c3dLwhIi+FVgIU3tzhBul+4ANeOs6QbucsVt+jSD0os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guCJ+dGFUf+yeyW2h/4rxGvKNKrTsuncpCZ8YrM68KmauqGuTAmsS+XviAi44ZVbWYp4qRcjdT2wirycw3yuoHzeFhFOVf2xJKh4bmadqa6J5UsTBHXJaxfFsV2bQeoyXG8VsqAEjbyAxVWbUi8dnsnDqDAeqkcxz4V7i2RCy2shPU+3wFWDcVtKChR6RRtI2OvYOpDaJpakYRstsyBRlsSvLAyTwIC0uUzIL9HD8yAK8a16reYKC4njwFP3KEu+g9Hdtok+9BfTdpYjHh31nhOiqo9zi0LcURmx2GSxb9vL8eeB8VTKa/RPEgYBdZB51pdAEDl53pY/x4ybDF/iyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mVyAysCI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mVyAysCI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZM1918MBz2ygh
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:05:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773680743; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c3dLwhIi+FVgIU3tzhBul+4ANeOs6QbucsVt+jSD0os=;
	b=mVyAysCI0P8Uz41zNkHDv8r6/rTMqLqHsGdjCv6dDQnySU6ZqKMF+jN3vEcQkD60RXCCsvn/Ly+7UV4TVnlOlWs0lblCVA7Httrz/x5DIsNvBLUxWssBFg2TRWjWbst7Dw5uZd6DQ+paDMC635g5I4lkUqVkEfh1bkdfb1RSJpY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.6zyyV_1773680741;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.6zyyV_1773680741 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 01:05:42 +0800
Message-ID: <5bf6079c-e66a-4c40-b6bf-f4abe961bc83@linux.alibaba.com>
Date: Tue, 17 Mar 2026 01:05:41 +0800
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
Subject: Re: [PATCH v3] erofs-utils: lib: name worker threads erofs_compress
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
 <20260316170233.30662-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260316170233.30662-1-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2755-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D609629DCD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 01:02, Nithurshen wrote:

..


> @@ -1427,6 +1430,12 @@ void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
>   {
>   	struct erofs_compress_wq_tls *tls;
>   
> +#if defined(__linux__)
> +	prctl(PR_SET_NAME, "erofs_compress");
> +#elif defined(__APPLE__)
> +	pthread_setname_np("erofs_compress");
> +#endif

Why not call them as `erofs_compressor`?

and could we wrap it up as a new function like:

erofs_set_thread_name() somewhere instead so that
users can use it easier instead?

Thanks,
Gao Xiang

> +
>   	tls = calloc(1, sizeof(*tls));
>   	if (!tls)
>   		return NULL;


