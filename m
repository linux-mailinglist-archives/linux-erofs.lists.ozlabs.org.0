Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 405FE9389B6
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 09:12:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hn7z4q5Z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSBL11Hrhz3cRK
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 17:12:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hn7z4q5Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSBKf24nKz3cM7
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2024 17:11:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721632306; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hHaKb27lHWEbC+x12j8wDscJsHdH6x3lDbJMIdIgzPo=;
	b=hn7z4q5ZdIRcdy0nOlqSjXZpPYr+H8nr6mHYYL+DVoaaZpz3omd0fmLgm1Nl64lAuy/IKNKbjO4Tu2eBqjhlsLfW5B/EwEIrAN2PH5xJhxSLxLOLwKpmgngYPMTa+sV1qYKG+OmpMeM3BjloNN712CQ/TBjlHawsAGFAhTKKs1c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WB-qPQR_1721632304;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WB-qPQR_1721632304)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 15:11:45 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs-utils: lib: enhance erofs_rebuild_get_dentry with bloom filter
Date: Mon, 22 Jul 2024 15:11:40 +0800
Message-ID: <20240722071140.1416782-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240722071140.1416782-1-hongzhen@linux.alibaba.com>
References: <20240722071140.1416782-1-hongzhen@linux.alibaba.com>
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

Add a bloom filter to exclude entries that are not in `pwd->i_subdirs`,
thereby improving the performance of `erofs_rebuild_get_dentry`. Below
are the results for different # of files in the same directory:

+---------+--------------------+
| # files | time reduction (%) |
+---------+--------------------+
|   1e4   |         55%        |
+---------+--------------------+
|   1e5   |         98%        |
+---------+--------------------+
|   2e5   |         98%        |
+---------+--------------------+
|   3e5   |         99%        |
+---------+--------------------+

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Changes since v1:
	- move erofs_bloom_init() to erofs_super_init()
	- make the # hash function and bit array size of the bloom filter configurable
