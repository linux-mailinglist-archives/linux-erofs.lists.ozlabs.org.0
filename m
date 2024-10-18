Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD19A3549
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 08:24:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XVF6b2Kshz3bnD
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 17:24:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729232677;
	cv=none; b=DgJ8W6UmfCrF/sUmxzxCgBhCnCrKIGd50AtNXLodOYn1HXGbqFKC0FvGuX6GdEFI02a7vNO733euRETlBVlRudTtNc5RkNDA+mpmQHn6zwPrQ7/lXKjuI0AYZ3sIZzi1yh1qBFlEMnEKbKN1WkBH0r4GiSVBJQRM6c3XZUd2SZs/su/ETNRQc61by69zog/KoJa4Cl7syG6E7aCtqLNtBJZvEBimWxT2C/8nu8HXNMuO69jJJSoUo8bd5eYC1iq3ApN/bPf8KiTDfU0WMRqILS7IThMUA63Ht1TedIYuoouNrWxvx/mS8d0i9Owh2ui2/sq80vv8A+D/KRT6XPqGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729232677; c=relaxed/relaxed;
	bh=EMShIBufTxJq/yECvGix0Y7v1UxHvXNsnf5mOsNc3xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIKgv4FBP01SAPKvM3g50Hswjx3f1i0RibcLb+o31OkBl9M10iiFw2WPk3KtwmyNO0NH8EfaiYuBZmmcYSZNVM4pQhLRjuIv3zc0B+q/y4eB+/ztqw57wNT+26nbM8ZTRdcIV+ycEhVg+IlzXfmxztcMcK88o41QxbyWZRO0cdFwMWIv3EVBY0459nEN8mLVZsfVfJIsqGRuzPtsG3zAYTn5FDigiOB9UykitKbZNWUGFcz4gYQGbaXaBx/7fI3UP6U0dJeda/e0sg4d7FQMP45dvf705OLbIGNKAC9pazWhZLJTco9iG+/v5uMKKsx25ekDKjqPsSdclDhejeGCRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KKFTJ5TW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KKFTJ5TW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XVF6T2qZXz3blC
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Oct 2024 17:24:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729232665; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EMShIBufTxJq/yECvGix0Y7v1UxHvXNsnf5mOsNc3xU=;
	b=KKFTJ5TW5b/kGnUMRVpr38f4eZyotvR/B7Ov/Tif2eGSOg3FyMHQQLIYACg/XXqQEvxwwUOeDyNfoPBRdP6j/iK2wjhRe+fqH7kn3gMacA4xGg5NIZ+yfkYz577d8mPZ7SeXihjAYM3tyb0tipV6JY0yJj+coU1eVPsx8rNRJrs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHNEMzt_1729232659 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 14:24:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: report leftovers for partially filled blocks
Date: Fri, 18 Oct 2024 14:24:17 +0800
Message-ID: <20241018062417.2297930-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

3rd-party applications may need the exact zeroed sizes for each
partial filesystem block to fill remote data.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/block_list.h |  2 +-
 lib/blobchunk.c            | 15 ++++++++++-----
 lib/block_list.c           | 10 +++++++---
 lib/inode.c                |  3 ++-
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 7db4d0c..8cc87d7 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -17,7 +17,7 @@ int erofs_blocklist_open(FILE *fp, bool srcmap);
 FILE *erofs_blocklist_close(void);
 
 void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
-			      erofs_off_t srcoff);
+			      erofs_off_t srcoff, unsigned int zeroedlen);
 #ifdef WITH_ANDROID
 void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks);
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 9e85721..119dd82 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -133,12 +133,13 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 				   erofs_off_t off)
 {
-	erofs_blk_t remaining_blks = BLK_ROUND_UP(inode->sbi, inode->i_size);
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_blk_t remaining_blks = BLK_ROUND_UP(sbi, inode->i_size);
 	struct erofs_inode_chunk_index idx = {0};
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
 	erofs_blk_t extent_end, chunkblks;
 	erofs_off_t source_offset;
-	unsigned int dst, src, unit;
+	unsigned int dst, src, unit, zeroedlen;
 	bool first_extent = true;
 
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
@@ -169,7 +170,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 				remaining_blks -= extent_end - extent_start;
 				tarerofs_blocklist_write(extent_start,
 						extent_end - extent_start,
-						source_offset);
+						source_offset, 0);
 				erofs_droid_blocklist_write_extent(inode,
 					extent_start,
 					extent_end - extent_start,
@@ -190,9 +191,13 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	}
 	off = roundup(off, unit);
 	extent_end = min(extent_end, extent_start + remaining_blks);
-	if (extent_start != EROFS_NULL_ADDR)
+	if (extent_start != EROFS_NULL_ADDR) {
+		zeroedlen = inode->i_size & (erofs_blksiz(sbi) - 1);
+		if (zeroedlen)
+			zeroedlen = erofs_blksiz(sbi) - zeroedlen;
 		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
-					 source_offset);
+					 source_offset, zeroedlen);
+	}
 	erofs_droid_blocklist_write_extent(inode, extent_start,
 			extent_start == EROFS_NULL_ADDR ?
 					0 : extent_end - extent_start,
diff --git a/lib/block_list.c b/lib/block_list.c
index 261e9ff..6bbe4ec 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -32,13 +32,17 @@ FILE *erofs_blocklist_close(void)
 
 /* XXX: really need to be cleaned up */
 void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
-			      erofs_off_t srcoff)
+			      erofs_off_t srcoff, unsigned int zeroedlen)
 {
 	if (!block_list_fp || !nblocks || !srcmap_enabled)
 		return;
 
-	fprintf(block_list_fp, "%08x %8x %08" PRIx64 "\n",
-		blkaddr, nblocks, srcoff);
+	if (zeroedlen)
+		fprintf(block_list_fp, "%08x %8x %08" PRIx64 " %08u\n",
+			blkaddr, nblocks, srcoff, zeroedlen);
+	else
+		fprintf(block_list_fp, "%08x %8x %08" PRIx64 "\n",
+			blkaddr, nblocks, srcoff);
 }
 
 #ifdef WITH_ANDROID
diff --git a/lib/inode.c b/lib/inode.c
index 48f46b1..7abde7f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1198,7 +1198,8 @@ static int erofs_inode_reserve_data_blocks(struct erofs_inode *inode)
 	erofs_bdrop(bh, false);
 
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
-	tarerofs_blocklist_write(inode->u.i_blkaddr, nblocks, inode->i_ino[1]);
+	tarerofs_blocklist_write(inode->u.i_blkaddr, nblocks, inode->i_ino[1],
+				 alignedsz - inode->i_size);
 	return 0;
 }
 
-- 
2.43.5

