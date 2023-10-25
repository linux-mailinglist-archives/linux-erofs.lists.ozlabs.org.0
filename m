Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE27D6100
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Oct 2023 07:05:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SFcMN4CMLz3c1Q
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Oct 2023 16:05:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SFcMB2R9tz2xmC
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Oct 2023 16:05:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VutHDPB_1698210332;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VutHDPB_1698210332)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 13:05:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: lib: propagate return code for erofs_bflush()
Date: Wed, 25 Oct 2023 13:05:31 +0800
Message-Id: <20231025050531.1507163-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231023081241.1946579-3-hsiangkao@linux.alibaba.com>
References: <20231023081241.1946579-3-hsiangkao@linux.alibaba.com>
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

Instead of just using a boolean.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |  8 ++++----
 lib/cache.c           | 21 ++++++++++++++-------
 lib/compress.c        |  1 +
 lib/inode.c           | 18 +++++++++---------
 mkfs/main.c           | 14 +++++++-------
 5 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 31f54a4..11fc6ab 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -30,7 +30,7 @@ struct erofs_buffer_block;
 #define DEVT		5
 
 struct erofs_bhops {
-	bool (*flush)(struct erofs_buffer_head *bh);
+	int (*flush)(struct erofs_buffer_head *bh);
 };
 
 struct erofs_buffer_head {
@@ -91,11 +91,11 @@ static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 		(end ? list_next_entry(bh, list)->off : bh->off);
 }
 
-static inline bool erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
+static inline int erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 {
 	list_del(&bh->list);
 	free(bh);
-	return true;
+	return 0;
 }
 
 struct erofs_buffer_head *erofs_buffer_init(void);
@@ -108,7 +108,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
-bool erofs_bflush(struct erofs_buffer_block *bb);
+int erofs_bflush(struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
 erofs_blk_t erofs_total_metablocks(void);
diff --git a/lib/cache.c b/lib/cache.c
index e3cf69e..393b275 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -21,7 +21,7 @@ static struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
 /* last mapped buffer block to accelerate erofs_mapbh() */
 static struct erofs_buffer_block *last_mapped_block = &blkh;
 
-static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
 }
@@ -30,9 +30,9 @@ const struct erofs_bhops erofs_drop_directly_bhops = {
 	.flush = erofs_bh_flush_drop_directly,
 };
 
-static bool erofs_bh_flush_skip_write(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_skip_write(struct erofs_buffer_head *bh)
 {
-	return false;
+	return -EBUSY;
 }
 
 const struct erofs_bhops erofs_skip_write_bhops = {
@@ -366,7 +366,7 @@ static void erofs_bfree(struct erofs_buffer_block *bb)
 	free(bb);
 }
 
-bool erofs_bflush(struct erofs_buffer_block *bb)
+int erofs_bflush(struct erofs_buffer_block *bb)
 {
 	const unsigned int blksiz = erofs_blksiz(&sbi);
 	struct erofs_buffer_block *p, *n;
@@ -376,6 +376,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 		struct erofs_buffer_head *bh, *nbh;
 		unsigned int padding;
 		bool skip = false;
+		int ret;
 
 		if (p == bb)
 			break;
@@ -383,9 +384,15 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 		blkaddr = __erofs_mapbh(p);
 
 		list_for_each_entry_safe(bh, nbh, &p->buffers.list, list) {
-			/* flush and remove bh */
-			if (!bh->op->flush(bh))
+			if (bh->op == &erofs_skip_write_bhops) {
 				skip = true;
+				continue;
+			}
+
+			/* flush and remove bh */
+			ret = bh->op->flush(bh);
+			if (ret < 0)
+				return ret;
 		}
 
 		if (skip)
@@ -401,7 +408,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 		erofs_bfree(p);
 	}
-	return true;
+	return 0;
 }
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
diff --git a/lib/compress.c b/lib/compress.c
index f6dc12a..5900233 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1045,6 +1045,7 @@ err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
 err_free_meta:
 	free(compressmeta);
+	inode->compressmeta = NULL;
 	return ret;
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index 8409ccd..98892af 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -117,6 +117,7 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	list_for_each_entry_safe(d, t, &inode->i_subdirs, d_child)
 		free(d);
 
+	free(inode->compressmeta);
 	if (inode->eof_tailraw)
 		free(inode->eof_tailraw);
 	list_del(&inode->i_hash);
@@ -486,7 +487,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 	return write_uncompressed_file_from_fd(inode, fd);
 }
 
-static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -578,19 +579,19 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 
 	ret = dev_write(sbi, &u, off, inode->inode_isize);
 	if (ret)
-		return false;
+		return ret;
 	off += inode->inode_isize;
 
 	if (inode->xattr_isize) {
 		char *xattrs = erofs_export_xattr_ibody(inode);
 
 		if (IS_ERR(xattrs))
-			return false;
+			return PTR_ERR(xattrs);
 
 		ret = dev_write(sbi, xattrs, off, inode->xattr_isize);
 		free(xattrs);
 		if (ret)
-			return false;
+			return ret;
 
 		off += inode->xattr_isize;
 	}
@@ -599,15 +600,14 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
 			ret = erofs_blob_write_chunk_indexes(inode, off);
 			if (ret)
-				return false;
+				return ret;
 		} else {
 			/* write compression metadata */
 			off = roundup(off, 8);
 			ret = dev_write(sbi, inode->compressmeta, off,
 					inode->extent_isize);
 			if (ret)
-				return false;
-			free(inode->compressmeta);
+				return ret;
 		}
 	}
 
@@ -718,7 +718,7 @@ noinline:
 	return 0;
 }
 
-static bool erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
 	const erofs_off_t off = erofs_btell(bh, false);
@@ -726,7 +726,7 @@ static bool erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 
 	ret = dev_write(inode->sbi, inode->idata, off, inode->idata_size);
 	if (ret)
-		return false;
+		return ret;
 
 	inode->idata_size = 0;
 	free(inode->idata);
diff --git a/mkfs/main.c b/mkfs/main.c
index 6d2b700..637d1b9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1170,10 +1170,9 @@ int main(int argc, char **argv)
 	}
 
 	/* flush all buffers except for the superblock */
-	if (!erofs_bflush(NULL)) {
-		err = -EIO;
+	err = erofs_bflush(NULL);
+	if (err)
 		goto exit;
-	}
 
 	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
 					    packed_nid);
@@ -1181,10 +1180,11 @@ int main(int argc, char **argv)
 		goto exit;
 
 	/* flush all remaining buffers */
-	if (!erofs_bflush(NULL))
-		err = -EIO;
-	else
-		err = dev_resize(&sbi, nblocks);
+	err = erofs_bflush(NULL);
+	if (err)
+		goto exit;
+
+	err = dev_resize(&sbi, nblocks);
 
 	if (!err && erofs_sb_has_sb_chksum(&sbi))
 		err = erofs_mkfs_superblock_csum_set();
-- 
2.39.3

