Return-Path: <linux-erofs+bounces-1080-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C2B949FE
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 08:53:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW9fR54BYz2ysc;
	Tue, 23 Sep 2025 16:53:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758610383;
	cv=none; b=dFGzpJwFjQkwXJm4O1VYoOEkQG7Jiw1eLbWKS9lVbAkAy665LZ5MdIqAoK3vGI3JLU2S+G/hrBa3+WiP+Kpbo4kr5B06a+S/v3Ux9OnQcScJa3Bdn7W7dKrgGEYXmGtWu1nzvYLlD4hE7NuPVX6syxcx7+gu8lc2VJU9OKfTGQH8VL3y9GFC7JhNm0V2/nqAiqMWvmt/kSS8jT2S7zzupcSx5hb/KBi3DyXcl/tJZSnls0DcgWIxr+3aUcjmijucawoADtB06rwZAWjC4D3snWW40Sb1lZGKMmU6WdvmP9zWdTXLZhL1yfVqFg4ONkbGmNGbXanhKV1ebvjlbFQTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758610383; c=relaxed/relaxed;
	bh=x+oNy5CTOjS4CLNDVmlZGVYAYk56nx14Tp+ovc/RIaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2ORnxBDriU8/KU12TV+3Cg3O+xBBJMcabCNtLk6qsUDOh128wM5kWDfd+hp6h9JKzXnF8DswgZbTR5Iq0M5DGSSzREOb1F5lYqkvge4AgMgRRnE6F6x90nk7rWDpv7TknF42810fQZq1gRNt5j9fYIP3CCftLDDrzVDVF2dGR+dElWusYNgM5AMkHhLfq1yZaXSXVUynpBVtBWwnKZ5u1V6V3AuVrYDt18kN1Co5MMWm6pLu2U/sDapOFygMEQhtPVi0JHc/1iqEqgbBihL4XKjDfd/+DGpuH/qXBFTK+wtaMnyp5t11cXmeF3yf9qHbiop7S4NrYyejNn2Ujqq5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.87; helo=out28-87.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.87; helo=out28-87.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-87.mail.aliyun.com (out28-87.mail.aliyun.com [115.124.28.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW9fP4p1sz2yqg
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 16:52:59 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.elSQ3Fa_1758610372 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 14:52:52 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v6] erofs-utils: oci: add support for indexing by layer digest
Date: Tue, 23 Sep 2025 14:52:50 +0800
Message-ID: <20250923065250.94051-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916153415.93839-1-hudson@cyzhu.com>
References: <20250916153415.93839-1-hudson@cyzhu.com>
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

Add support for indexing by layer_digest string for more precise
and reliable OCI layer identification. This change affects both mkfs.erofs
and mount.erofs tools.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/liberofs_oci.h |   6 +-
 lib/remotes/oci.c  |  87 ++++++++++++++++------
 mkfs/main.c        |  76 ++++++++++++--------
 mount/main.c       | 175 +++++++++++++++++++++++++++++++++++----------
 4 files changed, 256 insertions(+), 88 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index aa41141..71c8879 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -21,7 +21,8 @@ struct erofs_importer;
  * @platform: target platform in "os/arch" format (e.g., "linux/amd64")
  * @username: username for authentication (optional)
  * @password: password for authentication (optional)
- * @layer_index: specific layer to extract (-1 for all layers)
+ * @blob_digest: specific blob digest to extract (NULL for all layers)
+ * @layer_index: specific layer index to extract (negative for all layers)
  *
  * Configuration structure for OCI image parameters including registry
  * location, image identification, platform specification, and authentication
@@ -32,6 +33,7 @@ struct ocierofs_config {
 	char *platform;
 	char *username;
 	char *password;
+	char *blob_digest;
 	int layer_index;
 };
 
@@ -51,7 +53,7 @@ struct ocierofs_ctx {
 	char *tag;
 	char *manifest_digest;
 	struct ocierofs_layer_info **layers;
-	int layer_index;
+	char *blob_digest;
 	int layer_count;
 };
 
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 26aec27..b2f1f59 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -898,6 +898,20 @@ static int ocierofs_prepare_auth(struct ocierofs_ctx *ctx,
 	return 0;
 }
 
+static int ocierofs_find_layer_by_digest(struct ocierofs_ctx *ctx, const char *digest)
+{
+	int i;
+
+	for (i = 0; i < ctx->layer_count; i++) {
+		DBG_BUGON(!ctx->layers[i]);
+		DBG_BUGON(!ctx->layers[i]->digest);
+
+		if (!strcmp(ctx->layers[i]->digest, digest))
+			return i;
+	}
+	return -1;
+}
+
 static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
 				   const struct ocierofs_config *config)
 {
@@ -925,16 +939,34 @@ static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
 		goto out_manifest;
 	}
 
