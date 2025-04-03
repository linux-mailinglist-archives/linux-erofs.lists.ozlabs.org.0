Return-Path: <linux-erofs+bounces-142-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED51BA79DC0
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Apr 2025 10:14:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZSvf50Mgrz304x;
	Thu,  3 Apr 2025 19:14:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743668061;
	cv=none; b=EEpUAXCL17gCPBUeAK7t4KnMD4FwyonzExtk2USyg632qeETuIygeSDLRbzrrXDa/z8gsOJ626JWzr+o0fVu+r0kqr3oEsH/dDesuavIQbjjiKG/YHNdp7cJFGwCCEI0WpGBS4JkOC0JVux9MXZdXyzm9D/wFR9bfd45FjjlodV+yA2+U99Xrst25248dLjeiCdN+eTWJONtvdTiveFpvM3CoygrQL870kSu3ZYeyDKTBZqv3kwQnztiJkEteyYEWI2vzCTT4sZxwrK8O8czE0MwEbNfVDl7RxLSkaV/REkE4a1SOtjPsDU0gAaBSN3KLaLDTy+QiLndQaPLPrV+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743668061; c=relaxed/relaxed;
	bh=pqe8DJ/mPC4mMppDJP8yvOCQWN0YRXT8MBqcP8/+7KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMZsA8nHhWJhkN5icvaZV3YwU3+zZPu35WXodiNFA9BEZPglXgoPcy6djZVMIFbx8emFnNAGJqWmadjPJJ673iJ0jxulwnCtq9VG0h8yQVKLD2EhgtCAxmMIrDJ3hh9I0sDfvJFkRhrg2oJ/rZp0cqouC7XQzXy6LVUyM5WrbuwrsBd10/itEfaIxJTh1iHIr6rFG+wdx1CHjbge9MX3LVd7yQkixmfYlF2kwoNJlnqcVtQ2oMHQiejAKDA7ZOy1x46EX6MKgp9exAoUS+Dm8NbE7RAfxRw64n+luxcqGF7L/5vDpVGn5BiMG7XI54IblAb+Se1T+AT8C87xM3rfhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o4mXHmO8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o4mXHmO8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZSvf04PVTz3050
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Apr 2025 19:14:16 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743668052; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pqe8DJ/mPC4mMppDJP8yvOCQWN0YRXT8MBqcP8/+7KU=;
	b=o4mXHmO8D+mNHPARCMBAJnOBoVrsmvFFgiEcnuJi22YaCL1UpdUNfE9BdLQr/qswvo9HVIsBvlDu6I78urWoyvmlU5aQhHK5m2OpaYisWsvyOd5rw9FPpBdHxewX3jeOeEOzGBGbngcC1WSfXqO92OaAxRtimlmtxayp7pN/3qM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WUcFcOS_1743668050 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Apr 2025 16:14:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs-utils: mkfs: implement extent-based deduplication
Date: Thu,  3 Apr 2025 16:14:03 +0800
Message-ID: <20250403081403.2671077-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250403081403.2671077-1-hsiangkao@linux.alibaba.com>
References: <20250403081403.2671077-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, only rolling-hash deduplication could be used for
compressed data, and it is still single-threaded for now.

Before applying multi-threaded compression to that, let's allow
extent-based compressed data deduplication if `-Efragments` is on.

This feature will only work if multi-threaded compression is active.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/dedupe.h |   8 ++++
 lib/Makefile.am        |   2 +-
 lib/compress.c         |  63 +++++++++++++++++---------
 lib/dedupe_ext.c       | 100 +++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c            |  10 +++++
 5 files changed, 162 insertions(+), 21 deletions(-)
 create mode 100644 lib/dedupe_ext.c

diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
index 1af08e3..ffb00a5 100644
--- a/include/erofs/dedupe.h
+++ b/include/erofs/dedupe.h
@@ -32,6 +32,14 @@ void z_erofs_dedupe_commit(bool drop);
 int z_erofs_dedupe_init(unsigned int wsiz);
 void z_erofs_dedupe_exit(void);
 
