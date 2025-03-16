Return-Path: <linux-erofs+bounces-69-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E7A63375
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 04:37:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFkLK6G7Sz2yds;
	Sun, 16 Mar 2025 14:36:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742096217;
	cv=none; b=Z/ry8ZzDBsfxy9iu5+AbmOTeNg/Mz6UAUQkSRe6J2oyLjXUpdtqx0xOVMPj7oKyMtVkrA2uovI1LTbyhbY4MvUNTlHm8RlJ+/TMaffEq5ufkOlWElb+MCAI/9rqjUjKKP2rrFm/7yORIh+VVqt5bEgt+nW5BoaebqhUi4g3q87RqutSwnGDchJL8rv2ezc7ch1VI7xL1u9aBEtIr8hZ52IjERuJ/8iF8GcamT99Fup6UkFVzWxd6SSiBP4tIIk0r3DdQDmoKGg6hdYI8EOmkrmDF70XVDywHgiyztapOrRFmOl4Kek7NLKaYkZzmWRcRtUym2G0IYnx7xFgh/wyFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742096217; c=relaxed/relaxed;
	bh=v1xLHCxHDqUMXUYknYY/q6nwxtFPQzA/RSmH674zKU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPxWb89tWOL0uKuLgkgErAuZ7eeDXmWd7kdgm8bOs62fcf1cThFyOiZqds9/A+KzxKE4iwYXSDWntLm5omnk37PaNbNqF5L5FNxfun1pp3ovMhWzoamycuItSj+2TE18V8v79PYOBEaO3cXzTvP+Rhoguy3C2Rf/jbgMRnQ+7uxwQA1+wnE7vI39imtk1BvChDugeoTTV9r4w+MTiDD4q6RlFjXV9Fz8mB64PEaPR5g6qAH0eCyewSD0bMIUODrzhGGIiGirFvmpdp8X1Z7UYcw/X//m4ZZidNLLTWpIIobZWKqnin8Kh9c9X+/Ihu7L0m8NE7mjosBBvSbs5rdBJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LWPmIUhe; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LWPmIUhe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFkLD56Z6z2ydq
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 14:36:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742096208; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v1xLHCxHDqUMXUYknYY/q6nwxtFPQzA/RSmH674zKU4=;
	b=LWPmIUheAli5zd17zcjPV5xsJIY2C/mXsFmmrX5AumgulBxOJVXDlhLDlvDKdeBQqb9tGf2t1EvijisfNkbBOMjxZT4+2NlXolinAEkG/aD0WjEjQbORFvVbgc0Gg6AB0D5Df5JTU1x033X5voj1Wfb8McNvY9tzKJXy1KOwxb4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRSkS5J_1742096206 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 11:36:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 4/8] erofs-utils: implement 48-bit block addressing for unencoded inodes
Date: Sun, 16 Mar 2025 11:36:35 +0800
Message-ID: <20250316033639.1050759-4-hsiangkao@linux.alibaba.com>
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

Port the same kernel logic to erofsfuse and dump.erofs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: new patch

 dump/main.c              |   1 +
 include/erofs/internal.h |  21 +++---
 lib/block_list.c         |  16 ++---
 lib/data.c               | 143 +++++++++++++++------------------------
 lib/inode.c              |   6 +-
 lib/namei.c              |  35 +++++++---
 lib/super.c              |  14 +++-
 mkfs/main.c              |  12 ++--
 8 files changed, 119 insertions(+), 129 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 44f65da..f7d7ed2 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -104,6 +104,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
 	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
 	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
