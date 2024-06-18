Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3601D90C4E0
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 10:24:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cfyt977q;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3KYY6XZqz2xqq
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 18:24:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cfyt977q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3KYG3tr9z2yvx
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 18:24:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718699070; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/vCtArj1pkybWvpedGxPVOZt9EvRZGbNPksM9u4OhmU=;
	b=cfyt977qNle7EfYtS7+iJQudh4p/u1ZoGELFWub24QqlhjwdKaSCat1Bj2BVI9o8A6kEPW95HuvnWV/lLjT7BG967zfupTnRZ9UPZ6B58Uw0GH2H/XAE6LSoUHDbz4FVYxkmLbTSlT98ey9RiclFpxlWpaTfs1hCEhHRbOJRHuM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jcN9f_1718699068;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jcN9f_1718699068)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:24:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 03/10] erofs-utils: fix up root inode for incremental builds
Date: Tue, 18 Jun 2024 16:24:08 +0800
Message-Id: <20240618082414.47876-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
References: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
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

Move the new root inode to the original location if it cannot
be accessed by the super block.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  3 +-
 lib/inode.c           | 95 +++++++++++++++++++++++++++++++++++--------
 mkfs/main.c           | 13 ++++--
 3 files changed, 88 insertions(+), 23 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 557150c..0fc9b80 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -34,7 +34,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 int erofs_iflush(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
-int erofs_rebuild_dump_tree(struct erofs_inode *dir);
+int erofs_rebuild_dump_tree(struct erofs_inode *dir, bool incremental);
 int erofs_init_empty_dir(struct erofs_inode *dir);
 int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		       const char *path);
@@ -43,6 +43,7 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
 						    const char *path);
 struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 						     int fd, const char *name);
+int erofs_fixup_root_inode(struct erofs_inode *root);
 
 #ifdef __cplusplus
 }
diff --git a/lib/inode.c b/lib/inode.c
index 0bfaa56..a4f61ab 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -311,17 +311,18 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_off_t off, meta_offset;
 
-	if (!bh || (long long)inode->nid > 0)
-		return inode->nid;
-
-	erofs_mapbh(bh->block);
-	off = erofs_btell(bh, false);
-
-	meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
-	DBG_BUGON(off < meta_offset);
-	inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
-	erofs_dbg("Assign nid %llu to file %s (mode %05o)",
-		  inode->nid, inode->i_srcpath, inode->i_mode);
+	if (bh && (long long)inode->nid <= 0) {
+		erofs_mapbh(bh->block);
+		off = erofs_btell(bh, false);
+
+		meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
+		DBG_BUGON(off < meta_offset);
+		inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
+		erofs_dbg("Assign nid %llu to file %s (mode %05o)",
+			  inode->nid, inode->i_srcpath, inode->i_mode);
+	}
+	if (unlikely(IS_ROOT(inode)) && inode->nid > 0xffff)
+		return sbi->root_nid;
 	return inode->nid;
 }
 
@@ -739,7 +740,6 @@ static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 	if (ret)
 		return ret;
 
-	inode->idata_size = 0;
 	free(inode->idata);
 	inode->idata = NULL;
 
@@ -1531,7 +1531,8 @@ static void erofs_mark_parent_inode(struct erofs_inode *inode,
 	inode->i_parent = (void *)((unsigned long)dir | 1);
 }
 
-static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild)
+static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
+				bool incremental)
 {
 	struct erofs_sb_info *sbi = root->sbi;
 	struct erofs_inode *dumpdir = erofs_igrab(root);
@@ -1545,9 +1546,12 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild)
 	if (err)
 		return err;
 
-	erofs_mkfs_flushjobs(sbi);
-	erofs_fixup_meta_blkaddr(root);		/* assign root NID */
-	sbi->root_nid = root->nid;
+	/* assign root NID immediately for non-incremental builds */
+	if (!incremental) {
+		erofs_mkfs_flushjobs(sbi);
+		erofs_fixup_meta_blkaddr(root);
+		sbi->root_nid = root->nid;
+	}
 
 	do {
 		int err;
@@ -1600,6 +1604,7 @@ struct erofs_mkfs_buildtree_ctx {
 		const char *path;
 		struct erofs_inode *root;
 	} u;
+	bool incremental;
 };
 #ifndef EROFS_MT_ENABLED
 #define __erofs_mkfs_build_tree erofs_mkfs_build_tree
@@ -1619,7 +1624,7 @@ static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 		root = ctx->u.root;
 	}
 
