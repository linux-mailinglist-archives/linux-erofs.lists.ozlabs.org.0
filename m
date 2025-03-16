Return-Path: <linux-erofs+bounces-68-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E88A63376
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 04:37:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFkLK5Fdtz2ydQ;
	Sun, 16 Mar 2025 14:36:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742096217;
	cv=none; b=ZCrW6xG+JTduLK9JZB6/B0rSHc5rHbR96/zLFXnYatMM7W7G4wO31/XjbvY9OmrfTkv2HRGeb2emqowxWARMSv9YWCw4AMtoAPQ1njDSd++LUnT7Ss2+ic9MWyTfNWZPk1eRv7oELX8E1hAAzTYYPmAuuWMxtz6aZQ9tFkF9U0/bcE7QD/CqEH0QYo/zRZ0AxDCEC3Smpmebb3cG1YdBJ0ewkd9DvPxBUTNmYetfEOmHf+Nd/M3mWtpKeAl8VCxjk5jJHnq93QpQ+tfSoAfiY0uZN5apl3/XarCIF8qPkIXWPN2Ws7C6TqLRHQ3dyTEaZA4ln6zySzSFV0C1WqcWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742096217; c=relaxed/relaxed;
	bh=l1y/pUZQVbEWUsHAsdEvagDLD6EYa66YNzgnq3r16Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQITZkWdU4Ivd/KExcarWzfl3yx5WPVk6Fha7PqL6vEVvLX4O4bLrI/SwiRLm9vXToDCG0LWvuS+rjp0OTwdSTDN8SsCBxjRRrp2Pszjfq2KoK7Zw4qPd0aEZ4uITQhtRXjVMEFp2wJiT0UDTUijd1IJCBZEH8fRwHFrN/SGz7d8l1rTteETnoODvFb9VoOUCucex0AtG0MbLcX3qj6vvO29yO4M5LDhoujKqVyzsz8kFm0MVgFLOSG5JmxfC2AxEs+HEUtpjGBD8ldN8FsB/YkkTuk1W/huYtgfWudMqRR8Lmul/R98eT+kIa8ZZ8UtV0CHD64ErVL1r3Js9pK1cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EvsbBnbo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EvsbBnbo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFkLF3mQYz2yds
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 14:36:53 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742096209; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=l1y/pUZQVbEWUsHAsdEvagDLD6EYa66YNzgnq3r16Dc=;
	b=EvsbBnboKjeIrbfRgFiPA3WZdL54NGzCyKlAYKhPWx8FvDH7GpG2F+dHes8nkHd7sg0rtYgDgAHw2O4O230ITF0ONlGDwo+QAsYY79cq1C8qIpeg9ssZbbLpTFQ8g+Cb2Xr1a7gHBQuNejfLNvD5RtlP4sV4+OvMbg+ZEKMeuOk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRSkS5r_1742096207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 11:36:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 5/8] erofs-utils: mkfs: support 48-bit block addressing for unencoded inodes
Date: Sun, 16 Mar 2025 11:36:36 +0800
Message-ID: <20250316033639.1050759-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250316033639.1050759-1-hsiangkao@linux.alibaba.com>
References: <20250316033639.1050759-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add an extended option `-E48bit` to indicate 48-bit block addressing
is used.  Then, 32-byte inodes is preferred since they have per-inode
timestamps too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix chunk-based inode support.

 lib/blobchunk.c | 27 ++++++++-------
 lib/inode.c     | 88 ++++++++++++++++++++++++++++++++++++++++++-------
 mkfs/main.c     | 27 ++++++++++++---
 3 files changed, 116 insertions(+), 26 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 799bdd2..add0f33 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -141,11 +141,11 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_blk_t remaining_blks = BLK_ROUND_UP(sbi, inode->i_size);
 	struct erofs_inode_chunk_index idx = {0};
+	erofs_blk_t extent_end = EROFS_NULL_ADDR, chunkblks;
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
-	erofs_blk_t extent_end, chunkblks;
 	erofs_off_t source_offset;
 	unsigned int dst, src, unit, zeroedlen;
