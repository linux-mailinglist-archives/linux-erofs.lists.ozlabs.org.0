Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A19F30EF
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 13:53:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBfy35Vkbz3c03
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 23:53:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734353608;
	cv=none; b=On6K1DFZr4Vhyq6+/RtJaCPHRu3ynHkjz2+PF7dAyFvXdX/ulp/gGgS20GA8oEth+6Zo50wCG6X7UTMMXqr6n6XMVyetRabBVNs2tVh5vrXZ2tLOOnw5/1O26nGI/BKdkb4PZ+g9VxGlPQuPDv8f6k5+IiBFUWRVU9GqcbK2qk77qbAtkkHbE2zLTUrHUDFMo2NqeX8M9WomAmfvL3KH8VLcWsV9+oqrsegd6Dv+UiAnCgrEsnR49Pe1uOdIvmY7f7Woxc4pvyBuz9Ez/FkyCbsOAmqv4sLk915CJS9zRejj7Qf7ShbvSL4hNDXvdicY9qH1aVHVq5KM/A4Sq+fiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734353608; c=relaxed/relaxed;
	bh=PqTCnmya6pJ/BUWy1H3GyVZP6YqSpAKVxcHFV//6xNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOYI+UTCfyGyFRsbIpS3trqe6PtTD1AjPZXWHLMH6C6ofMKruqnfRDBBkLs9KCyvtLbcAM8h6fb9DPC3S2gvgb+utvCnE8/usGHXQaABAMSCnmuc1DAHyfOh+TRDfr8Y5CZmQgnc+2Z71UB/LgJ0bgaI8jaU7FtQ6kaLhh12gCVnHZEkanCW1D+mUUqRcS/tlfRclNSfdLt1qP+INW2xFIL2NbBltqP0mCQv9RMnYtm6VodGQ+JtsRBrg8xsrV6g0mXD4QF8lncHfMrXGOugIlHxhJF6U0SRjShb9PDgH1jPXe+nyPMtoXYLFYOx7eLjRuQP5LfF68IbZIYxLWjApA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qSTjh6KT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qSTjh6KT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBfxy013jz2yyy
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Dec 2024 23:53:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734353599; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PqTCnmya6pJ/BUWy1H3GyVZP6YqSpAKVxcHFV//6xNs=;
	b=qSTjh6KTVaF1BwJqf9YJ+Kvv+ujWuYz+6p1mBOSDbwP45mwdDqAs+hagzLU/9ENEEMjhLoSEY/Ff/nini5Nm8Rnt6QRObVvspaHctqN0GmrwrfZxs2OaRYP0VjUNKMmix6qQND6Xz6qUMerQAqWT/12m0ssY8g5lovp/K5TLbYE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLcksLx_1734353597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 20:53:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/4] erofs: use `struct erofs_device_info` for the primary device
Date: Mon, 16 Dec 2024 20:53:08 +0800
Message-ID: <20241216125310.930933-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
References: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
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

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - forgot to convert `sbi->s_fscache` which impacts fscache functionality.

 fs/erofs/data.c     | 12 ++++--------
 fs/erofs/fscache.c  |  6 +++---
 fs/erofs/internal.h |  8 ++------
 fs/erofs/super.c    | 27 +++++++++++++--------------
 4 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1c49f8962021..622017c65958 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -56,10 +56,10 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 
 	buf->file = NULL;
 	if (erofs_is_fileio_mode(sbi)) {
-		buf->file = sbi->fdev;		/* some fs like FUSE needs it */
+		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
 	} else if (erofs_is_fscache_mode(sb))
-		buf->mapping = sbi->s_fscache->inode->i_mapping;
+		buf->mapping = sbi->dif0.fscache->inode->i_mapping;
 	else
 		buf->mapping = sb->s_bdev->bd_mapping;
 }
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
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..ce7e38c82719 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -657,7 +657,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	if (IS_ERR(fscache))
 		return PTR_ERR(fscache);
 
-	sbi->s_fscache = fscache;
+	sbi->dif0.fscache = fscache;
 	return 0;
 }
 
@@ -665,14 +665,14 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	erofs_fscache_unregister_cookie(sbi->s_fscache);
+	erofs_fscache_unregister_cookie(sbi->dif0.fscache);
 
 	if (sbi->domain)
 		erofs_fscache_domain_put(sbi->domain);
 	else
 		fscache_relinquish_volume(sbi->volume, NULL, false);
 
-	sbi->s_fscache = NULL;
+	sbi->dif0.fscache = NULL;
 	sbi->volume = NULL;
 	sbi->domain = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1c847c30a918..3e8d71d516f4 100644
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
@@ -166,7 +163,6 @@ struct erofs_sb_info {
 
 	/* fscache support */
 	struct fscache_volume *volume;
-	struct erofs_fscache *s_fscache;
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
@@ -187,7 +183,7 @@ struct erofs_sb_info {
 
 static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
 {
-	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
+	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
 }
 
 static inline bool erofs_is_fscache_mode(struct super_block *sb)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index de8e3ecc6381..9044907354e1 100644
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

