Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B39CF79D061
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 13:51:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlMP64t8Cz3cBb
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Sep 2023 21:51:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlMNz1sj3z3bY3
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Sep 2023 21:51:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrwqwZ6_1694519461;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrwqwZ6_1694519461)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 19:51:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: print filesystem summaries after success
Date: Tue, 12 Sep 2023 19:50:59 +0800
Message-Id: <20230912115059.1997278-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Users might be interested in some details of the generated image.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h    |  1 +
 include/erofs/internal.h |  2 ++
 lib/blobchunk.c          |  1 +
 lib/cache.c              | 12 ++++++++++--
 lib/compress.c           |  5 +++++
 mkfs/main.c              | 27 +++++++++++++++++++++------
 6 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index dc29985..de5584e 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -112,6 +112,7 @@ erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
 bool erofs_bflush(struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
+erofs_blk_t erofs_total_metablocks(void);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 405cbf0..19b912b 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -114,6 +114,8 @@ struct erofs_sb_info {
 	unsigned int blobfd[256];
 
 	struct list_head list;
+
+	u64 saved_by_deduplication;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 07f18bd..71fb2ff 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -69,6 +69,7 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 	chunk = hashmap_get_from_hash(&blob_hashmap, hash, sha256);
 	if (chunk) {
 		DBG_BUGON(chunksize != chunk->chunksize);
+		sbi->saved_by_deduplication += chunksize;
 		erofs_dbg("Found duplicated chunk at %u", chunk->blkaddr);
 		return chunk;
 	}
diff --git a/lib/cache.c b/lib/cache.c
index 925054a..5205d57 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -14,7 +14,7 @@ static struct erofs_buffer_block blkh = {
 	.list = LIST_HEAD_INIT(blkh.list),
 	.blkaddr = NULL_ADDR,
 };
-static erofs_blk_t tail_blkaddr;
+static erofs_blk_t tail_blkaddr, erofs_metablkcnt;
 
 /* buckets for all mapped buffer blocks to boost up allocation */
 static struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
@@ -396,6 +396,8 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 			dev_fillzero(&sbi, erofs_pos(&sbi, blkaddr) - padding,
 				     padding, true);
 
+		if (p->type != DATA)
+			erofs_metablkcnt += BLK_ROUND_UP(&sbi, p->buffers.off);
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 		erofs_bfree(p);
 	}
@@ -419,8 +421,14 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	if (!list_empty(&bb->buffers.list))
 		return;
 
+	if (!rollback && bb->type != DATA)
+		erofs_metablkcnt += BLK_ROUND_UP(&sbi, bb->buffers.off);
 	erofs_bfree(bb);
-
 	if (rollback)
 		tail_blkaddr = blkaddr;
 }
+
+erofs_blk_t erofs_total_metablocks(void)
+{
+	return erofs_metablkcnt;
+}
diff --git a/lib/compress.c b/lib/compress.c
index e5d310f..8c79418 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -221,6 +221,8 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 			ctx->e.length -= delta;
 		}
 
+		sbi->saved_by_deduplication +=
+			dctx.e.compressedblks * erofs_blksiz(sbi);
 		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %u of %u blocks",
 			  dctx.e.length, dctx.e.raw ? "un" : "",
 			  delta, dctx.e.blkaddr, dctx.e.compressedblks);
@@ -975,6 +977,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	z_erofs_dedupe_commit(false);
 	z_erofs_write_mapheader(inode, compressmeta);
 
+	if (!ctx.fragemitted)
+		sbi->saved_by_deduplication += inode->fragment_size;
+
 	/* if the entire file is a fragment, a simplified form is used. */
 	if (inode->i_size == inode->fragment_size) {
 		DBG_BUGON(inode->fragmentoff >> 63);
diff --git a/mkfs/main.c b/mkfs/main.c
index 18b7dfe..1620d23 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -858,6 +858,25 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 	return 0;
 }
 
+static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
+{
+	char uuid_str[37] = {};
+
+	if (!(cfg.c_dbg_lvl > EROFS_ERR && cfg.c_showprogress))
+		return;
+
+	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
+
+	fprintf(stdout, "------\nFilesystem UUID: %s\n"
+		"Filesystem total blocks: %u (of %u-byte blocks)\n"
+		"Filesystem total inodes: %llu\n"
+		"Filesystem total metadata blocks: %u\n"
+		"Filesystem total deduplicated bytes (of source files): %llu\n",
+		uuid_str, nblocks, 1U << sbi.blkszbits, sbi.inos | 0ULL,
+		erofs_total_metablocks(),
+		sbi.saved_by_deduplication | 0ULL);
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -866,7 +885,6 @@ int main(int argc, char **argv)
 	erofs_nid_t root_nid, packed_nid;
 	erofs_blk_t nblocks;
 	struct timeval t;
-	char uuid_str[37];
 	FILE *packedfile = NULL;
 
 	erofs_init_configure();
@@ -1027,8 +1045,6 @@ int main(int argc, char **argv)
 			  erofs_strerror(err));
 		goto exit;
 	}
-	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
-	erofs_info("filesystem UUID: %s", uuid_str);
 
 	erofs_inode_manager_init();
 
@@ -1081,7 +1097,6 @@ int main(int argc, char **argv)
 	erofs_iput(root_inode);
 
 	if (erofstar.index_mode || cfg.c_chunkbits) {
-		erofs_info("total metadata: %u blocks", erofs_mapbh(NULL));
 		if (erofstar.index_mode && !erofstar.mapfile)
 			sbi.devs[0].blocks =
 				BLK_ROUND_UP(&sbi, erofstar.offset);
@@ -1142,8 +1157,8 @@ exit:
 		erofs_err("\tCould not format the device : %s\n",
 			  erofs_strerror(err));
 		return 1;
-	} else {
-		erofs_update_progressinfo("Build completed.\n");
 	}
+	erofs_update_progressinfo("Build completed.\n");
+	erofs_mkfs_showsummaries(nblocks);
 	return 0;
 }
-- 
2.39.3

