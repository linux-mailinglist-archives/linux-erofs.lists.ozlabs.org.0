Return-Path: <linux-erofs+bounces-3560-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CLCnEUzaJ2qQ3QIAu9opvQ
	(envelope-from <linux-erofs+bounces-3560-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 11:18:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9870965E383
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 11:18:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PcOuyPSV;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3560-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3560-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZNc9032Cz2yv2;
	Tue, 09 Jun 2026 19:18:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780996680;
	cv=none; b=VmYLFfNQQM4uQNswbq1j1Bo8IqBS0tjCz4DxPEBDyODNw+iLXcU2uVOhq9onRI8Ly7kt5NRdTv8iQHXYLcBkWGRQgqkqjJdQq1Pjq30PN1WTxSjrQrJWZKorgi3ewMF8LLJodz6tH0y1yqN8PIt3Y6Cr5GDFsd5++nyOnQB9rUFys771EUDQjIrrxPBtMWhDd3NVH51dnxuNqOEZbWCg8ojfYtfYu/QYy8P2AZ5E2s1h3rIxhlEdmJzoFeLjupLUS1vUF9xZWytvtMYPRRnaNqzdsb0ny2A5bEvlIwICvGm7gImMUAH/vIBCbPBOGvbWTFyyk9vKK8SLE0rcDKqCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780996680; c=relaxed/relaxed;
	bh=neT+DBNFdJVMXzpVfLBuoETHAOfTWkljT1jqTsQ2HPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu8ZbHm3Gkg1ygjv4OzrCNsohCppVaRxutmjQMneZ4vgEH0wTkmeIdGZLhSNQgxRxsVVle3uiqhotIE9e+vSxhuRZPV3yxCjkhZ9xNwSDBddHZ9BufM+esJXZUDOxq4fPsWo4pjdNX5XcaAztMaR84j3KkACvDz3j3ojZ7WtEMthAotJLkRot2lth/+Ck0c/qzfQaIkkpjIDVLTn5W/j1X3ZNZg1bW4CmqwDtuwGyWUAtjimPYKH9BpZnPUrPj+FqV7qQsY6IozL+Jip88PvZF0iYxHTFf3kv61+vOm+SpBL0q/3ObsGMASdNWLfLovQ8Z/4EHndIUVnOsYpcVvUug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PcOuyPSV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZNc74lyHz2xM7
	for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jun 2026 19:17:59 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2c27fc587ebso8010705ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jun 2026 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780996678; x=1781601478; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neT+DBNFdJVMXzpVfLBuoETHAOfTWkljT1jqTsQ2HPs=;
        b=PcOuyPSV6gBOrpR9CUlohWkEGyA5Yv7K4Tp0xtOCbeW8BxwsaJ9mU5Qe8C/mAfcXaY
         Xx8GI4ESEXu+k+oybBY5/2OWbida5qVDuByTdBDF8Vg53ZYKHetoachuXth1yNxwYzt/
         iNku55lzZVsqSVK+9izygDOOlCV/gScYdQDZV9UwTEJ9fUtkyyFcn+mjoIsSXfBX40gP
         2s4WST7IA3EvSSCT1OG5O9krXeCnf2ekxGbg9hyqP/lNwqIWUIwAsL5l89cIVceQczpz
         AhIkLGWjB/Ikz2IWF85S7G5ki49BHIwFIu7j5tWiQ5C9EqA4IivIuhmDQNwYVaOt/PMK
         976A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996678; x=1781601478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=neT+DBNFdJVMXzpVfLBuoETHAOfTWkljT1jqTsQ2HPs=;
        b=EycE7AvYJ4mlr1NSIqIyRRO8E0ItCWd70RwNR8kyZ8iONURSv1Jtmrw802cEqdBKlQ
         RfxpIpjXMcCHR6BYpjL9fSMAFhWNHIB8ccWiVRLwnPtqg5Omt4BpK9xBA06u7VbSGJBJ
         9Ag+ILGJOp/Cxoj7raY0wQF4M/poWimAdFDHLPvcm13MQhfQLS3Xj4uwJfkp0JvtcTY0
         DVn7X0/i2siFUQOrAgxJXrMTP+ktZb/A95yaP0il17vy8jRSh95JhX2VRGie82NCt2qS
         yseo4YS344qrgMZdjdQja9VRF3wdSqLByZ0i+D5mX7Y8UJXxzYdvQwHneLBDOcDwQZUa
         +3DA==
X-Forwarded-Encrypted: i=1; AFNElJ/SY00D3KcTInCVGzgRUw8EZmwZrCQEbtfdFvDj79X9x7DsVG3djlyV70mNC23RNxp1xJuaCfX6Z8ziwQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwiG3a22bzg09mDs2F1d6vA+2dodPoeNbfkoAqY9OBSL04vbHIt
	NwjBF23w5xBuIIjITK6pAhXsnhOfITIxNQ04U5Hga17HM3GU+I0p/8IH
X-Gm-Gg: Acq92OF+rmRcm1aiVqj/3g0gbFauzwdpHdg/ehvjodTg+EJPp128NDC7ldNaxjZ3GJW
	SQBcwxep03M4/mWOgL0NgQFhFQ4ChF3RJapWrQQ8q3DiLZTNmmpzwHhvFjdBwL17kzp6UpGzLSQ
	FAn2etFhABYU/M4WAh3V33MEdfUgWK5DGB72WYmsAiXUEjcnHqFqMAEVc8SdPKKChlZhh1ROgju
	/jpv9tMPreEJGXRJCpZI1X84IpcI5sCs741mA5KcAggxIfHhBziLvmrtTB+0uBBLpNXHZ31mSdA
	dN+6551HyDRG+qmGn8LZyFYTg/cGV6/wZ8sKqXljBMslMNP5jEb7MEKFE7rfmdfO2VXuc3mO1tL
	KU/o+cMtNae1f6D+IOtmKTRmF6YqGaSRCkCxbmIUCyemgiVBkW5X9C2Da3B1gDoVqc6auRfexX3
	2dyxtce9E3rzr+QRbRg0CZ9FEe694aj8z9kvQxVfktQSmglgAC9u8/p21v+1DCDR3TCQ==
X-Received: by 2002:a17:903:244d:b0:2bf:800:19f8 with SMTP id d9443c01a7336-2c1e7e500eamr204231865ad.17.1780996677527;
        Tue, 09 Jun 2026 02:17:57 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2e2sm201467005ad.49.2026.06.09.02.17.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 02:17:57 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v3 1/2] fsck.erofs: introduce multi-threaded decompression with static batching
