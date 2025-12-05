Return-Path: <linux-erofs+bounces-1486-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF93CCA72E2
	for <lists+linux-erofs@lfdr.de>; Fri, 05 Dec 2025 11:34:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dN76Q1pb4z2xrM;
	Fri, 05 Dec 2025 21:34:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764930878;
	cv=none; b=BwCKLd793HhCuVegTEclyGyUjHL1xAvVrcKrvBvVmr6LF+witAy6df/bXuZdcm9kMyPU3jsJn7gNPMvgylAqtVawp6wCE3lX+ECiMTHHIT47VgfCYv52i0n6GdV5EnqLkBxx7Ag7e3jpUzOq1SaHUL+zEj8NnC9Cwp9zTw3huLMXfoQnWDZn8LkY88Lp6jgH8w2aPS6mHsopJTBDhXzjTkIMhS3ksIuDcJ27wn08LLs142XG3VwLJnDEqqdhimQswYZA+x9ofXM6vSJ5iAT76ylvYWvJnt0AGLppUkevPNeIKDGMMQIO1VX6fYkx9zXhN92zNoJDQWXbG6HxzBx9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764930878; c=relaxed/relaxed;
	bh=00R3UXkOw1DeiRJMpAb17Wwdd9R7oF/oLnu+nYeSpU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHQbW/KlUcDc5TS37x/3wMzkHWSMl3CNqt3m4VCX1lyce7htogpBM/6F7mFeDcMcC/lFnM4Ewo5IQZZM4UhEKT0B39cN856vkHh4YQejcNxJGrYjFbZs8+YuZv/m9f/dA+n3S+ZqdX4TJv9PcbNW/Vv1VrW9PvtkzfGcawOkg9Me0MbfBlsqhhxTy7wW2jcZAYV/kFx/a2G11Bxab55tiZ/lj2t5I//IPfWPENS+MKknwgf1AbrHG1Bj3/csFg2Bul2w6yUVFNBaM7PgosE3gvALEVrSRQVMGYjeW5OPSMqyapq2Zl0FdpKT364UHI/zgauSZPZI9A9vc//jxnoLGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=pP/eywZA; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=pP/eywZA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dN76L6zlQz2xP8
	for <linux-erofs@lists.ozlabs.org>; Fri, 05 Dec 2025 21:34:33 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=00R3UXkOw1DeiRJMpAb17Wwdd9R7oF/oLnu+nYeSpU0=;
	b=pP/eywZAJ9aO4P/Jro4JWZEOUeq+YbP7saF8o/oBhlQ9QMrixhagZSiydXarQlcr+8fNf0XkL
	1Qm7ucpKn7rPc0yU2NxQfIKTcbTXuMvJUiiY/aEUlJMLTAOiAJJhNSPLP2CiEkY0SsMOXPToYT9
	o2dIO+9OD8kvnZVHZ6KAHys=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dN73x57kDz1cyPG;
	Fri,  5 Dec 2025 18:32:29 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 77B681A016C;
	Fri,  5 Dec 2025 18:34:23 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 5 Dec
 2025 18:34:22 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v2 2/2] erofs-utils: lib: oci: allow HTTP connections to registry
Date: Fri, 5 Dec 2025 18:33:22 +0800
Message-ID: <20251205103322.82638-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104257.877660-2-zhaoyifan28@huawei.com>
References: <20251130104257.877660-2-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, the URL used to send requests to the registry is hardcoded
with "https://". This patch introduces an optional insecure option for
oci in {mkfs,mount}.erofs, enabling registry access via the HTTP
protocol.

Also, this patch refactors the deeply nested logic in the `--oci`
argument parsing in both {mkfs,mount}/main.c.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
diff against v1:
- also add oci.insecure option in mount.erofs

 lib/liberofs_oci.h |   3 ++
 lib/remotes/oci.c  |  40 ++++++++++-------
 mkfs/main.c        |  97 ++++++++++++++++++----------------------
 mount/main.c       | 107 +++++++++++++++++++--------------------------
 4 files changed, 115 insertions(+), 132 deletions(-)

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
diff --git a/mount/main.c b/mount/main.c
index e25134c..b28b8ba 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -88,8 +88,7 @@ static int erofsmount_parse_oci_option(const char *option)
 	char *p;
 	long idx;
 
