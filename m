Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF544D1A4
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 06:30:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HqVg94S0hz2yPM
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 16:30:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636608645;
	bh=qfGawMJeIPXnfisKlLzwDFNufJkELepuJfO21etKYK4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LMJcmV3KBuRRLFbhXYfOWTRmASafJ90UgADmwEB6oJlV+EzLE14q8A4ftyKDVrDwG
	 5Hi9p+1jNLcNUoMlq2EtdspSp/vCkQXS5cwqj0O6zfjLWR3ArX3wExqum3TGwaMLWc
	 Uq9xz5H6+okufSIZ8JBpLBqjmVueHZJExIpoKqNmGDfvmIwf6EdnvpzDD0EUa9gFiF
	 IWP0rvfBMk/OVNS7KJTQ21xUTgy6jrfcSg3YUazKHlG8C5++p6Oj1S4bDRBHB8zAYd
	 HdziWzA4gvioUi2KaSBOKL4cUj5ZESOASOoj82qN4cxu6yUQm1UsBbA7CoDr4xkakF
	 zy0uQ3UBM51yQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--dvander.bounces.google.com
 (client-ip=2607:f8b0:4864:20::a4a; helo=mail-vk1-xa4a.google.com;
 envelope-from=3eqqmyqckcxuygv8yzc19916z.x97638fi-zc90d63ded.9k6vwd.9c1@flex--dvander.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Y3/ssigA; dkim-atps=neutral
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HqVg54XQCz2yNK
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 16:30:39 +1100 (AEDT)
Received: by mail-vk1-xa4a.google.com with SMTP id
 n6-20020a1f2706000000b002a45b52f52dso2374611vkn.22
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 21:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=qfGawMJeIPXnfisKlLzwDFNufJkELepuJfO21etKYK4=;
 b=GU0fC08UNcvpRn4po9ULFmE61Fa/n7OWaoRqueGXrFyQ8MJwJjO32oRnAhjKENlrB5
 yGS0EFwPV6HUAI8tJXI/cmuShy+VD3mkSdAzp4JErikBzk3Z/uMySjX03l/TaLVRQzdw
 TGNgwSvbC7p3fB21MkeeeHdNGmZvfTjSSScqWTzNucAXQUas6O4seVW7mLgAtvn+FFRK
 ozzyf29qchBuyK58uKgNaOpUWcx+fpsLmA2ZLjWWW2qbK3wTHxzN/b5KwN3hUOUYg1od
 FyLAUwcCD9ZpXJKFE9L36qKQfBDGlGyVUeJerKxfiVAUr3L9/oQh7iiMQCtbTlK+QNwk
 uLvQ==
X-Gm-Message-State: AOAM533rGCVWO4Gv8dlbwjk9WB9XCDWGFQiuLU/PV7jmSRlVrBmqAec1
 0LIfM0uZKMmLTJ0vy4P84lsf7SaY9oVuZLDlXpMkSq708hQTGAI2Ae5795pxzM11JuzHKx1Jiaq
 DfEJHqXWKf4Hgc/E7Q+mZBCiKSKdenrosPBXBXz9VSTFhy5nWkzlWdgEvBlNE2FzqhuUWFbzs
X-Google-Smtp-Source: ABdhPJx3X6vOUbDa0VSnYyQvpF7XTCQMqK857ThinbAVIpoz/vIpP8s9VQFx4x6FFj2JjU1MUxDWY4m8dhQe
X-Received: from dvandertop.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:2862])
 (user=dvander job=sendgmr) by 2002:a67:db0b:: with SMTP id
 z11mr6655038vsj.59.1636608634440; Wed, 10 Nov 2021 21:30:34 -0800 (PST)
Date: Thu, 11 Nov 2021 05:30:31 +0000
Message-Id: <20211111053031.4002774-1-dvander@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] erofs-utils: mkfs: add block list support for chunked files
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When using the --block-list-file option, add block mapping lines for
chunked files. The extent printing code has been slightly refactored to
accommodate multiple extent ranges.

Signed-off-by: David Anderson <dvander@google.com>
---
 include/erofs/block_list.h |  7 +++++++
 lib/blobchunk.c            | 27 ++++++++++++++++++++++++-
 lib/block_list.c           | 41 +++++++++++++++++++++++++++++---------
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index dcc0e50..40df228 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -15,11 +15,18 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks);
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 					  erofs_blk_t blkaddr);
+void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
+					erofs_blk_t blk_start, erofs_blk_t nblocks,
+					bool first_extent, bool last_extent);
 #else
 static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
 static inline void
 erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 					  erofs_blk_t blkaddr) {}
