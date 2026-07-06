Return-Path: <linux-erofs+bounces-3820-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 77JZMrVFS2r3OQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3820-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 08:05:41 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4B70CC6A
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 08:05:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Tduv5WM5;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3820-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3820-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtv3k2gBDz3bp7;
	Mon, 06 Jul 2026 16:05:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783317938;
	cv=none; b=YmHVHlY7D8B27H1cfaB9m+QefjdVv8IKq9MTdhWRzuO+jTfKa6C1J7Uengl/OwQTvO/eCW7rjBOXKNcDkoCktgGFNjVfIqEcsDr5tUi4u7WJvl5djJGxmphuZXWuSEOM99uGaox5G/MTWbRBEQ4zMyYiVt+IrXHSpX3HclTmA1vUHvFTPMxWqQYA3MEgiX0W052b9t9lNujnLJUgYI70ZSRNkUULYxpPpCKwNNXt5MBgkIeeuO89Ccyl9gtZ0Uo3CjqZM2vv1xHy+8ch6svnwaBNwedz5jzKC82/ilvPcoxmk3EGivBAzRDBvFqdsUct787Q0REPBGFNTrV7QIrUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783317938; c=relaxed/relaxed;
	bh=u9b9Fg6aCh+1qQxqjiD6SzHQMjtA7uu5Ad+hz//nA+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jn0Jl+TpT43EshhifuGgaRf9jJNzqnAyPn3kX77fU1gesYSE2xqkL6KiFBkvWYQJX9XG7k7oYBb2IG1HoWOQj51b9ZJ8OjU3NEGPXRIl5h47dfaCvK6TFJfj/I15UtqdU1+9PW++/QzqAOvA/i7PHNwZzuHG7kBllGzWYbfcsXAiVpMCb/o2SP4oXvo1VkxcqN5vYz5mY61EnLjkWhNmtyGzMpDh6i/8qSGH5h2wr7Fi+a9igrvvNdDvk78INFAasigJwynXkifNxBPNnEXOyBZ1AaSl82d/vcE5lf03HT3wf46sFughI260c8OOVNo03YIFqBlA1B0IqV6d2u1rSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tduv5WM5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtv3h4lfGz2yfS
	for <linux-erofs@lists.ozlabs.org>; Mon, 06 Jul 2026 16:05:36 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso28150295ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Jul 2026 23:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783317933; x=1783922733; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9b9Fg6aCh+1qQxqjiD6SzHQMjtA7uu5Ad+hz//nA+0=;
        b=Tduv5WM5/3WvoGHSTJkD3RsC9PGKKX3H0ln/zBY3X/wRtR7Jz1j9HlnGtd1GZz9Vza
         nqbESCtO7mXxDUOtnHPBOFBfZTnPbtZb25C79vGpSizSQo2R4Mh2kGZsgvoPheffYMc5
         9RQSmWIDioqi09vu0J4ZNkycIFub1iMZQtqSA6lTkYjVtCoVgEwZNMg8KVqQT/2u2XWR
         8gxid9t2MhwdGGgvWiZdYvm6ProUQdqm6VKNgjiBbNPACd6vjMqvEDRxKZscPzca7JfL
         fAXT/sEfKhHgK1wltkQ8vcRAhN1NVHz7zfW3NgLHu/Y7ZsgyhLAo/abFAgLc6xSRQZlM
         CEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783317933; x=1783922733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9b9Fg6aCh+1qQxqjiD6SzHQMjtA7uu5Ad+hz//nA+0=;
        b=GkExRFOuGpXlBrZiemM3V6m0Xxfac6B3PU4IVF/Z3KUUh5X5n3ZC0MGH9vpyBkObKg
         i/9f1bat2A3NNl9G1ZUIT/sI0rTNi5lIilG3e1Pd0tP9FLUJF/iGMygOZD874h7KZm5/
         fnIU5oh+ibtNydZ5lvbpqg5Lt85PIgJXwku2x4XfhHhAR9ie1qIAJbmLuvt8GwK47cX8
         6YFX+a1aPmDcLwuY2oF4w2QAxacAZ2eXwFcVQgXPHzQYMK1pHJ0rWmxKSnJ7m/S83Tms
         k13IoZWqYqaxWTzP6O8CbdEzjXG1dQcyBmZwEsgL6glHxWVmOx2k5U7NPytQxTCHVyvl
         /3Zg==
