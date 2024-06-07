Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDEE8FFFE8
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 11:53:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W3Xh7lyL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vwc3J2mhDz3cVX
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 19:53:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W3Xh7lyL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vwc330t3wz30W9
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jun 2024 19:53:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717754007; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=d2JDVH2p3YqLqjXSlpe4HZlas+N9OGvqlxaCTrpBMh4=;
	b=W3Xh7lyLm/C19oCo2LxSAOF3EO66+94pCPxC8IULGWGPFJg/wcf+kWqBwOZa4PkNp3rxopqfV++RGg3FwJkIL654Syu5AGenUl1KzLzulwk9HrAX897RVyHxjCFA66TnKzha3/C1fSf53RUbUX17WCP5WiZtqIeDGNeyoiwIFEo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8-d99Q_1717754000;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8-d99Q_1717754000)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 17:53:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: move erofs_writesb() into lib/
Date: Fri,  7 Jun 2024 17:53:18 +0800
Message-Id: <20240607095319.2169172-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

So that external programs can directly use it.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  4 +++
 lib/super.c              | 52 ++++++++++++++++++++++++++++++++
 mkfs/main.c              | 64 +++-------------------------------------
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d93bfab..f1d85be 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -134,6 +134,8 @@ struct erofs_sb_info {
 	bool useqpl;
 };
 
+#define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
+
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
 extern int erofs_assert_largefile[sizeof(off_t)-8];
 
@@ -393,6 +395,8 @@ struct erofs_map_dev {
 /* super.c */
 int erofs_read_superblock(struct erofs_sb_info *sbi);
 void erofs_put_super(struct erofs_sb_info *sbi);
+int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
+		  erofs_blk_t *blocks);
 
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/lib/super.c b/lib/super.c
index 6de5e49..33e908a 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include "erofs/print.h"
 #include "erofs/xattr.h"
+#include "erofs/cache.h"
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
@@ -149,3 +150,54 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 	}
 	erofs_xattr_prefixes_cleanup(sbi);
 }