-	if (ctx->layer_index >= ctx->layer_count) {
-		erofs_err("layer index %d exceeds available layers (%d)",
-			  ctx->layer_index, ctx->layer_count);
-		ret = -EINVAL;
-		goto out_layers;
+	if (!ctx->blob_digest && config->layer_index >= 0) {
+		if (config->layer_index >= ctx->layer_count) {
+			erofs_err("layer index %d out of range (0..%d)",
+				  config->layer_index, ctx->layer_count - 1);
+			ret = -EINVAL;
+			goto out_layers;
+		}
+		DBG_BUGON(!ctx->layers[config->layer_index]);
+		DBG_BUGON(!ctx->layers[config->layer_index]->digest);
+		ctx->blob_digest = strdup(ctx->layers[config->layer_index]->digest);
+		if (!ctx->blob_digest) {
+			ret = -ENOMEM;
+			goto out_layers;
+		}
+	}
+
+	if (ctx->blob_digest) {
+		if (ocierofs_find_layer_by_digest(ctx, ctx->blob_digest) < 0) {
+			erofs_err("layer digest %s not found in image layers",
+				  ctx->blob_digest);
+			ret = -ENOENT;
+			goto out_layers;
+		}
 	}
 	return 0;
 
 out_layers:
-	free(ctx->layers);
+	ocierofs_free_layers_info(ctx->layers, ctx->layer_count);
 	ctx->layers = NULL;
 out_manifest:
 	free(ctx->manifest_digest);
@@ -1054,10 +1086,10 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
 	if (ocierofs_curl_setup_common_options(ctx->curl))
 		return -EIO;
 
-	if (config->layer_index >= 0)
-		ctx->layer_index = config->layer_index;
+	if (config->blob_digest)
+		ctx->blob_digest = strdup(config->blob_digest);
 	else
-		ctx->layer_index = -1;
+		ctx->blob_digest = NULL;
 	ctx->registry = strdup("registry-1.docker.io");
 	ctx->tag = strdup("latest");
 	if (config->platform)
@@ -1190,6 +1222,7 @@ static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
 	free(ctx->tag);
 	free(ctx->platform);
 	free(ctx->manifest_digest);
+	free(ctx->blob_digest);
 }
 
 int ocierofs_build_trees(struct erofs_importer *importer,
@@ -1204,8 +1237,13 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 		return ret;
 	}
 
-	if (ctx.layer_index >= 0) {
-		i = ctx.layer_index;
+	if (ctx.blob_digest) {
+		i = ocierofs_find_layer_by_digest(&ctx, ctx.blob_digest);
+		if (i < 0) {
+			erofs_err("layer digest %s not found", ctx.blob_digest);
+			ret = -ENOENT;
+			goto out;
+		}
 		end = i + 1;
 	} else {
 		i = 0;
@@ -1215,25 +1253,26 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 	while (i < end) {
 		char *trimmed = erofs_trim_for_progressinfo(ctx.layers[i]->digest,
 				sizeof("Extracting layer  ...") - 1);
-		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
-				  trimmed);
+		erofs_update_progressinfo("Extracting layer %s ...", trimmed);
 		free(trimmed);
 		fd = ocierofs_extract_layer(&ctx, ctx.layers[i]->digest,
 					    ctx.auth_header);
 		if (fd < 0) {
-			erofs_err("failed to extract layer %d: %s", i,
-				  erofs_strerror(fd));
+			erofs_err("failed to extract layer %s: %s",
+				  ctx.layers[i]->digest, erofs_strerror(fd));
+			ret = fd;
 			break;
 		}
 		ret = ocierofs_process_tar_stream(importer, fd);
 		close(fd);
 		if (ret) {
-			erofs_err("failed to process tar stream for layer %d: %s", i,
-				  erofs_strerror(ret));
+			erofs_err("failed to process tar stream for layer %s: %s",
+				  ctx.layers[i]->digest, erofs_strerror(ret));
 			break;
 		}
 		i++;
 	}
+out:
 	ocierofs_ctx_cleanup(&ctx);
 	return ret;
 }
@@ -1246,12 +1285,18 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
 	const char *api_registry;
 	char rangehdr[64];
 	long http_code = 0;
-	int ret;
-	int index = ctx->layer_index;
-	u64 blob_size = ctx->layers[index]->size;
+	int ret, index;
+	const char *digest;
+	u64 blob_size;
 	size_t available;
 	size_t copy_size;
 