Date: Tue,  9 Jun 2026 14:47:42 +0530
Message-ID: <20260609091743.71420-2-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3560-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9870965E383

Currently, fsck.erofs extracts files synchronously. When decompressing
heavily packed images (like LZ4HC with 4K pclusters), the main thread
spends the majority of its time blocked on a combination of synchronous
vfs_write() syscalls and LZ4_decompress_safe(), bottlenecking overall
extraction speed.

This patch introduces a scalable, multi-threaded decompression framework
using the existing erofs_workqueue infrastructure to decouple compute
from the main thread's I/O.

To prevent massive scheduling overhead (futex contention) where worker
threads spend more CPU time waking up than actually decompressing small
4KB clusters, this implementation introduces a batching context. The
main thread collects an array of sequential pclusters (temporarily hard-
capped at Z_EROFS_PCLUSTER_BATCH_SIZE = 32) before submitting a single
erofs_work unit.

Key details of this implementation:
- The worker pool is dynamically sized based on available system CPUs.
- Decompression tasks take strict ownership of the raw and output
  buffers (safely tracking memory via a `free_out` flag) to prevent
  data races and memory leaks.
- Output buffers are explicitly zero-initialized via calloc() to
  prevent trailing garbage bytes from leaking into extracted files.
- Tail-end packed fragments are processed synchronously by the main
  thread, as their minimal overhead does not benefit from asynchronous
  offloading.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c              | 150 ++++++++++++---------------
 include/erofs/cond.h     |  31 ++++++
 include/erofs/internal.h |  20 +++-
 include/erofs/lock.h     |   3 +
 lib/data.c               | 213 +++++++++++++++++++++++++++++----------
 5 files changed, 274 insertions(+), 143 deletions(-)
 create mode 100644 include/erofs/cond.h

