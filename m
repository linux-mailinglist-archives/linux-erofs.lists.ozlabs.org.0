Return-Path: <linux-erofs+bounces-1038-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B98FB59C1E
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Sep 2025 17:34:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cR5YJ5XP7z300F;
	Wed, 17 Sep 2025 01:34:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.67
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758036868;
	cv=none; b=YpGqYag4S3IbCKS1LWA7/ygJdormu7aOXjmmD2Njd0YIUG25mUnLC8ZkH5Pnjk8Cg12KRcZKE3QZutwVM1tVqMC8IFj3QJdqBMdVdz9r0HYm2HlrDGlSfJcgKixe8yMiTT70W0Sr969Qk+uWFuiAC6t5ev+0xXnGsV+l7Hz6rbP6aIwqBSmdUCwcsRBB5YYfUzkcD2QoygfCfYdI6IwD8wTmXICZGR+FlQ3QDhkNIiP8O2g3NjnAbs/PedFm/+RFCcsdTMnAdYHuV/6PFgQmgfLLwK1mTnXNsY2cuhHruk+9EBP6duqQoV7RdqRhOx1OGXHypGkdhYGqWsopYS8POA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758036868; c=relaxed/relaxed;
	bh=MEt66bpKknIvB4LfezTFBVBmS18orDWZH2SDIP664XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXSt8Wlulsy29D0hKBqgTzUdyeJrPyEpDknrjHLlxtSGGNgiToUkHHLi1TNC9eXSFpVpEuxZpi+EITYQiWNy/XcSDT0A8HwOY4f80xaUk1tsTICGY6FIw4qeItEFKHUX1U0NNN9XdGhfcLWtDAS1LyUgRUSELp+aBJ2fbOdRYawiie6VAFuB8NzZOLINu5w1EMMHpA9iUN/aifDbsVOuHQWAH1AAaqzLK9S+UAZHqqPSdK9wgh6cl5p9umkEQby96THd7auu3vjnQwSLfyblr40a1SKUB9lLpuOnj32I1TgOXzI6VDlTvwoxGXagQqpQdiuzc0e+WT+4rGtgBoqp7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.67; helo=out28-67.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.67; helo=out28-67.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-67.mail.aliyun.com (out28-67.mail.aliyun.com [115.124.28.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cR5YH0N40z2yVP
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Sep 2025 01:34:24 +1000 (AEST)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.egUhTaL_1758036855 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 23:34:16 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v2] erofs-utils: oci: add support for indexing by layer digest
Date: Tue, 16 Sep 2025 23:34:15 +0800
Message-ID: <20250916153415.93839-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <06E91C03-951E-46B5-85C9-8F61F9BDE8EF@cyzhu.com>
References: <06E91C03-951E-46B5-85C9-8F61F9BDE8EF@cyzhu.com>
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
 lib/remotes/oci.c  |  89 +++++++++++++++++++------
 mkfs/main.c        |  75 +++++++++++++--------
 mount/main.c       | 160 +++++++++++++++++++++++++++++++++------------
 4 files changed, 240 insertions(+), 90 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index aa41141..621eb2b 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -21,7 +21,8 @@ struct erofs_importer;
  * @platform: target platform in "os/arch" format (e.g., "linux/amd64")
  * @username: username for authentication (optional)
  * @password: password for authentication (optional)
- * @layer_index: specific layer to extract (-1 for all layers)
+ * @layer_digest: specific layer digest to extract (NULL for all layers)
+ * @layer_index: specific layer index to extract (negative for all layers)
  *
  * Configuration structure for OCI image parameters including registry
  * location, image identification, platform specification, and authentication
@@ -32,6 +33,7 @@ struct ocierofs_config {
 	char *platform;
 	char *username;
 	char *password;
+	char *layer_digest;
 	int layer_index;
 };
 
@@ -51,7 +53,7 @@ struct ocierofs_ctx {
 	char *tag;
 	char *manifest_digest;
 	struct ocierofs_layer_info **layers;
-	int layer_index;
+	char *layer_digest;
 	int layer_count;
 };
 
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 26aec27..d22aa2e 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -898,6 +898,21 @@ static int ocierofs_prepare_auth(struct ocierofs_ctx *ctx,
 	return 0;
 }
 
+static int ocierofs_find_layer_by_digest(struct ocierofs_ctx *ctx, const char *digest)
+{
+	int i;
+
+	if (!digest || !ctx->layers)
+		return -1;
+
+	for (i = 0; i < ctx->layer_count; i++) {
+		if (ctx->layers[i] && ctx->layers[i]->digest &&
+		    !strcmp(ctx->layers[i]->digest, digest))
+			return i;
+	}
+	return -1;
+}
+
 static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
 				   const struct ocierofs_config *config)
 {
@@ -925,16 +940,35 @@ static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
 		goto out_manifest;
 	}
 