+	index = ocierofs_find_layer_by_digest(ctx, ctx->blob_digest);
+	if (index < 0)
+		return -ENOENT;
+	digest = ctx->blob_digest;
+	blob_size = ctx->layers[index]->size;
+
 	if (offset < 0)
 		return -EINVAL;
 
@@ -1265,7 +1310,7 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
 
 	api_registry = ocierofs_get_api_registry(ctx->registry);
 	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
-	     api_registry, ctx->repository, ctx->layers[index]->digest) == -1)
+	     api_registry, ctx->repository, digest) == -1)
 		return -ENOMEM;
 
 	if (length)
diff --git a/mkfs/main.c b/mkfs/main.c
index 50e2bdb..c8e0049 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -216,8 +216,9 @@ static void usage(int argc, char **argv)
 #ifdef OCIEROFS_ENABLED
 		" --oci[=platform=X]    X=platform (default: linux/amd64)\n"
 		"   [,layer=Y]          Y=layer index to extract (0-based; omit to extract all layers)\n"
-		"   [,username=Z]       Z=username for authentication (optional)\n"
-		"   [,password=W]       W=password for authentication (optional)\n"
+		"   [,blob=Z]           Z=blob digest to extract (omit to extract all layers)\n"
+		"   [,username=W]       W=username for authentication (optional)\n"
+		"   [,password=V]       V=password for authentication (optional)\n"
 #endif
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
@@ -707,13 +708,14 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
  * @options_str: comma-separated options string
  *
  * Parse OCI options string containing comma-separated key=value pairs.
- * Supported options include platform, layer, username, and password.
+ * Supported options include platform, blob, layer, username, and password.
  *
  * Return: 0 on success, negative errno on failure
  */
 static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options_str)
 {
 	char *opt, *q, *p;
+	long idx;
 
 	if (!options_str)
 		return 0;
@@ -732,40 +734,57 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 			if (!oci_cfg->platform)
 				return -ENOMEM;
 		} else {
-			p = strstr(opt, "layer=");
+			p = strstr(opt, "blob=");
 			if (p) {
-				p += strlen("layer=");
-				{
-					char *endptr;
-					unsigned long v = strtoul(p, &endptr, 10);
-
-					if (endptr == p || *endptr != '\0') {
-						erofs_err("invalid layer index %s",
-						  p);
-						return -EINVAL;
-					}
-					oci_cfg->layer_index = (int)v;
+				p += strlen("blob=");
+				free(oci_cfg->blob_digest);
+
+				if (oci_cfg->layer_index >= 0) {
+					erofs_err("invalid --oci: blob and layer cannot be set together");
+					return -EINVAL;
+				}
+
+				if (strncmp(p, "sha256:", 7) != 0) {
+					if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0)
+						return -ENOMEM;
+				} else {
+					oci_cfg->blob_digest = strdup(p);
+					if (!oci_cfg->blob_digest)
+						return -ENOMEM;
 				}
 			} else {
-				p = strstr(opt, "username=");
+				p = strstr(opt, "layer=");
 				if (p) {
-					p += strlen("username=");
-					free(oci_cfg->username);
-					oci_cfg->username = strdup(p);
-					if (!oci_cfg->username)
-						return -ENOMEM;
+					p += strlen("layer=");
+					if (oci_cfg->blob_digest) {
+						erofs_err("invalid --oci: layer and blob cannot be set together");
+						return -EINVAL;
+					}
+					idx = strtol(p, NULL, 10);
+					if (idx < 0)
+						return -EINVAL;
+					oci_cfg->layer_index = (int)idx;
 				} else {
+					p = strstr(opt, "username=");
+					if (p) {
+						p += strlen("username=");
+						free(oci_cfg->username);
+						oci_cfg->username = strdup(p);
+						if (!oci_cfg->username)
+							return -ENOMEM;
+					}
+
 					p = strstr(opt, "password=");
 					if (p) {
 						p += strlen("password=");
-					free(oci_cfg->password);
-					oci_cfg->password = strdup(p);
-					if (!oci_cfg->password)
-						return -ENOMEM;
-					} else {
-						erofs_err("mkfs: invalid --oci value %s", opt);
-						return -EINVAL;
+						free(oci_cfg->password);
+						oci_cfg->password = strdup(p);
+						if (!oci_cfg->password)
+							return -ENOMEM;
 					}
+
+					erofs_err("mkfs: invalid --oci value %s", opt);
+					return -EINVAL;
 				}
 			}
 		}
@@ -1850,6 +1869,7 @@ int main(int argc, char **argv)
 #endif
 #ifdef OCIEROFS_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
