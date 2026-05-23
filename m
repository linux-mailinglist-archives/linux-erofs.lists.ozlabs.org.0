Return-Path: <linux-erofs+bounces-3482-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDo3Bwf3EGoxgAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3482-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 23 May 2026 02:38:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6A5BC151
	for <lists+linux-erofs@lfdr.de>; Sat, 23 May 2026 02:38:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMjtK0FLMz3bpm;
	Sat, 23 May 2026 10:38:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779496696;
	cv=none; b=bH8nT11JD7rE8APL2StP3mjC+AcUOeSXBJZzYgEYkI73QWdLVV8ajQRhwVniCLFE26SQXavGKT/B8ncrLtbzqH4q1/ZKss/VqogZ1pRBKruJGzj+8syKQMkAiQJDuyYeCurYbYjmeq/7vjtyqPDFAlc69l2U0TIn0KuY5tce77G0ikpg2xzvx0Ky4He2qydSQGAKGMpszHxYAGvSKgKPtFBofMUf4dgakcLD5/0z9xZ8AKyFdrNQ6rS9ktvPZ6l8zz7E4PLRNfSzJL3S9Ug5R5b2IsDF9uKj5fzdwgDUC2+jmL3e0mt7qSBFJQuRRl4dsDwpD6tg4713xz5cRRUq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779496696; c=relaxed/relaxed;
	bh=MJrKqVLHRxRs903GN1lMuO1AVJALDO/Kh5a0ikVLR9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyN3NHVqC62AXRJ/ZL1RAI8Zw27YOmRRu1cNtlvmT9fGJy5RZWeIOM3viP5Hjy/bLLFgurIyuWkrkSJE1jeO3qvkEFNr3ELA/0u1ZUhccxHtvRqLqJ4I5l51ghpJSMVUXpk772z7zjO40sUKBi7LsgXE2SRF9flRbNYXr0ArmPvH6Pp7MTGjSYt8U9lWz9EjpBXNBsf76L7K1pGfDuWqKYPIsMLgfBWuOTuZWs3ZW73h3Rbb7DPJLy/DrQTBphBjc2E/QPz74T6bk88HbjY3ZBnFEMPQsGiLoHNzmF7Drg2V55p4wWqu6J+DQH51/CYIV0cuS/po+ViC3AxqHAMgHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j7WwdV5S; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j7WwdV5S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMjtJ31rsz2yH5
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 May 2026 10:38:16 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ba4a1a0325so51641365ad.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 May 2026 17:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779496694; x=1780101494; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJrKqVLHRxRs903GN1lMuO1AVJALDO/Kh5a0ikVLR9I=;
        b=j7WwdV5SrPplqKEzvmBxF1RAC+1WNtGuoeHqThsymfOzrDcTiwu7Hwjv3eG3arlEZ2
         +rSgIQdMLIF6NQ2kHV7h7uIq+R8Mxacp2nl4HxV9d8T0n1thkgExM2VZIbhDXqLepjKK
         nV6a8VocST4xQbM80E0LCBx6BGa7TWdu6N24TGUOO10B0A7Hy9hT5BoEVxFZQE9T8xzJ
         U8nbmcP/m7fXBES/sbDsNFu9wc6J98Myd/+jQMknf3OKeglGG3dHxI5xSiwsTIRNY7fC
         6voS/R2H99rjfOa4ekP7gxvTrnoZmeBlqKLKUSu4zGEYs0wGD5bt+JhJlC4fw68LO/13
         Ht3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496694; x=1780101494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJrKqVLHRxRs903GN1lMuO1AVJALDO/Kh5a0ikVLR9I=;
        b=TXhT1qlAyDtiLXp02aUJ9gd6d3Ctp49kZrCguV17ghjAxFKtWPTz8tRy469Oim7tov
         N0c1ZMJBuFfQfx60eInl5MbpdtwZ0ovYm4G9B77vqWcZvdFoJcLUSYHOC+OehpaPkph5
         IfBtjRfuC/JOqJ5KuyPGPm9Hy2BdaL1qHIbALznEFauDqfwx+Q/iYn8dFLLj/M0GAXql
         4nD2tZu3xGBqoCb09fyvedmd6rehzUJjUWIwZ+hCq1MjaxnXNkacPDLbRQnKeZvF8jDR
         hD0lXXgTj6Nm3mLRNCV2EhIM2Zme6FPhtdOBKMcZgstDsnwgUyXaBCi+3X8DkMQzqwPo
         HFgQ==
X-Gm-Message-State: AOJu0YwI+0cB5LDFnN6RKNCx2qw7/Aanq2s0y46Nn48tKUK0UUQZopo+
	ALacXpQioVUi+E4sRcUOdOL+c2StRqDY2wxvEP9XRVgi6kYxdy2lRBj9/Gwq4WSY
