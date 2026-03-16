Return-Path: <linux-erofs+bounces-2758-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFFaIBY9uGmpagEAu9opvQ
	(envelope-from <linux-erofs+bounces-2758-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:25:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385E29E239
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:25:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZMS31Jm2z2yh4;
	Tue, 17 Mar 2026 04:25:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773681939;
	cv=none; b=gqwoTYqhtDopGCbEfSY8qU/ZBCn3XfXAEu6O6hwHyiOLMlK11KkGHMDTdplfpXTMrZatmO4illUkXEZQhowi2KE+u5u8qELngRZfNonaExn7EFGE8uVz5ZqEyR/Zd2q1y/sPtZIHo6rtya7fhFrDAuHDjCGUVYhicVngPIXJH3rUqkjqVcL+o0X5K7mpw6UtGe8VKsTVIHn6ub5qZuM4JO2/S3uEV6kzyAa4k3v/zFcgFTUyTAfgwqmidsUytiP3knTX4HnTdx9NC68Upo+UU/rN01I5WCtmbvYV8wH2src7uutXZF3Vm0fYBZ0A3B9lOELpGj4q8XsAJmoO1FugtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773681939; c=relaxed/relaxed;
	bh=Vkly4j+Pl7voQB4sNyIx5ygbnMyayr0Pc6SL1GHQv8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RS7AvTS3k0bk46vUKg7ntFKowaJ8oQGAMT5R3oWWJJvP1eqJw7G8yR6mXT+Z/RFCgGPb9oaEjon2n3kEepKPSxpbeo8JmEYz2+FjmAgNZV4jaDByqQyzi876ySAog3iHsEVsZyZnEjKnLvNFXrXQK6m8nhWtvEeMX9S8R86NYh9lOlcBpnDAYtQJaOr+MKAxDxbkjZkGew1hzGkWsBYBprv34gDx72I0W6Xz73N2TovsvdvkpoIcbAvghnCK/6hEGb55muBBdoHK6Q4EwwPmiVGDtq5+WZOV3/RvFMyIdxnyYyraVzISJ6ezkexgEUcj95aMgAYLITrj944NGJFklg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RM1Zmvg6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RM1Zmvg6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZMS22KBKz2ygn
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:25:37 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2993122b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681936; x=1774286736; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vkly4j+Pl7voQB4sNyIx5ygbnMyayr0Pc6SL1GHQv8o=;
        b=RM1Zmvg6SxKcAni+elz5DMh8+qJL//k+plHHonOQ1a9RCyiq/asu+A9ZVyHcZFRWf6
         a8Y5KwKSKO7UC0TXeVRZvNNlumztfY0Ev4gfXeZ7LVtIstlxWUBmiSboQLMZFOdyWDj6
         v/rbudi/TEtbrA2Jd9zABTbE+QiklthTkT33Jlf5MA9lmbuEk8kBUriZg5XoVMyitwAj
         IzNYgAb+mttwbiQMup4QLgMORcB1yF12AU5D52muwU1Ho3Jod0j5G6L7lF2oQRgO6vIM
         BmCzmxjAvwai27MwAkGW//oSu8ue3Pkr2m7MvEhK6SOhQaIjMxMmlgDMWJ+JxyMRKWKs
         2UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681936; x=1774286736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vkly4j+Pl7voQB4sNyIx5ygbnMyayr0Pc6SL1GHQv8o=;
        b=Pp8EXCquDaYGCvVm0RvE6gxEXPWuKcIEdKbDRLBmo1GH/PZtHvFJj955wm1DjKjPzE
         +enAUSDOPVNRqCK9l9Agcs8W7KyZtBf3DbTlvk0Me8MxdqZKgJ0MI9ie0h8dtIJrjy0T
         B7tOdhvwdsefBGP79lQEUDmTCmX/mWAMqPiqwzVKIXo5KdxSCVXNO1OthnTbuc6qROyh
         Nz6SjEUeJl1G2DjTMxulhZSwYhOfaJoesEjERzwFTvrdelnMmaqcIeelV9yuAIy04jMl
         j+SgzcGqL2fnTDtN0Piylq7YzOKYTMsWaSvCiABSJHbQSXVeBYDU9Scdh4ocpXe9vTK9
         2nQQ==
X-Gm-Message-State: AOJu0YxoRBsr4f3mPEGvjpxlwk/Kft73RiCqG40L7a9EBLjJgR4Z5P9J
	QoJEGcDEbJS2xRYyYWv2N4DlaBO6lJ5YE6NB/0zccubdzwn6qBqoA12WdJ16ih46YDk=
X-Gm-Gg: ATEYQzynVWCtdiAGAp4cH+W95DNFncAv1hA5WglCmH7YT95g64k4TsOkX0gfCfgjMmW
	BPq98pwjf9+0j/OOUQxCkUje+44JCULnyFUkrdrv4BiqLMc3yEdEGiPnhv2OGWLezsbPOjYzw10
	fWEqHkkBsG16fUNH4kyHcTnDRyUTPT2JXFNiNZmRxp/w9aMGvzV0t3RNYmy9lguMrpAaWKcasmY
	QJ+bYMmMsfj/dIvheKnHyKatyKy52Ug5VSmmJeDUPf8+8heQSmLiAtn6SVUUXnIDhy/DhsfuMgv
	ODw+0RZew9bo+F6Vl7X45WD/N5/FOL3fHJqRRJUNqFG3/g5URDTdpAgELDBs02NXbavF0o54FMe
	ffh7LZMXguAxNQFcz4WKAuGPy6W3Xhsc5kXuoNWwSsgrx/GXUgn0szRObRLFhT/b53p1/2lzdNc
	o/dML3IOrmL8PasD17MMA+C4UVRaRgzJJL+IfkV3Tep3B0R/DZ8YhsmeT8ylW9Ig==
X-Received: by 2002:a05:6a00:1c86:b0:829:862d:6b46 with SMTP id d2e1a72fcca58-82a196d1230mr10413748b3a.6.1773681935809;
        Mon, 16 Mar 2026 10:25:35 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340439sm14010708b3a.31.2026.03.16.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:25:35 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v4] erofs-utils: lib: name worker threads erofscompressor
