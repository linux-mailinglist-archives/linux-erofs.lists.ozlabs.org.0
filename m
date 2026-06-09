Return-Path: <linux-erofs+bounces-3561-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wPrxH1XaJ2qW3QIAu9opvQ
	(envelope-from <linux-erofs+bounces-3561-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 11:18:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9559E65E39B
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 11:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CM0sqviX;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3561-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3561-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZNcD1QVrz30FP;
	Tue, 09 Jun 2026 19:18:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780996684;
	cv=none; b=kyAOykQzzS/FOalX49d+TVrrkEmp01RpvqV76VuWu7Zt2ACAjPBwMFlST1LGyMTyVJ7NqxuAQGD3fS4Bxk6H4whHuxjtQ4qbz4Z/ojKCozM++ojPWv0+Qe1klHANbXju+icy4MwZssY6rxo9rHGG6Qck06UNwJjjJTHIoyDd7z+jaDV+pJ44UbLJe4M5c8yJmRWYUgxR0J1Y6ZnSnOQpW5p7Dq8LxMAXLNmUCp7LI7klEFvtkZ31KjR7AsBxiaDmEzodtJU0IMnBptEv0JHNIsPVrurGBXExIL1g5RuLd4xPlCuGFNzW4ggLLpl2/VY6hehH6Rgh8htnVTAap3Be/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780996684; c=relaxed/relaxed;
	bh=wH1hkymN8otDMfW88PaGrNAJREC0O9Xvq1bbVA972RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTgd4onRxmq3FABYlLbzAv/ugHO+EtFuFOB6sTB/aaA/SaU0v7lad6OHa6TttzaPoB0dlaeg8EYZyWn8H7m8KGJdzWkhav4fSO2E12ZImgunUxhlO0d5BSO/rJS1S3tkVlBAkKqmbvWw1kxJDmzKclY7VnXavOYq9eDXiywh/JNB+m1FIXzBBYvBqETKCUwUHUUjOozN5oi3U/Jh9roZ/QMkMOKvWi890ZyjGHRIXGUNAryKLNkhFzAi0qxa2MtL2t4uQ5JbvPuP5v6IxK+8nr4rSgpl+7e/b8/hi4yDV478cEndJLVevAaLzeRrSDNstECIOcc3Ruu6lYZUl3/gKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CM0sqviX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZNcC3K3hz2xM7
	for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jun 2026 19:18:03 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c0c379e8ffso35966265ad.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jun 2026 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780996681; x=1781601481; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH1hkymN8otDMfW88PaGrNAJREC0O9Xvq1bbVA972RE=;
        b=CM0sqviXdbpNWSUlq+tT27ntXyM7a2MNWfQkdKL/ATmTyNC7ZuAjNLamiWNxAGfa+q
         AhQZ7rLKusWdEsqEPGW8R/e73WDqF7vhLlYmAGEUZ+MFiEA1yHiFV4FwJdMOlEMVEl2+
         ZRGz3aMYerhPMWz/vl7We/Hl0E+1HasNVRoRGvm0ne8BAWH4aJjirA4fy8dT2csDCFHc
         1hZsfpiy3+KiImqZ4D1AAzclsAMFqMzpcL6DBUo7+UMpyxC4oEoMu0Cip+H/yTG2XN43
         qMglY7Sn0mCsgMNzxeMeX0kZYIQ7Iht4df82gxL2ur0OmylRGPgBnnlHiLnU6QrR0Ik5
         Yshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996681; x=1781601481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wH1hkymN8otDMfW88PaGrNAJREC0O9Xvq1bbVA972RE=;
        b=WjHxHiYN1e1fOIFaY/z4GGItdIR4kZrytd2LVUlZ8khrcgPAM3CBiQcHAOwiVlOqCn
         yzdb8du2TAmNSPZsmlDa+z4TqEkaqCOFNsiOek02W0SB0OLG+k8De4s0YmyQ4gCtG5pm
         2qHgj1ks/RqIVmj1CmRAjSvm7oSrF2cQ0FuCPPW+lrZslSvSRtQCg4Gbss63U6WPTGYe
         fbyiRFhoXtJK1SlylMknlDJe8OrsfpmSr0TU6T0AHa6TBsroPKi2txoqTJVqfkoqhTlV
         CzMzKzGWPz1/OYdLPjHqSIZzOTM//drZWFfe8TOTcqVFAIAEHy3ZSX9sUhKosNjKVl/u
         R1Lw==
X-Forwarded-Encrypted: i=1; AFNElJ/GD6tQqd4f8i3Kh7xqH/tkZ3GIGnTm1J4EJYLoP5HSMyDWNEB3H9nE7PpMIGcTHfU7uYfDnU3KdE3yDg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwmybyMMCDgt4uWmQ5CMQApQ+mT03x+p7K1mICJftxjY1bumTJE
	P6rI1wcgn8p1SR8hJtB8xBVvrIfhFhsPodTa37JETtXpFIGFGP2quPPu
X-Gm-Gg: Acq92OH5HsRBo9bImUnpg3ABWmuOU70jpKD0w0Bb7T2l8zptzHWOG2W7pvWVjqi7WZw
	rHDw81HoVraY8bQ/cDLBX/jLLBMrToMaC1U/hzADJYq5nSp9PUIK+zZTE0bSef2AZh8XWALP/mT
	fgtF2zUezqKpHzVXwje3A0H72xShW0HQNLAt0BgVVEhvunFU8M6TQXew1798AbUskIy+UgdUcHi
	iVClkazSEPFBVwI9q20yEozSzpqg0maqa8kSrDGsnqPO1pwiYgY4BZR1cakF2mGt5VXDM9N+DNW
	1+5pmwj/9dNTjTUB/Edvm2p+PGOaxv7d+YURJ4sZMoza89L1UxX91Fnkwi+O3BWMXFXiPC6/VCY
	A5joWLMny/8xQDEyytSczDxG/GMYW0qUgcs356xJMgImq9mMOkBgrr5pI7yZhNbqwWKdO8mDTPk
	hz1pcAxx/kQbDGvNl2UjC3UMJB4JhjMjvY8BsSk/vAU+e/lYbjlCRMFRL5YFnalM2+YA==
X-Received: by 2002:a17:903:1245:b0:2c0:bcb3:86f with SMTP id d9443c01a7336-2c1e78e431dmr204896265ad.6.1780996681426;
        Tue, 09 Jun 2026 02:18:01 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2e2sm201467005ad.49.2026.06.09.02.17.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 02:18:01 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v3 2/2] fsck.erofs: implement algorithm-aware pcluster batching
Date: Tue,  9 Jun 2026 14:47:43 +0530
Message-ID: <20260609091743.71420-3-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260609091743.71420-1-nithurshen.dev@gmail.com>
References: <20260523003757.13078-1-nithurshen.dev@gmail.com>
 <20260609091743.71420-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3561-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9559E65E39B

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
 include/erofs/internal.h | 2 +-
 lib/data.c               | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b4db2e5..94f14da 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -64,7 +64,7 @@ struct erofs_buf {
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
-#define Z_EROFS_PCLUSTER_BATCH_SIZE 32
+#define Z_EROFS_PCLUSTER_MAX_BATCH_SIZE 32
 
 struct erofs_buffer_head;
 struct erofs_bufmgr;
diff --git a/lib/data.c b/lib/data.c
index de05c6f..e9d2218 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -25,7 +25,7 @@ struct z_erofs_decompress_item {
 struct z_erofs_decompress_task {
 	struct erofs_work work;
 	struct z_erofs_read_ctx *ctx;
-	struct z_erofs_decompress_item items[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	struct z_erofs_decompress_item items[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
 	unsigned int nr_reqs;
 };
 
@@ -409,7 +409,10 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	item->out_offset = out_offset;
 	item->out_length = length;
 
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


