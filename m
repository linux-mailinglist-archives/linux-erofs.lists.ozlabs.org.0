Return-Path: <linux-erofs+bounces-940-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BCB3DA91
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Sep 2025 09:01:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cFftJ3BnFz2yvk;
	Mon,  1 Sep 2025 17:01:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.63
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756710088;
	cv=none; b=J9zUKcLRbbAOYIu0rcSbV+TDdsJmap39OomEnbEsmKdbsDJrY+M9UAfqw0H2IV7iixBZiJXJGJ9KoWSAr7VqEIsnQKceA5yVWuziN6ESCKvN10gu3GVHV7VA078jrNKgLG4jE1PzcDmfyp9FtJK8+dY2o741tWmn4qeKUPQGLt5k6zbTpdY1SMtHHJjOfc8Dyd+CFi/qP/npWUmmO2WmwNzHCxBVXB2nXkyixZsxRztNWA1Luiut71lRo+5yepaogJlsKJQrCgUQ1cWyKIDpwQL+WD/Zh5kozQcKEgNm/Z7w+xPARyNKl8Kmh6XGbCffzX5ksWsOGfdskWXhOVVYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756710088; c=relaxed/relaxed;
	bh=SHcH81/8mpxXTnMPFboTmHAYSyJorLO3waV8xzCIHGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPOsJ7cvFw8WumwDrXyX6AQnvKt/70qJdakbfJ8ivylc3VfujLoLYjMN5fKW7eknT2wcNrlJDDV4SMuQWYtRPCaHoTFkqF7Kke2f0OCdvctZZMDv0cfOfnSYy/JqIm8X8/wafS6p009XiudPm2KionamlRUgOoTJuJ0bTV5cBaOkttiN1astkQv8mK6w73MeqrbBhPuV3lSk4zBq0RJ7P2OJJct6rObpe10WXr+U6nD36JOkpskUY1/XTlRsWzXFEE9/LCC2OepDN85AiYsEE045AHg6A7EsdfD6d9s8q36LgNMu6IZoEb9bD3EPzNE6kSRqXpCgLFbWcVYjd8hasQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-63.mail.aliyun.com (out28-63.mail.aliyun.com [115.124.28.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cFftG42sXz2ytT
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 Sep 2025 17:01:23 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eUkxQah_1756710077 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 01 Sep 2025 15:01:18 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1-changed] erofs-utils: refactor OCI code for better modularity
Date: Mon,  1 Sep 2025 15:01:15 +0800
Message-ID: <20250901070115.70603-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901051042.10905-1-hudson@cyzhu.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

Refactor OCI code to improve code organization and maintainability:

- Add `struct ocierofs_layer_info` to encapsulate layer metadata
- Extract authentication logic into `ocierofs_prepare_auth()`
- Split layer processing into `ocierofs_prepare_layers()`
- Move OCI parsing functions from `mkfs/main.c` to `lib/remotes/oci.c`
- Add `ocierofs_process_tar_stream()` for separate tar processing
- Improve error handling with `ocierofs_free_layers_info()`
- Refactor `ocierofs_extract_layer()` to return file descriptor

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h | 100 +++++++++
 lib/remotes/oci.c  | 540 +++++++++++++++++++++++++++++++++------------
 mkfs/main.c        | 200 +----------------
 3 files changed, 506 insertions(+), 334 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 3a8108b..698fe07 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -19,6 +19,23 @@ struct erofs_inode;
 struct CURL;
 struct erofs_importer;
 
+/**
+ * struct ocierofs_layer_info
+ * @digest: OCI content-addressable digest (e.g. "sha256:...")
+ * @media_type: mediaType string from the manifest
+ * @size: layer size in bytes from the manifest (0 if not available)
+ *
+ * This structure is exposed to callers so they can enumerate image layers,
+ * decide which ones to fetch, and pass the digest back to download APIs.
+ * Fields are heap-allocated NUL-terminated strings owned by the caller
+ * once returned from public APIs; the caller must free them.
+ */
+struct ocierofs_layer_info {
+	char *digest;
+	char *media_type;
+	u64 size;
+};
+
 /**
  * struct erofs_oci_params - OCI configuration parameters
  * @registry: registry hostname (e.g., "registry-1.docker.io")
@@ -88,6 +105,89 @@ int erofs_oci_params_set_string(char **field, const char *value);
  */
 int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci);
 
