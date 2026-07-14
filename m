Return-Path: <linux-erofs+bounces-3888-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LcrjHK+MVWrBpwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3888-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 03:11:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 106AD74FF98
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 03:11:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rE3HC6Wm;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3888-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3888-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzh8C3SJNz2yY0;
	Tue, 14 Jul 2026 11:11:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783991467;
	cv=none; b=B7rYC7J6JrMQmhXfCYaDpWyYm9pcCt2MRBIiFJYfLS0dZxQE7bmpMZzptcoaIMM3zElN1u9KUWJVjy+umzm8nSuEGUfXKIAgJRXxeUVONdwCKK8FQXCHAoVxHSmlWtQv13vhsWHzCXUfPz+Iog4C4p+DKrJowvuJfOx7R+YUm1GPNKVyClMltU008aE7kGlpO92xzIu4O7QRgBNQ42+c3FAaNcve0XdfQxER7Vk0RGw6TwpwXF7o85TAv6zelCIXL3HAj+0MzzHgGX5Ne27iL2tt614SLL47ksxpq1pT0F6IQZq9jVT0/kduS8gdZdVV+fWOhxOagMsa8RjjytzNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783991467; c=relaxed/relaxed;
	bh=YF5cvmE9fkaVqmI135B0VVKm1eVEwT13qBu9QJkzxfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hz6umU0z+RtwKw7wf1iNgzJdQ34MyVbxdUKooV7+4kQmZ9P2RZoLuzPq97xhdfHawSuwD8096HyOCurfv7Ssh/g1tgRQNNjC8DjV3/3zvNvDF0g3iHBLWes7Al7+SsNEQLgDaByF91t4ado1zmRXV1rJ0gCDcY67koY17BuoKrI8QdMv3bX90oKxTQdOg5DSN45urdWbXVulYwI1ZdTpGz1b0MgaiLtqPOrPjN4W84f/hhiaSD3ODQkw8ud1kLwDJvsyauXnVdL+D5j3rFb1+JrpK+bMpxSdJJ7cFHFvnISQZWq419iD7M1yddtSDyffdlCT16xE9thsVJ58loaqyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rE3HC6Wm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzh893tGqz2xVY
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 11:11:04 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-84a2dcede83so585301b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783991462; x=1784596262; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YF5cvmE9fkaVqmI135B0VVKm1eVEwT13qBu9QJkzxfY=;
        b=rE3HC6WmJvAnkEuBcbRVZTcYdAUzXTZFAcUpY9VZtX8AykAly4bj0LZJ6G3il/eLfW
         cq6rYConsuKxRENluNnwMmaHksf/0+cph7ETg5ZcQo2LDPGYSmDDB29utv+83ToOxPBt
         yOzS5HtEbdjI/sbIZW7sX4WpRnxa3cxADK0UT/akONUz3/pdoaI35wR/55ehQweYJ3TU
         EEN43JfqPBBUB/I8CkspnArjqb8RmIQoaiogvBr3mNVtyLqP41kIFw9vd+S39Vy/4ziL
         l3rtr6MYssjdrWUntcBk0QTzT8sM9viZ1pAzfz4rcVyqMuT80EpeiA7PPSw/CXie+xI5
         2scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783991462; x=1784596262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YF5cvmE9fkaVqmI135B0VVKm1eVEwT13qBu9QJkzxfY=;
        b=M2p6mTJBknswqWRCcOajZDPAUjSQV/RAiEhJniEowntOWUrrlMPZmiWD+PLUy30ilo
         nE2CBWraegmRtoj1SzunJTFBv/mJzXMgWlLe92AMGG3NMGQ54Nddlqh2cNt925x8o/mY
         s9x0V3aunYgjQtUEJKZd4W2J605bTQhMFdjCtltETC1OotV2/Hb2r7/+XZoAxN/6eUpS
         Dv6But0wqRhzv0zvU+NeQlNen1uTuPP35HR/oYnWil9DvhtTzRWrpCO7+g5+fNC98uU2
         zgjfgrBpHItDQiBCNDxsgqpRKa8HysJqsUMTvmMYVSCjt4ki0XJ15cmN6YoIE5BP+/Rx
         jOqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpgc9ewv5U1LuqIr2C+CI4bSpHup4jsGHyA/ixzOgM7hmaWDmJ3xcwAptLZLHkrf2uIO0ag8yHjaW1IKw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywc2QAHm2FdVkxGLX3e5D3cz/X5g1yYYb2XxE/AcXtEVISjV96d
	QZA2gOt5tUgmxc0rfRm6s8nMXJay4EUw6Szpih6E4mp4Fx4FtWO63foX
