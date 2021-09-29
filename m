Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D641BCB4
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Sep 2021 04:26:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HK0br2y0Qz2yPJ
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Sep 2021 12:26:00 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HK0bg2y1Fz2yK4
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Sep 2021 12:25:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0Uq-9wgd_1632882324; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uq-9wgd_1632882324) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 29 Sep 2021 10:25:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [RFC PATCH v2] erofs: add multiple device support
Date: Wed, 29 Sep 2021 10:25:21 +0800
Message-Id: <20210929022521.148059-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210928081608.9255-1-hsiangkao@linux.alibaba.com>
References: <20210928081608.9255-1-hsiangkao@linux.alibaba.com>
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
Cc: Yan Song <imeoer@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to support multi-layer container images, add multiple
device feature to EROFS. Two ways are available to use for now:

 - Devices can be mapped into 32-bit global block address space;
 - Device ID can be specified with the chunk indexes format.

Note that it assumes no extent would cross device boundary and mkfs
should take care of it seriously.

In the future, a dedicated device manager could be introduced then
so extra devices can be automatically scanned by uuid as well.

Cc: Liu Bo <bo.liu@linux.alibaba.com>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since RFC v1:
 - fix a 0day CI sparse report:
sparse warnings: (new ones prefixed by >>)
>> fs/erofs/data.c:139:38: sparse: sparse: restricted __le16 degrades to integer

 Documentation/filesystems/erofs.rst |  12 ++-
 fs/erofs/data.c                     |  73 ++++++++++++---
 fs/erofs/erofs_fs.h                 |  20 ++++-
 fs/erofs/internal.h                 |  28 +++++-
 fs/erofs/super.c                    | 133 ++++++++++++++++++++++++++--
 fs/erofs/zdata.c                    |  20 +++--
 6 files changed, 253 insertions(+), 33 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index b97579b7d8fb..01df283c7d04 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -19,9 +19,10 @@ It is designed as a better filesystem solution for the following scenarios:
    immutable and bit-for-bit identical to the official golden image for
    their releases due to security and other considerations and
 
- - hope to save some extra storage space with guaranteed end-to-end performance
-   by using reduced metadata and transparent file compression, especially
-   for those embedded devices with limited memory (ex, smartphone);
+ - hope to minimize extra storage space with guaranteed end-to-end performance
+   by using compact layout, transparent file compression and direct access,
+   especially for those embedded devices with limited memory and high-density
+   hosts with numerous containers;
 
 Here is the main features of EROFS:
 
@@ -51,7 +52,9 @@ Here is the main features of EROFS:
  - Support POSIX.1e ACLs by using xattrs;
 
  - Support transparent data compression as an option:
-   LZ4 algorithm with the fixed-sized output compression for high performance.
+   LZ4 algorithm with the fixed-sized output compression for high performance;
+
+ - Multiple device support for multi-layer container images.
 
 The following git tree provides the file system user-space tools under
 development (ex, formatting tool mkfs.erofs):
@@ -87,6 +90,7 @@ cache_strategy=%s      Select a strategy for cached decompression from now on:
 dax={always,never}     Use direct access (no page cache).  See
                        Documentation/filesystems/dax.rst.
 dax                    A legacy option which is an alias for ``dax=always``.