Date: Mon, 16 Mar 2026 22:55:27 +0530
Message-ID: <20260316172527.90399-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
References: <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2758-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9385E29E239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set a specific thread name for the multi-threaded workqueue workers
to make debugging, profiling, and process monitoring significantly
easier.

Previously, worker threads inherited the name of the parent process
(e.g., mkfs.erofs), making it difficult to distinguish them from the
main thread in tools like top, htop, or ps.

This introduces a new OS-independent wrapper, erofs_set_thread_name(),
which utilizes prctl(PR_SET_NAME) on Linux and pthread_setname_np on
macOS. This helper is now called during the workqueue's .on_start()
callback in compress.c to explicitly label the worker threads as
"erofscompressor".

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 include/erofs/workqueue.h |  2 ++
 lib/compress.c            |  2 ++
 lib/workqueue.c           | 13 +++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/erofs/workqueue.h b/include/erofs/workqueue.h
index 36037c3..27d3ba4 100644
--- a/include/erofs/workqueue.h
+++ b/include/erofs/workqueue.h
@@ -31,4 +31,6 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 			  erofs_wq_func_t on_exit);
 int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work);
 int erofs_destroy_workqueue(struct erofs_workqueue *wq);
+
+void erofs_set_thread_name(const char *name);
 #endif
diff --git a/lib/compress.c b/lib/compress.c
index 4a0d890..65971c9 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1427,6 +1427,8 @@ void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
 {
 	struct erofs_compress_wq_tls *tls;
 
+	erofs_set_thread_name("erofscompressor");
+
 	tls = calloc(1, sizeof(*tls));
 	if (!tls)
 		return NULL;
diff --git a/lib/workqueue.c b/lib/workqueue.c
index 18ee0f9..c924c1b 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -3,6 +3,19 @@
 #include <stdlib.h>
 #include "erofs/workqueue.h"
 
+#if defined(__linux__)
+#include <sys/prctl.h>
+#endif
+
+void erofs_set_thread_name(const char *name)
+{
+	#if defined(__linux__)
+		prctl(PR_SET_NAME, name);
+	#elif defined(__APPLE__)
+		pthread_setname_np(name);
+	#endif
+}
+
 static void *worker_thread(void *arg)
 {
 	struct erofs_workqueue *wq = arg;
-- 
2.51.0


