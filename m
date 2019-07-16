Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682936A2A3
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:41 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nryV4yrtzDqWW
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxd45sFzDqTW
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:53 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 90081CD5AF1ABFCC3BEE;
 Tue, 16 Jul 2019 15:04:50 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:41 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 15/17] erofs-utils: introduce compacted compression indexes
Date: Tue, 16 Jul 2019 15:04:17 +0800
Message-ID: <20190716070419.30203-16-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds compacted 2/4B compression indexes
support matched with in-kernel implementation. Several
continuous indexes will be packed into a compacted form.

Therefore, the total size of compression indexes
is three quarters off at most.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/config.h   |   1 +
 include/erofs/internal.h |   5 +
 include/erofs_fs.h       |  67 ++++++++++--
 lib/compress.c           | 214 +++++++++++++++++++++++++++++++++++++--
 lib/config.c             |   1 +
 lib/inode.c              |  18 ++--
 6 files changed, 285 insertions(+), 21 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 177017b..05fe6b2 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -15,6 +15,7 @@ struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
 	bool c_dry_run;
+	bool c_legacy_compress;
 
 	/* related arguments for mkfs.erofs */
 	char *c_img_path;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cf33e22..07a6f72 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -96,6 +96,11 @@ struct erofs_inode {
 	void *compressmeta;
 };
 
