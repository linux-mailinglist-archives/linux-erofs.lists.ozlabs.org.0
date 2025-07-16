Return-Path: <linux-erofs+bounces-637-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F189B07B1D
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 18:25:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bj1cB3Jwdz30FR;
	Thu, 17 Jul 2025 02:24:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752683098;
	cv=none; b=eOtxVEidz2eoNr3VtM5cB8gq7oEFASMHsMCKmbljFbiK1s3yZ0aSpYbuZKYifoTV+pNuOsJlpG6rep1+fGhGfsgX570RdfWXfHHEXqFezuJrE1ZtB3g3xdw66deQBhW8WMFrlFhZL/YDGHXzuGSZco1ujhdOtcDysBcVwPlcDdyhMyNfevRpGep/nCKvWCepq2gaT9Tcc2FJ6WpdxLeaVqSYOawZJS/ITDwFyZMTV78OLqzqJDzn7IcFcBKed2vIKLszsSpkQtQqWPpPFcmpEqlKMUwzEBMl3XuMQVpmrF07IQBvEcUNChwiUXp1BP/PyfvSDR0djIRa2LU2kz7B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752683098; c=relaxed/relaxed;
	bh=VXvpuroeXhDb+0RQM8/1WDWjuB+F6dEllY8amoAq6Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdew919Logtg19+2wUkf5Slcg5dYrIDnG0N2rzNVvUM6qe5sJ+JAQ4Jd5XzJ7LpXsmfYuBPF0ubJ0FFfZmP6eK/gQirhVk0al8URRMhyKGBmToiQWByO3HkFYMeFNR0XDJ86IFTJ9mGkqSh0t9lIpKKy4bSyxrLRCY+3yJQmuXnpqlfk6URGYPq0Dzeh608kaG/hrp3ydXLVLmzJrMcafo4pzWvBr2kStl3yw2bUTPQ3iT9CkmX/CQlTxYk27V6kUs8NmRGthnCpfXNbih5ZSM1+OF6cDlevP+AREv7VChvhG0rhhlteu2aGhUHPFLOo4U82YQqEuLYUsjVq8C20zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UJNj7jUd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UJNj7jUd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bj1c75lrSz2ySY
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 02:24:55 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752683091; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VXvpuroeXhDb+0RQM8/1WDWjuB+F6dEllY8amoAq6Ng=;
	b=UJNj7jUdO+79nTvy28gfjpYWBzUY10LwuWUqWC7c8qTpGs21qZ64G13FMDOIl9MGZd3DLAVbsSxFwxEet/HI1k4hjgrWX3fk6Fdp4rWXP4wao+RTAIaoqixUF/XfCpktYLzfKK3dIsfUVE+mgB9bsA29g/wJVc1ctJoVSFGkeNU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj5JWup_1752683089 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 00:24:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs-utils: use virtual file interface for the buffer manager
Date: Thu, 17 Jul 2025 00:24:41 +0800
Message-ID: <20250716162441.209783-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250716162441.209783-1-hsiangkao@linux.alibaba.com>
References: <20250716162441.209783-1-hsiangkao@linux.alibaba.com>
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

In order to prepare for the upcoming metadata compression.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h    |  9 +++++----
 include/erofs/internal.h |  6 ------
 include/erofs/io.h       |  2 +-
 lib/cache.c              | 12 +++++++++---
 lib/io.c                 |  6 +++---
 mkfs/main.c              |  4 ++--
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 0c665e8f..d5618c00 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -57,18 +57,18 @@ struct erofs_buffer_block {
 };
 
 struct erofs_bufmgr {
-	struct erofs_sb_info *sbi;
-
 	/* buckets for all buffer blocks to boost up allocation */
 	struct list_head watermeter[META + 1][2][EROFS_MAX_BLOCK_SIZE];
 	unsigned long bktmap[META + 1][2][EROFS_MAX_BLOCK_SIZE / BITS_PER_LONG];
 
 	struct erofs_buffer_block blkh;
-	erofs_blk_t tail_blkaddr, metablkcnt;
+	struct erofs_sb_info *sbi;
+	struct erofs_vfile *vf;
 
 	/* last mapped buffer block to accelerate erofs_mapbh() */
 	struct erofs_buffer_block *last_mapped_block;
 
+	erofs_blk_t tail_blkaddr, metablkcnt;
 	/* align data block addresses to multiples of `dsunit` */
 	unsigned int dsunit;
 };