+int z_erofs_dedupe_ext_insert(struct z_erofs_inmem_extent *e,
+			      u64 hash);
+erofs_blk_t z_erofs_dedupe_ext_match(struct erofs_sb_info *sbi,
+			u8 *encoded, unsigned int size, bool raw, u64 *hash);
+void z_erofs_dedupe_ext_commit(bool drop);
+int z_erofs_dedupe_ext_init(void);
+void z_erofs_dedupe_ext_exit(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 9cddc92..bdc74ad 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -35,7 +35,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c rebuild.c diskbuf.c bitops.c
+		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/compress.c b/lib/compress.c
index 50d155e..cc7dce0 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -49,6 +49,7 @@ struct z_erofs_compress_ictx {		/* inode context */
 	u32 tof_chksum;
 	bool fix_dedupedfrag;
 	bool fragemitted;
+	bool dedupe;
 
 	/* fields for write indexes */
 	u8 *metacur;
@@ -337,10 +338,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 			ei->e.partial = true;
 			ei->e.length -= delta;
 		}
-
-		/* fall back to noncompact indexes for deduplication */
-		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+		ctx->ictx->dedupe = true;
 		erofs_sb_set_dedupe(sbi);
 
 		sbi->saved_by_deduplication += dctx.e.plen;
@@ -1001,9 +999,25 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_extent_item *ei, *n;
 	void *metabuf;
 
+	if (!cfg.c_legacy_compress && !ctx->dedupe &&
+	    inode->z_logical_clusterbits <= 14) {
+		if (inode->z_logical_clusterbits <= 12)
+			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
+	} else {
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+	}
+
+	if (erofs_sb_has_big_pcluster(sbi)) {
+		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
+			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
+	}
+
 	metabuf = malloc(BLK_ROUND_UP(inode->sbi, inode->i_size) *
 			 sizeof(struct z_erofs_lcluster_index) +
 			 Z_EROFS_LEGACY_MAP_HEADER_SIZE);
@@ -1170,6 +1184,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		ret = -ENOSPC;
 		goto err_free_meta;
 	}
+	z_erofs_dedupe_ext_commit(false);
 	z_erofs_dedupe_commit(false);
 
 	if (!ictx->fragemitted)
