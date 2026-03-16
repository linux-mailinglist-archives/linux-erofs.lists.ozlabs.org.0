Return-Path: <linux-erofs+bounces-2752-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOezEso1uGkDagEAu9opvQ
	(envelope-from <linux-erofs+bounces-2752-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 17:54:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6129DB55
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 17:54:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZLm66vwwz2ygh;
	Tue, 17 Mar 2026 03:54:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773680070;
	cv=none; b=YNlmzOTFga5DiQVrx9fj3jWskD5P8p6yX29gGRMhjgXDjBWQ4baS63ejFeXNWTV7spzLCA8i4XQ1fHO7f12yUgUBMVZfz0uo8lKFtkkby3GiG5JpNAtYlAnDmX115bSnxh3X3iWS6Zk74KI9b1qDNM9R6zazbFLiP6CEj8LqJi+7dYiPBTFg0O5eoiSqIacf8YoSCqoivTyEK4e8PElcTVfOw+fEmZcgWKFYSLIjI3jP9YFr53B4j3JcDghGO2b/YckfC0E8tXtnX+JbTEM5dlW9XjdABcR/xp3uReBYmTP8BQMKiTU/QN07qUIo+CupMcfgnR8UE8EAK9Z1CeS2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773680070; c=relaxed/relaxed;
	bh=WiTJqmwIlqSudsYtdhNaHFoL2N9yY67eiriHHv7nks8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3GOvpylRsRliifCGj1EsJ/ah0uyYFZQlEhkapFR1E4c9EmljpKf4AzFqkXGdCOXON71Uca1K2sinmpjSEE3jEFMOAkXQG3eV9owFleSE/RBozoPvICXyZjg0y+Fu8Mbggz5yj8lX6VUwgv1rS2Q2m3Cyyn26L6w33i/hrrBgfB9UGvMZwNAx4/QRiLOhfCT7ELI7r8lBsmU8EbV6Bf+/aNPGWymR1FkDz8RxfjLgJ+qhIeTpFlMYUXDCTZ0bBgTgJaIygZXI+a2QwBE2F3UqVCVijcNwKZB0jRnlpRDgULQTGNnn/r0SqpluLFdGuJaB9rk8Jiqwr6QzU9JYVOlFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mCotIBV9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mCotIBV9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZLm52vLqz2y7r
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 03:54:28 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2aecefc7503so20981875ad.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680066; x=1774284866; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiTJqmwIlqSudsYtdhNaHFoL2N9yY67eiriHHv7nks8=;
        b=mCotIBV9qe4WJ/YahcMtsS3+UNUSuQlInDboALInywCcshp3oh6x43lLM04EJsuk6B
         Re7ztOq43CW2hJyCrncUnpkX+Zr9rg8P7h4Pj1j76RdMaBQusfv0dVqY2evyR/hdf6/N
         9rjTL7UXAXH77Io6lAXK77pfZp9M42GLaJsoxbQk5Gu2xtyM+mnOEBTZW1kZCBiBAkQ0
         tP6jNzocd2PUD0c8sARm9tYpOuZvL+p/j+SWztX+NRBdf/xDUnRC97hVN/sH4o90jEQA
         /pjD1T5qmSK/TLjTJsrwxK4N0mH/diodpvS9m3Qc0Pmz5Aw25+cnh1lcSYJCW1mQcJBm
         945g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680066; x=1774284866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiTJqmwIlqSudsYtdhNaHFoL2N9yY67eiriHHv7nks8=;
        b=GUtZnIrk66A72FUh9LyiG2YpjHqg/ovP+YDRaEZOIhOxUYLsi+c3XaRijMU7WiYYuD
         ePMFhXgHIJod84G0KrmP+fHu1b82kKQQ3CxNDNAKrk29jutKK+P6m7kiEIf+ddBmmMaB
         wj3h6py0JkFC1EJTVc5r/MtBRdc8YOzHw9y63JBzrJ1DGblMAmH9vnITs8gp+CfuD8jD
         Zn2jmAa01EwmIQIVVa6WNRc3yXikZe2Pt5x2+j5h/3YdSKjVmUvFxf3G0agPw+i8DYQq
         WX17PxJEvAWnT6eKaXnK6QkOHl6E0UT1Q/WtqaAmxXoKdF7GFpa6j343XOdfBFr+W0UQ
         me1Q==
X-Gm-Message-State: AOJu0YxvBaPPINfA98bfIH2zRp6FJOnCSUiDLT4HgNvx2WqBbwz2Vg3g
	FRg730URr3KI4HUPlrci59q0Bht8ScwXFXaenTBZFE/6Vsk4caFaAGTthyXaPsBrLnk=
X-Gm-Gg: ATEYQzzJNmcZj2vsRRqkRSc/NmjCtixnOmF615dCTc73k5DRpuln/NT9eSUO2QMb4I5
	M5k2eQtIyjc8mMxzYi3HxJ6+HY3zivFhgsjkxOq3z+e9nnlJfv+O6FkZ68vQBhVSG6x2FxIEuy0
	vZxacirI14irvd+HkGedFScAg0eh03FhF5j9tolX8rn4VPU4CMouhrOJT3eOXF869oEuA8xrcOx
	IK67jeODmMyPhuzLI98aeYZ41abaQfwcuvH3o7BTTPLFSmThc10pl2+pD6Vj+1aXdeNRzTxf7zY
	FVvoIvnSUfngfm9f6WPWYSd7PiSeHl9eNPsySo2GaABucEjhUq7oI8DMYeppC8pSBTor23McdKz
	rFCdw0kwcSvnvOLypCM5xev1CM+cskOxqxBzmoIjsmWp7DDwJfXGvT7Yu0o2jqYw7ZC9rIFNjKT
	kHttJn7iGRmSoZDod2600A8yUQ4npc0DYLpIhHQSNaHLtTR4Gxy5dGwlvfVpX7JQ==
X-Received: by 2002:a17:903:1a24:b0:2b0:5fa0:3afa with SMTP id d9443c01a7336-2b05fa03f33mr19138975ad.27.1773680066020;
        Mon, 16 Mar 2026 09:54:26 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece5c1465sm140891485ad.21.2026.03.16.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:54:25 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: name worker threads erofs_compress
Date: Mon, 16 Mar 2026 22:24:18 +0530
Message-ID: <20260316165418.7051-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2752-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 67A6129DB55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set a specific thread name for the multi-threaded workqueue workers
to make debugging, profiling, and process monitoring significantly
easier.

Previously, worker threads inherited the name of the parent process
(e.g., mkfs.erofs), making it difficult to distinguish them from the
main thread in tools like `top`, `htop`, or `ps`.

This utilizes `prctl(PR_SET_NAME)` on Linux and `pthread_setname_np`
on macOS to explicitly label these threads as "erofs_compress" upon
initialization.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/workqueue.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 18ee0f9..860e403 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -2,6 +2,9 @@
 #include <pthread.h>
 #include <stdlib.h>
 #include "erofs/workqueue.h"
+#if defined(__linux__)
+#include <sys/prctl.h>
+#endif
 
 static void *worker_thread(void *arg)
 {
@@ -9,6 +12,12 @@ static void *worker_thread(void *arg)
 	struct erofs_work *work;
 	void *tlsp = NULL;
 
+#if defined(__linux__)
+	prctl(PR_SET_NAME, "erofs_compress");
+#elif defined(__APPLE__)
+	pthread_setname_np("erofs_compress");
+#endif
+
 	if (wq->on_start)
 		tlsp = (wq->on_start)(wq, NULL);
 
-- 
2.51.0


