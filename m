Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A041503F
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 20:56:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF6wK0Z83z2ymb
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 04:56:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF6wC0JN1z2yMc
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 04:56:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UpFo0Io_1632336968; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpFo0Io_1632336968) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 02:56:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/5] erofs-utils: fuse: support reading chunk-based
 uncompressed files
Date: Thu, 23 Sep 2021 02:56:03 +0800
Message-Id: <20210922185607.49909-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
References: <20210922185607.49909-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Keep in sync with the latest kernel
commit 2a9dc7a8fec6 ("erofs: introduce chunk-based file on-disk format")
and
commit c5aa903a59db ("erofs: support reading chunk-based uncompressed files")

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  5 +++
 include/erofs_fs.h       | 48 ++++++++++++++++++++--
 lib/data.c               | 86 +++++++++++++++++++++++++++++++++++-----
 lib/namei.c              | 15 ++++++-
 4 files changed, 140 insertions(+), 14 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f5eacea5d4d7..8621f3426410 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -109,6 +109,7 @@ static inline void erofs_sb_clear_##name(void) \
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
+EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -140,6 +141,10 @@ struct erofs_inode {
 		u32 i_blkaddr;
 		u32 i_blocks;
 		u32 i_rdev;
+		struct {
+			unsigned short	chunkformat;
+			unsigned char	chunkbits;
+		};
 	} u;
 
 	char i_srcpath[PATH_MAX + 1];
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 48934bb76cec..66a68e3b2065 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
+ * Copyright (C) 2021, Alibaba Cloud
  */
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
@@ -21,10 +21,12 @@
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
+#define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
-	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
+	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -66,13 +68,16 @@ struct erofs_super_block {
  * inode, [xattrs], last_inline_data, ... | ... | no-holed data
  * 3 - inode compression D:
  * inode, [xattrs], map_header, extents ... | ...
- * 4~7 - reserved
+ * 4 - inode chunk-based E:
+ * inode, [xattrs], chunk indexes ... | ...
+ * 5~7 - reserved
  */
 enum {
 	EROFS_INODE_FLAT_PLAIN			= 0,
 	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
 	EROFS_INODE_FLAT_INLINE			= 2,
 	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_CHUNK_BASED			= 4,
 	EROFS_INODE_DATALAYOUT_MAX
 };
 
@@ -92,6 +97,19 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_ALL	\
 	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
 
+/* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
+#define EROFS_CHUNK_FORMAT_BLKBITS_MASK		0x001F
+/* with chunk indexes or just a 4-byte blkaddr array */
+#define EROFS_CHUNK_FORMAT_INDEXES		0x0020
+
+#define EROFS_CHUNK_FORMAT_ALL	\
+	(EROFS_CHUNK_FORMAT_BLKBITS_MASK | EROFS_CHUNK_FORMAT_INDEXES)
+
+struct erofs_inode_chunk_info {
+	__le16 format;		/* chunk blkbits, etc. */
+	__le16 reserved;
+};
+
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
 	__le16 i_format;	/* inode format hints */
@@ -109,6 +127,9 @@ struct erofs_inode_compact {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
 	} i_u;
 	__le32 i_ino;           /* only used for 32-bit stat compatibility */
 	__le16 i_uid;
@@ -137,6 +158,9 @@ struct erofs_inode_extended {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
 	} i_u;
 
 	/* only used for 32-bit stat compatibility */
@@ -206,6 +230,19 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 				 e->e_name_len + le16_to_cpu(e->e_value_size));
 }
 
+/* represent a zeroed chunk (hole) */
+#define EROFS_NULL_ADDR			-1
+
+/* 4-byte block address array */
+#define EROFS_BLOCK_MAP_ENTRY_SIZE	sizeof(__le32)
+
+/* 8-byte inode chunk indexes */
+struct erofs_inode_chunk_index {
+	__le16 advise;		/* always 0, don't care for now */
+	__le16 device_id;	/* back-end storage id, always 0 for now */
+	__le32 blkaddr;		/* start block address of this inode chunk */
+};
+
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
 
@@ -350,9 +387,14 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_info) != 4);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
+	/* keep in sync between 2 index structures for better extendibility */
+	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
+		     sizeof(struct z_erofs_vle_decompressed_index));
 
 	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
diff --git a/lib/data.c b/lib/data.c
index 1a1005a67350..641d8408b54f 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -25,13 +25,6 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
 	lastblk = nblocks - tailendpacking;
 
