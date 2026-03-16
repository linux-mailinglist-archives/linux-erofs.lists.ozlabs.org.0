Return-Path: <linux-erofs+bounces-2760-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHlTLHVFuGmLbAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2760-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 19:01:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E729EB61
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 19:01:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZNFG2WC0z2yh4;
	Tue, 17 Mar 2026 05:01:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773684082;
	cv=none; b=eSooem/OKPacLIHxk2MOBilcGxLgo2YAt8HgdABwEIa8SB4uFlTYJhQQj+6ukNdvO09IVPWRyGH4U3O0meB22UkAKpCvlohldwMtuzOG/0HhxXeP3a/VZhFIAxye1k+S+LeBtx9qBFGqGIYJm02REgjfVjx2zrODvP8a62ENdcsPT2W/czQcqpOthB1KTorxP7e0l7GJtB2ysL67F218Y5j96622TfTpR1rQ7snkgPD07In9luA0StF2aYV1b367VZ0DaYslFHPHzy8BwNHyaWwqbUtscXuiZy7zZNyafngTKNXZM262/+HjIRYjYlRTGL8SnBe6bgltIBc+2VzYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773684082; c=relaxed/relaxed;
	bh=kA7gHpRq0uZDxQY6JqiLWoEbfbAttlb99Ir2nYw5okw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQmfcvx9/tpxHioxlJYqBif9dhvk5gKEy6L9JpENAFAv8iznVt9ieB0j6VNNufjzy6tAoOwGl+UkZ1UaPrFlRNHyTCgZ8qWwgBddrjHK3gkafj7RklnEkWudVYyMlCII8V3A4CJgElqGFZWYaq2cuZm3NF5GBeR8AHgydrwGLKdF3rm4F1h4jTYqLmnDwUcS/n8+/ADF4IytArvYtsBhRbCdoZEr3S1Ec+BOZNO0ruvBOMRWso4mP9XHmQSgPlOTD5miXfjbyCaoyjhl76hF3y1+AKTPCQdUtS9O8uOEkvmNhI7so/knjQ74/Ra0Jh/EVAu6PsulF8FOiYTSJL+qYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gm4y8MJg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gm4y8MJg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZNFD5VHZz2ygn
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 05:01:20 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso870993a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684078; x=1774288878; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA7gHpRq0uZDxQY6JqiLWoEbfbAttlb99Ir2nYw5okw=;
        b=gm4y8MJgH7SgiBkkZRZlz8/jBxPSEIp98XIkLbxRRTzPCPeXORBQDy9EuK2qOIq4Y4
         hgY1Q6XzYPjWCMQXa6Rr+jnM2F8G9u4SXzugGWAsQ/8wbBs4FWzOf3NEZcekm4OgPYaz
         K8qIJL2+NK5UehNx3bvUis1bdiAmJixU2wjpveqdtK8bXhYF46tu9zZRNc8JV88PCwiX
         3BKXno0HPCXw1gJcEgamnurmDpu6HbiC/wLiz2y+yb5YFUNZaggPyQMu8ji8CTP9Vg8m
         qOthiBsvBOWUZHmUMc04SMtl8GCeU4I8D9c/Y7i2aSJXqgKwYoQe9ExydsOE6jnG5WLg
         OLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684078; x=1774288878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kA7gHpRq0uZDxQY6JqiLWoEbfbAttlb99Ir2nYw5okw=;
        b=ExXFmUOKUmTm99ezJyHZ1E55EszKAyAhSLeGW55uA8PVVcJBppGMqb7nBSCyPYRcGW
         94kJf07iu69WyXP52rijWqRE8R1QWV5GQYv41MXllO8XhncU6CH7twoYFhJcSm36dXaV
         hzyAPhvZuRruk6qp5ToWp2ORDlAuobkwru3Rx31dBh9tIdWnixMAoRo4RkESSpOz3GEI
         BbStPcDQQgSSbv4zwiTLOE2LluGlEKSDUMAvFtj57qMSayEedaEBxHSwu2eADsSZURQY
         /dlP7OUpF8caJQCLV/NGh2ejUxuF9rKGjViDgaqQlPDgS6tq1kbnB435J+EG3oAIBJQT
         97RA==
X-Gm-Message-State: AOJu0YxO4RhUlenCZOtWKtcYvCTm12Bl7Fn6o//Z+XRZPAkxXGyV5zR8
	RUDG8WnTYN0l0mdLYf7qAK671FmeZ2QaAEP/ZLztGuX3ce2Bi+jT8RTopQx1npc0BXU=
X-Gm-Gg: ATEYQzzmPKEDB3ojuAVBLrOk4B6afP0dJvOYnny+xLZAez9675K1AsMSRUZDzu36lcy
	kaKLhoa0NnBWnu5jWeRhZLUmUSHBye6j4F2sSDhv+MXahf7gOcFWXLoGl4P7pG2Uk3S9pZYZEOU
	YTlb85QqSRVXKUc6rA844RDu1TNRU9Z5GaGRxUQH9S6N3Lymne5jMTaf9vUOZLmQXZdAZpAPevL
	v5yNu6pdnCFbFxJQfzo9XtdKyTepXa6Oah7/+q7LcJ+DnnHH/DuuFtTyP4VRF3fbCoQOie24XqB
	7mHzPfDVboRzgkwWODw5JC/A/Xl5j4TL9SA9SSJ4lNvDbeNhT/5wtINiqs1/M5snJxy5CfyG1gW
	O/W29h+AeK3REuy0hwfe7RXBwvGhoGR5ag4eWQ/fguzM+mm3VBKo/idKa37cPEVJeuPZFK3+1ue
	TChKqpSCVOmLxlgR2kDa1WliWWdyOtfcHZgB9bwBRp7ENkHanejl0=
X-Received: by 2002:a17:90b:510b:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-35a21fd68f4mr12213172a91.23.1773684078023;
        Mon, 16 Mar 2026 11:01:18 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35badb906c6sm274341a91.9.2026.03.16.11.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:01:17 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v5] erofs-utils: lib: name worker threads erofscompressor
Date: Mon, 16 Mar 2026 23:31:06 +0530
Message-ID: <20260316180106.5991-1-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2760-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D14E729EB61
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
index 18ee0f9..1811c9c 100644
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
+#if defined(__linux__)
+	prctl(PR_SET_NAME, name);
+#elif defined(__APPLE__)
+	pthread_setname_np(name);
+#endif
+}
+
 static void *worker_thread(void *arg)
 {
 	struct erofs_workqueue *wq = arg;
-- 
2.51.0