+/*
+ * ocierofs_parse_options - Parse comma-separated OCI options string
+ * @oci: OCI client structure to update
+ * @options_str: comma-separated options string
+ *
+ * Parse OCI options string containing comma-separated key=value pairs.
+ * Supported options include platform, layer, username, and password.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_parse_options(struct erofs_oci *oci, char *options_str);
+
+/*
+ * ocierofs_parse_ref - Parse OCI image reference string
+ * @oci: OCI client structure to update
+ * @ref_str: OCI image reference in various formats
+ *
+ * Parse OCI image reference which can be in formats:
+ * - registry.example.com/namespace/repo:tag
+ * - namespace/repo:tag (uses default registry)
+ * - repo:tag (adds library/ prefix for Docker Hub)
+ * - repo (uses default tag "latest")
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_parse_ref(struct erofs_oci *oci, const char *ref_str);
+
+/*
+ * ocierofs_prepare_layers - Prepare OCI layers for processing
+ * @oci: OCI client structure with configured parameters
+ * @auth_header: Pointer to store authentication header
+ * @using_basic: Pointer to store basic auth flag
+ * @manifest_digest: Pointer to store manifest digest
+ * @layers: Pointer to store layers information
+ * @layer_count: Pointer to store number of layers
+ * @start_index: Pointer to store starting layer index
+ *
+ * Prepare authentication, get manifest digest and layers information
+ * for OCI image processing. This function handles all the preparation
+ * work needed before processing OCI layers.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_prepare_layers(struct erofs_oci *oci, char **auth_header,
+			   bool *using_basic, char **manifest_digest,
+			   struct ocierofs_layer_info ***layers,
+			   int *layer_count, int *start_index);
+
+/**
+ * ocierofs_free_layers_info - Free layer information array
+ * @layers: array of layer information structures
+ * @count: number of layers in the array
+ *
+ * Free all layer information structures and the array itself.
+ * This function handles NULL pointers safely.
+ */
+void ocierofs_free_layers_info(struct ocierofs_layer_info **layers, int count);
+
+/**
+ * ocierofs_prepare_auth - Prepare authentication for OCI requests
+ * @oci: OCI client structure
+ * @auth_header_out: pointer to store authentication header
+ * @using_basic_auth: pointer to store basic auth flag
+ *
+ * Prepare authentication header for OCI registry requests.
+ * This function handles both token-based and basic authentication.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_prepare_auth(struct erofs_oci *oci, char **auth_header_out,
+			  bool *using_basic_auth);
+
+/**
+ * ocierofs_curl_clear_auth - Clear basic authentication from CURL handle
+ * @curl: CURL handle to clear authentication from
+ *
+ * Clear basic authentication credentials from a CURL handle.
+ * This should be called after using basic authentication to clean up.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int ocierofs_curl_clear_auth(struct CURL *curl);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 0fb8c1f..9774d8d 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -42,7 +42,6 @@ struct erofs_oci_response {
 };
 
 struct erofs_oci_stream {
-	struct erofs_tarfile tarfile;
 	const char *digest;
 	int blobfd;
 };
@@ -111,7 +110,7 @@ static int ocierofs_curl_setup_basic_auth(struct CURL *curl, const char *usernam
 	return 0;
 }
 
-static int ocierofs_curl_clear_auth(struct CURL *curl)
+int ocierofs_curl_clear_auth(struct CURL *curl)
 {
 	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
 	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
@@ -181,7 +180,7 @@ static int ocierofs_request_perform(struct erofs_oci *oci,
 
 	ret = ocierofs_curl_setup_rq(oci->curl, req->url,
 				     OCIEROFS_HTTP_GET, req->headers,
-			             ocierofs_write_callback, resp,
+				     ocierofs_write_callback, resp,
 				     NULL, NULL);
 	if (ret)
 		return ret;
@@ -568,7 +567,7 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
 	const char *api_registry;
 	int ret = 0, len, i;
 
-	if (!registry || !repository || !tag || !platform)
+	if (!registry || !repository || !tag)
 		return ERR_PTR(-EINVAL);
 
 	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
@@ -581,8 +580,8 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
 
 	req.headers = curl_slist_append(req.headers,
 		"Accept: " DOCKER_MEDIATYPE_MANIFEST_LIST ","
-		OCI_MEDIATYPE_INDEX "," DOCKER_MEDIATYPE_MANIFEST_V1 ","
-		DOCKER_MEDIATYPE_MANIFEST_V2);
+		OCI_MEDIATYPE_INDEX "," OCI_MEDIATYPE_MANIFEST ","
+		DOCKER_MEDIATYPE_MANIFEST_V1 "," DOCKER_MEDIATYPE_MANIFEST_V2);
 
 	ret = ocierofs_request_perform(oci, &req, &resp);
 	if (ret)
@@ -663,7 +662,24 @@ out:
 	return ret ? ERR_PTR(ret) : digest;
 }
 
-static char **ocierofs_get_layers_info(struct erofs_oci *oci,
+void ocierofs_free_layers_info(struct ocierofs_layer_info **layers, int count)
+{
+	int i;
+
+	if (!layers)
+		return;
+
+	for (i = 0; i < count; i++) {
+		if (layers[i]) {
+			free(layers[i]->digest);
+			free(layers[i]->media_type);
+			free(layers[i]);
+		}
+	}
+	free(layers);
+}
+
+static struct ocierofs_layer_info **ocierofs_fetch_layers_info(struct erofs_oci *oci,
 				       const char *registry,
 				       const char *repository,
 				       const char *digest,
@@ -672,10 +688,10 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
 {
 	struct erofs_oci_request req = {};
 	struct erofs_oci_response resp = {};
-	json_object *root, *layers, *layer, *digest_obj;
-	char **layers_info = NULL;
+	json_object *root, *layers, *layer, *digest_obj, *media_type_obj, *size_obj;
+	struct ocierofs_layer_info **layers_info = NULL;
 	const char *api_registry;
-	int ret, len, i, j;
+	int ret, len, i;
 
 	if (!registry || !repository || !digest || !layer_count)
 		return ERR_PTR(-EINVAL);
@@ -725,7 +741,7 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
 		goto out_json;
 	}
 
-	layers_info = calloc(len, sizeof(char *));
+	layers_info = calloc(len, sizeof(*layers_info));
 	if (!layers_info) {
 		ret = -ENOMEM;
 		goto out_json;
@@ -740,11 +756,25 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
 			goto out_free;
 		}
 
-		layers_info[i] = strdup(json_object_get_string(digest_obj));
+		layers_info[i] = calloc(1, sizeof(**layers_info));
 		if (!layers_info[i]) {
 			ret = -ENOMEM;
 			goto out_free;
 		}
+		layers_info[i]->digest = strdup(json_object_get_string(digest_obj));
+		if (!layers_info[i]->digest) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		if (json_object_object_get_ex(layer, "mediaType", &media_type_obj))
+			layers_info[i]->media_type = strdup(json_object_get_string(media_type_obj));
+		else
+			layers_info[i]->media_type = NULL;
+
+		if (json_object_object_get_ex(layer, "size", &size_obj))
+			layers_info[i]->size = json_object_get_int64(size_obj);
+		else
+			layers_info[i]->size = 0;
 	}
 
 	*layer_count = len;
@@ -756,11 +786,7 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
 	return layers_info;
 
 out_free:
-	if (layers_info) {
-		for (j = 0; j < i; j++)
-			free(layers_info[j]);
-	}
-	free(layers_info);
+	ocierofs_free_layers_info(layers_info, i);
 out_json:
 	json_object_put(root);
 out:
@@ -771,8 +797,93 @@ out:
 	return ERR_PTR(ret);
 }
 
-static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *importer,
-				  const char *digest, const char *auth_header)
+/**
+ * ocierofs_process_tar_stream - Process tar stream from file descriptor
+ * @importer: EROFS importer structure
+ * @fd: File descriptor containing tar data
+ *
+ * Initialize tar stream, parse all entries, and clean up resources.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ocierofs_process_tar_stream(struct erofs_importer *importer, int fd)
+{
+	struct erofs_tarfile tarfile = {};
+	int ret;
+
+	memset(&tarfile, 0, sizeof(tarfile));
+	init_list_head(&tarfile.global.xattrs);
+
+	ret = erofs_iostream_open(&tarfile.ios, fd, EROFS_IOS_DECODER_GZIP);
+	if (ret) {
+		erofs_err("failed to initialize tar stream: %s",
+			  erofs_strerror(ret));
+		return ret;
+	}
+
+	do {
+		ret = tarerofs_parse_tar(importer, &tarfile);
+		/* Continue parsing until end of archive */
+	} while (!ret);
+	erofs_iostream_close(&tarfile.ios);
+
+	if (ret < 0 && ret != -ENODATA) {
+		erofs_err("failed to process tar stream: %s",
+			  erofs_strerror(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+int ocierofs_prepare_auth(struct erofs_oci *oci, char **auth_header_out,
+				      bool *using_basic_auth)
+{
+	char *auth_header = NULL;
+	int ret = 0;
+
+	if (using_basic_auth)
+		*using_basic_auth = false;
+	if (auth_header_out)
+		*auth_header_out = NULL;
+
+	if (oci->params.username && oci->params.password &&
+	    oci->params.username[0] && oci->params.password[0]) {
+		auth_header = ocierofs_get_auth_token(oci,
+				      oci->params.registry,
+				      oci->params.repository,
+				      oci->params.username,
+				      oci->params.password);
+		if (IS_ERR(auth_header)) {
+			auth_header = NULL;
+			ret = ocierofs_curl_setup_basic_auth(oci->curl,
+					     oci->params.username,
+					     oci->params.password);
+			if (ret)
+				return ret;
+			if (using_basic_auth)
+				*using_basic_auth = true;
+		}
+	} else {
+		auth_header = ocierofs_get_auth_token(oci,
+				      oci->params.registry,
+				      oci->params.repository,
+				      NULL, NULL);
+		if (IS_ERR(auth_header))
+			auth_header = NULL;
+	}
+
+	if (auth_header_out)
+		*auth_header_out = auth_header;
+	else
+		free(auth_header);
+	return 0;
+}
+
+static int ocierofs_download_blob_to_fd(struct erofs_oci *oci,
+				     const char *digest,
+				     const char *auth_header,
+				     int outfd)
 {
 	struct erofs_oci_request req = {};
 	struct erofs_oci_stream stream = {};
@@ -782,20 +893,14 @@ static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *
 
 	stream = (struct erofs_oci_stream) {
 		.digest = digest,
-		.blobfd = erofs_tmpfile(),
+		.blobfd = outfd,
 	};
-	if (stream.blobfd < 0) {
-		erofs_err("failed to create temporary file for %s", digest);
-		return -errno;
-	}
 
 	api_registry = (!strcmp(oci->params.registry, DOCKER_REGISTRY)) ?
 		       DOCKER_API_REGISTRY : oci->params.registry;
 	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
-	     api_registry, oci->params.repository, digest) == -1) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	     api_registry, oci->params.repository, digest) == -1)
+		return -ENOMEM;
 
 	if (auth_header && strstr(auth_header, "Bearer"))
 		req.headers = curl_slist_append(req.headers, auth_header);
