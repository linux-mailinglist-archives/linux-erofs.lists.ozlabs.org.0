Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3607921C8
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 12:03:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rg1KQ1Wt1z3cC7
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 20:03:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rg1Jx1N9qz3c2f
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 20:02:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrPSToO_1693908155;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VrPSToO_1693908155)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 18:02:36 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 08/11] erofs-utils: mkfs: introduce rebuild mode
Date: Tue,  5 Sep 2023 18:02:24 +0800
Message-Id: <20230905100227.1072-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
References: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
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
from either tarerfs index mode (--tar=i):

	mkfs.erofs --tar=i --aufs layer0.erofs layer0.tar
	...
	mkfs.erofs --tar=i --aufs layerN.erofs layerN.tar

	mkfs.erofs merge.erofs layerN.erofs ... layer0.erofs

or tarerofs non-index mode (--tar=f):

	mkfs.erofs --tar=f -Enoinline_data --aufs layer0.erofs layer0.tar
	...
	mkfs.erofs --tar=f -Enoinline_data --aufs layerN.erofs layerN.tar

	mkfs.erofs merge.erofs layerN.erofs ... layer0.erofs

When calling rebuild mode, the top most layer must be specified firstly
in the cmdline, while the bottom most layer i.e. layer0 the lastly.

The rebuild mode doesn't support flat inline datalayout yet.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |   2 +
 mkfs/main.c              | 216 ++++++++++++++++++++++++++++++---------
 2 files changed, 170 insertions(+), 48 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3d5c337..fcc0710 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -111,6 +111,8 @@ struct erofs_sb_info {
 	dev_t dev;
 	unsigned int nblobs;
 	unsigned int blobfd[256];
+
+	struct list_head list;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/mkfs/main.c b/mkfs/main.c
index 94f6407..b51ef37 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -26,6 +26,7 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
+#include "erofs/rebuild.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 
@@ -83,8 +84,14 @@ static void print_available_compressors(FILE *f, const char *delim)
 
 static void usage(void)
 {
-	fputs("usage: [options] FILE DIRECTORY\n\n"
-	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
+	fputs("usage:\n"
+	      "[options] FILE DIRECTORY\t"
+	      "Generate erofs image (FILE) from DIRECTORY.\n"
+	      "[options] FILE TARBALL\t\t"
+	      "Generate erofs image (FILE) from TARBALL.\n"
+	      "[options] FILE SOURCE(s)\t"
+	      "Generate erofs image (FILE) by merging previously generated images.\n\n"
+	      "[options] are:\n"
 	      " -b#                   set block size to # (# = page size by default)\n"
 	      " -d#                   set output message level to # (maximum 9)\n"
 	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
@@ -136,6 +143,10 @@ static struct erofs_tarfile erofstar = {
 	.global.xattrs = LIST_HEAD_INIT(erofstar.global.xattrs)
 };
 static bool tar_mode;
+static bool rebuild_mode;
+
+static unsigned int rebuild_src_count;
+static LIST_HEAD(rebuild_src_list);
 
 static int parse_extended_opts(const char *opts)
 {
@@ -291,10 +302,24 @@ static int mkfs_parse_compress_algs(char *algs)
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
+	struct stat st;
+	int opt, i, err;
 	bool quiet = false;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:",
@@ -550,7 +575,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		} else {
 			erofstar.fd = STDIN_FILENO;
 		}
-	}else {
+	} else {
 		cfg.c_src_path = realpath(argv[optind++], NULL);
 		if (!cfg.c_src_path) {
 			erofs_err("failed to parse source directory: %s",
@@ -558,7 +583,46 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
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
+			struct erofs_sb_info *src;
+
+			do {
+				src = malloc(sizeof(struct erofs_sb_info));
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
+				list_add_tail(&src->list, &rebuild_src_list);
+			} while (optind < argc && (srcpath = argv[optind++]));
+		} else if (optind < argc) {
 			erofs_err("unexpected argument: %s\n", argv[optind]);
 			return -EINVAL;
 		}
@@ -748,6 +812,61 @@ void erofs_show_progs(int argc, char *argv[])
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
@@ -755,7 +874,6 @@ int main(int argc, char **argv)
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode, *packed_inode;
 	erofs_nid_t root_nid, packed_nid;
-	struct stat st;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37];
@@ -778,26 +896,6 @@ int main(int argc, char **argv)
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
@@ -861,6 +959,20 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (rebuild_mode) {
+		struct erofs_sb_info *src;
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
@@ -928,7 +1040,35 @@ int main(int argc, char **argv)
 
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
@@ -944,27 +1084,6 @@ int main(int argc, char **argv)
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
@@ -1024,6 +1143,7 @@ exit:
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
+	erofs_rebuild_cleanup();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