+static inline bool is_inode_layout_compression(struct erofs_inode *inode)
+{
+	return erofs_inode_is_data_compressed(inode->data_mapping_mode);
+}
+
 #define IS_ROOT(x)	((x) == (x)->i_parent)
 
 struct erofs_dentry {
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 4b6c1d1..d9999bb 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -49,12 +49,20 @@ struct erofs_super_block {
  * 3~7 - reserved
  */
 enum {
-	EROFS_INODE_LAYOUT_PLAIN,
-	EROFS_INODE_LAYOUT_COMPRESSION,
-	EROFS_INODE_LAYOUT_INLINE,
+	EROFS_INODE_FLAT_PLAIN,
+	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
+	EROFS_INODE_FLAT_INLINE,
+	EROFS_INODE_FLAT_COMPRESSION,
 	EROFS_INODE_LAYOUT_MAX
 };
 
+static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
+{
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return true;
+	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+}
+
 /* bit definitions of inode i_advise */
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATA_MAPPING_BITS       3
@@ -169,10 +177,57 @@ struct erofs_xattr_entry {
 	sizeof(struct erofs_xattr_entry) + \
 	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
 
-/* have to be aligned with 8 bytes on disk */
+/* available compression algorithm types */
+#define Z_EROFS_COMPRESSION_LZ4         0
+
+/*
+ * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
+ *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
+ *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ */
+#define Z_EROFS_ADVISE_COMPACTED_2B_BIT         0
+
+#define Z_EROFS_ADVISE_COMPACTED_2B     (1 << Z_EROFS_ADVISE_COMPACTED_2B_BIT)
+
+struct z_erofs_map_header {
+	__le32  h_reserved1;
+	__le16  h_advise;
+	/*
+	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
+	 * bit 4-7 : algorithm type of head 2 (logical cluster type 11).
+	 */
+	__u8    h_algorithmtype;
+	/*
+	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
+	 * bit 3-4 : (physical - logical) cluster bits of head 1:
+	 *       For example, if logical clustersize = 4096, 1 for 8192.
+	 * bit 5-7 : (physical - logical) cluster bits of head 2.
+	 */
+	__u8    h_clusterbits;
+} __packed;
+
+/*
+ * each compacted index includes:
+ *  1) 4-byte blkaddr (ci_blkaddr), which indicates start
+ *     block address of this compacted pack;
+ *  2) each (2+x)-bit represents a logical cluster type, x means
+ *     user-defined bit count, usually x = 0;
+ *
+ *     low 2-bit of logical cluster type:
+ *     00 - shifted plaintext head
+ *     01 - algorithm 1 head
+ *     10 - nonhead
+ *     11 - algorithm 2 head (reserved now)
+ *
+ *  3) it ends with logical cluster offsets, each offset has y-bit,
+ *     usually y = 12.
+ *   ________________________________________________________________
+ *  | blkaddr | logical cluster types | .. | logical cluster offsets |
+ *  |_4 bytes_|_______(2+x) * n_______|____|_______(2+y) * n_________|
+ */
+
 struct erofs_extent_header {
-	__le32 eh_checksum;
-	__le32 eh_reserved[3];
+	__le32 eh_reserved[4];
 } __packed;
 
 /*
diff --git a/lib/compress.c b/lib/compress.c
index b378ba4..0063b97 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -20,6 +20,8 @@
 static struct erofs_compress compresshandle;
 static int compressionlevel;
 
+static struct z_erofs_map_header mapheader;
+
 struct z_erofs_vle_compress_ctx {
 	u8 *metacur;
 
@@ -30,7 +32,7 @@ struct z_erofs_vle_compress_ctx {
 	u16 clusterofs;
 };
 
-static unsigned int get_vle_compress_metasize(erofs_off_t filesize)
+static unsigned int vle_compressmeta_capacity(erofs_off_t filesize)
 {
 	const unsigned int indexsize = BLK_ROUND_UP(filesize) *
 		sizeof(struct z_erofs_vle_decompressed_index);
@@ -190,17 +192,186 @@ nocompression:
 	return 0;
 }
 
+struct z_erofs_compressindex_vec {
+	union {
+		erofs_blk_t blkaddr;
+		u16 delta[2];
+	} u;
+	u16 clusterofs;
+	u8  clustertype;
+};
+
+static void *parse_legacy_indexes(struct z_erofs_compressindex_vec *cv,
+				  unsigned int nr, void *metacur)
+{
+	struct z_erofs_vle_decompressed_index *const db = metacur;
+	unsigned int i;
+
+	for (i = 0; i < nr; ++i, ++cv) {
+		struct z_erofs_vle_decompressed_index *const di = db + i;
+		const unsigned int advise = le16_to_cpu(di->di_advise);
+
+		cv->clustertype = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
+			((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+		cv->clusterofs = le16_to_cpu(di->di_clusterofs);
+
+		if (cv->clustertype == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+			cv->u.delta[0] = le16_to_cpu(di->di_u.delta[0]);
+			cv->u.delta[1] = le16_to_cpu(di->di_u.delta[1]);
+		} else {
+			cv->u.blkaddr = le32_to_cpu(di->di_u.blkaddr);
+		}
+	}
+	return db + nr;
+}
+
+static void *write_compacted_indexes(u8 *out,
+				     struct z_erofs_compressindex_vec *cv,
+				     erofs_blk_t *blkaddr_ret,
+				     unsigned int destsize,
+				     unsigned int logical_clusterbits,
+				     bool final)
+{
+	unsigned int vcnt, encodebits, pos, i;
+	erofs_blk_t blkaddr;
+
+	if (destsize == 4) {
+		vcnt = 2;
+	} else if (destsize == 2 && logical_clusterbits == 12) {
+		vcnt = 16;
+	} else {
+		return ERR_PTR(-EINVAL);
+	}
+	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
+	blkaddr = *blkaddr_ret;
+
+	pos = 0;
+	for (i = 0; i < vcnt; ++i) {
+		unsigned int offset, v;
+		u8 ch, rem;
+
+		if (cv[i].clustertype == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+			if (i + 1 == vcnt)
+				offset = cv[i].u.delta[1];
+			else
+				offset = cv[i].u.delta[0];
+		} else {
+			offset = cv[i].clusterofs;
+			++blkaddr;
+			if (cv[i].u.blkaddr != blkaddr) {
+				if (i + 1 != vcnt)
+					DBG_BUGON(!final);
+				DBG_BUGON(cv[i].u.blkaddr);
+			}
+		}
+		v = (cv[i].clustertype << logical_clusterbits) | offset;
+		rem = pos & 7;
+		ch = out[pos / 8] & ((1 << rem) - 1);
+		out[pos / 8] = (v << rem) | ch;
+		out[pos / 8 + 1] = v >> (8 - rem);
+		out[pos / 8 + 2] = v >> (16 - rem);
+		pos += encodebits;
+	}
+	DBG_BUGON(destsize * vcnt * 8 != pos + 32);
+	*(__le32 *)(out + destsize * vcnt - 4) = cpu_to_le32(*blkaddr_ret);
+	*blkaddr_ret = blkaddr;
+	return out + destsize * vcnt;
+}
+
+int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
+					erofs_blk_t blkaddr,
+					unsigned int legacymetasize,
+					unsigned int logical_clusterbits)
+{
+	const uint headerpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
+							inode->xattr_isize) +
+			       sizeof(struct z_erofs_map_header);
+	const uint totalidx = (legacymetasize -
+			       sizeof(struct erofs_extent_header)) / 8;
+	u8 *out, *in;
+	struct z_erofs_compressindex_vec cv[16];
+	/* # of 8-byte units so that it can be aligned with 32 bytes */
+	unsigned int compacted_4b_initial, compacted_4b_end;
+	unsigned int compacted_2b;
+
+	if (logical_clusterbits < LOG_BLOCK_SIZE || LOG_BLOCK_SIZE < 12)
+		return -EINVAL;
+	if (logical_clusterbits > 14)	/* currently not supported */
+		return -ENOTSUP;
+	if (logical_clusterbits == 12) {
+		compacted_4b_initial = (32 - headerpos % 32) / 4;
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
+	out = in = inode->compressmeta;
+
+	/* write out compacted header */
+	memcpy(out, &mapheader, sizeof(mapheader));
+	out += sizeof(mapheader);
+	in += sizeof(struct erofs_extent_header);
+
+	/* generate compacted_4b_initial */
+	while (compacted_4b_initial) {
+		in = parse_legacy_indexes(cv, 2, in);
+		out = write_compacted_indexes(out, cv, &blkaddr,
+					      4, logical_clusterbits, false);
+		compacted_4b_initial -= 2;
+	}
+	DBG_BUGON(compacted_4b_initial);
+
+	/* generate compacted_2b */
+	while (compacted_2b) {
+		in = parse_legacy_indexes(cv, 16, in);
+		out = write_compacted_indexes(out, cv, &blkaddr,
+					      2, logical_clusterbits, false);
+		compacted_2b -= 16;
+	}
+	DBG_BUGON(compacted_2b);
+
+	/* generate compacted_4b_end */
+	while (compacted_4b_end > 1) {
+		in = parse_legacy_indexes(cv, 2, in);
+		out = write_compacted_indexes(out, cv, &blkaddr,
+					      4, logical_clusterbits, false);
+		compacted_4b_end -= 2;
+	}
+
+	/* generate final compacted_4b_end if needed */
+	if (compacted_4b_end) {
+		memset(cv, 0, sizeof(cv));
+		in = parse_legacy_indexes(cv, 1, in);
+		out = write_compacted_indexes(out, cv, &blkaddr,
+					      4, logical_clusterbits, true);
+	}
+	inode->extent_isize = out - (u8 *)inode->compressmeta;
+	inode->data_mapping_mode = EROFS_INODE_FLAT_COMPRESSION;
+	return 0;
+}
+
 int erofs_write_compressed_file(struct erofs_inode *inode)
 {
-	const unsigned int metasize = get_vle_compress_metasize(inode->i_size);
 	struct erofs_buffer_head *bh;
 	struct z_erofs_vle_compress_ctx ctx;
 	erofs_off_t remaining;
 	erofs_blk_t blkaddr;
-
+	unsigned int legacymetasize;
 	int ret, fd;
-	u8 *compressmeta = malloc(metasize);
 
+	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
 	if (!compressmeta)
 		return -ENOMEM;
 
@@ -271,8 +442,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	erofs_bdrop(bh, false);
 	inode->compressmeta = compressmeta;
 	inode->idata_size = 0;
-	inode->extent_isize = metasize;
-	inode->data_mapping_mode = EROFS_INODE_LAYOUT_COMPRESSION;
+
+	legacymetasize = ctx.metacur - compressmeta;
+	if (cfg.c_legacy_compress) {
+		inode->extent_isize = legacymetasize;
+		inode->data_mapping_mode = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+	} else {
+		ret = z_erofs_convert_to_compacted_format(inode, blkaddr - 1,
+							  legacymetasize, 12);
+		DBG_BUGON(ret);
+	}
 	return 0;
 
 err_bdrop:
@@ -284,8 +463,16 @@ err_free:
 	return ret;
 }
 
+static int erofs_get_compress_algorithm_id(const char *name)
+{
+	if (!strcmp(name, "lz4") || !strcmp(name, "lz4hc"))
+		return Z_EROFS_COMPRESSION_LZ4;
+	return -ENOTSUP;
+}
+
 int z_erofs_compress_init(void)
 {
+	unsigned int algorithmtype[2];
 	/* initialize for primary compression algorithm */
 	int ret = erofs_compressor_init(&compresshandle,
 					cfg.c_compr_alg_master);
@@ -295,6 +482,21 @@ int z_erofs_compress_init(void)
 	compressionlevel = cfg.c_compr_level_master < 0 ?
 		compresshandle.alg->default_level :
 		cfg.c_compr_level_master;
+
+	if (!cfg.c_compr_alg_master)
+		return 0;
+
+	/* figure out mapheader */
+	ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg_master);
+	if (ret < 0)
+		return ret;
+
+	algorithmtype[0] = ret;	/* primary algorithm (head 0) */
+	algorithmtype[1] = 0;	/* secondary algorithm (head 1) */
+	mapheader.h_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+	mapheader.h_algorithmtype = algorithmtype[1] << 4 |
+					  algorithmtype[0];
+	mapheader.h_clusterbits = LOG_BLOCK_SIZE - 12;
 	return 0;
 }
 
diff --git a/lib/config.c b/lib/config.c
index 3312c9b..07e2846 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -18,6 +18,7 @@ void erofs_init_configure(void)
 	cfg.c_dbg_lvl  = 0;
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
+	cfg.c_legacy_compress = false;
 	cfg.c_compr_level_master = -1;
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index affd6db..a8565ef 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -179,7 +179,7 @@ int erofs_prepare_dir_file(struct erofs_inode *dir)
 	dir->i_size = d_size;
 
 	/* no compression for all dirs */
-	dir->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+	dir->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
 
 	/* allocate dir main data */
 	ret = __allocate_inode_bh_data(dir, erofs_blknr(d_size));
@@ -259,7 +259,7 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 	const unsigned int nblocks = erofs_blknr(inode->i_size);
 	int ret;
 
-	inode->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+	inode->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
 
 	ret = __allocate_inode_bh_data(inode, nblocks);
 	if (ret)
@@ -295,7 +295,7 @@ int erofs_write_file(struct erofs_inode *inode)
 	}
 
 	/* fallback to all data uncompressed */
-	inode->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+	inode->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / EROFS_BLKSIZ;
 
 	ret = __allocate_inode_bh_data(inode, nblocks);
@@ -369,7 +369,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		break;
 
 	default:
-		if (inode->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+		if (is_inode_layout_compression(inode))
 			v1.i_u.compressed_blocks =
 				cpu_to_le32(inode->u.i_blocks);
 		else
@@ -440,21 +440,21 @@ int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 	inodesize = inode->inode_isize + inode->xattr_isize +
 		    inode->extent_isize;
 
-	if (inode->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+	if (is_inode_layout_compression(inode))
 		goto noinline;
 
 	/*
 	 * if the file size is block-aligned for uncompressed files,
-	 * should use EROFS_INODE_LAYOUT_PLAIN data mapping mode.
+	 * should use EROFS_INODE_FLAT_PLAIN data mapping mode.
 	 */
 	if (!inode->idata_size)
-		inode->data_mapping_mode = EROFS_INODE_LAYOUT_PLAIN;
+		inode->data_mapping_mode = EROFS_INODE_FLAT_PLAIN;
 
 	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
-		inode->data_mapping_mode = EROFS_INODE_LAYOUT_PLAIN;
+		inode->data_mapping_mode = EROFS_INODE_FLAT_PLAIN;
 noinline:
 		/* expend an extra block for tail-end data */
 		ret = erofs_prepare_tail_block(inode);
@@ -467,7 +467,7 @@ noinline:
 	} else if (IS_ERR(bh)) {
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
-		inode->data_mapping_mode = EROFS_INODE_LAYOUT_INLINE;
+		inode->data_mapping_mode = EROFS_INODE_FLAT_INLINE;
 
 		/* allocate inline buffer */
 		ibh = erofs_battach(bh, META, inode->idata_size);
-- 
2.17.1

