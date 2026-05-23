Return-Path: <linux-erofs+bounces-3480-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMaIIvr2EGoxgAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3480-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 23 May 2026 02:38:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAAE5BC11A
	for <lists+linux-erofs@lfdr.de>; Sat, 23 May 2026 02:38:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMjtF5J7gz2yMm;
	Sat, 23 May 2026 10:38:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779496693;
	cv=none; b=Z7/QZhQrfeUJSgWUxUq0+d4XeNc0OUxrGLO8Q8Zgcsi9q4YROSIvZPX+d1zsFWob5aqf3NoF8irEiqr6/xlPPeCbyT+Ly/6V73TLV1+bt5zwCdXYlhP0B62yzWBFY7H5fP5z+zCMbTT2TvKbcqmUN3eLastotAmQgpi9NzbJ4rDDC1s0Hnr74kMJUjqRV2fYjZPZ8A6SXf2Kwel4d2E4Wxsr/EkAy4NIth/yO8AeL2USQSNrx4IbQgzSYHAQ/IHk5G/0orj8uEgODPGLn+m8EKaGoXZcgezkTgZErjaV9q0HJtKv60PRjDBSTiQqQX28MDGRkx4Lk3EywSN/AE6gXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779496693; c=relaxed/relaxed;
	bh=LaxT9dM6UJjV6lxyKKgyR1xDVIiIcWEqe6ix1hwobS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJcoH838BlORZpfoq7/ICIY3JOVclOR/qC/RL12EqRRaYvPkEAhSQtakR+dHaK7fU9Rmlvdc8oqwNCW/nosZSUC1l/tUSCjPtiGETummpsINOulKkv8NvBwjSydWh0yJgxyNmeAzdG0wziR6BYc/wKJNhTe7QgMVJA8Ij25DINl0WDWgOu/CoWodf/y8KChS9y0XGmLBFv85pJg4+yje3kzxMUvJAZvTpRkHTYlFWBJt5qlqtweDIXN76P4CQSvV4gZ+IcxlqELcTXDxRtErRwTU92peOK7nVNgFtQbe20hrII6lGvHKZg1OzVQjTYUss6ndu0SKaSutUJQN1eji/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/HaNeEs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/HaNeEs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMjtB6QBLz2yH3
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 May 2026 10:38:09 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b4583f0a1aso54204135ad.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 May 2026 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779496686; x=1780101486; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaxT9dM6UJjV6lxyKKgyR1xDVIiIcWEqe6ix1hwobS8=;
        b=e/HaNeEsf0uHDFaVASv72ubuyi9SeCsUD10jLVzG9njF7nAUwFl02GeU2UJjUUCaDH
         +c3A8PaMbmrojyoXbqBeCFsaEcydS146kVmL/43zNXehjj7xm3MdFwqSYTt91iY2lhci
         rPpW9w5nER9XCpvBq00FSCXAVFlRH4QLkjfJ0VtfMvFhqQvCkOg2KTNaKOFfyZfCwyG3
         F1jCoy38Trpw6S+qzw5NNjqHDnycKaqGzH62V5lyWwiYkazu+LSkFyF44bNUtDy4GAmY
         UieKcEBzjIXnvpxdNEnxLKCtKcoWxvBUL4828dlA42pWAjWm4XC8/FKJqRfMZiXcMUbh
         8Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496686; x=1780101486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaxT9dM6UJjV6lxyKKgyR1xDVIiIcWEqe6ix1hwobS8=;
        b=hKYByxIYWOzEPNqYCy9+RxAN49zgr+PZLBH2ZTP4fdb0aEsbeBZIoIaaBqy8zxx5wV
         SToLtW4ffvYaSQ7Ow6yPAKAYg+NWukXc82375nt+aTpiucS21R1N4mWr7NljcNUT7aa3
         9S6eEmZbm1H2SFSBqU4IKbfRPcffCXMNeGh43P5bFXCB2PMPaUJ3zYHrJ0e9wPpvDtnz
         xNAA7yerShvRKVPrcvaugtvruNuBLmFZbC+yNtSq7IPQ4BwqIPoAxJbVQ+H5z8DdFPog
         B1tFTB10cw+lN+jFA8NbttJ0neHl7NlVumUfcNY8QSsk9g7X5o5D5wwpHxWlVHI385b1
         wBcw==
