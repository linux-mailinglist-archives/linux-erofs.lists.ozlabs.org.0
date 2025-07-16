Return-Path: <linux-erofs+bounces-636-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3BB07B1B
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 18:25:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bj1cB1Bq9z30Vb;
	Thu, 17 Jul 2025 02:24:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752683098;
	cv=none; b=S/5Ilo2ti3n2MEV5Jb+DcX5MsY8dQQzlXG2k1VjFHmCCTDBmNTTb1cHUNC0xfb04JnjLkoU+BejUAlCM/2aAbXTm2UJApBd9NghxGi+QtmWLbkHUXLzAiqlIc6lH5I+47EBUvhOuyMHHZcHZZPDRLlQ0OZRTcmu6DH9SU9HJU5sOjA/hKTmJ0M//UCiWArpRnwR0XagglvNRMY4dEtMQiHBj4g3YlIEUBAjC5TrvzH1sRwPe2mukUwVC/rHSMQIKHlHlgYZ/jhoPyORivabA4lGdUDIUfrdavCTeFOllrqrrg6sJCaxDA87qThKOnh3Cn5UHwF9sTmyHx9TlvVnN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752683098; c=relaxed/relaxed;
	bh=as/gZsVCWgs98YhpEWbt3n4Uo7CsDkbGMN9R+qWs1Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNCrAiTW/VMCDF0ToS2gNUCmr9E0tKZPE1+hVN38U85vlS7pFUhegudErA4bCOU+uJavhfr5TGk0VaTxWjyF+e0C0jHjXwX0+SxP1YtVzdI9zlsmeD8mL3otc/vE8Iui+NlWD195KBTl7wFkQSwQfFWBPxw2zTMFi5tssjbT+sldj7jys/7AU1EYBDA7fkrcwClG3m9bqjRMVpcDIRK44ZLAHe1RC1t8fWOGR/CIMOUifylMN+AZ3HNDliR+UPrD+ou7AN2GcMn0EVZjLzSLveyNltldp5Td2A9yyyVDPPJJ21l3uQQ28OENOkdLrnFr9GlBLeR9KgMm82aAXEfp+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QpO9oiDY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QpO9oiDY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bj1c75zVMz30FR
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 02:24:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752683091; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=as/gZsVCWgs98YhpEWbt3n4Uo7CsDkbGMN9R+qWs1Tg=;
	b=QpO9oiDY+RYj/Yjxj/Ij+m+WQivj9gjjOj4DWKHkYTggIBr/PqqvfB30XNW4rW3caVF6l2G4GhyGqCfHT2iDuE2M4U1BWGf5QSvN6tnQx4GXNf50cOJuJsuYLo5sHOyltLRdtshiNdUc5EdQgGrrhs2yrMmEUwtr4MHslHgmzjg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj5JWuV_1752683088 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 00:24:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: lib: consolidate erofs_iflush()
Date: Thu, 17 Jul 2025 00:24:40 +0800
Message-ID: <20250716162441.209783-2-hsiangkao@linux.alibaba.com>
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

.. Avoid erofs_dev_write() and use the bdev virtual file instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  3 +-
 lib/blobchunk.c          |  6 ++--
 lib/inode.c              | 67 +++++++++++++++++++---------------------
 lib/super.c              |  1 -
 4 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b5df8a48..65d40840 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -95,7 +95,6 @@ struct erofs_sb_info {
 	u32 feature_compat;
 	u32 feature_incompat;
 
-	unsigned char islotbits;
 	unsigned char blkszbits;
 
 	u32 sb_size;			/* total superblock size */
@@ -293,7 +292,7 @@ static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
 	struct erofs_sb_info *sbi = inode->sbi;
 
 	return erofs_pos(sbi, sbi->meta_blkaddr) +
-			(inode->nid << sbi->islotbits);
+			(inode->nid << EROFS_ISLOTBITS);
 }
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 3388ce0d..bbc69cfb 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -193,7 +193,6 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		else
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
-	off = roundup(off, unit);
 	if (extent_start != EROFS_NULL_ADDR) {
 		extent_end = min(extent_end, extent_start + remaining_blks);
 		zeroedlen = inode->i_size & (erofs_blksiz(sbi) - 1);
@@ -202,8 +201,9 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		tarerofs_blocklist_write(extent_start, extent_end - extent_start,
 					 source_offset, zeroedlen);
 	}
