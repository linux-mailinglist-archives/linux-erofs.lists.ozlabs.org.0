Return-Path: <linux-erofs+bounces-34-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CCA59057
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:55:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBC1X6hjpz30VV;
	Mon, 10 Mar 2025 20:55:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741600512;
	cv=none; b=NuMqjUTDJCsWSNGeHFgh0t8iXJhH22gfNOim/a7J8qM+3N61FIrGuumCPHHlIsQuV/hJFa1IwU9QFYHhn7ZJ6EtGcIDbZ4vT33IlkUH5vtHOzzV4XAXSQE/PcamrcLCsvSXfmzdSNnLUTyj0GVZCYUVwFSJ0Mi5cvAWNQnO3NXzmEvI94B3gWI+Uwg70ctSeWOtRX8ilZMEnZ2382smy+qnyNpzjDBwsf2/7xlYBr16QkQbshAE+87B1vwkxBst5xH01MnyZiNqBsfaI7uy4a5QD2Q6ZwB/POwFH5mnzWkADxPUrknUuCyHjAr+d1d+yhtj2mT92trmHGp3BFbkIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741600512; c=relaxed/relaxed;
	bh=uroFFZkg+9TmfgPuBM9ZBqZ5Jlq2UIuIm35LWHZSJMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfeP1iGC7PUA1CdZmlDEToiECq3zHPdntw5olohvBdEt8we8s3pkzz08RTfDorZFCtr9h2PU7mt3r+CWU5bPiXqMlkwJ++sGmHAWvnClnlQ1QX9bWcVyKwJStJRGPYJaI8OkOmOVkUAh/2m41VhEf5gYEQg2zFpsuEH+cYGC0B9f+e5QAfXzZ3MJdZWbuOifuoidA7Jcb3MBxMOg2mMzpMTTusvUPf5a1xEWzU//dXByL0eXLcz8H0HcKxFdxl3UPhMxDP1gbu4JhciZviYqWa/6C08/8osz14DBeRHAtR4HTZy0PinPRoE4hb4GyvoYT9Q9LkzKSFjS89qXeusOdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uvFj1rIT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uvFj1rIT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBC1V073xz2ykX
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:55:09 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600505; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uroFFZkg+9TmfgPuBM9ZBqZ5Jlq2UIuIm35LWHZSJMM=;
	b=uvFj1rITMbGXpsaYdJi7hAytlyWqWGtk/EvABF2Ym521jbO4nD0gWKGdRv2BiT3N1rl2xOHI83aQwhdoLSwvrAX9FUenjizVv7caalmPBQVMBXJUXzhja4g1crBmeRv9UdDNGe65Q8E3CQ4Gta46DGc57uBaN3zMQRK0UpejCPc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3x1_1741600504 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 01/10] erofs: get rid of erofs_map_blocks_flatmode()
Date: Mon, 10 Mar 2025 17:54:51 +0800
Message-ID: <20250310095459.2620647-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

It's simple enough to be folded into erofs_map_blocks().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 117 +++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 70 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1d2cb0fa1baf..2f45e39ce8c7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -70,58 +70,39 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 	return erofs_bread(buf, offset, need_kmap);
 }
 