+device=%s              Specify a path to an extra device to be used together.
 ===================    =========================================================
 
 On-disk details
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9db829715652..833e9bd88b3e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -89,6 +89,7 @@ static int erofs_map_blocks(struct inode *inode,
 	erofs_off_t pos;
 	int err = 0;
 
+	map->m_deviceid = 0;
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
@@ -135,14 +136,8 @@ static int erofs_map_blocks(struct inode *inode,
 		map->m_flags = 0;
 		break;
 	default:
-		/* only one device is supported for now */
-		if (idx->device_id) {
-			erofs_err(sb, "invalid device id %u @ %llu for nid %llu",
-				  le16_to_cpu(idx->device_id),
-				  chunknr, vi->nid);
-			err = -EFSCORRUPTED;
-			goto out_unlock;
-		}
+		map->m_deviceid = le16_to_cpu(idx->device_id) &
+			EROFS_SB(sb)->device_id_mask;
 		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
@@ -155,11 +150,55 @@ static int erofs_map_blocks(struct inode *inode,
 	return err;
 }
 
+int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_device_info *dif;
+	int id;
+
+	/* primary device by default */
+	map->m_bdev = sb->s_bdev;
+	map->m_daxdev = sbi->dax_dev;
+
+	if (map->m_deviceid) {
+		down_read(&sbi->ctx.devinfo_rwsem);
+		dif = idr_find(&sbi->ctx.devinfo, map->m_deviceid - 1);
+		if (!dif) {
+			up_read(&sbi->ctx.devinfo_rwsem);
+			return -ENODEV;
+		}
+		map->m_bdev = dif->bdev;
+		map->m_daxdev = dif->dax_dev;
+		up_read(&sbi->ctx.devinfo_rwsem);
+	} else if (sbi->ctx.extra_devices) {
+		down_read(&sbi->ctx.devinfo_rwsem);
+		idr_for_each_entry(&sbi->ctx.devinfo, dif, id) {
+			erofs_off_t startoff, length;
+
+			if (!dif->mapped_blkaddr)
+				continue;
+			startoff = blknr_to_addr(dif->mapped_blkaddr);
+			length = blknr_to_addr(dif->blocks);
+
+			if (map->m_pa >= startoff &&
+			    map->m_pa < startoff + length) {
+				map->m_pa -= startoff;
+				map->m_bdev = dif->bdev;
+				map->m_daxdev = dif->dax_dev;
+				break;
+			}
+		}
+		up_read(&sbi->ctx.devinfo_rwsem);
+	}
+	return 0;
+}
+
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	int ret;
 	struct erofs_map_blocks map;
+	struct erofs_map_dev mdev;
 
 	map.m_la = offset;
 	map.m_llen = length;
@@ -168,8 +207,16 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 
-	iomap->bdev = inode->i_sb->s_bdev;
-	iomap->dax_dev = EROFS_I_SB(inode)->dax_dev;
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map.m_deviceid,
+		.m_pa = map.m_pa,
+	};
+	ret = erofs_map_dev(inode->i_sb, &mdev);
+	if (ret)
+		return ret;
+
+	iomap->bdev = mdev.m_bdev;
+	iomap->dax_dev = mdev.m_daxdev;
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
@@ -188,15 +235,15 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 		iomap->type = IOMAP_INLINE;
 		ipage = erofs_get_meta_page(inode->i_sb,
-					    erofs_blknr(map.m_pa));
+					    erofs_blknr(mdev.m_pa));
 		if (IS_ERR(ipage))
 			return PTR_ERR(ipage);
 		iomap->inline_data = page_address(ipage) +
-					erofs_blkoff(map.m_pa);
+					erofs_blkoff(mdev.m_pa);
 		iomap->private = ipage;
 	} else {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_pa;
+		iomap->addr = mdev.m_pa;
 	}
 	return 0;
 }
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b0b23f41abc3..c2f1c2453a55 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -21,14 +21,27 @@
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
@@ -54,7 +67,9 @@ struct erofs_super_block {
 		/* customized sliding window size instead of 64k by default */
 		__le16 lz4_max_distance;
 	} __packed u1;
-	__u8 reserved2[42];
+	__le16 extra_devices;	/* # of devices besides the primary device */
+	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
+	__u8 reserved2[38];
 };
 
 /*
@@ -384,6 +399,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	/* keep in sync between 2 index structures for better extendibility */
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
 		     sizeof(struct z_erofs_vle_decompressed_index));
+	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
 	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9524e155b38f..91f67663e384 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,7 +47,18 @@ typedef u64 erofs_off_t;
 /* data type for filesystem-wide blocks number */
 typedef u32 erofs_blk_t;
 