-	return erofs_dev_write(inode->sbi, inode->chunkindexes, off,
-			       inode->extent_isize);
+	off = roundup(off, unit);
+	return erofs_io_pwrite(&sbi->bdev, inode->chunkindexes,
+			       off, inode->extent_isize);
 }
 
 int erofs_blob_mergechunks(struct erofs_inode *inode, unsigned int chunkbits,
diff --git a/lib/inode.c b/lib/inode.c
index 4f6715af..f7c6b87f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -609,22 +609,23 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 
 int erofs_iflush(struct erofs_inode *inode)
 {
-	const u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
+	u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
 	struct erofs_sb_info *sbi = inode->sbi;
-	erofs_off_t off;
+	struct erofs_buffer_head *bh = inode->bh;
+	erofs_off_t off = erofs_iloc(inode);
 	union {
 		struct erofs_inode_compact dic;
 		struct erofs_inode_extended die;
 	} u = {};
 	union erofs_inode_i_u u1;
 	union erofs_inode_i_nb nb;
+	unsigned int iovcnt = 0;
+	struct iovec iov[2];
+	char *xattrs = NULL;
 	bool nlink_1 = true;
 	int ret, fmt;
 
-	if (inode->bh)
-		off = erofs_btell(inode->bh, false);
-	else
-		off = erofs_iloc(inode);
+	DBG_BUGON(bh && erofs_btell(bh, false) != off);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
@@ -702,41 +703,41 @@ int erofs_iflush(struct erofs_inode *inode)
 	default:
 		erofs_err("unsupported on-disk inode version of nid %llu",
 			  (unsigned long long)inode->nid);
-		BUG_ON(1);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
 	}
 
-	ret = erofs_dev_write(sbi, &u, off, inode->inode_isize);
-	if (ret)
-		return ret;
-	off += inode->inode_isize;
-
+	iov[iovcnt++] = (struct iovec){ .iov_base = &u,
+					.iov_len = inode->inode_isize };
 	if (inode->xattr_isize) {
-		char *xattrs = erofs_export_xattr_ibody(inode);
-
+		xattrs = erofs_export_xattr_ibody(inode);
 		if (IS_ERR(xattrs))
 			return PTR_ERR(xattrs);
-
-		ret = erofs_dev_write(sbi, xattrs, off, inode->xattr_isize);
-		free(xattrs);
-		if (ret)
-			return ret;
-
-		off += inode->xattr_isize;
+		iov[iovcnt++] = (struct iovec){ .iov_base = xattrs,
+						.iov_len = inode->xattr_isize };
 	}
 
+	ret = erofs_io_pwritev(&sbi->bdev, iov, iovcnt, off);
+	free(xattrs);
+	if (ret != inode->inode_isize + inode->xattr_isize)
+		return ret < 0 ? ret : -EIO;
+
+	off += ret;
 	if (inode->extent_isize) {
 		if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
 			ret = erofs_blob_write_chunk_indexes(inode, off);
-			if (ret)
-				return ret;
-		} else {
-			/* write compression metadata */
+		} else {	/* write compression metadata */
 			off = roundup(off, 8);
-			ret = erofs_dev_write(sbi, inode->compressmeta, off,
-					      inode->extent_isize);
-			if (ret)
-				return ret;
+			ret = erofs_io_pwrite(&sbi->bdev, inode->compressmeta,
+					      off, inode->extent_isize);
 		}
+		if (ret != inode->extent_isize)
+			return ret < 0 ? ret : -EIO;
+	}
+	if (bh) {
+		inode->bh = NULL;
+		erofs_iput(inode);
+		return erofs_bh_flush_generic_end(bh);
 	}
 	return 0;
 }
@@ -744,15 +745,9 @@ int erofs_iflush(struct erofs_inode *inode)
 static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *inode = bh->fsprivate;
-	int ret;
 
 	DBG_BUGON(inode->bh != bh);
-	ret = erofs_iflush(inode);
-	if (ret)
-		return ret;
-	inode->bh = NULL;
-	erofs_iput(inode);
-	return erofs_bh_flush_generic_end(bh);
+	return erofs_iflush(inode);
 }
 
 static struct erofs_bhops erofs_write_inode_bhops = {
diff --git a/lib/super.c b/lib/super.c
index 0533a7c8..e5364d27 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -114,7 +114,6 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
-	sbi->islotbits = EROFS_ISLOTBITS;
 	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
 		sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
 		sbi->primarydevice_blocks = (sbi->primarydevice_blocks << 32) |
-- 
2.43.5


