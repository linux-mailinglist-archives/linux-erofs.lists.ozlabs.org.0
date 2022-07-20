Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4324157B2CC
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jul 2022 10:22:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lnpbx247rz3blT
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jul 2022 18:22:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.3; helo=out199-3.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lnpbq1Zj5z2xmk
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jul 2022 18:22:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJw6BQ8_1658305349;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJw6BQ8_1658305349)
          by smtp.aliyun-inc.com;
          Wed, 20 Jul 2022 16:22:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: get rid of erofs_prepare_dio() helper
Date: Wed, 20 Jul 2022 16:22:29 +0800
Message-Id: <20220720082229.12172-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fold in erofs_prepare_dio() in order to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20220506194612.117120-1-hsiangkao@linux.alibaba.com

 fs/erofs/data.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fbb037ba326e..fe8ac0e163f7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -366,42 +366,33 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 	return iomap_bmap(mapping, block, &erofs_iomap_ops);
 }
 
-static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	loff_t align = iocb->ki_pos | iov_iter_count(to) |
-		iov_iter_alignment(to);
-	struct block_device *bdev = inode->i_sb->s_bdev;
-	unsigned int blksize_mask;
-
-	if (bdev)
-		blksize_mask = (1 << ilog2(bdev_logical_block_size(bdev))) - 1;
-	else
-		blksize_mask = (1 << inode->i_blkbits) - 1;
 
-	if (align & blksize_mask)
-		return -EINVAL;
-	return 0;
-}
-
-static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
-{
 	/* no need taking (shared) inode lock since it's a ro filesystem */
 	if (!iov_iter_count(to))
 		return 0;
 
 #ifdef CONFIG_FS_DAX
-	if (IS_DAX(iocb->ki_filp->f_mapping->host))
+	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		int err = erofs_prepare_dio(iocb, to);
+		struct block_device *bdev = inode->i_sb->s_bdev;
+		unsigned int blksize_mask;
+
+		if (bdev)
+			blksize_mask = bdev_logical_block_size(bdev) - 1;
+		else
+			blksize_mask = (1 << inode->i_blkbits) - 1;
+
+		if ((iocb->ki_pos | iov_iter_count(to) |
+		     iov_iter_alignment(to)) & blksize_mask)
+			return -EINVAL;
 
-		if (!err)
-			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-					    NULL, 0, NULL, 0);
-		if (err < 0)
-			return err;
+		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
+				    NULL, 0, NULL, 0);
 	}
 	return filemap_read(iocb, to, 0);
 }
-- 
2.24.4

