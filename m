Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF18A65A9
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 10:05:32 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vx1QBTiK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJc6K6rG2z3cp1
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 18:05:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vx1QBTiK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJc5S5czcz3dLl
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 18:04:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 01D4461115;
	Tue, 16 Apr 2024 08:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEB8C32783;
	Tue, 16 Apr 2024 08:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713254682;
	bh=fpJMXFr/YzAQL1er9bwRhe9Sizw4zmyzdsSa2gt7gMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vx1QBTiKtVDK+oqKHoqo1IwJSAl/yYi8gwzQwjilvWK47yADNSj2SI6FfOoutBsOS
	 BJxj23GdMBNrsbrOgXifkxLoezXljDs7JAMpnUsL5cVMebWuQC4PPijxAS0zFjUSnS
	 wVwF3G2ZlRDCsRNRmB1Qn+wzccVmFM4FtqnIPk9EuXFc5RqxN9y7UUXoyb+J86Cv5w
	 Ps2DcUjfpsJQnhLwH/hGcY19jTBvnwgpUWt9ToRu+zGPimlftVO9pUNWv98MNDUlSc
	 XKLZpq0DyLr412J2Uf0gvpehPVspLXiF3KzdbjHLrIR6EwN1O3hU4JW98aVNASju5i
	 L00ToEZ5m89Yg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/8] erofs-utils: lib: introduce non-directory jobitem context
Date: Tue, 16 Apr 2024 16:04:18 +0800
Message-Id: <20240416080419.32491-7-xiang@kernel.org>
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

It will describe EROFS_MKFS_JOB_NDIR defer work.  Also start
compression before queueing EROFS_MKFS_JOB_NDIR.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 62 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 66eacab..681460c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1107,8 +1107,36 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-static int erofs_mkfs_handle_nondirectory(struct erofs_inode *inode)
+struct erofs_mkfs_job_ndir_ctx {
+	struct erofs_inode *inode;
+	void *ictx;
+	int fd;
+};
+
+static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 {
+	struct erofs_inode *inode = ctx->inode;
+	int ret;
+
+	if (ctx->ictx) {
+		ret = erofs_write_compressed_file(ctx->ictx);
+		if (ret != -ENOSPC)
+			goto out;
+		if (lseek(ctx->fd, 0, SEEK_SET) < 0) {
+			ret = -errno;
+			goto out;
+		}
+	}
+	/* fallback to all data uncompressed */
+	ret = erofs_write_unencoded_file(inode, ctx->fd, 0);
+out:
+	close(ctx->fd);
+	return ret;
+}
+
+static int erofs_mkfs_handle_nondirectory(struct erofs_mkfs_job_ndir_ctx *ctx)
+{
+	struct erofs_inode *inode = ctx->inode;
 	int ret = 0;
 
 	if (S_ISLNK(inode->i_mode)) {
@@ -1124,12 +1152,7 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_inode *inode)
 		ret = erofs_write_file_from_buffer(inode, symlink);
 		free(symlink);
 	} else if (inode->i_size) {
-		int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-
-		if (fd < 0)
-			return -errno;
-		ret = erofs_write_file(inode, fd, 0);
-		close(fd);
+		ret = erofs_mkfs_job_write_file(ctx);
 	}
 	if (ret)
 		return ret;
@@ -1148,6 +1171,7 @@ struct erofs_mkfs_jobitem {
 	enum erofs_mkfs_jobtype type;
 	union {
 		struct erofs_inode *inode;
+		struct erofs_mkfs_job_ndir_ctx ndir;
 	} u;
 };
 
@@ -1157,7 +1181,7 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
 	int ret;
 
 	if (item->type == EROFS_MKFS_JOB_NDIR)
-		return erofs_mkfs_handle_nondirectory(inode);
+		return erofs_mkfs_handle_nondirectory(&item->u.ndir);
 
 	if (item->type == EROFS_MKFS_JOB_DIR) {
 		ret = erofs_prepare_inode_buffer(inode);
@@ -1294,11 +1318,27 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 	if (ret < 0)
 		return ret;
 
-	if (!S_ISDIR(inode->i_mode))
+	if (!S_ISDIR(inode->i_mode)) {
+		struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode };
+
+		if (!S_ISLNK(inode->i_mode) && inode->i_size) {
+			ctx.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+			if (ctx.fd < 0)
+				return -errno;
+
+			if (cfg.c_compr_opts[0].alg &&
+			    erofs_file_is_compressible(inode)) {
+				ctx.ictx = erofs_begin_compressed_file(inode,
+								ctx.fd, 0);
+				if (IS_ERR(ctx.ictx))
+					return PTR_ERR(ctx.ictx);
+			}
+		}
 		ret = erofs_mkfs_go(inode->sbi, EROFS_MKFS_JOB_NDIR,
-				    &inode, sizeof(inode));
-	else
+				    &ctx, sizeof(ctx));
+	} else {
 		ret = erofs_mkfs_handle_directory(inode);
+	}
 	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
 		   inode->i_mode);
 	return ret;
-- 
2.30.2

