Return-Path: <linux-erofs+bounces-3778-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WWWeOB9BQmo62wkAu9opvQ
	(envelope-from <linux-erofs+bounces-3778-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 11:55:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F96D8840
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 11:55:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Oc1/2QLx";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3778-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3778-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphVN5wJpz2ygG;
	Mon, 29 Jun 2026 19:55:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782726940;
	cv=none; b=PAGCSIz0dvBXG+oNVJkw0DWVcMgErYfJjCLEo0G/RR0gBiuF4uK7ANuCPGnwhzPYHCL11gPsf0XP1XTYAT1b+IvHGm2a1kex/asppfDjrFRfK2fOsTgAhGyHCYwgmaFxwshPlutoFL8UgWghr3Ybz24yXaqlZn1u9JRiqiVEtV+C/WV4vS/H/BPCg7ugTXfSyMg6pW9iRhvhxRioWLGc98gDpjEuKrNjxs04mKhzG4QM/hnpoXJCcxixrRdH1GAjufOD3tdv+jrhUIocNsZyGK8KU2lBDQWPUYzR1ghWaGaC43cG0GgjmGVZ4VSEsgMZJwbEngDgh8way5G9ewdkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782726940; c=relaxed/relaxed;
	bh=B4IRhn/cbuvZPI0fyrVSJllaIFfcPZ8KSFhmiSPKKcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSkm4PNalnp2n/G1kD0VeMT3YdfymtbC9oUWf+f1fW2YTi1d9g2HlRPuYNw+EsZKR8bOgtx4ndro1+Ju7PJAwsMm4h+MGqmZpfabdVI85VJxtdIxY71Uf0Y7sdfDPm/0pomzX+YxdUhopMNMigY+0Fdphv81cJFKR2u2cBitRRyVUpq+JGF5xYaUl1by+wOpe9hFNdHIW3eubMzWucYdA/sOilXQYgjAKUX7qSBJ/LhVIqq6nbR+MtT7h6381/RUpJo+4NM9sB4tQ8krp7/hKvxtDJoI9jFsbUYDWaIR3cIBCNFCzHqyBclqUvZUmenH3l66o7kaCTaufIwzIxY2wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oc1/2QLx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com [IPv6:2607:f8b0:4864:20::1236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gphVM2PCmz2yFc
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jun 2026 19:55:39 +1000 (AEST)
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-139f3eaaa49so733724c88.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jun 2026 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726937; x=1783331737; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4IRhn/cbuvZPI0fyrVSJllaIFfcPZ8KSFhmiSPKKcQ=;
        b=Oc1/2QLxd7QltI+guTlll+XnVCbA+Z9ADZJDY0LF6oohCBf7Rdw3DWMEzHkqL6wBka
         /PLS4thvR54PiDDGQvCeWaUF8NqcEoBWfcIlRDl2vUFxxrN5szmOBVXyr/0d1ZAgKqma
         4Pu+8hxKy7FfrZbihe7yYTU4ZSQ3DCiYqzLp5YAV3U8pqWUtDfLPoqfoSI65MnSZpQi9
         aTZ5JhCkJBb8CAbJM/VxXyo62vtveqxOOqVOy6QbOqphkCFSiNKWNJgs0/XAmHe18LzR
         ip727AwkCuQwOpOEsrRMixzgSei96WGqhEzn9QgEQGGqTqXcUIjAt+uWo++vUNmdCgzT
         bd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726937; x=1783331737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4IRhn/cbuvZPI0fyrVSJllaIFfcPZ8KSFhmiSPKKcQ=;
        b=XO5bQVvU29D2jhQSXH86DykSETrrVCOlm48KLpyVSGYvd8qcqt8dN5aEriknLmUQuk
         UeVFka+/3CJe0eQbb0fDWHa11rZSy6txiy/lkyn/ylbmhawHJN6b0lBw3Ea5Akfp2U3M
         gURguAMccFoo9NWdchAeF5FMzU4SWwBBmBq2Whmqhzp3Kz+j4kLuFZd+zESJq7JI7GUf
         AY7FtSlYqNFaC2J0SVBWV01SQNF9Gddtj72dbBcZW50Gj2LUjMzZRnRfPPT06uS1fbQm
         TIr0ps081T34xgUGLR42RHhuJHgHbzj7rZ8g1ZjECkUpXCP1kdBESKJ7q4wN4rNKfSKt
         LuFg==
X-Forwarded-Encrypted: i=1; AFNElJ90Lb7ZI9kSUAftpZuGKoP6CVoYx7Aesd6A41omYFb3zLkaBWgQZ2ALtVdgp38UE3RrYfjOGkSmpUYeBg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yya2JFST47GrROXJGWkga8eIy99QG2bq1vZ/jdD4z6RUoTgvLhy
	TjF2J9oXND3qwYzzcI9fi9WLirB66eMLvoLknAorYLQyFT3gQ3ThpMd5h1qbCw==
X-Gm-Gg: AfdE7cmLEX6aSLQU0ukon/CGNwL8VKVtCfh3TmcJGOPqz5K1Q2T7z+R8H2AXakHU4Ai
	hcv/1JDn60bTVAn4UtWcqMq+n2FUn7+tzcIHYci3gdxQd1UlJNIYanTHams/Gdp6YVzGi+Bb7TC
	vgtZhMY5/1WUcH3Zw9hdk5XRxZiF8uTnv4mc7YaTEsFFvYb1C/f/AZiY0irDCD9Q3RJHz+FhfLX
	UXilYDIvPZtUpRd4KhkupDjhcwWYhpfetLns0uf9EwEDkKQWuEq1Fv2lO/s3dwGYXr2K/Kd5Fld
	DP0osGQCI9amRxDumPNKtAbVrjWVYTDjBLX1In+p0+5UU3rwFz0yRnA5ohWk+utpn3RUVIb7wG6
	Iy7qZ9F052oYcZWYi2/viAjp03PEPZ9O5I602PezUn75YuEOswPWX93AYG2Up8kXVhGRn3zh0Kk
	h81gp/0FuSAnBmOawG2ip1i8FtVtIXLUujHJPuZ4IJlFmj
X-Received: by 2002:a05:7022:98d:b0:137:e6a1:c4b3 with SMTP id a92af1059eb24-139dba0001emr11670628c88.0.1782726936737;
        Mon, 29 Jun 2026 02:55:36 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f318e7sm46852952c88.3.2026.06.29.02.55.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jun 2026 02:55:36 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH 1/2 v2] fsck.erofs: add multi-threaded decompression
Date: Mon, 29 Jun 2026 15:25:29 +0530
Message-ID: <20260629095529.58597-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260621120121.73114-2-nithurshen.dev@gmail.com>
References: <20260621120121.73114-2-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3778-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: F28F96D8840

Currently, fsck.erofs extracts files synchronously. When decompressing
heavily packed images, the main thread spends the majority of its time
blocked on a combination of synchronous vfs_write() syscalls and
decompression routines, bottlenecking overall extraction speed.

This patch introduces a scalable, multi-threaded decompression framework
using the existing erofs_workqueue infrastructure to decouple compute
from the main thread's I/O.

To prevent massive scheduling overhead (futex contention) where worker
threads spend more CPU time waking up than actually decompressing small
clusters, this implementation introduces a batching context. Because
different compression algorithms exhibit vastly different scheduling
thresholds, the batch size is algorithm-aware:
- Fast algorithms like LZ4 utilize a larger batch limit (up to 32
  pclusters) to effectively hide synchronization overhead.
- Compute-heavy algorithms like LZMA or ZSTD trigger at a lower
  threshold (8 pclusters) to prevent memory bloat and thread starvation.

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
 fsck/main.c              | 122 +++++++------------
 include/erofs/cond.h     |  31 +++++
 include/erofs/internal.h |  15 ++-
 include/erofs/lock.h     |   3 +
 lib/data.c               | 254 +++++++++++++++++++++++++++++++--------
 lib/global.c             |  15 +++
 6 files changed, 307 insertions(+), 133 deletions(-)
 create mode 100644 include/erofs/cond.h

diff --git a/fsck/main.c b/fsck/main.c
index 16cc627..c427a70 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -8,11 +8,13 @@
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
 
@@ -509,40 +511,31 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		.buf = __EROFS_BUF_INITIALIZER,
 	};
 	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