-	bool first_extent = true;
+	bool _48bit, first_extent = true;
 
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -153,24 +153,25 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
 	chunkblks = 1U << (inode->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
+	_48bit = inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT;
 	for (dst = src = 0; dst < inode->extent_isize;
 	     src += sizeof(void *), dst += unit) {
 		struct erofs_blobchunk *chunk;
+		erofs_blk_t startblk;
 
 		chunk = *(void **)(inode->chunkindexes + src);
 
 		if (chunk->blkaddr == EROFS_NULL_ADDR) {
-			idx.startblk_lo = EROFS_NULL_ADDR;
+			startblk = EROFS_NULL_ADDR;
 		} else if (chunk->device_id) {
 			DBG_BUGON(!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES));
-			idx.startblk_lo = chunk->blkaddr;
+			startblk = chunk->blkaddr;
 			extent_start = EROFS_NULL_ADDR;
 		} else {
-			idx.startblk_lo = remapped_base + chunk->blkaddr;
+			startblk = remapped_base + chunk->blkaddr;
 		}
 
-		if (extent_start == EROFS_NULL_ADDR ||
-		    idx.startblk_lo != extent_end) {
+		if (extent_start == EROFS_NULL_ADDR || startblk != extent_end) {
 			if (extent_start != EROFS_NULL_ADDR) {
 				remaining_blks -= extent_end - extent_start;
 				tarerofs_blocklist_write(extent_start,
@@ -182,12 +183,14 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 					first_extent, false);
 				first_extent = false;
 			}
-			extent_start = idx.startblk_lo;
+			extent_start = startblk;
 			source_offset = chunk->sourceoffset;
 		}
-		extent_end = idx.startblk_lo + chunkblks;
+		extent_end = startblk + chunkblks;
 		idx.device_id = cpu_to_le16(chunk->device_id);
-		idx.startblk_lo = cpu_to_le32(idx.startblk_lo);
+		idx.startblk_lo = cpu_to_le32(startblk);
+		idx.startblk_hi = cpu_to_le32(startblk >> 32);
+		DBG_BUGON(!_48bit && idx.startblk_hi);
 
 		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
 			memcpy(inode->chunkindexes + dst, &idx.startblk_lo, unit);
@@ -195,8 +198,8 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
 	off = roundup(off, unit);
-	extent_end = min(extent_end, extent_start + remaining_blks);
 	if (extent_start != EROFS_NULL_ADDR) {
+		extent_end = min(extent_end, extent_start + remaining_blks);
 		zeroedlen = inode->i_size & (erofs_blksiz(sbi) - 1);
 		if (zeroedlen)
 			zeroedlen = erofs_blksiz(sbi) - zeroedlen;
@@ -368,6 +371,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			goto err;
 		}
 
+		if (chunk->blkaddr >= UINT32_MAX)
+			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
 		if (!erofs_blob_can_merge(sbi, lastch, chunk)) {
 			erofs_update_minextblks(sbi, interval_start, pos,
 						&minextblks);
diff --git a/lib/inode.c b/lib/inode.c
index e63fb9f..cf3bcee 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -525,12 +525,29 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 	return true;
 }
 
-static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
+static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd,
+					   erofs_off_t fpos)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_blk_t nblocks, i;
 	unsigned int len;
 	int ret;
+	bool noseek = inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF;
+
+	if (!noseek && erofs_sb_has_48bit(sbi)) {
+		if (lseek(fd, fpos, SEEK_DATA) < 0 && errno == ENXIO) {
+			ret = erofs_allocate_inode_bh_data(inode, 0);
+			if (ret)
+				return ret;
+			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+			return 0;
+		}
+		ret = lseek(fd, fpos, SEEK_SET);
+		if (ret < 0)
+			return ret;
+		else if (ret != fpos)
+			return -EIO;
+	}
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size >> sbi->blkszbits;
@@ -545,7 +562,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 		ret = erofs_io_xcopy(&sbi->bdev,
 				     erofs_pos(sbi, inode->u.i_blkaddr + i),
 				     &((struct erofs_vfile){ .fd = fd }), len,
-			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
+				     noseek);
 		if (ret)
 			return ret;
 	}
@@ -580,7 +597,7 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 	}
 
 	/* fallback to all data uncompressed */
