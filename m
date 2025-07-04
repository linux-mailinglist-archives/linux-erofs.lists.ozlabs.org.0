Return-Path: <linux-erofs+bounces-514-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AAAAF89DC
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 09:46:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYQfp61nqz30T8;
	Fri,  4 Jul 2025 17:45:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751615154;
	cv=none; b=g9snpU0KC9ptDiYoKOk9Q3gS+i910KHB6A4spaGU0nSUnTVzSnftXS43qASDb7Rr+9yfL7/Eb5kURnUysU59+i+WKcFVGxI9f7c4NQHXrNX8n7/IdRsjumlHxS14qAzhMBcbZbtdfu2r+eWPI8VjatrEKkApy3WlgHDqV7syxKOQewB9JhRBtb8jDbLJHh+LSDtGuqto9doEY5RrBv6WFj7UGe0qvBFNptDP7gk2HmmtYdsQHDCw/5IqY2GnsauX7blIaAizmb9/Ytoax8R2Gku+ggZu+aff4KwLF17vMLjJBTABnTQ74JJsPW1EL4ZLO4diDjBqC0xsoiQAetApoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751615154; c=relaxed/relaxed;
	bh=icmDI3LDr/i3FxIZnEbCG/vCBVMPtYex0cczRp8AGAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXoNZmHwzdKYD4eQBKtnr0ykMnA76wkz2M0QR7d6pZ65Q5u+WUsmzFswB38LLMnVtr8H3qDBAWES17XUOwSZ6WbR67Nm/JKrTrQ8u267EUy3Aik79+VkwxQ2FEVYNwJ7bov0Iq313jE+Oh+M3m1KpN6sIO3tdSnKDMCx4Pq0jPg/EnKtRu1q72a9Tkrxz+zLWgmya8pJevZE5kMar80qLVxZyE0/L948w2wBavOLMABt2TmiN0n9kR8Vw8Jqb67+/+GARlsYt3+o/V/Bs9wikaPQuxVQ/LYdhqz4OVv1IOLPrlDZgX5XjJl3QxZATgplPHF1nm0VSjEwHbMEhCWL0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VhsT+EwQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VhsT+EwQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYQfl2MyPz2xQ4
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 17:45:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751615146; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=icmDI3LDr/i3FxIZnEbCG/vCBVMPtYex0cczRp8AGAA=;
	b=VhsT+EwQ6VZ40YDzNg4wvWqt/RzLrFOQOCDwtWbU3IveJWlp7qEBHvG862M+fJNaC5pPSRO8G8LlQIHDTvXdqsiXwLE8Arc41MzQwp9K1gT/EL3kXJWWRBZOYy7GaQ4lKB33ziZ8WUxtVyGuE4XUCECUkAFCwVI4HVbt46Hs3CU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhDC7C3_1751615145 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 15:45:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 for-merge 5/9] erofs-utils: implement 48-bit block addressing for unencoded inodes
Date: Fri,  4 Jul 2025 15:45:31 +0800
Message-ID: <20250704074535.2308212-6-hsiangkao@linux.alibaba.com>
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

.. Also port the same kernel logic to erofsfuse and dump.erofs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              |   3 +-
 include/erofs/internal.h |  21 +++---
 include/erofs_fs.h       |   2 +-
 lib/blobchunk.c          |   2 +-
 lib/block_list.c         |   8 +--
 lib/data.c               | 143 +++++++++++++++------------------------
 lib/inode.c              |  18 ++---
 lib/namei.c              |  35 +++++++---
 lib/super.c              |  18 +++--
 mkfs/main.c              |   8 +--
 10 files changed, 124 insertions(+), 134 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 44f65dab..993d9386 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -104,6 +104,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
 	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
