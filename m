Return-Path: <linux-erofs+bounces-1452-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 64321C94DE9
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Nov 2025 11:44:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dK3Yd5K1fz2yvV;
	Sun, 30 Nov 2025 21:44:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764499445;
	cv=none; b=n73W00n04oG5Aw2+f3/XH6GjndD0BzYpbtW/ishFxO+B+IcdD8LklD9/hT24/KdMP6o9iXB5U1sdGsMxoBUHBEUbEE/UfXtlXUqTh/R0R38YdPNacFXo95X9IvyDCw5vBSjKRPf+PzqxOmZ5pvDEIjuLi7EG2XVLHNzs4h50xwbkbjirWKXlYQaCRnfygM0+K2CptuHQ2r5oFZ4FQCfbFkQTnWDKV50JSXuLqpHUsGa5rtYf6ElmxABzOrWtau8aiENbfcUsZCj0QoPN7byVBZ2kPN45xo39q7agIDCofCwK0NooL2sE0SFrcfPwDlSLVR6f3X2d31tFaIhp88UPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764499445; c=relaxed/relaxed;
	bh=FrI2SxwNVoEwTDC6bmB2bdcY8GXdz+yKR+7sxSyn5Uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDSkXAFp6TTG66D+XDFY2E1+J4ZSUhqwZwUrq5ugdQe5TzQN7/iTNTkamUQIn6hCw1bFN8dx51bZVEz5F3t66J7vQHQMVlrk86kTiYUHfiQl4GzrGRWpqT2Cbet8Rr3don8W83k4DZZFZkDrq5jbRq8IQdbQDUV4zo77AJgPNv5kofLT+vHwSPG6Yj0n2499snoi8FoMQFFNHB9a3qmmkkOkkyIz9FidIikNfz/IvekJyoH/MLlI1iBUBU4V5z511frC4pzoprMqLs1zVsTMAyUSovECvF/mBi/KY+75kp72y8BX1U1Or1X0dYdE6pdWTqzm7wncVhRzpaZT+OhqPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TaazzUep; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TaazzUep;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dK3YZ0zdXz2yvL
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Nov 2025 21:44:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FrI2SxwNVoEwTDC6bmB2bdcY8GXdz+yKR+7sxSyn5Uc=;
	b=TaazzUeprAeNa1MNgCnqSW6WfhnNN4XxMEjpkTMMyUtDG3xDMOh5HhzM2JzmBPXUVE46KSllj
	6Es+WssYKQoZkaS/UWGjwbCsFvaXkkuzUBPWDXeTz1rJ+3/V10iLyRFXIgEOOUKd21grcRIY8ZE
	k2Xa5ooIxhKXgIUXT8WO00Q=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dK3WG3P4RzLlTG;
	Sun, 30 Nov 2025 18:42:02 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D2B2140279;
	Sun, 30 Nov 2025 18:43:52 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sun, 30 Nov
 2025 18:43:51 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudsonzhu@tencent.com>,
	<wayne.ma@huawei.com>, <jingrui@huawei.com>
Subject: [PATCH 2/2] erofs-utils: lib: oci: allow HTTP connections to registry
Date: Sun, 30 Nov 2025 18:42:57 +0800
Message-ID: <20251130104257.877660-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104257.877660-1-zhaoyifan28@huawei.com>
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
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
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, the URL used to send requests to the registry is hardcoded
with "https://". This patch introduces an optional insecure option for
`--oci`, enabling registry access via the HTTP protocol.

Also, this patch refactors the deeply nested logic in the `--oci`
argument parsing.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/liberofs_oci.h |  3 ++
 lib/remotes/oci.c  | 40 +++++++++++--------
 mkfs/main.c        | 97 ++++++++++++++++++++--------------------------
 3 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 5298f18..9e0571f 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -23,6 +23,7 @@ struct erofs_importer;
  * @password: password for authentication (optional)
  * @blob_digest: specific blob digest to extract (NULL for all layers)
  * @layer_index: specific layer index to extract (negative for all layers)
+ * @insecure: use HTTP for registry communication (optional)
  *
  * Configuration structure for OCI image parameters including registry
  * location, image identification, platform specification, and authentication
