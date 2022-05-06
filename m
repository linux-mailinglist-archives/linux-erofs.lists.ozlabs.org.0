Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCBC51DFC4
	for <lists+linux-erofs@lfdr.de>; Fri,  6 May 2022 21:46:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kw1Kd3Z8mz3c7W
	for <lists+linux-erofs@lfdr.de>; Sat,  7 May 2022 05:46:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kw1KW4WZFz3byX
 for <linux-erofs@lists.ozlabs.org>; Sat,  7 May 2022 05:46:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VCTGriZ_1651866373; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VCTGriZ_1651866373) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 07 May 2022 03:46:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] erofs: get rid of erofs_prepare_dio() helper
Date: Sat,  7 May 2022 03:46:10 +0800
Message-Id: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fold in erofs_prepare_dio() and it seems much clearer.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb9c1fd48c19..fa9fdc6a5966 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -366,42 +366,32 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
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
-
-	if (align & blksize_mask)
-		return -EINVAL;
-	return 0;
-}
 
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
-
-		if (!err)
-			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-					    NULL, 0, 0);
-		if (err < 0)
-			return err;
+		loff_t align = iocb->ki_pos | iov_iter_count(to) |
+			iov_iter_alignment(to);
+		struct block_device *bdev = inode->i_sb->s_bdev;
+		unsigned int blksize_mask;
+
+		if (bdev)
+			blksize_mask = bdev_logical_block_size(bdev) - 1;
+		else
+			blksize_mask = (1 << inode->i_blkbits) - 1;
+
+		if (align & blksize_mask)
+			return -EINVAL;
+		return iomap_dio_rw(iocb, to, &erofs_iomap_ops, NULL, 0, 0);
 	}
 	return filemap_read(iocb, to, 0);
 }
-- 
2.24.4