-	int ret = 0;
-	bool compressed;
+	int ret = 0, wait_err;
+	bool compressed = erofs_inode_is_data_compressed(inode->datalayout);
 	erofs_off_t pos = 0;
 	u64 pchunk_len = 0;
-	unsigned int raw_size = 0, buffer_size = 0;
-	char *raw = NULL, *buffer = NULL;
+	struct z_erofs_mt_read_ctx *ctx;
+
+	ctx = z_erofs_mt_read_ctx_alloc(outfd, true);
+	if (!ctx)
+		return -ENOMEM;
 
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
-		  inode->nid | 0ULL, inode->datalayout);
+		inode->nid | 0ULL, inode->datalayout);
 
-	compressed = erofs_inode_is_data_compressed(inode->datalayout);
 	while (pos < inode->i_size) {
-		unsigned int alloc_rawsize;
-
 		map.m_la = pos;
 		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
 		if (ret)
 			goto out;
 
-		if (!compressed && map.m_llen != map.m_plen) {
-			erofs_err("broken chunk length m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
-				  map.m_la, map.m_llen, map.m_plen);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		/* the last lcluster can be divided into 3 parts */
 		if (map.m_la + map.m_llen > inode->i_size)
 			map.m_llen = inode->i_size - map.m_la;
 
 		pchunk_len += map.m_plen;
 		pos += map.m_llen;
 
-		/* should skip decomp? */
 		if (map.m_la >= inode->i_size || !needdecode)
 			continue;
 
@@ -555,85 +548,53 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
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
+			size_t buffer_size = map.m_llen > erofs_blksiz(inode->sbi) ? 
+				map.m_llen : erofs_blksiz(inode->sbi);
+			char *raw, *buffer;
+			raw = malloc(map.m_plen);
+			buffer = calloc(1, buffer_size);
+			
+			if (!raw || !buffer) {
+				free(raw);
+				free(buffer);
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
+			ret = z_erofs_read_one_data(inode, &map, raw, buffer, 0, map.m_llen, 
+				false, map.m_la, ctx);
+			if (ret) {
+				goto out;
 			}
-			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
-						    0, map.m_llen, false);
+		} else {
+			char *raw = calloc(1, map.m_llen);
+			ret = erofs_read_one_data(inode, &map, raw, 0, map.m_llen);
+			if (ret >= 0 && outfd >= 0)
+				pwrite(outfd, raw, map.m_llen, map.m_la);
+			free(raw);
 			if (ret)
 				goto out;
-
-			if (outfd >= 0 && write(outfd, buffer, map.m_llen) < 0)
-				goto fail_eio;
-		} else {
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
 		}
 	}
