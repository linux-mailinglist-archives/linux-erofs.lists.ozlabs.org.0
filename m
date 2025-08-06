Return-Path: <linux-erofs+bounces-778-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F26B1C7B3
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Aug 2025 16:36:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxtCN17vrz3bnB;
	Thu,  7 Aug 2025 00:36:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754490992;
	cv=none; b=o2LyY/A0/lZ96ko2hS70/y+s8yqv9t1xYNpnQceuCcro2O/Z6s1ODOMt2mGfikrEVdJpl4ASQ2P6gTKu5yRKh/P4B4BSmXeXXk0NKhWUsITozxRdCE9Z/liUIL1h3w5029IjRKWdXXSgfy+LIlDWl8OmUljFqCKVIhfSlwyHatuWA44LGVcJo4R1cVyg8EEW4cxAi4lVseZmSayvaHSJ4+6POb+JjmD7C5qTs8GRNTNglEq/qlFhAKqVWm6sEyyfEFU/Tq3aYl/x8CL7ADJWL3/DxJg0OOyTnKgqYBYdBT/ztcWP4KC3e4KQV3LCICdC80vNBHZAj1FBA3ZtQnM2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754490992; c=relaxed/relaxed;
	bh=fLOIYT7c+0rfrhD+RAYxsUY0L8wFq0QG8eTF5ISFEuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNfVZlr8U6ltEVP0KALZvtUExjyjnygbRdPULtkArgINRFXx/QYzTUzTt2J0ebh6G7LuMaTTfaesIi3KsfngLBCb++56eB1h+hYo2KpHL91yigkDMxfQVOmxf03L8mNMLWBcO2e3JIf/6HbuZCG8rENzk7pmiFUeu6LvBBJS4bcE6+UZnJ/Fuoi/GzjI5BXf46c4ak+xffuM916zcs93JlOvYiKaepiazHaBZXDW2l6gwJ1Elt2ffDyg8WMoQHEcj6REcfYsOtKP6Czl7DeK4gqWNJGpOCNAaaIxqdk9CY4xb24hjt0MssPx0Zh+aUpgnLKETK+pqqIiLaQtym9Fjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iP500gzE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iP500gzE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxtCK1DV0z30Vb
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Aug 2025 00:36:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754490984; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fLOIYT7c+0rfrhD+RAYxsUY0L8wFq0QG8eTF5ISFEuo=;
	b=iP500gzEQvAmD56amD7ctABwrxaHJ/Hzyv7mtbbvYqSCMA0GdCdOdpMZO2/w/tkfKYnndXRikS/tMX8/UYoCgRH6305Rykh6U4T25fvgDqOLOLm7OhRZGgrsozmqDAjeHe0I9SLuLatjlRunxMa9sEJYN9M5W8HrxPqqjn9mrVg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlBLAvZ_1754490981 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Aug 2025 22:36:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 3/4] erofs-utils: mkfs: introduce --s3=... option
Date: Wed,  6 Aug 2025 22:36:13 +0800
Message-ID: <20250806143615.1661283-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806143615.1661283-1-hsiangkao@linux.alibaba.com>
References: <20250806143615.1661283-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Yifan Zhao <zhaoyifan28@huawei.com>

It introduces configuration options for the upcoming experimental S3
support, including configuration parsing and `passwd_file` reading
logic.

Users can specify the following options:
 - S3 service endpoint (required);
 - S3 credentials file in the format $ak:%sk (optional);
 - S3 API calling style (optional);
 - S3 API signature version (optional, only V2 is currently supported).

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/liberofs_s3.h |  40 +++++++++
 mkfs/main.c       | 218 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 229 insertions(+), 29 deletions(-)
 create mode 100644 lib/liberofs_s3.h

diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
new file mode 100644
index 0000000..fbf2f80
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
diff --git a/mkfs/main.c b/mkfs/main.c
index ab27b77..ecc1bbe 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -31,6 +31,7 @@
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 #include "../lib/liberofs_metabox.h"
+#include "../lib/liberofs_s3.h"
 #include "../lib/compressor.h"
 
 static struct option long_options[] = {
@@ -92,6 +93,9 @@ static struct option long_options[] = {
 #endif
 	{"fsalignblks", required_argument, NULL, 531},
 	{"vmdk-desc", required_argument, NULL, 532},
+#ifdef S3EROFS_ENABLED
+	{"s3", required_argument, NULL, 533},
+#endif
 	{0, 0, 0, 0},
 };
 
@@ -197,6 +201,12 @@ static void usage(int argc, char **argv)
 		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
 		" --sort=<path,none>    data sorting order for tarballs as input (default: path)\n"
+#ifdef S3EROFS_ENABLED
+		" --s3=X                generate an image from S3-compatible object store\n"
+		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
+		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
+		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
+#endif
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
 		"                                            headerball=file data is omited in the source stream)\n"
@@ -247,6 +257,10 @@ static struct erofs_tarfile erofstar = {
 static bool incremental_mode;
 static u8 metabox_algorithmid;
 
+#ifdef S3EROFS_ENABLED
+static struct erofs_s3 s3cfg;
+#endif
+
 enum {
 	EROFS_MKFS_DATA_IMPORT_DEFAULT,
 	EROFS_MKFS_DATA_IMPORT_FULLDATA,
@@ -257,6 +271,9 @@ enum {
 static enum {
 	EROFS_MKFS_SOURCE_LOCALDIR,
 	EROFS_MKFS_SOURCE_TAR,
+#ifdef S3EROFS_ENABLED
+	EROFS_MKFS_SOURCE_S3,
+#endif
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
@@ -522,6 +539,137 @@ static void mkfs_parse_tar_cfg(char *cfg)
 		erofstar.index_mode = true;
 }
 
+#ifdef S3EROFS_ENABLED
+static int mkfs_parse_s3_cfg_passwd(const char *filepath, char *ak, char *sk)
+{
+	struct stat st;
+	int fd, n, ret;
+	char buf[S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3];
+	char *colon;
+
+	fd = open(filepath, O_RDONLY);
+	if (fd < 0) {
+		erofs_err("failed to open passwd_file %s", filepath);
+		return -errno;
+	}
+
+	ret = fstat(fd, &st);
+	if (ret) {
+		ret = -errno;
+		goto err;
+	}
+
+	if (!S_ISREG(st.st_mode)) {
+		erofs_err("%s is not a regular file", filepath);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if ((st.st_mode & 077) != 0)
+		erofs_warn("passwd_file %s should not be accessible by group or others",
+			   filepath);
+
+	if (st.st_size > S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3) {
+		erofs_err("passwd_file %s is too large (size: %llu)", filepath,
+			  st.st_size | 0ULL);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	n = read(fd, buf, st.st_size);
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
+	if (source_mode != EROFS_MKFS_SOURCE_LOCALDIR)
+		return -EINVAL;
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
+			p += sizeof("passwd_file=") - 1;
+			ret = mkfs_parse_s3_cfg_passwd(p, s3cfg.access_key,
+						       s3cfg.secret_key);
+			if (ret)
+				return ret;
+		} else if ((p = strstr(opt, "urlstyle="))) {
+			p += sizeof("urlstyle=") - 1;
+			if (strncmp(p, "vhost", 5) == 0) {
+				s3cfg.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST;
+			} else if (strncmp(p, "path", 4) == 0) {
+				s3cfg.url_style = S3EROFS_URL_STYLE_PATH;
+			} else {
+				erofs_err("invalid S3 addressing style %s", p);
+				return -EINVAL;
+			}
+		} else if ((p = strstr(opt, "sig="))) {
+			p += strlen("sig=");
+			if (strncmp(p, "4", 1) == 0) {
+				erofs_warn("AWS Signature Version 4 is not supported yet, using Version 2");
+			} else if (strncmp(p, "2", 1) == 0) {
+				s3cfg.sig = S3EROFS_SIGNATURE_VERSION_2;
+			} else {
+				erofs_err("Invalid AWS Signature Version %s", p);
+				return -EINVAL;
+			}
+		} else {
+			erofs_err("invalid --s3 option %s", opt);
+			return -EINVAL;
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
@@ -670,6 +818,13 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 			erofstar.ios.dumpfd = fd;
 		}
 		break;
+#ifdef S3EROFS_ENABLED
+	case EROFS_MKFS_SOURCE_S3:
+		s3cfg.bucket = strdup(argv[optind++]);
+		if (!s3cfg.bucket)
+			return -ENOMEM;
+		break;
+#endif
 	default:
 		erofs_err("unexpected source_mode: %d", source_mode);
 		return -EINVAL;
@@ -1058,6 +1213,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+#ifdef S3EROFS_ENABLED
+		case 533:
+			err = mkfs_parse_s3_cfg(optarg);
+			if (err)
+				return err;
+			break;
+#endif
 		case 'V':
 			version();
 			exit(0);
@@ -1538,35 +1700,7 @@ int main(int argc, char **argv)
 
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
+	if (source_mode == EROFS_MKFS_SOURCE_LOCALDIR) {
 		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg.c_src_path);
 		if (err) {
 			erofs_err("failed to build shared xattrs: %s",
@@ -1583,6 +1717,32 @@ int main(int argc, char **argv)
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
+#ifdef S3EROFS_ENABLED
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
2.43.5


