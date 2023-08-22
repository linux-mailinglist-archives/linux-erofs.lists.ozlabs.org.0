Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9220783CD7
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 11:25:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVP8s5n8Fz3btp
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 19:25:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVP895bH9z302F
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Aug 2023 19:25:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqM6R.j_1692696308;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqM6R.j_1692696308)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 17:25:08 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 10/11] erofs-utils: lib: add erofs_rebuild_load_tree() helper
Date: Tue, 22 Aug 2023 17:24:56 +0800
Message-Id: <20230822092457.114686-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230822092457.114686-1-jefflexu@linux.alibaba.com>
References: <20230822092457.114686-1-jefflexu@linux.alibaba.com>
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

Since we need to read the content of the symlink file from disk when
loading tree, add dependency on zlib_LIBS for mkfs.erofs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |   3 +
 include/erofs/rebuild.h  |   2 +
 lib/rebuild.c            | 278 +++++++++++++++++++++++++++++++++++++++
 lib/tar.c                |   2 -
 4 files changed, 283 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index fa0a240..2559892 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -108,6 +108,7 @@ struct erofs_sb_info {
 
 	int devfd;
 	u64 devsz;
+	dev_t dev;
 	unsigned int nblobs;
 	unsigned int blobfd[256];
 };
@@ -424,6 +425,8 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, size_t len)
 	return crc;
 }
 
+#define EROFS_WHITEOUT_DEV	0
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index 92873c9..3ac074c 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -12,6 +12,8 @@ extern "C"
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq);
 
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 7aaa071..80eb7e6 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -3,9 +3,18 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
+#include <config.h>
+#if defined(HAVE_SYS_SYSMACROS_H)
+#include <sys/sysmacros.h>
+#endif
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/rebuild.h"
+#include "erofs/io.h"
+#include "erofs/dir.h"
+#include "erofs/xattr.h"
+#include "erofs/blobchunk.h"
 #include "erofs/internal.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
@@ -115,3 +124,272 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 	}
 	return d;
 }
