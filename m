Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49333799A03
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rjdp8108vz3cGk
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rjdnm1qwqz3by9
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:33:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrfyqWQ_1694277189;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqWQ_1694277189)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:33:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 11/13] erofs-utils: lib: add erofs_rebuild_load_tree() helper
Date: Sun, 10 Sep 2023 00:32:38 +0800
Message-Id: <20230909163240.42057-12-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
References: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Add erofs_rebuild_load_tree() helper to load the inode tree from a
given erofs image, and make it merged acting as an overlayfs-like
model.

Since the content of the symlink file needs to be read when loading
tree, let's add a dependency on zlib_LIBS for mkfs.erofs.

Also rename tarerofs_dump_tree() to erofs_rebuild_dump_tree() since
it is also called in the rebuild mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h    |   2 +-
 include/erofs/internal.h |   6 +-
 include/erofs/rebuild.h  |   2 +
 lib/inode.c              |   4 +-
 lib/rebuild.c            | 288 +++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |   2 +-
 6 files changed, 298 insertions(+), 6 deletions(-)

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
index c711c71..b973266 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -109,6 +109,7 @@ struct erofs_sb_info {
 
 	int devfd;
 	u64 devsz;
+	dev_t dev;
 	unsigned int nblobs;
 	unsigned int blobfd[256];
 };
@@ -151,8 +152,6 @@ struct erofs_inode {
 	union {
 		/* (erofsfuse) runtime flags */
 		unsigned int flags;
-		/* (mkfs.erofs) device ID containing source file */
-		u32 dev;
 		/* (mkfs.erofs) queued sub-directories blocking dump */
 		u32 subdirs_queued;
 	};
@@ -160,6 +159,9 @@ struct erofs_inode {
 	struct erofs_sb_info *sbi;
 	struct erofs_inode *i_parent;
 
+	/* (mkfs.erofs) device ID containing source file */
+	u32 dev;
+
 	umode_t i_mode;
 	erofs_off_t i_size;
 
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
index 3191843..74c3c32 100644
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
@@ -1395,7 +1395,7 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
 			continue;
 
 		inode = erofs_igrab(d->inode);
-		ret = tarerofs_dump_tree(inode);
+		ret = erofs_rebuild_dump_tree(inode);
 		dir->i_nlink += (erofs_mode_to_ftype(inode->i_mode) == EROFS_FT_DIR);
 		erofs_iput(inode);
 		if (ret)
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 2398ca6..27a1df4 100644
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
@@ -114,3 +123,282 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 	}
 	return d;
 }
+
+static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
+{
+	int ret;
+	unsigned int count, unit, chunkbits, i;
+	struct erofs_inode_chunk_index *idx;
+	erofs_off_t chunksize;
+	erofs_blk_t blkaddr;
+
+	/* TODO: fill data map in other layouts */
+	if (inode->datalayout != EROFS_INODE_CHUNK_BASED &&
+	    inode->datalayout != EROFS_INODE_FLAT_PLAIN) {
+		erofs_err("%s: unsupported datalayout %d", inode->i_srcpath, inode->datalayout);
+		return -EOPNOTSUPP;
+	}
+
+	if (inode->sbi->extra_devices) {
+		chunkbits = inode->u.chunkbits;
+		if (chunkbits < sbi.blkszbits) {
+			erofs_err("%s: chunk size %u is too small to fit the target block size %u",
+				  inode->i_srcpath, 1U << chunkbits, 1U << sbi.blkszbits);
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
+		chunk = erofs_get_unhashed_chunk(inode->dev, blkaddr, 0);
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
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFCHR:
+		if (erofs_inode_is_whiteout(inode))
+			inode->i_parent->whiteouts = true;
+		/* fallthrough */
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_size = 0;
+		erofs_dbg("\tdev: %d %d", major(inode->u.i_rdev),
+			  minor(inode->u.i_rdev));
+		inode->u.i_rdev = erofs_new_encode_dev(inode->u.i_rdev);
+		return 0;
+	case S_IFDIR:
+		return erofs_init_empty_dir(inode);
+	case S_IFLNK: {
+		int ret;
+
+		inode->i_link = malloc(inode->i_size + 1);
+		if (!inode->i_link)
+			return -ENOMEM;
+		ret = erofs_pread(inode, inode->i_link, inode->i_size, 0);
+		erofs_dbg("\tsymlink: %s -> %s", inode->i_srcpath, inode->i_link);
+		return ret;
+	}
+	case S_IFREG:
+		if (inode->i_size)
+			return erofs_rebuild_fixup_inode_index(inode);
+		return 0;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+/*
+ * @parent:  parent directory in inode tree
+ * @ctx.dir: parent directory when itering erofs_iterate_dir()
+ */
+struct erofs_rebuild_dir_context {
+	struct erofs_dir_context ctx;
+	struct erofs_inode *parent;
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
+	bool dumb;
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
+	erofs_dbg("parsing %s", path);
+	dname = path + strlen(parent->i_srcpath) + 1;
+
+	d = erofs_rebuild_get_dentry(parent, dname, false, &dumb, &dumb);
+	if (IS_ERR(d)) {
+		ret = PTR_ERR(d);
+		goto out;
+	}
+
+	ret = 0;
+	if (d->type != EROFS_FT_UNKNOWN) {
+		/*
+		 * bail out if the file exists in the upper layers.  (Note that
+		 * extended attributes won't be merged too even for dirs.)
+		 */
+		if (!S_ISDIR(d->inode->i_mode) || d->inode->opaque)
+			goto out;
+
+		/* merge directory entries */
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
+		DBG_BUGON(parent != d->inode);
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
+		inode->dev = inode->sbi->dev;
+
+		if (S_ISREG(inode->i_mode) && inode->i_nlink > 1 &&
+		    (candidate = erofs_iget(inode->dev, ctx->de_nid))) {
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
+			erofs_insert_ihash(inode, inode->dev, inode->i_ino[1]);
+			parent = dir = inode;
+		}
+
+		d->inode = inode;
+		d->type = erofs_mode_to_ftype(inode->i_mode);
+	}
+
+	if (S_ISDIR(inode->i_mode)) {
+		struct erofs_rebuild_dir_context nctx = *rctx;
+
+		nctx.parent = parent;
+		nctx.ctx.dir = dir;
+		ret = erofs_iterate_dir(&nctx.ctx, false);
+		if (ret)
+			goto out;
+	}
+
+	/* reset sbi, nid after subdirs are all loaded for the final dump */
+	inode->sbi = &sbi;
+	inode->nid = 0;
+out:
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
2.24.4

