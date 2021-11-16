Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE836452E5F
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 10:50:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HthBG5f4nz2yfg
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 20:50:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HthB743cCz2yMq
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 20:50:07 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UwqPg0-_1637056181; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwqPg0-_1637056181) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 17:49:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 3/6] erofs-utils: mkfs: add extra blob device support
Date: Tue, 16 Nov 2021 17:49:36 +0800
Message-Id: <20211116094939.32246-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
References: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
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
Cc: Yan Song <imeoer@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In this patch, blob data from chunked-based files is redirected to
another blob file.

In order to achieve that, "--blobdev" should be used to specify
the output blob file/device for all chunk-based files, e.g.
 mkfs.erofs --blobdev blob.erofs --chunksize 4096 foo.erofs foo

Note that the upcoming RAFS v6 (EROFS-compatible on-disk format) [1]
will make full use of EROFS multiple device feature together with
Nydus [2] container image service.

[1] https://sched.co/pcdL
[2] https://github.com/dragonflyoss/image-service

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fuse/main.c               |  2 +-
 include/erofs/blobchunk.h |  3 +-
 include/erofs/cache.h     |  5 +++
 include/erofs/config.h    |  1 +
 include/erofs/internal.h  |  5 ++-
 lib/blobchunk.c           | 70 +++++++++++++++++++++++++++++++++------
 man/mkfs.erofs.1          |  3 ++
 mkfs/main.c               | 19 ++++++++++-
 8 files changed, 93 insertions(+), 15 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index a92f06882b75..255965e30969 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -154,7 +154,7 @@ static int optional_opt_func(void *data, const char *arg, int key,
 
 	switch (key) {
 	case 1:
-		ret = blob_open_ro(arg);
+		ret = blob_open_ro(arg + sizeof("--device=") - 1);
 		if (ret)
 			return -1;
 		++sbi.extra_devices;
diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index b418227e0ef8..59a47013017f 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -13,6 +13,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode);
 int erofs_blob_remap(void);
 void erofs_blob_exit(void);
-int erofs_blob_init(void);
+int erofs_blob_init(const char *blobfile_path);
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
index 08e5cfb287f2..a10ca8cc8750 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -25,6 +25,8 @@ struct erofs_blobchunk {
 static struct hashmap blob_hashmap;
 static FILE *blobfile;
 static erofs_blk_t remapped_base;
+static bool multidev;
+static struct erofs_buffer_head *bh_devt;
 
 static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 		unsigned int chunksize)
@@ -103,22 +105,28 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 {
 	struct erofs_inode_chunk_index idx = {0};
 	erofs_blk_t extent_start = EROFS_NULL_ADDR;
-	erofs_blk_t extent_end = EROFS_NULL_ADDR;
-	unsigned int dst, src, unit, num_extents;
+	erofs_blk_t extent_end, extents_blks;
+	unsigned int dst, src, unit;
 	bool first_extent = true;
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
 		if (extent_start != EROFS_NULL_ADDR &&
 		    idx.blkaddr == extent_end + 1) {
 			extent_end = idx.blkaddr;
@@ -141,11 +149,11 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	off = roundup(off, unit);
 
 	if (extent_start == EROFS_NULL_ADDR)
-		num_extents = 0;
+		extents_blks = 0;
 	else
-		num_extents = (extent_end - extent_start) + 1;
-	erofs_droid_blocklist_write_extent(inode, extent_start, num_extents,
-		first_extent, true);
+		extents_blks = (extent_end - extent_start) + 1;
+	erofs_droid_blocklist_write_extent(inode, extent_start, extents_blks,
+					   first_extent, true);
 
 	return dev_write(inode->chunkindexes, off, inode->extent_isize);
 }
@@ -208,6 +216,20 @@ int erofs_blob_remap(void)
 
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
@@ -231,16 +253,42 @@ void erofs_blob_exit(void)
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
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index c7829c3f1c8f..71a26d88121a 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -66,6 +66,9 @@ like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
 .B \-\-all-root
 Make all files owned by root.
 .TP
+.BI "\-\-blobdev " file
+Specify another extra blob device to store chunk-based data.
+.TP
 .BI "\-\-chunksize " #
 Generate chunk-based files with #-byte chunks.
 .TP
diff --git a/mkfs/main.c b/mkfs/main.c
index 2604bf2abd6b..29042c801794 100644
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
+	      " --blobdev=X           specify an extra device X to store chunked data\n"
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
@@ -360,6 +365,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	if (optind >= argc)
 		return -EINVAL;
 
+	if (cfg.c_blobdev_path && cfg.c_chunkbits < LOG_BLOCK_SIZE) {
+		erofs_err("--blobdev must be used together with --chunksize");
+		return -EINVAL;
+	}
 	cfg.c_img_path = strdup(argv[optind++]);
 	if (!cfg.c_img_path)
 		return -ENOMEM;
@@ -401,6 +410,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.extra_devices = cpu_to_le16(sbi.extra_devices),
+		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
 	};
 	const unsigned int sb_blksize =
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
@@ -549,7 +560,7 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_chunkbits) {
-		err = erofs_blob_init();
+		err = erofs_blob_init(cfg.c_blobdev_path);
 		if (err)
 			return 1;
 	}
@@ -626,6 +637,12 @@ int main(int argc, char **argv)
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

