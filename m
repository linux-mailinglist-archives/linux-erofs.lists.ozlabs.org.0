Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3976783CD5
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 11:25:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVP8l4834z3bbW
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 19:25:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVP876GG2z302F
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Aug 2023 19:25:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqM6n6z_1692696306;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqM6n6z_1692696306)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 17:25:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 08/11] erofs-utils: lib: add erofs_rebuild_dump_tree() helper
Date: Tue, 22 Aug 2023 17:24:54 +0800
Message-Id: <20230822092457.114686-9-jefflexu@linux.alibaba.com>
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

Enhance tarerofs_dump_tree() so that it could optionally skip specified
files, usually for whiteout files.

Rename it to erofs_rebuild_dump_tree().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/inode.h    |  2 +-
 include/erofs/internal.h |  1 +
 lib/inode.c              | 15 +++++++++++----
 mkfs/main.c              |  2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

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
index 455a73a..fa0a240 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -191,6 +191,7 @@ struct erofs_inode {
 	bool lazy_tailblock;
 	bool with_tmpfile;
 	bool opaque;
+	bool drop;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/lib/inode.c b/lib/inode.c
index b967aab..96012e4 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1323,9 +1323,9 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	return inode;
 }
 
-int tarerofs_dump_tree(struct erofs_inode *dir)
+int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 {
-	struct erofs_dentry *d;
+	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs;
 	int ret;
 
@@ -1369,8 +1369,15 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
 	}
 
 	nr_subdirs = 0;
-	list_for_each_entry(d, &dir->i_subdirs, d_child)
+	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+		if (d->inode->drop) {
+			list_del(&d->d_child);
+			erofs_d_invalidate(d);
+			free(d);
+			continue;
+		}
 		++nr_subdirs;
+	}
 
 	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
 	if (ret)
@@ -1391,7 +1398,7 @@ int tarerofs_dump_tree(struct erofs_inode *dir)
 			continue;
 
 		inode = erofs_igrab(d->inode);
-		ret = tarerofs_dump_tree(inode);
+		ret = erofs_rebuild_dump_tree(inode);
 		dir->i_nlink += (erofs_mode_to_ftype(inode->i_mode) == EROFS_FT_DIR);
 		erofs_iput(inode);
 		if (ret)
diff --git a/mkfs/main.c b/mkfs/main.c
index c03a7a8..628af59 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -946,7 +946,7 @@ int main(int argc, char **argv)
 		if (err < 0)
 			goto exit;
 
-		err = tarerofs_dump_tree(root_inode);
+		err = erofs_rebuild_dump_tree(root_inode);
 		if (err < 0)
 			goto exit;
 	}
-- 
2.19.1.6.gb485710b

