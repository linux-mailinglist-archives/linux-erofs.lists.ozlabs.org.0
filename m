Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF0578514E
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 09:16:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVyDp27DMz3bwj
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:16:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVyD46L9sz2yst
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Aug 2023 17:15:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqPMMFx_1692774927;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqPMMFx_1692774927)
          by smtp.aliyun-inc.com;
          Wed, 23 Aug 2023 15:15:28 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 10/10] erofs-utils: mkfs: add --keep-whiteout option for tarfs and rebuild mode
Date: Wed, 23 Aug 2023 15:15:17 +0800
Message-Id: <20230823071517.12303-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
References: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
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

Add "--keep-whiteout=[0|1]" option for tarfs and rebuild mode,
controlling whether whiteout files are kept in the generated image.

This option is enabled by default for both tarfs and rebuild mode, i.e.
as if "--keep-whiteout=1" is specified by default.

To hide whiteout files, specify "--keep-whiteout=0" explicitly.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  2 ++
 lib/config.c             |  1 +
 lib/inode.c              | 17 +++++++++++++++--
 lib/tar.c                |  2 --
 mkfs/main.c              | 12 ++++++++++++
 6 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8f52d2c..91c9d7d 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
+	bool c_keep_whiteout;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3596689..7cc3864 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -426,6 +426,8 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, size_t len)
 	return crc;
 }
 
+#define EROFS_WHITEOUT_DEV	0
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/config.c b/lib/config.c
index a3235c8..ae24a17 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -33,6 +33,7 @@ void erofs_init_configure(void)
 	cfg.c_pclusterblks_max = 1;
 	cfg.c_pclusterblks_def = 1;
 	cfg.c_max_decompressed_extent_bytes = -1;
+	cfg.c_keep_whiteout = true;
 }
 
 void erofs_show_config(void)
diff --git a/lib/inode.c b/lib/inode.c
index 1cd69ec..c14c30d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1323,9 +1323,14 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	return inode;
 }
 
+static bool erofs_inode_is_whiteout(struct erofs_inode *inode)
+{
+	return S_ISCHR(inode->i_mode) && inode->u.i_rdev == EROFS_WHITEOUT_DEV;
+}
+
 int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 {
-	struct erofs_dentry *d;
+	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs;
 	int ret;
 
@@ -1369,8 +1374,16 @@ int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 	}
 
 	nr_subdirs = 0;
-	list_for_each_entry(d, &dir->i_subdirs, d_child)
+	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+		if (!cfg.c_keep_whiteout && erofs_inode_is_whiteout(d->inode)) {
+			erofs_dbg("skip whiteout %s", d->inode->i_srcpath);
+			list_del(&d->d_child);
+			erofs_d_invalidate(d);
+			free(d);
+			continue;
+		}
 		++nr_subdirs;
+	}
 
 	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
 	if (ret)
diff --git a/lib/tar.c b/lib/tar.c
index cf3497f..26830f4 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -13,8 +13,6 @@
 #include "erofs/blobchunk.h"
 #include "erofs/rebuild.h"
 
-#define EROFS_WHITEOUT_DEV	0
-
 static char erofs_libbuf[16384];
 
 struct tar_header {
diff --git a/mkfs/main.c b/mkfs/main.c
index 961dfba..e5f3485 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -57,6 +57,7 @@ static struct option long_options[] = {
 	{"gid-offset", required_argument, NULL, 17},
 	{"tar", optional_argument, NULL, 20},
 	{"aufs", no_argument, NULL, 21},
+	{"keep-whiteout", required_argument, NULL, 22},
 	{"mount-point", required_argument, NULL, 512},
 	{"xattr-prefix", required_argument, NULL, 19},
 #ifdef WITH_ANDROID
@@ -121,6 +122,7 @@ static void usage(void)
 	      " --preserve-mtime      keep per-file modification time strictly\n"
 	      " --aufs                replace aufs special files with overlayfs metadata\n"
 	      " --tar=[fi]            generate an image from tarball(s)\n"
+	      " --keep-whiteout=[01]  keep whiteout in tarfs or rebuild mode\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
@@ -521,6 +523,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 21:
 			erofstar.aufs = true;
 			break;
+		case 22:
+			if (!strcmp(optarg, "0"))
+				cfg.c_keep_whiteout = false;
+			else if (!strcmp(optarg, "1"))
+				cfg.c_keep_whiteout = true;
+			else {
+				erofs_err("invalid keep-whiteout %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.19.1.6.gb485710b

