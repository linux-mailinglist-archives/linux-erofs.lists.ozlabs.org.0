Return-Path: <linux-erofs+bounces-150-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C8A7CDB8
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Apr 2025 13:27:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZVqnz4kDNz2y3b;
	Sun,  6 Apr 2025 21:27:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743938871;
	cv=none; b=YCEh8PwZ5LiJIXJ03gIYg/vZdWzU8az4chkGClJA9pci8f28n1rgAo+stG55fm7IhXlK+Ez8EElh6vpAS5Q+lUTlCcLsWkAYb1zLAg8gf18HYwenLMKqKbaZUWb9fzFCssVVQPu68OlpllRvr2uRihkTAbu3qcmInj71v4b1ZanHOnZfRMklzeTnhPCRyCrYqcBoPt7hoAeSgVM1UaDRhEU5hJnVIh+u+66EUz8XT5d4vJXCzVVWlGMb/VRpAHmbkNoQb7VGvlPfo/wY4SoOYMSEiy/+4vR4VfsLMSYDY1SZQ11q0kszt8vcASn1/u+nAOP7iiC30CO2c/du5wRLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743938871; c=relaxed/relaxed;
	bh=P6zdQnz+bNQEGWj4yoImSam/kgvgbYt/VrmJ15YyIiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZJ6OgkLb0y/TIurizEbPAE4WK9okGaA3f3QuWKsStrPUwUAJq3DPCKIQZWrs3tPUx+Ihz8deag73sX+6ST3dunNe9534xOUnKNuZzYMwZ6mf1zZi8vfFCzeuOlQbymPZRdDrjwGtYgatV33EDMcSOeIXjJhpyiO3dLhsNQWFQpKH4HXHewDvwcNP5aturs0N8xyN1PXWlUgEOtb1PKjXspmyK2Hq4QRtElJ1q0pT1su2Qe5tDGlOKUlzntoKznugNYnjfwlNVNPgPUL1+1kX4PvThezpI3TVy01LWpoQifLoYzrX2NqYRy5ZkOI0tZkuAr8pSV5blVnqRuupqBKsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qSfSx7tZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qSfSx7tZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVqnw69mRz2xsW
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Apr 2025 21:27:47 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743938863; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P6zdQnz+bNQEGWj4yoImSam/kgvgbYt/VrmJ15YyIiI=;
	b=qSfSx7tZEvcNftMHRA0ATLyrtsrpcf9jMQf9zeNYg06YlkgLlNXLYcnv+pRxyga6FnsO2qsya17eaYG/9X2Nj1VT4BuQpmXooiLNg52pIk/DqRx7zlNNSZZ1qE19LuKIACvl8gI+9GznWJo/+CsN9fixwj2HOxmw09s/8wXGopQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WVY5XuN_1743938856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 06 Apr 2025 19:27:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Kelvin Zhang <zhangkelvin@google.com>
Subject: [PATCH] AOSP: erofs-utils: mkfs: remove block list implementation
Date: Sun,  6 Apr 2025 19:27:35 +0800
Message-ID: <20250406112735.348328-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

The current Android doesn't use this method.  Let's remove it
for simplicity, as it's difficult to verify its functionality
without setuping the Android environment.

Cc: Kelvin Zhang <zhangkelvin@google.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/block_list.h | 20 ----------
 lib/blobchunk.c            | 11 ------
 lib/block_list.c           | 77 --------------------------------------
 lib/compress.c             |  3 --
 lib/inode.c                |  5 ---
 mkfs/main.c                | 13 -------
 6 files changed, 129 deletions(-)

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 8cc87d7..9d06c9c 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -18,26 +18,6 @@ FILE *erofs_blocklist_close(void);
 
 void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
 			      erofs_off_t srcoff, unsigned int zeroedlen);
-#ifdef WITH_ANDROID
-void erofs_droid_blocklist_write(struct erofs_inode *inode,
-				 erofs_blk_t blk_start, erofs_blk_t nblocks);
-void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
-					  erofs_blk_t blkaddr);
-void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
-					erofs_blk_t blk_start, erofs_blk_t nblocks,
-					bool first_extent, bool last_extent);
-#else
-static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
-				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
-static inline void
-erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
-					  erofs_blk_t blkaddr) {}
-static inline void
-erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
-				   erofs_blk_t blk_start, erofs_blk_t nblocks,
-				   bool first_extent, bool last_extent) {}
-#endif
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index e6386d6..de9150f 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -145,7 +145,6 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	erofs_blk_t extent_end, chunkblks;
 	erofs_off_t source_offset;
 	unsigned int dst, src, unit, zeroedlen;
-	bool first_extent = true;
 
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -176,11 +175,6 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 				tarerofs_blocklist_write(extent_start,
 						extent_end - extent_start,
 						source_offset, 0);
-				erofs_droid_blocklist_write_extent(inode,
-					extent_start,
-					extent_end - extent_start,
-					first_extent, false);
-				first_extent = false;
 			}
 			extent_start = idx.blkaddr;
 			source_offset = chunk->sourceoffset;
@@ -203,11 +197,6 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
 					 source_offset, zeroedlen);
 	}
-	erofs_droid_blocklist_write_extent(inode, extent_start,
-			extent_start == EROFS_NULL_ADDR ?
-					0 : extent_end - extent_start,
-					   first_extent, true);
-
 	return erofs_dev_write(inode->sbi, inode->chunkindexes, off,
 			       inode->extent_isize);
 }
