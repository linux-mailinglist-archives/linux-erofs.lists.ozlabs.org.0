Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893B90C4E5
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 10:25:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z8ILzWzU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3KYx25D4z3cGC
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 18:25:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z8ILzWzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3KYK1BsLz30Tp
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 18:24:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718699073; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UaPDkggijezAVjESNPPKOvXoiun9iEUu5HnohH4VOtU=;
	b=Z8ILzWzUz9lEEGuu5dyqb6zGo2U5E361SIZIYQmNmfqovFWA3B4t8QKz7RAteOAa6osD2aIzKafpYejhOeIu8wojdUICFI3hQ7vpkm6Kw93XiJ9yrRz6e180Wajpst6lKgEKQzTmpSImTiNAePnUSibA+04QORC4MVvnZhEr5AU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jcNAz_1718699071;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jcNAz_1718699071)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:24:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 06/10] erofs-utils: support building image with reserved space
Date: Tue, 18 Jun 2024 16:24:11 +0800
Message-Id: <20240618082414.47876-6-hsiangkao@linux.alibaba.com>
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

A new mode is prepared in order to preallocate/reserve data blocks only
since some applications tend to fill data after EROFS images are built.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  7 +++-
 include/erofs/rebuild.h  |  9 ++++-
 lib/inode.c              | 45 +++++++++++++++++----
 lib/rebuild.c            | 84 ++++++++++++++++++++++++----------------
 lib/tar.c                |  2 +-
 mkfs/main.c              |  3 +-
 6 files changed, 104 insertions(+), 46 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 39cf066..1d6496a 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -170,6 +170,11 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
 struct erofs_diskbuf;
 
+#define EROFS_INODE_DATA_SOURCE_NONE		0
+#define EROFS_INODE_DATA_SOURCE_LOCALPATH	1
+#define EROFS_INODE_DATA_SOURCE_DISKBUF		2
+#define EROFS_INODE_DATA_SOURCE_RESVSP		3
+
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
@@ -216,9 +221,9 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
 	unsigned short idata_size;
+	char datasource;
 	bool compressed_idata;
 	bool lazy_tailblock;
-	bool with_diskbuf;
 	bool opaque;
 	/* OVL: non-merge dir that may contain whiteout entries */
 	bool whiteouts;
diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index e99ce74..59b2f6f 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -9,10 +9,17 @@ extern "C"
 
 #include "internal.h"
 
+enum erofs_rebuild_datamode {
+	EROFS_REBUILD_DATA_BLOB_INDEX,
+	EROFS_REBUILD_DATA_RESVSP,
+	EROFS_REBUILD_DATA_FULL,
+};
+
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq, bool to_head);
 
-int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi);
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
+			    enum erofs_rebuild_datamode mode);
 
 #ifdef __cplusplus
 }
diff --git a/lib/inode.c b/lib/inode.c
index 6c4fa2a..60a076a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -143,7 +143,8 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	list_del(&inode->i_hash);
 	if (inode->i_srcpath)
 		free(inode->i_srcpath);
-	if (inode->with_diskbuf) {
+
+	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
 		erofs_diskbuf_close(inode->i_diskbuf);
 		free(inode->i_diskbuf);
 	} else if (inode->i_link) {
@@ -1175,6 +1176,30 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
+static int erofs_inode_reserve_data_blocks(struct erofs_inode *inode)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_off_t alignedsz = round_up(inode->i_size, erofs_blksiz(sbi));
+	erofs_blk_t nblocks = alignedsz >> sbi->blkszbits;
+	struct erofs_buffer_head *bh;
+
+	/* allocate data blocks */
+	bh = erofs_balloc(DATA, alignedsz, 0, 0);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	/* get blkaddr of the bh */
+	(void)erofs_mapbh(bh->block);
+
+	/* write blocks except for the tail-end block */
+	inode->u.i_blkaddr = bh->block->blkaddr;
+	erofs_bdrop(bh, false);
+
+	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+	tarerofs_blocklist_write(inode->u.i_blkaddr, nblocks, inode->i_ino[1]);
+	return 0;
+}
+
 struct erofs_mkfs_job_ndir_ctx {
 	struct erofs_inode *inode;
 	void *ictx;
@@ -1187,7 +1212,8 @@ static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 	struct erofs_inode *inode = ctx->inode;
 	int ret;
 
-	if (inode->with_diskbuf && lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
+	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF &&
+	    lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
 		ret = -errno;
 		goto out;
 	}
@@ -1204,11 +1230,11 @@ static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 	/* fallback to all data uncompressed */
 	ret = erofs_write_unencoded_file(inode, ctx->fd, ctx->fpos);
 out:
-	if (inode->with_diskbuf) {
+	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
 		erofs_diskbuf_close(inode->i_diskbuf);
 		free(inode->i_diskbuf);
 		inode->i_diskbuf = NULL;
-		inode->with_diskbuf = false;
+		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
 	} else {
 		close(ctx->fd);
 	}
@@ -1236,8 +1262,11 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_mkfs_job_ndir_ctx *ctx)
 		ret = erofs_write_file_from_buffer(inode, symlink);
 		free(symlink);
 		inode->i_link = NULL;
