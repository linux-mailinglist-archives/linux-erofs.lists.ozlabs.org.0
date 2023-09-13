Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1079E78A
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 14:03:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rlzd24Tt8z3cC2
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 22:03:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlzcR0gwrz3bVr
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 22:03:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs-fU1F_1694606594;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vs-fU1F_1694606594)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 20:03:14 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 8/8] erofs-utils: mkfs: add `--ovlfs-strip` option
Date: Wed, 13 Sep 2023 20:03:03 +0800
Message-Id: <20230913120304.15741-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
References: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
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

Add `--ovlfs-strip=[0|1]` option for tarfs and rebuild mode for now
in order to control whether some overlayfs related stuffs (e.g.
whiteout files, OVL_XATTR_OPAQUE and OVL_XATTR_ORIGIN xattrs) are
finally stripped.

This option is disabled by default for mkfs, that is, the overlayfs
related stuffs described above are kept in the image by default.

Specify `--ovlfs-strip=1` explicitly to strip these stuffs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  1 +
 include/erofs/xattr.h  |  1 +
 lib/inode.c            | 17 ++++++++++++++---
 lib/xattr.c            | 18 ++++++++++++++++++
 mkfs/main.c            |  8 ++++++++
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 5d3bfba..e342722 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -54,6 +54,7 @@ struct erofs_configure {
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
+	bool c_ovlfs_strip;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 0364f24..0f76037 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -57,6 +57,7 @@ int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
 int erofs_set_opaque_xattr(struct erofs_inode *inode);
+void erofs_clear_opaque_xattr(struct erofs_inode *inode);
 int erofs_set_origin_xattr(struct erofs_inode *inode);
 int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
 
diff --git a/lib/inode.c b/lib/inode.c
index 93e6b23..37aa79e 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1326,7 +1326,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 
 int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 {
-	struct erofs_dentry *d;
+	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs;
 	int ret;
 
@@ -1341,7 +1341,10 @@ int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 		dir->inode_isize = sizeof(struct erofs_inode_compact);
 	}
 
-	if (dir->whiteouts)
+	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
+	if (cfg.c_ovlfs_strip)
+		erofs_clear_opaque_xattr(dir);
+	else if (dir->whiteouts)
 		erofs_set_origin_xattr(dir);
 
 	ret = erofs_prepare_xattr_ibody(dir);
@@ -1373,8 +1376,16 @@ int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 	}
 
 	nr_subdirs = 0;
-	list_for_each_entry(d, &dir->i_subdirs, d_child)
+	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+		if (cfg.c_ovlfs_strip && erofs_inode_is_whiteout(d->inode)) {
+			erofs_dbg("remove whiteout %s", d->inode->i_srcpath);
+			list_del(&d->d_child);
+			erofs_d_invalidate(d);
+			free(d);
+			continue;
+		}
 		++nr_subdirs;
+	}
 
 	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
 	if (ret)
diff --git a/lib/xattr.c b/lib/xattr.c
index e3a1b44..fffccb4 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -499,11 +499,29 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	return erofs_xattr_add(&inode->i_xattrs, item);
 }
 
+static void erofs_clearxattr(struct erofs_inode *inode, const char *key)
+{
+	struct inode_xattr_node *node, *n;
+
+	list_for_each_entry_safe(node, n, &inode->i_xattrs, list) {
+		if (!strcmp(node->item->kvbuf, key)) {
+			list_del(&node->list);
+			put_xattritem(node->item);
+			free(node);
+		}
+	}
+}
+
 int erofs_set_opaque_xattr(struct erofs_inode *inode)
 {
 	return erofs_setxattr(inode, OVL_XATTR_OPAQUE, "y", 1);
 }
 
+void erofs_clear_opaque_xattr(struct erofs_inode *inode)
+{
+	erofs_clearxattr(inode, OVL_XATTR_OPAQUE);
+}
+
 int erofs_set_origin_xattr(struct erofs_inode *inode)
 {
 	return erofs_setxattr(inode, OVL_XATTR_ORIGIN, NULL, 0);
diff --git a/mkfs/main.c b/mkfs/main.c
index ce2b0e2..389bb1b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -64,6 +64,7 @@ static struct option long_options[] = {
 	{"fs-config-file", required_argument, NULL, 514},
 	{"block-list-file", required_argument, NULL, 515},
 #endif
+	{"ovlfs-strip", optional_argument, NULL, 516},
 	{0, 0, 0, 0},
 };
 
@@ -115,6 +116,7 @@ static void usage(void)
 	      " --preserve-mtime      keep per-file modification time strictly\n"
 	      " --aufs                replace aufs special files with overlayfs metadata\n"
 	      " --tar=[fi]            generate an image from tarball(s)\n"
+	      " --ovlfs-strip=[01]    strip overlayfs metadata in the target image (e.g. whiteouts)\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
@@ -516,6 +518,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 21:
 			erofstar.aufs = true;
 			break;
+		case 516:
+			if (!optarg || !strcmp(optarg, "1"))
+				cfg.c_ovlfs_strip = true;
+			else
+				cfg.c_ovlfs_strip = false;
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.19.1.6.gb485710b