+struct erofs_device_info {
+	char *path;
+	struct block_device *bdev;
+	struct dax_device *dax_dev;
+
+	u32 blocks;
+	u32 mapped_blkaddr;
+};
+
 struct erofs_fs_context {
+	struct idr devinfo;
+	struct rw_semaphore devinfo_rwsem;
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
@@ -58,6 +69,7 @@ struct erofs_fs_context {
 	unsigned int max_sync_decompress_pages;
 #endif
 	unsigned int mount_opt;
+	unsigned int extra_devices;
 };
 
 /* all filesystem-wide lz4 configurations */
@@ -86,11 +98,14 @@ struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct dax_device *dax_dev;
-	u32 blocks;
+	u64 total_blocks;
+	u32 primarydevice_blocks;
+
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
 	u32 xattr_blkaddr;
 #endif
+	u16 device_id_mask;
 
 	/* inode slot unit size in bit shift */
 	unsigned char islotbits;
@@ -237,6 +252,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
+EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -355,6 +371,7 @@ struct erofs_map_blocks {
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
 
+	unsigned int m_deviceid;
 	unsigned int m_flags;
 
 	struct page *mpage;
@@ -386,9 +403,18 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+struct erofs_map_dev {
+	struct block_device *m_bdev;
+	struct dax_device *m_daxdev;
+
+	erofs_off_t m_pa;
+	unsigned int m_deviceid;
+};
+
 /* data.c */
 extern const struct file_operations erofs_file_fops;
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
+int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 11b88559f8bf..d940d5ae74a0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -252,6 +252,79 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 }
 #endif
 
+static int erofs_init_devices(struct super_block *sb,
+			      struct erofs_super_block *dsb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	unsigned int ondisk_extradevs;
+	erofs_off_t pos;
+	struct page *page = NULL;
+	struct erofs_device_info *dif;
+	struct erofs_deviceslot *dis;
+	void *ptr;
+	int id, err = 0;
+
+	sbi->total_blocks = sbi->primarydevice_blocks;
+	if (!erofs_sb_has_device_table(sbi))
+		ondisk_extradevs = 0;
+	else
+		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
+
+	if (ondisk_extradevs != sbi->ctx.extra_devices) {
+		erofs_err(sb, "extra devices don't match (ondisk %u, given %u)",
+			  ondisk_extradevs, sbi->ctx.extra_devices);
+		return -EINVAL;
+	}
+	if (!ondisk_extradevs)
+		return 0;
+
+	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
+	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
+	down_read(&sbi->ctx.devinfo_rwsem);
+	idr_for_each_entry(&sbi->ctx.devinfo, dif, id) {
+		erofs_blk_t blk = erofs_blknr(pos);
+		struct block_device *bdev;
+
+		if (!page || page->index != blk) {
+			if (page) {
+				kunmap(page);
+				unlock_page(page);
+				put_page(page);
+			}
+
+			page = erofs_get_meta_page(sb, blk);
+			if (IS_ERR(page)) {
+				up_read(&sbi->ctx.devinfo_rwsem);
+				return PTR_ERR(page);
+			}
+			ptr = kmap(page);
+		}
+		dis = ptr + erofs_blkoff(pos);
+
+		bdev = blkdev_get_by_path(dif->path,
+					  FMODE_READ | FMODE_EXCL,
+					  sb->s_type);
+		if (IS_ERR(bdev)) {
+			err = PTR_ERR(bdev);
+			goto err_out;
+		}
+		dif->bdev = bdev;
+		dif->dax_dev = fs_dax_get_by_bdev(bdev);
+		dif->blocks = le32_to_cpu(dis->blocks);
+		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
+		sbi->total_blocks += dif->blocks;
+		pos += sizeof(*dis);
+	}
+err_out:
+	up_read(&sbi->ctx.devinfo_rwsem);
+	if (page) {
+		kunmap(page);
+		unlock_page(page);
+		put_page(page);
+	}
+	return err;
+}
+
 static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
@@ -303,7 +376,7 @@ static int erofs_read_superblock(struct super_block *sb)
 			  sbi->sb_size);
 		goto out;
 	}
-	sbi->blocks = le32_to_cpu(dsb->blocks);
+	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
@@ -330,6 +403,11 @@ static int erofs_read_superblock(struct super_block *sb)
 		ret = erofs_load_compr_cfgs(sb, dsb);
 	else
 		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	if (ret < 0)
+		goto out;
+
+	/* handle multiple devices */
+	ret = erofs_init_devices(sb, dsb);
 out:
 	kunmap(page);
 	put_page(page);
@@ -358,6 +436,7 @@ enum {
 	Opt_cache_strategy,
 	Opt_dax,
 	Opt_dax_enum,
+	Opt_device,
 	Opt_err
 };
 
@@ -381,6 +460,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 		     erofs_param_cache_strategy),
 	fsparam_flag("dax",             Opt_dax),
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
+	fsparam_string("device",	Opt_device),
 	{}
 };
 
@@ -414,7 +494,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 {
 	struct erofs_fs_context *ctx __maybe_unused = fc->fs_private;
 	struct fs_parse_result result;
-	int opt;
+	struct erofs_device_info *dif;
+	int opt, ret;
 
 	opt = fs_parse(fc, erofs_fs_parameters, param, &result);
 	if (opt < 0)
@@ -456,6 +537,25 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!erofs_fc_set_dax_mode(fc, result.uint_32))
 			return -EINVAL;
 		break;
