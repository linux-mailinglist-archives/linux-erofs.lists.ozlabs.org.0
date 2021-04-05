Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC21353D5C
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 11:50:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDQrH68fwz30D6
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 19:50:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FDQrD259Gz303S
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Apr 2021 19:50:18 +1000 (AEST)
Received: from laptop.huww98.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowAD3_tZC3WpgZNkZAA--.11032S4;
 Mon, 05 Apr 2021 17:49:55 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: hsiangkao@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: get rid of inode->i_srcpath
Date: Mon,  5 Apr 2021 17:49:50 +0800
Message-Id: <20210405094950.150983-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAD3_tZC3WpgZNkZAA--.11032S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JryDAF4DWFW5Zw4xJry7ZFb_yoWfXr4UpF
 Wjkry8J3ykXryUCr4ktr4qv3W3KF4xtr47u34xXwn5Z3W3Jr1IqF40kr95JF45GrWkX39I
 vF429w1Uur13tw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
 GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU6rWrUUU
 UU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQASBlepTBMIEQAbs2
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This cut the memory usage by half.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 include/erofs/compress.h |  2 +-
 include/erofs/internal.h |  2 --
 include/erofs/xattr.h    |  2 +-
 lib/compress.c           | 24 +++++++--------------
 lib/inode.c              | 45 ++++++++++++++++++++--------------------
 lib/xattr.c              |  4 ++--
 6 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 952f287..a1dd55f 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -16,7 +16,7 @@
 #define EROFS_CONFIG_COMPR_MAX_SZ           (900  * 1024)
 #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
 
-int erofs_write_compressed_file(struct erofs_inode *inode);
+int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(void);
 int z_erofs_compress_exit(void);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ac5b270..d99d4ac 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -137,8 +137,6 @@ struct erofs_inode {
 		u32 i_rdev;
 	} u;
 
-	char i_srcpath[PATH_MAX + 1];
-
 	unsigned char datalayout;
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 197fe25..e22342d 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -42,7 +42,7 @@
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif
 
-int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
+int erofs_prepare_xattr_ibody(struct erofs_inode *inode, const char *path);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
 
diff --git a/lib/compress.c b/lib/compress.c
index 4b685cd..ea2310e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -170,8 +170,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 					      &count, dst, EROFS_BLKSIZ);
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
-				erofs_err("failed to compress %s: %s",
-					  inode->i_srcpath,
+				erofs_err("failed to compress: %s",
 					  erofs_strerror(ret));
 			}
 nocompression:
@@ -388,30 +387,24 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	return 0;
 }
 
-int erofs_write_compressed_file(struct erofs_inode *inode)
+int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
 	struct z_erofs_vle_compress_ctx ctx;
 	erofs_off_t remaining;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
-	int ret, fd;
+	int ret;
 
 	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
 	if (!compressmeta)
 		return -ENOMEM;
 
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0) {
-		ret = -errno;
-		goto err_free;
-	}
-
 	/* allocate main data buffer */
 	bh = erofs_balloc(DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
-		goto err_close;
+		goto err;
 	}
 
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
@@ -455,13 +448,12 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 
 	vle_write_indexes_final(&ctx);
 
-	close(fd);
 	DBG_BUGON(!compressed_blocks);
 	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
 	DBG_BUGON(ret != EROFS_BLKSIZ);
 
-	erofs_info("compressed %s (%llu bytes) into %u blocks",
-		   inode->i_srcpath, (unsigned long long)inode->i_size,
+	erofs_info("compressed %llu bytes into %u blocks",
+		   (unsigned long long)inode->i_size,
 		   compressed_blocks);
 
 	/*
@@ -486,9 +478,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 
 err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
-err_close:
-	close(fd);
-err_free:
+err:
 	free(compressmeta);
 	return ret;
 }
diff --git a/lib/inode.c b/lib/inode.c
index d52facf..44ed6f6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -362,9 +362,9 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-int erofs_write_file(struct erofs_inode *inode)
+int erofs_write_file(struct erofs_inode *inode, int fd)
 {
-	int ret, fd;
+	int ret;
 
 	if (!inode->i_size) {
 		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
@@ -372,17 +372,15 @@ int erofs_write_file(struct erofs_inode *inode)
 	}
 
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode);
+		ret = erofs_write_compressed_file(inode, fd);
 
-		if (!ret || ret != -ENOSPC)
+		if (!ret || ret != -ENOSPC) {
+			close(fd);
 			return ret;
+		}
 	}
 
 	/* fallback to all data uncompressed */
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0)
-		return -errno;
-
 	ret = write_uncompressed_file_from_fd(inode, fd);
 	close(fd);
 	return ret;