+	{ false, EROFS_FEATURE_INCOMPAT_48BIT, "48bit" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 08d33b8..fd8d43d 100644
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
@@ -88,8 +87,8 @@ struct erofs_sb_info {
 	u64 total_blocks;
 	u64 primarydevice_blocks;
 
-	erofs_blk_t meta_blkaddr;
-	erofs_blk_t xattr_blkaddr;
+	u32 meta_blkaddr;
+	u32 xattr_blkaddr;
 
 	u32 feature_compat;
 	u32 feature_incompat;
@@ -98,8 +97,9 @@ struct erofs_sb_info {
 	unsigned char blkszbits;
 
 	u32 sb_size;			/* total superblock size */
-	u32 build_time_nsec;
-	u64 build_time;
+	u32 build_time;
+	u32 fixed_nsec;
+	u64 epoch;
 
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
@@ -170,6 +170,7 @@ EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
+EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
@@ -211,8 +212,8 @@ struct erofs_inode {
 	u32 i_nlink;
 
 	union {
-		u32 i_blkaddr;
-		u32 i_blocks;
+		erofs_blk_t i_blkaddr;
+		erofs_blk_t i_blocks;
 		u32 i_rdev;
 		struct {
 			unsigned short	chunkformat;
diff --git a/lib/block_list.c b/lib/block_list.c
index 8f1c93b..484c196 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -38,11 +38,11 @@ void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
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
 
 #ifdef WITH_ANDROID
@@ -62,10 +62,10 @@ static void blocklist_write(const char *path, erofs_blk_t blk_start,
 	}
 
 	if (nblocks == 1)
-		fprintf(block_list_fp, " %u", blk_start);
+		fprintf(block_list_fp, " %llu", blk_start | 0ULL);
 	else
-		fprintf(block_list_fp, " %u-%u", blk_start,
-			blk_start + nblocks - 1);
+		fprintf(block_list_fp, " %llu-%llu", blk_start | 0ULL,
+			(blk_start + nblocks - 1) | 0ULL);
 
 	if (last_extent)
 		fprintf(block_list_fp, "\n");
@@ -114,7 +114,7 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 		if (blkaddr == EROFS_NULL_ADDR)
 			fprintf(block_list_fp, "\n");
 		else
-			fprintf(block_list_fp, " %u\n", blkaddr);
+			fprintf(block_list_fp, " %llu\n", blkaddr | 0ULL);
 		return;
 	}
 	if (blkaddr != EROFS_NULL_ADDR)
diff --git a/lib/data.c b/lib/data.c
index 6f6db6d..dd33d9e 100644
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
-	map->m_plen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
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
+	map->m_llen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
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
index 89a0985..e63fb9f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -930,7 +930,7 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
 	if ((inode->i_mtime != inode->sbi->build_time ||
-	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
+	     inode->i_mtime_nsec != inode->sbi->fixed_nsec) &&
 	    !cfg.c_ignore_mtime)
 		return true;
 	return false;
@@ -1030,7 +1030,7 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 			break;
 	case TIMESTAMP_FIXED:
 		inode->i_mtime = sbi->build_time;
-		inode->i_mtime_nsec = sbi->build_time_nsec;
+		inode->i_mtime_nsec = sbi->fixed_nsec;
 	default:
 		break;
 	}
@@ -1998,7 +1998,7 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
 	root->i_mode = S_IFDIR | 0777;
 	root->i_parent = root;
 	root->i_mtime = root->sbi->build_time;
-	root->i_mtime_nsec = root->sbi->build_time_nsec;
+	root->i_mtime_nsec = root->sbi->fixed_nsec;
 	erofs_init_empty_dir(root);
 	return root;
 }
diff --git a/lib/namei.c b/lib/namei.c
index 66b8eef..dec544c 100644
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
index 00a1683..e44f918 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -116,13 +116,20 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
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
 
+	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
+	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	sbi->build_time = le64_to_cpu(dsb->build_time);
-	sbi->build_time_nsec = le32_to_cpu(dsb->fixed_nsec);
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
 
@@ -163,8 +170,9 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 		.blkszbits = sbi->blkszbits,
 		.rb.rootnid_2b  = cpu_to_le16(sbi->root_nid),
 		.inos      = cpu_to_le64(sbi->inos),
+		.epoch     = cpu_to_le64(sbi->epoch),
 		.build_time = cpu_to_le64(sbi->build_time),
-		.fixed_nsec = cpu_to_le32(sbi->build_time_nsec),
+		.fixed_nsec = cpu_to_le32(sbi->fixed_nsec),
 		.meta_blkaddr  = cpu_to_le32(sbi->meta_blkaddr),
 		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
 		.xattr_prefix_count = sbi->xattr_prefix_count,
diff --git a/mkfs/main.c b/mkfs/main.c
index 9d6a0f2..d604c77 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1184,12 +1184,12 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 	erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
 
 	fprintf(stdout, "------\nFilesystem UUID: %s\n"
-		"Filesystem total blocks: %u (of %u-byte blocks)\n"
+		"Filesystem total blocks: %llu (of %u-byte blocks)\n"
 		"Filesystem total inodes: %llu\n"
-		"Filesystem %s metadata blocks: %u\n"
+		"Filesystem %s metadata blocks: %llu\n"
 		"Filesystem %s deduplicated bytes (of source files): %llu\n",
-		uuid_str, nblocks, 1U << g_sbi.blkszbits, g_sbi.inos | 0ULL,
-		incr, erofs_total_metablocks(g_sbi.bmgr),
+		uuid_str, nblocks | 0ULL, 1U << g_sbi.blkszbits, g_sbi.inos | 0ULL,
+		incr, erofs_total_metablocks(g_sbi.bmgr) | 0ULL,
 		incr, g_sbi.saved_by_deduplication | 0ULL);
 }
 
@@ -1222,10 +1222,10 @@ int main(int argc, char **argv)
 
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