diff --git a/fsck/main.c b/fsck/main.c
index 16cc627..ffe7e29 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -8,14 +8,18 @@
 #include <time.h>
 #include <utime.h>
 #include <unistd.h>
+#include "erofs/lock.h"
 #include <sys/stat.h>
 #include "erofs/print.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
 #include "erofs/xattr.h"
+#include "erofs/workqueue.h"
 #include "../lib/compressor.h"
 #include "../lib/liberofs_compress.h"
 
+extern struct erofs_workqueue erofs_wq;
+
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
 struct erofsfsck_dirstack {
@@ -505,44 +509,36 @@ out:
 
 static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 {
-	struct erofs_map_blocks map = {
-		.buf = __EROFS_BUF_INITIALIZER,
-	};
+	struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };
 	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
 	int ret = 0;
-	bool compressed;
+	bool compressed = erofs_inode_is_data_compressed(inode->datalayout);
 	erofs_off_t pos = 0;
 	u64 pchunk_len = 0;
-	unsigned int raw_size = 0, buffer_size = 0;
-	char *raw = NULL, *buffer = NULL;
 
-	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
-		  inode->nid | 0ULL, inode->datalayout);
+	struct z_erofs_read_ctx ctx = {
+		.pending_tasks = 0,
+		.final_err = 0,
+		.outfd = outfd,
+		.free_out = true,
+		.current_task = NULL
+	};
+	erofs_mutex_init(&ctx.lock);
+	erofs_cond_init(&ctx.cond);
 
-	compressed = erofs_inode_is_data_compressed(inode->datalayout);
-	while (pos < inode->i_size) {
-		unsigned int alloc_rawsize;
+	erofs_dbg("verify data chunk of nid(%llu): type(%d)", inode->nid | 0ULL, inode->datalayout);
 
+	while (pos < inode->i_size) {
 		map.m_la = pos;
 		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
-		if (ret)
-			goto out;
-
-		if (!compressed && map.m_llen != map.m_plen) {
-			erofs_err("broken chunk length m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
-				  map.m_la, map.m_llen, map.m_plen);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
+		if (ret) goto out;
 
-		/* the last lcluster can be divided into 3 parts */
 		if (map.m_la + map.m_llen > inode->i_size)
 			map.m_llen = inode->i_size - map.m_la;
 
 		pchunk_len += map.m_plen;
 		pos += map.m_llen;
 
-		/* should skip decomp? */
 		if (map.m_la >= inode->i_size || !needdecode)
 			continue;
 
@@ -555,85 +551,53 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			continue;
 		}
 
-		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
-			if (compressed && !(map.m_flags & __EROFS_MAP_FRAGMENT)) {
-				erofs_err("invalid pcluster size %" PRIu64 " @ offset %" PRIu64 " of nid %" PRIu64,
-					  map.m_plen, map.m_la,
-					  inode->nid | 0ULL);
-				ret = -EFSCORRUPTED;
-				goto out;
-			}
-			alloc_rawsize = Z_EROFS_PCLUSTER_MAX_SIZE;
-		} else {
-			alloc_rawsize = map.m_plen;
-		}
-
-		if (alloc_rawsize > raw_size) {
-			char *newraw = realloc(raw, alloc_rawsize);
-
-			if (!newraw) {
+		if (compressed) {
+			char *raw = malloc(map.m_plen);
+			size_t buffer_size = map.m_llen > erofs_blksiz(inode->sbi) ? map.m_llen : erofs_blksiz(inode->sbi);
+			char *buffer = calloc(1, buffer_size);
+			
+			if (!raw || !buffer) {
+				free(raw); free(buffer);
 				ret = -ENOMEM;
 				goto out;
 			}
-			raw = newraw;
-			raw_size = alloc_rawsize;
-		}
 
-		if (compressed) {
-			if (map.m_llen > buffer_size) {
-				char *newbuffer;
-
-				buffer_size = map.m_llen;
-				newbuffer = realloc(buffer, buffer_size);
-				if (!newbuffer) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				buffer = newbuffer;
-			}
-			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
-						    0, map.m_llen, false);
-			if (ret)
+			ret = z_erofs_read_one_data(inode, &map, raw, buffer, 0, map.m_llen, false, map.m_la, &ctx);
+			if (ret) {
+				/* DO NOT free(raw) or free(buffer) here. z_erofs_read_one_data took ownership! */
 				goto out;
-
-			if (outfd >= 0 && write(outfd, buffer, map.m_llen) < 0)
-				goto fail_eio;
+			}
 		} else {
-			u64 p = 0;
-
-			do {
-				u64 count = min_t(u64, alloc_rawsize,
-						  map.m_llen);
-
-				ret = erofs_read_one_data(inode, &map, raw, p, count);
-				if (ret)
-					goto out;
-
-				if (outfd >= 0 && write(outfd, raw, count) < 0)
-					goto fail_eio;
-				map.m_llen -= count;
-				p += count;
-			} while (map.m_llen);
+			char *raw = calloc(1, map.m_llen);
+			ret = erofs_read_one_data(inode, &map, raw, 0, map.m_llen);
+			if (ret >= 0 && outfd >= 0)
+				pwrite(outfd, raw, map.m_llen, map.m_la);
+			free(raw);
+			if (ret) goto out;
 		}
 	}
+	z_erofs_read_ctx_enqueue(&ctx);
+
+out:
+	erofs_mutex_lock(&ctx.lock);
+	while (ctx.pending_tasks > 0)
+		erofs_cond_wait(&ctx.cond, &ctx.lock);
+	if (ctx.final_err < 0 && ret >= 0)
+		ret = ctx.final_err;
+	erofs_mutex_unlock(&ctx.lock);
 
 	if (fsckcfg.print_comp_ratio) {
 		if (!erofs_is_packed_inode(inode))
 			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->sbi, inode->i_size);
 		fsckcfg.physical_blocks += BLK_ROUND_UP(inode->sbi, pchunk_len);
 	}