@@ -786,16 +784,12 @@ int erofs_fill_inode(struct erofs_inode *inode,
 		return -EINVAL;
 	}
 
-	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
-	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
-
 	inode->dev = st->st_dev;
 	inode->i_ino[1] = st->st_ino;
 
 	if (erofs_should_use_inode_extended(inode)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
-			erofs_err("file %s cannot be in compact form",
-				  inode->i_srcpath);
+			erofs_err("file %s cannot be in compact form", path);
 			return -EINVAL;
 		}
 		inode->inode_isize = sizeof(struct erofs_inode_extended);
@@ -916,14 +910,15 @@ void erofs_d_invalidate(struct erofs_dentry *d)
 	erofs_iput(inode);
 }
 
-struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
+struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir,
+		const char *src_path)
 {
 	int ret;
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
 
-	ret = erofs_prepare_xattr_ibody(dir);
+	ret = erofs_prepare_xattr_ibody(dir, src_path);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
@@ -933,7 +928,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 			if (!symlink)
 				return ERR_PTR(-ENOMEM);
-			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
+			ret = readlink(src_path, symlink, dir->i_size);
 			if (ret < 0) {
 				free(symlink);
 				return ERR_PTR(-errno);
@@ -944,7 +939,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			if (ret)
 				return ERR_PTR(ret);
 		} else {
-			ret = erofs_write_file(dir);
+			int fd = open(src_path, O_RDONLY | O_BINARY);
+
+			if (fd < 0)
+				return ERR_PTR(-errno);
+			ret = erofs_write_file(dir, fd);
 			if (ret)
 				return ERR_PTR(ret);
 		}
@@ -954,10 +953,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		return dir;
 	}
 
-	_dir = opendir(dir->i_srcpath);
+	_dir = opendir(src_path);
 	if (!_dir) {
 		erofs_err("%s, failed to opendir at %s: %s",
-			  __func__, dir->i_srcpath, erofs_strerror(errno));
+			  __func__, src_path, erofs_strerror(errno));
 		return ERR_PTR(-errno);
 	}
 
@@ -976,7 +975,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			continue;
 
 		/* skip if it's a exclude file */
-		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
+		if (erofs_is_exclude_path(src_path, dp->d_name))
 			continue;
 
 		d = erofs_d_alloc(dir, dp->d_name);
@@ -1017,7 +1016,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		}
 
 		ret = snprintf(buf, PATH_MAX, "%s/%s",
-			       dir->i_srcpath, d->name);
+			       src_path, d->name);
 		if (ret < 0 || ret >= PATH_MAX) {
 			/* ignore the too long path */
 			goto fail;
@@ -1038,7 +1037,7 @@ fail:
 
 		erofs_d_invalidate(d);
 		erofs_info("add file %s/%s (nid %llu, type %d)",
-			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
+			   src_path, d->name, (unsigned long long)d->nid,
 			   d->type);
 	}
 	erofs_write_dir_file(dir);
@@ -1071,6 +1070,6 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 	else
 		inode->i_parent = inode;	/* rootdir mark */
 
-	return erofs_mkfs_build_tree(inode);
+	return erofs_mkfs_build_tree(inode, path);
 }
 
diff --git a/lib/xattr.c b/lib/xattr.c
index 8b7bcb1..e128f3d 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -401,7 +401,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 }
 #endif
 
-int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
+int erofs_prepare_xattr_ibody(struct erofs_inode *inode, const char *path)
 {
 	int ret;
 	struct inode_xattr_node *node;
@@ -411,7 +411,7 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 	if (cfg.c_inline_xattr_tolerance < 0)
 		return 0;
 
-	ret = read_xattrs_from_file(inode->i_srcpath, inode->i_mode, ixattrs);
+	ret = read_xattrs_from_file(path, inode->i_mode, ixattrs);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1

