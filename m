Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 699E68A929D
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 07:52:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=r3G9is/b;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKn4J14mwz3cRJ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 15:52:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=r3G9is/b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKn496zHZz3c1L
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 15:52:41 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1157599a12.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713419559; x=1714024359; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SNbchehS9V71OFSJUo8wSiL4/cAyChuKhgxDef/zWA=;
        b=r3G9is/b2uMCAERCzLfEo7DI+wrzfVvWunb39stq+rC6y50FxGh+1uBXNAytUNNheQ
         eH4Slg1eGdO0XAtCtvYgmQO4gzfqALdJ4OYZVF2Rw/wHjf95kTbKeCnGI4HXb+1mbka4
         x64lK7ptz8qevugiqk59OT4XnaoBnVHeET294roIMmGmLCi7jlbK+k1hvfiBRLRLxub8
         K5FBIHDNKvSZWigGHru4i3S7v3T7oOyNrMI6pkUprARhE+ObojNZd3agmzrACHykALWw
         F9adyCuM1rfMgkysasOJ62pLXqYCMoKzG5ZpNJkKq2Kjj/qG4/TnLEWbjtAzij8K9c9p
         dDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713419559; x=1714024359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SNbchehS9V71OFSJUo8wSiL4/cAyChuKhgxDef/zWA=;
        b=dN6amK6dQroya6LWkZrHp5Mv7udwjV3xuTSdaO8yA+gN3Vd4uwn+RVAaK+NGSvri6/
         WG5sScXoTPOOgstbWd1YOo2FEScfKMiOKkTyB7TFU0QV0mM9qTCcpKczYypDRevz8mcm
         YqSKI9GHhN8tkgkBuDyPaFv/yy2sc6L4YjqZISw0K/eNOybgulF8aT8szETD6h8HvlIN
         Z+FT8ywJQlfvo05aBMbYbK8gUzeyZ2dL8pCF+YVTB+Zt31LjLoZx4pB4CNZI+axPvFFS
         IR+ZIvdJZCiknNFzNpL5CfHLL6yPPxOTERmwvwOfuq9tSzHA8VVYutCEQ3hhhahtTyTo
         6qQw==
X-Gm-Message-State: AOJu0Ywx/bcu4YeJmsOycmdUpz3aHh4Qn1hLuhi9nEdbUGRl/ticwJy1
	9GsQjoV6r280JMTbuuQUMpKJv/VFHQRC8FSIiGDnxmkavGM6u6bPkTrM79iQw8INwPPED2Zh1Lv
	mQaQ=
X-Google-Smtp-Source: AGHT+IGUgcFBL/iSmEPn9IrdCdKA9nRyr2Nhnj4UDymocJRqbigUAHirUbMMeRqNkXf33kxBRAzsiQ==
X-Received: by 2002:a17:90a:530e:b0:2a2:d05c:95f6 with SMTP id x14-20020a17090a530e00b002a2d05c95f6mr2150234pjh.7.1713419559541;
        Wed, 17 Apr 2024 22:52:39 -0700 (PDT)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b001e4ea358407sm642991plg.46.2024.04.17.22.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:52:39 -0700 (PDT)
From: Noboru Asai <asai@sijam.com>
To: hsiangkao@linux.alibaba.com,
	zhaoyifan@sjtu.edu.cn
Subject: [PATCH 1/3] erofs-utils: determine the [un]compressed data block is inline or not early
Date: Thu, 18 Apr 2024 14:52:29 +0900
Message-ID: <20240418055231.146591-1-asai@sijam.com>
X-Mailer: git-send-email 2.44.0
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introducing erofs_get_inodesize function and erofs_get_lowest_offset function,
we can determine the [un]compressed data block is inline or not before
executing z_erofs_merge_segment function. It enable the following,

* skip the redundant write for ztailpacking block.
* simplify erofs_prepare_inode_buffer function. (remove handling ENOSPC error)

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 include/erofs/inode.h |   2 +
 lib/compress.c        |  11 +++--
 lib/inode.c           | 112 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 116 insertions(+), 9 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index d5a732a..fb93b81 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -40,6 +40,8 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 struct erofs_inode *erofs_new_inode(void);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
+unsigned int erofs_get_inodesize(struct erofs_inode *inode);
+unsigned int erofs_get_lowest_offset(struct erofs_inode *inode);
 
 #ifdef __cplusplus
 }
diff --git a/lib/compress.c b/lib/compress.c
index 74c5707..dfe59da 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -20,6 +20,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/fragments.h"
+#include "erofs/inode.h"
 #ifdef EROFS_MT_ENABLED
 #include "erofs/workqueue.h"
 #endif
@@ -530,7 +531,8 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 			e->length = len;
 			goto frag_packing;
 		}
-		if (!may_inline && len <= blksz)
+		if ((!may_inline && len <= blksz) ||
+		    (may_inline && erofs_get_lowest_offset(inode) + len > blksz))
 			goto nocompression;
 	}
 
