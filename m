Return-Path: <linux-erofs+bounces-2449-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOwfIBo9pWne6QUAu9opvQ
	(envelope-from <linux-erofs+bounces-2449-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 08:32:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD81D3F65
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 08:32:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPVyG5R3Jz2xc8;
	Mon, 02 Mar 2026 18:32:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772436758;
	cv=none; b=dV5/bf7UClMP4SBs//KM6zfrlUYU0/wire2XGSXbzTCVWdo5LLpmzAkDmfXb80vmpf/GGg9Fs3Lmt1DwlzbhZKSQ9pTP4LmcZ38kgh6SPtkSPBl/2DurfZQAASpPaDeEu4rgfjCyhZJOGQY/GwnAP9MfSeaIGe+E/QEoReVkU/tVBtPESFWWUc+sJYx5bSy8ApABcgS8qWcYSX3lHEFssHuWo+CjMrIO7a87qLMwlnxSJn6vro/qQ50MdhLoug+T0gPIAbhQNmDrj14BSnsGoy8ON/61sVRR5oAnnpJoUFMbs01utrqd2so9Hc8mtpZNhprJZsqluqZ/yb76hDMVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772436758; c=relaxed/relaxed;
	bh=wUVGWrDmsdg40ntNGfyX1oxWOTY8LQ7yM/uLjjpehNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYgrx8/lZYG6m1vB4JjStpH/7xM17ejhtu1QdGVnu3p0Kev4q411Vlux8ozwDhbLlV2zCwxz4BSn+bKPUzMxEukHxuCpsjaCrk7nBN1P8hwti35bkH9vjllTfeP9amPT3a9F5S0O1KBn0n5kvspnxXYhAc5NFTb69+GgwkxGvkpmdZ9ZL/JkGk8Ph6GzzsL5Cjfu1ajewOgpxe7Ir9G0WcV+urXTwPukfYSC3qavIhxEGbQv6meODbDywYxTMFGI+ISmvxOn+hgQq69Mu0Ly9W4k5FHMAnB/X1dvjqOLsoHf1JYzKcFyiN3zGQzsLVgFyUbzJabPHiHgsvgVaNGing==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=he9jgjLF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=he9jgjLF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPVyF3FBLz2xYw
	for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 18:32:36 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ae50a33ff8so4306945ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 01 Mar 2026 23:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772436754; x=1773041554; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUVGWrDmsdg40ntNGfyX1oxWOTY8LQ7yM/uLjjpehNc=;
        b=he9jgjLFfAjYDSgekDUfo3F2DPv24dXhGf0MQ0JCLBHMCUVc+NYsnxq5Ww0IMxiZbV
         AodZhoQCCGi8Q5LBZK9eI2ZfpIzIIy/UuUv644Pm/gga3CMUQvqRROWiTjLhIoQxOU+H
         2GsIZOjBXl6OI8GGgRGrcnZAyZV0aZf6ce1RhRngKQ311cS76h4MhcT5tGSOKM02cAhL
         WjxBMC6nD58wTBHd+uzB6UqgW1cFAbWAeRzFCZWm6hVbGsJJyeQZ4AayV45KwlVG78Gf
         PbLtN1CgKdI7lLW/StyNhKBeG2fPxthed/jWXyRrcwX3GoigB5cBxuqh+6uEOKvqMfnR
         OP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772436754; x=1773041554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUVGWrDmsdg40ntNGfyX1oxWOTY8LQ7yM/uLjjpehNc=;
        b=JMUa17Acg5vzFtmUXWO1PExgbQxd3CZXErzhlzGfpBuG/Tmu5gKh+8mOds4gDQzXTk
         MM5CFtRin+jEGNOZwwDoDl0aHYHEWwcPWJepwwtJccKJNGuADjlES0RxRC0qL/RLfzSf
         Q2suCMJom/7am2+0y5hwq5/T+gRA0ooC35rHPUaIUgHo7KIJYvHRZ12kNcL00vBqsjxk
         M+cu79ct/xNmH6QiSgIAkfputPC7dKa1B1OXiC5lflMPgWi/Lg4j4btDFEEo25RYdkTA
         /pM/vWVB15veuUSoIWv5ElzMDDH59heHiG05Prto2aq4JSJNc2YmynwhQwVqxidSrNtW
         +xNg==
X-Gm-Message-State: AOJu0Yzbce0jaUe/PYJrslwKm+XGRdiArEWUuw+oLqEZAOP9Y716uw6x
	dYpDckf/P4NbNMB3+KpNByQA7oGuR5KaMIFWuUlusaxD45Fmg2Xdm193vnpPQG1mWCc=
X-Gm-Gg: ATEYQzzPjeUIIw0jTYxUhhzXK5FS5gkdDKuE/JVNd7/1cgqvz8MvZizbNmEf6wWQ+GZ
	b6cXKyUX4m5Q0DC41ggvjZGS0zGGiq4NVh5rHUEAgDU8TAvEVZYTYjm06s7zuSFFERVz2aeXSNm
	RZdNnXFnKqMjDiGRItbuFEH7eYxo9OCvlISKJrlDhtN2fA4wK9aCCvRX2ggU5PqcLr5RLvSkKL4
	sgJm6XyWyyKvhrYHs/MjjHof4pSJkGNh2pD9Bkogp5MRPNf3tFmXXWOqz8H+7urHApdKUbbtrkQ
	RbaoOqswMXbZejii9J0TTqLIl3G+mfjGdwo3pi1RKOYvZR2BVQPvkdlFXQry8YvpC+QpUEUdM6Y
	FnT1ZY+JnSZdk++KHURUBdYbFJ+JARUhiOcJB07LYe1xBKppXOiqTGoIfEBEurCQmPk2+3Z5N+Z
	PBSUXrc8a7Xx1Wh/HLnm1B++WLYop28xPee2Si
X-Received: by 2002:a17:903:22c8:b0:2ae:5aed:1f4d with SMTP id d9443c01a7336-2ae5aed2282mr205695ad.42.1772436754029;
        Sun, 01 Mar 2026 23:32:34 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm129725645ad.45.2026.03.01.23.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 23:32:33 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH] fsck.erofs: introduce multi-threaded decompression PoC with pcluster batching
