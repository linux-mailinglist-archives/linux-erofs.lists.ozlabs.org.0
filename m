Return-Path: <linux-erofs+bounces-28-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCAA58F8B
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:25:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBBM70BzWz30VV;
	Mon, 10 Mar 2025 20:25:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741598722;
	cv=none; b=LPU2v+xhgZPoncI7GJp7p6+cWMvEUYnqDJYd2PXDswquEKybJXwEOKOzwFoj39eNwJXaU7K+AYfHhG8kLPtDcKy1Qo6K7IIo95sUIPWciYiUy3jnBg86FwjVgUiE8wDnM0jvrLOcJz0rhXnEgqxE/+W5Vt8wPlXyy0MopWML8LcsRyD3lzUqj/m9TsLAiW7WCGbZSMJuOYX25sZMZdSm8DeFuW1fAyfKjgmGm7WlhwIOhVbdSA+7a9VVtPf1gX4BFvm2s6W5ErV9Byid2+++CAf6Uo7y7lXrTMhzkadi3MI1zJdCw42Yga5DojGAWn08FEkih7qb6uElFikJWrk4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741598722; c=relaxed/relaxed;
	bh=R1Dl5bBQZTlVM39J4Nx4Q1wTwrSS0G8GaTaELKFYxQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1RpVui61Ak6mPDgKgRDCs3S6v4gNrCYhcdbPjrjegTTfbz6BAC5Xa79HMGE3W28+1lfsKz4D4f1wysfMIt8VaKBDrJHWRDeQey7nVpoQgOSPuA9ZZpZHzYOqeETJJfPqZwB4DSJXLYYTE6TqoXlvf7nk/8HcNy4qA+UEr2O/g6mUbEInOH3qOkXfedN9KLbjWkwNr22Wv8TaDuOuYbX+PXSI/Ebt7S5sadk1npGkdt3kAmyTZ8ayzwSHJ9YZ2gtOnsoMR++mS7U3siKpuKQUhORXybP5GWf1TSOsunrwPO05pXO8PFgbkleehgT+xB80y8J75lpRHPegYbQ8Z94XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iT2EQVy9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iT2EQVy9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBBM42bXKz305P
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:25:19 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741598716; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R1Dl5bBQZTlVM39J4Nx4Q1wTwrSS0G8GaTaELKFYxQM=;
	b=iT2EQVy9md/4T22qqL+q9Bv4m9FBGPq72NrwusgpqzFMgPZbl5A7bcy5XWXilP6YJhayl06KseyepgXrr8FWorK29uPWspzTWEmlQ/+B1nl75i2CKqcZ55EIjKTrWKa29XYtcBYtcWGTVCbGX0jFbc3qyGGRYAAUtrf8djku8H4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR0RNAZ_1741598714 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:25:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/7] erofs-utils: implement 48-bit block addressing for unencoded inodes
Date: Mon, 10 Mar 2025 17:25:05 +0800
Message-ID: <20250310092508.2573532-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310092508.2573532-1-hsiangkao@linux.alibaba.com>
References: <20250310092508.2573532-1-hsiangkao@linux.alibaba.com>
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

Add an extended option `-E48bit` to indicate 48-bit block addressing
is used.  Then, 32-byte inodes is preferred since they have per-inode
timestamps too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              |  1 +
 include/erofs/internal.h | 21 ++++-----
 lib/block_list.c         | 16 +++----
 lib/inode.c              | 92 ++++++++++++++++++++++++++++++++++------
 lib/namei.c              |  4 +-
 lib/super.c              |  6 ++-
 mkfs/main.c              | 35 +++++++++++----
 7 files changed, 132 insertions(+), 43 deletions(-)

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
diff --git a/lib/inode.c b/lib/inode.c
index 89a0985..7230549 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -525,12 +525,30 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
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
+		} else {
+			ret = lseek(fd, fpos, SEEK_SET);
+			if (ret < 0)
+				return ret;
+			else if (ret != fpos)
+				return -EIO;
+		}
+	}
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size >> sbi->blkszbits;
@@ -545,7 +563,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 		ret = erofs_io_xcopy(&sbi->bdev,
 				     erofs_pos(sbi, inode->u.i_blkaddr + i),
 				     &((struct erofs_vfile){ .fd = fd }), len,
-			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
+				     noseek);
 		if (ret)
 			return ret;
 	}
