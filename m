Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43244E664
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 13:31:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrHyj5knYz305F
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 23:31:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrHyf3C5zz2xtf
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 23:31:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UwBaAUF_1636720289; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwBaAUF_1636720289) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 12 Nov 2021 20:31:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: add extra blob device support
Date: Fri, 12 Nov 2021 20:31:28 +0800
Message-Id: <20211112123128.126741-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211112123128.126741-1-hsiangkao@linux.alibaba.com>
References: <20211112123128.126741-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In this patch, blob data from chunked-based files is redirected to
another blob file.

In order to redirect that, "--blobdev" should be used to specify
the output blob file/device for all chunk-based files, e.g.
 mkfs.erofs --blobdev blob.erofs --chunksize 4096 foo.erofs foo

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fuse/main.c               |  2 +-
 include/erofs/blobchunk.h |  3 +-
 include/erofs/cache.h     |  5 ++++
 include/erofs/config.h    |  1 +
 include/erofs/internal.h  |  5 +++-
 lib/blobchunk.c           | 58 +++++++++++++++++++++++++++++++++++----
 mkfs/main.c               | 15 +++++++++-
 7 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 21939cd15923..de494b79b8ad 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -153,7 +153,7 @@ static int optional_opt_func(void *data, const char *arg, int key,
 
 	switch (key) {
 	case 1:
-		ret = blob_open_ro(arg);
+		ret = blob_open_ro(arg + sizeof("--device=") - 1);
 		if (ret)
 			return -1;
 		++sbi.extra_devices;
diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index b418227e0ef8..85efe0f1687f 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -13,6 +13,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode);
 int erofs_blob_remap(void);
 void erofs_blob_exit(void);
-int erofs_blob_init(void);
+int erofs_blob_init(const char *);
+int erofs_generate_devtable(void);
 
 #endif
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index e324d929b0b9..b19d54e1b4f4 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -19,6 +19,8 @@ struct erofs_buffer_block;
 #define INODE		2
 /* shared xattrs */
 #define XATTR		3
+/* device table */
+#define DEVT		4
 
 struct erofs_bhops {
 	bool (*preflush)(struct erofs_buffer_head *bh);
@@ -56,6 +58,9 @@ static inline const int get_alignsize(int type, int *type_ret)
 	} else if (type == XATTR) {
 		*type_ret = META;
 		return sizeof(struct erofs_xattr_entry);
+	} else if (type == DEVT) {
+		*type_ret = META;
+		return EROFS_DEVT_SLOT_SIZE;
 	}
 
 	if (type == META)
diff --git a/include/erofs/config.h b/include/erofs/config.h
index a18c88301279..8d459c692dac 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -51,6 +51,7 @@ struct erofs_configure {
 	/* related arguments for mkfs.erofs */
 	char *c_img_path;
 	char *c_src_path;
+	char *c_blobdev_path;
 	char *c_compress_hints_file;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 974c069baa4f..f22a016373ca 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -93,7 +93,10 @@ struct erofs_sb_info {
 
 	u32 checksum;
 	u16 extra_devices;
-	u16 device_id_mask;
+	union {
+		u16 devt_slotoff;		/* used for mkfs */
+		u16 device_id_mask;		/* used for others */
+	};
 };
 
 /* global sbi */
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a0ff79c748c6..96d1d49e92f9 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -24,6 +24,8 @@ struct erofs_blobchunk {
 static struct hashmap blob_hashmap;
 static FILE *blobfile;
 static erofs_blk_t remapped_base;
+static bool multidev;
+static struct erofs_buffer_head *bh_devt;
 
 static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 		unsigned int chunksize)
@@ -102,19 +104,25 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 {
 	struct erofs_inode_chunk_index idx = {0};
 	unsigned int dst, src, unit;
+	erofs_blk_t base_blkaddr = 0;
 
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
 	else
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
+	if (multidev)
+		idx.device_id = 1;
+	else
+		base_blkaddr = remapped_base;
+
 	for (dst = src = 0; dst < inode->extent_isize;
 	     src += sizeof(void *), dst += unit) {
 		struct erofs_blobchunk *chunk;
 
 		chunk = *(void **)(inode->chunkindexes + src);
 
-		idx.blkaddr = chunk->blkaddr + remapped_base;
+		idx.blkaddr = base_blkaddr + chunk->blkaddr;
 		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
 			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
 		else
@@ -183,6 +191,20 @@ int erofs_blob_remap(void)
 
 	fflush(blobfile);
 	length = ftell(blobfile);
+	if (multidev) {
+		struct erofs_deviceslot dis = {
+			.blocks = erofs_blknr(length),
+		};
+
+		pos_out = erofs_btell(bh_devt, false);
+		ret = dev_write(&dis, pos_out, sizeof(dis));
+		if (ret)
+			return ret;
+
+		bh_devt->op = &erofs_drop_directly_bhops;
+		erofs_bdrop(bh_devt, false);
+		return 0;
+	}
 	bh = erofs_balloc(DATA, length, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
@@ -206,16 +228,42 @@ void erofs_blob_exit(void)
 	hashmap_free(&blob_hashmap, 1);
 }
 
-int erofs_blob_init(void)
+int erofs_blob_init(const char *blobfile_path)
 {
+	if (!blobfile_path) {
 #ifdef HAVE_TMPFILE64
-	blobfile = tmpfile64();
+		blobfile = tmpfile64();
 #else
-	blobfile = tmpfile();
+		blobfile = tmpfile();
 #endif
+		multidev = false;
+	} else {
+		blobfile = fopen(blobfile_path, "wb");
+		multidev = true;
+	}
 	if (!blobfile)
-		return -ENOMEM;
+		return -EACCES;
 
 	hashmap_init(&blob_hashmap, erofs_blob_hashmap_cmp, 0);
 	return 0;
 }
+
+int erofs_generate_devtable(void)
+{
+	struct erofs_deviceslot dis;
+
+	if (!multidev)
+		return 0;
+
+	bh_devt = erofs_balloc(DEVT, sizeof(dis), 0, 0);
+	if (IS_ERR(bh_devt))
+		return PTR_ERR(bh_devt);
+
+	dis = (struct erofs_deviceslot) {};
+	erofs_mapbh(bh_devt->block);
+	bh_devt->op = &erofs_skip_write_bhops;
+	sbi.devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
+	sbi.extra_devices = 1;
+	erofs_sb_set_device_table();
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 2604bf2abd6b..740e67be6d13 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -47,6 +47,7 @@ static struct option long_options[] = {
 	{"compress-hints", required_argument, NULL, 10},
 	{"chunksize", required_argument, NULL, 11},
 	{"quiet", no_argument, 0, 12},
+	{"blobdev", required_argument, NULL, 13},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -83,6 +84,7 @@ static void usage(void)
 	      " -UX                   use a given filesystem UUID\n"
 #endif
 	      " --all-root            make all files owned by root\n"
+	      " --blobdev=X           specify an extra device X for chunk data\n"
 	      " --chunksize=#         generate chunk-based files with #-byte chunks\n"
 	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
 	      " --exclude-path=X      avoid including file X (X = exact literal path)\n"
@@ -348,6 +350,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 12:
 			quiet = true;
 			break;
+		case 13:
+			cfg.c_blobdev_path = optarg;
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -401,6 +406,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.extra_devices = cpu_to_le16(sbi.extra_devices),
+		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -549,7 +556,7 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_chunkbits) {
-		err = erofs_blob_init();
+		err = erofs_blob_init(cfg.c_blobdev_path);
 		if (err)
 			return 1;
 	}
@@ -626,6 +633,12 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	err = erofs_generate_devtable();
+	if (err) {
+		erofs_err("Failed to generate device table: %s",
+			  erofs_strerror(err));
+		goto exit;
+	}
 #ifdef HAVE_LIBUUID
 	uuid_unparse_lower(sbi.uuid, uuid_str);
 #endif
-- 
2.24.4

