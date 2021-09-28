Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6FC41AFAC
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 15:10:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJfxR0SCHz2yPw
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 23:10:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJfxL3WrRz2xth
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 23:09:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R801e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0UpwpOLa_1632834572; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpwpOLa_1632834572) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Sep 2021 21:09:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH] erofs-utils: add extra blob device support
Date: Tue, 28 Sep 2021 21:09:30 +0800
Message-Id: <20210928130930.204516-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Yan Song <imeoer@linux.alibaba.com>
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
 include/erofs/blobchunk.h |  3 +-
 include/erofs/cache.h     |  5 ++++
 include/erofs/config.h    |  1 +
 include/erofs/internal.h  |  4 +++
 include/erofs_fs.h        | 19 +++++++++++--
 lib/blobchunk.c           | 58 +++++++++++++++++++++++++++++++++++----
 mkfs/main.c               | 15 +++++++++-
 7 files changed, 96 insertions(+), 9 deletions(-)

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
index 574dd52be12d..072a4c519578 100644
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
index 8b154edb9f88..74d0c6c59174 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -82,6 +82,9 @@ struct erofs_sb_info {
 
 	u16 available_compr_algs;
 	u16 lz4_max_distance;
+
+	u16 extra_devices;
+	u16 devt_slotoff;
 };
 
 /* global sbi */
@@ -110,6 +113,7 @@ EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
+EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 66a68e3b2065..745d925378f6 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -22,14 +22,27 @@
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
+#define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
 	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
-	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
+	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
+	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
+struct erofs_deviceslot {
+	union {
+		u8 uuid[16];		/* used for device manager later */
+		u8 userdata[64];	/* digest(sha256), etc. */
+	} u;
+	__le32 blocks;
+	__le32 mapped_blkaddr;
+	u8 reserved[56];
+};
+#define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
+
 /* erofs on-disk super block (currently 128 bytes) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
@@ -55,7 +68,9 @@ struct erofs_super_block {
 		/* customized sliding window size instead of 64k by default */
 		__le16 lz4_max_distance;
 	} __packed u1;
-	__u8 reserved2[42];
+	__le16 extra_devices;	/* # of devices besides the primary device */
+	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
+	__u8 reserved2[38];
 };
 
 /*
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 661c5d0121a8..79f775e66f63 100644
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
index 1c8dea55f0cd..aadb3390a19d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -46,6 +46,7 @@ static struct option long_options[] = {
 	{"max-extent-bytes", required_argument, NULL, 9},
 	{"compress-hints", required_argument, NULL, 10},
 	{"chunksize", required_argument, NULL, 11},
+	{"blobdev", required_argument, NULL, 12},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -82,6 +83,7 @@ static void usage(void)
 	      " -UX                   use a given filesystem UUID\n"
 #endif
 	      " --all-root            make all files owned by root\n"
+	      " --blobdev=X           specify an extra device X for chunk data\n"
 	      " --chunksize=#         generate chunk-based files with #-byte chunks\n"
 	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
 	      " --exclude-path=X      avoid including file X (X = exact literal path)\n"
@@ -344,6 +346,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			erofs_sb_set_chunked_file();
 			erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
 			break;
+		case 12:
+			cfg.c_blobdev_path = optarg;
+			break;
 
 		case 1:
 			usage();
@@ -396,6 +401,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.extra_devices = cpu_to_le16(sbi.extra_devices),
+		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -552,7 +559,7 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_chunkbits) {
-		err = erofs_blob_init();
+		err = erofs_blob_init(cfg.c_blobdev_path);
 		if (err)
 			return 1;
 	}
@@ -628,6 +635,12 @@ int main(int argc, char **argv)
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

