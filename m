Return-Path: <linux-erofs+bounces-1970-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AEBD38E80
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jan 2026 13:28:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dtbbq2BwCz2xqG;
	Sat, 17 Jan 2026 23:28:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768652903;
	cv=none; b=RpkdH7awzCw4FXvBKoVreq4KgUL3lEuHVswS0ENnUME/SxkIgZJxLXaf57FnoOkETVKDFB7I0938D1ptfE2i3lEvspihas6lANgrlh/1jD3AlIuPiiW3kVMZwsd0UBUN8aXZ0BU1JqHpS8h3MjyyPr8aeZKxK1T+SrKl2VNcCLS9EmY61h5K1YBHNJBsNbPeEzSuFPJDKD/zllQU/m/ExO1bwogcRGYAzur+mtRzHdIDkWOVIfkLyr3ZN4Ov+wekvuIBQSUvPxGVBUQq0LZQ9en4vRJBxvKSQLWs1qOFJZj72bY5vLccBKLZ8nzKrNLgXVHpWqjhYrwrpQiuHvUUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768652903; c=relaxed/relaxed;
	bh=MJYvQF4Is/MSD78TZMTJj0PUkhhTELBkZHsDWFg7Yy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDBkIVEKClkkkyIYUL7pHAB6Dt4agaaJHxKmgHE6KVx9e5lLQLj4tcWaktJuPOPJTQmNIJKPkA6m6ZUlNJXdSLQVWMyQzt0/TlWOYhvSLN53VRekDQGgwk5hZ/BGVwXg9OlMo9NAtBCqF5PSiaO9EdpkAsPxMnovzA9sh0RTfO3TES9avfw0bYSRz0S69Xj7cM+W2iXB1KE8ybOpeBC2AIBLevSKZOAqjRQ8veMzelp8E2ebdf16o8bfMA/4Xg3tt4iSMuO2Ht+MxhBiZIFNGUB314/MuqH2+xdi/dNQ4SyM7Jxazs8oZbHZFhHHPrFxr3j/0OcOxBSVjznxBAQZYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k5VKp85i; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k5VKp85i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dtbbl2vG6z2xQC
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 23:28:17 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768652888; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MJYvQF4Is/MSD78TZMTJj0PUkhhTELBkZHsDWFg7Yy4=;
	b=k5VKp85iontc983sVajlJ1lKz6poWj2C+TB+AYJcIqz2LzItY17rx9ZfaamKXycNtvdQWyl8VKlCpElyt95Xpxxm3AY8tkdbuF3WzgnL263l5DJKSc51blhBpzksktCor/DxMmK/k81OlOSHhL84XHkBv/Vq29l11ufIjyC51Kc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxD6uj._1768652883 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 20:28:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3] erofs-utils: mkfs: enable directory data in the metadata zone
Date: Sat, 17 Jan 2026 20:28:02 +0800
Message-ID: <20260117122802.3794690-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260117010049.31207-1-xiang@kernel.org>
References: <20260117010049.31207-1-xiang@kernel.org>
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

It allows directory data and inode metadata to be kept as close
as possible, significantly improving metadata performance for
long-latency remote image use cases.

Usage:
 $ mkfs.erofs --MZ foo.erofs foo/

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3:
  - use correct vfile according to corresponding bufmgr in
    erofs_write_tail_end().

 include/erofs/importer.h |   1 +
 include/erofs/inode.h    |   3 +-
 include/erofs/internal.h |   8 +++
 lib/cache.c              |   4 ++
 lib/inode.c              | 114 ++++++++++++++++++++++++++++-----------
 lib/io.c                 |   5 +-
 lib/metabox.c            |  22 +++++---
 lib/remotes/s3.c         |   3 +-
 lib/super.c              |   4 +-
 lib/tar.c                |   2 +-
 mkfs/main.c              |  26 +++++++--
 11 files changed, 144 insertions(+), 48 deletions(-)

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index a525b474f1d5..60160d6bea05 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -46,6 +46,7 @@ struct erofs_importer_params {
 	bool no_datainline;
 	/* Issue directory data (except inline data) separately from regular inodes */
 	bool grouped_dirdata;
+	bool dirdata_in_metazone;
 	bool hard_dereference;
 	bool ovlfs_strip;
 	bool dot_omitted;
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 89bd16aecc06..ba62ece9a7cc 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -38,7 +38,8 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 int erofs_iflush(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
-int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks);
+int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks,
+				 bool in_metazone);
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d);
 int __erofs_fill_inode(struct erofs_importer *im, struct erofs_inode *inode,
 		       struct stat *st, const char *path);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 62594b877151..db6014bce62f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -156,6 +156,7 @@ struct erofs_sb_info {
 	struct erofs_buffer_head *bh_devt;
 	bool useqpl;
 	bool sb_valid;
+	u32 metazone_startblk;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
@@ -203,6 +204,8 @@ struct erofs_diskbuf;
 #define EROFS_INODE_DATA_SOURCE_DISKBUF		2
 #define EROFS_INODE_DATA_SOURCE_RESVSP		3
 
+#define EROFS_I_BLKADDR_DEV_ID_BIT		48
+
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
@@ -306,6 +309,11 @@ static inline bool erofs_inode_in_metabox(struct erofs_inode *inode)
 	return inode->nid >> EROFS_DIRENT_NID_METABOX_BIT;
 }
 