X-Gm-Gg: AfdE7ckDI3dwiBLzc4ye3cVMN1oVFNtUxg7xvim/DE+ZyEicHfFB6XSWbv7HMnS3nQb
	NPaxI4a8ZK8dVZ/rw4CUAuzRR9+M3Jt58BMCQ3+r//ozdw8YXoXxQ3BBytTQ3iHOOZjn7EpDsec
	H8jttbKOOtYL6HaROUzxxLoWBHDCA2CfkUmYUSsgZNGTwuFAc7bW0jZiLnGqjCJv4yNxhPIw3CT
	GbeKTn40KJeS8vz5BJuNIWPItodJxn+Q52Pjg0Uc33MkO9IKXcAlmSo/zCEJ77x30uKhgxLtLe9
	mqnHebyc0EQBPdynpJy1DpL+FO8Z4hHKmbVjEmxxVYr5TFEgb9dkh5y0G7yKdYZInuro1FORBVK
	Hdi2i0fbssxUNCE3FATtmcMufPQUrDGoiI3zAzVYrHKtiK8GrWA6dUGlgxWqfJqikOxrQ1DeK31
	Dk2gk3mdJzeIWLos129xohDtpRSvu9eWuOeS/OzJG5eHu8OQ==
X-Received: by 2002:a05:6a21:495:b0:3bf:6c08:2847 with SMTP id adf61e73a8af0-3c1108c1f79mr11965483637.54.1783991461420;
        Mon, 13 Jul 2026 18:11:01 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm67389785c88.13.2026.07.13.18.10.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 18:11:01 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v5] fsck.erofs: add multi-threaded decompression
Date: Tue, 14 Jul 2026 06:40:54 +0530
Message-ID: <20260714011054.71167-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260621120121.73114-3-nithurshen.dev@gmail.com>
References: <20260621120121.73114-3-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3888-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 106AD74FF98

Currently, fsck.erofs extracts files synchronously. When decompressing
heavily packed images, the main thread spends the majority of its time
blocked on a combination of synchronous I/O syscalls and CPU-heavy
decompression routines, bottlenecking overall extraction speed.

This patch introduces a scalable, multi-threaded decompression framework
to decouple compute operations from the main thread's I/O. This is
achieved by implementing a dedicated, per-CPU worker queue system
alongside custom condition variable wrappers to handle decompression
tasks asynchronously.

To prevent massive scheduling overhead (futex contention) where worker
threads spend more CPU time waking up than actually decompressing small
clusters, this implementation introduces a batching context
(`z_erofs_mt_read_ctx`). Because different compression algorithms exhibit
vastly different scheduling thresholds, the batch limit is algorithm-aware,
and multi-threading is bypassed entirely for files under a 128KB threshold.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c              | 136 +++++++++++++---
 include/erofs/cond.h     |  31 ++++
 include/erofs/internal.h |  20 ++-
 include/erofs/lock.h     |   2 +
 lib/data.c               | 336 ++++++++++++++++++++++++++++++++++++---
 lib/global.c             |  11 +-
 6 files changed, 484 insertions(+), 52 deletions(-)
 create mode 100644 include/erofs/cond.h

diff --git a/fsck/main.c b/fsck/main.c
index b2d8f1a..be1d3c5 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -16,6 +16,7 @@
 #include "../lib/compressor.h"
 #include "../lib/liberofs_compress.h"
 #include "../lib/liberofs_sha256.h"
+#include "erofs/internal.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
@@ -513,6 +514,8 @@ out:
 	return ret;
 }
 
+#define EROFS_MT_THRESHOLD (128 * 1024)
+
 static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 				   struct sha256_state *digest)
 {
@@ -526,6 +529,19 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 	u64 pchunk_len = 0;
 	u64 raw_size = 0, buffer_size = 0;
 	char *raw = NULL, *buffer = NULL;
+	struct z_erofs_mt_read_ctx *ctx = NULL;
+
+	if (!digest && inode->i_size > EROFS_MT_THRESHOLD) {
+		ctx = z_erofs_mt_read_ctx_alloc(outfd, true);
+		if (!ctx)
+			return -ENOMEM;
+	}
+	if (outfd >= 0) {
+			if (ftruncate(outfd, inode->i_size) < 0) {
+				erofs_warn("failed to pre-allocate file to %llu", 
+				           (unsigned long long)inode->i_size);
+			}
+	}
 
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
 		  inode->nid | 0ULL, inode->datalayout);
@@ -569,7 +585,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 						(const u8 *)zeros, chunk);
 					remain -= chunk;
 				}