v1: https://lore.kernel.org/all/20240718054025.427439-3-hongzhen@linux.alibaba.com/
---
 include/erofs/config.h   |  2 ++
 include/erofs/internal.h |  1 +
 lib/rebuild.c            | 61 ++++++++++++++++++++++++++++++++++------
 lib/super.c              | 27 ++++++++++++++++++
 mkfs/main.c              | 20 +++++++++++++
 5 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index f8726b5..c322c9a 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -92,6 +92,8 @@ struct erofs_configure {
 	char *fs_config_file;
 	char *block_list_file;
 #endif
+	u32 c_bloom_nrfuc;
+	unsigned long c_bloom_bitsize;
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d3dd676..ef7dd2d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -402,6 +402,7 @@ struct erofs_map_dev {
 };
 
 /* super.c */
+int erofs_super_init(struct erofs_sb_info *sbi);
 int erofs_read_superblock(struct erofs_sb_info *sbi);
 void erofs_put_super(struct erofs_sb_info *sbi);
 int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 9e8bf8f..3fd3ea0 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -15,6 +15,7 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/internal.h"
+#include "erofs/bloom_filter.h"
 #include "liberofs_uuid.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
@@ -62,14 +63,48 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq, bool to_head)
 {
 	struct erofs_dentry *d = NULL;
-	unsigned int len = strlen(path);
-	char *s = path;
+	unsigned int len, p = 0;
+	char *s;
+	struct erofs_sb_info *sbi = pwd->sbi;
+	char buf[4096];
 
 	*whout = false;
 	*opq = false;
 
+	s = pwd->i_srcpath;
+	len = strlen(pwd->i_srcpath);
+	/* normalize the pwd path, e.g., /./../xxx/yyy -> /xxx/yyy */
+	buf[p++] = '/';
+	while (s < pwd->i_srcpath + len) {
+		char *slash = memchr(s, '/', pwd->i_srcpath + len - s);
+		if (slash) {
+			if (s == slash) {
+				while(*++s == '/');
+				continue;;
+			}
+			*slash = '\0';
+		}
+		if (memcmp(s, ".", 2) && memcmp(s, "..", 3)) {
+			memcpy(buf + p, s, strlen(s));
+			p += strlen(s);
+			buf[p++] = '/';
+
+		}
+		if (slash) {
+			*slash = '/';
+			s = slash + 1;
+		} else{
+			break;
+		}
+	}
+	if (buf[p - 1] != '/')
+		buf[p++] = '/';
+
+	s = path;
+	len = strlen(path);
 	while (s < path + len) {
 		char *slash = memchr(s, '/', path + len - s);
+		int bloom, slen;
 
 		if (slash) {
 			if (s == slash) {
@@ -97,13 +132,19 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 				}
 			}
 
-			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
-				if (!strcmp(d->name, s)) {
-					if (d->type != EROFS_FT_DIR && slash)
-						return ERR_PTR(-EIO);
-					inode = d->inode;
-					break;
+			slen = strlen(s);
+			memcpy(buf + p, s, slen);
+			p += slen;
+			if ((bloom = erofs_bloom_test(sbi, buf, p)) > 0) {
+				list_for_each_entry(d, &pwd->i_subdirs, d_child) {
+					if (!strcmp(d->name, s)) {
+						if (d->type != EROFS_FT_DIR && slash)
+							return ERR_PTR(-EIO);
+						inode = d->inode;
+						break;
+					}
 				}
+
 			}
 
 			if (inode) {
@@ -124,6 +165,10 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 					return d;
 				pwd = d->inode;
 			}
+			if (!bloom && erofs_bloom_add(sbi, buf, p))
+				return ERR_PTR(-EINVAL);
+			if (slash)
+				buf[p++] = '/';
 		}
 		if (slash) {
 			*slash = '/';
diff --git a/lib/super.c b/lib/super.c
index 45233c4..39c3bfd 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -4,9 +4,14 @@
  */
 #include <string.h>
 #include <stdlib.h>
+#include <time.h>
 #include "erofs/print.h"
 #include "erofs/xattr.h"
 #include "erofs/cache.h"
+#include "erofs/bloom_filter.h"
+
+#define DEFAULT_BLOOM_NRFUNC	5
+#define DEFAULT_BLOOM_SIZE	1000000
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
@@ -72,6 +77,27 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	return 0;
 }
 
+int erofs_super_init(struct erofs_sb_info *sbi)
+{
+	int err;
+
+	srand(time(NULL));
+	if (cfg.c_bloom_nrfuc && cfg.c_bloom_bitsize)
+		err = erofs_bloom_init(sbi, cfg.c_bloom_nrfuc,
+				       cfg.c_bloom_bitsize, rand());
+	else
+		err = erofs_bloom_init(sbi, DEFAULT_BLOOM_NRFUNC,
+				       DEFAULT_BLOOM_SIZE, rand());
+	if (err) {
+		erofs_err("failed to init bloom filter");
+		goto exit;
+	}
+
+	err = 0;
+exit:
+	return err;
+}
+
 int erofs_read_superblock(struct erofs_sb_info *sbi)
 {
 	u8 data[EROFS_MAX_BLOCK_SIZE];
@@ -153,6 +179,7 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 		erofs_buffer_exit(sbi->bmgr);
 		sbi->bmgr = NULL;
 	}
+	erofs_bloom_exit(sbi);
 }
 
 int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
diff --git a/mkfs/main.c b/mkfs/main.c
index 20f12fc..21003bc 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -31,6 +31,7 @@
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 #include "../lib/compressor.h"
+#include "erofs/bloom_filter.h"
 
 static struct option long_options[] = {
 	{"version", no_argument, 0, 'V'},
@@ -81,6 +82,7 @@ static struct option long_options[] = {
 	{"zfeature-bits", required_argument, NULL, 521},
 	{"clean", optional_argument, NULL, 522},
 	{"incremental", optional_argument, NULL, 523},
+	{"bloom-filter", optional_argument, NULL, 524},
 	{0, 0, 0, 0},
 };
 
@@ -179,6 +181,9 @@ static void usage(int argc, char **argv)
 		"                                            headerball=file data is omited in the source stream)\n"
 		" --ovlfs-strip=<0,1>   strip overlayfs metadata in the target image (e.g. whiteouts)\n"
 		" --quiet               quiet execution (do not write anything to standard output.)\n"
+		" --bloom-filter=X      boost up images generation with bloom filter\n"
+		"			(X=n,s; n=# of hash functions (default 5),\n"
+		"				s=bit array size (default 1e6))\n"
 #ifndef NDEBUG
 		" --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 		" --random-algorithms   randomize per-file algorithms (debugging only)\n"
@@ -820,6 +825,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			incremental_mode = (opt == 523);
 			break;
+		case 524:
+			cfg.c_bloom_nrfuc = strtol(optarg, &endptr, 0);
+			if (*endptr != ',') {
+				erofs_err("invalid --bloom-filter=%s", optarg);
+				cfg.c_bloom_nrfuc = 0;
+				return -EINVAL;
+			}
+			cfg.c_bloom_bitsize = strtol(endptr + 1, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid --bloom-filter=%s", optarg);
+				cfg.c_bloom_bitsize = 0;
+				return -EINVAL;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1344,6 +1363,7 @@ int main(int argc, char **argv)
 	}
 
 	erofs_inode_manager_init();
+	erofs_super_init(&g_sbi);
 
 	if (tar_mode) {
 		root = erofs_rebuild_make_root(&g_sbi);
-- 
2.43.5

