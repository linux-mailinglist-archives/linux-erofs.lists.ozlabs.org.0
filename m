Return-Path: <linux-erofs+bounces-1644-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F673CE7CB8
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 19:07:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dg41P1Vl6z2x9M;
	Tue, 30 Dec 2025 05:07:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767031625;
	cv=none; b=coFFjIf299Vm7SSTIBiEsnupXVAWReWnVMqduj9baU+fr+Us2bqJR1xDa3fp1pKwgYTk0pdGhR+twZqFhJaRdUF4/7oAK+4WOEXuSU8SzRc2RBbqzbs+lwwxC2Q+ovcUS6HcVs8rZ14dXV6CuSdDisGPErTcQjHCtycB+9LQtE8W5yc0HM35U98oVIO/hHLDqGJ+OWPYSOwCQTuWEem0N2wAPNH3JbdnjQ1h6IeBqrJz4AE6z8GrUyFs1dD0SbJEFFcYkBg2pCotCVwA4K/uawg26HiDKHR5+0LWixq8JvQK5SVdHA0AMRgH6oamLUZ9p436yK6ru2q+f5fIQyQv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767031625; c=relaxed/relaxed;
	bh=7GH+UeVYZcRsdVz413zaOzCmM/leI7eBEJnscEyfvBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1uD2YZIcUe2eluKAA/WPBPZbjx+92/9yicJBYiYwySkxnHMvnpHC4tCbQ2i6FkleLYak8nb1SHyVrgyoGGNDuouzvVBrvdZuP7IW5aYDhizCqZRGSJMQ6HIVkTJlBvXMoDxM42y6UEF2QC2tmPnjiPLYkqjTRlytvA6kNF5nAmSGxECD1DaUxGjbGc29W7ifFMftR+AP/x3HOLWdXfVRugpCpXGJoGZtsf3kw7Lc4axPNt+lo8yQ/I7pravJH0d44dGiPjZNRwKJw+komxVUncAC4KD1R4vyjlXkhcm4twJVdfJFLJm8OwsZYB92vbZ0fRa+WRXn2vVFhCH2+JZFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DF6X6VHA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DF6X6VHA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dg41L0FZhz2xgv
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 05:06:59 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767031616; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7GH+UeVYZcRsdVz413zaOzCmM/leI7eBEJnscEyfvBY=;
	b=DF6X6VHA/HhhefV+IaIzliiO0LZMrcMZ5Pvs7FIbGhOT7Bgkf12ple6+Kbk3b6E++EvldPvC5j/zLTuQXs5eTdZTWXKkJ8d2gC7C6Tesm1bXkkdBAecQ3oNutbhQv++u07HQS8T0ca1qlCx9BkL6uUG95qx6WQJtMXglNFNzESc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvwyKv8_1767031613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 02:06:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 3/4] erofs-utils: lib: delay erofs_prepare_xattr_ibody()
Date: Tue, 30 Dec 2025 02:06:45 +0800
Message-ID: <20251229180646.3017326-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229180646.3017326-1-hsiangkao@linux.alibaba.com>
References: <20251229180646.3017326-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Call erofs_prepare_xattr_ibody() in erofs_mkfs_handle_nondirectory()
and erofs_mkfs_create_directory() instead.

Note that it shouldn't be called in erofs_prepare_inode_buffer(),
which is too late.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 77 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index dc3d82749405..7ee16f4db183 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1459,7 +1459,12 @@ static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 					  struct erofs_mkfs_job_ndir_ctx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
-	int ret = 0;
+	int ret;
+
+	ret = erofs_prepare_xattr_ibody(inode,
+					btctx->incremental && IS_ROOT(inode));
+	if (ret < 0)
+		return ret;
 
 	if (S_ISLNK(inode->i_mode)) {
 		char *symlink = inode->i_link;
@@ -1490,6 +1495,42 @@ static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 	return 0;
 }
 
