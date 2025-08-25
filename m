Return-Path: <linux-erofs+bounces-902-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897DB33A13
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 11:02:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9Ptp62nKz3cdD;
	Mon, 25 Aug 2025 19:02:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.60
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756112530;
	cv=none; b=Rcj9QZyUpwwGBUXxOaI/cObeEW7hVziNbShYftWVZoPWk4PJ3ANN02H1ooGn5oMLx/mezquutxC8vD2pBufXFerEQxReybVj5xEVGVMc9+xqWdjkDSe7OIdMIrsitReWZhvKGJmoMqjrQrVLjIX4NhLg8ZD3Hb4eXoZSp9dHrcvc8CwD71o9yt5QKDMS36wNb290M09CkKkO0SUnyCRUf0/5N9UmwiT3v7bmAtlMRMlBsKxzhN44ZH8t9OjU5hAdN8HRCMtKYVy3nF6B1DK3TvTp+A2RovFZPYLpRqW0GRo3alXk3N5hJzmgs4rMF2khrEHUa/VMsB2iN46k5E3x5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756112530; c=relaxed/relaxed;
	bh=7WOx6uLxgsTXbQddF6dFqO5Ym/6ghb97XrUUxn4vrFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELleD6wTWdVRR7JGSyRAtS/bAsSbW4AGTn/PXcfKy0p0N1pokt3kLRIwsqTt3bzmPZqT1TNEvAV4bLit10ydQu13lTqAMr3x11R6OZIRLaHvGSlEIwQPRYtqnMIQFvAdtvrtaklhTbi11QUpwXrcVQWVwJND7rCU4PTGpkAqmgmbDJzyEZcvmyuIXjjQxCjlBpP+B/rRIaTvtSYeCIiNt+o3Z/VFvaudiOGHwRSYw3BP1XZTBoSjWO/LHih4riX0pTcN+u5izAXfqCANSiefyElUnpr7LDxSMzZM37klSXrKCvMPZB1w6/B1yfAKoQ37y2hQ6sESJ6jf3K5MQt5JUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.60; helo=out28-60.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.60; helo=out28-60.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-60.mail.aliyun.com (out28-60.mail.aliyun.com [115.124.28.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9Ptm29v0z3ccl
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 19:02:05 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eP-J7mG_1756112519 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 17:02:00 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudson@cyzhu.com>,
	Changzhi Xie <sa.z@qq.com>
Subject: [PATCH v6] erofs-utils: add OCI registry support
Date: Mon, 25 Aug 2025 17:01:55 +0800
Message-ID: <20250825090155.90587-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250821073258.89073-1-hudson@cyzhu.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,UNPARSEABLE_RELAY
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudson@cyzhu.com>

This patch adds support for building EROFS filesystems from
OCI-compliant container registries, enabling users to create EROFS
images directly from container images stored in registries like
Docker Hub, Quay.io, etc.

The implementation includes:
- OCI remote backend with registry authentication support
- Manifest parsing for Docker v2 and OCI v1 formats
- Layer extraction and tar processing integration
- Multi-platform image selection capability
- Both anonymous and authenticated registry access
- Comprehensive build system integration

Configure: ./configure --enable-oci
New mkfs.erofs option: --oci-options=[option] target source-image

Supported options:
- platform=os/arch (default: linux/amd64)
- layer=N (extract specific layer, default: all layers)
- username/password (basic authentication)

e.g.:
- mkfs.erofs \
  --oci-options=platform=linux/amd64, \
  username=1234,password=1234 \
  image.erofs ubuntu

Signed-off-by: Changzhi Xie <sa.z@qq.com>
Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>
---
 configure.ac       |   45 ++
 lib/Makefile.am    |    8 +-
 lib/liberofs_oci.h |   89 ++++
 lib/remotes/oci.c  | 1031 ++++++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c        |  296 ++++++++++++-
 5 files changed, 1467 insertions(+), 2 deletions(-)
 create mode 100644 lib/liberofs_oci.h
 create mode 100644 lib/remotes/oci.c

diff --git a/configure.ac b/configure.ac
index 1efb57a..135365e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -177,10 +177,19 @@ AC_ARG_WITH(libxml2,
    [AS_HELP_STRING([--with-libxml2],
       [Enable and build with libxml2 support @<:@default=auto@:>@])])
 
+AC_ARG_WITH(json_c,
+   [AS_HELP_STRING([--with-json-c],
+      [Enable and build with json-c support @<:@default=auto@:>@])])
+
 AC_ARG_ENABLE(s3,
    [AS_HELP_STRING([--enable-s3], [enable s3 image generation support @<:@default=no@:>@])],
    [enable_s3="$enableval"], [enable_s3="no"])
 
+AC_ARG_ENABLE(oci,
+    AS_HELP_STRING([--enable-oci],
+                   [enable OCI registry based input support @<:@default=no@:>@]),
+    [enable_oci="$enableval"],[enable_oci="no"])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -624,6 +633,37 @@ AS_IF([test "x$with_libcurl" != "xno"], [
   ])
 ])
 