X-Forwarded-Encrypted: i=1; AHgh+RpFLxTMASSefZhCh6rS7cfnZHSHhHut9PoBkEFMANOA0ctJMqqvZTk49i559l7R+tjcqeRcSzk4s2aebw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyg8aTxEKo2NItIA8dMBwFxFnGPzpjhYf1e6GxU1vdvhX/hRPUW
	6bhrUEBqT9X+Ib9bkVYJgbuT5qAhJHHYsBl4DsPSHUNj5QAJbMAjie6k
X-Gm-Gg: AfdE7cnncyYTsrkHtEJj9lcIGclL1C4J0LrKTJuKFmCIY6azVjDCXvqVfbEsb5E7kLD
	5whp2GvpEhBIGdLBW9esFtgmgGd8exnZ18gC/u4XUyMT1wKOgj3ZePNf0F3wgZUEUGPLAtuLzyT
	UAS7bMuBnOPqc5FYgHkJTQT3nCah8Csssp0/JIt8QiopE2bYdOPtm37YoPTzhTGHUKEMHRtZTti
	xE7qOx0HTgHAYTGeIlrhFVi+72nbfTWEcijkiB+pBm9bwzeGaoRh3CdtJFfXHhJ1bFoWo7/8/7Y
	8Jrb1hBA0pVRj9vZvBOgcDKrSxH/R7QGCA3oe0W/LcAJl/2fAbPqcPNbMXuMlUVOXMSc+pseo6y
	4cpjA2boNecETOgWFULZWz+DkqN7mGT0zE6FDU4MM1Lzkqa+Nh3S2cVqJzTv367M1RbJNFCm7js
	TBKFs6lQJtD1mNXn6npRSN1exjS6fR+EY6wpTEmRzNw//AaA==
X-Received: by 2002:a17:902:d508:b0:2c9:9a19:10c with SMTP id d9443c01a7336-2cbb9edf4bamr77608085ad.40.1783317932306;
        Sun, 05 Jul 2026 23:05:32 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm63424712c88.12.2026.07.05.23.05.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 23:05:31 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH 1/2 v3] fsck.erofs: add multi-threaded decompression
Date: Mon,  6 Jul 2026 11:35:25 +0530
Message-ID: <20260706060525.14018-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3820-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BD4B70CC6A

Currently, fsck.erofs extracts files synchronously. When decompressing
heavily packed images, the main thread spends the majority of its time
blocked on a combination of synchronous I/O syscalls and CPU-heavy
decompression routines, bottlenecking overall extraction speed.

This patch introduces a scalable, multi-threaded decompression framework
using the existing erofs_workqueue infrastructure to decouple compute
from the main thread's I/O.

To prevent massive scheduling overhead (futex contention) where worker
threads spend more CPU time waking up than actually decompressing small
clusters, this implementation introduces a batching context. Because
different compression algorithms exhibit vastly different scheduling
thresholds, the batch limit is algorithm-aware.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c              | 127 ++++++++++++++++-----
 include/erofs/cond.h     |  31 ++++++
 include/erofs/internal.h |  17 ++-
 include/erofs/lock.h     |   2 +
 lib/data.c               | 230 ++++++++++++++++++++++++++++++++++-----
 lib/global.c             |  17 +++
 6 files changed, 373 insertions(+), 51 deletions(-)
 create mode 100644 include/erofs/cond.h

diff --git a/fsck/main.c b/fsck/main.c
index b2d8f1a..b74ae68 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -16,6 +16,7 @@
 #include "../lib/compressor.h"
 #include "../lib/liberofs_compress.h"
 #include "../lib/liberofs_sha256.h"
+#include "erofs/internal.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
@@ -526,6 +527,13 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 	u64 pchunk_len = 0;
 	u64 raw_size = 0, buffer_size = 0;
 	char *raw = NULL, *buffer = NULL;
+	struct z_erofs_mt_read_ctx *ctx = NULL;
+
+	if (!digest) {
+		ctx = z_erofs_mt_read_ctx_alloc(outfd, true);
+		if (!ctx)
+			return -ENOMEM;
+	}
 
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
 		  inode->nid | 0ULL, inode->datalayout);
