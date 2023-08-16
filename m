Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C577D840
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 04:14:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQWt71jr3z3cVJ
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 12:14:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQWsT4Zskz3cPk
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 12:14:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VptwY9m_1692152040;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VptwY9m_1692152040)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 10:14:01 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 12/12] erofs-utils: mkfs: introduce rebuild mode
Date: Wed, 16 Aug 2023 10:13:47 +0800
Message-Id: <20230816021347.126886-13-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
References: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
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
 mkfs/main.c              | 197 +++++++++++++++++++++++++++++++--------
 2 files changed, 158 insertions(+), 41 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d643d79..0d5f38d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -105,6 +105,8 @@ struct erofs_sb_info {
 	dev_t dev;
 	unsigned int nblobs;
 	unsigned int blobfd[256];
+
+	struct list_head list;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/mkfs/main.c b/mkfs/main.c
index 269ccf4..63e937d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -26,6 +26,7 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
+#include "erofs/rebuild.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 
@@ -134,6 +135,10 @@ static void usage(void)
 static unsigned int pclustersize_packed, pclustersize_max;
 static struct erofs_tarfile erofstar;
 static bool tar_mode;
+static bool rebuild_mode;
+
+static unsigned int rebuild_src_count;
+static LIST_HEAD(rebuild_src_list);
 
 static int parse_extended_opts(const char *opts)
 {
@@ -274,10 +279,24 @@ static int mkfs_parse_compress_algs(char *algs)
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
@@ -533,7 +552,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		} else {
 			erofstar.fd = STDIN_FILENO;
 		}
-	}else {
+	} else {
 		cfg.c_src_path = realpath(argv[optind++], NULL);
 		if (!cfg.c_src_path) {
 			erofs_err("failed to parse source directory: %s",
@@ -541,11 +560,51 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
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
+			optind--; /* roll back to retrieve the first source */
+			while (optind < argc) {
+				struct erofs_sb_info *src;
+
+				src = malloc(sizeof(struct erofs_sb_info));
+				if (!src) {
+					erofs_rebuild_cleanup();
+					return -ENOMEM;
+				}
+
+				err = dev_open_ro(src, argv[optind++]);
+				if (err) {
+					free(src);
+					erofs_rebuild_cleanup();
+					return err;
+				}
+
+				/* extra device index starts from 1 */
+				src->dev = ++rebuild_src_count;
+				list_add_tail(&src->list, &rebuild_src_list);
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
@@ -730,13 +789,63 @@ void erofs_show_progs(int argc, char *argv[])
 		printf("%s %s\n", basename(argv[0]), cfg.c_version);
 }
 
+struct erofs_inode *erofs_rebuild_load_trees(void)
+{
+	struct erofs_sb_info *src;
+	struct erofs_inode *root;
+	unsigned int extra_devices = 0;
+	erofs_blk_t nblocks;
+	int ret, i = 0;
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
+	list_for_each_entry(src, &rebuild_src_list, list) {
+		ret = erofs_rebuild_load_tree(root, src);
+		if (ret)
+			return ERR_PTR(ret);
+
+		if (src->extra_devices > 1) {
+			erofs_err("%s: unsupported number of extra devices",
+				  src->devname, src->extra_devices);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+		extra_devices += src->extra_devices;
+	}
+
+	if (extra_devices && extra_devices != rebuild_src_count) {
+		erofs_err("unsupported mix of source images");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	ret = erofs_mkfs_init_devices(&sbi, rebuild_src_count);
+	if (ret)
+		return ERR_PTR(ret);
+
+	list_for_each_entry(src, &rebuild_src_list, list) {
+		if (extra_devices)
+			nblocks = src->devs[0].blocks;
+		else
+			nblocks = src->primarydevice_blocks;
+		sbi.devs[i++].blocks = nblocks;
+	}
+
+	return root;
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode, *packed_inode;
 	erofs_nid_t root_nid, packed_nid;
-	struct stat st;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37];
@@ -759,26 +868,6 @@ int main(int argc, char **argv)
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
@@ -845,6 +934,21 @@ int main(int argc, char **argv)
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
+			erofs_err("failed to read superblock of img %s", src->devname);
+			goto exit;
+		}
+		sbi.blkszbits = src->blkszbits;
+		erofs_dbg("sbi.blkszbits %d", sbi.blkszbits);
+	}
+
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
@@ -912,23 +1016,7 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
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
@@ -949,6 +1037,32 @@ int main(int argc, char **argv)
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
@@ -1002,6 +1116,7 @@ exit:
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
+	erofs_rebuild_cleanup();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.19.1.6.gb485710b

