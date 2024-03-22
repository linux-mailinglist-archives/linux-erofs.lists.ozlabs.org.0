Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17E886881
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 09:50:31 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ihi6F2RH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V1GHn2Clnz3dxN
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 19:50:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ihi6F2RH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V1GHh38pSz3dX3
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Mar 2024 19:50:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711097417; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IdzWtUtvFRiblfXys9Gj3t+5I8xSMDSORN3idsVTE/c=;
	b=Ihi6F2RHecigEIQP1xi6rgDZ1jFV6vrWlvRkLKdYV3p1rXE1vw2Nf9laKmqFQ0Ts9TpVrGWpCJZOAjcXZlQgBPWVx8NSd8TPGBirzqVqIuPuuMahZqQijql7pzdU/rChoUs+iW34lKintyG8ZnKC3DfcFRsceFbtdRRAJ928Qgo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W31WL1E_1711097408;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W31WL1E_1711097408)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 16:50:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tar: all regular inodes should be zeroed in headerball mode
Date: Fri, 22 Mar 2024 16:50:07 +0800
Message-Id: <20240322085007.2592729-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

.. Instead of reporting IO errors which implies a corrupted image.

Fixes: 6894ca9623e7 ("erofs-utils: mkfs: Support tar source without data")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/blobchunk.h |  1 +
 lib/blobchunk.c           | 41 +++++++++++++++++++++++++++++++++++++++
 lib/tar.c                 |  6 ++++--
 mkfs/main.c               | 18 +++++++++--------
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 89c8048..a674640 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -19,6 +19,7 @@ struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff);
+int erofs_write_zero_inode(struct erofs_inode *inode);
 int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
 int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
 void erofs_blob_exit(void);
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 6d2501e..ee12194 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -338,6 +338,47 @@ err:
 	return ret;
 }
 
+int erofs_write_zero_inode(struct erofs_inode *inode)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int chunkbits = ilog2(inode->i_size - 1) + 1;
+	unsigned int count;
+	erofs_off_t chunksize, len, pos;
+	struct erofs_inode_chunk_index *idx;
+
+	if (chunkbits < sbi->blkszbits)
+		chunkbits = sbi->blkszbits;
+	if (chunkbits - sbi->blkszbits > EROFS_CHUNK_FORMAT_BLKBITS_MASK)
+		chunkbits = EROFS_CHUNK_FORMAT_BLKBITS_MASK + sbi->blkszbits;
+
+	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
+
+	chunksize = 1ULL << chunkbits;
+	count = DIV_ROUND_UP(inode->i_size, chunksize);
+
+	inode->extent_isize = count * EROFS_BLOCK_MAP_ENTRY_SIZE;
+	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
+	if (!idx)
+		return -ENOMEM;
+	inode->chunkindexes = idx;
+
+	for (pos = 0; pos < inode->i_size; pos += len) {
+		struct erofs_blobchunk *chunk;
+
+		len = min_t(erofs_off_t, inode->i_size - pos, chunksize);
+		chunk = erofs_get_unhashed_chunk(0, EROFS_NULL_ADDR, -1);
+		if (IS_ERR(chunk)) {
+			free(inode->chunkindexes);
+			inode->chunkindexes = NULL;
+			return PTR_ERR(chunk);
+		}
+
+		*(void **)idx++ = chunk;
+	}
+	inode->datalayout = EROFS_INODE_CHUNK_BASED;
+	return 0;
+}
+
 int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
diff --git a/lib/tar.c b/lib/tar.c
index fe7fdd3..7c271f6 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -645,7 +645,7 @@ static int tarerofs_write_file_index(struct erofs_inode *inode,
 	ret = tarerofs_write_chunkes(inode, data_offset);
 	if (ret)
 		return ret;
-	if (!tar->headeronly_mode && erofs_iostream_lskip(&tar->ios, inode->i_size))
+	if (erofs_iostream_lskip(&tar->ios, inode->i_size))
 		return -EIO;
 	return 0;
 }
@@ -1002,7 +1002,9 @@ new_inode:
 			inode->i_link = malloc(inode->i_size + 1);
 			memcpy(inode->i_link, eh.link, inode->i_size + 1);
 		} else if (inode->i_size) {
-			if (tar->index_mode)
+			if (tar->headeronly_mode)
+				ret = erofs_write_zero_inode(inode);
+			else if (tar->index_mode)
 				ret = tarerofs_write_file_index(inode, tar,
 								data_offset);
 			else
diff --git a/mkfs/main.c b/mkfs/main.c
index e9f0522..2fb4a57 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1260,12 +1260,14 @@ int main(int argc, char **argv)
 			return 1;
 	}
 
-	if ((erofstar.index_mode && !erofstar.mapfile) || cfg.c_blobdev_path)
+	if (((erofstar.index_mode && !erofstar.headeronly_mode) &&
+	    !erofstar.mapfile) || cfg.c_blobdev_path) {
 		err = erofs_mkfs_init_devices(&sbi, 1);
-	if (err) {
-		erofs_err("failed to generate device table: %s",
-			  erofs_strerror(err));
-		goto exit;
+		if (err) {
+			erofs_err("failed to generate device table: %s",
+				  erofs_strerror(err));
+			goto exit;
+		}
 	}
 
 	erofs_inode_manager_init();
@@ -1318,10 +1320,10 @@ int main(int argc, char **argv)
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
 
+	if (erofstar.index_mode && sbi.extra_devices && !erofstar.mapfile)
+		sbi.devs[0].blocks = BLK_ROUND_UP(&sbi, erofstar.offset);
+
 	if (erofstar.index_mode || cfg.c_chunkbits || sbi.extra_devices) {
-		if (erofstar.index_mode && !erofstar.mapfile)
-			sbi.devs[0].blocks =
-				BLK_ROUND_UP(&sbi, erofstar.offset);
 		err = erofs_mkfs_dump_blobs(&sbi);
 		if (err)
 			goto exit;
-- 
2.39.3

