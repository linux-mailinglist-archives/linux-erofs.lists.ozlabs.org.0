Return-Path: <linux-erofs+bounces-1161-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F31BC7BDC
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Oct 2025 09:42:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cj1zX09K4z300F;
	Thu,  9 Oct 2025 18:42:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759995719;
	cv=none; b=l8+tcZM2zabFBysTV0l5125TASEp3SIymrHgeiOvdSETqzLCmdLhPtROFZW6BCnJaG9dYFR6lwSczBqx6PpUeJETjyDmHlRfgwV9ucAteOHa+YOjPoOpSp5bPeoTczXRvphS+whPHKRGC83j4f7VFZXU+XmdXo1+x1SL1ruYBpr2M3Wrc86Ki19XHwIBuSfDbba9eupoYnxXK9DVsCwP1pk8meucLom/gowKbHdti4kgS5+LaRjXI4/I4fkYl0djqcAuFR3DDgpjeZPJGiMre0jL//a4U3jkHsEI7yEzIxSu9OEbfYTw3g1mi/e6d5CiJKXrxNpUI54YCuJXddk5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759995719; c=relaxed/relaxed;
	bh=wKnM3Tx2dKl5IQsklO24y9kyAsAZnqOUSP0Zpt1Br0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxtAUyjO8Ru81yZM/bpSpiUWq/Ky8pgXZhCEZiHzU1n+KFBoNb//a5aTjQS3a1Zu0AMqX+j4jDmLUTOusiAkUrXipxg+umBHE4MTALFXrV4agFfBmA1nOqxOx0TBtM707t9tYtoIk2KZ95GGiwkUV3pcmJ3l6KDiPMFsNfSiyYWtl4MSW4BlWcYT/L0xoWCdGZjK7rlMMQ46B/bwkTFE0RzIzoKlIkEeaJPIfYWak7Howp5nl1nS8nCPeFFqmeGUJK0HikiCxnrBhYMDGgbwDyp66jslGVEkti0FXcAV0cea7mQebBIksu/0EF/292mIHM+PCagi7cvfa9KxSzz6cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.54; helo=out28-54.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.54; helo=out28-54.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-54.mail.aliyun.com (out28-54.mail.aliyun.com [115.124.28.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cj1zV28VLz2xQ0
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Oct 2025 18:41:55 +1100 (AEDT)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.evurv88_1759995708 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 15:41:49 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1 1/2] erofs-utils: mkfs,oci: support tarindex mode with zinfo for OCI
Date: Thu,  9 Oct 2025 15:41:45 +0800
Message-ID: <20251009074146.52884-1-hudson@cyzhu.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

Introduce OCI tarindex mode and optional zinfo generation.

e.g.:
$ mkfs.erofs --oci=i,platform=linux/amd64,layer=3 \
   --gzinfo=golang.zinfo golang.erofs golang:1.22.8

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/liberofs_oci.h |  2 ++
 lib/remotes/oci.c  | 57 ++++++++++++++++++++++++++++++++---
 mkfs/main.c        | 74 +++++++++++++++++++++++++++++-----------------
 3 files changed, 102 insertions(+), 31 deletions(-)

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index 71c8879..5298f18 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -35,6 +35,8 @@ struct ocierofs_config {
 	char *password;
 	char *blob_digest;
 	int layer_index;
+	char *tarindex_path;
+	char *zinfo_path;
 };
 
 struct ocierofs_layer_info {
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index b2f1f59..d5ae4d8 100644
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
+	 * - tarindex + zinfo -> tar.gzip (GZRAN decoder)
+	 * - tarindex only -> tar (no decoder, raw)
+	 * - neither -> default gzip decoder
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
index 1c37576..5657b1d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -213,7 +213,8 @@ static void usage(int argc, char **argv)
 		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
 #endif
 #ifdef OCIEROFS_ENABLED
-		" --oci[=platform=X]    X=platform (default: linux/amd64)\n"
+		" --oci=[f|i]           generate a full (f) or index-only (i) image from OCI remote source\n"
+		"   [,=platform=X]      X=platform (default: linux/amd64)\n"
 		"   [,layer=#]          #=layer index to extract (0-based; omit to extract all layers)\n"
 		"   [,blob=Y]           Y=blob digest to extract (omit to extract all layers)\n"
 		"   [,username=Z]       Z=username for authentication (optional)\n"
@@ -285,8 +286,8 @@ static struct erofs_s3 s3cfg;
 
 #ifdef OCIEROFS_ENABLED
 static struct ocierofs_config ocicfg;
-static char *mkfs_oci_options;
 #endif
+static bool mkfs_oci_tarindex_mode;
 
 enum {
 	EROFS_MKFS_DATA_IMPORT_DEFAULT,
@@ -727,7 +728,9 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
  * @options_str: comma-separated options string
  *
  * Parse OCI options string containing comma-separated key=value pairs.
- * Supported options include platform, blob, layer, username, and password.
+ *
+ * Supported options include f|i, platform, blob|layer, username, password,
+ * and zinfo.
  *
  * Return: 0 on success, negative errno on failure
  */
@@ -740,11 +743,22 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
 		return 0;
 
 	opt = options_str;
+	q = strchr(opt, ',');
+	if (q)
+		*q = '\0';
+	if (!strcmp(opt, "i") || !strcmp(opt, "f")) {
+		mkfs_oci_tarindex_mode = (*opt == 'i');
+		opt = q ? q + 1 : NULL;
+	} else if (q) {
+		*q = ',';
+	}
+
 	while (opt) {
 		q = strchr(opt, ',');
 		if (q)
 			*q = '\0';
 
+
 		p = strstr(opt, "platform=");
 		if (p) {
 			p += strlen("platform=");
@@ -790,19 +804,19 @@ static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, char *options
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
+							erofs_err("mkfs: invalid --oci value %s", opt);
+							return -EINVAL;
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
@@ -1378,10 +1392,13 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
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
@@ -1757,6 +1774,9 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 		mkfs_blkszbits = src->blkszbits;
+	} else if (mkfs_oci_tarindex_mode) {
+		mkfs_blkszbits = 9;
+		tar_index_512b = true;
 	}
 
 	if (!incremental_mode)
@@ -1883,13 +1903,11 @@ int main(int argc, char **argv)
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
@@ -1914,10 +1932,12 @@ int main(int argc, char **argv)
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
2.51.0