@@ -550,7 +552,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 
 	/* check if there is enough gain to keep the compressed data */
 	if (ret * h->compress_threshold / 100 >= e->length) {
-		if (may_inline && len < blksz) {
+		if (may_inline && (erofs_get_lowest_offset(inode) + len < blksz)) {
 			ret = z_erofs_fill_inline_data(inode,
 					ctx->queue + ctx->head, len, true);
 		} else {
@@ -584,7 +586,8 @@ frag_packing:
 		e->raw = false;
 		ictx->fragemitted = true;
 	/* tailpcluster should be less than 1 block */
-	} else if (may_inline && len == e->length && compressedsize < blksz) {
+	} else if (may_inline && len == e->length &&
+		   (erofs_get_lowest_offset(inode) + compressedsize < blksz)) {
 		if (ctx->clusterofs + len <= blksz) {
 			inode->eof_tailraw = malloc(len);
 			if (!inode->eof_tailraw)
@@ -621,7 +624,7 @@ frag_packing:
 					&e->length, dst, &compressedsize);
 
 		e->compressedblks = BLK_ROUND_UP(sbi, compressedsize);
-		DBG_BUGON(e->compressedblks * blksz >= e->length);
+		DBG_BUGON(!may_inline && e->compressedblks * blksz >= e->length);
 
 		padding = 0;
 		tailused = compressedsize & (blksz - 1);
diff --git a/lib/inode.c b/lib/inode.c
index 7508c74..45d2fbc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -440,6 +440,11 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / erofs_blksiz(sbi);
+	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
+	if (erofs_get_inodesize(inode) + inode->idata_size > erofs_blksiz(sbi)) {
+		nblocks += 1;
+		inode->idata_size = 0;
+	}
 
 	ret = __allocate_inode_bh_data(inode, nblocks, DATA);
 	if (ret)
@@ -452,7 +457,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 		if (ret != erofs_blksiz(sbi)) {
 			if (ret < 0)
 				return -errno;
-			return -EAGAIN;
+			memset(buf + ret, 0, erofs_blksiz(sbi) - ret);
 		}
 
 		ret = blk_write(sbi, buf, inode->u.i_blkaddr + i, 1);
@@ -461,7 +466,6 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	}
 
 	/* read the tail-end data */
-	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
 		if (!inode->idata)
@@ -667,6 +671,104 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	return 0;
 }
 
+static unsigned int erofs_get_compacted_extent_isize(struct erofs_inode *inode)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	const unsigned int mpos = roundup(inode->inode_isize +
+					  inode->xattr_isize, 8) +
+				  sizeof(struct z_erofs_map_header);
+	const unsigned int totalidx = BLK_ROUND_UP(sbi, inode->i_size);
+	/* # of 8-byte units so that it can be aligned with 32 bytes */
+	unsigned int compacted_4b_initial, compacted_4b_end;
+	unsigned int compacted_2b;
+	unsigned int extent_isize = 0;
+
+	if (inode->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
+		compacted_4b_initial = (32 - mpos % 32) / 4;
+		if (compacted_4b_initial == 32 / 4)
+			compacted_4b_initial = 0;
+
+		if (compacted_4b_initial > totalidx) {
+			compacted_4b_initial = compacted_2b = 0;
+			compacted_4b_end = totalidx;
+		} else {
+			compacted_2b = rounddown(totalidx -
+						 compacted_4b_initial, 16);
+			compacted_4b_end = totalidx - compacted_4b_initial -
+					   compacted_2b;
+		}
+	} else {
+		compacted_2b = compacted_4b_initial = 0;
+		compacted_4b_end = totalidx;
+	}
+
+	extent_isize += sizeof(struct z_erofs_map_header);
+
+	/* generate compacted_4b_initial */
+	while (compacted_4b_initial) {
+		extent_isize += 4 * 2;
+		compacted_4b_initial -= 2;
+	}
+	DBG_BUGON(compacted_4b_initial);
+
+	/* generate compacted_2b */
+	while (compacted_2b) {
+		extent_isize += 2 * 16;
+		compacted_2b -= 16;
+	}
+	DBG_BUGON(compacted_2b);
+
+	/* generate compacted_4b_end */
+	while (compacted_4b_end > 1) {
+		extent_isize += 4 * 2;
+		compacted_4b_end -= 2;
+	}
+
+	/* generate final compacted_4b_end if needed */
+	if (compacted_4b_end) {
+		extent_isize += 4 * 2;
+	}
+	return extent_isize;
+}
+
+/* datalayout may change in z_erofs_compress_dedupe function,
+ * so use carefully.
+ */
+unsigned int erofs_get_inodesize(struct erofs_inode *inode)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int inodesize;
+
+	inodesize = inode->inode_isize + inode->xattr_isize;
+
+	if (inode->extent_isize)
+		return roundup(inodesize, 8) + inode->extent_isize;
+
+	switch (inode->datalayout) {
+	case EROFS_INODE_COMPRESSED_FULL:
+		inodesize = roundup(inodesize, 8);
+		inodesize += BLK_ROUND_UP(sbi, inode->i_size) *
+			sizeof(struct z_erofs_lcluster_index) +
+			Z_EROFS_FULL_INDEX_ALIGN(0); /* Z_EROFS_LEGACY_MAP_HEADER_SIZE */
+		break;
+	case EROFS_INODE_COMPRESSED_COMPACT:
+		inodesize = roundup(inodesize, 8);
+		inodesize += erofs_get_compacted_extent_isize(inode);
+		break;
+	default:
+	}
+
+	return inodesize;
+}
+
+unsigned int erofs_get_lowest_offset(struct erofs_inode *inode)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int blksz = erofs_blksiz(sbi);
+
+	return erofs_get_inodesize(inode) & (blksz - 1);
+}
+
 static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 {
 	unsigned int inodesize;
@@ -674,9 +776,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	DBG_BUGON(inode->bh || inode->bh_inline);
 
-	inodesize = inode->inode_isize + inode->xattr_isize;
-	if (inode->extent_isize)
-		inodesize = roundup(inodesize, 8) + inode->extent_isize;
+	inodesize = erofs_get_inodesize(inode);
 
 	/* TODO: tailpacking inline of chunk-based format isn't finalized */
 	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
@@ -699,6 +799,8 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
+		BUG_ON(1);
+
 		if (is_inode_layout_compression(inode))
 			z_erofs_drop_inline_pcluster(inode);
 		else
-- 
2.44.0

