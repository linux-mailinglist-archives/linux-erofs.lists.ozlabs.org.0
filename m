Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC78544E663
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 13:31:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrHyh663sz2yQC
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 23:31:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrHyW4L1fz2xtf
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 23:31:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UwBaAUF_1636720289; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwBaAUF_1636720289) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 12 Nov 2021 20:31:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/3] erofs-utils: add extra device I/O interface
Date: Fri, 12 Nov 2021 20:31:26 +0800
Message-Id: <20211112123128.126741-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order for erofsfuse to support multiple devices.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - add erofsfuse multiple device support.

 fsck/main.c        |  8 ++++----
 include/erofs/io.h | 10 ++++++----
 lib/data.c         |  6 +++---
 lib/io.c           | 48 +++++++++++++++++++++++++++++++++++++---------
 lib/namei.c        |  4 ++--
 lib/super.c        |  2 +-
 lib/zmap.c         |  4 ++--
 mkfs/main.c        |  2 +-
 8 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index d81d60024c8a..b742e3579c59 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -97,7 +97,7 @@ static int erofs_check_sb_chksum(void)
 	u32 crc;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(buf, 0, 1);
+	ret = blk_read(0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to check checksum: %d",
 			  ret);
@@ -317,7 +317,7 @@ static int verify_compressed_inode(struct erofs_inode *inode)
 			BUG_ON(!buffer);
 		}
 
-		ret = dev_read(raw, map.m_pa, map.m_plen);
+		ret = dev_read(0, raw, map.m_pa, map.m_plen);
 		if (ret < 0) {
 			erofs_err("failed to read compressed data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %d",
 				  map.m_pa, map.m_plen, inode->nid | 0ULL, ret);
@@ -381,7 +381,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	}
 
 	addr = iloc(inode->nid) + inode->inode_isize;
-	ret = dev_read(buf, addr, xattr_hdr_size);
+	ret = dev_read(0, buf, addr, xattr_hdr_size);
 	if (ret < 0) {
 		erofs_err("failed to read xattr header @ nid %llu: %d",
 			  inode->nid | 0ULL, ret);
@@ -411,7 +411,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	while (remaining > 0) {
 		unsigned int entry_sz;
 
-		ret = dev_read(buf, addr, xattr_entry_size);
+		ret = dev_read(0, buf, addr, xattr_entry_size);
 		if (ret) {
 			erofs_err("failed to read xattr entry @ nid %llu: %d",
 				  inode->nid | 0ULL, ret);
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 9d73adc5f5f9..10a3681882e1 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -15,11 +15,13 @@
 #define O_BINARY	0
 #endif
 
+void blob_closeall(void);
+int blob_open_ro(const char *dev);
 int dev_open(const char *devname);
 int dev_open_ro(const char *dev);
 void dev_close(void);
 int dev_write(const void *buf, u64 offset, size_t len);
-int dev_read(void *buf, u64 offset, size_t len);
+int dev_read(int device_id, void *buf, u64 offset, size_t len);
 int dev_fillzero(u64 offset, size_t len, bool padding);
 int dev_fsync(void);
 int dev_resize(erofs_blk_t nblocks);
@@ -38,10 +40,10 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
 			 blknr_to_addr(nblocks));
 }
 
-static inline int blk_read(void *buf, erofs_blk_t start,
-			    u32 nblocks)
+static inline int blk_read(int device_id, void *buf,
+			   erofs_blk_t start, u32 nblocks)
 {
-	return dev_read(buf, blknr_to_addr(start),
+	return dev_read(device_id, buf, blknr_to_addr(start),
 			 blknr_to_addr(nblocks));
 }
 
diff --git a/lib/data.c b/lib/data.c
index b5f0196c97dd..b83cbff3e731 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -91,7 +91,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
 	pos = roundup(iloc(vi->nid) + vi->inode_isize +
 		      vi->xattr_isize, unit) + unit * chunknr;
 
-	err = blk_read(buf, erofs_blknr(pos), 1);
+	err = blk_read(0, buf, erofs_blknr(pos), 1);
 	if (err < 0)
 		return -EIO;
 
@@ -176,7 +176,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			map.m_la = ptr;
 		}
 
-		ret = dev_read(estart, map.m_pa, eend - map.m_la);
+		ret = dev_read(0, estart, map.m_pa, eend - map.m_la);
 		if (ret < 0)
 			return -EIO;
 		ptr = eend;
@@ -240,7 +240,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 				break;
 			}
 		}
-		ret = dev_read(raw, map.m_pa, map.m_plen);
+		ret = dev_read(0, raw, map.m_pa, map.m_plen);
 		if (ret < 0)
 			break;
 
