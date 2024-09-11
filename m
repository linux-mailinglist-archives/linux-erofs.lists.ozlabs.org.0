Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B90974C3A
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 10:10:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3YCt33b1z2yk8
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 18:10:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726042231;
	cv=none; b=g/9jABjguIIm+0UWLleGcQPN/9/r3AAx5Y0HrECBpUm9SDYqIVUtklOKsy6oHoRh/38ue9b2qkudEC/y3dz/etfD7RbtVhBCvZVjw+duhGOy8ALzRtgCATZeESukeb6mIKfgdm2EJ20lx6YUIVOKZos5Zqe49lgSN370Ppzq/iVhDmteRNGYZdBTS+hPj4B3u6EeixxtQGV48OUREG7IOUwrlHzUP/M2QRGhIJCIgtX7TD/OTjgbCjdKcz9UcTX1n+HUL8gHhcXiEC5dI5eBN3DSSDqBkne7AD7B0GKBVbiEFdyUecTakqXSzDqZT3kwp1BC7b4fLIxv8qJZ80FrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726042231; c=relaxed/relaxed;
	bh=Kp1kj5/AVa+t0TnEHklpRWQd7jCh2XKIgXanh88fa4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpelneQjCmElh1w0r96dg76U+EBzApZjKD1fh7qW1Mtfhkz5lHHf0mN3ZXiWAX7nM9O0fYkXuQnSarv0+9/MZbA57IacGmsm+2rSMJ/85ec0Xwx1OXHd1GskiAU2eeMQ3hX3Y2P4Wq5lJx5OLRfnQDsIa+WLWCUiBM3aT0laJqrUYzAv8aApT9UAtnhvmMLp6WNTrQVxbw+VfgU24oSm8UxHLFqwZZ2E1Kp2zXBPg9DXlu4mpA3xTjViwvqDhfKP5oG2QdieCEYCcyGY2CXZxJ8JW4LnsbidyXavQUqZ+A0Jcf+J1JSSPVgL/Q5RNtpeoizMoYxsU2z6CVBxnizc5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E7cfNXYb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E7cfNXYb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3YCn5n8Zz2xGF
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 18:10:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726042223; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Kp1kj5/AVa+t0TnEHklpRWQd7jCh2XKIgXanh88fa4A=;
	b=E7cfNXYbVdqtF+/UEQ5Ub4T5VCzX0fxTPrNDX/z0tqDd2lAxBBRVryHrPrTydGjUueVH/KhVCX9/GSpXhpd5Ckf87+HJaEc5OwUJnR2UiBsCCwUdLf0GIGyowf3H+KfDeRJDKKwntiLhbWMdRC4F5pXNwKTQIDLJlCxVfd5aWZ0=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEnADdj_1726042221)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 16:10:22 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix the incorrect nblocks number under chunk mode
Date: Wed, 11 Sep 2024 16:10:20 +0800
Message-ID: <20240911081020.2088531-1-hongzhen@linux.alibaba.com>
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

Currently, in chunk mode, the number of blocks (nblocks) for the last
chunk written to the blocklist file is the size of the chunk, which may
not be consistent with the size of the original file in the last chunk.
This patch writes the actual number of blocks of the file in the last
chunk to the blocklist file.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/blobchunk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 33dadd5..40b731b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -135,6 +135,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 {
 	struct erofs_inode_chunk_index idx = {0};
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
+	erofs_blk_t front_blks = 0, tail_blks;
 	erofs_blk_t extent_end, chunkblks;
 	erofs_off_t source_offset;
 	unsigned int dst, src, unit;
@@ -165,6 +166,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		if (extent_start == EROFS_NULL_ADDR ||
 		    idx.blkaddr != extent_end) {
 			if (extent_start != EROFS_NULL_ADDR) {
+				front_blks += extent_end - extent_start;
 				tarerofs_blocklist_write(extent_start,
 						extent_end - extent_start,
 						source_offset);
@@ -187,9 +189,12 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
 	off = roundup(off, unit);
-	if (extent_start != EROFS_NULL_ADDR)
-		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
+	if (extent_start != EROFS_NULL_ADDR) {
+		tail_blks = BLK_ROUND_UP(inode->sbi, inode->i_size)
+			    - front_blks;
+		tarerofs_blocklist_write(extent_start, tail_blks,
 					 source_offset);
+	}
 	erofs_droid_blocklist_write_extent(inode, extent_start,
 			extent_start == EROFS_NULL_ADDR ?
 					0 : extent_end - extent_start,
-- 
2.43.5

