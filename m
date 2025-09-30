Return-Path: <linux-erofs+bounces-1148-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C6BAE14C
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 18:46:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbkTZ5YHfz3cb1;
	Wed,  1 Oct 2025 02:46:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759250770;
	cv=none; b=EmdjPg+tVKFkRiaJjWEYmSvMxlq8pyYom90SxDOfR7icIAk0xlrjPctuo3K4OxPZKM8S8qiNUv1O5MW0E5PmXtUck+61mVVjA5dBJl4YZ9ow+LaIq/auHjgbH0cDE/fnO+gGmdnD4/gRzzNfqug7/l/ZrFkPvswP3nRrqSYbL2NOeX3sJoNtkDRjqQ2TaAdwYM2o6JmE9GSZbppBlGzPQTzUztM24ZObrX5WZ1h1G/RUqmC3Zb3NbUne/KkRBi5IFX/aYQbBwsQopSdEWtsko7MZP5z5A5/dqBroSE3tykrOoXI6NWdRUkp4jodMIvGS/UdqyHsYsYDV3VecldEDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759250770; c=relaxed/relaxed;
	bh=IT9bkUvX6wvUs/OtehvP/oJm8J49oPRdq/oK0asVaO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRQqU2Dc083qDOzrTDZD2RU+3mAsWiPDgwK0sGGBMe6+xQ9/x+9Hf/kHJKlksZasiXVrJyw/aZiSXpZT3f+nG+pFx8aOia/bd4joNau90fXhXwswwBSO2XylIIpePqjUkQOVg2TkPGb/JRGLsZPt+k6tGRVl5OHDm8af/rREAZLSqoX24mwevM3N8UlqEX1/sQqwEC9iVd6SbpvF0BsJKakpe2/vvxx0rsmbjX7iYFS7LG1Re8N2sL8IyK2zDGQSIAGxduOKG15iCb3tsDG7jt0NbuUa0t9Ub3WtMEM/MiybRcrA2r1EEAvhj0JEvzb1YHiwC3WayEnV+KYvWOxnoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.64; helo=out28-64.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.64; helo=out28-64.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-64.mail.aliyun.com (out28-64.mail.aliyun.com [115.124.28.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbkTY37gHz3cZd
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 Oct 2025 02:46:06 +1000 (AEST)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eqp4Ot5_1759250758 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 01 Oct 2025 00:45:58 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils: mkfs,oci: support tarindex mode with zinfo for OCI
Date: Wed,  1 Oct 2025 00:45:22 +0800
Message-ID: <20250930164557.21555-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

Introduce OCI tarindex mode and optional zinfo generation.

e.g.:
mkfs.erofs --oci=i,platform=linux/amd64,layer=3 \
--gzinfo=golang.zinfo golang.erofs golang:1.22.8

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 lib/remotes/oci.c | 57 ++++++++++++++++++++++++++++++++++++++---
 mkfs/main.c       | 65 ++++++++++++++++++++++++++++-------------------
 2 files changed, 92 insertions(+), 30 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index b25e0b2..349e080 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -27,6 +27,7 @@
 #include "liberofs_base64.h"
 #include "liberofs_oci.h"
 #include "liberofs_private.h"
+#include "liberofs_gzran.h"
 
 #ifdef OCIEROFS_ENABLED
 
@@ -840,14 +841,33 @@ out:
 	return ret;
 }
 
-static int ocierofs_process_tar_stream(struct erofs_importer *importer, int fd)
+static int ocierofs_process_tar_stream(struct erofs_importer *importer, int fd,
+				       const struct ocierofs_config *config,
+				       u64 *tar_offset_out)
 {
 	struct erofs_tarfile tarfile = {};
-	int ret;
+	int ret, decoder, zinfo_fd;
+	struct erofs_vfile vf;
 
 	init_list_head(&tarfile.global.xattrs);
 
-	ret = erofs_iostream_open(&tarfile.ios, fd, EROFS_IOS_DECODER_GZIP);
+	/*
+	 * Choose decoder based on config:
+	 * - tarindex + zinfo  → tar.gzip (GZRAN decoder)
+	 * - tarindex only → tar (no decoder, raw)
+	 * - neither → default gzip decoder
+	 */
+	if (config && config->tarindex_path) {
+		tarfile.index_mode = true;
+		if (config->zinfo_path)
+			decoder = EROFS_IOS_DECODER_GZRAN;
+		else
+			decoder = EROFS_IOS_DECODER_NONE;
+	} else {
+		decoder = EROFS_IOS_DECODER_GZIP;
+	}
+
+	ret = erofs_iostream_open(&tarfile.ios, fd, decoder);
 	if (ret) {
 		erofs_err("failed to initialize tar stream: %s",
 			  erofs_strerror(ret));
@@ -858,6 +878,25 @@ static int ocierofs_process_tar_stream(struct erofs_importer *importer, int fd)
 		ret = tarerofs_parse_tar(importer, &tarfile);
 		/* Continue parsing until end of archive */
 	} while (!ret);
+
+	if (decoder == EROFS_IOS_DECODER_GZRAN) {
+		zinfo_fd = open(config->zinfo_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		if (zinfo_fd < 0) {
+			ret = -errno;
+		} else {
+			vf = (struct erofs_vfile){ .fd = zinfo_fd };
+			ret = erofs_gzran_builder_export_zinfo(tarfile.ios.gb, &vf);
+			close(zinfo_fd);
+			if (ret < 0) {
+				erofs_err("failed to export zinfo: %s",
+					  erofs_strerror(ret));
+			}
+		}
+	}
+
+	if (tar_offset_out)
+		*tar_offset_out = tarfile.offset;
+
 	erofs_iostream_close(&tarfile.ios);
 
 	if (ret < 0 && ret != -ENODATA) {
@@ -1230,6 +1269,7 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 {
 	struct ocierofs_ctx ctx = {};
 	int ret, i, end, fd;
+	u64 tar_offset = 0;
 
 	ret = ocierofs_init(&ctx, config);
 	if (ret) {
@@ -1250,6 +1290,12 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 		end = ctx.layer_count;
 	}
 
+	if (config->tarindex_path && (end - i) != 1) {
+		erofs_err("tarindex mode requires exactly one layer (use blob= or layer= option)");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	while (i < end) {
 		char *trimmed = erofs_trim_for_progressinfo(ctx.layers[i]->digest,
 				sizeof("Extracting layer  ...") - 1);
@@ -1263,7 +1309,7 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 			ret = fd;
 			break;
 		}
-		ret = ocierofs_process_tar_stream(importer, fd);
+		ret = ocierofs_process_tar_stream(importer, fd, config, &tar_offset);
 		close(fd);
 		if (ret) {
 			erofs_err("failed to process tar stream for layer %s: %s",
@@ -1273,6 +1319,9 @@ int ocierofs_build_trees(struct erofs_importer *importer,
 		i++;
 	}
 out:
+	if (config->tarindex_path && importer->sbi)
+		importer->sbi->devs[0].blocks = BLK_ROUND_UP(importer->sbi, tar_offset);
+
 	ocierofs_ctx_cleanup(&ctx);
 	return ret;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 1c37576..c7359f6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -218,6 +218,8 @@ static void usage(int argc, char **argv)
 		"   [,blob=Y]           Y=blob digest to extract (omit to extract all layers)\n"
 		"   [,username=Z]       Z=username for authentication (optional)\n"
 		"   [,password=W]       W=password for authentication (optional)\n"
+		"   [,i]                generate tarindex file (requires layer or blob selection)\n"
+
 #endif
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
@@ -285,7 +287,7 @@ static struct erofs_s3 s3cfg;
 
 #ifdef OCIEROFS_ENABLED
 static struct ocierofs_config ocicfg;
-static char *mkfs_oci_options;
+static bool mkfs_oci_tarindex_mode;
 #endif
 
 enum {
@@ -727,7 +729,7 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
  * @options_str: comma-separated options string
  *
  * Parse OCI options string containing comma-separated key=value pairs.
- * Supported options include platform, blob, layer, username, and password.
+ * Supported options include platform, blob, layer, username, password, i (tarindex mode), and zinfo.
  *
  * Return: 0 on success, negative errno on failure
  */
@@ -745,6 +747,7 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 		if (q)
 			*q = '\0';
 
+
 		p = strstr(opt, "platform=");
 		if (p) {
 			p += strlen("platform=");
@@ -790,19 +793,23 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 						oci_cfg->username = strdup(p);
 						if (!oci_cfg->username)
 							return -ENOMEM;
+					} else {
+						p = strstr(opt, "password=");
+						if (p) {
+							p += strlen("password=");
+							free(oci_cfg->password);
+							oci_cfg->password = strdup(p);
+							if (!oci_cfg->password)
+								return -ENOMEM;
+						} else {
+							if (!strcmp(opt, "i"))
+								mkfs_oci_tarindex_mode = true;
+							else {
+								erofs_err("mkfs: invalid --oci value %s", opt);
+								return -EINVAL;
+							}
+						}
 					}
-
-					p = strstr(opt, "password=");
-					if (p) {
-						p += strlen("password=");
-						free(oci_cfg->password);
-						oci_cfg->password = strdup(p);
-						if (!oci_cfg->password)
-							return -ENOMEM;
-					}
-
-					erofs_err("mkfs: invalid --oci value %s", opt);
-					return -EINVAL;
 				}
 			}
 		}
@@ -1378,10 +1385,13 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			break;
 #endif
 #ifdef OCIEROFS_ENABLED
-		case 534:
-			mkfs_oci_options = optarg;
+		case 534: {
 			source_mode = EROFS_MKFS_SOURCE_OCI;
+			err = mkfs_parse_oci_options(&ocicfg, optarg);
+			if (err)
+				return err;
 			break;
+		}
 #endif
 		case 535:
 			if (optarg)
@@ -1757,6 +1767,9 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 		mkfs_blkszbits = src->blkszbits;
+	} else if (mkfs_oci_tarindex_mode) {
+		mkfs_blkszbits = 9;
+		tar_index_512b = true;
 	}
 
 	if (!incremental_mode)
@@ -1883,13 +1896,11 @@ int main(int argc, char **argv)
 #endif
 #ifdef OCIEROFS_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_OCI) {
-			ocicfg.blob_digest = NULL;
-			ocicfg.layer_index = -1;
-
-			err = mkfs_parse_oci_options(&ocicfg, mkfs_oci_options);
-			if (err)
-				goto exit;
 			ocicfg.image_ref = cfg.c_src_path;
+			if (mkfs_oci_tarindex_mode)
+				ocicfg.tarindex_path = strdup(cfg.c_src_path);
+			if (!ocicfg.zinfo_path)
+				ocicfg.zinfo_path = mkfs_aws_zinfo_file;
 
 			if (incremental_mode ||
 			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP ||
@@ -1914,10 +1925,12 @@ int main(int argc, char **argv)
 		if (!g_sbi.extra_devices) {
 			DBG_BUGON(1);
 		} else {
-			if (cfg.c_src_path)
-				g_sbi.devs[0].src_path = strdup(cfg.c_src_path);
-			g_sbi.devs[0].blocks =
-				BLK_ROUND_UP(&g_sbi, erofstar.offset);
+			if (source_mode != EROFS_MKFS_SOURCE_OCI) {
+				if (cfg.c_src_path)
+					g_sbi.devs[0].src_path = strdup(cfg.c_src_path);
+				g_sbi.devs[0].blocks =
+					BLK_ROUND_UP(&g_sbi, erofstar.offset);
+			}
 		}
 	}
 
-- 
2.47.1


