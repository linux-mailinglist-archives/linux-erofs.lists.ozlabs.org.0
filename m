Return-Path: <linux-erofs+bounces-1303-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B4DC1E551
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Oct 2025 05:13:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxrMc4BRdz2yvv;
	Thu, 30 Oct 2025 15:13:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761797628;
	cv=none; b=P2Ewh43T6iGypeZHVTn71V/P2TK8JFCRZubBYpIxlvtm7phqd50Hipn74jYehxrri1NCfcBkjgOcdBJXNEJb/JpYwW286XUcwGygArPyRp7dejW4D1hKMbHE3uVwwJ+FBrYVwKpYEeGz+/V4oxMXv1nuDRPxm9WAC8aAF6jCI9KDircD5sgB9afg/ZEHkHbpKFJU4yxGdLYunWRqPwZFcmdM83luQM2yCyWKSSovhB1Tr6JK2xgzO5UjxjY1EKLu37H2Nhbml39B7FOjwcVjHRH72kcN+AkM0WiwcgNKMDqlpnCG30KnhtaZbGNAVlBQVjXoXRfgSZHIGeumhqudLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761797628; c=relaxed/relaxed;
	bh=7cr6Ma9YCr2H+S6pVoqZyu2oPQOcIEYf3hghtTHT3i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYi0VMz1vZtBYJjhldALplUXDwL3Qny6i+GaYVsTJEbRW8HWfgVqf04UkregJ2TXsTVQjKWPpNt0zivtEbzJLEfTtHJ0MNGu5+9b61FIn6QBLI0IBgLyQ2eYK+e2iTAvx5YCjpY6IjSBU1CvUCytohDlbNmA4/30T6fOg7+1g3ovTJ/OdhIPPEp0A7/3nH6ZpLAkaZKHzuKBI9hgJjir0L51FAoQuo7HPD3q1PUm3n+dAyn9I45Oebrnk6lcYHL04pNSAS3h3Fu2T5jz9kgze3Tna3Btkd7QeXql+a1K67+iwOcXcC52ggMuDtm7xBaF/Mtad9YlCdZ4NFBL9ZQlWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wp43gY2m; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wp43gY2m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxrMZ5Wqpz2xxS
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Oct 2025 15:13:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761797621; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7cr6Ma9YCr2H+S6pVoqZyu2oPQOcIEYf3hghtTHT3i4=;
	b=wp43gY2mZSy9kOl+c4rwWJuVqyFSl6xFepZKuX2lY9Y0AyOHF9KKP9AJeeR9ALly9STAPAfDQXds04R0hS9c2xqk7D3H10xAVKgCb+MY19UVdKVx5u6+hDn1QlfoUazlLurjFJwFmYV6FJgZgdR4O1vojUBx+02qvNpUpZgc5IU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrIe8-X_1761797615 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 12:13:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3] erofs-utils: mkfs: Turn off deduplication under chunk mode with '-E^dedupe'
Date: Thu, 30 Oct 2025 12:13:34 +0800
Message-ID: <20251030041334.2092102-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251028032809.1371395-1-friendy.su@sony.com>
References: <20251028032809.1371395-1-friendy.su@sony.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Friendy Su <friendy.su@sony.com>

With '-E^dedupe', deduplication will be disabled even in chunk mode.
This is currently mandatory when mounting EROFS with DAX.

Deduplicated chunks are shared among multiple files or between different
parts of the same file.  Kernel DAX map got wrong when map them.

