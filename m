Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B0775BDA2
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 07:08:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R6cyK4hLTz3bcP
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jul 2023 15:08:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R6cyH1ftwz2yth
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jul 2023 15:08:06 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vnt851U_1689916075;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vnt851U_1689916075)
          by smtp.aliyun-inc.com;
          Fri, 21 Jul 2023 13:08:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] AOSP: erofs-utils: mkfs: fix block list support for chunked files
Date: Fri, 21 Jul 2023 13:07:55 +0800
Message-Id: <20230721050755.82122-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

chunksize may not always equal to blocksize (e.g. 4KiB).  Also it can
lead to unexpected behaviors when the consecutive chunk merging is
implemented later since the chunksize is also on a per-file basis.

Fixes: d9a01943f8c5 ("AOSP: erofs-utils: mkfs: add block list support for chunked files")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 56077dc..44541d5 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -127,7 +127,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 {
 	struct erofs_inode_chunk_index idx = {0};
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
-	erofs_blk_t extent_end, extents_blks;
+	erofs_blk_t extent_end, chunkblks;
 	unsigned int dst, src, unit;
 	bool first_extent = true;
 
@@ -136,6 +136,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	else
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
+	chunkblks = 1U << (inode->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	for (dst = src = 0; dst < inode->extent_isize;
 	     src += sizeof(void *), dst += unit) {
 		struct erofs_blobchunk *chunk;
@@ -152,20 +153,18 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			idx.blkaddr = remapped_base + chunk->blkaddr;
 		}
 
-		if (extent_start != EROFS_NULL_ADDR &&
-		    idx.blkaddr == extent_end + 1) {
-			extent_end = idx.blkaddr;
-		} else {
+		if (extent_start == EROFS_NULL_ADDR ||
+		    idx.blkaddr != extent_end) {
 			if (extent_start != EROFS_NULL_ADDR) {
 				erofs_droid_blocklist_write_extent(inode,
 					extent_start,
-					(extent_end - extent_start) + 1,
+					extent_end - extent_start,
 					first_extent, false);
 				first_extent = false;
 			}
 			extent_start = idx.blkaddr;
-			extent_end = idx.blkaddr;
 		}
+		extent_end = idx.blkaddr + chunkblks;
 		idx.device_id = cpu_to_le16(chunk->device_id);
 		idx.blkaddr = cpu_to_le32(idx.blkaddr);
 
@@ -175,12 +174,9 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
 	off = roundup(off, unit);
-
-	if (extent_start == EROFS_NULL_ADDR)
-		extents_blks = 0;
-	else
-		extents_blks = (extent_end - extent_start) + 1;
-	erofs_droid_blocklist_write_extent(inode, extent_start, extents_blks,
+	erofs_droid_blocklist_write_extent(inode, extent_start,
+			extent_start == EROFS_NULL_ADDR ?
+					0 : extent_end - extent_start,
 					   first_extent, true);
 
 	return dev_write(inode->sbi, inode->chunkindexes, off, inode->extent_isize);
-- 
2.24.4

