Return-Path: <linux-erofs+bounces-515-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB6AF89DB
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 09:46:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYQfp6bWCz30VV;
	Fri,  4 Jul 2025 17:45:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751615154;
	cv=none; b=QQkGNbvbWd+PNjsjjeS+E0xeAO3OuJEHiFUAoVwzfCphPKZUVXdDtzny1upKjPteenP+/nrkEQY5lT2mHXfW//cNFcl2Xrv0/ApFzKYgRgCUv0c1THdMBzZujwZQXWZbizPkZWUNd//W2HSldW0qhnIxWrE8Mgd0g3sfCH8eW/w0zFI9sCjytUP4UyipwIzpssY1dAttYoZv1VK4TZ8F3c07OBgU3hITEiEAdl2UGvJvmZjrMgfnbKKVRl7ECp7JddU23URpfpUm3q75rD/TR9OA+YdlOEDcxsjpxI28y5fU0i75bJsb/57rpiHGHy2t01WGWtJH2stS4gXMi4X6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751615154; c=relaxed/relaxed;
	bh=wEUQweTgyOO7kcq9WQTUHSLl/49RqHmSGWMMwxVafSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OATdm56eoEhkp0Ncvy5cj8zey6BSWWANWMhzjJlyNtWNFh8dfcMzEDsnOxa6bv86ZVJAOdmVGmLEqUVqGV5pHhaPmLIriRLE7EGog45Vf8AZpWDoFSNy+/AxTu+PVmexFdbNR3R5LPlHDG6RfUrbBIcgs/6kpucpdaKIYLSR2KbMEb5YEY+oetOTr9/pvZN3JI/NiXMuoju5K72trZjw1DrytWy8nVTkFb+nWZQ6DzdSxL4587KWVpLbpSSQ8KYrQkgIVgrthCx9wcIcVfdq04PvHuNIXdo22qnjNR5YKyKqXXYgYI6nXWr02f0VLnMxgPQ9a3YIbIhSyIBSEZ6iig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gGYPl8bg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gGYPl8bg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYQfl5MDLz30MY
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 17:45:51 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751615147; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wEUQweTgyOO7kcq9WQTUHSLl/49RqHmSGWMMwxVafSU=;
	b=gGYPl8bg3GlLEBOW5KmrUIo4r5jfKrochynW6Rz2Y+4kZORjDbtZF10H6QJ9sjy2sc87QvS3YFkkC1UBDwYUbcTpxZBCXtbrFItZKRsFH2d2Dp613b2//uLSc3rnRNOPdEQ9mbp58CdD4frJuAOIz5eF4kRuGIq8u08pizRDx5w=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhDC7Cf_1751615146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 15:45:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 for-merge 6/9] erofs-utils: mkfs: support 48-bit block addressing for unencoded inodes
Date: Fri,  4 Jul 2025 15:45:32 +0800
Message-ID: <20250704074535.2308212-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
References: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
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

Add an extended option `-E48bit` to indicate 48-bit block addressing
is used.  Then, 32-byte inodes is preferred since they have per-inode
timestamps too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 31 +++++++++++------
 lib/inode.c     | 91 +++++++++++++++++++++++++++++++++++++++++++------
 lib/super.c     |  5 +++
 mkfs/main.c     | 27 ++++++++++++---
 4 files changed, 129 insertions(+), 25 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 38c44229..ccc77b0b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -139,10 +139,11 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_blk_t remaining_blks = BLK_ROUND_UP(sbi, inode->i_size);
 	struct erofs_inode_chunk_index idx = {0};
+	erofs_blk_t extent_end = EROFS_NULL_ADDR, chunkblks, addrmask;
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
-	erofs_blk_t extent_end, chunkblks;
 	erofs_off_t source_offset;
 	unsigned int dst, src, unit, zeroedlen;