-	err = erofs_mkfs_dump_tree(root, !from_path);
+	err = erofs_mkfs_dump_tree(root, !from_path, ctx->incremental);
 	if (err) {
 		if (from_path)
 			erofs_iput(root);
@@ -1692,11 +1697,12 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
 	return ctx.u.root;
 }
 
-int erofs_rebuild_dump_tree(struct erofs_inode *root)
+int erofs_rebuild_dump_tree(struct erofs_inode *root, bool incremental)
 {
 	return erofs_mkfs_build_tree(&((struct erofs_mkfs_buildtree_ctx) {
 		.sbi = NULL,
 		.u.root = root,
+		.incremental = incremental,
 	}));
 }
 
@@ -1758,3 +1764,56 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 	erofs_write_tail_end(inode);
 	return inode;
 }
+
+int erofs_fixup_root_inode(struct erofs_inode *root)
+{
+	struct erofs_sb_info *sbi = root->sbi;
+	struct erofs_inode oi;
+	unsigned int ondisk_capacity, ondisk_size;
+	char *ibuf;
+	int err;
+
+	if (sbi->root_nid == root->nid)
+		return 0;
+
+	if (root->nid <= 0xffff) {
+		sbi->root_nid = root->nid;
+		return 0;
+	}
+
+	oi = (struct erofs_inode){ .sbi = sbi, .nid = sbi->root_nid };
+	err = erofs_read_inode_from_disk(&oi);
+	if (err) {
+		erofs_err("failed to read root inode: %s",
+			  erofs_strerror(err));
+		return err;
+	}
+
+	if (oi.datalayout != EROFS_INODE_FLAT_INLINE &&
+	    oi.datalayout != EROFS_INODE_FLAT_PLAIN)
+		return -EOPNOTSUPP;
+
+	ondisk_capacity = oi.inode_isize + oi.xattr_isize;
+	if (oi.datalayout == EROFS_INODE_FLAT_INLINE)
+		ondisk_capacity += erofs_blkoff(sbi, oi.i_size);
+
+	ondisk_size = root->inode_isize + root->xattr_isize;
+	if (root->extent_isize)
+		ondisk_size = roundup(ondisk_size, 8) + root->extent_isize;
+	ondisk_size += root->idata_size;
+
+	if (ondisk_size > ondisk_capacity) {
+		erofs_err("no enough room for the root inode from nid %llu",
+			  root->nid);
+		return -ENOSPC;
+	}
+
+	ibuf = malloc(ondisk_size);
+	if (!ibuf)
+		return -ENOMEM;
+	err = erofs_dev_read(sbi, 0, ibuf, erofs_iloc(root), ondisk_size);
+	if (err >= 0)
+		err = erofs_dev_write(sbi, ibuf, erofs_iloc(&oi), ondisk_size);
+	free(ibuf);
+	return err;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index d15b790..cb6dfe6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1136,7 +1136,7 @@ int main(int argc, char **argv)
 {
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
-	struct erofs_inode *root;
+	struct erofs_inode *root = NULL;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	FILE *packedfile = NULL;
@@ -1309,7 +1309,7 @@ int main(int argc, char **argv)
 		if (err < 0)
 			goto exit;
 
-		err = erofs_rebuild_dump_tree(root);
+		err = erofs_rebuild_dump_tree(root, false);
 		if (err < 0)
 			goto exit;
 	} else if (rebuild_mode) {
@@ -1322,7 +1322,7 @@ int main(int argc, char **argv)
 		err = erofs_rebuild_load_trees(root);
 		if (err)
 			goto exit;
-		err = erofs_rebuild_dump_tree(root);
+		err = erofs_rebuild_dump_tree(root, false);
 		if (err)
 			goto exit;
 	} else {
@@ -1342,7 +1342,6 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 	}
-	erofs_iput(root);
 
 	if (erofstar.index_mode && sbi.extra_devices && !erofstar.mapfile)
 		sbi.devs[0].blocks = BLK_ROUND_UP(&sbi, erofstar.offset);
@@ -1365,6 +1364,10 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
+	erofs_fixup_root_inode(root);
+	erofs_iput(root);
+	root = NULL;
+
 	err = erofs_writesb(&sbi, sb_bh, &nblocks);
 	if (err)
 		goto exit;
@@ -1379,6 +1382,8 @@ int main(int argc, char **argv)
 	if (!err && erofs_sb_has_sb_chksum(&sbi))
 		err = erofs_mkfs_superblock_csum_set();
 exit:
+	if (root)
+		erofs_iput(root);
 	z_erofs_compress_exit();
 	z_erofs_dedupe_exit();
 	erofs_blocklist_close();
-- 
2.39.3

