Return-Path: <linux-erofs+bounces-836-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182DB2B785
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Aug 2025 05:28:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Zmg0N9Mz3clH;
	Tue, 19 Aug 2025 13:28:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755574115;
	cv=none; b=LwvIIsB3elLXOw6NZR0vT2n8YeUQcjO11RtZTC0DDp6O39HAqwpq8/Kgb23XwXtnQi2NmMGlKpurrfhu38aAeS1nTWo8k2aufAco45n/V+qM+Ew3vXWtDtMDIRD47WAtjqMY+NV5lqS0vO+c96AVqCKdGlmYf1gMTEizrtpml8frOqSp4rCVqqXxMIQND5u2CpMlaIXYOV9UEhZosb/tARvUXMQ/z4+Ea8H2XNQR5YyPvAggBWMi6r/ce5hVVliqOeIs4PRGD+lzC09jNxDW4DaAsgP5hBr+dIMBUd4LyELZOD5unRrz5tLk6AMzKHnuxMpawdsX9K52u+/d8jVRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755574115; c=relaxed/relaxed;
	bh=wwtnIW0/TYuqxwz+yc9qWTo3bl/wega8jX9CQIgJxWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8phtQrNwNsEyMXxvs0rbxhFH8TFeC8JXm6urPULwvPo/apuHBtXycsR6K+hyr+b30RV7bYm5fz+vxa/PHF0k3Qs2IQp9mSCPo7YSlF4ET6PikEkiOcrKZYDEeV/DBIyCCmtUKyU4M7l/u0jEW+oNK3mzShgj0QXAVko8J2rulVFEh4HurKXifrBTxJmHgag7c5srpSJ/pJn1el6ow0gChy4nWnGJYy+bPEkb2WVT1CuQ4EkN3M1fODH0oDeS8Meym7PMZGWGg29l74crt7OqwxaHXUw62b8TnHFMAzaVdDlHcnkKNHlO93/HmaPBGM0feSnRqDjgYIzhPTIMAuiKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wEARnTul; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wEARnTul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5ZmZ5nXHz3cb5
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 13:28:29 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755574105; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wwtnIW0/TYuqxwz+yc9qWTo3bl/wega8jX9CQIgJxWQ=;
	b=wEARnTulCJ50qPDGTHBj9Tf8qBr2oewWCTd9uJqD/DnQj77JIT8MimDNBCbVlK6Z1dPTe6LKuJ48XqLeSC3GulmuGn6uhKdLtDf/3HOsOFynyTL0F9csfL4xCDVsLMhCwoI2FETYQhieJqVayoNugzMZcvlUYlfxNaHBwvti71w=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm5DR3o_1755574098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 11:28:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 1/7] erofs-utils: lib: introduce liberofs_global_{init,exit}
Date: Tue, 19 Aug 2025 11:28:12 +0800
Message-ID: <20250819032818.3598157-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Currently, the codebase only supports a single instance during
the entire running time. This will be extended to allow 3rd-party
applications to formally use liberofs with multiple instances
simultaneously. Therefore, it is necessary to separate global
initialization from per-instance initialization.

Another point is that libcurl will be used for other remote
backends, so it also needs to be separated from the current S3
backend.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  3 ++
 include/erofs/lock.h     |  6 ++++
 lib/Makefile.am          |  5 ++--
 lib/global.c             | 57 +++++++++++++++++++++++++++++++++++
 lib/liberofs_s3.h        |  1 +
 lib/remotes/s3.c         | 65 ++++++++++++++++++----------------------
 mkfs/main.c              | 22 +++++++-------
 7 files changed, 111 insertions(+), 48 deletions(-)
 create mode 100644 lib/global.c

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e9b9099..92e83fd 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -426,6 +426,9 @@ struct erofs_map_dev {
 	unsigned int m_deviceid;
 };
 
+int liberofs_global_init(void);
+void liberofs_global_exit(void);
+
 /* super.c */
 int erofs_read_superblock(struct erofs_sb_info *sbi);
 void erofs_put_super(struct erofs_sb_info *sbi);
