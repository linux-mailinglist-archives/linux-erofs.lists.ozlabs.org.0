Return-Path: <linux-erofs+bounces-2751-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KJMMbA0uGnXaQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2751-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 17:49:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CF29DA47
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 17:49:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZLfh6zkMz2ygh;
	Tue, 17 Mar 2026 03:49:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773679788;
	cv=none; b=nfXwewzStrb07v05nz9864+mwNxiPhQGhGfW+y1XHN75UhN/5cOg80qcVYrWpcG8wiZbPsdDP/UBALL9YplY40/Z6553TTVkCgTYtqqcIgMQuIJ0JDFn44DtMeVGJ0kRJC3DcekNqCp+oqx285VULodj+Gho+ue4Nbwax0QSD5PdEjd15vLpd/DCP7XTB9PwFaTaCCsCeLC8qvOP5wi8pcYfW8fBygpwR1z7qCQcUHhwfecaPF0wUuu9P7s8a2cc3nDXToam0cKlV1Te7SLgPNSOrCjBZPHdALe2oeToyXz0K77QiRFm6RBblmAkA7QIcClzj56J0JQp/cQUfOqlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773679788; c=relaxed/relaxed;
	bh=HLwPBZYSgXS09TZl6g5dhTul5XI0lnhq9/lGcifbvJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ec2ur+yUwbw97HXW3E3cIl9zSIxvdys+a50hBfFWO1ImX50zqTFf1Le42Nar88KhlvQ4tQWJIRjEthMrzbgUIAATsebvGTojYHw02K9n5DAsbmQipwupRAsIkJUEB50VxYI1r+a5/SaektBHuAaU5O/qM+cQ4a/O4xzHLmGqIdjSjS9bG/f7eQjK8FjVYrYKur2zRYMX0PJaYpdHPZ9Xw2lGv+ExH+cS7Ckz+tJM41egoMIXvB1BZVxCYs+W8LNJ1Ec5Rx+8KlErg2mgvw3Us0B4TUbWYfRi4NEPOOrLgD+1s46eN2XYNrrAojOSf6r7LasLP6EViJIcjbXdG1SW1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GsWGIFQs; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GsWGIFQs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZLff152tz2yZc
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 03:49:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773679775; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HLwPBZYSgXS09TZl6g5dhTul5XI0lnhq9/lGcifbvJc=;
	b=GsWGIFQsH7Bwu4MaE9aKqf+CVXdqg0+xMfNjgp0tGQuVw3DedpAl8tVzVUs0m1ndwmdvC8O/KsZ1Xajl7EXPWd4+p+d8T+6pZ8q1SQ0A5jkLOT5cXLjqTLqhHHyxu9+cHZvtf/QEe+7X2x/voYiMAILRmsYIPab0/djCeYld040=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.5wiR2_1773679774;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.5wiR2_1773679774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 00:49:34 +0800
Message-ID: <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
Date: Tue, 17 Mar 2026 00:49:33 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: name worker threads erofs_compress
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260316151352.59423-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260316151352.59423-1-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2751-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D77CF29DA47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/16 23:13, Nithurshen wrote:
> Set a specific thread name for the multi-threaded workqueue workers
> to make debugging, profiling, and process monitoring significantly
> easier.
> 
> Previously, worker threads inherited the name of the parent process
> (e.g., mkfs.erofs), making it difficult to distinguish them from the
> main thread in tools like \`top\`, \`htop\`, or \`ps\`.

Please just use `top`, `htop`, or `ps` here.

> 
> This utilizes \`prctl(PR_SET_NAME)\` on Linux and \`pthread_setname_np\`
> on macOS to explicitly label these threads as \"erofs_compress\" upon
> initialization.

Why not just calling erofs_compressor, since those worker are really
compressor.

> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> ---
>   lib/workqueue.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/lib/workqueue.c b/lib/workqueue.c
> index 18ee0f9..860e403 100644
> --- a/lib/workqueue.c
> +++ b/lib/workqueue.c
> @@ -2,6 +2,9 @@
>   #include <pthread.h>
>   #include <stdlib.h>
>   #include "erofs/workqueue.h"
> +#if defined(__linux__)
> +#include <sys/prctl.h>
> +#endif
>   
>   static void *worker_thread(void *arg)
>   {
> @@ -9,6 +12,12 @@ static void *worker_thread(void *arg)
>   	struct erofs_work *work;
>   	void *tlsp = NULL;
>   
> +#if defined(__linux__)
> +	prctl(PR_SET_NAME, "erofs_compress");
> +#elif defined(__APPLE__)
> +	pthread_setname_np("erofs_compress");
> +#endif

I don't think they should be added here, you could
add in .on_start() of lib/compress.c instead.

Thanks,
Gao Xiang

> +
>   	if (wq->on_start)
>   		tlsp = (wq->on_start)(wq, NULL);
>   


