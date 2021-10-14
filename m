Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF7A42D48F
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 10:10:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVMXh66Frz2xtV
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 19:10:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVMXX6j50z2xtV
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Oct 2021 19:10:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UrnWaEE_1634199010; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UrnWaEE_1634199010) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 14 Oct 2021 16:10:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH v6 2/2] erofs: add multiple device support
Date: Thu, 14 Oct 2021 16:10:10 +0800
Message-Id: <20211014081010.43485-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211010063345.28183-1-xiang@kernel.org>
References: <20211010063345.28183-1-xiang@kernel.org>
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
thus extra devices can be automatically scanned by UUID as well.

Cc: Chao Yu <chao@kernel.org>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v5:
 - update the outdated comment of on-disk device id;
 - add some description about device_id_mask: which is calculated by
   using valid bits of extra_devices + 1. Thus the rest bits can be
   used for userdata to record extra information.

 Documentation/filesystems/erofs.rst |  12 ++-
 fs/erofs/Kconfig                    |  24 +++--
 fs/erofs/data.c                     |  73 ++++++++++---
 fs/erofs/erofs_fs.h                 |  22 +++-
 fs/erofs/internal.h                 |  35 ++++++-
 fs/erofs/super.c                    | 156 ++++++++++++++++++++++++++--
 fs/erofs/zdata.c                    |  20 +++-
 7 files changed, 296 insertions(+), 46 deletions(-)

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
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 14b747026742..addfe608d08e 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -6,16 +6,22 @@ config EROFS_FS
 	select FS_IOMAP
 	select LIBCRC32C
 	help
-	  EROFS (Enhanced Read-Only File System) is a lightweight
-	  read-only file system with modern designs (eg. page-sized
-	  blocks, inline xattrs/data, etc.) for scenarios which need
-	  high-performance read-only requirements, e.g. Android OS
-	  for mobile phones and LIVECDs.
+	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
+	  file system with modern designs (e.g. no buffer heads, inline
+	  xattrs/data, chunk-based deduplication, multiple devices, etc.) for
+	  scenarios which need high-performance read-only solutions, e.g.
+	  smartphones with Android OS, LiveCDs and high-density hosts with
+	  numerous containers;
 