@@ -1345,8 +1360,11 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 {
 	struct z_erofs_extent_item *ei, *n;
 	struct erofs_sb_info *sbi = ictx->inode->sbi;
+	bool dedupe_ext = cfg.c_fragments;
 	erofs_off_t off = 0;
 	int ret = 0, ret2;
+	erofs_blk_t dupb;
+	u64 hash;
 
 	list_for_each_entry_safe(ei, n, &sctx->extents, list) {
 		list_del(&ei->list);
@@ -1361,13 +1379,30 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 		/* skip write data but leave blkaddr for inline fallback */
 		if (ei->e.inlined || !ei->e.plen)
 			continue;
+
+		if (dedupe_ext) {
+			dupb = z_erofs_dedupe_ext_match(sbi, sctx->membuf + off,
+						ei->e.plen, ei->e.raw, &hash);
+			if (dupb != EROFS_NULL_ADDR) {
+				ei->e.pstart = dupb;
+				sctx->pstart -= ei->e.plen;
+				off += ei->e.plen;
+				ictx->dedupe = true;
+				erofs_sb_set_dedupe(sbi);
+				sbi->saved_by_deduplication += ei->e.plen;
+				erofs_dbg("Dedupe %u %scompressed data to %llu of %u bytes",
+					  ei->e.length, ei->e.raw ? "un" : "",
+					  ei->e.pstart | 0ULL, ei->e.plen);
+				continue;
+			}
+		}
 		ret2 = erofs_dev_write(sbi, sctx->membuf + off, ei->e.pstart,
 				       ei->e.plen);
 		off += ei->e.plen;
-		if (ret2) {
+		if (ret2)
 			ret = ret2;
-			continue;
-		}
+		else if (dedupe_ext)
+			z_erofs_dedupe_ext_insert(&ei->e, hash);
 	}
 	free(sctx->membuf);
 	sctx->membuf = NULL;
@@ -1543,19 +1578,6 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
 	inode->z_logical_clusterbits = sbi->blkszbits;
-	if (!cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
-		if (inode->z_logical_clusterbits <= 12)
-			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
-	} else {
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-	}
-
-	if (erofs_sb_has_big_pcluster(sbi)) {
-		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
-		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
-			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
-	}
 	if (cfg.c_fragments && !cfg.c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
@@ -1615,6 +1637,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	init_list_head(&ictx->extents);
 	ictx->fix_dedupedfrag = false;
 	ictx->fragemitted = false;
+	ictx->dedupe = false;
 
 	if (all_fragments && !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tof_chksum);
diff --git a/lib/dedupe_ext.c b/lib/dedupe_ext.c
new file mode 100644
index 0000000..b6603e6
--- /dev/null
+++ b/lib/dedupe_ext.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/dedupe.h"
+#include "liberofs_xxhash.h"
+#include <stdlib.h>
+
+struct z_erofs_dedupe_ext_item {
+	struct list_head list;
+	struct z_erofs_dedupe_ext_item *revoke;
+	struct z_erofs_inmem_extent e;
+	u64		xxh64;
+};
+
+static struct list_head dupl_ext[65536];
+static struct z_erofs_dedupe_ext_item *revoke_list;
+
+int z_erofs_dedupe_ext_insert(struct z_erofs_inmem_extent *e,
+			      u64 hash)
+{
+	struct z_erofs_dedupe_ext_item *item;
+	struct list_head *p;
+
+	item = malloc(sizeof(struct z_erofs_dedupe_ext_item));
+	if (!item)
+		return -ENOMEM;
+	item->e = *e;
+	item->xxh64 = hash;
+
+	p = &dupl_ext[hash & (ARRAY_SIZE(dupl_ext) - 1)];
+	list_add_tail(&item->list, p);
+	item->revoke = revoke_list;
+	revoke_list = item;
+	return 0;
+}
+
+erofs_blk_t z_erofs_dedupe_ext_match(struct erofs_sb_info *sbi,
+				     u8 *encoded, unsigned int len,
+				     bool raw, u64 *hash)
+{
+	struct z_erofs_dedupe_ext_item *item;
+	struct list_head *p;
+	u64 _xxh64;
+	char *memb;
+	int ret;
+
+	*hash = _xxh64 = xxh64(encoded, len, 0);
+	p = &dupl_ext[_xxh64 & (ARRAY_SIZE(dupl_ext) - 1)];
+	list_for_each_entry(item, p, list) {
+		if (item->xxh64 == _xxh64 && item->e.plen == len &&
+		    item->e.raw == raw) {
+			memb = malloc(len);
+			if (!memb)
+				break;
+			ret = erofs_dev_read(sbi, 0, memb, item->e.pstart, len);
+			free(memb);
+			if (ret < 0 || memcmp(memb, encoded, len))
+				break;
+			return item->e.pstart;
+		}
+	}
+	return EROFS_NULL_ADDR;
+}
+
+void z_erofs_dedupe_ext_commit(bool drop)
+{
+	if (drop) {
+		struct z_erofs_dedupe_ext_item *item, *n;
+
+		for (item = revoke_list; item; item = n) {
+			n = item->revoke;
+			list_del(&item->list);
+			free(item);
+		}
+	}
+	revoke_list = NULL;
+}
+
+int z_erofs_dedupe_ext_init(void)
+{
+	struct list_head *p;
+
+	for (p = dupl_ext; p < dupl_ext + ARRAY_SIZE(dupl_ext); ++p)
+		init_list_head(p);
+	return 0;
+}
+
+void z_erofs_dedupe_ext_exit(void)
+{
+	struct z_erofs_dedupe_ext_item *item, *n;
+	struct list_head *p;
+
+	if (!dupl_ext[0].next)
+		return;
+	z_erofs_dedupe_commit(true);
+	for (p = dupl_ext; p < dupl_ext + ARRAY_SIZE(dupl_ext); ++p) {
+		list_for_each_entry_safe(item, n, p, list) {
+			list_del(&item->list);
+			free(item);
+		}
+	}
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index b2396d0..00bd21a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1374,6 +1374,15 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (cfg.c_fragments) {
+		err = z_erofs_dedupe_ext_init();
+		if (err) {
+			erofs_err("failed to initialize extent deduplication: %s",
+				  erofs_strerror(err));
+			goto exit;
+		}
+	}
+
 	if (cfg.c_chunkbits) {
 		err = erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chunkbits);
 		if (err)
@@ -1486,6 +1495,7 @@ exit:
 		erofs_iput(root);
 	z_erofs_compress_exit();
 	z_erofs_dedupe_exit();
+	z_erofs_dedupe_ext_exit();
 	blklst = erofs_blocklist_close();
 	if (blklst)
 		fclose(blklst);
-- 
2.43.5