diff --git a/include/erofs/lock.h b/include/erofs/lock.h
index f7a4b47..c6e3093 100644
--- a/include/erofs/lock.h
+++ b/include/erofs/lock.h
@@ -16,6 +16,9 @@ static inline void erofs_mutex_init(erofs_mutex_t *lock)
 #define erofs_mutex_lock	pthread_mutex_lock
 #define erofs_mutex_unlock	pthread_mutex_unlock
 
+#define EROFS_DEFINE_MUTEX(lock)	\
+	erofs_mutex_t lock = PTHREAD_MUTEX_INITIALIZER
+
 typedef pthread_rwlock_t erofs_rwsem_t;
 
 static inline void erofs_init_rwsem(erofs_rwsem_t *lock)
@@ -33,6 +36,9 @@ static inline void erofs_mutex_init(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_lock(erofs_mutex_t *lock) {}
 static inline void erofs_mutex_unlock(erofs_mutex_t *lock) {}
 
+#define EROFS_DEFINE_MUTEX(lock)	\
+	erofs_mutex_t lock = {}
+
 typedef struct {} erofs_rwsem_t;
 static inline void erofs_init_rwsem(erofs_rwsem_t *lock) {}
 static inline void erofs_down_read(erofs_rwsem_t *lock) {}
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b079897..a3972b1 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -29,7 +29,8 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
-      $(top_srcdir)/lib/liberofs_metabox.h
+      $(top_srcdir)/lib/liberofs_metabox.h \
+      $(top_srcdir)/lib/liberofs_s3.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
@@ -37,7 +38,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
 		      block_list.c rebuild.c diskbuf.c bitops.c dedupe_ext.c \
-		      vmdk.c metabox.c
+		      vmdk.c metabox.c global.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/global.c b/lib/global.c
new file mode 100644
index 0000000..b1a6d76
--- /dev/null
+++ b/lib/global.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2025 Alibaba Cloud
+ */
+#include "erofs/lock.h"
+#ifdef HAVE_CURL_CURL_H
+#include <curl/curl.h>
+#endif
+#ifdef HAVE_LIBXML_PARSER_H
+#include <libxml/parser.h>
+#endif
+#include "erofs/err.h"
+#include "erofs/config.h"
+
+static EROFS_DEFINE_MUTEX(erofs_global_mutex);
+#ifdef HAVE_LIBCURL
+static bool erofs_global_curl_initialized;
+#endif
+
+int liberofs_global_init(void)
+{
+	int err = 0;
+
+	erofs_mutex_lock(&erofs_global_mutex);
+	erofs_init_configure();
+#ifdef S3EROFS_ENABLED
+	xmlInitParser();
+#endif
+#ifdef HAVE_LIBCURL
+	if (!erofs_global_curl_initialized) {
+		if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK) {
+			err = -EFAULT;
+			goto out_unlock;
+		}
+		erofs_global_curl_initialized = true;
+	}
+out_unlock:
+#endif
+	erofs_mutex_unlock(&erofs_global_mutex);
+	return err;
+}
+
+void liberofs_global_exit(void)
+{
+	erofs_mutex_lock(&erofs_global_mutex);
+#ifdef HAVE_LIBCURL
+	if (erofs_global_curl_initialized) {
+		curl_global_cleanup();
+		erofs_global_curl_initialized = false;
+	}
+#endif
+#ifdef S3EROFS_ENABLED
+	xmlCleanupParser();
+#endif
+	erofs_exit_configure();
+	erofs_mutex_unlock(&erofs_global_mutex);
+}
diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
index 27b041c..a178c64 100644
--- a/lib/liberofs_s3.h
+++ b/lib/liberofs_s3.h
@@ -25,6 +25,7 @@ enum s3erofs_signature_version {
 #define S3_SECRET_KEY_LEN 256
 
 struct erofs_s3 {
+	void *easy_curl;
 	const char *endpoint;
 	char access_key[S3_ACCESS_KEY_LEN + 1];
 	char secret_key[S3_SECRET_KEY_LEN + 1];
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 1497b54..f4a364d 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -26,8 +26,6 @@
 
 #define BASE64_ENCODE_LEN(len)	(((len + 2) / 3) * 4)
 
-static CURL *easy_curl;
-
 struct s3erofs_query_params {
 	int num;
 	const char *key[S3EROFS_MAX_QUERY_PARAMS];
@@ -213,6 +211,7 @@ static int s3erofs_request_perform(struct erofs_s3 *s3,
 				   struct s3erofs_curl_request *req, void *resp)
 {
 	struct curl_slist *request_headers = NULL;
+	CURL *curl = s3->easy_curl;
 	long http_code = 0;
 	int ret;
 
@@ -226,11 +225,11 @@ static int s3erofs_request_perform(struct erofs_s3 *s3,
 		}
 	}
 
-	curl_easy_setopt(easy_curl, CURLOPT_URL, req->url);
-	curl_easy_setopt(easy_curl, CURLOPT_WRITEDATA, resp);
-	curl_easy_setopt(easy_curl, CURLOPT_HTTPHEADER, request_headers);
+	curl_easy_setopt(curl, CURLOPT_URL, req->url);
+	curl_easy_setopt(curl, CURLOPT_WRITEDATA, resp);
+	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, request_headers);
 
-	ret = curl_easy_perform(easy_curl);
+	ret = curl_easy_perform(curl);
 	if (ret != CURLE_OK) {
 		erofs_err("curl_easy_perform() failed: %s",
 			  curl_easy_strerror(ret));
@@ -238,7 +237,7 @@ static int s3erofs_request_perform(struct erofs_s3 *s3,
 		goto err_header;
 	}
 
-	ret = curl_easy_getinfo(easy_curl, CURLINFO_RESPONSE_CODE, &http_code);
+	ret = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
 	if (ret != CURLE_OK) {
 		erofs_err("curl_easy_getinfo() failed: %s",
 			  curl_easy_strerror(ret));
@@ -473,7 +472,7 @@ static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
 	if (ret < 0)
 		return ret;
 
-	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
+	if (curl_easy_setopt(s3->easy_curl, CURLOPT_WRITEFUNCTION,
 			     s3erofs_request_write_memory_cb) != CURLE_OK)
 		return -EIO;
 
@@ -547,43 +546,37 @@ s3erofs_get_next_object(struct s3erofs_object_iterator *it)
 	return NULL;
 }
 
-static int s3erofs_global_init(void)
+static int s3erofs_curl_easy_init(struct erofs_s3 *s3)
 {
-	if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK)
-		return -EIO;
+	CURL *curl;
 
-	easy_curl = curl_easy_init();
-	if (!easy_curl)
-		goto out_err;
+	curl = curl_easy_init();
+	if (!curl)
+		return -ENOMEM;
 
-	if (curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK)
-		goto out_err;
+	if (curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK)
+		goto out_cleanup;
 
-	if (curl_easy_setopt(easy_curl, CURLOPT_CONNECTTIMEOUT, 30L) != CURLE_OK)
-		goto out_err;
+	if (curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L) != CURLE_OK)
+		goto out_cleanup;
 
-	if (curl_easy_setopt(easy_curl, CURLOPT_USERAGENT,
+	if (curl_easy_setopt(curl, CURLOPT_USERAGENT,
 			     "s3erofs/" PACKAGE_VERSION) != CURLE_OK)
-		goto out_err;
+		goto out_cleanup;
 
-	xmlInitParser();
+	s3->easy_curl = curl;
 	return 0;
-out_err:
-	curl_global_cleanup();
-	return -EIO;
+out_cleanup:
+	curl_easy_cleanup(curl);
+	return -EFAULT;
 }
 
-static void s3erofs_global_exit(void)
+static void s3erofs_curl_easy_exit(struct erofs_s3 *s3)
 {
-	if (!easy_curl)
+	if (!s3->easy_curl)
 		return;
-
-	xmlCleanupParser();
-
-	curl_easy_cleanup(easy_curl);
-	easy_curl = NULL;
-
-	curl_global_cleanup();
+	curl_easy_cleanup(s3->easy_curl);
+	s3->easy_curl = NULL;
 }
 
 struct s3erofs_curl_getobject_resp {
@@ -623,7 +616,7 @@ static int s3erofs_remote_getobject(struct erofs_s3 *s3,
 	if (ret < 0)
 		return ret;
 
-	if (curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION,
+	if (curl_easy_setopt(s3->easy_curl, CURLOPT_WRITEFUNCTION,
 			     s3erofs_remote_getobject_cb) != CURLE_OK)
 		return -EIO;
 
@@ -689,7 +682,7 @@ int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
 	st.st_uid = root->i_uid;
 	st.st_gid = root->i_gid;
 
-	ret = s3erofs_global_init();
+	ret = s3erofs_curl_easy_init(s3);
 	if (ret) {
 		erofs_err("failed to initialize s3erofs: %s", erofs_strerror(ret));
 		return ret;
@@ -764,6 +757,6 @@ int s3erofs_build_trees(struct erofs_inode *root, struct erofs_s3 *s3,
 err_iter:
 	s3erofs_destroy_object_iterator(iter);
 err_global:
-	s3erofs_global_exit();
+	s3erofs_curl_easy_exit(s3);
 	return ret;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 804d483..b8773fd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1481,10 +1481,12 @@ int main(int argc, char **argv)
 	struct timeval t;
 	FILE *blklst = NULL;
 	s64 mkfs_time = 0;
-	int err = 0;
+	int err;
 	u32 crc;
 
-	erofs_init_configure();
+	err = liberofs_global_init();
+	if (err)
+		return 1;
 	erofs_mkfs_default_options();
 
 	err = mkfs_parse_options_cfg(argc, argv);
@@ -1492,13 +1494,13 @@ int main(int argc, char **argv)
 	if (err) {
 		if (err == -EINVAL)
 			fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
-		return 1;
+		goto exit;
 	}
 
 	err = parse_source_date_epoch();
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
-		return 1;
+		goto exit;
 	}
 
 	g_sbi.fixed_nsec = 0;
@@ -1521,14 +1523,14 @@ int main(int argc, char **argv)
 				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
-		return 1;
+		goto exit;
 	}
 
 #ifdef WITH_ANDROID
 	if (cfg.fs_config_file &&
 	    load_canned_fs_config(cfg.fs_config_file) < 0) {
 		erofs_err("failed to load fs config %s", cfg.fs_config_file);
-		return 1;
+		goto exit;
 	}
 #endif
 	erofs_show_config();
@@ -1540,7 +1542,7 @@ int main(int argc, char **argv)
 		if (err) {
 			erofs_err("failed to initialize packedfile: %s",
 				  strerror(-err));
-			return 1;
+			goto exit;
 		}
 	}
 
@@ -1549,7 +1551,7 @@ int main(int argc, char **argv)
 		if (err) {
 			erofs_err("failed to initialize metabox: %s",
 				  erofs_strerror(err));
-			return 1;
+			goto exit;
 		}
 	}
 
@@ -1687,7 +1689,7 @@ int main(int argc, char **argv)
 	if (cfg.c_chunkbits) {
 		err = erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chunkbits);
 		if (err)
-			return 1;
+			goto exit;
 	}
 
 	if (tar_index_512b || cfg.c_blobdev_path) {
@@ -1851,7 +1853,6 @@ exit:
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
-	erofs_exit_configure();
 	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		erofs_iostream_close(&erofstar.ios);
 		if (erofstar.ios.dumpfd >= 0)
@@ -1866,5 +1867,6 @@ exit:
 	erofs_update_progressinfo("Build completed.\n");
 	erofs_mkfs_showsummaries();
 	erofs_put_super(&g_sbi);
+	liberofs_global_exit();
 	return 0;
 }
-- 
2.43.5


