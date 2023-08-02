Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F876C953
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 11:18:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RG5xt6mPzz3bm2
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 19:18:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RG5xG4D0Dz3c4s
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Aug 2023 19:18:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VouWEww_1690967884;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VouWEww_1690967884)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 17:18:05 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 14/16] erofs-utils: generate data block bitmap when loading tree
Date: Wed,  2 Aug 2023 17:17:48 +0800
Message-Id: <20230802091750.74181-14-jefflexu@linux.alibaba.com>
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

Enhance erofs_rebuild_load_tree() making it generate a bitmap describing
used data blocks by all regular files in given erofs image.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/rebuild.h |  3 ++-
 lib/rebuild.c           | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index 57c0e42..55cd856 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -21,7 +21,8 @@ struct erofs_img *erofs_get_img(const char *path);
 int erofs_add_img(const char *path);
 void erofs_cleanup_imgs(void);
 
-int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img);
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img,
+		unsigned long **datablk_map, unsigned long *datablks);
 
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq);
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 33b539f..f641c40 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -11,6 +11,7 @@
 #include "erofs/dir.h"
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
+#include "erofs/bitops.h"
 #include "erofs/internal.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
@@ -125,7 +126,7 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 }
 
 static int erofs_rebuild_fill_inode_map(struct erofs_inode *inode,
-				struct erofs_inode *vi, dev_t dev)
+		struct erofs_inode *vi, dev_t dev, unsigned long *datablk)
 {
 	int ret;
 	unsigned int count, unit, chunkbits, deviceid, i;
@@ -178,6 +179,9 @@ static int erofs_rebuild_fill_inode_map(struct erofs_inode *inode,
 			goto err;
 		}
 		*(void **)idx++ = chunk;
+
+		if (datablk)
+			__set_bit(blkaddr, datablk);
 		erofs_dbg("\t%s: chunk %d (deviceid %u, blkaddr %u)",
 			inode->i_srcpath, i, deviceid, blkaddr);
 
@@ -191,7 +195,7 @@ err:
 }
 
 static int erofs_rebuild_fill_inode(struct erofs_inode *inode,
-			struct erofs_inode *vi, dev_t dev)
+		struct erofs_inode *vi, dev_t dev, unsigned long *datablk)
 {
 	int ret = 0;
 
@@ -226,7 +230,7 @@ static int erofs_rebuild_fill_inode(struct erofs_inode *inode,
 	case S_IFREG:
 		inode->i_size = vi->i_size;
 		if (inode->i_size)
-			ret = erofs_rebuild_fill_inode_map(inode, vi, dev);
+			ret = erofs_rebuild_fill_inode_map(inode, vi, dev, datablk);
 		else
 			inode->u.i_blkaddr = NULL_ADDR;
 		break;
@@ -241,6 +245,7 @@ struct erofs_rebuild_dir_context {
 	struct erofs_dir_context ctx;
 	struct erofs_inode *root;
 	dev_t dev;
+	unsigned long *datablk;
 };
 
 static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
@@ -313,7 +318,8 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 
 			inode->i_parent = d->inode;
 			inode->dev = rctx->dev;
-			ret = erofs_rebuild_fill_inode(inode, &vi, rctx->dev);
+			ret = erofs_rebuild_fill_inode(inode, &vi, rctx->dev,
+						       rctx->datablk);
 			if (ret)
 				goto exit_inode;
 
@@ -345,11 +351,13 @@ exit_inode:
 	goto exit;
 }
 
-int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img)
+int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img,
+		unsigned long **datablk_map, unsigned long *datablks)
 {
 	struct erofs_inode inode = {};
 	struct erofs_sb_info *sbi = &img->sbi;
 	struct erofs_rebuild_dir_context ctx;
+	unsigned long *datablk = NULL;
 	int ret;
 
 	erofs_dbg("Loading image %s...", img->path);
@@ -366,11 +374,27 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img)
 		goto exit;
 	}
 
+	if (datablk_map) {
+		if (sbi->extra_devices) {
+			erofs_err("don't support scanning data blocks for extra devices");
+			ret = -EOPNOTSUPP;
+			goto exit;
+		}
+
+		datablk = calloc(BITS_TO_LONGS(sbi->total_blocks),
+				sizeof(unsigned long));
+		if (!datablk) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+	}
+
 	inode.nid = sbi->root_nid;
 	inode.sbi = sbi;
 	ret = erofs_read_inode_from_disk(&inode);
 	if (ret) {
 		erofs_err("failed to read root inode of image %s", img->path);
+		free(datablk);
 		goto exit;
 	}
 	inode.i_srcpath = strdup("/");
@@ -380,9 +404,14 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img)
 		.ctx.cb = erofs_rebuild_dirent_iter,
 		.root = root,
 		.dev = img->dev,
+		.datablk = datablk,
 	};
 	ret = erofs_iterate_dir(&ctx.ctx, false);
 	free(inode.i_srcpath);
+	if (datablk_map) {
+		*datablk_map = datablk;
+		*datablks = sbi->total_blocks;
+	}
 exit:
 	dev_close(sbi);
 	return ret;
-- 
2.19.1.6.gb485710b

