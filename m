Return-Path: <linux-erofs+bounces-2776-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ1LNZTZuGmjkAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2776-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:33:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0E2A3BBA
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:33:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfGS21phz2xb3;
	Tue, 17 Mar 2026 15:33:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773722000;
	cv=none; b=aVcm2PmKAbaw2Dl91nthvl/ptfRPblW1kdKoJTd0efjwlfgiXZT8vKm6yTCHKY1yE55XJCf87RU+3s/qnVuD892fogsytmenzVbn3UGsMoUdhnJMwjFIdjqM6NsTnwJyi0yE0Bi3lnf/6lkRh5PXQ1juHu5otK+rwG3v66MqEz+P9FLoly3URwrYGUfoCYUgu4gmeJEDB3wiehN1a2qVIxZuTzOO+CCKmMF3gEmlzSVQIbfbRGpJfecy4urEmMK0fm9zulwdMs1Nemhx6ENtwUBC6QJmm5Rzhzz+na6bJl3+7F3UOLTx588Z1kmdQF5R8v9uV3TZ0SnqfXEmH2DY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773722000; c=relaxed/relaxed;
	bh=xzZgf5Mzfe3M3o+xWxpQuB1apcy49fmUJENoO7gBMKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neTJ27t+YL3KP8byxZMcMK5faJASpY0Cmsv+Bm4eiOupVuAP665xS7+2Dkn2b9Dg5vm2lGXqed4TXb89ZFoIf4Zzu/Z+BP7gZKqetsl++3YalArsFhLqhkPip1P9BRB0woyDG3Z0WQnBDKIb5mEFRPCmCJxhTY5CfyS1U525VS29U1H7lKBjxT3G6q5M758F5Wz0+10n9z9eHRxsK+QgQ3BKs/TcQcoTkDxR5/3/+iNhqFZ5GQA3qYgMpjUeQ9AZ2vWHg11g/BLlmww/7W99yFDCVYcIKtuz1/dPJ/DRZ3vMfaQRllfe4mgaVSCtUSlhKGaNODsQm/sWVpCCUQSw9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VokExpSO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VokExpSO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfGQ5Q8yz2xS2
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:33:17 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso1124441a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773721995; x=1774326795; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzZgf5Mzfe3M3o+xWxpQuB1apcy49fmUJENoO7gBMKU=;
        b=VokExpSOmnlkJxv/rJegh6eLlW9/w31QaWp0T7ZUs3nX34ybxM7lwxUGuQK2iQ6ORi
         /W5DmwGvs10ZAAvnbZ7Gb6hr136vQPXQTC3HM+29WKYL1HWwUZ8lggDmi2GkeVwpV4vg
         JD5ZzTNE/car/QW+eg/876DjajYlylqY15vByJos9xJB+YPAS8R32wjcXsEdSZgvX5q9
         TgfPjKHHc9XMxQ4OXIDRoeF/KwkxNkEBAdsBp8yRUMDFJQqHPGul/Z50Rz/zYltCzpC5
         eQhUVU8FDTEEXxfS4m2oNRsHya7hH5WLavdGHxVXXHDYto2W9LolcoaYLtxO9MEgwz/J
         743g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773721995; x=1774326795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzZgf5Mzfe3M3o+xWxpQuB1apcy49fmUJENoO7gBMKU=;
        b=MNph0M4W3mDg73Mz8q6cYYQqtyd3D+kPmbenvpvEgkAMXEZJG6NsbwP8Jziwtg5mM2
         3ZQBClStitpGGm+QLyJkA/4JUQbQ446Tv4yQ5XEKYlyUE0tJQsL55ATE+XKIvG5t3XC+
         FFLo4A8WrbTmExvItEALUaSoOKrVwNrS8f2bBaOmVWJtmQJJTpqkth0NU8GnPpUt/Aae
         d17E1H0o72KrM0Zc1HJ6QW0Zkw4nIRVGJdluwSrseHbzDT7Gjau9T6LXIuMI3Smjkyhq
         yN0LbKNiVVui3fud88yluE6QnzxIG35VHLvi2uC4xKrAgpwvcT+BMs56Wbfik7SKJPeR
         w+Lw==
X-Gm-Message-State: AOJu0YwCM1gMUY3Lejxhq2udrn1hH/jozWNCRTepqDwn0LywlC2tnegf
	HElc/ev8ZxwCDSD6/fjTJjUFQaoSrAOoIYvBY7O6Lu1WXKla65iiiMleoSWBfEaS9Wg=
X-Gm-Gg: ATEYQzy5cO/wVwmne+DNdKZ7GhVoNsQsaxpESoqpfds1mYYivnQ6hU7wfsuH3ZnCsSM
	H5h4EPiCnXOymzJwdGH0Mv+rJf1qpdMakygytMtJFuLviGqHbT/F9RQ6IPc2PSGYLLOYH5qqRxl
	njMB5tGO70scjT0zl9jwwLbVzyBcEa6UIKFxiINbGJ2vZpuT08WF8Sdd1TbilfTeytG3+Lcqd9n
	Vxw5JLIzFP+IwHPda1s0iNdmSrBWsanL2LGwlxPr3H57KERc8RZiaMtKGP0iJROaUtg9DiFeDX5
	q/E57X11qpHKTjeSnZD/rRSUeGTjHeiVSUHE32JcwuY1ZR0c36MrMti5hsarPIiFMZ4NUzJuZnH
	Y448uWXp/Yt4mzsVAErIjZF7/T3RyAAqI+Q52snXHcC9fhiL+sB2XUwegVfBjv6o6WChXFzcfwj
	j2QWORNabkKme0YrcEdeWpxrlfGxVEVGRiTnNLWXtXJyQ7ExKMyoyULFPghksTfA==
X-Received: by 2002:a17:90b:250f:b0:35b:9c97:3d18 with SMTP id 98e67ed59e1d1-35b9c976381mr3990154a91.12.1773721995033;
        Mon, 16 Mar 2026 21:33:15 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a243cf81fsm5550890a91.3.2026.03.16.21.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 21:33:14 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH] erofs-utils: fix thread join loop in erofs_destroy_workqueue
Date: Tue, 17 Mar 2026 10:03:07 +0530
Message-ID: <20260317043307.27575-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2776-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,huawei.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.996];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 27B0E2A3BBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, erofs_destroy_workqueue returns immediately if a single
pthread_join fails. This halts the teardown process, potentially
leaving orphaned threads and leaking the workqueue's mutexes and
worker array.

Refactor the joining logic to unconditionally join all worker
threads. Capture the first error encountered, continue joining the
remaining threads, and ensure all workqueue resources are properly
freed before returning the captured error.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/workqueue.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 18ee0f9..23eb460 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -42,6 +42,8 @@ static void *worker_thread(void *arg)
 
 int erofs_destroy_workqueue(struct erofs_workqueue *wq)
 {
+	int err = 0;
+
 	if (!wq)
 		return -EINVAL;
 
@@ -53,15 +55,17 @@ int erofs_destroy_workqueue(struct erofs_workqueue *wq)
 	while (wq->nworker) {
 		int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
 
-		if (ret)
-			return ret;
+		if (ret && !err)
+			err = ret;
+
 		--wq->nworker;
 	}
 	free(wq->workers);
 	pthread_mutex_destroy(&wq->lock);
 	pthread_cond_destroy(&wq->cond_empty);
 	pthread_cond_destroy(&wq->cond_full);
-	return 0;
+
+	return err;
 }
 
 int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
-- 
2.51.0


