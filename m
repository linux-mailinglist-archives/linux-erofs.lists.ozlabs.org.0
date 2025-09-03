Return-Path: <linux-erofs+bounces-958-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE7B4187E
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Sep 2025 10:29:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGwkn66xjz2xQ1;
	Wed,  3 Sep 2025 18:29:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756888161;
	cv=none; b=ns3CDVZOtgoenEzqaHqdO1XPa+PqmS/gHxIPf2PHt1lthk07eGdHZfyqor3+H7SkT4tcqv20v+TQPPfam0+2FVf5gFVcoGKr+GeWAFKWKx46h+AfS6b2MDLmVWHqI1NE8ituLyPIx3rlyi8T6F730h867WMTZciBsJPqLUZ3tyG2WNS2jqbekp2/nOfjhha0c7kC6e7nCz6RPUT3983vtiHEjo2BYmrZZwQEaQ4ECemHKk8XrIHraqPbMjHP78vaskCHHNyisuL4XftCw9mIMN9ze3MC7QwpBL3qeJA9/j8GzKL/5GUBqUBPuZ3tIEdcd38+t6GCw3sJtVdVOEz6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756888161; c=relaxed/relaxed;
	bh=oiR8XT55v1r9v6q5cbRktYcQ12+P2RVX5oQH4wyjg/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLUkJFWWch3U9oVW5eLMJvIx9e+F3DA8sUAIUMVGqAlCPHmMRKiLb15tA2l7Hk/god7PKbGJ6W0GLVRzjHmVcR2ZUhxddHR4Ck/m3saR5TCZCCXZ5qgwCudyGZjAtJhcJLu+Zu2aGjRAZ7kB5/HccJz6bCFqgqCT0/8uKkuVkgdejwrIrU0MQIhvRHaqCoHe9dZf3neAwvhkEdv5Esgi/CW/GaLJAtgfRrJuPDBlI/IxEmV0GOxBBAqg/c3wSes7gJ2UKdCHoQ9uhb2ZvWCh8oo8Z50FDYl9/Mf8hRktLrTevkXIXOPbsiG1Jnv50t/87MpSuwJZlk6e6lqlb8Km9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.64; helo=out28-64.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.64; helo=out28-64.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-64.mail.aliyun.com (out28-64.mail.aliyun.com [115.124.28.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGwkk6dyfz2yFJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 18:29:18 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eWS3HNJ_1756888149 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 16:29:13 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v3 1/2] erofs-utils: refactor OCI code for better modularity
Date: Wed,  3 Sep 2025 16:29:05 +0800
Message-ID: <20250903082906.83826-2-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903082906.83826-1-hudson@cyzhu.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
 <20250903082906.83826-1-hudson@cyzhu.com>
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

From: Chengyu Zhu <hudsonzhu@tencent.com>

Refactor OCI code to improve code organization and maintainability:

Key changes:
- Add `ocierofs_get_api_registry()` and unify API endpoint selection.
- Implement Bearer token discovery with Basic fallback; cache auth header.
- Parse layer metadata (digest, mediaType, size) and add a proper free helper.
- Split blob download from tar processing; process tar via a temp fd.
- Rework init/teardown into `ocierofs_init()` and `ocierofs_ctx_cleanup()`.
- Update mkfs to use `struct ocierofs_config` and new `--oci` parsing.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |  84 ++---
 lib/remotes/oci.c  | 885 ++++++++++++++++++++++++++-------------------
 mkfs/main.c        | 192 ++--------
 3 files changed, 566 insertions(+), 595 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 3a8108b..d119a2b 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -8,85 +8,65 @@
 
 #include <stdbool.h>
 
-#define DOCKER_REGISTRY "docker.io"
-#define DOCKER_API_REGISTRY "registry-1.docker.io"
-
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-struct erofs_inode;
-struct CURL;
 struct erofs_importer;
 
-/**
- * struct erofs_oci_params - OCI configuration parameters
- * @registry: registry hostname (e.g., "registry-1.docker.io")
- * @repository: image repository (e.g., "library/ubuntu")
- * @tag: image tag or digest (e.g., "latest" or sha256:...)
+/*
+ * struct ocierofs_config - OCI configuration structure
+ * @image_ref: OCI image reference (e.g., "ubuntu:latest", "myregistry.com/app:v1.0")
  * @platform: target platform in "os/arch" format (e.g., "linux/amd64")
  * @username: username for authentication (optional)
  * @password: password for authentication (optional)
  * @layer_index: specific layer to extract (-1 for all layers)
  *
- * Configuration structure for OCI image parameters including registry
- * location, image identification, platform specification, and authentication
- * credentials.
  */
-struct erofs_oci_params {
-	char *registry;
-	char *repository;
-	char *tag;
+struct ocierofs_config {
+	char *image_ref;
 	char *platform;
 	char *username;
 	char *password;
 	int layer_index;
 };
 
-/**
- * struct erofs_oci - Combined OCI client structure
- * @curl: CURL handle for HTTP requests
- * @params: OCI configuration parameters
- *
- * Main OCI client structure combining CURL HTTP client with
- * OCI-specific configuration parameters.
- */
-struct erofs_oci {
-	struct CURL *curl;
-	struct erofs_oci_params params;
+struct ocierofs_layer_info {
+	char *digest;
+	char *media_type;
+	u64 size;
 };
 
-/*
- * ocierofs_init - Initialize OCI client with default parameters
- * @oci: OCI client structure to initialize
- *
- * Return: 0 on success, negative errno on failure
- */
-int ocierofs_init(struct erofs_oci *oci);
+struct ocierofs_ctx {
+	struct {
+		struct CURL *curl;
+		char *auth_header;
+		bool using_basic;
+	} net;
 
-/*
- * ocierofs_cleanup - Clean up OCI client and free allocated resources
- * @oci: OCI client structure to clean up
- */
-void ocierofs_cleanup(struct erofs_oci *oci);
+	struct {
+		char *registry;
+		char *repository;
+		char *platform;
+		int layer_index;
+		char *tag;
+		char *manifest_digest;
+		struct ocierofs_layer_info **layers;
+		int layer_count;
+	} img;
+};
 
-/*
- * erofs_oci_params_set_string - Set a string field with dynamic allocation
- * @field: pointer to the string field to set
- * @value: string value to set
- *
- * Return: 0 on success, negative errno on failure
- */
-int erofs_oci_params_set_string(char **field, const char *value);
+int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config);
 
 /*
- * ocierofs_build_trees - Build file trees from OCI container image layers
- * @root:     root inode to build the file tree under
- * @oci:      OCI client structure with configured parameters
+ * ocierofs_build_trees - Build file trees from an OCI container image
+ * @importer: erofs importer to populate
+ * @cfg:      oci configuration
  *
  * Return: 0 on success, negative errno on failure
  */
-int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci);
+int ocierofs_build_trees(struct erofs_importer *importer,
+			 const struct ocierofs_config *cfg);
 
 #ifdef __cplusplus
 }
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 0fb8c1f..01f1e24 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -21,6 +21,9 @@
 #include "liberofs_oci.h"
 #include "liberofs_private.h"
 