@@ -569,7 +577,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 						(const u8 *)zeros, chunk);
 					remain -= chunk;
 				}
-			} else if (outfd >= 0) {
+			} else if (!ctx && outfd >= 0) {
 				ret = lseek(outfd, map.m_llen, SEEK_CUR);
 				if (ret < 0) {
 					ret = -errno;
@@ -592,8 +600,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 			alloc_rawsize = map.m_plen;
 		}
 
-		if (alloc_rawsize > raw_size) {
-			char *newraw = realloc(raw, alloc_rawsize);
+		if (!ctx) {
+			if (alloc_rawsize > raw_size) {
+				char *newraw = realloc(raw, alloc_rawsize);
 
 			if (!newraw) {
 				ret = -ENOMEM;
@@ -602,9 +611,22 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 			raw = newraw;
 			raw_size = alloc_rawsize;
 		}
+	}
 
 		if (compressed) {
-			if (map.m_llen > buffer_size) {
+			char *c_raw = raw;
+			char *c_buf = buffer;
+
+			if (ctx) {
+				c_raw = malloc(alloc_rawsize);
+				c_buf = calloc(1, map.m_llen);
+				if (!c_raw || !c_buf) {
+					free(c_raw);
+					free(c_buf);
+					ret = -ENOMEM;
+					goto out;
+				}
+			} else if (map.m_llen > buffer_size) {
 				char *newbuffer;
 
 				buffer_size = map.m_llen;
@@ -614,45 +636,98 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 					goto out;
 				}
 				buffer = newbuffer;
+				c_buf = buffer;
 			}
-			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
-						    0, map.m_llen, false);
-			if (ret)
+
+			ret = z_erofs_read_one_data(inode, &map, c_raw, c_buf,
+						    0, map.m_llen, false,
+						    map.m_la, ctx);
+			if (ret) {
+				if (ctx) {
+					free(c_raw);
+					free(c_buf);
+				}
 				goto out;
+			}
 
-			if (digest)
-				erofs_sha256_process(digest,
-					(const u8 *)buffer, map.m_llen);
-			if (outfd >= 0 && write(outfd, buffer, map.m_llen) < 0)
-				goto fail_eio;
+			if (!ctx) {
+				if (digest)
+					erofs_sha256_process(digest,
+						(const u8 *)c_buf, map.m_llen);
+				if (outfd >= 0 && write(outfd, c_buf, map.m_llen) < 0)
+					goto fail_eio;
+			}
 		} else {
+			char *c_raw = raw;
 			u64 p = 0;
+			erofs_off_t m_llen = map.m_llen;
+
+			if (ctx) {
+				c_raw = calloc(1, alloc_rawsize);
+				if (!c_raw) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
 
 			do {
-				u64 count = min_t(u64, alloc_rawsize,
-						  map.m_llen);
+				u64 count = min_t(u64, alloc_rawsize, m_llen);
 
-				ret = erofs_read_one_data(inode, &map, raw, p, count);
-				if (ret)
+				ret = erofs_read_one_data(inode, &map, c_raw, p, count);
+				if (ret) {
+					if (ctx)
+						free(c_raw);
 					goto out;
+				}
 
-				if (digest)
-					erofs_sha256_process(digest,
-						(const u8 *)raw, count);
-				if (outfd >= 0 && write(outfd, raw, count) < 0)
-					goto fail_eio;
-				map.m_llen -= count;
+				if (!ctx) {
+					if (digest)
+						erofs_sha256_process(digest,
+							(const u8 *)c_raw, count);
+					if (outfd >= 0 && write(outfd, c_raw, count) < 0)
+						goto fail_eio;
+				} else if (outfd >= 0) {
+					if (pwrite(outfd, c_raw, count, map.m_la + p) < 0) {
+						free(c_raw);
+						goto fail_eio;
+					}
+				}
+				m_llen -= count;
 				p += count;
-			} while (map.m_llen);
+			} while (m_llen);
+
+			if (ctx)
+				free(c_raw);
 		}
 	}
 
+	if (ctx) {
+		int wait_err;
+
+		z_erofs_mt_read_enqueue(ctx);
+		wait_err = z_erofs_mt_read_ctx_wait(ctx);
+		if (wait_err < 0 && ret == 0)
+			ret = wait_err;
+	}
+
 	if (fsckcfg.print_comp_ratio) {
 		if (!erofs_is_packed_inode(inode))
 			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->sbi, inode->i_size);
 		fsckcfg.physical_blocks += BLK_ROUND_UP(inode->sbi, pchunk_len);
 	}
 out:
+	if (ctx) {
+		/* use ftruncate to handle trailing unmapped blocks (holes) */
+		if (outfd >= 0 && ret == 0) {
+			if (ftruncate(outfd, inode->i_size) < 0) {
+				erofs_err("failed to truncate file to %llu: %d", 
+						(unsigned long long)inode->i_size, errno);
+				if (ret == 0) 
+					ret = -errno;
+			}
+		}
+		z_erofs_mt_read_ctx_free(ctx);
+	}
 	if (raw)
 		free(raw);
 	if (buffer)
@@ -1127,7 +1202,9 @@ int main(int argc, char *argv[])
 {
 	int err;
 
-	erofs_init_configure();
+	err = liberofs_global_init();
+	if (err)
+		return 1;
 
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
@@ -1283,7 +1360,7 @@ exit_dev_close:
 	erofs_dev_close(&g_sbi);
 exit:
 	erofs_blob_closeall(&g_sbi);
-	erofs_exit_configure();
+	liberofs_global_exit();
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
index 2cc9cc8..5e9d8c1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -25,6 +25,11 @@ typedef unsigned short umode_t;
 #ifdef HAVE_PTHREAD_H
 #include <pthread.h>
 #endif
+#ifdef HAVE_PTHREAD_H
+#include <pthread.h>
+#endif
+#include <erofs/lock.h>
+#include "erofs/cond.h"
 #include <stdlib.h>
 #include <string.h>
 #include "atomic.h"
@@ -62,6 +67,7 @@ struct erofs_buf {
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
+#define Z_EROFS_PCLUSTER_MAX_BATCH_SIZE 32
 
 struct erofs_buffer_head;
 struct erofs_bufmgr;
@@ -451,6 +457,14 @@ struct z_erofs_paramset {
 	char *extraopts;
 };
 
+struct z_erofs_decompress_task;
+struct z_erofs_mt_read_ctx;
+
+struct z_erofs_mt_read_ctx *z_erofs_mt_read_ctx_alloc(int outfd, bool free_out);
+int z_erofs_mt_read_ctx_wait(struct z_erofs_mt_read_ctx *ctx);
+void z_erofs_mt_read_ctx_free(struct z_erofs_mt_read_ctx *ctx);
+void z_erofs_mt_read_enqueue(struct z_erofs_mt_read_ctx *ctx);
+
 int liberofs_global_init(void);
 void liberofs_global_exit(void);
 
@@ -487,7 +501,8 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
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
index 884f23e..e08b76e 100644
--- a/include/erofs/lock.h
+++ b/include/erofs/lock.h
@@ -15,6 +15,7 @@ static inline void erofs_mutex_init(erofs_mutex_t *lock)
 }
 #define erofs_mutex_lock	pthread_mutex_lock
 #define erofs_mutex_unlock	pthread_mutex_unlock
+#define erofs_mutex_destroy	pthread_mutex_destroy
 
 #define EROFS_DEFINE_MUTEX(lock)	\
 	erofs_mutex_t lock = PTHREAD_MUTEX_INITIALIZER
@@ -35,6 +36,7 @@ typedef struct {} erofs_mutex_t;
 static inline void erofs_mutex_init(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_lock(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_unlock(erofs_mutex_t *lock) {}
+static inline void erofs_mutex_destroy(erofs_mutex_t *lock) {}
 
 #define EROFS_DEFINE_MUTEX(lock)	\
 	erofs_mutex_t lock = {}
diff --git a/lib/data.c b/lib/data.c
index 1bb9269..edb262d 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,123 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 #include "liberofs_fragments.h"
+#include "erofs/lock.h"
+
+#ifdef EROFS_MT_ENABLED
+#include "erofs/workqueue.h"
+struct erofs_workqueue z_erofs_mt_wq;
+#endif
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
@@ -277,20 +394,29 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
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
 			erofs_err("fragment should not exist in the packed inode %llu",
-				  sbi->packed_nid | 0ULL);
-			return -EFSCORRUPTED;
+				sbi->packed_nid | 0ULL);
+			ret = -EFSCORRUPTED;
+			goto err_out;
 		}
-		return erofs_packedfile_read(sbi, buffer, length - skip,
-				   inode->fragmentoff + skip);
+		ret = erofs_packedfile_read(sbi, buffer, length - skip,
+					inode->fragmentoff + skip);
+		if (ret >= 0 && ctx && ctx->outfd >= 0) {
+			if (pwrite(ctx->outfd, buffer, length - skip, out_offset) < 0)
+				ret = -errno;
+		}
+		goto err_out;
 	}
 
 	/* no device id here, thus it will always succeed */