@@ -37,6 +38,7 @@ struct ocierofs_config {
 	int layer_index;
 	char *tarindex_path;
 	char *zinfo_path;
+	bool insecure;
 };
 
 struct ocierofs_layer_info {
@@ -57,6 +59,7 @@ struct ocierofs_ctx {
 	struct ocierofs_layer_info **layers;
 	char *blob_digest;
 	int layer_count;
+	const char *schema;
 };
 
 struct ocierofs_iostream {
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index c1d6cae..d5afd6a 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -496,8 +496,8 @@ static char *ocierofs_discover_auth_endpoint(struct ocierofs_ctx *ctx,
 
 	api_registry = ocierofs_get_api_registry(registry);
 
-	if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
-	     api_registry, repository) < 0)
+	if (asprintf(&test_url, "%s%s/v2/%s/manifests/nonexistent",
+	     ctx->schema, api_registry, repository) < 0)
 		return NULL;
 
 	curl_easy_reset(ctx->curl);
@@ -528,9 +528,9 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
 				     const char *password)
 {
 	static const char * const auth_patterns[] = {
-		"https://%s/v2/auth",
-		"https://auth.%s/token",
-		"https://%s/token",
+		"%s%s/v2/auth",
+		"%sauth.%s/token",
+		"%s%s/token",
 		NULL,
 	};
 	char *auth_header = NULL;
@@ -561,8 +561,8 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
 
 		api_registry = ocierofs_get_api_registry(registry);
 
-		if (asprintf(&test_url, "https://%s/v2/%s/manifests/nonexistent",
-		     api_registry, repository) >= 0) {
+		if (asprintf(&test_url, "%s%s/v2/%s/manifests/nonexistent",
+		     ctx->schema, api_registry, repository) >= 0) {
 			curl_easy_reset(ctx->curl);
 			ocierofs_curl_setup_common_options(ctx->curl);
 
@@ -598,7 +598,7 @@ static char *ocierofs_get_auth_token(struct ocierofs_ctx *ctx, const char *regis
 	for (i = 0; auth_patterns[i]; i++) {
 		char *auth_url;
 
-		if (asprintf(&auth_url, auth_patterns[i], registry) < 0)
+		if (asprintf(&auth_url, auth_patterns[i], ctx->schema, registry) < 0)
 			continue;
 
 		auth_header = ocierofs_get_auth_token_with_url(ctx, auth_url,
@@ -629,8 +629,8 @@ static char *ocierofs_get_manifest_digest(struct ocierofs_ctx *ctx,
 	int ret = 0, len, i;
 
 	api_registry = ocierofs_get_api_registry(registry);
-	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
-	     api_registry, repository, tag) < 0)
+	if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
+	     ctx->schema, api_registry, repository, tag) < 0)
 		return ERR_PTR(-ENOMEM);
 
 	if (auth_header && strstr(auth_header, "Bearer"))
@@ -749,8 +749,8 @@ static int ocierofs_fetch_layers_info(struct ocierofs_ctx *ctx)
 	ctx->layer_count = 0;
 	api_registry = ocierofs_get_api_registry(registry);
 
-	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
-		     api_registry, repository, digest) < 0)
+	if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
+		     ctx->schema, api_registry, repository, digest) < 0)
 		return -ENOMEM;
 
 	if (auth_header && strstr(auth_header, "Bearer"))
@@ -1124,10 +1124,18 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
 	if (!ctx->registry || !ctx->tag || !ctx->platform)
 		return -ENOMEM;
 
+	ctx->schema = config->insecure ? "http://" : "https://";
+
 	ret = ocierofs_parse_ref(ctx, config->image_ref);
 	if (ret)
 		return ret;
 
+	if (config->insecure && (!strcmp(ctx->registry, DOCKER_API_REGISTRY) ||
+				 !strcmp(ctx->registry, DOCKER_REGISTRY))) {
+		erofs_err("Insecure connection to Docker registry is not allowed");
+		return -EINVAL;
+	}
+
 	ret = ocierofs_prepare_layers(ctx, config);
 	if (ret)
 		return ret;
@@ -1152,8 +1160,8 @@ static int ocierofs_download_blob_to_fd(struct ocierofs_ctx *ctx,
 	};
 
 	api_registry = ocierofs_get_api_registry(ctx->registry);
-	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
-	     api_registry, ctx->repository, digest) == -1)
+	if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
+	     ctx->schema, api_registry, ctx->repository, digest) == -1)
 		return -ENOMEM;
 
 	if (auth_header && strstr(auth_header, "Bearer"))
@@ -1344,8 +1352,8 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
 		length = (size_t)(blob_size - offset);
 
 	api_registry = ocierofs_get_api_registry(ctx->registry);
-	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
-	     api_registry, ctx->repository, digest) == -1)
+	if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
+	     ctx->schema, api_registry, ctx->repository, digest) == -1)
 		return -ENOMEM;
 
 	if (length)
diff --git a/mkfs/main.c b/mkfs/main.c
index 7aa8eae..5710948 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -218,11 +218,12 @@ static void usage(int argc, char **argv)
 #endif
 #ifdef OCIEROFS_ENABLED
 		" --oci=[f|i]           generate a full (f) or index-only (i) image from OCI remote source\n"