-static int erofs_map_blocks_flatmode(struct inode *inode,
-				     struct erofs_map_blocks *map)
-{
-	struct erofs_inode *vi = EROFS_I(inode);
-	struct super_block *sb = inode->i_sb;
-	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
-	erofs_blk_t lastblk = erofs_iblks(inode) - tailendpacking;
-
-	map->m_flags = EROFS_MAP_MAPPED;	/* no hole in flat inodes */
-	if (map->m_la < erofs_pos(sb, lastblk)) {
-		map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
-		map->m_plen = erofs_pos(sb, lastblk) - map->m_la;
-	} else {
-		DBG_BUGON(!tailendpacking);
-		map->m_pa = erofs_iloc(inode) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(sb, map->m_la);
-		map->m_plen = inode->i_size - map->m_la;
-
-		/* inline data should be located in the same meta block */
-		if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
-			erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		map->m_flags |= EROFS_MAP_META;
-	}
-	return 0;
-}
-
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 {
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = inode->i_sb;
+	unsigned int unit, blksz = sb->s_blocksize;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_chunk_index *idx;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	u64 chunknr;
-	unsigned int unit;
+	erofs_blk_t startblk;
+	bool tailpacking;
 	erofs_off_t pos;
-	void *kaddr;
+	u64 chunknr;
 	int err = 0;
 
 	trace_erofs_map_blocks_enter(inode, map, 0);
 	map->m_deviceid = 0;
-	if (map->m_la >= inode->i_size) {
-		/* leave out-of-bound access unmapped */
-		map->m_flags = 0;
-		map->m_plen = map->m_llen;
+	map->m_flags = 0;
+	if (map->m_la >= inode->i_size)
 		goto out;
-	}
 
 	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
-		err = erofs_map_blocks_flatmode(inode, map);
+		tailpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+		pos = erofs_pos(sb, erofs_iblks(inode) - tailpacking);
+
+		map->m_flags = EROFS_MAP_MAPPED;
+		if (map->m_la < pos) {
+			map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
+			map->m_llen = pos - map->m_la;
+		} else {
+			map->m_pa = erofs_iloc(inode) + vi->inode_isize +
+				vi->xattr_isize + erofs_blkoff(sb, map->m_la);
+			map->m_llen = inode->i_size - map->m_la;
+			map->m_flags |= EROFS_MAP_META;
+		}
 		goto out;
 	}
 
@@ -134,45 +115,41 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize +
 		    vi->xattr_isize, unit) + unit * chunknr;
 
-	kaddr = erofs_read_metabuf(&buf, sb, pos, true);
-	if (IS_ERR(kaddr)) {
-		err = PTR_ERR(kaddr);
+	idx = erofs_read_metabuf(&buf, sb, pos, true);
+	if (IS_ERR(idx)) {
+		err = PTR_ERR(idx);
 		goto out;
 	}
 	map->m_la = chunknr << vi->chunkbits;
-	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
-			round_up(inode->i_size - map->m_la, sb->s_blocksize));
-
-	/* handle block map */
-	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
-		__le32 *blkaddr = kaddr;
-
-		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
-			map->m_flags = 0;
-		} else {
-			map->m_pa = erofs_pos(sb, le32_to_cpu(*blkaddr));
+	map->m_llen = min_t(erofs_off_t, 1UL << vi->chunkbits,
+			    round_up(inode->i_size - map->m_la, blksz));
+	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
+		startblk = le32_to_cpu(idx->blkaddr);
+		if (startblk != EROFS_NULL_ADDR) {
+			map->m_deviceid = le16_to_cpu(idx->device_id) &
+				EROFS_SB(sb)->device_id_mask;
+			map->m_pa = erofs_pos(sb, startblk);
+			map->m_flags = EROFS_MAP_MAPPED;
+		}
+	} else {
+		startblk = le32_to_cpu(*(__le32 *)idx);
+		if (startblk != EROFS_NULL_ADDR) {
+			map->m_pa = erofs_pos(sb, startblk);
 			map->m_flags = EROFS_MAP_MAPPED;
 		}
-		goto out_unlock;
-	}
-	/* parse chunk indexes */
-	idx = kaddr;
-	switch (le32_to_cpu(idx->blkaddr)) {
-	case EROFS_NULL_ADDR:
-		map->m_flags = 0;
-		break;
-	default:
-		map->m_deviceid = le16_to_cpu(idx->device_id) &
-			EROFS_SB(sb)->device_id_mask;
-		map->m_pa = erofs_pos(sb, le32_to_cpu(idx->blkaddr));
-		map->m_flags = EROFS_MAP_MAPPED;
-		break;
 	}
-out_unlock:
 	erofs_put_metabuf(&buf);
 out:
-	if (!err)
-		map->m_llen = map->m_plen;
+	if (!err) {
+		map->m_plen = map->m_llen;
+		/* inline data should be located in the same meta block */
+		if ((map->m_flags & EROFS_MAP_META) &&
+		    erofs_blkoff(sb, map->m_pa) + map->m_plen > blksz) {
+			erofs_err(sb, "inline data across blocks @ nid %llu", vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+	}
 	trace_erofs_map_blocks_exit(inode, map, 0, err);
 	return err;
 }
-- 
2.43.5