+static inline erofs_blk_t erofs_inode_dev_baddr(struct erofs_inode *inode)
+{
+	return inode->u.i_blkaddr & (BIT(EROFS_I_BLKADDR_DEV_ID_BIT) - 1);
+}
+
 static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
diff --git a/lib/cache.c b/lib/cache.c
index a87575ad74d1..f23dbb06264a 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -479,6 +479,10 @@ static int __erofs_bflush(struct erofs_bufmgr *bmgr,
 
 			/* flush and remove bh */
 			ret = bh->op->flush(bh);
+			if (__erofs_unlikely(ret == -EBUSY && !forget)) {
+				skip = true;
+				continue;
+			}
 			if (ret < 0)
 				return ret;
 		}
diff --git a/lib/inode.c b/lib/inode.c
index f447f99138c7..fc60fa23d665 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -193,9 +193,12 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 }
 
 /* allocate main data for an inode */
-int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
+int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks,
+				 bool in_metazone)
 {
-	struct erofs_bufmgr *bmgr = inode->sbi->bmgr;
+	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_bufmgr *bmgr = in_metazone ?
+		erofs_metadata_bmgr(sbi, false) : sbi->bmgr;
 	struct erofs_buffer_head *bh;
 	int ret, type;
 
@@ -205,9 +208,15 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 		return 0;
 	}
 
+	if (in_metazone && !bmgr) {
+		erofs_err("cannot allocate data in the metazone when unavailable for %s",
+			  inode->i_srcpath);
+		return -EINVAL;
+	}
+
 	/* allocate main data buffer */
 	type = S_ISDIR(inode->i_mode) ? DIRA : DATA;
-	bh = erofs_balloc(bmgr, type, erofs_pos(inode->sbi, nblocks), 0);
+	bh = erofs_balloc(bmgr, type, erofs_pos(sbi, nblocks), 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -219,7 +228,8 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 	DBG_BUGON(ret < 0);
 
 	/* write blocks except for the tail-end block */
-	inode->u.i_blkaddr = bh->block->blkaddr;
+	inode->u.i_blkaddr = bh->block->blkaddr | (in_metazone ?
+		(sbi->extra_devices + 1ULL) << EROFS_I_BLKADDR_DEV_ID_BIT : 0);
 	return 0;
 }
 
@@ -590,7 +600,7 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
-	ret = erofs_allocate_inode_bh_data(inode, nblocks);
+	ret = erofs_allocate_inode_bh_data(inode, nblocks, false);
 	if (ret)
 		return ret;
 
