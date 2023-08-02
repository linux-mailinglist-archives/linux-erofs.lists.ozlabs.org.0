Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39C76C952
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 11:18:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RG5xq6xsdz3bpd
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 19:18:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RG5xD643gz30hM
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Aug 2023 19:18:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VouWeGu_1690967883;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VouWeGu_1690967883)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 17:18:04 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 13/16] erofs-utils: add erofs_rebuild_load_tree() helper
Date: Wed,  2 Aug 2023 17:17:47 +0800
Message-Id: <20230802091750.74181-13-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
References: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add erofs_rebuild_load_tree() helper loading inode tree from given erofs
image, and making it merged into a given inode tree in an overlayfs like
model.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/rebuild.h |   2 +
 lib/rebuild.c           | 269 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 271 insertions(+)

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index df7613a..57c0e42 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -21,6 +21,8 @@ struct erofs_img *erofs_get_img(const char *path);
 int erofs_add_img(const char *path);
 void erofs_cleanup_imgs(void);
 
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img);
+
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq);
 
diff --git a/lib/rebuild.c b/lib/rebuild.c
index e2f6c1d..33b539f 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -3,9 +3,14 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/rebuild.h"
+#include "erofs/io.h"
+#include "erofs/dir.h"
+#include "erofs/xattr.h"
+#include "erofs/blobchunk.h"
 #include "erofs/internal.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
@@ -119,6 +124,270 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 	return d;
 }
 
