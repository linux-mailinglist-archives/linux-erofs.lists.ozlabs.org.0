Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 327CE7A1614
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 08:27:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rn44T0yRqz3cGk
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 16:27:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rn44K20Ybz3c5f
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Sep 2023 16:27:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs61A3Z_1694759255;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs61A3Z_1694759255)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 14:27:36 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: support flatdev for multi-blob images
Date: Fri, 15 Sep 2023 14:27:35 +0800
Message-Id: <20230915062735.124203-1-jefflexu@linux.alibaba.com>
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
for multi-blob images"), flatdev feature is introduced to support for
mounting multi-blobs container image as a single block device.

Introduce "-Eflatdev" option to generate images in flatdev mode.
Currently this can only work with rebuild mode, where the device tag is
filled with the uuid of the corresponding source image.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 lib/blobchunk.c          | 15 +++++++++++++--
 lib/super.c              |  1 +
 mkfs/main.c              | 26 ++++++++++++++++++++++----
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index e342722..95c6aab 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -55,6 +55,7 @@ struct erofs_configure {
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
 	bool c_ovlfs_strip;
+	bool c_flatdev;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
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
index aca616e..52ec438 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -410,20 +410,31 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
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
 				.blocks = cpu_to_le32(sbi->devs[i].blocks),
 			};
-			int ret;
+
+			if (cfg.c_flatdev) {
+				dis.mapped_blkaddr = cpu_to_le32(nblocks);
+				if (!sbi->devs[i].tag[0]) {
+					erofs_err("empty device tag");
+					return -EINVAL;
+				}
+				memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
+			}
 
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
index 4fa2d92..937a0f5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -249,6 +249,10 @@ handle_fragment:
 			if (vallen)
 				return -EINVAL;
 			cfg.c_xattr_name_filter = !clear;
+		} else if ((MATCH_EXTENTED_OPT("flatdev", token, keylen))) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_flatdev = !clear;
 		} else {
 			erofs_err("unknown extended option %.*s",
 				  p - token, token);
@@ -620,6 +624,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_showprogress = false;
 	}
 
+	if (cfg.c_flatdev && !rebuild_mode) {
+		erofs_err("--flatdev is supported only in rebuild mode currently");
+		return -EINVAL;
+	}
+
 	if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) != getpagesize())
 		erofs_warn("Please note that subpage blocksize with compression isn't yet supported in kernel. "
 			   "This compressed image will only work with bs = ps = %u bytes",
@@ -765,8 +774,15 @@ static void erofs_mkfs_default_options(void)
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
 
-	/* generate a default uuid first */
-	erofs_uuid_generate(sbi.uuid);
+	/*
+	 * Generate a default uuid first.  In rebuild mode the uuid of the
+	 * source image is used as the device slot's tag.  The kernel will
+	 * identify the tag as empty and fail the mount if its first byte is
+	 * zero.  Apply this constraint to uuid to work around it.
+	 */
+	do {
+		erofs_uuid_generate(sbi.uuid);
+	} while (!sbi.uuid[0]);
 }
 
 /* https://reproducible-builds.org/specs/source-date-epoch/ for more details */
@@ -822,7 +838,7 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 	struct erofs_sb_info *src;
 	unsigned int extra_devices = 0;
 	erofs_blk_t nblocks;
-	int ret;
+	int ret, idx;
 
 	list_for_each_entry(src, &rebuild_src_list, list) {
 		ret = erofs_rebuild_load_tree(root, src);
@@ -854,7 +870,9 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
 		else
 			nblocks = src->primarydevice_blocks;
 		DBG_BUGON(src->dev < 1);
-		sbi.devs[src->dev - 1].blocks = nblocks;
+		idx = src->dev - 1;
+		sbi.devs[idx].blocks = nblocks;
+		memcpy(sbi.devs[idx].tag, src->uuid, sizeof(src->uuid));
 	}
 	return 0;
 }
-- 
2.19.1.6.gb485710b

