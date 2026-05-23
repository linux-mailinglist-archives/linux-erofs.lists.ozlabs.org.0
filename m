Return-Path: <linux-erofs+bounces-3481-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDQMBf32EGoxgAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3481-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 23 May 2026 02:38:21 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B55BC130
	for <lists+linux-erofs@lfdr.de>; Sat, 23 May 2026 02:38:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMjtG60zZz2yRF;
	Sat, 23 May 2026 10:38:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779496694;
	cv=none; b=Jpd3Y8f9pKJQkM1umvqkAzZKU0opO1/UWCdZ0pllb+eVXEfveGqYZJdlxiawgEonZofWHjHRIcFF0ES81UQP8vAZEnO0xp4wTfZjmIhm8kMDH6VYQ4yQDsQ1omXJRnZ+pZPMjwr+X5lqq3gQTIpgTbd7WQIru9U1U4IhDk9NxIoDe8F01bHQRTRUHgztdYCkTxXVajPA86Yinfv8MSID5QDSBWf7POeKMJEhRlgc/1ZcC8o6K3Kc8cxqunA0auCSQU7Evc6YloHZv6Cakbh/zMnkwSmmjBXTeMrzGb2wVz1hPK0DguVIGTEcvKbHzsqI8TJIWtWwvCssrlpU3I2Igg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779496694; c=relaxed/relaxed;
	bh=yClioFDJcXb2R1iJ6tA0eGZVPpNgyv15pXfy+ouj4h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAWyhNOwCLXAuL9wR6HCdDfymzaI0jahnxA3s/5qbguwEuBpZpwdv7PqwAPP7h2HLJT0c3Jw1Y7nq3RW/IOU6DApaSO/OvbC333vTrGjmfYbvXxlqiJ7pdnjYajcR3k6bssuLP8Vq3+MIW2rEBvxm8JrtjruOhLJITN6Pqj4kndvv8IUtix3wTupmNdkBfI4uWvWrcUXpxkOUnludl4UhItwvOS6j2KruhqL5fJ+aUqrt3Z+nD+6GVLlZOCiFE1UBD8kDtIB9MlxhvdymPVEcU0UjFUGPRyzZyrbBkTterXUqZBTCBQA8zWd4jwMga8BnOk1hA7P+3znDoYtv2B5kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rwNzpWtE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rwNzpWtE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMjtD5RhTz2yH4
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 May 2026 10:38:12 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b9e9a6802aso34116325ad.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 May 2026 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779496691; x=1780101491; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yClioFDJcXb2R1iJ6tA0eGZVPpNgyv15pXfy+ouj4h4=;
        b=rwNzpWtEiNNBNiSYlzio2lKOkHV5VLC2AWySkzxC2HRWNe0OOCfvM29nEEsRCXcNww
         /s9HbeAkZ1x24qNt1/YjK91VKGOB98xbGzxNdsb9F87+OJMpmSGW3BreWJRj+fU20J9O
         vPK+/01Y7Mscf7odUn+fUlMfiZtI8JKdLzdY1kx9Y5rTv3GpwHIgr4XrSrFYGagZrInW
         n66pJn1NOHi/NGd1lb9GjJJ9viPwd187UyNcXlTSmCW6qdK0MBQJA/15Eux1/A3ouYdt
         0LfWmo7xe6QMWD5t5/77sxF4UJVvTlyZ6jz1DLPWRFb/AiNd0rEZwF9PQImrBRQ1+SY6
         NUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496691; x=1780101491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yClioFDJcXb2R1iJ6tA0eGZVPpNgyv15pXfy+ouj4h4=;
        b=IYjdg9d7tEbcpvGnnQpcyV8J3KMEAdhGfrYlqihw2ZnApRSx8+MUNiTkq78wIKdVz4
         CUNgMbu/wWpKRwxDSjc9vml/7fWtBPMmi5KxpzMd2BAIdHQzz2la4B+lLuqjBDLxX8+Y
         p1pwOwaN9WIT7cPVeoZ9Jb0JHVHgsQZTyo5eFA4s/GlrTnkG3ok8IXcMd9Y/fJwD0atd
         t1qHSTt/K2jiGAYYvpIO/AJUv/3WVqtCp0pIGQM6gHp5JwMzlH/QG7nxosrz1UxchRDg
         +Vb0VFaS7Rhvj/blDdQvCyXmtcFWmJuIdGBof19NUCv3qnHN+yN3hlr0jJ2iQnMFxXbj
         hr7g==