+	case Opt_device:
+		dif = kzalloc(sizeof(*dif), GFP_KERNEL);
+		if (!dif)
+			return -ENOMEM;
+		dif->path = kstrdup(param->string, GFP_KERNEL);
+		if (!dif->path) {
+			kfree(dif);
+			return -ENOMEM;
+		}
+		down_write(&ctx->devinfo_rwsem);
+		ret = idr_alloc(&ctx->devinfo, dif, 0, 0, GFP_KERNEL);
+		up_write(&ctx->devinfo_rwsem);
+		if (ret < 0) {
+			kfree(dif->path);
+			kfree(dif);
+			return ret;
+		}
+		++ctx->extra_devices;
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -541,6 +641,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->ctx = *ctx;
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -562,8 +664,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
-	sbi->ctx = *ctx;
-
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
 #endif
@@ -632,15 +732,29 @@ static const struct fs_context_operations erofs_context_ops = {
 
 static int erofs_init_fs_context(struct fs_context *fc)
 {
+	struct erofs_fs_context *ctx;
+
 	fc->fs_private = kzalloc(sizeof(struct erofs_fs_context), GFP_KERNEL);
 	if (!fc->fs_private)
 		return -ENOMEM;
 
-	/* set default mount options */
-	erofs_default_options(fc->fs_private);
-
+	ctx = fc->fs_private;
+	idr_init(&ctx->devinfo);
+	init_rwsem(&ctx->devinfo_rwsem);
+	erofs_default_options(ctx);
 	fc->ops = &erofs_context_ops;
+	return 0;
+}
 
+static int erofs_release_device_info(int id, void *ptr, void *data)
+{
+	struct erofs_device_info *dif = ptr;
+
+	fs_put_dax(dif->dax_dev);
+	if (dif->bdev)
+		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
+	kfree(dif->path);
+	kfree(dif);
 	return 0;
 }
 
@@ -659,6 +773,9 @@ static void erofs_kill_sb(struct super_block *sb)
 	sbi = EROFS_SB(sb);
 	if (!sbi)
 		return;
+
+	idr_for_each(&sbi->ctx.devinfo, &erofs_release_device_info, NULL);
+	idr_destroy(&sbi->ctx.devinfo);
 	fs_put_dax(sbi->dax_dev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -748,7 +865,7 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = EROFS_BLKSIZ;
-	buf->f_blocks = sbi->blocks;
+	buf->f_blocks = sbi->total_blocks;
 	buf->f_bfree = buf->f_bavail = 0;
 
 	buf->f_files = ULLONG_MAX;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 11c7a1aaebad..e9bc6537043a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1266,8 +1266,9 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	void *bi_private;
 	z_erofs_next_pcluster_t owned_head = f->clt.owned_head;
-	/* since bio will be NULL, no need to initialize last_index */
+	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
 	pgoff_t last_index;
+	struct block_device *last_bdev;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
 
@@ -1279,6 +1280,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	q[JQ_SUBMIT]->head = owned_head;
 
 	do {
+		struct erofs_map_dev mdev;
 		struct z_erofs_pcluster *pcl;
 		pgoff_t cur, end;
 		unsigned int i = 0;
@@ -1290,7 +1292,13 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
-		cur = pcl->obj.index;
+		/* no device id here, thus it will always succeed */
+		mdev = (struct erofs_map_dev) {
+			.m_pa = blknr_to_addr(pcl->obj.index),
+		};
+		(void)erofs_map_dev(sb, &mdev);
+
+		cur = erofs_blknr(mdev.m_pa);
 		end = cur + pcl->pclusterpages;
 
 		/* close the main owned chain at first */
@@ -1306,7 +1314,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			if (!page)
 				continue;
 
-			if (bio && cur != last_index + 1) {
+			if (bio && (cur != last_index + 1 ||
+				    last_bdev != mdev.m_bdev)) {
 submit_bio_retry:
 				submit_bio(bio);
 				bio = NULL;
@@ -1314,9 +1323,10 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 			if (!bio) {
 				bio = bio_alloc(GFP_NOIO, BIO_MAX_VECS);
-
 				bio->bi_end_io = z_erofs_decompressqueue_endio;
-				bio_set_dev(bio, sb->s_bdev);
+
+				bio_set_dev(bio, mdev.m_bdev);
+				last_bdev = mdev.m_bdev;
 				bio->bi_iter.bi_sector = (sector_t)cur <<
 					LOG_SECTORS_PER_BLOCK;
 				bio->bi_private = bi_private;
-- 
2.24.4

