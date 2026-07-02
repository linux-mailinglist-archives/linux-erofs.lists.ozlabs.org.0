Return-Path: <linux-erofs+bounces-3799-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8HeBOREdRmrNKAsAu9opvQ
	(envelope-from <linux-erofs+bounces-3799-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 10:10:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC76F49FE
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 10:10:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RBAzK+SD;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3799-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3799-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grV252zYSz2xPb;
	Thu, 02 Jul 2026 18:10:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782979853;
	cv=none; b=awW7ooZY4h6mdd7VTxbxn5yNH0u0zPOQkVuzK/QY4+pIKWjdWOjchPp/7BvRoi/NeSteK19mG58keDF/zlU47ppOg+0LIF9qMVNcCCwY+iGqwdorfe9FdfSQWneMmVhgO/4hLIBBgw4GeB6GrhkoV9hR1kanC9wbg/P2MCv9La9B/GYws418T3ueJAekOMkDefphU5C2AzEmAi2wjHmBC7TyssaNGnUfAYVM4VyKYFBRdSTvkkSvubSYAQ5LZ8jp44Y2hpg/fyoO8wm4+WAw5w0YkaJM2v6cWv4npqC7ls5yMppPWZ9g8VdYNjn/ApFVhj3pQH1dtMerWN7TOgXvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782979853; c=relaxed/relaxed;
	bh=thRsNzV+pA+ZLJNi6wkbjaYc2KJKeH/MmW51nmM5rAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+ASPn6zA4oEr8BlkcC2Hi2ESEhPa2JtNcbVDgsZagk8A5y9TcJZ6DYvkv7Fk4RaBIB9ElSVSLKrLSFs5pa0Prs2T9KKYCSXTe0eWtVCjc0AkYt9syy+MAMv2rSCp6XnwzaighfeuCA3TDd9ptIyz2qp4U6PZjt7yY/euxB0RXn/6unXVPXbekf+Gi7QtkKhuue6RnDz/Awi6eQnOe1hX0URqu5yRMusAet6jye5Kan2IDrkYp2xxBLvNkoBbdjlGD9jeRS2akKu06rV29f9Awvcfvcka9fb6pIUpi4YLcRPOFrgcnXbYoKKqkCFCAY6DRGP+yuahLQQujqXE1EWPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RBAzK+SD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grV226BfWz2xHK
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Jul 2026 18:10:49 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c89636920a3so645595a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Jul 2026 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782979842; x=1783584642; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=thRsNzV+pA+ZLJNi6wkbjaYc2KJKeH/MmW51nmM5rAk=;
        b=RBAzK+SDpYpZfybW1/QsbMocfEnmPrXoN4ijucCCyIf5WSoECJbABmOSHAuFoI2o4g
         UXktkpASJc9v0RKXfXCGR6669dAzRjmeTwlOjInIT6ntX7/Rv1PEWdUUh4GrP6Qzy2F7
         Y6iyHICeP/tyOprkYiRZv58tlF6cIzzvcOPNPQT5KGEOUV029YSoAJzR6+ITDtpF13sS
         xTxS9ah8xfexpgSH2WCRL3eMMFN5anNIzpBRlZsy8UDqsLkdSIJGmpoaMI3SEtX+GXSu
         IjADSMM9DeWCUTeBnfOaFjcorAB9tI5wdql46IUtUYE4LFPXZHhIl0kc5q3J/oO+HL/r
         EFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979842; x=1783584642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thRsNzV+pA+ZLJNi6wkbjaYc2KJKeH/MmW51nmM5rAk=;
        b=mFXRL+BQz0jEvWP7apUXVbZ4A+QVbvrLPJV213qOyLMccErxNBTPFvUl3/yt+k/k13
         AO00UKG6Zvj+WAV16GdL1OoZngb6o5sGy+1yLtzAuXHLH9xhDb/3zZMyB9sqbfnxHAzK
         6PQxq1rX7B3mIzDsm+gQpaUyvZ6tmJoO4ctDCvoPyBHtdggZ1n+kBsCb+djADzvUrQ6N
         v1P5+wnZGfSJPztCdtx8xVmvCjiGFq7Oyr6j5o/zCPtXMr6wwTC26n/I6EwwOAz3uTFh
         Qr9btM19wbu3ogqD/q/DedxiPYtXOjyu503p9MYrXAt32imjcJQXEnO4cskbHueZxHsg
         0yxA==
X-Gm-Message-State: AOJu0YyFhsoyg2AoZdpfKRvwcv2q3fkw52OOwIL53LLyhCBER6wnlflT
	25l30Rz+/DnwFR+Q2nm8EuOQbejE/jIuJDLcgjqKlpn+l9AyDel6SpCosmaq8w==
X-Gm-Gg: AfdE7ckgadnbh92ijhurCjJrQv2LjjGLxRwoUH3M4U2kZ81H7dUrgjNp5os/gN/NFn9
	uo0J6xqfkezIDyaEifq/AqIXx+hlc/5SwzA3WvyTuZrw/dsCz9NuZJaR3X3H3AJxhfIAyTuw+YQ
	xvvGoGZXwQ2jDClZBrjDVlgdKjORDgMX03c2FyCPdrSjFk9VmRqxufYFv08eGjc7iOA4fwCQn4O
	h9VMfsPkHnKYxiPLKy+0FTX0zzk66wfi3oG3x/ehznttBNSyTVL+7eZDWl3iLqcWfA94AQlA8JR
	m51gtsVQdH0d21flhgUKPtky9udq8eAro26WEQEdJWNFY9/K79TC3+6sZb/tY3FjD2LmuMQ8JAs
	jAgkCt63cRWhBIp3JLj8Z3TiTWWuIngKxON0v2osNR1R1rF9Fufa33A281kZOd0JtNGQFl7AW2z
	We3aDgtJ9Rozk/8qrJzpwfDXtxTBNUM5/4yq36nrRP6Vtw
X-Received: by 2002:a05:6a21:3a83:b0:3bf:63af:85d with SMTP id adf61e73a8af0-3bff40a528emr5680304637.18.1782979842142;
        Thu, 02 Jul 2026 01:10:42 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a8asm6995082eec.2.2026.07.02.01.10.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 01:10:41 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: nithurshen.dev@gmail.com,
	xiang@kernel.org,
	hsiangkao@alibaba.com
Subject: [PATCH] erofs-utils: fsck: add concurrent extraction and decompression
Date: Thu,  2 Jul 2026 13:40:30 +0530
Message-ID: <20260702081030.10038-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URI_NOVOWEL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3799-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dirstack.top:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EADC76F49FE

This patch introduces a multi-threaded pipeline for fsck.erofs,
combining parallel directory traversal with background pcluster
decompression to significantly reduce extraction time.

Key architectural changes include:

- Thread-Safe State: Removes the global dirstack array and
  fsckcfg.extract_path. These are replaced with per-task localized
  paths and thread-local linked lists to eliminate data races.
- Concurrent Traversal: Refactors erofsfsck_dirent_iter to allocate
  task structures and dispatch inode processing to a background
  workqueue (z_erofs_mt_wq).
- Asynchronous Decompression: Introduces z_erofs_mt_read_ctx to
  batch pcluster reads and decouple decompression from main I/O.
  Limits batch size dynamically (32 for LZ4, 8 for compute-heavy
  algorithms) to balance CPU cache hits and memory overhead.
- Memory & Deadlock Safety: Implements inline backpressure during
  directory iteration. If pending inodes exceed workqueue capacity,
  execution falls back to synchronous processing to prevent
  recursive thread-pool starvation and unbounded memory growth.
- Synchronization Primitives: Adds portable condition variable
  wrappers (erofs_cond_t) to ensure the main thread safely waits
  for all pending background inodes before exiting.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c              | 446 ++++++++++++++++++++++++---------------
 include/erofs/cond.h     |  31 +++
 include/erofs/internal.h |  15 +-
 include/erofs/lock.h     |   3 +
 lib/data.c               | 248 +++++++++++++++++-----
 5 files changed, 525 insertions(+), 218 deletions(-)
 create mode 100644 include/erofs/cond.h

diff --git a/fsck/main.c b/fsck/main.c
index 16cc627..15500ce 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -8,23 +8,43 @@
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
 
-static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
-
 struct erofsfsck_dirstack {
-	erofs_nid_t dirs[PATH_MAX];
-	int top;
+	erofs_nid_t nid;
+	struct erofsfsck_dirstack *parent;
+	int depth;
 };
 
+static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid, const char *path,
+                 struct erofsfsck_dirstack *dirstack);
+
+#ifdef EROFS_MT_ENABLED
+static EROFS_DEFINE_MUTEX(erofsfsck_mt_lock);
+static erofs_cond_t erofsfsck_mt_cond;
+static int erofsfsck_pending_inodes = 0;
+static int erofsfsck_global_err = 0;
+extern struct erofs_workqueue z_erofs_mt_wq;
+static struct erofs_workqueue erofsfsck_wq;
+
+struct erofsfsck_inode_task {
+	struct erofs_work work;
+	erofs_nid_t pnid;
+	erofs_nid_t nid;
+	char *path;
+	struct erofsfsck_dirstack *dirstack;
+};
+#endif
+
 struct erofsfsck_cfg {
-	struct erofsfsck_dirstack dirstack;
 	u64 physical_blocks;
 	u64 logical_blocks;
 	char *extract_path;
@@ -306,7 +326,7 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
 	int ret;
 
 	/* don't apply attributes when fsck is used without extraction */
-	if (!fsckcfg.extract_path)
+	if (!path)
 		return;
 
 #ifdef HAVE_UTIMENSAT
@@ -509,32 +529,27 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		.buf = __EROFS_BUF_INITIALIZER,
 	};
 	bool needdecode = fsckcfg.check_decomp && !erofs_is_packed_inode(inode);