X-Gm-Message-State: AOJu0YwM5ROkJ4vVIeAxwpF7uO4Tt2HkiVAs+6FaBzKdObGTdUDP7jHe
	gTI72QAQ2fWAGj3ZU6wAgbDRy5McwiIA/XQPY1psqapkxDWDRpLCSVTGA8x81ca0
X-Gm-Gg: Acq92OGKI3Kc0qPcLELk/Ni0U80ab5c+9db1MxKW4WP0CAu6tVuBdYVx295UVoEqecH
	DOvmNjLifHa6mc2kJeWmonQmANyllAJUbxOnjsVBDNZaIjCn8XSRHd654/Sx5BhrG6QXM7FjKc6
	tGC4gzP/54HdZDZk8ojAt0sAJhoYIsFXQRm9FhJf3UASGbGKhX5Qx7JO/SlEWSBu8z78ncHMV26
	dr3TYmE72p2WCNUV+D0KT7aowaP1j2Pr53a/ivHG9rZCFHjKjISE5jT0LAoTgMHHIbTG47mtjTX
	l2bHZk9nXmF7+I58+LrJD/5M5dAeRqLc4deZSZumPZ+vd4ou62GuJKr4f56Bu4Jo3ch+U5fTr7U
	3YPHw7yDVAzTnw23s5AzYmLJSZA5B2lqj5J8jLwZRKp3QcAesgePcdT6N7rabG+tlRVtMp9VAUH
	iI9TN70N4mEYy1ULcxqidn89mJIIDer6l+d9nNZIjqy9UkYRmVd2c9VTE=
X-Received: by 2002:a17:903:2c07:b0:2ba:bfb5:9cc with SMTP id d9443c01a7336-2beb0631a41mr58574405ad.26.1779496690481;
        Fri, 22 May 2026 17:38:10 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f3dsm27393835ad.1.2026.05.22.17.38.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 May 2026 17:38:09 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 1/2] fsck.erofs: introduce multi-threaded decompression with static batching
Date: Sat, 23 May 2026 06:07:56 +0530
Message-ID: <20260523003757.13078-2-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3481-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 7E1B55BC130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 fsck/main.c              | 234 +++++++++++++++++----------------------
 include/erofs/internal.h |  18 ++-
 lib/data.c               | 203 +++++++++++++++++++++++----------
 3 files changed, 265 insertions(+), 190 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 16cc627..d7810e8 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -8,14 +8,18 @@
 #include <time.h>
 #include <utime.h>
 #include <unistd.h>