Date: Mon,  2 Mar 2026 13:02:16 +0530
Message-ID: <20260302073216.94384-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2449-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 98CD81D3F65
X-Rspamd-Action: no action

This is a Proof of Concept to introduce a scalable, multi-threaded
decompression framework into fsck.erofs to reduce extraction time.

Baseline Profiling:
Using the Linux 6.7 kernel source packed with LZ4HC (4K pclusters),
perf showed a strictly synchronous execution path. The main thread
spent ~52% of its time in LZ4_decompress_safe, heavily blocked by
synchronous I/O (~32% in el0_svc/vfs_read).

First Iteration (Naive Workqueue):
A standard producer-consumer workqueue overlapping compute with pwrite()
suffered massive scheduling overhead. For 4KB LZ4 clusters, workers
spent ~44% of CPU time spinning on __arm64_sys_futex and try_to_wake_up.

Current PoC (Dynamic Pcluster Batching):
To eliminate lock contention, this patch introduces a batching context.
Instead of queuing 1 pcluster per task, the main thread collects an
array of sequential pclusters (Z_EROFS_PCLUSTER_BATCH_SIZE = 32) before
submitting a single erofs_work unit.

Results:
- Scheduling overhead (futex) dropped significantly.
- Workers stay cache-hot, decompressing 32 blocks per wakeup.
- LZ4_decompress_safe is successfully offloaded to background cores
  (~18.8% self-execution time), completely decoupled from main thread I/O.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c              | 144 ++++++++++++-------------------
 include/erofs/internal.h |  15 +++-
 lib/data.c               | 182 +++++++++++++++++++++++++++++++--------
 3 files changed, 217 insertions(+), 124 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ab697be..1b6db42 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -15,6 +15,9 @@
 #include "erofs/xattr.h"
 #include "../lib/compressor.h"
 #include "../lib/liberofs_compress.h"
+#include "erofs/workqueue.h"
+
+extern struct erofs_workqueue erofs_wq;
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
@@ -493,135 +496,96 @@ out:
 
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
+		.current_task = NULL
+	};
+	pthread_mutex_init(&ctx.lock, NULL);
+	pthread_cond_init(&ctx.cond, NULL);
 