+	bool _48bit;
 
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -150,36 +151,42 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
 	chunkblks = 1U << (inode->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
+	_48bit = inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT;
 	for (dst = src = 0; dst < inode->extent_isize;
 	     src += sizeof(void *), dst += unit) {
 		struct erofs_blobchunk *chunk;
+		erofs_blk_t startblk;
 
 		chunk = *(void **)(inode->chunkindexes + src);
 
 		if (chunk->blkaddr == EROFS_NULL_ADDR) {
-			idx.startblk_lo = (u32)EROFS_NULL_ADDR;
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
 						extent_end - extent_start,
 						source_offset, 0);
 			}
-			extent_start = idx.startblk_lo;
+			extent_start = startblk;
 			source_offset = chunk->sourceoffset;
 		}
-		extent_end = idx.startblk_lo + chunkblks;
+		extent_end = startblk + chunkblks;
+
+		addrmask = _48bit ? BIT_ULL(48) - 1 : BIT_ULL(32) - 1;
+		startblk &= addrmask;
 		idx.device_id = cpu_to_le16(chunk->device_id);
-		idx.startblk_lo = cpu_to_le32(idx.startblk_lo);
+		idx.startblk_lo = cpu_to_le32(startblk);
+		idx.startblk_hi = cpu_to_le32(startblk >> 32);
+		DBG_BUGON(!_48bit && idx.startblk_hi);
 
 		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
 			memcpy(inode->chunkindexes + dst, &idx.startblk_lo, unit);
@@ -187,8 +194,8 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 			memcpy(inode->chunkindexes + dst, &idx, sizeof(idx));
 	}
 	off = roundup(off, unit);
-	extent_end = min(extent_end, extent_start + remaining_blks);
 	if (extent_start != EROFS_NULL_ADDR) {
+		extent_end = min(extent_end, extent_start + remaining_blks);
 		zeroedlen = inode->i_size & (erofs_blksiz(sbi) - 1);
 		if (zeroedlen)
 			zeroedlen = erofs_blksiz(sbi) - zeroedlen;
@@ -355,6 +362,10 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			goto err;
 		}
 
+		/* FIXME! `chunk->blkaddr` is not the final blkaddr here */
+		if (chunk->blkaddr != EROFS_NULL_ADDR &&
+		    chunk->blkaddr >= UINT32_MAX)
+			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
 		if (!erofs_blob_can_merge(sbi, lastch, chunk)) {
 			erofs_update_minextblks(sbi, interval_start, pos,
 						&minextblks);
diff --git a/lib/inode.c b/lib/inode.c
index 026a71b4..a97425f5 100644
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
@@ -579,7 +596,7 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 	}
 
 	/* fallback to all data uncompressed */
-	return write_uncompressed_file_from_fd(inode, fd);
+	return write_uncompressed_file_from_fd(inode, fd, fpos);
 }
 
 int erofs_iflush(struct erofs_inode *inode)
@@ -592,7 +609,9 @@ int erofs_iflush(struct erofs_inode *inode)
 		struct erofs_inode_extended die;
 	} u = {};
 	union erofs_inode_i_u u1;
-	int ret;
+	union erofs_inode_i_nb nb;
+	bool nlink_1 = true;
+	int ret, fmt;
 
 	if (inode->bh)
 		off = erofs_btell(inode->bh, false);
@@ -609,9 +628,26 @@ int erofs_iflush(struct erofs_inode *inode)
 	else
 		u1.startblk_lo = cpu_to_le32(inode->u.i_blkaddr);
 
