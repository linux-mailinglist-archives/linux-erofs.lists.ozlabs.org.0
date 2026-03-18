Return-Path: <linux-erofs+bounces-2820-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B4IDTUkumk3SAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2820-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 05:04:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D070E2B5A13
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 05:04:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbFZ91X1fz2yjm;
	Wed, 18 Mar 2026 15:04:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773806641;
	cv=none; b=hduSW5rrRRlFwwsIMwzYQk3ipc4jwRaNDrj7BxPWUcHR3Oa6pxzBFkOe/xBnvtxPWcoic0MtTh+dIMG59JnJExI5DXS+USAjdMzURxcebWkAjlc0vjjLrjgUrM9HXRd1DI3pvGS3vGciDM2jU3Ji7gbgnxJsxMTJI7eHkbTsJGTgcxyZ/vGra5NqoqYsU7AdxJz4A/o/lA702NAD9r8riZBmLQEBE86bnYezWFmZPJ50vTFclOLLqcp3SPi/lgsAFv7e3PfYQKsToqFwvGlXMCTpoX38CHNQA+kotWrrDtHQAxoUrUC5dd43/RP/9YZyGd7yN9zzzlQ0DntN9BCbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773806641; c=relaxed/relaxed;
	bh=r9a9E7Zy/lS5GyrcYWClIe6RIb6CFkPfrhhHLUdHPTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8honFlzNguYJNMO2VuIm9ANk6377JVsBW/9ND0dWAWWZ4wkBjxPCOOZ+rwQJvAqO7COIDoXlQT3cfnEAaGEBbNWXryaz1K+DX77/k77K4e5JRVH6TDJqx+1AC0+TggF8kUTw9K5N/uys2vbIXwrFt2GG4ETAhMpSf4UhleX4dFpaU3LY965H9uTJJycuEaE+aRawTQVy48d3lesAyRzLsG7PZym3JKift50A2Y4s2RK4n5lU66RRDYdAJUh+oc0ALtqFOmibcFitAOtyXp0niw9ptREFODMJWl40S32SJX9VzaJ2V3J0EbSQ0XMCvTk7I7nFLqKUmwRs0XAFWoETQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=htJy5PX9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=htJy5PX9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbFZ82hNDz2xYk
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 15:04:00 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso131009a91.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 21:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773806638; x=1774411438; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9a9E7Zy/lS5GyrcYWClIe6RIb6CFkPfrhhHLUdHPTU=;
        b=htJy5PX9hSfAJsC+WyhZmWTW0PjbjYalgdNVbnCbGDi2ZA+MLe3pBAl4h1/t/WY5nu
         KuUxta5VMktp2SJXiP/3iEm6RSslptJbK66BsBfaVAzy3MTHzPuNkxpyPmPZXcIRcJlM
         PU1BPBwtSoMugftFbHPqlgnstBANrcZK6WT282Ms2ne2EAyI8x6Xp2M1a8vrMDP2VKoz
         zawVzto3GpYjkz8vlwf/Px9lWrkfcTRvSXE69mkBbutnQ8F1nsM0+ICJj5nSd5g5SVxl
         uFTNVs2lh2xsoHZDjbllhKW+0zIfN0HAr3tVm6zgEuOjX2qyoTYVzjK5wqtrr4+ult48
         GeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773806638; x=1774411438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9a9E7Zy/lS5GyrcYWClIe6RIb6CFkPfrhhHLUdHPTU=;
        b=EqraQgLLbDKVHFhG5Mr23pNvqR7yxKcVFXy5S3KPyDEA1BespTko43pc0zgvI9GPS4
         zlKTeL3gCZsf4UtC9V6LhZ7OijfpA8nSnLFESPNmdvb/NgvFEN6yoYr1nL1fbx7+lGpr
         Jfm5cylvdBGfpFRMI0dJ7qhfRFQzQHDaVydoSGvF/kY0VA7aiA984RQpeI9O42s8gbfU
         i9QO/EHkSZ1fOTNLz6yR3vLzjpDmyPSwnv9A0WTgZSWoGnVkP5TlgW6i7q/c/ptu7LjT
         xXuw8zQgYyZlIhmtEBqkcdb3s+qJ3H7Y+r4XQjy8t1Buas3WMyyIS0vIzBlpBynZSzW6
         ASaw==
X-Gm-Message-State: AOJu0YwRJf4pQrjwxcMujjKqbhs6nz31fi10WrsFpYKiP1CSKpcp/csB
	DvE3CVig47/+UDJdStICT8Gm801FYUZ+OKlPHgd52mxV8viRmwUOE63wU7hWcZqo
X-Gm-Gg: ATEYQzzHCYbRuIvRAnjMgbAh2kZz0TRp6nZG2UYdncOuqe9mRTUn4VajuieGYXJ3e0P
	ys3USEi7srMPTClBjL9r8JGsump3ZNO2Ui1sSL468QXnvFaniI3FETS9L69B7cpcdlSDzRnpJhr
	bS3EBzNjKKTklbp8hySJjgUxMqwJy/1HSA4KZf93oS+89ymSrkJIqmWU+4makZ5FqNMDJKqsOjt
	idfsvhxwxOU89d0O70kcD1aNhngBBW5P2sc3qwrr3ZWGZAlV+IURMjiGoPSmhpl4sxrFcz2Afdp
	1hIutiTBiK5OvZMnNI3bzK9HR4mLIr5Jpmtny5usskqUsAZsdZUY9XYtuR/pS1E7JfNSGd1iRe9
	t8p5h5gNBLWbaXc2J31xpg9gaiQB9rK0E+75u076RG0r2qjXXjYDOSfmrUOtk/KD9yYOUtpa8hT
	hkKRKnNxdTiRxOtriu8c8B40bN016PIOmWKyxMom2a1NDWB6pBRjE4o5eaF6RHKK01UoY=
X-Received: by 2002:a17:90a:e707:b0:35b:9d97:63ac with SMTP id 98e67ed59e1d1-35bb9e6e799mr1549637a91.7.1773806637887;
        Tue, 17 Mar 2026 21:03:57 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35badbcdad9sm5621330a91.16.2026.03.17.21.03.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 21:03:57 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	stopire@gmail.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2] erofs-utils: fix thread join loop in erofs_destroy_workqueue
Date: Wed, 18 Mar 2026 09:33:49 +0530
Message-ID: <20260318040349.6535-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317043307.27575-1-nithurshen.dev@gmail.com>
References: <20260317043307.27575-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-2820-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D070E2B5A13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, `erofs_destroy_workqueue` returns immediately if a single
`pthread_join` fails. This halts the teardown process, potentially
leaving orphanedd threads and leaking the workqueue's mutexes and
worker array.

Refactor the joining logic to unconditionally join all worker
threads. If a thread fails to join, print an error message with
the return code. Crucially, if any join fails, skip cleaning up
the synchronization primitives and worker array to prevent a severe
UAF vulnerability caused by still-living threads.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
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
-- 
2.43.0


