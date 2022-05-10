Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B6521103
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 11:35:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KyCZP72Kwz3bqb
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 19:35:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KyCZH4gppz3bYF
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 May 2022 19:35:17 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VCqPVT1_1652175311; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VCqPVT1_1652175311) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 10 May 2022 17:35:12 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: scan devices from device table
Date: Tue, 10 May 2022 17:35:11 +0800
Message-Id: <20220510093511.77473-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When "-o device" mount option is not specified, scan the device table
and instantiate the devices if there's any in the device table. In this
case, the tag field of each device slot uniquely specifies a device.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |   9 ++--
 fs/erofs/super.c    | 102 ++++++++++++++++++++++++++++++--------------
 2 files changed, 72 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 1238ca104f09..1adde3a813b4 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -37,12 +37,9 @@
 #define EROFS_SB_EXTSLOT_SIZE	16
 
 struct erofs_deviceslot {
-	union {
-		u8 uuid[16];		/* used for device manager later */
-		u8 userdata[64];	/* digest(sha256), etc. */
-	} u;
-	__le32 blocks;			/* total fs blocks of this device */
-	__le32 mapped_blkaddr;		/* map starting at mapped_blkaddr */
+	u8 tag[64];		/* digest(sha256), etc. */
+	__le32 blocks;		/* total fs blocks of this device */
+	__le32 mapped_blkaddr;	/* map starting at mapped_blkaddr */
 	u8 reserved[56];
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 4a623630e1c4..3f19c2031e69 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -219,7 +219,52 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 }
 #endif
 
-static int erofs_init_devices(struct super_block *sb,
+static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
+			     struct erofs_device_info *dif, erofs_off_t *pos)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_deviceslot *dis;
+	struct block_device *bdev;
+	void *ptr;
+	int ret;
+
+	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	dis = ptr + erofs_blkoff(*pos);
+
+	if (!dif->path) {
+		if (!dis->tag[0]) {
+			erofs_err(sb, "Empty digest data (pos %llu)", *pos);
+			return -EINVAL;
+		}
+		dif->path = kmemdup_nul(dis->tag, sizeof(dis->tag), GFP_KERNEL);
+		if (!dif->path)
+			return -ENOMEM;
+	}
+
+	if (erofs_is_fscache_mode(sb)) {
+		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
+				dif->path, false);
+		if (ret)
+			return ret;
+	} else {
+		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
+					  sb->s_type);
+		if (IS_ERR(bdev))
+			return PTR_ERR(bdev);
+		dif->bdev = bdev;
+		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
+	}
+
+	dif->blocks = le32_to_cpu(dis->blocks);
+	dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
+	sbi->total_blocks += dif->blocks;
+	*pos += EROFS_DEVT_SLOT_SIZE;
+	return 0;
+}
+
+static int erofs_scan_devices(struct super_block *sb,
 			      struct erofs_super_block *dsb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -227,8 +272,6 @@ static int erofs_init_devices(struct super_block *sb,
 	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_device_info *dif;
-	struct erofs_deviceslot *dis;
-	void *ptr;
 	int id, err = 0;
 
 	sbi->total_blocks = sbi->primarydevice_blocks;
@@ -237,7 +280,8 @@ static int erofs_init_devices(struct super_block *sb,
 	else
 		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
 
-	if (ondisk_extradevs != sbi->devs->extra_devices) {
+	if (sbi->devs->extra_devices &&
+	    ondisk_extradevs != sbi->devs->extra_devices) {
 		erofs_err(sb, "extra devices don't match (ondisk %u, given %u)",
 			  ondisk_extradevs, sbi->devs->extra_devices);
 		return -EINVAL;
@@ -248,39 +292,31 @@ static int erofs_init_devices(struct super_block *sb,
 	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
 	down_read(&sbi->devs->rwsem);
-	idr_for_each_entry(&sbi->devs->tree, dif, id) {
-		struct block_device *bdev;
-
-		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
-					 EROFS_KMAP);
-		if (IS_ERR(ptr)) {
-			err = PTR_ERR(ptr);
-			break;
-		}
-		dis = ptr + erofs_blkoff(pos);
-
-		if (erofs_is_fscache_mode(sb)) {
-			err = erofs_fscache_register_cookie(sb, &dif->fscache,
-							    dif->path, false);
+	if (sbi->devs->extra_devices) {
+		idr_for_each_entry(&sbi->devs->tree, dif, id) {
+			err = erofs_init_device(&buf, sb, dif, &pos);
 			if (err)
 				break;
-		} else {
-			bdev = blkdev_get_by_path(dif->path,
-						  FMODE_READ | FMODE_EXCL,
-						  sb->s_type);
-			if (IS_ERR(bdev)) {
-				err = PTR_ERR(bdev);
+		}
+	} else {
+		for (id = 0; id < ondisk_extradevs; id++) {
+			dif = kzalloc(sizeof(*dif), GFP_KERNEL);
+			if (!dif) {
+				err = -ENOMEM;
 				break;
 			}
-			dif->bdev = bdev;
-			dif->dax_dev = fs_dax_get_by_bdev(bdev,
-							  &dif->dax_part_off);
-		}
 
-		dif->blocks = le32_to_cpu(dis->blocks);
-		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
-		sbi->total_blocks += dif->blocks;
-		pos += EROFS_DEVT_SLOT_SIZE;
+			err = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+			if (err < 0) {
+				kfree(dif);
+				break;
+			}
+			++sbi->devs->extra_devices;
+
+			err = erofs_init_device(&buf, sb, dif, &pos);
+			if (err)
+				break;
+		}
 	}
 	up_read(&sbi->devs->rwsem);
 	erofs_put_metabuf(&buf);
@@ -367,7 +403,7 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 
 	/* handle multiple devices */
-	ret = erofs_init_devices(sb, dsb);
+	ret = erofs_scan_devices(sb, dsb);
 
 	if (erofs_sb_has_ztailpacking(sbi))
 		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
-- 
2.27.0