-		"   [,=platform=X]      X=platform (default: linux/amd64)\n"
+		"   [,platform=X]       X=platform (default: linux/amd64)\n"
 		"   [,layer=#]          #=layer index to extract (0-based; omit to extract all layers)\n"
 		"   [,blob=Y]           Y=blob digest to extract (omit to extract all layers)\n"
 		"   [,username=Z]       Z=username for authentication (optional)\n"
 		"   [,password=W]       W=password for authentication (optional)\n"
+		"   [,insecure]         use HTTP instead of HTTPS (optional)\n"
 #endif
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
@@ -744,7 +745,7 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
  * Parse OCI options string containing comma-separated key=value pairs.
  *
  * Supported options include f|i, platform, blob|layer, username, password,
- * and zinfo.
+ * and insecure.
  *
  * Return: 0 on success, negative errno on failure
  */
@@ -772,67 +773,55 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 		if (q)
 			*q = '\0';
 
-
-		p = strstr(opt, "platform=");
-		if (p) {
+		if ((p = strstr(opt, "platform="))) {
 			p += strlen("platform=");
 			free(oci_cfg->platform);
 			oci_cfg->platform = strdup(p);
 			if (!oci_cfg->platform)
 				return -ENOMEM;
-		} else {
-			p = strstr(opt, "blob=");
-			if (p) {
-				p += strlen("blob=");
-				free(oci_cfg->blob_digest);
+		} else if ((p = strstr(opt, "blob="))) {
+			p += strlen("blob=");
+			free(oci_cfg->blob_digest);
 
-				if (oci_cfg->layer_index >= 0) {
-					erofs_err("invalid --oci: blob and layer cannot be set together");
-					return -EINVAL;
-				}
+			if (oci_cfg->layer_index >= 0) {
+				erofs_err("invalid --oci: blob and layer cannot be set together");
+				return -EINVAL;
+			}
 
-				if (!strncmp(p, "sha256:", 7)) {
-					oci_cfg->blob_digest = strdup(p);
-					if (!oci_cfg->blob_digest)
-						return -ENOMEM;
-				} else if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
+			if (!strncmp(p, "sha256:", 7)) {
+				oci_cfg->blob_digest = strdup(p);
+				if (!oci_cfg->blob_digest)
 					return -ENOMEM;
-				}
-			} else {
-				p = strstr(opt, "layer=");
-				if (p) {
-					p += strlen("layer=");
-					if (oci_cfg->blob_digest) {
-						erofs_err("invalid --oci: layer and blob cannot be set together");
-						return -EINVAL;
-					}
-					idx = strtol(p, NULL, 10);
-					if (idx < 0)
-						return -EINVAL;
-					oci_cfg->layer_index = (int)idx;
-				} else {
-					p = strstr(opt, "username=");
-					if (p) {
-						p += strlen("username=");
-						free(oci_cfg->username);
-						oci_cfg->username = strdup(p);
-						if (!oci_cfg->username)
-							return -ENOMEM;
-					} else {
-						p = strstr(opt, "password=");
-						if (p) {
-							p += strlen("password=");
-							free(oci_cfg->password);
-							oci_cfg->password = strdup(p);
-							if (!oci_cfg->password)
-								return -ENOMEM;
-						} else {
-							erofs_err("mkfs: invalid --oci value %s", opt);
-							return -EINVAL;
-						}
-					}
-				}
+			} else if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
+				return -ENOMEM;
 			}
+		} else if ((p = strstr(opt, "layer="))) {
+			p += strlen("layer=");
+			if (oci_cfg->blob_digest) {
+				erofs_err("invalid --oci: layer and blob cannot be set together");
+				return -EINVAL;
+			}
+			idx = strtol(p, NULL, 10);
+			if (idx < 0)
+				return -EINVAL;
+			oci_cfg->layer_index = (int)idx;
+		} else if ((p = strstr(opt, "username="))) {
+			p += strlen("username=");
+			free(oci_cfg->username);
+			oci_cfg->username = strdup(p);
+			if (!oci_cfg->username)
+				return -ENOMEM;
+		} else if ((p = strstr(opt, "password="))) {
+			p += strlen("password=");
+			free(oci_cfg->password);
+			oci_cfg->password = strdup(p);
+			if (!oci_cfg->password)
+				return -ENOMEM;
+		} else if ((p = strstr(opt, "insecure"))) {
+			oci_cfg->insecure = true;
+		} else {
+			erofs_err("mkfs: invalid --oci value %s", opt);
+			return -EINVAL;
 		}
 
 		opt = q ? q + 1 : NULL;
-- 
2.43.0


