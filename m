Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF7789A92E
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Apr 2024 07:37:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fNbEN92d;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VBPJL5ZP7z3vYw
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Apr 2024 16:37:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fNbEN92d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VBPJF05HJz2ykC
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 Apr 2024 16:37:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712381847; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=axPOC3nWf2Oi+ElYOKFzBpP2dfnKvDuX088pV4kOG7Y=;
	b=fNbEN92d2ky3cANDsM+XNx9OBCyEZ/p1fxvfgJaFx//371U8wdqIweaWmNkF56+jSZyUzjgGvr7iZKhyc/0/4o+L3YrbM+Vb2hGG1CmRByTNndgnXBhfH0UurezvD3Jw3ktggqWbEn9MYD8gDG73zYVS4unTo4ec2Ko1a7Ssw2w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W3ykLeg_1712381838;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3ykLeg_1712381838)
          by smtp.aliyun-inc.com;
          Sat, 06 Apr 2024 13:37:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib: split out several helpers in inode.c
Date: Sat,  6 Apr 2024 13:37:16 +0800
Message-Id: <20240406053717.565119-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

The following new helpers are added to prepare for the upcoming
multi-threaded inter-file compression:
 - erofs_mkfs_handle_{non,}directory;
 - erofs_write_unencoded_file.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 106 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index ba0419f..f419f3c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -477,12 +477,8 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
+int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
-	int ret;
-
-	DBG_BUGON(!inode->i_size);
-
 	if (cfg.c_chunkbits) {
 		inode->u.chunkbits = cfg.c_chunkbits;
 		/* chunk indexes when explicitly specified */
@@ -492,7 +488,17 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
 
+	/* fallback to all data uncompressed */
+	return write_uncompressed_file_from_fd(inode, fd);
+}
+
+int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
+{
+	DBG_BUGON(!inode->i_size);
+
 	if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode)) {
+		int ret;
+
 		ret = erofs_write_compressed_file(inode, fd, fpos);
 		if (!ret || ret != -ENOSPC)
 			return ret;
@@ -500,9 +506,8 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 		if (lseek(fd, fpos, SEEK_SET) < 0)
 			return -errno;
 	}
-
 	/* fallback to all data uncompressed */
-	return write_uncompressed_file_from_fd(inode, fd);
+	return erofs_write_unencoded_file(inode, fd, fpos);
 }
 
 static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
@@ -1095,52 +1100,44 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs)
+static int erofs_mkfs_handle_nondirectory(struct erofs_inode *inode)
 {
-	int ret;
-	DIR *_dir;
-	struct dirent *dp;
-	struct erofs_dentry *d;
-	unsigned int nr_subdirs, i_nlink;
+	int ret = 0;
 
-	ret = erofs_scan_file_xattrs(dir);
-	if (ret < 0)
-		return ret;
+	if (S_ISLNK(inode->i_mode)) {
+		char *const symlink = malloc(inode->i_size);
 
-	ret = erofs_prepare_xattr_ibody(dir);
-	if (ret < 0)
-		return ret;
-
-	if (!S_ISDIR(dir->i_mode)) {
-		if (S_ISLNK(dir->i_mode)) {
-			char *const symlink = malloc(dir->i_size);
-
-			if (!symlink)
-				return -ENOMEM;
-			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
-			if (ret < 0) {
-				free(symlink);
-				return -errno;
-			}
-			ret = erofs_write_file_from_buffer(dir, symlink);
+		if (!symlink)
+			return -ENOMEM;
+		ret = readlink(inode->i_srcpath, symlink, inode->i_size);
+		if (ret < 0) {
 			free(symlink);
-		} else if (dir->i_size) {
-			int fd = open(dir->i_srcpath, O_RDONLY | O_BINARY);
-			if (fd < 0)
-				return -errno;
-
-			ret = erofs_write_file(dir, fd, 0);
-			close(fd);
-		} else {
-			ret = 0;
+			return -errno;
 		}
-		if (ret)
-			return ret;
+		ret = erofs_write_file_from_buffer(inode, symlink);
+		free(symlink);
+	} else if (inode->i_size) {
+		int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 
-		erofs_prepare_inode_buffer(dir);
-		erofs_write_tail_end(dir);
-		return 0;
+		if (fd < 0)
+			return -errno;
+		ret = erofs_write_file(inode, fd, 0);
+		close(fd);
 	}
+	if (ret)
+		return ret;
+	erofs_prepare_inode_buffer(inode);
+	erofs_write_tail_end(inode);
+	return 0;
+}
+
+static int erofs_mkfs_handle_directory(struct erofs_inode *dir, struct list_head *dirs)
+{
+	DIR *_dir;
+	struct dirent *dp;
+	struct erofs_dentry *d;
+	unsigned int nr_subdirs, i_nlink;
+	int ret;
 
 	_dir = opendir(dir->i_srcpath);
 	if (!_dir) {
@@ -1252,6 +1249,23 @@ err_closedir:
 	return ret;
 }
 
+static int erofs_mkfs_build_tree(struct erofs_inode *inode, struct list_head *dirs)
+{
+	int ret;
+
+	ret = erofs_scan_file_xattrs(inode);
+	if (ret < 0)
+		return ret;
+
+	ret = erofs_prepare_xattr_ibody(inode);
+	if (ret < 0)
+		return ret;
+
+	if (!S_ISDIR(inode->i_mode))
+		return erofs_mkfs_handle_nondirectory(inode);
+	return erofs_mkfs_handle_directory(inode, dirs);
+}
+
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 {
 	LIST_HEAD(dirs);
-- 
2.39.3