-	return write_uncompressed_file_from_fd(inode, fd);
+	return write_uncompressed_file_from_fd(inode, fd, fpos);
 }
 
 int erofs_iflush(struct erofs_inode *inode)
@@ -593,7 +610,9 @@ int erofs_iflush(struct erofs_inode *inode)
 		struct erofs_inode_extended die;
 	} u = {};
 	union erofs_inode_i_u u1;
-	int ret;
+	union erofs_inode_i_nb nb;
+	bool nlink_1 = true;
+	int ret, fmt;
 
 	if (inode->bh)
 		off = erofs_btell(inode->bh, false);
@@ -610,9 +629,22 @@ int erofs_iflush(struct erofs_inode *inode)
 	else
 		u1.startblk_lo = cpu_to_le32(inode->u.i_blkaddr);
 
+	if (is_inode_layout_compression(inode) &&
+	    inode->u.i_blocks > UINT32_MAX) {
+		nb.blocks_hi = cpu_to_le16(inode->u.i_blocks >> 32);
+	} else if (inode->datalayout != EROFS_INODE_CHUNK_BASED &&
+		 inode->u.i_blkaddr > UINT32_MAX) {
+		if (inode->u.i_blkaddr == EROFS_NULL_ADDR)
+			nlink_1 = false;
+		nb.startblk_hi = cpu_to_le16(inode->u.i_blkaddr >> 32);
+	} else {
+		nlink_1 = false;
+		nb = (union erofs_inode_i_nb){};
+	}
+
 	switch (inode->inode_isize) {
 	case sizeof(struct erofs_inode_compact):
-		u.dic.i_format = cpu_to_le16(0 | (inode->datalayout << 1));
+		fmt = 0 | (inode->datalayout << 1);
 		u.dic.i_xattr_icount = cpu_to_le16(icount);
 		u.dic.i_mode = cpu_to_le16(inode->i_mode);
 		u.dic.i_nb.nlink = cpu_to_le16(inode->i_nlink);
@@ -622,7 +654,19 @@ int erofs_iflush(struct erofs_inode *inode)
 
 		u.dic.i_uid = cpu_to_le16((u16)inode->i_uid);
 		u.dic.i_gid = cpu_to_le16((u16)inode->i_gid);
+		if (!cfg.c_ignore_mtime)
+			u.dic.i_mtime = cpu_to_le64(inode->i_mtime - sbi->epoch);
 		u.dic.i_u = u1;
+
+		if (nlink_1) {
+			if (inode->i_nlink != 1)
+				return -EFSCORRUPTED;
+			u.dic.i_nb = nb;
+			fmt |= 1 << EROFS_I_NLINK_1_BIT;
+		} else {
+			u.dic.i_nb.nlink = cpu_to_le16(inode->i_nlink);
+		}
+		u.dic.i_format = cpu_to_le16(fmt);
 		break;
 	case sizeof(struct erofs_inode_extended):
 		u.die.i_format = cpu_to_le16(1 | (inode->datalayout << 1));
@@ -639,6 +683,7 @@ int erofs_iflush(struct erofs_inode *inode)
 		u.die.i_mtime = cpu_to_le64(inode->i_mtime);
 		u.die.i_mtime_nsec = cpu_to_le32(inode->i_mtime_nsec);
 		u.die.i_u = u1;
+		u.die.i_nb = nb;
 		break;
 	default:
 		erofs_err("unsupported on-disk inode version of nid %llu",
@@ -725,6 +770,19 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	return 0;
 }
 
+static bool erofs_inode_need_48bit(struct erofs_inode *inode)
+{
+	if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
+		if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT)
+			return true;
+	} else if (!is_inode_layout_compression(inode)) {
+		if (inode->u.i_blkaddr != EROFS_NULL_ADDR &&
+		    inode->u.i_blkaddr > UINT32_MAX)
+			return true;
+	}
+	return false;
+}
+
 static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 {
 	struct erofs_bufmgr *bmgr = inode->sbi->bmgr;
@@ -733,6 +791,14 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
 	DBG_BUGON(inode->bh || inode->bh_inline);
 
+	if (erofs_inode_need_48bit(inode)) {
+		if (!erofs_sb_has_48bit(inode->sbi))
+			return -ENOSPC;
+		if (inode->inode_isize == sizeof(struct erofs_inode_compact) &&
+		    inode->i_nlink != 1)
+			inode->inode_isize =
+				sizeof(struct erofs_inode_extended);
+	}
 	inodesize = inode->inode_isize + inode->xattr_isize;
 	if (inode->extent_isize)
 		inodesize = roundup(inodesize, 8) + inode->extent_isize;
@@ -929,9 +995,9 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if ((inode->i_mtime != inode->sbi->build_time ||
-	     inode->i_mtime_nsec != inode->sbi->fixed_nsec) &&
-	    !cfg.c_ignore_mtime)
+	if (!cfg.c_ignore_mtime &&
+	    !erofs_sb_has_48bit(inode->sbi) &&
+	    inode->i_mtime != inode->sbi->epoch)
 		return true;
 	return false;
 }
