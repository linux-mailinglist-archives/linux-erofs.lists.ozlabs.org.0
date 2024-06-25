Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86657915D4F
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 05:25:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iqJ54FQB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W7VZY05Qsz3cZr
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 13:25:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iqJ54FQB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W7VZS1b2Cz3cFw
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2024 13:25:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719285899; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xsZaXO+0tPCLM15S+60XAI3WGks6dXxNoj+N9UavIZk=;
	b=iqJ54FQB/irLobPLI2LdPx9uKMgmmuZ+ATDw7Hja//JFWVBzFMOGBqlm3SutOsnAST0LNTW2k0Hh9VxwjgLr/3f0JFPrL/tgS6h47k22bRUziUxn3bKjTuBIZhIzSF2i7MYunZETh2kl5oI/QXsWvHz3R64bKkLIBpE/PsIujIU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9E13hN_1719285897;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9E13hN_1719285897)
          by smtp.aliyun-inc.com;
          Tue, 25 Jun 2024 11:24:58 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: lib: add erofs_{rebuild_make_root,enable_sb_chksum}
Date: Tue, 25 Jun 2024 11:24:56 +0800
Message-Id: <20240625032456.1347088-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Move erofs_sb_csum_set() and erofs_mkfs_alloc_root() into liberofs
for external use.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Update the commit message.
v1: https://lore.kernel.org/all/20240625031005.1334796-1-hongzhen@linux.alibaba.com/
---
 include/erofs/inode.h    |  1 +
 include/erofs/internal.h |  1 +
 lib/inode.c              | 16 +++++++++
 lib/super.c              | 47 ++++++++++++++++++++++++
 mkfs/main.c              | 77 +++++-----------------------------------
 5 files changed, 73 insertions(+), 69 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 2af8e6c..604161c 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -45,6 +45,7 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
 struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 						     int fd, const char *name);
 int erofs_fixup_root_inode(struct erofs_inode *root);
+struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 8ed5b0e..361477a 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -403,6 +403,7 @@ void erofs_put_super(struct erofs_sb_info *sbi);
 int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 		  erofs_blk_t *blocks);
 struct erofs_buffer_head *erofs_reserve_sb(struct erofs_sb_info *sbi);
+int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc);
 
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/lib/inode.c b/lib/inode.c
index 60a076a..68f16f4 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1986,3 +1986,19 @@ int erofs_fixup_root_inode(struct erofs_inode *root)
 	free(ibuf);
 	return err;
 }
+
+struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
+{
+	struct erofs_inode *root;
+
+	root = erofs_new_inode(sbi);
+	if (IS_ERR(root))
+		return root;
+	root->i_srcpath = strdup("/");
+	root->i_mode = S_IFDIR | 0777;
+	root->i_parent = root;
+	root->i_mtime = root->sbi->build_time;
+	root->i_mtime_nsec = root->sbi->build_time_nsec;
+	erofs_init_empty_dir(root);
+	return root;
+}
diff --git a/lib/super.c b/lib/super.c
index 69c57c8..7579875 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -232,3 +232,50 @@ err_bdrop:
 	erofs_bdrop(bh, true);
 	return ERR_PTR(err);
 }
+
+int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc)
+{
+	int ret;
+	u8 buf[EROFS_MAX_BLOCK_SIZE];
+	unsigned int len;
+	struct erofs_super_block *sb;
+
+	ret = erofs_blk_read(sbi, 0, buf, 0, erofs_blknr(sbi, EROFS_SUPER_END) + 1);
+	if (ret) {
+		erofs_err("failed to read superblock to set checksum: %s",
+			  erofs_strerror(ret));
+		return ret;
+	}
+
+	/*
+	 * skip the first 1024 bytes, to allow for the installation
+	 * of x86 boot sectors and other oddities.
+	 */
+	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
+
+	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("internal error: not an erofs valid image");
+		return -EFAULT;
+	}
+
+	/* turn on checksum feature */
+	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
+					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
+	if (erofs_blksiz(sbi) > EROFS_SUPER_OFFSET)
+		len = erofs_blksiz(sbi) - EROFS_SUPER_OFFSET;
+	else
+		len = erofs_blksiz(sbi);
+	*crc = erofs_crc32c(~0, (u8 *)sb, len);
+
+	/* set up checksum field to erofs_super_block */
+	sb->checksum = cpu_to_le32(*crc);
+
+	ret = erofs_blk_write(sbi, buf, 0, 1);
+	if (ret) {
+		erofs_err("failed to write checksummed superblock: %s",
+			  erofs_strerror(ret));
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index e20e8c0..28a271d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -975,55 +975,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	return 0;
 }
 