diff --git a/lib/io.c b/lib/io.c
index 279c7dd4b877..a0d366a4c3f1 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -26,6 +26,7 @@
 static const char *erofs_devname;
 int erofs_devfd = -1;
 static u64 erofs_devsz;
+static unsigned int erofs_nblobs, erofs_blobfd[256];
 
 int dev_get_blkdev_size(int fd, u64 *bytes)
 {
@@ -106,6 +107,30 @@ int dev_open(const char *dev)
 	return 0;
 }
 
+void blob_closeall(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < erofs_nblobs; ++i)
+		close(erofs_blobfd[i]);
+	erofs_nblobs = 0;
+}
+
+int blob_open_ro(const char *dev)
+{
+	int fd = open(dev, O_RDONLY | O_BINARY);
+
+	if (fd < 0) {
+		erofs_err("failed to open(%s).", dev);
+		return -errno;
+	}
+
+	erofs_blobfd[erofs_nblobs] = fd;
+	erofs_info("successfully to open blob%u %s", erofs_nblobs, dev);
+	++erofs_nblobs;
+	return 0;
+}
+
 /* XXX: temporary soluation. Disk I/O implementation needs to be refactored. */
 int dev_open_ro(const char *dev)
 {
@@ -229,9 +254,9 @@ int dev_resize(unsigned int blocks)
 	return dev_fillzero(st.st_size, length, true);
 }
 
-int dev_read(void *buf, u64 offset, size_t len)
+int dev_read(int device_id, void *buf, u64 offset, size_t len)
 {
-	int ret;
+	int ret, fd;
 
 	if (cfg.c_dry_run)
 		return 0;
@@ -240,16 +265,21 @@ int dev_read(void *buf, u64 offset, size_t len)
 		erofs_err("buf is NULL");
 		return -EINVAL;
 	}
-	if (offset >= erofs_devsz || len > erofs_devsz ||
-	    offset > erofs_devsz - len) {
-		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
-			  offset, len, erofs_devsz);
-		return -EINVAL;
+
+	if (!device_id) {
+		fd = erofs_devfd;
+	} else {
+		if (device_id > erofs_nblobs) {
+			erofs_err("invalid device id %d", device_id);
+			return -ENODEV;
+		}
+		fd = erofs_blobfd[device_id - 1];
 	}
+
 #ifdef HAVE_PREAD64
-	ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
+	ret = pread64(fd, buf, len, (off64_t)offset);
 #else
-	ret = pread(erofs_devfd, buf, len, (off_t)offset);
+	ret = pread(fd, buf, len, (off_t)offset);
 #endif
 	if (ret != (int)len) {
 		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
diff --git a/lib/namei.c b/lib/namei.c
index 56f199aba382..7377e74fad9b 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -30,7 +30,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	struct erofs_inode_extended *die;
 	const erofs_off_t inode_loc = iloc(vi->nid);
 
-	ret = dev_read(buf, inode_loc, sizeof(*dic));
+	ret = dev_read(0, buf, inode_loc, sizeof(*dic));
 	if (ret < 0)
 		return -EIO;
 
@@ -47,7 +47,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
-		ret = dev_read(buf + sizeof(*dic), inode_loc + sizeof(*dic),
+		ret = dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
 			       sizeof(*die) - sizeof(*dic));
 		if (ret < 0)
 			return -EIO;
diff --git a/lib/super.c b/lib/super.c
index 0c3040394272..bf4d4318a321 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -30,7 +30,7 @@ int erofs_read_superblock(void)
 	unsigned int blkszbits;
 	int ret;
 
-	ret = blk_read(data, 0, 1);
+	ret = blk_read(0, data, 0, 1);
 	if (ret < 0) {
 		erofs_err("cannot read erofs superblock: %d", ret);
 		return -EIO;
diff --git a/lib/zmap.c b/lib/zmap.c
index 7dbda87c3b13..9dd0c7633a45 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -38,7 +38,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
-	ret = dev_read(buf, pos, sizeof(buf));
+	ret = dev_read(0, buf, pos, sizeof(buf));
 	if (ret < 0)
 		return -EIO;
 
@@ -88,7 +88,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	if (map->index == eblk)
 		return 0;
 
-	ret = blk_read(mpage, eblk, 1);
+	ret = blk_read(0, mpage, eblk, 1);
 	if (ret < 0)
 		return -EIO;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 4ea5467679b7..2604bf2abd6b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -436,7 +436,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 	u32 crc;
 	struct erofs_super_block *sb;
 
-	ret = blk_read(buf, 0, 1);
+	ret = blk_read(0, buf, 0, 1);
 	if (ret) {
 		erofs_err("failed to read superblock to set checksum: %s",
 			  erofs_strerror(ret));
-- 
2.24.4

