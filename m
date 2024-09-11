Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7609D974CBC
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 10:35:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3Yn20x1sz2yn2
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 18:35:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726043748;
	cv=none; b=Q+j8rwnY6TrGwhIdz08DRHOpyMQFREkGr4/2mbkChBrHZQYrqd4ke7ArpNMvVtktht5c11JxO7MiwZYEFuaBggXLEx+LIJLIrCWbma6YGS2v2NTWAelKSQ469/S5llN/ThkF7//1kz0k9qmFufNtGoARRZiNvbOjGitvORUGPyiS/C+sEfE4bfR6ORfzy7iUkZ4lKGen/xU51zEvBQHmd5tlQOGhCby6MSdcimIKmLE/Y78Aco9YIUTPSwrJs6uq7iG5q+jkypbPvgvfPwG+wR3x2dy1GptwoUHcnn3soHW/glLsTM7Wk3ZgvsA0Izw3pV9hBS4QEnv9GMbUTOyGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726043748; c=relaxed/relaxed;
	bh=kSfSC9p7bnxLY7RW2XDREl/b3AxMqC4ui3d/keKEJB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSRv9A/+uLWaNA1rvU1gZCGC4Ujuy9Thon7TGikK4tt7cO1+cRSSvTguz0lHGD60qTASEPN5SsYmxmkWcBpxXrAjLxZ5hugRsfjEAuauo+zZXEDO4OtJd3srxrLVTVue5VHYsLy4kFoq6WICgpO0PZ55LQqsN+skiswS5Rhmz6YmEciMW6nt2iLmCaPrJlQ8Pu8BvQo0DNYfINCTjld2VHrulUvxYQuZb2r2DjwcpBuABFpeSmFN/Iqphe+NxAzTyX9bFUlwzUC1K0lhkK6v3PVNRlkRjz1uEWyu2aO84ra6+oFvbh3t2HdNFwEtnYugOK1wJ0f1uQj9sggov/XGUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BHe1a8bq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BHe1a8bq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3Ymz3yYcz2yYk
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 18:35:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726043741; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kSfSC9p7bnxLY7RW2XDREl/b3AxMqC4ui3d/keKEJB4=;
	b=BHe1a8bq12lLDfHWXr+DeJI1+HG5//wpopY++oTpWgs0wnYw9vwPpifocdsy8/K6B4h/IJcNAfHwIdkui6qNoWNmjt6ONj/eQo+e1gLOwfKcKv86+Y7bT1CRZLbeJAUspbaLq8hIOCeK6TsJEsMohvmeU9S1KvUrOme1n1wdiEU=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEnALcv_1726043740)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 16:35:40 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: lib: fix incorrect nblocks in block list for chunked inodes
Date: Wed, 11 Sep 2024 16:35:39 +0800
Message-ID: <20240911083539.2111707-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, the number of physical blocks (nblocks) for the last chunk
written to the block list file is incorrectly recorded as the inode
chunksize.

This patch writes the actual number of physical blocks for the inode in
the last chunk to the block list file.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/blobchunk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 33dadd5..a0f3d0e 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -133,6 +133,7 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 				   erofs_off_t off)
 {
+	erofs_blk_t remaining_blks = BLK_ROUND_UP(inode->sbi, inode->i_size);
 	struct erofs_inode_chunk_index idx = {0};
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
 	erofs_blk_t extent_end, chunkblks;
@@ -165,6 +166,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		if (extent_start == EROFS_NULL_ADDR ||
 		    idx.blkaddr != extent_end) {
 			if (extent_start != EROFS_NULL_ADDR) {
+				remaining_blks -= extent_end - extent_start;
 				tarerofs_blocklist_write(extent_start,
 						extent_end - extent_start,
 						source_offset);
@@ -187,9 +189,11 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
 	off = roundup(off, unit);
-	if (extent_start != EROFS_NULL_ADDR)
+	if (extent_start != EROFS_NULL_ADDR) {
+		extent_end = min(extent_end, extent_start + remaining_blks);
 		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
 					 source_offset);
+	}
 	erofs_droid_blocklist_write_extent(inode, extent_start,
 			extent_start == EROFS_NULL_ADDR ?
 					0 : extent_end - extent_start,
-- 
2.43.5