-out:
-	if (raw)
-		free(raw);
-	if (buffer)
-		free(buffer);
-	return ret < 0 ? ret : 0;
 
-fail_eio:
-	erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
-		  inode->nid | 0ULL);
-	ret = -EIO;
-	goto out;
+	if (outfd >= 0 && ret >= 0)
+		ftruncate(outfd, inode->i_size);
+	
+	erofs_mutex_destroy(&ctx.lock);
+	erofs_cond_destroy(&ctx.cond);
+	return ret < 0 ? ret : 0;
 }
 
 static inline int erofs_extract_dir(struct erofs_inode *inode)
@@ -1043,10 +1007,21 @@ int erofsfsck_fuzz_one(int argc, char *argv[])
 int main(int argc, char *argv[])
 #endif
 {
+
 	int err;
+#ifdef EROFS_MT_ENABLED
+	int workers;
+#endif
 
 	erofs_init_configure();
 
+#ifdef EROFS_MT_ENABLED
+	workers = erofs_get_available_processors();
+	if (workers < 1) 
+		workers = 1;
+	erofs_alloc_workqueue(&erofs_wq, workers, 256, NULL, NULL);
+#endif
+
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
 	fsckcfg.extract_path = NULL;
@@ -1181,6 +1156,9 @@ exit_dev_close:
 exit:
 	erofs_blob_closeall(&g_sbi);
 	erofs_exit_configure();
+#ifdef EROFS_MT_ENABLED
+	erofs_destroy_workqueue(&erofs_wq);
+#endif
 	return err ? 1 : 0;
 }
 
