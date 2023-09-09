Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E559799A04
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RjdpC1DJ6z3cNY
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rjdnm4mNtz3cCH
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:33:16 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrfyqX2_1694277191;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqX2_1694277191)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:33:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 12/13] erofs-utils: mkfs: introduce rebuild mode
Date: Sun, 10 Sep 2023 00:32:39 +0800
Message-Id: <20230909163240.42057-13-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
References: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Introduce a new EXPERIMENTAL rebuild mode, which can be used to
generate a meta-only multidev manifest image with an overlayfs-like
merged tree from multiple specific EROFS images either of

tarerofs index mode (--tar=i):

  mkfs.erofs --tar=i --aufs layer0.erofs layer0.tar
  ...
  mkfs.erofs --tar=i --aufs layerN.erofs layerN-1.tar

or mkfs.erofs uncompressed mode without inline data:

  mkfs.erofs --tar=f -Enoinline_data --aufs layer0.erofs layer0.tar
  ...
  mkfs.erofs --tar=f -Enoinline_data --aufs layerN-1.erofs layerN-1.tar

To merge these layers, just type:
  mkfs.erofs merged.erofs layer0.erofs ... layerN-1.erofs

It doesn't support compression and/or flat inline datalayout yet.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |   2 +
 mkfs/main.c              | 217 ++++++++++++++++++++++++++++++---------
 2 files changed, 169 insertions(+), 50 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b973266..405cbf0 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -112,6 +112,8 @@ struct erofs_sb_info {
 	dev_t dev;
 	unsigned int nblobs;
 	unsigned int blobfd[256];
+
+	struct list_head list;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/mkfs/main.c b/mkfs/main.c
index 94f6407..571cf19 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -26,6 +26,7 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
+#include "erofs/rebuild.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 
@@ -83,8 +84,8 @@ static void print_available_compressors(FILE *f, const char *delim)
 
 static void usage(void)
 {
-	fputs("usage: [options] FILE DIRECTORY\n\n"
-	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
+	fputs("usage: [options] FILE SOURCE(s)\n"
+	      "Generate EROFS image (FILE) from DIRECTORY, TARBALL and/or EROFS images.  And [options] are:\n"
 	      " -b#                   set block size to # (# = page size by default)\n"
 	      " -d#                   set output message level to # (maximum 9)\n"
 	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
@@ -135,7 +136,10 @@ static unsigned int pclustersize_packed, pclustersize_max;
 static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
 };
-static bool tar_mode;
+static bool tar_mode, rebuild_mode;
+
+static unsigned int rebuild_src_count;
+static LIST_HEAD(rebuild_src_list);
 
 static int parse_extended_opts(const char *opts)
 {
@@ -291,10 +295,23 @@ static int mkfs_parse_compress_algs(char *algs)
 	return 0;
 }
 
+static void erofs_rebuild_cleanup(void)
+{
+	struct erofs_sb_info *src, *n;
+
+	list_for_each_entry_safe(src, n, &rebuild_src_list, list) {
+		list_del(&src->list);
+		erofs_put_super(src);
+		dev_close(src);
+		free(src);
+	}
+	rebuild_src_count = 0;
+}
+
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	char *endptr;
-	int opt, i;
+	int opt, i, err;
 	bool quiet = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:",
@@ -545,12 +562,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 	if (optind >= argc) {
 		if (!tar_mode) {
-			erofs_err("missing argument: DIRECTORY");
+			erofs_err("missing argument: SOURCE(s)");
 			return -EINVAL;
 		} else {
 			erofstar.fd = STDIN_FILENO;
 		}
-	}else {
+	} else {
+		struct stat st;
+
 		cfg.c_src_path = realpath(argv[optind++], NULL);
 		if (!cfg.c_src_path) {
 			erofs_err("failed to parse source directory: %s",
@@ -558,7 +577,47 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
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
+			char *srcpath = cfg.c_src_path;
+
+			do {
+				struct erofs_sb_info *src;
+
+				src = calloc(1, sizeof(struct erofs_sb_info));
+				if (!src) {
+					erofs_rebuild_cleanup();
+					return -ENOMEM;
+				}
+
+				err = dev_open_ro(src, srcpath);
+				if (err) {
+					free(src);
+					erofs_rebuild_cleanup();
+					return err;
+				}
+
+				/* extra device index starts from 1 */
+				src->dev = ++rebuild_src_count;
+				list_add(&src->list, &rebuild_src_list);
+			} while (optind < argc && (srcpath = argv[optind++]));
+		} else if (optind < argc) {
 			erofs_err("unexpected argument: %s\n", argv[optind]);
 			return -EINVAL;
 		}
@@ -748,6 +807,61 @@ void erofs_show_progs(int argc, char *argv[])
 	if (cfg.c_dbg_lvl >= EROFS_WARN)
 		printf("%s %s\n", basename(argv[0]), cfg.c_version);
 }
+static struct erofs_inode *erofs_alloc_root_inode(void)
+{
+	struct erofs_inode *root;
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
+	return root;
+}
+
+static int erofs_rebuild_load_trees(struct erofs_inode *root)
+{
+	struct erofs_sb_info *src;
+	unsigned int extra_devices = 0;
+	erofs_blk_t nblocks;
+	int ret, i = 0;
+
+	list_for_each_entry(src, &rebuild_src_list, list) {
+		ret = erofs_rebuild_load_tree(root, src);
+		if (ret) {
+			erofs_err("failed to load %s", src->devname);
+			return ret;
+		}
+		if (src->extra_devices > 1) {
+			erofs_err("%s: unsupported number of extra devices",
+				  src->devname, src->extra_devices);
+			return -EOPNOTSUPP;
+		}
+		extra_devices += src->extra_devices;
+	}
+
+	if (extra_devices && extra_devices != rebuild_src_count) {
+		erofs_err("unsupported mix of source images");
+		return -EOPNOTSUPP;
+	}
+
+	ret = erofs_mkfs_init_devices(&sbi, rebuild_src_count);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(src, &rebuild_src_list, list) {
+		if (extra_devices)
+			nblocks = src->devs[0].blocks;
+		else
+			nblocks = src->primarydevice_blocks;
+		sbi.devs[i++].blocks = nblocks;
+	}
+	return 0;
+}
 
 int main(int argc, char **argv)
 {
@@ -755,7 +869,6 @@ int main(int argc, char **argv)
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode, *packed_inode;
 	erofs_nid_t root_nid, packed_nid;
-	struct stat st;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37];
@@ -778,26 +891,6 @@ int main(int argc, char **argv)
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
@@ -861,6 +954,22 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (rebuild_mode) {
+		struct erofs_sb_info *src;
+
+		erofs_warn("EXPERIMENTAL rebuild mode in use. Use at your own risk!");
+
+		src = list_first_entry(&rebuild_src_list, struct erofs_sb_info, list);
+		if (!src)
+			goto exit;
+		err = erofs_read_superblock(src);
+		if (err) {
+			erofs_err("failed to read superblock of %s", src->devname);
+			goto exit;
+		}
+		sbi.blkszbits = src->blkszbits;
+	}
+
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
@@ -928,7 +1037,35 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
-	if (!tar_mode) {
+	if (tar_mode) {
+		root_inode = erofs_alloc_root_inode();
+		if (IS_ERR(root_inode)) {
+			err = PTR_ERR(root_inode);
+			goto exit;
+		}
+
+		while (!(err = tarerofs_parse_tar(root_inode, &erofstar)));
+
+		if (err < 0)
+			goto exit;
+
+		err = erofs_rebuild_dump_tree(root_inode);
+		if (err < 0)
+			goto exit;
+	} else if (rebuild_mode) {
+		root_inode = erofs_alloc_root_inode();
+		if (IS_ERR(root_inode)) {
+			err = PTR_ERR(root_inode);
+			goto exit;
+		}
+
+		err = erofs_rebuild_load_trees(root_inode);
+		if (err)
+			goto exit;
+		err = erofs_rebuild_dump_tree(root_inode);
+		if (err)
+			goto exit;
+	} else {
 		err = erofs_build_shared_xattrs_from_path(&sbi, cfg.c_src_path);
 		if (err) {
 			erofs_err("failed to build shared xattrs: %s",
@@ -944,27 +1081,6 @@ int main(int argc, char **argv)
 			err = PTR_ERR(root_inode);
 			goto exit;
 		}
-	} else {
-		root_inode = erofs_new_inode();
-		if (IS_ERR(root_inode)) {
-			err = PTR_ERR(root_inode);
-			goto exit;
-		}
-		root_inode->i_srcpath = strdup("/");
-		root_inode->i_mode = S_IFDIR | 0777;
-		root_inode->i_parent = root_inode;
-		root_inode->i_mtime = sbi.build_time;
-		root_inode->i_mtime_nsec = sbi.build_time_nsec;
-		erofs_init_empty_dir(root_inode);
-
-		while (!(err = tarerofs_parse_tar(root_inode, &erofstar)));
-
-		if (err < 0)
-			goto exit;
-
-		err = erofs_rebuild_dump_tree(root_inode);
-		if (err < 0)
-			goto exit;
 	}
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
@@ -1024,6 +1140,7 @@ exit:
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
+	erofs_rebuild_cleanup();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.24.4

