Return-Path: <linux-erofs+bounces-769-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12FB1B03A
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Aug 2025 10:31:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bx68v6WCrz3bkL;
	Tue,  5 Aug 2025 18:31:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754382703;
	cv=none; b=YA4KqjVo58v6V6VxW8hFV0gENyGVky7OxEYohmIglNwUgMmHvnQgbKG14fAKnZTe76QdjC9PcwuLm4wR9+dGkCmZEBYK1iOnXKaURRciB6bmu71Ln/uqVpa6/RDCZJ8bZ1ai01ZD8rVAU2ninuw825U6m9SZWHnKSyc1WUkz+UP6FlFVOuQhF0APKZvOpvlxK1/OzQ4xkYjTFqRmrjtF3BcrhgZqnh2TTVsuXvi8dMnOd/xlBel4D5jgpuWI0gzl5yFde/GfHFLm6IIk9ACyJFVcgpZft+r3nSJYZZjk9pE/u0MUHaVo0vOPeR/NWakxwqgLA342NdtdgGsvvjp1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754382703; c=relaxed/relaxed;
	bh=Q9a41in1HGt5IojYB+LaEaNbu+d/gybJv+H5uzv8MoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCiNE53HeZIkdXwDDNoa5GChBZTwc8ZbS9StMHGRGO6Xs4oxL1a2KYIbxhk5vfdSGNvjVS2xEZ+gwv3fxAJO4DMo02IN0Dtshb0aukiI8/cJNwPIoi42J/UxqwWrPqykwtotbHkBsbCdsrl1R0k0Ic7zgQH+Hxu68Vcvv24xkHZMMKbq84hGuyaukMgWVDWm1fFb16+3PU2OsoimSetrJ55aPW/6Pf8b6IV5r7o6fOxZt2oyjlhzGLHq5kFLhTnAJIo4s9OEJ8aCnSjy57gvFUsZ6mBUWGs9Jy5sM3Gnpb5OGmiwhHnpTSLsOIt8JBegRNDoCemwTKo9JTrM3Y34xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nrz6p/fH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nrz6p/fH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bx68s24V4z2yLJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 18:31:39 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754382696; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q9a41in1HGt5IojYB+LaEaNbu+d/gybJv+H5uzv8MoQ=;
	b=nrz6p/fHjgFTy3DoN0vv2T+aqfZCkEGeUv89AsP67QtuEp/nHSFk3kthIUlg0zSOoeX/69Dl6PU++7XFP01Td8gIlwnUNfI8x3uiIah7bOV71iqj8cHIPhZe+DWIVJWk6FnB7RwhQqKOYOI+0J44FUVZ0k4ca3MLbEciAJmhgVI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wl4aK39_1754382693 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 16:31:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs-utils: introduce metadata compression [metabox]
Date: Tue,  5 Aug 2025 16:31:21 +0800
Message-ID: <20250805083121.3479866-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250805083121.3479866-1-hsiangkao@linux.alibaba.com>
References: <20250805083121.3479866-1-hsiangkao@linux.alibaba.com>
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

This implements metadata compression for mkfs.erofs.

It introduces a new command-line option `-m <size>[:algorithm]`.  If
specified, all inode metadata will be kept in a special inode called
`the metabox inode`.

The metabox inode will be compressed using the specified physical
cluster size <size>.  For example:

  $ mkfs.erofs -zlzma -C1048576 -m 4096 foo.erofs foo

will compress metadata in 4096-byte pclusters.

EROFS supports multiple algorithms within a filesystem, so metadata can
be compressed with a different algorithm.  For instance, LZMA may be too
slow for metadata, but users may still want to save metadata space:

  $ mkfs.erofs -zlzma -C1048576 -m4096:lz4hc,12 foo.erofs foo
Or
  $ mkfs.erofs -zlzma:lz4hc,12 -C1048576 -m4096:1 foo.erofs foo

