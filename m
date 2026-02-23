Return-Path: <linux-erofs+bounces-2369-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN1oI3ZonGlnGAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2369-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 15:47:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69AE1783B8
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 15:47:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKNww2j7pz2yDk;
	Tue, 24 Feb 2026 01:47:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771858032;
	cv=none; b=jW1Fpb7aWPUatmaLOzQo1aDYvSg4lTZN5afNiwxfZT5cHHvGHEsNuvlNIjXvT4uBapzO+hevdGOnvN9Xm21GT8+q4fWbnV6fCiL5RAVG6z3qi9bT3jfbVx0PZNM1gNt9NC7nxVTFCgTzn+Qx9i8lXZF4ScF9dTYeZX2xZWEZeaPTMAgw0rha9hU+B805RL+qWIJ4M90Qn7YcQG6nEuupFK80LBszLGUhS6PJZCDSzCmlcs87TcTJygKbcTPmJ4oa7Ky8IDrCI3HQS4cXfsyL+XepAHV0Jl6ca6oynXsNPfYVI9KD2ZvirpQ+2EOWGznWXqSqoFp2wxW40TU3VqYy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771858032; c=relaxed/relaxed;
	bh=jrdY52taT3U/NZQPuGXBlMxO3l3XijeN4kwKfbf/UaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIO+RTV33w6EqNR+vscXbI1yTRbG74DXEmQvvbuZsvilhlbbxaFJt/XeP7oBcMPDetv3aJcuL9A9uMC8BjCsYfCXEbcrXh/u8EaoYnv3U+O/l+ZpLwIELwaeuPBpSoyJ1WX9cwNS5RCBcdR/dUQJBPMEm9DqzxS+ec87QgO3cD4xsT6yjUczXUF6LUmYz73gZ1MLS6K/gVDnVKV+1jVonKfcESOWFSPCC4GivteRhPLJCZOQOBtD4UFerbiZZBKjEqgopFgakuLGLfqAWipDAamLcZKTVpej5oS5E9UveZ6ev1eYmFdn3kYRHd86FZPLw6FlxDqszTdjZUk5ht5aVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gvPA+MB/; dkim-atps=neutral; spf=pass (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gvPA+MB/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 80 seconds by postgrey-1.37 at boromir; Tue, 24 Feb 2026 01:47:08 AEDT
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKNwr2q3fz2xN8
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 01:47:08 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771857916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrdY52taT3U/NZQPuGXBlMxO3l3XijeN4kwKfbf/UaA=;
	b=gvPA+MB/3rPZe3/+/xAdy7rLGGsuixZx+6Lg/SFcdvj7Pne2gcTVBzuqWYk6/eSywKtBCg
	/+sZ+33MMW3OoWIFucMMZgXUSMYkPwnWDirsMg0jvpEzROz4AOTFePeJ+p4rAiMfDKgcVO
	5d9tzkSlI2GvoE75tBd7urtM5+ANWj4=
From: Usama Arif <usama.arif@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH v1 01/11] relay: zero page->private when freeing pages
Date: Mon, 23 Feb 2026 06:45:06 -0800
Message-ID: <20260223144507.3065618-1-usama.arif@linux.dev>
In-Reply-To: <20260223032641.1859381-2-ziy@nvidia.com>
References: 
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
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2369-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ziy@nvidia.com,m:usama.arif@linux.dev,m:linux-mm@kvack.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-block@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:kernelxing@tencent.com,m:katrinzhou@tencent.com,m:mhiramat@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linux.dev:mid,linux.dev:dkim,tencent.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D69AE1783B8
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 22:26:31 -0500 Zi Yan <ziy@nvidia.com> wrote:

> This prepares for upcoming page->private checks in page freeing path.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Jason Xing <kernelxing@tencent.com>
> Cc: Yushan Zhou <katrinzhou@tencent.com>
> Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> ---
>  kernel/relay.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 5c665b729132..d16f9966817f 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -131,8 +131,10 @@ static void *relay_alloc_buf(struct rchan_buf *buf, size_t *size)
>  	return mem;
>  
>  depopulate:
> -	for (j = 0; j < i; j++)
> +	for (j = 0; j < i; j++) {
> +		set_page_private(buf->page_array[i], 0);

Hi Zi,

Should the index into page_array be j and not i over here?

>  		__free_page(buf->page_array[j]);
> +	}
>  	relay_free_page_array(buf->page_array);
>  	return NULL;
>  }
> @@ -196,8 +198,10 @@ static void relay_destroy_buf(struct rchan_buf *buf)
>  
>  	if (likely(buf->start)) {
>  		vunmap(buf->start);
> -		for (i = 0; i < buf->page_count; i++)
> +		for (i = 0; i < buf->page_count; i++) {
> +			set_page_private(buf->page_array[i], 0);
>  			__free_page(buf->page_array[i]);
> +		}
>  		relay_free_page_array(buf->page_array);
>  	}
>  	*per_cpu_ptr(chan->buf, buf->cpu) = NULL;
> -- 
> 2.51.0
> 
> 