[    2.031496] WARNING: CPU: 0 PID: 1 at fs/dax.c:460 dax_insert_entry+0x36e/0x380
[    2.031978] Modules linked in:
[    2.032173] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2+ #111 PREEMPT(voluntary)
[    2.032688] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.033291] RIP: 0010:dax_insert_entry+0x36e/0x380
[    2.033591] Code: 59 fe ff ff 48 8b 30 b9 09 00 00 00 83 e6 40 0f 85 70 ff ff ff e9 77 ff ff ff 31 f6 90 0f 0b 90 85 f6 75 ae e9 34 fe ff
ff 90 <0f> 0b 90 e9 02 fe ff ff be 09 00 00 00 eb e3 0f 1f 00 90 90 90 90
[    2.034654] RSP: 0000:ffffb93fc0013b88 EFLAGS: 00010086
[    2.034948] RAX: ffffe124441dc140 RBX: ffffb93fc0013c78 RCX: 0000000000000000
[    2.035339] RDX: 00007f310337c000 RSI: 0000000000000000 RDI: ffffe124441dc140
[    2.035730] RBP: 00000000020ee0a1 R08: 0000000001077050 R09: 0000000000000000
[    2.036120] R10: ffffb93fc0013cd8 R11: 0000000000001000 R12: 0000000000000011
[    2.036513] R13: 0000000000000000 R14: fffffffffffff000 R15: 00000000020ee0a1
[    2.036912] FS:  00007f31026ad940(0000) GS:ffff90436812c000(0000) knlGS:0000000000000000
[    2.037352] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.037669] CR2: 00007f31033c2216 CR3: 0000000001d17006 CR4: 0000000000770ef0
[    2.038062] PKRU: 55555554
[    2.038216] Call Trace:
[    2.038363]  <TASK>
[    2.038486]  dax_fault_iter+0x286/0x6a0
[    2.038704]  dax_iomap_pte_fault+0x17f/0x370
[    2.038950]  __do_fault+0x30/0xc0
[    2.039153]  __handle_mm_fault+0x90a/0x15a0
[    2.039391]  handle_mm_fault+0xde/0x240
[    2.039607]  do_user_addr_fault+0x166/0x640
[    2.039853]  exc_page_fault+0x74/0x170
[    2.040087]  asm_exc_page_fault+0x26/0x30
[    2.040319] RIP: 0033:0x7f31039389bd
[    2.040519] Code: 08 48 8b 85 68 ff ff ff 48 8b bd 60 ff ff ff 48 8b b5 58 ff ff ff 4c 89 f2 48 03 33 45 89 f7 48 c1 ea 20 48 89 b5 70 ff
ff ff <0f> b7 04 50 48 8d 14 52 4c 8d 24 d7 25 ff 7f 00 00 4c 89 65 80 48