will compress metadata in 4096-byte pclusters using LZ4HC level 12.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/blobchunk.h |   3 +-
 include/erofs/compress.h  |  11 ----
 include/erofs/config.h    |   2 +
 include/erofs/fragments.h |   5 ++
 include/erofs/internal.h  |   5 +-
 lib/Makefile.am           |   5 +-
 lib/blobchunk.c           |   6 +-
 lib/compress.c            |  26 ++++++--
 lib/config.c              |   1 +
 lib/inode.c               | 131 +++++++++++++++++++++++++-------------
 lib/liberofs_metabox.h    |  20 ++++++
 lib/metabox.c             |  78 +++++++++++++++++++++++
 mkfs/main.c               |  65 +++++++++++++++++--
 13 files changed, 284 insertions(+), 74 deletions(-)
 create mode 100644 lib/liberofs_metabox.h
 create mode 100644 lib/metabox.c

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 619155f..ef06773 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -16,7 +16,8 @@ extern "C"
 
 struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
 		erofs_blk_t blkaddr, erofs_off_t sourceoffset);
-int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
+int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
+			      erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff);
 int erofs_write_zero_inode(struct erofs_inode *inode);
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 4731a8b..d5b2519 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -30,17 +30,6 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi);
 const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
 const struct erofs_algorithm *z_erofs_list_available_compressors(int *i);
 
-static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
-{
-	erofs_nid_t packed_nid = inode->sbi->packed_nid;
-
-	if (inode->nid == EROFS_PACKED_NID_UNALLOCATED) {
-		DBG_BUGON(packed_nid != EROFS_PACKED_NID_UNALLOCATED);
-		return true;
-	}
-	return (packed_nid > 0 && inode->nid == packed_nid);
-}
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/erofs/config.h b/include/erofs/config.h
index e4d2bb3..8c40fd1 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -79,11 +79,13 @@ struct erofs_configure {
 	struct erofs_compr_opts c_compr_opts[EROFS_MAX_COMPR_CFGS];
 	char c_force_inodeversion;
 	char c_force_chunkformat;
+	u8 c_mkfs_metabox_algid;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 	u32 c_mkfs_pclustersize_max;
 	u32 c_mkfs_pclustersize_def;
 	u32 c_mkfs_pclustersize_packed;
+	s32 c_mkfs_pclustersize_metabox;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 112f002..7c7acf4 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -15,6 +15,11 @@ extern "C"
 extern const char *erofs_frags_packedname;
 #define EROFS_PACKED_INODE	erofs_frags_packedname
 
+static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
+{
+	return inode->i_srcpath == EROFS_PACKED_INODE;
+}
+
 u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos);
 int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh);
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index de6f4ea..e9b9099 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -83,11 +83,10 @@ struct erofs_xattr_prefix_item {
 	u8 infix_len;
 };
 
-#define EROFS_PACKED_NID_UNALLOCATED	-1
-
 struct erofs_mkfs_dfops;
 struct erofs_packed_inode;
 struct z_erofs_mgr;
+struct erofs_metaboxmgr;
 
 struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
@@ -149,6 +148,7 @@ struct erofs_sb_info {
 #endif
 	struct erofs_bufmgr *bmgr;
 	struct z_erofs_mgr *zmgr;
+	struct erofs_metaboxmgr *m2gr;
 	struct erofs_packed_inode *packedinode;
 	struct erofs_buffer_head *bh_devt;
 	bool useqpl;
@@ -245,6 +245,7 @@ struct erofs_inode {
 	/* inline tail-end packing size */
 	unsigned short idata_size;
 	char datasource;
+	bool in_metabox;
 	bool compressed_idata;
 	bool lazy_tailblock;
 	bool opaque;
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 688403b..0db81df 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -28,7 +28,8 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/lib/liberofs_private.h \
-      $(top_srcdir)/lib/liberofs_xxhash.h
+      $(top_srcdir)/lib/liberofs_xxhash.h \
+      $(top_srcdir)/lib/liberofs_metabox.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
@@ -36,7 +37,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
-		      vmdk.c
+		      vmdk.c metabox.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index bbc69cf..157b9a9 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -133,8 +133,8 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
 		      sizeof(ec1->sha256));
 }
 
-int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
-				   erofs_off_t off)
+int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
+			      erofs_off_t off)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_blk_t remaining_blks = BLK_ROUND_UP(sbi, inode->i_size);
@@ -202,7 +202,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 					 source_offset, zeroedlen);
 	}
 	off = roundup(off, unit);
