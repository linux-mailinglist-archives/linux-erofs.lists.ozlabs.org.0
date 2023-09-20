Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD67A71CA
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 07:12:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rr69P3h9Rz3c1H
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 15:12:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rr69K21mcz2ysB
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 15:12:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsTtWbr_1695186744;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsTtWbr_1695186744)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 13:12:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix --force-{g,u}id support for tarerofs
Date: Wed, 20 Sep 2023 13:12:23 +0800
Message-Id: <20230920051223.657008-1-hsiangkao@linux.alibaba.com>
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

Temporarily move the common part into __erofs_fill_inode() for tarerofs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  2 ++
 lib/inode.c           | 19 ++++++++++++++++---
 lib/tar.c             | 16 ++++++++++------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index fe9dda2..bcfd98e 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -34,6 +34,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
 int erofs_rebuild_dump_tree(struct erofs_inode *dir);
 int erofs_init_empty_dir(struct erofs_inode *dir);
+int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
+		       const char *path);
 struct erofs_inode *erofs_new_inode(void);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
diff --git a/lib/inode.c b/lib/inode.c
index 4dc8260..b534b0a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -912,15 +912,15 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #endif
 
-static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
-			    const char *path)
+int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
+		       const char *path)
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
 	struct erofs_sb_info *sbi = inode->sbi;
 
 	if (err)
 		return err;
-	inode->i_mode = st->st_mode;
+
 	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
 	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
 
@@ -945,6 +945,19 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	default:
 		break;
 	}
+
+	return 0;
+}
+
+static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
+			    const char *path)
+{
+	int err = __erofs_fill_inode(inode, st, path);
+
+	if (err)
+		return err;
+
+	inode->i_mode = st->st_mode;
 	inode->i_nlink = 1;	/* fix up later if needed */
 
 	switch (inode->i_mode & S_IFMT) {
diff --git a/lib/tar.c b/lib/tar.c
index b159d70..52036a6 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -923,11 +923,17 @@ new_inode:
 		if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode))
 			inode->u.i_rdev = erofs_new_encode_dev(st.st_rdev);
 	}
+
 	inode->i_srcpath = strdup(eh.path);
-	inode->i_uid = st.st_uid;
-	inode->i_gid = st.st_gid;
+	if (!inode->i_srcpath) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = __erofs_fill_inode(inode, &st, eh.path);
+	if (ret)
+		goto out;
 	inode->i_size = st.st_size;
-	inode->i_mtime = st.st_mtime;
 
 	if (!S_ISDIR(inode->i_mode)) {
 		if (S_ISLNK(inode->i_mode)) {
@@ -940,10 +946,8 @@ new_inode:
 								data_offset);
 			else
 				ret = tarerofs_write_file_data(inode, tar);
-			if (ret) {
-				erofs_iput(inode);
+			if (ret)
 				goto out;
-			}
 		}
 		inode->i_nlink++;
 	} else if (!inode->i_nlink) {
-- 
2.39.3