diff --git a/include/erofs/cond.h b/include/erofs/cond.h
new file mode 100644
index 0000000..90ec838
--- /dev/null
+++ b/include/erofs/cond.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_COND_H
+#define __EROFS_COND_H
+
+#include "lock.h"
+
+#if defined(HAVE_PTHREAD_H) && defined(EROFS_MT_ENABLED)
+#include <pthread.h>
+
+typedef pthread_cond_t erofs_cond_t;
+
+static inline void erofs_cond_init(erofs_cond_t *cond)
+{
+	pthread_cond_init(cond, NULL);
+}
+#define erofs_cond_wait		pthread_cond_wait
+#define erofs_cond_signal	pthread_cond_signal
+#define erofs_cond_broadcast	pthread_cond_broadcast
+#define erofs_cond_destroy	pthread_cond_destroy
+
+#else
+typedef struct {} erofs_cond_t;
+
+static inline void erofs_cond_init(erofs_cond_t *cond) {}
+static inline int erofs_cond_wait(erofs_cond_t *cond, erofs_mutex_t *mutex) { return 0; }
+static inline int erofs_cond_signal(erofs_cond_t *cond) { return 0; }
+static inline int erofs_cond_broadcast(erofs_cond_t *cond) { return 0; }
+static inline int erofs_cond_destroy(erofs_cond_t *cond) { return 0; }
+#endif
+
+#endif
\ No newline at end of file
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 671880f..b4db2e5 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -25,6 +25,8 @@ typedef unsigned short umode_t;
 #ifdef HAVE_PTHREAD_H
 #include <pthread.h>
 #endif
+#include <erofs/lock.h>
+#include "erofs/cond.h"
 #include <stdlib.h>
 #include <string.h>
 #include "atomic.h"
@@ -62,6 +64,7 @@ struct erofs_buf {
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
+#define Z_EROFS_PCLUSTER_BATCH_SIZE 32
 
 struct erofs_buffer_head;
 struct erofs_bufmgr;
@@ -442,6 +445,20 @@ struct z_erofs_paramset {
 	char *extraopts;
 };
 
+struct z_erofs_decompress_task;
+
+struct z_erofs_read_ctx {
+	erofs_mutex_t lock;
+	erofs_cond_t cond;
+	int pending_tasks;
+	int final_err;
+	int outfd;
+	bool free_out;
+	struct z_erofs_decompress_task *current_task;
+};
+
+void z_erofs_read_ctx_enqueue(struct z_erofs_read_ctx *ctx);
+
 int liberofs_global_init(void);
 void liberofs_global_exit(void);
 
@@ -478,7 +495,8 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
 			char *buffer, u64 offset, size_t len);
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed);
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx);
 void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
 			  erofs_off_t *offset, int *lengthp);
 int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb);
diff --git a/include/erofs/lock.h b/include/erofs/lock.h
index c6e3093..2e79d52 100644
--- a/include/erofs/lock.h
+++ b/include/erofs/lock.h
@@ -15,6 +15,7 @@ static inline void erofs_mutex_init(erofs_mutex_t *lock)
 }
 #define erofs_mutex_lock	pthread_mutex_lock
 #define erofs_mutex_unlock	pthread_mutex_unlock
+#define erofs_mutex_destroy	pthread_mutex_destroy
 
 #define EROFS_DEFINE_MUTEX(lock)	\
 	erofs_mutex_t lock = PTHREAD_MUTEX_INITIALIZER
@@ -29,12 +30,14 @@ static inline void erofs_init_rwsem(erofs_rwsem_t *lock)
 #define erofs_down_write	pthread_rwlock_wrlock
 #define erofs_up_read		pthread_rwlock_unlock
 #define erofs_up_write		pthread_rwlock_unlock