-	return erofs_io_pwrite(&sbi->bdev, inode->chunkindexes,
+	return erofs_io_pwrite(vf, inode->chunkindexes,
 			       off, inode->extent_isize);
 }
 
diff --git a/lib/compress.c b/lib/compress.c
index 22fb5d6..0bfad3f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -25,6 +25,7 @@
 #ifdef EROFS_MT_ENABLED
 #include "erofs/workqueue.h"
 #endif
+#include "liberofs_metabox.h"
 
 #define Z_EROFS_DESTBUF_SZ	(Z_EROFS_PCLUSTER_MAX_SIZE + EROFS_MAX_BLOCK_SIZE * 2)
 
@@ -459,6 +460,8 @@ static unsigned int z_erofs_get_max_pclustersize(struct erofs_inode *inode)
 {
 	if (erofs_is_packed_inode(inode)) {
 		return cfg.c_mkfs_pclustersize_packed;
+	} else if (erofs_is_metabox_inode(inode)) {
+		return cfg.c_mkfs_pclustersize_metabox;
 #ifndef NDEBUG
 	} else if (cfg.c_random_pclusterblks) {
 		unsigned int pclusterblks =
@@ -567,7 +570,8 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
-	bool may_packing = (cfg.c_fragments && tsg && final && !is_packed_inode);
+	bool may_packing = (cfg.c_fragments && tsg && final && !is_packed_inode &&
+			    !erofs_is_metabox_inode(inode));
 	bool data_unaligned = ictx->data_unaligned;
 	bool may_inline = (cfg.c_ztailpacking && !data_unaligned && tsg &&
 			   final && !may_packing);
@@ -1247,6 +1251,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
 	bool frag = cfg.c_fragments && !erofs_is_packed_inode(inode) &&
+		!erofs_is_metabox_inode(inode) &&
 		ctx->seg_idx >= ictx->seg_num - 1;
 	int fd = ictx->fd;
 	int ret;
@@ -1764,8 +1769,9 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_compress_ictx *ictx;
-	bool all_fragments = cfg.c_all_fragments &&
-					!erofs_is_packed_inode(inode);
+	bool frag = cfg.c_fragments && !erofs_is_packed_inode(inode) &&
+		!erofs_is_metabox_inode(inode);
+	bool all_fragments = cfg.c_all_fragments && frag;
 	int ret;
 
 	/* initialize per-file compression setting */
@@ -1799,8 +1805,10 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 			return ERR_PTR(-ENOMEM);
 	}
 	ictx->fd = fd;
-
-	ictx->ccfg = &sbi->zmgr->ccfg[inode->z_algorithmtype[0]];
+	if (erofs_is_metabox_inode(inode))
+		ictx->ccfg = &sbi->zmgr->ccfg[cfg.c_mkfs_metabox_algid];
+	else
+		ictx->ccfg = &sbi->zmgr->ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 	ictx->data_unaligned = erofs_sb_has_48bit(sbi) &&
@@ -1809,7 +1817,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	if (cfg.c_fragments && !cfg.c_dedupe && !ictx->data_unaligned)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
-	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+	if (frag) {
 		ictx->tofh = z_erofs_fragments_tofh(inode, fd, fpos);
 		if (ictx == &g_ictx && cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
 			/*
@@ -2107,6 +2115,12 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		return -EINVAL;
 	}
 
+	if (cfg.c_mkfs_pclustersize_metabox > (s32)cfg.c_mkfs_pclustersize_max) {
+		erofs_err("invalid pclustersize for the metabox file %u",
+			  cfg.c_mkfs_pclustersize_metabox);
+		return -EINVAL;
+	}
+
 	if (sb_bh && erofs_sb_has_compr_cfgs(sbi)) {
 		ret = z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size);
 		if (ret)
diff --git a/lib/config.c b/lib/config.c
index 848bc59..f7c6fba 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -36,6 +36,7 @@ void erofs_init_configure(void)
 	cfg.c_uid = -1;
 	cfg.c_gid = -1;
 	cfg.c_max_decompressed_extent_bytes = -1;
+	cfg.c_mkfs_pclustersize_metabox = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index 1168dbf..08d30dd 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -28,6 +28,12 @@
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
 #include "liberofs_private.h"
+#include "liberofs_metabox.h"
+
+static inline bool erofs_is_special_identifier(const char *path)
+{
+	return path == EROFS_PACKED_INODE || path == EROFS_METABOX_INODE;
+}
 
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
@@ -143,7 +149,8 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	free(inode->compressmeta);
 	free(inode->eof_tailraw);
 	erofs_remove_ihash(inode);
-	free(inode->i_srcpath);
+	if (!erofs_is_special_identifier(inode->i_srcpath))
+		free(inode->i_srcpath);
 
 	if (inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF) {
 		erofs_diskbuf_close(inode->i_diskbuf);
@@ -375,24 +382,39 @@ static int write_dirblock(struct erofs_sb_info *sbi,
 	return erofs_blk_write(sbi, buf, blkaddr, 1);
 }
 
+#define EROFS_NID_UNALLOCATED   -1ULL
+
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *const bh = inode->bh;
 	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_off_t off, meta_offset;
+	erofs_nid_t nid;
 
-	if (bh && (long long)inode->nid <= 0) {
+	if (bh && inode->nid == EROFS_NID_UNALLOCATED) {
 		erofs_mapbh(NULL, bh->block);
 		off = erofs_btell(bh, false);
 
-		meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
-		DBG_BUGON(off < meta_offset);
-		inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
-		erofs_dbg("Assign nid %llu to file %s (mode %05o)",
-			  inode->nid, inode->i_srcpath, inode->i_mode);
+		if (!inode->in_metabox) {
+			meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
+			DBG_BUGON(off < meta_offset);
+		} else {
+			meta_offset = 0;
+		}
+
+		nid = (off - meta_offset) >> EROFS_ISLOTBITS;
+		inode->nid = nid |
+			(u64)inode->in_metabox << EROFS_DIRENT_NID_METABOX_BIT;
+		erofs_dbg("Assign nid %s%llu to file %s (mode %05o)",
+			  inode->in_metabox ? "[M]" : "", nid,
+			  inode->i_srcpath, inode->i_mode);
+	}
+	if (__erofs_unlikely(IS_ROOT(inode))) {
+		if (inode->in_metabox)
+			DBG_BUGON(!erofs_sb_has_48bit(sbi));
+		else if (inode->nid > 0xffff)
+			return sbi->root_nid;
 	}
-	if (__erofs_unlikely(IS_ROOT(inode)) && inode->nid > 0xffff)
-		return sbi->root_nid;
 	return inode->nid;
 }
 
@@ -578,6 +600,9 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 /* rules to decide whether a file could be compressed or not */
 static bool erofs_file_is_compressible(struct erofs_inode *inode)
 {
+	if (erofs_is_metabox_inode(inode) &&
+	    cfg.c_mkfs_pclustersize_metabox < 0)
+		return false;
 	if (cfg.c_compress_hints_file)
 		return z_erofs_apply_compress_hints(inode);
 	return true;
@@ -663,6 +688,8 @@ int erofs_iflush(struct erofs_inode *inode)
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_buffer_head *bh = inode->bh;
 	erofs_off_t off = erofs_iloc(inode);
+	struct erofs_bufmgr *ibmgr = inode->in_metabox ?
+				erofs_metabox_bmgr(sbi) : sbi->bmgr;
 	union {
 		struct erofs_inode_compact dic;
 		struct erofs_inode_extended die;
@@ -767,7 +794,7 @@ int erofs_iflush(struct erofs_inode *inode)
 						.iov_len = inode->xattr_isize };
 	}
 
-	ret = erofs_io_pwritev(&sbi->bdev, iov, iovcnt, off);
+	ret = erofs_io_pwritev(ibmgr->vf, iov, iovcnt, off);
 	free(xattrs);
 	if (ret != inode->inode_isize + inode->xattr_isize)
 		return ret < 0 ? ret : -EIO;
@@ -775,10 +802,10 @@ int erofs_iflush(struct erofs_inode *inode)
 	off += ret;
 	if (inode->extent_isize) {
 		if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
-			ret = erofs_blob_write_chunk_indexes(inode, off);
+			ret = erofs_write_chunk_indexes(inode, ibmgr->vf, off);
 		} else {	/* write compression metadata */
 			off = roundup(off, 8);
-			ret = erofs_io_pwrite(&sbi->bdev, inode->compressmeta,
+			ret = erofs_io_pwrite(ibmgr->vf, inode->compressmeta,
 					      off, inode->extent_isize);
 		}
 		if (ret != inode->extent_isize)
@@ -844,14 +871,16 @@ static bool erofs_inode_need_48bit(struct erofs_inode *inode)
 
 static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 {
-	struct erofs_bufmgr *bmgr = inode->sbi->bmgr;
+	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_bufmgr *bmgr = sbi->bmgr;
+	struct erofs_bufmgr *ibmgr = bmgr;
 	unsigned int inodesize;
 	struct erofs_buffer_head *bh, *ibh;
 
 	DBG_BUGON(inode->bh || inode->bh_inline);
 
 	if (erofs_inode_need_48bit(inode)) {
-		if (!erofs_sb_has_48bit(inode->sbi))
+		if (!erofs_sb_has_48bit(sbi))
 			return -ENOSPC;
 		if (inode->inode_isize == sizeof(struct erofs_inode_compact) &&
 		    inode->i_nlink != 1)
@@ -882,7 +911,13 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	bh = erofs_balloc(bmgr, INODE, inodesize, inode->idata_size);
+	if (!erofs_is_special_identifier(inode->i_srcpath) &&
+	    erofs_metabox_bmgr(sbi))
+		inode->in_metabox = true;
+
+	if (inode->in_metabox)
+		ibmgr = erofs_metabox_bmgr(sbi) ?: bmgr;
+	bh = erofs_balloc(ibmgr, INODE, inodesize, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
@@ -895,7 +930,7 @@ noinline:
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
-		bh = erofs_balloc(bmgr, INODE, inodesize, 0);
+		bh = erofs_balloc(ibmgr, INODE, inodesize, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		DBG_BUGON(inode->bh_inline);
@@ -907,7 +942,7 @@ noinline:
 			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
 				  inode->compressed_idata ? "" : "un",
 				  inode->idata_size, inode->i_srcpath);
-			erofs_sb_set_ztailpacking(inode->sbi);
+			erofs_sb_set_ztailpacking(sbi);
 		} else {
 			inode->datalayout = EROFS_INODE_FLAT_INLINE;
 			erofs_dbg("Inline tail-end data (%u bytes) to %s",
@@ -926,20 +961,24 @@ noinline:
 	bh->fsprivate = erofs_igrab(inode);
 	bh->op = &erofs_write_inode_bhops;
 	inode->bh = bh;
-	inode->i_ino[0] = ++inode->sbi->inos;  /* inode serial number */
+	inode->i_ino[0] = ++sbi->inos;	/* inode serial number */
 	return 0;
 }
 
 static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
+	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_bufmgr *ibmgr = inode->in_metabox ?
+				erofs_metabox_bmgr(sbi) : sbi->bmgr;
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = erofs_dev_write(inode->sbi, inode->idata, off, inode->idata_size);
-	if (ret)
+	ret = erofs_io_pwrite(ibmgr->vf, inode->idata, off, inode->idata_size);
+	if (ret < 0)
 		return ret;
-
+	if (ret != inode->idata_size)
+		return -EIO;
 	free(inode->idata);
 	inode->idata = NULL;
 
@@ -1048,7 +1087,7 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
 		return true;
 	if (inode->i_nlink > USHRT_MAX)
 		return true;
-	if (path != EROFS_PACKED_INODE && !cfg.c_ignore_mtime &&
+	if (!erofs_is_special_identifier(path) && !cfg.c_ignore_mtime &&
 	    !erofs_sb_has_48bit(inode->sbi) &&
 	    inode->i_mtime != inode->sbi->epoch)
 		return true;
@@ -1078,7 +1117,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	if (!cfg.fs_config_file && !cfg.mount_point)
 		return 0;
 	/* avoid loading special inodes */
-	if (path == EROFS_PACKED_INODE)
+	if (erofs_is_special_identifier(path))
 		return 0;
 
 	if (!cfg.mount_point ||
@@ -1140,7 +1179,7 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		erofs_err("gid overflow @ %s", path);
 	inode->i_gid += cfg.c_gid_offset;
 
-	if (path == EROFS_PACKED_INODE) {
+	if (erofs_is_special_identifier(path)) {
 		inode->i_mtime = sbi->epoch + sbi->build_time;
 		inode->i_mtime_nsec = sbi->fixed_nsec;
 		return 0;
@@ -1189,9 +1228,13 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		return -EINVAL;
 	}
 
-	inode->i_srcpath = strdup(path);
-	if (!inode->i_srcpath)
-		return -ENOMEM;
+	if (erofs_is_special_identifier(path)) {
+		inode->i_srcpath = (char *)path;
+	} else {
+		inode->i_srcpath = strdup(path);
+		if (!inode->i_srcpath)
+			return -ENOMEM;
+	}
 
 	if (erofs_should_use_inode_extended(inode, path)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
@@ -1226,6 +1269,7 @@ struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 	inode->dev = sbi->dev;
 	inode->i_count = 1;
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+	inode->nid = EROFS_NID_UNALLOCATED;
 
 	init_list_head(&inode->i_hash);
 	init_list_head(&inode->i_subdirs);
@@ -1269,22 +1313,28 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
 	return inode;
 }
 
-static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
+static void erofs_fixup_meta_blkaddr(struct erofs_inode *root)
 {
 	const erofs_off_t rootnid_maxoffset = 0xffff << EROFS_ISLOTBITS;
-	struct erofs_buffer_head *const bh = rootdir->bh;
-	struct erofs_sb_info *sbi = rootdir->sbi;
-	erofs_off_t off, meta_offset;
+	struct erofs_buffer_head *const bh = root->bh;
+	struct erofs_sb_info *sbi = root->sbi;
+	erofs_off_t meta_offset = 0;
+	erofs_off_t off;
 
 	erofs_mapbh(NULL, bh->block);
 	off = erofs_btell(bh, false);
-
-	if (off > rootnid_maxoffset)
-		meta_offset = round_up(off - rootnid_maxoffset, erofs_blksiz(sbi));
-	else
-		meta_offset = 0;
+	if (!root->in_metabox && off > rootnid_maxoffset)
+		meta_offset = round_up(off - rootnid_maxoffset,
+				       erofs_blksiz(sbi));
+	else if (root->in_metabox && !erofs_sb_has_48bit(sbi)) {
+		sbi->build_time = sbi->epoch;
+		sbi->epoch = max_t(s64, 0, (s64)sbi->build_time - UINT32_MAX);
+		sbi->build_time -= sbi->epoch;
+		erofs_sb_set_48bit(sbi);
+	}
 	sbi->meta_blkaddr = erofs_blknr(sbi, meta_offset);
-	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
+	root->nid = ((off - meta_offset) >> EROFS_ISLOTBITS) |
+		((u64)root->in_metabox << EROFS_DIRENT_NID_METABOX_BIT);
 }
 
 static int erofs_inode_reserve_data_blocks(struct erofs_inode *inode)
@@ -2076,7 +2126,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 	if (IS_ERR(inode))
 		return inode;
 
-	if (name == EROFS_PACKED_INODE) {
+	if (erofs_is_special_identifier(name)) {
 		st.st_uid = st.st_gid = 0;
 		st.st_nlink = 0;
 	}
@@ -2087,11 +2137,6 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 		return ERR_PTR(ret);
 	}
 
-	if (name == EROFS_PACKED_INODE) {
-		inode->sbi->packed_nid = EROFS_PACKED_NID_UNALLOCATED;
-		inode->nid = inode->sbi->packed_nid;
-	}
-
 	if (cfg.c_compr_opts[0].alg &&
 	    erofs_file_is_compressible(inode)) {
 		ictx = erofs_begin_compressed_file(inode, fd, 0);
diff --git a/lib/liberofs_metabox.h b/lib/liberofs_metabox.h
new file mode 100644
index 0000000..a783678
--- /dev/null
+++ b/lib/liberofs_metabox.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_LIB_LIBEROFS_METABOX_H
+#define __EROFS_LIB_LIBEROFS_METABOX_H
+
+#include "erofs/internal.h"
+
+extern const char *erofs_metabox_identifier;
+#define EROFS_METABOX_INODE	erofs_metabox_identifier
+
+static inline bool erofs_is_metabox_inode(struct erofs_inode *inode)
+{
+	return inode->i_srcpath == EROFS_METABOX_INODE;
+}
+
+void erofs_metabox_exit(struct erofs_sb_info *sbi);
+int erofs_metabox_init(struct erofs_sb_info *sbi);
+struct erofs_bufmgr *erofs_metabox_bmgr(struct erofs_sb_info *sbi);
+int erofs_metabox_iflush(struct erofs_sb_info *sbi);
+
+#endif
diff --git a/lib/metabox.c b/lib/metabox.c
new file mode 100644
index 0000000..a4c0822
--- /dev/null
+++ b/lib/metabox.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include <stdlib.h>
+#include "erofs/cache.h"
+#include "erofs/inode.h"
+#include "liberofs_private.h"
+#include "liberofs_metabox.h"
+
+const char *erofs_metabox_identifier = "metabox";
+
+struct erofs_metaboxmgr {
+	struct erofs_vfile vf;
+	struct erofs_bufmgr *bmgr;
+};
+
+void erofs_metabox_exit(struct erofs_sb_info *sbi)
+{
+	struct erofs_metaboxmgr *m2gr = sbi->m2gr;
+
+	if (!m2gr)
+		return;
+	DBG_BUGON(!m2gr->bmgr);
+	erofs_buffer_exit(m2gr->bmgr);
+	close(m2gr->vf.fd);
+	free(m2gr);
+}
+
+int erofs_metabox_init(struct erofs_sb_info *sbi)
+{
+	struct erofs_metaboxmgr *m2gr;
+	int ret;
+
+	m2gr = malloc(sizeof(*m2gr));
+	if (!m2gr)
+		return -ENOMEM;
+
+	ret = erofs_tmpfile();
+	if (ret < 0)
+		goto out_err;
+
+	m2gr->vf = (struct erofs_vfile){ .fd = ret };
+	m2gr->bmgr = erofs_buffer_init(sbi, 0, &m2gr->vf);
+	if (m2gr->bmgr) {
+		erofs_sb_set_metabox(sbi);
+		sbi->m2gr = m2gr;
+		return 0;
+	}
+	ret = -ENOMEM;
+out_err:
+	free(m2gr);
+	return ret;
+}
+
+struct erofs_bufmgr *erofs_metabox_bmgr(struct erofs_sb_info *sbi)
+{
+	return sbi->m2gr ? sbi->m2gr->bmgr : NULL;
+}
+
+int erofs_metabox_iflush(struct erofs_sb_info *sbi)
+{
+	struct erofs_metaboxmgr *m2gr = sbi->m2gr;
+	struct erofs_inode *inode;
+	int err;
+
+	if (!m2gr || !erofs_sb_has_metabox(sbi))
+		return -EINVAL;
+
+	err = erofs_bflush(m2gr->bmgr, NULL);
+	if (err)
+		return err;
+
+	if (erofs_io_lseek(&m2gr->vf, 0, SEEK_END) <= 0)
+		return 0;
+	inode = erofs_mkfs_build_special_from_fd(sbi, m2gr->vf.fd,
+						 EROFS_METABOX_INODE);
+	sbi->metabox_nid = erofs_lookupnid(inode);
+	erofs_iput(inode);
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 30804d1..dc2df06 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -30,6 +30,7 @@
 #include "erofs/rebuild.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
+#include "../lib/liberofs_metabox.h"
 #include "../lib/compressor.h"
 
 static struct option long_options[] = {
@@ -159,6 +160,8 @@ static void usage(int argc, char **argv)
 		" -C#                   specify the size of compress physical cluster in bytes\n"
 		" -EX[,...]             X=extended options\n"
 		" -L volume-label       set the volume label (maximum 15 bytes)\n"
+		" -m#[:X]               enable metadata compression (# = physical cluster size in bytes;\n"
+		"                                                    X = another compression algorithm for metadata)\n"
 		" -T#                   specify a fixed UNIX timestamp # as build time\n"
 		"    --all-time         the timestamp is also applied to all files (default)\n"
 		"    --mkfs-time        the timestamp is applied as build time only\n"
@@ -237,10 +240,12 @@ static void version(void)
 }
 
 static unsigned int pclustersize_packed, pclustersize_max;
+static int pclustersize_metabox = -1;
 static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
 };
 static bool tar_mode, rebuild_mode, incremental_mode;
+static u8 metabox_algorithmid;
 
 enum {
 	EROFS_MKFS_DATA_IMPORT_DEFAULT,
@@ -249,7 +254,7 @@ enum {
 	EROFS_MKFS_DATA_IMPORT_SPARSE,
 } dataimport_mode;
 
-static unsigned int rebuild_src_count;
+static unsigned int rebuild_src_count, total_ccfgs;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
@@ -575,19 +580,19 @@ static int mkfs_parse_one_compress_alg(char *alg,
 
 static int mkfs_parse_compress_algs(char *algs)
 {
-	unsigned int i;
 	char *s;
 	int ret;
 
-	for (s = strtok(algs, ":"), i = 0; s; s = strtok(NULL, ":"), ++i) {
-		if (i >= EROFS_MAX_COMPR_CFGS - 1) {
+	for (s = strtok(algs, ":"); s; s = strtok(NULL, ":")) {
+		if (total_ccfgs >= EROFS_MAX_COMPR_CFGS - 1) {
 			erofs_err("too many algorithm types");
 			return -EINVAL;
 		}
 
-		ret = mkfs_parse_one_compress_alg(s, &cfg.c_compr_opts[i]);
+		ret = mkfs_parse_one_compress_alg(s, &cfg.c_compr_opts[total_ccfgs]);
 		if (ret)
 			return ret;
+		++total_ccfgs;
 	}
 	return 0;
 }
@@ -694,7 +699,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	bool quiet = false;
 	bool has_timestamp = false;
 
-	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:Vh",
+	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:m:x:z:Vh",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -849,6 +854,25 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			pclustersize_max = i;
 			break;
+		case 'm': {
+			char *algid = strchr(optarg, ':');
+
+			if (algid) {
+				algid[0] = '\0';
+				metabox_algorithmid =
+					strtoul(algid + 1, &endptr, 0);
+				if (*endptr != '\0') {
+					err = mkfs_parse_one_compress_alg(algid + 1,
+							&cfg.c_compr_opts[total_ccfgs]);
+					if (err)
+						return err;
+					metabox_algorithmid = total_ccfgs++;
+				}
+			}
+			pclustersize_metabox = atoi(optarg);
+			break;
+		}
+
 		case 11:
 			i = strtol(optarg, &endptr, 0);
 			if (*endptr != '\0') {
@@ -1108,6 +1132,18 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_mkfs_pclustersize_packed = pclustersize_packed;
 	}
 
+	if (pclustersize_metabox >= 0) {
+		if (pclustersize_metabox &&
+		    (pclustersize_metabox < erofs_blksiz(&g_sbi) ||
+		     pclustersize_metabox % erofs_blksiz(&g_sbi))) {
+			erofs_err("invalid pcluster size %u for the metabox inode",
+				  pclustersize_metabox);
+			return -EINVAL;
+		}
+		cfg.c_mkfs_pclustersize_metabox = pclustersize_metabox;
+		cfg.c_mkfs_metabox_algid = metabox_algorithmid;
+	}
+
 	if (has_timestamp && cfg.c_timeinherit == TIMESTAMP_UNSPECIFIED)
 		cfg.c_timeinherit = TIMESTAMP_FIXED;
 	return 0;
@@ -1334,6 +1370,15 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (cfg.c_mkfs_pclustersize_metabox >= 0) {
+		err = erofs_metabox_init(&g_sbi);
+		if (err) {
+			erofs_err("failed to initialize metabox: %s",
+				  erofs_strerror(err));
+			return 1;
+		}
+	}
+
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
@@ -1541,6 +1586,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (erofs_sb_has_metabox(&g_sbi)) {
+		erofs_update_progressinfo("Handling metabox ...");
+		erofs_metabox_iflush(&g_sbi);
+		if (err)
+			goto exit;
+	}
+
 	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
 	    erofs_sb_has_fragments(&g_sbi)) {
 		erofs_update_progressinfo("Handling packed data ...");
@@ -1594,6 +1646,7 @@ int main(int argc, char **argv)
 exit:
 	if (root)
 		erofs_iput(root);
+	erofs_metabox_exit(&g_sbi);
 	z_erofs_compress_exit(&g_sbi);
 	z_erofs_dedupe_exit();
 	z_erofs_dedupe_ext_exit();
-- 
2.43.5


