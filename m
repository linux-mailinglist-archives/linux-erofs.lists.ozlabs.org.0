Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CDD9EE7BE
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 14:35:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8D4D2bmPz3c5m
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 00:35:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734010521;
	cv=none; b=LJo+8NfxJ3p60KBB7zWSdKS0qxfJuOeBy+5DQfq7US4kVEdBdsNpg9o3/PszMIuVpmkzqg9e2DL9+h4PgruU5zpdyI0j/0Zs36X1ur58YZFnAfE5iUdOjmfU6BkWdxbqvjVDbgUqs0EAMcT9QK7laMf888gDJUzEUDj2R1TpQNtPLoYuzwTpVHexXJb3Duc/SI/3AhUKDLZmIGNznPsPNfcM1nW2AiSjGLtM0k10xjUBeDAZeDqYjCKegEFYONDOPfZbA1I6/wsZ3E9+Th6t5+XUpLnhEWJXoAo9VP3imnIDukI+vQfO6zwl5ZMTMLKn2I98zGqoqRJAPvmWtiFGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734010521; c=relaxed/relaxed;
	bh=UyJPya5OT9LNAFzMrChSZjHIOfkqieiGV8h+l6rPH0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHGKEInig1m0oAWc/3UA6OeCkgF8TDsLJCNJdlkM937M12X0YYAx5koevqRoymmzCGRJA0gt/C75yV4Uxz8A5p9tCagHuLJZSbJhr0RgzikgwGL6sGkCJL8+wwbDaXWBRdkWpYxKbYozNb7NZJa3z7DKBkkjt9+T4M93S18jgfkY9sDZrbDe6pTDHRgYyw2/BCJqlO9pL2gGEGd2BTdGIqwgm7uH3T3quq+t88LkFSyEb/LrgiGg3VnsH7Lv9HddESstBwkFpGISD7g7cmvEBYmEfvrdrUVRaCq3MwpodCopOBDBwOimS1wTuh4ghpbdnsj31t1IHPR2YFenMbKxgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OdU75h+P; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OdU75h+P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8D4654qvz30VL
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 00:35:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734010513; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UyJPya5OT9LNAFzMrChSZjHIOfkqieiGV8h+l6rPH0s=;
	b=OdU75h+PtWiL0fO0XPb1x917oVTZC3gCDCLMcfbJmtVo1pCjFS/x/dGhphDYQCLCAIFB+iTp9T3wY1MqWlLUqNoMHurTxXQfMBO7fE6UghPALSXi8pgUwtt07zi54pMLO92oHh+JRp66aHn5HShZRIVCmSTSdsL8wSEhtmXFHUA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLvJpH_1734010510 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 21:35:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs: use `struct erofs_device_info` for the primary device
Date: Thu, 12 Dec 2024 21:35:02 +0800
Message-ID: <20241212133504.2047178-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
References: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Instead of just listing each one directly in `struct erofs_sb_info`
except that we still use `sb->s_bdev` for the primary block device.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 10 +++-------
 fs/erofs/internal.h |  7 ++-----
 fs/erofs/super.c    | 27 +++++++++++++--------------
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1c49f8962021..0b0385fa3025 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -56,7 +56,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 
 	buf->file = NULL;
 	if (erofs_is_fileio_mode(sbi)) {
-		buf->file = sbi->fdev;		/* some fs like FUSE needs it */
+		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
 	} else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
@@ -201,12 +201,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	erofs_off_t startoff, length;
 	int id;
 
-	map->m_bdev = sb->s_bdev;
-	map->m_daxdev = EROFS_SB(sb)->dax_dev;
-	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
-	map->m_fscache = EROFS_SB(sb)->s_fscache;
-	map->m_fp = EROFS_SB(sb)->fdev;
-
+	erofs_fill_from_devinfo(map, &EROFS_SB(sb)->dif0);
+	map->m_bdev = sb->s_bdev;	/* use s_bdev for the primary device */
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
 		dif = idr_find(&devs->tree, map->m_deviceid - 1);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1c847c30a918..6e91fcdeba94 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -107,6 +107,7 @@ struct erofs_xattr_prefix_item {
 };
 
 struct erofs_sb_info {
+	struct erofs_device_info dif0;
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
@@ -124,13 +125,9 @@ struct erofs_sb_info {
 
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
-	struct file *fdev;
 	struct inode *packed_inode;
 	struct erofs_dev_context *devs;
-	struct dax_device *dax_dev;
-	u64 dax_part_off;
 	u64 total_blocks;
-	u32 primarydevice_blocks;
 
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -187,7 +184,7 @@ struct erofs_sb_info {
 
 static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
 {
-	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
+	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
 }
 
 static inline bool erofs_is_fscache_mode(struct super_block *sb)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1ce5ca11d32b..934fb1513095 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -203,7 +203,7 @@ static int erofs_scan_devices(struct super_block *sb,
 	struct erofs_device_info *dif;
 	int id, err = 0;
 
-	sbi->total_blocks = sbi->primarydevice_blocks;
+	sbi->total_blocks = sbi->dif0.blocks;
 	if (!erofs_sb_has_device_table(sbi))
 		ondisk_extradevs = 0;
 	else
@@ -307,7 +307,7 @@ static int erofs_read_superblock(struct super_block *sb)
 			  sbi->sb_size);
 		goto out;
 	}
-	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
+	sbi->dif0.blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
@@ -602,9 +602,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return -EINVAL;
 		}
 
-		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
-						  &sbi->dax_part_off,
-						  NULL, NULL);
+		sbi->dif0.dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
+				&sbi->dif0.dax_part_off, NULL, NULL);
 	}
 
 	err = erofs_read_superblock(sb);
@@ -627,7 +626,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-		if (!sbi->dax_dev) {
+		if (!sbi->dif0.dax_dev) {
 			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
 			clear_opt(&sbi->opt, DAX_ALWAYS);
 		} else if (sbi->blkszbits != PAGE_SHIFT) {
@@ -707,14 +706,13 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
-
 		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
-		sbi->fdev = file;
+		sbi->dif0.file = file;
 
-		if (S_ISREG(file_inode(sbi->fdev)->i_mode) &&
-		    sbi->fdev->f_mapping->a_ops->read_folio)
+		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
+		    sbi->dif0.file->f_mapping->a_ops->read_folio)
 			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
 #endif
@@ -771,8 +769,8 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
 	erofs_free_dev_context(sbi->devs);
 	kfree(sbi->fsid);
 	kfree(sbi->domain_id);
-	if (sbi->fdev)
-		fput(sbi->fdev);
+	if (sbi->dif0.file)
+		fput(sbi->dif0.file);
 	kfree(sbi);
 }
 
@@ -817,11 +815,12 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) || sbi->fdev)
+	if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) ||
+	    sbi->dif0.file)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
-	fs_put_dax(sbi->dax_dev, NULL);
+	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
 	sb->s_fs_info = NULL;
-- 
2.43.5