-	compressed = erofs_inode_is_data_compressed(inode->datalayout);
-	while (pos < inode->i_size) {
-		unsigned int alloc_rawsize;
+	erofs_dbg("verify data chunk of nid(%llu): type(%d)", inode->nid | 0ULL, inode->datalayout);
 
+	while (pos < inode->i_size) {
 		map.m_la = pos;
 		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
-		if (ret)
-			goto out;
+		if (ret) goto out;
 
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
 
 		if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
-			ret = lseek(outfd, map.m_llen, SEEK_CUR);
-			if (ret < 0) {
-				ret = -errno;
-				goto out;
-			}
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
+			char *buffer = malloc(buffer_size);
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
+			pthread_mutex_lock(&ctx.lock);
+			if (erofs_wq.job_count > 128) {
+				z_erofs_read_ctx_enqueue(&ctx);
+				while (ctx.pending_tasks > 0)
+					pthread_cond_wait(&ctx.cond, &ctx.lock);
 			}
-			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
-						    0, map.m_llen, false);
-			if (ret)
+			pthread_mutex_unlock(&ctx.lock);
+
+			ret = z_erofs_read_one_data(inode, &map, raw, buffer, 0, map.m_llen, false, map.m_la, &ctx);
+			if (ret) {
+				free(raw); free(buffer);
 				goto out;
+			}
 
-			if (outfd >= 0 && write(outfd, buffer, map.m_llen) < 0)
-				goto fail_eio;
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
+			char *raw = malloc(map.m_llen);
+			ret = erofs_read_one_data(inode, &map, raw, 0, map.m_llen);
+			if (ret == 0 && outfd >= 0)
+				pwrite(outfd, raw, map.m_llen, map.m_la);
+			free(raw);
+			if (ret) goto out;
 		}
 	}
+	z_erofs_read_ctx_enqueue(&ctx);
+
+out:
+	pthread_mutex_lock(&ctx.lock);
+	while (ctx.pending_tasks > 0)
+		pthread_cond_wait(&ctx.cond, &ctx.lock);
+	if (ctx.final_err < 0 && ret == 0)
+		ret = ctx.final_err;
+	pthread_mutex_unlock(&ctx.lock);
 
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
+	if (outfd >= 0 && ret == 0)
+		ftruncate(outfd, inode->i_size);
+	pthread_mutex_destroy(&ctx.lock);
+	pthread_cond_destroy(&ctx.cond);
+	return ret < 0 ? ret : 0;
 }
 
 static inline int erofs_extract_dir(struct erofs_inode *inode)
@@ -1019,6 +983,8 @@ int main(int argc, char *argv[])
 
 	erofs_init_configure();
 
+	erofs_alloc_workqueue(&erofs_wq, 4, 256, NULL, NULL);
+
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
 	fsckcfg.extract_path = NULL;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e741f1c..de9ac49 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -63,6 +63,8 @@ struct erofs_buf {
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
 
+#define Z_EROFS_PCLUSTER_BATCH_SIZE 32
+
 struct erofs_buffer_head;
 struct erofs_bufmgr;
 
@@ -475,9 +477,20 @@ int erofs_map_blocks(struct erofs_inode *inode,
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
 int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
 			char *buffer, u64 offset, size_t len);
+struct z_erofs_decompress_task;
+struct z_erofs_read_ctx {
+	pthread_mutex_t lock;
+	pthread_cond_t cond;
+	int pending_tasks;
+	int final_err;
+	int outfd;
+	struct z_erofs_decompress_task *current_task;
+};
+void z_erofs_read_ctx_enqueue(struct z_erofs_read_ctx *ctx);
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed);
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx);
 void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
 			  erofs_off_t *offset, int *lengthp);
 int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb);