@@ -300,31 +426,85 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
 	ret = erofs_map_dev(sbi, &mdev);
 	if (ret) {
 		DBG_BUGON(1);
-		return ret;
+		goto err_out;
 	}
 
 	ret = erofs_dev_read(sbi, mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
 	if (ret < 0)
+		goto err_out;
+
+	if (!ctx) {
+		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+				.sbi = sbi,
+				.in = raw,
+				.out = buffer,
+				.decodedskip = skip,
+				.interlaced_offset =
+					map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
+						erofs_blkoff(sbi, map->m_la) : 0,
+				.inputsize = map->m_plen,
+				.decodedlength = length,
+				.alg = map->m_algorithmformat,
+				.partial_decoding = trimmed ? true :
+					!(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
+						(map->m_flags & EROFS_MAP_PARTIAL_REF),
+				});
 		return ret;
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
+	task = ctx->current_task;
+	if (!task) {
+		task = calloc(1, sizeof(*task));
+		if (!task) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
+		task->ctx = ctx;
+		task->work.fn = z_erofs_decompress_worker;
+		ctx->current_task = task;
+
+		erofs_mutex_lock(&ctx->lock);
+		ctx->pending_tasks++;
+		erofs_mutex_unlock(&ctx->lock);
+	}
+
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
+					Z_EROFS_PCLUSTER_MAX_BATCH_SIZE : 8;
+
+	if (task->nr_reqs >= batch_limit)
+		z_erofs_mt_read_enqueue(ctx);
 	return 0;
+
+err_out:
+	if (ctx) {
+		if (ctx->free_out)
+			free(buffer);
+		free(raw);
+	}
+	return ret;
 }
 
 static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
@@ -387,7 +567,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		ret = z_erofs_read_one_data(inode, &map, raw,
-				buffer + end - offset, skip, length, trimmed);
+				buffer + end - offset, skip, length, trimmed, 0, NULL);
 		if (ret < 0)
 			break;
 	}
diff --git a/lib/global.c b/lib/global.c
index 938aa0a..af2093b 100644
--- a/lib/global.c
+++ b/lib/global.c
@@ -12,6 +12,12 @@
 #include "erofs/err.h"
 #include "erofs/config.h"
 #include "liberofs_compress.h"
+#include "erofs/internal.h"
+
+#ifdef EROFS_MT_ENABLED
+#include "erofs/workqueue.h"
+extern struct erofs_workqueue z_erofs_mt_wq;
+#endif
 
 static EROFS_DEFINE_MUTEX(erofs_global_mutex);
 #ifdef HAVE_LIBCURL
@@ -27,6 +33,14 @@ int liberofs_global_init(void)
 #ifdef S3EROFS_ENABLED
 	xmlInitParser();
 #endif
+#ifdef EROFS_MT_ENABLED
+	{
+		int workers = erofs_get_available_processors();
+		if (workers < 1) 
+			workers = 1;
+		erofs_alloc_workqueue(&z_erofs_mt_wq, workers, 256, NULL, NULL);
+	}
+#endif
 #ifdef HAVE_LIBCURL
 	if (!erofs_global_curl_initialized) {
 		if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK) {
@@ -45,6 +59,9 @@ void liberofs_global_exit(void)
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
2.53.0