-	  It also provides fixed-sized output compression support,
-	  which improves storage density, keeps relatively higher
-	  compression ratios, which is more useful to achieve high
-	  performance for embedded devices with limited memory.
+	  It also provides fixed-sized output compression support in order to
+	  improve storage density as well as keep relatively higher compression
+	  ratios and implements in-place decompression to reuse the file page
+	  for compressed data temporarily with proper strategies, which is
+	  quite useful to ensure guaranteed end-to-end runtime decompression
+	  performance under extremely memory pressure without extra cost.
+
+	  See the documentation at <file:Documentation/filesystems/erofs.rst>
+	  for more details.
 
 	  If unsure, say N.
 
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9db829715652..808234d9190c 100644
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
+	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
+	struct erofs_device_info *dif;
+	int id;
+
+	/* primary device by default */
+	map->m_bdev = sb->s_bdev;
+	map->m_daxdev = EROFS_SB(sb)->dax_dev;
+
+	if (map->m_deviceid) {
+		down_read(&devs->rwsem);
+		dif = idr_find(&devs->tree, map->m_deviceid - 1);
+		if (!dif) {
+			up_read(&devs->rwsem);
+			return -ENODEV;
+		}
+		map->m_bdev = dif->bdev;
+		map->m_daxdev = dif->dax_dev;
+		up_read(&devs->rwsem);
+	} else if (devs->extra_devices) {
+		down_read(&devs->rwsem);
+		idr_for_each_entry(&devs->tree, dif, id) {
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
+		up_read(&devs->rwsem);
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
index b0b23f41abc3..d5d74a469281 100644
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
+	__le32 blocks;			/* total fs blocks of this device */
+	__le32 mapped_blkaddr;		/* map starting at mapped_blkaddr */
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
@@ -238,7 +253,7 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 /* 8-byte inode chunk indexes */
 struct erofs_inode_chunk_index {
 	__le16 advise;		/* always 0, don't care for now */
-	__le16 device_id;	/* back-end storage id, always 0 for now */
+	__le16 device_id;	/* back-end storage id (with bits masked) */
 	__le32 blkaddr;		/* start block address of this inode chunk */
 };
 
@@ -384,6 +399,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	/* keep in sync between 2 index structures for better extendibility */
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
 		     sizeof(struct z_erofs_vle_decompressed_index));
+	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
 	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b1b9d1b5cb66..0661d7d6969a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,6 +47,15 @@ typedef u64 erofs_off_t;
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
 struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
@@ -60,8 +69,16 @@ struct erofs_mount_opts {
 	unsigned int mount_opt;
 };
 
+struct erofs_dev_context {
+	struct idr tree;
+	struct rw_semaphore rwsem;
+
+	unsigned int extra_devices;
+};
+
 struct erofs_fs_context {
 	struct erofs_mount_opts opt;
+	struct erofs_dev_context *devs;
 };
 
 /* all filesystem-wide lz4 configurations */
@@ -74,7 +91,6 @@ struct erofs_sb_lz4_info {
 
 struct erofs_sb_info {
 	struct erofs_mount_opts opt;	/* options */
-
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
 	struct list_head list;
@@ -91,12 +107,16 @@ struct erofs_sb_info {
 
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
+	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
-	u32 blocks;
+	u64 total_blocks;
+	u32 primarydevice_blocks;
+
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
 	u32 xattr_blkaddr;
 #endif
+	u16 device_id_mask;	/* valid bits of device id to be used */
 
 	/* inode slot unit size in bit shift */
 	unsigned char islotbits;
@@ -241,6 +261,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
+EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -359,6 +380,7 @@ struct erofs_map_blocks {
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
 
+	unsigned short m_deviceid;
 	unsigned int m_flags;
 
 	struct page *mpage;
@@ -390,9 +412,18 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
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
index 25f6b8b37f28..b8f042c3e7e6 100644
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
+	if (ondisk_extradevs != sbi->devs->extra_devices) {
+		erofs_err(sb, "extra devices don't match (ondisk %u, given %u)",
+			  ondisk_extradevs, sbi->devs->extra_devices);
+		return -EINVAL;
+	}
+	if (!ondisk_extradevs)
+		return 0;
+
+	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
+	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
+	down_read(&sbi->devs->rwsem);
+	idr_for_each_entry(&sbi->devs->tree, dif, id) {
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
+				up_read(&sbi->devs->rwsem);
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
+	up_read(&sbi->devs->rwsem);
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
 
@@ -412,9 +492,10 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
-	struct erofs_fs_context *ctx __maybe_unused = fc->fs_private;
+	struct erofs_fs_context *ctx = fc->fs_private;
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
+		down_write(&ctx->devs->rwsem);
+		ret = idr_alloc(&ctx->devs->tree, dif, 0, 0, GFP_KERNEL);
+		up_write(&ctx->devs->rwsem);
+		if (ret < 0) {
+			kfree(dif->path);
+			kfree(dif);
+			return ret;
+		}
+		++ctx->devs->extra_devices;
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -542,6 +642,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
 	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->devs = ctx->devs;
+	ctx->devs = NULL;
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -617,9 +720,33 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
+static int erofs_release_device_info(int id, void *ptr, void *data)
+{
+	struct erofs_device_info *dif = ptr;
+
+	fs_put_dax(dif->dax_dev);
+	if (dif->bdev)
+		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
+	kfree(dif->path);
+	kfree(dif);
+	return 0;
+}
+
+static void erofs_free_dev_context(struct erofs_dev_context *devs)
+{
+	if (!devs)
+		return;
+	idr_for_each(&devs->tree, &erofs_release_device_info, NULL);
+	idr_destroy(&devs->tree);
+	kfree(devs);
+}
+
 static void erofs_fc_free(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct erofs_fs_context *ctx = fc->fs_private;
+
+	erofs_free_dev_context(ctx->devs);
+	kfree(ctx);
 }
 
 static const struct fs_context_operations erofs_context_ops = {
@@ -631,13 +758,20 @@ static const struct fs_context_operations erofs_context_ops = {
 
 static int erofs_init_fs_context(struct fs_context *fc)
 {
-	fc->fs_private = kzalloc(sizeof(struct erofs_fs_context), GFP_KERNEL);
-	if (!fc->fs_private)
-		return -ENOMEM;
+	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 
-	/* set default mount options */
-	erofs_default_options(fc->fs_private);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
+	if (!ctx->devs) {
+		kfree(ctx);
+		return -ENOMEM;
+	}
+	fc->fs_private = ctx;
 
+	idr_init(&ctx->devs->tree);
+	init_rwsem(&ctx->devs->rwsem);
+	erofs_default_options(ctx);
 	fc->ops = &erofs_context_ops;
 	return 0;
 }
@@ -657,6 +791,8 @@ static void erofs_kill_sb(struct super_block *sb)
 	sbi = EROFS_SB(sb);
 	if (!sbi)
 		return;
+
+	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -746,7 +882,7 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = EROFS_BLKSIZ;
-	buf->f_blocks = sbi->blocks;
+	buf->f_blocks = sbi->total_blocks;
 	buf->f_bfree = buf->f_bavail = 0;
 
 	buf->f_files = ULLONG_MAX;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e59e22852c78..8c947ed49299 100644
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