@@ -1029,7 +1095,7 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		if (inode->i_mtime < sbi->build_time)
 			break;
 	case TIMESTAMP_FIXED:
-		inode->i_mtime = sbi->build_time;
+		inode->i_mtime = sbi->epoch + sbi->build_time;
 		inode->i_mtime_nsec = sbi->fixed_nsec;
 	default:
 		break;
@@ -1925,7 +1991,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 		if (ret < 0)
 			return ERR_PTR(-errno);
 	}
-	ret = write_uncompressed_file_from_fd(inode, fd);
+	ret = write_uncompressed_file_from_fd(inode, fd, 0);
 	if (ret)
 		return ERR_PTR(ret);
 out:
@@ -1997,7 +2063,7 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
 	root->i_srcpath = strdup("/");
 	root->i_mode = S_IFDIR | 0777;
 	root->i_parent = root;
-	root->i_mtime = root->sbi->build_time;
+	root->i_mtime = root->sbi->epoch + root->sbi->build_time;
 	root->i_mtime_nsec = root->sbi->fixed_nsec;
 	erofs_init_empty_dir(root);
 	return root;
diff --git a/mkfs/main.c b/mkfs/main.c
index d604c77..2defa92 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -322,6 +322,18 @@ static int erofs_mkfs_feat_set_fragdedupe(bool en, const char *val,
 	return 0;
 }
 
+static int erofs_mkfs_feat_set_48bit(bool en, const char *val,
+				     unsigned int vallen)
+{
+	if (vallen)
+		return -EINVAL;
+	if (en)
+		erofs_sb_set_48bit(&g_sbi);
+	else
+		erofs_sb_clear_48bit(&g_sbi);
+	return 0;
+}
+
 static struct {
 	char *feat;
 	int (*set)(bool en, const char *val, unsigned int len);
@@ -332,6 +344,7 @@ static struct {
 	{"all-fragments", erofs_mkfs_feat_set_all_fragments},
 	{"dedupe", erofs_mkfs_feat_set_dedupe},
 	{"fragdedupe", erofs_mkfs_feat_set_fragdedupe},
+	{"48bit", erofs_mkfs_feat_set_48bit},
 	{NULL, NULL},
 };
 
@@ -1201,6 +1214,7 @@ int main(int argc, char **argv)
 	erofs_blk_t nblocks = 0;
 	struct timeval t;
 	FILE *blklst = NULL;
+	s64 mkfs_time = 0;
 	u32 crc;
 
 	erofs_init_configure();
@@ -1220,12 +1234,17 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	g_sbi.fixed_nsec = 0;
 	if (cfg.c_unix_timestamp != -1) {
-		g_sbi.build_time      = cfg.c_unix_timestamp;
-		g_sbi.fixed_nsec      = 0;
+		mkfs_time = cfg.c_unix_timestamp;
 	} else if (!gettimeofday(&t, NULL)) {
-		g_sbi.build_time      = t.tv_sec;
-		g_sbi.fixed_nsec      = t.tv_usec;
+		mkfs_time = t.tv_sec;
+	}
+	if (erofs_sb_has_48bit(&g_sbi)) {
+		g_sbi.epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
+		g_sbi.build_time = mkfs_time - g_sbi.epoch;
+	} else {
+		g_sbi.epoch = mkfs_time;
 	}
 
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
-- 
2.43.5