+#define DOCKER_REGISTRY "docker.io"
+#define DOCKER_API_REGISTRY "registry-1.docker.io"
+
 #define DOCKER_MEDIATYPE_MANIFEST_V2 \
 	"application/vnd.docker.distribution.manifest.v2+json"
 #define DOCKER_MEDIATYPE_MANIFEST_V1 \
@@ -30,28 +33,67 @@
 #define OCI_MEDIATYPE_MANIFEST "application/vnd.oci.image.manifest.v1+json"
 #define OCI_MEDIATYPE_INDEX "application/vnd.oci.image.index.v1+json"
 
-struct erofs_oci_request {
+struct ocierofs_request {
 	char *url;
 	struct curl_slist *headers;
 };
 
-struct erofs_oci_response {
+struct ocierofs_response {
 	char *data;
 	size_t size;
 	long http_code;
 };
 
-struct erofs_oci_stream {
-	struct erofs_tarfile tarfile;
+struct ocierofs_stream {
 	const char *digest;
 	int blobfd;
 };
 
+static inline const char *ocierofs_get_api_registry(const char *registry)
+{
+	if (!registry)
+		return DOCKER_API_REGISTRY;
+	return !strcmp(registry, DOCKER_REGISTRY) ? DOCKER_API_REGISTRY : registry;
+}
+
+static inline bool ocierofs_is_manifest_list(const char *media_type)
+{
+	return media_type && (!strcmp(media_type, DOCKER_MEDIATYPE_MANIFEST_LIST) ||
+			       !strcmp(media_type, OCI_MEDIATYPE_INDEX));
+}
+
+static inline bool ocierofs_is_manifest(const char *media_type)
+{
+	return media_type && (!strcmp(media_type, DOCKER_MEDIATYPE_MANIFEST_V2) ||
+			       !strcmp(media_type, OCI_MEDIATYPE_MANIFEST));
+}
+
+static inline void ocierofs_request_cleanup(struct ocierofs_request *req)
+{
+	if (!req)
+		return;
+	if (req->headers)
+		curl_slist_free_all(req->headers);
+	free(req->url);
+	req->url = NULL;
+	req->headers = NULL;
+}
+
+static inline void ocierofs_response_cleanup(struct ocierofs_response *resp)
+{
+	if (!resp)
+		return;
+	free(resp->data);
+	resp->data = NULL;
+	resp->size = 0;
+	resp->http_code = 0;
+}
+
 static size_t ocierofs_write_callback(void *contents, size_t size,
 				      size_t nmemb, void *userp)
 {
 	size_t realsize = size * nmemb;
-	struct erofs_oci_response *resp = userp;
+	struct ocierofs_response *resp = userp;
 	char *ptr;
 
 	if (!resp->data)
@@ -72,16 +114,23 @@ static size_t ocierofs_write_callback(void *contents, size_t size,
 static size_t ocierofs_layer_write_callback(void *contents, size_t size,
 					    size_t nmemb, void *userp)
 {
-	struct erofs_oci_stream *stream = userp;
+	struct ocierofs_stream *stream = userp;
 	size_t realsize = size * nmemb;
+	const char *buf = contents;
+	size_t written = 0;
 
 	if (stream->blobfd < 0)
 		return 0;
 
-	if (write(stream->blobfd, contents, realsize) != realsize) {
-		erofs_err("failed to write layer data for layer %s",
-			  stream->digest);
-		return 0;
+	while (written < realsize) {
+		ssize_t n = write(stream->blobfd, buf + written, realsize - written);
+
+		if (n < 0) {
+			erofs_err("failed to write layer data for layer %s",
+				  stream->digest);
+			return 0;
+		}
+		written += n;
 	}
 	return realsize;
 }
@@ -93,6 +142,14 @@ static int ocierofs_curl_setup_common_options(struct CURL *curl)
 	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 120L);
 	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
 	curl_easy_setopt(curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
+	curl_easy_setopt(curl, CURLOPT_ACCEPT_ENCODING, "");
+	curl_easy_setopt(curl, CURLOPT_TCP_KEEPALIVE, 1L);
+#if defined(CURLOPT_TCP_KEEPIDLE)
+	curl_easy_setopt(curl, CURLOPT_TCP_KEEPIDLE, 30L);
+#endif
+#if defined(CURLOPT_TCP_KEEPINTVL)
+	curl_easy_setopt(curl, CURLOPT_TCP_KEEPINTVL, 15L);
+#endif
 	return 0;
 }
 
@@ -111,10 +168,10 @@ static int ocierofs_curl_setup_basic_auth(struct CURL *curl, const char *usernam
 	return 0;
 }
 
-static int ocierofs_curl_clear_auth(struct CURL *curl)
+static int ocierofs_curl_clear_auth(struct ocierofs_ctx *ctx)
 {
-	curl_easy_setopt(curl, CURLOPT_USERPWD, NULL);
-	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
+	curl_easy_setopt(ctx->net.curl, CURLOPT_USERPWD, NULL);
+	curl_easy_setopt(ctx->net.curl, CURLOPT_HTTPAUTH, CURLAUTH_NONE);
 	return 0;
 }
 
@@ -173,20 +230,20 @@ static int ocierofs_curl_perform(struct CURL *curl, long *http_code_out)
 	return 0;
 }
 
-static int ocierofs_request_perform(struct erofs_oci *oci,
-				    struct erofs_oci_request *req,
-				    struct erofs_oci_response *resp)
+static int ocierofs_request_perform(struct ocierofs_ctx *ctx,
+				    struct ocierofs_request *req,
+				    struct ocierofs_response *resp)
 {
 	int ret;
 
-	ret = ocierofs_curl_setup_rq(oci->curl, req->url,
+	ret = ocierofs_curl_setup_rq(ctx->net.curl, req->url,
 				     OCIEROFS_HTTP_GET, req->headers,
-			             ocierofs_write_callback, resp,
+				     ocierofs_write_callback, resp,
 				     NULL, NULL);
 	if (ret)
 		return ret;
 
-	ret = ocierofs_curl_perform(oci->curl, &resp->http_code);
+	ret = ocierofs_curl_perform(ctx->net.curl, &resp->http_code);
 	if (ret)
 		return ret;
 
@@ -201,15 +258,10 @@ static int ocierofs_request_perform(struct erofs_oci *oci,
  * @realm_out: pointer to store realm value
  * @service_out: pointer to store service value
  * @scope_out: pointer to store scope value
- *
- * Parse Bearer authentication header and extract realm, service, and scope
- * parameters for subsequent token requests.
- *
- * Return: 0 on success, negative errno on failure
  */
 static int ocierofs_parse_auth_header(const char *auth_header,
-				      char **realm_out, char **service_out,
-				      char **scope_out)
+			      char **realm_out, char **service_out,
+			      char **scope_out)
 {
 	char *realm = NULL, *service = NULL, *scope = NULL;
 	static const char * const param_names[] = {"realm=", "service=", "scope="};
@@ -218,7 +270,6 @@ static int ocierofs_parse_auth_header(const char *auth_header,
 	const char *p;
 	int i, ret = 0;
 
-	// https://datatracker.ietf.org/doc/html/rfc6750#section-3
 	if (strncmp(auth_header, "Bearer ", strlen("Bearer ")))
 		return -EINVAL;
 
@@ -226,7 +277,6 @@ static int ocierofs_parse_auth_header(const char *auth_header,
 	if (!header_copy)
 		return -ENOMEM;
 
-	/* Clean up header: replace newlines with spaces and remove double spaces */
 	for (char *q = header_copy; *q; q++) {
 		if (*q == '\n' || *q == '\r')
 			*q = ' ';
@@ -274,22 +324,9 @@ out:
 	return ret;
 }
 
-/**
- * ocierofs_extract_www_auth_info - Extract WWW-Authenticate header information
- * @resp_data: HTTP response data containing headers
- * @realm_out: pointer to store realm value (optional)
- * @service_out: pointer to store service value (optional)
- * @scope_out: pointer to store scope value (optional)
- *
- * Extract realm, service, and scope from WWW-Authenticate header in HTTP response.
- * This function handles the common pattern of parsing WWW-Authenticate headers
- * that appears in multiple places in the OCI authentication flow.
- *
- * Return: 0 on success, negative errno on failure
- */
 static int ocierofs_extract_www_auth_info(const char *resp_data,
-					  char **realm_out, char **service_out,
-					  char **scope_out)
+				  char **realm_out, char **service_out,
+				  char **scope_out)
 {
 	char *www_auth;
 	char *line_end;
@@ -333,29 +370,15 @@ static int ocierofs_extract_www_auth_info(const char *resp_data,
 	return ret;
 }
 
-/**
- * ocierofs_get_auth_token_with_url - Get authentication token from auth server
- * @oci: OCI client structure
- * @auth_url: authentication server URL
- * @service: service name for authentication
- * @repository: repository name
- * @username: username for basic auth (optional)
- * @password: password for basic auth (optional)
- *
- * Request authentication token from the specified auth server URL using
- * basic authentication if credentials are provided.
- *
- * Return: authentication header string on success, ERR_PTR on failure
- */
-static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
-					      const char *auth_url,
-					      const char *service,
-					      const char *repository,
-					      const char *username,
-					      const char *password)
+static char *ocierofs_get_auth_token_with_url(struct ocierofs_ctx *ctx,
+				      const char *auth_url,
+				      const char *service,
+				      const char *repository,
+				      const char *username,
+				      const char *password)
 {
-	struct erofs_oci_request req = {};
-	struct erofs_oci_response resp = {};
+	struct ocierofs_request req = {};
+	struct ocierofs_response resp = {};
 	json_object *root, *token_obj, *access_token_obj;
 	const char *token;
 	char *auth_header = NULL;
@@ -370,14 +393,14 @@ static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
 	}
 
 	if (username && password && *username) {
-		ret = ocierofs_curl_setup_basic_auth(oci->curl, username,
-						     password);
+		ret = ocierofs_curl_setup_basic_auth(ctx->net.curl, username,
+					     password);
 		if (ret)
 			goto out_url;
 	}
 
-	ret = ocierofs_request_perform(oci, &req, &resp);
-	ocierofs_curl_clear_auth(oci->curl);
+	ret = ocierofs_request_perform(ctx, &req, &resp);
+	ocierofs_curl_clear_auth(ctx);
 	if (ret)
 		goto out_url;
 
@@ -391,7 +414,7 @@ static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
 	if (!root) {
 		erofs_err("failed to parse auth response");
 		ret = -EINVAL;
-		goto out_url;
+		goto out_json;
 	}
 
 	if (!json_object_object_get_ex(root, "token", &token_obj) &&
@@ -416,16 +439,16 @@ static char *ocierofs_get_auth_token_with_url(struct erofs_oci *oci,
 out_json:
 	json_object_put(root);
 out_url:
-	free(req.url);
-	free(resp.data);
+	ocierofs_response_cleanup(&resp);
+	ocierofs_request_cleanup(&req);
 	return ret ? ERR_PTR(ret) : auth_header;
 }
 
-static char *ocierofs_discover_auth_endpoint(struct erofs_oci *oci,
-					     const char *registry,
-					     const char *repository)
+static char *ocierofs_discover_auth_endpoint(struct ocierofs_ctx *ctx,
+			     const char *registry,
+			     const char *repository)
 {
-	struct erofs_oci_response resp = {};
+	struct ocierofs_response resp = {};
 	char *realm = NULL;
 	char *service = NULL;
 	char *result = NULL;
@@ -434,20 +457,20 @@ static char *ocierofs_discover_auth_endpoint(struct erofs_oci *oci,
 	CURLcode res;
 	long http_code;
 
-	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+	api_registry = ocierofs_get_api_registry(registry);
 
 	if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
 	     api_registry, repository) < 0)
 		return NULL;
 
-	curl_easy_reset(oci->curl);
-	ocierofs_curl_setup_common_options(oci->curl);
+	curl_easy_reset(ctx->net.curl);
+	ocierofs_curl_setup_common_options(ctx->net.curl);
 
-	ocierofs_curl_setup_rq(oci->curl, test_url, OCIEROFS_HTTP_HEAD, NULL,
+	ocierofs_curl_setup_rq(ctx->net.curl, test_url, OCIEROFS_HTTP_HEAD, NULL,
 			       NULL, NULL, ocierofs_write_callback, &resp);
 
-	res = curl_easy_perform(oci->curl);
-	curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE, &http_code);
+	res = curl_easy_perform(ctx->net.curl);
+	curl_easy_getinfo(ctx->net.curl, CURLINFO_RESPONSE_CODE, &http_code);
 
 	if (res == CURLE_OK && (http_code == 401 || http_code == 403 ||
 	    http_code == 404) && resp.data) {
@@ -458,14 +481,14 @@ static char *ocierofs_discover_auth_endpoint(struct erofs_oci *oci,
 	}
 	free(realm);
 	free(service);
-	free(resp.data);
+	ocierofs_response_cleanup(&resp);
 	free(test_url);
 	return result;
 }
 
-static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry,
-				     const char *repository, const char *username,
-				     const char *password)
+static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *registry,
+			     const char *repository, const char *username,
+			     const char *password)
 {
 	static const char * const auth_patterns[] = {
 		"https://%s/v2/auth",
@@ -484,35 +507,35 @@ static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry
 		!strcmp(registry, DOCKER_REGISTRY);
 	if (docker_reg) {
 		service = "registry.docker.io";
-		auth_header = ocierofs_get_auth_token_with_url(oci,
+		auth_header = ocierofs_get_auth_token_with_url(ctx,
 				"https://auth.docker.io/token", service, repository,
 				username, password);
 		if (!IS_ERR(auth_header))
 			return auth_header;
 	}
 
-	discovered_auth_url = ocierofs_discover_auth_endpoint(oci, registry, repository);
+	discovered_auth_url = ocierofs_discover_auth_endpoint(ctx, registry, repository);
 	if (discovered_auth_url) {
 		const char *api_registry, *auth_service;
-		struct erofs_oci_response resp = {};
+		struct ocierofs_response resp = {};
 		char *test_url;
 		CURLcode res;
 		long http_code;
 
-		api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+		api_registry = ocierofs_get_api_registry(registry);
 
 		if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
 		     api_registry, repository) >= 0) {
-			curl_easy_reset(oci->curl);
-			ocierofs_curl_setup_common_options(oci->curl);
+			curl_easy_reset(ctx->net.curl);
+			ocierofs_curl_setup_common_options(ctx->net.curl);
 
-			ocierofs_curl_setup_rq(oci->curl, test_url,
-					       OCIEROFS_HTTP_HEAD, NULL,
-					       NULL, NULL,
-					       ocierofs_write_callback, &resp);
+			ocierofs_curl_setup_rq(ctx->net.curl, test_url,
+				       OCIEROFS_HTTP_HEAD, NULL,
+				       NULL, NULL,
+				       ocierofs_write_callback, &resp);
 
-			res = curl_easy_perform(oci->curl);
-			curl_easy_getinfo(oci->curl, CURLINFO_RESPONSE_CODE, &http_code);
+			res = curl_easy_perform(ctx->net.curl);
+			curl_easy_getinfo(ctx->net.curl, CURLINFO_RESPONSE_CODE, &http_code);
 
 			if (res == CURLE_OK && (http_code == 401 || http_code == 403 ||
 			    http_code == 404) && resp.data) {
@@ -521,14 +544,14 @@ static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry
 				ocierofs_extract_www_auth_info(resp.data, &realm, &discovered_service, NULL);
 				free(realm);
 			}
-			free(resp.data);
+			ocierofs_response_cleanup(&resp);
 			free(test_url);
 		}
 
 		auth_service = discovered_service ? discovered_service : service;
-		auth_header = ocierofs_get_auth_token_with_url(oci, discovered_auth_url,
-							       auth_service, repository,
-							       username, password);
+		auth_header = ocierofs_get_auth_token_with_url(ctx, discovered_auth_url,
+				       auth_service, repository,
+				       username, password);
 		free(discovered_auth_url);
 		free(discovered_service);
 		if (!IS_ERR(auth_header))
@@ -541,9 +564,9 @@ static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry
 		if (asprintf(&auth_url, auth_patterns[i], registry) < 0)
 			continue;
 
-		auth_header = ocierofs_get_auth_token_with_url(oci, auth_url,
-							       service, repository,
-							       username, password);
+		auth_header = ocierofs_get_auth_token_with_url(ctx, auth_url,
+				       service, repository,
+				       username, password);
 		free(auth_url);
 
 		if (!IS_ERR(auth_header))
@@ -554,24 +577,24 @@ static char *ocierofs_get_auth_token(struct erofs_oci *oci, const char *registry
 	return ERR_PTR(-ENOENT);
 }
 
-static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
-					  const char *registry,
-					  const char *repository, const char *tag,
-					  const char *platform,
-					  const char *auth_header)
+static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
+				  const char *registry,
+				  const char *repository, const char *tag,
+				  const char *platform,
+				  const char *auth_header)
 {
-	struct erofs_oci_request req = {};
-	struct erofs_oci_response resp = {};
+	struct ocierofs_request req = {};
+	struct ocierofs_response resp = {};
 	json_object *root, *manifests, *manifest, *platform_obj, *arch_obj;
 	json_object *os_obj, *digest_obj, *schema_obj, *media_type_obj;
 	char *digest = NULL;
 	const char *api_registry;
 	int ret = 0, len, i;
 
-	if (!registry || !repository || !tag || !platform)
+	if (!registry || !repository || !tag)
 		return ERR_PTR(-EINVAL);
 
-	api_registry = (!strcmp(registry, DOCKER_REGISTRY)) ? DOCKER_API_REGISTRY : registry;
+	api_registry = ocierofs_get_api_registry(registry);
 	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
 	     api_registry, repository, tag) < 0)
 		return ERR_PTR(-ENOMEM);
@@ -581,10 +604,10 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
 
 	req.headers = curl_slist_append(req.headers,
 		"Accept: " DOCKER_MEDIATYPE_MANIFEST_LIST ","
-		OCI_MEDIATYPE_INDEX "," DOCKER_MEDIATYPE_MANIFEST_V1 ","
-		DOCKER_MEDIATYPE_MANIFEST_V2);
+		OCI_MEDIATYPE_INDEX "," OCI_MEDIATYPE_MANIFEST ","
+		DOCKER_MEDIATYPE_MANIFEST_V1 "," DOCKER_MEDIATYPE_MANIFEST_V2);
 
-	ret = ocierofs_request_perform(oci, &req, &resp);
+	ret = ocierofs_request_perform(ctx, &req, &resp);
 	if (ret)
 		goto out;
 
@@ -612,8 +635,7 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
 	if (json_object_object_get_ex(root, "mediaType", &media_type_obj)) {
 		const char *media_type = json_object_get_string(media_type_obj);
 
-		if (!strcmp(media_type, DOCKER_MEDIATYPE_MANIFEST_V2) ||
-		    !strcmp(media_type, OCI_MEDIATYPE_MANIFEST)) {
+		if (ocierofs_is_manifest(media_type)) {
 			digest = strdup(tag);
 			ret = 0;
 			goto out_json;
@@ -631,9 +653,9 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
 		manifest = json_object_array_get_idx(manifests, i);
 
 		if (json_object_object_get_ex(manifest, "platform",
-					      &platform_obj) &&
+				      &platform_obj) &&
 		    json_object_object_get_ex(platform_obj, "architecture",
-					      &arch_obj) &&
+				      &arch_obj) &&
 		    json_object_object_get_ex(platform_obj, "os", &os_obj) &&
 		    json_object_object_get_ex(manifest, "digest", &digest_obj)) {
 			const char *arch = json_object_get_string(arch_obj);
@@ -655,34 +677,47 @@ static char *ocierofs_get_manifest_digest(struct erofs_oci *oci,
 out_json:
 	json_object_put(root);
 out:
-	free(resp.data);
-	if (req.headers)
-		curl_slist_free_all(req.headers);
-	free(req.url);
-
+	ocierofs_response_cleanup(&resp);
+	ocierofs_request_cleanup(&req);
 	return ret ? ERR_PTR(ret) : digest;
 }
 
-static char **ocierofs_get_layers_info(struct erofs_oci *oci,
-				       const char *registry,
-				       const char *repository,
-				       const char *digest,
-				       const char *auth_header,
-				       int *layer_count)
+static void ocierofs_free_layers_info(struct ocierofs_layer_info **layers, int count)
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
+static struct ocierofs_layer_info **ocierofs_fetch_layers_info(struct ocierofs_ctx *ctx,
+			       const char *registry,
+			       const char *repository,
+			       const char *digest,
+			       const char *auth_header,
+			       int *layer_count)
 {
-	struct erofs_oci_request req = {};
-	struct erofs_oci_response resp = {};
-	json_object *root, *layers, *layer, *digest_obj;
-	char **layers_info = NULL;
+	struct ocierofs_request req = {};
+	struct ocierofs_response resp = {};
+	json_object *root, *layers, *layer, *digest_obj, *media_type_obj, *size_obj;
+	struct ocierofs_layer_info **layers_info = NULL;
 	const char *api_registry;
-	int ret, len, i, j;
+	int ret, len, i;
 
 	if (!registry || !repository || !digest || !layer_count)
 		return ERR_PTR(-EINVAL);
 
 	*layer_count = 0;
-	api_registry = (!strcmp(registry, DOCKER_REGISTRY) ?
-			DOCKER_API_REGISTRY : registry);
+	api_registry = ocierofs_get_api_registry(registry);
 
 	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
 		     api_registry, repository, digest) < 0)
@@ -694,7 +729,7 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
 	req.headers = curl_slist_append(req.headers,
 			"Accept: " OCI_MEDIATYPE_MANIFEST "," DOCKER_MEDIATYPE_MANIFEST_V2);
 
-	ret = ocierofs_request_perform(oci, &req, &resp);
+	ret = ocierofs_request_perform(ctx, &req, &resp);
 	if (ret)
 		goto out;
 
@@ -725,7 +760,7 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
 		goto out_json;
 	}
 
-	layers_info = calloc(len, sizeof(char *));
+	layers_info = calloc(len, sizeof(*layers_info));
 	if (!layers_info) {
 		ret = -ENOMEM;
 		goto out_json;
@@ -740,329 +775,421 @@ static char **ocierofs_get_layers_info(struct erofs_oci *oci,
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
 	json_object_put(root);
-	free(resp.data);
-	if (req.headers)
-		curl_slist_free_all(req.headers);
-	free(req.url);
+	ocierofs_response_cleanup(&resp);
+	ocierofs_request_cleanup(&req);
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
-	free(resp.data);
-	if (req.headers)
-		curl_slist_free_all(req.headers);
-	free(req.url);
+	ocierofs_response_cleanup(&resp);
+	ocierofs_request_cleanup(&req);
 	return ERR_PTR(ret);
 }
 
-static int ocierofs_extract_layer(struct erofs_oci *oci, struct erofs_importer *importer,
-				  const char *digest, const char *auth_header)
+static int ocierofs_process_tar_stream(struct erofs_importer *importer, int fd)
 {
-	struct erofs_oci_request req = {};
-	struct erofs_oci_stream stream = {};
-	const char *api_registry;
-	long http_code;
+	struct erofs_tarfile tarfile = {};
 	int ret;
 
-	stream = (struct erofs_oci_stream) {
-		.digest = digest,
-		.blobfd = erofs_tmpfile(),
-	};
-	if (stream.blobfd < 0) {
-		erofs_err("failed to create temporary file for %s", digest);
-		return -errno;
-	}
-
-	api_registry = (!strcmp(oci->params.registry, DOCKER_REGISTRY)) ?
-		       DOCKER_API_REGISTRY : oci->params.registry;
-	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
-	     api_registry, oci->params.repository, digest) == -1) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	if (auth_header && strstr(auth_header, "Bearer"))
-		req.headers = curl_slist_append(req.headers, auth_header);
-
-	curl_easy_reset(oci->curl);
-
-	ret = ocierofs_curl_setup_common_options(oci->curl);
-	if (ret)
-		goto out;
-
-	ret = ocierofs_curl_setup_rq(oci->curl, req.url, OCIEROFS_HTTP_GET,
-				     req.headers,
-				     ocierofs_layer_write_callback,
-				     &stream, NULL, NULL);
-	if (ret)
-		goto out;
-
-	ret = ocierofs_curl_perform(oci->curl, &http_code);
-	if (ret)
-		goto out;
-
-	if (http_code < 200 || http_code >= 300) {
-		erofs_err("HTTP request failed with code %ld", http_code);
-		ret = -EIO;
-		goto out;
-	}
+	init_list_head(&tarfile.global.xattrs);
 
-	if (lseek(stream.blobfd, 0, SEEK_SET) < 0) {
-		erofs_err("failed to seek to beginning of temp file: %s",
-			  strerror(errno));
-		ret = -errno;
-		goto out;
-	}
-
-	memset(&stream.tarfile, 0, sizeof(stream.tarfile));
-	init_list_head(&stream.tarfile.global.xattrs);
-
-	ret = erofs_iostream_open(&stream.tarfile.ios, stream.blobfd,
-				  EROFS_IOS_DECODER_GZIP);
+	ret = erofs_iostream_open(&tarfile.ios, fd, EROFS_IOS_DECODER_GZIP);
 	if (ret) {
 		erofs_err("failed to initialize tar stream: %s",
 			  erofs_strerror(ret));
-		goto out;
+		return ret;
 	}
 
 	do {
-		ret = tarerofs_parse_tar(importer, &stream.tarfile);
+		ret = tarerofs_parse_tar(importer, &tarfile);
 		/* Continue parsing until end of archive */
 	} while (!ret);
-	erofs_iostream_close(&stream.tarfile.ios);
+	erofs_iostream_close(&tarfile.ios);
 
 	if (ret < 0 && ret != -ENODATA) {
 		erofs_err("failed to process tar stream: %s",
 			  erofs_strerror(ret));
-		goto out;
+		return ret;
 	}
-	ret = 0;
 
-out:
-	if (stream.blobfd >= 0)
-		close(stream.blobfd);
-	if (req.headers)
-		curl_slist_free_all(req.headers);
-	free(req.url);
-	return ret;
+	return 0;
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
+static int ocierofs_prepare_auth(struct ocierofs_ctx *ctx,
+			      const char *username,
+			      const char *password)
 {
 	char *auth_header = NULL;
-	char *manifest_digest = NULL;
-	char **layers = NULL;
-	int layer_count = 0;
-	int ret, i;
-
-	if (!importer || !oci)
-		return -EINVAL;
+	int ret = 0;
+
+	ctx->net.using_basic = false;
+	free(ctx->net.auth_header);
+	ctx->net.auth_header = NULL;
+
+	/* Try to get a Bearer token first (with credentials if provided) */
+	auth_header = ocierofs_get_auth_token(ctx,
+			      ctx->img.registry,
+			      ctx->img.repository,
+			      username, password);
+	if (!IS_ERR(auth_header)) {
+		ctx->net.auth_header = auth_header;
+		return 0;
+	}
 
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
+	/* If token failed but credentials are provided, fall back to Basic */
+	if (username && password && *username && *password) {
+		ret = ocierofs_curl_setup_basic_auth(ctx->net.curl,
+						    username, password);
+		if (ret)
+			return ret;
+		ctx->net.using_basic = true;
 	}
+	return 0;
+}
 
-	manifest_digest = ocierofs_get_manifest_digest(oci, oci->params.registry,
-						       oci->params.repository,
-						       oci->params.tag,
-						       oci->params.platform,
-						       auth_header);
-	if (IS_ERR(manifest_digest)) {
-		ret = PTR_ERR(manifest_digest);
+static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
+			       const struct ocierofs_config *config)
+{
+	int ret;
+
+	ret = ocierofs_prepare_auth(ctx, config ? config->username : NULL,
+				      config ? config->password : NULL);
+	if (ret)
+		return ret;
+
+	ctx->img.manifest_digest = ocierofs_get_manifest_digest(ctx, ctx->img.registry,
+					   ctx->img.repository,
+					   ctx->img.tag,
+					   ctx->img.platform,
+					   ctx->net.auth_header);
+	if (IS_ERR(ctx->img.manifest_digest)) {
+		ret = PTR_ERR(ctx->img.manifest_digest);
 		erofs_err("failed to get manifest digest: %s",
 			  erofs_strerror(ret));
+		ctx->img.manifest_digest = NULL;
 		goto out_auth;
 	}
 
-	layers = ocierofs_get_layers_info(oci, oci->params.registry,
-					  oci->params.repository,
-					  manifest_digest, auth_header,
-					  &layer_count);
-	if (IS_ERR(layers)) {
-		ret = PTR_ERR(layers);
+	ctx->img.layers = ocierofs_fetch_layers_info(ctx, ctx->img.registry,
+				       ctx->img.repository,
+				       ctx->img.manifest_digest, ctx->net.auth_header,
+				       &ctx->img.layer_count);
+	if (IS_ERR(ctx->img.layers)) {
+		ret = PTR_ERR(ctx->img.layers);
 		erofs_err("failed to get image layers: %s", erofs_strerror(ret));
+		ctx->img.layers = NULL;
 		goto out_manifest;
 	}
 
-	if (oci->params.layer_index >= 0) {
-		if (oci->params.layer_index >= layer_count) {
+	if (ctx->img.layer_index >= 0) {
+		if (ctx->img.layer_index >= ctx->img.layer_count) {
 			erofs_err("layer index %d exceeds available layers (%d)",
-				  oci->params.layer_index, layer_count);
+			  ctx->img.layer_index, ctx->img.layer_count);
 			ret = -EINVAL;
 			goto out_layers;
 		}
-		layer_count = 1;
-		i = oci->params.layer_index;
+		ctx->img.layer_count = 1;
 	} else {
-		i = 0;
+		ctx->img.layer_index = 0;
 	}
 
-	while (i < layer_count) {
-		char *trimmed = erofs_trim_for_progressinfo(layers[i],
-				sizeof("Extracting layer  ...") - 1);
-		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
-					  trimmed);
-		free(trimmed);
-		ret = ocierofs_extract_layer(oci, importer, layers[i],
-					     auth_header);
-		if (ret) {
-			erofs_err("failed to extract layer %d: %s", i,
-				  erofs_strerror(ret));
-			break;
-		}
-		i++;
-	}
+	return 0;
+
 out_layers:
-	for (i = 0; i < layer_count; i++)
-		free(layers[i]);
-	free(layers);
+	free(ctx->img.layers);
+	ctx->img.layers = NULL;
 out_manifest:
-	free(manifest_digest);
+	free(ctx->img.manifest_digest);
+	ctx->img.manifest_digest = NULL;
 out_auth:
-	free(auth_header);
-
-	if (oci->params.username && oci->params.password &&
-	    oci->params.username[0] && oci->params.password[0] &&
-	    !auth_header) {
-		ocierofs_curl_clear_auth(oci->curl);
-	}
-out:
+	free(ctx->net.auth_header);
+	ctx->net.auth_header = NULL;
+	if (ctx->net.using_basic)
+		ocierofs_curl_clear_auth(ctx);
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
-int ocierofs_init(struct erofs_oci *oci)
+static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
 {
-	if (!oci)
+	char *slash, *colon, *dot;
+	const char *repo_part;
+	size_t len;
+	char *tmp;
+
+	if (!ctx || !ref_str)
 		return -EINVAL;
 
-	*oci = (struct erofs_oci){};
-	oci->curl = curl_easy_init();
-	if (!oci->curl)
+	slash = strchr(ref_str, '/');
+	if (slash) {
+		dot = strchr(ref_str, '.');
+		if (dot && dot < slash) {
+			len = slash - ref_str;
+			tmp = strndup(ref_str, len);
+			if (!tmp)
+				return -ENOMEM;
+			free(ctx->img.registry);
+			ctx->img.registry = tmp;
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
+		tmp = strndup(repo_part, len);
+		if (!tmp)
+			return -ENOMEM;
+
+		if (!strchr(tmp, '/') &&
+		    (!strcmp(ctx->img.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(ctx->img.registry, DOCKER_REGISTRY))) {
+			char *full_repo;
+
+			if (asprintf(&full_repo, "library/%s", tmp) == -1) {
+				free(tmp);
+				return -ENOMEM;
+			}
+			free(tmp);
+			tmp = full_repo;
+		}
+		free(ctx->img.repository);
+		ctx->img.repository = tmp;
+
+		free(ctx->img.tag);
+		ctx->img.tag = strdup(colon + 1);
+		if (!ctx->img.tag)
+			return -ENOMEM;
+	} else {
+		tmp = strdup(repo_part);
+		if (!tmp)
+			return -ENOMEM;
+
+		if (!strchr(tmp, '/') &&
+		    (!strcmp(ctx->img.registry, DOCKER_API_REGISTRY) ||
+		     !strcmp(ctx->img.registry, DOCKER_REGISTRY))) {
+
+			char *full_repo;
+			if (asprintf(&full_repo, "library/%s", tmp) == -1) {
+				free(tmp);
+				return -ENOMEM;
+			}
+			free(tmp);
+			tmp = full_repo;
+		}
+		free(ctx->img.repository);
+		ctx->img.repository = tmp;
+	}
+	return 0;
+}
+
+int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
+{
+	int ret;
+
+	ctx->net.curl = curl_easy_init();
+	if (!ctx->net.curl)
 		return -EIO;
 
-	if (ocierofs_curl_setup_common_options(oci->curl)) {
-		ocierofs_cleanup(oci);
+	if (ocierofs_curl_setup_common_options(ctx->net.curl))
 		return -EIO;
-	}
 
-	if (erofs_oci_params_set_string(&oci->params.platform,
-				"linux/amd64") ||
-	    erofs_oci_params_set_string(&oci->params.registry,
-				DOCKER_API_REGISTRY) ||
-	    erofs_oci_params_set_string(&oci->params.tag, "latest")) {
-		ocierofs_cleanup(oci);
+	ctx->img.layer_index = -1;
+	ctx->img.registry = strdup("registry-1.docker.io");
+	ctx->img.tag = strdup("latest");
+	if (config && config->platform)
+		ctx->img.platform = strdup(config->platform);
+	else
+		ctx->img.platform = strdup("linux/amd64");
+	if (!ctx->img.registry || !ctx->img.tag || !ctx->img.platform)
 		return -ENOMEM;
-	}
-	oci->params.layer_index = -1; /* -1 means extract all layers */
+
+	if (config && config->layer_index >= 0)
+		ctx->img.layer_index = config->layer_index;
+
+	ret = ocierofs_parse_ref(ctx, config->image_ref);
+	if (ret)
+		return ret;
+
+	ret = ocierofs_prepare_layers(ctx, config);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-/**
- * ocierofs_cleanup - Clean up OCI client and free allocated resources
- * @oci: OCI client structure to clean up
- *
- * Clean up CURL handle, free all allocated string parameters, and
- * reset the OCI client structure to a clean state.
- */
-void ocierofs_cleanup(struct erofs_oci *oci)
+static int ocierofs_download_blob_to_fd(struct ocierofs_ctx *ctx,
+			     const char *digest,
+			     const char *auth_header,
+			     int outfd)
 {
-	if (!oci)
-		return;
+	struct ocierofs_request req = {};
+	struct ocierofs_stream stream = {};
+	const char *api_registry;
+	long http_code;
+	int ret;
+
+	stream = (struct ocierofs_stream) {
+		.digest = digest,
+		.blobfd = outfd,
+	};
 
-	if (oci->curl) {
-		curl_easy_cleanup(oci->curl);
-		oci->curl = NULL;
+	api_registry = ocierofs_get_api_registry(ctx->img.registry);
+	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
+	     api_registry, ctx->img.repository, digest) == -1)
+		return -ENOMEM;
+
+	if (auth_header && strstr(auth_header, "Bearer"))
+		req.headers = curl_slist_append(req.headers, auth_header);
+
+	curl_easy_reset(ctx->net.curl);
+
+	ret = ocierofs_curl_setup_common_options(ctx->net.curl);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_setup_rq(ctx->net.curl, req.url, OCIEROFS_HTTP_GET,
+				     req.headers,
+				     ocierofs_layer_write_callback,
+				     &stream, NULL, NULL);
+	if (ret)
+		goto out;
+
+	ret = ocierofs_curl_perform(ctx->net.curl, &http_code);
+	if (ret)
+		goto out;
+
+	if (http_code < 200 || http_code >= 300) {
+		erofs_err("HTTP request failed with code %ld", http_code);
+		ret = -EIO;
+		goto out;
+	}
+	ret = 0;
+out:
+	ocierofs_request_cleanup(&req);
+	return ret;
+}
+
+static int ocierofs_extract_layer(struct ocierofs_ctx *ctx,
+			  const char *digest, const char *auth_header)
+{
+	struct ocierofs_stream stream = {};
+	int ret;
+
+	stream = (struct ocierofs_stream) {
+		.digest = digest,
+		.blobfd = erofs_tmpfile(),
+	};
+	if (stream.blobfd < 0) {
+		erofs_err("failed to create temporary file for %s", digest);
+		return -errno;
+	}
+
+	ret = ocierofs_download_blob_to_fd(ctx, digest, auth_header, stream.blobfd);
+	if (ret)
+		goto out;
+
+	if (lseek(stream.blobfd, 0, SEEK_SET) < 0) {
+		erofs_err("failed to seek to beginning of temp file: %s",
+			  strerror(errno));
+		ret = -errno;
+		goto out;
 	}
 
-	free(oci->params.registry);
-	free(oci->params.repository);
-	free(oci->params.tag);
-	free(oci->params.platform);
-	free(oci->params.username);
-	free(oci->params.password);
-
-	oci->params.registry = NULL;
-	oci->params.repository = NULL;
-	oci->params.tag = NULL;
-	oci->params.platform = NULL;
-	oci->params.username = NULL;
-	oci->params.password = NULL;
+	return stream.blobfd;
+
+out:
+	if (stream.blobfd >= 0)
+		close(stream.blobfd);
+	return ret;
 }
 
-int erofs_oci_params_set_string(char **field, const char *value)
+static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
 {
-	char *new_value;
+	if (!ctx)
+		return;
 
-	if (!field)
-		return -EINVAL;
+	if (ctx->net.curl) {
+		curl_easy_cleanup(ctx->net.curl);
+		ctx->net.curl = NULL;
+	}
+	free(ctx->net.auth_header);
+	ctx->net.auth_header = NULL;
+
+	ocierofs_free_layers_info(ctx->img.layers, ctx->img.layer_count);
+	free(ctx->img.registry);
+	free(ctx->img.repository);
+	free(ctx->img.tag);
+	free(ctx->img.platform);
+	free(ctx->img.manifest_digest);
+	memset(&ctx->img, 0, sizeof(ctx->img));
+}
 
-	if (!value) {
-		free(*field);
-		*field = NULL;
-		return 0;
+int ocierofs_build_trees(struct erofs_importer *importer,
+			 const struct ocierofs_config *config)
+{
+	struct ocierofs_ctx ctx = {};
+	int ret, i;
+
+	ret = ocierofs_init(&ctx, config);
+	if (ret) {
+		ocierofs_ctx_cleanup(&ctx);
+		return ret;
 	}
 
-	new_value = strdup(value);
-	if (!new_value)
-		return -ENOMEM;
+	i = ctx.img.layer_index;
+	while (i < ctx.img.layer_count) {
+		char *trimmed = erofs_trim_for_progressinfo(ctx.img.layers[i]->digest,
+				sizeof("Extracting layer  ...") - 1);
+		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
+				  trimmed);
+		free(trimmed);
+		int fd = ocierofs_extract_layer(&ctx, ctx.img.layers[i]->digest,
+				     ctx.net.auth_header);
+		if (fd < 0) {
+			erofs_err("failed to extract layer %d: %s", i,
+				  erofs_strerror(fd));
+			break;
+		}
+		ret = ocierofs_process_tar_stream(importer, fd);
+		close(fd);
+		if (ret) {
+			erofs_err("failed to process tar stream for layer %d: %s", i,
+				  erofs_strerror(ret));
+			break;
+		}
+		i++;
+	}
 
-	free(*field);
-	*field = new_value;
-	return 0;
+	ocierofs_ctx_cleanup(&ctx);
+	return ret;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index bc895f1..5e8da7a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -150,18 +150,18 @@ static void usage(int argc, char **argv)
 				 * "0-9,100-109" instead of a continuous "0-109", and to
 				 * state what those two subranges respectively mean.  */
 				printf("%s  [,level=<0-9,100-109>]\t0-9=normal, 100-109=extreme (default=%i)\n",
-				       spaces, s->c->default_level);
+			       spaces, s->c->default_level);
 			else
 				printf("%s  [,level=<0-%i>]\t\t(default=%i)\n",
-				       spaces, s->c->best_level, s->c->default_level);
+			       spaces, s->c->best_level, s->c->default_level);
 		}
 		if (s->c->setdictsize) {
 			if (s->c->default_dictsize)
 				printf("%s  [,dictsize=<dictsize>]\t(default=%u, max=%u)\n",
-				       spaces, s->c->default_dictsize, s->c->max_dictsize);
+			       spaces, s->c->default_dictsize, s->c->max_dictsize);
 			else
 				printf("%s  [,dictsize=<dictsize>]\t(default=<auto>, max=%u)\n",
-				       spaces, s->c->max_dictsize);
+			       spaces, s->c->max_dictsize);
 		}
 	}
 	printf(
@@ -272,7 +272,7 @@ static struct erofs_s3 s3cfg;
 #endif
 
 #ifdef OCIEROFS_ENABLED
-static struct erofs_oci ocicfg;
+static struct ocierofs_config ocicfg;
 static char *mkfs_oci_options;
 #endif
 
@@ -689,21 +689,14 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 #endif
 
 #ifdef OCIEROFS_ENABLED
-
-
-/**
- * mkfs_parse_oci_options - Parse comma-separated OCI options string
+/*
+ * mkfs_parse_oci_options - Parse OCI options for mkfs tool
+ * @cfg: OCI configuration structure to update
  * @options_str: comma-separated options string
- *
- * Parse OCI options string containing comma-separated key=value pairs.
- * Supported options include platform, layer, username, and password.
- *
- * Return: 0 on success, negative errno on failure
  */
-static int mkfs_parse_oci_options(char *options_str)
+static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options_str)
 {
 	char *opt, *q, *p;
-	int ret;
 
 	if (!options_str)
 		return 0;
@@ -717,41 +710,38 @@ static int mkfs_parse_oci_options(char *options_str)
 		p = strstr(opt, "platform=");
 		if (p) {
 			p += strlen("platform=");
-			ret = erofs_oci_params_set_string(&ocicfg.params.platform, p);
-			if (ret) {
-				erofs_err("failed to set platform");
-				return ret;
-			}
+			free(oci_cfg->platform);
+			oci_cfg->platform = strdup(p);
+			if (!oci_cfg->platform)
+				return -ENOMEM;
 		} else {
 			p = strstr(opt, "layer=");
 			if (p) {
 				p += strlen("layer=");
-				ocicfg.params.layer_index = atoi(p);
-				if (ocicfg.params.layer_index < 0) {
+				oci_cfg->layer_index = atoi(p);
+				if (oci_cfg->layer_index < 0) {
 					erofs_err("invalid layer index %d",
-						  ocicfg.params.layer_index);
+					  oci_cfg->layer_index);
 					return -EINVAL;
 				}
 			} else {
 				p = strstr(opt, "username=");
 				if (p) {
 					p += strlen("username=");
-					ret = erofs_oci_params_set_string(&ocicfg.params.username, p);
-					if (ret) {
-						erofs_err("failed to set username");
-						return ret;
-					}
+					free(oci_cfg->username);
+					oci_cfg->username = strdup(p);
+					if (!oci_cfg->username)
+						return -ENOMEM;
 				} else {
 					p = strstr(opt, "password=");
 					if (p) {
 						p += strlen("password=");
-						ret = erofs_oci_params_set_string(&ocicfg.params.password, p);
-						if (ret) {
-							erofs_err("failed to set password");
-							return ret;
-						}
+											free(oci_cfg->password);
+					oci_cfg->password = strdup(p);
+					if (!oci_cfg->password)
+						return -ENOMEM;
 					} else {
-						erofs_err("invalid --oci value %s", opt);
+						erofs_err("mkfs: invalid --oci value %s", opt);
 						return -EINVAL;
 					}
 				}
@@ -763,125 +753,6 @@ static int mkfs_parse_oci_options(char *options_str)
 
 	return 0;
 }
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
 #endif
 
 static int mkfs_parse_one_compress_alg(char *alg,
@@ -1951,16 +1822,12 @@ int main(int argc, char **argv)
 #endif
 #ifdef OCIEROFS_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
-			err = ocierofs_init(&ocicfg);
-			if (err)
-				goto exit;
+			ocicfg.layer_index = -1;
 
-			err = mkfs_parse_oci_options(mkfs_oci_options);
-			if (err)
-				goto exit;
-			err = mkfs_parse_oci_ref(cfg.c_src_path);
+			err = mkfs_parse_oci_options(&ocicfg, mkfs_oci_options);
 			if (err)
 				goto exit;
+			ocicfg.image_ref = cfg.c_src_path;
 
 			if (incremental_mode ||
 			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP ||
@@ -2035,9 +1902,6 @@ exit:
 		erofs_blob_exit();
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
-#ifdef OCIEROFS_ENABLED
-	ocierofs_cleanup(&ocicfg);
-#endif
 	erofs_diskbuf_exit();
 	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
 		erofs_iostream_close(&erofstar.ios);
-- 
2.51.0