@@ -621,16 +631,17 @@ static bool erofs_file_is_compressible(struct erofs_importer *im,
 
 static int erofs_write_unencoded_data(struct erofs_inode *inode,
 				      struct erofs_vfile *vf, erofs_off_t fpos,
-				      bool noseek)
+				      bool noseek, bool in_metazone)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	erofs_blk_t nblocks, i;
+	struct erofs_bufmgr *bmgr;
+	erofs_off_t remaining, pos;
 	unsigned int len;
 	int ret;
 
 	if (!noseek && erofs_sb_has_48bit(sbi)) {
-		if (erofs_io_lseek(vf, fpos, SEEK_DATA) < 0 && errno == ENXIO) {
-			ret = erofs_allocate_inode_bh_data(inode, 0);
+		if (erofs_io_lseek(vf, fpos, SEEK_DATA) == -ENXIO) {
+			ret = erofs_allocate_inode_bh_data(inode, 0, false);
 			if (ret)
 				return ret;
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
@@ -639,27 +650,31 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 		ret = erofs_io_lseek(vf, fpos, SEEK_SET);
 		if (ret < 0)
 			return ret;
-		else if (ret != fpos)
+		if (ret != fpos)
 			return -EIO;
 	}
 
-	nblocks = inode->i_size >> sbi->blkszbits;
-	ret = erofs_allocate_inode_bh_data(inode, nblocks);
+	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
+	remaining = inode->i_size - inode->idata_size;
+
+	ret = erofs_allocate_inode_bh_data(inode, remaining >> sbi->blkszbits,
+					   in_metazone);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nblocks; i += (len >> sbi->blkszbits)) {
+	bmgr = in_metazone ? erofs_metadata_bmgr(sbi, false) : sbi->bmgr;
+	pos = erofs_pos(sbi, erofs_inode_dev_baddr(inode));
+	while (remaining) {
 		len = min_t(u64, round_down(UINT_MAX, 1U << sbi->blkszbits),
-			    erofs_pos(sbi, nblocks - i));
-		ret = erofs_io_xcopy(&sbi->bdev,
-				     erofs_pos(sbi, inode->u.i_blkaddr + i),
-				     vf, len, noseek);
+			    remaining);
+		ret = erofs_io_xcopy(bmgr->vf, pos, vf, len, noseek);
 		if (ret)
 			return ret;
+		pos += len;
+		remaining -= len;
 	}
 
 	/* read the tail-end data */
-	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
 		if (!inode->idata)
@@ -690,10 +705,11 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 	/* fallback to all data uncompressed */
 	return erofs_write_unencoded_data(inode,
 			&(struct erofs_vfile){ .fd = fd }, fpos,
-			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
+			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF, false);
 }
 
-static int erofs_write_dir_file(struct erofs_inode *dir)
+static int erofs_write_dir_file(const struct erofs_importer *im,
+				struct erofs_inode *dir)
 {
 	unsigned int bsz = erofs_blksiz(dir->sbi);
 	struct erofs_vfile *vf;
@@ -707,12 +723,44 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 		err = erofs_write_compress_dir(dir, vf);
 	} else {
 		DBG_BUGON(dir->idata_size != (dir->i_size & (bsz - 1)));
-		err = erofs_write_unencoded_data(dir, vf, 0, true);
+		err = erofs_write_unencoded_data(dir, vf, 0, true,
+					im->params->dirdata_in_metazone);
 	}
 	erofs_io_close(vf);
 	return err;
 }
 
+static int erofs_inode_map_flat_blkaddr(struct erofs_inode *inode)
+{
+	const struct erofs_sb_info *sbi = inode->sbi;
+	erofs_blk_t dev_startblk;
+	int dev_id;
+
+	if (inode->u.i_blkaddr == EROFS_NULL_ADDR)
+		return 0;
+
+	dev_id = inode->u.i_blkaddr >> EROFS_I_BLKADDR_DEV_ID_BIT;
+	if (!dev_id)
+		return 0;
+
+	if (dev_id <= sbi->extra_devices) {
+		if (!sbi->devs[dev_id - 1].uniaddr) {
+			DBG_BUGON(1);	/* impossible now */
+			return -EBUSY;
+		}
+		dev_startblk = sbi->devs[dev_id - 1].uniaddr;
+	} else {
+		if (sbi->metazone_startblk == EROFS_META_NEW_ADDR) {
+			DBG_BUGON(1);	/* impossible now */
+			return -EBUSY;
+		}
+		DBG_BUGON(dev_id != sbi->extra_devices + 1);
+		dev_startblk = sbi->metazone_startblk;
+	}
+	inode->u.i_blkaddr = erofs_inode_dev_baddr(inode) + dev_startblk;
+	return 0;
+}
+
 int erofs_iflush(struct erofs_inode *inode)
 {
 	u16 icount = EROFS_INODE_XATTR_ICOUNT(inode->xattr_isize);
@@ -734,16 +782,19 @@ int erofs_iflush(struct erofs_inode *inode)
 	int ret, fmt;
 
 	DBG_BUGON(bh && erofs_btell(bh, false) != off);
-
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
-	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		u1.rdev = cpu_to_le32(inode->u.i_rdev);
-	else if (is_inode_layout_compression(inode))
+	} else if (is_inode_layout_compression(inode)) {
 		u1.blocks_lo = cpu_to_le32(inode->u.i_blocks);
-	else if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
+	} else if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
 		u1.c.format = cpu_to_le16(inode->u.chunkformat);