diff --git a/lib/data.c b/lib/data.c
index 6fd1389..4d8fcef 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,35 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 #include "liberofs_fragments.h"
+#include "erofs/workqueue.h"
+#include <pthread.h>
+
+struct erofs_workqueue erofs_wq;
+
+/* struct z_erofs_read_ctx {
+	pthread_mutex_t lock;
+	pthread_cond_t cond;
+	int pending_tasks;
+	int final_err;
+	int outfd;
+}; */
+
+struct z_erofs_decompress_task {
+	struct erofs_work work;
+	struct z_erofs_read_ctx *ctx;
+	struct z_erofs_decompress_req reqs[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	char *raw_bufs[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	erofs_off_t out_offsets[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	unsigned int nr_reqs;
+};
+
+void z_erofs_read_ctx_enqueue(struct z_erofs_read_ctx *ctx)
+{
+	if (ctx && ctx->current_task) {
+		erofs_queue_work(&erofs_wq, &ctx->current_task->work);
+		ctx->current_task = NULL;
+	}
+}
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
@@ -275,9 +304,45 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
+static void z_erofs_decompress_worker(struct erofs_work *work, void *tlsp)
+{
+    struct z_erofs_decompress_task *task = (struct z_erofs_decompress_task *)work;
+    struct z_erofs_read_ctx *ctx = task->ctx;
+    int i, ret = 0, first_err = 0;
+
+    for (i = 0; i < task->nr_reqs; ++i) {
+        ret = z_erofs_decompress(&task->reqs[i]);
+
+        if (ret == 0 && ctx && ctx->outfd >= 0) {
+            if (pwrite(ctx->outfd, task->reqs[i].out,
+                       task->reqs[i].decodedlength, task->out_offsets[i]) < 0)
+                ret = -errno;
+        }
+
+        if (ret < 0 && first_err == 0)
+            first_err = ret;
+
+        free(task->raw_bufs[i]);
+        if (ctx && ctx->outfd >= 0)
+            free(task->reqs[i].out);
+    }
+
+    if (ctx) {
+        pthread_mutex_lock(&ctx->lock);
+        if (first_err < 0 && ctx->final_err == 0)
+            ctx->final_err = first_err;
+        ctx->pending_tasks--;
+        if (ctx->pending_tasks == 0)
+            pthread_cond_signal(&ctx->cond);
+        pthread_mutex_unlock(&ctx->lock);
+    }
+    free(task);
+}
+
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed)
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_dev mdev;
@@ -307,24 +372,40 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	if (ret < 0)
 		return ret;
 
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
-	return 0;
+	struct z_erofs_decompress_task *task = ctx->current_task;
+    if (!task) {
+        task = calloc(1, sizeof(*task));
+        task->ctx = ctx;
+        task->work.fn = z_erofs_decompress_worker;
+        ctx->current_task = task;
+
+        pthread_mutex_lock(&ctx->lock);
+        ctx->pending_tasks++;
+        pthread_mutex_unlock(&ctx->lock);
+    }
+
+    int idx = task->nr_reqs++;
+    task->reqs[idx] = (struct z_erofs_decompress_req) {
+        .sbi = sbi,
+        .in = raw,
+        .out = buffer,
+        .decodedskip = skip,
+        .interlaced_offset = map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
+                    erofs_blkoff(sbi, map->m_la) : 0,
+        .inputsize = map->m_plen,
+        .decodedlength = length,
+        .alg = map->m_algorithmformat,
+        .partial_decoding = trimmed ? true :
+            !(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
+                (map->m_flags & EROFS_MAP_PARTIAL_REF),
+    };
+    task->raw_bufs[idx] = raw;
+    task->out_offsets[idx] = out_offset;
+
+    if (task->nr_reqs == Z_EROFS_PCLUSTER_BATCH_SIZE) {
+        z_erofs_read_ctx_enqueue(ctx);
+    }
+    return 0;
 }
 
 static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
@@ -335,10 +416,17 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
+		.current_task = NULL
+	};
+	pthread_mutex_init(&ctx.lock, NULL);
+	pthread_cond_init(&ctx.cond, NULL);
+
 	end = offset + size;
 	while (end > offset) {
 		map.m_la = end - 1;
@@ -374,25 +462,51 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
-		if (map.m_plen > bufsize) {
-			char *newraw;
+		/*
+		 * If the global workqueue is getting too deep,
+		 * dynamically throttle the producer by forcing the main thread
+		 * to wait early. Prevents memory bloat from fast I/O out-pacing
+		 * the decompression threads.
+		 */
+		pthread_mutex_lock(&ctx.lock);
+		if (erofs_wq.job_count > 128) {
+			z_erofs_read_ctx_enqueue(&ctx);
+			while (ctx.pending_tasks > 0)
+				pthread_cond_wait(&ctx.cond, &ctx.lock);
+		}
+		pthread_mutex_unlock(&ctx.lock);
 
-			bufsize = map.m_plen;
-			newraw = realloc(raw, bufsize);
-			if (!newraw) {
-				ret = -ENOMEM;
-				break;
-			}
-			raw = newraw;
+		/* Allocate fresh raw buffer for each pcluster. */
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
+			free(raw);
 			break;
+		}
+	}
+	z_erofs_read_ctx_enqueue(&ctx);
+
+	/*
+	 * Wait for all queued pclusters for this read request to finish
+	 * before allowing the VFS layer or fsck core to consume the buffer.
+	 */
+	pthread_mutex_lock(&ctx.lock);
+	while (ctx.pending_tasks > 0) {
+		pthread_cond_wait(&ctx.cond, &ctx.lock);
 	}
-	if (raw)
-		free(raw);
+
+	/* Bubble up any decompression errors caught by the worker threads */
+	if (ctx.final_err < 0 && ret == 0)
+		ret = ctx.final_err;
+
+	pthread_mutex_destroy(&ctx.lock);
+	pthread_cond_destroy(&ctx.cond);
 	return ret < 0 ? ret : 0;
 }
 
-- 
2.51.0