-			} else if (outfd >= 0) {
+			} else if (!ctx && outfd >= 0) {
 				ret = lseek(outfd, map.m_llen, SEEK_CUR);
 				if (ret < 0) {
 					ret = -errno;
@@ -592,8 +608,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
 			alloc_rawsize = map.m_plen;
 		}
 
-		if (alloc_rawsize > raw_size) {
-			char *newraw = realloc(raw, alloc_rawsize);
+		if (!ctx) {
+			if (alloc_rawsize > raw_size) {
+				char *newraw = realloc(raw, alloc_rawsize);
 
 			if (!newraw) {
 				ret = -ENOMEM;
@@ -602,9 +619,22 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
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
+				c_buf = malloc(map.m_llen);
+				if (!c_raw || !c_buf) {
+					free(c_raw);
+					free(c_buf);
+					ret = -ENOMEM;
+					goto out;
+				}
+			} else if (map.m_llen > buffer_size) {
 				char *newbuffer;
 
 				buffer_size = map.m_llen;
@@ -614,45 +644,99 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd,
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
+			if (ret < 0) {
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
+				c_raw = malloc(alloc_rawsize);
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
+				if (ret < 0) {
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
+	/* use ftruncate to handle trailing unmapped blocks (holes) */
+	if (outfd >= 0 && ret == 0) {
+		if (ftruncate(outfd, inode->i_size) < 0) {
+			erofs_err("failed to truncate file to %llu: %d", 
+					(unsigned long long)inode->i_size, errno);
+			if (ret == 0) 
+				ret = -errno;
+		}
+	}
+
+	if (ctx) {
+		z_erofs_mt_read_ctx_free(ctx);
+	}
 	if (raw)
 		free(raw);
 	if (buffer)
@@ -1127,7 +1211,9 @@ int main(int argc, char *argv[])
 {
 	int err;
 
-	erofs_init_configure();
+	err = liberofs_global_init();
+	if (err)
+		return 1;
 
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
@@ -1283,7 +1369,7 @@ exit_dev_close:
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
index 2cc9cc8..6d3d407 100644
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
@@ -451,6 +457,17 @@ struct z_erofs_paramset {
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
+int z_erofs_mt_workers_init(void);
+void z_erofs_mt_workers_exit(void);
+
 int liberofs_global_init(void);
 void liberofs_global_exit(void);
 
@@ -487,7 +504,8 @@ int erofs_read_one_data(struct erofs_inode *inode, struct erofs_map_blocks *map,
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
index 1bb9269..ef9f29b 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,228 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 #include "liberofs_fragments.h"
+#include "erofs/lock.h"
+
+#ifdef EROFS_MT_ENABLED
+#include "erofs/config.h"
+
+struct z_erofs_percpu_queue {
+	erofs_mutex_t lock;
+	erofs_cond_t cond;
+	struct z_erofs_decompress_task *head;
+	struct z_erofs_decompress_task *tail;
+	int pending_tasks;
+	bool shutdown;
+	pthread_t thread;
+} __attribute__((aligned(64)));
+
+static struct z_erofs_percpu_queue *worker_queues;
+static int num_workers;
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
+	struct z_erofs_decompress_task *next;
+	struct z_erofs_mt_read_ctx *ctx;
+	struct z_erofs_decompress_item items[Z_EROFS_PCLUSTER_MAX_BATCH_SIZE];
+	unsigned int nr_reqs;
+};
+
+static void z_erofs_process_task(struct z_erofs_decompress_task *task)
+{
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
+#ifdef EROFS_MT_ENABLED
+static void *z_erofs_worker_thread(void *arg)
+{
+	struct z_erofs_percpu_queue *q = arg;
+
+	while (1) {
+		erofs_mutex_lock(&q->lock);
+		while (!q->head && !q->shutdown)
+			erofs_cond_wait(&q->cond, &q->lock);
+
+		if (q->shutdown && !q->head) {
+			erofs_mutex_unlock(&q->lock);
+			break;
+		}
+
+		struct z_erofs_decompress_task *tasks = q->head;
+		q->head = q->tail = NULL;
+		q->pending_tasks = 0;
+		erofs_mutex_unlock(&q->lock);
+
+		while (tasks) {
+			struct z_erofs_decompress_task *task = tasks;
+			tasks = tasks->next;
+			z_erofs_process_task(task);
+		}
+	}
+	return NULL;
+}
+
+int z_erofs_mt_workers_init(void)
+{
+	int i;
+	num_workers = erofs_get_available_processors();
+	if (num_workers < 1)
+		num_workers = 1;
+	
+	worker_queues = calloc(num_workers, sizeof(*worker_queues));
+	if (!worker_queues)
+		return -ENOMEM;
+
+	for (i = 0; i < num_workers; ++i) {
+		erofs_mutex_init(&worker_queues[i].lock);
+		erofs_cond_init(&worker_queues[i].cond);
+		worker_queues[i].head = worker_queues[i].tail = NULL;
+		worker_queues[i].pending_tasks = 0;
+		worker_queues[i].shutdown = false;
+		pthread_create(&worker_queues[i].thread, NULL, z_erofs_worker_thread, &worker_queues[i]);
+	}
+	return 0;
+}
+
+void z_erofs_mt_workers_exit(void)
+{
+	int i;
+	if (!worker_queues) return;
+	for (i = 0; i < num_workers; ++i) {
+		erofs_mutex_lock(&worker_queues[i].lock);
+		worker_queues[i].shutdown = true;
+		erofs_cond_signal(&worker_queues[i].cond);
+		erofs_mutex_unlock(&worker_queues[i].lock);
+
+		pthread_join(worker_queues[i].thread, NULL);
+		erofs_cond_destroy(&worker_queues[i].cond);
+		erofs_mutex_destroy(&worker_queues[i].lock);
+	}
+	free(worker_queues);
+	worker_queues = NULL;
+}
+#endif
+
+void z_erofs_mt_read_enqueue(struct z_erofs_mt_read_ctx *ctx)
+{
+#ifdef EROFS_MT_ENABLED
+	static int next_worker = 0;
+#endif
+
+	if (!ctx || !ctx->current_task)
+		return;
+
+	struct z_erofs_decompress_task *task = ctx->current_task;
+	ctx->current_task = NULL;
+
+#ifdef EROFS_MT_ENABLED
+	if (num_workers > 0) {
+		int target = next_worker;
+		next_worker = (next_worker + 1) % num_workers;
+		struct z_erofs_percpu_queue *q = &worker_queues[target];
+
+		erofs_mutex_lock(&q->lock);
+		task->next = NULL;
+		if (!q->tail) {
+			q->head = q->tail = task;
+		} else {
+			q->tail->next = task;
+			q->tail = task;
+		}
+		q->pending_tasks++;
+		erofs_cond_signal(&q->cond);
+		erofs_mutex_unlock(&q->lock);
+		return;
+	}
+#endif
+	task->next = NULL;
+	z_erofs_process_task(task);
+}
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
@@ -277,20 +499,29 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
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
+		}
+		ret = erofs_packedfile_read(sbi, buffer, length - skip,
+					inode->fragmentoff + skip);
+		if (ret >= 0 && ctx && ctx->outfd >= 0) {
+			if (pwrite(ctx->outfd, buffer, length - skip, out_offset) < 0)
+				ret = -errno;
 		}
-		return erofs_packedfile_read(sbi, buffer, length - skip,
-				   inode->fragmentoff + skip);
+		goto err_out;
 	}
 
 	/* no device id here, thus it will always succeed */
@@ -300,31 +531,86 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
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
+		task = malloc(sizeof(*task));
+		if (!task) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
+		task->nr_reqs = 0;
+		task->ctx = ctx;
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
+	batch_limit = (map->m_algorithmformat == Z_EROFS_COMPRESSION_LZ4 ||
+						map->m_algorithmformat == Z_EROFS_COMPRESSION_LZ4) ?
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
@@ -387,7 +673,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		ret = z_erofs_read_one_data(inode, &map, raw,
-				buffer + end - offset, skip, length, trimmed);
+				buffer + end - offset, skip, length, trimmed, 0, NULL);
 		if (ret < 0)
 			break;
 	}
diff --git a/lib/global.c b/lib/global.c
index 938aa0a..8bb9da0 100644
--- a/lib/global.c
+++ b/lib/global.c
@@ -12,6 +12,7 @@
 #include "erofs/err.h"
 #include "erofs/config.h"
 #include "liberofs_compress.h"
+#include "erofs/internal.h"
 
 static EROFS_DEFINE_MUTEX(erofs_global_mutex);
 #ifdef HAVE_LIBCURL
@@ -27,6 +28,11 @@ int liberofs_global_init(void)
 #ifdef S3EROFS_ENABLED
 	xmlInitParser();
 #endif
+#ifdef EROFS_MT_ENABLED
+	err = z_erofs_mt_workers_init();
+	if (err)
+		goto out_unlock;
+#endif
 #ifdef HAVE_LIBCURL
 	if (!erofs_global_curl_initialized) {
 		if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK) {
@@ -35,8 +41,8 @@ int liberofs_global_init(void)
 		}
 		erofs_global_curl_initialized = true;
 	}
-out_unlock:
 #endif
+out_unlock:
 	erofs_mutex_unlock(&erofs_global_mutex);
 	return err;
 }
@@ -45,6 +51,9 @@ void liberofs_global_exit(void)
 {
 	erofs_mutex_lock(&erofs_global_mutex);
 	z_erofs_mt_global_exit();
+#ifdef EROFS_MT_ENABLED
+	z_erofs_mt_workers_exit();
+#endif
 #ifdef HAVE_LIBCURL
 	if (erofs_global_curl_initialized) {
 		curl_global_cleanup();
-- 
2.53.0


