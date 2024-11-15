Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7669CDA05
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 08:46:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqTcV5jC1z30T8
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 18:46:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731656809;
	cv=none; b=Dy768daq/I1VL8fLdyq1GtzEAOZ3xdtysLEYweEM3vx3Bp+kAyhr1Fsz9IPuvMfAS40ouU/6mQzdma88++oUR5B4SlM/RbJ77p+jJIeg/ii7YdFnBOxeH8V727u+Glpsm9bTrIkV0K2mg+J1o3MsYFRvo3AhbSGP4mdqe2rmlny3+LPXH8Ub42r85VM/OpuHLfHEIvW+exg9z10Qtv42Qrxio3GQxWhgwglNO4COmptvN1cHLGjF6/i/1cu/7V4slcLnu03SZX7XrzCrcoE1aJgZiwusvCHYbDJyb1plxtd9fhjXYTFJOTHF74PJEIpeZiPG8Oooqt4Vx5Qmpin8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731656809; c=relaxed/relaxed;
	bh=klSvFmmsqd9sENMEOR6smds4gtQMegD4wv7mVDkLMIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTHSRJUd6x53MNxV+9++HkY5iC8/CiaX96TyQqJAT4eB6x7mEUp+rGkrY9lTNNBad4SjZs/xHYuWUQJ5HtQvl+D5T/QffEwKooMfnBkDBfuEmXrrSgniDrP8UiDYCVllOtnziYpr5BbOEVbgvUeJRKs0nWYtYhY3LezfSrCF2Fjn9m9aiGiIbB5abZme9iw855S2R0V0UE60EpTYL8noyU+En2nki8MLn79PWWd5Nfyii3F14kIV6YZ3VVnw+ObeMUn1SD4OGEhOyfNEM5SubW/DyHOxHUHzWwBgeU9iSevSc1e+yVstd5SOLFF89MGYpHNJDTlr7B6LoQrlet811Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fNc0iYZm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fNc0iYZm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqTcP4KWgz2y65
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 18:46:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731656793; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=klSvFmmsqd9sENMEOR6smds4gtQMegD4wv7mVDkLMIg=;
	b=fNc0iYZmGfDiRgKGTtP7RuH29ORJ8fGj+VE5e+6GoxaO1vB1fk1GcpObmENwjL82L2cMk9gtx18vulH1jaIFbr0ZP0JBCCb1uKDXSM2a9d54cWGDtfh2Ltttkjhu/WKFBwHkaY56hG15tOQ34+kWQLMAy31xmYvhk1YAXdcCB9E=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJSN0YK_1731656787 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 15:46:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clarify direct I/O support
Date: Fri, 15 Nov 2024 15:46:25 +0800
Message-ID: <20241115074625.2520728-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, only filesystems backed by block devices support direct I/O.

Also remove the unnecessary strict checks that can be supported with iomap.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c  | 15 +--------------
 fs/erofs/inode.c | 12 ++++++------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index db4bde4c0852..bb9751f6dea8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -413,22 +413,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		struct block_device *bdev = inode->i_sb->s_bdev;
-		unsigned int blksize_mask;
-
-		if (bdev)
-			blksize_mask = bdev_logical_block_size(bdev) - 1;
-		else
-			blksize_mask = i_blocksize(inode) - 1;
-
-		if ((iocb->ki_pos | iov_iter_count(to) |
-		     iov_iter_alignment(to)) & blksize_mask)
-			return -EINVAL;
-
+	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
 				    NULL, 0, NULL, 0);
-	}
 	return filemap_read(iocb, to, 0);
 }
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index db29190656eb..d4b89407822a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -318,6 +318,7 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
+	struct block_device *bdev = inode->i_sb->s_bdev;
 	bool compressed =
 		erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout);
 
@@ -330,15 +331,14 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	/*
 	 * Return the DIO alignment restrictions if requested.
 	 *
-	 * In EROFS, STATX_DIOALIGN is not supported in ondemand mode and
-	 * compressed files, so in these cases we report no DIO support.
+	 * In EROFS, STATX_DIOALIGN is only supported in bdev-based mode
+	 * and uncompressed inodes, otherwise we report no DIO support.
 	 */
 	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
 		stat->result_mask |= STATX_DIOALIGN;
-		if (!erofs_is_fscache_mode(inode->i_sb) && !compressed) {
-			stat->dio_mem_align =
-				bdev_logical_block_size(inode->i_sb->s_bdev);
-			stat->dio_offset_align = stat->dio_mem_align;
+		if (bdev && !compressed) {
+			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
 	}
 	generic_fillattr(idmap, request_mask, inode, stat);
-- 
2.43.5