+			ocicfg.blob_digest = NULL;
 			ocicfg.layer_index = -1;
 
 			err = mkfs_parse_oci_options(&ocicfg, mkfs_oci_options);
diff --git a/mount/main.c b/mount/main.c
index f368746..726ec6c 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -81,51 +81,76 @@ static int erofsmount_parse_oci_option(const char *option)
 {
 	struct ocierofs_config *oci_cfg = &nbdsrc.ocicfg;
 	char *p;
+	long idx;
 
-	p = strstr(option, "oci.layer=");
+	if (oci_cfg->layer_index == 0 && !oci_cfg->blob_digest &&
+	    !oci_cfg->platform && !oci_cfg->username && !oci_cfg->password)
+		oci_cfg->layer_index = -1;
+
+	p = strstr(option, "oci.blob=");
 	if (p != NULL) {
-		p += strlen("oci.layer=");
-		{
-			char *endptr;
-			unsigned long v = strtoul(p, &endptr, 10);
+		p += strlen("oci.blob=");
+		free(oci_cfg->blob_digest);
 
-			if (endptr == p || *endptr != '\0')
-				return -EINVAL;
-			oci_cfg->layer_index = (int)v;
+		if (oci_cfg->layer_index >= 0) {
+			erofs_err("invalid options: oci.blob and oci.layer cannot be set together");
+			return -EINVAL;
+		}
+
+		if (strncmp(p, "sha256:", 7) != 0) {
+			if (asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0)
+				return -ENOMEM;
+		} else {
+			oci_cfg->blob_digest = strdup(p);
+			if (!oci_cfg->blob_digest)
+				return -ENOMEM;
 		}
 	} else {
-		p = strstr(option, "oci.platform=");
+		p = strstr(option, "oci.layer=");
 		if (p != NULL) {
-			p += strlen("oci.platform=");
-			free(oci_cfg->platform);
-			oci_cfg->platform = strdup(p);
-			if (!oci_cfg->platform)
-				return -ENOMEM;
+			p += strlen("oci.layer=");
+			if (oci_cfg->blob_digest) {
+				erofs_err("invalid options: oci.layer and oci.blob cannot be set together");
+				return -EINVAL;
+			}
+			idx = strtol(p, NULL, 10);
+			if (idx < 0)
+				return -EINVAL;
+			oci_cfg->layer_index = (int)idx;
 		} else {
-			p = strstr(option, "oci.username=");
+			p = strstr(option, "oci.platform=");
 			if (p != NULL) {
-				p += strlen("oci.username=");
-				free(oci_cfg->username);
-				oci_cfg->username = strdup(p);
-				if (!oci_cfg->username)
+				p += strlen("oci.platform=");
+				free(oci_cfg->platform);
+				oci_cfg->platform = strdup(p);
+				if (!oci_cfg->platform)
 					return -ENOMEM;
 			} else {
-				p = strstr(option, "oci.password=");
+				p = strstr(option, "oci.username=");
 				if (p != NULL) {
-					p += strlen("oci.password=");
-					free(oci_cfg->password);
-					oci_cfg->password = strdup(p);
-					if (!oci_cfg->password)
+					p += strlen("oci.username=");
+					free(oci_cfg->username);
+					oci_cfg->username = strdup(p);
+					if (!oci_cfg->username)
 						return -ENOMEM;
 				} else {
-					return -EINVAL;
+					p = strstr(option, "oci.password=");
+					if (p != NULL) {
+						p += strlen("oci.password=");
+						free(oci_cfg->password);
+						oci_cfg->password = strdup(p);
+						if (!oci_cfg->password)
+							return -ENOMEM;
+					} else {
+						return -EINVAL;
+					}
 				}
 			}
 		}
 	}
 
 	if (oci_cfg->platform || oci_cfg->username || oci_cfg->password ||
-	    oci_cfg->layer_index)
+	    oci_cfg->blob_digest || oci_cfg->layer_index >= 0)
 		nbdsrc.type = EROFSNBD_SOURCE_OCI;
 	return 0;
 }
@@ -215,6 +240,8 @@ static int erofsmount_parse_options(int argc, char **argv)
 	char *dot;
 	int opt;
 