-	if (offset >= inode->i_size) {
-		/* leave out-of-bound access unmapped */
-		map->m_flags = 0;
-		map->m_plen = 0;
-		goto out;
-	}
-
 	/* there is no hole in flatmode */
 	map->m_flags = EROFS_MAP_MAPPED;
 
@@ -62,14 +55,86 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 		goto err_out;
 	}
 
-out:
 	map->m_llen = map->m_plen;
-
 err_out:
 	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
 	return err;
 }
 
+static int erofs_map_blocks(struct erofs_inode *inode,
+			    struct erofs_map_blocks *map, int flags)
+{
+	struct erofs_inode *vi = inode;
+	struct erofs_inode_chunk_index *idx;
+	u8 buf[EROFS_BLKSIZ];
+	u64 chunknr;
+	unsigned int unit;
+	erofs_off_t pos;
+	int err = 0;
+
+	if (map->m_la >= inode->i_size) {
+		/* leave out-of-bound access unmapped */
+		map->m_flags = 0;
+		map->m_plen = 0;
+		goto out;
+	}
+
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
+		return erofs_map_blocks_flatmode(inode, map, flags);
+
+	if (vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+		unit = sizeof(*idx);			/* chunk index */
+	else
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
+
+	chunknr = map->m_la >> vi->u.chunkbits;
+	pos = roundup(iloc(vi->nid) + vi->inode_isize +
+		      vi->xattr_isize, unit) + unit * chunknr;
+
+	err = blk_read(buf, erofs_blknr(pos), 1);
+	if (err < 0)
+		return -EIO;
+
+	map->m_la = chunknr << vi->u.chunkbits;
+	map->m_plen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
+			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
+
+	/* handle block map */
+	if (!(vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
+		__le32 *blkaddr = (void *)buf + erofs_blkoff(pos);
+
+		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
+			map->m_flags = 0;
+		} else {
+			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
+			map->m_flags = EROFS_MAP_MAPPED;
+		}
+		goto out;
+	}
+	/* parse chunk indexes */
+	idx = (void *)buf + erofs_blkoff(pos);
+	switch (le32_to_cpu(idx->blkaddr)) {
+	case EROFS_NULL_ADDR:
+		map->m_flags = 0;
+		break;
+	default:
+		/* only one device is supported for now */
+		if (idx->device_id) {
+			erofs_err("invalid device id %u @ %" PRIu64 " for nid %llu",
+				  le16_to_cpu(idx->device_id),
+				  chunknr, vi->nid | 0ULL);
+			err = -EFSCORRUPTED;
+			goto out;
+		}
+		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
+		map->m_flags = EROFS_MAP_MAPPED;
+		break;
+	}
+out:
+	map->m_llen = map->m_plen;
+	return err;
+}
+
 static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
@@ -84,7 +149,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 		erofs_off_t eend;
 
 		map.m_la = ptr;
-		ret = erofs_map_blocks_flatmode(inode, &map, 0);
+		ret = erofs_map_blocks(inode, &map, 0);
 		if (ret)
 			return ret;
 
@@ -206,6 +271,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 	switch (inode->datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
 	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_CHUNK_BASED:
 		return erofs_read_raw_data(inode, buf, count, offset);
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
diff --git a/lib/namei.c b/lib/namei.c
index f96e400c36b0..b4bdabf10acb 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -82,6 +82,9 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_ctime = le64_to_cpu(die->i_ctime);
 		vi->i_ctime_nsec = le64_to_cpu(die->i_ctime_nsec);
 		vi->i_size = le64_to_cpu(die->i_size);
+		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
+			/* fill chunked inode summary info */
+			vi->u.chunkformat = le16_to_cpu(die->i_u.c.format);
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
@@ -115,6 +118,8 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->i_ctime_nsec = sbi.build_time_nsec;
 
 		vi->i_size = le32_to_cpu(dic->i_size);
+		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
+			vi->u.chunkformat = le16_to_cpu(dic->i_u.c.format);
 		break;
 	default:
 		erofs_err("unsupported on-disk inode version %u of nid %llu",
@@ -123,7 +128,15 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	}
 
 	vi->flags = 0;
-	if (erofs_inode_is_data_compressed(vi->datalayout))
+	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+		if (vi->u.chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
+			erofs_err("unsupported chunk format %x of nid %llu",
+				  vi->u.chunkformat, vi->nid | 0ULL);
+			return -EOPNOTSUPP;
+		}
+		vi->u.chunkbits = LOG_BLOCK_SIZE +
+			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
+	} else if (erofs_inode_is_data_compressed(vi->datalayout))
 		z_erofs_fill_inode(vi);
 	return 0;
 bogusimode:
-- 
2.24.4