-	else
+	} else {
+		ret = erofs_inode_map_flat_blkaddr(inode);
+		if (ret)
+			return ret;
 		u1.startblk_lo = cpu_to_le32(inode->u.i_blkaddr);
+	}
 
 	if (is_inode_layout_compression(inode) &&
 	    inode->u.i_blocks > UINT32_MAX) {
@@ -893,7 +944,7 @@ static bool erofs_inode_need_48bit(struct erofs_inode *inode)
 			return true;
 	} else if (!is_inode_layout_compression(inode)) {
 		if (inode->u.i_blkaddr != EROFS_NULL_ADDR &&
-		    inode->u.i_blkaddr > UINT32_MAX)
+		    erofs_inode_dev_baddr(inode) > UINT32_MAX)
 			return true;
 	}
 	return false;
@@ -1038,6 +1089,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		ibh->fsprivate = erofs_igrab(inode);
 		ibh->op = &erofs_write_inline_bhops;
 	} else {
+		struct erofs_bufmgr *bmgr;
 		struct iovec iov[2];
 		erofs_off_t pos;
 		int ret;
@@ -1068,6 +1120,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 			ret = erofs_mapbh(NULL, bh->block);
 		}
 		DBG_BUGON(ret < 0);
+		bmgr = (struct erofs_bufmgr *)bh->block->buffers.fsprivate;
 		pos = erofs_btell(bh, true) - erofs_blksiz(sbi);
 
 		/* 0'ed data should be padded at head for 0padding conversion */
@@ -1078,7 +1131,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 					   .iov_len = inode->idata_size };
 		iov[!h0] = (struct iovec) { .iov_base = (u8 *)zeroed,
 				erofs_blksiz(sbi) - inode->idata_size };
-		ret = erofs_io_pwritev(&sbi->bdev, iov, 2, pos);
+		ret = erofs_io_pwritev(bmgr->vf, iov, 2, pos);
 		if (ret < 0)
 			return ret;
 		else if (ret < erofs_blksiz(sbi))
