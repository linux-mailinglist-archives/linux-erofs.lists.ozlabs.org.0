Return-Path: <linux-erofs+bounces-737-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76E1B17D91
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 09:31:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btd1928SQz30T9;
	Fri,  1 Aug 2025 17:31:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754033485;
	cv=none; b=icUP6bjd7QSrxcus0gIT4Rw96OIMqFkCPVnRFoI9FJ1ubMJmUDxbomgmybw9ZnliOts8KZOxdHMva5RQwYfOHJsRFPa59XedDt7De6YZPTIZkCp8vkfeJ7b6mWNcIaq46OvX4ARa0lGPcUJVge5HtUaqMz61LeI2HxdZfWX4AozFX01ioyh/D0gyRVWngva/p0F3dJ3ILNr3HSLdbQ9h5Xg7S6z3/gHNOVdmVKJYjm4BaRHCwPqCuJUlPHCZSy/QZXkFAymcHGjZPFeGe1hND+KKspQjjFBXyABXIOChI9bIMj9yvfnVYrTDuA88KMN6vNgHGBXxCo6KaXspZYElDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754033485; c=relaxed/relaxed;
	bh=CqcvN8aTtJ9jHAB2hzpUClLPQzS1rpK4dYvcDp9FUN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC4N8JrwUT/mjeY2zaGQangmNGAOAqepF4wjlZTPHwJVT36KOdo8ZqEq3Kf94W+2JRBq8vdFu3yBtEiHvugshTFLRZvdOKsKeDNvW2ochXw7MyuICtX0wQKUUDS0UFbeo4E7mWvcfzq68TbeSbpfgSZd2puz1DmL90MkZfD0MW7jXQq6bHWnUWw82yy85vapjKXgVo7VJtm1Jmye3FKmJ6MV8wgA30fmaQSxBfyZ/NGAO+t0Tm1nrsTtVr9o5ZKjYIC3RcUDshVukxZ5fp5g47hDUocPkaHwTSOIRek2z+1ry9/+0O8ZTEf2TO/9U9ouzV0BQYh/WPZSmcq0CAnnAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btd16628cz2ymc
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 17:31:20 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4btcyD4pB7z23jYJ;
	Fri,  1 Aug 2025 15:28:52 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id E8F3114010D;
	Fri,  1 Aug 2025 15:31:16 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 15:31:16 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<lihongbo22@huawei.com>, zhaoyifan <zhaoyifan28@huawei.com>
Subject: [PATCH v2 3/4] erofs-utils: mkfs: introduce `--s3=...` option
Date: Fri, 1 Aug 2025 15:30:45 +0800
Message-ID: <20250801073046.1900016-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250801073046.1900016-1-zhaoyifan28@huawei.com>
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

This patch introduces configuration options for the upcoming experimental S3
support, including configuration parsing and passwd_file reading logic.

User could specify the following options:
- S3 service endpoint (Compulsory)
- S3 credentials file, in the format of "$ak:%sk" (Optional)
- S3 API calling style (Optional)
- S3 API signature version, only sigV2 supported yet (Optional)

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
change since v1:
- rename: include/erofs/s3.h => lib/liberofs_s3.h
- add liberofs_s3.h in this patch rather than previous one

 lib/liberofs_s3.h |  40 +++++++++
 lib/remotes/s3.c  |   3 +-
 mkfs/main.c       | 220 ++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 233 insertions(+), 30 deletions(-)
 create mode 100644 lib/liberofs_s3.h

diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
new file mode 100644
index 0000000..16a06c9
--- /dev/null
+++ b/lib/liberofs_s3.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Yifan Zhao <zhaoyifan28@huawei.com>
+ */
+#ifndef __EROFS_S3_H
+#define __EROFS_S3_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+enum s3erofs_url_style {
+    S3EROFS_URL_STYLE_PATH,          // Path style: https://s3.amazonaws.com/bucket/object
+    S3EROFS_URL_STYLE_VIRTUAL_HOST,  // Virtual host style: https://bucket.s3.amazonaws.com/object
+};
+
+enum s3erofs_signature_version {
+	S3EROFS_SIGNATURE_VERSION_2,
+	S3EROFS_SIGNATURE_VERSION_4,
+};
+
+#define S3_ACCESS_KEY_LEN 256
+#define S3_SECRET_KEY_LEN 256
+
+struct erofs_s3 {
+	const char *endpoint, *bucket;
+	char access_key[S3_ACCESS_KEY_LEN + 1];
+	char secret_key[S3_SECRET_KEY_LEN + 1];
+
+	enum s3erofs_url_style url_style;
+	enum s3erofs_signature_version sig;
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
\ No newline at end of file
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index ed2b023..358ee91 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -3,4 +3,5 @@
  * Copyright (C) 2025 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Yifan Zhao <zhaoyifan28@huawei.com>
- */
\ No newline at end of file
+ */
+#include "liberofs_s3.h"
\ No newline at end of file
diff --git a/mkfs/main.c b/mkfs/main.c
index 3aa1421..f524f45 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -31,6 +31,7 @@
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 #include "../lib/liberofs_metabox.h"
+#include "../lib/liberofs_s3.h"
 #include "../lib/compressor.h"
 
 static struct option long_options[] = {
@@ -59,6 +60,9 @@ static struct option long_options[] = {
 	{"gid-offset", required_argument, NULL, 17},
 	{"tar", optional_argument, NULL, 20},
 	{"aufs", no_argument, NULL, 21},
+#ifdef HAVE_S3
+	{"s3", required_argument, NULL, 22},
+#endif
 	{"mount-point", required_argument, NULL, 512},
 	{"xattr-prefix", required_argument, NULL, 19},
 #ifdef WITH_ANDROID
@@ -197,6 +201,12 @@ static void usage(int argc, char **argv)
 		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
 		" --sort=<path,none>    data sorting order for tarballs as input (default: path)\n"
+#ifdef HAVE_S3
+		" --s3=X                generate an index-only image from s3-compatible object store backend\n"
+		"   [,passwd_file=Y]    X=endpoint, Y=s3 credentials file\n"
+		"   [,style=Z]          S3 API calling style (Z = vhost|path) (default: vhost)\n"
+		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
+#endif
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
 		"                                            headerball=file data is omited in the source stream)\n"
@@ -247,6 +257,10 @@ static struct erofs_tarfile erofstar = {
 static bool incremental_mode;
 static u8 metabox_algorithmid;
 
+#ifdef HAVE_S3
+static struct erofs_s3 s3cfg;
+#endif
+
 enum {
 	EROFS_MKFS_DATA_IMPORT_DEFAULT,
 	EROFS_MKFS_DATA_IMPORT_FULLDATA,
@@ -257,6 +271,9 @@ enum {
 enum {
 	EROFS_MKFS_SOURCE_DEFAULT,
 	EROFS_MKFS_SOURCE_TAR,
+#ifdef HAVE_S3
+	EROFS_MKFS_SOURCE_S3,
+#endif
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
@@ -522,6 +539,139 @@ static void mkfs_parse_tar_cfg(char *cfg)
 		erofstar.index_mode = true;
 }
 
+#ifdef HAVE_S3
+static int mkfs_parse_s3_cfg_passwd(const char *filepath, char *ak, char *sk)
+{
+	struct stat file_stat;
+	int fd, n, ret = 0;
+	char buf[S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3];
+	char *colon;
+
+	fd = open(filepath, O_RDONLY);
+	if (fd < 0) {
+		erofs_err("failed to open passwd_file %s", filepath);
+		return -errno;
+	}
+
+	if (fstat(fd, &file_stat) != 0) {
+		ret = -errno;
+		goto err;
+	}
+
+	if (!S_ISREG(file_stat.st_mode)) {
+		erofs_err("%s is not a regular file", filepath);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if ((file_stat.st_mode & (S_IXUSR | S_IROTH | S_IWOTH | S_IXOTH | S_IRGRP |
+				  S_IWGRP | S_IXGRP)) != 0) {
+		erofs_err("%s should not have others/group permission", filepath);
+		ret = -EPERM;
+		goto err;
+	}
+
+	if (file_stat.st_size > S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3) {
+		erofs_err("passwd_file %s with size %lu is too big", filepath,
+			  file_stat.st_size);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	n = read(fd, buf, file_stat.st_size);
+	if (n < 0) {
+		ret = -errno;
+		goto err;
+	}
+	buf[n] = '\0';
+
+	while (n > 0 && (buf[n - 1] == '\n' || buf[n - 1] == '\r'))
+		buf[--n] = '\0';
+
+	colon = strchr(buf, ':');
+	if (!colon) {
+		ret = -EINVAL;
+		goto err;
+	}
+	*colon = '\0';
+
+	strcpy(ak, buf);
+	strcpy(sk, colon + 1);
+
+err:
+	close(fd);
+	return ret;
+}
+
+static int mkfs_parse_s3_cfg(char *cfg_str)
+{
+	char *p, *q, *opt;
+	int ret = 0;
+
+	if (source_mode != EROFS_MKFS_SOURCE_DEFAULT) {
+		erofs_warn("generation image from s3 conflicting with other "
+			   "options, ignoring it");
+		return 0;
+	}
+	source_mode = EROFS_MKFS_SOURCE_S3;
+
+	if (!cfg_str) {
+		erofs_err("s3: missing parameter");
+		return -EINVAL;
+	}
+
+	s3cfg.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST;
+	s3cfg.sig = S3EROFS_SIGNATURE_VERSION_2;
+
+	p = strchr(cfg_str, ',');
+	if (p) {
+		s3cfg.endpoint = strndup(cfg_str, p - cfg_str);
+	} else {
+		s3cfg.endpoint = strdup(cfg_str);
+		return 0;
+	}
+
+	opt = p + 1;
+	while (opt) {
+		q = strchr(opt, ',');
+		if (q)
+			*q = '\0';
+
+		if ((p = strstr(opt, "passwd_file="))) {
+			p += strlen("passwd_file=");
+			ret = mkfs_parse_s3_cfg_passwd(p, s3cfg.access_key,
+						       s3cfg.secret_key);
+			if (ret)
+				return ret;
+		} else if ((p = strstr(opt, "style="))) {
+			p += strlen("style=");
+			if (strncmp(p, "vhost", 5) == 0) {
+				s3cfg.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST;
+			} else if (strncmp(p, "path", 4) == 0) {
+				s3cfg.url_style = S3EROFS_URL_STYLE_PATH;
+			} else {
+				erofs_err("invalid s3 style %s", p);
+				return -EINVAL;
+			}
+		} else if ((p = strstr(opt, "sig="))) {
+			p += strlen("sig=");
+			if (strncmp(p, "4", 1) == 0) {
+				erofs_warn("AWS Signature Version 4 is not supported yet, using Version 2");
+			} else if (strncmp(p, "2", 1) == 0) {
+				s3cfg.sig = S3EROFS_SIGNATURE_VERSION_2;
+			} else {
+				erofs_err("invalid s3 sig %s", p);
+				return -EINVAL;
+			}
+		}
+
+		opt = q ? q + 1 : NULL;
+	}
+
+	return 0;
+}
+#endif
+
 static int mkfs_parse_one_compress_alg(char *alg,
 				       struct erofs_compr_opts *copts)
 {
@@ -670,6 +820,13 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 			erofstar.ios.dumpfd = fd;
 		}
 		break;
+#ifdef HAVE_S3
+	case EROFS_MKFS_SOURCE_S3:
+		s3cfg.bucket = strdup(argv[optind++]);
+		if (!s3cfg.bucket)
+			return -ENOMEM;
+		break;
+#endif
 	case EROFS_MKFS_SOURCE_REBUILD:
 	default:
 		erofs_err("unexpected source_mode: %d", source_mode);
@@ -944,6 +1101,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 21:
 			erofstar.aufs = true;
 			break;
+#ifdef HAVE_S3
+		case 22:
+			err = mkfs_parse_s3_cfg(optarg);
+			if (err)
+				return err;
+			break;
+#endif
 		case 516:
 			if (!optarg || !strcmp(optarg, "1"))
 				cfg.c_ovlfs_strip = true;
@@ -1539,35 +1703,7 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
-	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
-		root = erofs_rebuild_make_root(&g_sbi);
-		if (IS_ERR(root)) {
-			err = PTR_ERR(root);
-			goto exit;
-		}
-
-		while (!(err = tarerofs_parse_tar(root, &erofstar)));
-
-		if (err < 0)
-			goto exit;
-
-		err = erofs_rebuild_dump_tree(root, incremental_mode);
-		if (err < 0)
-			goto exit;
-	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
-		root = erofs_rebuild_make_root(&g_sbi);
-		if (IS_ERR(root)) {
-			err = PTR_ERR(root);
-			goto exit;
-		}
-
-		err = erofs_mkfs_rebuild_load_trees(root);
-		if (err)
-			goto exit;
-		err = erofs_rebuild_dump_tree(root, incremental_mode);
-		if (err)
-			goto exit;
-	} else {
+	if (source_mode == EROFS_MKFS_SOURCE_DEFAULT) {
 		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg.c_src_path);
 		if (err) {
 			erofs_err("failed to build shared xattrs: %s",
@@ -1584,6 +1720,32 @@ int main(int argc, char **argv)
 			root = NULL;
 			goto exit;
 		}
+	} else {
+		root = erofs_rebuild_make_root(&g_sbi);
+		if (IS_ERR(root)) {
+			err = PTR_ERR(root);
+			goto exit;
+		}
+
+		if (source_mode == EROFS_MKFS_SOURCE_TAR) {
+			while (!(err = tarerofs_parse_tar(root, &erofstar)))
+				;
+			if (err < 0)
+				goto exit;
+		} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
+			err = erofs_mkfs_rebuild_load_trees(root);
+			if (err)
+				goto exit;
+#ifdef HAVE_S3
+		} else if (source_mode == EROFS_MKFS_SOURCE_S3) {
+			err = -EOPNOTSUPP;
+			goto exit;
+#endif
+		}
+
+		err = erofs_rebuild_dump_tree(root, incremental_mode);
+		if (err)
+			goto exit;
 	}
 
 	if (tar_index_512b) {
-- 
2.46.0