-	} else if (inode->i_size && ctx->fd >= 0) {
-		ret = erofs_mkfs_job_write_file(ctx);
+	} else if (inode->i_size) {
+		if (inode->datasource == EROFS_INODE_DATA_SOURCE_RESVSP)
+			ret = erofs_inode_reserve_data_blocks(inode);
+		else if (ctx->fd >= 0)
+			ret = erofs_mkfs_job_write_file(ctx);
 	}
 	if (ret)
 		return ret;
@@ -1628,8 +1657,8 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 		struct erofs_mkfs_job_ndir_ctx ctx =
 			{ .inode = inode, .fd = -1 };
 
-		if (!S_ISLNK(inode->i_mode) && inode->i_size &&
-		    inode->with_diskbuf) {
+		if (S_ISREG(inode->i_mode) && inode->i_size &&
+		    inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
 			ctx.fd = erofs_diskbuf_getfd(inode->i_diskbuf, &ctx.fpos);
 			if (ctx.fd < 0)
 				return ret;
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 6f2e301..9c1e8f8 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -128,7 +128,8 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 	return d;
 }
 
-static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
+static int erofs_rebuild_write_blob_index(struct erofs_sb_info *dst_sb,
+					  struct erofs_inode *inode)
 {
 	int ret;
 	unsigned int count, unit, chunkbits, i;
@@ -137,26 +138,26 @@ static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
 	erofs_blk_t blkaddr;
 
 	/* TODO: fill data map in other layouts */
-	if (inode->datalayout != EROFS_INODE_CHUNK_BASED &&
-	    inode->datalayout != EROFS_INODE_FLAT_PLAIN) {
-		erofs_err("%s: unsupported datalayout %d", inode->i_srcpath, inode->datalayout);
-		return -EOPNOTSUPP;
-	}
-
-	if (inode->sbi->extra_devices) {
+	if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
 		chunkbits = inode->u.chunkbits;
-		if (chunkbits < sbi.blkszbits) {
-			erofs_err("%s: chunk size %u is too small to fit the target block size %u",
-				  inode->i_srcpath, 1U << chunkbits, 1U << sbi.blkszbits);
+		if (chunkbits < dst_sb->blkszbits) {
+			erofs_err("%s: chunk size %u is smaller than the target block size %u",
+				  inode->i_srcpath, 1U << chunkbits,
+				  1U << dst_sb->blkszbits);
 			return -EINVAL;
 		}
-	} else {
+	} else if (inode->datalayout == EROFS_INODE_FLAT_PLAIN) {
 		chunkbits = ilog2(inode->i_size - 1) + 1;
-		if (chunkbits < sbi.blkszbits)
-			chunkbits = sbi.blkszbits;
-		if (chunkbits - sbi.blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
-			chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi.blkszbits;
+		if (chunkbits < dst_sb->blkszbits)
+			chunkbits = dst_sb->blkszbits;
+		if (chunkbits - dst_sb->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+			chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + dst_sb->blkszbits;
+	} else {
+		erofs_err("%s: unsupported datalayout %d ", inode->i_srcpath,
+			  inode->datalayout);
+		return -EOPNOTSUPP;
 	}
+
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
 
@@ -178,7 +179,7 @@ static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
 		if (ret)
 			goto err;
 
-		blkaddr = erofs_blknr(&sbi, map.m_pa);
+		blkaddr = erofs_blknr(dst_sb, map.m_pa);
 		chunk = erofs_get_unhashed_chunk(inode->dev, blkaddr, 0);
 		if (IS_ERR(chunk)) {
 			ret = PTR_ERR(chunk);
@@ -189,7 +190,7 @@ static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
 	}
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
 	inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
-	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
+	inode->u.chunkformat |= chunkbits - dst_sb->blkszbits;
 	return 0;
 err:
 	free(inode->chunkindexes);
@@ -197,8 +198,12 @@ err:
 	return ret;
 }
 
-static int erofs_rebuild_fill_inode(struct erofs_inode *inode)
+static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
+				      struct erofs_inode *inode,
+				      enum erofs_rebuild_datamode datamode)
 {
+	int err = 0;
+
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFCHR:
 		if (erofs_inode_is_whiteout(inode))
@@ -211,36 +216,44 @@ static int erofs_rebuild_fill_inode(struct erofs_inode *inode)
 		erofs_dbg("\tdev: %d %d", major(inode->u.i_rdev),
 			  minor(inode->u.i_rdev));
 		inode->u.i_rdev = erofs_new_encode_dev(inode->u.i_rdev);
-		return 0;
+		break;
 	case S_IFDIR:
-		return erofs_init_empty_dir(inode);
-	case S_IFLNK: {
-		int ret;
-
+		err = erofs_init_empty_dir(inode);
+		break;
+	case S_IFLNK:
 		inode->i_link = malloc(inode->i_size + 1);
 		if (!inode->i_link)
 			return -ENOMEM;
-		ret = erofs_pread(inode, inode->i_link, inode->i_size, 0);
+		err = erofs_pread(inode, inode->i_link, inode->i_size, 0);
 		erofs_dbg("\tsymlink: %s -> %s", inode->i_srcpath, inode->i_link);
-		return ret;
-	}
+		break;
 	case S_IFREG:
-		if (inode->i_size)
-			return erofs_rebuild_fixup_inode_index(inode);
-		return 0;
-	default:
+		if (!inode->i_size) {
+			inode->u.i_blkaddr = NULL_ADDR;
+			break;
+		}
+		if (datamode == EROFS_REBUILD_DATA_BLOB_INDEX)
+			err = erofs_rebuild_write_blob_index(dst_sb, inode);
+		else if (datamode == EROFS_REBUILD_DATA_RESVSP)
+			inode->datasource = EROFS_INODE_DATA_SOURCE_RESVSP;
+		else
+			err = -EOPNOTSUPP;
 		break;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
+	return err;
 }
 
 /*
  * @mergedir: parent directory in the merged tree
  * @ctx.dir:  parent directory when itering erofs_iterate_dir()
+ * @datamode: indicate how to import inode data
  */
 struct erofs_rebuild_dir_context {
 	struct erofs_dir_context ctx;
 	struct erofs_inode *mergedir;
+	enum erofs_rebuild_datamode datamode;
 };
 
 static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
@@ -340,7 +353,8 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 			inode->i_ino[1] = inode->nid;
 			inode->i_nlink = 1;
 
-			ret = erofs_rebuild_fill_inode(inode);
+			ret = erofs_rebuild_update_inode(&sbi, inode,
+							 rctx->datamode);
 			if (ret) {
 				erofs_iput(inode);
 				goto out;
@@ -372,7 +386,8 @@ out:
 	return ret;
 }
 
-int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi)
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
+			    enum erofs_rebuild_datamode mode)
 {
 	struct erofs_inode inode = {};
 	struct erofs_rebuild_dir_context ctx;
@@ -403,6 +418,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi)
 		.ctx.dir = &inode,
 		.ctx.cb = erofs_rebuild_dirent_iter,
 		.mergedir = root,
+		.datamode = mode,
 	};
 	ret = erofs_iterate_dir(&ctx.ctx, false);
 	free(inode.i_srcpath);
diff --git a/lib/tar.c b/lib/tar.c
index 3a5d484..53a1188 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -607,7 +607,7 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 		j -= nread;
 	}
 	erofs_diskbuf_commit(inode->i_diskbuf, inode->i_size);
-	inode->with_diskbuf = true;
+	inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index cb6dfe6..425fe00 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1060,7 +1060,8 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 	int ret, idx;
 
 	list_for_each_entry(src, &rebuild_src_list, list) {
-		ret = erofs_rebuild_load_tree(root, src);
+		ret = erofs_rebuild_load_tree(root, src,
+					      EROFS_REBUILD_DATA_BLOB_INDEX);
 		if (ret) {
 			erofs_err("failed to load %s", src->devname);
 			return ret;
-- 
2.39.3