+#include <pthread.h>
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
@@ -505,135 +509,95 @@ out:
 
 static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 {
-	struct erofs_map_blocks map = {
-		.buf = __EROFS_BUF_INITIALIZER,
-	};
-	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
-	int ret = 0;
-	bool compressed;
-	erofs_off_t pos = 0;
-	u64 pchunk_len = 0;
-	unsigned int raw_size = 0, buffer_size = 0;
-	char *raw = NULL, *buffer = NULL;
-
-	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
-		  inode->nid | 0ULL, inode->datalayout);
-
-	compressed = erofs_inode_is_data_compressed(inode->datalayout);
-	while (pos < inode->i_size) {
-		unsigned int alloc_rawsize;
-
-		map.m_la = pos;
-		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
-		if (ret)
-			goto out;
-
-		if (!compressed && map.m_llen != map.m_plen) {
-			erofs_err("broken chunk length m_la %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64,
-				  map.m_la, map.m_llen, map.m_plen);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		/* the last lcluster can be divided into 3 parts */
-		if (map.m_la + map.m_llen > inode->i_size)
-			map.m_llen = inode->i_size - map.m_la;
-
-		pchunk_len += map.m_plen;
-		pos += map.m_llen;
-
-		/* should skip decomp? */
-		if (map.m_la >= inode->i_size || !needdecode)
-			continue;
+    struct erofs_map_blocks map = { .buf = __EROFS_BUF_INITIALIZER };
+    bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
+    int ret = 0;
+    bool compressed = erofs_inode_is_data_compressed(inode->datalayout);
+    erofs_off_t pos = 0;
+    u64 pchunk_len = 0;
+
+    struct z_erofs_read_ctx ctx = {
+        .pending_tasks = 0,
+        .final_err = 0,
+        .outfd = outfd,
+		.free_out = true,
+        .current_task = NULL
+    };
+    pthread_mutex_init(&ctx.lock, NULL);
+    pthread_cond_init(&ctx.cond, NULL);
+
+    erofs_dbg("verify data chunk of nid(%llu): type(%d)", inode->nid | 0ULL, inode->datalayout);
+
+    while (pos < inode->i_size) {
+        map.m_la = pos;
+        ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_FIEMAP);
+        if (ret) goto out;
+
+        if (map.m_la + map.m_llen > inode->i_size)
+            map.m_llen = inode->i_size - map.m_la;
+
+        pchunk_len += map.m_plen;
+        pos += map.m_llen;
+
+        if (map.m_la >= inode->i_size || !needdecode)
+            continue;
+
+        if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
+            ret = lseek(outfd, map.m_llen, SEEK_CUR);
+            if (ret < 0) {
+                ret = -errno;
+                goto out;
+            }
+            continue;
+        }
+
+        if (compressed) {
+            char *raw = malloc(map.m_plen);
+            size_t buffer_size = map.m_llen > erofs_blksiz(inode->sbi) ? map.m_llen : erofs_blksiz(inode->sbi);
+            char *buffer = calloc(1, buffer_size);
+            
+            if (!raw || !buffer) {
+                free(raw); free(buffer);
+                ret = -ENOMEM;
+                goto out;
+            }
+
+            ret = z_erofs_read_one_data(inode, &map, raw, buffer, 0, map.m_llen, false, map.m_la, &ctx);
+            if (ret) {
+                /* DO NOT free(raw) or free(buffer) here. z_erofs_read_one_data took ownership! */
+                goto out;
+            }
+        } else {
+            char *raw = calloc(1, map.m_llen);
+            ret = erofs_read_one_data(inode, &map, raw, 0, map.m_llen);
+            if (ret >= 0 && outfd >= 0)
+                pwrite(outfd, raw, map.m_llen, map.m_la);
+            free(raw);
+            if (ret) goto out;
+        }
+    }
+    z_erofs_read_ctx_enqueue(&ctx);
 
-		if (outfd >= 0 && !(map.m_flags & EROFS_MAP_MAPPED)) {
-			ret = lseek(outfd, map.m_llen, SEEK_CUR);
-			if (ret < 0) {
-				ret = -errno;
-				goto out;
-			}
-			continue;
-		}
-
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
-				ret = -ENOMEM;
-				goto out;
-			}
-			raw = newraw;
-			raw_size = alloc_rawsize;
-		}
-
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
-				goto out;
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
-		}
-	}
-
-	if (fsckcfg.print_comp_ratio) {
-		if (!erofs_is_packed_inode(inode))
-			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->sbi, inode->i_size);
-		fsckcfg.physical_blocks += BLK_ROUND_UP(inode->sbi, pchunk_len);
-	}
 out:
-	if (raw)
-		free(raw);
-	if (buffer)
-		free(buffer);
-	return ret < 0 ? ret : 0;
-
-fail_eio:
-	erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
-		  inode->nid | 0ULL);
-	ret = -EIO;
-	goto out;
+    pthread_mutex_lock(&ctx.lock);
+    while (ctx.pending_tasks > 0)
+        pthread_cond_wait(&ctx.cond, &ctx.lock);
+    if (ctx.final_err < 0 && ret >= 0)
+        ret = ctx.final_err;
+    pthread_mutex_unlock(&ctx.lock);
+
+    if (fsckcfg.print_comp_ratio) {
+        if (!erofs_is_packed_inode(inode))
+            fsckcfg.logical_blocks += BLK_ROUND_UP(inode->sbi, inode->i_size);
+        fsckcfg.physical_blocks += BLK_ROUND_UP(inode->sbi, pchunk_len);
+    }
+
+    if (outfd >= 0 && ret >= 0)
+        ftruncate(outfd, inode->i_size);
+    
+    pthread_mutex_destroy(&ctx.lock);
+    pthread_cond_destroy(&ctx.cond);
+    return ret < 0 ? ret : 0;
 }
 
 static inline int erofs_extract_dir(struct erofs_inode *inode)
@@ -1043,9 +1007,14 @@ int erofsfsck_fuzz_one(int argc, char *argv[])
 int main(int argc, char *argv[])
 #endif
 {
-	int err;
+    int err;
+    int workers;
+
+    erofs_init_configure();
 
-	erofs_init_configure();
+    workers = sysconf(_SC_NPROCESSORS_ONLN);
+    if (workers < 1) workers = 1;
+    erofs_alloc_workqueue(&erofs_wq, workers, 256, NULL, NULL);
 
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
@@ -1179,9 +1148,10 @@ exit_put_super:
 exit_dev_close:
 	erofs_dev_close(&g_sbi);
 exit:
-	erofs_blob_closeall(&g_sbi);
-	erofs_exit_configure();
-	return err ? 1 : 0;
+    erofs_blob_closeall(&g_sbi);
+    erofs_exit_configure();
+    erofs_destroy_workqueue(&erofs_wq);
+    return err ? 1 : 0;
 }
 
 #ifdef FUZZING
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 671880f..38020ee 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -62,6 +62,7 @@ struct erofs_buf {
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
+#define Z_EROFS_PCLUSTER_BATCH_SIZE 32
 
 struct erofs_buffer_head;
 struct erofs_bufmgr;
@@ -442,6 +443,20 @@ struct z_erofs_paramset {
 	char *extraopts;
 };
 
+struct z_erofs_decompress_task;
+
+struct z_erofs_read_ctx {
+	pthread_mutex_t lock;
+	pthread_cond_t cond;
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
 
@@ -478,7 +493,8 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
 			char *buffer, u64 offset, size_t len);
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed);
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx);
 void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
 			  erofs_off_t *offset, int *lengthp);
 int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb);
