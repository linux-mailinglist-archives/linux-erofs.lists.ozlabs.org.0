Return-Path: <linux-erofs+bounces-2754-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P+AN7c3uGkDagEAu9opvQ
	(envelope-from <linux-erofs+bounces-2754-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:02:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A90629DC97
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:02:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZLxb6fbJz2ygl;
	Tue, 17 Mar 2026 04:02:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773680563;
	cv=none; b=lXbfBe2b6tv9XBdn9tjjB9dUNA1Muo2lc3abGQ2ryQRd+qKdo4PQ7CrU9u8jo4+9M1V4c+1KEPfvoSx/iGwKSJWwCQV3+4Tl1oqyUFbPj1PznDshSRuGE0RK/71GbBPQ71zNe9sd5bJ+OiFzwLota3TUtfKzzQRvhvzY/bdtL0lRiNYZ78XonJOG5hnzSEmgMbo109QMTCwxW2FQpIAhBLrhImDKk+ci+j5OMzCtRUgDpD9AU5dqGtnoFZE1YJlACQ+glsVp7HuVzrrdCu4muXrtCUh4VMgs+1RiQaKmlGC4yQeppB1vNq0hYWpEQmz6/nM8ZIUw5u9XC0J8GLTZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773680563; c=relaxed/relaxed;
	bh=V/PuJ2FCgl6iVHRPuOeAaJQ5C36/x3upvoooaUwXqi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsQJtmR/ZkLnkVYByjGKChyK9xhDFKPakh9XBeXyw5KhNTxYZIAAv76k/tEU2MwzFaHdU3tcdWFr90mCuLlWsdKkxMtoPNxHMSY9ascEP6BDBsNbS8FInMKqaMyxLihd0+jfqqmPHEWltdvmMeg2Pceguic/GEUNLo/C7sPPePwGUMMSZj7Nye6YL5yAyRSfJT/32QJDEA0gBxxcmlqMy3ZTQL6nI38B/eYghRaX11XFZRx9N2jOA3w0BFT6hk/P6LYUadldbHtUetiamnWKLzUbArRKGdlWsaEJEZVeBu/VVARKOygrxS3ZOs+hswAzGjMN5zhWkDGIRiobkTuj7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=czSyNmtg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=czSyNmtg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZLxb1fN3z2xS3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:02:42 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso831641a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680560; x=1774285360; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/PuJ2FCgl6iVHRPuOeAaJQ5C36/x3upvoooaUwXqi4=;
        b=czSyNmtgOnDT/8v4a29bQEgQOkWY7Un4zasVb7JO5QAo8+OsUmO337tZcSERGpNnaF
         LPYHWkWoht9/novvOUf4KySwsq3jT4lLkgGH4fKD4O7BVDmb6OI2/KXS8Py7HHeIFxZD
         xaKb6drSLwLPfu/wWw5gd8A7vs1fJYypADBQNQs1+UCvQjjhbZLFZAw2wq46h2CEz/Eg
         pV5jUbwewFvmLWrU9PDTpyRp2MlW5DlrB8nQI9hIej2tIYbKB6PUZkrk0FDZc5+K+xKu
         5oxIdW2ryr8/vl6OSo/SSd+WUz/C3DykBS827heJ0Gkrhfmr8dC+MkeKUzd41H8916hp
         SUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680560; x=1774285360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/PuJ2FCgl6iVHRPuOeAaJQ5C36/x3upvoooaUwXqi4=;
        b=MZp8g4dJOunLYbM5DeClbJ+p8bOs3ZECVhC8n9egFfcZhiq2+WGVhWla5Ry860oS3A
         2TzyHV7qb/NQHwPohd8YKaN6L3J0KfLgNBwQ2QdhvXIr/3NHx0aPvNUqfP3Vi1oo2HD0
         bkfcxcQ/lKyS0ur2vm3ItDKgpKscWTQFBAz4H4gmUl5MgEq6fxD8du+7nBD6zweOJJu3
         DXhuN7Hm4au8z3xWmkGA2RrZ8FGXaGbCmq4A9MEUf4zaFHGcYHdudh7HFERfI5PIcYDS
         9GPt6N3wCJopbLR1MXfXeerdHX/xPMTN/X4/5VzmWXyC6WAaOCX5g14GuTTqQvhj+kcp
         +uBw==
X-Gm-Message-State: AOJu0Yz4mUIfVgTJafjk/cctqad92S057vct0gZM36Az03cJ3k/pyCaL
	cT2M2ow7xXEsWnClf/XEs8iTFLiSdUXMK3z761X0WnsPRsGx+S++aJqjj6wfVlexGxg=
X-Gm-Gg: ATEYQzwuLq+yMM3Ru1J2PzGUid+U17eAf3dkSm63pSS6wgV6n00k7OIv0M81eNXNjA+
	ocImknZSwkZAbUIMqcIKjlEWtMOKLrLmLaWDcvpk5NTuSn5BUNUNczgSJiKl4bfmrRVsCmUbo8W
	IIlpUI9fNUxGr/OJeOwGokozQx1V/h7PJPVWCtIrjW6UhZ7vRJqH7viCA77BWgX32XTxACekiv8
	zR4S0K+FaO64SpEq8HZQ+k781LL5bF326CE0CQ9pI4aVLWjQkg8+gx1eabz9mzHd0iXPo0e9ylM
	AHpMWx4mV4yqsz5wJ0TFniVPQoPAiBAzTwkqJ089l5YpJD2khgOAvI84PxpInVhyLBj5LKCnCb4
	jsBiK063hQZkZoWBjmckb8jMLTQkeOW+qpEUQOZivU5TU7D69JilPC6JZrKr/GajkAlNVnTojVg
	moq5iNffvzc7yvr5WFdQ7Ma64YSi899gQHNNPtQNhxgCUcstWqub/ufeaMzFiEnA==
X-Received: by 2002:a17:90b:3f0d:b0:356:9405:759d with SMTP id 98e67ed59e1d1-35a21e4ee18mr11905014a91.9.1773680560421;
        Mon, 16 Mar 2026 10:02:40 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35badbcda60sm158217a91.14.2026.03.16.10.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:02:40 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v3] erofs-utils: lib: name worker threads erofs_compress