+static int erofs_mkfs_create_directory(const struct erofs_mkfs_btctx *ctx,
+				       struct erofs_inode *inode)
+{
+	unsigned int bsz = erofs_blksiz(inode->sbi);
+	int ret;
+
+	ret = erofs_prepare_xattr_ibody(inode, ctx->incremental && IS_ROOT(inode));
+	if (ret < 0)
+		return ret;
+
+	if (inode->datalayout == EROFS_INODE_DATALAYOUT_MAX) {
+		inode->datalayout = EROFS_INODE_FLAT_INLINE;
+
+		ret = erofs_begin_compress_dir(ctx->im, inode);
+		if (ret && ret != -ENOSPC)
+			return ret;
+	} else {
+		DBG_BUGON(inode->datalayout != EROFS_INODE_FLAT_PLAIN);
+	}
+
+	/* it will be used in erofs_prepare_inode_buffer */
+	if (inode->datalayout == EROFS_INODE_FLAT_INLINE)
+		inode->idata_size = inode->i_size & (bsz - 1);
+
+	/*
+	 * Directory on-disk inodes should be close to other inodes
+	 * in the parent directory since parent directories should
+	 * generally be prioritized.
+	 */
+	ret = erofs_prepare_inode_buffer(ctx->im, inode);
+	if (ret)
+		return ret;
+	inode->bh->op = &erofs_skip_write_bhops;
+	return 0;
+}
+
 enum erofs_mkfs_jobtype {	/* ordered job types */
 	EROFS_MKFS_JOB_NDIR,
 	EROFS_MKFS_JOB_DIR,
@@ -1518,34 +1559,8 @@ static int erofs_mkfs_jobfn(const struct erofs_mkfs_btctx *ctx,
 	if (item->type == EROFS_MKFS_JOB_NDIR)
 		return erofs_mkfs_handle_nondirectory(ctx, &item->u.ndir);
 
-	if (item->type == EROFS_MKFS_JOB_DIR) {
-		unsigned int bsz = erofs_blksiz(inode->sbi);
-
-		if (inode->datalayout == EROFS_INODE_DATALAYOUT_MAX) {
-			inode->datalayout = EROFS_INODE_FLAT_INLINE;
-
-			ret = erofs_begin_compress_dir(ctx->im, inode);
-			if (ret && ret != -ENOSPC)
-				return ret;
-		} else {
-			DBG_BUGON(inode->datalayout != EROFS_INODE_FLAT_PLAIN);
-		}
-
-		/* it will be used in erofs_prepare_inode_buffer */
-		if (inode->datalayout == EROFS_INODE_FLAT_INLINE)
-			inode->idata_size = inode->i_size & (bsz - 1);
-
-		/*
-		 * Directory on-disk inodes should be close to other inodes
-		 * in the parent directory since parent directories should
-		 * generally be prioritized.
-		 */
-		ret = erofs_prepare_inode_buffer(ctx->im, inode);
-		if (ret)
-			return ret;
-		inode->bh->op = &erofs_skip_write_bhops;
-		return 0;
-	}
+	if (item->type == EROFS_MKFS_JOB_DIR)
+		return erofs_mkfs_create_directory(ctx, inode);
 
 	if (item->type == EROFS_MKFS_JOB_DIR_BH) {
 		ret = erofs_write_dir_file(inode);
@@ -1964,10 +1979,6 @@ static int erofs_mkfs_handle_inode(const struct erofs_mkfs_btctx *ctx,
 	else if (inode->whiteouts)
 		erofs_set_origin_xattr(inode);
 
-	ret = erofs_prepare_xattr_ibody(inode, ctx->incremental && IS_ROOT(inode));
-	if (ret < 0)
-		return ret;
-
 	if (!S_ISDIR(inode->i_mode)) {
 		ret = erofs_mkfs_begin_nondirectory(ctx, inode);
 	} else {
-- 
2.43.5


