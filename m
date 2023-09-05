Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB707921C7
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 12:03:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rg1KM1NrQz3c3H
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 20:03:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rg1Jv61TKz3bv3
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 20:02:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrPV9dB_1693908154;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VrPV9dB_1693908154)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 18:02:35 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 07/11] erofs-utils: lib: add erofs_rebuild_load_tree() helper
Date: Tue,  5 Sep 2023 18:02:23 +0800
Message-Id: <20230905100227.1072-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
References: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
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

Also rename tarerofs_dump_tree() to erofs_rebuild_dump_tree(), so that
it could also be called from rebuild mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/inode.h    |   2 +-
 include/erofs/internal.h |   1 +
 include/erofs/rebuild.h  |   2 +
 lib/inode.c              |   4 +-
 lib/rebuild.c            | 284 +++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |   2 +-
 6 files changed, 291 insertions(+), 4 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 1c602a8..fe9dda2 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -32,7 +32,7 @@ unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
-int tarerofs_dump_tree(struct erofs_inode *dir);
+int erofs_rebuild_dump_tree(struct erofs_inode *dir);
 int erofs_init_empty_dir(struct erofs_inode *dir);
 struct erofs_inode *erofs_new_inode(void);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6020553..3d5c337 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -108,6 +108,7 @@ struct erofs_sb_info {
 
 	int devfd;
 	u64 devsz;
+	dev_t dev;
 	unsigned int nblobs;
 	unsigned int blobfd[256];
 };
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
diff --git a/lib/inode.c b/lib/inode.c
index 8fab964..7e5d464 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1324,7 +1324,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	return inode;
 }
 
-int tarerofs_dump_tree(struct erofs_inode *dir)
+int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 {
 	struct erofs_dentry *d;
 	unsigned int nr_subdirs;
@@ -1392,7 +1392,7 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
 			continue;
 
 		inode = erofs_igrab(d->inode);
-		ret = tarerofs_dump_tree(inode);
+		ret = erofs_rebuild_dump_tree(inode);
 		dir->i_nlink += (erofs_mode_to_ftype(inode->i_mode) == EROFS_FT_DIR);
 		erofs_iput(inode);
 		if (ret)
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 7aaa071..477d68d 100644
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
@@ -115,3 +124,278 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 	}
 	return d;
 }