-	if (ctx->layer_index >= ctx->layer_count) {
-		erofs_err("layer index %d exceeds available layers (%d)",
-			  ctx->layer_index, ctx->layer_count);
-		ret = -EINVAL;
-		goto out_layers;
+	if (config->layer_index >= 0) {
+		if (config->layer_index >= ctx->layer_count) {
+			erofs_err("layer index %d out of range (0..%d)",
+				  config->layer_index, ctx->layer_count - 1);
+			ret = -EINVAL;
+			goto out_layers;
+		}
+		if (!ctx->layers[config->layer_index] ||
+		    !ctx->layers[config->layer_index]->digest) {
+			ret = -EINVAL;
+			goto out_layers;
+		}
+		ctx->layer_digest = strdup(ctx->layers[config->layer_index]->digest);
+		if (!ctx->layer_digest) {
+			ret = -ENOMEM;
+			goto out_layers;
+		}
+	} else if (ctx->layer_digest) {
+		if (ocierofs_find_layer_by_digest(ctx, ctx->layer_digest) < 0) {
+			erofs_err("layer digest %s not found in image layers",
+				  ctx->layer_digest);
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
@@ -1054,10 +1088,10 @@ static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config
 	if (ocierofs_curl_setup_common_options(ctx->curl))
 		return -EIO;
 
-	if (config->layer_index >= 0)
-		ctx->layer_index = config->layer_index;
+	if (config->layer_digest)
+		ctx->layer_digest = strdup(config->layer_digest);
 	else
-		ctx->layer_index = -1;
+		ctx->layer_digest = NULL;
 	ctx->registry = strdup("registry-1.docker.io");
 	ctx->tag = strdup("latest");
 	if (config->platform)
@@ -1190,6 +1224,7 @@ static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
 	free(ctx->tag);
 	free(ctx->platform);
 	free(ctx->manifest_digest);
+	free(ctx->layer_digest);
 }
 
 int ocierofs_build_trees(struct erofs_importer *importer,
@@ -1204,8 +1239,13 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 		return ret;
 	}
 
-	if (ctx.layer_index >= 0) {
-		i = ctx.layer_index;
+	if (ctx.layer_digest) {
+		i = ocierofs_find_layer_by_digest(&ctx, ctx.layer_digest);
+		if (i < 0) {
+			erofs_err("layer digest %s not found", ctx.layer_digest);
+			ret = -ENOENT;
+			goto out;
+		}
 		end = i + 1;
 	} else {
 		i = 0;
@@ -1215,25 +1255,26 @@ int ocierofs_build_trees(struct erofs_importer *importer,
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
@@ -1246,12 +1287,18 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
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
 
+	index = ocierofs_find_layer_by_digest(ctx, ctx->layer_digest);
+	if (index < 0)
+		return -ENOENT;
+	digest = ctx->layer_digest;
+	blob_size = ctx->layers[index]->size;
+
 	if (offset < 0)
 		return -EINVAL;
 
@@ -1265,7 +1312,7 @@ static int ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
 
 	api_registry = ocierofs_get_api_registry(ctx->registry);
 	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
-	     api_registry, ctx->repository, ctx->layers[index]->digest) == -1)
+	     api_registry, ctx->repository, digest) == -1)
 		return -ENOMEM;
 
 	if (length)
diff --git a/mkfs/main.c b/mkfs/main.c
index a8208d4..09d77d6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -213,7 +213,7 @@ static void usage(int argc, char **argv)
 #endif
 #ifdef OCIEROFS_ENABLED
 		" --oci[=platform=X]    X=platform (default: linux/amd64)\n"
-		"   [,layer=Y]          Y=layer index to extract (0-based; omit to extract all layers)\n"
+		"   [,layer=Y]          Y=layer digest to extract (omit to extract all layers)\n"
 		"   [,username=Z]       Z=username for authentication (optional)\n"
 		"   [,password=W]       W=password for authentication (optional)\n"
 #endif
@@ -700,13 +700,14 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
  * @options_str: comma-separated options string
  *
  * Parse OCI options string containing comma-separated key=value pairs.
- * Supported options include platform, layer, username, and password.
+ * Supported options include platform, layer_digest, layer_index, username, and password.
  *
  * Return: 0 on success, negative errno on failure
  */
 static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options_str)
 {
 	char *opt, *q, *p;
+	long idx;
 
 	if (!options_str)
 		return 0;
@@ -725,40 +726,59 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 			if (!oci_cfg->platform)
 				return -ENOMEM;
 		} else {
-			p = strstr(opt, "layer=");
+			p = strstr(opt, "layer_digest=");
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
+				p += strlen("layer_digest=");
+				free(oci_cfg->layer_digest);
+
+				if (oci_cfg->layer_index >= 0) {
+					erofs_err("invalid --oci: layer_digest and layer_index cannot be set together");
+					return -EINVAL;
+				}
+
+				if (strncmp(p, "sha256:", 7) != 0) {
+					if (asprintf(&oci_cfg->layer_digest, "sha256:%s", p) < 0)
+						return -ENOMEM;
+				} else {
+					oci_cfg->layer_digest = strdup(p);
+					if (!oci_cfg->layer_digest)
+						return -ENOMEM;
 				}
 			} else {
-				p = strstr(opt, "username=");
+				p = strstr(opt, "layer_index=");
 				if (p) {
-					p += strlen("username=");
-					free(oci_cfg->username);
-					oci_cfg->username = strdup(p);
-					if (!oci_cfg->username)
-						return -ENOMEM;
+					p += strlen("layer_index=");
+					if (oci_cfg->layer_digest) {
+						erofs_err("invalid --oci: layer_index and layer_digest cannot be set together");
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
+						goto next_opt;
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
+						goto next_opt;
 					}
+
+					erofs_err("mkfs: invalid --oci value %s", opt);
+					return -EINVAL;
 				}
 			}
 		}