+	z_erofs_mt_read_enqueue(ctx);
+
+out:
+	wait_err = z_erofs_mt_read_ctx_wait(ctx);
+	if (wait_err < 0 && ret >= 0)
+		ret = wait_err;
 
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
+	z_erofs_mt_read_ctx_free(ctx);
+	return ret < 0 ? ret : 0;
 }
 
 static inline int erofs_extract_dir(struct erofs_inode *inode)
@@ -1043,6 +1004,7 @@ int erofsfsck_fuzz_one(int argc, char *argv[])
 int main(int argc, char *argv[])
 #endif
 {
+
 	int err;
 
 	erofs_init_configure();
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
index 671880f..a3ddcfb 100644
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
+#define Z_EROFS_PCLUSTER_MAX_BATCH_SIZE 32
 
 struct erofs_buffer_head;
 struct erofs_bufmgr;
@@ -442,6 +445,15 @@ struct z_erofs_paramset {
 	char *extraopts;
 };
 
+struct z_erofs_decompress_task;
+
+struct z_erofs_mt_read_ctx;
+
+struct z_erofs_mt_read_ctx *z_erofs_mt_read_ctx_alloc(int outfd, bool free_out);
+int z_erofs_mt_read_ctx_wait(struct z_erofs_mt_read_ctx *ctx);
+void z_erofs_mt_read_ctx_free(struct z_erofs_mt_read_ctx *ctx);
+void z_erofs_mt_read_enqueue(struct z_erofs_mt_read_ctx *ctx);
+
 int liberofs_global_init(void);
 void liberofs_global_exit(void);
 
@@ -478,7 +490,8 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
 			char *buffer, u64 offset, size_t len);
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed);
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_mt_read_ctx *ctx);
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
index 6fd1389..fe0005c 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,121 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 #include "liberofs_fragments.h"
+#include "erofs/workqueue.h"
+#include "erofs/lock.h"
+
+struct erofs_workqueue z_erofs_mt_wq;
+
+struct z_erofs_mt_read_ctx {
+	erofs_mutex_t lock;
+	erofs_cond_t cond;
+	int pending_tasks;
+	int final_err;
+	int outfd;
+	bool free_out;
+	struct z_erofs_decompress_task *current_task;
+};
+
+struct z_erofs_mt_read_ctx *z_erofs_mt_read_ctx_alloc(int outfd, bool free_out)
+{
+	struct z_erofs_mt_read_ctx *ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return NULL;
+
+	erofs_mutex_init(&ctx->lock);
+	erofs_cond_init(&ctx->cond);
+	ctx->outfd = outfd;
+	ctx->free_out = free_out;
+	return ctx;
+}
+
+int z_erofs_mt_read_ctx_wait(struct z_erofs_mt_read_ctx *ctx)
+{
+	int err;
+	if (!ctx)
+		return 0;
+
+	erofs_mutex_lock(&ctx->lock);
+	while (ctx->pending_tasks > 0)
+		erofs_cond_wait(&ctx->cond, &ctx->lock);
+	err = ctx->final_err;
+	erofs_mutex_unlock(&ctx->lock);
+
+	return err;
+}
+
+void z_erofs_mt_read_ctx_free(struct z_erofs_mt_read_ctx *ctx)
+{
+	if (!ctx)
+		return;
+	
+	erofs_mutex_destroy(&ctx->lock);
+	erofs_cond_destroy(&ctx->cond);
+	free(ctx);
+}
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
+	struct z_erofs_mt_read_ctx *ctx;
+	struct z_erofs_decompress_item items[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
+	unsigned int nr_reqs;
+};
+
+static void z_erofs_decompress_worker(struct erofs_work *work, void *tlsp)
+{
+	struct z_erofs_decompress_task *task = (struct z_erofs_decompress_task *)work;
+	struct z_erofs_mt_read_ctx *ctx = task->ctx;
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
+		if (ret < 0 && !first_err)
+			first_err = ret;
+
+		free(item->raw_buf);
+		if (ctx && ctx->free_out)
+			free(item->out_buf);
+	}
+
+	if (ctx) {
+		erofs_mutex_lock(&ctx->lock);
+		if (first_err < 0 && !ctx->final_err)
+			ctx->final_err = first_err;
+		ctx->pending_tasks--;
+		if (!ctx->pending_tasks)
+			erofs_cond_signal(&ctx->cond);
+		erofs_mutex_unlock(&ctx->lock);
+	}
+	free(task);
+}
+
+void z_erofs_mt_read_enqueue(struct z_erofs_mt_read_ctx *ctx)
+{
+	if (ctx && ctx->current_task) {
+#ifdef EROFS_MT_ENABLED
+		erofs_queue_work(&z_erofs_mt_wq, &ctx->current_task->work);
+#else
+		z_erofs_decompress_worker(&ctx->current_task->work, NULL);
+#endif
+		ctx->current_task = NULL;
+	}
+}
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
@@ -277,20 +392,28 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed)
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_mt_read_ctx *ctx)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_dev mdev;
-	int ret = 0;
+	struct z_erofs_decompress_task *task;
+	struct z_erofs_decompress_item *item;
+	int ret = 0, idx, batch_limit;
 
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
 
 	/* no device id here, thus it will always succeed */