diff --git a/lib/block_list.c b/lib/block_list.c
index 6bbe4ec..4a6466d 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -44,80 +44,3 @@ void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
 		fprintf(block_list_fp, "%08x %8x %08" PRIx64 "\n",
 			blkaddr, nblocks, srcoff);
 }
-
-#ifdef WITH_ANDROID
-static void blocklist_write(const char *path, erofs_blk_t blk_start,
-			    erofs_blk_t nblocks, bool first_extent,
-			    bool last_extent)
-{
-	const char *fspath = erofs_fspath(path);
-
-	if (first_extent) {
-		fprintf(block_list_fp, "/%s", cfg.mount_point);
-
-		if (fspath[0] != '/')
-			fprintf(block_list_fp, "/");
-
-		fprintf(block_list_fp, "%s", fspath);
-	}
-
-	if (nblocks == 1)
-		fprintf(block_list_fp, " %u", blk_start);
-	else
-		fprintf(block_list_fp, " %u-%u", blk_start,
-			blk_start + nblocks - 1);
-
-	if (last_extent)
-		fprintf(block_list_fp, "\n");
-}
-
-void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
-					erofs_blk_t blk_start,
-					erofs_blk_t nblocks, bool first_extent,
-					bool last_extent)
-{
-	if (!block_list_fp || !cfg.mount_point)
-		return;
-
-	if (!nblocks) {
-		if (last_extent)
-			fprintf(block_list_fp, "\n");
-		return;
-	}
-
-	blocklist_write(inode->i_srcpath, blk_start, nblocks, first_extent,
-			last_extent);
-}
-
-void erofs_droid_blocklist_write(struct erofs_inode *inode,
-				 erofs_blk_t blk_start, erofs_blk_t nblocks)
-{
-	if (!block_list_fp || !cfg.mount_point || !nblocks)
-		return;
-
-	blocklist_write(inode->i_srcpath, blk_start, nblocks,
-			true, !inode->idata_size);
-}
-
-void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
-					  erofs_blk_t blkaddr)
-{
-	if (!block_list_fp || !cfg.mount_point)
-		return;
-
-	/* XXX: a bit hacky.. may need a better approach */
-	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		return;
-
-	/* XXX: another hack, which means it has been outputed before */
-	if (erofs_blknr(inode->sbi, inode->i_size)) {
-		if (blkaddr == NULL_ADDR)
-			fprintf(block_list_fp, "\n");
-		else
-			fprintf(block_list_fp, " %u\n", blkaddr);
-		return;
-	}
-	if (blkaddr != NULL_ADDR)
-		blocklist_write(inode->i_srcpath, blkaddr, 1, true, true);
-}
-#endif
diff --git a/lib/compress.c b/lib/compress.c
index 1742529..d046112 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1238,9 +1238,6 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		DBG_BUGON(ret);
 	}
 	inode->compressmeta = compressmeta;
-	if (!erofs_is_packed_inode(inode))
-		erofs_droid_blocklist_write(inode, pstart >> bbits,
-					    inode->u.i_blocks);
 	return 0;
 
 err_free_meta:
diff --git a/lib/inode.c b/lib/inode.c
index 108aa9e..7a10624 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -564,7 +564,6 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 			return -EIO;
 		}
 	}
-	erofs_droid_blocklist_write(inode, inode->u.i_blkaddr, nblocks);
 	return 0;
 }
 
@@ -843,8 +842,6 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 
 		ibh->fsprivate = erofs_igrab(inode);
 		ibh->op = &erofs_write_inline_bhops;
-
-		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
 	} else {
 		int ret;
 		erofs_off_t pos, zero_pos;
@@ -899,8 +896,6 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		inode->idata_size = 0;
 		free(inode->idata);
 		inode->idata = NULL;
-
-		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(sbi, pos));
 	}
 out:
 	/* now bh_data can drop directly */
diff --git a/mkfs/main.c b/mkfs/main.c
index 6d1a2de..2907789 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -63,7 +63,6 @@ static struct option long_options[] = {
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
-	{"block-list-file", required_argument, NULL, 515},
 #endif
 	{"ovlfs-strip", optional_argument, NULL, 516},
 	{"offset", required_argument, NULL, 517},
@@ -213,7 +212,6 @@ static void usage(int argc, char **argv)
 		"Android-specific options:\n"
 		" --product-out=X       X=product_out directory\n"
 		" --fs-config-file=X    X=fs_config file\n"
-		" --block-list-file=X   X=block_list file\n"
 #endif
 #ifdef EROFS_MT_ENABLED
 		, erofs_get_available_processors() /* --workers= */
@@ -723,9 +721,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 514:
 			cfg.fs_config_file = optarg;
 			break;
-		case 515:
-			cfg.block_list_file = optarg;
-			break;
 #endif
 		case 'C':
 			i = strtoull(optarg, &endptr, 0);
@@ -1241,14 +1236,6 @@ int main(int argc, char **argv)
 		erofs_err("failed to load fs config %s", cfg.fs_config_file);
 		return 1;
 	}
-
-	if (cfg.block_list_file) {
-		blklst = fopen(cfg.block_list_file, "w");
-		if (!blklst || erofs_blocklist_open(blklst, false)) {
-			erofs_err("failed to open %s", cfg.block_list_file);
-			return 1;
-		}
-	}
 #endif
 	erofs_show_config();
 	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
-- 
2.43.5


