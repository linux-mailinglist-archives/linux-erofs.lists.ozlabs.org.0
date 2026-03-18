Return-Path: <linux-erofs+bounces-2826-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ6DKzJkumklWAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2826-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 09:37:06 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CCA2B828E
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 09:37:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbMdB5ZZ9z2ygT;
	Wed, 18 Mar 2026 19:37:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b129" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773823022;
	cv=pass; b=g+ZJlIvnKTK+hS4qFGPtLKrBxYFXl2CEwhuQ1s3DYz4X7kAARiktxre0L/ev0CuKG4nBeo8FQWonfaK58F3LpVa2elOPIPnTm+pt63NSmbXbdsriUtst4hEBdc/2DyC8ZTUCAWHFk15zizNhY3uAyU/rcJ3KqP/d79gxYk2gTJ8okTPrbMpC91SGip75mCQTMlCVY8fwr6MSCkLh07VCjR5pIL50AST3aI3WQS+LRzwl9R0/eyOscadg/h8GOrOjkWchBogkr9u9PRsq2xPI5wbrHTU5cLVOu5z3dVK7d3lrmdyJSlCqoGiqG225jdRL9JtFN88ReBPFFBXA1WWlBg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773823022; c=relaxed/relaxed;
	bh=qtYYC4rS+xron5E2EZmcEn9u+N6WCAcay+Erg5NK5Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8ugeHdIX7AdoCALIlINYu6akMKwFBuBaX+9+Yr2RtCxuIoo6qEdyk7kFnXluW5hBhabcs4GhcO27fdEkTLoxntuMKJaYaAAixvBOLrJAyZsYByvsnv8CKF87evHGPNxaVGijGxM/wk990kNZnv/LecNUHch1ZDsHsnJni0hQZTtDPYNSYYUbtYC61v6412lK6ui8nDtOAc0MMWwnq6ndc0eZqJaDjCSeKBoQGnDNdicwGEsywxdfTLpYdbxfqPlCQCfNqxUx4IqBt1t4IeHh89TMJ5jdKGovAkU4St/2XHgi1VExTJL7GTDqc2PF2VLBNgOk1vQbF3svNN5nBy86A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CGmAHhcF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CGmAHhcF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com [IPv6:2607:f8b0:4864:20::b129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbMd96SRSz2xlx
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 19:37:00 +1100 (AEDT)
Received: by mail-yx1-xb129.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so5384982d50.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 01:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773823017; cv=none;
        d=google.com; s=arc-20240605;
        b=U4y+aHjolJKb7kGYnw9k/L0Tpynz2nte3mFcEHsY7kTazXN7Ss9KYpR9W8DCjpax5g
         US5liWrmCFzDvN9W2euopb6/AbqtrLMgzSJK7Px080kbkY+dPOoFhz9yygp+Hc7K8iCj
         jf46f7A65/pP3MhkA8HwzsQVkU61gqZYOvO+VOv+EjzFGJy5aT4JC6ctou6xV60+wRhF
         wduGCuKO4QteRPdHWUbnyV2Zz7Lwael6q0A1c0Vj3Hh1+FyAoaDuIFoBeb+iW446HTLp
         69aLmkrxNcYYbwGTUw1q/pzmtRQ0stANphvOHmO2rpZ3UB567+T+9qeS1qgjIqWlwDqh
         7QXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qtYYC4rS+xron5E2EZmcEn9u+N6WCAcay+Erg5NK5Rw=;
        fh=qxxaoduvaoVXZK8r06Ms7a5wD3TgtA5ImyvTPFbKT+w=;
        b=E5Ym3cgQV9A09b7FHZaJR6qCrFPd2Pbma6zUq3cSVNqAYex0/aZpnb7W62QqBG15Cu
         c0pGJH8Zwn8n6l3SVgFnC2jwA2uv6BYk+PVtOIDFU++VlEKl3rOj0V+vsWA9eWgk1YCz
         81J98U6q/bQW2w1TYlr1BpzxQ1+VgFbMMu1+0SXZ0oyEK6U7mrttfXxw79LfgzaO0Ce4
         /U+ySEV8u/Q/SCP33XNr5574Pz1BLSRcW/efWiTuvvzrbJKfxFslel8TX38aCJLc/f26
         2rn4S472or0gb/D7JaO8wOrXHZkZOPJLVlP/jWiRmhlSHF1PkPDxH6K6bwqR3HBPxE9r
         sm5Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773823017; x=1774427817; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtYYC4rS+xron5E2EZmcEn9u+N6WCAcay+Erg5NK5Rw=;
        b=CGmAHhcFH/etwfex2wDCbbGwGDpBODUobA6RJege1J79HtRIIEbUjYSetAT+DKZRhE
         GHI7iNhHA2b5QUj4lw+J0WBgJJ6IsuO9GP0tDdvKE02HmQXWeQX0ZHMwiy1B4B8MvuCW
         ap/PdtXw2N5Gwm8yJ8Agze1zOC8qMClmlxUHWSEBb0HTwZ3RdcOch0L5jy8aNrhRYnnN
         pfknb1BE356IcD1TJbJiadWtAdXUkXRPVPa6KP+xdzf0naAXbj2GV0DWN1559h5TLeg2
         tEcusYp9Ot+3rfaaGj0nnSQ4bnfUFw5M4QxeLweW8ghubD8qMW9FESS9jxUL+qZk8C0y
         OjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773823017; x=1774427817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtYYC4rS+xron5E2EZmcEn9u+N6WCAcay+Erg5NK5Rw=;
        b=H1KlehB7gsjs26LXAjVZYDpJZt1KWdq4eVvNVNCI29zDxN/CSTRqlB58oqKAs2b+Jb
         ZudO/EVDrQRIMk+Ev0GgatxFA2/GzirxV3CBvi3nG0MUl5u1RnXWSr6carfmtc7GJYAj
         17fZgh/f66KM/TAkUZAki82AfQ5F0rV2WcZooDdEeMJlAaR3JHVEbMyBjjjWHMbnKaq8
         p21ePvLIKiYMhLH5D9qDkwR71MpJtpVIX8Oz1gTrBd80qCwdTM9chjSDZompv2VUeKY+
         oCK0sll4hMNk9m8U1E6wEI6eME6994wxnoxKdqJIPrLuQi7n3PxPIx0veo0F5fh3Oo7q
         892Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9UH0npParq8USRqJua+oZ87z56bwSWWQ1/zzmQJctvGybVkW0dal9XijNeKUSKSX/zccRjR9m4FJcTA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2BUG2nA3OnibOumKJOmbFNiCHtOFX3xh0W0HM4jjBHfw4Y1RP
	nDJMjBJXNvcoDAJryu5JldWYdE/lVaQIaZvlMfglhxTj5oxBxvREVaIXFlDWY3uRoCr7kbQIGgq
	40SS3vqpLKOLErLzcxPwlY3xLg+EqDjw=
X-Gm-Gg: ATEYQzx04k4fOFshpQ1nodSvLMpf+tYhf0arA0WaCSBUbxlMljcouSvDGoy6X+YBeHI
	EC7qFGKBZV7IzteC6pA5F4qnRCF27unrZqV5TNXOngqRg8RE6hGTVt2c8FvksM6e59e+edrrWBs
	EU4XXh4Dz4S4w4n1U3uyGbvVuAHdLY6Rnh3m+/xGGv8554SFFjDYoau2crJOvF4me7X9Twon5lj
	ULZZe1HXuyaxt6tzXsw8bYNXqrlb/n7Uu3Dk/dWfIeO9oZcQpeS7ZlsuS1yFZ13E6ZeTkAx99rR
	4MN9xl4=
X-Received: by 2002:a53:cb92:0:b0:64a:d7e3:cf7c with SMTP id
 956f58d0204a3-64e9131d122mr1942454d50.13.1773823017355; Wed, 18 Mar 2026
 01:36:57 -0700 (PDT)
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
References: <20260317043307.27575-1-nithurshen.dev@gmail.com>
 <20260318060319.13191-1-nithurshen.dev@gmail.com> <CABra5+2gf8+T4ker-7rdABiy25VVPjPUSLjzarttxajYkjU2xg@mail.gmail.com>
In-Reply-To: <CABra5+2gf8+T4ker-7rdABiy25VVPjPUSLjzarttxajYkjU2xg@mail.gmail.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Wed, 18 Mar 2026 14:06:46 +0530
X-Gm-Features: AaiRm53ejbNyDiWD71DwX845ha1zJSJSzKw59E2wL12DK8-fHBTU6fxW3a5r7ws
Message-ID: <CANRYsKjM39syDFQEv1v7NBa6OSqEVFwdYHo1+5qFQD7VVupgZw@mail.gmail.com>
Subject: Re: [PATCH v3] erofs-utils: fix thread join loop in erofs_destroy_workqueue
To: Yifan Zhao <stopire@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org, 
	"zhaoyifan (H)" <zhaoyifan28@huawei.com>, Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stopire@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:zhaoyifan28@huawei.com,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2826-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,huawei.com,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 53CCA2B828E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 1:47=E2=80=AFPM Yifan Zhao <stopire@gmail.com> wrot=
e:
>>
>> On 3/18/2026 2:03 PM, Nithurshen wrote:
>>
>> Currently, `erofs_destroy_workqueue` returns immediately if a single
>> `pthread_join` fails. However, it does not log the failure, making it
>> difficult to debug if a worker thread gets stuck.
>>
>> Add an error log when `pthread_join` fails. Retain the early return
>> behavior to safely abort the teardown process, ensuring we do not
>> free the synchronization primitives and worker array while threads
>> are potentially still alive (avoiding a use after free).
>>
>> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
>> ---
>>  lib/workqueue.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/workqueue.c b/lib/workqueue.c
>> index 18ee0f9..4a1a957 100644
>> --- a/lib/workqueue.c
>> +++ b/lib/workqueue.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>>  #include <pthread.h>
>>  #include <stdlib.h>
>> +#include "erofs/print.h"
>>  #include "erofs/workqueue.h"
>>
>>  static void *worker_thread(void *arg)
>> @@ -53,10 +54,14 @@ int erofs_destroy_workqueue(struct erofs_workqueue *=
wq)
>>   while (wq->nworker) {
>>   int ret =3D -pthread_join(wq->workers[wq->nworker - 1], NULL);
>>
>> - if (ret)
>> + if (ret) {
>> + erofs_err("failed to join worker thread %u: %d",
>> +  wq->nworker - 1, ret);
>>   return ret;
>> + }
>>   --wq->nworker;
>>   }
>> +
>>   free(wq->workers);
>>   pthread_mutex_destroy(&wq->lock);
>>   pthread_cond_destroy(&wq->cond_empty);
>>
>> Reviewed-by: Yifan Zhao <stopire@gmail.com>

Thanks for the review,
It looks like the CC list was dropped on your last reply,
so I'm adding the mailing list back.