diff --git a/lib/data.c b/lib/data.c
index 6fd1389..fa36899 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,64 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 #include "liberofs_fragments.h"
+#include "erofs/workqueue.h"
+#include <pthread.h>
+
+struct erofs_workqueue erofs_wq;
+
+struct z_erofs_decompress_task {
+	struct erofs_work work;
+	struct z_erofs_read_ctx *ctx;
+	struct z_erofs_decompress_req reqs[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	char *raw_bufs[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	char *out_bufs[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	erofs_off_t out_offsets[Z_EROFS_PCLUSTER_BATCH_SIZE];
+	unsigned int out_lengths[Z_EROFS_PCLUSTER_BATCH_SIZE];
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
+
+static void z_erofs_decompress_worker(struct erofs_work *work, void *tlsp)
+{
+	struct z_erofs_decompress_task *task = (struct z_erofs_decompress_task *)work;
+	struct z_erofs_read_ctx *ctx = task->ctx;
+	int i, ret = 0, first_err = 0;
+
+	for (i = 0; i < task->nr_reqs; ++i) {
+		ret = z_erofs_decompress(&task->reqs[i]);
+
+		if (ret >= 0 && ctx && ctx->outfd >= 0) {
+			if (pwrite(ctx->outfd, task->out_bufs[i],
+				   task->out_lengths[i], task->out_offsets[i]) < 0)
+				ret = -errno;
+		}
+
+		if (ret < 0 && first_err == 0)
+			first_err = ret;
+
+		free(task->raw_bufs[i]);
+		if (ctx && ctx->free_out)
+			free(task->out_bufs[i]);
+	}
+
+	if (ctx) {
+		pthread_mutex_lock(&ctx->lock);
+		if (first_err < 0 && ctx->final_err == 0)
+			ctx->final_err = first_err;
+		ctx->pending_tasks--;
+		if (ctx->pending_tasks == 0)
+			pthread_cond_signal(&ctx->cond);
+		pthread_mutex_unlock(&ctx->lock);
+	}
+	free(task);
+}
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
@@ -277,7 +335,8 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
 int z_erofs_read_one_data(struct erofs_inode *inode,
 			struct erofs_map_blocks *map, char *raw, char *buffer,
-			erofs_off_t skip, erofs_off_t length, bool trimmed)
+			erofs_off_t skip, erofs_off_t length, bool trimmed,
+			erofs_off_t out_offset, struct z_erofs_read_ctx *ctx)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_map_dev mdev;
@@ -285,77 +344,101 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 
 	if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 		if (__erofs_unlikely(inode->nid == sbi->packed_nid)) {
-			erofs_err("fragment should not exist in the packed inode %llu",
-				  sbi->packed_nid | 0ULL);
-			return -EFSCORRUPTED;
+			ret = -EFSCORRUPTED;
+			goto err_out;
 		}
-		return erofs_packedfile_read(sbi, buffer, length - skip,
-				   inode->fragmentoff + skip);
+		ret = erofs_packedfile_read(sbi, buffer, length - skip,
+					   inode->fragmentoff + skip);
+		
+		if (ret >= 0 && ctx && ctx->outfd >= 0) {
+			if (pwrite(ctx->outfd, buffer, length - skip, out_offset) < 0)
+				ret = -errno;
+		}
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
+	if (ret) goto err_out;
 
 	ret = erofs_dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) goto err_out;
+
+	struct z_erofs_decompress_task *task = ctx->current_task;
+	if (!task) {
+		task = calloc(1, sizeof(*task));
+		task->ctx = ctx;
+		task->work.fn = z_erofs_decompress_worker;
+		ctx->current_task = task;
+
+		pthread_mutex_lock(&ctx->lock);
+		ctx->pending_tasks++;
+		pthread_mutex_unlock(&ctx->lock);
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
+	task->reqs[idx] = (struct z_erofs_decompress_req) {
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
+	task->raw_bufs[idx] = raw;
+	task->out_bufs[idx] = buffer;
+	task->out_offsets[idx] = out_offset;
+	task->out_lengths[idx] = length;
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
+	pthread_mutex_init(&ctx.lock, NULL);
+	pthread_cond_init(&ctx.cond, NULL);
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
@@ -374,25 +457,31 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
+	pthread_mutex_lock(&ctx.lock);
+	while (ctx.pending_tasks > 0)
+		pthread_cond_wait(&ctx.cond, &ctx.lock);
+	
+	if (ctx.final_err < 0 && ret == 0)
+		ret = ctx.final_err;
+
+	pthread_mutex_unlock(&ctx.lock);
+	pthread_mutex_destroy(&ctx.lock);
+	pthread_cond_destroy(&ctx.cond);
+
 	return ret < 0 ? ret : 0;
 }
 
-- 
2.52.0