-	int ret = 0;
+	int ret = 0, wait_err;
 	bool compressed;
 	erofs_off_t pos = 0;
 	u64 pchunk_len = 0;
-	unsigned int raw_size = 0, buffer_size = 0;
-	char *raw = NULL, *buffer = NULL;
+	struct z_erofs_mt_read_ctx *ctx;
 
 	erofs_dbg("verify data chunk of nid(%llu): type(%d)",
-		  inode->nid | 0ULL, inode->datalayout);
+		inode->nid | 0ULL, inode->datalayout);
 
+	ctx = z_erofs_mt_read_ctx_alloc(outfd, true);
+	if (!ctx)
+		return -ENOMEM;
+	
 	compressed = erofs_inode_is_data_compressed(inode->datalayout);
-	while (pos < inode->i_size) {
-		unsigned int alloc_rawsize;
 
+	while (pos < inode->i_size) {
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
 		/* the last lcluster can be divided into 3 parts */
 		if (map.m_la + map.m_llen > inode->i_size)
 			map.m_llen = inode->i_size - map.m_la;
@@ -555,92 +570,60 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
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
 
-static inline int erofs_extract_dir(struct erofs_inode *inode)
+static inline int erofs_extract_dir(struct erofs_inode *inode, const char* path)
 {
 	int ret;
 
-	erofs_dbg("create directory %s", fsckcfg.extract_path);
+	erofs_dbg("create directory %s", path);
 
 	/* verify data chunk layout */
 	ret = erofs_verify_inode_data(inode, -1);
@@ -653,19 +636,19 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 	 * write/execute permission.  These are fixed up later in
 	 * erofsfsck_set_attributes().
 	 */
-	if (mkdir(fsckcfg.extract_path, 0700) < 0) {
+	if (mkdir(path, 0700) < 0) {
 		struct stat st;
 
 		if (errno != EEXIST) {
 			erofs_err("failed to create directory: %s (%s)",
-				  fsckcfg.extract_path, strerror(errno));
+				  path, strerror(errno));
 			return -errno;
 		}
 
-		if (lstat(fsckcfg.extract_path, &st) ||
+		if (lstat(path, &st) ||
 		    !S_ISDIR(st.st_mode)) {
 			erofs_err("path is not a directory: %s",
-				  fsckcfg.extract_path);
+				  path);
 			return -ENOTDIR;
 		}
 
@@ -673,9 +656,9 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 		 * Try to change permissions of existing directory so
 		 * that we can write to it
 		 */
-		if (chmod(fsckcfg.extract_path, 0700) < 0) {
+		if (chmod(path, 0700) < 0) {
 			erofs_err("failed to set permissions: %s (%s)",
-				  fsckcfg.extract_path, strerror(errno));
+				  path, strerror(errno));
 			return -errno;
 		}
 	}
@@ -739,37 +722,37 @@ static void erofsfsck_hardlink_exit(void)
 	}
 }
 
-static inline int erofs_extract_file(struct erofs_inode *inode)
+static inline int erofs_extract_file(struct erofs_inode *inode, const char* path)
 {
 	bool tryagain = true;
 	int ret, fd;
 
-	erofs_dbg("extract file to path: %s", fsckcfg.extract_path);
+	erofs_dbg("extract file to path: %s", path);
 
 again:
-	fd = open(fsckcfg.extract_path,
+	fd = open(path,
 		  O_WRONLY | O_CREAT | O_NOFOLLOW |
 			(fsckcfg.overwrite ? O_TRUNC : O_EXCL), 0700);
 	if (fd < 0) {
 		if (fsckcfg.overwrite && tryagain) {
 			if (errno == EISDIR) {
 				erofs_warn("try to forcely remove directory %s",
-					   fsckcfg.extract_path);
-				if (rmdir(fsckcfg.extract_path) < 0) {
+					   path);
+				if (rmdir(path) < 0) {
 					erofs_err("failed to remove: %s (%s)",
-						  fsckcfg.extract_path, strerror(errno));
+						  path, strerror(errno));
 					return -EISDIR;
 				}
 			} else if (errno == EACCES &&
-				   chmod(fsckcfg.extract_path, 0700) < 0) {
+				   chmod(path, 0700) < 0) {
 				erofs_err("failed to set permissions: %s (%s)",
-					  fsckcfg.extract_path, strerror(errno));
+					  path, strerror(errno));
 				return -errno;
 			}
 			tryagain = false;
 			goto again;
 		}
-		erofs_err("failed to open: %s (%s)", fsckcfg.extract_path,
+		erofs_err("failed to open: %s (%s)", path,
 			  strerror(errno));
 		return -errno;
 	}
@@ -780,14 +763,14 @@ again:
 	return ret;
 }
 
-static inline int erofs_extract_symlink(struct erofs_inode *inode)
+static inline int erofs_extract_symlink(struct erofs_inode *inode, const char* path)
 {
 	struct erofs_vfile vf;
 	bool tryagain = true;
 	int ret;
 	char *buf = NULL;
 
-	erofs_dbg("extract symlink to path: %s", fsckcfg.extract_path);
+	erofs_dbg("extract symlink to path: %s", path);
 
 	/* verify data chunk layout */
 	ret = erofs_verify_inode_data(inode, -1);
@@ -813,13 +796,13 @@ static inline int erofs_extract_symlink(struct erofs_inode *inode)
 
 	buf[inode->i_size] = '\0';
 again:
-	if (symlink(buf, fsckcfg.extract_path) < 0) {
+	if (symlink(buf, path) < 0) {
 		if (errno == EEXIST && fsckcfg.overwrite && tryagain) {
 			erofs_warn("try to forcely remove file %s",
-				   fsckcfg.extract_path);
-			if (unlink(fsckcfg.extract_path) < 0) {
+				   path);
+			if (unlink(path) < 0) {
 				erofs_err("failed to remove: %s",
-					  fsckcfg.extract_path);
+					  path);
 				ret = -errno;
 				goto out;
 			}
@@ -827,7 +810,7 @@ again:
 			goto again;
 		}
 		erofs_err("failed to create symlink: %s",
-			  fsckcfg.extract_path);
+			  path);
 		ret = -errno;
 	}
 out:
@@ -836,12 +819,12 @@ out:
 	return ret;
 }
 