@@ -122,7 +122,8 @@ static inline int erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 }
 
 struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
-				       erofs_blk_t startblk);
+				       erofs_blk_t startblk,
+				       struct erofs_vfile *vf);
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
 
 struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 65d40840..1431c16d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -487,12 +487,6 @@ static inline int erofs_dev_write(struct erofs_sb_info *sbi, const void *buf,
 	return 0;
 }
 
-static inline int erofs_dev_fillzero(struct erofs_sb_info *sbi, u64 offset,
-				     size_t len, bool pad)
-{
-	return erofs_io_fallocate(&sbi->bdev, offset, len, pad);
-}
-
 static inline int erofs_dev_resize(struct erofs_sb_info *sbi,
 				   erofs_blk_t blocks)
 {
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 101a5ba4..14d6e45f 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -59,7 +59,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf, u64 pos, size_t
 ssize_t erofs_io_pwritev(struct erofs_vfile *vf, const struct iovec *iov,
 			 int iovcnt, u64 pos);
 int erofs_io_fsync(struct erofs_vfile *vf);
-ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
+int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
 ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
 ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t len);
diff --git a/lib/cache.c b/lib/cache.c
index b3cf1c48..079465ed 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -29,7 +29,8 @@ const struct erofs_bhops erofs_skip_write_bhops = {
 };
 
 struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
-				       erofs_blk_t startblk)
+				       erofs_blk_t startblk,
+				       struct erofs_vfile *vf)
 {
 	unsigned int blksiz = erofs_blksiz(sbi);
 	struct erofs_bufmgr *bmgr;
@@ -54,6 +55,7 @@ struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
 	bmgr->last_mapped_block = &bmgr->blkh;
 	bmgr->metablkcnt = 0;
 	bmgr->dsunit = 0;
+	bmgr->vf = vf ?: &sbi->bdev;
 	return bmgr;
 }
 
@@ -482,9 +484,13 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 			continue;
 
 		padding = blksiz - (p->buffers.off & (blksiz - 1));
-		if (padding != blksiz)
-			erofs_dev_fillzero(sbi, erofs_pos(sbi, blkaddr) - padding,
+		if (padding != blksiz) {
+			ret = erofs_io_fallocate(bmgr->vf,
+					   erofs_pos(sbi, blkaddr) - padding,
 					   padding, true);
+			if (ret < 0)
+				return ret;
+		}
 
 		if (p->type != DATA)
 			bmgr->metablkcnt += p->buffers.nblocks;
diff --git a/lib/io.c b/lib/io.c
index aa043cae..983d9bf9 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -147,8 +147,8 @@ int erofs_io_fsync(struct erofs_vfile *vf)
 	return 0;
 }
 
-ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
-			   size_t len, bool zeroout)
+int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
+		       size_t len, bool zeroout)
 {
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	ssize_t ret;
@@ -167,7 +167,7 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 	while (len > EROFS_MAX_BLOCK_SIZE) {
 		ret = erofs_io_pwrite(vf, zero, offset, EROFS_MAX_BLOCK_SIZE);
 		if (ret < 0)
-			return ret;
+			return (int)ret;
 		len -= ret;
 		offset += ret;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index fce26336..30804d10 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1377,7 +1377,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!incremental_mode) {
-		g_sbi.bmgr = erofs_buffer_init(&g_sbi, 0);
+		g_sbi.bmgr = erofs_buffer_init(&g_sbi, 0, NULL);
 		if (!g_sbi.bmgr) {
 			err = -ENOMEM;
 			goto exit;
@@ -1405,7 +1405,7 @@ int main(int argc, char **argv)
 			u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(&g_sbi));
 		else
 			u.startblk = g_sbi.primarydevice_blocks;
-		g_sbi.bmgr = erofs_buffer_init(&g_sbi, u.startblk);
+		g_sbi.bmgr = erofs_buffer_init(&g_sbi, u.startblk, NULL);
 		if (!g_sbi.bmgr) {
 			err = -ENOMEM;
 			goto exit;
-- 
2.43.5


