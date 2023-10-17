Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C17CC61A
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Oct 2023 16:44:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S8xZy4KnGz3cCM
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Oct 2023 01:44:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S8xZq1ckCz3c7q
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Oct 2023 01:44:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VuNtr7l_1697553861;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VuNtr7l_1697553861)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 22:44:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix corrupted directories with hardlinks
Date: Tue, 17 Oct 2023 22:44:20 +0800
Message-Id: <20231017144420.289469-1-hsiangkao@linux.alibaba.com>
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

An inode with hard links may belong to several directories. It's
invalid to update `subdirs_queued` for hard-link inodes since it
only records one of the parent directories.

References: https://github.com/NixOS/nixpkgs/issues/261394
Fixes: 21d84349e79a ("erofs-utils: rearrange on-disk metadata")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  5 +++--
 lib/inode.c              | 29 ++++++++++++-----------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d859905..c1ff582 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -159,8 +159,9 @@ struct erofs_inode {
 	union {
 		/* (erofsfuse) runtime flags */
 		unsigned int flags;
-		/* (mkfs.erofs) queued sub-directories blocking dump */
-		u32 subdirs_queued;
+
+		/* (mkfs.erofs) next pointer for directory dumping */
+		struct erofs_inode *next_dirwrite;
 	};
 	unsigned int i_count;
 	struct erofs_sb_info *sbi;
diff --git a/lib/inode.c b/lib/inode.c
index a91578a..dd242a1 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1229,7 +1229,6 @@ fail:
 			inode->i_parent = dir;
 			erofs_igrab(inode);
 			list_add_tail(&inode->i_subdirs, dirs);
-			++dir->subdirs_queued;
 		}
 		ftype = erofs_mode_to_ftype(inode->i_mode);
 		i_nlink += (ftype == EROFS_FT_DIR);
@@ -1254,17 +1253,10 @@ err_closedir:
 	return ret;
 }
 
-static void erofs_mkfs_dump_directory(struct erofs_inode *dir)
-{
-	erofs_write_dir_file(dir);
-	erofs_write_tail_end(dir);
-	dir->bh->op = &erofs_write_inode_bhops;
-}
-
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 {
 	LIST_HEAD(dirs);
-	struct erofs_inode *inode, *root, *parent;
+	struct erofs_inode *inode, *root, *dumpdir;
 
 	root = erofs_iget_from_path(path, true);
 	if (IS_ERR(root))
@@ -1272,9 +1264,9 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 
 	(void)erofs_igrab(root);
 	root->i_parent = root;	/* rootdir mark */
-	root->subdirs_queued = 1;
 	list_add(&root->i_subdirs, &dirs);
 
+	dumpdir = NULL;
 	do {
 		int err;
 		char *trimmed;
@@ -1294,15 +1286,18 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 			root = ERR_PTR(err);
 			break;
 		}
-		parent = inode->i_parent;
 
-		DBG_BUGON(!parent->subdirs_queued);
-		if (S_ISDIR(inode->i_mode) && !inode->subdirs_queued)
-			erofs_mkfs_dump_directory(inode);
-		if (!--parent->subdirs_queued)
-			erofs_mkfs_dump_directory(parent);
-		erofs_iput(inode);
+		if (S_ISDIR(inode->i_mode)) {
+			inode->next_dirwrite = dumpdir;
+			dumpdir = inode;
+		}
 	} while (!list_empty(&dirs));
+
+	for (; dumpdir; dumpdir = dumpdir->next_dirwrite) {
+		erofs_write_dir_file(dumpdir);
+		erofs_write_tail_end(dumpdir);
+		dumpdir->bh->op = &erofs_write_inode_bhops;
+	}
 	return root;
 }
 
-- 
2.39.3

