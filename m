Return-Path: <linux-erofs+bounces-2821-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB/8EgYoumnYSAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2821-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 05:20:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F72B5C11
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 05:20:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbFww4M3rz2xYk;
	Wed, 18 Mar 2026 15:20:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::435" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773807616;
	cv=pass; b=GI80gDhYXNwjxLSCLgzatMObR+N4GJVHR43dm+pEV6Ifom8VdLIdkHf04+i4k8qLrnQP+VzNhTUL0a2v8L0tlJOas/UAknwjtkQDaUrlBbe3fScrXEJvrwOR8nbOmx8wfptETmywHgQSHlnq948rCRSIlwoCGf9eBHY5hvVSTrDkqHP+lDgMMJJnEVls4SKzb0/Rs10I9lNFu2kkD5SJGiAnPq6KwNX0FO9HSWlfrN4Wsiq4BpE3U+dUJiZp/xcSdQb8ucyYL2BO2hmFNTJj+hWgtZgaqu5S9Xt1gvT1BqnTBlTlGTPxReLBKHAKi17i93CBDkrwpB020AS0Gdgl4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773807616; c=relaxed/relaxed;
	bh=lmlMjzmHWQBGxgUbujIl7zDm752JXPvCfDcsvYX+dm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWwSiyYBUwcrDSZtIKGlntjlK9Dy3wQFWw8xWvBXR87INeO1L9XQHpCieq6lbE4t/Rx8TVwwY2EVSN/M3y0LrkGqZ1cmlK2uBHPF/zussTSHAFTu4hSfQ27yU8e02idStzVKCwAJ4UP8RJPgDswmZR4gI2GQ8I1CBtUv+HvM6YzE8S0Tf6Db/oiX1najRNtrGH3rogrfszN50cJw0mYaHzFNbaemtPgYPPlTZRfOMTYBBQGEPwr7UNoWExXs6K4vBOjoIvC5fA7xrhsZ+ZIOQ5gzvVrcnMzjO8Szw9bAdP4xzzQCrik2FRcW8qtKwl3T1ezLJZ3mg1m/OIQy4iLVoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KucrHhww; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KucrHhww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbFwv5Drgz2xQB
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 15:20:14 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-82a73593410so3201b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 21:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773807612; cv=none;
        d=google.com; s=arc-20240605;
        b=FAC7AahAaKOX1BdHNVxENGUvESmHpgaBGZrYwG12xkbPXLYDDaUWR2pMO5qJCpho7L
         KPHsC5705YJrPXg1dijMWVP+CAUgEwUL5U8j1Uk0mZNBpWIqSQDjoQqOHg1cXnjpA/rU
         jVsXuti66oG7/woY0hzElNCiYCGgEgFvnX5cy6gypiX3hdh3gNhwVZV4sPVNoJZj+N9y
         RWdGWyA51burv0NuSGPD1a99otiG3hdxZreNolylsQJbJS+GZnJ/iSQPMnanTc4dLoGX
         MamU7JrXKqvetcVR6i0iqPFCpvsfKNwhRr5VV2FrEnAkaTVm2scR4KSxlQoIpFXpNw9B
         2H/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lmlMjzmHWQBGxgUbujIl7zDm752JXPvCfDcsvYX+dm8=;
        fh=OfN4ilhYxAbW6opQQSegbxgHK1wAkyx/trSCW5vJ2yM=;
        b=LyOvgEhGVjvla4CSEu3UPOGrJC3Z8YyX7b8bz3ugNjsIksy+b58eN8oddQu66Pu8iv
         SlO7xd279yNVzKmy4vBUrsWBDP+E2Dio1GHfOlXaJ8Fqy3j/R8tosjpN/18eO/a/Z8RH
         +aXRmA8/HuKYWMPGsF6/lSnc/iXY3Bs7Z7H3EZ9FqOkLyp2fl3miITVahKxR5uxNPZe0
         puBQqN18uGef3MI0Z4Gq6pobWgrjovjdkK5nVDmFo2wUDQ9GgThWFNxanL2hm9HPAeH3
         I+S8Fbv7WpayGCespUdM6vY6JvBk4pgoS1ECBHc316fjgtEJ31ZNIaBjOGaMIdszjFO6
         bjbw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773807612; x=1774412412; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmlMjzmHWQBGxgUbujIl7zDm752JXPvCfDcsvYX+dm8=;
        b=KucrHhwwQaT5c+bc1bvpK0zwZPvO+iqbZetSiLOmNb0eccI2wY0nKOe6jnO6IJgsIZ
         mOVKs6YQxph2OhIkk0Ti9RVuUW4qS2eiameXDRNk+VO849vr2D4J2IUI0TlhVvpD5T2Z
         tiMKPDhkUK2Pa0aaR9sukCeAJvrMd0cdL6QGp4OoUsLB63QsFyze3N0qN7rsOIpaeMzL
         Na1QYtaRhJHcny92tXRfU4ZH14mr9+S1Z39/bZw1ZH+kvuYkf3Osqugzh3SmG63fDUE9
         wBqVBSQI+X7XVTuwa/hCvl8ZZ5V/C9GKXkCnCAalMBav8tUuu9+UIhP2P/KWxrbk4PEc
         ybyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773807612; x=1774412412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmlMjzmHWQBGxgUbujIl7zDm752JXPvCfDcsvYX+dm8=;
        b=Vn8xOaDEKM4Su706SqdIczLR9k0JpPGeFFalkxr0Y7wg+Tuj6awHhFLMd1zBmyMhiP
         JKOMSsyk90Lwdb7zmDditywuAEM5w5YRSxnxzlDxaTwmVZpX5R4qjrFt9RZM1qzbMRap
         khg7WQDlFgSTH6Czem6LFR+m81As0E2Zhyc4UcODyEMkYDZe6H2a8b5TCCNppJNbz8hH
         bL2Qjt161PNlXKSCkxjsjzacxzhC73XVtZoLkp3z6YW3bWS/6eP7H0NsRTJe+Fl20evr
         lmBXpDTd64f2if6Yw3RCkkKaEmzy3+SQL5w7Kb7xWf/UdoFSCFjq9wdEECcv1Ub0frnF
         OwDA==