+
+int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
+		  erofs_blk_t *blocks)
+{
+	struct erofs_super_block sb = {
+		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
+		.blkszbits = sbi->blkszbits,
+		.root_nid  = cpu_to_le16(sbi->root_nid),
+		.inos      = cpu_to_le64(sbi->inos),
+		.build_time = cpu_to_le64(sbi->build_time),
+		.build_time_nsec = cpu_to_le32(sbi->build_time_nsec),
+		.meta_blkaddr  = cpu_to_le32(sbi->meta_blkaddr),
+		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
+		.xattr_prefix_count = sbi->xattr_prefix_count,
+		.xattr_prefix_start = cpu_to_le32(sbi->xattr_prefix_start),
+		.feature_incompat = cpu_to_le32(sbi->feature_incompat),
+		.feature_compat = cpu_to_le32(sbi->feature_compat &
+					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
+		.extra_devices = cpu_to_le16(sbi->extra_devices),
+		.devt_slotoff = cpu_to_le16(sbi->devt_slotoff),
+		.packed_nid = cpu_to_le64(sbi->packed_nid),
+	};
+	const u32 sb_blksize = round_up(EROFS_SUPER_END, erofs_blksiz(sbi));
+	char *buf;
+	int ret;
+
+	*blocks         = erofs_mapbh(NULL);
+	sb.blocks       = cpu_to_le32(*blocks);
+	memcpy(sb.uuid, sbi->uuid, sizeof(sb.uuid));
+	memcpy(sb.volume_name, sbi->volume_name, sizeof(sb.volume_name));
+
+	if (erofs_sb_has_compr_cfgs(sbi))
+		sb.u1.available_compr_algs = cpu_to_le16(sbi->available_compr_algs);
+	else
+		sb.u1.lz4_max_distance = cpu_to_le16(sbi->lz4_max_distance);
+
+	buf = calloc(sb_blksize, 1);
+	if (!buf) {
+		erofs_err("failed to allocate memory for sb: %s",
+			  erofs_strerror(-errno));
+		return -ENOMEM;
+	}
+	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
+
+	ret = erofs_dev_write(sbi, buf, sb_bh ? erofs_btell(sb_bh, false) : 0,
+			      EROFS_SUPER_END);
+	free(buf);
+	if (sb_bh)
+		erofs_bdrop(sb_bh, false);
+	return ret;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 007bea8..6577267 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -32,8 +32,6 @@
 #include "../lib/liberofs_uuid.h"
 #include "../lib/compressor.h"
 
-#define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
-
 static struct option long_options[] = {
 	{"version", no_argument, 0, 'V'},
 	{"help", no_argument, 0, 'h'},
@@ -935,58 +933,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	return 0;
 }
 
-int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
-				  erofs_nid_t root_nid,
-				  erofs_blk_t *blocks,
-				  erofs_nid_t packed_nid)
-{
-	struct erofs_super_block sb = {
-		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
-		.blkszbits = sbi.blkszbits,
-		.inos   = cpu_to_le64(sbi.inos),
-		.build_time = cpu_to_le64(sbi.build_time),
-		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
-		.blocks = 0,
-		.meta_blkaddr  = cpu_to_le32(sbi.meta_blkaddr),
-		.xattr_blkaddr = cpu_to_le32(sbi.xattr_blkaddr),
-		.xattr_prefix_count = sbi.xattr_prefix_count,
-		.xattr_prefix_start = cpu_to_le32(sbi.xattr_prefix_start),
-		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
-		.feature_compat = cpu_to_le32(sbi.feature_compat &
-					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
-		.extra_devices = cpu_to_le16(sbi.extra_devices),
-		.devt_slotoff = cpu_to_le16(sbi.devt_slotoff),
-	};
-	const u32 sb_blksize = round_up(EROFS_SUPER_END, erofs_blksiz(&sbi));
-	char *buf;
-	int ret;
-
-	*blocks         = erofs_mapbh(NULL);
-	sb.blocks       = cpu_to_le32(*blocks);
-	sb.root_nid     = cpu_to_le16(root_nid);
-	sb.packed_nid    = cpu_to_le64(packed_nid);
-	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
-	memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
-
-	if (erofs_sb_has_compr_cfgs(&sbi))
-		sb.u1.available_compr_algs = cpu_to_le16(sbi.available_compr_algs);
-	else
-		sb.u1.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance);
-
-	buf = calloc(sb_blksize, 1);
-	if (!buf) {
-		erofs_err("failed to allocate memory for sb: %s",
-			  erofs_strerror(-errno));
-		return -ENOMEM;
-	}
-	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
-
-	ret = erofs_dev_write(&sbi, buf, erofs_btell(bh, false), EROFS_SUPER_END);
-	free(buf);
-	erofs_bdrop(bh, false);
-	return ret;
-}
-
 static int erofs_mkfs_superblock_csum_set(void)
 {
 	int ret;
@@ -1190,7 +1136,6 @@ int main(int argc, char **argv)
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode, *packed_inode;
-	erofs_nid_t root_nid, packed_nid;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	FILE *packedfile = NULL;
@@ -1411,7 +1356,7 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 	}
-	root_nid = erofs_lookupnid(root_inode);
+	sbi.root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
 
 	if (erofstar.index_mode && sbi.extra_devices && !erofstar.mapfile)
@@ -1423,7 +1368,7 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
-	packed_nid = 0;
+	sbi.packed_nid = 0;
 	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
 	    erofs_sb_has_fragments(&sbi)) {
 		erofs_update_progressinfo("Handling packed_file ...");
@@ -1432,7 +1377,7 @@ int main(int argc, char **argv)
 			err = PTR_ERR(packed_inode);
 			goto exit;
 		}
-		packed_nid = erofs_lookupnid(packed_inode);
+		sbi.packed_nid = erofs_lookupnid(packed_inode);
 		erofs_iput(packed_inode);
 	}
 
@@ -1441,8 +1386,7 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
-	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
-					    packed_nid);
+	err = erofs_writesb(&sbi, sb_bh, &nblocks);
 	if (err)
 		goto exit;
 
-- 
2.39.3