+
 #else
 typedef struct {} erofs_mutex_t;
 
 static inline void erofs_mutex_init(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_lock(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_unlock(erofs_mutex_t *lock) {}
+static inline void erofs_mutex_destroy(erofs_mutex_t *lock) {}
 
 #define EROFS_DEFINE_MUTEX(lock)	\
 	erofs_mutex_t lock = {}
diff --git a/lib/data.c b/lib/data.c
index 6fd1389..de05c6f 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,73 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 #include "liberofs_fragments.h"
+#include "erofs/workqueue.h"
+#include "erofs/lock.h"
+
+struct erofs_workqueue erofs_wq;
+
+struct z_erofs_decompress_item {
+	struct z_erofs_decompress_req req;
+	char *raw_buf;
+	char *out_buf;
+	erofs_off_t out_offset;
+	unsigned int out_length;
+};
+
+struct z_erofs_decompress_task {
+	struct erofs_work work;
+	struct z_erofs_read_ctx *ctx;
+	struct z_erofs_decompress_item items[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	unsigned int nr_reqs;
+};
+
+static void z_erofs_decompress_worker(struct erofs_work *work, void *tlsp)
+{
+	struct z_erofs_decompress_task *task = (struct z_erofs_decompress_task *)work;
+	struct z_erofs_read_ctx *ctx = task->ctx;
+	int i, ret = 0, first_err = 0;
+
+	for (i = 0; i < task->nr_reqs; ++i) {
+		struct z_erofs_decompress_item *item = &task->items[i];
+		ret = z_erofs_decompress(&item->req);
+
+		if (ret >= 0 && ctx && ctx->outfd >= 0) {
+			if (pwrite(ctx->outfd, item->out_buf,
+				   item->out_length, item->out_offset) < 0)
+				ret = -errno;
+		}
+
+		if (ret < 0 && first_err == 0)
+			first_err = ret;
+
+		free(item->raw_buf);
+		if (ctx && ctx->free_out)
+			free(item->out_buf);
+	}
+
+	if (ctx) {
+		erofs_mutex_lock(&ctx->lock);
+		if (first_err < 0 && ctx->final_err == 0)
+			ctx->final_err = first_err;
+		ctx->pending_tasks--;
+		if (ctx->pending_tasks == 0)
+			erofs_cond_signal(&ctx->cond);
+		erofs_mutex_unlock(&ctx->lock);
+	}
+	free(task);
+}
+
+void z_erofs_read_ctx_enqueue(struct z_erofs_read_ctx *ctx)
+{
+	if (ctx && ctx->current_task) {
+#ifdef EROFS_MT_ENABLED
+		erofs_queue_work(&erofs_wq, &ctx->current_task->work);
+#else
+		z_erofs_decompress_worker(&ctx->current_task->work, NULL);
+#endif
+		ctx->current_task = NULL;
+	}
+}
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
@@ -277,7 +344,8 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed)
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_dev mdev;
@@ -285,77 +353,104 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 
 	if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 		if (__erofs_unlikely(inode->nid == sbi->packed_nid)) {
-			erofs_err("fragment should not exist in the packed inode %llu",
-				  sbi->packed_nid | 0ULL);
-			return -EFSCORRUPTED;
+			ret = -EFSCORRUPTED;
+			goto err_out;
+		}
+		ret = erofs_packedfile_read(sbi, buffer, length - skip,
+					   inode->fragmentoff + skip);
+		
+		if (ret >= 0 && ctx && ctx->outfd >= 0) {
+			if (pwrite(ctx->outfd, buffer, length - skip, out_offset) < 0)
+				ret = -errno;
 		}
-		return erofs_packedfile_read(sbi, buffer, length - skip,
-				   inode->fragmentoff + skip);
+		goto err_out;
 	}
 
-	/* no device id here, thus it will always succeed */
-	mdev = (struct erofs_map_dev) {
-		.m_pa = map->m_pa,
-	};
+	mdev = (struct erofs_map_dev) { .m_pa = map->m_pa };
 	ret = erofs_map_dev(sbi, &mdev);
-	if (ret) {
-		DBG_BUGON(1);
-		return ret;
-	}
+	if (ret)
+		goto err_out;
 
 	ret = erofs_dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
 	if (ret < 0)
-		return ret;
+		goto err_out;
+	struct z_erofs_decompress_task *task = ctx->current_task;
+	if (!task) {
+		task = calloc(1, sizeof(*task));
+		task->ctx = ctx;
+		task->work.fn = z_erofs_decompress_worker;
+		ctx->current_task = task;
+
+		erofs_mutex_lock(&ctx->lock);
+		ctx->pending_tasks++;
+		erofs_mutex_unlock(&ctx->lock);
+	}
 
-	ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
-			.sbi = sbi,
-			.in = raw,
-			.out = buffer,
-			.decodedskip = skip,
-			.interlaced_offset =
-				map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
-					erofs_blkoff(sbi, map->m_la) : 0,
-			.inputsize = map->m_plen,
-			.decodedlength = length,
-			.alg = map->m_algorithmformat,
-			.partial_decoding = trimmed ? true :
-				!(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
-					(map->m_flags & EROFS_MAP_PARTIAL_REF),
-			 });
-	if (ret < 0)
-		return ret;
+	int idx = task->nr_reqs++;
+	struct z_erofs_decompress_item *item = &task->items[idx];
+
+	item->req = (struct z_erofs_decompress_req) {
+		.sbi = sbi,
+		.in = raw,
+		.out = buffer,
+		.decodedskip = skip,
+		.interlaced_offset =
+			map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
+				erofs_blkoff(sbi, map->m_la) : 0,
+		.inputsize = map->m_plen,
+		.decodedlength = length,
+		.alg = map->m_algorithmformat,
+		.partial_decoding = trimmed ? true :
+			!(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
+				(map->m_flags & EROFS_MAP_PARTIAL_REF),
+	};
+	item->raw_buf = raw;
+	item->out_buf = buffer;
+	item->out_offset = out_offset;
+	item->out_length = length;
+
+	if (task->nr_reqs == Z_EROFS_PCLUSTER_BATCH_SIZE) {
+		z_erofs_read_ctx_enqueue(ctx);
+	}
 	return 0;
+
+err_out:
+	if (ctx && ctx->free_out) free(buffer);
+	free(raw);
+	return ret;
 }
 
 static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
