Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C58967A1DB4
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 13:53:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RnCJT529bz3cKc
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 21:53:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RnCJP0Y3wz3c2D
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 21:53:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs753Bn_1694778813;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs753Bn_1694778813)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 19:53:34 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: mkfs: support flatdev for multi-blob images
Date: Fri, 15 Sep 2023 19:53:33 +0800
Message-Id: <20230915115333.17599-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since kernel commit 8b465fecc35a ("erofs: support flattened block device
for multi-blob images"), the flatdev feature has been introduced to
support mounting multi-blobs container image as a single block device.

To enable this feature, the mapped_blkaddr of each device slot needs to
be set properly to the offset of the device in the flat address space.

The kernel side requires a non-empty device tag to mount an image in
flatdev mode.  The uuid of the source image is used as the corresponding
device tag in rebuild mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v3: convert uuid to hex string and use it as the device tag
v2: https://lore.kernel.org/all/20230915081654.33112-1-jefflexu@linux.alibaba.com/
---
 include/erofs/internal.h |  1 +
 lib/blobchunk.c          |  8 ++++++--
 lib/super.c              |  1 +
 mkfs/main.c              | 16 ++++++++++++++--
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 19b912b..616cd3a 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -54,6 +54,7 @@ extern struct erofs_sb_info sbi;
 struct erofs_buffer_head;
 
 struct erofs_device_info {
+	u8 tag[64];
 	u32 blocks;
 	u32 mapped_blkaddr;
 };
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index aca616e..a599f3a 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -410,20 +410,24 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 	}
 
 	if (sbi->extra_devices) {
-		unsigned int i;
+		unsigned int i, ret;
+		erofs_blk_t nblocks;
 
+		nblocks = erofs_mapbh(NULL);
 		pos_out = erofs_btell(bh_devt, false);
 		i = 0;
 		do {
 			struct erofs_deviceslot dis = {
+				.mapped_blkaddr = cpu_to_le32(nblocks),
 				.blocks = cpu_to_le32(sbi->devs[i].blocks),
 			};
-			int ret;
 
+			memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
 			ret = dev_write(sbi, &dis, pos_out, sizeof(dis));
 			if (ret)
 				return ret;
 			pos_out += sizeof(dis);
+			nblocks += sbi->devs[i].blocks;
 		} while (++i < sbi->extra_devices);
 		bh_devt->op = &erofs_drop_directly_bhops;
 		erofs_bdrop(bh_devt, false);
diff --git a/lib/super.c b/lib/super.c
index ce97278..f952f7e 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -65,6 +65,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 
 		sbi->devs[i].mapped_blkaddr = le32_to_cpu(dis.mapped_blkaddr);
 		sbi->devs[i].blocks = le32_to_cpu(dis.blocks);
+		memcpy(sbi->devs[i].tag, dis.tag, sizeof(dis.tag));
 		sbi->total_blocks += sbi->devs[i].blocks;
 		pos += EROFS_DEVT_SLOT_SIZE;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 4fa2d92..884bd35 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -822,7 +822,7 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 	struct erofs_sb_info *src;
 	unsigned int extra_devices = 0;
 	erofs_blk_t nblocks;
-	int ret;
+	int ret, idx;
 
 	list_for_each_entry(src, &rebuild_src_list, list) {
 		ret = erofs_rebuild_load_tree(root, src);
@@ -854,7 +854,19 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 		else
 			nblocks = src->primarydevice_blocks;
 		DBG_BUGON(src->dev < 1);
-		sbi.devs[src->dev - 1].blocks = nblocks;
+		idx = src->dev - 1;
+		sbi.devs[idx].blocks = nblocks;
+		/* convert uuid of source to hex string as the device tag */
+		sprintf((char *)sbi.devs[idx].tag,
+			"%04x%04x%04x%04x%04x%04x%04x%04x",
+			(src->uuid[0] << 8) | src->uuid[1],
+			(src->uuid[2] << 8) | src->uuid[3],
+			(src->uuid[4] << 8) | src->uuid[5],
+			(src->uuid[6] << 8) | src->uuid[7],
+			(src->uuid[8] << 8) | src->uuid[9],
+			(src->uuid[10] << 8) | src->uuid[11],
+			(src->uuid[12] << 8) | src->uuid[13],
+			(src->uuid[14] << 8) | src->uuid[15]);
 	}
 	return 0;
 }
-- 
2.19.1.6.gb485710b

