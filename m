Return-Path: <linux-erofs+bounces-3525-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vblcHhZOJmplUgIAu9opvQ
	(envelope-from <linux-erofs+bounces-3525-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 07:07:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB751652B25
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 07:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m5muS5T8;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3525-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3525-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYg5b33C1z2yv0;
	Mon, 08 Jun 2026 15:07:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780895251;
	cv=none; b=bYUsxGs+SuUa8AsN6+N7DfPSnGXhSYtqegphWanbB/4WqMvexrb0m/NikwNItibr/xbiXKvy9o32LskLblqhB32xTgL5/89k9CxxhjHGf7mXMT75YN+L4z7Y/JYkAa2x2iQEPpEuuMWm+OwLAkGRM/VgSkfWT1K2OTW4P2MkgJrRPVF6f1QHls+c+uTGErKbhRpn4nQQqHdrfR+kzERRI9gxd7tm9an/0yBvdSIejYgV126+L8T9lJ6/SzJXBFGuX9Kg4s8/end6diVdRoqk/fk4wCdIc6ixJ1Y/rKbMwyvWEfkFOvJY0VEn4LNOl/crk4YK/pdpPGKxPN98z2ojew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780895251; c=relaxed/relaxed;
	bh=wed8GTfZ7uSeWSN4DR7Dt87RaaU2t92zl+l/kNYm+X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGk4V4rSjozKZCEo1obZ4yKWmGlXhK4eEv1AmSubnZYPlcmuOAC4kEAW4E/TpOdPY90eWMJkaqdrpjmJbSm5gnrBts6vvrfcDQnedosxOAl8J+Al0sly+caK26S6mRn/qNBvfJzFEJsXDPKQJtPsocwEuDSW2eGHzpvJrt8MMToghG6Qfl2X4tEs1v0IFwfzyIP6AO8RWlFzJd423BZJWuUh1cZCzqH0Cl9XstoHupJqU5aY+VHPtD4pOHIDSAjil75h63ksOKJeBt4wv1f4JC5ass2cgBK5WIWQw34vvLRCi4vragq5c4CxiKMSgrBvAKIFEkPT1hdnXIb34U15yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m5muS5T8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYg5Z489Tz2xqv
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Jun 2026 15:07:30 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-36d8b644473so3881996a91.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 07 Jun 2026 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895248; x=1781500048; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wed8GTfZ7uSeWSN4DR7Dt87RaaU2t92zl+l/kNYm+X8=;
        b=m5muS5T8q9tXEWmRCdkH9J65/v91jiLyDaEbsj0jpQheDGAxWIkNnp4nTJLonuR6cu
         WhpUApRzKmxtoTO0eG9pG/jF59K+kgYEgfZoOYhdVTHks+rwTw1I9M63uGWKkPdv8zhc
         47i0KczrDKIgudiK010UTFJiTSYdPVudZw4WdOB/EpJzVPMDvyOXFcyClO/GMvlPlmu6
         ihyrPM4RNSIkDNdFh+WWDYhz99RwSjyEJwRe5t4Pf82pe27o9588JT0KIM3T227v6pJI
         E0wQhG8yrqygBhZBrGkOULtGL2d4J5iIVng5golknI6NnofyQqpWC7ARzBNa3ObjsAWs
         D9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895248; x=1781500048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wed8GTfZ7uSeWSN4DR7Dt87RaaU2t92zl+l/kNYm+X8=;
        b=rLAe4SgK/r1MLZ3wfT9pwmNPTqPg6Xwc9zh+m75u6hSHUpzn33l92mXodPJAjSG/h+
         N7n+ckAo0nMwN2/exHiLq6WGfYqGe2a4moRbdRH+npv/NJJ7mfHc2F8BapDH6QovGb+6
         XVgO2fIkX5VYaRnVUbKnRT6VBcw9OnZmrib4SpdIb2zPJw/scux+9b2cjx05niOJkTxP
         aR6kcdPmbdLjmMk7i5BIkAjQOGGzY8GH3O9osmuf36GxEeAoTf81kiegTikIEs8qZ6IX
         8NBlbViADnnsFUxvUAa1krtn/L6hXEHCMQsw9AgqXC6v2QEipdeuxk0+eTx7dnFN7Goq
         WkpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wONrDWBkUIoEIryYumlMdc4NW3fKJmg/VbdwCqjr1Fn+UTSRYvIS6lH3rSKFBtioVZc7wUPkh2gDgyw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBU+UUrGcnJIl9atwK8vocVB172NjUoY6vTSEr1eDLCR9z5yxR
	PyaCLschobrmgXHH2NPZnbOXnz7ymfJeMAaHg/kU8Ymj34WOj45o/pa3
X-Gm-Gg: Acq92OGp2IqG0LglQqbcctuqBKWMwUGve5DUwa+Q1YSGj6ferFgJjFcpVIQKMPTlYvj
	eni9fsbASeHqYxVx04jXrKDjwjBdrSNec9PCAQy+KMpuKpeKrf8Q+d4HRb1hhkKyRFBG2jvvmWg
	TCKPCEPZuZL8koyAGoFIJsHlSkl9Ze8XF5n4j9y7pnsJhEC44rUCQp7mjhiYff766Afd+VDG2HL
	d5RE6v5u4oHtRXrTXao6qNzR/FkYCRT7VCQu8YlLLD4b1dU3w+rmtbR6chVC3NXBhDFAi8dp+QP
	0CM0bfUlu5RviRZsQ1CIMZzUOXag3W5zOBowaso/jaobUq+HbC/5Ysj0Wu4yN9ReHVrtHX2aqB/
	Y3Z1NurssCjWUTBPx9auOV920oshcw8h3lUzcttOelr5+GbfNq+EfJfSqdHV24skUNcfgZ42brh
	14rNfbK3sEmbpqShCqCYAzP/c0kQVr5keJbw529SX6UNYCY7TReCj5qpp5zd2z6sU3EJBgKDnDh
	QskvjUsFqOETjY74ULSLqN+6y3xhQ3aAeY=
X-Received: by 2002:a17:90a:d44f:b0:369:69f8:ad6b with SMTP id 98e67ed59e1d1-370ec3d60cemr15666895a91.0.1780895248385;
        Sun, 07 Jun 2026 22:07:28 -0700 (PDT)
Received: from pool-100-10-46-50.prvdri.fios.verizon.net ([139.167.225.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a29cd6sm14198397a91.11.2026.06.07.22.07.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 22:07:28 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v2 2/2] fsck.erofs: implement algorithm-aware pcluster batching
Date: Mon,  8 Jun 2026 10:37:11 +0530
Message-ID: <20260608050711.30648-3-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608050711.30648-1-nithurshen.dev@gmail.com>
References: <20260523003757.13078-1-nithurshen.dev@gmail.com>
 <20260608050711.30648-1-nithurshen.dev@gmail.com>
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
X-Rspamd-Action: no action
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3525-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB751652B25

While static batching successfully overlaps I/O and compute, different
compression algorithms exhibit vastly different scheduling thresholds.
Extremely fast algorithms like LZ4 require large batches (e.g., 32
pclusters) to effectively hide the synchronization overhead of the
thread pool.

Conversely, applying this large batch size to compute-heavy algorithms
like LZMA or ZSTD causes memory bloat and thread starvation, as the
main thread spends too much time reading and accumulating memory before
waking up the background workers.

This patch modifies the workqueue submission logic in
z_erofs_read_one_data to scale the batch size based on the algorithm
format. LZ4 is permitted to utilize the Z_EROFS_PCLUSTER_MAX_BATCH_SIZE,
while other heavier algorithms trigger workqueue submission at a much
lower threshold (8 pclusters) to ensure a steady pipeline of work and a
bounded memory footprint.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 include/erofs/internal.h |  2 +-
 lib/data.c               | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 63fd3bf..ffb0adb 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -63,7 +63,7 @@ struct erofs_buf {
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
-#define Z_EROFS_PCLUSTER_BATCH_SIZE 32
+#define Z_EROFS_PCLUSTER_MAX_BATCH_SIZE 32
 
 struct erofs_buffer_head;
 struct erofs_bufmgr;
diff --git a/lib/data.c b/lib/data.c
index 26fdb43..cb882c5 100644
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
 
@@ -401,7 +401,10 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
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