Date: Mon, 16 Mar 2026 22:32:33 +0530
Message-ID: <20260316170233.30662-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2754-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.992];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A90629DC97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set a specific thread name for the multi-threaded workqueue workers
to make debugging, profiling, and process monitoring significantly
easier.

Previously, worker threads inherited the name of the parent process
(e.g., mkfs.erofs), making it difficult to distinguish them from the
main thread in tools like top, htop, or ps.

This utilizes prctl(PR_SET_NAME) on Linux and pthread_setname_np
on macOS to explicitly label these threads as "erofs_compressor" upon
initialization in the workqueue's .on_start() callback.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/compress.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/compress.c b/lib/compress.c
index 4a0d890..66b3b8b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -26,6 +26,9 @@
 #include "liberofs_compress.h"
 #include "liberofs_fragments.h"
 #include "liberofs_metabox.h"
+#if defined(__linux__)
+#include <sys/prctl.h>
+#endif
 
 #define Z_EROFS_DESTBUF_SZ	(Z_EROFS_PCLUSTER_MAX_SIZE + EROFS_MAX_BLOCK_SIZE * 2)
 
@@ -1427,6 +1430,12 @@ void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
 {
 	struct erofs_compress_wq_tls *tls;
 
+#if defined(__linux__)
+	prctl(PR_SET_NAME, "erofs_compress");
+#elif defined(__APPLE__)
+	pthread_setname_np("erofs_compress");
+#endif
+
 	tls = calloc(1, sizeof(*tls));
 	if (!tls)
 		return NULL;
-- 
2.51.0