-static int erofs_mkfs_superblock_csum_set(void)
-{
-	int ret;
-	u8 buf[EROFS_MAX_BLOCK_SIZE];
-	u32 crc;
-	unsigned int len;
-	struct erofs_super_block *sb;
-
-	ret = erofs_blk_read(&sbi, 0, buf, 0, erofs_blknr(&sbi, EROFS_SUPER_END) + 1);
-	if (ret) {
-		erofs_err("failed to read superblock to set checksum: %s",
-			  erofs_strerror(ret));
-		return ret;
-	}
-
-	/*
-	 * skip the first 1024 bytes, to allow for the installation
-	 * of x86 boot sectors and other oddities.
-	 */
-	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
-
-	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
-		erofs_err("internal error: not an erofs valid image");
-		return -EFAULT;
-	}
-
-	/* turn on checksum feature */
-	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
-					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
-	if (erofs_blksiz(&sbi) > EROFS_SUPER_OFFSET)
-		len = erofs_blksiz(&sbi) - EROFS_SUPER_OFFSET;
-	else
-		len = erofs_blksiz(&sbi);
-	crc = erofs_crc32c(~0, (u8 *)sb, len);
-
-	/* set up checksum field to erofs_super_block */
-	sb->checksum = cpu_to_le32(crc);
-
-	ret = erofs_blk_write(&sbi, buf, 0, 1);
-	if (ret) {
-		erofs_err("failed to write checksummed superblock: %s",
-			  erofs_strerror(ret));
-		return ret;
-	}
-
-	erofs_info("superblock checksum 0x%08x written", crc);
-	return 0;
-}
-
 static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
@@ -1075,22 +1026,6 @@ void erofs_show_progs(int argc, char *argv[])
 		printf("%s %s\n", basename(argv[0]), cfg.c_version);
 }
 
-static struct erofs_inode *erofs_mkfs_alloc_root(struct erofs_sb_info *sbi)
-{
-	struct erofs_inode *root;
-
-	root = erofs_new_inode(sbi);
-	if (IS_ERR(root))
-		return root;
-	root->i_srcpath = strdup("/");
-	root->i_mode = S_IFDIR | 0777;
-	root->i_parent = root;
-	root->i_mtime = root->sbi->build_time;
-	root->i_mtime_nsec = root->sbi->build_time_nsec;
-	erofs_init_empty_dir(root);
-	return root;
-}
-
 static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 {
 	struct erofs_sb_info *src;
@@ -1198,6 +1133,7 @@ int main(int argc, char **argv)
 	erofs_blk_t nblocks;
 	struct timeval t;
 	FILE *packedfile = NULL;
+	u32 crc;
 
 	erofs_init_configure();
 	erofs_mkfs_default_options();
@@ -1390,7 +1326,7 @@ int main(int argc, char **argv)
 	erofs_inode_manager_init();
 
 	if (tar_mode) {
-		root = erofs_mkfs_alloc_root(&sbi);
+		root = erofs_rebuild_make_root(&sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
@@ -1405,7 +1341,7 @@ int main(int argc, char **argv)
 		if (err < 0)
 			goto exit;
 	} else if (rebuild_mode) {
-		root = erofs_mkfs_alloc_root(&sbi);
+		root = erofs_rebuild_make_root(&sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
@@ -1471,8 +1407,11 @@ int main(int argc, char **argv)
 
 	err = erofs_dev_resize(&sbi, nblocks);
 
-	if (!err && erofs_sb_has_sb_chksum(&sbi))
-		err = erofs_mkfs_superblock_csum_set();
+	if (!err && erofs_sb_has_sb_chksum(&sbi)) {
+		err = erofs_enable_sb_chksum(&sbi, &crc);
+		if (!err)
+			erofs_info("superblock checksum 0x%08x written", crc);
+	}
 exit:
 	if (root)
 		erofs_iput(root);
-- 
2.39.3