@@ -1838,6 +1858,7 @@ int main(int argc, char **argv)
 #endif
 #ifdef OCIEROFS_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
+			ocicfg.layer_digest = NULL;
 			ocicfg.layer_index = -1;
 
 			err = mkfs_parse_oci_options(&ocicfg, mkfs_oci_options);
diff --git a/mount/main.c b/mount/main.c
index f368746..9ab8b23 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -81,51 +81,76 @@ static int erofsmount_parse_oci_option(const char *option)
 {
 	struct ocierofs_config *oci_cfg = &nbdsrc.ocicfg;
 	char *p;
+	long idx;
 
-	p = strstr(option, "oci.layer=");
+	if (oci_cfg->layer_index == 0 && !oci_cfg->layer_digest &&
+	    !oci_cfg->platform && !oci_cfg->username && !oci_cfg->password)
+		oci_cfg->layer_index = -1;
+
+	p = strstr(option, "oci.layer_digest=");
 	if (p != NULL) {
-		p += strlen("oci.layer=");
-		{
-			char *endptr;
-			unsigned long v = strtoul(p, &endptr, 10);
+		p += strlen("oci.layer_digest=");
+		free(oci_cfg->layer_digest);
 
-			if (endptr == p || *endptr != '\0')
-				return -EINVAL;
-			oci_cfg->layer_index = (int)v;
+		if (oci_cfg->layer_index >= 0) {
+			erofs_err("invalid options: oci.layer_digest and oci.layer_index cannot be set together");
+			return -EINVAL;
+		}
+
+		if (strncmp(p, "sha256:", 7) != 0) {
+			if (asprintf(&oci_cfg->layer_digest, "sha256:%s", p) < 0)
+				return -ENOMEM;
+		} else {
+			oci_cfg->layer_digest = strdup(p);
+			if (!oci_cfg->layer_digest)
+				return -ENOMEM;
 		}
 	} else {
-		p = strstr(option, "oci.platform=");
+		p = strstr(option, "oci.layer_index=");
 		if (p != NULL) {
-			p += strlen("oci.platform=");
-			free(oci_cfg->platform);
-			oci_cfg->platform = strdup(p);
-			if (!oci_cfg->platform)
-				return -ENOMEM;
+			p += strlen("oci.layer_index=");
+			if (oci_cfg->layer_digest) {
+				erofs_err("invalid options: oci.layer_index and oci.layer_digest cannot be set together");
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
+	    oci_cfg->layer_digest || oci_cfg->layer_index >= 0)
 		nbdsrc.type = EROFSNBD_SOURCE_OCI;
 	return 0;
 }
@@ -215,15 +240,21 @@ static int erofsmount_parse_options(int argc, char **argv)
 	char *dot;
 	int opt;
 
+	nbdsrc.ocicfg.layer_index = -1;
+
 	while ((opt = getopt_long(argc, argv, "Nfno:st:uv",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
-		case 'o':
+		case 'o': {
+			long r;
 			mountcfg.full_options = optarg;
-			mountcfg.flags =
-				erofsmount_parse_flagopts(optarg, mountcfg.flags,
-							  &mountcfg.options);
+			r = erofsmount_parse_flagopts(optarg, mountcfg.flags,
+						      &mountcfg.options);
+			if (r < 0)
+				return (int)r;
+			mountcfg.flags = r;
 			break;
+		}
 		case 't':
 			dot = strchr(optarg, '.');
 			if (dot) {
@@ -406,6 +437,7 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 {
 	char *b64cred = NULL;
 	int ret;
+	char *layer_field = NULL;
 
 	if (source->ocicfg.username || source->ocicfg.password) {
 		b64cred = ocierofs_encode_userpass(source->ocicfg.username,
@@ -413,11 +445,29 @@ static int erofsmount_write_recovery_oci(FILE *f, struct erofs_nbd_source *sourc
 		if (IS_ERR(b64cred))
 			return PTR_ERR(b64cred);
 	}
-	ret = fprintf(f, "OCI_LAYER %s %s %d %s\n",
+	if (source->ocicfg.layer_digest && *source->ocicfg.layer_digest) {
+		if (asprintf(&layer_field, "digest:%s", source->ocicfg.layer_digest) < 0) {
+			free(b64cred);
+			return -ENOMEM;
+		}
+	} else if (source->ocicfg.layer_index >= 0) {
+		if (asprintf(&layer_field, "index:%d", source->ocicfg.layer_index) < 0) {
+			free(b64cred);
+			return -ENOMEM;
+		}
+	} else {
+		layer_field = strdup("");
+		if (!layer_field) {
+			free(b64cred);
+			return -ENOMEM;
+		}
+	}
+	ret = fprintf(f, "OCI_LAYER %s %s %s %s\n",
 		       source->ocicfg.image_ref ?: "",
 		       source->ocicfg.platform ?: "",
-		       source->ocicfg.layer_index,
+		       layer_field,
 		       b64cred ?: "");
+	free(layer_field);
 	free(b64cred);
 	return ret < 0 ? -ENOMEM : 0;
 }
@@ -477,7 +527,12 @@ static char *erofsmount_write_recovery_info(struct erofs_nbd_source *source)
 }
 
 #ifdef OCIEROFS_ENABLED
-/* Parse input string in format: "image_ref platform layer [b64cred]" */
+/* Parse input string in format: "image_ref platform layer [b64cred]"
+ * where layer is one of:
+ *   - "digest:<sha256...>" (layer_digest)
+ *   - "index:<N>"          (layer_index)
+ *   - ""                   (no specific layer)
+ */
 static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
 					      char *source)
 {
@@ -485,8 +540,8 @@ static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
 	int token_count = 0;
 	char *p = source;
 	int err;
-	char *endptr;
-	unsigned long v;
+	long idx;
+	const char *val;
 
 	while (token_count < 4 && (p = strchr(p, ' ')) != NULL) {
 		*p++ = '\0';
@@ -503,14 +558,39 @@ static int erofsmount_parse_recovery_ocilayer(struct ocierofs_config *oci_cfg,
 	oci_cfg->image_ref = source;
 	oci_cfg->platform = tokens[0];
 
-	v = strtoul(tokens[1], &endptr, 10);
-	if (endptr == tokens[1] || *endptr != '\0')
-		return -EINVAL;
-	oci_cfg->layer_index = (int)v;
+	if (tokens[1] && strlen(tokens[1]) > 0) {
+		if (!strncmp(tokens[1], "index:", 6)) {
+			idx = strtol(tokens[1] + 6, NULL, 10);
+
+			if (idx < 0)
+				return -EINVAL;
+			oci_cfg->layer_index = (int)idx;
+			free(oci_cfg->layer_digest);
+			oci_cfg->layer_digest = NULL;
+		} else if (!strncmp(tokens[1], "digest:", 7)) {
+			val = tokens[1] + 7;
+
+			free(oci_cfg->layer_digest);
+			if (strncmp(val, "sha256:", 7) != 0) {
+				if (asprintf(&oci_cfg->layer_digest, "sha256:%s", val) < 0)
+					return -ENOMEM;
+			} else {
+				oci_cfg->layer_digest = strdup(val);
+				if (!oci_cfg->layer_digest)
+					return -ENOMEM;
+			}
+			oci_cfg->layer_index = -1;
+		} else {
+			return -EINVAL;
+		}
+	} else {
+		oci_cfg->layer_digest = NULL;
+		oci_cfg->layer_index = -1;
+	}
 
 	if (token_count > 2) {
 		err = ocierofs_decode_userpass(tokens[2], &oci_cfg->username,
-					       &oci_cfg->password);
+				       &oci_cfg->password);
 		if (err)
 			return err;
 	}
-- 
2.47.1