+	if (is_inode_layout_compression(inode) &&
+	    inode->u.i_blocks > UINT32_MAX) {
+		nb.blocks_hi = cpu_to_le16(inode->u.i_blocks >> 32);
+	} else if (inode->datalayout != EROFS_INODE_CHUNK_BASED &&
+		 inode->u.i_blkaddr > UINT32_MAX) {
+		nb.startblk_hi = cpu_to_le16(inode->u.i_blkaddr >> 32);
+		if (inode->u.i_blkaddr == EROFS_NULL_ADDR) {
+			nlink_1 = false;
+			/* In sync with old non-48bit mkfses */
+			if (!erofs_sb_has_48bit(sbi))
+				nb.startblk_hi = 0;
+		}
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
@@ -621,7 +657,19 @@ int erofs_iflush(struct erofs_inode *inode)
 
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
@@ -638,6 +686,7 @@ int erofs_iflush(struct erofs_inode *inode)
 		u.die.i_mtime = cpu_to_le64(inode->i_mtime);
 		u.die.i_mtime_nsec = cpu_to_le32(inode->i_mtime_nsec);
 		u.die.i_u = u1;
+		u.die.i_nb = nb;
 		break;
 	default:
 		erofs_err("unsupported on-disk inode version of nid %llu",
@@ -724,6 +773,19 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
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
@@ -732,6 +794,14 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 
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
@@ -922,10 +992,9 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if (path != EROFS_PACKED_INODE &&
-	    (inode->i_mtime != inode->sbi->epoch ||
-	     inode->i_mtime_nsec != inode->sbi->fixed_nsec) &&
-	    !cfg.c_ignore_mtime)
+	if (path != EROFS_PACKED_INODE && !cfg.c_ignore_mtime &&
+	    !erofs_sb_has_48bit(inode->sbi) &&
+	    inode->i_mtime != inode->sbi->epoch)
 		return true;
 	return false;
 }
@@ -1976,7 +2045,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 		if (ret < 0)
 			return ERR_PTR(-errno);
 	}
-	ret = write_uncompressed_file_from_fd(inode, fd);
+	ret = write_uncompressed_file_from_fd(inode, fd, 0);
 	if (ret)
 		return ERR_PTR(ret);
 out:
@@ -1996,7 +2065,7 @@ int erofs_fixup_root_inode(struct erofs_inode *root)
 	if (sbi->root_nid == root->nid)		/* for most mkfs cases */
 		return 0;
 
-	if (root->nid <= 0xffff) {
+	if (erofs_sb_has_48bit(sbi) || root->nid <= UINT16_MAX) {
 		sbi->root_nid = root->nid;
 		return 0;
 	}
diff --git a/lib/super.c b/lib/super.c
index e4696f87..29c36527 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -192,6 +192,11 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 	int ret;
 
 	sb.blocks_lo	= cpu_to_le32(sbi->primarydevice_blocks);
+	if (sbi->primarydevice_blocks > UINT32_MAX ||
+	    sbi->root_nid > UINT16_MAX) {
+		sb.rb.blocks_hi = sb.rb.blocks_hi;
+		sb.rootnid_8b = cpu_to_le64(sbi->root_nid);
+	}
 	memcpy(sb.uuid, sbi->uuid, sizeof(sb.uuid));
 	memcpy(sb.volume_name, sbi->volume_name, sizeof(sb.volume_name));
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 579b90fe..93b4ff2d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -333,6 +333,18 @@ static int erofs_mkfs_feat_set_fragdedupe(bool en, const char *val,
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
@@ -343,6 +355,7 @@ static struct {
 	{"all-fragments", erofs_mkfs_feat_set_all_fragments},
 	{"dedupe", erofs_mkfs_feat_set_dedupe},
 	{"fragdedupe", erofs_mkfs_feat_set_fragdedupe},
+	{"48bit", erofs_mkfs_feat_set_48bit},
 	{NULL, NULL},
 };
 
@@ -1246,6 +1259,7 @@ int main(int argc, char **argv)
 	bool tar_index_512b = false;
 	struct timeval t;
 	FILE *blklst = NULL;
+	s64 mkfs_time = 0;
 	int err = 0;
 	u32 crc;
 
@@ -1266,12 +1280,17 @@ int main(int argc, char **argv)
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