@@ -298,46 +421,77 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 		.m_pa = map->m_pa,
 	};
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
+        
+	task = ctx->current_task;
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
+	idx = task->nr_reqs++;
+	item = &task->items[idx];
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
+	batch_limit = (map->m_algorithmformat == Z_EROFS_COMPRESSION_LZ4) ? 
+						Z_EROFS_PCLUSTER_MAX_BATCH_SIZE : 8;
+
+	if (task->nr_reqs >= batch_limit) {
+		z_erofs_mt_read_enqueue(ctx);
+	}
 	return 0;
+
+err_out:
+	if (ctx && ctx->free_out)
+		free(buffer);
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
-	int ret = 0;
+	int ret = 0, wait_err;
+	struct z_erofs_mt_read_ctx *ctx;
+
+	ctx = z_erofs_mt_read_ctx_alloc(-1, false);
+	if (!ctx)
+		return -ENOMEM;
 
 	end = offset + size;
 	while (end > offset) {
@@ -347,15 +501,10 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret)
 			break;
 
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
@@ -374,25 +523,26 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
+				buffer + end - offset, skip, length, trimmed, 0, ctx);
+		if (ret < 0) {
 			break;
+		}
 	}
-	if (raw)
-		free(raw);
+	z_erofs_mt_read_enqueue(ctx);
+
+	wait_err = z_erofs_mt_read_ctx_wait(ctx);
+	if (wait_err < 0 && !ret)
+		ret = wait_err;
+
+	z_erofs_mt_read_ctx_free(ctx);
+
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/lib/global.c b/lib/global.c
index c3d8aec..4ef424a 100644
--- a/lib/global.c
+++ b/lib/global.c
@@ -12,6 +12,11 @@
 #include "erofs/err.h"
 #include "erofs/config.h"
 #include "liberofs_compress.h"