+
+static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
+{
+	int ret;
+	unsigned int count, unit, chunkbits, i;
+	unsigned int deviceid = inode->dev;
+	struct erofs_inode_chunk_index *idx;
+	erofs_off_t chunksize;
+	erofs_blk_t blkaddr;
+
+	/* TODO: fill data map in other layouts */
+	if (inode->datalayout != EROFS_INODE_CHUNK_BASED &&
+	    inode->datalayout != EROFS_INODE_FLAT_PLAIN) {
+		erofs_err("unsupported datalayout %d", inode->datalayout);
+		return -EOPNOTSUPP;
+	}
+
+	if (inode->sbi->extra_devices) {
+		chunkbits = inode->u.chunkbits;
+		if (chunkbits < sbi.blkszbits) {
+			erofs_err("blkszbits no greater than source blkszbits");
+			return -EINVAL;
+		}
+	} else {
+		chunkbits = ilog2(inode->i_size - 1) + 1;
+		if (chunkbits < sbi.blkszbits)
+			chunkbits = sbi.blkszbits;
+		if (chunkbits - sbi.blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+			chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi.blkszbits;
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
+		ret = erofs_map_blocks(inode, &map, 0);
+		if (ret)
+			goto err;
+
+		blkaddr = erofs_blknr(&sbi, map.m_pa);
+		chunk = erofs_get_unhashed_chunk(deviceid, blkaddr, 0);
+		if (IS_ERR(chunk)) {
+			ret = PTR_ERR(chunk);
+			goto err;
+		}
+		*(void **)idx++ = chunk;
+
+	}
+	inode->datalayout = EROFS_INODE_CHUNK_BASED;
+	inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
+	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
+	return 0;
+err:
+	free(idx);
+	inode->chunkindexes = NULL;
+	return ret;
+}
+
+static int erofs_rebuild_fill_inode(struct erofs_inode *inode)
+{
+	int ret = 0;
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_size = 0;
+		erofs_dbg("\tdev: %d %d", major(inode->u.i_rdev),
+			  minor(inode->u.i_rdev));
+		inode->u.i_rdev = erofs_new_encode_dev(inode->u.i_rdev);
+		break;
+	case S_IFDIR:
+		ret = erofs_init_empty_dir(inode);
+		break;
+	case S_IFLNK:
+		inode->i_link = malloc(inode->i_size + 1);
+		if (!inode->i_link)
+			return -ENOMEM;
+		ret = erofs_pread(inode, inode->i_link, inode->i_size, 0);
+		erofs_dbg("\tsymlink: %s -> %s", inode->i_srcpath, inode->i_link);
+		break;
+	case S_IFREG:
+		if (inode->i_size)
+			ret = erofs_rebuild_fixup_inode_index(inode);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+/*
+ * @parent:  parent directory in inode tree
+ * @ctx.dir: parent directory when itering erofs_iterate_dir()
+ */
+struct erofs_rebuild_dir_context {
+	struct erofs_dir_context ctx;
+	struct erofs_inode *parent;
+	dev_t dev;
+};
+
+static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
+{
+	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
+	struct erofs_inode *parent = rctx->parent;
+	struct erofs_inode *dir = ctx->dir;
+	struct erofs_inode *inode, *candidate;
+	struct erofs_inode src;
+	struct erofs_dentry *d;
+	char *path, *dname;
+	int ret;
+
+	if (ctx->dot_dotdot)
+		return 0;
+
+	ret = asprintf(&path, "%s/%.*s", rctx->parent->i_srcpath,
+		       ctx->de_namelen, ctx->dname);
+	if (ret < 0)
+		return ret;
+
+	erofs_dbg("parsing path %s", path);
+	dname = path + strlen(parent->i_srcpath) + 1;
+
+	d = erofs_rebuild_get_dentry(parent, dname, false, NULL, NULL);
+	if (IS_ERR(d)) {
+		ret = PTR_ERR(d);
+		goto out;
+	}
+	DBG_BUGON(parent != d->inode);
+
+	ret = 0;
+	if (d->type != EROFS_FT_UNKNOWN) {
+		/* file exists in upper layer */
+		if (!S_ISDIR(d->inode->i_mode) || d->inode->opaque)
+			goto out;
+
+		/* merging directories */
+		src = (struct erofs_inode) {
+			.sbi = dir->sbi,
+			.nid = ctx->de_nid
+		};
+		ret = erofs_read_inode_from_disk(&src);
+		if (ret || !S_ISDIR(src.i_mode))
+			goto out;
+		parent = d->inode;
+		inode = dir = &src;
+	} else {
+		u64 nid;
+
+		inode = erofs_new_inode();
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
+			goto out;
+		}
+
+		/* reuse i_ino[0] to read nid in source fs */
+		nid = inode->i_ino[0];
+		inode->sbi = dir->sbi;
+		inode->nid = ctx->de_nid;
+		ret = erofs_read_inode_from_disk(inode);
+		if (ret)
+			goto out;
+
+		/* restore nid in new generated fs */
+		inode->i_ino[1] = inode->i_ino[0];
+		inode->i_ino[0] = nid;
+
+		if (S_ISREG(inode->i_mode) && inode->i_nlink > 1 &&
+		    (candidate = erofs_iget(rctx->dev, ctx->de_nid))) {
+			/* hardlink file */
+			erofs_iput(inode);
+			inode = candidate;
+			if (S_ISDIR(inode->i_mode)) {
+				erofs_err("hardlink directory not supported");
+				ret = -EISDIR;
+				goto out;
+			}
+			inode->i_nlink++;
+			erofs_dbg("\thardlink: %s -> %s", path, inode->i_srcpath);
+		} else {
+			ret = erofs_read_xattrs_from_disk(inode);
+			if (ret) {
+				erofs_iput(inode);
+				goto out;
+			}
+
+			inode->i_parent = d->inode;
+			inode->dev = rctx->dev;
+			inode->i_srcpath = path;
+			path = NULL;
+			inode->i_ino[1] = inode->nid;
+			inode->i_nlink = 1;
+
+			ret = erofs_rebuild_fill_inode(inode);
+			if (ret) {
+				erofs_iput(inode);
+				goto out;
+			}
+
+			erofs_insert_ihash(inode, rctx->dev, inode->i_ino[1]);
+			parent = dir = inode;
+		}
+
+		d->inode = inode;
+		d->type = erofs_mode_to_ftype(inode->i_mode);
+	}
+
+	ret = 0;
+	if (S_ISDIR(inode->i_mode)) {
+		struct erofs_rebuild_dir_context nctx = *rctx;
+
+		nctx.parent = parent;
+		nctx.ctx.dir = dir;
+		ret = erofs_iterate_dir(&nctx.ctx, false);
+	}
+
+	/* don't restore inode->sbi until all the read work has finished */
+	inode->sbi = &sbi;
+	inode->nid = 0;
+out:
+	if (path)
+		free(path);
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
+		erofs_err("failed to find a device for rebuilding");
+		return -EINVAL;
+	}
+
+	ret = erofs_read_superblock(sbi);
+	if (ret) {
+		erofs_err("failed to read superblock of %s", sbi->devname);
+		return ret;
+	}
+
+	inode.nid = sbi->root_nid;
+	inode.sbi = sbi;
+	ret = erofs_read_inode_from_disk(&inode);
+	if (ret) {
+		erofs_err("failed to read root inode of %s", sbi->devname);
+		return ret;
+	}
+	inode.i_srcpath = strdup("/");
+
+	ctx = (struct erofs_rebuild_dir_context) {
+		.ctx.dir = &inode,
+		.ctx.cb = erofs_rebuild_dirent_iter,
+		.parent = root,
+		.dev = sbi->dev,
+	};
+	ret = erofs_iterate_dir(&ctx.ctx, false);
+	free(inode.i_srcpath);
+	return ret;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 607c883..94f6407 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -962,7 +962,7 @@ int main(int argc, char **argv)
 		if (err < 0)
 			goto exit;
 
-		err = tarerofs_dump_tree(root_inode);
+		err = erofs_rebuild_dump_tree(root_inode);
 		if (err < 0)
 			goto exit;
 	}
-- 
2.19.1.6.gb485710b

