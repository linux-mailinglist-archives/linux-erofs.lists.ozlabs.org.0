Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9377B042
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 05:43:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPKxS4blNz3cBZ
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 13:43:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPKww2wlFz30gF
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 13:42:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VpelF2B_1691984571;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VpelF2B_1691984571)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 11:42:51 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 10/13] erofs-utils: lib: add erofs_rebuild_dump_tree() helper
Date: Mon, 14 Aug 2023 11:42:36 +0800
Message-Id: <20230814034239.54660-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
References: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
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

Enhance tarerofs_dump_tree() so that it could optionally skip whiteout
files when it's supposed to output image in merged view.  Rename it to
erofs_rebuild_dump_tree().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/inode.h    |  2 +-
 include/erofs/internal.h |  2 ++
 lib/inode.c              | 23 ++++++++++++++++++++---
 lib/tar.c                |  2 --
 mkfs/main.c              |  2 +-
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 1c602a8..f273e9e 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -32,7 +32,7 @@ unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
-int tarerofs_dump_tree(struct erofs_inode *dir);
+int erofs_rebuild_dump_tree(struct erofs_inode *dir, bool merged_view);
 int erofs_init_empty_dir(struct erofs_inode *dir);
 struct erofs_inode *erofs_new_inode(void);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3631cc1..179ecb3 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -416,6 +416,8 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, size_t len)
 	return crc;
 }
 
+#define EROFS_WHITEOUT_DEV	0
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/inode.c b/lib/inode.c
index b967aab..7f59a58 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1323,9 +1323,14 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	return inode;
 }
 
-int tarerofs_dump_tree(struct erofs_inode *dir)
+static bool erofs_inode_is_whiteout(struct erofs_inode *inode)
 {
-	struct erofs_dentry *d;
+	return S_ISCHR(inode->i_mode) && inode->u.i_rdev == EROFS_WHITEOUT_DEV;
+}
+
+int erofs_rebuild_dump_tree(struct erofs_inode *dir, bool merged_view)
+{
+	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs;
 	int ret;
 
@@ -1368,6 +1373,18 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
 		return 0;
 	}
 
+	if (merged_view) {
+		list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+			if (erofs_inode_is_whiteout(d->inode)) {
+				erofs_dbg("skip whiteout %s", d->inode->i_srcpath);
+				erofs_d_invalidate(d);
+				list_del(&d->d_child);
+				free(d);
+				continue;
+			}
+		}
+	}
+
 	nr_subdirs = 0;
 	list_for_each_entry(d, &dir->i_subdirs, d_child)
 		++nr_subdirs;
@@ -1391,7 +1408,7 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
 			continue;
 
 		inode = erofs_igrab(d->inode);
-		ret = tarerofs_dump_tree(inode);
+		ret = erofs_rebuild_dump_tree(inode, merged_view);
 		dir->i_nlink += (erofs_mode_to_ftype(inode->i_mode) == EROFS_FT_DIR);
 		erofs_iput(inode);
 		if (ret)
diff --git a/lib/tar.c b/lib/tar.c
index d7a58d2..3205f06 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -19,8 +19,6 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 
-#define EROFS_WHITEOUT_DEV	0
-
 static char erofs_libbuf[16384];
 
 struct tar_header {
diff --git a/mkfs/main.c b/mkfs/main.c
index c03a7a8..269ccf4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -946,7 +946,7 @@ int main(int argc, char **argv)
 		if (err < 0)
 			goto exit;
 
-		err = tarerofs_dump_tree(root_inode);
+		err = erofs_rebuild_dump_tree(root_inode, false);
 		if (err < 0)
 			goto exit;
 	}
-- 
2.19.1.6.gb485710b

