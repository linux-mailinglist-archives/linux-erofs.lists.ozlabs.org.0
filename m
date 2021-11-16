Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A54A452E5C
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 10:50:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HthBB1P40z2xvc
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 20:50:10 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HthB050x2z2xCN
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 20:49:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R841e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UwqPg0-_1637056181; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwqPg0-_1637056181) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 17:49:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 2/6] erofs-utils: fuse: add multiple device support
Date: Tue, 16 Nov 2021 17:49:35 +0800
Message-Id: <20211116094939.32246-3-hsiangkao@linux.alibaba.com>
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

Keep in sync with the latest kernel
commit dfeab2e95a75 ("erofs: add multiple device support")

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              |  2 +-
 fuse/main.c              | 11 +++++++
 include/erofs/defs.h     | 32 +++++++++++++++++++
 include/erofs/internal.h | 19 +++++++++++-
 include/erofs_fs.h       | 22 ++++++++++++--
 lib/data.c               | 66 +++++++++++++++++++++++++++++++++-------
 lib/super.c              | 43 ++++++++++++++++++++++++--
 man/erofsfuse.1          |  4 +++
 8 files changed, 181 insertions(+), 18 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index a7199937b8e0..d0efe9505317 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -611,7 +611,7 @@ static void erofsdump_show_superblock(void)
 	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
 			EROFS_SUPER_MAGIC_V1);
 	fprintf(stdout, "Filesystem blocks:                            %llu\n",
-			sbi.blocks | 0ULL);
+			sbi.total_blocks | 0ULL);
 	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
 			sbi.meta_blkaddr);
 	fprintf(stdout, "Filesystem shared xattr metadata start block: %u\n",
diff --git a/fuse/main.c b/fuse/main.c
index 8137421b1dea..a92f06882b75 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -113,6 +113,7 @@ static struct options {
 static const struct fuse_opt option_spec[] = {
 	OPTION("--dbglevel=%u", debug_lvl),
 	OPTION("--help", show_help),
+	FUSE_OPT_KEY("--device=", 1),
 	FUSE_OPT_END
 };
 
@@ -123,6 +124,7 @@ static void usage(void)
 	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
 	      "Options:\n"
 	      "    --dbglevel=#           set output message level to # (maximum 9)\n"
+	      "    --device=#             specify an extra device to be used together\n"
 #if FUSE_MAJOR_VERSION < 3
 	      "    --help                 display this help and exit\n"
 #endif
@@ -148,7 +150,15 @@ static void erofsfuse_dumpcfg(void)
 static int optional_opt_func(void *data, const char *arg, int key,
 			     struct fuse_args *outargs)
 {
+	int ret;
+
 	switch (key) {
+	case 1:
+		ret = blob_open_ro(arg);
+		if (ret)
+			return -1;
+		++sbi.extra_devices;
+		return 0;
 	case FUSE_OPT_KEY_NONOPT:
 		if (fusecfg.mountpoint)
 			return -1; /* Too many args */
@@ -237,6 +247,7 @@ int main(int argc, char *argv[])
 
 	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
 err_dev_close:
+	blob_closeall();
 	dev_close();
 err_fuse_free_args:
 	fuse_opt_free_args(&args);
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 96bbb6574ff3..6398cbb2aa4d 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -252,6 +252,38 @@ static inline u32 get_unaligned_le32(const u8 *p)
 	(n) & (1ULL <<  1) ?  1 : 0	\
 )
 
+static inline unsigned int fls_long(unsigned long x)
+{
+	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
+}
+
+/**
+ * __roundup_pow_of_two() - round up to nearest power of two
+ * @n: value to round up
+ */
+static inline __attribute__((const))
+unsigned long __roundup_pow_of_two(unsigned long n)
+{
+	return 1UL << fls_long(n - 1);
+}
+
+/**
+ * roundup_pow_of_two - round the given value up to nearest power of two
+ * @n: parameter
+ *
+ * round the given value up to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two(n)			\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 1) ? 1 :		\
+		(1UL << (ilog2((n) - 1) + 1))	\
+				   ) :		\
+	__roundup_pow_of_two(n)			\
+)
+
 #ifndef __always_inline
 #define __always_inline	inline
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f84e6b4f125d..974c069baa4f 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -60,8 +60,16 @@ typedef u32 erofs_blk_t;
 
 struct erofs_buffer_head;
 
+struct erofs_device_info {
+	u32 blocks;
+	u32 mapped_blkaddr;
+};
+
 struct erofs_sb_info {
-	u64 blocks;
+	struct erofs_device_info *devs;
+
+	u64 total_blocks;
+	u64 primarydevice_blocks;
 
 	erofs_blk_t meta_blkaddr;
 	erofs_blk_t xattr_blkaddr;
@@ -84,6 +92,8 @@ struct erofs_sb_info {
 	u16 lz4_max_distance;
 
 	u32 checksum;
+	u16 extra_devices;
+	u16 device_id_mask;
 };
 
 /* global sbi */
@@ -112,6 +122,7 @@ EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
+EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
@@ -257,6 +268,7 @@ struct erofs_map_blocks {
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
 
+	unsigned short m_deviceid;
 	unsigned int m_flags;
 	erofs_blk_t index;
 };
@@ -267,6 +279,11 @@ struct erofs_map_blocks {
  */
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
 
+struct erofs_map_dev {
+	erofs_off_t m_pa;
+	unsigned int m_deviceid;
+};
+
 /* super.c */
 int erofs_read_superblock(void);
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 4291970753a8..9a918775750c 100644
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
+	__le32 blocks;			/* total fs blocks of this device */
+	__le32 mapped_blkaddr;		/* map starting at mapped_blkaddr */
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
@@ -239,7 +254,7 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 /* 8-byte inode chunk indexes */
 struct erofs_inode_chunk_index {
 	__le16 advise;		/* always 0, don't care for now */
-	__le16 device_id;	/* back-end storage id, always 0 for now */
+	__le16 device_id;	/* back-end storage id (with bits masked) */
 	__le32 blkaddr;		/* start block address of this inode chunk */
 };
 
@@ -404,6 +419,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	/* keep in sync between 2 index structures for better extendibility */
 	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
 		     sizeof(struct z_erofs_vle_decompressed_index));
+	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
 
 	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
 		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
diff --git a/lib/data.c b/lib/data.c
index b83cbff3e731..136c0d97ab45 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -72,6 +72,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	erofs_off_t pos;
 	int err = 0;
 
+	map->m_deviceid = 0;
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
@@ -118,14 +119,8 @@ int erofs_map_blocks(struct erofs_inode *inode,
 		map->m_flags = 0;
 		break;
 	default:
-		/* only one device is supported for now */
-		if (idx->device_id) {
-			erofs_err("invalid device id %u @ %" PRIu64 " for nid %llu",
-				  le16_to_cpu(idx->device_id),
-				  chunknr, vi->nid | 0ULL);
-			err = -EFSCORRUPTED;
-			goto out;
-		}
+		map->m_deviceid = le16_to_cpu(idx->device_id) &
+			sbi.device_id_mask;
 		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
@@ -135,12 +130,41 @@ out:
 	return err;
 }
 
+int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
+{
+	struct erofs_device_info *dif;
+	int id;
+
+	if (map->m_deviceid) {
+		if (sbi->extra_devices < map->m_deviceid)
+			return -ENODEV;
+	} else if (sbi->extra_devices) {
+		for (id = 0; id < sbi->extra_devices; ++id) {
+			erofs_off_t startoff, length;
+
+			dif = sbi->devs + id;
+			if (!dif->mapped_blkaddr)
+				continue;
+			startoff = blknr_to_addr(dif->mapped_blkaddr);
+			length = blknr_to_addr(dif->blocks);
+
+			if (map->m_pa >= startoff &&
+			    map->m_pa < startoff + length) {
+				map->m_pa -= startoff;
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
 static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
+	struct erofs_map_dev mdev;
 	int ret;
 	erofs_off_t ptr = offset;
 
@@ -155,6 +179,14 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
 		DBG_BUGON(map.m_plen != map.m_llen);
 
+		mdev = (struct erofs_map_dev) {
+			.m_deviceid = map.m_deviceid,
+			.m_pa = map.m_pa,
+		};
+		ret = erofs_map_dev(&sbi, &mdev);
+		if (ret)
+			return ret;
+
 		/* trim extent */
 		eend = min(offset + size, map.m_la + map.m_llen);
 		DBG_BUGON(ptr < map.m_la);
@@ -172,11 +204,12 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (ptr > map.m_la) {
-			map.m_pa += ptr - map.m_la;
+			mdev.m_pa += ptr - map.m_la;
 			map.m_la = ptr;
 		}
 
-		ret = dev_read(0, estart, map.m_pa, eend - map.m_la);
+		ret = dev_read(mdev.m_deviceid, estart, mdev.m_pa,
+			       eend - map.m_la);
 		if (ret < 0)
 			return -EIO;
 		ptr = eend;
@@ -191,6 +224,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
+	struct erofs_map_dev mdev;
 	bool partial;
 	unsigned int algorithmformat, bufsize;
 	char *raw = NULL;
@@ -205,6 +239,16 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret)
 			break;
 
+		/* no device id here, thus it will always succeed */
+		mdev = (struct erofs_map_dev) {
+			.m_pa = map.m_pa,
+		};
+		ret = erofs_map_dev(&sbi, &mdev);
+		if (ret) {
+			DBG_BUGON(1);
+			break;
+		}
+
 		/*
 		 * trim to the needed size if the returned extent is quite
 		 * larger than requested, and set up partial flag as well.
@@ -240,7 +284,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 				break;
 			}
 		}
-		ret = dev_read(0, raw, map.m_pa, map.m_plen);
+		ret = dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
 		if (ret < 0)
 			break;
 
diff --git a/lib/super.c b/lib/super.c
index bf4d4318a321..3ccc551f18cf 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -23,6 +23,45 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 	return true;
 }
 
+static int erofs_init_devices(struct erofs_sb_info *sbi,
+			      struct erofs_super_block *dsb)
+{
+	unsigned int ondisk_extradevs, i;
+	erofs_off_t pos;
+
+	sbi->total_blocks = sbi->primarydevice_blocks;
+
+	if (!erofs_sb_has_device_table())
+		ondisk_extradevs = 0;
+	else
+		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
+
+	if (ondisk_extradevs != sbi->extra_devices) {
+		erofs_err("extra devices don't match (ondisk %u, given %u)",
+			  ondisk_extradevs, sbi->extra_devices);
+		return -EINVAL;
+	}
+	if (!ondisk_extradevs)
+		return 0;
+
+	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
+	sbi->devs = calloc(ondisk_extradevs, sizeof(*sbi->devs));
+	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
+	for (i = 0; i < ondisk_extradevs; ++i) {
+		struct erofs_deviceslot dis;
+		int ret;
+
+		ret = dev_read(0, &dis, pos, sizeof(dis));
+		if (ret < 0)
+			return ret;
+
+		sbi->devs[i].mapped_blkaddr = dis.mapped_blkaddr;
+		sbi->total_blocks += dis.blocks;
+		pos += EROFS_DEVT_SLOT_SIZE;
+	}
+	return 0;
+}
+
 int erofs_read_superblock(void)
 {
 	char data[EROFS_BLKSIZ];
@@ -56,7 +95,7 @@ int erofs_read_superblock(void)
 	if (!check_layout_compatibility(&sbi, dsb))
 		return ret;
 
-	sbi.blocks = le32_to_cpu(dsb->blocks);
+	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
 	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi.islotbits = EROFS_ISLOTBITS;
@@ -68,5 +107,5 @@ int erofs_read_superblock(void)
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
-	return 0;
+	return erofs_init_devices(&sbi, dsb);
 }
diff --git a/man/erofsfuse.1 b/man/erofsfuse.1
index 6bd48b0460bd..9db6827f4d0e 100644
--- a/man/erofsfuse.1
+++ b/man/erofsfuse.1
@@ -22,6 +22,10 @@ display help and exit
 .BI "\-\-dbglevel=" #
 Specify the level of debugging messages. The default is 2, which shows basic
 warning messages.
+.TP
+.BI "\-\-device=" path
+Specify an extra device to be used together.
+You may give multiple `--device' options in the correct order.
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug
-- 
2.24.4