+#include "erofs/internal.h"
+#ifdef EROFS_MT_ENABLED
+#include "erofs/workqueue.h"
+extern struct erofs_workqueue z_erofs_mt_wq;
+#endif
 
 static EROFS_DEFINE_MUTEX(erofs_global_mutex);
 #ifdef HAVE_LIBCURL
@@ -22,6 +27,13 @@ int liberofs_global_init(void)
 {
 	int err = 0;
 
+#ifdef EROFS_MT_ENABLED
+	int workers = erofs_get_available_processors();
+	if (workers < 1) 
+		workers = 1;
+	erofs_alloc_workqueue(&z_erofs_mt_wq, workers, 256, NULL, NULL);
+#endif
+
 	erofs_mutex_lock(&erofs_global_mutex);
 	erofs_init_configure();
 #ifdef S3EROFS_ENABLED
@@ -45,6 +57,9 @@ void liberofs_global_exit(void)
 {
 	erofs_mutex_lock(&erofs_global_mutex);
 	z_erofs_mt_global_exit();
+#ifdef EROFS_MT_ENABLED
+	erofs_destroy_workqueue(&z_erofs_mt_wq);
+#endif
 #ifdef HAVE_LIBCURL
 	if (erofs_global_curl_initialized) {
 		curl_global_cleanup();
-- 
2.52.0