-			     erofs_off_t size, erofs_off_t offset)
+				 erofs_off_t size, erofs_off_t offset)
 {
 	erofs_off_t end, length, skip;
 	struct erofs_map_blocks map = {
 		.buf = __EROFS_BUF_INITIALIZER,
 	};
 	bool trimmed;
-	unsigned int bufsize = 0;
-	char *raw = NULL;
 	int ret = 0;
 
+	struct z_erofs_read_ctx ctx = {
+		.pending_tasks = 0,
+		.final_err = 0,
+		.outfd = -1,
+		.free_out = false,
+		.current_task = NULL
+	};
+	erofs_mutex_init(&ctx.lock);
+	erofs_cond_init(&ctx.cond);
+
 	end = offset + size;
 	while (end > offset) {
 		map.m_la = end - 1;
 
 		ret = z_erofs_map_blocks_iter(inode, &map, 0);
-		if (ret)
-			break;
+		if (ret) break;
 
-		/*
-		 * trim to the needed size if the returned extent is quite
-		 * larger than requested, and set up partial flag as well.
-		 */
 		if (end < map.m_la + map.m_llen) {
 			length = end - map.m_la;
 			trimmed = true;
 		} else {
-			DBG_BUGON(end != map.m_la + map.m_llen);
 			length = map.m_llen;
 			trimmed = false;
 		}
@@ -374,25 +469,31 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
-		if (map.m_plen > bufsize) {
-			char *newraw;
-
-			bufsize = map.m_plen;
-			newraw = realloc(raw, bufsize);
-			if (!newraw) {
-				ret = -ENOMEM;
-				break;
-			}
-			raw = newraw;
+		char *raw = malloc(map.m_plen);
+		if (!raw) {
+			ret = -ENOMEM;
+			break;
 		}
 
 		ret = z_erofs_read_one_data(inode, &map, raw,
-				buffer + end - offset, skip, length, trimmed);
-		if (ret < 0)
+				buffer + end - offset, skip, length, trimmed, 0, &ctx);
+		if (ret < 0) {
 			break;
+		}
 	}
-	if (raw)
-		free(raw);
+	z_erofs_read_ctx_enqueue(&ctx);
+
+	erofs_mutex_lock(&ctx.lock);
+	while (ctx.pending_tasks > 0)
+		erofs_cond_wait(&ctx.cond, &ctx.lock);
+	
+	if (ctx.final_err < 0 && ret == 0)
+		ret = ctx.final_err;
+
+	erofs_mutex_unlock(&ctx.lock);
+	erofs_mutex_destroy(&ctx.lock);
+	erofs_cond_destroy(&ctx.cond);
+
 	return ret < 0 ? ret : 0;
 }
 
-- 
2.52.0