+# Configure json-c
+have_json_c="no"
+AS_IF([test "x$with_json_c" != "xno"], [
+  PKG_CHECK_MODULES([json_c], [json-c], [
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${json_c_CFLAGS} ${CPPFLAGS}"
+    LIBS="${json_c_LIBS} $LIBS"
+    AC_CHECK_HEADERS([json-c/json.h],[
+      AC_CHECK_DECL(json_tokener_parse, [have_json_c="yes"],
+        [AC_MSG_ERROR([json-c doesn't work properly])], [[
+#include <json-c/json.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"
+  ], [
+    AC_MSG_ERROR([Cannot find proper json-c])
+  ])
+])
+
+# Validate dependencies for OCI registry
+AS_IF([test "x$enable_oci" = "xyes"], [
+  AS_IF([test "x$have_libcurl" = "xyes" -a "x$have_json_c" = "xyes"], [
+    have_oci="yes"
+  ], [
+    have_oci="no"
+    AC_MSG_ERROR([OCI registry disabled: missing libcurl or json-c])
+  ])
+], [have_oci="no"])
+
 # Configure openssl
 have_openssl="no"
 AS_IF([test "x$with_openssl" != "xno"], [
@@ -713,6 +753,7 @@ AM_CONDITIONAL([ENABLE_OPENSSL], [test "x${have_openssl}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
 AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
+AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -785,6 +826,10 @@ if test "x$have_s3" = "xyes"; then
   AC_DEFINE([S3EROFS_ENABLED], 1, [Define to 1 if s3 is enabled])
 fi
 
+if test "x$have_oci" = "xyes"; then
+  AC_DEFINE([OCIEROFS_ENABLED], 1, [Define to 1 if OCI registry is enabled])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 955495d..118b047 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -42,6 +42,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      vmdk.c metabox.c global.c importer.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
+liberofs_la_LDFLAGS =
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${liblz4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
@@ -73,6 +74,11 @@ if ENABLE_S3
 liberofs_la_SOURCES += remotes/s3.c
 endif
 if ENABLE_EROFS_MT
-liberofs_la_LDFLAGS = -lpthread
+liberofs_la_LDFLAGS += -lpthread
 liberofs_la_SOURCES += workqueue.c
 endif
+if ENABLE_OCI
+liberofs_la_SOURCES += remotes/oci.c
+liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${json_c_CFLAGS}
+liberofs_la_LDFLAGS += ${libcurl_LIBS} ${json_c_LIBS}
+endif
diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
new file mode 100644
index 0000000..05efbbc
--- /dev/null
+++ b/lib/liberofs_oci.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 Tencent, Inc.
+ *             http://www.tencent.com/
+ */
+#ifndef __EROFS_OCI_H
+#define __EROFS_OCI_H
+
+#include <stdbool.h>
+
+#define DOCKER_REGISTRY "docker.io"
+#define DOCKER_API_REGISTRY "registry-1.docker.io"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct erofs_inode;
+struct CURL;
+
+/*
+ * struct erofs_oci_params - OCI configuration
+ * @registry:         registry hostname (e.g., "registry-1.docker.io")
+ * @repository:       image repository (e.g., "library/ubuntu")
+ * @tag:              image tag or digest (e.g., "latest" or sha256:...)
+ * @platform:         target platform in "os/arch" format (e.g., "linux/amd64")
+ * @username:         username for authentication (optional)
+ * @password:         password for authentication (optional)
+ * @layer_index:      specific layer to extract (-1 for all layers)
+ */
+struct erofs_oci_params {
+	char *registry;
+	char *repository;
+	char *tag;
+	char *platform;
+	char *username;
+	char *password;
+	int layer_index;
+};
+
+/*
+ * struct erofs_oci - Combined OCI client structure
+ * @curl:             CURL handle for HTTP requests
+ * @params:           OCI configuration parameters
+ */
+struct erofs_oci {
+	struct CURL *curl;
+	struct erofs_oci_params params;
+};
+
+/*
+ * ocierofs_init - Initialize OCI client with default parameters
+ * @oci: OCI client structure to initialize
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_init(struct erofs_oci *oci);
+
+/*
+ * ocierofs_cleanup - Clean up OCI client and free allocated resources
+ * @oci: OCI client structure to clean up
+ */
+void ocierofs_cleanup(struct erofs_oci *oci);
+
+/*
+ * erofs_oci_params_set_string - Set a string field with dynamic allocation
+ * @field: pointer to the string field to set
+ * @value: string value to set
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int erofs_oci_params_set_string(char **field, const char *value);
+
+/*
+ * ocierofs_build_trees - Build file trees from OCI container image layers
+ * @root:     root inode to build the file tree under
+ * @oci:      OCI client structure with configured parameters
+ * @fillzero: if true, only create inodes without downloading actual data
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_build_trees(struct erofs_inode *root, struct erofs_oci *oci,
+			 bool fillzero);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __EROFS_OCI_H */
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
new file mode 100644
index 0000000..3fb2ef7
--- /dev/null
+++ b/lib/remotes/oci.c
@@ -0,0 +1,1031 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C) 2025 Tencent, Inc.
+ *             http://www.tencent.com/
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <curl/curl.h>
+#include <json-c/json.h>
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include "erofs/inode.h"
+#include "erofs/blobchunk.h"
+#include "erofs/diskbuf.h"
+#include "erofs/rebuild.h"
+#include "erofs/tar.h"
+#include "liberofs_oci.h"
+#include "liberofs_private.h"
+
+#define DOCKER_MEDIATYPE_MANIFEST_V2 \
+	"application/vnd.docker.distribution.manifest.v2+json"
+#define DOCKER_MEDIATYPE_MANIFEST_V1 \
+	"application/vnd.docker.distribution.manifest.v1+json"
+#define DOCKER_MEDIATYPE_MANIFEST_LIST \
+	"application/vnd.docker.distribution.manifest.list.v2+json"
+#define OCI_MEDIATYPE_MANIFEST "application/vnd.oci.image.manifest.v1+json"
+#define OCI_MEDIATYPE_INDEX "application/vnd.oci.image.index.v1+json"
+
+struct erofs_oci_request {
+	char *url;
+	struct curl_slist *headers;
+};
+
+struct erofs_oci_response {
+	char *data;
+	size_t size;
+	long http_code;
+};
+
+struct erofs_oci_stream {
+	struct erofs_tarfile tarfile;
+	int temp_fd;
+	int layer_index;
+};
+
+static size_t ocierofs_write_callback(void *contents, size_t size,
+				     size_t nmemb, void *userp)
+{
+	size_t realsize = size * nmemb;
+	struct erofs_oci_response *resp = userp;
+	char *ptr;
+
+	if (!resp || !contents)
+		return 0;
+
+	if (resp->data == NULL)
+		resp->size = 0;
+
+	ptr = realloc(resp->data, resp->size + realsize + 1);
+	if (!ptr) {
+		erofs_err("failed to allocate memory for response data");
+		return 0;
+	}
+
+	resp->data = ptr;
+	memcpy(&resp->data[resp->size], contents, realsize);
+	resp->size += realsize;
+	resp->data[resp->size] = '\0';
+	return realsize;
+}
+
+static size_t ocierofs_layer_write_callback(void *contents, size_t size,
+					   size_t nmemb, void *userp)
+{
+	struct erofs_oci_stream *stream = userp;
+	size_t realsize = size * nmemb;
+
+	if (stream->temp_fd < 0)
+		return 0;
+
+	if (write(stream->temp_fd, contents, realsize) != realsize) {
+		erofs_err("failed to write layer data for layer %d",
+			  stream->layer_index);
+		return 0;
+	}
+
+	return realsize;
+}
+
+static int ocierofs_curl_setup_common_options(struct CURL *curl)
+{
+	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
+	curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L);
+	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 120L);
+	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
+	curl_easy_setopt(curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
+
+	return 0;
+}
+
+static int ocierofs_curl_setup_basic_auth(struct CURL *curl, const char *username,
+					 const char *password)
+{
+	char *userpwd;
+
+	if (asprintf(&userpwd, "%s:%s", username, password) == -1)
+		return -ENOMEM;
+
+	curl_easy_setopt(curl, CURLOPT_USERPWD, userpwd);
+	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
+
+	free(userpwd);
+	return 0;
+}
+
+static int ocierofs_curl_clear_auth(struct CURL *curl)
+{
+	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
+	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
+
+	return 0;
+}
+
+enum ocierofs_http_method { OCIEROFS_HTTP_GET, OCIEROFS_HTTP_HEAD };
+
+static int ocierofs_curl_setup_request_ex(struct CURL *curl, const char *url,
+					 enum ocierofs_http_method method,
+					 struct curl_slist *headers,
+					 size_t (*write_func)(void *, size_t, size_t, void *),
+					 void *write_data,
+					 size_t (*header_func)(void *, size_t, size_t, void *),
+					 void *header_data)
+{
+	curl_easy_setopt(curl, CURLOPT_URL, url);
+
+	if (method == OCIEROFS_HTTP_HEAD) {
+		curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);
+	} else {
+		curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
+		curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);
+	}
+
+	if (write_func) {
+		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_func);
+		curl_easy_setopt(curl, CURLOPT_WRITEDATA, write_data);
+	}
+
+	curl_easy_setopt(curl, CURLOPT_HEADERFUNCTION, header_func);
+	curl_easy_setopt(curl, CURLOPT_HEADERDATA, header_data);
+
+	if (headers)
+		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
+
+	return 0;
+}
+
+static int ocierofs_curl_perform(struct CURL *curl, long *http_code_out)
+{
+	CURLcode res;
+	long http_code = 0;
+
+	res = curl_easy_perform(curl);
+	if (res != CURLE_OK) {
+		erofs_err("curl request failed: %s", curl_easy_strerror(res));
+		return -EIO;
+	}
+
+	if (http_code_out) {
+		res = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
+		if (res != CURLE_OK) {
+			erofs_err("failed to get HTTP response code: %s",
+				  curl_easy_strerror(res));
+			return -EIO;
+		}
+		*http_code_out = http_code;
+	}
+	return 0;
+}
+
+static int ocierofs_request_perform(struct erofs_oci *oci,
+				   struct erofs_oci_request *req,
+				   struct erofs_oci_response *resp)
+{
+	int ret;
+
+	ret = ocierofs_curl_setup_request_ex(oci->curl, req->url,
+					    OCIEROFS_HTTP_GET,
+					    req->headers,
+					    ocierofs_write_callback, resp,
+					    NULL, NULL);
+	if (ret)
+		return ret;
+
+	ret = ocierofs_curl_perform(oci->curl, &resp->http_code);
+	if (ret)
+		return ret;
+
+	if (resp->http_code < 200 || resp->http_code >= 300)
+		return -EIO;
+
+	return 0;
+}
+
+static int ocierofs_parse_auth_header(const char *auth_header,
+				     char **realm_out, char **service_out, char **scope_out)
+{
+	const char *p, *start;
+	char *value;
+	size_t len;
+	char *realm = NULL, *service = NULL, *scope = NULL;
+
+	if (!auth_header || strncmp(auth_header, "Bearer ", strlen("Bearer ")) != 0)
+		return -EINVAL;
+
+	p = auth_header + strlen("Bearer ");
+
+	p = strstr(p, "realm=\"");
+	if (p) {
+		p += strlen("realm=\"");
+		start = p;
+		p = strchr(start, '"');
+		if (p) {
+			len = p - start;
+			value = strndup(start, len);
+			if (!value)
+				goto enomem;
+			realm = value;
+		}
+	}
+
+	p = strstr(auth_header, "service=\"");
+	if (p) {
+		p += strlen("service=\"");
+		start = p;
+		p = strchr(start, '"');
+		if (p) {
+			len = p - start;
+			value = strndup(start, len);
+			if (!value)
+				goto enomem;
+			service = value;
+		}
+	}
+
+	p = strstr(auth_header, "scope=\"");
+	if (p) {
+		p += strlen("scope=\"");
+		start = p;
+		p = strchr(start, '"');
+		if (p) {
+			len = p - start;
+			value = strndup(start, len);
+			if (!value)
+				goto enomem;
+			scope = value;
+		}
+	}
+
+	if (realm_out) {
+		*realm_out = realm;
+		realm = NULL;
+	}
+	if (service_out) {
+		*service_out = service;
+		service = NULL;
+	}
+	if (scope_out) {
+		*scope_out = scope;
+		scope = NULL;
+	}
+
+	free(realm);
+	free(service);
+	free(scope);
+	return 0;
+
+enomem:
+	free(realm);
+	free(service);
+	free(scope);
+	return -ENOMEM;
+}
+
+static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
+					     const char *auth_url,
+					     const char *service,
+					     const char *repository,
+					     const char *username,
+					     const char *password)
+{
+	struct erofs_oci_request req = {};
+	struct erofs_oci_response resp = {};
+	json_object *root, *token_obj, *access_token_obj;
+	const char *token;
+	char *auth_header = NULL;
+	int ret;
+
+	if (!auth_url || !service || !repository)
+		return ERR_PTR(-EINVAL);
+
+	if (asprintf(&req.url, "%s?service=%s&scope=repository:%s:pull",
+		     auth_url, service, repository) == -1) {
+		return ERR_PTR(-ENOMEM);
+	}
+
+	erofs_dbg("Requesting auth token from: %s", req.url);
+
+	if (username && password && *username) {
+		ret = ocierofs_curl_setup_basic_auth(oci->curl, username,
+						    password);
+		if (ret)
+			goto out_url;
+	}
+
+	ret = ocierofs_request_perform(oci, &req, &resp);
+
+	ocierofs_curl_clear_auth(oci->curl);
+
+	if (ret)
+		goto out_url;
+
+	if (!resp.data) {
+		erofs_err("empty response from auth server");
+		ret = -EINVAL;
+		goto out_url;
+	}
+
+	root = json_tokener_parse(resp.data);
+	if (!root) {
+		erofs_err("failed to parse auth response");
+		ret = -EINVAL;
+		goto out_url;
+	}
+
+	if (!json_object_object_get_ex(root, "token", &token_obj) &&
+	    !json_object_object_get_ex(root, "access_token", &access_token_obj)) {
+		erofs_err("no token found in auth response");
+		ret = -EINVAL;
+		goto out_json;
+	}
+
+	token = json_object_get_string(token_obj ? token_obj : access_token_obj);
+	if (!token) {
+		erofs_err("invalid token in auth response");
+		ret = -EINVAL;
+		goto out_json;
+	}
+
+	if (asprintf(&auth_header, "Authorization: Bearer %s", token) == -1) {
+		ret = -ENOMEM;
+		goto out_json;
+	}
+
+out_json:
+	json_object_put(root);
+out_url:
+	free(req.url);
+	free(resp.data);
+	return ret ? ERR_PTR(ret) : auth_header;
+}
+
+static char *ocierofs_discover_auth_endpoint(struct erofs_oci *oci,
+					    const char *registry,
+					    const char *repository)
+{
+	struct erofs_oci_response resp = {};
+	char *realm = NULL;
+	char *result = NULL;
+	char *test_url;
+	const char *api_registry;
+	CURLcode res;
+	long http_code;
+
+	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+
+	if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
+	     api_registry, repository) == -1) {
+		return NULL;
+	}
+
+	curl_easy_reset(oci->curl);
+	ocierofs_curl_setup_common_options(oci->curl);
+
+	ocierofs_curl_setup_request_ex(oci->curl, test_url,
+				      OCIEROFS_HTTP_HEAD,
+				      NULL,
+				      NULL, NULL,
+				      ocierofs_write_callback, &resp);
+
+	res = curl_easy_perform(oci->curl);
+	curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE, &http_code);
+
+	if (res == CURLE_OK && (http_code == 401 || http_code == 403 ||
+	    http_code == 404) && resp.data) {
+		char *www_auth = strstr(resp.data, "WWW-Authenticate:");
+
+		if (www_auth) {
+			char *line_end = strchr(www_auth, '\n');
+
+			if (line_end)
+				*line_end = '\0';
+
+			www_auth += strlen("WWW-Authenticate:");
+			while (*www_auth == ' ')
+				www_auth++;
+
+			if (ocierofs_parse_auth_header(www_auth, &realm, NULL, NULL) == 0) {
+				result = realm;
+				realm = NULL;
+			}
+		}
+	}
+
+	free(realm);
+	free(resp.data);
+	free(test_url);
+	return result;
+}
+
+static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry,
+				    const char *repository, const char *username,
+				    const char *password)
+{
+	char *auth_header = NULL;
+	char *discovered_auth_url = NULL;
+	const char *service = registry;
+
+	if (!strcmp(registry, DOCKER_API_REGISTRY) ||
+	    !strcmp(registry, DOCKER_REGISTRY)) {
+		service = "registry.docker.io";
+		auth_header = ocierofs_get_auth_token_with_url(oci,
+							      "https://auth.docker.io/token",
+							      service, repository,
+							      username, password);
+		if (!IS_ERR(auth_header))
+			return auth_header;
+	}
+
+	discovered_auth_url = ocierofs_discover_auth_endpoint(oci, registry, repository);
+	if (discovered_auth_url) {
+		auth_header = ocierofs_get_auth_token_with_url(oci, discovered_auth_url,
+							      service, repository,
+							      username, password);
+		free(discovered_auth_url);
+		if (!IS_ERR(auth_header))
+			return auth_header;
+	}
+
+	static const char * const auth_patterns[] = {
+		"https://%s/v2/auth",
+		"https://auth.%s/token",
+		"https://%s/token",
+		NULL
+	};
+
+	for (int i = 0; auth_patterns[i]; i++) {
+		char *auth_url;
+
+		if (asprintf(&auth_url, auth_patterns[i], registry) == -1)
+			continue;
+
+		auth_header = ocierofs_get_auth_token_with_url(oci, auth_url,
+							      service, repository,
+							      username, password);
+		free(auth_url);
+
+		if (!IS_ERR(auth_header))
+			return auth_header;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
+					 const char *registry,
+					 const char *repository, const char *tag,
+					 const char *platform,
+					 const char *auth_header)
+{
+	struct erofs_oci_request req = {};
+	struct erofs_oci_response resp = {};
+	json_object *root, *manifests, *manifest, *platform_obj, *arch_obj;
+	json_object *os_obj, *digest_obj, *schema_obj, *media_type_obj;
+	char *digest = NULL;
+	const char *api_registry;
+	int ret = 0, len, i;
+
+	if (!registry || !repository || !tag || !platform)
+		return ERR_PTR(-EINVAL);
+
+	memset(&resp, 0, sizeof(resp));
+
+	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+
+	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
+	     api_registry, repository, tag) == -1) {
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+
+	req.headers = curl_slist_append(req.headers,
+		"Accept: " DOCKER_MEDIATYPE_MANIFEST_LIST ","
+		OCI_MEDIATYPE_INDEX "," DOCKER_MEDIATYPE_MANIFEST_V1 ","
+		DOCKER_MEDIATYPE_MANIFEST_V2);
+
+	ret = ocierofs_request_perform(oci, &req, &resp);
+	if (ret)
+		goto out;
+
+	if (!resp.data) {
+		erofs_err("empty response from manifest request");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	root = json_tokener_parse(resp.data);
+	if (!root) {
+		erofs_err("failed to parse manifest JSON");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (json_object_object_get_ex(root, "schemaVersion", &schema_obj)) {
+		if (json_object_get_int(schema_obj) == 1) {
+			digest = strdup(tag);
+			ret = 0;
+			goto out_json;
+		}
+	}
+
+	if (json_object_object_get_ex(root, "mediaType", &media_type_obj)) {
+		const char *media_type = json_object_get_string(media_type_obj);
+
+		if (!strcmp(media_type, DOCKER_MEDIATYPE_MANIFEST_V2) ||
+		    !strcmp(media_type, OCI_MEDIATYPE_MANIFEST)) {
+			digest = strdup(tag);
+			ret = 0;
+			goto out_json;
+		}
+	}
+
+	if (!json_object_object_get_ex(root, "manifests", &manifests)) {
+		erofs_err("no manifests found in manifest list");
+		ret = -EINVAL;
+		goto out_json;
+	}
+
+	len = json_object_array_length(manifests);
+	for (i = 0; i < len; i++) {
+		manifest = json_object_array_get_idx(manifests, i);
+
+		if (json_object_object_get_ex(manifest, "platform",
+					     &platform_obj) &&
+		    json_object_object_get_ex(platform_obj, "architecture",
+					     &arch_obj) &&
+		    json_object_object_get_ex(platform_obj, "os", &os_obj) &&
+		    json_object_object_get_ex(manifest, "digest", &digest_obj)) {
+			const char *arch = json_object_get_string(arch_obj);
+			const char *os = json_object_get_string(os_obj);
+			char manifest_platform[64];
+
+			snprintf(manifest_platform, sizeof(manifest_platform),
+				 "%s/%s", os, arch);
+			if (!strcmp(manifest_platform, platform)) {
+				digest = strdup(json_object_get_string(digest_obj));
+				break;
+			}
+		}
+	}
+
+	if (!digest)
+		ret = -ENOENT;
+
+out_json:
+	json_object_put(root);
+out:
+	free(resp.data);
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	free(req.url);
+
+	return ret ? ERR_PTR(ret) : digest;
+}
+
+static char **ocierofs_get_layers_info(struct erofs_oci *oci,
+				       const char *registry,
+				       const char *repository,
+				       const char *digest,
+				       const char *auth_header,
+				       int *layer_count)
+{
+	struct erofs_oci_request req = {};
+	struct erofs_oci_response resp = {};
+	json_object *root, *layers, *layer, *digest_obj;
+	char **layers_info = NULL;
+	const char *api_registry;
+	int ret, len, i;
+
+	if (!registry || !repository || !digest || !layer_count)
+		return ERR_PTR(-EINVAL);
+
+	*layer_count = 0;
+	memset(&resp, 0, sizeof(resp));
+	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+
+	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
+	     api_registry, repository, digest) == -1) {
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+
+	req.headers = curl_slist_append(req.headers,
+		"Accept: " OCI_MEDIATYPE_MANIFEST "," DOCKER_MEDIATYPE_MANIFEST_V2);
+
+	ret = ocierofs_request_perform(oci, &req, &resp);
+	if (ret)
+		goto out;
+
+	if (!resp.data) {
+		erofs_err("empty response from layers request");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	root = json_tokener_parse(resp.data);
+	if (!root) {
+		erofs_err("failed to parse manifest JSON");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!json_object_object_get_ex(root, "layers", &layers) ||
+	    json_object_get_type(layers) != json_type_array) {
+		erofs_err("no layers found in manifest");
+		ret = -EINVAL;
+		goto out_json;
+	}
+
+	len = json_object_array_length(layers);
+	if (len == 0) {
+		erofs_err("empty layer list in manifest");
+		ret = -EINVAL;
+		goto out_json;
+	}
+
+	layers_info = calloc(len, sizeof(char *));
+	if (!layers_info) {
+		ret = -ENOMEM;
+		goto out_json;
+	}
+
+	for (i = 0; i < len; i++) {
+		layer = json_object_array_get_idx(layers, i);
+
+		if (!json_object_object_get_ex(layer, "digest", &digest_obj)) {
+			erofs_err("failed to parse layer %d", i);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		layers_info[i] = strdup(json_object_get_string(digest_obj));
+		if (!layers_info[i]) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	*layer_count = len;
+	json_object_put(root);
+	free(resp.data);
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	free(req.url);
+	return layers_info;
+
+out_free:
+	if (layers_info) {
+		for (int j = 0; j < i; j++)
+			free(layers_info[j]);
+	}
+	free(layers_info);
+out_json:
+	json_object_put(root);
+out:
+	free(resp.data);
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	free(req.url);
+	return ERR_PTR(ret);
+}
+
+static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_inode *root,
+				 const char *layer_digest, const char *auth_header,
+				 int layer_index)
+{
+	struct erofs_oci_request req = {};
+	struct erofs_oci_stream stream = {};
+	const char *api_registry;
+	int ret, fd = -1;
+	long http_code;
+
+	if (!oci || !root || !layer_digest || layer_index < 0) {
+		erofs_err("invalid parameters for layer extraction");
+		return -EINVAL;
+	}
+
+	memset(&stream, 0, sizeof(stream));
+	stream.layer_index = layer_index;
+
+	stream.temp_fd = erofs_tmpfile();
+	if (stream.temp_fd < 0) {
+		erofs_err("failed to create temporary file for layer %d",
+			  layer_index);
+		return -errno;
+	}
+
+	api_registry = (!strcmp(oci->params.registry, DOCKER_REGISTRY)) ?
+		       DOCKER_API_REGISTRY : oci->params.registry;
+
+	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
+	     api_registry, oci->params.repository,
+	     layer_digest) == -1) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+
+	curl_easy_reset(oci->curl);
+
+	ret = ocierofs_curl_setup_common_options(oci->curl);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_setup_request_ex(oci->curl, req.url,
+					    OCIEROFS_HTTP_GET,
+					    req.headers,
+					    ocierofs_layer_write_callback,
+					    &stream,
+					    NULL, NULL);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_perform(oci->curl, &http_code);
+	if (ret)
+		goto out;
+
+	if (http_code < 200 || http_code >= 300) {
+		erofs_err("HTTP request failed with code %ld", http_code);
+		ret = -EIO;
+		goto out;
+	}
+
+	if (lseek(stream.temp_fd, 0, SEEK_SET) < 0) {
+		erofs_err("failed to seek to beginning of temp file: %s",
+			  strerror(errno));
+		ret = -errno;
+		goto out;
+	}
+
+	fd = dup(stream.temp_fd);
+	if (fd < 0) {
+		erofs_err("failed to duplicate temp file descriptor: %s",
+			  strerror(errno));
+		ret = -errno;
+		goto out;
+	}
+
+	memset(&stream.tarfile, 0, sizeof(stream.tarfile));
+	init_list_head(&stream.tarfile.global.xattrs);
+
+	ret = erofs_iostream_open(&stream.tarfile.ios, fd,
+				  EROFS_IOS_DECODER_GZIP);
+	if (ret) {
+		erofs_err("failed to initialize tar stream: %s",
+			  erofs_strerror(ret));
+		goto out;
+	}
+
+	ret = tarerofs_parse_tar(root, &stream.tarfile);
+	while (!ret) {
+		/* Continue parsing until end of archive */
+		ret = tarerofs_parse_tar(root, &stream.tarfile);
+	}
+
+	erofs_iostream_close(&stream.tarfile.ios);
+
+	if (ret < 0 && ret != -ENODATA) {
+		erofs_err("failed to process tar stream: %s",
+			  erofs_strerror(ret));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	if (fd >= 0)
+		close(fd);
+
+	if (stream.temp_fd >= 0)
+		close(stream.temp_fd);
+
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+
+	free(req.url);
+
+	return ret;
+}
+
+int ocierofs_build_trees(struct erofs_inode *root, struct erofs_oci *oci,
+			 bool fillzero)
+{
+	char *auth_header = NULL;
+	char *manifest_digest = NULL;
+	char **layers_info = NULL;
+	int layer_count = 0;
+	int ret, i;
+
+	if (!root || !oci)
+		return -EINVAL;
+
+	if (oci->params.username && oci->params.password &&
+	    oci->params.username[0] && oci->params.password[0]) {
+		auth_header = ocierofs_get_auth_token(oci,
+						     oci->params.registry,
+						     oci->params.repository,
+						     oci->params.username,
+						     oci->params.password);
+		if (IS_ERR(auth_header)) {
+			auth_header = NULL;
+			ret = ocierofs_curl_setup_basic_auth(oci->curl,
+							    oci->params.username,
+							    oci->params.password);
+			if (ret)
+				goto out;
+		}
+	} else {
+		auth_header = ocierofs_get_auth_token(oci,
+						     oci->params.registry,
+						     oci->params.repository,
+						     NULL, NULL);
+		if (IS_ERR(auth_header))
+			auth_header = NULL;
+	}
+
+	manifest_digest = ocierofs_get_manifest_digest(oci, oci->params.registry,
+						      oci->params.repository,
+						      oci->params.tag,
+						      oci->params.platform,
+						      auth_header);
+	if (IS_ERR(manifest_digest)) {
+		ret = PTR_ERR(manifest_digest);
+		erofs_err("failed to get manifest digest: %s",
+			  erofs_strerror(ret));
+		goto out_auth;
+	}
+
+	layers_info = ocierofs_get_layers_info(oci, oci->params.registry,
+					      oci->params.repository,
+					      manifest_digest, auth_header,
+					      &layer_count);
+	if (IS_ERR(layers_info)) {
+		ret = PTR_ERR(layers_info);
+		erofs_err("failed to get layers info: %s",
+			  erofs_strerror(ret));
+		goto out_manifest;
+	}
+
+	if (oci->params.layer_index >= 0) {
+		char *trimmed;
+
+		if (oci->params.layer_index >= layer_count) {
+			erofs_err("layer index %d exceeds available layers (%d)",
+				  oci->params.layer_index, layer_count);
+			ret = -EINVAL;
+			goto out_layers;
+		}
+
+		i = oci->params.layer_index;
+		trimmed = erofs_trim_for_progressinfo(layers_info[i],
+				sizeof("Extracting layer  ...") - 1);
+		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
+					  trimmed);
+		free(trimmed);
+
+		if (!fillzero) {
+			ret = ocierofs_extract_layer(oci, root, layers_info[i],
+						    auth_header, i);
+			if (ret) {
+				erofs_err("failed to extract layer %d: %s", i,
+					  erofs_strerror(ret));
+				goto out_layers;
+			}
+		}
+	} else {
+		for (i = 0; i < layer_count; i++) {
+			char *trimmed = erofs_trim_for_progressinfo(layers_info[i],
+					sizeof("Extracting layer  ...") - 1);
+			erofs_update_progressinfo("Extracting layer %s ...",
+					  trimmed);
+			free(trimmed);
+
+			if (fillzero)
+				continue;
+
+			ret = ocierofs_extract_layer(oci, root, layers_info[i],
+						    auth_header, i);
+			if (ret) {
+				erofs_err("failed to extract layer %d: %s", i,
+					  erofs_strerror(ret));
+				goto out_layers;
+			}
+		}
+	}
+
+	ret = 0;
+
+out_layers:
+	for (i = 0; i < layer_count; i++)
+		free(layers_info[i]);
+	free(layers_info);
+out_manifest:
+	free(manifest_digest);
+out_auth:
+	free(auth_header);
+
+	if (oci->params.username && oci->params.password &&
+	    oci->params.username[0] && oci->params.password[0] &&
+	    !auth_header) {
+		ocierofs_curl_clear_auth(oci->curl);
+	}
+
+out:
+	return ret;
+}
+
+int ocierofs_init(struct erofs_oci *oci)
+{
+	if (!oci)
+		return -EINVAL;
+
+	memset(oci, 0, sizeof(*oci));
+
+	if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK)
+		return -EIO;
+
+	oci->curl = curl_easy_init();
+	if (!oci->curl) {
+		curl_global_cleanup();
+		return -EIO;
+	}
+
+	if (ocierofs_curl_setup_common_options(oci->curl)) {
+		ocierofs_cleanup(oci);
+		return -EIO;
+	}
+
+	if (erofs_oci_params_set_string(&oci->params.platform,
+				"linux/amd64") ||
+	    erofs_oci_params_set_string(&oci->params.registry,
+				DOCKER_API_REGISTRY) ||
+	    erofs_oci_params_set_string(&oci->params.tag, "latest")) {
+		ocierofs_cleanup(oci);
+		return -ENOMEM;
+	}
+
+	oci->params.layer_index = -1; /* -1 means extract all layers */
+
+	return 0;
+}
+
+void ocierofs_cleanup(struct erofs_oci *oci)
+{
+	if (!oci)
+		return;
+
+	if (oci->curl) {
+		curl_easy_cleanup(oci->curl);
+		oci->curl = NULL;
+	}
+	curl_global_cleanup();
+
+	free(oci->params.registry);
+	free(oci->params.repository);
+	free(oci->params.tag);
+	free(oci->params.platform);
+	free(oci->params.username);
+	free(oci->params.password);
+
+	oci->params.registry = NULL;
+	oci->params.repository = NULL;
+	oci->params.tag = NULL;
+	oci->params.platform = NULL;
+	oci->params.username = NULL;
+	oci->params.password = NULL;
+}
+
+int erofs_oci_params_set_string(char **field, const char *value)
+{
+	char *new_value;
+
+	if (!field)
+		return -EINVAL;
+
+	if (!value) {
+		free(*field);
+		*field = NULL;
+		return 0;
+	}
+
+	new_value = strdup(value);
+	if (!new_value)
+		return -ENOMEM;
+
+	free(*field);
+	*field = new_value;
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index e0ba55d..403cd6a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -32,6 +32,7 @@
 #include "../lib/liberofs_uuid.h"
 #include "../lib/liberofs_metabox.h"
 #include "../lib/liberofs_s3.h"
+#include "../lib/liberofs_oci.h"
 #include "../lib/compressor.h"
 
 static struct option long_options[] = {
@@ -95,6 +96,9 @@ static struct option long_options[] = {
 	{"vmdk-desc", required_argument, NULL, 532},
 #ifdef S3EROFS_ENABLED
 	{"s3", required_argument, NULL, 533},
+#endif
+#ifdef OCIEROFS_ENABLED
+	{"oci-options", required_argument, NULL, 534},
 #endif
 	{0, 0, 0, 0},
 };
@@ -206,6 +210,14 @@ static void usage(int argc, char **argv)
 		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
 		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
 		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
+#endif
+#ifdef OCIEROFS_ENABLED
+		" --oci-options=X       specify OCI options\n"
+		"   X=platform=Y,layer=Z,username=U,password=P\n"
+		"   platform=Y          Y=platform (default: linux/amd64)\n"
+		"   layer=Z             Z=layer index to extract (0-based; omit to extract all layers)\n"
+		"   username=U          U=username for authentication (optional)\n"
+		"   password=P          P=password for authentication (optional)\n"
 #endif
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
@@ -261,6 +273,11 @@ static u8 metabox_algorithmid;
 static struct erofs_s3 s3cfg;
 #endif
 
+#ifdef OCIEROFS_ENABLED
+static struct erofs_oci ocicfg;
+static char *oci_options;
+#endif
+
 enum {
 	EROFS_MKFS_DATA_IMPORT_DEFAULT,
 	EROFS_MKFS_DATA_IMPORT_FULLDATA,
@@ -272,6 +289,7 @@ static enum {
 	EROFS_MKFS_SOURCE_LOCALDIR,
 	EROFS_MKFS_SOURCE_TAR,
 	EROFS_MKFS_SOURCE_S3,
+	EROFS_MKFS_SOURCE_OCI,
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
@@ -672,6 +690,235 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 }
 #endif
 
+#ifdef OCIEROFS_ENABLED
+static int parse_oci_platform_option(const char *opt, char *options_copy)
+{
+	const char *p;
+
+	p = strstr(opt, "platform=");
+	if (p) {
+		if (erofs_oci_params_set_string(&ocicfg.params.platform,
+						p + strlen("platform="))) {
+			erofs_err("failed to set platform");
+			free(options_copy);
+			return -ENOMEM;
+		}
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int parse_oci_layer_option(const char *opt, char *options_copy)
+{
+	const char *p;
+
+	p = strstr(opt, "layer=");
+	if (p) {
+		ocicfg.params.layer_index = atoi(p + strlen("layer="));
+		if (ocicfg.params.layer_index < 0) {
+			erofs_err("invalid layer index %d",
+				  ocicfg.params.layer_index);
+			free(options_copy);
+			return -EINVAL;
+		}
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int parse_oci_username_option(const char *opt, char *options_copy)
+{
+	const char *p;
+
+	p = strstr(opt, "username=");
+	if (p) {
+		if (erofs_oci_params_set_string(&ocicfg.params.username,
+						p + strlen("username="))) {
+			erofs_err("failed to set username");
+			free(options_copy);
+			return -ENOMEM;
+		}
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int parse_oci_password_option(const char *opt, char *options_copy)
+{
+	const char *p;
+
+	p = strstr(opt, "password=");
+	if (p) {
+		if (erofs_oci_params_set_string(&ocicfg.params.password,
+						p + strlen("password="))) {
+			erofs_err("failed to set password");
+			free(options_copy);
+			return -ENOMEM;
+		}
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int mkfs_parse_oci_options(const char *options_str)
+{
+	char *opt, *q, *options_copy;
+	int ret;
+
+	if (!options_str)
+		return 0;
+
+	options_copy = strdup(options_str);
+	if (!options_copy)
+		return -ENOMEM;
+
+	opt = options_copy;
+	while (opt) {
+		q = strchr(opt, ',');
+		if (q)
+			*q = '\0';
+
+		ret = parse_oci_platform_option(opt, options_copy);
+		if (ret == 0) {
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		ret = parse_oci_layer_option(opt, options_copy);
+		if (ret == 0) {
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		ret = parse_oci_username_option(opt, options_copy);
+		if (ret == 0) {
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		ret = parse_oci_password_option(opt, options_copy);
+		if (ret == 0) {
+			opt = q ? q + 1 : NULL;
+			continue;
+		}
+
+		erofs_err("invalid --oci-options value %s", opt);
+		free(options_copy);
+		return -EINVAL;
+	}
+
+	free(options_copy);
+	return 0;
+}
+
+static int mkfs_parse_oci_ref(const char *ref_str)
+{
+	char *slash, *colon, *dot;
+	const char *repo_part;
+	size_t len;
+
+	slash = strchr(ref_str, '/');
+	if (slash) {
+		dot = strchr(ref_str, '.');
+		if (dot && dot < slash) {
+			char *registry_str;
+
+			len = slash - ref_str;
+			registry_str = strndup(ref_str, len);
+
+			if (!registry_str) {
+				erofs_err("failed to allocate memory for registry");
+				return -ENOMEM;
+			}
+			if (erofs_oci_params_set_string(&ocicfg.params.registry,
+							registry_str)) {
+				free(registry_str);
+				erofs_err("failed to set registry");
+				return -ENOMEM;
+			}
+			free(registry_str);
+			repo_part = slash + 1;
+		} else {
+			repo_part = ref_str;
+		}
+	} else {
+		repo_part = ref_str;
+	}
+
+	colon = strchr(repo_part, ':');
+	if (colon) {
+		char *repo_str;
+
+		len = colon - repo_part;
+		repo_str = strndup(repo_part, len);
+
+		if (!repo_str) {
+			erofs_err("failed to allocate memory for repository");
+			return -ENOMEM;
+		}
+
+		if (!strchr(repo_str, '/') &&
+		    (!strcmp(ocicfg.params.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(ocicfg.params.registry, DOCKER_REGISTRY))) {
+			char *full_repo;
+
+			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
+				free(repo_str);
+				erofs_err("failed to allocate memory for full repository name");
+				return -ENOMEM;
+			}
+			free(repo_str);
+			repo_str = full_repo;
+		}
+
+		if (erofs_oci_params_set_string(&ocicfg.params.repository,
+						repo_str)) {
+			free(repo_str);
+			erofs_err("failed to set repository");
+			return -ENOMEM;
+		}
+		free(repo_str);
+
+		if (erofs_oci_params_set_string(&ocicfg.params.tag,
+						colon + 1)) {
+			erofs_err("failed to set tag");
+			return -ENOMEM;
+		}
+	} else {
+		char *repo_str = strdup(repo_part);
+
+		if (!repo_str) {
+			erofs_err("failed to allocate memory for repository");
+			return -ENOMEM;
+		}
+
+		if (!strchr(repo_str, '/') &&
+		    (!strcmp(ocicfg.params.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(ocicfg.params.registry, DOCKER_REGISTRY))) {
+			char *full_repo;
+
+			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
+				free(repo_str);
+				erofs_err("failed to allocate memory for full repository name");
+				return -ENOMEM;
+			}
+			free(repo_str);
+			repo_str = full_repo;
+		}
+
+		if (erofs_oci_params_set_string(&ocicfg.params.repository,
+						repo_str)) {
+			free(repo_str);
+			erofs_err("failed to set repository");
+			return -ENOMEM;
+		}
+		free(repo_str);
+	}
+
+	return 0;
+}
+#endif
+
 static int mkfs_parse_one_compress_alg(char *alg,
 				       struct erofs_compr_opts *copts)
 {
@@ -826,6 +1073,18 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 		if (!cfg.c_src_path)
 			return -ENOMEM;
 		break;
+#endif
+#ifdef OCIEROFS_ENABLED
+	case EROFS_MKFS_SOURCE_OCI:
+		if (optind < argc) {
+			cfg.c_src_path = strdup(argv[optind++]);
+			if (!cfg.c_src_path)
+				return -ENOMEM;
+		} else {
+			erofs_err("missing OCI source argument");
+			return -EINVAL;
+		}
+		break;
 #endif
 	default:
 		erofs_err("unexpected source_mode: %d", source_mode);
@@ -1221,6 +1480,14 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			if (err)
 				return err;
 			break;
+#endif
+#ifdef OCIEROFS_ENABLED
+		case 534:
+			oci_options = strdup(optarg);
+			if (!oci_options)
+				return -ENOMEM;
+			source_mode = EROFS_MKFS_SOURCE_OCI;
+			break;
 #endif
 		case 'V':
 			version();
@@ -1592,7 +1859,8 @@ int main(int argc, char **argv)
 		erofs_uuid_generate(g_sbi.uuid);
 
 	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
-	    (source_mode == EROFS_MKFS_SOURCE_S3)) {
+	    (source_mode == EROFS_MKFS_SOURCE_S3) ||
+	    (source_mode == EROFS_MKFS_SOURCE_OCI)) {
 		err = erofs_diskbuf_init(1);
 		if (err) {
 			erofs_err("failed to initialize diskbuf: %s",
@@ -1702,6 +1970,28 @@ int main(int argc, char **argv)
 			err = s3erofs_build_trees(&importer, &s3cfg,
 						  cfg.c_src_path,
 				dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
+#endif
+#ifdef OCIEROFS_ENABLED
+		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
+			err = ocierofs_init(&ocicfg);
+			if (err)
+				goto exit;
+
+			err = mkfs_parse_oci_options(oci_options);
+			if (err)
+				goto exit;
+			err = mkfs_parse_oci_ref(cfg.c_src_path);
+			if (err)
+				goto exit;
+
+			if (incremental_mode ||
+			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
+				err = -EOPNOTSUPP;
+			else
+				err = ocierofs_build_trees(&importer, &ocicfg,
+					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
+			if (err)
+				goto exit;
 #endif
 	}
 	if (err < 0)
@@ -1767,6 +2057,10 @@ exit:
 		erofs_blob_exit();
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
+#ifdef OCIEROFS_ENABLED
+	ocierofs_cleanup(&ocicfg);
+	free(oci_options);
+#endif
 	erofs_diskbuf_exit();
 	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		erofs_iostream_close(&erofstar.ios);
-- 
2.51.0