+static inline void
+erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
+				   erofs_blk_t blk_start, erofs_blk_t nblocks,
+				   bool first_extent, bool last_extent) {}
 #endif
 #endif
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 661c5d0..a2e62be 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -7,6 +7,7 @@
 #define _GNU_SOURCE
 #include "erofs/hashmap.h"
 #include "erofs/blobchunk.h"
+#include "erofs/block_list.h"
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include <unistd.h>
@@ -101,7 +102,10 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 				   erofs_off_t off)
 {
 	struct erofs_inode_chunk_index idx = {0};
-	unsigned int dst, src, unit;
+	erofs_blk_t extent_start = EROFS_NULL_ADDR;
+	erofs_blk_t extent_end = EROFS_NULL_ADDR;
+	unsigned int dst, src, unit, num_extents;
+	bool first_extent = true;
 
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -115,6 +119,20 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		chunk = *(void **)(inode->chunkindexes + src);
 
 		idx.blkaddr = chunk->blkaddr + remapped_base;
+		if (extent_start != EROFS_NULL_ADDR &&
+		    idx.blkaddr == extent_end + 1) {
+			extent_end = idx.blkaddr;
+		} else {
+			if (extent_start != EROFS_NULL_ADDR) {
+				erofs_droid_blocklist_write_extent(inode,
+					extent_start,
+					(extent_end - extent_start) + 1,
+					first_extent, false);
+				first_extent = false;
+			}
+			extent_start = idx.blkaddr;
+			extent_end = idx.blkaddr;
+		}
 		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
 			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
 		else
@@ -122,6 +140,13 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	}
 	off = roundup(off, unit);
 
+	if (extent_start == EROFS_NULL_ADDR)
+		num_extents = 0;
+	else
+		num_extents = (extent_end - extent_start) + 1;
+	erofs_droid_blocklist_write_extent(inode, extent_start, num_extents,
+		first_extent, true);
+
 	return dev_write(inode->chunkindexes, off, inode->extent_isize);
 }
 
diff --git a/lib/block_list.c b/lib/block_list.c
index 096dc9b..87609a9 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -32,25 +32,48 @@ void erofs_droid_blocklist_fclose(void)
 }
 
 static void blocklist_write(const char *path, erofs_blk_t blk_start,
-			    erofs_blk_t nblocks, bool has_tail)
+			    erofs_blk_t nblocks, bool first_extent,
+			    bool last_extent)
 {
 	const char *fspath = erofs_fspath(path);
 
-	fprintf(block_list_fp, "/%s", cfg.mount_point);
+	if (first_extent) {
+		fprintf(block_list_fp, "/%s", cfg.mount_point);
 
-	if (fspath[0] != '/')
-		fprintf(block_list_fp, "/");
+		if (fspath[0] != '/')
+			fprintf(block_list_fp, "/");
+
+		fprintf(block_list_fp, "%s", fspath);
+	}
 
 	if (nblocks == 1)
-		fprintf(block_list_fp, "%s %u", fspath, blk_start);
+		fprintf(block_list_fp, " %u", blk_start);
 	else
-		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
+		fprintf(block_list_fp, " %u-%u", blk_start,
 			blk_start + nblocks - 1);
 
-	if (!has_tail)
+	if (last_extent)
 		fprintf(block_list_fp, "\n");
 }
 
+void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
+					erofs_blk_t blk_start,
+					erofs_blk_t nblocks, bool first_extent,
+					bool last_extent)
+{
+	if (!block_list_fp || !cfg.mount_point)
+		return;
+
+	if (!nblocks) {
+		if (last_extent)
+			fprintf(block_list_fp, "\n");
+		return;
+	}
+
+	blocklist_write(inode->i_srcpath, blk_start, nblocks, first_extent,
+			last_extent);
+}
+
 void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks)
 {
@@ -58,7 +81,7 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
 		return;
 
 	blocklist_write(inode->i_srcpath, blk_start, nblocks,
-			!!inode->idata_size);
+			true, !inode->idata_size);
 }
 
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
@@ -80,6 +103,6 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 		return;
 	}
 	if (blkaddr != NULL_ADDR)
-		blocklist_write(inode->i_srcpath, blkaddr, 1, false);
+		blocklist_write(inode->i_srcpath, blkaddr, 1, true, true);
 }
 #endif
-- 
2.34.0.rc0.344.g81b53c2807-goog