@@ -1563,7 +1616,7 @@ static int erofs_mkfs_jobfn(const struct erofs_mkfs_btctx *ctx,
 		return erofs_mkfs_create_directory(ctx, inode);
 
 	if (item->type == EROFS_MKFS_JOB_DIR_BH) {
-		ret = erofs_write_dir_file(inode);
+		ret = erofs_write_dir_file(ctx->im, inode);
 		if (ret)
 			return ret;
 		erofs_write_tail_end(inode);
@@ -2273,7 +2326,8 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	ret = erofs_write_unencoded_data(inode,
 			&(struct erofs_vfile){ .fd = fd }, 0,
-			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
+			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF,
+			false);
 	if (ret)
 		return ERR_PTR(ret);
 out:
diff --git a/lib/io.c b/lib/io.c
index 37a74f63c45e..0c5eb2c29989 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -571,10 +571,13 @@ ssize_t erofs_io_write(struct erofs_vfile *vf, void *buf, size_t len)
 
 off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
 {
+	off_t ret;
+
 	if (vf->ops)
 		return vf->ops->lseek(vf, offset, whence);
 
-	return lseek(vf->fd, offset, whence);
+	ret = lseek(vf->fd, offset, whence);
+	return ret < 0 ? -errno : ret;
 }
 
 ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
diff --git a/lib/metabox.c b/lib/metabox.c
index 37267ddb73cf..d6abd5123cc8 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -54,7 +54,7 @@ int erofs_metadata_init(struct erofs_sb_info *sbi)
 	struct erofs_metamgr *m2gr;
 	int ret;
 
-	if (!sbi->m2gr && sbi->meta_blkaddr == EROFS_META_NEW_ADDR) {
+	if (!sbi->m2gr && sbi->metazone_startblk == EROFS_META_NEW_ADDR) {
 		m2gr = malloc(sizeof(*m2gr));
 		if (!m2gr)
 			return -ENOMEM;
@@ -62,6 +62,8 @@ int erofs_metadata_init(struct erofs_sb_info *sbi)
 		if (ret)
 			goto err_free;
 		sbi->m2gr = m2gr;
+		/* FIXME: sbi->meta_blkaddr should be 0 for 48-bit layouts */
+		sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
 	}
 
 	if (!sbi->mxgr && erofs_sb_has_metabox(sbi)) {
@@ -124,20 +126,24 @@ int erofs_metazone_flush(struct erofs_sb_info *sbi)
 
 	if (!m2gr)
 		return 0;
-	m2bgr = m2gr->bmgr;
+	bh = erofs_balloc(sbi->bmgr, DATA, 0, 0);
+	if (!bh)
+		return PTR_ERR(bh);
+	erofs_mapbh(NULL, bh->block);
+	pos_out = erofs_btell(bh, false);
+	meta_blkaddr = pos_out >> sbi->blkszbits;
+	sbi->metazone_startblk = meta_blkaddr;
 
+	m2bgr = m2gr->bmgr;
 	ret = erofs_bflush(m2bgr, NULL);
 	if (ret)
 		return ret;
 
 	length = erofs_mapbh(m2bgr, NULL) << sbi->blkszbits;
-	bh = erofs_balloc(sbi->bmgr, DATA, length, 0);
-	if (!bh)
-		return PTR_ERR(bh);
+	ret = erofs_bh_balloon(bh, length);
+	if (ret < 0)
+		return ret;
 
-	erofs_mapbh(NULL, bh->block);
-	pos_out = erofs_btell(bh, false);
-	meta_blkaddr = pos_out >> sbi->blkszbits;
 	do {
 		count = min_t(erofs_off_t, length, INT_MAX);
 		ret = erofs_io_xcopy(sbi->bmgr->vf, pos_out,
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 223c3e89d6fd..b0ca84b51afc 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -1032,7 +1032,8 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 		inode->idata_size = 0;
 		ret = erofs_allocate_inode_bh_data(inode,
-				DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits));
+				DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits),
+				false);
 		if (ret)
 			return ret;
 		resp.vf = &sbi->bdev;
diff --git a/lib/super.c b/lib/super.c
index e54aff2d4ab7..a203f96e6996 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -436,9 +436,9 @@ int erofs_mkfs_format_fs(struct erofs_sb_info *sbi, unsigned int blkszbits,
 	sbi->bmgr = bmgr;
 	bmgr->dsunit = dsunit;
 	if (metazone)
-		sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
+		sbi->metazone_startblk = EROFS_META_NEW_ADDR;
 	else
-		sbi->meta_blkaddr = 0;
+		sbi->metazone_startblk = 0;
 	bh = erofs_reserve_sb(bmgr);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
diff --git a/lib/tar.c b/lib/tar.c
index d5095169f9ba..1f3092566bd9 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -632,7 +632,7 @@ static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	nblocks = DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits);
 
-	ret = erofs_allocate_inode_bh_data(inode, nblocks);
+	ret = erofs_allocate_inode_bh_data(inode, nblocks, false);
 	if (ret)
 		return ret;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index e29eb99cca08..70d08b5a8fd3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -101,7 +101,7 @@ static struct option long_options[] = {
 	{"oci", optional_argument, NULL, 534},
 #endif
 	{"zD", optional_argument, NULL, 536},
-	{"ZI", optional_argument, NULL, 537},
+	{"MZ", optional_argument, NULL, 537},
 	{0, 0, 0, 0},
 };
 
@@ -177,7 +177,7 @@ static void usage(int argc, char **argv)
 		"    --mkfs-time        the timestamp is applied as build time only\n"
 		" -UX                   use a given filesystem UUID\n"
 		" --zD[=<0|1>]          specify directory compression: 0=disable [default], 1=enable\n"
-		" --ZI[=<0|1>]          specify the separate inode metadata zone availability: 0=disable [default], 1=enable\n"
+		" --MZ[=<0|[id]>]       put inode metadata ('i') and/or directory data ('d') into the separate metadata zone.\n"
 		" --all-root            make all files owned by root\n"
 #ifdef EROFS_MT_ENABLED
 		" --async-queue-limit=# specify the maximum number of entries in the multi-threaded job queue\n"
@@ -1419,10 +1419,28 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			}
 			break;
 		case 537:
-			if (!optarg || strcmp(optarg, "1"))
+			if (!optarg) {
 				mkfscfg.inode_metazone = true;
-			else
+				params->dirdata_in_metazone = true;
+			} else if (!strcmp(optarg, "0")) {
 				mkfscfg.inode_metazone = false;
+				params->dirdata_in_metazone = false;
+			} else {
+				for (i = 0; optarg[i]; ++i) {
+					if (optarg[i] == 'i') {
+						mkfscfg.inode_metazone = true;
+					} else if (optarg[i] == 'd') {
+						params->dirdata_in_metazone = true;
+					} else {
+						erofs_err("invalid metazone flags `%s`", optarg);
+						return -EINVAL;
+					}
+				}
+				if (params->dirdata_in_metazone && !mkfscfg.inode_metazone) {
+					erofs_err("inode metadata must be in the metadata zone if directory data is stored there");
+					return -EINVAL;
+				}
+			}
 			break;
 		case 'V':
 			version();
-- 
2.43.5