-	p = strstr(option, "oci.blob=");
-	if (p != NULL) {
+	if ((p = strstr(option, "oci.blob=")) != NULL) {
 		p += strlen("oci.blob=");
 		free(oci_cfg->blob_digest);
 
@@ -103,68 +102,52 @@ static int erofsmount_parse_oci_option(const char *option)
 			if (!oci_cfg->blob_digest)
 				return -ENOMEM;
 		} else if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
-				return -ENOMEM;
+			return -ENOMEM;
 		}
-	} else {
-		p = strstr(option, "oci.layer=");
-		if (p != NULL) {
-			p += strlen("oci.layer=");
-			if (oci_cfg->blob_digest) {
-				erofs_err("invalid options: oci.layer and oci.blob cannot be set together");
-				return -EINVAL;
-			}
-			idx = strtol(p, NULL, 10);
-			if (idx < 0)
-				return -EINVAL;
-			oci_cfg->layer_index = (int)idx;
-		} else {
-			p = strstr(option, "oci.platform=");
-			if (p != NULL) {
-				p += strlen("oci.platform=");
-				free(oci_cfg->platform);
-				oci_cfg->platform = strdup(p);
-				if (!oci_cfg->platform)
-					return -ENOMEM;
-			} else {
-				p = strstr(option, "oci.username=");
-				if (p != NULL) {
-					p += strlen("oci.username=");
-					free(oci_cfg->username);
-					oci_cfg->username = strdup(p);
-					if (!oci_cfg->username)
-						return -ENOMEM;
-				} else {
-					p = strstr(option, "oci.password=");
-					if (p != NULL) {
-						p += strlen("oci.password=");
-						free(oci_cfg->password);
-						oci_cfg->password = strdup(p);
-						if (!oci_cfg->password)
-							return -ENOMEM;
-					} else {
-						p = strstr(option, "oci.tarindex=");
-						if (p != NULL) {
-							p += strlen("oci.tarindex=");
-							free(oci_cfg->tarindex_path);
-							oci_cfg->tarindex_path = strdup(p);
-							if (!oci_cfg->tarindex_path)
-								return -ENOMEM;
-						} else {
-							p = strstr(option, "oci.zinfo=");
-							if (p != NULL) {
-								p += strlen("oci.zinfo=");
-								free(oci_cfg->zinfo_path);
-								oci_cfg->zinfo_path = strdup(p);
-								if (!oci_cfg->zinfo_path)
-									return -ENOMEM;
-							} else {
-								return -EINVAL;
-							}
-						}
-					}
-				}
-			}
+	} else if ((p = strstr(option, "oci.layer=")) != NULL) {
+		p += strlen("oci.layer=");
+		if (oci_cfg->blob_digest) {
+			erofs_err("invalid options: oci.layer and oci.blob cannot be set together");
+			return -EINVAL;
 		}
+		idx = strtol(p, NULL, 10);
+		if (idx < 0)
+			return -EINVAL;
+		oci_cfg->layer_index = (int)idx;
+	} else if ((p = strstr(option, "oci.platform=")) != NULL) {
+		p += strlen("oci.platform=");
+		free(oci_cfg->platform);
+		oci_cfg->platform = strdup(p);
+		if (!oci_cfg->platform)
+			return -ENOMEM;
+	} else if ((p = strstr(option, "oci.username=")) != NULL) {
+		p += strlen("oci.username=");
+		free(oci_cfg->username);
+		oci_cfg->username = strdup(p);
+		if (!oci_cfg->username)
+			return -ENOMEM;
+	} else if ((p = strstr(option, "oci.password=")) != NULL) {
+		p += strlen("oci.password=");
+		free(oci_cfg->password);
+		oci_cfg->password = strdup(p);
+		if (!oci_cfg->password)
+			return -ENOMEM;
+	} else if ((p = strstr(option, "oci.tarindex=")) != NULL) {
+		p += strlen("oci.tarindex=");
+		free(oci_cfg->tarindex_path);
+		oci_cfg->tarindex_path = strdup(p);
+		if (!oci_cfg->tarindex_path)
+			return -ENOMEM;
+	} else if ((p = strstr(option, "oci.zinfo=")) != NULL) {
+		p += strlen("oci.zinfo=");
+		free(oci_cfg->zinfo_path);
+		oci_cfg->zinfo_path = strdup(p);
+		if (!oci_cfg->zinfo_path)
+			return -ENOMEM;
+	} else if ((p = strstr(option, "oci.insecure")) != NULL) {
+		oci_cfg->insecure = true;
+	} else {
+		return -EINVAL;
 	}
 	return 0;
 }
-- 
2.43.0