X-Forwarded-Encrypted: i=1; AJvYcCVaZTI3JquihRX1+kULdg/gHWMpu47NwBxQMP+qozBG0WcKBym4aV0+e82tflcw6xNyjCbYSewNOb3nng==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YziiLPJsYiTpSjmynK5yH78LQDdjQKuQwjGRmEroGz75zIFNIl2
	sc8QFY2xqsuVo+uoyjP7Rq12KXbWYck+ueKE1kdA8sCwQ2uQHaoIi76ZgAqotXwGcHRCwoIaEC9
	qiUwWpMKzq/GDRShCRSODU4d6xrUIiYyJGvK5YoJs0THkvdo=
X-Gm-Gg: ATEYQzyiGktlWR44XHKhYhOK5NN49+o1RHw7LCHtM9uUgBxKSa551cYCEC/15+0/DbM
	6ft7eoAuGhOP7kfR1wOjlLEzQRzIP9SRa3/8cCupyPgmAMEcD1EFtzYnNg1sd3GKTvyvTksKs/Y
	RTbmhKZkxzaIRT+qNyKheS7z/0ZR9wVA6QemaJ6nog0PpRWvE2Cc4saYfrhAUdAknK7lwOJUWZr
	S0tu5AykadBMt/gYz9QLo54ZqqqZE+bMTpymKmExPa2Y68hn82dt1G20/+Qv4bOJQ/4fQTf720l
	EPo4blfkXtRPIoPhsPC2UH635UtvhquHgmgWDl2S
X-Received: by 2002:a05:6a00:bd12:b0:829:a127:518 with SMTP id
 d2e1a72fcca58-82a6ae0c30bmr1854654b3a.40.1773807612436; Tue, 17 Mar 2026
 21:20:12 -0700 (PDT)
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
References: <20260317043307.27575-1-nithurshen.dev@gmail.com> <20260318040349.6535-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260318040349.6535-1-nithurshen.dev@gmail.com>
From: Yifan Zhao <stopire@gmail.com>
Date: Wed, 18 Mar 2026 12:20:07 +0800
X-Gm-Features: AaiRm50wDKl7XT4njpIPwrrM3FSiwSl3xwolXdAI4zBZXn19xROHYYb2uB-2vZg
Message-ID: <CABra5+0FVdW+BMiqgoqaOxFB-P91ngVYXPL2eAoaNq_BJUpCoA@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: fix thread join loop in erofs_destroy_workqueue
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, hsiangkao@linux.alibaba.com, zhaoyifan28@huawei.com
Content-Type: multipart/alternative; boundary="000000000000a3a41c064d44c462"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,m:zhaoyifan28@huawei.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-2821-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.949];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 757F72B5C11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000a3a41c064d44c462
Content-Type: text/plain; charset="UTF-8"

On 3/18/2026 12:03 PM, Nithurshen wrote:

Currently, `erofs_destroy_workqueue` returns immediately if a single
`pthread_join` fails. This halts the teardown process, potentially
leaving orphanedd threads and leaking the workqueue's mutexes and
worker array.

Refactor the joining logic to unconditionally join all worker
threads. If a thread fails to join, print an error message with
the return code. Crucially, if any join fails, skip cleaning up
the synchronization primitives and worker array to prevent a severe
UAF vulnerability caused by still-living threads.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com> <nithurshen.dev@gmail.com>
---
 lib/workqueue.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 18ee0f9..98c181b 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 #include <pthread.h>
 #include <stdlib.h>
+#include "erofs/print.h"
 #include "erofs/workqueue.h"

 static void *worker_thread(void *arg)
@@ -42,6 +43,8 @@ static void *worker_thread(void *arg)

 int erofs_destroy_workqueue(struct erofs_workqueue *wq)
 {
+	int err = 0;
+
 	if (!wq)
 		return -EINVAL;

@@ -51,12 +54,20 @@ int erofs_destroy_workqueue(struct erofs_workqueue *wq)
 	pthread_mutex_unlock(&wq->lock);

 	while (wq->nworker) {
-		int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
+		int ret = pthread_join(wq->workers[wq->nworker - 1], NULL);

-		if (ret)

I think just a erofs_err() here is enough.., as joining other workers
brings very little benefit here.

Yifan

-			return ret;
+		if (ret) {
+			erofs_err("failed to join worker thread %u: %d",
+				  wq->nworker - 1, ret);
+			if (!err)
+				err = -ret;
+		}
 		--wq->nworker;
 	}
+
+	if (err)
+		return err;
+
 	free(wq->workers);
 	pthread_mutex_destroy(&wq->lock);
 	pthread_cond_destroy(&wq->cond_empty);

--000000000000a3a41c064d44c462
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><u></u>

  
    
  
  <div>
    <p><br>
    </p>
    <div>On 3/18/2026 12:03 PM, Nithurshen
      wrote:<br>
    </div>
    <blockquote type="cite">
      <pre>Currently, `erofs_destroy_workqueue` returns immediately if a single
`pthread_join` fails. This halts the teardown process, potentially
leaving orphanedd threads and leaking the workqueue&#39;s mutexes and
worker array.

Refactor the joining logic to unconditionally join all worker
threads. If a thread fails to join, print an error message with
the return code. Crucially, if any join fails, skip cleaning up
the synchronization primitives and worker array to prevent a severe
UAF vulnerability caused by still-living threads.

Signed-off-by: Nithurshen <a href="mailto:nithurshen.dev@gmail.com" target="_blank">&lt;nithurshen.dev@gmail.com&gt;</a>
---
 lib/workqueue.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 18ee0f9..98c181b 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 #include &lt;pthread.h&gt;
 #include &lt;stdlib.h&gt;
+#include &quot;erofs/print.h&quot;
 #include &quot;erofs/workqueue.h&quot;
 
 static void *worker_thread(void *arg)
@@ -42,6 +43,8 @@ static void *worker_thread(void *arg)
 
 int erofs_destroy_workqueue(struct erofs_workqueue *wq)
 {
+	int err = 0;
+
 	if (!wq)
 		return -EINVAL;
 
@@ -51,12 +54,20 @@ int erofs_destroy_workqueue(struct erofs_workqueue *wq)
 	pthread_mutex_unlock(&amp;wq-&gt;lock);
 
 	while (wq-&gt;nworker) {
-		int ret = -pthread_join(wq-&gt;workers[wq-&gt;nworker - 1], NULL);
+		int ret = pthread_join(wq-&gt;workers[wq-&gt;nworker - 1], NULL);
 
-		if (ret)</pre>
    </blockquote>
    <p>I think just a erofs_err() here is enough.., as joining other
      workers brings very little benefit here.</p>
    <p>Yifan</p>
    <blockquote type="cite">
      <pre>-			return ret;
+		if (ret) {
+			erofs_err(&quot;failed to join worker thread %u: %d&quot;,
+				  wq-&gt;nworker - 1, ret);
+			if (!err)
+				err = -ret;
+		}
 		--wq-&gt;nworker;
 	}
+
+	if (err)
+		return err;
+
 	free(wq-&gt;workers);
 	pthread_mutex_destroy(&amp;wq-&gt;lock);
 	pthread_cond_destroy(&amp;wq-&gt;cond_empty);
</pre>
    </blockquote>
  </div>

</div>

--000000000000a3a41c064d44c462--

