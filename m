Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C88A65A2
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 10:04:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LZv4lSFu;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJc5d3F4Dz3dmy
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 18:04:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LZv4lSFu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJc5M6s9yz3cGY
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 18:04:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7968C610A7;
	Tue, 16 Apr 2024 08:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1585FC4AF09;
	Tue, 16 Apr 2024 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713254677;
	bh=yjA3u8q0CqZVcSBq6wEm6xrStn1/v7LTnBHxFHjDl+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZv4lSFunP/Z4qum0/40ERDY2n2gjoKzSHRg+RW6xO331jN388se7aXckxQbgQxLW
	 +xDwxCt+k3EjiWIfILgu+zdrH6wGUog6IjNGDU+gnI3v6qgDR31Q+KhOVkpSSfYxh/
	 cQrAuQ0MdUevoE+J88wCRCaFjM7w8CzS2MWwNrhHBcmg+rYpGKGuUt2JAxMApklZJN
	 2vrBfChf4E+KDd3Bg3YQobuJZMYkKFGu617iJ26e3xelD6OnM6IgiyMFYxNIuaJVAm
	 C+b4HnX+eTpjXEWvX7npUmbWrOff8Ao6XEEe17+Lu0HsjiTJ+gzM/rq8FQrziuw2a4
	 e1zG1QvYlZsMQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/8] erofs-utils: lib: prepare for later deferred work
Date: Tue, 16 Apr 2024 16:04:13 +0800
Message-Id: <20240416080419.32491-2-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240416080419.32491-1-xiang@kernel.org>
References: <20240416080419.32491-1-xiang@kernel.org>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Split out ordered metadata operations and add the following helpers:

 - erofs_mkfs_jobfn()

 - erofs_mkfs_go()

to handle these mkfs job items for multi-threadding support.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 68 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 55969d9..8ef0604 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1133,6 +1133,57 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_inode *inode)
 	return 0;
 }
 
+enum erofs_mkfs_jobtype {	/* ordered job types */
+	EROFS_MKFS_JOB_NDIR,
+	EROFS_MKFS_JOB_DIR,
+	EROFS_MKFS_JOB_DIR_BH,
+};
+
+struct erofs_mkfs_jobitem {
+	enum erofs_mkfs_jobtype type;
+	union {
+		struct erofs_inode *inode;
+	} u;
+};
+
+static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
+{
+	struct erofs_inode *inode = item->u.inode;
+	int ret;
+
+	if (item->type == EROFS_MKFS_JOB_NDIR)
+		return erofs_mkfs_handle_nondirectory(inode);
+
+	if (item->type == EROFS_MKFS_JOB_DIR) {
+		ret = erofs_prepare_inode_buffer(inode);
+		if (ret)
+			return ret;
+		inode->bh->op = &erofs_skip_write_bhops;
+		if (IS_ROOT(inode))
+			erofs_fixup_meta_blkaddr(inode);
+		return 0;
+	}
+
+	if (item->type == EROFS_MKFS_JOB_DIR_BH) {
+		erofs_write_dir_file(inode);
+		erofs_write_tail_end(inode);
+		inode->bh->op = &erofs_write_inode_bhops;
+		erofs_iput(inode);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+int erofs_mkfs_go(struct erofs_sb_info *sbi,
+		  enum erofs_mkfs_jobtype type, void *elem, int size)
+{
+	struct erofs_mkfs_jobitem item;
+
+	item.type = type;
+	memcpy(&item.u, elem, size);
+	return erofs_mkfs_jobfn(&item);
+}
+
 static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 {
 	DIR *_dir;
@@ -1213,11 +1264,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 	else
 		dir->i_nlink = i_nlink;
 
-	ret = erofs_prepare_inode_buffer(dir);
-	if (ret)
-		return ret;
-	dir->bh->op = &erofs_skip_write_bhops;
-	return 0;
+	return erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 
 err_closedir:
 	closedir(_dir);
@@ -1243,7 +1290,8 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 		return ret;
 
 	if (!S_ISDIR(inode->i_mode))
-		ret = erofs_mkfs_handle_nondirectory(inode);
+		ret = erofs_mkfs_go(inode->sbi, EROFS_MKFS_JOB_NDIR,
+				    &inode, sizeof(inode));
 	else
 		ret = erofs_mkfs_handle_directory(inode);
 	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
@@ -1302,10 +1350,10 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 		}
 		*last = dumpdir;	/* fixup the last (or the only) one */
 		dumpdir = head;
-		erofs_write_dir_file(dir);
-		erofs_write_tail_end(dir);
-		dir->bh->op = &erofs_write_inode_bhops;
-		erofs_iput(dir);
+		err = erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR_BH,
+				    &dir, sizeof(dir));
+		if (err)
+			return ERR_PTR(err);
 	} while (dumpdir);
 
 	return root;
-- 
2.30.2