-static int erofs_extract_special(struct erofs_inode *inode)
+static int erofs_extract_special(struct erofs_inode *inode, const char* path)
 {
 	bool tryagain = true;
 	int ret;
 
-	erofs_dbg("extract special to path: %s", fsckcfg.extract_path);
+	erofs_dbg("extract special to path: %s", path);
 
 	/* verify data chunk layout */
 	ret = erofs_verify_inode_data(inode, -1);
@@ -849,13 +832,13 @@ static int erofs_extract_special(struct erofs_inode *inode)
 		return ret;
 
 again:
-	if (mknod(fsckcfg.extract_path, inode->i_mode, inode->u.i_rdev) < 0) {
+	if (mknod(path, inode->i_mode, inode->u.i_rdev) < 0) {
 		if (errno == EEXIST && fsckcfg.overwrite && tryagain) {
 			erofs_warn("try to forcely remove file %s",
-				   fsckcfg.extract_path);
-			if (unlink(fsckcfg.extract_path) < 0) {
+				   path);
+			if (unlink(path) < 0) {
 				erofs_err("failed to remove: %s",
-					  fsckcfg.extract_path);
+					  path);
 				return -errno;
 			}
 			tryagain = false;
@@ -863,28 +846,73 @@ again:
 		}
 		if (errno == EEXIST || fsckcfg.superuser) {
 			erofs_err("failed to create special file: %s",
-				  fsckcfg.extract_path);
+				  path);
 			ret = -errno;
 		} else {
 			erofs_warn("failed to create special file: %s, skipped",
-				   fsckcfg.extract_path);
+				   path);
 			ret = -ECANCELED;
 		}
 	}
 	return ret;
 }
 