Signed-off-by: Friendy Su <friendy.su@sony.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
In the long term, `importer_params->dedupe` should be used
for inode chunks too.

 include/erofs/config.h   |  1 +
 include/erofs/importer.h |  8 +++++++-
 lib/blobchunk.c          | 27 +++++++++++++++------------
 lib/compress.c           |  9 +++++----
 mkfs/main.c              |  5 +++--
 5 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 1685adf..525a8cd 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -41,6 +41,7 @@ struct erofs_configure {
 	bool c_dry_run;
 	char c_timeinherit;
 	char c_chunkbits;
+	char c_dedupe;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 60f81d6..e1734b9 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -17,6 +17,12 @@ enum {
 	EROFS_FORCE_INODE_EXTENDED,
 };
 
+enum {
+	EROFS_DEDUPE_UNSPECIFIED,
+	EROFS_DEDUPE_FORCE_OFF,
+	EROFS_DEDUPE_FORCE_ON,
+};
+
 enum {
 	EROFS_FRAGDEDUPE_FULL,
 	EROFS_FRAGDEDUPE_INODE,
@@ -45,7 +51,7 @@ struct erofs_importer_params {
 	bool no_zcompact;
 	bool no_lz4_0padding;
 	bool ztailpacking;
-	bool dedupe;
+	char dedupe;
 	bool fragments;
 	bool all_fragments;
 	bool compress_dir;
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a5945f8..3b1c97b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -8,6 +8,7 @@
 #include "erofs/hashmap.h"
 #include "erofs/blobchunk.h"
 #include "erofs/block_list.h"
+#include "erofs/importer.h"
 #include "liberofs_cache.h"
 #include "liberofs_private.h"
 #include "sha256.h"
@@ -64,19 +65,21 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 
 	erofs_sha256(buf, chunksize, sha256);
 	hash = memhash(sha256, sizeof(sha256));
-	chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
-	if (chunk) {
-		DBG_BUGON(chunksize != chunk->chunksize);
-
-		sbi->saved_by_deduplication += chunksize;
-		if (chunk->blkaddr == erofs_holechunk.blkaddr) {
-			chunk = &erofs_holechunk;
-			erofs_dbg("Found duplicated hole chunk");
-		} else {
-			erofs_dbg("Found duplicated chunk at %llu",
-				  chunk->blkaddr | 0ULL);
+	if (cfg.c_dedupe != EROFS_DEDUPE_FORCE_OFF) {
+		chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
+		if (chunk) {
+			DBG_BUGON(chunksize != chunk->chunksize);
+
+			sbi->saved_by_deduplication += chunksize;
+			if (chunk->blkaddr == erofs_holechunk.blkaddr) {
+				chunk = &erofs_holechunk;
+				erofs_dbg("Found duplicated hole chunk");
+			} else {
+				erofs_dbg("Found duplicated chunk at %llu",
+					  chunk->blkaddr | 0ULL);
+			}
+			return chunk;
 		}
-		return chunk;
 	}
 
 	chunk = malloc(sizeof(struct erofs_blobchunk));
diff --git a/lib/compress.c b/lib/compress.c
index 1a68841..c90369f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -636,7 +636,7 @@ retry_aligned:
 			may_packing = false;
 			e->length = min_t(u32, e->length, ctx->pclustersize);
 nocompression:
-			if (params->dedupe)
+			if (params->dedupe != EROFS_DEDUPE_FORCE_OFF)
 				ret = write_uncompressed_block(ctx, len, dst);
 			else
 				ret = write_uncompressed_extents(ctx, len,
@@ -1381,7 +1381,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 
 	if (ptotal)
 		(void)erofs_bh_balloon(bh, ptotal);
-	else if (!params->fragments && !params->dedupe)
+	else if (!params->fragments && params->dedupe != EROFS_DEDUPE_FORCE_OFF)
 		DBG_BUGON(!inode->idata_size);
 
 	erofs_info("compressed %s (%llu bytes) into %llu bytes",
@@ -1743,7 +1743,7 @@ static int z_erofs_mt_global_init(struct erofs_importer *im)
 	if (workers < 1)
 		return 0;
 	/* XXX: `dedupe` is actually not a global option here. */
-	if (workers >= 1 && params->dedupe) {
+	if (workers >= 1 && params->dedupe != EROFS_DEDUPE_FORCE_OFF) {
 		erofs_warn("multi-threaded dedupe is NOT implemented for now");
 		cfg.c_mt_workers = 0;
 	} else {
@@ -1844,7 +1844,8 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 	ictx->data_unaligned = erofs_sb_has_48bit(sbi) &&
 		cfg.c_max_decompressed_extent_bytes <=
 			z_erofs_get_pclustersize(ictx);
-	if (params->fragments && !params->dedupe && !ictx->data_unaligned)
+	if (params->fragments && params->dedupe != EROFS_DEDUPE_FORCE_OFF &&
+	    !ictx->data_unaligned)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 	init_list_head(&ictx->extents);
diff --git a/mkfs/main.c b/mkfs/main.c
index f1ea7df..4de298b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -376,7 +376,7 @@ static int erofs_mkfs_feat_set_dedupe(struct erofs_importer_params *params,
 {
 	if (vallen)
 		return -EINVAL;
-	params->dedupe = en;
+	params->dedupe = en ? EROFS_DEDUPE_FORCE_ON : EROFS_DEDUPE_FORCE_OFF;
 	return 0;
 }
 
@@ -1826,7 +1826,7 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
-	if (importer_params.dedupe) {
+	if (importer_params.dedupe == EROFS_DEDUPE_FORCE_ON) {
 		if (!cfg.c_compr_opts[0].alg) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
 			cfg.c_chunkbits = g_sbi.blkszbits;
@@ -1840,6 +1840,7 @@ int main(int argc, char **argv)
 		}
 	}
 
+	cfg.c_dedupe = importer_params.dedupe;
 	if (cfg.c_chunkbits) {
 		err = erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chunkbits);
 		if (err)
-- 
2.43.5


