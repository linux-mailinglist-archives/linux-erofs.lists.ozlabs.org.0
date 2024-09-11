Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1786974D8E
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 10:55:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3ZD13JH3z2ym2
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 18:55:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726044940;
	cv=none; b=hawSA5wJDx3cm6+MneyW1eDToNTjM9SModjqQ/lAWDeEdTFgTG9M2NIedqWenLb0cm46WbCirmxdzqaJKxlIBl5kXlWFysxwL53wYKcfqrNthc5xqnMLIjLEXItbuRQl6SccxKPALSDtKggja9oqOqixZoNYutQvdCp3TlnLoONkEzCYuq5bh92UmegXfcaYSqcHST/wpIpT0JQF4Nq5QcyXBHaParLDyAtUEkVlQZawj4zJMb1RKcGVOxAqXzR6T5zpJc1zX/JHu/MMdFhwgTzrSg7SgjTy4pW/s9JFe7Uv5bs8MvEtRZ0QL0tsTEno/3P5j8mbgnv/Dq8/5cMitg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726044940; c=relaxed/relaxed;
	bh=zXIpT+5a8kPvi7b61whJQoT8/OhKNo7cK3uSHma4L7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqfO8/dACOR0nb7hf/UgYjJ4q/HXsNJY5vyP2ry458BqDyVEF72czmDJiCGj1uo+TgLdO4er/nB4UM6sZ+mLgx2UFsOV6mKuiL7GEBQm8zDd6fa4AVWTh8s/ZAATFqnuAHOwK/VJWVi3FRX0go8lg2LIQGPK40Em2zHTGW5nKNY0sMLw8jy2DFepPjHn2YtiLgSoBIm9ikQ+4AeStopGwUbOIOzeYbZyP2yMc3VwOTKG6LZnsFM155rPGexa93PRLuPN424G7MXmezVQs1idfP1plAfgxMWzi0/xfqGDtSySr+ngkCAwo03iLfUd6QnFfN6v4WbfzQsLUh6vIkRc2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=czwxGxQp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=czwxGxQp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3ZCv4pCLz2xXW
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 18:55:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726044934; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zXIpT+5a8kPvi7b61whJQoT8/OhKNo7cK3uSHma4L7M=;
	b=czwxGxQpVBFswQ0ZpscjDvz/LKMZFdoXJrp6hSKC2wcXrPAgo7hhlh2GIHwpdBfBAiPDY/NLOKDC2t29RSMlbOVc+Su9I+eU7myLlLJd3W0mdv76JYxGYouz29+nxITEgXDfC9YBjmbiA7uAlNYpg/+/yt3FUVdrk3o5aiLdmXE=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEnARyX_1726044932)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 16:55:33 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: lib: fix incorrect nblocks in block list for chunked inodes
Date: Wed, 11 Sep 2024 16:55:31 +0800
Message-ID: <20240911085531.2133723-1-hongzhen@linux.alibaba.com>
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
v3: Make the computed `extend_end` have impact on erofs_droid_blocklist_write_extent().
v2: https://lore.kernel.org/all/20240911083539.2111707-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240911081020.2088531-1-hongzhen@linux.alibaba.com/
---
 lib/blobchunk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 33dadd5..6c2ea0e 100644
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
@@ -187,6 +189,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
 	off = roundup(off, unit);
+	extent_end = min(extent_end, extent_start + remaining_blks);
 	if (extent_start != EROFS_NULL_ADDR)
 		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
 					 source_offset);
-- 
2.43.5