-struct erofsfsck_get_parent_ctx {
+#ifdef EROFS_MT_ENABLED
+static void erofsfsck_inode_worker(struct erofs_work *work, void *tlsp)
+{
+    struct erofsfsck_inode_task *task = (struct erofsfsck_inode_task *)work;
+    int ret;
+
+    ret = erofsfsck_check_inode(task->pnid, task->nid, task->path, task->dirstack);
+
+    erofs_mutex_lock(&erofsfsck_mt_lock);
+    if (ret < 0 && !erofsfsck_global_err)
+        erofsfsck_global_err = ret;
+
+    erofsfsck_pending_inodes--;
+    if (erofsfsck_pending_inodes == 0)
+        erofs_cond_signal(&erofsfsck_mt_cond);
+    erofs_mutex_unlock(&erofsfsck_mt_lock);
+
+	struct erofsfsck_dirstack *curr = task->dirstack;
+	while (curr) {
+		struct erofsfsck_dirstack *next = curr->parent;
+		free(curr);
+		curr = next;
+	}
+	task->dirstack = NULL;
+
+    free(task->path);
+    free(task->dirstack);
+    free(task);
+}
+
+static void erofsfsck_wait_pending_inodes(void)
+{
+    erofs_mutex_lock(&erofsfsck_mt_lock);
+    while (erofsfsck_pending_inodes > 0)
+        erofs_cond_wait(&erofsfsck_mt_cond, &erofsfsck_mt_lock);
+
+    if (erofsfsck_global_err && !fsckcfg.corrupted)
+        fsckcfg.corrupted = true;
+    erofs_mutex_unlock(&erofsfsck_mt_lock);
+}
+#else
+static void erofsfsck_wait_pending_inodes(void) {}
+#endif
+
+struct erofsfsck_dir_context {
 	struct erofs_dir_context ctx;
-	erofs_nid_t pnid;
+	const char *parent_path;
+	struct erofsfsck_dirstack *dirstack;
 };
 
 static int erofsfsck_get_parent_cb(struct erofs_dir_context *ctx)
 {
-	struct erofsfsck_get_parent_ctx *pctx = (void *)ctx;
+	struct erofsfsck_dir_context *dctx = (struct erofsfsck_dir_context *)ctx;
 
 	if (ctx->dot_dotdot && ctx->de_namelen == 2) {
-		pctx->pnid = ctx->de_nid;
+		dctx->ctx.pnid = ctx->de_nid;
 		return 1;
 	}
 	return 0;
@@ -892,45 +920,89 @@ static int erofsfsck_get_parent_cb(struct erofs_dir_context *ctx)
 
 static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 {
-	int ret;
-	size_t prev_pos, curr_pos;
+	struct erofsfsck_dir_context *dctx = (struct erofsfsck_dir_context *)ctx;
+	int ret = 0;
+	char *path = NULL;
 
 	if (ctx->dot_dotdot)
 		return 0;
 
-	prev_pos = fsckcfg.extract_pos;
-	curr_pos = prev_pos;
+	if (dctx->parent_path) {
+		size_t plen = strlen(dctx->parent_path);
+		if (plen + 1 + ctx->de_namelen >= PATH_MAX)
+			return -ENAMETOOLONG;
 
-	if (prev_pos + ctx->de_namelen >= PATH_MAX) {
-		erofs_err("unable to fsck since the path is too long (%llu)",
-			  (curr_pos + ctx->de_namelen) | 0ULL);
-		return -EOPNOTSUPP;
+		path = malloc(plen + 1 + ctx->de_namelen + 1);
+		if (!path)
+			return -ENOMEM;
+		snprintf(path, PATH_MAX, "%s/%.*s", dctx->parent_path,
+			(int)ctx->de_namelen, ctx->dname);
 	}
 
-	if (fsckcfg.extract_path) {
-		fsckcfg.extract_path[curr_pos++] = '/';
-		strncpy(fsckcfg.extract_path + curr_pos, ctx->dname,
-			ctx->de_namelen);
-		curr_pos += ctx->de_namelen;
-		fsckcfg.extract_path[curr_pos] = '\0';
+#ifdef EROFS_MT_ENABLED
+	bool queue_full = false;
+
+	erofs_mutex_lock(&erofsfsck_mt_lock);
+	/* Backpressure: Prevent recursive thread-pool deadlock */
+	if (erofsfsck_pending_inodes >= erofsfsck_wq.max_jobs) {
+		queue_full = true;
 	} else {
-		curr_pos += ctx->de_namelen;
+		erofsfsck_pending_inodes++;
 	}
-	fsckcfg.extract_pos = curr_pos;
-	ret = erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
+	erofs_mutex_unlock(&erofsfsck_mt_lock);
+
+	/* If space is available, offload to background workers */
+	if (!queue_full) {
+		struct erofsfsck_inode_task *task = calloc(1, sizeof(*task));
+		if (!task) {
+			erofs_mutex_lock(&erofsfsck_mt_lock);
+			erofsfsck_pending_inodes--;
+			erofs_mutex_unlock(&erofsfsck_mt_lock);
+			free(path);
+			return -ENOMEM;
+		}
 
-	if (fsckcfg.extract_path)
-		fsckcfg.extract_path[prev_pos] = '\0';
-	fsckcfg.extract_pos = prev_pos;
+		task->pnid = ctx->dir->nid;
+		task->nid = ctx->de_nid;
+		task->path = path;
+
+	if (dctx->dirstack) {
+		struct erofsfsck_dirstack *src = dctx->dirstack;
+		struct erofsfsck_dirstack *new_node = NULL;
+		struct erofsfsck_dirstack *prev_node = NULL;
+
+		// Build the stack from the bottom up to preserve order
+		while (src) {
+			new_node = malloc(sizeof(struct erofsfsck_dirstack));
+			if (!new_node) break;
+			
+			new_node->nid = src->nid;
+			new_node->depth = src->depth;
+			new_node->parent = prev_node;
+			
+			prev_node = new_node;
+			src = src->parent;
+		}
+		task->dirstack = prev_node;
+	}
+	task->work.fn = erofsfsck_inode_worker;
+	erofs_queue_work(&erofsfsck_wq, &task->work);
+	return 0;
+}
+#endif
+
+	/* Fallback: Execute synchronously if MT disabled or queue is full */
+	ret = erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid, path, dctx->dirstack);
+	free(path);
 	return ret;
 }
 
-static int erofsfsck_extract_inode(struct erofs_inode *inode)
+static int erofsfsck_extract_inode(struct erofs_inode *inode, const char *path)
 {
 	int ret;
 	char *oldpath;
 
-	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {
+	if (!path || erofs_is_packed_inode(inode)) {
 verify:
 		/* verify data chunk layout */
 		return erofs_verify_inode_data(inode, -1);
@@ -938,9 +1010,9 @@ verify:
 
 	oldpath = erofsfsck_hardlink_find(inode->nid);
 	if (oldpath) {
-		if (link(oldpath, fsckcfg.extract_path) == -1) {
+		if (link(oldpath, path) == -1) {
 			erofs_err("failed to extract hard link: %s (%s)",
-				  fsckcfg.extract_path, strerror(errno));
+				  path, strerror(errno));
 			return -errno;
 		}
 		return 0;
@@ -948,19 +1020,19 @@ verify:
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFDIR:
-		ret = erofs_extract_dir(inode);
+		ret = erofs_extract_dir(inode, path);
 		break;
 	case S_IFREG:
-		ret = erofs_extract_file(inode);
+		ret = erofs_extract_file(inode, path);
 		break;
 	case S_IFLNK:
-		ret = erofs_extract_symlink(inode);
+		ret = erofs_extract_symlink(inode, path);
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
-		ret = erofs_extract_special(inode);
+		ret = erofs_extract_special(inode, path);
 		break;
 	default:
 		/* TODO */
@@ -972,13 +1044,14 @@ verify:
 	/* record nid and old path for hardlink */
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		ret = erofsfsck_hardlink_insert(inode->nid,
-						fsckcfg.extract_path);
+						path);
 	return ret;
 }
 
-static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
+static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid, const char *path,
+				struct erofsfsck_dirstack *dirstack)
 {
-	int ret, i;
+	int ret;
 	struct erofs_inode inode = {.sbi = &g_sbi, .nid = nid};
 
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
@@ -997,7 +1070,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			goto out;
 	}
 
-	ret = erofsfsck_extract_inode(&inode);
+	ret = erofsfsck_extract_inode(&inode, path);
 	if (ret && ret != -ECANCELED)
 		goto out;
 
@@ -1008,26 +1081,39 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	}
 
 	if (S_ISDIR(inode.i_mode)) {
-		struct erofs_dir_context ctx = {
-			.flags = EROFS_READDIR_VALID_PNID,
-			.pnid = pnid,
-			.dir = &inode,
-			.cb = erofsfsck_dirent_iter,
+		struct erofsfsck_dirstack ds = {
+			.nid = pnid,
+			.parent = dirstack,
+			.depth = dirstack ? dirstack->depth + 1 : 0
 		};
 
-		/* XXX: support the deeper cases later */
-		if (fsckcfg.dirstack.top >= ARRAY_SIZE(fsckcfg.dirstack.dirs))
-			return -ENAMETOOLONG;
-		for (i = 0; i < fsckcfg.dirstack.top; ++i)
-			if (inode.nid == fsckcfg.dirstack.dirs[i])
-				return -ELOOP;
-		fsckcfg.dirstack.dirs[fsckcfg.dirstack.top++] = pnid;
-		ret = erofs_iterate_dir(&ctx, true);
-		--fsckcfg.dirstack.top;
+		struct erofsfsck_dir_context ctx = {
+			.ctx.flags = EROFS_READDIR_VALID_PNID,
+			.ctx.pnid = pnid,
+			.ctx.dir = &inode,
+			.ctx.cb = erofsfsck_dirent_iter,
+			.parent_path = path,
+			.dirstack = &ds
+		};
+
+		struct erofsfsck_dirstack *check_ds = dirstack;
+		while (check_ds) {
+			if (inode.nid == check_ds->nid) {
+				ret = -ELOOP;
+				goto out;
+			}
+			if (check_ds->depth >= PATH_MAX) {
+				ret = -ENAMETOOLONG;
+				goto out;
+			}
+			check_ds = check_ds->parent;
+		}
+
+		ret = erofs_iterate_dir(&ctx.ctx, true);
 	}
 
 	if (!ret && !erofs_is_packed_inode(&inode))
-		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
+		erofsfsck_set_attributes(&inode, (char *)path);
 
 	if (ret == -ECANCELED)
 		ret = 0;
@@ -1043,6 +1129,7 @@ int erofsfsck_fuzz_one(int argc, char *argv[])
 int main(int argc, char *argv[])
 #endif
 {
+
 	int err;
 
 	erofs_init_configure();
@@ -1120,7 +1207,8 @@ int main(int argc, char *argv[])
 				goto exit_hardlink;
 			}
 
-			err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
+			err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid,
+							fsckcfg.extract_path, NULL);
 			if (err) {
 				erofs_err("failed to verify packed file");
 				goto exit_packedinode;
@@ -1128,6 +1216,17 @@ int main(int argc, char *argv[])
 		}
 	}
 
+#ifdef EROFS_MT_ENABLED
+	erofs_cond_init(&erofsfsck_mt_cond);
+	
+	int workers = erofs_get_available_processors();
+	if (workers < 1) 
+		workers = 1;
+
+	erofs_alloc_workqueue(&erofsfsck_wq, workers, 256, NULL, NULL);
+	erofs_alloc_workqueue(&z_erofs_mt_wq, workers, 256, NULL, NULL);
+#endif
+
 	{
 		erofs_nid_t pnid = fsckcfg.nid;
 
@@ -1135,17 +1234,19 @@ int main(int argc, char *argv[])
 			struct erofs_inode inode = { .sbi = &g_sbi, .nid = fsckcfg.nid };
 
 			if (!erofs_read_inode_from_disk(&inode) &&
-			    S_ISDIR(inode.i_mode)) {
-				struct erofsfsck_get_parent_ctx ctx = {
+				S_ISDIR(inode.i_mode)) {
+				struct erofsfsck_dir_context ctx = {
 					.ctx.dir = &inode,
 					.ctx.cb = erofsfsck_get_parent_cb,
 				};
 
 				if (erofs_iterate_dir(&ctx.ctx, false) == 1)
-					pnid = ctx.pnid;
+					pnid = ctx.ctx.pnid;
 			}
 		}
-		err = erofsfsck_check_inode(pnid, fsckcfg.nid);
+		
+		err = erofsfsck_check_inode(pnid, fsckcfg.nid, fsckcfg.extract_path, NULL);
+		erofsfsck_wait_pending_inodes();
 	}
 
 	if (fsckcfg.corrupted) {
@@ -1169,6 +1270,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+#ifdef EROFS_MT_ENABLED
+	erofs_destroy_workqueue(&erofsfsck_wq);
+    erofs_destroy_workqueue(&z_erofs_mt_wq);
+#endif
+
 exit_packedinode:
 	erofs_packedfile_exit(&g_sbi);
 exit_hardlink:
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
index 6fd1389..6208d37 100644
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
+				  erofs_off_t size, erofs_off_t offset)
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
@@ -355,7 +509,6 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			length = end - map.m_la;
 			trimmed = true;
 		} else {
-			DBG_BUGON(end != map.m_la + map.m_llen);
 			length = map.m_llen;
 			trimmed = false;
 		}
@@ -374,25 +527,26 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
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
+				buffer + end - offset, skip, length, trimmed, 0, ctx);
 		if (ret < 0)
 			break;
+
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
 
-- 
2.52.0


