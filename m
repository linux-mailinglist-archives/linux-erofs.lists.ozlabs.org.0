Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C276C955
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 11:18:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RG5y06wDxz2ytX
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 19:18:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RG5xK2cp3z3c9G
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Aug 2023 19:18:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VouWExn_1690967886;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VouWExn_1690967886)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 17:18:07 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 16/16] erofs-utils: mkfs: introduce rebuild mode
Date: Wed,  2 Aug 2023 17:17:50 +0800
Message-Id: <20230802091750.74181-16-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
References: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
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

Introduce a new rebuild mode merging multiple erofs images generated
from tarfs mode.  This can be called like:

	mkfs.erofs IMAGE UPPER_IMAGE LOWER_IMAGE ...

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/rebuild.h |   1 +
 lib/rebuild.c           |  25 ++++++++++
 mkfs/main.c             | 108 +++++++++++++++++++++++++---------------
 3 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index 55cd856..04fcb26 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -23,6 +23,7 @@ void erofs_cleanup_imgs(void);
 
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_img *img,
 		unsigned long **datablk_map, unsigned long *datablks);
+struct erofs_inode *erofs_rebuild_load_trees(void);
 
 struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq);
diff --git a/lib/rebuild.c b/lib/rebuild.c
index f641c40..d23bbdf 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -417,6 +417,31 @@ exit:
 	return ret;
 }
 