X-Gm-Gg: Acq92OG2cnB0UQIr3OZfvHvasBz+McBVr+6+j77L/NelptKqz7Jc0iuEuT3UotOBvA5
	sHw8aaw4rRzqfm06xUWGH+SOEPmdudiFdV4AWlWzLHfBgx5pqVDPbDc1K7oDuSE3ECamy72nXFz
	5SVmDTx/1rXa844ZoW1kcidoHTBfVHjgI25mFx3UGfqEElq494/VD6w5TM78ETiVQ1mLscDkMVe
	gBvlteCy8L3GbOAVnANzvh+ZIgOnPhzKnmznJkguVqttzL87pHTQMB1UFvdIfw5bHkoaGJ15KEZ
	tyVqT1336AbTOPeZfT0yzh4Js9Deg4qvW/JHW2MfwnQhg/784z169Pte1y19Y0wieSW01kIzZ/S
	GxabwoFXiJ8u5oPU407guYbjxj7Rt0Q0KWr2H87eYnD96jRw0Ka3XRAhXsJmpQbTlRc07DbP4gN
	kyjxbUXF8qiA2llDMifhVW9HwND+aKgr83sk5UZncMxBo9MIpZyDazXpSGnjGYdw00uQ==
X-Received: by 2002:a17:903:4405:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2beb06733bemr63052955ad.13.1779496694408;
        Fri, 22 May 2026 17:38:14 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f3dsm27393835ad.1.2026.05.22.17.38.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 May 2026 17:38:14 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 2/2] fsck.erofs: implement dynamic pcluster batching based on algorithm complexity
Date: Sat, 23 May 2026 06:07:57 +0530
Message-ID: <20260523003757.13078-3-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523003757.13078-1-nithurshen.dev@gmail.com>
References: <20260523003757.13078-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3482-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 69D6A5BC151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While static batching successfully overlaps I/O and compute, different
compression algorithms exhibit vastly different scheduling thresholds.
Extremely fast algorithms like LZ4 require large batches (e.g., 32
pclusters) to effectively hide the synchronization overhead of the
thread pool.

Conversely, applying this large batch size to compute-heavy algorithms
like LZMA or ZSTD causes memory bloat and thread starvation, as the
main thread spends too much time reading and accumulating memory before
waking up the background workers.

This patch modifies the workqueue submission logic in z_erofs_read_one_data
to dynamically scale the batch size based on the algorithm format. LZ4
is permitted to utilize the Z_EROFS_PCLUSTER_MAX_BATCH_SIZE, while
other heavier algorithms trigger workqueue submission at a much lower
threshold (8 pclusters) to ensure a steady pipeline of work and a
bounded memory footprint.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 include/erofs/internal.h |  2 +-
 lib/data.c               | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 38020ee..c8f056f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -62,7 +62,7 @@ struct erofs_buf {
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
-#define Z_EROFS_PCLUSTER_BATCH_SIZE 32
+#define Z_EROFS_PCLUSTER_MAX_BATCH_SIZE 32
 
 struct erofs_buffer_head;
 struct erofs_bufmgr;
diff --git a/lib/data.c b/lib/data.c
index fa36899..a06f4c2 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -17,11 +17,11 @@ struct erofs_workqueue erofs_wq;
 struct z_erofs_decompress_task {
 	struct erofs_work work;
 	struct z_erofs_read_ctx *ctx;
-	struct z_erofs_decompress_req reqs[Z_EROFS_PCLUSTER_BATCH_SIZE];
-	char *raw_bufs[Z_EROFS_PCLUSTER_BATCH_SIZE];
-	char *out_bufs[Z_EROFS_PCLUSTER_BATCH_SIZE];
-	erofs_off_t out_offsets[Z_EROFS_PCLUSTER_BATCH_SIZE];
-	unsigned int out_lengths[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	struct z_erofs_decompress_req reqs[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
+	char *raw_bufs[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
+	char *out_bufs[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
+	erofs_off_t out_offsets[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
+	unsigned int out_lengths[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
 	unsigned int nr_reqs;
 };
 
@@ -397,7 +397,10 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	task->out_offsets[idx] = out_offset;
 	task->out_lengths[idx] = length;
 
-	if (task->nr_reqs == Z_EROFS_PCLUSTER_BATCH_SIZE) {
+	int batch_limit = (map->m_algorithmformat == Z_EROFS_COMPRESSION_LZ4) ? 
+						Z_EROFS_PCLUSTER_MAX_BATCH_SIZE : 8;
+
+	if (task->nr_reqs >= batch_limit) {
 		z_erofs_read_ctx_enqueue(ctx);
 	}
 	return 0;
-- 
2.52.0