+static int erofs_rebuild_fill_inode_map(struct erofs_inode *inode,
+				struct erofs_inode *vi, dev_t dev)
+{
+	int ret;
+	unsigned int count, unit, chunkbits, deviceid, i;
+	erofs_off_t chunksize;
+	erofs_blk_t blkaddr;
+	struct erofs_inode_chunk_index *idx;
+
+	/* TODO: fill data map in other layouts */
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
+		inode->u.i_blkaddr = NULL_ADDR;
+		return 0;
+	}
+
+	inode->u.chunkformat = vi->u.chunkformat;
+	chunkbits = vi->u.chunkbits;
+	chunksize = 1ULL << chunkbits;
+	count = DIV_ROUND_UP(inode->i_size, chunksize);
+
+	if (vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+		unit = sizeof(struct erofs_inode_chunk_index);
+	else
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
+
+	inode->extent_isize = count * unit;
+	idx = malloc(max(sizeof(*idx), sizeof(void *)));
+	if (!idx)
+		return -ENOMEM;
+	inode->chunkindexes = idx;
+
+	if (vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+		deviceid = dev;
+	else
+		deviceid = 0;
+
+	for (i = 0; i < count; i++) {
+		struct erofs_blobchunk *chunk;
+		struct erofs_map_blocks map = {
+			.index = UINT_MAX,
+		};
+
+		map.m_la = i << chunkbits;
+		ret = erofs_map_blocks(vi, &map, 0);
+		if (ret)
+			goto err;
+
+		blkaddr = erofs_blknr(vi->sbi, map.m_pa);
+		chunk = erofs_get_unhashed_chunk(deviceid, blkaddr, 0);
+		if (IS_ERR(chunk)) {
+			ret = PTR_ERR(chunk);
+			goto err;
+		}
+		*(void **)idx++ = chunk;
+		erofs_dbg("\t%s: chunk %d (deviceid %u, blkaddr %u)",
+			inode->i_srcpath, i, deviceid, blkaddr);
+
+	}
+	inode->datalayout = EROFS_INODE_CHUNK_BASED;
+	return 0;
+err:
+	free(idx);
+	inode->chunkindexes = NULL;
+	return ret;
+}
+
+static int erofs_rebuild_fill_inode(struct erofs_inode *inode,
+			struct erofs_inode *vi, dev_t dev)
+{
+	int ret = 0;
+
+	inode->i_srcpath = strdup(vi->i_srcpath);
+	inode->i_mode = vi->i_mode;
+	inode->i_uid = vi->i_uid;
+	inode->i_gid = vi->i_gid;
+	inode->i_mtime = vi->i_mtime;
+	inode->i_ino[1] = vi->i_ino[0];
+	inode->i_nlink = 1;
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->u.i_rdev = erofs_new_encode_dev(vi->u.i_rdev);
+		inode->i_size = 0;
+		erofs_dbg("\tdev: %d %d", major(vi->u.i_rdev),
+			  minor(vi->u.i_rdev));
+		break;
+	case S_IFDIR:
+		inode->i_size = 0;
+		ret = erofs_init_empty_dir(inode);
+		break;
+	case S_IFLNK:
+		inode->i_size = vi->i_size;
+		inode->i_link = malloc(inode->i_size + 1);
+		ret = erofs_pread(vi, inode->i_link, inode->i_size, 0);
+		erofs_dbg("\tsymlink: %s -> %s", inode->i_srcpath, inode->i_link);
+		break;
+	case S_IFREG:
+		inode->i_size = vi->i_size;
+		if (inode->i_size)
+			ret = erofs_rebuild_fill_inode_map(inode, vi, dev);
+		else
+			inode->u.i_blkaddr = NULL_ADDR;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+struct erofs_rebuild_dir_context {
+	struct erofs_dir_context ctx;
+	struct erofs_inode *root;
+	dev_t dev;
+};
+
+static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
+{
+	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
+	struct erofs_inode *dir = ctx->dir;
+	struct erofs_sb_info *sbi = dir->sbi;
+	struct erofs_inode *inode, vi = {};
+	struct erofs_dentry *d;
+	char *path;
+	int ret;
+
+	if (ctx->dot_dotdot)
+		return 0;
+
+	vi.nid = ctx->de_nid;
+	vi.sbi = sbi;
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret) {
+		erofs_err("file %s/%.*s: read failed",
+			  dir->i_srcpath, ctx->de_namelen, ctx->dname);
+		return ret;
+	}
+
+	ret = asprintf(&path, "%s/%.*s", dir->i_srcpath, ctx->de_namelen,
+		       ctx->dname);
+	if (ret < 0) {
+		erofs_err("file %s/%.*s: failed to alloc path",
+			  dir->i_srcpath, ctx->de_namelen, ctx->dname);
+		return ret;
+	}
+	vi.i_srcpath = path;
+
+	d = erofs_rebuild_get_dentry(rctx->root, path, false, NULL, NULL);
+	if (IS_ERR(d)) {
+		ret = PTR_ERR(d);
+		goto exit;
+	}
+
+	if (d->type != EROFS_FT_UNKNOWN) {
+		inode = d->inode;
+		DBG_BUGON((inode->i_mode & S_IFMT) != (vi.i_mode & S_IFMT));
+		if (!S_ISDIR(inode->i_mode) || inode->opaque) {
+			erofs_dbg("file %s: %s (%d) exists",
+				  path, inode->i_srcpath,
+				  erofs_mode_to_ftype(inode->i_mode));
+			free(path);
+			return 0;
+		}
+		erofs_dbg("dir %s: %s merging", path, inode->i_srcpath);
+	} else {
+		erofs_dbg("loading file: %s (%d) (nid %llu)",
+			  path, erofs_mode_to_ftype(vi.i_mode), ctx->de_nid);
+		if (S_ISREG(vi.i_mode) && vi.i_nlink > 1 &&
+		    (inode = erofs_iget(rctx->dev, vi.i_ino[0]))) {
+			/* hardlink file */
+			if (S_ISDIR(inode->i_mode)) {
+				erofs_dbg("hardlink directory not supported");
+				erofs_iput(inode);
+				return -EISDIR;
+			}
+			inode->i_nlink++;
+			erofs_dbg("\thardlink: %s -> %s", vi.i_srcpath, inode->i_srcpath);
+		} else {
+			inode = erofs_new_inode();
+			if (IS_ERR(inode)) {
+				ret = PTR_ERR(inode);
+				goto exit;
+			}
+
+			inode->i_parent = d->inode;
+			inode->dev = rctx->dev;
+			ret = erofs_rebuild_fill_inode(inode, &vi, rctx->dev);
+			if (ret)
+				goto exit_inode;
+
+			ret = erofs_read_xattrs_from_disk(&vi);
+			if (ret)
+				goto exit_inode;
+			list_splice_tail(&vi.i_xattrs, &inode->i_xattrs);
+			erofs_inode_tag_opaque(inode);
+
+			erofs_insert_ihash(inode, rctx->dev, inode->i_ino[1]);
+		}
+
+		d->inode = inode;
+		d->type = erofs_mode_to_ftype(inode->i_mode);
+	}
+
+	ret = 0;
+	if (S_ISDIR(vi.i_mode)) {
+		struct erofs_rebuild_dir_context nctx = *rctx;
+
+		nctx.ctx.dir = &vi;
+		ret = erofs_iterate_dir(&nctx.ctx, false);
+	}
+exit:
+	free(path);
+	return ret;
+exit_inode:
+	erofs_iput(inode);
+	goto exit;
+}
+
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img)
+{
+	struct erofs_inode inode = {};
+	struct erofs_sb_info *sbi = &img->sbi;
+	struct erofs_rebuild_dir_context ctx;
+	int ret;
+
+	erofs_dbg("Loading image %s...", img->path);
+
+	ret = dev_open_ro(sbi, img->path);
+	if (ret) {
+		erofs_err("failed to open image %s", img->path);
+		return ret;
+	}
+
+	ret = erofs_read_superblock(sbi);
+	if (ret) {
+		erofs_err("failed to read superblock of image %s", img->path);
+		goto exit;
+	}
+
+	inode.nid = sbi->root_nid;
+	inode.sbi = sbi;
+	ret = erofs_read_inode_from_disk(&inode);
+	if (ret) {
+		erofs_err("failed to read root inode of image %s", img->path);
+		goto exit;
+	}
+	inode.i_srcpath = strdup("/");
+
+	ctx = (struct erofs_rebuild_dir_context) {
+		.ctx.dir = &inode,
+		.ctx.cb = erofs_rebuild_dirent_iter,
+		.root = root,
+		.dev = img->dev,
+	};
+	ret = erofs_iterate_dir(&ctx.ctx, false);
+	free(inode.i_srcpath);
+exit:
+	dev_close(sbi);
+	return ret;
+}
+
 struct erofs_img *erofs_get_img(const char *path)
 {
 	struct erofs_img *img = malloc(sizeof(*img));
-- 
2.19.1.6.gb485710b