+
+static int erofs_rebuild_fill_inode_map(struct erofs_inode *inode,
+					struct erofs_inode *vi)
+{
+	int ret;
+	struct erofs_sb_info *sbi = vi->sbi;
+	unsigned int count, unit, chunkbits, i;
+	unsigned int deviceid = inode->dev;
+	erofs_off_t chunksize;
+	erofs_blk_t blkaddr;
+	struct erofs_inode_chunk_index *idx;
+
+	/* TODO: fill data map in other layouts */
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED &&
+	    vi->datalayout != EROFS_INODE_FLAT_PLAIN) {
+		erofs_err("unsupported datalayout %d", vi->datalayout);
+		return -EOPNOTSUPP;
+	}
+
+	if (sbi->extra_devices) {
+		chunkbits = vi->u.chunkbits;
+		inode->u.chunkformat = vi->u.chunkformat;
+	} else {
+		chunkbits = ilog2(inode->i_size - 1) + 1;
+		if (chunkbits < sbi->blkszbits)
+			chunkbits = sbi->blkszbits;
+		if (chunkbits - sbi->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+			chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
+		inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
+		inode->u.chunkformat |= chunkbits - sbi->blkszbits;
+	}
+	chunksize = 1ULL << chunkbits;
+	count = DIV_ROUND_UP(inode->i_size, chunksize);
+
+	unit = sizeof(struct erofs_inode_chunk_index);
+	inode->extent_isize = count * unit;
+	idx = malloc(max(sizeof(*idx), sizeof(void *)));
+	if (!idx)
+		return -ENOMEM;
+	inode->chunkindexes = idx;
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
+		blkaddr = erofs_blknr(sbi, map.m_pa);
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
+				    struct erofs_inode *vi)
+{
+	int ret = 0;
+
+	inode->i_srcpath = strdup(vi->i_srcpath);
+	inode->i_mode = vi->i_mode;
+	inode->i_uid = vi->i_uid;
+	inode->i_gid = vi->i_gid;
+	inode->i_mtime = vi->i_mtime;
+	inode->i_ino[1] = vi->nid;
+	inode->i_nlink = 1;
+	inode->opaque = vi->opaque;
+	list_splice_tail(&vi->i_xattrs, &inode->i_xattrs);
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
+			ret = erofs_rebuild_fill_inode_map(inode, vi);
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
+static int erofs_rebuild_parse_inode(struct erofs_rebuild_dir_context *rctx,
+				     struct erofs_inode *vi)
+{
+	struct erofs_inode *inode;
+	struct erofs_dentry *d;
+	int ret;
+
+	d = erofs_rebuild_get_dentry(rctx->root, vi->i_srcpath,
+				     false, NULL, NULL);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	if (d->type != EROFS_FT_UNKNOWN) {
+		inode = d->inode;
+		/* drop whiteout if victim has appeared */
+		if (S_ISCHR(inode->i_mode) &&
+		    inode->u.i_rdev == EROFS_WHITEOUT_DEV) {
+			inode->drop = true;
+			return 0;
+		}
+
+		DBG_BUGON((inode->i_mode & S_IFMT) != (vi->i_mode & S_IFMT));
+		if (!S_ISDIR(inode->i_mode) || inode->opaque) {
+			erofs_dbg("file %s: %s (%d) exists",
+				  vi->i_srcpath, inode->i_srcpath,
+				  erofs_mode_to_ftype(inode->i_mode));
+			return 0;
+		}
+		erofs_dbg("dir %s: %s merging", vi->i_srcpath, inode->i_srcpath);
+	} else {
+		erofs_dbg("loading file: %s (%d) (nid %llu)", vi->i_srcpath,
+			  erofs_mode_to_ftype(vi->i_mode), vi->nid);
+		if (S_ISREG(vi->i_mode) && vi->i_nlink > 1 &&
+		    (inode = erofs_iget(rctx->dev, vi->nid))) {
+			/* hardlink file */
+			if (S_ISDIR(inode->i_mode)) {
+				erofs_dbg("hardlink directory not supported");
+				ret = -EISDIR;
+				goto put_inode;
+			}
+			inode->i_nlink++;
+			erofs_dbg("\thardlink: %s -> %s",
+				  vi->i_srcpath, inode->i_srcpath);
+		} else {
+			inode = erofs_new_inode();
+			if (IS_ERR(inode))
+				return PTR_ERR(inode);
+
+			ret = erofs_read_xattrs_from_disk(vi);
+			if (ret)
+				goto put_inode;
+
+			inode->i_parent = d->inode;
+			inode->dev = rctx->dev;
+			ret = erofs_rebuild_fill_inode(inode, vi);
+			if (ret)
+				goto put_inode;
+
+			erofs_insert_ihash(inode, rctx->dev, vi->nid);
+		}
+
+		d->inode = inode;
+		d->type = erofs_mode_to_ftype(inode->i_mode);
+	}
+
+	ret = 0;
+	if (S_ISDIR(vi->i_mode)) {
+		struct erofs_rebuild_dir_context nctx = *rctx;
+		nctx.ctx.dir = vi;
+		ret = erofs_iterate_dir(&nctx.ctx, false);
+	}
+	return ret;
+
+put_inode:
+	erofs_iput(inode);
+	return ret;
+}
+
+static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
+{
+	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
+	struct erofs_inode *dir = ctx->dir;
+	struct erofs_inode vi = {};
+	char *path;
+	int ret;
+
+	if (ctx->dot_dotdot)
+		return 0;
+
+	erofs_dbg("file %s/%.*s", dir->i_srcpath, ctx->de_namelen, ctx->dname);
+	vi.nid = ctx->de_nid;
+	vi.sbi = dir->sbi;
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret)
+		return ret;
+
+	ret = asprintf(&path, "%s/%.*s", dir->i_srcpath, ctx->de_namelen,
+		       ctx->dname);
+	if (ret < 0)
+		return ret;
+	vi.i_srcpath = path;
+
+	ret = erofs_rebuild_parse_inode(rctx, &vi);
+	free(path);
+	return ret;
+}
+
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi)
+{
+	struct erofs_inode inode = {};
+	struct erofs_rebuild_dir_context ctx;
+	int ret;
+
+	if (!sbi->devname) {
+		erofs_err("please open the device first");
+		return -EINVAL;
+	}
+
+	ret = erofs_read_superblock(sbi);
+	if (ret) {
+		erofs_err("failed to read superblock of img %s", sbi->devname);
+		return ret;
+	}
+
+	inode.nid = sbi->root_nid;
+	inode.sbi = sbi;
+	ret = erofs_read_inode_from_disk(&inode);
+	if (ret) {
+		erofs_err("failed to read root inode of img %s", sbi->devname);
+		return ret;
+	}
+	inode.i_srcpath = strdup("/");
+
+	ctx = (struct erofs_rebuild_dir_context) {
+		.ctx.dir = &inode,
+		.ctx.cb = erofs_rebuild_dirent_iter,
+		.root = root,
+		.dev = sbi->dev,
+	};
+	ret = erofs_iterate_dir(&ctx.ctx, false);
+	free(inode.i_srcpath);
+	return ret;
+}
diff --git a/lib/tar.c b/lib/tar.c
index cf3497f..26830f4 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -13,8 +13,6 @@
 #include "erofs/blobchunk.h"
 #include "erofs/rebuild.h"
 
-#define EROFS_WHITEOUT_DEV	0
-
 static char erofs_libbuf[16384];
 
 struct tar_header {
-- 
2.19.1.6.gb485710b