+	{ false, EROFS_FEATURE_INCOMPAT_48BIT, "48bit" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
@@ -623,7 +624,7 @@ static void erofsdump_print_supported_compressors(FILE *f, unsigned int mask)
 
 static void erofsdump_show_superblock(void)
 {
-	time_t time = g_sbi.build_time;
+	time_t time = g_sbi.epoch + g_sbi.build_time;
 	char uuid_str[37];
 	int i = 0;
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a294561f..51def099 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -41,15 +41,14 @@ typedef unsigned short umode_t;
 
 typedef u64 erofs_off_t;
 typedef u64 erofs_nid_t;
-/* data type for filesystem-wide blocks number */
-typedef u32 erofs_blk_t;
+typedef u64 erofs_blk_t;
 
 /* global sbi */
 extern struct erofs_sb_info g_sbi;
 
 #define erofs_blksiz(sbi)	(1u << (sbi)->blkszbits)
-#define erofs_blknr(sbi, addr)  ((addr) >> (sbi)->blkszbits)
-#define erofs_blkoff(sbi, addr) ((addr) & (erofs_blksiz(sbi) - 1))
+#define erofs_blknr(sbi, pos)	((pos) >> (sbi)->blkszbits)
+#define erofs_blkoff(sbi, pos)	((pos) & (erofs_blksiz(sbi) - 1))
 #define erofs_pos(sbi, nr)      ((erofs_off_t)(nr) << (sbi)->blkszbits)
 #define BLK_ROUND_UP(sbi, addr)	\
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
@@ -90,8 +89,8 @@ struct erofs_sb_info {
 	u64 total_blocks;
 	u64 primarydevice_blocks;
 
-	erofs_blk_t meta_blkaddr;
-	erofs_blk_t xattr_blkaddr;
+	u32 meta_blkaddr;
+	u32 xattr_blkaddr;
 
 	u32 feature_compat;
 	u32 feature_incompat;
@@ -100,8 +99,9 @@ struct erofs_sb_info {
 	unsigned char blkszbits;
 
 	u32 sb_size;			/* total superblock size */
-	u32 build_time_nsec;
-	u64 build_time;
+	u32 build_time;
+	u32 fixed_nsec;
+	u64 epoch;
 
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
@@ -174,6 +174,7 @@ EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
+EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
@@ -218,8 +219,8 @@ struct erofs_inode {
 	u32 i_nlink;
 
 	union {
-		u32 i_blkaddr;
-		u32 i_blocks;
+		erofs_blk_t i_blkaddr;
+		erofs_blk_t i_blocks;
 		u32 i_rdev;
 		struct {
 			unsigned short	chunkformat;
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index ce319d79..41a398cb 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -256,7 +256,7 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 }
 
 /* represent a zeroed chunk (hole) */
-#define EROFS_NULL_ADDR			-1
+#define EROFS_NULL_ADDR			-1ULL
 
 /* 4-byte block address array */
 #define EROFS_BLOCK_MAP_ENTRY_SIZE	sizeof(__le32)
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 18eafdce..38c44229 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -157,7 +157,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 		chunk = *(void **)(inode->chunkindexes + src);
 
 		if (chunk->blkaddr == EROFS_NULL_ADDR) {
-			idx.startblk_lo = EROFS_NULL_ADDR;
+			idx.startblk_lo = (u32)EROFS_NULL_ADDR;
 		} else if (chunk->device_id) {
 			DBG_BUGON(!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES));
 			idx.startblk_lo = chunk->blkaddr;
diff --git a/lib/block_list.c b/lib/block_list.c
index 4a6466de..f8dc9138 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -38,9 +38,9 @@ void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
 		return;
 
 	if (zeroedlen)
-		fprintf(block_list_fp, "%08x %8x %08" PRIx64 " %08u\n",
-			blkaddr, nblocks, srcoff, zeroedlen);
+		fprintf(block_list_fp, "%08llx %8llx %08" PRIx64 " %08u\n",
+			blkaddr | 0ULL, nblocks | 0ULL, srcoff, zeroedlen);
 	else
-		fprintf(block_list_fp, "%08x %8x %08" PRIx64 "\n",
-			blkaddr, nblocks, srcoff);
+		fprintf(block_list_fp, "%08llx %8llx %08" PRIx64 "\n",
+			blkaddr | 0ULL, nblocks | 0ULL, srcoff);
 }
diff --git a/lib/data.c b/lib/data.c
index 2547615f..f674230c 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -10,81 +10,46 @@
 #include "erofs/decompress.h"
 #include "erofs/fragments.h"
 
-static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
-				     struct erofs_map_blocks *map,
-				     int flags)
-{
-	int err = 0;
-	erofs_blk_t nblocks, lastblk;
-	u64 offset = map->m_la;
-	struct erofs_inode *vi = inode;
-	struct erofs_sb_info *sbi = inode->sbi;
-	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
-
-	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
-
-	nblocks = BLK_ROUND_UP(sbi, inode->i_size);
-	lastblk = nblocks - tailendpacking;
-
-	/* there is no hole in flatmode */
-	map->m_flags = EROFS_MAP_MAPPED;
-
-	if (offset < erofs_pos(sbi, lastblk)) {
-		map->m_pa = erofs_pos(sbi, vi->u.i_blkaddr) + map->m_la;
-		map->m_plen = erofs_pos(sbi, lastblk) - offset;
-	} else if (tailendpacking) {
-		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
-		map->m_pa = erofs_iloc(vi) + vi->inode_isize +
-			vi->xattr_isize + erofs_blkoff(sbi, map->m_la);
-		map->m_plen = inode->i_size - offset;
-
-		/* inline data should be located in the same meta block */
-		if (erofs_blkoff(sbi, map->m_pa) + map->m_plen >
-							erofs_blksiz(sbi)) {
-			erofs_err("inline data cross block boundary @ nid %" PRIu64,
-				  vi->nid);
-			DBG_BUGON(1);
-			err = -EFSCORRUPTED;
-			goto err_out;
-		}
-
-		map->m_flags |= EROFS_MAP_META;
-	} else {
-		erofs_err("internal error @ nid: %" PRIu64 " (size %llu), m_la 0x%" PRIx64,
-			  vi->nid, (unsigned long long)inode->i_size, map->m_la);
-		DBG_BUGON(1);
-		err = -EIO;
-		goto err_out;
-	}
-
-	map->m_llen = map->m_plen;
-err_out:
-	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
-	return err;
-}
-
 int __erofs_map_blocks(struct erofs_inode *inode,
 		       struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
 	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int unit, blksz = 1 << sbi->blkszbits;
 	struct erofs_inode_chunk_index *idx;
 	u8 buf[EROFS_MAX_BLOCK_SIZE];
-	u64 chunknr;
-	unsigned int unit;
+	erofs_blk_t startblk, addrmask, nblocks;
+	bool tailpacking;
 	erofs_off_t pos;
+	u64 chunknr;
 	int err = 0;
 
 	map->m_deviceid = 0;
-	if (map->m_la >= inode->i_size) {
-		/* leave out-of-bound access unmapped */
-		map->m_flags = 0;
-		map->m_plen = 0;
+	map->m_flags = 0;
+	if (map->m_la >= inode->i_size)
 		goto out;
-	}
 
-	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
-		return erofs_map_blocks_flatmode(inode, map, flags);
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
+		tailpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+		if (!tailpacking && vi->u.i_blkaddr == EROFS_NULL_ADDR) {
+			map->m_llen = inode->i_size - map->m_la;
+			goto out;
+		}
+		nblocks = BLK_ROUND_UP(sbi, inode->i_size);
+		pos = erofs_pos(sbi, nblocks - tailpacking);
+
+		map->m_flags = EROFS_MAP_MAPPED;
+		if (map->m_la < pos) {
+			map->m_pa = erofs_pos(sbi, vi->u.i_blkaddr) + map->m_la;
+			map->m_llen = pos - map->m_la;
+		} else {
+			map->m_pa = erofs_iloc(inode) + vi->inode_isize +
+				vi->xattr_isize + erofs_blkoff(sbi, map->m_la);
+			map->m_llen = inode->i_size - map->m_la;
+			map->m_flags |= EROFS_MAP_META;
+		}
+		goto out;
+	}
 
 	if (vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(*idx);			/* chunk index */
@@ -99,37 +64,39 @@ int __erofs_map_blocks(struct erofs_inode *inode,
 	if (err < 0)
 		return -EIO;
 
+	idx = (void *)buf + erofs_blkoff(sbi, pos);
 	map->m_la = chunknr << vi->u.chunkbits;
-	map->m_plen = min_t(erofs_off_t, 1ULL << vi->u.chunkbits,
-			roundup(inode->i_size - map->m_la, erofs_blksiz(sbi)));
-
-	/* handle block map */
-	if (!(vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
-		__le32 *blkaddr = (void *)buf + erofs_blkoff(sbi, pos);
-
-		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
-			map->m_flags = 0;
-		} else {
-			map->m_pa = erofs_pos(sbi, le32_to_cpu(*blkaddr));
+	map->m_llen = min_t(erofs_off_t, 1ULL << vi->u.chunkbits,
+			    round_up(inode->i_size - map->m_la, blksz));
+	if (vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
+		addrmask = (vi->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT) ?
+			BIT_ULL(48) - 1 : BIT_ULL(32) - 1;
+		startblk = (((u64)le16_to_cpu(idx->startblk_hi) << 32) |
+			le32_to_cpu(idx->startblk_lo)) & addrmask;
+		if ((startblk ^ EROFS_NULL_ADDR) & addrmask) {
+			map->m_deviceid = le16_to_cpu(idx->device_id) &
+				sbi->device_id_mask;
+			map->m_pa = erofs_pos(sbi, startblk);
+			map->m_flags = EROFS_MAP_MAPPED;
+		}
+	} else {
+		startblk = le32_to_cpu(*(__le32 *)idx);
+		if (startblk != EROFS_NULL_ADDR) {
+			map->m_pa = erofs_pos(sbi, startblk);
 			map->m_flags = EROFS_MAP_MAPPED;
 		}
-		goto out;
-	}
-	/* parse chunk indexes */
-	idx = (void *)buf + erofs_blkoff(sbi, pos);
-	switch (le32_to_cpu(idx->startblk_lo)) {
-	case EROFS_NULL_ADDR:
-		map->m_flags = 0;
-		break;
-	default:
-		map->m_deviceid = le16_to_cpu(idx->device_id) &
-			sbi->device_id_mask;
-		map->m_pa = erofs_pos(sbi, le32_to_cpu(idx->startblk_lo));
-		map->m_flags = EROFS_MAP_MAPPED;
-		break;
 	}
 out:
-	map->m_llen = map->m_plen;
+	if (!err) {
+		map->m_plen = map->m_llen;
+		/* inline data should be located in the same meta block */
+		if ((map->m_flags & EROFS_MAP_META) &&
+		    erofs_blkoff(sbi, map->m_pa) + map->m_plen > blksz) {
+			erofs_err("inline data across blocks @ nid %llu", vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+	}
 	return err;
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index 5ccffc09..026a71b4 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -923,8 +923,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
 	if (path != EROFS_PACKED_INODE &&
-	    (inode->i_mtime != inode->sbi->build_time ||
-	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
+	    (inode->i_mtime != inode->sbi->epoch ||
+	     inode->i_mtime_nsec != inode->sbi->fixed_nsec) &&
 	    !cfg.c_ignore_mtime)
 		return true;
 	return false;
@@ -1016,8 +1016,8 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	inode->i_gid += cfg.c_gid_offset;
 
 	if (path == EROFS_PACKED_INODE) {
-		inode->i_mtime = sbi->build_time;
-		inode->i_mtime_nsec = sbi->build_time_nsec;
+		inode->i_mtime = sbi->epoch + sbi->build_time;
+		inode->i_mtime_nsec = sbi->fixed_nsec;
 		return 0;
 	}
 	inode->i_mtime = st->st_mtime;
@@ -1025,11 +1025,11 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 
 	switch (cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
-		if (inode->i_mtime < sbi->build_time)
+		if (inode->i_mtime < sbi->epoch + sbi->build_time)
 			break;
 	case TIMESTAMP_FIXED:
-		inode->i_mtime = sbi->build_time;
-		inode->i_mtime_nsec = sbi->build_time_nsec;
+		inode->i_mtime = sbi->epoch + sbi->build_time;
+		inode->i_mtime_nsec = sbi->fixed_nsec;
 	default:
 		break;
 	}
@@ -2048,8 +2048,8 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
 	root->i_srcpath = strdup("/");
 	root->i_mode = S_IFDIR | 0777;
 	root->i_parent = root;
-	root->i_mtime = root->sbi->build_time;
-	root->i_mtime_nsec = root->sbi->build_time_nsec;
+	root->i_mtime = root->sbi->epoch + root->sbi->build_time;
+	root->i_mtime_nsec = root->sbi->fixed_nsec;
 	erofs_init_empty_dir(root);
 	return root;
 }
diff --git a/lib/namei.c b/lib/namei.c
index 66b8eef4..dec544c9 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -28,9 +28,9 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	char buf[sizeof(struct erofs_inode_extended)];
 	erofs_off_t inode_loc = erofs_iloc(vi);
 	struct erofs_sb_info *sbi = vi->sbi;
+	erofs_blk_t addrmask = BIT_ULL(48) - 1;
+	struct erofs_inode_extended *die, copied;
 	struct erofs_inode_compact *dic;
-	struct erofs_inode_extended *die;
-	union erofs_inode_i_u iu;
 
 	DBG_BUGON(!sbi);
 	ret = erofs_dev_read(sbi, 0, buf, inode_loc, sizeof(*dic));
@@ -60,7 +60,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(die->i_mode);
 		vi->i_ino[0] = le32_to_cpu(die->i_ino);
-		iu = die->i_u;
+		copied.i_u = die->i_u;
+		copied.i_nb = die->i_nb;
 		vi->i_uid = le32_to_cpu(die->i_uid);
 		vi->i_gid = le32_to_cpu(die->i_gid);
 		vi->i_nlink = le32_to_cpu(die->i_nlink);
@@ -74,13 +75,21 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 		vi->i_mode = le16_to_cpu(dic->i_mode);
 		vi->i_ino[0] = le32_to_cpu(dic->i_ino);
-		iu = dic->i_u;
+		copied.i_u = dic->i_u;
+		copied.i_nb = dic->i_nb;
 		vi->i_uid = le16_to_cpu(dic->i_uid);
 		vi->i_gid = le16_to_cpu(dic->i_gid);
-		vi->i_nlink = le16_to_cpu(dic->i_nb.nlink);
-
-		vi->i_mtime = sbi->build_time;
-		vi->i_mtime_nsec = sbi->build_time_nsec;
+		if (!S_ISDIR(vi->i_mode) &&
+		    ((ifmt >> EROFS_I_NLINK_1_BIT) & 1)) {
+			vi->i_nlink = 1;
+			copied.i_nb = dic->i_nb;
+		} else {
+			vi->i_nlink = le16_to_cpu(dic->i_nb.nlink);
+			copied.i_nb.startblk_hi = 0;
+			addrmask = BIT_ULL(32) - 1;
+		}
+		vi->i_mtime = sbi->epoch + le32_to_cpu(dic->i_mtime);
+		vi->i_mtime_nsec = sbi->fixed_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
 		break;
@@ -94,11 +103,15 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case S_IFREG:
 	case S_IFDIR:
 	case S_IFLNK:
-		vi->u.i_blkaddr = le32_to_cpu(iu.startblk_lo);
+		vi->u.i_blkaddr = le32_to_cpu(copied.i_u.startblk_lo) |
+			((u64)le16_to_cpu(copied.i_nb.startblk_hi) << 32);
+		if (vi->datalayout == EROFS_INODE_FLAT_PLAIN &&
+		    !((vi->u.i_blkaddr ^ EROFS_NULL_ADDR) & addrmask))
+			vi->u.i_blkaddr = EROFS_NULL_ADDR;
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
-		vi->u.i_rdev = erofs_new_decode_dev(le32_to_cpu(iu.rdev));
+		vi->u.i_rdev = erofs_new_decode_dev(le32_to_cpu(copied.i_u.rdev));
 		break;
 	case S_IFIFO:
 	case S_IFSOCK:
@@ -113,7 +126,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	vi->flags = 0;
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
 		/* fill chunked inode summary info */
-		vi->u.chunkformat = le16_to_cpu(iu.c.format);
+		vi->u.chunkformat = le16_to_cpu(copied.i_u.c.format);
 		if (vi->u.chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
 			erofs_err("unsupported chunk format %x of nid %llu",
 				  vi->u.chunkformat, vi->nid | 0ULL);
diff --git a/lib/super.c b/lib/super.c
index 6a59a236..e4696f87 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -115,13 +115,20 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
 	sbi->islotbits = EROFS_ISLOTBITS;
-	sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
+	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
+		sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
+		sbi->primarydevice_blocks = (sbi->primarydevice_blocks << 32) |
+				le16_to_cpu(dsb->rb.blocks_hi);
+	} else {
+		sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
+	}
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
 
-	sbi->build_time = le64_to_cpu(dsb->epoch);
-	sbi->build_time_nsec = le32_to_cpu(dsb->fixed_nsec);
+	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
+	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
+	sbi->build_time = le32_to_cpu(dsb->build_time);
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
 
@@ -166,8 +173,9 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 		.blkszbits = sbi->blkszbits,
 		.rb.rootnid_2b  = cpu_to_le16(sbi->root_nid),
 		.inos      = cpu_to_le64(sbi->inos),
-		.epoch     = cpu_to_le64(sbi->build_time),
-		.fixed_nsec = cpu_to_le32(sbi->build_time_nsec),
+		.epoch     = cpu_to_le64(sbi->epoch),
+		.build_time = cpu_to_le64(sbi->build_time),
+		.fixed_nsec = cpu_to_le32(sbi->fixed_nsec),
 		.meta_blkaddr  = cpu_to_le32(sbi->meta_blkaddr),
 		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
 		.xattr_prefix_count = sbi->xattr_prefix_count,
diff --git a/mkfs/main.c b/mkfs/main.c
index c266f617..579b90fe 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1231,11 +1231,11 @@ static void erofs_mkfs_showsummaries(void)
 	fprintf(stdout, "------\nFilesystem UUID: %s\n"
 		"Filesystem total blocks: %llu (of %u-byte blocks)\n"
 		"Filesystem total inodes: %llu\n"
-		"Filesystem %s metadata blocks: %u\n"
+		"Filesystem %s metadata blocks: %llu\n"
 		"Filesystem %s deduplicated bytes (of source files): %llu\n",
 		uuid_str, g_sbi.total_blocks | 0ULL, 1U << g_sbi.blkszbits,
 		g_sbi.inos | 0ULL,
-		incr, erofs_total_metablocks(g_sbi.bmgr),
+		incr, erofs_total_metablocks(g_sbi.bmgr) | 0ULL,
 		incr, g_sbi.saved_by_deduplication | 0ULL);
 }
 
@@ -1268,10 +1268,10 @@ int main(int argc, char **argv)
 
 	if (cfg.c_unix_timestamp != -1) {
 		g_sbi.build_time      = cfg.c_unix_timestamp;
-		g_sbi.build_time_nsec = 0;
+		g_sbi.fixed_nsec      = 0;
 	} else if (!gettimeofday(&t, NULL)) {
 		g_sbi.build_time      = t.tv_sec;
-		g_sbi.build_time_nsec = t.tv_usec;
+		g_sbi.fixed_nsec      = t.tv_usec;
 	}
 
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
-- 
2.43.5