X-Gm-Message-State: AOJu0YyH0lL5LwrFr7lKd4gB2P0VlxjJfnjn1VzIMTUVEBAwlkd/9xlq
	5rv9Ahzcup9f2BG1XkXKAS9ZfewAs3g4ZvRIX72lT163Tm+/zdaDj/kRDCyM713w
X-Gm-Gg: Acq92OGF/80t0jSe0THGPN56cQsyEQFoj5uWbJK/A9KW5fERN08+SLX7Psi4Woq6Bs7
	uPIFNqJjQxJXdKNi1ET4w1A7uuNkkmbc6BBdMCWEVsIaSJPeXCZBi//jfephOdJI1ltjrzNGvPc
	vorbHo2F4imiT0RsF3tDjI563oH/iFVX4DJgwfDX0LZclpTFrG7hIqsv/qvpFbCL7rS5F94qnaP
	7HZPgWx34RQAUkYkOd5HQsFvUNajwOnFOyvj0YOPufp0ixJuthYzaeb6QXvXl+gaxrgKrQg/P13
	j4y2kYDl395amlk/GS+5llY15ntDnCKlqXgNAnlSlClLPDbPCqsorwLRef35SCPvf+GgZiybFL8
	GTNPadQzmxUXKi3UMIQJRrAQ0+udqsD4wog3RDOabCLMwOURUYMymUM3PbVh8DwZiJff+i6Zkw7
	+Vr1F+HeCbxuQA/90AaXaDZye9LDq9ufb3+AmrkvfO3KZrwBcwxzVYBhRyDkk5dU05Xw==
X-Received: by 2002:a17:902:da92:b0:2b2:5857:583e with SMTP id d9443c01a7336-2beb080a6dbmr60583175ad.31.1779496685909;
        Fri, 22 May 2026 17:38:05 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f3dsm27393835ad.1.2026.05.22.17.38.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 May 2026 17:38:05 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 0/2] fsck.erofs: introduce multi-threaded decompression
Date: Sat, 23 May 2026 06:07:55 +0530
Message-ID: <20260523003757.13078-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3480-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 2BAAE5BC11A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

As part of my GSoC 2026 proposal to introduce Multi-Threaded 
Decompression Support in fsck.erofs, I am submitting this two-patch 
series which establishes the core workqueue offloading infrastructure.

Baseline profiling of fsck.erofs extracting LZ4HC 4K pclusters showed 
the main thread bottlenecking on synchronous VFS writes while blocking 
decompression tasks. This series decouples the compute payload into the 
existing erofs_workqueue.

- Patch 1 introduces the baseline producer-consumer logic. To avoid 
  massive futex scheduling overhead on tiny 4K clusters, it implements 
  a batching context that groups sequential pclusters into a single 
  erofs_work unit. Buffer memory ownership is strictly delegated to 
  the workers using calloc() to prevent garbage-byte leaks.
  
- Patch 2 implements dynamic, algorithm-aware batching. Fast algorithms 
  (LZ4) are permitted to utilize the maximum batch size (32 pclusters) 
  to hide scheduling latency, whereas compute-heavy algorithms (LZMA) 
  trigger much smaller batches (8 pclusters) to prevent memory bloat 
  and keep the thread pool continuously fed.

The implementation has been verified to produce bit-perfect extractions 
against heavily packed LZ4HC test images.

Nithurshen (2):
  fsck.erofs: introduce multi-threaded decompression with static
    batching
  fsck.erofs: implement dynamic pcluster batching based on algorithm
    complexity

 fsck/main.c              | 234 +++++++++++++++++----------------------
 include/erofs/internal.h |  18 ++-
 lib/data.c               | 206 ++++++++++++++++++++++++----------
 3 files changed, 268 insertions(+), 190 deletions(-)

-- 
2.52.0