+	nbdsrc.ocicfg.layer_index = -1;
+
 	while ((opt = getopt_long(argc, argv, "Nfno:st:uv",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
@@ -413,13 +440,29 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 		if (IS_ERR(b64cred))
 			return PTR_ERR(b64cred);
 	}
-	ret = fprintf(f, "OCI_LAYER %s %s %d %s\n",
-		       source->ocicfg.image_ref ?: "",
-		       source->ocicfg.platform ?: "",
-		       source->ocicfg.layer_index,
-		       b64cred ?: "");
+
+	if (source->ocicfg.blob_digest && *source->ocicfg.blob_digest) {
+		ret = fprintf(f, "OCI_NATIVE_BLOB %s %s %s %s\n",
+			      source->ocicfg.image_ref ?: "",
+			      source->ocicfg.platform ?: "",
+			      source->ocicfg.blob_digest,
+			      b64cred ?: "");
+		free(b64cred);
+		return ret < 0 ? -ENOMEM : 0;
+	}
+
+	if (source->ocicfg.layer_index >= 0) {
+		ret = fprintf(f, "OCI_LAYER %s %s %d %s\n",
+			      source->ocicfg.image_ref ?: "",
+			      source->ocicfg.platform ?: "",
+			      source->ocicfg.layer_index,
+			      b64cred ?: "");
+		free(b64cred);
+		return ret < 0 ? -ENOMEM : 0;
+	}
+
 	free(b64cred);
-	return ret < 0 ? -ENOMEM : 0;
+	return -EINVAL;
 }
 #else
 static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *source)
@@ -507,6 +550,8 @@ static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
 	if (endptr == tokens[1] || *endptr != '\0')
 		return -EINVAL;
 	oci_cfg->layer_index = (int)v;
+	free(oci_cfg->blob_digest);
+	oci_cfg->blob_digest = NULL;
 
 	if (token_count > 2) {
 		err = ocierofs_decode_userpass(tokens[2], &oci_cfg->username,
@@ -517,19 +562,75 @@ static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
 	return 0;
 }
 
-static int erofsmount_reattach_ocilayer(struct erofs_vfile *vf, char *source)
+static int erofsmount_parse_recovery_ociblob(struct ocierofs_config *oci_cfg,
+					    char *source)
+{
+	char *tokens[4] = {0};
+	int token_count = 0;
+	char *p = source;
+	int err;
+
+	while (token_count < 4 && (p = strchr(p, ' ')) != NULL) {
+		*p++ = '\0';
+		while (*p == ' ')
+			p++;
+		if (*p == '\0')
+			break;
+		tokens[token_count++] = p;
+	}
+
+	if (token_count < 2)
+		return -EINVAL;
+
+	oci_cfg->image_ref = source;
+	oci_cfg->platform = tokens[0];
+
+	{
+		const char *digest = tokens[1];
+		const char *hex;
+
+		if (!digest || strncmp(digest, "sha256:", 7) != 0)
+			return -EINVAL;
+		hex = digest + 7;
+		if (strlen(hex) != 64)
+			return -EINVAL;
+		free(oci_cfg->blob_digest);
+		oci_cfg->blob_digest = strdup(digest);
+		if (!oci_cfg->blob_digest)
+			return -ENOMEM;
+	}
+	oci_cfg->layer_index = -1;
+
+	if (token_count > 2) {
+		err = ocierofs_decode_userpass(tokens[2], &oci_cfg->username,
+			       &oci_cfg->password);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int erofsmount_reattach_oci(struct erofs_vfile *vf,
+				   const char *type, char *source)
 {
 	struct ocierofs_config oci_cfg = {};
 	int err;
 
-	err = erofsmount_parse_recovery_ocilayer(&oci_cfg, source);
+	if (!strcmp(type, "OCI_LAYER"))
+		err = erofsmount_parse_recovery_ocilayer(&oci_cfg, source);
+	else if (!strcmp(type, "OCI_NATIVE_BLOB"))
+		err = erofsmount_parse_recovery_ociblob(&oci_cfg, source);
+	else
+		return -EOPNOTSUPP;
+
 	if (err)
 		return err;
 
 	return ocierofs_io_open(vf, &oci_cfg);
 }
 #else
-static int erofsmount_reattach_ocilayer(struct erofs_vfile *vf, char *source)
+static int erofsmount_reattach_oci(struct erofs_vfile *vf,
+				   const char *type, char *source)
 {
 	return -EOPNOTSUPP;
 }
@@ -694,8 +795,8 @@ static int erofsmount_reattach(const char *target)
 			goto err_line;
 		}
 		ctx.vd.fd = err;
-	} else if (!strcmp(line, "OCI_LAYER")) {
-		err = erofsmount_reattach_ocilayer(&ctx.vd, source);
+	} else if (!strcmp(line, "OCI_LAYER") || !strcmp(line, "OCI_NATIVE_BLOB")) {
+		err = erofsmount_reattach_oci(&ctx.vd, line, source);
 		if (err)
 			goto err_line;
 	} else {
-- 
2.51.0