@@ -822,6 +927,32 @@ static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *
 		ret = -EIO;
 		goto out;
 	}
+	ret = 0;
+out:
+	if (req.headers)
+		curl_slist_free_all(req.headers);
+	free(req.url);
+	return ret;
+}
+
+static int ocierofs_extract_layer(struct erofs_oci *oci,
+				  const char *digest, const char *auth_header)
+{
+	struct erofs_oci_stream stream = {};
+	int ret;
+
+	stream = (struct erofs_oci_stream) {
+		.digest = digest,
+		.blobfd = erofs_tmpfile(),
+	};
+	if (stream.blobfd < 0) {
+		erofs_err("failed to create temporary file for %s", digest);
+		return -errno;
+	}
+
+	ret = ocierofs_download_blob_to_fd(oci, digest, auth_header, stream.blobfd);
+	if (ret)
+		goto out;
 
 	if (lseek(stream.blobfd, 0, SEEK_SET) < 0) {
 		erofs_err("failed to seek to beginning of temp file: %s",
@@ -830,162 +961,125 @@ static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *
 		goto out;
 	}
 
-	memset(&stream.tarfile, 0, sizeof(stream.tarfile));
-	init_list_head(&stream.tarfile.global.xattrs);
-
-	ret = erofs_iostream_open(&stream.tarfile.ios, stream.blobfd,
-				  EROFS_IOS_DECODER_GZIP);
-	if (ret) {
-		erofs_err("failed to initialize tar stream: %s",
-			  erofs_strerror(ret));
-		goto out;
-	}
-
-	do {
-		ret = tarerofs_parse_tar(importer, &stream.tarfile);
-		/* Continue parsing until end of archive */
-	} while (!ret);
-	erofs_iostream_close(&stream.tarfile.ios);
-
-	if (ret < 0 && ret != -ENODATA) {
-		erofs_err("failed to process tar stream: %s",
-			  erofs_strerror(ret));
-		goto out;
-	}
-	ret = 0;
+	return stream.blobfd;
 
 out:
 	if (stream.blobfd >= 0)
 		close(stream.blobfd);
-	if (req.headers)
-		curl_slist_free_all(req.headers);
-	free(req.url);
 	return ret;
 }
 
-/**
- * ocierofs_build_trees - Build file trees from OCI container image layers
- * @importer: EROFS importer structure
- * @oci: OCI client structure with configured parameters
- *
- * Extract and build file system trees from all layers of an OCI container
- * image.
- *
- * Return: 0 on success, negative errno on failure
- */
-int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci)
+int ocierofs_prepare_layers(struct erofs_oci *oci, char **auth_header,
+			   bool *using_basic, char **manifest_digest,
+			   struct ocierofs_layer_info ***layers,
+			   int *layer_count, int *start_index)
 {
-	char *auth_header = NULL;
-	char *manifest_digest = NULL;
-	char **layers = NULL;
-	int layer_count = 0;
-	int ret, i;
-
-	if (!importer || !oci)
-		return -EINVAL;
+	int ret;
 
-	if (oci->params.username && oci->params.password &&
-	    oci->params.username[0] && oci->params.password[0]) {
-		auth_header = ocierofs_get_auth_token(oci,
-						      oci->params.registry,
-						      oci->params.repository,
-						      oci->params.username,
-						      oci->params.password);
-		if (IS_ERR(auth_header)) {
-			auth_header = NULL;
-			ret = ocierofs_curl_setup_basic_auth(oci->curl,
-							     oci->params.username,
-							     oci->params.password);
-			if (ret)
-				goto out;
-		}
-	} else {
-		auth_header = ocierofs_get_auth_token(oci,
-						      oci->params.registry,
-						      oci->params.repository,
-						      NULL, NULL);
-		if (IS_ERR(auth_header))
-			auth_header = NULL;
-	}
+	ret = ocierofs_prepare_auth(oci, auth_header, using_basic);
+	if (ret)
+		return ret;
 
-	manifest_digest = ocierofs_get_manifest_digest(oci, oci->params.registry,
+	*manifest_digest = ocierofs_get_manifest_digest(oci, oci->params.registry,
 						       oci->params.repository,
 						       oci->params.tag,
 						       oci->params.platform,
-						       auth_header);
-	if (IS_ERR(manifest_digest)) {
-		ret = PTR_ERR(manifest_digest);
+						       *auth_header);
+	if (IS_ERR(*manifest_digest)) {
+		ret = PTR_ERR(*manifest_digest);
 		erofs_err("failed to get manifest digest: %s",
 			  erofs_strerror(ret));
 		goto out_auth;
 	}
 
-	layers = ocierofs_get_layers_info(oci, oci->params.registry,
-					  oci->params.repository,
-					  manifest_digest, auth_header,
-					  &layer_count);
-	if (IS_ERR(layers)) {
-		ret = PTR_ERR(layers);
+	*layers = ocierofs_fetch_layers_info(oci, oci->params.registry,
+					   oci->params.repository,
+					   *manifest_digest, *auth_header,
+					   layer_count);
+	if (IS_ERR(*layers)) {
+		ret = PTR_ERR(*layers);
 		erofs_err("failed to get image layers: %s", erofs_strerror(ret));
 		goto out_manifest;
 	}
 
 	if (oci->params.layer_index >= 0) {
-		if (oci->params.layer_index >= layer_count) {
+		if (oci->params.layer_index >= *layer_count) {
 			erofs_err("layer index %d exceeds available layers (%d)",
-				  oci->params.layer_index, layer_count);
+				  oci->params.layer_index, *layer_count);
 			ret = -EINVAL;
 			goto out_layers;
 		}
-		layer_count = 1;
-		i = oci->params.layer_index;
+		*layer_count = 1;
+		*start_index = oci->params.layer_index;
 	} else {
-		i = 0;
+		*start_index = 0;
 	}
 
+	return 0;
+
+out_layers:
+	free(*layers);
+	*layers = NULL;
+out_manifest:
+	free(*manifest_digest);
+	*manifest_digest = NULL;
+out_auth:
+	free(*auth_header);
+	*auth_header = NULL;
+	if (*using_basic)
+		ocierofs_curl_clear_auth(oci->curl);
+	return ret;
+}
+
+int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci)
+{
+	char *auth_header = NULL;
+	char *manifest_digest = NULL;
+	struct ocierofs_layer_info **layers = NULL;
+	int layer_count = 0;
+	int ret, i;
+	bool using_basic = false;
+
+	if (!importer || !oci)
+		return -EINVAL;
+
+	ret = ocierofs_prepare_layers(oci, &auth_header, &using_basic,
+				     &manifest_digest, &layers, &layer_count, &i);
+	if (ret)
+		return ret;
+
 	while (i < layer_count) {
-		char *trimmed = erofs_trim_for_progressinfo(layers[i],
+		char *trimmed = erofs_trim_for_progressinfo(layers[i]->digest,
 				sizeof("Extracting layer  ...") - 1);
 		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
 					  trimmed);
 		free(trimmed);
-		ret = ocierofs_extract_layer(oci, importer, layers[i],
+		int fd = ocierofs_extract_layer(oci, layers[i]->digest,
 					     auth_header);
-		if (ret) {
+		if (fd < 0) {
 			erofs_err("failed to extract layer %d: %s", i,
+				  erofs_strerror(fd));
+			break;
+		}
+		ret = ocierofs_process_tar_stream(importer, fd);
+		close(fd);
+		if (ret) {
+			erofs_err("failed to process tar stream for layer %d: %s", i,
 				  erofs_strerror(ret));
 			break;
 		}
 		i++;
 	}
-out_layers:
-	for (i = 0; i < layer_count; i++)
-		free(layers[i]);
-	free(layers);
-out_manifest:
+
+	ocierofs_free_layers_info(layers, layer_count);
 	free(manifest_digest);
-out_auth:
 	free(auth_header);
-
-	if (oci->params.username && oci->params.password &&
-	    oci->params.username[0] && oci->params.password[0] &&
-	    !auth_header) {
+	if (using_basic)
 		ocierofs_curl_clear_auth(oci->curl);
-	}
-out:
+
 	return ret;
 }
 
-/**
- * ocierofs_init - Initialize OCI client with default parameters
- * @oci: OCI client structure to initialize
- *
- * Initialize OCI client structure, set up CURL handle, and configure
- * default parameters including platform (linux/amd64), registry
- * (registry-1.docker.io), and tag (latest).
- *
- * Return: 0 on success, negative errno on failure
- */
 int ocierofs_init(struct erofs_oci *oci)
 {
 	if (!oci)
@@ -1066,3 +1160,177 @@ int erofs_oci_params_set_string(char **field, const char *value)
 	*field = new_value;
 	return 0;
 }
+
+int ocierofs_parse_options(struct erofs_oci *oci, char *options_str)
+{
+	char *opt, *q, *p;
+	int ret;
+
+	if (!options_str)
+		return 0;
+
+	opt = options_str;
+	while (opt) {
+		q = strchr(opt, ',');
+		if (q)
+			*q = '\0';
+
+		p = strstr(opt, "platform=");
+		if (p) {
+			p += strlen("platform=");
+			ret = erofs_oci_params_set_string(&oci->params.platform, p);
+			if (ret) {
+				erofs_err("failed to set platform");
+				return ret;
+			}
+		} else {
+			p = strstr(opt, "layer=");
+			if (p) {
+				p += strlen("layer=");
+				oci->params.layer_index = atoi(p);
+				if (oci->params.layer_index < 0) {
+					erofs_err("invalid layer index %d",
+						  oci->params.layer_index);
+					return -EINVAL;
+				}
+			} else {
+				p = strstr(opt, "username=");
+				if (p) {
+					p += strlen("username=");
+					ret = erofs_oci_params_set_string(&oci->params.username, p);
+					if (ret) {
+						erofs_err("failed to set username");
+						return ret;
+					}
+				} else {
+					p = strstr(opt, "password=");
+					if (p) {
+						p += strlen("password=");
+						ret = erofs_oci_params_set_string(&oci->params.password, p);
+						if (ret) {
+							erofs_err("failed to set password");
+							return ret;
+						}
+					} else {
+						erofs_err("invalid --oci value %s", opt);
+						return -EINVAL;
+					}
+				}
+			}
+		}
+
+		opt = q ? q + 1 : NULL;
+	}
+
+	return 0;
+}
+
+int ocierofs_parse_ref(struct erofs_oci *oci, const char *ref_str)
+{
+	char *slash, *colon, *dot;
+	const char *repo_part;
+	size_t len;
+
+	if (!oci || !ref_str)
+		return -EINVAL;
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
+			if (erofs_oci_params_set_string(&oci->params.registry,
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
+		    (!strcmp(oci->params.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(oci->params.registry, DOCKER_REGISTRY))) {
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
+		if (erofs_oci_params_set_string(&oci->params.repository,
+						repo_str)) {
+			free(repo_str);
+			erofs_err("failed to set repository");
+			return -ENOMEM;
+		}
+		free(repo_str);
+
+		if (erofs_oci_params_set_string(&oci->params.tag,
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
+		    (!strcmp(oci->params.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(oci->params.registry, DOCKER_REGISTRY))) {
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
+		if (erofs_oci_params_set_string(&oci->params.repository,
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
diff --git a/mkfs/main.c b/mkfs/main.c
index bc895f1..825cff3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -688,202 +688,6 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 }
 #endif
 
-#ifdef OCIEROFS_ENABLED
-
-
-/**
- * mkfs_parse_oci_options - Parse comma-separated OCI options string
- * @options_str: comma-separated options string
- *
- * Parse OCI options string containing comma-separated key=value pairs.
- * Supported options include platform, layer, username, and password.
- *
- * Return: 0 on success, negative errno on failure
- */
-static int mkfs_parse_oci_options(char *options_str)
-{
-	char *opt, *q, *p;
-	int ret;
-
-	if (!options_str)
-		return 0;
-
-	opt = options_str;
-	while (opt) {
-		q = strchr(opt, ',');
-		if (q)
-			*q = '\0';
-
-		p = strstr(opt, "platform=");
-		if (p) {
-			p += strlen("platform=");
-			ret = erofs_oci_params_set_string(&ocicfg.params.platform, p);
-			if (ret) {
-				erofs_err("failed to set platform");
-				return ret;
-			}
-		} else {
-			p = strstr(opt, "layer=");
-			if (p) {
-				p += strlen("layer=");
-				ocicfg.params.layer_index = atoi(p);
-				if (ocicfg.params.layer_index < 0) {
-					erofs_err("invalid layer index %d",
-						  ocicfg.params.layer_index);
-					return -EINVAL;
-				}
-			} else {
-				p = strstr(opt, "username=");
-				if (p) {
-					p += strlen("username=");
-					ret = erofs_oci_params_set_string(&ocicfg.params.username, p);
-					if (ret) {
-						erofs_err("failed to set username");
-						return ret;
-					}
-				} else {
-					p = strstr(opt, "password=");
-					if (p) {
-						p += strlen("password=");
-						ret = erofs_oci_params_set_string(&ocicfg.params.password, p);
-						if (ret) {
-							erofs_err("failed to set password");
-							return ret;
-						}
-					} else {
-						erofs_err("invalid --oci value %s", opt);
-						return -EINVAL;
-					}
-				}
-			}
-		}
-
-		opt = q ? q + 1 : NULL;
-	}
-
-	return 0;
-}
-
-/**
- * mkfs_parse_oci_ref - Parse OCI image reference string
- * @ref_str: OCI image reference in various formats
- *
- * Parse OCI image reference which can be in formats:
- * - registry.example.com/namespace/repo:tag
- * - namespace/repo:tag (uses default registry)
- * - repo:tag (adds library/ prefix for Docker Hub)
- * - repo (uses default tag "latest")
- *
- * Return: 0 on success, negative errno on failure
- */
-static int mkfs_parse_oci_ref(const char *ref_str)
-{
-	char *slash, *colon, *dot;
-	const char *repo_part;
-	size_t len;
-
-	slash = strchr(ref_str, '/');
-	if (slash) {
-		dot = strchr(ref_str, '.');
-		if (dot && dot < slash) {
-			char *registry_str;
-
-			len = slash - ref_str;
-			registry_str = strndup(ref_str, len);
-
-			if (!registry_str) {
-				erofs_err("failed to allocate memory for registry");
-				return -ENOMEM;
-			}
-			if (erofs_oci_params_set_string(&ocicfg.params.registry,
-							registry_str)) {
-				free(registry_str);
-				erofs_err("failed to set registry");
-				return -ENOMEM;
-			}
-			free(registry_str);
-			repo_part = slash + 1;
-		} else {
-			repo_part = ref_str;
-		}
-	} else {
-		repo_part = ref_str;
-	}
-
-	colon = strchr(repo_part, ':');
-	if (colon) {
-		char *repo_str;
-
-		len = colon - repo_part;
-		repo_str = strndup(repo_part, len);
-
-		if (!repo_str) {
-			erofs_err("failed to allocate memory for repository");
-			return -ENOMEM;
-		}
-
-		if (!strchr(repo_str, '/') &&
-		    (!strcmp(ocicfg.params.registry, DOCKER_API_REGISTRY) ||
-		     !strcmp(ocicfg.params.registry, DOCKER_REGISTRY))) {
-			char *full_repo;
-
-			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
-				free(repo_str);
-				erofs_err("failed to allocate memory for full repository name");
-				return -ENOMEM;
-			}
-			free(repo_str);
-			repo_str = full_repo;
-		}
-
-		if (erofs_oci_params_set_string(&ocicfg.params.repository,
-						repo_str)) {
-			free(repo_str);
-			erofs_err("failed to set repository");
-			return -ENOMEM;
-		}
-		free(repo_str);
-
-		if (erofs_oci_params_set_string(&ocicfg.params.tag,
-						colon + 1)) {
-			erofs_err("failed to set tag");
-			return -ENOMEM;
-		}
-	} else {
-		char *repo_str = strdup(repo_part);
-
-		if (!repo_str) {
-			erofs_err("failed to allocate memory for repository");
-			return -ENOMEM;
-		}
-
-		if (!strchr(repo_str, '/') &&
-		    (!strcmp(ocicfg.params.registry, DOCKER_API_REGISTRY) ||
-		     !strcmp(ocicfg.params.registry, DOCKER_REGISTRY))) {
-			char *full_repo;
-
-			if (asprintf(&full_repo, "library/%s", repo_str) == -1) {
-				free(repo_str);
-				erofs_err("failed to allocate memory for full repository name");
-				return -ENOMEM;
-			}
-			free(repo_str);
-			repo_str = full_repo;
-		}
-
-		if (erofs_oci_params_set_string(&ocicfg.params.repository,
-						repo_str)) {
-			free(repo_str);
-			erofs_err("failed to set repository");
-			return -ENOMEM;
-		}
-		free(repo_str);
-	}
-
-	return 0;
-}
-#endif
-
 static int mkfs_parse_one_compress_alg(char *alg,
 				       struct erofs_compr_opts *copts)
 {
@@ -1955,10 +1759,10 @@ int main(int argc, char **argv)
 			if (err)
 				goto exit;
 
-			err = mkfs_parse_oci_options(mkfs_oci_options);
+			err = ocierofs_parse_options(&ocicfg, mkfs_oci_options);
 			if (err)
 				goto exit;
-			err = mkfs_parse_oci_ref(cfg.c_src_path);
+			err = ocierofs_parse_ref(&ocicfg, cfg.c_src_path);
 			if (err)
 				goto exit;
 
-- 
2.51.0