+struct erofs_inode *erofs_rebuild_load_trees(void)
+{
+	struct erofs_img *img;
+	struct erofs_inode *root;
+	int ret, index = 0;
+
+	root = erofs_new_inode();
+	if (IS_ERR(root))
+		return root;
+	root->i_srcpath = strdup("/");
+	root->i_mode = S_IFDIR | 0777;
+	root->i_parent = root;
+	root->i_mtime = root->sbi->build_time;
+	root->i_mtime_nsec = root->sbi->build_time_nsec;
+	erofs_init_empty_dir(root);
+
+	list_for_each_entry(img, &imgs_list, list) {
+		ret = erofs_rebuild_load_tree(root, img, NULL, NULL);
+		if (ret)
+			return ERR_PTR(ret);
+		sbi.devs[index++].blocks = img->sbi.devs[0].blocks;
+	}
+	return root;
+}
+
 struct erofs_img *erofs_get_img(const char *path)
 {
 	struct erofs_img *img = malloc(sizeof(*img));
diff --git a/mkfs/main.c b/mkfs/main.c
index b495a54..3290ec8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -26,6 +26,7 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
+#include "erofs/rebuild.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 
@@ -132,6 +133,7 @@ static void usage(void)
 static unsigned int pclustersize_packed, pclustersize_max;
 static struct erofs_tarfile erofstar;
 static bool tar_mode;
+static bool rebuild_mode;
 
 static int parse_extended_opts(const char *opts)
 {
@@ -275,7 +277,8 @@ static int mkfs_parse_compress_algs(char *algs)
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	char *endptr;
-	int opt, i;
+	struct stat st;
+	int opt, i, err;
 	bool quiet = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:",
@@ -531,7 +534,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		} else {
 			erofstar.fd = STDIN_FILENO;
 		}
-	}else {
+	} else {
 		cfg.c_src_path = realpath(argv[optind++], NULL);
 		if (!cfg.c_src_path) {
 			erofs_err("failed to parse source directory: %s",
@@ -539,11 +542,39 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			return -ENOENT;
 		}
 
-		if (optind < argc) {
+		if (tar_mode) {
+			erofstar.fd = open(cfg.c_src_path, O_RDONLY);
+			if (erofstar.fd < 0) {
+				erofs_err("failed to open file: %s", cfg.c_src_path);
+				usage();
+				return -errno;
+			}
+		} else {
+			err = lstat(cfg.c_src_path, &st);
+			if (err)
+				return -errno;
+			if (S_ISDIR(st.st_mode))
+				erofs_set_fs_root(cfg.c_src_path);
+			else
+				rebuild_mode = true;
+		}
+
+		if (rebuild_mode) {
+			optind--;
+			while (optind < argc) {
+				err = erofs_add_img(argv[optind++]);
+				if (err) {
+					erofs_err("failed to parse image file");
+					erofs_cleanup_imgs();
+					return err;
+				}
+			}
+		} else if (optind < argc) {
 			erofs_err("unexpected argument: %s\n", argv[optind]);
 			return -EINVAL;
 		}
 	}
+
 	if (quiet) {
 		cfg.c_dbg_lvl = EROFS_ERR;
 		cfg.c_showprogress = false;
@@ -734,7 +765,6 @@ int main(int argc, char **argv)
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode, *packed_inode;
 	erofs_nid_t root_nid, packed_nid;
-	struct stat st;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37];
@@ -757,26 +787,6 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (!tar_mode) {
-		err = lstat(cfg.c_src_path, &st);
-		if (err)
-			return 1;
-		if (!S_ISDIR(st.st_mode)) {
-			erofs_err("root of the filesystem is not a directory - %s",
-				  cfg.c_src_path);
-			usage();
-			return 1;
-		}
-		erofs_set_fs_root(cfg.c_src_path);
-	} else if (cfg.c_src_path) {
-		erofstar.fd = open(cfg.c_src_path, O_RDONLY);
-		if (erofstar.fd < 0) {
-			erofs_err("failed to open file: %s", cfg.c_src_path);
-			usage();
-			return 1;
-		}
-	}
-
 	if (cfg.c_unix_timestamp != -1) {
 		sbi.build_time      = cfg.c_unix_timestamp;
 		sbi.build_time_nsec = 0;
@@ -843,6 +853,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (rebuild_mode)
+		sbi.blkszbits = 9;
+
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
@@ -900,6 +913,8 @@ int main(int argc, char **argv)
 
 	if ((erofstar.index_mode && !erofstar.mapfile) || cfg.c_blobdev_path)
 		err = erofs_mkfs_init_devices(&sbi, 1);
+	else if (rebuild_mode)
+		err = erofs_mkfs_init_devices(&sbi, imgs_count);
 	if (err) {
 		erofs_err("failed to generate device table: %s",
 			  erofs_strerror(err));
@@ -913,23 +928,7 @@ int main(int argc, char **argv)
 	if (cfg.c_extra_ea_name_prefixes)
 		erofs_xattr_write_name_prefixes(&sbi, packedfile);
 
-	if (!tar_mode) {
-		err = erofs_build_shared_xattrs_from_path(&sbi, cfg.c_src_path);
-		if (err) {
-			erofs_err("failed to build shared xattrs: %s",
-				  erofs_strerror(err));
-			goto exit;
-		}
-
-		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_write_name_prefixes(&sbi, packedfile);
-
-		root_inode = erofs_mkfs_build_tree_from_path(cfg.c_src_path);
-		if (IS_ERR(root_inode)) {
-			err = PTR_ERR(root_inode);
-			goto exit;
-		}
-	} else {
+	if (tar_mode) {
 		root_inode = erofs_new_inode();
 		if (IS_ERR(root_inode)) {
 			err = PTR_ERR(root_inode);
@@ -950,6 +949,32 @@ int main(int argc, char **argv)
 		err = erofs_rebuild_dump_tree(root_inode, false);
 		if (err < 0)
 			goto exit;
+	} else if (rebuild_mode) {
+		root_inode = erofs_rebuild_load_trees();
+		if (IS_ERR(root_inode)) {
+			err = PTR_ERR(root_inode);
+			goto exit;
+		}
+
+		err = erofs_rebuild_dump_tree(root_inode, true);
+		if (err)
+			goto exit;
+	} else {
+		err = erofs_build_shared_xattrs_from_path(&sbi, cfg.c_src_path);
+		if (err) {
+			erofs_err("failed to build shared xattrs: %s",
+				  erofs_strerror(err));
+			goto exit;
+		}
+
+		if (cfg.c_extra_ea_name_prefixes)
+			erofs_xattr_write_name_prefixes(&sbi, packedfile);
+
+		root_inode = erofs_mkfs_build_tree_from_path(cfg.c_src_path);
+		if (IS_ERR(root_inode)) {
+			err = PTR_ERR(root_inode);
+			goto exit;
+		}
 	}
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
@@ -1003,6 +1028,7 @@ exit:
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
+	erofs_cleanup_imgs();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

