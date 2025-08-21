Return-Path: <linux-erofs+bounces-856-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B957B2EFB7
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 09:33:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6w606Wc6z2yhD;
	Thu, 21 Aug 2025 17:33:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.65
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755761592;
	cv=none; b=he9ueMw+gagFW/yvx+7dkdIUittH64YbyAYj3d+baDE4gnYahfTeumvXQSZaWjzFgb9ZOphndzSpECCHEquD6O3fvaOGkiTbwsgMURVnG2CR8YVCCBcB19AdhbtbtibRmmO7bELmiJ1b/geZKvA2E07pVs7yPcz63H+GEIRJIrBd29CM4xqGdBTBNLnv+d4K7ULc/U1vwAktC5OxfXo+cP2HjXimcPDDMEpkrFstYz2CWa6GeT5oTxxB4uGq3WZig18dEtdTwiPDS8zMchug0KgdmFR4+W765LKSagMA0gYQLvp6oCITtlZAyb5F1m6i3uZ6xAbNLwcKl7BJDccCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755761592; c=relaxed/relaxed;
	bh=u3N7sEkhgRHmPd57jg4bbtMRIhv6vG1ZxmQ1CuVrhRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFNmYavGZUop/bfnUqCn3a9NTVeGi1Z5awnwtrLciXezB7UvdKwbMzChouR8VAO+R29uRcSbPIMfZ3BpQwTNKJU8mEI24Q3NW06UZ96iI27ixPOyzq2J2TZiu7UDdqfGugHWz9VE18gg4T4yPtV+mDf69hoIMcdJ2KpzAeKjlIO9X1Uhf2U3Kc43xp5u1M9K/dOhEDP7NOzcZ0CzbbSzmjfLnZwgRFpndvT047M7RywNwV1FOSON54llP7JZSWKZDJy6NeNAYC91mWjw2asiXZSQp97r6liH+h8hLy03uALLPr6ShR7vPmfqv6meGZIRTIGWfSaCGZ0EBDyy5PL41w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.65; helo=out28-65.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.65; helo=out28-65.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-65.mail.aliyun.com (out28-65.mail.aliyun.com [115.124.28.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6w5y4L8bz2xpn
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 17:33:08 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eLlkn2I_1755761580 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 15:33:01 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	ChengyuZhu6 <hudson@cyzhu.com>,
	Changzhi Xie <sa.z@qq.com>
Subject: [PATCH 1/1] erofs-utils: add OCI registry support
Date: Thu, 21 Aug 2025 15:32:58 +0800
Message-ID: <20250821073258.89073-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
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
	SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_FRAUD_PHISH,
	T_FILL_THIS_FORM_SHORT,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This patch adds support for building EROFS filesystems from OCI-compliant
container registries, enabling users to create EROFS images directly from
container images stored in registries like Docker Hub, Quay.io, etc.

The implementation includes:
- OCI remote backend with registry authentication support
- Manifest parsing for Docker v2 and OCI v1 formats
- Layer extraction and tar processing integration
- Multi-platform image selection capability
- Both anonymous and authenticated registry access
- Comprehensive build system integration

New mkfs.erofs option: --oci=registry/repo:tag[,options]

Supported options:
- platform=os/arch (default: linux/amd64)
- layer=N (extract specific layer, default: all layers)
- anonymous (use anonymous access)
- username/password (basic authentication)

Signed-off-by: Chengyu Zhu <hudson@cyzhu.com>
Signed-off-by: Changzhi Xie <sa.z@qq.com>
---
 configure.ac       |  45 +++
 lib/Makefile.am    |   8 +-
 lib/liberofs_oci.h |  73 +++++
 lib/remotes/oci.c  | 665 +++++++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c        | 155 ++++++++++-
 5 files changed, 944 insertions(+), 2 deletions(-)
 create mode 100644 lib/liberofs_oci.h
 create mode 100644 lib/remotes/oci.c

diff --git a/configure.ac b/configure.ac
index 7769ac9..4659747 100644
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
@@ -712,6 +752,7 @@ AM_CONDITIONAL([ENABLE_OPENSSL], [test "x${have_openssl}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
 AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
+AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -784,6 +825,10 @@ if test "x$have_s3" = "xyes"; then
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
index b079897..1e930e3 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -40,6 +40,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      vmdk.c metabox.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
+liberofs_la_LDFLAGS =
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${liblz4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
@@ -71,6 +72,11 @@ if ENABLE_S3
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
index 0000000..8ed98d7
--- /dev/null
+++ b/lib/liberofs_oci.h
@@ -0,0 +1,73 @@
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
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct erofs_inode;
+
+/* OCI authentication modes */
+enum oci_auth_mode {
+	OCI_AUTH_ANONYMOUS,	/* No authentication */
+	OCI_AUTH_TOKEN,		/* Bearer token authentication */
+	OCI_AUTH_BASIC,		/* Basic authentication */
+};
+
+/* Maximum lengths for OCI parameters */
+#define OCI_REGISTRY_LEN		256
+#define OCI_REPOSITORY_LEN		256
+#define OCI_TAG_LEN			64
+#define OCI_PLATFORM_LEN		32
+#define OCI_USERNAME_LEN		64
+#define OCI_PASSWORD_LEN		256
+
+/**
+ * struct erofs_oci - OCI configuration
+ * @registry:         registry hostname (e.g., "registry-1.docker.io")
+ * @repository:       image repository (e.g., "library/ubuntu")
+ * @tag:              image tag or digest (e.g., "latest" or sha256:...)
+ * @platform:         target platform in "os/arch" format (e.g., "linux/amd64")
+ * @username:         username for basic authentication
+ * @password:         password for basic authentication
+ * @auth_mode:        authentication mode to use
+ * @layer_index:      specific layer to extract (-1 for all layers)
+ * @anonymous_access: whether to use anonymous access
+ */
+struct erofs_oci {
+	char registry[OCI_REGISTRY_LEN + 1];
+	char repository[OCI_REPOSITORY_LEN + 1];
+	char tag[OCI_TAG_LEN + 1];
+	char platform[OCI_PLATFORM_LEN + 1];
+	char username[OCI_USERNAME_LEN + 1];
+	char password[OCI_PASSWORD_LEN + 1];
+	
+	enum oci_auth_mode auth_mode;
+	int layer_index;
+	bool anonymous_access;
+};
+
+/**
+ * ocierofs_build_trees - Build file trees from OCI container image layers
+ * @root:     root inode to build the file tree under
+ * @oci:      OCI configuration
+ * @ref:      reference string (unused, kept for API compatibility)
+ * @fillzero: if true, only create inodes without downloading actual data
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_build_trees(struct erofs_inode *root, struct erofs_oci *oci,
+			 const char *ref, bool fillzero);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __EROFS_OCI_H */
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
new file mode 100644
index 0000000..e86af50
--- /dev/null
+++ b/lib/remotes/oci.c
@@ -0,0 +1,665 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
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
+
+/* Constants */
+#define OCI_URL_MAX_LEN			8192
+#define OCI_AUTH_HEADER_MAX_LEN		1024
+#define OCI_TEMP_FILENAME_MAX_LEN	256
+
+/* Media types */
+#define DOCKER_MEDIATYPE_MANIFEST_V2	"application/vnd.docker.distribution.manifest.v2+json"
+#define DOCKER_MEDIATYPE_MANIFEST_V1	"application/vnd.docker.distribution.manifest.v1+json"
+#define DOCKER_MEDIATYPE_MANIFEST_LIST	"application/vnd.docker.distribution.manifest.list.v2+json"
+#define OCI_MEDIATYPE_MANIFEST		"application/vnd.oci.image.manifest.v1+json"
+#define OCI_MEDIATYPE_INDEX		"application/vnd.oci.image.index.v1+json"
+
+/* Registry constants */
+#define DOCKER_REGISTRY			"docker.io"
+#define DOCKER_API_REGISTRY		"registry-1.docker.io"
+#define QUAY_REGISTRY			"quay.io"
+
+/* Global CURL handle */
+static CURL *g_curl;
+
+/* HTTP request/response structures */
+struct oci_request {
+	char url[OCI_URL_MAX_LEN];
+	struct curl_slist *headers;
+};
+
+struct oci_response {
+	char *data;
+	size_t size;
+	long http_code;
+};
+
+/* Layer information */
+struct oci_layer {
+	char *digest;
+	u64 size;
+	const char *media_type;
+};
+
+/* Layer streaming context */
+struct oci_stream {
+	struct erofs_tarfile tarfile;
+	FILE *temp_file;
+	char temp_filename[OCI_TEMP_FILENAME_MAX_LEN];
+	int layer_index;
+};
+
+/* Callback for writing response data to memory */
+static size_t oci_write_callback(void *contents, size_t size, size_t nmemb, void *userp)
+{
+	size_t realsize = size * nmemb;
+	struct oci_response *resp = userp;
+	char *ptr;
+
+	ptr = realloc(resp->data, resp->size + realsize + 1);
+	if (!ptr)
+		return 0;
+
+	resp->data = ptr;
+	memcpy(&resp->data[resp->size], contents, realsize);
+	resp->size += realsize;
+	resp->data[resp->size] = '\0';
+	return realsize;
+}
+
+/* Callback for writing layer data to file */
+static size_t oci_layer_write_callback(void *contents, size_t size, size_t nmemb, void *userp)
+{
+	struct oci_stream *stream = userp;
+	size_t realsize = size * nmemb;
+	
+	if (!stream->temp_file)
+		return 0;
+		
+	if (fwrite(contents, 1, realsize, stream->temp_file) != realsize) {
+		erofs_err("failed to write layer data for layer %d", stream->layer_index);
+		return 0;
+	}
+	
+	return realsize;
+}
+
+/* Perform HTTP request */
+static int oci_request_perform(struct oci_request *req, struct oci_response *resp)
+{
+	CURLcode res;
+	
+	erofs_dbg("requesting URL: %s", req->url);
+	
+	curl_easy_setopt(g_curl, CURLOPT_URL, req->url);
+	curl_easy_setopt(g_curl, CURLOPT_WRITEDATA, resp);
+	curl_easy_setopt(g_curl, CURLOPT_WRITEFUNCTION, oci_write_callback);
+	
+	if (req->headers)
+		curl_easy_setopt(g_curl, CURLOPT_HTTPHEADER, req->headers);
+
+	res = curl_easy_perform(g_curl);
+	if (res != CURLE_OK) {
+		erofs_err("curl request failed: %s", curl_easy_strerror(res));
+		return -EIO;
+	}
+
+	res = curl_easy_getinfo(g_curl, CURLINFO_RESPONSE_CODE, &resp->http_code);
+	if (res != CURLE_OK) {
+		erofs_err("failed to get HTTP response code: %s", curl_easy_strerror(res));
+		return -EIO;
+	}
+
+	if (resp->http_code < 200 || resp->http_code >= 300) {
+		erofs_err("HTTP request failed with code %ld", resp->http_code);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Get authentication token */
+static char *oci_get_auth_token(const char *registry, const char *repository,
+				const char *username, const char *password)
+{
+	struct oci_request req = {};
+	struct oci_response resp = {};
+	json_object *root, *token_obj;
+	const char *token;
+	char *auth_header = NULL;
+	int ret;
+
+	if (!registry || !repository)
+		return ERR_PTR(-EINVAL);
+
+	if (!strcmp(registry, DOCKER_API_REGISTRY) || !strcmp(registry, DOCKER_REGISTRY)) {
+		snprintf(req.url, sizeof(req.url), 
+			 "https://auth.docker.io/token?service=registry.docker.io&scope=repository:%s:pull",
+			 repository);
+	} else if (!strcmp(registry, QUAY_REGISTRY)) {
+		snprintf(req.url, sizeof(req.url), 
+			 "https://%s/v2/auth?service=%s&scope=repository:%s:pull",
+			 QUAY_REGISTRY, QUAY_REGISTRY, repository);
+	} else {
+		snprintf(req.url, sizeof(req.url), 
+			 "https://%s/token?service=%s&scope=repository:%s:pull",
+			 registry, registry, repository);
+	}
+
+	if (username && password && *username) {
+		char *userpwd = malloc(strlen(username) + strlen(password) + 2);
+		if (!userpwd)
+			return ERR_PTR(-ENOMEM);
+			
+		sprintf(userpwd, "%s:%s", username, password);
+		curl_easy_setopt(g_curl, CURLOPT_USERPWD, userpwd);
+		curl_easy_setopt(g_curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
+		free(userpwd);
+	}
+
+	ret = oci_request_perform(&req, &resp);
+	
+	curl_easy_setopt(g_curl, CURLOPT_USERPWD, NULL);
+	curl_easy_setopt(g_curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
+	
+	if (ret)
+		goto out;
+
+	root = json_tokener_parse(resp.data);
+	if (!root) {
+		erofs_err("failed to parse auth response");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!json_object_object_get_ex(root, "token", &token_obj)) {
+		erofs_err("no token found in auth response");
+		ret = -EINVAL;
+		goto out_json;
+	}
+
+	token = json_object_get_string(token_obj);
+	if (!token) {
+		erofs_err("invalid token in auth response");
+		ret = -EINVAL;
+		goto out_json;
+	}
+
+	auth_header = malloc(strlen("Authorization: Bearer ") + strlen(token) + 1);
+	if (!auth_header) {
+		ret = -ENOMEM;
+		goto out_json;
+	}
+	
+	sprintf(auth_header, "Authorization: Bearer %s", token);
+
+out_json:
+	json_object_put(root);
+out:
+	free(resp.data);
+	return ret ? ERR_PTR(ret) : auth_header;
+}
+
+/* Get manifest digest for specified platform */
+static char *oci_get_manifest_digest(const char *registry, const char *repository,
+				     const char *tag, const char *platform,
+				     const char *auth_header)
+{
+	struct oci_request req = {};
+	struct oci_response resp = {};
+	json_object *root, *manifests, *manifest, *platform_obj, *arch_obj, *os_obj, *digest_obj;
+	json_object *schema_obj, *media_type_obj;
+	char *digest = NULL;
+	const char *api_registry;
+	int ret, len, i;
+
+	if (!registry || !repository || !tag || !platform)
+		return ERR_PTR(-EINVAL);
+
+	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+
+	snprintf(req.url, sizeof(req.url), "https://%s/v2/%s/manifests/%s",
+		 api_registry, repository, tag);
+
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+
+	req.headers = curl_slist_append(req.headers, 
+		"Accept: " DOCKER_MEDIATYPE_MANIFEST_LIST ","
+		OCI_MEDIATYPE_INDEX ","
+		DOCKER_MEDIATYPE_MANIFEST_V1 ","
+		DOCKER_MEDIATYPE_MANIFEST_V2);
+
+	ret = oci_request_perform(&req, &resp);
+	if (ret)
+		goto out;
+
+	root = json_tokener_parse(resp.data);
+	if (!root) {
+		erofs_err("failed to parse manifest JSON");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Handle v1 manifests */
+	if (json_object_object_get_ex(root, "schemaVersion", &schema_obj)) {
+		if (json_object_get_int(schema_obj) == 1) {
+			digest = strdup(tag);
+			goto out_json;
+		}
+	}
+
+	/* Handle single v2 manifests */
+	if (json_object_object_get_ex(root, "mediaType", &media_type_obj)) {
+		const char *media_type = json_object_get_string(media_type_obj);
+		if (!strcmp(media_type, DOCKER_MEDIATYPE_MANIFEST_V2) ||
+		    !strcmp(media_type, OCI_MEDIATYPE_MANIFEST)) {
+			digest = strdup(tag);
+			goto out_json;
+		}
+	}
+
+	/* Handle manifest lists */
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
+		if (json_object_object_get_ex(manifest, "platform", &platform_obj) &&
+		    json_object_object_get_ex(platform_obj, "architecture", &arch_obj) &&
+		    json_object_object_get_ex(platform_obj, "os", &os_obj) &&
+		    json_object_object_get_ex(manifest, "digest", &digest_obj)) {
+
+			const char *arch = json_object_get_string(arch_obj);
+			const char *os = json_object_get_string(os_obj);
+			char manifest_platform[64];
+
+			snprintf(manifest_platform, sizeof(manifest_platform), "%s/%s", os, arch);
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
+	
+	return ret ? ERR_PTR(ret) : digest;
+}
+
+/* Get all layer information from manifest */
+static struct oci_layer *oci_get_layers_info(const char *registry, const char *repository,
+					      const char *digest, const char *auth_header,
+					      int *layer_count)
+{
+	struct oci_request req = {};
+	struct oci_response resp = {};
+	json_object *root, *layers, *layer, *digest_obj, *size_obj, *media_type_obj;
+	struct oci_layer *layers_info = NULL;
+	const char *api_registry;
+	int ret, len, i;
+
+	if (!registry || !repository || !digest || !layer_count)
+		return ERR_PTR(-EINVAL);
+
+	*layer_count = 0;
+	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+
+	snprintf(req.url, sizeof(req.url), "https://%s/v2/%s/manifests/%s",
+		 api_registry, repository, digest);
+
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+		
+	req.headers = curl_slist_append(req.headers, 
+		"Accept: " OCI_MEDIATYPE_MANIFEST "," DOCKER_MEDIATYPE_MANIFEST_V2);
+
+	ret = oci_request_perform(&req, &resp);
+	if (ret)
+		goto out;
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
+	layers_info = calloc(len, sizeof(*layers_info));
+	if (!layers_info) {
+		ret = -ENOMEM;
+		goto out_json;
+	}
+
+	for (i = 0; i < len; i++) {
+		layer = json_object_array_get_idx(layers, i);
+		
+		if (!json_object_object_get_ex(layer, "digest", &digest_obj) ||
+		    !json_object_object_get_ex(layer, "size", &size_obj)) {
+			erofs_err("failed to parse layer %d", i);
+			ret = -EINVAL;
+			goto out_free;
+		}
+			
+		layers_info[i].digest = strdup(json_object_get_string(digest_obj));
+		if (!layers_info[i].digest) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		
+		layers_info[i].size = json_object_get_int64(size_obj);
+
+		if (json_object_object_get_ex(layer, "mediaType", &media_type_obj))
+			layers_info[i].media_type = json_object_get_string(media_type_obj);
+	}
+
+	*layer_count = len;
+	json_object_put(root);
+	free(resp.data);
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	return layers_info;
+
+out_free:
+	for (int j = 0; j < i; j++)
+		free(layers_info[j].digest);
+	free(layers_info);
+out_json:
+	json_object_put(root);
+out:
+	free(resp.data);
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	return ERR_PTR(ret);
+}
+
+/* Download and extract a single layer */
+static int oci_extract_layer(struct erofs_oci *oci, struct erofs_inode *root,
+			     const char *layer_digest, const char *auth_header,
+			     int layer_index)
+{
+	struct oci_request req = {};
+	struct oci_stream stream = {};
+	const char *api_registry;
+	int ret, fd;
+
+	if (!oci || !root || !layer_digest || layer_index < 0)
+		return -EINVAL;
+
+	snprintf(stream.temp_filename, sizeof(stream.temp_filename), 
+		 "/tmp/oci_layer_%d_%d.tar.gz", getpid(), layer_index);
+	stream.temp_file = fopen(stream.temp_filename, "wb");
+	if (!stream.temp_file) {
+		erofs_err("failed to create temp file: %s", stream.temp_filename);
+		return -errno;
+	}
+	stream.layer_index = layer_index;
+
+	api_registry = (!strcmp(oci->registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : oci->registry;
+
+	snprintf(req.url, sizeof(req.url), "https://%s/v2/%s/blobs/%s",
+		 api_registry, oci->repository, layer_digest);
+	
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+	
+	curl_easy_setopt(g_curl, CURLOPT_URL, req.url);
+	curl_easy_setopt(g_curl, CURLOPT_WRITEFUNCTION, oci_layer_write_callback);
+	curl_easy_setopt(g_curl, CURLOPT_WRITEDATA, &stream);
+	
+	if (req.headers)
+		curl_easy_setopt(g_curl, CURLOPT_HTTPHEADER, req.headers);
+
+	ret = curl_easy_perform(g_curl);
+	fclose(stream.temp_file);
+	stream.temp_file = NULL;
+
+	if (ret != CURLE_OK) {
+		erofs_err("failed to download layer: %s", curl_easy_strerror(ret));
+		ret = -EIO;
+		goto out;
+	}
+
+	fd = open(stream.temp_filename, O_RDONLY);
+	if (fd < 0) {
+		erofs_err("failed to open downloaded layer file");
+		ret = -errno;
+		goto out;
+	}
+
+	memset(&stream.tarfile, 0, sizeof(stream.tarfile));
+	init_list_head(&stream.tarfile.global.xattrs);
+	
+	ret = erofs_iostream_open(&stream.tarfile.ios, fd, EROFS_IOS_DECODER_GZIP);
+	if (ret) {
+		erofs_err("failed to initialize tar stream: %s", erofs_strerror(ret));
+		close(fd);
+		goto out;
+	}
+
+	while (!(ret = tarerofs_parse_tar(root, &stream.tarfile))) {
+		/* Continue parsing until end of archive */
+	}
+	
+	erofs_iostream_close(&stream.tarfile.ios);
+	
+	if (ret < 0 && ret != -ENODATA) {
+		erofs_err("failed to process tar stream: %s", erofs_strerror(ret));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	
+	if (unlink(stream.temp_filename) && errno != ENOENT)
+		erofs_warn("failed to remove temp file: %s", stream.temp_filename);
+		
+	return ret;
+}
+
+/* Initialize global CURL handle */
+static int oci_global_init(void)
+{
+	if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK)
+		return -EIO;
+
+	g_curl = curl_easy_init();
+	if (!g_curl) {
+		curl_global_cleanup();
+		return -EIO;
+	}
+
+	curl_easy_setopt(g_curl, CURLOPT_FOLLOWLOCATION, 1L);
+	curl_easy_setopt(g_curl, CURLOPT_CONNECTTIMEOUT, 30L);
+	curl_easy_setopt(g_curl, CURLOPT_TIMEOUT, 120L);
+	curl_easy_setopt(g_curl, CURLOPT_NOSIGNAL, 1L);
+	curl_easy_setopt(g_curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
+
+	return 0;
+}
+
+/* Cleanup global CURL handle */
+static void oci_global_exit(void)
+{
+	if (g_curl) {
+		curl_easy_cleanup(g_curl);
+		g_curl = NULL;
+	}
+	curl_global_cleanup();
+}
+
+/* Main function to build trees from OCI image */
+int ocierofs_build_trees(struct erofs_inode *root, struct erofs_oci *oci,
+			 const char *ref, bool fillzero)
+{
+	char *auth_header = NULL;
+	char *manifest_digest = NULL;
+	struct oci_layer *layers_info = NULL;
+	int layer_count = 0;
+	int ret, i;
+
+	if (!root || !oci)
+		return -EINVAL;
+
+	ret = oci_global_init();
+	if (ret) {
+		erofs_err("failed to initialize OCI client: %s", erofs_strerror(ret));
+		return ret;
+	}
+
+	if (!oci->anonymous_access) {
+		if (oci->username[0] && oci->password[0]) {
+			auth_header = oci_get_auth_token(oci->registry, oci->repository, 
+							 oci->username, oci->password);
+			if (IS_ERR(auth_header)) {
+				erofs_info("token auth failed, trying basic auth");
+				auth_header = NULL;
+				char *userpwd = malloc(strlen(oci->username) + strlen(oci->password) + 2);
+				if (!userpwd) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				sprintf(userpwd, "%s:%s", oci->username, oci->password);
+				curl_easy_setopt(g_curl, CURLOPT_USERPWD, userpwd);
+				curl_easy_setopt(g_curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
+				free(userpwd);
+			}
+		} else {
+			auth_header = oci_get_auth_token(oci->registry, oci->repository, NULL, NULL);
+			if (IS_ERR(auth_header)) {
+				ret = PTR_ERR(auth_header);
+				erofs_err("failed to get auth token: %s", erofs_strerror(ret));
+				goto out;
+			}
+		}
+	}
+	
+	manifest_digest = oci_get_manifest_digest(oci->registry, oci->repository,
+						  oci->tag, oci->platform, auth_header);
+	if (IS_ERR(manifest_digest)) {
+		ret = PTR_ERR(manifest_digest);
+		erofs_err("failed to get manifest digest: %s", erofs_strerror(ret));
+		goto out_auth;
+	}
+
+	layers_info = oci_get_layers_info(oci->registry, oci->repository,
+					  manifest_digest, auth_header, &layer_count);
+	if (IS_ERR(layers_info)) {
+		ret = PTR_ERR(layers_info);
+		erofs_err("failed to get layers info: %s", erofs_strerror(ret));
+		goto out_manifest;
+	}
+
+	/* Check if we should extract all layers or just a specific one */
+	if (oci->layer_index >= 0) {
+		if (oci->layer_index >= layer_count) {
+			erofs_err("layer index %d exceeds available layers (%d)", 
+				  oci->layer_index, layer_count);
+			ret = -EINVAL;
+			goto out_layers;
+		}
+		
+		/* Extract only the specified layer */
+		i = oci->layer_index;
+		char *trimmed = erofs_trim_for_progressinfo(layers_info[i].digest,
+				sizeof("Extracting layer  ...") - 1);
+		erofs_update_progressinfo("Extracting layer %d: %s ...", i, trimmed);
+		free(trimmed);
+
+		if (!fillzero) {
+			ret = oci_extract_layer(oci, root, layers_info[i].digest, auth_header, i);
+			if (ret) {
+				erofs_err("failed to extract layer %d: %s", i, erofs_strerror(ret));
+				goto out_layers;
+			}
+		}
+	} else {
+		/* Extract all layers */
+		for (i = 0; i < layer_count; i++) {
+			char *trimmed = erofs_trim_for_progressinfo(layers_info[i].digest,
+					sizeof("Extracting layer  ...") - 1);
+			erofs_update_progressinfo("Extracting layer %s ...", trimmed);
+			free(trimmed);
+
+			if (fillzero)
+				continue;
+
+			ret = oci_extract_layer(oci, root, layers_info[i].digest, auth_header, i);
+			if (ret) {
+				erofs_err("failed to extract layer %d: %s", i, erofs_strerror(ret));
+				goto out_layers;
+			}
+		}
+	}
+
+	ret = 0;
+
+out_layers:
+	for (i = 0; i < layer_count; i++)
+		free(layers_info[i].digest);
+	free(layers_info);
+out_manifest:
+	free(manifest_digest);
+out_auth:
+	free(auth_header);
+	
+	if (oci->username[0] && oci->password[0] && !auth_header) {
+		curl_easy_setopt(g_curl, CURLOPT_USERPWD, NULL);
+		curl_easy_setopt(g_curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
+	}
+	
+out:
+	oci_global_exit();
+	return ret;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 804d483..f2b9958 100644
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
+	{"oci", required_argument, NULL, 534},
 #endif
 	{0, 0, 0, 0},
 };
@@ -206,6 +210,14 @@ static void usage(int argc, char **argv)
 		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
 		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
 		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
+#endif
+#ifdef OCIEROFS_ENABLED
+		" --oci=X               generate an image from OCI-compatible registry\n"
+		"   [,platform=Y]       X=registry/repo:tag, Y=platform (default: linux/amd64)\n"
+		"   [,layer=Z]          Z=layer index to extract (default: 0)\n"
+		"   [,anonymous]        use anonymous access (no authentication)\n"
+		"   [,username=U]       U=username for basic authentication\n"
+		"   [,password=P]       P=password for basic authentication\n"
 #endif
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
@@ -261,6 +273,10 @@ static u8 metabox_algorithmid;
 static struct erofs_s3 s3cfg;
 #endif
 
+#ifdef OCIEROFS_ENABLED
+static struct erofs_oci ocicfg;
+#endif
+
 enum {
 	EROFS_MKFS_DATA_IMPORT_DEFAULT,
 	EROFS_MKFS_DATA_IMPORT_FULLDATA,
@@ -272,6 +288,7 @@ static enum {
 	EROFS_MKFS_SOURCE_LOCALDIR,
 	EROFS_MKFS_SOURCE_TAR,
 	EROFS_MKFS_SOURCE_S3,
+	EROFS_MKFS_SOURCE_OCI,
 	EROFS_MKFS_SOURCE_REBUILD,
 } source_mode;
 
@@ -668,6 +685,112 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 }
 #endif
 
+#ifdef OCIEROFS_ENABLED
+static int mkfs_parse_oci_cfg(char *cfg_str)
+{
+	char *p, *q, *opt, *ref_str;
+	char *slash, *colon, *dot;
+	const char *repo_part;
+	size_t len;
+
+	if (source_mode != EROFS_MKFS_SOURCE_LOCALDIR)
+		return -EINVAL;
+	source_mode = EROFS_MKFS_SOURCE_OCI;
+
+	if (!cfg_str) {
+		erofs_err("oci: missing parameter");
+		return -EINVAL;
+	}
+
+	memset(&ocicfg, 0, sizeof(ocicfg));
+	strcpy(ocicfg.platform, "linux/amd64");
+	strcpy(ocicfg.registry, "registry-1.docker.io");
+	strcpy(ocicfg.tag, "latest");
+	ocicfg.layer_index = -1;  /* -1 means extract all layers */
+	ocicfg.auth_mode = OCI_AUTH_TOKEN;
+
+	p = strchr(cfg_str, ',');
+	ref_str = p ? strndup(cfg_str, p - cfg_str) : strdup(cfg_str);
+	if (!ref_str)
+		return -ENOMEM;
+
+	slash = strchr(ref_str, '/');
+	if (slash) {
+		dot = strchr(ref_str, '.');
+		if (dot && dot < slash) {
+			len = slash - ref_str;
+			if (len >= sizeof(ocicfg.registry)) {
+				erofs_err("registry name too long");
+				goto err_free;
+			}
+			strncpy(ocicfg.registry, ref_str, len);
+			ocicfg.registry[len] = '\0';
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
+		len = colon - repo_part;
+		if (len >= sizeof(ocicfg.repository)) {
+			erofs_err("repository name too long");
+			goto err_free;
+		}
+		strncpy(ocicfg.repository, repo_part, len);
+		ocicfg.repository[len] = '\0';
+		strncpy(ocicfg.tag, colon + 1, sizeof(ocicfg.tag) - 1);
+	} else {
+		strncpy(ocicfg.repository, repo_part, sizeof(ocicfg.repository) - 1);
+	}
+
+	free(ref_str);
+
+	if (!p)
+		return 0;
+
+	opt = p + 1;
+	while (opt) {
+		q = strchr(opt, ',');
+		if (q)
+			*q = '\0';
+
+		if ((p = strstr(opt, "platform="))) {
+			strncpy(ocicfg.platform, p + 9, sizeof(ocicfg.platform) - 1);
+		} else if ((p = strstr(opt, "layer="))) {
+			ocicfg.layer_index = atoi(p + 6);
+			if (ocicfg.layer_index < 0) {
+				erofs_err("invalid layer index %d", ocicfg.layer_index);
+				return -EINVAL;
+			}
+		} else if (!strcmp(opt, "anonymous")) {
+			ocicfg.anonymous_access = true;
+			ocicfg.auth_mode = OCI_AUTH_ANONYMOUS;
+		} else if ((p = strstr(opt, "username="))) {
+			strncpy(ocicfg.username, p + 9, sizeof(ocicfg.username) - 1);
+			ocicfg.auth_mode = OCI_AUTH_BASIC;
+		} else if ((p = strstr(opt, "password="))) {
+			strncpy(ocicfg.password, p + 9, sizeof(ocicfg.password) - 1);
+			ocicfg.auth_mode = OCI_AUTH_BASIC;
+		} else {
+			erofs_err("invalid --oci option %s", opt);
+			return -EINVAL;
+		}
+
+		opt = q ? q + 1 : NULL;
+	}
+
+	return 0;
+
+err_free:
+	free(ref_str);
+	return -EINVAL;
+}
+#endif
+
 static int mkfs_parse_one_compress_alg(char *alg,
 				       struct erofs_compr_opts *copts)
 {
@@ -822,6 +945,13 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
 		if (!cfg.c_src_path)
 			return -ENOMEM;
 		break;
+#endif
+#ifdef OCIEROFS_ENABLED
+	case EROFS_MKFS_SOURCE_OCI:
+		cfg.c_src_path = strdup(argv[optind++]);
+		if (!cfg.c_src_path)
+			return -ENOMEM;
+		break;
 #endif
 	default:
 		erofs_err("unexpected source_mode: %d", source_mode);
@@ -1219,6 +1349,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (err)
 				return err;
 			break;
+#endif
+#ifdef OCIEROFS_ENABLED
+		case 534:
+			err = mkfs_parse_oci_cfg(optarg);
+			if (err)
+				return err;
+			break;
 #endif
 		case 'V':
 			version();
@@ -1638,7 +1775,8 @@ int main(int argc, char **argv)
 		erofs_uuid_generate(g_sbi.uuid);
 
 	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
-	    (source_mode == EROFS_MKFS_SOURCE_S3)) {
+	    (source_mode == EROFS_MKFS_SOURCE_S3) ||
+	    (source_mode == EROFS_MKFS_SOURCE_OCI)) {
 		err = erofs_diskbuf_init(1);
 		if (err) {
 			erofs_err("failed to initialize diskbuf: %s",
@@ -1756,12 +1894,27 @@ int main(int argc, char **argv)
 					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
 			if (err)
 				goto exit;
+#endif
+#ifdef OCIEROFS_ENABLED
+		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
+			if (incremental_mode ||
+			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
+				err = -EOPNOTSUPP;
+			else
+				err = ocierofs_build_trees(root, &ocicfg,
+							   cfg.c_src_path,
+					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
+			if (err)
+				goto exit;
+			erofs_info("OCI build_trees completed, starting filesystem construction");
 #endif
 		}
 
+		erofs_info("Starting erofs_rebuild_dump_tree...");
 		err = erofs_rebuild_dump_tree(root, incremental_mode);
 		if (err)
 			goto exit;
+		erofs_info("erofs_rebuild_dump_tree completed");
 	}
 
 	if (tar_index_512b) {
-- 
2.47.1