@@ -580,7 +598,7 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 	}
 
 	/* fallback to all data uncompressed */
-	return write_uncompressed_file_from_fd(inode, fd);
+	return write_uncompressed_file_from_fd(inode, fd, fpos);
 }
 
 int erofs_iflush(struct erofs_inode *inode)
@@ -593,7 +611,9 @@ int erofs_iflush(struct erofs_inode *inode)
 		struct erofs_inode_extended die;
 	} u = {};
 	union erofs_inode_i_u u1;
-	int ret;
+	union erofs_inode_i_nb nb;
+	bool nlink_1 = true;
+	int ret, fmt;
 
 	if (inode->bh)
 		off = erofs_btell(inode->bh, false);
@@ -610,9 +630,22 @@ int erofs_iflush(struct erofs_inode *inode)
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
@@ -622,7 +655,19 @@ int erofs_iflush(struct erofs_inode *inode)
 
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
@@ -639,6 +684,7 @@ int erofs_iflush(struct erofs_inode *inode)
 		u.die.i_mtime = cpu_to_le64(inode->i_mtime);
 		u.die.i_mtime_nsec = cpu_to_le32(inode->i_mtime_nsec);
 		u.die.i_u = u1;
+		u.die.i_nb = nb;
 		break;
 	default:
 		erofs_err("unsupported on-disk inode version of nid %llu",
@@ -725,6 +771,18 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	return 0;
 }
 
+static bool erofs_inode_need_48bit(struct erofs_inode *inode)
+{
+	if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
+		if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT)
+			return true;
+	} else if (!is_inode_layout_compression(inode)) {
+		if (inode->u.i_blkaddr > UINT32_MAX)	/* + EROFS_NULL_ADDR */
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
-	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
-	    !cfg.c_ignore_mtime)
+	if (!cfg.c_ignore_mtime &&
+	    !erofs_sb_has_48bit(inode->sbi) &&
+	    inode->i_mtime != inode->sbi->epoch)
 		return true;
 	return false;
 }
@@ -1029,8 +1095,8 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		if (inode->i_mtime < sbi->build_time)
 			break;
 	case TIMESTAMP_FIXED:
-		inode->i_mtime = sbi->build_time;
-		inode->i_mtime_nsec = sbi->build_time_nsec;
+		inode->i_mtime = sbi->epoch + sbi->build_time;
+		inode->i_mtime_nsec = sbi->fixed_nsec;
 	default:
 		break;
 	}
@@ -1925,7 +1991,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 		if (ret < 0)
 			return ERR_PTR(-errno);
 	}
-	ret = write_uncompressed_file_from_fd(inode, fd);
+	ret = write_uncompressed_file_from_fd(inode, fd, 0);
 	if (ret)
 		return ERR_PTR(ret);
 out:
@@ -1997,8 +2063,8 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
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
index 66b8eef..ac14a20 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -79,8 +79,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_gid = le16_to_cpu(dic->i_gid);
 		vi->i_nlink = le16_to_cpu(dic->i_nb.nlink);
 
-		vi->i_mtime = sbi->build_time;
-		vi->i_mtime_nsec = sbi->build_time_nsec;
+		vi->i_mtime = sbi->epoch + le32_to_cpu(dic->i_mtime);
+		vi->i_mtime_nsec = sbi->fixed_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
 		break;
diff --git a/lib/super.c b/lib/super.c
index 00a1683..d9d9526 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -121,8 +121,9 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
 
+	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
+	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	sbi->build_time = le64_to_cpu(dsb->build_time);
-	sbi->build_time_nsec = le32_to_cpu(dsb->fixed_nsec);
 
 	memcpy(&sbi->uuid, dsb->uuid, sizeof(dsb->uuid));
 
@@ -163,8 +164,9 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
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
index 9d6a0f2..2defa92 100644
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
 
@@ -1184,12 +1197,12 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
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
-		g_sbi.build_time_nsec = 0;
+		mkfs_time = cfg.c_unix_timestamp;
 	} else if (!gettimeofday(&t, NULL)) {
-		g_sbi.build_time      = t.tv_sec;
-		g_sbi.build_time_nsec = t.tv_usec;
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


