Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7297D7921CB
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 12:03:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rg1Kb2Dhnz3c9n
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 20:03:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rg1Jz6rB0z3bhp
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 20:02:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrPmnJj_1693908158;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VrPmnJj_1693908158)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 18:02:39 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 11/11] erofs-utils: mkfs: add --overlay-strip option for tarfs and rebuild mode
Date: Tue,  5 Sep 2023 18:02:27 +0800
Message-Id: <20230905100227.1072-12-jefflexu@linux.alibaba.com>
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

Add "--overlay-strip=[0|1]" option for tarfs and rebuild mode,
controlling whether overlayfs related stuff, e.g. whiteout files and
origin xattrs, are stripped from the generated image.

This option is disabled by default for both tarfs and rebuild mode, that
is, whiteout files and origin xattrs are kept in the image by default.
Specify "--overlay-strip=1" explicitly to strip these stuff.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h |  1 +
 lib/inode.c            | 12 ++++++++++--
 lib/rebuild.c          | 10 ++++++----
 lib/tar.c              | 16 +++++++++-------
 lib/xattr.c            |  5 +++++
 mkfs/main.c            | 12 ++++++++++++
 6 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index c51f0cd..f244607 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -54,6 +54,7 @@ struct erofs_configure {
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
+	bool c_overlay_strip;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/inode.c b/lib/inode.c
index 7e5d464..42a4c2f 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1326,7 +1326,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 
 int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 {
-	struct erofs_dentry *d;
+	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs;
 	int ret;
 
@@ -1370,8 +1370,16 @@ int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 	}
 
 	nr_subdirs = 0;
-	list_for_each_entry(d, &dir->i_subdirs, d_child)
+	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+		if (cfg.c_overlay_strip && erofs_inode_is_whiteout(d->inode)) {
+			erofs_dbg("strip whiteout %s", d->inode->i_srcpath);
+			list_del(&d->d_child);
+			erofs_d_invalidate(d);
+			free(d);
+			continue;
+		}
 		++nr_subdirs;
+	}
 
 	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
 	if (ret)
diff --git a/lib/rebuild.c b/lib/rebuild.c
index b254dea..1d8c7bc 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -200,10 +200,12 @@ static int erofs_rebuild_fill_inode(struct erofs_inode *inode)
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFCHR:
-		if (erofs_inode_is_whiteout(inode)) {
-			ret = erofs_set_origin_xattr(inode->i_parent);
-			if (ret)
-				break;
+		if (!cfg.c_overlay_strip) {
+			if (erofs_inode_is_whiteout(inode)) {
+				ret = erofs_set_origin_xattr(inode->i_parent);
+				if (ret)
+					break;
+			}
 		}
 		/* fallthrough */
 	case S_IFBLK:
diff --git a/lib/tar.c b/lib/tar.c
index b75b723..3389bf6 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -740,13 +740,15 @@ new_inode:
 		inode->i_mode = (inode->i_mode & ~S_IFMT) | S_IFCHR;
 		inode->u.i_rdev = EROFS_WHITEOUT_DEV;
 		d->type = EROFS_FT_CHRDEV;
-		/*
-		 * Mark parent directory as copied-up to avoid exposing
-		 * whiteouts in the overlayfs mount.
-		 */
-		ret = erofs_set_origin_xattr(inode->i_parent);
-		if (ret)
-			goto out;
+		if (!cfg.c_overlay_strip) {
+			/*
+			 * Mark parent directory as copied-up to avoid exposing
+			 * whiteouts in the overlayfs mount.
+			 */
+			ret = erofs_set_origin_xattr(inode->i_parent);
+			if (ret)
+				goto out;
+		}
 	} else {
 		inode->i_mode = st.st_mode;
 		if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode))
diff --git a/lib/xattr.c b/lib/xattr.c
index feafe96..d7f4e3a 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -601,6 +601,11 @@ int erofs_read_xattrs_from_disk(struct erofs_inode *inode)
 			inode->opaque = true;
 		}
 
+		if (cfg.c_overlay_strip && !strcmp(key, OVL_XATTR_ORIGIN)) {
+			ret = 0;
+			continue;
+		}
+
 		ret = erofs_getxattr(inode, key, NULL, 0);
 		if (ret < 0)
 			goto out;
diff --git a/mkfs/main.c b/mkfs/main.c
index b51ef37..4af07f2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -57,6 +57,7 @@ static struct option long_options[] = {
 	{"gid-offset", required_argument, NULL, 17},
 	{"tar", optional_argument, NULL, 20},
 	{"aufs", no_argument, NULL, 21},
+	{"overlay-strip", required_argument, NULL, 22},
 	{"mount-point", required_argument, NULL, 512},
 	{"xattr-prefix", required_argument, NULL, 19},
 #ifdef WITH_ANDROID
@@ -121,6 +122,7 @@ static void usage(void)
 	      " --preserve-mtime      keep per-file modification time strictly\n"
 	      " --aufs                replace aufs special files with overlayfs metadata\n"
 	      " --tar=[fi]            generate an image from tarball(s)\n"
+	      " --overlay-strip=[01]  strip overlayfs stuff e.g. whiteout in tarfs or rebuild mode\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
@@ -538,6 +540,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 21:
 			erofstar.aufs = true;
 			break;
+		case 22:
+			if (!strcmp(optarg, "0"))
+				cfg.c_overlay_strip = false;
+			else if (!strcmp(optarg, "1"))
+				cfg.c_overlay_strip = true;
+			else {
+				erofs_err("invalid overlay-strip %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.19.1.6.gb485710b

